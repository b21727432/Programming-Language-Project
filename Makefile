parser: y.tab.c
	gcc -o parser y.tab.c
y.tab.c: project.y lex.yy.c
	yacc project.y
lex.yy.c: project.l
	lex project.l