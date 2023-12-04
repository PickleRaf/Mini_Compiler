%{
    #include "../inc/bison_code.tab.h"
    #include "../inc/sym_tab.h"
int line_counter = 1 ;
int colomn_counter = 0 ;
extern YYSTYPE yylval;

%}


digit		[0-9]
letter 		[a-zA-Z]
idf		{letter}({letter}[_]?|{digit}[_]?)*
integre		[-+]?([1-9][0-9]*|0)
float_value	[-+]?([1-9][0-9]*|0)(\.[0-9]+)?
boolean_value 	false|true
comment		"{" [^}] "}"

%%

"int"		return(KW_int);printf("21");
"float"		return(KW_float);printf("22");
"boolean"	return(KW_boolean);printf("23");
"BEGIN"		return(KW_BEGIN);printf("24");
"END"		return(KW_END);printf("25");
"For"		return(KW_For);printf("26");
"If"		return(KW_If);printf("27");
"else"		return(KW_Else);printf("28");
"Const"		return(KW_Const);printf("29");
"return"	return(KW_Return);printf("30");
"void"		return(KW_Void);printf("31");
"function"	return(KW_Function);printf("32");

integre		{yylval.integer=atoi(yytext);return(INT);printf("33");}
float_value	{yylval.floatV=atof(yytext);return(FLOAT);printf("34");}
boolean_value	{strcpy(yylval.boolV, strdup(yytext));return(BOOL);printf("35");}
idf		{strcpy(yylval.string, strdup(yytext));return(IDF);printf("36");}

[-+*/%<>!,;(){}]	return yytext[0];printf("37");
":="			return(SC_ASSIGN);printf("38");
"=="			return(SC_EQUALS);printf("39");
"<>"			return(SC_DIFF);printf("40");
"<="			return(SC_LOE);printf("41");
">="			return(SC_GOE);printf("42");
"++"			return(SC_INCR);printf("43");
"--"			return(SC_DECR);printf("44");
\n			line_counter ++; 
comment			{	}
[ \t]			{	}
.		printf("erreur a la ligne %d \n",line_counter);
%%	

int yywrap(void)
{
	return 1;
}
