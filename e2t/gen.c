/****************************************************/
/* File: util.c                                     */
/* Utility function implementation                  */
/* for the TINY compiler                            */
/* Compiler Construction: Principles and Practice   */
/* Kenneth C. Louden                                */
/****************************************************/

#include "global.h"
#include "util.h"

//t0-t6:0-6
//s0-s11:7-18
//a0-a7:19-26
string regName[] = {"t0","t1","t2","t3","t4","t5","t6",//caller saved
                    "a0","a1","a2","a3","a4","a5","a6","a7",//param 7+
                    "s0","s1","s2","s3","s4","s5","s6","s7","s8","s9","s10","s11"};//15+
int callerSaved[] = {0,1,2,3,4,5,6};
int NUMREG1 = 24;
int NUMREG2 = 25;
int ADDRREG = 26;
int line;
void link(int reg,variable *var)
{
  regInfo[reg]._var = var;
  var->_reg = reg;
  var->_pos = REG;
}
void RegToMem(int reg,variable *var)
{
  cout<<"store "<<regName[reg]<<" "<<var->mem<<endl;
  var->_pos = MEM;
}
void RegToGlb(int reg,variable *var)
{
  cout<<"loadaddr v"<<var->glbID<<" "<<regName[ADDRREG]<<endl;
  cout<<regName[ADDRREG]<<"[0]"<<" = "<<regName[reg]<<endl;
  var->_pos = GLB;
}
void MemToReg(int reg,variable *var)
{
  cout<<"load "<<var->mem<<" "<<regName[reg]<<endl;
}
void GlbToReg(int reg,variable *var)
{
  cout<<"load v"<<var->glbID<<" "<<regName[reg]<<endl;
}
void RegToReg(int reg1,int reg2)
{
  cout<<regName[reg1]<<" = "<<regName[reg2]<<endl;
}
void LoadVarTemp(int reg,variable* var)//传参并不修改变量描述
{
  // regInfo[reg]._var = var;
  if(var->_pos == REG)
  {
    cout<<regName[reg]<<" = "<<regName[var->_reg]<<endl;
  }
  else if(var->_pos == MEM)
  {
    cout<<"load "<<var->mem<<" "<<regName[reg]<<endl;
  }
  else if(var->_pos == GLB)
  {
    cout<<"load v"<<var->glbID<<" "<<regName[reg]<<endl;
  }
}
int LoadNum(int reg,string num)
{
  cout<<regName[reg]<<" = "<<num<<endl;
  return reg;
}
int LoadAddr(variable *var)
{
  if(var->isGlobal)
    cout<<"loadaddr v"<<var->glbID<<" "<<regName[ADDRREG]<<endl;
  else
    cout<<"loadaddr "<<var->mem<<" "<<regName[ADDRREG]<<endl;
  return ADDRREG;
}
void LoadVar(int reg,variable* var)//并不处理spill
{
  // regInfo[reg]._var = var;
  if(var->_pos == REG)
  {
    cout<<regName[reg]<<" = "<<regName[var->_reg]<<endl;
  }
  else if(var->_pos == MEM)
  {
    cout<<"load "<<var->mem<<" "<<regName[var->_reg]<<endl;
  }
  else if(var->_pos == GLB)
  {
    cout<<"load "<<var->glbID<<" "<<regName[var->_reg]<<endl;
  }
  link(reg,var);
}
void IfStatement(int reg1, string op,int reg2,string label)
{
  cout<<"if "<<regName[reg1]<<op<<regName[reg2]<<" goto "<<label<<endl;
}
void OP1Statement(int reg1, int reg2, string op, int reg3)
{
  cout<<regName[reg1]<<" = "<<regName[reg2]<<" "<<op<<" "<<regName[reg3]<<endl;
}
void OP2Statement(int reg1, string op, int reg2)
{
  cout<<regName[reg1]<<" = "<<op<<" "<<regName[reg2]<<endl;
}
void ASSStatement(string reg1, string reg2)
{
  cout<<reg1<<" = "<<reg2<<endl;
}
void _SpillVar_(int reg,variable *var)
{
  if(var->mem)
  {
    RegToMem(reg,regInfo[reg]._var);
    var->_pos = MEM;
  }
  else
  {
    RegToGlb(reg,regInfo[reg]._var);
    var->_pos = GLB;
  }
  // var->_mem = var->mem;
  regInfo[reg]._var = NULL;
}
void _RecoverVar_(variable *var)//保证为空
{
  if(var == NULL) {return;}
  if(var->ed < line) {return;}
  if(var->_pos == REG) return;
  if(var->_pos == MEM)
  {
    if(regInfo[var->reg]._var != NULL) _SpillVar_(var->reg,regInfo[var->reg]._var);
    MemToReg(var->reg,var);
  }
  if(var->_pos == GLB)
  {
    if(regInfo[var->reg]._var != NULL) _SpillVar_(var->reg,regInfo[var->reg]._var);
    GlbToReg(var->reg,var);
  }
  link(var->reg,var);
}
int _GetReg_(variable *var,variable* &spilled)
{
  spilled = NULL;
  if(var->_pos == REG) return var->_reg;
  if(var->_pos == MEM || var->_pos == GLB)
  {
    if(regInfo[var->reg]._var != NULL)
    {
      spilled = regInfo[var->reg]._var;
      _SpillVar_(var->reg,regInfo[var->reg]._var);
    }
    _RecoverVar_(var);
    return var->reg;
  }
  if(var->_pos == DEAD)
  {
    if(regInfo[var->reg]._var != NULL)
    {
      spilled = regInfo[var->reg]._var;
      _SpillVar_(var->reg,regInfo[var->reg]._var);
    }
    link(var->reg,var);
    return var->reg;
  }
  cout<<"Error in GetReg!"<<endl;
  return -1;
}

int isGlobal;
void gen()
{
  vector<variable*> varOfCallerToRec,varOfCalleeToRec;
  vector<string> varToParam;
  int param_cnt = 0;
  for(line = 0;line < blocks.size();line++)
  {
    block now = blocks[line];
    switch (now.type) {
      case iIF:
      {
        int reg1,reg2;
        variable *rec1 = NULL,*rec2 = NULL;
        if(isdigit(now.arg1)) reg1 = LoadNum(NUMREG1,now.arg1);
        else reg1 = _GetReg_(&vars[synTable[now.arg1]],rec1);
        if(isdigit(now.arg3)) reg2 = LoadNum(NUMREG2,now.arg3);
        else reg2 = _GetReg_(&vars[synTable[now.arg3]],rec2);
        IfStatement(reg1,now.arg2,reg2,now.arg4);
        _RecoverVar_(rec1);_RecoverVar_(rec2);
        break;
      }
      case iGOTO:
      {
        cout<<"goto "<<now.arg1<<endl;
        break;
      }
      case iOP1:
      {
        int reg1,reg2,reg3;
        variable *rec1 = NULL ,*rec2 = NULL,*rec3 = NULL;
        if(isdigit(now.arg2)) reg2 = LoadNum(NUMREG1,now.arg2);
        else reg2 = _GetReg_(&vars[synTable[now.arg2]],rec2);
        if(isdigit(now.arg4)) reg3 = LoadNum(NUMREG2,now.arg4);
        else reg3 = _GetReg_(&vars[synTable[now.arg4]],rec3);
        if(vars[synTable[now.arg1]].reg == reg2 || vars[synTable[now.arg1]].reg == reg3)
        {
          reg1 = vars[synTable[now.arg1]].reg;
          OP1Statement(reg1,reg2,now.arg3,reg3);
          link(reg1,&vars[synTable[now.arg1]]);
        }
        else
        {
          reg1 = _GetReg_(&vars[synTable[now.arg1]],rec1);
          OP1Statement(reg1,reg2,now.arg3,reg3);
        }
        _RecoverVar_(rec1);_RecoverVar_(rec2);_RecoverVar_(rec3);
        break;
      }
      case iOP2:
      {
        int reg1,reg2;
        variable *rec1 = NULL,*rec2 = NULL;
        if(isdigit(now.arg3)) reg2 = LoadNum(NUMREG1,now.arg3);
        else reg2 = _GetReg_(&vars[synTable[now.arg3]],rec1);
        reg1 = _GetReg_(&vars[synTable[now.arg1]],rec2);
        OP2Statement(reg1,now.arg2,reg2);
        _RecoverVar_(rec1);_RecoverVar_(rec2);
        break;
      }
      case iVAR:
      {
        variable *var = &vars[synTable[now.arg1]];
        if(var->isGlobal)
        {
          cout<<"v"<<var->glbID<<" = 0"<<endl;
        }
        break;
      }
      case iGVAR:
      {
        variable *var = &vars[synTable[now.arg2]];
        if(var->isGlobal)
        {
          cout<<"v"<<var->glbID<<" = malloc "<<now.arg1<<endl;
        }
        break;
      }
      case iFBEGIN:
      {
        myfunction nowfunc;
        for(int i = 0;i < 24; i++)
        {regInfo[i]._var = NULL;}
        for(int i = 0;i < functions.size();i++)
        {
          if(functions[i].name == now.arg1)
          {nowfunc = functions[i];break;}
        }
        cout<<now.arg1<<" "<<"["<<now.arg2<<"] ["<<nowfunc.stackSize<<']'<<endl;
        for(int reg = 15;reg < 24;reg++)
        {
          cout<<"store "<<regName[reg]<<" "<<reg-15<<endl;
          // if(regInfo[reg]._var != NULL)
          // {
          //   varOfCalleeToRec.push_back(regInfo[reg]._var);
          //   _SpillVar_(reg,regInfo[reg]._var);
          // }
        }
        for(int para = 0;para < stoi(now.arg2);para++)
        {
          variable *parameter = &vars[synTable["p" + to_string(para) + now.arg1]];
          RegToReg(parameter->reg, 7 + para);
          link(parameter->reg,parameter);
        }
        break;
      }
      case iFEND:
      {
        // for(int reg = 0;reg < varOfCalleeToRec.size();reg++)
        // {
        //   _RecoverVar_(varOfCalleeToRec[reg]);
        // }
        // varOfCalleeToRec.clear();
        cout<<"end "<<now.arg1<<endl;
        break;
      }
      case iASS:
      {
        int reg1,reg2;
        variable *rec1 = NULL,*rec2 = NULL;
        reg1 = _GetReg_(&vars[synTable[now.arg1]],rec1);
        if(isdigit(now.arg2))
        {ASSStatement(regName[reg1],now.arg2);}
        else {reg2 = _GetReg_(&vars[synTable[now.arg2]],rec2);
        ASSStatement(regName[reg1],regName[reg2]);}
        _RecoverVar_(rec1);_RecoverVar_(rec2);
        break;
      }
      case iARRSET:
      {
        int reg1,reg2;
        variable *addvar = &vars[synTable[now.arg1]],*rec1 = NULL,*rec2 = NULL;
        LoadAddr(addvar);
        if(isdigit(now.arg2))
          cout<<regName[ADDRREG]<<" = "<<regName[ADDRREG]<<" + "<<now.arg2<<endl;
        else
        {
          reg1 = _GetReg_(&vars[synTable[now.arg2]],rec1);
          OP1Statement(ADDRREG,ADDRREG,"+",reg1);
        }
        if(isdigit(now.arg3))
          reg2 = LoadNum(NUMREG1,now.arg3);
        else
          reg2 = _GetReg_(&vars[synTable[now.arg3]],rec2);
        cout<<regName[ADDRREG]<<"[0] = "<<regName[reg2]<<endl;
        _RecoverVar_(rec1);_RecoverVar_(rec2);
        break;
      }
      case iARRGET:
      {
        int reg1,reg2;
        variable *lvar = &vars[synTable[now.arg1]];
        variable *addvar = &vars[synTable[now.arg2]];
        variable *rec1 = NULL,*rec2 = NULL;
        LoadAddr(addvar);
        if(isdigit(now.arg3))
          cout<<regName[ADDRREG]<<" = "<<regName[ADDRREG]<<" + "<<now.arg2<<endl;
        else
        {
          reg1 = _GetReg_(&vars[synTable[now.arg3]],rec1);
          OP1Statement(ADDRREG,ADDRREG,"+",reg1);
        }
        reg2 = _GetReg_(lvar,rec2);
        cout<<regName[reg2]<<" = "<<regName[ADDRREG]<<"[0]"<<endl;
        _RecoverVar_(rec1);_RecoverVar_(rec2);
        break;
      }
      case iPARAM:
      {
        varToParam.push_back(now.arg1);
        // int reg;
        // if(regInfo[7+param_cnt]._var != NULL)
        // _SpillVar_(7+param_cnt,regInfo[7+param_cnt]._var);
        // if(isdigit(now.arg1))
        // {
        //   LoadNum(7 + param_cnt,now.arg1);
        // }
        // else
        // {
        //   // if(var->_pos == MEM)
        //   LoadVar(7 + param_cnt,&vars[synTable[now.arg1]]);
        //   // variable* var = &vars[synTable[now.arg1]];
        //   // reg = _GetReg_(var);
        //   // RegToReg(7 + param_cnt,reg);
        // }
        // param_cnt++;
        break;
      }
      case iCALL:
      {
        param_cnt = 0;
        for(int reg = 0;reg < 7;reg++)
        {
          if(regInfo[reg]._var != NULL)
          {
            varOfCallerToRec.push_back(regInfo[reg]._var);
            _SpillVar_(reg,regInfo[reg]._var);
          }
        }
        for(int cnt = 0;cnt < varToParam.size();cnt++)
        {
          if(isdigit(varToParam[cnt])) LoadNum(7 + cnt,varToParam[cnt]);
          else{
            variable* var = &vars[synTable[varToParam[cnt]]];
            if(regInfo[7+cnt]._var != NULL)
              _SpillVar_(7+cnt,regInfo[7+cnt]._var);
            LoadVarTemp(7+cnt,var);
          }
        }
        varToParam.clear();
        cout<<"call "<<now.arg2<<endl;
        variable *res = &vars[synTable[now.arg1]],*rec1 = NULL;
        for(int reg = 0;reg < varOfCallerToRec.size();reg++)
        {
          _RecoverVar_(varOfCallerToRec[reg]);
        }
        varOfCallerToRec.clear();
        int reg = _GetReg_(res,rec1);
        RegToReg(reg,7);
        _RecoverVar_(rec1);
        break;
      }
      case iRETURN:
      {
        int reg;
        if(isdigit(now.arg1))
        {
          LoadNum(7,now.arg1);
        }
        else
        {
          variable* var = &vars[synTable[now.arg1]],*rec1 = NULL;
          reg = _GetReg_(var,rec1);
          RegToReg(7,reg);
        }
        for(int reg = 15;reg < 24;reg++)
        {
          cout<<"load "<<reg-15<<" "<<regName[reg]<<endl;
        }
        cout<<"return"<<endl;
        break;
      }
      case iLABEL:
      {
        cout<<now.arg1<<":"<<endl;
        break;
      }
    }
  }
}

/* macros to increase/decrease indentation */
#define INDENT indentno+=2
#define UNINDENT indentno-=2
