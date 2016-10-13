/* analyseur lexical evolutif */
%{
/* notre bibliothèque gérant les listes */
#include <stdio.h>
#include "list.h"
%}

WORD [a-z]*

%%

^{WORD} { /* Premier mot de la phrase */
			list_add(l, yytext);
			printf("%s ajouté\n", yytext);
		}

%%

int main(int argc, char **argv) {
	list *l = list_new();
	yyin = stdin;
	list_free(&l);
}