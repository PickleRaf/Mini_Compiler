%{		/*C declarations*/


%}

		/* Yacc definitions*/
%union{int integer;
	float floatV;
	boolean bool;
	char[2] specialChar;
	char[11] string;
	
}

%start 	Prog
%token	KW_int KW_float KW_boolean INT FLOAT BOOL IDF SC_ASSIGN SC_EQUALS SC_DIFF SC_LOE SC_GOE KW_For KW_If KW_Else KW_BEGIN KW_END KW_Return KW_Const KW_Void

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

Declarations_Liste : 
	/*empty*/
	|VarDeclaration Declarations_Liste
	|FuncDeclaration Declarations_Liste
	|ProDeclaration Declarations_Liste
	|Assignment  Declarations_Liste
;

VarDeclaration:
	Type G_IDF ';'
;

FuncDeclaration:
	Type IDF '('PARA')''{' Assignment Instructions Return'}' /*need to define args*/
;

Return : 
	KW_Return INT ';'
	|KW_Return FLOAT ';'
	|KW_Return BOOL ';'
	|KW_Return IDF ';'
;

ProDeclaration:
	KW_Void IDF '('PARA')''{'Assignment Instructions'}' /*need to define args*/
;

Assignment : 	
	KW_int G_IDF SC_ASSIGN INT';'
	|G_IDF SC_ASSIGN INT';'
	|KW_float G_IDF SC_ASSIGN FLOAT ';'
	|G_IDF SC_ASSIGN FLOAT ';'
	|KW_boolean G_IDF SC_ASSIGN BOOL ';'
	|G_IDF SC_ASSIGN BOOL ';'
;	 

G_IDF: 
	IDF ',' G_IDF
	|IDF 
;

Type:
	KW_int
	|KW_float
	|KW_boolean
;

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
	|FuncCall Instructions
	|ProCall Instructions
	
;

ArithmeticOp:
	Div ArithmeticOp	|Div
	|Mult ArithmeticOp	|Mult
	|Add ArithmeticOp	|Add
	|Sub ArithmeticOp	|Sub 
	|Mod ArithmeticOp	|Mod
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

Condition: 
	'('Expression')'
;

Expression:
	OpSide RelationalOp OpSide
;

OpSide:
	IDF
	|Num
	|ArithmeticOp
	|FuncCall
;

Num:	/*Num must be renamed to const later*/
	INT
	|FLOAT
;

For:
	KW_For '(' IDF SC_ASSIGN INT ';' Expression  ';' Increment ')''{' Instructions '}'
;

If: 
	KW_If Condition '{' Instructions '}'
	|KW_If Condition '{' Instructions '}' KW_Else '{' Instructions '}'
;

FuncCall:
	IDF'('ARGS')'';'
;

ProCall:
	IDF'('ARGS')'';'
;


























%%

		/*C code*/
		

