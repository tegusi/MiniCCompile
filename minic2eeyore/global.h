#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <vector>
#include <string>
#include <map>
#include <iostream>
#ifndef _GLOBAL_H_
#define _GLOBAL_H_
using namespace std;
/* Yacc/Bison generates internally its own values
 * for the tokens. Other files can access these values
 * by including the tab.h file generated using the
 * Yacc/Bison option -d ("generate header")
 *
 * The YYPARSER flag prevents inclusion of the tab.h
 * into the Yacc/Bison output itself
 */

#ifndef YYPARSER

/* the name of the following file may change */
#include "y.tab.h"

/* ENDFILE is implicitly defined by Yacc/Bison,
 * and not included in the tab.h file
 */
#define ENDFILE 0

#endif

#ifndef FALSE
#define FALSE 0
#endif

#ifndef TRUE
#define TRUE 1
#endif

/* MAXRESERVED = the number of reserved words */
#define MAXRESERVED 8
#define MAXTOKENLEN 40

typedef int TokenType;

/* tokenString array stores the lexeme of each token */
extern char tokenString[MAXTOKENLEN];

/* function getToken returns the
 * next token in source file
 */
TokenType getToken(void);

extern int yylineno; /* source line number for listing */

typedef pair<string,string> maps;
typedef struct environment
  {
    struct environment* pre;
    map<string,string> symTable;
    map<string,string> declList;
    map<string,string> funcPara;
    int varCnt;
  } Env;

#endif
