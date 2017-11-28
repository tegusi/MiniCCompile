%{
  #include "global.h"
	char tokenString[MAXTOKENLEN+1];
//  #include "scan.h"
//  #include "util.h"
//  #include "parse.h"
  void comment();
%}
NUM [1-9][0-9]*|0
SYMBOL [Ttp][0-9]+
LABEL l[0-9]+
FUNCTION f_[_a-zA-Z][_a-zA-Z0-9]*
LOGIOP ==
OP [\+\-\*\/\%\!]|\|\||&&|>|<|!=|==

%%
"\n"	{; yylineno++;}
"var"	{; return VAR;}
"if"	{; return IF;}
"goto"	{; return GOTO;}
"param"	{; return PARAM;}
"call"	{; return CALL;}
"return" {; return RETURN;}
"end"	{; return END;}

{OP}            {return OP;}
"//"[^\n]*      {}//{;}
"/*"            {comment();}
"="             {return '=';}
":"             {return ':';}
"["             {return '[';}
"]"             {return ']';}

{LABEL}	{;return LABEL;}
{NUM}	{;return INTEGER;}
{SYMBOL} {;return VARIABLE;}
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
