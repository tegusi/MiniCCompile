#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <vector>
#include <string>
#include <queue>
#include <map>
#include <bitset>
#include <iostream>
#include <algorithm>
using namespace std;
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

#define GLB 3
#define MEM 2
#define REG 1
#define DEAD 0

#define iOP1	1
#define iOP2	2
#define iASS	3
#define iARRSET	4
#define iARRGET	5
#define iIF	6
#define iGOTO	7
#define iPARAM	8
#define iCALLVOID	9
#define iCALL 	10
#define iRETURN	11
#define iVAR	12
#define iGVAR 	13
#define iFBEGIN 14
#define iFEND	15
#define iLABEL  16
#define iNOOP	0

typedef int TokenType;
#define MAXTOKENLEN 40
#define MAXVARS 500
#define MAXREGS 24

extern int glbID_cnt;
/* tokenString array stores the lexeme of each token */
extern char tokenString[MAXTOKENLEN+1];

/* function getToken returns the
 * next token in source file
 */
TokenType getToken(void);

extern FILE* source; /* source code text file */
extern FILE* listing; /* listing output text file */
extern FILE* code; /* code text file for TM simulator */

extern int yylineno; /* source line number for listing */
