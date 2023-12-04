%{
    #include "../inc/bison_code.tab.h"
    #include "../inc/sym_tab.h"
int line_counter = 1 ;
int colomn_counter = 0 ;
extern YYSTYPE yylval;

%}


digit		[0-9]
letter 		[a-zA-Z]
identif		[a-zA-Z]([a-zA-Z][_]?|[0-9][_]?)*
integre		[-+]?([1-9][0-9]*|0)
float_value	[-+]?([1-9][0-9]*|0)(\.[0-9]+)?
boolean_value 	false|true
comment		"{" [^{}]* "}"

%%

"int"		printf("21"); return(KW_int);
"float"		printf("22"); return(KW_float);
"boolean"	printf("23"); return(KW_boolean);
"BEGIN"		printf("24"); return(KW_BEGIN);
"END"		printf("25"); return(KW_END);
"For"		printf("26"); return(KW_For);
"If"		printf("27"); return(KW_If);
"else"		printf("28"); return(KW_Else);
"Const"		printf("29"); return(KW_Const);
"return"	printf("30"); return(KW_Return);
"void"		printf("31"); return(KW_Void);
"function"	printf("32"); return(KW_Function);

integre		{yylval.integerV=atoi(yytext); printf("33"); return(INT);}
float_value	{yylval.floatV=atof(yytext); printf("34"); return(FLOAT);}
boolean_value	{strcpy(yylval.boolV, strdup(yytext)); printf("35"); return(BOOL);}

identif		{strcpy(yylval.string, strdup(yytext)); printf("36"); return(IDF);}

[-+*/%<>!,;()]		printf("37"); return yytext[0];
":="			printf("38"); return(SC_ASSIGN);
"=="			printf("39"); return(SC_EQUALS);
"<>"			printf("40"); return(SC_DIFF);
"<="			printf("41"); return(SC_LOE);
">="			printf("42"); return(SC_GOE);
"++"			printf("43"); return(SC_INCR);
"--"			printf("44"); return(SC_DECR);
\n			line_counter ++; 
[ \t]			{	}
comment			{	}
%%	

int yywrap(void)
{
	return 1;
}
