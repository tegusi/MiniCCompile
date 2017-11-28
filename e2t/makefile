all: a.out

a.out: lex.yy.c y.tab.c util.c gen.c
	g++ --std=c++11 -o a.out lex.yy.c y.tab.c util.c gen.c
lex.yy.c: Eeyore.l
	flex Eeyore.l
y.tab.c y.tab.h: Eeyore.y
	yacc -d Eeyore.y
clean:
	rm a.out y.tab.c y.tab.h lex.yy.c
