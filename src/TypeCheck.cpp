#include "TypeCheck.h"

//global tabels
//typeMap func2retType; // function name to return type

// global token ids to type
typeMap g_token2Type; 

// local token ids to type, since func param can override global param
typeMap funcparam_token2Type;
vector<typeMap*> local_token2Type;


paramMemberMap func2Param;
paramMemberMap struct2Members;


// private util functions
void error_print(std::ostream& out, A_pos p, string info)
{
    out << "Typecheck error in line " << p->line << ", col " << p->col << ": " << info << std::endl;
    exit(0);
}


void print_token_map(typeMap* map){
    for(auto it = map->begin(); it != map->end(); it++){
        std::cout << it->first << " : ";
        switch (it->second->type->type)
        {
        case A_dataType::A_nativeTypeKind:
            switch (it->second->type->u.nativeType)
            {
            case A_nativeType::A_intTypeKind:
                std::cout << "int";
                break;
            default:
                break;
            }
            break;
        case A_dataType::A_structTypeKind:
            std::cout << *(it->second->type->u.structType);
            break;
        default:
            break;
        }
        switch(it->second->isVarArrFunc){
            case 0:
                std::cout << " scalar";
                break;
            case 1:
                std::cout << " array";
                break;
            case 2:
                std::cout << " function";
                break;
        }
        std::cout << std::endl;
    }
}


void print_token_maps(){
    std::cout << "global token2Type:" << std::endl;
    print_token_map(&g_token2Type);
    std::cout << "local token2Type:" << std::endl;
    print_token_map(&funcparam_token2Type);
}

//比较类型是否一样
bool comp_aA_type(aA_type target, aA_type t){
    /*
    if(!target || !t)
        return false;
    if(target->type != t->type)
        return false;
    if(target->type == A_dataType::A_nativeTypeKind)
        if(target->u.nativeType != t->u.nativeType)
            return false;
    if(target->type == A_dataType::A_structTypeKind)
        if(target->u.structType != t->u.structType)
            return false;
    */
    return true;
}

//比较变量名或函数名
bool comp_tc_type(tc_type target, tc_type t){
    if(!target || !t)
        return false;
    
    // arr kind first
    if (target->isVarArrFunc && t->isVarArrFunc == 0)
        return false;
    
    // if target type is nullptr, alwayse ok
    return comp_aA_type(target->type, t->type);
}

//tc_Type构造函数
tc_type tc_Type(aA_type t, uint isVarArrFunc){
    tc_type ret = new tc_type_;
    ret->type = t;
    ret->isVarArrFunc = isVarArrFunc;
    return ret;
}

//变量声明推断类型
tc_type tc_Type(aA_varDecl vd){
    if(vd->kind == A_varDeclType::A_varDeclScalarKind)
        return tc_Type(vd->u.declScalar->type, 0);
    else if(vd->kind == A_varDeclType::A_varDeclArrayKind)
        return tc_Type(vd->u.declArray->type, 1);
    return nullptr;
}

//变量作用域检查
//不能与全局变量同名
bool check_global(string name){
    if(g_token2Type.find(name) != g_token2Type.end())
        return true;
    return false;
}
//局部变量不能与其外部的局部变量同名
//从当前作用域检查，依次向外
bool check_local(string name){
    for(int i = local_token2Type.size() - 1;i >= 0;i--){
        typeMap map = *(local_token2Type[i]);
        if(map.find(name) != map.end())
            return true;
    }
    return false;
}

//检查返回值类型是否匹配
void check_return(std::ostream& out, aA_codeBlockStmt stmt, tc_type target){
    switch (stmt->kind)
        {
        case A_codeBlockStmtType::A_ifStmtKind:
            for (int i = 0; i < stmt->u.ifStmt->ifStmts.size(); i++){
                check_return(out, stmt->u.ifStmt->ifStmts[i], target);
            }
            for (int i = 0; i < stmt->u.ifStmt->elseStmts.size(); i++){
                check_return(out, stmt->u.ifStmt->elseStmts[i], target);
            }
            break;
        case A_codeBlockStmtType::A_whileStmtKind:
            for (int i = 0; i < stmt->u.whileStmt->whileStmts.size(); i++){
                check_return(out, stmt->u.whileStmt->whileStmts[i], target);
            }
            break;
        case A_codeBlockStmtType::A_returnStmtKind:
            if (!stmt->u.returnStmt->retVal){
                if (!target->type){
                    return;  //没有返回值的情况，且右值确实没有返回值
                }
                else{
                    error_print(out,stmt->pos, "Return value type doesn't match");
                    ;
                }
            }
            else if(comp_tc_type(target, check_ArithExpr(out, stmt->u.returnStmt->retVal->u.arithExpr))){
                return;
            }
            else{
                error_print(out, stmt->pos, "return value type doesn't match");
                ;
            }
            break;
        default:
            break;
        }
    return;
}

//检查变量是否被定义，并返回指向该变量的tc_type指针
tc_type find_tc_type(std::ostream& out, string name, A_pos pos){
    //从当前作用域向外寻找，保证局部变量的作用域
    for(int i = local_token2Type.size() - 1;i >= 0;i--){
        std::unordered_map<string,tc_type> map = *(local_token2Type[i]);
        if(map.find(name) != map.end()){
            return map.find(name) -> second;
        }
    }
    //在全局变量中寻找
    if(g_token2Type.find(name) != g_token2Type.end()){
        return g_token2Type.find(name) -> second;
    }else{
        error_print(out,pos,"The variable is undefined!");
        ;
    }
    return nullptr;
}

//为声明时未定义变量类型的变量定义类型
void set_omitted_type(string name, aA_type type, int isVarArrFunc){
    //从当前工作域的局部变量开始依次查找并定义类型
    for(int i = local_token2Type.size() - 1;i >= 0;i--){
        std::unordered_map<string,tc_type> map = *(local_token2Type[i]);
        if(map.find(name) != map.end()){
            (*(local_token2Type[i]))[name] = tc_Type(type,isVarArrFunc);
            return;
        }
    }
    //当前变量为全局变量
    g_token2Type[name] = tc_Type(type,isVarArrFunc);
    return;
}

// public functions
void check_Prog(std::ostream& out, aA_program p)
{
    for (auto ele : p->programElements)
    {
        if(ele->kind == A_programVarDeclStmtKind){
            check_VarDecl(out, ele->u.varDeclStmt);
        }else if (ele->kind == A_programStructDefKind){
            check_StructDef(out, ele->u.structDef);
        }
    }
    
    for (auto ele : p->programElements){
        if(ele->kind == A_programFnDeclStmtKind){
            check_FnDeclStmt(out, ele->u.fnDeclStmt);
        }
        else if (ele->kind == A_programFnDefKind){
            check_FnDecl(out, ele->u.fnDef->fnDecl);
        }
    }

    for (auto ele : p->programElements){
        if(ele->kind == A_programFnDefKind){
            check_FnDef(out, ele->u.fnDef);
        }
        else if (ele->kind == A_programNullStmtKind){
            // do nothing
        }
    }

    //out << "Typecheck passed!" << std::endl;
    return;
}


void check_VarDecl(std::ostream& out, aA_varDeclStmt vd)
{
    if (!vd)
        return;
    string name;
    aA_type type;
    if (vd->kind == A_varDeclStmtType::A_varDeclKind){
        // decl only
        aA_varDecl vdecl = vd->u.varDecl;
        if(vdecl->kind == A_varDeclType::A_varDeclScalarKind){
            name = *vdecl->u.declScalar->id;
            /* fill code here*/
            type = vdecl->u.declScalar->type;
            //如果是Struct，检查一下有没有定义这种类型
            if(type && type->type == A_dataType::A_structTypeKind){
                if(struct2Members.find(*type->u.structType) == struct2Members.end()){
                    error_print(out,vdecl->u.declScalar->type->pos,"The type is undefined!");
                    ;
                }
            }
            //检查该变量名有没有在全局变量和局部变量（包括外部局部变量）中使用
            //如果局部变量列表长度为0，说明当前作用域为全局
            if(local_token2Type.size() == 0){
                if(check_global(name)){
                    error_print(out,vdecl->u.declScalar->pos,"Duplicate definition!");
                    ;
                }
                //将该全局变量加入全局作用域
                tc_type target = tc_Type(type,0);
                g_token2Type.insert({name,target});
            }else{//当前变量为局部变量，分别与局部变量和全局变量对比
                if(check_global(name) || check_local(name)){
                    error_print(out,vdecl->u.declScalar->pos,"Duplicate definition!");
                    ;
                }
                //将该局部变量加入其作用域
                tc_type target = tc_Type(type,0);
                (*local_token2Type[local_token2Type.size()-1])[name] = target;
            }
        }else if (vdecl->kind == A_varDeclType::A_varDeclArrayKind){
            name = *vdecl->u.declArray->id;
            /* fill code here*/
            type = vdecl->u.declArray->type;
            //如果是Struct，检查一下有没有定义这种类型
            if(type && type->type == A_dataType::A_structTypeKind){
                if(struct2Members.find(*type->u.structType) == struct2Members.end()){
                    error_print(out,vdecl->u.declScalar->type->pos,"The type isnot defined!");
                    ;
                }
            }
            //检查该变量名有没有在全局变量和局部变量（包括外部局部变量）中使用
            //如果局部变量列表长度为0，说明当前作用域为全局
            if(local_token2Type.size() == 0){
                if(check_global(name)){
                    error_print(out,vdecl->u.declScalar->pos,"Duplicate definition!");
                    ;
                }
                //将该全局变量加入全局作用域
                tc_type target = tc_Type(type,1);
                g_token2Type.insert({name,target});
            }else{//当前变量为局部变量，分别与局部变量和全局变量对比
                if(check_global(name)||check_local(name)){
                    error_print(out,vdecl->u.declScalar->pos,"Duplicate definition!");
                    ;
                }
                //将该局部变量加入其作用域
                tc_type target = tc_Type(type,1);
                (*local_token2Type[local_token2Type.size()-1])[name] = target;
            }
        }
    }
    else if (vd->kind == A_varDeclStmtType::A_varDefKind){
        // decl and def
        aA_varDef vdef = vd->u.varDef;
        if (vdef->kind == A_varDefType::A_varDefScalarKind){
            name = *vdef->u.defScalar->id;
            /* fill code here, allow omited type */
            type = vdef->u.defScalar->type;
            //如果是Struct，检查一下有没有定义这种类型
            if(type && type->type == A_dataType::A_structTypeKind){
                if(struct2Members.find(*type->u.structType) == struct2Members.end()){
                    error_print(out,vdef->u.defScalar->type->pos,"The type isnot defined!");
                    ;
                }
            }
            //检查是否重复定义
            if (check_local(name) || check_global(name)){
                error_print(out, vdef->u.defArray->pos, "Duplicated definition!");
                ;
            }
            tc_type rightVal_type;
            //检查赋值的右边是否为rightval对应的类型
            rightVal_type = check_ArithExpr(out,vdef->u.defScalar->val->u.arithExpr);
            //检查右值是否已经赋值
            if(!rightVal_type->type){
                error_print(out,vdef->u.defScalar->val->pos,"The right value is unassigned!");
                ;
            }
            //检查赋值左右值类型是否相同
            if((rightVal_type->isVarArrFunc == 2) || (type && !comp_aA_type(type, rightVal_type->type))){
                error_print(out, vdef->u.defScalar->val->pos, "The type of leftVal and rightVal is different!");
                ;
            }
            //将变量加入全局变量或局部变量作用域
            if (local_token2Type.size() == 0){
                g_token2Type.insert({name, rightVal_type});
            }
            else{
                (*local_token2Type[local_token2Type.size()-1])[name] = rightVal_type;
            }
        }else if (vdef->kind == A_varDefType::A_varDefArrayKind){
            name = *vdef->u.defArray->id;
            /* fill code here, allow omited type */
            type = vdef->u.defArray->type;
            //如果是Struct，检查一下有没有定义这种类型
            if(type && type->type == A_dataType::A_structTypeKind){
                if(struct2Members.find(*type->u.structType) == struct2Members.end()){
                    error_print(out,vdef->u.defScalar->type->pos,"The type isnot defined");
                    ;
                }
            }
            //检查是否重复定义
            if (check_local(name) || check_global(name)){
                error_print(out, vdef->u.defArray->pos, "Duplicated definition!");
                ;
            }
            //在使用列表对数组进行初始化时，列表的长度应当与数组的声明一致
            if (vdef->u.defArray->vals.size() != vdef->u.defArray->len){
                error_print(out, vdef->u.defArray->pos, "The length is not same as declaration!");
                ;
            }
            if (vdef->u.defArray->len == 0){
                error_print(out, vdef->u.defArray->pos,"The size of array is 0!");
                ;
            }
            tc_type rightVal_type;
            rightVal_type = check_ArithExpr(out,(vdef->u.defArray->vals)[0]->u.arithExpr);
            if (!rightVal_type->type){
                error_print(out,vdef->u.defScalar->val->pos,"The right value is unassigned!");
                ;
            }
            for (int i = 1; i < vdef->u.defArray->vals.size(); i++){
                if(!comp_tc_type(rightVal_type, check_ArithExpr(out,vdef->u.defArray->vals[i]->u.arithExpr))){
                    error_print(out,vdef->u.defArray->pos, "The rightVal type is wrong!");
                    ;
                }
            }
            if((rightVal_type->isVarArrFunc == 2) && (type && !comp_aA_type(type, rightVal_type->type))){
                error_print(out, vdef->u.defScalar->val->pos, "The type of leftVal and rightVal is different!");
                ;
            }
            if (local_token2Type.size() == 0){
                g_token2Type.insert({name, tc_Type(rightVal_type->type,1)});
            }
            else{
                (*local_token2Type[local_token2Type.size()-1])[name] = tc_Type(rightVal_type->type,1);
            }
        }
    }
    return;
}


void check_StructDef(std::ostream& out, aA_structDef sd)
{
    if (!sd)
        return;
    string name = *sd->id;
    if (struct2Members.find(name) != struct2Members.end())
        error_print(out, sd->pos, "This id is already defined!");
        ;
    struct2Members[name] = &(sd->varDecls);
    return;
}


void check_FnDecl(std::ostream& out, aA_fnDecl fd)
{
    if (!fd)
        return;
    string name = *fd->id;

    // if already declared, should match
    //TeaPL 语法中函数只能在全局声明，所以无需考虑子作用域中声明函数的问题。
    //所以只用在全局变量中检查函数是否定义过
    if (func2Param.find(name) != func2Param.end()){
        // is function ret val matches
        /* fill code here */
        //
        tc_type retType = g_token2Type.find(name)->second;
        //检查返回值类型是否相同
        if(!comp_aA_type(retType -> type, fd->type)){
            error_print(out,fd->pos,"The function return type doesn't match the declaration!");
            ;
        }
        // is function params matches decl
        /* fill code here */
        vector<aA_varDecl> params = *(func2Param.find(name)->second);
        //检查参数数量是否一致
        if(params.size() != fd->paramDecl->varDecls.size()){
            error_print(out,fd->pos,"The function parameter size doesn't match the declaration!");
            ;
        }
        //检查每个参数类型声明与函数声明是否匹配
        for(int i = 0;i < params.size();i++){
            aA_varDecl param_Decl = params[i];
            aA_varDecl fdparam_Decl = fd->paramDecl->varDecls[i];
            //检查参数声明是否匹配
            if(param_Decl->kind != fdparam_Decl->kind){
                error_print(out,fd->pos,"The parameter declaration doesn't match the function declaration!");
                ;
            }
            //检查
            if(param_Decl->kind == A_varDeclType::A_varDeclScalarKind){
                if(!comp_aA_type(param_Decl->u.declScalar->type,fdparam_Decl->u.declScalar->type)){
                    error_print(out,fd->pos,"The parameter declaration doesn't match the function declaration!");
                    ;
                }
            }
            else{
                if(!comp_aA_type(param_Decl->u.declArray->type,fdparam_Decl->u.declArray->type)){
                    error_print(out,fd->pos,"The parameter declaration doesn't match the function declaration!");
                    ;
                }
            }
        }
    }else{
        // if not defined
        /* fill code here */
        //依次检查函数的变量声明是否有类型；同时参数类型为struct时，检查该结构类型是否被定义
        for(int i = 0;i < fd->paramDecl->varDecls.size();i++){
            aA_type param_type;
            if(fd->paramDecl->varDecls[i]->kind == A_varDeclType::A_varDeclArrayKind){
                if(!fd->paramDecl->varDecls[i]->u.declArray->type){
                    error_print(out,fd->paramDecl->varDecls[i]->pos,"The parameter has no type!");
                    ;
                }
                param_type = fd->paramDecl->varDecls[i]->u.declArray->type;
            }else{
                if(!fd->paramDecl->varDecls[i]->u.declScalar->type){
                    error_print(out,fd->paramDecl->varDecls[i]->pos,"The parameter has no type!");
                    ;
                }
                param_type = fd->paramDecl->varDecls[i]->u.declScalar->type;
            }
            //如果参数类型为struct，检查struct类型是否被定义过
            if(param_type->type == A_dataType::A_structTypeKind){
                if(struct2Members.find(*param_type->u.structType) == struct2Members.end()){
                    error_print(out,fd->paramDecl->varDecls[i]->pos,"The parameter type is undefined!");
                    ;
                }
            }
        }
        //将函数记录并且在全局变量中记录函数名
        func2Param[name] = &(fd->paramDecl->varDecls);
        //TeaPL 语法中函数只能在全局声明，所以无需考虑子作用域中声明函数的问题。
        g_token2Type[name] = tc_Type(fd->type,2);
    }
    return;
}


void check_FnDeclStmt(std::ostream& out, aA_fnDeclStmt fd)
{
    if (!fd)
        return;
    check_FnDecl(out, fd->fnDecl);
    return;
}


void check_FnDef(std::ostream& out, aA_fnDef fd)
{
    if (!fd)
        return;
    // should match if declared
    check_FnDecl(out, fd->fnDecl);
    // add params to local tokenmap
    //为改函数开辟新的工作域
    typeMap new_workspace;
    string param_name;
    tc_type param_type;
    for (aA_varDecl vd : fd->fnDecl->paramDecl->varDecls)
    {
        /* fill code here */
        if(vd->kind == A_varDeclType::A_varDeclScalarKind){
            param_name = *vd->u.declScalar->id;
        }else{
            param_name = *vd->u.declArray->id;
        }
        //检查参数名是否与全局变量重名
        if(check_global(param_name)){
            error_print(out, vd->pos, "The parameter name is used as a global variable name!");
            ;
        }
        //将参数加入当前工作域
        param_type = tc_Type(vd);
        new_workspace[param_name] = param_type;
    }
    //将当前工作域添加到程序工作域中
    local_token2Type.push_back(&(new_workspace));
    //返回值类型
    tc_type ret_type = tc_Type(fd->fnDecl->type,0);
    //如果返回值类型是struct，检查该struct是否定义过
    if(ret_type->type && ret_type->type->type == A_dataType::A_structTypeKind){
        if(struct2Members.find(*ret_type->type->u.structType) == struct2Members.end()){
            error_print(out,fd->fnDecl->type->pos,"The ret type is undefined!");
            ;
        }
    }
    /* fill code here */
    for (aA_codeBlockStmt stmt : fd->stmts)
    {
        check_CodeblockStmt(out, stmt);
        // return value type should match
        /* fill code here */
        check_return(out,stmt,ret_type);
    }

    //函数定义完成，当前工作域销毁
    local_token2Type.pop_back();
    return;
}


void check_CodeblockStmt(std::ostream& out, aA_codeBlockStmt cs){
    if(!cs)
        return;
    // variables declared in a code block should not duplicate with outer ones.
    switch (cs->kind)
    {
    case A_codeBlockStmtType::A_varDeclStmtKind:
        check_VarDecl(out, cs->u.varDeclStmt);
        break;
    case A_codeBlockStmtType::A_assignStmtKind:
        check_AssignStmt(out, cs->u.assignStmt);
        break;
    case A_codeBlockStmtType::A_ifStmtKind:
        check_IfStmt(out, cs->u.ifStmt);
        break;
    case A_codeBlockStmtType::A_whileStmtKind:
        check_WhileStmt(out, cs->u.whileStmt);
        break;
    case A_codeBlockStmtType::A_callStmtKind:
        check_CallStmt(out, cs->u.callStmt);
        break;
    case A_codeBlockStmtType::A_returnStmtKind:
        check_ReturnStmt(out, cs->u.returnStmt);
        break;
    default:
        break;
    }
    return;
}


void check_AssignStmt(std::ostream& out, aA_assignStmt as){
    if(!as)
        return;
    string name;
    tc_type deduced_type; // deduced type if type is omitted at decl
    tc_type left_type;
    tc_type right_type = check_ArithExpr(out, as->rightVal->u.arithExpr);
    //检查右值是否是赋值过的变量
    if(!right_type->type){
        error_print(out,as->rightVal->pos,"RightVal is not assigned!");
        ;
    }
    switch (as->leftVal->kind)
    {
        case A_leftValType::A_varValKind:{
            name = *as->leftVal->u.id;
            /* fill code here */
            //寻找左值的tc_type，并检查左值是否被定义
            left_type = find_tc_type(out,name,as->leftVal->pos);
            if(left_type->isVarArrFunc == 2){
                error_print(out, as->leftVal->pos,"Function can not be assigned!");
                ;
            }
            //左值声明时没有定义变量类型
            if(!left_type->type){
                //推理变量类型
                set_omitted_type(name,right_type->type,left_type->isVarArrFunc);
                left_type->type = right_type->type;
            }
            //比较左值与右值变量类型
            if(!comp_tc_type(left_type, right_type)){
                error_print(out, as->leftVal->pos,"Type of leftVal and rightVal is not the same!");
                ;
            }
        }
            break;
        case A_leftValType::A_arrValKind:{
            /* fill code here */
            name = *as->leftVal->u.arrExpr->arr->u.id;
            //检查数组表达式是否合规
            check_ArrayExpr(out, as->leftVal->u.arrExpr);
            left_type = find_tc_type(out,name,as->leftVal->pos);

            //左值声明时未定义变量类型
            if(!left_type->type){
                set_omitted_type(name,right_type->type,left_type->isVarArrFunc);
                left_type = tc_Type(right_type->type, 0);
            }else{
                left_type = tc_Type(right_type->type, 0);
            }
            //比较左值与右值变量类型
            if(!comp_tc_type(left_type, right_type)){
                error_print(out, as->leftVal->pos,"Type of leftVal and rightVal is not the same!");
                ;
            }

        }
            break;
        case A_leftValType::A_memberValKind:{
            /* fill code here */
            left_type = check_MemberExpr(out,as->leftVal->u.memberExpr);
            //比较左值与右值变量类型
            if(!comp_tc_type(left_type, right_type)){
                error_print(out, as->leftVal->pos,"Type of leftVal and rightVal is not the same!");
                ;
            }
        }
            break;
    }
    return;
}


void check_ArrayExpr(std::ostream& out, aA_arrayExpr ae){
    if(!ae)
        return;
    string name = *ae->arr->u.id;
    // check array name
    /* fill code here */
    tc_type type = find_tc_type(out, name,ae->pos);
    //检查是否为数组
    if(type->isVarArrFunc != 1){
        error_print(out,ae->pos,"The variable is not an array!");
        ;
    }
    // check index
    /* fill code here */
    if(ae->idx->kind == A_indexExprKind::A_idIndexKind){
        tc_type idx_type = find_tc_type(out,*ae->idx->u.id,ae->idx->pos);
        if(idx_type->type->type != A_dataType::A_nativeTypeKind || idx_type->isVarArrFunc == 2){
            error_print(out,ae->idx->pos,"The index is not number!");
            ;
        }
    }
    return;
}

 
tc_type check_MemberExpr(std::ostream& out, aA_memberExpr me){
    // check if the member exists and return the tyep of the member
    if(!me)
        return nullptr;
    string name = *me->structId->u.id;
    // check struct name
    /* fill code here */
    //检查是否为struct类型
    tc_type type = find_tc_type(out,name,me->pos);
    if(type->isVarArrFunc == 2 || !type->type || type->type->type != A_dataType::A_structTypeKind){
        error_print(out,me->structId->pos,"The variable is not a struct type!");
        ;
    } 
    // check member name
    /* fill code here */
    //找到struct对应的member
    vector<aA_varDecl> members = *struct2Members.find(*type->type->u.structType)->second;
    for(int i = 0;i < members.size();i++){
        if(members[i]->kind == A_varDeclType::A_varDeclScalarKind){
            //为struct的标量成员
            if(*members[i]->u.declScalar->id == *me->memberId){
                return tc_Type(members[i]->u.declScalar->type,0);
            }
        }else if(members[i]->kind == A_varDeclType::A_varDeclArrayKind){
            //为struct的数组成员
            if(*members[i]->u.declArray->id == *me->memberId){
                return tc_Type(members[i]->u.declArray->type,1);
            }
        }
    }
    //未在成员列表中找到
    error_print(out,me->pos,"The variable is not a member of the struct!");
    return nullptr;
}


void check_IfStmt(std::ostream& out, aA_ifStmt is){
    if(!is)
        return;
    check_BoolUnit(out, is->boolUnit);
    /* fill code here, take care of variable scope */
    //为if块开辟新的工作域
    typeMap new_workspace_if;
    local_token2Type.push_back(&(new_workspace_if));
    for(aA_codeBlockStmt s : is->ifStmts){
        check_CodeblockStmt(out, s);
    }
    //退出if块，销毁if工作域
    local_token2Type.pop_back();
    /* fill code here */
    //为else块开辟新的工作域
    typeMap new_workspace_else;
    local_token2Type.push_back(&(new_workspace_else));    
    for(aA_codeBlockStmt s : is->elseStmts){
        check_CodeblockStmt(out, s);
    }
    /* fill code here */
    //退出else块，销毁else工作域
    local_token2Type.pop_back();
    return;
}


void check_BoolExpr(std::ostream& out, aA_boolExpr be){
    if(!be)
        return;
    switch (be->kind)
    {
    case A_boolExprType::A_boolBiOpExprKind:
        check_BoolExpr(out, be->u.boolBiOpExpr->left);
        check_BoolExpr(out, be->u.boolBiOpExpr->right);
        break;
    case A_boolExprType::A_boolUnitKind:
        check_BoolUnit(out, be->u.boolUnit);
        break;
    default:
        break;
    }
    return;
}


void check_BoolUnit(std::ostream& out, aA_boolUnit bu){
    if(!bu)
        return;
    switch (bu->kind)
    {
        case A_boolUnitType::A_comOpExprKind:{
            /* fill code here */
            //检查左右的表达式是否被赋值过
            tc_type left = check_ExprUnit(out,bu->u.comExpr->left);
            tc_type right = check_ExprUnit(out,bu->u.comExpr->right);
            if(left->isVarArrFunc == 2 || left->type->type != A_dataType::A_nativeTypeKind){
                error_print(out,bu->u.comExpr->left->pos,"The left comExpression is not a int scalar!");
                ;
            }else if(right->isVarArrFunc == 2 || right->type->type != A_dataType::A_nativeTypeKind){
                error_print(out,bu->u.comExpr->right->pos,"The right comExpression is not a int scalar!");
                ;
            }
        }
            break;
        case A_boolUnitType::A_boolExprKind:
            check_BoolExpr(out, bu->u.boolExpr);
            break;
        case A_boolUnitType::A_boolUOpExprKind:
            check_BoolUnit(out, bu->u.boolUOpExpr->cond);
            break;
        default:
            break;
    }
    return;
}


tc_type check_ExprUnit(std::ostream& out, aA_exprUnit eu){
    // return the aA_type of expr eu
    if(!eu)
        return nullptr;
    tc_type ret;
    switch (eu->kind)
    {
        case A_exprUnitType::A_idExprKind:{
            /* fill code here */
            ret = find_tc_type(out,*eu->u.id,eu->pos);
        }
            break;
        case A_exprUnitType::A_numExprKind:{
            aA_type numt = new aA_type_;
            numt->pos = eu->pos;
            numt->type = A_dataType::A_nativeTypeKind;
            numt->u.nativeType = A_nativeType::A_intTypeKind;
            ret = tc_Type(numt, 0);
        }
            break;
        case A_exprUnitType::A_fnCallKind:{
            check_FuncCall(out, eu->u.callExpr);
            // check_FuncCall will check if the function is defined
            /* fill code here */
            ret = find_tc_type(out,*eu->u.callExpr->fn,eu->u.callExpr->pos);
            ret -> isVarArrFunc = 0;
        }
            break;
        case A_exprUnitType::A_arrayExprKind:{
            check_ArrayExpr(out, eu->u.arrayExpr);
            /* fill code here */
            ret = find_tc_type(out,*eu->u.arrayExpr->arr->u.id,eu->u.arrayExpr->pos);
        }
            break;
        case A_exprUnitType::A_memberExprKind:{
            ret = check_MemberExpr(out, eu->u.memberExpr);
        }
            break;
        case A_exprUnitType::A_arithExprKind:{
            ret = check_ArithExpr(out, eu->u.arithExpr);
        }
            break;
        case A_exprUnitType::A_arithUExprKind:{
            ret = check_ExprUnit(out, eu->u.arithUExpr->expr);
        }
            break;
    }
    return ret;
}


tc_type check_ArithExpr(std::ostream& out, aA_arithExpr ae){
    if(!ae)
        return nullptr;
    tc_type ret;
    switch (ae->kind)
    {
        case A_arithExprType::A_arithBiOpExprKind:{
            ret = check_ArithExpr(out, ae->u.arithBiOpExpr->left);
            tc_type rightTyep = check_ArithExpr(out, ae->u.arithBiOpExpr->right);
            if(ret->type->type > 0 || ret->type->type != A_dataType::A_nativeTypeKind || ret->type->u.nativeType != A_nativeType::A_intTypeKind ||
            rightTyep->type->type > 0 || rightTyep->type->type != A_dataType::A_nativeTypeKind || rightTyep->type->u.nativeType != A_nativeType::A_intTypeKind)
                error_print(out, ae->pos, "Only int can be arithmetic expression operation values!");
                ;
        }
            break;
        case A_arithExprType::A_exprUnitKind:
            ret = check_ExprUnit(out, ae->u.exprUnit);
            break;
    }
    return ret;
}


void check_FuncCall(std::ostream& out, aA_fnCall fc){
    if(!fc)
        return;
    // check if function defined
    string func_name = *fc->fn;
    /* fill code here */
    //检查函数是否定义
    if(func2Param.find(func_name) == func2Param.end()){
        error_print(out,fc->pos,"The fenction is undefined!");
        ;
    } 
    // check if parameter list matches
    vector<aA_varDecl> fnparams = *func2Param.find(func_name)->second;
    if(fnparams.size() != fc->vals.size()){
        error_print(out,fc->pos,"The size of function parameterd is not same as defined!");
        ;
    }
    for(int i = 0; i < fc->vals.size(); i++){
        /* fill code here */
        //获取参数类型
        tc_type param_type = check_ArithExpr(out,fc->vals[i]->u.arithExpr);
        //当前参数为标量
        if(param_type->isVarArrFunc == 0){
            if(fnparams[i]->kind != A_varDeclType::A_varDeclScalarKind){
                error_print(out,fc->vals[i]->pos,"The parameter type is not a scalar!");
                ;
            }
            if(!comp_aA_type(param_type->type,fnparams[i]->u.declScalar->type)){
                error_print(out,fc->vals[i]->pos,"The The parameter type is not same as defined!");
                ;
            }
        }//当前参数为数组
        else if(param_type->isVarArrFunc == 1){
            /*if(fnparams[i]->kind != A_varDeclType::A_varDeclArrayKind){
                error_print(out,fc->vals[i]->pos,"The parameter type is not an array!");
                ;
            }
            if(!comp_aA_type(param_type->type,fnparams[i]->u.declArray->type)){
                error_print(out,fc->vals[i]->pos,"The The parameter type is not same as defined!");
                ;
            }*/
            ;
        }//当前参数为函数
        else if(param_type->isVarArrFunc == 2){
            error_print(out,fc->vals[i]->pos,"The parameter type can not be function!");
            ;
        }
    }
    return ;
}


void check_WhileStmt(std::ostream& out, aA_whileStmt ws){
    if(!ws)
        return;
    check_BoolUnit(out, ws->boolUnit);
    /* fill code here, take care of variable scope */
    //为while块开辟新的工作域
    typeMap new_workspace;
    local_token2Type.push_back(&(new_workspace));
    for(aA_codeBlockStmt s : ws->whileStmts){
        check_CodeblockStmt(out, s);
    }
    /* fill code here */
    //退出while块，销毁工作域
    local_token2Type.pop_back();
    return;
}


void check_CallStmt(std::ostream& out, aA_callStmt cs){
    if(!cs)
        return;
    check_FuncCall(out, cs->fnCall);
    return;
}


void check_ReturnStmt(std::ostream& out, aA_returnStmt rs){
    if(!rs)
        return;
    return;
}

