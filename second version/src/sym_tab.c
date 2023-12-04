#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdbool.h>
#include "../inc/sym_tab.h"

int stnCounter = 0;
char* Current_type;
bool isAssignment = true;
bool isDeclaration = false;
char* Current_const_valtype;
STN* List_head = NULL;
STN* List_tail = NULL;

void Sym_Tab_Destroy(){
    STN* Q1 = List_head;
    STN* Q2 = NULL;
    while(Q1 != NULL){
        free(Q1-> EntityName);
        Q1-> EntityName = NULL;
      
        free(Q1-> EntityCode);
        Q1-> EntityCode = NULL;
        
        free(Q1-> EntityType);
        Q1-> EntityCode = NULL;
        
        Q2 = Q1 ;
        Q1= Q1-> NextNode;
        free(Q2);
    }
    List_head = NULL;
    List_tail = NULL;
}

int search(char entityName[])
{
STN* Q = List_head;
while(Q != NULL )
{
if (strcmp(entityName,Q->EntityName)==0) return Q->LineNumber;
Q = Q->NextNode;
}
return -1;
}

void insert(char entityName[], char entityCode[], char entityType[], bool constant)
{
	if ( search(entityName)==-1)
	{

		STN* newNode = (STN*)malloc(sizeof(STN));

		if(newNode == NULL ) {
			printf("memory allocation failed!");
		}

		strcpy(newNode->EntityName,entityName); 
		strcpy(newNode->EntityCode,entityCode);
		strcpy(newNode->EntityType,entityType);
		newNode->Constant = constant;
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
		printf("idf already exists !");
	}
}

void print_STN ()
{
printf("\n/***************Table des symboles ******************/\n");
printf("__________________________________________________________________\n");
printf("\t| EntityName | EntityCode | EntityType | Constant | LineNumber |\n");
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


