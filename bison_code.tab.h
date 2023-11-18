/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

#ifndef YY_YY_BISON_CODE_TAB_H_INCLUDED
# define YY_YY_BISON_CODE_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    INT = 258,                     /* INT  */
    FLOAT = 259,                   /* FLOAT  */
    BOOL = 260,                    /* BOOL  */
    IDF = 261,                     /* IDF  */
    SC_ASSIGN = 262,               /* SC_ASSIGN  */
    SC_EQUALS = 263,               /* SC_EQUALS  */
    SC_DIFF = 264,                 /* SC_DIFF  */
    SC_LOE = 265,                  /* SC_LOE  */
    SC_GOE = 266,                  /* SC_GOE  */
    SC_INCR = 267,                 /* SC_INCR  */
    SC_DECR = 268,                 /* SC_DECR  */
    KW_int = 269,                  /* KW_int  */
    KW_float = 270,                /* KW_float  */
    KW_boolean = 271,              /* KW_boolean  */
    KW_For = 272,                  /* KW_For  */
    KW_If = 273,                   /* KW_If  */
    KW_Else = 274,                 /* KW_Else  */
    KW_BEGIN = 275,                /* KW_BEGIN  */
    KW_END = 276,                  /* KW_END  */
    KW_Return = 277,               /* KW_Return  */
    KW_Const = 278,                /* KW_Const  */
    KW_Void = 279,                 /* KW_Void  */
    KW_Pc = 280,                   /* KW_Pc  */
    KW_Fc = 281                    /* KW_Fc  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 15 "bison_code.y"
int integer;
	float floatV;
	boolean bool;
	char[2] specialChar;
	char[11] string;
	

#line 98 "bison_code.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;


int yyparse (void);


#endif /* !YY_YY_BISON_CODE_TAB_H_INCLUDED  */
