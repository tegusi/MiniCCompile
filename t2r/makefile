all: a.out

a.out: lex.yy.c y.tab.c #util.c gen.c
	g++ --std=c++11 -Wno-deprecated-register -o a.out lex.yy.c y.tab.c #util.c gen.c
lex.yy.c: tigger.l
	flex tigger.l
y.tab.c y.tab.h: tigger.y
	yacc -d tigger.y
clean:
	rm a.out y.tab.c y.tab.h lex.yy.c
