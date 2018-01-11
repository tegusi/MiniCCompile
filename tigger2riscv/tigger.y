%{
#define YYPARSER
#include "stdio.h"
#include "global.h"
#define YYSTYPE string
static int yylex();
void yyerror(const char *s);
string rsvWord[] = {"getint","putchar","putint","getchar","main"};
int stack_size;
%}

%token OP LOAD LOADADDR STORE MALLOC GVAR REGISTER
%token RETURN CALL END PARAM LABEL VAR
%token IF GOTO
%token FUNCTION  INTEGER
//%type<vstr> Function Register
%%

Program :
  Program FuncDecl
  | Program GVarDecl
  |
  ;

GVarDecl:
  Variable '=' Integer
  {printf("\
  .global %s\n\
  .section .sdata\n\
  .align 2\n\
  .type %s, @object\n\
  .size %s, 4\n\
%s:\n\
  .word %s\n",$1.c_str(),$1.c_str(),$1.c_str(),$1.c_str(),$3.c_str());}
  | Variable '=' MALLOC Integer
  {cout<<".comm "<<$1<<","<<stoi($4)*4<<",4"<<endl;}
  ;

FuncDecl:
  Function '[' Integer ']' '[' Integer ']'
  {
  if($1 == "f_main")
  $1 = "main";
  stack_size = (stoi($6)/4 + 1) * 16;
  printf("\
  .text\n\
  .align 2\n\
  .global %s\n\
  .type %s, @function\n\
%s:\n\
  add sp,sp,-%d\n\
  sw ra,%d(sp)\n",$1.c_str(),$1.c_str(),$1.c_str(),stack_size,stack_size-4);
  }
  Statement
  END Function
  {
  printf("  .size %s, .-%s\n",$1.c_str(),$1.c_str());
  stack_size = 0;
  };

Statement:
  Statement Expression
  | Expression;

Expression:
  Register '=' Register op Register
  {
  printf("  ");
    if($4 == "+")
      printf("add %s,%s,%s\n",$1.c_str(),$3.c_str(),$5.c_str());
    else if($4 == "-")
      printf("sub %s,%s,%s\n",$1.c_str(),$3.c_str(),$5.c_str());
    else if($4 == "*")
    {
      if($3 == "s8")
      {
      printf("slli %s,%s,2\n",$1.c_str(),$5.c_str());
      }
      else if($5 == "s8")
      {
      printf("slli %s,%s,2\n",$1.c_str(),$3.c_str());
      }
      else
      printf("mul %s,%s,%s\n",$1.c_str(),$3.c_str(),$5.c_str());
    }
    else if($4 == "/")
      printf("div %s,%s,%s\n",$1.c_str(),$3.c_str(),$5.c_str());
    else if($4 == "%")
      printf("rem %s,%s,%s\n",$1.c_str(),$3.c_str(),$5.c_str());
    else if($4 == "<")
      printf("slt %s,%s,%s\n",$1.c_str(),$3.c_str(),$5.c_str());
    else if($4 == ">")
      printf("sgt %s,%s,%s\n",$1.c_str(),$3.c_str(),$5.c_str());
    else if($4 == "&&")
    {
      printf("seqz %s,%s\n", $1.c_str(), $3.c_str());
      printf("add %s,%s,-1\n", $1.c_str(), $1.c_str());
      printf("and %s,%s,%s\n", $1.c_str(), $1.c_str(), $5.c_str());
      printf("snez %s,%s\n", $1.c_str(), $1.c_str());
    }
    else if($4 == "||")
    {
      printf("or %s,%s,%s\n", $1.c_str(), $3.c_str(), $5.c_str());
      printf("snez %s,%s\n", $1.c_str(), $1.c_str());
      break;
    }
    else if($4 == "!=")
    {
      printf("xor %s,%s,%s\n", $1.c_str(), $3.c_str(), $5.c_str());
      printf("snez %s,%s\n", $1.c_str(), $1.c_str());
      break;
    }
    else if($4 == "==")
    {
      printf("xor %s,%s,%s\n", $1.c_str(), $3.c_str(), $5.c_str());
      printf("seqz %s,%s\n", $1.c_str(), $1.c_str());
      break;
    }
  }
  | Register '=' Register op Integer
  {printf("  ");
    if($4 == "+")
      printf("add %s,%s,%s\n",$1.c_str(),$2.c_str(),$3.c_str());
    else if($4 == "<")
      printf("slti %s,%s,%s\n",$1.c_str(),$2.c_str(),$3.c_str());
  }
  | Register '=' op Register
  {printf("  ");
    if($3 == "-")
      printf("sub %s,zero,%s\n",$1.c_str(),$4.c_str());
    if($3 == "!")
    {
      printf("seqz %s,%s\n", $1.c_str(), $4.c_str());
      printf("and %s,%s,0xff\n", $1.c_str(), $1.c_str());
    }
  }
  | Register '=' Integer
  {printf("  ");
    cout<<"li "<<$1<<","<<$3<<endl;
  }
  | Register '=' Register
  {printf("  ");
    cout<<"mv "<<$1<<","<<$3<<endl;
  }
  | Register '=' '[' Integer ']'
  {printf("  ");
    cout<<"li "<<$1<<","<<$3<<endl;
  }
  | Register '[' Integer ']' '=' Register
  {printf("  ");
    cout<<"sw "<<$6<<","<<$3<<"("<<$1<<")"<<endl;
  }
  | Register '=' Register '[' Integer ']'
  {printf("  ");
    cout<<"lw "<<$1<<","<<$5<<"("<<$3<<")"<<endl;
  }
  | IF Register op Register GOTO Label
  {printf("  ");
    if($3 == "<")
      cout<<"blt "<<$2<<","<<$4<<",."<<$6<<endl;
    else if($3 == ">")
      cout<<"bgt "<<$2<<","<<$4<<",."<<$6<<endl;
    else if($3 == "!=")
      cout<<"bne "<<$2<<","<<$4<<",."<<$6<<endl;
    else if($3 == "==")
      cout<<"beq "<<$2<<","<<$4<<",."<<$6<<endl;
    else if($3 == "<=")
      cout<<"ble "<<$2<<","<<$4<<",."<<$6<<endl;
    else if($3 == ">=")
      cout<<"ble "<<$4<<","<<$2<<",."<<$6<<endl;
  }
  | GOTO Label//可以优化
  {printf("  ");
    cout<<"j ."<<$2<<endl;
  }
  | CALL Function
  {printf("  ");

  if($2 == "f_putint")
    $2 = "putint";
  if($2 == "f_getint")
    $2 = "getint";
    if($2 == "f_putchar")
      $2 = "putchar";
    if($2 == "f_getchar")
      $2 = "getchar";
    cout<<"call "<<$2<<endl;
  }
  | Label ':'
  {
    cout<<"."<<$1<<":"<<endl;
  }
  | STORE Register Integer
  {printf("  ");
    printf("sw %s,%d(sp)\n",$2.c_str(),stoi($3)*4);
  }
  | LOAD Integer Register
  {printf("  ");
    printf("lw %s,%d(sp)\n",$3.c_str(),stoi($2)*4);
  }
  | LOAD Variable Register
  {printf("  ");
    printf("lui %s,%%hi(%s)\n",$3.c_str(),$2.c_str());
    printf("lw %s,%%lo(%s)(%s)\n",$3.c_str(),$2.c_str(),$3.c_str());
  }
  | LOADADDR Integer Register
  {printf("  ");
    printf("add %s,sp,%d\n",$3.c_str(),stoi($2) * 4);
  }
  | LOADADDR Variable Register
  {printf("  ");
    printf("lui %s,%%hi(%s)\n",$3.c_str(),$2.c_str());
    printf("add %s,%s,%%lo(%s)\n",$3.c_str(),$3.c_str(),$2.c_str());
  }
  | RETURN
  {printf("  ");
    printf("lw ra,%d(sp)\n", stack_size - 4);
    printf("add sp,sp,%d\n", stack_size);
    printf("jr ra\n");
  }
  ;

Variable:
  GVAR
  {$$ = string(tokenString);};

Register:
  REGISTER
  {$$ = string(tokenString);};

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
  yyparse();
  return 0;
}
