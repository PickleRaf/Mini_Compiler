#ifndef SYM_TAB_H 
#define SYM_TAB_H

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdbool.h>


typedef struct Symbole_Table_Node{
    char *EntityName;
    char *EntityCode;
    char *EntityType;
    bool Constant;
    int LineNumber;
    struct Symbole_Table_Node* NextNode; 
}STN;

void varNotDec();

void deleteEntity();

void Sym_Tab_Destroy();

int search(char* entityName);

int doubleDeclaration(char* idf);

void insert(char* entityName, char* entityCode);

void insertEntityType(char* entityName, char* entityType);

void isConst(char* entityName);

void print_STN ();

int count_nl(char *comment, size_t comment_len);


#endif 
