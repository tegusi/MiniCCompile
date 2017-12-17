/****************************************************/
/* File: util.h                                     */
/* Utility functions for the TINY compiler          */
/* Compiler Construction: Principles and Practice   */
/* Kenneth C. Louden                                */
/****************************************************/

#ifndef _UTIL_H_
#define _UTIL_H_

Env* newEnv(Env* preEnv);
string findVar(Env* env,string name);
string getNewFuncVar(Env* env,int& glbid);
string getNewTmpVar(Env* env,int& glbid);
string getNewOriVar(Env* env,int& glbid);
void decl(Env* env,string a);
void assign(string a,string b);

#endif
