%{
#define YYPARSER
#include "stdio.h"
#include "global.h"
#include "scan.h"
#include "util.h"
#include "parse.h"
#define YYSTYPE string
static int yylex();
void yyerror(const char *s);
TreeNode *savedTree;
Env *nowEnv;
int glb_cnt;
int glb_id;
int glb_lbl_id;
int isParam;
string rsvWord[] = {"getint","putchar","putint","getchar","main"};
%}

%left EQ UNEQ
%left PLUS MINUS
%left TIMES OVER MOD
%left NOT AND OR GT LT
%token RETURN MAIN INT
%token IF THEN ELSE WHILE
%token ASSIGN
%token INTEGER IDENTIFIER
%%

Goal :
  DefnDeclList//MainFunc
  ;

DefnDeclList :
  DefnDeclList VarDefn
  | DefnDeclList FuncDefn
  | DefnDeclList FuncDecl
  |
  ;

VarDefn :
  Type Identifier ';' {decl($2);}
  | Type Identifier '[' Integer {decl(to_string(4 * stoi($4)) + " " + $2);} ']' ';'
  ;

VarDecl :
  Type Identifier
  {$$ = $2;}
  | Type Identifier '[' Integer ']'
  {$$ = $2;}
  ;

FuncDefn :
  Type Identifier '(' ParaList ')'
  {
    isParam = 0;
    if($2=="main")
      cout<<"f_"<<$2<<" [0]"<<endl;
    else
      cout<<"f_"<<$2<<" ["<<nowEnv->symTable.size()<<"]"<<endl;
  }
  '{'FuncBody'}'
  {cout<<"end f_"<<$2<<endl;nowEnv=nowEnv->pre;}
  ;

FuncDecl :
  Type Identifier '(' ParaList ')' ';'
  {
    // nowEnv->symTable.insert(maps($2,getNewOriVar(nowEnv, glb_id)));
    nowEnv = nowEnv->pre;
  }
  ;

ParaList :
  {nowEnv = newEnv(nowEnv);isParam = 1;}
  VarDecl
  {
    // nowEnv->symTable[$1] = 'p' + to_string(nowEnv->varCnt);
  }
  | ParaList ',' VarDecl
  {
    // string varId = getNewFuncVar(nowEnv, glb_id);
    // nowEnv->symTable.insert(maps($3,varId));
    // nowEnv->symTable[$3] = 'p' + to_string(nowEnv->varCnt);
  }
  |
  { nowEnv = newEnv(nowEnv); }
  ;

FuncBody :
  FuncBody FuncDecl
  | FuncBody Statement
  |
  ;

Type :
  INT
  ;

Statement:
  '{' {nowEnv = newEnv(nowEnv);} StatementLine '}' {nowEnv = nowEnv->pre;}
  | IF '(' Expression ')'
  {
    string L1 = to_string(glb_lbl_id++);
    cout<<"if "<<$3<<" ==0 goto l"<<L1<<endl;
    $3 = L1;
  }
  Statement
  StatementElse
  | WHILE
  {
    string L1 = to_string(glb_lbl_id++);
    cout<<"l"<<L1<<":"<<endl;
    $1 = L1;
  }
  '(' Expression ')'
  {
    string L2 = to_string(glb_lbl_id++);
    cout<<"if "<<$4<<" ==0 goto l"<<L2<<endl;
    $4 = L2;
  }
  Statement
  {
    cout<<"goto l"<<$1<<endl;
    cout<<"l"<<$4<<":"<<endl;
  }
  | Identifier '=' Expression ';'
  { assign($1,$3); }
  | Identifier '[' Expression ']' '=' Expression ';'
  {
    string varId = getNewTmpVar(nowEnv, glb_id);
    assign(varId,"4 * " + $3);
    cout<<$1+"["+varId+"] = "+$6<<endl;
  }
  | VarDefn {}
  | RETURN Expression ';'
  { cout<<"return "<<$2<<endl; }
  ;

StatementElse:
  ELSE
  {
    string L2 = to_string(glb_lbl_id++);
    cout<<"goto l"<<L2<<endl;
    cout<<"l"<<$-3<<":"<<endl;
    $1 = L2;
  }
  Statement
  { cout<<"l"<<$1<<":"<<endl; }
  |
  { cout<<"l"<<$-3<<":"<<endl; }
  ;

StatementLine:
  StatementLine Statement
  |
  ;

p1Expression :
  Integer { $$ = $1; }
  | Identifier {$$ = $1;}
  | '!' p1Expression
  {
    string varId = getNewTmpVar(nowEnv, glb_id);
    cout<<"var "<<varId<<endl;
    cout<<varId<<" = ! "<<$2<<endl;
    $$ = varId;
  }
  | MINUS p1Expression
  {
    string varId = getNewTmpVar(nowEnv, glb_id);
    cout<<"var "<<varId<<endl;
    cout<<varId<<" = - "<<$2<<endl;
    $$ = varId;
  }
  | Identifier '(' IdenList ')'
  {
    string varId = getNewTmpVar(nowEnv, glb_id);
    cout<<"var "<<varId<<endl;
    cout<<varId<<" = call f_"+$1<<endl;
    $$ = varId;
  }
  | Identifier '[' Expression ']'
    {
      string varId = getNewTmpVar(nowEnv, glb_id);
      cout<<"var "<<varId<<endl;
      assign(varId,"4 * " + $3);
      cout<<varId<<" = "<<$1<<"["<<varId<<"]"<<endl;
      $$ = varId;
    }
  | '(' Expression ')'
    {$$ = $2;}
  ;

p2Expression :
  p1Expression {$$ = $1;}
  | p2Expression TIMES p1Expression
  {
    string varId = getNewTmpVar(nowEnv, glb_id);
    cout<<"var "<<varId<<endl;
    cout<<varId<<" = "<<$1<<" * "<<$3<<endl;
    $$ = varId;
  }
  | p2Expression OVER p1Expression
  {
    string varId = getNewTmpVar(nowEnv, glb_id);
    cout<<"var "<<varId<<endl;
    cout<<varId<<" = "<<$1<<" / "<<$3<<endl;
    $$ = varId;
  }
  | p2Expression MOD p1Expression
  {
    string varId = getNewTmpVar(nowEnv,glb_id);
    cout<<"var "<<varId<<endl;
    cout<<varId<<" = "<<$1<<" % "<<$3<<endl;
    $$ = varId;
  }
  ;

p3Expression :
  p2Expression {$$ = $1;}
  | p3Expression PLUS p2Expression
  {
    string varId = getNewTmpVar(nowEnv,glb_id);
    cout<<"var "<<varId<<endl;
    cout<<varId<<" = "<<$1<<" + "<<$3<<endl;
    $$ = varId;
  }
  | p3Expression MINUS p2Expression
  {
    string varId = getNewTmpVar(nowEnv,glb_id);
    cout<<"var "<<varId<<endl;
    cout<<varId<<" = "<<$1<<" - "<<$3<<endl;
    $$ = varId;
  }
  ;

p4Expression :
  p3Expression {$$ = $1;}
  | p4Expression LT p3Expression
  {
    string varId = getNewTmpVar(nowEnv,glb_id);
    cout<<"var "<<varId<<endl;
    cout<<varId<<" = "<<$1<<" < "<<$3<<endl;
    $$ = varId;
  }
  | p4Expression EQ p3Expression
  {
    string varId = getNewTmpVar(nowEnv,glb_id);
    cout<<"var "<<varId<<endl;
    cout<<varId<<" = "<<$1<<" == "<<$3<<endl;
    $$ = varId;
  }
  | p4Expression GT p3Expression
  {
    string varId = getNewTmpVar(nowEnv,glb_id);
    cout<<"var "<<varId<<endl;
    cout<<varId<<" = "<<$1<<" > "<<$3<<endl;
    $$ = varId;
  }
  | p4Expression UNEQ p3Expression
  {
    string varId = getNewTmpVar(nowEnv,glb_id);
    cout<<"var "<<varId<<endl;
    cout<<varId<<" = "<<$1<<" != "<<$3<<endl;
    $$ = varId;
  }
  ;

p5Expression :
  p4Expression
  | p5Expression AND p4Expression
  {
    string varId = getNewTmpVar(nowEnv,glb_id);
    cout<<"var "<<varId<<endl;
    cout<<varId<<" = "<<$1<<" && "<<$3<<endl;
    $$ = varId;
  }
  | p5Expression OR p4Expression
  {
    string varId = getNewTmpVar(nowEnv,glb_id);
    cout<<"var "<<varId<<endl;
    cout<<varId<<" = "<<$1<<" || "<<$3<<endl;
    $$ = varId;
  }
  ;

Expression :
  p5Expression {$$ = $1;}
  ;

IdenList :
  Integer
  {cout<<"param "<<$1<<endl;}
  |
  Identifier
  {cout<<"param "<<$1<<endl;}
    // {$$ = newExpNode(IdK);$$->sibling = NULL;}
  | IdenList ',' Identifier
  {cout<<"param "<<$3<<endl;}
  | IdenList ',' Integer
  {cout<<"param "<<$3<<endl;}
    // {$$ = newExpNode(IdK);$1->sibling = $3;$3->sibling = NULL;$$->sibling = $1;}
  |
  ;

Integer : INTEGER
  {
    $$ = string(tokenString);
  }
Identifier : IDENTIFIER
  {
    string varId;int flag = 1;
    for(int i = 0;i < 5;i++)
      if(string(tokenString) == rsvWord[i])
        {
          $$ = rsvWord[i];
          flag = 0;
        }
    if(flag)
    {
      if((varId = findVar(nowEnv,string(tokenString))) != "")
        $$ = varId;
      else
      {
        if(isParam) varId = getNewFuncVar(nowEnv,glb_id);
        else varId = getNewOriVar(nowEnv,glb_id);
        nowEnv->symTable.insert(maps(string(tokenString),varId));
        $$ = varId;
      }
    }
    // $$ = newExpNode(IdK);$$->attr.name = copyString(tokenString);
  };
%%
void yyerror(const char *s)
{
    extern int yylineno;
    printf("%d\n", yylineno);
    puts(s);
    exit(1);
}
static int yylex(void)
{ return getToken(); }

TreeNode * parse(void)
{ yyparse();
  return savedTree;}
int main() {
  glb_id = 0;
  isParam = 0;
  nowEnv = newEnv(NULL);
  parse();
  return 0;
}
