#!/bin/bash

flex flex_code.l
bison -d bison_code.y
cp bison_code.tab.h ../inc
gcc lex.yy.c bison_code.tab.c sym_tab.c main.c -lfl -o compile -g

