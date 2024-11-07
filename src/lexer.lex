%{
#include <stdio.h>
#include <string.h>
#include "TeaplAst.h"
#include "y.tab.hpp"
extern int line, col; /* line is current line number, col is current column number*/
int c;
int calc(const char *s, int len);
char* strdup(char *s, int len);
%}

%start COMMENT_Short COMMENT_Long

%%

<INITIAL>"//" { col += yyleng;BEGIN COMMENT_Short; }
<INITIAL>"/*" { col += yyleng;BEGIN COMMENT_Long; }

<COMMENT_Short>"\n" { ++line; col = 1; BEGIN INITIAL; }
<COMMENT_Short>.    { col += yyleng;}

<COMMENT_Long>"*/" { col += yyleng; BEGIN INITIAL; }
<COMMENT_Long>"\n" { ++line; col = 1; }
<COMMENT_Long>. { col += yyleng; }


<INITIAL>" "|"\r"|"\t" { col += yyleng; }
<INITIAL>"\n" { line++; col = 1; }

<INITIAL>"if" { yylval.pos=A_Pos(line,col);col += yyleng;return IF; } /* 保留字 10 */
<INITIAL>"else" { yylval.pos=A_Pos(line,col);col += yyleng;return ELSE; }
<INITIAL>"while" { yylval.pos=A_Pos(line,col);col += yyleng;return WHILE; }
<INITIAL>"break" { yylval.pos=A_Pos(line,col);col += yyleng;return BREAK; }
<INITIAL>"continue" { yylval.pos=A_Pos(line,col);col += yyleng;return CONTINUE; }
<INITIAL>"ret" { yylval.pos=A_Pos(line,col);col += yyleng;return RET; }
<INITIAL>"let" { yylval.pos=A_Pos(line,col);col += yyleng;return LET; }
<INITIAL>"int" { yylval.pos=A_Pos(line,col);col += yyleng;return INT; }
<INITIAL>"struct" { yylval.pos=A_Pos(line,col);col += yyleng;return STRUCT; }
<INITIAL>"fn" { yylval.pos=A_Pos(line,col);col += yyleng;return FN; }

<INITIAL>"+" { yylval.pos=A_Pos(line,col);col += yyleng;return ADD; } /* OP 13 */
<INITIAL>"-" { yylval.pos=A_Pos(line,col);col += yyleng;return SUB; }
<INITIAL>"*" { yylval.pos=A_Pos(line,col);col += yyleng;return MUL; }
<INITIAL>"/" { yylval.pos=A_Pos(line,col);col += yyleng;return DIV; }

<INITIAL>"==" { yylval.pos=A_Pos(line,col);col += yyleng;return EQ; }
<INITIAL>"!=" { yylval.pos=A_Pos(line,col);col += yyleng;return NEQ; }
<INITIAL>"<" { yylval.pos=A_Pos(line,col);col += yyleng;return LT; }
<INITIAL>"<=" { yylval.pos=A_Pos(line,col);col += yyleng;return LE; }
<INITIAL>">" { yylval.pos=A_Pos(line,col);col += yyleng;return GT; }
<INITIAL>">=" { yylval.pos=A_Pos(line,col);col += yyleng;return GE; }

<INITIAL>"&&" { yylval.pos=A_Pos(line,col);col += yyleng;return AND; }
<INITIAL>"||" { yylval.pos=A_Pos(line,col);col += yyleng;return OR; }
<INITIAL>"!" { yylval.pos=A_Pos(line,col);col += yyleng;return NOT; }
<INITIAL>"=" { yylval.pos=A_Pos(line,col);col += yyleng;return ASSIGN; }
<INITIAL>":" { yylval.pos=A_Pos(line,col);col += yyleng;return COLON;}/* 赋值，声明 */
<INITIAL>";" { yylval.pos=A_Pos(line,col);col += yyleng;return SEMICOLON; }/* 连接分隔符 10 */
<INITIAL>"," { yylval.pos=A_Pos(line,col);col += yyleng;return COMMA; }
<INITIAL>"."  { yylval.pos=A_Pos(line,col);col += yyleng;return DOT; }

<INITIAL>"(" { yylval.pos=A_Pos(line,col);col += yyleng;return LP; }
<INITIAL>")" { yylval.pos=A_Pos(line,col);col += yyleng;return RP; }
<INITIAL>"[" { yylval.pos=A_Pos(line,col);col += yyleng;return LB; }
<INITIAL>"]" { yylval.pos=A_Pos(line,col);col += yyleng;return RB; }
<INITIAL>"{" { yylval.pos=A_Pos(line,col);col += yyleng;return LC; } // left curly
<INITIAL>"}" { yylval.pos=A_Pos(line,col);col += yyleng;return RC; }
<INITIAL>"->" { yylval.pos=A_Pos(line,col);col += yyleng;return RA; } // right arrow

<INITIAL>[1-9][0-9]* {/* 数字和名 */
    yylval.tokenNum = A_TokenNum(A_Pos(line, col), calc(yytext, yyleng));
    col+=yyleng;
    return NUM;
}
<INITIAL>0 {
    yylval.tokenNum = A_TokenNum(A_Pos(line,col), 0);
    ++col;
    return NUM;
}
<INITIAL>[a-zA-Z_]([a-zA-Z0-9_])* {
    yylval.tokenId = A_TokenId(A_Pos(line, col), strdup(yytext, yyleng));
    col+=yyleng;
    return ID;
}
<INITIAL>. { printf("Illegal CHAR: %s\n", yytext); }

%%

// This function takes a string of digits and its length as input, and returns the integer value of the string.
int calc(const char *s, int len) {
    int ret = 0;
    for(int i = 0; i < len; i++)
        ret = ret * 10 + (s[i] - '0');
    return ret;
}
char* strdup(char *s, int len){
    char* p = (char*)malloc(len + 1);
    strcpy(p, s);
    return p;
}