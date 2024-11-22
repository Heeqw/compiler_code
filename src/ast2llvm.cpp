#include "ast2llvm.h"
#include <vector>
#include <unordered_map>
#include <string>
#include <cassert>
#include <list>

using namespace std;
using namespace LLVMIR;

static unordered_map<string,FuncType> funcReturnMap;
static unordered_map<string,StructInfo> structInfoMap;
static unordered_map<string,Name_name*> globalVarMap;
static unordered_map<string,Temp_temp*> localVarMap;
static list<L_stm*> emit_irs;

LLVMIR::L_prog* ast2llvm(aA_program p)
{
    auto defs = ast2llvmProg_first(p);
    auto funcs = ast2llvmProg_second(p);
    vector<L_func*> funcs_block;
    for(const auto &f : funcs)
    {
        funcs_block.push_back(ast2llvmFuncBlock(f));
    }
    for(auto &f : funcs_block)
    {
        ast2llvm_moveAlloca(f);
    }
    return new L_prog(defs,funcs_block);
}

int ast2llvmRightVal_first(aA_rightVal r)
{
    if(r == nullptr)
    {
        return 0;
    }
    switch (r->kind)
    {
    case A_arithExprValKind:
    {
        return ast2llvmArithExpr_first(r->u.arithExpr);
        break;
    }
    case A_boolExprValKind:
    {
        return ast2llvmBoolExpr_first(r->u.boolExpr);
        break;
    }
    default:
        break;
    }
    return 0;
}

int ast2llvmBoolExpr_first(aA_boolExpr b)
{
    switch (b->kind)
    {
    case A_boolBiOpExprKind:
    {
        return ast2llvmBoolBiOpExpr_first(b->u.boolBiOpExpr);
        break;
    }
    case A_boolUnitKind:
    {
        return ast2llvmBoolUnit_first(b->u.boolUnit);
        break;
    }
    default:
         break;
    }
    return 0;
}

int ast2llvmBoolBiOpExpr_first(aA_boolBiOpExpr b)
{
    int l = ast2llvmBoolExpr_first(b->left);
    int r = ast2llvmBoolExpr_first(b->right);
    if(b->op == A_and)
    {
        return l && r;
    }
    else
    {
        return l || r;
    }
}

int ast2llvmBoolUOpExpr_first(aA_boolUOpExpr b)
{
    if(b->op == A_not)
    {
        return !ast2llvmBoolUnit_first(b->cond);
    }
    return 0;
}

int ast2llvmBoolUnit_first(aA_boolUnit b)
{
    switch (b->kind)
    {
    case A_comOpExprKind:
    {
        return ast2llvmComOpExpr_first(b->u.comExpr);
        break;
    }
    case A_boolExprKind:
    {
        return ast2llvmBoolExpr_first(b->u.boolExpr);
        break;
    }
    case A_boolUOpExprKind:
    {
        return ast2llvmBoolUOpExpr_first(b->u.boolUOpExpr);
        break;
    }
    default:
        break;
    }
    return 0;
}

int ast2llvmComOpExpr_first(aA_comExpr c)
{
    auto l = ast2llvmExprUnit_first(c->left);
    auto r = ast2llvmExprUnit_first(c->right);
    switch (c->op)
    {
    case A_lt:
    {
        return l < r;
        break;
    }
    case A_le:
    {
        return l <= r;
        break;
    }
    case A_gt:
    {
        return l > r;
        break;
    }
    case A_ge:
    {
        return l >= r;
        break;
    }
    case A_eq:
    {
        return l == r;
        break;
    }
    case A_ne:
    {
        return l != r;
        break;
    }
    default:
        break;
    }
    return 0;
}

int ast2llvmArithBiOpExpr_first(aA_arithBiOpExpr a)
{
    auto l= ast2llvmArithExpr_first(a->left);
    auto r = ast2llvmArithExpr_first(a->right);
    switch (a->op)
    {
    case A_add:
    {
        return l + r;
        break;
    }
    case A_sub:
    {
        return l - r;
        break;
    }
    case A_mul:
    {
        return l * r;
        break;
    }
    case A_div:
    {
        return l / r;
        break;
    }
    default:
        break;
    }
    return 0;
}

int ast2llvmArithUExpr_first(aA_arithUExpr a)
{
    if(a->op == A_neg)
    {
        return -ast2llvmExprUnit_first(a->expr);
    }
    return 0;
}

int ast2llvmArithExpr_first(aA_arithExpr a)
{
    switch (a->kind)
    {
    case A_arithBiOpExprKind:
    {
        return ast2llvmArithBiOpExpr_first(a->u.arithBiOpExpr);
        break;
    }
    case A_exprUnitKind:
    {
        return ast2llvmExprUnit_first(a->u.exprUnit);
        break;
    }
    default:
        assert(0);
        break;
    }
    return 0;
}

int ast2llvmExprUnit_first(aA_exprUnit e)
{
    if(e->kind == A_numExprKind)
    {
        return e->u.num;
    }
    else if(e->kind == A_arithExprKind)
    {
        return ast2llvmArithExpr_first(e->u.arithExpr);
    }
    else if(e->kind == A_arithUExprKind)
    {
        return ast2llvmArithUExpr_first(e->u.arithUExpr);
    }
    else
    {
        assert(0);
    }
    return 0;
}

std::vector<LLVMIR::L_def*> ast2llvmProg_first(aA_program p)
{
    vector<L_def*> defs;

    // add to returnMap
    funcReturnMap["getch"] = FuncType(ReturnType::INT_TYPE);
    funcReturnMap["getint"] = FuncType(ReturnType::INT_TYPE);
    funcReturnMap["putch"] = FuncType(ReturnType::VOID_TYPE);
    funcReturnMap["putint"] = FuncType(ReturnType::VOID_TYPE);
    funcReturnMap["putarray"] = FuncType(ReturnType::VOID_TYPE);
    funcReturnMap["_sysy_starttime"] = FuncType(ReturnType::VOID_TYPE);
    funcReturnMap["_sysy_stoptime"] = FuncType(ReturnType::VOID_TYPE);
    for(const auto &v : p->programElements)
    {
        switch (v->kind)
        {
        case A_programNullStmtKind:
        {
            break;
        }
        case A_programVarDeclStmtKind:
        {
            if(v->u.varDeclStmt->kind == A_varDeclKind)
            {
                if(v->u.varDeclStmt->u.varDecl->kind == A_varDeclScalarKind)
                {
                    if(v->u.varDeclStmt->u.varDecl->u.declScalar->type->type == A_structTypeKind)
                    {
                        globalVarMap.emplace(*v->u.varDeclStmt->u.varDecl->u.declScalar->id,
                            Name_newname_struct(Temp_newlabel_named(*v->u.varDeclStmt->u.varDecl->u.declScalar->id),*v->u.varDeclStmt->u.varDecl->u.declScalar->type->u.structType));
                        TempDef def(TempType::STRUCT_TEMP,0,*v->u.varDeclStmt->u.varDecl->u.declScalar->type->u.structType);
                        defs.push_back(L_Globaldef(*v->u.varDeclStmt->u.varDecl->u.declScalar->id,def,vector<int>()));
                    }
                    else
                    {
                        globalVarMap.emplace(*v->u.varDeclStmt->u.varDecl->u.declScalar->id,
                            Name_newname_int(Temp_newlabel_named(*v->u.varDeclStmt->u.varDecl->u.declScalar->id)));
                        TempDef def(TempType::INT_TEMP,0);
                        defs.push_back(L_Globaldef(*v->u.varDeclStmt->u.varDecl->u.declScalar->id,def,vector<int>()));
                    }
                }
                else if(v->u.varDeclStmt->u.varDecl->kind == A_varDeclArrayKind)
                {
                    if(v->u.varDeclStmt->u.varDecl->u.declArray->type->type == A_structTypeKind)
                    {
                        globalVarMap.emplace(*v->u.varDeclStmt->u.varDecl->u.declArray->id,
                            Name_newname_struct_ptr(Temp_newlabel_named(*v->u.varDeclStmt->u.varDecl->u.declArray->id),v->u.varDeclStmt->u.varDecl->u.declArray->len,*v->u.varDeclStmt->u.varDecl->u.declArray->type->u.structType));
                        TempDef def(TempType::STRUCT_PTR,v->u.varDeclStmt->u.varDecl->u.declArray->len,*v->u.varDeclStmt->u.varDecl->u.declArray->type->u.structType);
                        defs.push_back(L_Globaldef(*v->u.varDeclStmt->u.varDecl->u.declArray->id,def,vector<int>()));
                    }
                    else
                    {
                        globalVarMap.emplace(*v->u.varDeclStmt->u.varDecl->u.declArray->id,
                            Name_newname_int_ptr(Temp_newlabel_named(*v->u.varDeclStmt->u.varDecl->u.declArray->id),v->u.varDeclStmt->u.varDecl->u.declArray->len));
                        TempDef def(TempType::INT_PTR,v->u.varDeclStmt->u.varDecl->u.declArray->len);
                        defs.push_back(L_Globaldef(*v->u.varDeclStmt->u.varDecl->u.declArray->id,def,vector<int>()));
                    }
                }
                else
                {
                    assert(0);
                }
            }
            else if(v->u.varDeclStmt->kind == A_varDefKind)
            {
                if(v->u.varDeclStmt->u.varDef->kind == A_varDefScalarKind)
                {
                    if(v->u.varDeclStmt->u.varDef->u.defScalar->type->type == A_structTypeKind)
                    {
                        globalVarMap.emplace(*v->u.varDeclStmt->u.varDef->u.defScalar->id,
                            Name_newname_struct(Temp_newlabel_named(*v->u.varDeclStmt->u.varDef->u.defScalar->id),*v->u.varDeclStmt->u.varDef->u.defScalar->type->u.structType));
                        TempDef def(TempType::STRUCT_TEMP,0,*v->u.varDeclStmt->u.varDef->u.defScalar->type->u.structType);
                        defs.push_back(L_Globaldef(*v->u.varDeclStmt->u.varDef->u.defScalar->id,def,vector<int>()));
                    }
                    else
                    {
                        globalVarMap.emplace(*v->u.varDeclStmt->u.varDef->u.defScalar->id,
                            Name_newname_int(Temp_newlabel_named(*v->u.varDeclStmt->u.varDef->u.defScalar->id)));
                        TempDef def(TempType::INT_TEMP,0);
                        vector<int> init;
                        init.push_back(ast2llvmRightVal_first(v->u.varDeclStmt->u.varDef->u.defScalar->val));
                        defs.push_back(L_Globaldef(*v->u.varDeclStmt->u.varDef->u.defScalar->id,def,init));
                    }
                }
                else if(v->u.varDeclStmt->u.varDef->kind == A_varDefArrayKind)
                {
                    if(v->u.varDeclStmt->u.varDef->u.defArray->type->type == A_structTypeKind)
                    {
                        globalVarMap.emplace(*v->u.varDeclStmt->u.varDef->u.defArray->id,
                            Name_newname_struct_ptr(Temp_newlabel_named(*v->u.varDeclStmt->u.varDef->u.defArray->id),v->u.varDeclStmt->u.varDef->u.defArray->len,*v->u.varDeclStmt->u.varDef->u.defArray->type->u.structType));
                        TempDef def(TempType::STRUCT_PTR,v->u.varDeclStmt->u.varDef->u.defArray->len,*v->u.varDeclStmt->u.varDef->u.defArray->type->u.structType);
                        defs.push_back(L_Globaldef(*v->u.varDeclStmt->u.varDef->u.defArray->id,def,vector<int>()));
                    }
                    else
                    {
                        globalVarMap.emplace(*v->u.varDeclStmt->u.varDef->u.defArray->id,
                            Name_newname_int_ptr(Temp_newlabel_named(*v->u.varDeclStmt->u.varDef->u.defArray->id),v->u.varDeclStmt->u.varDef->u.defArray->len));
                        TempDef def(TempType::INT_PTR,v->u.varDeclStmt->u.varDef->u.defArray->len);
                        vector<int> init;
                        for(auto &el : v->u.varDeclStmt->u.varDef->u.defArray->vals)
                        {
                            init.push_back(ast2llvmRightVal_first(el));
                        }
                        defs.push_back(L_Globaldef(*v->u.varDeclStmt->u.varDef->u.defArray->id,def,init));
                    }
                }
                else
                {
                    assert(0);
                }
            }
            else
            {
                assert(0);
            }
            break;
        }
        case A_programStructDefKind:
        {
            StructInfo si;
            int off = 0;
            vector<TempDef> members;
            for(const auto &decl : v->u.structDef->varDecls)
            {
                if(decl->kind == A_varDeclScalarKind)
                {
                    if(decl->u.declScalar->type->type == A_structTypeKind)
                    {
                        TempDef def(TempType::STRUCT_TEMP,0,*decl->u.declScalar->type->u.structType);
                        MemberInfo info(off++,def);
                        si.memberinfos.emplace(*decl->u.declScalar->id,info);
                        members.push_back(def);
                    }
                    else
                    {
                        TempDef def(TempType::INT_TEMP,0);
                        MemberInfo info(off++,def);
                        si.memberinfos.emplace(*decl->u.declScalar->id,info);
                        members.push_back(def);
                    }
                }
                else if(decl->kind == A_varDeclArrayKind)
                {
                    if(decl->u.declArray->type->type == A_structTypeKind)
                    {
                        TempDef def(TempType::STRUCT_PTR,decl->u.declArray->len,*decl->u.declArray->type->u.structType);
                        MemberInfo info(off++,def);
                        si.memberinfos.emplace(*decl->u.declArray->id,info);
                        members.push_back(def);
                    }
                    else
                    {
                        TempDef def(TempType::INT_PTR,decl->u.declArray->len);
                        MemberInfo info(off++,def);
                        si.memberinfos.emplace(*decl->u.declArray->id,info);
                        members.push_back(def);
                    }
                }
                else
                {
                    assert(0);
                }
            }
            structInfoMap.emplace(*v->u.structDef->id,std::move(si));
            defs.push_back(L_Structdef(*v->u.structDef->id,members));
            break;
        }
        case A_programFnDeclStmtKind:
        {
            FuncType type;
            if(v->u.fnDeclStmt->fnDecl->type == nullptr)
            {
                type.type = ReturnType::VOID_TYPE;
            }
            else if(v->u.fnDeclStmt->fnDecl->type->type == A_nativeTypeKind)
            {
                type.type = ReturnType::INT_TYPE;
            }
            else if(v->u.fnDeclStmt->fnDecl->type->type == A_structTypeKind)
            {
                type.type = ReturnType::STRUCT_TYPE;
                type.structname = *v->u.fnDeclStmt->fnDecl->type->u.structType;
            }
            else
            {
                assert(0);
            }
            if(funcReturnMap.find(*v->u.fnDeclStmt->fnDecl->id) == funcReturnMap.end())
                funcReturnMap.emplace(*v->u.fnDeclStmt->fnDecl->id,std::move(type));
            vector<TempDef> args;
            for(const auto & decl : v->u.fnDeclStmt->fnDecl->paramDecl->varDecls)
            {
                if(decl->kind == A_varDeclScalarKind)
                {
                    if(decl->u.declScalar->type->type == A_structTypeKind)
                    {
                        TempDef def(TempType::STRUCT_PTR,0,*decl->u.declScalar->type->u.structType);
                        args.push_back(def);
                    }
                    else
                    {
                        TempDef def(TempType::INT_TEMP,0);
                        args.push_back(def);
                    }
                }
                else if(decl->kind == A_varDeclArrayKind)
                {
                    if(decl->u.declArray->type->type == A_structTypeKind)
                    {
                        TempDef def(TempType::STRUCT_PTR,-1,*decl->u.declArray->type->u.structType);
                        args.push_back(def);
                    }
                    else
                    {
                        TempDef def(TempType::INT_PTR,-1);
                        args.push_back(def);
                    }
                }
                else
                {
                    assert(0);
                }
            }
            defs.push_back(L_Funcdecl(*v->u.fnDeclStmt->fnDecl->id,args,type));
            break;
        }
        case A_programFnDefKind:
        {
            if(funcReturnMap.find(*v->u.fnDef->fnDecl->id) == funcReturnMap.end())
            {
                FuncType type;
                if(v->u.fnDef->fnDecl->type == nullptr)
                {
                    type.type = ReturnType::VOID_TYPE;
                }
                else if(v->u.fnDef->fnDecl->type->type == A_nativeTypeKind)
                {
                    type.type = ReturnType::INT_TYPE;
                }
                else if(v->u.fnDef->fnDecl->type->type == A_structTypeKind)
                {
                    type.type = ReturnType::STRUCT_TYPE;
                    type.structname = *v->u.fnDef->fnDecl->type->u.structType;
                }
                else
                {
                    assert(0);
                }
                funcReturnMap.emplace(*v->u.fnDef->fnDecl->id,std::move(type));
            }
            break;
        }
        default:
            assert(0);
            break;
        }
    }
    return defs;
}

std::vector<Func_local*> ast2llvmProg_second(aA_program p)
{
    vector<Func_local*> funcs;
    for(const auto & v : p->programElements)
    {
        switch (v->kind)
        {
        case A_programNullStmtKind:
        {
            break;
        }
        case A_programVarDeclStmtKind:
        {
            break;
        }
        case A_programStructDefKind:
        {
            break;
        }
        case A_programFnDeclStmtKind:
        {
            break;
        }
        case A_programFnDefKind:
        {
            funcs.push_back(ast2llvmFunc(v->u.fnDef));
            break;
        }
        default:
            assert(0);
            break;
        }
    }
    return funcs;
}

AS_operand* get_dst(AS_operand* src){
    AS_operand* dst;
    TempType tempType;
    int len;
    string name;
    if (src->kind == OperandKind::ICONST){
        return AS_Operand_Const(src->u.ICONST);
    }
    else if(src->kind == OperandKind::NAME){
        tempType = src->u.NAME->type;
        len = src->u.NAME->len;
        name = src->u.NAME->structname;
    }
    else if(src->kind == OperandKind::TEMP){
        tempType = src->u.TEMP->type;
        len = src->u.TEMP->len;
        name = src->u.TEMP->structname;
    }

    if(tempType == TempType::INT_TEMP){
        dst = AS_Operand_Temp(Temp_newtemp_int());
    }
    else if(tempType == TempType::INT_PTR){
        dst = AS_Operand_Temp(Temp_newtemp_int_ptr(len));
    }
    else if(tempType == TempType::STRUCT_TEMP){
        dst = AS_Operand_Temp(Temp_newtemp_struct(name));
    }
    else if(tempType == TempType::STRUCT_PTR){
        dst = AS_Operand_Temp(Temp_newtemp_struct_ptr(len, name));
    }

    return dst;
}

Func_local* ast2llvmFunc(aA_fnDef f)
{
    // 清空已有的中间代码和局部变量映射
    emit_irs.clear();
    localVarMap.clear();
    
    // 获取函数名称
    string fun_name = *f->fnDecl->id;
    FuncType ret_type;

    // 判断函数返回类型并设置
    if (!f->fnDecl->type) {
        // 如果没有返回类型，默认为 void
        ret_type = FuncType(LLVMIR::ReturnType::VOID_TYPE);
    }
    else {
        if (f->fnDecl->type->type == A_dataType::A_nativeTypeKind) {
            // 如果返回类型是原生类型（例如 int），则设置为默认返回类型
            ret_type = FuncType();
        }
        else {
            // 如果返回类型是结构体类型
            ret_type = FuncType(LLVMIR::ReturnType::STRUCT_TYPE, *f->fnDecl->type->u.structType);
        }
    }

    // 存储参数及其生成的临时变量
    std::vector<Temp_temp*> args;
    list<L_stm*> args_irs;

    // 遍历参数声明
    for (int i = 0; i < f->fnDecl->paramDecl->varDecls.size(); i++) {
        // 处理标量参数
        if (f->fnDecl->paramDecl->varDecls[i]->kind == A_varDeclType::A_varDeclScalarKind) {
            string arg_name = *f->fnDecl->paramDecl->varDecls[i]->u.declScalar->id;
            if (f->fnDecl->paramDecl->varDecls[i]->u.declScalar->type->type == A_dataType::A_nativeTypeKind) {
                // 如果是原生类型参数（例如 int）
                Temp_temp* temp = Temp_newtemp_int();  // 创建临时变量
                Temp_temp* load = Temp_newtemp_int_ptr(0);  // 创建指针类型临时变量
                args_irs.push_back(L_Alloca(AS_Operand_Temp(load)));  // 为参数分配内存
                args_irs.push_back(L_Store(AS_Operand_Temp(temp), AS_Operand_Temp(load)));  // 将参数值存储到分配的内存中
                args.push_back(temp);
                localVarMap.emplace(arg_name, load);  // 将参数映射到局部变量
            }
            else {
                // 如果是结构体类型参数
                string struct_name = *f->fnDecl->paramDecl->varDecls[i]->u.declScalar->type->u.structType;
                StructInfo info = structInfoMap.find(struct_name)->second;  // 获取结构体信息
                Temp_temp* temp = Temp_newtemp_struct_ptr(0, struct_name);  // 创建结构体类型的临时变量
                args.push_back(temp);
                localVarMap.emplace(arg_name, temp);  // 将参数映射到局部变量
            }
        }
        else {
            // 处理数组参数
            string arg_name = *f->fnDecl->paramDecl->varDecls[i]->u.declArray->id;
            if (f->fnDecl->paramDecl->varDecls[i]->u.declArray->type->type == A_dataType::A_nativeTypeKind) {
                Temp_temp *temp = Temp_newtemp_int_ptr(-1);  // 创建数组类型的指针变量
                args.push_back(temp);
                localVarMap.emplace(arg_name, temp);  // 将数组参数映射到局部变量
            }
            else {
                // 如果是结构体数组类型
                string struct_name = *f->fnDecl->paramDecl->varDecls[i]->u.declArray->type->u.structType;
                Temp_temp *temp = Temp_newtemp_struct_ptr(-1, struct_name);  // 创建结构体数组的临时变量
                args.push_back(temp);
                localVarMap.emplace(arg_name, temp);  // 将数组参数映射到局部变量
            }
        }
    }

    // 生成 IR 代码
    Temp_label* start_label = Temp_newlabel();  // 为函数生成入口标签
    if (args_irs.size() > 0) {
        // 如果参数需要特殊处理，生成参数部分的 IR
        Temp_label* args_label = Temp_newlabel();
        emit_irs.push_back(L_Label(args_label));  // 参数部分标签
        for (auto it = args_irs.begin(); it != args_irs.end(); ++it) {
            emit_irs.push_back(*it);  // 添加参数 IR
        }
        emit_irs.push_back(L_Jump(start_label));  // 跳转到函数开始
    }

    emit_irs.push_back(L_Label(start_label));  // 函数体标签

    // 生成函数体内的每一条语句的 IR
    for (int i = 0; i < f->stmts.size(); i++) {
        ast2llvmBlock(f->stmts[i], start_label);  // 对每个语句生成 IR
    }

    // 如果最后一条语句不是返回语句、条件跳转、无条件跳转，则根据返回类型添加默认的返回语句
    if (emit_irs.back()->type != L_StmKind::T_RETURN && emit_irs.back()->type != L_StmKind::T_CJUMP && emit_irs.back()->type != L_StmKind::T_JUMP) {
        if (ret_type.type == ReturnType::INT_TYPE) {
            emit_irs.push_back(L_Ret(AS_Operand_Const(0)));  // 返回整数 0
        }
        else {
            emit_irs.push_back(L_Ret(nullptr));  // 返回空（void 函数）
        }
    }

    // 返回生成的函数 IR
    Func_local* func = new Func_local(fun_name, ret_type, args, emit_irs);
    return func;
}


void ast2llvmBlock(aA_codeBlockStmt b, Temp_label *con_label, Temp_label *bre_label)
{
    // 如果是函数调用语句
    if (b->kind == A_codeBlockStmtType::A_callStmtKind){
        // 获取函数返回类型
        FuncType ret_type = funcReturnMap.find(*b->u.callStmt->fnCall->fn)->second;
        
        std::vector<AS_operand*> args;
        // 遍历函数调用参数
        for (int i = 0; i < b->u.callStmt->fnCall->vals.size(); i++)
        {
            // 如果参数是算术表达式
            if(b->u.callStmt->fnCall->vals[i]->kind == A_arithExprValKind){
                if (b->u.callStmt->fnCall->vals[i]->u.arithExpr->kind == A_exprUnitKind){
                    if (b->u.callStmt->fnCall->vals[i]->u.arithExpr->u.exprUnit->kind == A_idExprKind){
                        // 如果参数是全局变量
                        if (globalVarMap.find(*b->u.callStmt->fnCall->vals[i]->u.arithExpr->u.exprUnit->u.id) != globalVarMap.end())
                        {
                            Name_name* name = globalVarMap.at(*b->u.callStmt->fnCall->vals[i]->u.arithExpr->u.exprUnit->u.id);
                            if (name->type == TempType::STRUCT_PTR)
                            {
                                // 如果是结构体指针类型，处理为指针并获取元素
                                AS_operand* tmp = AS_Operand_Temp(Temp_newtemp_struct_ptr(-1,name->structname));
                                emit_irs.push_back(L_Gep(tmp, AS_Operand_Name(name), AS_Operand_Const(0)));
                                args.push_back(tmp);
                                continue;
                            }
                            if (name->type == TempType::INT_PTR)
                            {
                                // 如果是整型指针类型，处理为指针并获取元素
                                AS_operand* tmp = AS_Operand_Temp(Temp_newtemp_int_ptr(-1));
                                emit_irs.push_back(L_Gep(tmp, AS_Operand_Name(name), AS_Operand_Const(0)));
                                args.push_back(tmp);
                                continue;
                            }
                        }
                        // 如果是局部变量，处理为局部变量的地址
                        else if (localVarMap.find(*b->u.callStmt->fnCall->vals[i]->u.arithExpr->u.exprUnit->u.id) != localVarMap.end())
                        {
                            AS_operand* local_type = ast2llvmRightVal(b->u.callStmt->fnCall->vals[i]);
                            if (local_type->u.TEMP->type == TempType::STRUCT_PTR || local_type->u.TEMP->type == TempType::INT_PTR)
                            {
                                Temp_temp* name = localVarMap.at(*b->u.callStmt->fnCall->vals[i]->u.arithExpr->u.exprUnit->u.id);
                                // 处理结构体和整型指针类型局部变量
                                if (name->type == TempType::STRUCT_PTR && name->len >= 0)
                                {
                                    AS_operand* tmp = AS_Operand_Temp(Temp_newtemp_struct_ptr(-1,name->structname));
                                    emit_irs.push_back(L_Gep(tmp, AS_Operand_Temp(name), AS_Operand_Const(0)));
                                    args.push_back(tmp);
                                    continue;
                                }
                                if (name->type == TempType::INT_PTR && name->len >= 0)
                                {
                                    AS_operand* tmp = AS_Operand_Temp(Temp_newtemp_int_ptr(-1));
                                    emit_irs.push_back(L_Gep(tmp, AS_Operand_Temp(name), AS_Operand_Const(0)));
                                    args.push_back(tmp);
                                    continue;
                                }
                            }
                        }
                    }
                }
            }
            // 将表达式值转换为LLVM右值，并加入参数列表
            args.push_back(ast2llvmRightVal(b->u.callStmt->fnCall->vals[i]));
        }
        
        // 根据返回类型生成相应的函数调用IR
        if (ret_type.type == ReturnType::VOID_TYPE){
            emit_irs.push_back(L_Voidcall(*b->u.callStmt->fnCall->fn, args));
        }
        else if (ret_type.type == ReturnType::INT_TYPE){
            Temp_temp* ret = Temp_newtemp_int();
            emit_irs.push_back(L_Call(*b->u.callStmt->fnCall->fn,AS_Operand_Temp(ret),args));
        }
        else{
            Temp_temp* ret = Temp_newtemp_struct(ret->structname);
            emit_irs.push_back(L_Call(*b->u.callStmt->fnCall->fn,AS_Operand_Temp(ret),args));
        }
    }

    // 如果是变量声明语句
    else if(b->kind == A_codeBlockStmtType::A_varDeclStmtKind){
        // 如果是标量变量声明
        if (b->u.varDeclStmt->kind == A_varDeclStmtType::A_varDeclKind){
            if (b->u.varDeclStmt->u.varDecl->kind == A_varDeclType::A_varDeclScalarKind){
                string var_name = *b->u.varDeclStmt->u.varDecl->u.declScalar->id;
                // 如果是局部变量，首先删除它（如果存在）
                if (localVarMap.find(var_name) != localVarMap.end()){
                    localVarMap.erase(var_name);
                }
                Temp_temp* reg;
                // 根据类型决定变量的类型（指针类型或结构体类型）
                if(!b->u.varDeclStmt->u.varDecl->u.declScalar->type){
                    reg = Temp_newtemp_int_ptr(0);
                }
                else if(b->u.varDeclStmt->u.varDecl->u.declScalar->type->type == A_dataType::A_nativeTypeKind){
                    reg = Temp_newtemp_int_ptr(0);
                }
                else if(b->u.varDeclStmt->u.varDecl->u.declScalar->type->type == A_dataType::A_structTypeKind){
                    reg = Temp_newtemp_struct_ptr(0, *b->u.varDeclStmt->u.varDecl->u.declScalar->type->u.structType);
                }
                emit_irs.push_back(L_Alloca(AS_Operand_Temp(reg)));
                localVarMap.emplace(var_name, reg);
            }
            // 如果是数组变量声明
            else if(b->u.varDeclStmt->u.varDecl->kind == A_varDeclType::A_varDeclArrayKind){
                string var_name = *b->u.varDeclStmt->u.varDecl->u.declArray->id;
                if (localVarMap.find(var_name) != localVarMap.end()){
                    localVarMap.erase(var_name);
                }
                int arr_len = b->u.varDeclStmt->u.varDecl->u.declArray->len;
                Temp_temp* reg;
                // 根据数组元素类型决定类型
                if(!b->u.varDeclStmt->u.varDecl->u.declArray->type){
                    reg =  Temp_newtemp_int_ptr(arr_len);
                }
                else if(b->u.varDeclStmt->u.varDecl->u.declArray->type->type == A_dataType::A_nativeTypeKind){
                    reg =  Temp_newtemp_int_ptr(arr_len);
                }
                else if(b->u.varDeclStmt->u.varDecl->u.declArray->type->type == A_dataType::A_structTypeKind){
                    reg =  Temp_newtemp_struct_ptr(arr_len, *b->u.varDeclStmt->u.varDecl->u.declArray->type->u.structType);
                }
                emit_irs.push_back(L_Alloca(AS_Operand_Temp(reg)));
                localVarMap.emplace(var_name, reg);
            }
        }
        // 如果是变量定义语句
        else if(b->u.varDeclStmt->kind == A_varDeclStmtType::A_varDefKind){
            // 处理标量变量的赋值
            if(b->u.varDeclStmt->u.varDef->kind == A_varDefType::A_varDefScalarKind){
                if (!b->u.varDeclStmt->u.varDef->u.defScalar->type){
                    Temp_temp* reg = Temp_newtemp_int_ptr(0);
                    AS_operand* rightVal = ast2llvmRightVal(b->u.varDeclStmt->u.varDef->u.defScalar->val);
                    emit_irs.push_back(L_Alloca(AS_Operand_Temp(reg)));
                    emit_irs.push_back(L_Store(rightVal, AS_Operand_Temp(reg)));
                    if (localVarMap.find(*b->u.varDeclStmt->u.varDef->u.defScalar->id) != localVarMap.end()){
                        localVarMap.erase(*b->u.varDeclStmt->u.varDef->u.defScalar->id);
                    }
                    localVarMap.emplace(*b->u.varDeclStmt->u.varDef->u.defScalar->id, reg);
                }
                // 同样的处理数组类型
                else if(b->u.varDeclStmt->u.varDef->u.defScalar->type->type == A_dataType::A_nativeTypeKind){
                    Temp_temp* reg = Temp_newtemp_int_ptr(0);
                    AS_operand* rightVal = ast2llvmRightVal(b->u.varDeclStmt->u.varDef->u.defScalar->val);
                    emit_irs.push_back(L_Alloca(AS_Operand_Temp(reg)));
                    emit_irs.push_back(L_Store(rightVal, AS_Operand_Temp(reg)));
                    if (localVarMap.find(*b->u.varDeclStmt->u.varDef->u.defScalar->id) != localVarMap.end()){
                        localVarMap.erase(*b->u.varDeclStmt->u.varDef->u.defScalar->id);
                    }
                    localVarMap.emplace(*b->u.varDeclStmt->u.varDef->u.defScalar->id, reg);
                }
                // 结构体类型的处理
                else if(b->u.varDeclStmt->u.varDef->u.defScalar->type->type == A_dataType::A_structTypeKind){
                    Temp_temp* reg = Temp_newtemp_struct_ptr(0,*b->u.varDeclStmt->u.varDef->u.defScalar->type->u.structType);
                    AS_operand* rightVal = ast2llvmRightVal(b->u.varDeclStmt->u.varDef->u.defScalar->val);
                    emit_irs.push_back(L_Alloca(AS_Operand_Temp(reg)));
                    emit_irs.push_back(L_Store(rightVal, AS_Operand_Temp(reg)));
                    if (localVarMap.find(*b->u.varDeclStmt->u.varDef->u.defScalar->id) != localVarMap.end()){
                        localVarMap.erase(*b->u.varDeclStmt->u.varDef->u.defScalar->id);
                    }
                    localVarMap.emplace(*b->u.varDeclStmt->u.varDef->u.defScalar->id, reg);
                }
            }
            // 处理数组类型变量定义
            else if(b->u.varDeclStmt->u.varDef->kind == A_varDefType::A_varDefArrayKind){
                if (!b->u.varDeclStmt->u.varDef->u.defArray->type){
                    Temp_temp* reg = Temp_newtemp_int_ptr(b->u.varDeclStmt->u.varDef->u.defArray->len);
                    emit_irs.push_back(L_Alloca(AS_Operand_Temp(reg)));
                    for (int i = 0; i < b->u.varDeclStmt->u.varDef->u.defArray->vals.size(); i++){
                        AS_operand* rightVal = ast2llvmRightVal(b->u.varDeclStmt->u.varDef->u.defArray->vals[i]);
                        Temp_temp* reg_temp = Temp_newtemp_int_ptr(0);
                        emit_irs.push_back(L_Gep(AS_Operand_Temp(reg_temp), AS_Operand_Temp(reg), AS_Operand_Const(i)));
                        emit_irs.push_back(L_Store(rightVal, AS_Operand_Temp(reg_temp)));
                    }
                    if (localVarMap.find(*b->u.varDeclStmt->u.varDef->u.defArray->id) != localVarMap.end()){
                        localVarMap.erase(*b->u.varDeclStmt->u.varDef->u.defArray->id);
                    }
                    localVarMap.emplace(*b->u.varDeclStmt->u.varDef->u.defArray->id, reg);
                }
                else if(b->u.varDeclStmt->u.varDef->u.defArray->type->type == A_dataType::A_nativeTypeKind){
                    Temp_temp* reg = Temp_newtemp_int_ptr(b->u.varDeclStmt->u.varDef->u.defArray->len);
                    
                    emit_irs.push_back(L_Alloca(AS_Operand_Temp(reg)));
                    for (int i = 0; i < b->u.varDeclStmt->u.varDef->u.defArray->vals.size(); i++){
                        AS_operand* rightVal = ast2llvmRightVal(b->u.varDeclStmt->u.varDef->u.defArray->vals[i]);
                        Temp_temp* reg_temp = Temp_newtemp_int_ptr(0);
                        emit_irs.push_back(L_Gep(AS_Operand_Temp(reg_temp), AS_Operand_Temp(reg), AS_Operand_Const(i)));
                        emit_irs.push_back(L_Store(rightVal, AS_Operand_Temp(reg_temp)));
                    }
                    if (localVarMap.find(*b->u.varDeclStmt->u.varDef->u.defArray->id) != localVarMap.end()){
                        localVarMap.erase(*b->u.varDeclStmt->u.varDef->u.defArray->id);
                    }
                    localVarMap.emplace(*b->u.varDeclStmt->u.varDef->u.defArray->id, reg);
                }
                else if(b->u.varDeclStmt->u.varDef->u.defArray->type->type == A_dataType::A_structTypeKind){
                    Temp_temp* reg = Temp_newtemp_struct_ptr(b->u.varDeclStmt->u.varDef->u.defArray->len, *b->u.varDeclStmt->u.varDef->u.defArray->type->u.structType);
                    emit_irs.push_back(L_Alloca(AS_Operand_Temp(reg)));
                    for (int i = 0; i < b->u.varDeclStmt->u.varDef->u.defArray->vals.size(); i++){
                        AS_operand* rightVal = ast2llvmRightVal(b->u.varDeclStmt->u.varDef->u.defArray->vals[i]);
                        Temp_temp* reg_temp = Temp_newtemp_struct_ptr(b->u.varDeclStmt->u.varDef->u.defArray->len-i, *b->u.varDeclStmt->u.varDef->u.defArray->type->u.structType);
                        emit_irs.push_back(L_Gep(AS_Operand_Temp(reg_temp), AS_Operand_Temp(reg), AS_Operand_Const(i)));
                        emit_irs.push_back(L_Store(rightVal, AS_Operand_Temp(reg_temp)));
                    }
                    if (localVarMap.find(*b->u.varDeclStmt->u.varDef->u.defArray->id) != localVarMap.end()){
                        localVarMap.erase(*b->u.varDeclStmt->u.varDef->u.defArray->id);
                    }
                    localVarMap.emplace(*b->u.varDeclStmt->u.varDef->u.defArray->id, reg);
                }
            }
        }
    }

    // 处理赋值语句
    else if(b->kind == A_codeBlockStmtType::A_assignStmtKind){
        AS_operand* right = ast2llvmRightVal(b->u.assignStmt->rightVal);
        AS_operand* left = ast2llvmLeftVal(b->u.assignStmt->leftVal);
        emit_irs.push_back(L_Store(right, left));
    }

    // 处理返回语句
    else if (b->kind == A_codeBlockStmtType::A_returnStmtKind){
        AS_operand* ret;
        if (!b->u.returnStmt->retVal){
            ret = nullptr;
        }
        else{
            ret = ast2llvmRightVal(b->u.returnStmt->retVal);
        }
        emit_irs.push_back(L_Ret(ret));
    }

    // 处理if语句
    else if(b->kind == A_codeBlockStmtType::A_ifStmtKind){
        Temp_label* if_label = Temp_newlabel();
        Temp_label* else_label = Temp_newlabel();
        Temp_label* continue_label = Temp_newlabel();
        // 将条件表达式转化为LLVM IR并生成跳转指令
        ast2llvmBoolUnit(b->u.ifStmt->boolUnit, if_label, else_label);
        emit_irs.push_back(L_Label(if_label));
        // 处理if语句块
        for (int i = 0; i < b->u.ifStmt->ifStmts.size(); i++){
            ast2llvmBlock(b->u.ifStmt->ifStmts[i], con_label, bre_label);
        }
        emit_irs.push_back(L_Jump(continue_label));
        // 处理else语句块
        if (b->u.ifStmt->elseStmts.size() > 0){
            emit_irs.push_back(L_Label(else_label));
            for (int i = 0; i < b->u.ifStmt->elseStmts.size(); i++){
                ast2llvmBlock(b->u.ifStmt->elseStmts[i], con_label, bre_label);
            }
            emit_irs.push_back(L_Jump(continue_label));
        }
        else{
            emit_irs.push_back(L_Label(else_label));
            emit_irs.push_back(L_Jump(continue_label));
        }
        emit_irs.push_back(L_Label(continue_label));
    }

    // 处理while语句
    else if(b->kind == A_codeBlockStmtType::A_whileStmtKind){
        Temp_label* check_label = Temp_newlabel();
        Temp_label* body_label = Temp_newlabel();
        Temp_label* out_label = Temp_newlabel();
        emit_irs.push_back(L_Jump(check_label));
        emit_irs.push_back(L_Label(check_label));
        ast2llvmBoolUnit(b->u.whileStmt->boolUnit,body_label,out_label);
        emit_irs.push_back(L_Label(body_label));
        for (int i = 0; i < b->u.whileStmt->whileStmts.size(); i++)
        {
            ast2llvmBlock(b->u.whileStmt->whileStmts[i], check_label, out_label);
        }
        emit_irs.push_back(L_Jump(check_label));
        emit_irs.push_back(L_Label(out_label));
    }

    // 处理break语句
    else if(b->kind == A_codeBlockStmtType::A_breakStmtKind){
        emit_irs.push_back(L_Jump(bre_label));
    }

    // 处理continue语句
    else if(b->kind == A_codeBlockStmtType::A_continueStmtKind){
        emit_irs.push_back(L_Jump(con_label));
    }
}




AS_operand* ast2llvmRightVal(aA_rightVal r)
{
    // 右值类型可以是算术表达式或布尔表达式
    if (r->kind == A_rightValType::A_arithExprValKind) {
        // 如果是算术表达式，调用 ast2llvmArithExpr 转换算术表达式为 IR
        return ast2llvmArithExpr(r->u.arithExpr);
    }
    else {
        // 如果是布尔表达式，处理布尔值转换
        Temp_label* true_label = Temp_newlabel();  // 创建布尔表达式为真时的跳转标签
        Temp_label* false_label = Temp_newlabel(); // 创建布尔表达式为假时的跳转标签
        AS_operand* return_bool = AS_Operand_Temp(Temp_newtemp_int_ptr(0));  // 为布尔结果分配内存
        emit_irs.push_back(L_Alloca(return_bool));  // 将分配内存的 IR 添加到 IR 列表中

        // 处理布尔表达式并生成 IR
        AS_operand* result = ast2llvmBoolExpr(r->u.boolExpr, true_label, false_label);

        // 创建退出标签，表示布尔表达式计算完成后跳转
        Temp_label* out_label = Temp_newlabel();
        emit_irs.push_back(L_Label(true_label));  // 进入 true 标签
        emit_irs.push_back(L_Store(AS_Operand_Const(1), return_bool));  // 如果为真，将 1 存储到布尔值地址
        emit_irs.push_back(L_Jump(out_label));  // 跳转到 out_label

        emit_irs.push_back(L_Label(false_label));  // 进入 false 标签
        emit_irs.push_back(L_Store(AS_Operand_Const(0), return_bool));  // 如果为假，将 0 存储到布尔值地址
        emit_irs.push_back(L_Jump(out_label));  // 跳转到 out_label

        emit_irs.push_back(L_Label(out_label));  // out_label 标签，表示布尔表达式处理完毕

        // 加载布尔结果到临时变量并返回
        AS_operand* load_result = AS_Operand_Temp(Temp_newtemp_int());
        emit_irs.push_back(L_Load(load_result, return_bool));  // 从布尔值地址加载值
        return load_result;  // 返回加载的结果
    }
}


AS_operand* ast2llvmLeftVal(aA_leftVal l)
{
    // 处理不同类型的左值
    AS_operand* result;  // 用来存储最终的操作数
    AS_operand* left;    // 临时变量，存储中间结果

    // 1. 如果是变量（id）
    if (l->kind == A_leftValType::A_varValKind){
        // 如果在局部变量映射表中找到该变量
        if(localVarMap.find(*l->u.id) != localVarMap.end()){
            // 从局部变量映射表获取并返回对应的操作数（临时变量）
            result = AS_Operand_Temp(localVarMap.find(*l->u.id)->second);
        }
        // 如果在全局变量映射表中找到该变量
        else if(globalVarMap.find(*l->u.id) != globalVarMap.end()){
            // 从全局变量映射表获取并返回对应的操作数（全局变量的名称）
            result = AS_Operand_Name(globalVarMap.find(*l->u.id)->second);
        }
    }
    // 2. 如果是结构体成员（左值是结构体的成员）
    else if(l->kind == A_leftValType::A_memberValKind){
        // 递归调用 ast2llvmLeftVal 获取结构体的基地址（base）
        AS_operand* base = ast2llvmLeftVal(l->u.memberExpr->structId);
        StructInfo info;

        // 判断 base 操作数的类型（TEMP 或 NAME）
        if (base->kind == OperandKind::TEMP){
            // 如果 base 是临时变量，获取结构体信息
            info = structInfoMap.find(base->u.TEMP->structname)->second;
        }
        else{
            // 如果 base 是全局变量，获取结构体信息
            info = structInfoMap.find(base->u.NAME->structname)->second;
        }

        // 获取成员变量的名字和信息
        string member_id = *l->u.memberExpr->memberId;
        MemberInfo member = info.memberinfos.find(member_id)->second;
        int index = member.offset;  // 成员的偏移量

        // 创建新的指针类型临时变量（根据成员类型）
        Temp_temp* new_ptr;
        if (member.def.kind == TempType::INT_TEMP){
            new_ptr = Temp_newtemp_int();  // 整数类型
        }
        else if(member.def.kind == TempType::INT_PTR){
            new_ptr = Temp_newtemp_int_ptr(member.def.len);  // 整数指针类型
        }
        else if(member.def.kind == TempType::STRUCT_TEMP){
            new_ptr = Temp_newtemp_struct_ptr(0, member.def.structname);  // 结构体类型
        }
        else if(member.def.kind == TempType::STRUCT_PTR){
            new_ptr = Temp_newtemp_struct_ptr(member.def.len, member.def.structname);  // 结构体指针类型
        }

        // 将新创建的临时变量作为操作数返回
        result = AS_Operand_Temp(new_ptr);

        // 生成 IR，使用 L_Gep 指令生成成员变量的地址
        emit_irs.push_back(L_Gep(result, base, AS_Operand_Const(index)));
    }
    // 3. 如果是数组元素（左值是数组的元素）
    else if(l->kind == A_leftValType::A_arrValKind){
        // 处理数组下标表达式，递归生成数组下标的 IR
        AS_operand* index = ast2llvmIndexExpr(l->u.arrExpr->idx);
        // 获取数组基地址
        AS_operand* base = ast2llvmLeftVal(l->u.arrExpr->arr);

        // 创建新的寄存器变量，根据基地址的类型判断新寄存器类型
        Temp_temp* new_reg;
        if (base->kind == OperandKind::TEMP){
            if (base->u.TEMP->type == TempType::INT_PTR){
                new_reg = Temp_newtemp_int_ptr(base->u.TEMP->len);  // 整数指针类型
            }
            else{
                new_reg = Temp_newtemp_struct_ptr(0, base->u.TEMP->structname);  // 结构体指针类型
            }
        }
        else if (base->kind == OperandKind::NAME){
            if (base->u.NAME->type == TempType::INT_PTR){
                new_reg = Temp_newtemp_int_ptr(base->u.NAME->len);  // 整数指针类型
            }
            else{
                new_reg = Temp_newtemp_struct_ptr(0, base->u.NAME->structname);  // 结构体指针类型
            }
        }

        // 将新创建的寄存器操作数作为结果返回
        result = AS_Operand_Temp(new_reg);

        // 生成 IR，使用 L_Gep 指令生成数组元素的地址
        emit_irs.push_back(L_Gep(result, base, index));
    }

    return result;  // 返回最终生成的操作数
}


AS_operand* ast2llvmIndexExpr(aA_indexExpr index)
{
    AS_operand* result;  // 存储最终生成的操作数
    AS_operand* ptr;     // 临时变量，用于存储索引变量的操作数

    // 1. 如果索引是一个常数数字（A_numIndexKind）
    if (index->kind == A_indexExprKind::A_numIndexKind){
        // 如果是常数索引，直接返回常数操作数
        result = AS_Operand_Const(index->u.num);
    }
    else{
        // 2. 如果索引是一个变量（id）
        // 检查该变量是否在局部变量映射表中
        if(localVarMap.find(*index->u.id) != localVarMap.end()){
            // 如果是局部变量，从局部变量表获取对应的操作数
            ptr = AS_Operand_Temp(localVarMap.find(*index->u.id)->second);
        }
        else{
            // 如果是全局变量，从全局变量表获取对应的操作数
            ptr = AS_Operand_Name(globalVarMap.find(*index->u.id)->second);
        }
        
        // 创建一个新的临时整数变量，用来存储索引结果
        result = AS_Operand_Temp(Temp_newtemp_int());
        
        // 生成 IR，使用 L_Load 指令将索引变量的值加载到 `result` 中
        emit_irs.push_back(L_Load(result, ptr));
    }

    // 返回生成的操作数（索引值）
    return result;
}



AS_operand* ast2llvmBoolExpr(aA_boolExpr b,Temp_label *true_label,Temp_label *false_label)
{
    bool should_return = false;
    AS_operand* stackPtr = nullptr;
    if (true_label == nullptr || false_label == nullptr) {
        true_label = Temp_newlabel();
        false_label = Temp_newlabel();
        should_return = true;
        stackPtr = AS_Operand_Temp(Temp_newtemp_int_ptr(0));

        // 需要分配空间存放布尔值(用int表示)
        emit_irs.push_back(L_Alloca(stackPtr));
    }
    if (b->kind == A_boolExprType::A_boolBiOpExprKind) {
        ast2llvmBoolBiOpExpr(b->u.boolBiOpExpr, true_label, false_label);
    } else if (b->kind == A_boolExprType::A_boolUnitKind) {
        ast2llvmBoolUnit(b->u.boolUnit, true_label, false_label);
    }
    if (should_return) {
        // cerr << "ast2llvmBoolExpr: should_return"<<endl;
        auto temp = AS_Operand_Temp(Temp_newtemp_int());
        auto end_label = Temp_newlabel();
        // cerr << "true:"<<true_label->name << "\tfalse:" << false_label->name << "\tend:" << end_label->name << endl;
        // cerr << "stackPtr:" << stackPtr->u.TEMP->num << endl;
        // 在真和假标签处，分别存储整数值 1 和 0 到之前分配的 stackPtr
        // 从这两个标签跳转到一个公共的结束标签

        // true
        emit_irs.push_back(L_Label(true_label));
        emit_irs.push_back(L_Store(AS_Operand_Const(1), stackPtr));
        emit_irs.push_back(L_Jump(end_label));

        // false
        emit_irs.push_back(L_Label(false_label));
        emit_irs.push_back(L_Store(AS_Operand_Const(0), stackPtr));
        emit_irs.push_back(L_Jump(end_label));

        // 加载 stackPtr 的内容到另一个新的临时变量
        // ir: end
        emit_irs.push_back(L_Label(end_label));
        emit_irs.push_back(L_Load(temp, stackPtr));

        return temp;
    }
    return nullptr;
}


void ast2llvmBoolBiOpExpr(aA_boolBiOpExpr b, Temp_label *true_label, Temp_label *false_label)
{
    // 创建一个临时操作数用于存储布尔二元操作的结果（初始为指向 int 的指针）
    AS_operand* result = AS_Operand_Temp(Temp_newtemp_int_ptr(0));
    
    // 生成一个用于跳转的中间标签
    Temp_label* middle_label = Temp_newlabel();
    
    // 1. 如果操作符是 AND（逻辑与）
    if (b->op == A_boolBiOp::A_and)
    {
        // 递归调用 ast2llvmBoolExpr 处理左操作数，若左操作数为假，跳转到 false_label
        ast2llvmBoolExpr(b->left, middle_label, false_label);
        
        // 添加中间标签，用于右操作数的计算
        emit_irs.push_back(L_Label(middle_label));
        
        // 递归调用 ast2llvmBoolExpr 处理右操作数，若右操作数为假，跳转到 false_label
        ast2llvmBoolExpr(b->right, true_label, false_label);
    }
    // 2. 如果操作符是 OR（逻辑或）
    else
    {
        // 递归调用 ast2llvmBoolExpr 处理左操作数，若左操作数为真，跳转到 true_label
        ast2llvmBoolExpr(b->left, true_label, middle_label);
        
        // 添加中间标签，用于右操作数的计算
        emit_irs.push_back(L_Label(middle_label));
        
        // 递归调用 ast2llvmBoolExpr 处理右操作数，若右操作数为真，跳转到 true_label
        ast2llvmBoolExpr(b->right, true_label, false_label);
    }
}

void ast2llvmBoolUOpExpr(aA_boolUOpExpr b,Temp_label* true_label,Temp_label* false_label) {
    // 检查布尔单目操作符是否为逻辑非（!）
    if (b->op == A_boolUOp::A_not) {
        // 处理布尔单元（条件），并交换 true_label 和 false_label，因为逻辑非的含义是反转
        ast2llvmBoolUnit(b->cond, false_label, true_label);
    } else {
        // 如果是其他类型的布尔单目操作符，断言失败（目前只支持 A_not）
        assert(0);
    }
}


void ast2llvmBoolUnit(aA_boolUnit b, Temp_label *true_label, Temp_label *false_label)
{
    // 如果布尔单元是布尔表达式类型
    if (b->kind == A_boolUnitType::A_boolExprKind) {
        // 调用 ast2llvmBoolExpr 处理布尔表达式
        ast2llvmBoolExpr(b->u.boolExpr, true_label, false_label);
    }
    // 如果布尔单元是布尔单目运算符表达式类型
    else if (b->kind == A_boolUnitType::A_boolUOpExprKind) {
        // 调用 ast2llvmBoolUOpExpr 处理布尔单目运算符表达式（如逻辑非）
        ast2llvmBoolUOpExpr(b->u.boolUOpExpr, true_label, false_label);
    }
    // 如果布尔单元是比较运算符表达式类型
    else if (b->kind == A_boolUnitType::A_comOpExprKind) {
        // 调用 ast2llvmComOpExpr 处理比较运算符表达式（如大于、小于等）
        ast2llvmComOpExpr(b->u.comExpr, true_label, false_label);
    }
}

void ast2llvmComOpExpr(aA_comExpr c, Temp_label *true_label, Temp_label *false_label)
{
    // 通过 ast2llvmExprUnit 转换左侧和右侧的表达式
    auto l = ast2llvmExprUnit(c->left); // 处理左侧表达式
    auto r = ast2llvmExprUnit(c->right); // 处理右侧表达式

    // 创建一个临时的操作数（用于存储比较结果）
    auto dst = AS_Operand_Temp(Temp_newtemp_int());

    // 根据比较运算符类型生成相应的比较指令
    switch (c->op) {
        case A_comOp::A_lt: {
            // 生成小于（<）比较指令
            emit_irs.push_back(L_Cmp(L_relopKind::T_lt, l, r, dst));
            break;
        }
        case A_comOp::A_le: {
            // 生成小于等于（<=）比较指令
            emit_irs.push_back(L_Cmp(L_relopKind::T_le, l, r, dst));
            break;
        }
        case A_comOp::A_gt: {
            // 生成大于（>）比较指令
            emit_irs.push_back(L_Cmp(L_relopKind::T_gt, l, r, dst));
            break;
        }
        case A_comOp::A_ge: {
            // 生成大于等于（>=）比较指令
            emit_irs.push_back(L_Cmp(L_relopKind::T_ge, l, r, dst));
            break;
        }
        case A_comOp::A_eq: {
            // 生成等于（==）比较指令
            emit_irs.push_back(L_Cmp(L_relopKind::T_eq, l, r, dst));
            break;
        }
        case A_comOp::A_ne: {
            // 生成不等于（!=）比较指令
            emit_irs.push_back(L_Cmp(L_relopKind::T_ne, l, r, dst));
            break;
        }
        default:
            break;
    }

    // 根据比较结果执行跳转操作，如果条件为真跳转到 true_label，否则跳转到 false_label
    emit_irs.push_back(L_Cjump(dst, true_label, false_label));
}


AS_operand* ast2llvmArithBiOpExpr(aA_arithBiOpExpr a)
{
    // 1. 递归转换左操作数
    AS_operand* left = ast2llvmArithExpr(a->left);
    
    // 2. 递归转换右操作数
    AS_operand* right = ast2llvmArithExpr(a->right);
    
    // 3. 创建一个新的临时寄存器来存储计算结果，所有的算术运算结果都为 int 类型
    Temp_temp* reg = Temp_newtemp_int();  // 生成一个新的 int 类型的临时寄存器
    
    AS_operand* as = AS_Operand_Temp(reg);  // 将寄存器封装成操作数类型
    
    // 4. 根据二元算术运算符（加法、减法、乘法、除法）选择相应的 LLVM IR 操作
    switch (a->op)
    {
        case A_arithBiOp::A_add:  // 加法操作
            emit_irs.push_back(L_Binop(L_binopKind::T_plus, left, right, AS_Operand_Temp(reg)));
            break;
        case A_arithBiOp::A_sub:  // 减法操作
            emit_irs.push_back(L_Binop(L_binopKind::T_minus, left, right, AS_Operand_Temp(reg)));
            break;
        case A_arithBiOp::A_mul:  // 乘法操作
            emit_irs.push_back(L_Binop(L_binopKind::T_mul, left, right, AS_Operand_Temp(reg)));
            break;
        case A_arithBiOp::A_div:  // 除法操作
            emit_irs.push_back(L_Binop(L_binopKind::T_div, left, right, AS_Operand_Temp(reg)));
            break;
        default:
            break;  // 默认情况：不处理其他运算
    }
    
    // 5. 返回计算结果的临时寄存器
    return AS_Operand_Temp(reg);
}


AS_operand* ast2llvmArithUExpr(aA_arithUExpr a)
{
    // 1. 递归转换表达式，得到原始算术操作数
    AS_operand* origin_ari = ast2llvmExprUnit(a->expr);
    
    // 2. 创建一个新的临时寄存器，用于存储最终计算结果
    Temp_temp* result_reg = Temp_newtemp_int();  // 结果存储为 int 类型的临时寄存器
    
    AS_operand* result = AS_Operand_Temp(result_reg);  // 将寄存器封装成操作数类型
    
    // 3. 执行一元运算：负号（-）
    // 这里的负号操作等价于将 0 减去原始表达式的值，产生负数
    emit_irs.push_back(L_Binop(L_binopKind::T_minus, AS_Operand_Const(0), origin_ari, result));
    
    // 4. 返回计算结果的临时寄存器
    return result;
}


AS_operand* ast2llvmArithExpr(aA_arithExpr a)
{
    // 1. 判断是否为二元算术操作（如加法、减法等）
    if (a->kind == A_arithExprType::A_arithBiOpExprKind){
        // 如果是二元算术操作，递归调用处理二元算术操作的函数
        return ast2llvmArithBiOpExpr(a->u.arithBiOpExpr);
    }
    else{
        // 否则，处理为基本的表达式单元（例如变量、常量等）
        return ast2llvmExprUnit(a->u.exprUnit);
    }
}


AS_operand* ast2llvmExprUnit(aA_exprUnit e)
{
    AS_operand* result;
    switch (e->kind)  // 根据表达式单元的类型进行不同的处理
    {
        case A_exprUnitType::A_numExprKind:{
            result = AS_Operand_Const(e->u.num);  // 处理常量数字，直接返回常量操作数
            break;
        }
        case A_exprUnitType::A_idExprKind:{
            AS_operand* ptr;
            if (localVarMap.find(*e->u.id) != localVarMap.end()){  // 处理局部变量
                ptr = AS_Operand_Temp(localVarMap.find(*e->u.id)->second);
                if (ptr->u.TEMP->type == TempType::INT_PTR && ptr->u.TEMP->len == 0){  // 如果是指针类型并且长度为0
                    result = AS_Operand_Temp(Temp_newtemp_int());
                    emit_irs.push_back(L_Load(result, ptr));  // 从指针加载数据
                }
                else{
                    result = ptr;  // 否则，直接返回该变量
                }
            }
            else if(globalVarMap.find(*e->u.id) != globalVarMap.end()){  // 处理全局变量
                ptr = AS_Operand_Name(globalVarMap.find(*e->u.id)->second);
                if ((ptr->u.NAME->type == TempType::INT_PTR || ptr->u.NAME->type == TempType::INT_TEMP) && ptr->u.NAME->len == 0){  // 类似指针的情况
                    result = AS_Operand_Temp(Temp_newtemp_int());
                    emit_irs.push_back(L_Load(result, ptr));
                }
                else{
                    result = ptr;  // 直接返回全局变量
                }
            }
            break;
        }
        case A_exprUnitType::A_arithExprKind:{
            result = ast2llvmArithExpr(e->u.arithExpr);  // 处理算术表达式，递归调用
            break;
        }
        case A_exprUnitType::A_arithUExprKind:{
            result = ast2llvmArithUExpr(e->u.arithUExpr);  // 处理一元算术表达式，递归调用
            break;
        }
        case A_exprUnitType::A_arrayExprKind:{
            // 处理数组表达式
            AS_operand* index = ast2llvmIndexExpr(e->u.arrayExpr->idx);  // 处理数组索引
            AS_operand* base = ast2llvmLeftVal(e->u.arrayExpr->arr);  // 处理数组基址
            Temp_temp* new_reg;
            if (base->kind == OperandKind::TEMP){  // 如果基址是临时寄存器
                int len = base->u.TEMP->len;
                if (base->u.TEMP->type == TempType::INT_PTR){
                    new_reg = Temp_newtemp_int_ptr(base->u.TEMP->len);  // 创建指针类型的临时寄存器
                }
                else{
                    new_reg = Temp_newtemp_struct_ptr(0, base->u.TEMP->structname);  // 结构体类型
                }
            }
            else if (base->kind == OperandKind::NAME){  // 如果基址是名称
                if (base->u.NAME->type == TempType::INT_PTR){
                    new_reg = Temp_newtemp_int_ptr(base->u.NAME->len);  // 创建指针类型的临时寄存器
                }
                else{
                    new_reg = Temp_newtemp_struct_ptr(0, base->u.NAME->structname);  // 结构体类型
                }
            }
            emit_irs.push_back(L_Gep(AS_Operand_Temp(new_reg), base, index));  // 生成GEP指令
            result = AS_Operand_Temp(Temp_newtemp_int());  // 创建临时寄存器来存储结果
            emit_irs.push_back(L_Load(result, AS_Operand_Temp(new_reg)));  // 从GEP结果中加载数据
            break;
        }
        case A_exprUnitType::A_memberExprKind:{
            // 处理结构体成员访问
            AS_operand* base = ast2llvmLeftVal(e->u.memberExpr->structId);  // 获取结构体基址
            StructInfo info;
            if (base->kind == OperandKind::TEMP){  // 如果基址是临时寄存器
                info = structInfoMap.find(base->u.TEMP->structname)->second;
            }
            else{
                info = structInfoMap.find(base->u.NAME->structname)->second;
            }
            string member_id = *e->u.memberExpr->memberId;  // 获取成员名
            MemberInfo member = info.memberinfos.find(member_id)->second;  // 获取成员信息
            int index = member.offset;  // 获取成员的偏移量
            Temp_temp* new_ptr;
            if (member.def.kind == TempType::INT_TEMP){
                new_ptr = Temp_newtemp_int();  // 为整数类型成员创建临时寄存器
            }
            else if(member.def.kind == TempType::INT_PTR){
                new_ptr = Temp_newtemp_int_ptr(member.def.len);  // 为整数指针类型成员创建临时寄存器
            }
            else if(member.def.kind == TempType::STRUCT_TEMP){
                new_ptr = Temp_newtemp_struct_ptr(0, member.def.structname);  // 为结构体类型成员创建临时寄存器
            }
            else if(member.def.kind == TempType::STRUCT_PTR){
                new_ptr = Temp_newtemp_struct_ptr(member.def.len, member.def.structname);  // 为结构体指针类型成员创建临时寄存器
            }
            result = AS_Operand_Temp(new_ptr);
            emit_irs.push_back(L_Gep(result, base, AS_Operand_Const(index)));  // 生成GEP指令，获取成员地址
            if (member.def.kind == TempType::INT_TEMP){
                result = AS_Operand_Temp(Temp_newtemp_int());
                emit_irs.push_back(L_Load(result, AS_Operand_Temp(new_ptr)));  // 加载成员值
            }
            break;
        }
        case A_exprUnitType::A_fnCallKind:{
            // 处理函数调用
            FuncType ret_fn = funcReturnMap.find(*e->u.callExpr->fn)->second;
            std::vector<AS_operand*> args;
            for (int i = 0; i < e->u.callExpr->vals.size(); i++)
            {
                args.push_back(ast2llvmRightVal(e->u.callExpr->vals[i]));  // 递归处理函数参数
            }
            
            if (ret_fn.type == ReturnType::VOID_TYPE){  // 如果函数返回类型是void
                emit_irs.push_back(L_Voidcall(*e->u.callExpr->fn, args));
            }
            else if (ret_fn.type == ReturnType::INT_TYPE){  // 如果函数返回类型是int
                Temp_temp* ret_fn = Temp_newtemp_int();
                result = AS_Operand_Temp(ret_fn);
                emit_irs.push_back(L_Call(*e->u.callExpr->fn,result,args));  // 调用函数并返回结果
            }
            else{  // 如果函数返回类型是结构体
                Temp_temp* ret = Temp_newtemp_struct(ret->structname);
                result = AS_Operand_Temp(ret);
                emit_irs.push_back(L_Call(*e->u.callExpr->fn,result,args));  // 调用函数并返回结构体类型的结果
            }
            break;
        }
        default:
            break;
    }

    return result;  // 返回生成的LLVM IR操作数
}


LLVMIR::L_func* ast2llvmFuncBlock(Func_local *f)
{
    // 创建一个空的列表，用于存储转换后的LLVM IR块
    list<L_block *> blocks;

    // 创建一个临时的指令列表，用于存放当前正在处理的块内的所有指令
    list<L_stm *> irs = list<L_stm *>();
    
    // 遍历函数中的所有指令（即 f->irs）
    for(const auto &block : f->irs) {
        // 如果当前指令是标签指令（L_LABEL），则表示当前指令是一个块的开始
        if(block->type == L_StmKind::T_LABEL){
            // 如果 irs 列表中有指令，则将这些指令作为一个块存储到 blocks 中
            if(!irs.empty()){
                blocks.push_back(L_Block(irs)); // 将当前的指令列表作为一个新的块加入到 blocks 中
                irs.clear(); // 清空指令列表，为下一个块做准备
            }
        }
        // 将当前指令添加到当前块的指令列表中
        irs.push_back(block);
    }

    // 如果在最后一组指令中还有指令没被加入块中，推入一个新块
    if(!irs.empty()){
        blocks.push_back(L_Block(irs)); // 将剩余的指令作为一个块加入到 blocks 中
    }

    // 创建一个新的 L_func 对象，包含函数的名称、返回类型、参数列表以及所有生成的块
    return new L_func(f->name, f->ret, f->args, blocks);
}


void ast2llvm_moveAlloca(LLVMIR::L_func *f)
{
    auto first_block = f->blocks.front();
    for(auto i = ++f->blocks.begin();i != f->blocks.end();++i)
    {
        for(auto it = (*i)->instrs.begin();it != (*i)->instrs.end();)
        {
            if((*it)->type == L_StmKind::T_ALLOCA)
            {
                first_block->instrs.insert(++first_block->instrs.begin(),*it);
                it = (*i)->instrs.erase(it);
            }
            else
            {
                ++it;
            }
        }
    }
}