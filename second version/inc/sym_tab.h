#ifndef SYM_TAB_H 
#define SYM_TAB_H

#include "./bison_code.tab.h"
#include "../src/sym_tab.c"

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdbool.h>


typedef struct Symbole_Table_Node{
    char EntityName[11];
    char EntityCode[15];
    char EntityType[10];
    bool Constant;
    int LineNumber;
    STNP NextNode; 
}STN;

typedef struct STN_Pointer {
	STN* Node;
}STNP;

void Sym_Tab_Destroy();

int search(char entityName[]);

void insert(char entityName[], char entityCode[], char entityType[], bool constant);

void print_STN ();


#endif 
