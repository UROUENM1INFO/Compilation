
%{
    struct _list {
        char* word; /* le mot contenu dans la cellule */
        struct _list *next; /* maillon suivant */
    };

    typedef struct _list *List;

    struct _type {
        char* type; /* le type */
        List list; /* les mots associés à ce type */
        List lastList; /* le dernier mot associé à la liste */
        struct _type *next; /*maillon suivant */
    };

    typedef struct _type *Type;
    List createList();
    Type createType();
    void addType(char* c);
    void addWord(char* c);
    char* searchTable(char* c);

    Type typeList; /* le premier maillon */
    Type lastType; /* le dernier maillon */
    Type lastEntry; /* le dernier type entré */
%}

ID [a-zA-Z][a-z]*

%%

^("nom"|"pronom"|"verbe"|"adj") addType(yytext);
^{ID} { 
        lastEntry = NULL;
        char* s = searchTable(yytext);
        s = (s == NULL) ? "Non reconnu" : s;
        printf("%s : %s\n", yytext, s);
      }
{ID} {
        if (lastEntry != NULL) {
            addWord(yytext);
        } else {
            char* s = searchTable(yytext);
            s = (s == NULL) ? "Non reconnu" : s;
            printf("%s : %s\n", yytext, s);
        }
      }
%%



Type createType(char* s) {
    Type t = (Type) malloc(sizeof(Type));
    t->type = malloc(strlen(s) * sizeof(char));
    strcpy(t->type, s);
    t->list = NULL;
    t->next = NULL;
    t->lastList = NULL;
    return t;
}

List createList(char* s) {
    List l = (List) malloc(sizeof(List));
    l->word = malloc(strlen(s) * sizeof(char));
    strcpy(l->word, s);
    l->next = NULL;
    return l;
}

Type searchType(char* c) {
    if (typeList == NULL) {
        return NULL;
    }
    Type t = typeList;
    while (t != NULL) {
        if (strcmp(t->type, c) == 0) {
            return t;
        }
        t = t->next;
    }
    return NULL;
}

List searchWord(List l, char* c) {
    if (l == NULL) {
        return l;
    }
    while (l != NULL) {
        if (strcmp(l->word, c) == 0) {
            return l;
        }
        l = l->next;
    }
    return NULL;
}

void addType(char* c) {
    if (typeList == NULL) {
        Type t = createType(c);
        typeList = t;
        lastType = t;
        lastEntry = t;
    } else {
        Type t;
        if ((t = searchType(c)) == NULL) {
            t = createType(c);
            lastType->next = t;
            lastType = t; 
            lastEntry = t;   
        } else {
            lastEntry = t;
        }
    }
}

void addWord(char* c) {
    if(lastEntry->lastList == NULL) {
        List l = createList(c);
        lastEntry->list = l;
        lastEntry->lastList = l;
    } else {
        if(searchWord(lastEntry->list, c) == NULL) {
            List l = createList(c);
            lastEntry->lastList->next = l;
            lastEntry->lastList = l;
        }
    }
}

char* searchTable(char* c) {
    char* str = NULL;
    Type t = typeList;

    while (str == NULL && t != NULL) {
        if(searchWord(t->list, c) != NULL) {
            str = t->type;
        }
        t = t->next;
    }

    return str;
}

int main(int arg, char **argv) {
    typeList = NULL;
    lastType = NULL;
    lastEntry = NULL;

    yyin = stdin;
    yylex();


    return EXIT_SUCCESS;
}