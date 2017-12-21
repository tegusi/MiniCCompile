all: tigger2riscv

tigger2riscv: lex.yy.c y.tab.c
	g++ --std=c++11 -Wno-deprecated-register -o tigger2riscv lex.yy.c y.tab.c
lex.yy.c: tigger.l
	flex tigger.l
y.tab.c y.tab.h: tigger.y
	bison -y -d tigger.y
clean:
	-rm tigger2riscv y.tab.c y.tab.h lex.yy.c
