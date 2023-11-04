%{
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
comment		\{[^{}]*\}

%%

"int"		{yylval.string=strdup(yytext);return(KW_int);}
"float"		{yylval.string=strdup(yytext);return(KW_float);}
"boolean"	{yylval.string=strdup(yytext);return(KW_boolean);}
"BEGIN"		{yylval.string=strdup(yytext);return(KW_BEGIN);}
"END"		{yylval.string=strdup(yytext);return(KW_END);}
"For"		{yylval.string=strdup(yytext);return(KW_For);}
"If"		{yylval.string=strdup(yytext);return(KW_IF);}
"else"		{yylval.string=strdup(yytext);return(KW_else);}


integre		{yylval.integer=atoi(yytext);return(INT);}
float_value	{yylval.floatV=atoi(yytext);return(FLOAT);}
boolean_value	return(BOOL);
idf		{yylval.string=strdup(yytext);return(IDF);}

[-+*/%<>!,;(){}]	return yytext[0];
":="			return(SC_ASSIGN);
"=="			return(SC_EQUALS);
"<>"			return(SC_DIFF);
"<="			return(SC_LOE);
">="			return(SC_GOE);
comment			return(COMMENT);
\n			line_counter ++; 
\t
.		printf("unexpected character \n");
%%	

int yywrap(void)
{
	return 1;
}
