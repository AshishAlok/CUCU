%{
    #include<stdio.h>
    #include<string.h>
    #include<stdlib.h>
    FILE *outl;
    
%}

%union{
    int number;
    char *string;
}

%token COMMA WHILE VOID CCURBRAC OCURBRAC CPAREN OPAREN FOR IF ELSE SEMI TRUE FALSE LTEQ GTEQ EQ EQUAL NEQ GT LT AND OR ADD MULTIPLY DIVIDE SUBTRACT RETURN
%token <string> ID CHARACTER STR;
%token <number> NUMBER; 
%token <string> TYPE;

%%
program : program funcs
|funcs
;
funcs : var_dec
|func_dec
|func_def
;

var_dec : TYPE ID SEMI {fprintf(outl,"\nVar_declaration := type : %s , Id : %s ,SEMI \n",$1,$2);}
|TYPE ID EQUAL expr SEMI {fprintf(outl,"\nVar_initialization := type : %s , Id : %s ,SEMI \n",$1,$2);}
;

func_dec : TYPE ID OPAREN func_args CPAREN SEMI {fprintf(outl,"\nfunc_return_type : %s, function declared : %s\n",$1,$2);}

;

func_def : TYPE ID OPAREN func_args CPAREN func_body {fprintf(outl,"\nfunc_return_type  : %s, function_defined : %s\n",$1,$2);}

;

func_args : TYPE ID COMMA func_args {fprintf(outl,"type : %s, Id : %s, ",$1,$2);}
| TYPE ID  {fprintf(outl,"\nfunc_args := type : %s, Id : %s , ",$1,$2);}
| ;

func_body : OCURBRAC statements CCURBRAC | OCURBRAC CCURBRAC ;
;

statements : statements statement
| statement 
;

statement : TYPE ID EQUAL expr SEMI  {fprintf(outl,"type : %s, Id : %s, OP : EQUAL (=) , ",$1,$2);}
| ID EQUAL expr SEMI   {fprintf(outl,"Id : %s, OP : = ,",$1);}
| WHILE OPAREN expr CPAREN OCURBRAC statements CCURBRAC {fprintf(outl,"INBUILT FUNCTION : while , ");}

| IF OPAREN expr CPAREN OCURBRAC statements CCURBRAC {fprintf(outl,"INBUILT FUNCTION : if , ");}
| IF OPAREN expr CPAREN OCURBRAC statements CCURBRAC ELSE OCURBRAC statements CCURBRAC {fprintf(outl,"INBUILT_FUNC : if else ,");}
| RETURN expr SEMI  {fprintf(outl,"\nCONTROL_STATEMENT : return ,");}
| TYPE ID SEMI {fprintf(outl, "\ntype : %s, id : %s ",$1,$2);}
|func_call SEMI
| expr SEMI         
;

expr : bit_expr | bit_expr EQUAL expr ;
bit_expr : e_expr
           | bit_expr AND e_expr {fprintf(outl,"OPERATOR : & , ");}
           | bit_expr OR e_expr   {fprintf(outl,"OPERATOR : | , ");}
           ;
e_expr : relt_expr
         | e_expr NEQ relt_expr  {fprintf(outl,"RELATIONAL_OP : NOT EQUALS(!=) , ");}
         | e_expr EQ relt_expr  {fprintf(outl,"RELATIONAL_OP : EQUALS EQUALS (==) , ");}
         ;   
relt_expr : art_expr
            | relt_expr LT art_expr {fprintf(outl,"RELATIONAL_OP : LESS THAN(<) , ");}
            | relt_expr GT art_expr {fprintf(outl,"RELATIONAL_OP : GREATER THAN(>) , ");}
            | relt_expr GTEQ art_expr  {fprintf(outl,"RELATIONAL_OP : GREATER THAN EQUAL TO (>=) , ");}
            | relt_expr LTEQ art_expr {fprintf(outl,"RELATIONAL_OP : LESS THAN EQUAL TO (<=) , ");} 
            ; 

art_expr : 
           art_expr ADD term   {fprintf(outl,"ARITH_OP : PLUS(+) ,");}
           |art_expr SUBTRACT term {fprintf(outl,"ARITH_OP : SUBTRACT(-) , ");}
          | art_expr ADD func_call
          |art_expr SUBTRACT func_call
          | term 
          
          ; 
 term : p_expr MULTIPLY term {fprintf(outl,"ARITH_OP : MULTIPLY(*) , ");}
 | p_expr DIVIDE term  {fprintf(outl,"ARITH_OP : DIVIDE(/)  ,");}
 | p_expr
 ;
 
p_expr : end 
        | p_expr expr
        | p_expr OPAREN expr CPAREN 
        |func_call expr
        ;
func_call :ID OPAREN func_para CPAREN  {fprintf(outl,"function call : %s ,",$1);}
;
func_para : ID COMMA func_para {fprintf(outl,"Id : %s, ",$1);}
| NUMBER COMMA func_para {fprintf(outl,"NUMBER : %d ,",$1);}
|expr COMMA func_para 
|expr
| ID  {fprintf(outl,"func_para :=Id : %s ,",$1);}
| NUMBER {fprintf(outl,"func_para := NUMBER : %d ,",$1);}
 ;

end : NUMBER {fprintf(outl,"NUM : %d \n",$1);} 
| ID   {fprintf(outl,"ID : %s \n",$1);}
| OPAREN expr CPAREN 
|STR {fprintf(outl,"CHARACTER : %s \n",$1);}
|CHARACTER {fprintf(outl,"CHARACTER : %s \n",$1);}
| /*nothing*/ 
;

%%


void yyerror(const char *s){
        printf(stderr,"%s",s);
    }

    int yywrap(){
        return 1;
    }


    main(int argc[],char *argv[]){
    	 extern FILE *yyin, *yyout ;
        yyin = fopen(argv[1],"r");
        yyout = fopen("Lexer.txt","w");
        outl = fopen("Parser.txt","w");
        
        yyparse();
    }
