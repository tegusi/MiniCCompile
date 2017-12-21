all: eeyore2tigger

eeyore2tigger: lex.yy.c y.tab.c util.c gen.c global.h
	g++ --std=c++11 -Wno-deprecated-register -o eeyore2tigger lex.yy.c y.tab.c util.c gen.c
lex.yy.c: eeyore.l
	flex eeyore.l
y.tab.c y.tab.h: eeyore.y
	bison -y -d eeyore.y
clean:
	-rm eeyore2tigger y.tab.c y.tab.h lex.yy.c
