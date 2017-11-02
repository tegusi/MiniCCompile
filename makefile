all: a.out

a.out: lex.yy.c y.tab.c util.c
	g++ --std=c++11 -o a.out lex.yy.c y.tab.c util.c
lex.yy.c: hw.lex
	flex hw.lex
y.tab.c y.tab.h: hw.y
	yacc -d hw.y
clean:
	rm a.out y.tab.c y.tab.h lex.yy.c
