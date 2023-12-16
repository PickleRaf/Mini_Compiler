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
        Q1->EntityType = NULL;
        
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

		newNode->EntityName = strdup(entityName); //error1
		newNode->EntityCode= strdup(entityCode);//error2
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

}

void insertEntityType(char* entityName, char* entityType)
{
	int lineNumber = search(entityName);
	
	if(lineNumber == -1){
		
		printf("error IDF doesn't exist  85 st\n");
	}
	else{
		STN* Q = List_head;
		while(Q != NULL )
		{
			if ( Q->LineNumber == lineNumber){
				Q->EntityType = strdup(entityType);
			}
			Q = Q->NextNode;
		}
	}
}

void isConst(char* entityName)
{
	int lineNumber = search(entityName);
	
	if(lineNumber == -1){
		
		printf("error IDF doesn't exist ! 105 st\n");
	}
	else{
		STN* Q = List_head;
		while(Q != NULL )
		{
			if ( Q->LineNumber == lineNumber){
				Q->Constant = true;
			}
			
			Q = Q->NextNode;
			
		}
	}
}

int doubleDeclaration(char* idf)
{
	STN* Q = List_head;
	while(Q != NULL )
	{
		if ( strcmp(Q->EntityName,idf)==0){/*strcmp(Q->EntityName,idf)==0*/
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

void varNotDec(){

	STN* Q = List_head;
	
	while(Q != NULL )
	{
		if ( Q->EntityType == NULL ){

			printf("semantic error : variable (%s) NOT Declared !\n", Q->EntityName);
			deleteEntity(Q->LineNumber);

		}
		
		Q = Q->NextNode;
		
	}

}

void deleteEntity(int lineNumber){

	STN* Q1 = List_head;
	STN* Q2 = List_head ->NextNode ;
	STN* Q3 = NULL ;
	STN* Q4 = NULL ;
	bool deleted = false ;
		
		if (lineNumber == 1)
		{
			List_head = Q2;
			
			free(Q1->EntityName);
      		Q1-> EntityName = NULL;
      
      		free(Q1->EntityCode);
       		Q1-> EntityCode = NULL;
        
      		free(Q1->EntityType);
        	Q1->EntityType = NULL;

			free(Q1);
			Q1 = NULL;
		}
		else if (List_tail->LineNumber == lineNumber)
			{
				while (deleted == false)
				{
					if (Q1->LineNumber == (lineNumber-1) )
					{
						List_tail = Q1;

						Q1 = Q1->NextNode;
						List_tail->NextNode = NULL;

						free(Q1->EntityName);
      					Q1-> EntityName = NULL;
      
      					free(Q1->EntityCode);
       					Q1-> EntityCode = NULL;
        
      					free(Q1->EntityType);
        				Q1->EntityType = NULL;


						free(Q1);
						Q1 = NULL;
						deleted = true;
					}	
					if (!deleted)
					{
						Q1= Q1->NextNode;				
						
					}
					
				}			
			}
			else{
		
				while(Q1 != NULL && deleted== false)
				{
					if ( Q1->LineNumber == lineNumber){
				
						free(Q1->EntityName);
  		 				Q1-> EntityName = NULL;
  
  		  				free(Q1->EntityCode);
   		 				Q1-> EntityCode = NULL;
        
  		  				free(Q1->EntityType);
    					Q1->EntityType = NULL;
    
    					Q4 = Q1 ;
						Q1 = Q2 ;
    					Q3->NextNode = Q2;
    		
						free(Q4);
						Q4 = NULL;
						deleted = true;
					}
		
					Q3 = Q1;
					Q1 = Q2;
					Q2 = Q2->NextNode;
				}

				Q1 = List_head;

				while (Q1 != NULL)
				{
					if (Q1->LineNumber > lineNumber)
					{
						Q1->LineNumber = Q1->LineNumber -1; 
					}
					
					Q1 = Q1->NextNode;
				}
				
			
			}	
			stnCounter = stnCounter -1;
}

void print_STN ()
{
printf("\n/*******************Symboles Table *************************/\n");
printf("________________________________________________________________________\n");
printf("\t|  EntityName | EntityCode  | EntityType | Constant | LineNumber(stab) |\n");
printf("________________________________________________________________________\n");

int i=0;
STN* Q = List_head;
 while(i < stnCounter)
 {
 	printf("\t|%12s |%12s |%11s |%11s | %d \n",
 		Q->EntityName, Q->EntityCode, Q->EntityType, Q->Constant?"true" : "false",
 		Q->LineNumber );
 	i++;
 	Q = Q->NextNode;
 }
}

int count_nl(char *comment, size_t comment_len)
{
    int counter = 0;

    for(int i = 0; i < comment_len; i++){
        if(comment[i] == '\n')
            counter++;
    }
    
    return counter;
}


