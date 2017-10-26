all: frontend

frontend: lex.yy.c y.tab.c util.c
	g++ -o frontend lex.yy.c y.tab.c util.c
lex.yy.c: hw.lex
	flex hw.lex
y.tab.c y.tab.h: hw.y
	yacc -d hw.y
clean:
	rm frontend y.tab.c y.tab.h lex.yy.c
