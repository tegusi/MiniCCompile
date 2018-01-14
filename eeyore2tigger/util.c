/****************************************************/
/* File: util.c                                     */
/* Utility function implementation                  */
/* for the TINY compiler                            */
/* Compiler Construction: Principles and Practice   */
/* Kenneth C. Louden                                */
/****************************************************/

#include "global.h"
#include "util.h"
#include "gen.h"
/* Variable indentno is used by printTree to
 * store current number of spaces to indent
 */
static int indentno = 0;

//t0-t6:0-6
//s0-s11:7-18
//a0-a7:19-26
reg regInfo[MAXREGS];

bool isdigit(string a)
{
  return isdigit(a.c_str()[0]);
}

bool compare(variable a,variable b)
{
  return a.st == b.st ? (a.ed < b.ed) : a.st < b.st;
}
bool rollback(variable a,variable b)
{
  return a.id < b.id;
}
void liveAnalysis()
{
  queue<int> q;
  //   cout<<"Label Table:"<<endl;
  // for(auto i = lblTable.begin();i != lblTable.end();i++)
  // {
  //   cout<<i->first<<" "<<i->second<<endl;
  // }
  // cout<<endl;
  for(int i = 0;i < blocks.size();i++)
  {blocks[i].pre.clear();blocks[i].live.reset();}
  for(int i = blocks.size() - 1;i >= 0;i--)
  {
    if(blocks[i].type == iFBEGIN)
    continue;
    if(blocks[i].type == iGOTO)
    {
      blocks[lblTable[blocks[i].arg1]].pre.push_back(i);
    }
    else if(blocks[i].type == iIF)
    {
      blocks[lblTable[blocks[i].arg4]].pre.push_back(i);
    }
    // else if(blocks[i].type == iFEND)
    // {
    //   q.push(i);
    // }
    q.push(i);
    if(i-1>=0) blocks[i].pre.push_back(i-1);
  }
  while(!q.empty())
  {
    int t = q.front();q.pop();
    block* line = &blocks[t];
    bitset<MAXVARS> origin = line->live;
    if(line->type == iFBEGIN) continue;
    if(line->type == iGOTO)
    {
      line->live |= blocks[lblTable[line->arg1]].live;
    }
    else if(line->type == iIF)
    {
      line->live |= blocks[lblTable[line->arg4]].live | blocks[t+1].live;
    }
    else if(line->type != iFEND) {line->live |= blocks[t+1].live;}
    line->live &= (~(line->def));
    line->live |= line->use;
    if(origin != line->live)
      for(auto i = line->pre.begin();i != line->pre.end();i++)
      {
        q.push(*i);
      }
  }
  for(int i = blocks.size() - 1;i >= 0;i--)
  {
    blocks[i].gen[i] = 1;
    int var;
    for(int j = blocks.size() - 1;j >= 0;j--)
      if(blocks[i].def[j]) var = j;
    for(int j = blocks.size() - 1;j >= 0;j--)
    {
      if(blocks[j].use[var]) blocks[i].kill[j] = 1;
    }
    q.push(i);
  }
  while(!q.empty())
  {
    int t = q.front();q.pop();
    block* line = &blocks[t];
    bitset<MAXVARS> origin = line->out;
    for(auto i = line->pre.begin();i != line->pre.end();i++)
    {
      int j = *i;
      line->in |= blocks[j].out;
    }
    line->out = line->gen;
    line->out |= line->in & (~(line->kill));
    if(origin != line->out)
    {
      if(line->type == iFBEGIN) continue;
      if(line->type == iGOTO)
      {
        q.push(lblTable[line->arg1]);
      }
      else if(line->type == iIF)
      {
        q.push(lblTable[line->arg1]);
        q.push(t+1);
      }
      else if(line->type != iFEND) {q.push(t+1);}
    }
  }//得到in和out集合
  for(int i = blocks.size() - 1;i >= 0;i--)
  {
    blocks[i].gen[i] = 1;
    for(int var = 0;var < glb_cnt;var++)
    {
      if(blocks[i].use[var])
      {
        for(int j = blocks.size() - 1;j >= 0;j--)
        if(blocks[i].in[j] && blocks[j].def[var])
          blocks[i].ud_chain[j] = 1;
      }
    }
  }//得到ud_chain
  for(int var = 0;var < glb_cnt;var++)
  {vars[var].st = 63333;vars[var].ed = -1;}
  for(int i = 0;i < blocks.size();i++)
  {
    for(int var = 0;var < glb_cnt;var++)
    {
      if(blocks[i].def[var] == 1)
        vars[var].st = min(vars[var].st,i);
      if(blocks[i].live[var] == 1)
      {
        vars[var].st = min(vars[var].st,i);
        vars[var].ed = max(vars[var].ed,i);
      }
    }
  }
  // for(int var = 0;var < glb_cnt;var++)
  // {
  //   cout<<vars[var].name<<" "<<vars[var].st<<" "<<vars[var].ed<<endl;
  // }
}


void assign(int reg,variable* var)
{
  regInfo[reg].vars = var;
  regInfo[reg].live = 1;
  var->reg = reg;
  var->active = 1;
  var->pos = REG;
}
#define AVLREGS 6
int getFreeReg()
{
  for(int reg = 1;reg < MAXREGS;reg++)
  {
    if(regInfo[reg].live == 0) return reg;
  }
  return -1;
}
void expireVars(int endTime,int startVar)
{
  for(int var = 0; var < startVar; var++)
  {
    if(regInfo[vars[var].reg].live && vars[var].ed < endTime && vars[var].active )
    {
      regInfo[vars[var].reg].live = 0;
      vars[var].active = 0;
    }
  }
}
void spillVar(variable* var)
{
  int maxed = -1;
  variable *maxvar;
  for(int reg = 1;reg < MAXREGS; reg++)
  {
    if(regInfo[reg].vars->ed > maxed)
    {
      maxed = regInfo[reg].vars->ed;
      maxvar = regInfo[reg].vars;
    }
  }
  assign(maxvar->reg,var);
  maxvar->pos = MEM;
  maxvar->active = 0;
}
void linear_scan() {
  sort(vars,vars+glb_cnt,compare);
  int reg_tmp;
  for(int var = 0;var < glb_cnt;var++)
  {
    if(vars[var].ed == -1) assign(0,&vars[var]);
    else
    {
      expireVars(vars[var].st,var);
      reg_tmp = getFreeReg();
      if(reg_tmp != -1) assign(reg_tmp,&vars[var]);
      else spillVar(&vars[var]);
    }
  }
}

void optimize()
{
  auto ptr = blocks.begin();
  while(ptr != blocks.end())//窥孔优化
  {
    if((ptr->type == iOP1 || ptr->type == iCALL)
      && (ptr+1)->type == iASS
      && (ptr)->arg1 == (ptr+1)->arg2
      && vars[synTable[(ptr)->arg1]].ed - vars[synTable[(ptr)->arg1]].st == 1)
    {(ptr)->arg1 = (ptr+1)->arg1;
      ptr->def = (ptr+1)->def;
    ptr = blocks.erase(ptr+1);}
    else ptr++;
  }
  for(int i = 0;i < blocks.size();i++)//复写传播
  {
    if(blocks[i].type == iASS)
    {
      string lval = blocks[i].arg1;
      for(int j = i + 1; blocks[j].arg1 != lval && j < blocks.size();j++)
      {
        if(blocks[j].type == iASS && blocks[j].arg2 == lval)
        {
          blocks[j].arg2 = blocks[i].arg2;
          blocks[j].use = blocks[i].use;
        }
      }
    }
  }
  ptr = blocks.begin();
  while(ptr != blocks.end())//无用代码消除
  {
    if(ptr->type == iGOTO)
    {
      ptr++;
      while(ptr->type != iLABEL)
      ptr = blocks.erase(ptr);
    }
    ptr++;
  }
  for(int i = 0;i < blocks.size();i++)//if优化
  {
    if(blocks[i].type == iIF && blocks[i-1].type == iOP1 && blocks[i-1].arg3 != "&&" && blocks[i-1].arg3 != "||")
    {
      blocks[i].arg1 = blocks[i-1].arg2;
      blocks[i].arg2 = blocks[i-1].arg3;
      blocks[i].arg3 = blocks[i-1].arg4;
      if(blocks[i].arg2 == ">")
        blocks[i].arg2 = "<=";
      else if(blocks[i].arg2 == "<")
        blocks[i].arg2 = ">=";
      else if(blocks[i].arg2 == "<=")
        blocks[i].arg2 = ">";
      else if(blocks[i].arg2 == ">=")
        blocks[i].arg2 = "<";
      else if(blocks[i].arg2 == "!=")
        blocks[i].arg2 = "==";
      else if(blocks[i].arg2 == "==")
        blocks[i].arg2 = "!=";
      blocks[i].use = blocks[i-1].use;
    }
  }
  for(int i = 0;i < blocks.size();i++)
  {
    if(blocks[i].type == iLABEL)
    {
      lblTable[blocks[i].arg1] = i;
    }
  }
  liveAnalysis();
  ptr = blocks.begin();
  while(ptr != blocks.end())//无用代码消除
  {
    if(synTable.find(ptr->arg1) == synTable.end()) {ptr++;continue;}
    if(vars[synTable[ptr->arg1]].ed == -1 && ptr->type != iCALL)
    {
      ptr = blocks.erase(ptr);
    }
    else
      ptr++;
  }
  for(int i = 0;i < blocks.size();i++)
  {
    int end = -1;
    if(blocks[i].type == iLABEL)
    {
      for(int j = i + 1;j < blocks.size();j++)
      {
        if(blocks[j].type == iGOTO && blocks[j].arg1 == blocks[i].arg1)
        {
          end = j;
          break;
        }
      }
    }//找出循环块
    if(end == -1)
    continue;
    for(int j = i;j < end;j++)
    {
      int flag = 0;
      for(int k = i;k < end;k++)
      {
        if(blocks[j].ud_chain[k]) flag = 1;
      }
      if(flag == 0)
      {
        block tmp = blocks[j];
        blocks.erase(blocks.begin() + j);
        blocks.insert(blocks.begin() + i,tmp);
      }
    }//不变量外提
  }
  for(int i = 0;i < blocks.size();i++)
  {
    if(blocks[i].type == iLABEL)
    {
      lblTable[blocks[i].arg1] = i;
    }
  }
}
void printCode()
{
  // for(int i = 0;i < blocks.size();i++)
  // {
  //   cout<<blocks[i].type<<" "<<blocks[i].arg1<<" "<<blocks[i].arg2<<" ";
  //   cout<<blocks[i].arg3<<" "<<blocks[i].arg4<<endl;
  // }
  liveAnalysis();
  optimize();
  liveAnalysis();
  linear_scan();
  sort(vars,vars+glb_cnt,rollback);
  // for(int var = 0;var < glb_cnt;var++)
  // {
  //   cout<<vars[var].name<<" "<<vars[var].reg<<" "<<vars[var].mem<<endl;
  // }
  gen();
}
/* macros to increase/decrease indentation */
#define INDENT indentno+=2
#define UNINDENT indentno-=2
