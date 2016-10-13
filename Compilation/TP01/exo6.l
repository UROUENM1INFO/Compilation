/* analyseur lexical evolutif */
%{
/* notre bibliothèque gérant les listes */
#include "liste.h"
%}

WORD [a-z]*

%%

^{WORD} { /* Premier mot de la phrase */
			list_add(l, yytext);
			printf("%s ajouté\n", yytext);
		}

%%

main(int argc, char **argv) {
	--argc, ++argv; /* suppression des erreurs */
	list *l = list_new();
	yyin = stdin;
	list_free(&l);
}