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

%type <string>		G_IDF
%type <string> 		KW_Const
%type <string>		Const
%type <string> 		Type

%left ','
%left SC_EQUALS SC_DIFF 
%left '+' '-'
%left '*' '/' '%'
%left '('

%%
		/*grammar*/

Programme: 
	
	Declarations_List Instructions_List{
		
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
		if(strcmp($2,$5)!=0){
			printf("semantic error: incompatible type , in line %d\n",line_counter);
		}
		isConst($3);
	}
;

Const:
	INT{ 	
		$$ ="int";

	}
	|FLOAT{
		$$="float";

	}
	|BOOL{	
		$$="boolean";

	}
;

VarInit:
	Type  G_IDF SC_ASSIGN Const ';' {
		
		if(strcmp($1,$4)!=0){
			printf("semantic error: incompatible type , in line %d\n",line_counter);
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
	%empty
	|KW_BEGIN stmt KW_END  
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
			printf("idf NOT DECLARED ! 206 line:%d\n ",line_counter);
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
			fprintf(stderr,"%s line:%d\n", s,line_counter);
		}

