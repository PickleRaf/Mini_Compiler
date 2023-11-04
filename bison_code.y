%{		/*C declarations*/


%}

		/* Yacc definitions*/
%union{int integer;
	float floatV;
	boolean bool;
	char[2] specialChar;
	char[11] string;
	char[] text;
	
}

%start 	Prog
%token	KW_int KW_float KW_boolean INT FLOAT BOOL IDF SC_ASSIGN SC_EQUALS SC_DIFF SC_LOE SC_GOE KW_For KW_If KW_Else KW_BEGIN KW_END COMMENT

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
%type <text>		COMMENT
%type <bool>		BOOL

%%
		/*grammar*/
Prog: 
	Declarations_Liste Instructions_Liste
;

Declarations_Liste : 
	|Assignment ';' Declarations_Liste
;

Assignment : 	
	AgnType1 
	|AgnType2
	|AgnType3
;	

AgnType1: 
	KW_int IDF ';'
	|KW_int G_IDF ASSIGN INT';'
;



AgnType2: 
	KW_float IDF ';'
	|KW_float G_IDF ASSIGN FLOAT ';'
;

AgnType3: 
	KW_boolean IDF ';'
	|KW_boolean G_IDF ASSIGN BOOL ';'
; 

G_IDF: 
	IDF ',' G_IDF
	|IDF 
;

Liste_Instructions :
	KW_BEGIN Instructions KW_END
;

Instructions : 

;

ArithmeticOp:
	Div ArithmeticOp	|Div
	|Mult ArithmeticOp	|Mult
	|Add ArithmeticOp	|Add
	|Sub ArithmeticOp	|Sub
	|Mod ArithmeticOp	|Mod
;

Div:
	IDF '/' IDF
	|IDF '/' Num
	|Num '/' IDF
	|Num '/' Num
;

Mult:
	IDF '*' IDF
	|IDF '*' Num
	|Num '*' IDF
	|Num '*' Num
;

Add:
	IDF '+' IDF
	|IDF '+' Num
	|Num '+' IDF
	|Num '+' Num
;

Sub:
	IDF '-' IDF
	|IDF '-' Num
	|Num '-' IDF
	|Num '-' Num
;

Mod:
	IDF '%' IDF
	|IDF '%' Num
	|Num '%' IDF
	|Num '%' Num
;

Num:
	INT
	|FLOAT
;

For:
	KW_For '(' IDF SC_ASSIGN INT ';' CONDITION ';' Increment ')''{' Instructions '}'
;

If: 
	KW_If '(' CONDITION ')' '{' Instructions '}'
	|KW_If '(' CONDITION ')' '{' Instructions '}' KW_Else '{' Instructions '}'
;




























%%

		/*C code*/
		

