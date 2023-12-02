%{
    #include "../inc/bison_code.tab.h"
    #include "../inc/sym_tab.h"
int line_counter = 0 ;
int colomn_counter = 0 ;
extern YYSTYPE yylval;

%}


digit		[0-9]
letter 		[a-zA-Z]
idf		{letter}({letter}[_]?|{digit}[_]?)*
integre		[-+]?([1-9][0-9]*|0)
float_value	[-+]?([1-9][0-9]*|0)(\.[0-9]+)?
boolean_value 	false|true
comment		\{[^}]*\}

%%

"int"		return(KW_int);
"float"		return(KW_float);
"boolean"	return(KW_boolean);
"BEGIN"		return(KW_BEGIN);
"END"		return(KW_END);}
"For"		return(KW_For);}
"If"		return(KW_IF);}
"else"		return(KW_else);}
"Const"		return(KW_Const);
"return"	return(KW_Return);
"void"		return(KW_Void);
"function"	return(KW_Function);


integre		{yylval.integer=atoi(yytext);return(INT);}
float_value	{yylval.floatV=atof(yytext);return(FLOAT);}
boolean_value	{yylval.string=strdup(yytext);return(BOOL);}
idf		{yylval.string=strdup(yytext);return(IDF);}

[-+*/%<>!,;(){}]	return yytext[0];
":="			return(SC_ASSIGN);
"=="			return(SC_EQUALS);
"<>"			return(SC_DIFF);
"<="			return(SC_LOE);
">="			return(SC_GOE);
"++"			return(SC_INCR);
"--"			return(SC_DECR);
\n			line_counter ++; 
comment			
[ \t]
.		printf("erreur a la ligne %d \n",line_counter);
%%	

int yywrap(void)
{
	return 1;
}
