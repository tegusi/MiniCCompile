/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

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

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    EQ = 258,
    UNEQ = 259,
    PLUS = 260,
    MINUS = 261,
    TIMES = 262,
    OVER = 263,
    MOD = 264,
    NOT = 265,
    AND = 266,
    OR = 267,
    GT = 268,
    LT = 269,
    RETURN = 270,
    MAIN = 271,
    INT = 272,
    IF = 273,
    THEN = 274,
    ELSE = 275,
    WHILE = 276,
    ASSIGN = 277,
    INTEGER = 278,
    IDENTIFIER = 279
  };
#endif
/* Tokens.  */
#define EQ 258
#define UNEQ 259
#define PLUS 260
#define MINUS 261
#define TIMES 262
#define OVER 263
#define MOD 264
#define NOT 265
#define AND 266
#define OR 267
#define GT 268
#define LT 269
#define RETURN 270
#define MAIN 271
#define INT 272
#define IF 273
#define THEN 274
#define ELSE 275
#define WHILE 276
#define ASSIGN 277
#define INTEGER 278
#define IDENTIFIER 279

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
