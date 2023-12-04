%{		/*C declarations*/
#include <stdio.h> 
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>
#include "../inc/bison_code.tab.h"
#include "../inc/sym_tab.h" 

extern int line_counter;
extern bool isAssignment;
extern bool isDeclaration;
extern char* Current_type;
extern char* Current_const_valtype;
void yyerror();
int yylex();

%}

		/* Yacc definitions*/
%union{int integer;
	float floatV;
	char* boolV;
	char* specialChar;
	char* string;
	
}

%start 	Programme

%token	INT FLOAT BOOL IDF 
%token	SC_ASSIGN SC_EQUALS SC_DIFF SC_LOE SC_GOE  SC_INCR SC_DECR
%token	KW_int KW_float KW_boolean KW_For KW_If KW_Else KW_BEGIN KW_END KW_Return KW_Const KW_Void KW_Pc KW_Fc KW_Function KW_While

%type <specialChar>	SC_ASSIGN
%type <specialChar>	SC_EQUALS
%type <specialChar>	SC_DIFF
%type <specialChar>	SC_LOE
%type <specialChar>	SC_GOE
%type <string> 		KW_BEGIN
%type <string> 		KW_END
%type <string> 		KW_int
%type <string> 		KW_float
%type <string> 		KW_boolean
%type <string> 		KW_For
%type <string> 		KW_If
%type <string> 		KW_Else
%type <string> 		IDF
%type <integer>		INT
%type <floatV>		FLOAT
%type <boolV>		BOOL

%left ','
%left SC_EQUALS SC_DIFF 
%left '+' '-'
%left '*' '/' '%'
%left '('

%%
		/*grammar*/

Programme: 
	Declarations_List Instructions_List{
		
		printf("This code is correct");
		YYACCEPT;
	}
;

		/*handling declarations*/
Declarations_List:
	%empty 
	|ConstDeclaration Declarations_List {printf("went through the consdec ");}
	|VarDeclaration Declarations_List
	|VarInit Declarations_List	
;

ConstDeclaration :
	KW_Const Type IDF SC_ASSIGN Const ';'{

		if(search($3) == -1){
			if(strcmp(Current_const_valtype,Current_type)==0){
				insert($3,"idf", Current_type, true);
			}
			else{
				printf("incompatible type!");
			}
		}	
		else{
			printf("idf already declared in ");
		}		
	}
;

Const:
	INT{ 
		strcpy(Current_const_valtype,"int");
	}
	|FLOAT{
		strcpy(Current_const_valtype,"float");
	}
	|BOOL{
		strcpy(Current_const_valtype,"boolean");
	}
;

VarInit:
	Type  G_IDF SC_ASSIGN Const ';' {
	
		if(strcmp(Current_const_valtype,Current_type)!=0){
				printf("incompatible type!");
		}
	}				
;

VarDeclaration :
	Type G_IDF ';'			
; 

G_IDF:
	G_IDF ',' IDF{ 
		if(isDeclaration && !isAssignment){
			if(search($3)!=-1){
				printf("idf already declared !");
			}
			else{
			insert($3,"idf", Current_type, false);	
			}
		}else if(!isDeclaration && isAssignment){
			if(search($3)==-1){
				printf("idf NOT DECLARED !");
			}
		}
	}
	|IDF { 
		if(isDeclaration && !isAssignment){
			if(search($1)!=-1){
				printf("idf already declared !");
			}
			else{
				insert($1,"idf", Current_type, false);	
			}
		}else if(!isDeclaration && isAssignment){
			if(search($1)==-1){
				printf("idf NOT DECLARED !");
			}
		}
	}
	
	
;

Type:
	KW_int{ 
		strcpy(Current_type,"int");
	}
	|KW_float{ 
		strcpy(Current_type,"float");
	}
	|KW_boolean{ 
		strcpy(Current_type,"boolean");
	}
;

Instructions_List:
	%empty
	|KW_BEGIN stmt KW_END  {
			isDeclaration = true ;
			isAssignment = false ;
	}
;


Assignment:
   	 G_IDF SC_ASSIGN exprA ';'{
   	 	}
   	 
;
   
stmt:
	%empty
	|If_instruction stmt
	|IfElse_instruction stmt
	|While_insruction stmt
	|exprA stmt 
	|Assignment stmt
;

exprA:
	INT
	|FLOAT
	|IDF {
		if(search($1)==-1){
			printf("idf NOT DECLARED !");
		}
	}
	|'(' exprA ')'
	|exprA '+' exprA
	|exprA '-' exprA	%prec '+'
	|exprA '*' exprA
	|exprA '/' exprA
	|exprA '%' exprA
	
;

If_instruction :
	KW_If '(' exprA')' '{' stmt  '}'
;

IfElse_instruction :
	If_instruction KW_Else '{' stmt '}'
;

While_insruction :
		KW_While '(' exprA')' '{' stmt '}'
;

%%

		/*C code*/
		void yyerror(char const *s){
			fprintf(stderr,"%s\n", s);
		}

