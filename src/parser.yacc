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

//  :
// your parser

%union {
  A_pos pos;
  A_tokenId tokenId;
  A_tokenNum tokenNum;
  A_type type;
  A_varDecl varDecl;
  A_varDef varDef;
  A_rightVal rightVal;
  A_arithExpr arithExpr;
  A_boolExpr boolExpr;
  A_arithBiOpExpr arithBiOpExpr;
  A_arithUExpr arithUExpr;
  A_exprUnit exprUnit;
  A_fnCall fnCall;
  A_indexExpr indexExpr;
  A_arrayExpr arrayExpr;
  A_memberExpr memberExpr;
  A_boolUnit boolUnit;
  A_boolBiOpExpr boolBiOpexpr;
  A_boolUOpExpr boolUOpExpr;
  A_comExpr comExpr;
  A_leftVal leftVal;
  A_assignStmt assignStmt;
  A_rightValList rightValList;
  A_varDefScalar varDefScalar;
  A_varDefArray varDefArray;
  A_varDeclScalar varDeclScalar;
  A_varDeclArray varDeclArray;
  A_varDeclStmt varDeclStmt;
  A_varDeclList varDeclList;
  A_structDef structDef;
  A_paramDecl paramDecl;
  A_fnDecl fnDecl;
  A_fnDef fnDef;
  A_codeBlockStmt codeBlockStmt;
  A_ifStmt ifStmt;
  A_whileStmt whileStmt;
  A_fnDeclStmt fnDeclStmt;
  A_callStmt callStmt;
  A_returnStmt returnStmt;
  A_programElement programElement;
  A_codeBlockStmtList codeBlockStmtList;
  A_programElementList programElementList;
  A_program program;
}

%token <tokenNum> UNUM
%token <tokenId> ID

//define keyword
%token <pos> LET
%token <pos> INT
%token <pos> STRUCT
%token <pos> FN
%token <pos> RETURN
%token <pos> IF
%token <pos> ELSE
%token <pos> WHILE
%token <pos> BREAK
%token <pos> CONTINUE


%token <pos> ADD
%token <pos> SUB
%token <pos> MUL
%token <pos> DIV
%token <pos> AND
%token <pos> OR
%token <pos> NOT
%token <pos> GT
%token <pos> LT
%token <pos> GE
%token <pos> LE
%token <pos> EQ
%token <pos> NE
%token <pos> ASS

%token <pos> LPAREN
%token <pos> RPAREN
%token <pos> LBRACKET
%token <pos> RBRACKET
%token <pos> DOT
%token <pos> COMMA
%token <pos> LBRACE
%token <pos> RBRACE
%token <pos> COLON
%token <pos> POINT
%token <pos> SEMICOLON

//define type
%type <tokenNum> NUM
%type <program> Program
%type <arithExpr> ArithExpr
%type <boolExpr> BoolExpr
%type <boolUnit> BoolUnit
%type <programElementList> ProgramElementList
%type <programElement> ProgramElement
%type <exprUnit> ExprUnit
%type <varDeclList> VarDeclList
%type <structDef> StructDef
%type <varDeclStmt> VarDeclStmt
%type <varDecl> VarDecl
%type <varDef> VarDef
%type <fnDecl> FnDecl
%type <fnDeclStmt> FnDeclStmt
%type <codeBlockStmt> CodeBlockStmt
%type <codeBlockStmtList> CodeBlockStmtList
%type <ifStmt> IfStmt
%type <whileStmt> WhileStmt
%type <returnStmt> ReturnStmt
%type <callStmt> CallStmt
%type <paramDecl> ParamDecl
%type <fnDef> FnDef
%type <fnCall> FnCall
%type <leftVal> LeftVal
%type <rightVal> RightVal
%type <rightValList> RightValList
%type <assignStmt> AssignStmt
%type <type> Type

//define priority
%left SEMICOLON
%left COMMA
%left WHILE
%left IF ELSE
%left LBRACE RBRACE
%left LET
%right ASS
%left OR
%left AND
%left EQ NE
%left GT LT GE LE
%left ADD SUB
%left MUL DIV
%right NOT
%left DOT
%left POINT
%left LPAREN RPAREN
%left LBRACKET RBRACKET

%start Program

%%                   /* beginning of rules section */
//define num: num := unum | < - > unum
NUM:UNUM
{
  $$ = A_TokenNum($1->pos,$1->num);
}
| SUB UNUM
{
  $$ = A_TokenNum($1,-($2->num));
}
;

Program: ProgramElementList 
{  
  root = A_Program($1);
  $$ = A_Program($1);
}
;

ProgramElementList: ProgramElement ProgramElementList
{
  $$ = A_ProgramElementList($1, $2);
}
|
{
  $$ = nullptr;
}
;

ProgramElement: VarDeclStmt
{
  $$ = A_ProgramVarDeclStmt($1->pos, $1);
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

//define structure 
StructDef: STRUCT ID LBRACE VarDeclList RBRACE
{
  $$ = A_StructDef($1, $2->id, $4);
}
;


Type: INT
{
  $$ = A_NativeType($1,A_intTypeKind);
}
| ID
{
  $$ = A_StructType($1->pos, $1->id);
}
;

//define arith expression:arithExpr arithBiOp arithExpr | exprUnit
ArithExpr: ArithExpr ADD ArithExpr
{
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
| ExprUnit
{
  $$ = A_ExprUnit($1->pos, $1);
}
;

//define expression: num | id | < ( > arithExpr < ) > | fnCall | leftVal 
ExprUnit: NUM
{
  $$ = A_NumExprUnit($1->pos, $1->num);
}
| ID
{
  $$ = A_IdExprUnit($1->pos, $1->id);
}
| LPAREN ArithExpr RPAREN
{
  $$ = A_ArithExprUnit($1, $2);
}
| FnCall
{
  $$ = A_CallExprUnit($1->pos, $1);
}
| LeftVal LBRACKET ID RBRACKET
{
  $$ = A_ArrayExprUnit($1->pos,A_ArrayExpr($1->pos, $1, A_IdIndexExpr($3->pos, $3->id)));
}
| LeftVal LBRACKET NUM RBRACKET
{
  $$ = A_ArrayExprUnit($1->pos,A_ArrayExpr($1->pos, $1, A_NumIndexExpr($3->pos, $3->num)));
}
| LeftVal DOT ID
{
  $$ = A_MemberExprUnit($1->pos, A_MemberExpr($1->pos, $1, $3->id));
}
;

//define boolen expression:boolExpr boolBiOp boolExpr | boolUnit
BoolExpr: BoolExpr AND BoolExpr
{
  $$ = A_BoolBiOp_Expr($1->pos, A_BoolBiOpExpr($1->pos, A_and, $1, $3));
}
| BoolExpr OR BoolExpr
{
  $$ = A_BoolBiOp_Expr($1->pos, A_BoolBiOpExpr($1->pos, A_or, $1, $3));
}
| BoolUnit
{
  $$ = A_BoolExpr($1->pos, $1);
}
;

//define boolen unit: < ( > exprUnit comOp exprUnit < ) > | < ( > boolExpr < ) > | boolUOp boolUnit
BoolUnit:LPAREN ExprUnit GT ExprUnit RPAREN
{
  $$ = A_ComExprUnit($1, A_ComExpr($1, A_gt, $2, $4));
}
| LPAREN ExprUnit LT ExprUnit RPAREN
{
  $$ = A_ComExprUnit($1, A_ComExpr($1, A_lt, $2, $4));
}
| LPAREN ExprUnit GE ExprUnit RPAREN
{
  $$ = A_ComExprUnit($1, A_ComExpr($1, A_ge, $2, $4));
}
| LPAREN ExprUnit LE ExprUnit RPAREN
{
  $$ = A_ComExprUnit($1, A_ComExpr($1, A_le, $2, $4));
}
| LPAREN ExprUnit EQ ExprUnit RPAREN
{
  $$ = A_ComExprUnit($1, A_ComExpr($1, A_eq, $2, $4));
}
| LPAREN ExprUnit NE ExprUnit RPAREN
{
  $$ = A_ComExprUnit($1, A_ComExpr($1, A_ne, $2, $4));
}
| LPAREN BoolExpr RPAREN
{
  $$ = A_BoolExprUnit($1, $2);
}
| NOT BoolUnit
{
  $$ = A_BoolUOpExprUnit($1, A_BoolUOpExpr($1, A_not, $2));
}
;


//define assign statement: leftVal < = > rightVal < ; >  
AssignStmt: LeftVal ASS RightVal SEMICOLON
{
  $$ = A_AssignStmt($1->pos, $1, $3);
}
;

//define left value: id | leftVal < [ > id | num < ] > | leftVal < . > id
LeftVal: ID
{
  $$ = A_IdExprLVal($1->pos, $1->id);
}
| LeftVal LBRACKET ID RBRACKET
{
  $$ = A_ArrExprLVal($1->pos, A_ArrayExpr($1->pos, $1, A_IdIndexExpr($3->pos, $3->id)));
}
| LeftVal LBRACKET NUM RBRACKET
{
  $$ = A_ArrExprLVal($1->pos, A_ArrayExpr($1->pos, $1,A_NumIndexExpr($3->pos, $3->num)));
}
| LeftVal DOT ID
{
  $$ = A_MemberExprLVal($1->pos, A_MemberExpr($1->pos, $1, $3->id));
}
;

//define right value list
RightValList: RightVal COMMA RightValList
{
  $$ = A_RightValList($1, $3);
}
| RightVal
{
  $$ = A_RightValList($1, nullptr);
}
|
{
  $$ = nullptr;
}
;

//define right value:arithExpr
RightVal: ArithExpr
{
  $$ = A_ArithExprRVal($1->pos, $1);
}
| BoolExpr
{
  $$ = A_BoolExprRVal($1->pos, $1);
}
;

//define function call:id < ( > rightVal (< , > rightVal)* | ϵ < ) >
FnCall: ID LPAREN RightValList RPAREN
{
  $$ = A_FnCall($1->pos, $1->id, $3);
}
;

//define variable declare statement:< let > (varDecl | varDef) < ; > 
VarDeclStmt: LET VarDecl SEMICOLON
{
  $$ = A_VarDeclStmt($2->pos, $2);
}
| LET VarDef SEMICOLON
{
  $$ = A_VarDefStmt($2->pos, $2);
}
;

//define variable declare list
VarDeclList: VarDecl COMMA VarDeclList
{
  $$ = A_VarDeclList($1, $3);
}
| VarDecl
{
  $$ = A_VarDeclList($1, nullptr);
}
|
{
  $$ = nullptr;
}
;

//define variable:id < : > type |  id < [ > num < ] >< : > type | id |  id < [ > num < ] >
VarDecl: ID COLON Type
{
  $$ = A_VarDecl_Scalar($1->pos, A_VarDeclScalar($1->pos, $1->id, $3));
}
| ID LBRACKET NUM RBRACKET COLON Type
{
  $$ = A_VarDecl_Array($1->pos, A_VarDeclArray($1->pos, $1->id, $3->num, $6));
}
| ID
{
  $$ = A_VarDecl_Scalar($1->pos, A_VarDeclScalar($1->pos, $1->id, A_NativeType(nullptr, A_intTypeKind)));
}
| ID LBRACKET NUM RBRACKET
{
  $$ = A_VarDecl_Array($1->pos, A_VarDeclArray($1->pos, $1->id, $3->num, A_NativeType(nullptr, A_intTypeKind)));
}
;

//define variable definition: id < : > type < = > rightVal | id < = > rightVal
VarDef: ID COLON Type ASS RightVal
{
  $$ = A_VarDef_Scalar($1->pos, A_VarDefScalar($1->pos, $1->id, $3, $5));
}
| ID ASS RightVal
{
  $$ = A_VarDef_Scalar($1->pos, A_VarDefScalar($1->pos, $1->id, A_NativeType(nullptr, A_intTypeKind), $3));
}
| ID LBRACKET NUM RBRACKET COLON Type ASS LBRACE RightValList RBRACE
{
  $$ = A_VarDef_Array($1->pos, A_VarDefArray($1->pos, $1->id, $3->num, $6, $9));
}
| ID LBRACKET NUM RBRACKET ASS LBRACE RightValList RBRACE
{
  $$ = A_VarDef_Array($1->pos, A_VarDefArray($1->pos, $1->id, $3->num, A_NativeType(nullptr, A_intTypeKind), $7));
}
;


//define function 
FnDef: FnDecl LBRACE CodeBlockStmtList RBRACE
{
  $$ = A_FnDef($1->pos, $1, $3);
}
;

//define function declare statement
FnDeclStmt: FnDecl SEMICOLON
{
  $$ = A_FnDeclStmt($1->pos, $1);
}  
;

ParamDecl: VarDeclList
{
  $$ = A_ParamDecl($1);
}

//define function declare: < fn > id < ( > paramDecl < ) > | < fn > id < ( > paramDecl < ) > < -> > type 
FnDecl: FN ID LPAREN ParamDecl RPAREN
{
  $$ = A_FnDecl($1, $2->id, $4, nullptr);
}
| FN ID LPAREN ParamDecl RPAREN POINT Type
{
  $$ = A_FnDecl($1, $2->id, $4, $7);
}
;



//define code block statement list
CodeBlockStmtList: CodeBlockStmt CodeBlockStmtList
{
  $$ = A_CodeBlockStmtList($1, $2);
}
|
{
  $$ = nullptr;
}
;

//define code block statement
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
  $$ =A_BlockContinueStmt($1);
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

//define return statement:< RETURN > rightVal < ; > | < RETURN > < ; >
ReturnStmt: RETURN RightVal SEMICOLON
{
  $$ = A_ReturnStmt($1, $2);
}
| RETURN SEMICOLON
{
  $$ = A_ReturnStmt($1, nullptr);
}
;

//define call statement: fnCall < ; >
CallStmt: FnCall SEMICOLON
{
  $$ = A_CallStmt($1->pos, $1);
}
;

//define if statement:< if > boolUnit codeBlock ( < else > codeBlock | ϵ )
IfStmt: IF BoolUnit LBRACE CodeBlockStmtList RBRACE ELSE LBRACE CodeBlockStmtList RBRACE
{
  $$ = A_IfStmt($1, $2, $4, $8);
}
| IF BoolUnit LBRACE CodeBlockStmtList RBRACE
{
  $$ = A_IfStmt($1, $2, $4, nullptr);
}
;

//define while statement
WhileStmt: WHILE BoolUnit LBRACE CodeBlockStmtList RBRACE
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


