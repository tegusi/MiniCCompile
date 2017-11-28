/****************************************************/
/* File: util.h                                     */
/* Utility functions for the TINY compiler          */
/* Compiler Construction: Principles and Practice   */
/* Kenneth C. Louden                                */
/****************************************************/

#ifndef _UTIL_H_
#define _UTIL_H_

string findVar(char* name);
// string getNewFuncVar(Env* env,int& glbid);
// string getNewTmpVar(Env* env,int& glbid);
// string getNewOriVar(Env* env,int& glbid);
// void decl(Env* env,string a);
void assign(string a,string b);
bool isdigit(string a);
void refill();
void printCode();
void liveAnalysis();
void optimize();
#endif
