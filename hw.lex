%{
  // #include "y.tab.h"
  #include <string>
  #include "global.h"
  #include "scan.h"
  #include "util.h"
  #include "parse.h"
  // #include <iostream>
  void comment();
  char tokenString[MAXTOKENLEN+1];
%}
digit       [0-9]
number      {digit}+
letter      [a-zA-Z_]
identifier  {letter}({letter}|{digit})*
whitespace  [ \t\v\n\f]+

%%

"\n"            {yylineno++;}
"if"            {return IF;}
"then"          {return THEN;}
"else"          {return ELSE;}
"while"         {return WHILE;}
"return"        {return RETURN;}
"int"           {return INT;}
"main"          {return IDENTIFIER;}

"=="            {return EQ;}
"="             {return '=';}
"!="            {return UNEQ;}
"&&"            {return AND;}
"||"            {return OR;}
"<"             {return LT;}
">"             {return GT;}
"!"             {return NOT;}
"//"[^\n]*      {}//{printf("%s\n",yytext );}
"/*"            {comment();}
"["             {return '[';}
"]"             {return ']';}
"+"             {return PLUS;}
"-"             {return MINUS;}
"*"             {return TIMES;}
"/"             {return OVER;}
"%"             {return MOD;}
"!"             {return '!';}
"("             {return '(';}
")"             {return ')';}
"{"             {return '{';}
"}"             {return '}';}
";"             {return ';';}
","             {return ',';}
{number}        {return INTEGER;}
{identifier}    {return IDENTIFIER;}
{whitespace}    {/* skip whitespace */}
.               {/* skip else */}

%%
int yywrap(void)
{     return 1; }


TokenType getToken(void)
{ static int firstTime = TRUE;
  TokenType currentToken;
  // printf("%d ", firstTime);
  if (firstTime)
  { firstTime = FALSE;

    // lineno++;
    // yyin = source;
    // yyout = listing;
  }
  currentToken = yylex();
  // printf("%s\n", yytext);
  strncpy(tokenString,yytext,MAXTOKENLEN);
  // if (TraceScan) {
  //   fprintf(listing,"\t%d: ",lineno);
  //   printToken(currentToken,tokenString);
  // }
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
