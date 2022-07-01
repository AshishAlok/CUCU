%{
    #include "cucu.tab.h"
    #include <stdio.h>
%}


%%


int|char[ ][*]            { fprintf(yyout,"DATA_TYPE : %s\n",yytext); yylval.string = strdup(yytext); return TYPE; };
void                      {fprintf(yyout,"KEYWORD : VOID\n",yytext); return VOID; };
return                    { fprintf(yyout,"KEYWORD : RETURN\n");return RETURN; };
while                     { fprintf(yyout,"KEYWORD : WHILE\n");return WHILE;} ;
for	                  { fprintf(yyout,"KEYWORD : FOR\n"); return FOR; };
if	                   {fprintf(yyout,"KEYWORD : IF\n"); return IF; };
else	                {fprintf(yyout,"KEYWORD : ELSE\n");return ELSE; };
true                      {fprintf(yyout,"BOOLEAN VALUE : TRUE\n"); return TRUE; };
false                   { fprintf(yyout,"BOOLEAN VALUE : FALSE\n");return FALSE; };
[-]?[0-9]+                  {fprintf(yyout,"INTEGER : %s\n",yytext); yylval.number = atoi(yytext); return NUMBER; };
[a-zA-Z_][a-zA-Z0-9_]*      {fprintf(yyout,"ID : %s\n",yytext); yylval.string = strdup(yytext); return ID; };
[<][=]             {fprintf(yyout,"LESS_THAN_EQUAL : <=\n"); return LTEQ; };
[>][=]            {fprintf(yyout,"GREATER_THAN_EQUAL : >=\n"); return GTEQ; };
[=][=]            { fprintf(yyout,"EQUAL_EQUAL : ==\n"); return EQ; };
[=]              {fprintf(yyout,"ASSIGN : =\n");return EQUAL;};
[,]	    {fprintf(yyout,"COMMA : ,\n");return COMMA;};
[!][=]               {fprintf(yyout,"NOT_EQUALS : !=\n"); return NEQ; };
[&]                   {fprintf(yyout,"BITWISE_AND : &\n");return AND;};
[|]                   {fprintf(yyout,"BITWISE_OR : |\n");return OR;};
[>]	              { fprintf(yyout,"GREATER_THAN : >\n");return GT; };
[<]	              { fprintf(yyout,"LESS_THAN : <\n");return LT; };
[+]                   {fprintf(yyout,"PLUS : +\n"); return ADD; };
[-]                  {fprintf(yyout,"MINUS : -\n"); return SUBTRACT; };
[/]                  {fprintf(yyout,"DIVIDE :  /\n"); return DIVIDE; };
[*]                   { fprintf(yyout,"MULTIPLY : *\n");return MULTIPLY; };
[(]                { fprintf(yyout,"OPEN_PARENTHESIS : (\n"); return OPAREN; }; 
[)]              {fprintf(yyout,"CLOSE_PARENTHESIS : )\n"); return CPAREN; };
[{]              { fprintf(yyout,"OPEN_CUR_BRAC : {\n");return OCURBRAC; };
[}]            { fprintf(yyout,"CLOSE_CUR_BRAC : }\n");return CCURBRAC; };
[;]             {fprintf(yyout,"SEMICOLON : ;\n"); return SEMI; };
\/\/.*                      { ; };
\/\*(.*\n)*.*\*\/           { ; } ;
[ \t]*                      { ; };
[\n]                             ;
["].*["]                    {fprintf(yyout,"STRING : %s\n",yytext); yylval.string = strdup(yytext); return STR; };
['].[']                     {fprintf(yyout,"CHARACTER : %s\n",yytext); return CHARACTER; };
.	                     { return *yytext; };


%%

