%{
  #include "global.h"
	char tokenString[MAXTOKENLEN+1];
  void comment();
%}
NUM [1-9][0-9]*|0
REG [sxat][0-9]+
LABEL l[0-9]+
GVAR v[0-9]+
FUNCTION f_[_a-zA-Z][_a-zA-Z0-9]*
OP [\+\-\*\/\%\!]|\|\||&&|>|<|!=|==

%%
"\n"	{; yylineno++;}
"end"	{; return END;}
"if"	{; return IF;}
"goto"	{; return GOTO;}
"call"	{; return CALL;}
"load"	{; return LOAD;}
"loadaddr"	{; return LOADADDR;}
"store"	{; return STORE;}
"return" {; return RETURN;}
"malloc" {return MALLOC;}

{OP}            {return OP;}
"//"[^\n]*      {}//{;}
"/*"            {comment();}
"="             {return '=';}
":"             {return ':';}
"["             {return '[';}
"]"             {return ']';}

{LABEL}	{;return LABEL;}
{GVAR}	{;return GVAR;}
{NUM}	{;return INTEGER;}
{REG} {;return REGISTER;}
{FUNCTION}	{;return FUNCTION;}
. {}
%%
int yywrap(){
	return 1;
}

TokenType getToken()
{
  TokenType currentToken;
  currentToken = yylex();
  ;
  strncpy(tokenString,yytext,MAXTOKENLEN);
  return currentToken;
}

void comment()
{
  char c;
  while(1)
  {
    if(c != '*')
    {
      if(c=='\n') yylineno++;
    c = yyinput();
    continue;}
    else
    {
      c = yyinput();
      if(c == '/')
        break;
      else
        continue;
    }
    c = yyinput();
  }
}
