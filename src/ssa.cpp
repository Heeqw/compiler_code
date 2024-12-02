#include "ssa.h"
#include <cassert>
#include <iostream>
#include <list>
#include <stack>
#include <string>
#include <algorithm>
#include <unordered_map>
#include <unordered_set>
#include <vector>
#include "bg_llvm.h"
#include "graph.hpp"
#include "liveness.h"
#include "printLLVM.h"

using namespace std;
using namespace LLVMIR;
using namespace GRAPH;
struct imm_Dominator {
    LLVMIR::L_block* pred;
    unordered_set<LLVMIR::L_block*> succs;
};

unordered_map<L_block*, unordered_set<L_block*>> dominators;
unordered_map<L_block*, imm_Dominator> tree_dominators;
unordered_map<L_block*, unordered_set<L_block*>> DF_array;
unordered_map<L_block*, Node<LLVMIR::L_block*>*> revers_graph;
// 寄存器到操作数的映射
unordered_map<Temp_temp*, AS_operand*> temp2ASoper;

static void init_table() {
    dominators.clear();
    tree_dominators.clear();
    DF_array.clear();
    revers_graph.clear();
    temp2ASoper.clear();
}

LLVMIR::L_prog* SSA(LLVMIR::L_prog* prog) {
    for (auto& fun : prog->funcs) {
        init_table();
        combine_addr(fun);
        // Step1:将标量放入寄存器
        mem2reg(fun);
        // Step2:构建控制流图
        auto RA_bg = Create_bg(fun->blocks);
        // Step3:删除不可达节点
        SingleSourceGraph(RA_bg.mynodes[0], RA_bg,fun);
        // Step4:活跃分析
        Liveness(RA_bg.mynodes[0], RA_bg, fun->args);
        // Step5:支配节点
        Dominators(RA_bg);
        // Step6:构建支配树
        tree_Dominators(RA_bg);
        // 默认0是入口block
        // Step7:计算支配边界
        computeDF(RA_bg, RA_bg.mynodes[0]);
        // Step8:插入phi函数
        Place_phi_fu(RA_bg, fun);
        // Step9:重命名
        Rename(RA_bg);
        combine_addr(fun);
    }
    return prog;
}

/**
 *  判断一条语句是否是alloc且是否是分配在栈上的标量
*/
static bool is_mem_variable(L_stm* stm) {
    return stm->type == L_StmKind::T_ALLOCA && stm->u.ALLOCA->dst->kind == OperandKind::TEMP && stm->u.ALLOCA->dst->u.TEMP->type == TempType::INT_PTR && stm->u.ALLOCA->dst->u.TEMP->len == 0;
}

// 保证相同的AS_operand,地址一样,常量除外
void combine_addr(LLVMIR::L_func* fun) {
    unordered_map<Temp_temp*, unordered_set<AS_operand**>> temp_set;
    unordered_map<Name_name*, unordered_set<AS_operand**>> name_set;
    for (auto& block : fun->blocks) {
        for (auto& stm : block->instrs) {
            auto AS_operand_list = get_all_AS_operand(stm);
            for (auto AS_op : AS_operand_list) {
                if ((*AS_op)->kind == OperandKind::TEMP) {
                    temp_set[(*AS_op)->u.TEMP].insert(AS_op);
                } else if ((*AS_op)->kind == OperandKind::NAME) {
                    name_set[(*AS_op)->u.NAME].insert(AS_op);
                }
            }
        }
    }
    for (auto temp : temp_set) {
        AS_operand* fi_AS_op = **temp.second.begin();
        for (auto AS_op : temp.second) {
            *AS_op = fi_AS_op;
        }
    }
    for (auto name : name_set) {
        AS_operand* fi_AS_op = **name.second.begin();
        for (auto AS_op : name.second) {
            *AS_op = fi_AS_op;
        }
    }
}

/*
*   将标量从内存移动到寄存器
*/
void mem2reg(LLVMIR::L_func* fun) {
    // 第一步：分析每个变量的第一次使用
    unordered_map<Temp_temp*, bool> need_init;
    
    // 1.1 收集所有alloca的变量
    for(auto block : fun->blocks) {
        for(auto stm : block->instrs) {
            if(is_mem_variable(stm)) {
                need_init[stm->u.ALLOCA->dst->u.TEMP] = false;  // 默认不需要初始化
            }
        }
    }
    
    // 1.2 分析每个变量的使用情况
    for(auto block : fun->blocks) {
        for(auto stm : block->instrs) {
            if(stm->type == L_StmKind::T_LOAD) {
                Temp_temp* ptr = stm->u.LOAD->ptr->u.TEMP;
                if(need_init.find(ptr) != need_init.end()) {
                    // 如果第一次遇到的是load,说明需要初始化
                    need_init[ptr] = true;
                }
            }
        }
    }

    // 第二步：处理alloca/load/store指令
    unordered_map<Temp_temp*, AS_operand*> loadTemp2ASOper;
    
    // 2.1 处理alloca
    for(auto block : fun->blocks) {
        for(auto it = block->instrs.begin(); it != block->instrs.end(); ) {
            L_stm* stm = *it;
            if(is_mem_variable(stm)) {
                Temp_temp* new_temp = Temp_newtemp_int();
                AS_operand* new_oper = AS_Operand_Temp(new_temp);
                temp2ASoper[stm->u.ALLOCA->dst->u.TEMP] = new_oper;
                
                if(need_init[stm->u.ALLOCA->dst->u.TEMP]) {
                    // 只有需要初始化的变量才生成move 0
                    *it = L_Move(AS_Operand_Const(0), new_oper);
                    ++it;
                } else {
                    // 不需要初始化的直接删除alloca
                    it = block->instrs.erase(it);
                }
            } else {
                ++it;
            }
        }
    }
    
    // 2.2 处理load/store
    for(auto block : fun->blocks) {
        for(auto it = block->instrs.begin(); it != block->instrs.end(); ) {
            L_stm* stm = *it;
            switch(stm->type) {
                case L_StmKind::T_STORE: {
                    AS_operand* ptr = stm->u.STORE->ptr;
                    AS_operand* src = stm->u.STORE->src;
                    
                    if(src->kind == OperandKind::TEMP && 
                       src->u.TEMP->type == TempType::INT_TEMP && 
                       loadTemp2ASOper.find(src->u.TEMP) != loadTemp2ASOper.end()) {
                        src = loadTemp2ASOper[src->u.TEMP];
                    }
                    
                    if(ptr->kind == OperandKind::TEMP && 
                       ptr->u.TEMP->type == TempType::INT_PTR && 
                       ptr->u.TEMP->len == 0 && 
                       temp2ASoper.find(ptr->u.TEMP) != temp2ASoper.end()) {
                        *it = L_Move(src, temp2ASoper[ptr->u.TEMP]);
                        ++it;
                    } else {
                        ++it;
                    }
                    break;
                }
                
                case L_StmKind::T_LOAD: {
                    AS_operand* dst = stm->u.LOAD->dst;
                    AS_operand* ptr = stm->u.LOAD->ptr;
                    
                    if(ptr->kind == OperandKind::TEMP && 
                       ptr->u.TEMP->type == TempType::INT_PTR && 
                       ptr->u.TEMP->len == 0 && 
                       temp2ASoper.find(ptr->u.TEMP) != temp2ASoper.end()) {
                        if(dst->kind == OperandKind::TEMP) {
                            *it = L_Move(temp2ASoper[ptr->u.TEMP], dst);
                            loadTemp2ASOper[dst->u.TEMP] = temp2ASoper[ptr->u.TEMP];
                            ++it;
                        } else {
                            assert(0);
                        }
                    } else {
                        ++it;
                    }
                    break;
                }
                
                default: {
                    list<AS_operand**> as_list = get_all_AS_operand(stm);
                    for(auto as : as_list) {
                        AS_operand* oper = *as;
                        if(oper->kind == OperandKind::TEMP && 
                           oper->u.TEMP->type == TempType::INT_TEMP && 
                           loadTemp2ASOper.find(oper->u.TEMP) != loadTemp2ASOper.end()) {
                            *as = loadTemp2ASOper[oper->u.TEMP];
                        }
                    }
                    ++it;
                    break;
                }
            }
        }
    }
}

/**
 *  计算支配节点
 *  使用迭代算法计算每个节点的支配节点集合
*/
void Dominators(GRAPH::Graph<LLVMIR::L_block*>& bg) {
    // TODO
    unordered_set<L_block*> blocks = unordered_set<L_block*>();

    // 统计所有的block
    map<int, Node<L_block*>*> &nodes = bg.mynodes;
    for(auto pair:nodes){
        Node<L_block*>* node = pair.second;
        if(node==nullptr || node->nodeInfo()==nullptr){
            assert(0);
        }
        blocks.emplace(node->nodeInfo());
    }

    // 初始化:所有节点支配所有节点
    for(auto pair : nodes){
        Node<L_block*>* node = pair.second;
        dominators[node->nodeInfo()] = unordered_set<L_block*>(blocks.begin(), blocks.end());
    }

    // 入口块只支配自己
    unordered_set<L_block*> root_block_dominators = unordered_set<L_block*>();
    root_block_dominators.emplace(nodes[0]->nodeInfo());
    dominators[nodes[0]->nodeInfo()] = root_block_dominators;

    // 迭代计算直到不动点
    bool changed = true;
    while(changed){
        changed = false;
        for(auto pair : nodes){
            Node<L_block*>* node = pair.second;
            unordered_set<L_block*> node_dominators = dominators[node->nodeInfo()];
            int origin_size = node_dominators.size();
            
            // 计算所有前驱的支配集合交集
            NodeSet* preds = node->pred();
            for(auto pred_id:*preds){
                Node<L_block*>* pred = bg.mynodes[pred_id];
                if(origin_size>0){
                    node_dominators = make_intersection(node_dominators, dominators[pred->nodeInfo()]);
                }
            }   
            
            // 如果支配集合发生变化,继续迭代
            if(node_dominators.size()!=origin_size){
                changed = true;
                dominators[node->nodeInfo()] = node_dominators;
            }
        }
    }
}

void printf_domi() {
    printf("Dominator:\n");
    for (auto x : dominators) {
        printf("%s :\n", x.first->label->name.c_str());
        for (auto t : x.second) {
            printf("%s ", t->label->name.c_str());
        }
        printf("\n\n");
    }
}

void printf_D_tree() {
    printf("dominator tree:\n");
    for (auto x : tree_dominators) {
        printf("%s :\n", x.first->label->name.c_str());
        for (auto t : x.second.succs) {
            printf("%s ", t->label->name.c_str());
        }
        printf("\n\n");
    }
}
void printf_DF() {
    printf("DF:\n");
    for (auto x : DF_array) {
        printf("%s :\n", x.first->label->name.c_str());
        for (auto t : x.second) {
            printf("%s ", t->label->name.c_str());
        }
        printf("\n\n");
    }
}

/**
 *  计算支配树
 *  根据支配关系构建支配树,每个节点(除入口节点外)都有唯一的直接支配节点
*/
void tree_Dominators(GRAPH::Graph<LLVMIR::L_block*>& bg) {
    // 为每个块找到直接支配节点
    for(auto pair:dominators){
        L_block* block = pair.first;
        unordered_set<L_block*> block_dominators = pair.second;

        for(L_block* dominator:block_dominators){
            if(dominator==block) continue;
            
            // 判断是否是直接支配节点(没有其他节点支配该节点)
            bool isIdom = true;
            for(L_block* other_dominator:block_dominators){
                if(other_dominator==block || other_dominator==dominator) continue;
                if(dominators[other_dominator].find(dominator)!=
                   dominators[other_dominator].end()){
                    isIdom = false;
                    break;
                }
            }
            
            if(isIdom){
                // 记录直接支配关系
                imm_Dominator idom = imm_Dominator();
                idom.pred = dominator;
                tree_dominators[block] = idom;
            }
        }
    }

    // 设置入口块的直接支配节点为nullptr
    imm_Dominator root_idom = imm_Dominator();
    root_idom.pred = nullptr;
    tree_dominators[bg.mynodes[0]->nodeInfo()] = root_idom;

    // 建立支配树的边(succ关系)
    for(auto pair:tree_dominators){
        L_block* block = pair.first;
        imm_Dominator idom = tree_dominators[block];
        
        if(idom.pred!=nullptr){
            tree_dominators[idom.pred].succs.emplace(block);
        }
    }
}

/**
 *  计算支配边界
 *  支配边界是指对于节点n,那些"刚好不被n支配"的节点的集合
*/
void computeDF(GRAPH::Graph<LLVMIR::L_block*>& bg, GRAPH::Node<LLVMIR::L_block*>* r) {
    unordered_set<L_block*> s = unordered_set<L_block*>();

    // 计算局部支配边界(DF_local)
    for(int succ_id:*r->succ()){
        Node<L_block*>* node = bg.mynodes[succ_id];
        imm_Dominator idom = tree_dominators[node->nodeInfo()];
        if(idom.pred != r->nodeInfo()){
            s.emplace(node->nodeInfo());
        }
    }

    // 计算上升支配边界(DF_up)
    imm_Dominator idom = tree_dominators[r->nodeInfo()];
    for(L_block* succ:idom.succs){
        int succ_id = bg.findNode(succ);
        if(succ_id==-1){
            assert(0);
        }
        computeDF(bg, bg.mynodes[succ_id]);

        // 合并子节点的支配边界
        unordered_set<L_block*> c_df_array = DF_array[succ];
        for(L_block* c_df:c_df_array){
            if(dominators[c_df].find(r->nodeInfo())==dominators[c_df].end() || 
               r->nodeInfo()==c_df){
                s.emplace(c_df);
            }
        }
    }

    DF_array[r->nodeInfo()] = s;
}



/**
 *  获得一条语句中所有定义的int标量操作数
*/
static list<AS_operand**> get_def_int_operand(LLVMIR::L_stm* stm) {
    list<AS_operand**> ret1 = get_def_operand(stm), ret2;
    for (auto AS_op : ret1) {
        if ((**AS_op).kind==OperandKind::TEMP && (**AS_op).u.TEMP->type == TempType::INT_TEMP) {
            ret2.push_back(AS_op);
        }
    }
    return ret2;
}

/**
 *  获得一条语句中所有使用的int标量操作数
*/
static list<AS_operand**> get_use_int_operand(LLVMIR::L_stm* stm) {
    list<AS_operand**> ret1 = get_use_operand(stm), ret2;
    for (auto AS_op : ret1) {
        if ((**AS_op).kind==OperandKind::TEMP && (**AS_op).u.TEMP->type == TempType::INT_TEMP) {
            ret2.push_back(AS_op);
        }
    }
    return ret2;
}

/**
 *  插入phi函数
 *  只对标量做
*/
void Place_phi_fu(GRAPH::Graph<LLVMIR::L_block*>& bg, L_func* fun) {
    // A_orig[n] - 在块n中定义的变量集合
    unordered_map<L_block*, unordered_set<AS_operand*>> A_orig;
    // defsites[a] - 变量a的所有定义点集合
    unordered_map<AS_operand*, unordered_set<L_block*>> defsites;
    // A_phi[n] - 在块n中已插入phi的变量集合
    unordered_map<L_block*, unordered_set<AS_operand*>> A_phi;

    // 求A_orig - 找出每个块中定义的变量
    for(auto pair:bg.mynodes){
        L_block* block = pair.second->nodeInfo();
        for(L_stm* stm:block->instrs){
            list<AS_operand**> def_operands = get_def_int_operand(stm);
            for(AS_operand** def_operand:def_operands){
                // 只处理标量变量
                auto it = std::find_if(temp2ASoper.begin(), temp2ASoper.end(), 
                                     [&](const auto &pair){ 
                                         return pair.second == *def_operand; 
                                     });
                if (it != temp2ASoper.end()){
                    A_orig[block].emplace(*def_operand);
                }
            }
        }
    }

    // 计算defsites - 找出每个变量在哪些块中被定义
    for(auto pair:A_orig){
        L_block* block = pair.first;
        for(AS_operand* operand:pair.second){
            defsites[operand].emplace(block);
        }
    }

    // 插入phi语句
    for(auto pair:defsites){
        AS_operand* a = pair.first;
        unordered_set<L_block*> w = pair.second;
        while(w.size()>0){
            // 取出一个定义点
            L_block* n = w.extract(w.begin()).value();
            w.erase(n);
            unordered_set<L_block*> df_array = DF_array[n];

            for(L_block* y:df_array){
                if(A_phi[y].find(a)==A_phi[y].end()){
                    int node_id = bg.findNode(y);
                    Node<L_block*>* y_node = bg.mynodes[node_id];

                    // 为每个前驱创建phi参数
                    std::vector<std::pair<AS_operand*, Temp_label*>> phis;
                    for(int pred_id:*y_node->pred()){
                        Node<L_block*>* pred = bg.mynodes[pred_id];
                        phis.push_back({a, pred->nodeInfo()->label});
                    }

                    // 插入phi指令(在label之后)
                    L_stm* first_stm = y->instrs.front();
                    if(first_stm->type==L_StmKind::T_LABEL){
                        y->instrs.pop_front();
                    }
                    y->instrs.push_front(L_Phi(a, phis));
                    if(first_stm->type==L_StmKind::T_LABEL){
                        y->instrs.push_front(first_stm);
                    }

                    A_phi[y].emplace(a);
                    
                    // 如果y中没有对a的定义,将y加入工作集
                    if(A_orig[y].find(a)==A_orig[y].end()){
                        w.emplace(y);
                    }
                }
            }
        }
    }
}

/**
 *  递归实现寄存器重命名
*/
static void Rename_temp(GRAPH::Graph<LLVMIR::L_block*>& bg, GRAPH::Node<LLVMIR::L_block*>* n, 
                       unordered_map<Temp_temp*, stack<Temp_temp*>> Stack) {
    // 处理块内的每条指令
    for(L_stm* stm : n->nodeInfo()->instrs){
        // 非phi指令的use操作数需要替换为最新的定义
        if(stm->type!=L_StmKind::T_PHI){
            list<AS_operand**> used_operands = get_use_int_operand(stm);
            for(AS_operand** used_operand : used_operands){
                if(Stack.find((*used_operand)->u.TEMP)!=Stack.end()){
                    *used_operand = AS_Operand_Temp(Stack[(*used_operand)->u.TEMP].top());
                }
            }
        }

        // 对def操作数生成新的版本
        list<AS_operand**> def_operands = get_def_int_operand(stm);
        for(AS_operand** def_operand : def_operands){
            if(Stack.find((*def_operand)->u.TEMP)!=Stack.end()){
                Temp_temp* new_temp = Temp_newtemp_int();
                Stack[(*def_operand)->u.TEMP].push(new_temp);
                *def_operand = AS_Operand_Temp(new_temp);
            }
        }
    }

    // 处理后继块中的phi函数
    for(int succ_id : *n->succ()){
        Node<L_block*>* succ = bg.mynodes[succ_id];
        
        // 找到n是succ的第几个前驱
        int loc = 0;
        for(int pred_id:*succ->pred()){
            Node<L_block*>* pred = bg.mynodes[pred_id];
            if(n==pred)
                break;
            
            loc++;
        }

        // 更新phi函数中对应前驱的操作数
        for(L_stm* stm : succ->nodeInfo()->instrs){
            if(stm->type==L_StmKind::T_PHI){
                Temp_temp* old_temp = stm->u.PHI->phis[loc].first->u.TEMP;
                stm->u.PHI->phis[loc].first = AS_Operand_Temp(Stack[old_temp].top());
            }
        }
    }

    // 递归处理支配树中的子节点
    imm_Dominator idom = tree_dominators[n->nodeInfo()];
    for(L_block* succ:idom.succs){
        int node_id = bg.findNode(succ);
        Rename_temp(bg, bg.mynodes[node_id], Stack);
    }
}

/**
 *  寄存器重命名
 *  只初始化，具体还要依靠Rename_Temp实现
*/
void Rename(GRAPH::Graph<LLVMIR::L_block*>& bg) {
    // 初始化栈,每个变量的初始版本就是自己
    unordered_map<Temp_temp*, stack<Temp_temp*>> stack;
    for(auto pair:temp2ASoper){
        stack[pair.second->u.TEMP].push(pair.second->u.TEMP);
    }

    // 从入口块开始重命名
    Rename_temp(bg, bg.mynodes[0], stack);
}

template <typename T>
std::unordered_set<T> make_intersection(std::unordered_set<T> &tl1, std::unordered_set<T> &tl2)
{
    unordered_set<T> intersection = unordered_set<T>();
    for (auto &it : tl1)
    {
        if (tl2.find(it) != tl2.end())
        {
            intersection.emplace(it);
        }
    }
    return intersection;
}