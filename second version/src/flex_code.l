%{
#include "../inc/bison_code.tab.h"
#include "../inc/sym_tab.h"
int line_counter = 1;
extern YYSTYPE yylval;

%}


digit		[0-9]
letter 		[a-zA-Z]

integre		[-+]?([1-9][0-9]*|0)
float_value	[-+]?([1-9][0-9]*|0)\.[0-9]+


identif		{letter}({letter}[_]?|{digit}[_]?)*
comment		"{"[^{}]*"}"

%%
"int"		return(KW_int);
"float"		return(KW_float);
"boolean"	return(KW_boolean);
"BEGIN"		return(KW_BEGIN);
"END"		return(KW_END);
"While"		return(KW_While);
"If"		return(KW_If);
"else"		return(KW_Else);
"Const"		return(KW_Const);
"return"	return(KW_Return);
"void"		return(KW_Void);
"false"		return(KW_false);
"true"		return(KW_true);
"function"	return(KW_Function);

{integre}	{ yylval.integerV=atoi(yytext); return(INT); }
{float_value}	{ yylval.floatV=atof(yytext); return(FLOAT); }
{identif}	{ if(yyleng > 12){ printf("(%s) IDF too long\n", yytext); exit(1);} 	else{ yylval.string = strdup(yytext); insert(yytext, "idf"); return IDF;} }
		
[-+*/%<>!,;()\[\]]		return yytext[0];
":="			return(SC_ASSIGN);
"=="			return(SC_EQUALS);
"<>"			return(SC_DIFF);
"<="			return(SC_LOE);
">="			return(SC_GOE);
"&&"			return(SC_AND);
"||"			return(SC_OR);
"++"			return(SC_INCR);
"--"			return(SC_DECR);

{comment}		{line_counter = line_counter + count_nl(yytext, yyleng);}
\n				line_counter ++;
[ \t]			{	}
.           		printf("erreur a la ligne %d\n", line_counter);
%%


int yywrap(void)
{
	return 1;
}
