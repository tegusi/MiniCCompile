/* A Bison parser, made by GNU Bison 2.3.  */

/* Skeleton interface for Bison's Yacc-like parsers in C

   Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor,
   Boston, MA 02110-1301, USA.  */

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

/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     UNEQ = 258,
     EQ = 259,
     MINUS = 260,
     PLUS = 261,
     MOD = 262,
     OVER = 263,
     TIMES = 264,
     LT = 265,
     GT = 266,
     OR = 267,
     AND = 268,
     NOT = 269,
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
#define UNEQ 258
#define EQ 259
#define MINUS 260
#define PLUS 261
#define MOD 262
#define OVER 263
#define TIMES 264
#define LT 265
#define GT 266
#define OR 267
#define AND 268
#define NOT 269
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




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;

