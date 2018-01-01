%{
#define YYPARSER
#include "stdio.h"
#include "global.h"
// #include "scan.h"
#include "util.h"
#define YYSTYPE string
// #include "parse.h"
static int yylex();
void yyerror(const char *s);
// TreeNode *savedTree;
vector<block> blocks;
map<string,int> synTable;
map<int,string> numToSyn;
map<string,int> lblTable;
vector<myfunction> functions;
variable vars[MAXVARS];
myfunction* nowFunc;
int isFunction;
string funcName;
int glb_cnt;
int glbID_cnt;
// int glb_id;
// int glb_lbl_id;
// int isParam;
// int isDecl;

string rsvWord[] = {"getint","putchar","putint","getchar","main"};
%}

%token OP
%token RETURN CALL END PARAM LABEL VAR
%token IF GOTO
%token FUNCTION VARIABLE INTEGER
//%type<vstr> Function Variable
%%

Program :
  Program Statement FuncDecl
  | Program FuncDecl
  |
  ;

FuncDecl:
  Function '[' Integer {
    blocks.push_back(block(iFBEGIN,$1,$3));
    myfunction func = myfunction($1,stoi($3));
    functions.push_back(func);
    nowFunc = &functions.back();
    for(int i = 0;i < stoi($3);i++)
    {
      string varName = "p" + to_string(i) + $1;
      vars[glb_cnt] = variable(varName,glb_cnt,nowFunc->stackSize++);
      numToSyn.insert(pair<int,string>(glb_cnt,varName));
      synTable.insert(pair<string,int>(varName,glb_cnt));
      glb_cnt++;
    }
    isFunction = 1;
    funcName = $1;
  }']'

  Statement
  END Function
  {
    blocks.push_back(block(iFEND,$1));
    nowFunc = NULL;
    isFunction = 0;
    funcName = "";
  };

Statement:
  Statement Expression
  | Expression;

Expression:
  Variable '=' RightValue op RightValue
  {
    block tmp = block(iOP1,$1,$3,$4,$5);
    int id = synTable[$1];tmp.def[id] = 1;
    if(isdigit($3) && isdigit($5))//常数计算
    {
      int res;
      tmp.type = iASS;
      if($4 == "+")
        res = stoi($3) + stoi($5);
      if($4 == "-")
        res = stoi($3) - stoi($5);
      if($4 == "*")
        res = stoi($3) * stoi($5);
      if($4 == "/")
        res = stoi($3) / stoi($5);
      tmp.arg2 = to_string(res);
    }
    else
    {
      if(!isdigit($3))
      {
        int id = synTable[$3];tmp.use[id] = 1;
      }
      if(!isdigit($5))
      {
        int id = synTable[$5];tmp.use[id] = 1;
      }
    }
    blocks.push_back(tmp);
  }
  | Variable '=' op RightValue
  {
    block tmp = block(iOP2,$1,$3,$4);
    int id = synTable[$1];tmp.def[id] = 1;
    if(!isdigit($4))
    {
      int id = synTable[$4];tmp.use[id] = 1;
    }
    blocks.push_back(tmp);
  }
  | Variable '=' RightValue
  {
    block tmp = block(iASS,$1,$3);
    int id = synTable[$1];tmp.def[id] = 1;
    if(!isdigit($3))
    {
      int id = synTable[$3];tmp.use[id] = 1;
    }
    blocks.push_back(tmp);
  }
  | Variable '[' RightValue ']' '=' RightValue
  {
    block tmp = block(iARRSET,$1,$3,$6);
    if(!isdigit($3))
    {
      int id = synTable[$3];tmp.use[id] = 1;
    }
    if(!isdigit($1))
    {
      int id = synTable[$1];tmp.use[id] = 1;
    }
    if(!isdigit($6))
    {
      int id = synTable[$6];tmp.use[id] = 1;
    }
    blocks.push_back(tmp);
  }
  | Variable '=' Variable '[' RightValue ']'
  {
    block tmp = block(iARRGET,$1,$3,$5);
    if(!isdigit($3))
    {
      int id = synTable[$3];tmp.use[id] = 1;
    }
    if(!isdigit($5))
    {
      int id = synTable[$5];tmp.use[id] = 1;
    }
    blocks.push_back(tmp);
  }
  | IF RightValue op RightValue GOTO Label
  {
    block tmp = block(iIF,$2,$3,$4,$6);
    if(!isdigit($2))
    {
      int id = synTable[$2];tmp.use[id] = 1;
    }
    if(!isdigit($4))
    {
      int id = synTable[$4];tmp.use[id] = 1;
    }
    blocks.push_back(tmp);
  }
  | GOTO Label//可以优化
  {
    block tmp = block(iGOTO,$2);
    blocks.push_back(tmp);
  }
  | Label ':'
  {
    block tmp = block(iLABEL,$1);
    blocks.push_back(tmp);
    lblTable.insert(pair<string,int>($1,blocks.size()-1));
  }
  | PARAM RightValue
  {
    block tmp = block(iPARAM,$2);
    if(!isdigit($2))
    {
      int id = synTable[$2];
      tmp.use[id] = 1;
    }
    blocks.push_back(tmp);
  }
  | Variable '=' CALL Function
  {
    block tmp = block(iCALL,$1,$4);
    int id = synTable[$1];
    tmp.def[id] = 1;
    blocks.push_back(tmp);
  }
  | RETURN RightValue
  {
    if(isdigit($2))
    blocks.push_back(block(iRETURN,$2));
    else
    {
      block tmp = block(iRETURN,$2);
      int id = synTable[$2];
      tmp.use[id] = 1;
      blocks.push_back(tmp);
    }
  }
  | VAR Integer Variable
  {
    if(nowFunc == NULL)
    {
      vars[glb_cnt] = variable($3,glb_cnt);
      vars[glb_cnt].isArray = 1;
    }
    else
    {
      vars[glb_cnt] = variable($3,glb_cnt,nowFunc->stackSize);
      vars[glb_cnt].isArray = 1;
      nowFunc->stackSize += stoi($2);
    }
    numToSyn.insert(pair<int,string>(glb_cnt,$3));
    synTable.insert(pair<string,int>($3,glb_cnt));
    glb_cnt++;
    blocks.push_back(block(iGVAR,$2,$3));
  }
  | VAR Variable
  {
    if(nowFunc == NULL)
    {
      vars[glb_cnt] = variable($2,glb_cnt);
    }
    else
    {
      vars[glb_cnt] = variable($2,glb_cnt,nowFunc->stackSize++);
    }
    numToSyn.insert(pair<int,string>(glb_cnt,$2));
    synTable.insert(pair<string,int>($2,glb_cnt));
    glb_cnt++;
    blocks.push_back(block(iVAR,$2));
  }
  ;

RightValue:
  Variable {$$ = $1;}
  | Integer {$$ = $1;}
  ;

Variable:
  VARIABLE
  {
    string varName = string(tokenString);
    if(varName[0] == 'p')
    {
      $$ = varName + funcName;
    }
    else
    {
      $$ = varName;
    }
  };

Integer:
  INTEGER
  {$$ = string(tokenString);};

Function:
  FUNCTION
  {$$ = string(tokenString);};

Label:
  LABEL
  {$$ = string(tokenString);};

op:
  OP
  {$$ = string(tokenString);};
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

int main() {
  isFunction = 0;
  glb_cnt = 0;
  glbID_cnt = 0;
  nowFunc = NULL;
  // glb_id = 0;
  // isParam = 0;
  // isDecl = 0;
  // nowEnv = newEnv(NULL);
  yyparse();
  printCode();
  return 0;
}
