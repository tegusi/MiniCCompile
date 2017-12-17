/****************************************************/
/* File: util.c                                     */
/* Utility function implementation                  */
/* for the TINY compiler                            */
/* Compiler Construction: Principles and Practice   */
/* Kenneth C. Louden                                */
/****************************************************/

#include "global.h"
#include "util.h"

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
