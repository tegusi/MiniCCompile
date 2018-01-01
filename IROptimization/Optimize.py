import re
code = []

def read():
    with open("../tmp.e",'r') as f:
        for line in f.readlines():
            code.append(line[:-1])

blocks = []
def parse():
    tmpBlock = [];
    for line in code:
        tmpBlock.append(line)
        if ("f_" not in line or 'call' in line) and ("goto" not in line) and not re.match("""l\d+:""",line):
            continue
        else:
            blocks.append(tmpBlock)
            optimize(tmpBlock)
            tmpBlock = []

def optimize(block):
    assert isinstance(block,list)
    for idx,line in enumerate(block):
        if 'if' in line:
            elements = line.split(' ')
            lvar = elements[1]
            for line2 in block:
                elements2 = line2.split(' ')
                if elements2[0] == lvar:
                    elements[1] = ' '.join(elements2[-3:])
            line = ' '.join(elements[:2] + elements[-2:])
            block[idx] = line
        elif '=' in line and not '==' in line:
            lvar = line.split('=')[0].strip(' ')
            for idx2, line2 in enumerate(block[idx+1:]):
                if not len(line2.split('=')) == 2:
                    continue
                rvar = line2.split('=')[1].strip(' ')
                if rvar == lvar:
                    break
                line2.replace(rvar, lvar)
                block[idx2] = line2.replace(rvar,lvar)

    print(block)
        # block.remove(line)
if __name__=="__main__":
    read()
    parse()
    # print(code)