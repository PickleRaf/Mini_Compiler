#include "../inc/sym_tab.h"

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdbool.h>
char[] Current_type;
char[] Current_const_valtype;
STNP List_head = NULL;
STNP List_tail = NULL;
int stnCounter = 0;

void Sym_Tab_Destroy(){
    STNP Q1 = List_head;
    STNP Q2 = NULL;
    while(Q != NULL){
        free(Q1->m_EntityName);
        Q1->m_EntityName = NULL;
        free(Q1->m_EntityCode);
        Q1->m_EntityCode = NULL;
        free(Q-1>m_EntityType);
        Q1->m_EntityCode = NULL;
        Q2 = Q ;
        Q= Q->NextNode;
        free(Q2);
    }
    List_head = NULL;
    List_tail = NULL;
}

int search(char entityName[])
{
STNP Q = List_head;
while(Q != NULL )
{
if (strcmp(entityName,Q->EntityName)==0) return Q->LineNumber;
Q = Q->NextNode;
}
return -1;
}

void insert(char entityName[], char entityCode[], char entityType[], bool constant)
{
	if ( search(entity)==-1)
	{

		STN* newNode = (STN*)malloc(sizeof(STN));

		if(newNode == NULL ) {printf("memory allocation failed!");}

		strcpy(newNode->EntityName,entityName); 
		strcpy(newNode->EntityCode,entityCode);
		strcpy(newNode->EntityType,entityType);
		newNode->Constant = constant;
		stnCounter++;
		newNode->LineNumber = stnCounter;
       
		if(Sym_head == NULL){
			newNode->NextNode = NULL;
        		List_head = List_tail = newNode;
		}
		else{
			List_tail->NextNode = newNode;
			newNode->NextNode = NULL;
			List_tail = newNode;
		}
	}
	else{ printf
}

void print_STN ()
{
printf("\n/***************Table des symboles ******************/\n");
printf("__________________________________________________________________\n");
printf("\t| EntityName | EntityCode | EntityType | Constant | LineNumber |\n");
printf("__________________________________________________________________\n");

int i=0;
STNP Q = List_head;
 while(i < stnCounter)
 {
 	printf("\t|%12s |%15s |%10s |%5s | %3s \n",
 	Q->EntityName,Q->EntityCode,Q->EntityType,Q->Constant?"true"|"false",
 	Q->LineNumber );
 	i++;
 	Q = Q->NextNode;
 }
}


