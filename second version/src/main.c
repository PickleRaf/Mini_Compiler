#include "../inc/bison_code.tab.h"
#include "../inc/sym_tab.h"

#include <stdio.h>
#include <stdlib.h>

extern FILE* yyin;
extern int yylex();

int main(int argc, char** argv){
   
    if(argc == 1 ){
    
  	  return 1;//error no input file 
   
    }
    else{
    
    	for(int i = 1; i < argc; i++){
   	 
   		yyin = fopen(argv[i], "r");
   	 
   	 	if(yyin==NULL){
   	 		perror("error opening file");
   	 		return 1;//error
   	 	}
    	 
    	printf("%s Analysis: \n", argv[i]);

	yylex();	 
    yyparse();


   	print_STN();
   	Sym_Tab_Destroy();
   	 
   	fclose(yyin);
   	 
   	 printf("\n--------------------------------------\n");
    	}
    	
    	return 0; // success
    }
}
