%{		/*C declarations*/
#include "../inc/bison_code.tab.h"
#include "../inc/sym_tab.h" 
#include <stdio.h> 
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>
extern int line_counter;
extern char[] Current_type;
extern char[] Current_const_valtype;
void yyerror();
int yylex();

%}

		/* Yacc definitions*/
%union{int integer;
	float floatV;
	bool boolV;
	char[2] specialChar;
	char[11] string;
	
}

%start 	Prog
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
Prog: 
	Declarations_Liste /*Instructions_Liste */{
		
		printf("This code is correct");
		YYACCEPT;
	}
;

		/*handling declarations*/
Declarations_Liste:
	%empty 
	|ConstDeclaration Declarations_Liste
	|VarDeclaration Declarations_Liste
	|VarInit Declarations_Liste
;

ConstDeclaration :
	KW_Const Type IDF SC_ASSIGN Const ';'{
		if(search($3) == -1){
			switch (Current_type){
				case "int" :
					if(Current_const_valtype =="int"){
						insert($3,"idf", Current_type, true);
					}else{
						print("incompatible type!");
					}	
				break;
				
				case "float" : 
					if(Current_const_valtype =="float"){
						insert($3,"idf", Current_type, true);
					}else{
						print("incompatible type!");
					}
				break;
				
				case"boolean": 
					if(Current_const_valtype =="boolean"){
						insert($3,"idf", Current_type, true);
					}else{
						print("incompatible type!");
					}
				break;
			}
		}	
		else{
			printf("idf already declared in ");
		}	
	}	
;

Const:
	INT{ 
		Current_const_valtype = "int";
	}
	|FLOAT{
		Current_const_valtype = "float"
	}
	|BOOL{
		Current_const_valtype = "boolean"
	}
;

VarInit:
	Type  G_IDF SC_ASSIGN Const ';' {
			switch (Current_type){
				case "int" :
					if(Current_const_valtype !="int"){
						print("incompatible type!");
					}	
				break;
				
				case "float" : 
					if(Current_const_valtype =="boolean"){
						print("incompatible type!");
					}
				break;
				
				case"boolean": 
					if(Current_const_valtype !="boolean"){
						print("incompatible type!");
					}
				break;
			}	
	}
;

VarDeclaration :
	Type G_IDF ; 
		
	
; 

G_IDF:
	G_IDF ',' IDF{ 
		if(search($3)!=-1){
			printf("idf already declared !");
		}
		else{
			insert($3,"idf", Current_type, false);	
		}
	}
	|IDF { 
		if(search($1)!=-1){
			printf("idf already declared !");
		}
		else{
			insert($1,"idf", Current_type, false);	
		}
	}

;

Type:
	KW_int{ 
		Current_type = "int";
	}
	|KW_float{ 
		Current_type = "float";
	}
	|KW_boolean{ 
		Current_type = "boolean";
	}
;
/*
Instructions_Liste:
	KW_BEGIN stmt KW_END
;


Assignment:
   	 G_IDF SC_ASSIGN expr ';'{
   	 	}
   	 
;
   
stmt:
	KW_If '(' expr')' stmt
	|KW_While '(' expr')' stmt
	|expr
	|';'
;

expr:
	Const
	|IDF
	|'(' expr ')'
	|expr'(' expr')'
	|expr '+' expr
	|expr '-' expr	%prec '+'
	|expr SC_EQUALS expr
	|expr SC_DIFF expr
	|'*' expr
	|'/' expr
	|'%' expr
;
*/
%%

		/*C code*/
		

