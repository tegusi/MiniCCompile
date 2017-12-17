all: minic2eeyore

minic2eeyore: lex.yy.c y.tab.c util.c
	g++ --std=c++11 -Wno-deprecated-register -o minic2eeyore lex.yy.c y.tab.c util.c
lex.yy.c: minic.lex
	flex minic.lex
y.tab.c y.tab.h: minic.y
	bison -y -d minic.y
clean:
	-rm y.tab.c y.tab.h lex.yy.c minic2eeyore
