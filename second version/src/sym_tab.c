#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdbool.h>
#include "../inc/sym_tab.h"

int stnCounter = 0;
char* Current_type=NULL;
char* Current_const_valtype;
STN* List_head = NULL;
STN* List_tail = NULL;

void Sym_Tab_Destroy(){
    STN* Q1 = List_head;
    STN* Q2 = NULL;
    while(Q1 != NULL){
        free(Q1->EntityName);
        Q1-> EntityName = NULL;
      
        free(Q1->EntityCode);
        Q1-> EntityCode = NULL;
        
        free(Q1->EntityType);
        Q1->EntityCode = NULL;
        
        Q2 = Q1 ;
        Q1= Q1->NextNode;
        free(Q2);
    }
    List_head = NULL;
    List_tail = NULL;
}

int search(char* entityName)
{
STN* Q = List_head;
while(Q != NULL )
{
if (strcmp(entityName,Q->EntityName)==0) return Q->LineNumber;
Q = Q->NextNode;
}
return -1;
}

void insert(char* entityName, char* entityCode/*, char* entityType, bool constant*/)
{
	if ( search(entityName)==-1)
	{

		STN* newNode = (STN*)malloc(sizeof(STN));

		if(newNode == NULL ) {
			printf("memory allocation failed!\n");
		}

		newNode->EntityName = entityName; 
		newNode->EntityCode= entityCode;
		newNode->EntityType = NULL;
		newNode->Constant = false;
		stnCounter++;
		newNode->LineNumber = stnCounter;
       
		if(List_head == NULL){
			newNode->NextNode = NULL;
        		List_head = List_tail = newNode;
		}
		else{
			List_tail->NextNode = newNode;
			newNode->NextNode = NULL;
			List_tail = newNode;
		}
	}
	else{
		printf("idf already exists !\n");
	}
}

void insertEntityType(char* entityName, char* entityType)
{
	int lineNumber = search(entityName);
	
	if(lineNumber == -1){
		
		printf("error IDF doesn't exist\n");
	}
	else{
		STN* Q = List_head;
		while(Q != NULL )
		{
			if ( Q->LineNumber == lineNumber){
				Q->EntityType = entityType;
			}
			else{
				Q = Q->NextNode;
			}
		}
	}
}

void isConst(char* entityName)
{
	int lineNumber = search(entityName);
	
	if(lineNumber == -1){
		
		printf("error IDF doesn't exist\n");
	}
	else{
		STN* Q = List_head;
		while(Q != NULL )
		{
			if ( Q->LineNumber == lineNumber){
				Q->Constant = true;
			}
			else{
				Q = Q->NextNode;
			}
		}
	}
}

int doubleDeclaration(char* idf)
{
	STN* Q = List_head;
	while(Q != NULL )
	{
		if ( Q->EntityName == idf){
			if(Q->EntityType != NULL){
				return 1;
			}
			else{
				return 0;
			}
		}
		else{
			Q = Q->NextNode;
		}
	}
	
	return -1;

}

void print_STN ()
{
printf("\n/*******************Symboles Table *************************/\n");
printf("__________________________________________________________________\n");
printf("\t| EntityName | EntityCode | EntityType | Constant | LineNumber(symtab) |\n");
printf("__________________________________________________________________\n");

int i=0;
STN* Q = List_head;
 while(i < stnCounter)
 {
 	printf("\t|%12s |%15s |%10s |%5s | %d \n",
 		Q->EntityName, Q->EntityCode, Q->EntityType, Q->Constant?"true" : "false",
 		Q->LineNumber );
 	i++;
 	Q = Q->NextNode;
 }
}

int count_nl(char *comment, size_t comment_len)
{
    int counter = 1;

    for(int i = 0; i < comment_len; i++){
        if(comment[i] == '\n')
            counter++;
    }
    
    return counter;
}


