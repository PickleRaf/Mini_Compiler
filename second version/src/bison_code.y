%{		/*C declarations*/
#include <stdio.h> 
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>
#include "../inc/bison_code.tab.h"
#include "../inc/sym_tab.h" 

extern int line_counter;
extern char* Current_type;
extern char* Current_const_valtype;
void yyerror();
int yylex();

%}

		/* Yacc definitions*/
%union{
	int   boolV;
	int   integerV;
	float floatV;
	char* string;
	char* specialChar;
	
}

%start 	Programme

%token	INT FLOAT BOOL IDF 
%token	SC_ASSIGN SC_EQUALS SC_DIFF SC_LOE SC_GOE SC_AND SC_OR SC_INCR SC_DECR
%token	KW_int KW_float KW_boolean KW_While KW_If KW_Else KW_BEGIN KW_END KW_Void KW_Function
%token  KW_false KW_true KW_Return KW_Const

%type <string> 		IDF
%type <integer>		INT
%type <floatV>		FLOAT
%type <boolV>		BOOL
%type <string> 		KW_Const

%type <string>		G_IDF
%type <string>		Const
%type <string> 		Type


%left ','
%left SC_OR
%left SC_AND
%left SC_EQUALS SC_DIFF 
%left SC_LOE SC_GOE  '<' '>'
%left '+' '-'
%left '*' '/' '%'
%left '!'
%left '('

%%
		/*grammar*/

Programme: 
	
	Declarations_List Instructions_List{
		
		varNotDec();
		printf("This code is correct\n");
		YYACCEPT;
	}
;

		/*handling declarations*/
Declarations_List:
	%empty 
	|ConstDeclaration Declarations_List 
	|VarDeclaration Declarations_List
	|VarInit Declarations_List	
;

ConstDeclaration :
	KW_Const  Type G_IDF SC_ASSIGN Const ';'{
		isConst($3);
		if(strcmp($2,$5)!=0){
			printf("semantic error: incompatible type for %s, expected (%s) affected (%s) line %d\n",$3,$2,$5,line_counter);
		}
	}
;

Const:
	INT{ 	
		$$ ="int";

	}
	|FLOAT{
		$$="float";

	}
	|KW_false{	
		$$="boolean";

	}
	|KW_true{	
		$$="boolean";

	}
;

VarInit:
	Type  G_IDF SC_ASSIGN Const ';' {
		
		if(strcmp($1,$4)!=0){
			printf("semantic error: incompatible type for %s, expected (%s) affected (%s) line %d\n",$2,$1,$4,line_counter);
		}
	}				
;

VarDeclaration :
	Type G_IDF ';'			
; 

G_IDF:
	G_IDF ',' IDF{ 
		
		if(doubleDeclaration($3)==0){
			insertEntityType($3,Current_type );
		}
		else{
			printf("semantic error: double declaration of %s, in line %d\n",$3,line_counter);
		}	

	}
	|IDF { 	
		
		if(doubleDeclaration($1)==0){
			insertEntityType($1,Current_type );
		}
		else{
			printf("semantic error: double declaration of %s, in line %d\n",$1,line_counter);
		}
	}	

	
	
;

Type:
	KW_int{ 
		$$ ="int";
		if(Current_type!=NULL){
			free(Current_type);
			Current_type=NULL;
		}
		Current_type=strdup("int");

	}
	|KW_float{ 
		$$ ="float";
		if(Current_type!=NULL){
			free(Current_type);
			Current_type=NULL;
		}
		Current_type=strdup("float");
	}
	|KW_boolean{ 
		$$ ="boolean";
		if(Current_type!=NULL){
			free(Current_type);
			Current_type=NULL;
		}
		Current_type=strdup("boolean");
	}
;

Instructions_List:
	
	KW_BEGIN stmt KW_END  
;


Assignment:
   	 IDF SC_ASSIGN exprA ';' {
					
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
	|IDF 
	|'(' exprA ')'
	|exprA '+' exprA
	|exprA '-' exprA	%prec '+'
	|exprA '*' exprA
	|exprA '/' exprA	//{if(strcmp($3,"0")==0){printf("semantic error : division by 0, Line %d",line_counter);}}	
	|exprA '%' exprA
	
;

exprR:
	exprA
	|exprR SC_EQUALS exprR
	|exprR SC_DIFF exprR
	|exprR SC_LOE exprR
	|exprR SC_GOE exprR
	|exprR '<' exprR
	|exprR '>' exprR
;

exprL:
	exprR
	|'!'exprL
	|exprL SC_AND exprL
	|exprL SC_OR exprL
;

Condition :
	KW_true
	|KW_false
	|exprL
;

If_instruction :
	KW_If '(' Condition')' '[' stmt  ']'
;

IfElse_instruction :
	If_instruction KW_Else '[' stmt ']'
;

While_insruction :
		KW_While '('Condition')' '[' stmt ']'
;

%%

		/*C code*/
		void yyerror(char const *s){
			fprintf(stderr,"%s line:%d\n", s,line_counter);
		}

