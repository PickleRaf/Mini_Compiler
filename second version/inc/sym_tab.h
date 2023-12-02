#ifndef SYM_TABLE_H 
#define SYM_TABLE_H

#include "./bison_code.tab.h"
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdbool.h>

typedef struct STN_Pointer {
	ST* Node;
}STNP;

typedef struct Symbole_Table_Node{
    char[11] EntityName;
    char[15] EntityCode;
    char[10] EntityType;
    bool Constant;
    int LineNumber;
    STNP NextNode; 
}STN;


void Sym_Tab_Destroy();

int search(char entityName[]);

void insert(char entityName[], char entityCode[], char entityType[], bool constant);

void print_STN ();


#endif 
