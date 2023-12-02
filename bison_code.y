%{		/*C declarations*/

#include <stdio.h> 
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>
#include "../inc/sym_tab.h" 
extern int line_counter;
void yyerror();
int yylex();

%}

		/* Yacc definitions*/
%union{int integer;
	float floatV;
	boolean bool;
	char[2] specialChar;
	char[11] string;
	
}

%start 	Prog
%token	INT FLOAT BOOL IDF 
%token	SC_ASSIGN SC_EQUALS SC_DIFF SC_LOE SC_GOE  SC_INCR SC_DECR
%token	KW_int KW_float KW_boolean KW_For KW_If KW_Else KW_BEGIN KW_END KW_Return KW_Const KW_Void KW_Pc KW_Fc KW_Function

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
%type <bool>		BOOL

%%
		/*grammar*/
Prog: 
	Declarations_Liste Instructions_Liste
;

		/*handling declarations*/
		
Declarations_Liste : 
	/*empty*/
	|ConstDeclaration Declarations_Liste
	|VarInit Declarations_Liste
	|FuncDeclaration Declarations_Liste
	|ProDeclaration Declarations_Liste
	|VarDeclaration  Declarations_Liste
;

VarDeclaration:
	Type G_IDF ';'
;

FuncDeclaration:
	KW_Function Type IDF '('Parameter_Liste')''{' VarInit Instructions Return'}' 
;

ProDeclaration:
	KW_Void IDF '('Parameter_Liste')''{' VarInit Instructions'}' 
;

Parameter_Liste:
	/*empty*/
	|Type IDF',' Parameter_Liste
;

Return : 
	KW_Return INT ';'
	|KW_Return FLOAT ';'
	|KW_Return BOOL ';'
	|KW_Return IDF ';'
;

ConstDeclaration :
	KW_Const Type IDF SC_ASSIGN Const ';'
;

Const:
	INT
	|FLOAT
;

VarInit:
	Type Assignment
;

Assignment:
    G_IDF SC_ASSIGN INT ';'
    | G_IDF SC_ASSIGN FLOAT ';'
    | G_IDF SC_ASSIGN BOOL ';'
;	 

G_IDF: 
	G_IDF ',' IDF
	|IDF 
;

Type:
	KW_int
	|KW_float
	|KW_boolean
;

		/*handling instructions*/
		
Instructions_Liste :
	KW_BEGIN Instructions KW_END
;

Instructions:
	/*empty*/
	|Assignment Instructions
	|For Instructions
	|If Instructions
	|Div Instructions
	|Mult Instructions
	|Add Instructions
	|Sub Instructions
	|Mod Instructions
	|Increment';' Instructions
	|Decrement';' Instructions
	|FuncCall Instructions
	|ProCall Instructions
	
;


%left '+' '-';
%left '*' '/' '%';

ArithmeticOp:
    UnaryPlus
    |UnaryMinus
    | Div
    | Mult
    | Add
    | Sub
    | Mod
;

UnaryPlus:
	'+' OpSide %prec '+'
;

UnaryMinus:
	'-' OpSide %prec '-'
;

Div:
	OpSide '/' OpSide
;

Mult:
	OpSide '*' OpSide
;

Add:
	OpSide '+' OpSide
;

Sub:
	OpSide '-' OpSide
;

Mod:
	OpSide'%' OpSide
;

Increment:
	IDF SC_INCR 
;

Decrement:
	IDF SC_DECR
;

RelationalOp:
	EqualityOp 
	|InequalityOp
;

EqualityOp:
	SC_EQUALS 
	|SC_DIFF 
;

InequalityOp:
	SC_LOE
	|SC_GOE
	|'>'
	|'<'
;

OpSide:
	IDF
	|ArithmeticOp
	|Const
	|FuncCall
;

Condition: 
	'('Expression')'
;

Expression:
	OpSide RelationalOp OpSide
;



For:
	KW_For '(' IDF SC_ASSIGN INT ';' Expression  ';' Increment')''{' Instructions '}'
;

If: 
	KW_If Condition '{' Instructions '}'
	|KW_If Condition '{' Instructions '}' KW_Else '{' Instructions '}'
;

FuncCall:
	KW_Fc IDF'('Args_Liste')'';'
;

ProCall:
	KW_Pc IDF'('Args_Liste')'';'
;

Args_Liste:
	/*empty*/
	|G_IDF
;



%%

		/*C code*/
		

