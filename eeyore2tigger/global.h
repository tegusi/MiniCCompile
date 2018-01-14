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
#define MAXVARS 1000
#define MAXREGS 23

extern int glbID_cnt;
struct block{
  int type;
  // int line_num, type;
	string arg1, arg2, arg3, arg4;
  vector<int> pre;
  bitset<MAXVARS> def,use,live,gen,kill,in,out,ud_chain;
  block(int _type, string _arg1 = "", string _arg2 = "", string _arg3 = "", string _arg4 = ""):
  type(_type),arg1(_arg1),arg2(_arg2),arg3(_arg3),arg4(_arg4) {};
};

struct variable{
  int id,st,ed,pos,reg,mem,active,isGlobal,isArray,glbID;
  int _pos,_reg,_mem,_active;
  string name;

  variable(string _name,int _id,int memID = 0):id(_id),name(_name)
  {
    mem = memID;isArray = 0;
    st = 63333;ed = -1;_pos = 0;_reg = 0;
    if(mem == 0) {isGlobal = 1;glbID = glbID_cnt++;}
    else isGlobal = 0;
  };
  variable() {};
};

struct myfunction{
  string name;
  int stackSize,varCnt;
  myfunction(string _name,int _varCnt)
  {
    name = _name;
    varCnt = _varCnt;
    stackSize = 12;
  };
  myfunction(){};
};
struct reg{
  int live,dead;
  variable *vars,*_var;
};
typedef pair<int,int> Interval;

typedef pair<string,string> maps;
typedef struct environment
  {
    struct environment* pre;
    map<string,int> VarToID;
    bitset<MAXVARS> chain;
  } Env;

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
extern int glb_cnt;
extern std::vector<block> blocks;
extern map<string,int> synTable;
extern map<string,int> lblTable;
extern map<int,string> numToSyn;
extern vector<myfunction> functions;
extern reg regInfo[MAXREGS];
extern variable vars[MAXVARS];
typedef enum {StmtK,ExpK} NodeKind;
typedef enum {IfK,WhileK,AssignK,AssignAddrK,ElseK} StmtKind;
typedef enum {OpK,ConstK,IdK} ExpKind;
