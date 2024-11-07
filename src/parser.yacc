%{
#include <stdio.h>
#include "TeaplAst.h"

extern A_pos pos;
extern A_program root;

extern int yylex(void);
extern "C"{
extern void yyerror(const char *s); 
extern int  yywrap();
}

%}

// TODO:
// your parser

//declination、definition、expression、function call
//left right value、statement、struct
%union {  
  A_pos pos; 
  A_program program;
  A_programElementList programElementList;
  A_programElement programElement;
  //表达式
  A_arithExpr arithExpr;
  A_exprUnit exprUnit; 
  A_arithBiOpExpr arithBiOpExpr; 
  A_arithUExpr arithUExpr; 

  A_boolExpr boolExpr; 
  A_boolUnit boolUnit; 
  A_boolBiOpExpr boolBiOpExpr; //&& ||
  A_boolUOpExpr boolUOpExpr; //!
  A_comExpr comExpr; 
  A_comOp comOp;
  A_boolBiOp boolBiOp;

  A_assignStmt assignStmt; 
  A_leftVal leftVal;
  A_rightVal rightVal;

  A_fnCall fnCall; //函数调用

  A_varDeclStmt varDeclStmt; 
  A_varDecl varDecl; 
  A_varDef varDef; 
  A_varDeclScalar varDeclScalar; 
  A_varDeclArray varDeclArray;
  A_varDefScalar varDefScalar;
  A_varDefArray varDefArray;
  A_type type;

  A_structDef structDef; 

  A_fnDeclStmt fnDeclStmt;
  A_fnDecl fnDecl;
  A_paramDecl paramDecl;

  A_fnDef fnDef; 
  A_codeBlockStmt codeBlockStmt;
  A_codeBlockStmtList codeBlockStmtList;
  A_returnStmt returnStmt;
  A_callStmt callStmt;

  A_ifStmt ifStmt;
  A_whileStmt whileStmt;

  A_tokenId tokenId;
  A_tokenNum tokenNum;
  A_arrayExpr arrayExpr;
  A_memberExpr memberExpr;
  A_rightValList rightValList;
  A_varDeclList varDeclList;
}

//保留字 10
%token <pos> IF
%token <pos> ELSE
%token <pos> WHILE
%token <pos> BREAK
%token <pos> CONTINUE
%token <pos> RET
%token <pos> LET
%token <pos> INT
%token <pos> STRUCT
%token <pos> FN

//OP
%token <pos> ADD // +
%token <pos> SUB // -
%token <pos> MUL // *
%token <pos> DIV // /

%token <pos> EQ // ==
%token <pos> NEQ // !=
%token <pos> LT // <
%token <pos> LE // <=
%token <pos> GT // >
%token <pos> GE // >=

%token <pos> AND // &&
%token <pos> OR // ||
%token <pos> NOT // !

//赋值，声明
%token <pos> ASSIGN //=
%token <pos> COLON //:

//连接分隔符
%token <pos> COMMA // ,
%token <pos> DOT // .
%token <pos> LP // (
%token <pos> RP // )
%token <pos> LB // [
%token <pos> RB // ]
%token <pos> LC // {
%token <pos> RC // }
%token <pos> RA // ->
%token <pos> SEMICOLON // ;

%token <tokenNum> NUM;
%token <tokenId> ID;

// non-terminals
%type <program> Program
%type <programElementList> ProgramElementList
%type <programElement> ProgramElement

%type <arithExpr> ArithExpr
%type <exprUnit> ExprUnit 

%type <boolExpr> BoolExpr 
%type <boolUnit> BoolUnit 
%type <boolUOpExpr> BoolUOpExpr //!
%type <comOp> ComOp
%type <boolBiOp> BoolBiOp

%type <assignStmt> AssignStmt 
%type <leftVal> LeftVal
%type <rightVal> RightVal

%type <fnCall> FnCall 

%type <varDeclStmt> VarDeclStmt 
%type <varDecl> VarDecl 
%type <varDef> VarDef 
%type <type> Type

%type <structDef> StructDef 

%type <fnDeclStmt> FnDeclStmt
%type <fnDecl> FnDecl
%type <paramDecl> ParamDecl

%type <fnDef> FnDef 
%type <codeBlockStmt> CodeBlockStmt
%type <codeBlockStmtList> CodeBlockStmtList
%type <returnStmt> ReturnStmt
%type <callStmt> CallStmt

%type <ifStmt> IfStmt
%type <whileStmt> WhileStmt

%type <arrayExpr> ArrayExpr
%type <memberExpr> MemberExpr
%type <rightValList> RightValList
%type <varDeclList> VarDeclList

%start Program

%right ASSIGN
%left AND OR
%left EQ NEQ
%left LT LE GT GE
%left ADD SUB
%left MUL DIV
%right NOT
%nonassoc LOWER_THAN_LP
%nonassoc HIGHEST
%left LP RP LB RB DOT RA

%%                   /* beginning of rules section */

Program: ProgramElementList 
{  
  root = A_Program($1); //AST中的Program节点
  $$ = A_Program($1);
}
;

ProgramElementList: ProgramElement ProgramElementList
{
  $$ = A_ProgramElementList($1, $2);//构造链表
}
|
{
  $$ = nullptr;
}
;

ProgramElement: VarDeclStmt
{
  $$ = A_ProgramVarDeclStmt($1->pos, $1); //variant definition
}
| StructDef
{
  $$ = A_ProgramStructDef($1->pos, $1);
}
| FnDeclStmt
{
  $$ = A_ProgramFnDeclStmt($1->pos, $1);
}
| FnDef
{
  $$ = A_ProgramFnDef($1->pos, $1);
}
| SEMICOLON
{
  $$ = A_ProgramNullStmt($1);
}
;

Type: INT
{
  $$ = A_NativeType($1, A_intTypeKind);
}
| ID
{
  $$ = A_StructType($1->pos, $1->id);
}
;

RightVal: ArithExpr
{
  $$ = A_ArithExprRVal($1->pos, $1);
}
| BoolExpr
{
  $$ = A_BoolExprRVal($1->pos, $1);
}
;

RightValList: RightVal
{
  $$ = A_RightValList($1, nullptr);
}
| RightVal COMMA RightValList
{
  $$ = A_RightValList($1, $3);
}
;

ArithExpr: ArithExpr ADD ArithExpr // 一个算术表达式由两个算术表达式通过加法操作符（ADD）连接而成
{
  // 生成一个表示加法的表达式节点
  $$ = A_ArithBiOp_Expr($1->pos, A_ArithBiOpExpr($1->pos, A_add, $1, $3));
}
| ArithExpr SUB ArithExpr
{
  $$ = A_ArithBiOp_Expr($1->pos, A_ArithBiOpExpr($1->pos, A_sub, $1, $3));
}
| ArithExpr MUL ArithExpr
{
  $$ = A_ArithBiOp_Expr($1->pos, A_ArithBiOpExpr($1->pos, A_mul, $1, $3));
}
| ArithExpr DIV ArithExpr
{
  $$ = A_ArithBiOp_Expr($1->pos, A_ArithBiOpExpr($1->pos, A_div, $1, $3));
}
| ExprUnit // 基本表达式单元
{
  $$ = A_ExprUnit($1->pos, $1);
}
;

//exprUnit :=  num | id | < ( > arithExpr < ) > | fnCall | leftVal < [ > id | num < ] > | leftVal < . > id
ExprUnit: NUM
{
  $$ = A_NumExprUnit($1->pos, $1->num);
}
| ID
{
  $$ = A_IdExprUnit($1->pos, $1->id);
}
| LP ArithExpr RP
{
  $$ = A_ArithExprUnit($1, $2);
}
| FnCall
{
  $$ = A_CallExprUnit($1->pos, $1);
}
| ArrayExpr 
{
  $$ = A_ArrayExprUnit($1->pos, $1);
}
| MemberExpr
{
  $$ = A_MemberExprUnit($1->pos, $1);
}
| SUB NUM
{
  $$ = A_NumExprUnit($2->pos, -$2->num);
}
;

//fnCall := id < ( > rightVal (< , > rightVal)* | ϵ < ) >
FnCall: ID LP RightValList RP
{
  $$ = A_FnCall($1->pos, $1->id, $3);
}
| ID LP RP
{
  $$ = A_FnCall($1->pos, $1->id, nullptr);
}
;



//ArrayExpr := LeftVal < [ > id | num < ] >
ArrayExpr: ID LB NUM RB
{
    $$ = A_ArrayExpr($1->pos, A_IdExprLVal($1->pos, $1->id), A_NumIndexExpr($3->pos, $3->num));
}
| ID LB ID RB
{
    $$ = A_ArrayExpr($1->pos, A_IdExprLVal($1->pos, $1->id), A_IdIndexExpr($3->pos, $3->id));
}
| LeftVal LB NUM RB
{
    $$ = A_ArrayExpr($1->pos, $1, A_NumIndexExpr($3->pos, $3->num));
}
| LeftVal LB ID RB
{
    $$ = A_ArrayExpr($1->pos, $1, A_IdIndexExpr($3->pos, $3->id));
}
;


//MemberExpr := structId.memberId
MemberExpr: LeftVal DOT ID
{
  $$ = A_MemberExpr($1->pos, $1, $3->id);
}
| ID DOT ID
{
  $$ = A_MemberExpr($1->pos, A_IdExprLVal($1->pos, $1->id), $3->id);
}
;


BoolUOpExpr: NOT BoolUnit
{
  $$ = A_BoolUOpExpr($1,A_not,$2);
}
;


//boolExpr := boolExpr boolBiOp boolExpr | boolUnit
BoolExpr: BoolExpr BoolBiOp BoolExpr %prec HIGHEST
{
    $$ = A_BoolBiOp_Expr($1->pos, A_BoolBiOpExpr($1->pos, $2, $1, $3));
}
| BoolUnit
{
  $$ = A_BoolExpr($1->pos, $1);
}
;



BoolBiOp: AND
{
  $$ = A_and;
}
| OR
{
  $$ = A_or;
}
;


//boolUnit := < ( > exprUnit comOp exprUnit < ) > | < ( > boolExpr < ) > | boolUOp 
BoolUnit: LP ExprUnit ComOp ExprUnit RP
{
  $$ = A_ComExprUnit($2->pos, A_ComExpr($2->pos, $3, $2, $4));
}
| LP BoolExpr RP
{
  $$ = A_BoolExprUnit($1, $2);
}
| BoolUOpExpr
{
  $$ = A_BoolUOpExprUnit($1->pos, $1);
}
;

ComOp: GT
{
  $$ = A_gt;
}
| LT
{
  $$ = A_lt;
}
| GE
{
  $$ = A_ge;
}
| LE
{
  $$ = A_le;
}
| EQ
{
  $$ = A_eq;
}
| NEQ
{
  $$ = A_ne;
}
;

//assignStmt := leftVal < = > rightVal < ; >  
AssignStmt: LeftVal ASSIGN RightVal SEMICOLON
{
  $$ = A_AssignStmt($1->pos, $1, $3);
}
;

// leftVal := id | leftVal < [ > id | num < ] > | leftVal < . > id
LeftVal: ID %prec LOWER_THAN_LP
{
  $$ = A_IdExprLVal($1->pos, $1->id);
}
| ArrayExpr
{
  $$ = A_ArrExprLVal($1->pos, $1);
}
| MemberExpr
{
  $$ = A_MemberExprLVal($1->pos, $1);
}
;


//varDeclStmt := < let > (varDecl | varDef) < ; >   
VarDeclStmt: LET VarDecl SEMICOLON
{
  $$ = A_VarDeclStmt($1, $2);
}
| LET VarDef SEMICOLON
{
  $$ = A_VarDefStmt($1, $2);
}
;



VarDecl: ID COLON Type
{
    $$ = A_VarDecl_Scalar($1->pos, A_VarDeclScalar($1->pos, $1->id, $3));
}
| ArrayExpr COLON Type
{
    $$ = A_VarDecl_Array($1->pos, A_VarDeclArray($1->pos, $1->arr->u.id, $1->idx->u.num, $3));
}
| ID  // 允许在声明时不指定类型
{
    $$ = A_VarDecl_Scalar($1->pos, A_VarDeclScalar($1->pos, $1->id, nullptr));
}
| ArrayExpr
{
    $$ = A_VarDecl_Array($1->pos, A_VarDeclArray($1->pos, $1->arr->u.id, $1->idx->u.num, nullptr));
};


VarDef: ID COLON Type ASSIGN RightVal
{
    $$ = A_VarDef_Scalar($1->pos, A_VarDefScalar($1->pos, $1->id, $3, $5));
}
| ID ASSIGN RightVal
{
    $$ = A_VarDef_Scalar($1->pos, A_VarDefScalar($1->pos, $1->id, nullptr, $3));
}
| ArrayExpr COLON Type ASSIGN LC RightValList RC
{
    $$ = A_VarDef_Array($1->pos, A_VarDefArray($1->pos, $1->arr->u.id, $1->idx->u.num, $3, $6));
}
| ArrayExpr ASSIGN LC RightValList RC
{
    $$ = A_VarDef_Array($1->pos, A_VarDefArray($1->pos, $1->arr->u.id, $1->idx->u.num, nullptr, $4));
}
| ArrayExpr COLON Type ASSIGN LC RC
{
    $$ = A_VarDef_Array($1->pos, A_VarDefArray($1->pos, $1->arr->u.id, $1->idx->u.num, $3, nullptr));
}
| ArrayExpr ASSIGN LC RC
{
    $$ = A_VarDef_Array($1->pos, A_VarDefArray($1->pos, $1->arr->u.id, $1->idx->u.num, nullptr, nullptr));
}
;

VarDeclList: VarDecl
{
  $$ = A_VarDeclList($1, nullptr);
}
| VarDecl COMMA VarDeclList
{
  $$ = A_VarDeclList($1, $3);
}
|
{
  $$ = nullptr;
}
;

//structDef := < struct > id < { > (fieldDecl) (< , > fieldDecl)* < } >
StructDef: STRUCT ID LC VarDeclList RC
{
  $$ = A_StructDef($1, $2->id, $4);
}
;

//fnDeclStmt := fnDecl < ; >
FnDeclStmt: FnDecl SEMICOLON
{
  $$ = A_FnDeclStmt($1->pos, $1);
}
;

//fnDecl := < fn > id < ( > paramDecl < ) > //without return value
//        | < fn > id < ( > paramDecl < ) > < -> > type //with return value
FnDecl: FN ID LP ParamDecl RP
{
  $$ = A_FnDecl($1, $2->id, $4, nullptr);
}
| FN ID LP ParamDecl RP RA Type
{
  $$ = A_FnDecl($1, $2->id, $4, $7);
}
;

//paramDecl := varDecl (< , > varDecl)* | ϵ
ParamDecl: VarDeclList
{
  $$ = A_ParamDecl($1);
}
;

//fnDef := fnDecl codeBlock  
FnDef: FnDecl LC CodeBlockStmtList RC
{
  $$ = A_FnDef($1->pos, $1, $3);
}
;

CodeBlockStmtList: CodeBlockStmt
{
  $$ = A_CodeBlockStmtList($1, nullptr);
}
| CodeBlockStmt CodeBlockStmtList
{
  $$ = A_CodeBlockStmtList($1, $2);
}
;

//codeBlock :=  < { > (varDeclStmt | assignStmt | callStmt | ifStmt | whileStmt | returnStmt | continueStmt | breakStmt | < ; > )* < } > 
CodeBlockStmt: VarDeclStmt
{
  $$ = A_BlockVarDeclStmt($1->pos, $1);
}
| AssignStmt
{
  $$ = A_BlockAssignStmt($1->pos, $1);
}
| CallStmt
{
  $$ = A_BlockCallStmt($1->pos, $1);
}
| IfStmt
{
  $$ = A_BlockIfStmt($1->pos, $1);
}
| WhileStmt
{
  $$ = A_BlockWhileStmt($1->pos, $1);  
}
| ReturnStmt
{
  $$ = A_BlockReturnStmt($1->pos, $1);
}
| CONTINUE SEMICOLON
{
  $$ = A_BlockContinueStmt($1);
}
| BREAK SEMICOLON
{
  $$ = A_BlockBreakStmt($1);
}
| SEMICOLON
{
  $$ = A_BlockNullStmt($1);
}
;


//returnStmt ：= < ret > rightVal < ; > | < ret > < ; >
ReturnStmt: RET RightVal SEMICOLON
{
  $$ = A_ReturnStmt($1, $2);
}
| RET SEMICOLON
{
  $$ = A_ReturnStmt($1, nullptr);
}
;


//callStmt := fnCall < ; >
CallStmt: FnCall SEMICOLON
{
  $$ = A_CallStmt($1->pos, $1);
}
;

//ifStmt := < if > boolUnit_ codeBlock ( < else > codeBlock | ϵ )
IfStmt: IF BoolUnit LC CodeBlockStmtList RC
{
  $$ = A_IfStmt($1, $2, $4, NULL);
}
| IF BoolUnit LC CodeBlockStmtList RC ELSE LC CodeBlockStmtList RC
{
  $$ = A_IfStmt($1, $2, $4, $8);
}
;

//whileStmt := < while > boolUnit_ codeBlock
WhileStmt: WHILE BoolUnit LC CodeBlockStmtList RC
{
  $$ = A_WhileStmt($1, $2, $4);
}
;




%%

extern "C"{
void yyerror(const char * s)
{
  fprintf(stderr, "%s\n",s);
}
int yywrap()
{
  return(1);
}
}


