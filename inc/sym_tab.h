
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdbool.h>

typedef struct Symbole_Table{
    char[11] EntityName;
    char[15] EntityCode;
    char[10] EntityType;
    bool Constant;
    int FirstLineOfDeclaration;
    int[30] LinesReferencedIn ;/* l'utilisation des listes chainées est plus optimale */
}ST;

ST st[100];

int stCounter = 0;

int search(char entity[])
{
int i=0;
while(i < stCounter)
{
if (strcmp(entity,st[i].EntityName)==0) return i;
i++;
}
return -1;
}


void insert(char entity[], char code[])
{
if ( recherche(entity)==-1)
{
strcpy(st[stCounter].EntityName,entity); 
strcpy(st[stCounter].EntityCode,code);
stCounter++;
}
}


void print_ST ()
{
printf("\n/***************Table des symboles ******************/\n");
printf("________________________\n");
printf("\t| NomEntite | CodeEntite \n");
printf("________________________\n");
int i=0;
 while(i < stCounter)
 {
 printf("\t|%10s |%12s |\n",st[i].EntityName,st[i].EntityCode,st[i].EntityType);
 i++;
 }
}


