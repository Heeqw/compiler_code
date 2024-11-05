/* A Bison parser, made by GNU Bison 3.5.1.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2020 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

#ifndef YY_YY_Y_TAB_HPP_INCLUDED
# define YY_YY_Y_TAB_HPP_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 1
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    IF = 258,
    ELSE = 259,
    WHILE = 260,
    BREAK = 261,
    CONTINUE = 262,
    RET = 263,
    LET = 264,
    INT = 265,
    STRUCT = 266,
    FN = 267,
    ADD = 268,
    SUB = 269,
    MUL = 270,
    DIV = 271,
    EQ = 272,
    NEQ = 273,
    LT = 274,
    LE = 275,
    GT = 276,
    GE = 277,
    AND = 278,
    OR = 279,
    NOT = 280,
    ASSIGN = 281,
    COLON = 282,
    COMMA = 283,
    DOT = 284,
    LP = 285,
    RP = 286,
    LB = 287,
    RB = 288,
    LC = 289,
    RC = 290,
    RA = 291,
    SEMICOLON = 292,
    NUM = 293,
    ID = 294,
    LOWER_THAN_LP = 295,
    HIGHEST = 296
  };
#endif
/* Tokens.  */
#define IF 258
#define ELSE 259
#define WHILE 260
#define BREAK 261
#define CONTINUE 262
#define RET 263
#define LET 264
#define INT 265
#define STRUCT 266
#define FN 267
#define ADD 268
#define SUB 269
#define MUL 270
#define DIV 271
#define EQ 272
#define NEQ 273
#define LT 274
#define LE 275
#define GT 276
#define GE 277
#define AND 278
#define OR 279
#define NOT 280
#define ASSIGN 281
#define COLON 282
#define COMMA 283
#define DOT 284
#define LP 285
#define RP 286
#define LB 287
#define RB 288
#define LC 289
#define RC 290
#define RA 291
#define SEMICOLON 292
#define NUM 293
#define ID 294
#define LOWER_THAN_LP 295
#define HIGHEST 296

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 21 "parser.yacc"
  
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

#line 196 "y.tab.hpp"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_HPP_INCLUDED  */
