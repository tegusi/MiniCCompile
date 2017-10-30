/****************************************************/
/* File: util.c                                     */
/* Utility function implementation                  */
/* for the TINY compiler                            */
/* Compiler Construction: Principles and Practice   */
/* Kenneth C. Louden                                */
/****************************************************/

#include "global.h"
#include "util.h"

/* Procedure printToken prints a token
 * and its lexeme to the listing file
 */
// void printToken( TokenType token, const char* tokenString )
// { switch (token)
//   { case IF:
//     case THEN:
//     case ELSE:
//     case END:
//     case ASSIGN: fprintf(listing,":=\n"); break;
//     case LT: fprintf(listing,"<\n"); break;
//     case EQ: fprintf(listing,"=\n"); break;
//     case LPAREN: fprintf(listing,"(\n"); break;
//     case RPAREN: fprintf(listing,")\n"); break;
//     case SEMI: fprintf(listing,";\n"); break;
//     case PLUS: fprintf(listing,"+\n"); break;
//     case MINUS: fprintf(listing,"-\n"); break;
//     case TIMES: fprintf(listing,"*\n"); break;
//     case OVER: fprintf(listing,"/\n"); break;
//     case ENDFILE: fprintf(listing,"EOF\n"); break;
//     case NUM:
//       fprintf(listing,
//           "NUM, val= %s\n",tokenString);
//       break;
//     case ID:
//       fprintf(listing,
//           "ID, name= %s\n",tokenString);
//       break;
//     case ERROR:
//       fprintf(listing,
//           "ERROR: %s\n",tokenString);
//       break;
//     default: /* should never happen */
//       fprintf(listing,"Unknown token: %d\n",token);
//   }
// }

/* Function newStmtNode creates a new statement
 * node for syntax tree construction
 */
TreeNode * newStmtNode(StmtKind kind)
{ TreeNode * t = (TreeNode *) malloc(sizeof(TreeNode));
  int i;
  if (t==NULL)
    ;//fprintf(listing,"Out of memory error at line %d\n",yylineno);
  else {
    t->childs.push_back(NULL);
    for (i=0;i<MAXCHILDREN;i++) t->child[i] = NULL;
    t->sibling = NULL;
    t->nodekind = StmtK;
    t->kind.stmt = kind;
    t->lineno = yylineno;
  }
  return t;
}

/* Function newExpNode creates a new expression
 * node for syntax tree construction
 */
TreeNode * newExpNode(ExpKind kind)
{ TreeNode * t = (TreeNode *) malloc(sizeof(TreeNode));
  int i;
  if (t==NULL)
    ;
    // fprintf(listing,"Out of memory error at line %d\n",yylineno);
  else {
    for (i=0;i<MAXCHILDREN;i++) t->child[i] = NULL;
    t->sibling = NULL;
    t->nodekind = ExpK;
    t->kind.exp = kind;
    t->lineno = yylineno;
    t->type = Void;
  }
  return t;
}

Env* newEnv(Env* preEnv)
{
  Env* tmp = new Env;
  tmp->pre = preEnv;
  tmp->varCnt = 0;
  return tmp;
}

string getNewFuncVar(Env* env,int& glbid)
{
  return "p" + to_string(env->varCnt++);
}

string getNewTmpVar(Env* env,int& glbid)
{
  return "t" + to_string(glbid++);
}

string getNewOriVar(Env* env,int& glbid)
{
  return "T" + to_string(glbid++);
}

string findVar(Env* env,string name)
{
  while(env != NULL)
  {
    auto iter = env->symTable.find(name);
    if(iter != env->symTable.end())
      return iter->second;
    env = env->pre;
  }
  return "";
}

void decl(Env* env,string a)
{
  cout<<"var "<<a<<endl;
  env->declList.insert(maps(a,"1"));
}
void assign(string a,string b)
{
  cout<<a<<" = "<<b<<endl;
}
/* Function copyString allocates and makes a new
 * copy of an existing string
 */
char * copyString(char * s)
{ int n;
  char * t;
  if (s==NULL) return NULL;
  n = strlen(s)+1;
  t = (char*)malloc(n);
  // if (t==NULL)
  //   fprintf(listing,"Out of memory error at line %d\n",yylineno);
  strcpy(t,s);
  return t;
}

/* Variable indentno is used by printTree to
 * store current number of spaces to indent
 */
static int indentno = 0;

/* macros to increase/decrease indentation */
#define INDENT indentno+=2
#define UNINDENT indentno-=2
