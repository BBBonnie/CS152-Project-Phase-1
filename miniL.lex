 /* cs152-miniL phase1 */
   
%{   
   /* write your C code here for definitions of variables and including headers */
int currLine = 1, currPos = 0;
%}

   /* some common rules */
DIGIT    [0-9]

%%
   /* specific lexer rules in regex */

function               {currPos += yyleng; printf("FUNCTION\n"); }
beginparams            {currPos += yyleng; printf("BEGIN_PARAMS\n"); }
endparams              {currPos += yyleng; printf("END_PARAMS\n"); }
beginlocals            {currPos += yyleng; printf("BEGIN_LOCALS\n"); }
endlocals              {currPos += yyleng; printf("END_LOCALS\n"); }
beginbody              {currPos += yyleng; printf("BEGIN_BODY\n"); }
endbody                {currPos += yyleng; printf("END_BODY\n"); }
integer                {currPos += yyleng; printf("INTEGER\n"); }
array                  {currPos += yyleng; printf("ARRAY\n"); }
of                     {currPos += yyleng; printf("OF\n"); }
if                     {currPos += yyleng; printf("IF\n"); }
then                   {currPos += yyleng; printf("THEN\n"); }
endif                  {currPos += yyleng; printf("ENDIF\n"); }
else                   {currPos += yyleng; printf("ELSE\n"); }
while                  {currPos += yyleng; printf("WHILE\n"); }
do                     {currPos += yyleng; printf("DO\n"); }
beginloop              {currPos += yyleng; printf("BEGINLOOP\n"); }
endloop                {currPos += yyleng; printf("ENDLOOP\n"); }
continue               {currPos += yyleng; printf("CONTINUE\n");} 
break                  {currPos += yyleng; printf("BREAK\n"); }
read                   {currPos += yyleng; printf("READ\n"); }
write                  {currPos += yyleng; printf("WRITE\n"); }
not                    {currPos += yyleng; printf("NOT\n"); }
true                   {currPos += yyleng; printf("TRUE\n"); }
false                  {currPos += yyleng; printf("FALSE\n"); }
return                 {currPos += yyleng; printf("RETURN\n"); }

"("            {currPos += yyleng; printf("L_PAREN\n");}
")"            {currPos += yyleng; printf("R_PAREN\n");  }
"["            {currPos += yyleng; printf("L_SQUARE_BRACKET\n");  }
"]"            {currPos += yyleng; printf("R_SQUARE_BRACKET\n");  }
"-"            {currPos += yyleng; printf("SUB\n"); }
"*"            {currPos += yyleng; printf("MULT\n"); }
"/"            {currPos += yyleng; printf("DIV\n"); }
"%"            {currPos += yyleng; printf("MOD\n"); }
"+"            {currPos += yyleng; printf("ADD\n"); }
"<"            {currPos += yyleng; printf("LT\n"); }
"<="           {currPos += yyleng; printf("LTE\n"); }
">"            {currPos += yyleng; printf("GT\n"); }
">="           {currPos += yyleng; printf("GTE\n"); }
"=="           {currPos += yyleng; printf("EQ\n"); }
"<>"           {currPos += yyleng; printf("NEQ\n"); }
":="           {currPos += yyleng; printf("ASSIGN\n"); }
";"            {currPos += yyleng; printf("SEMICOLON\n"); }
":"            {currPos += yyleng; printf("COLON\n"); }
","            {currPos += yyleng; printf("COMMA\n"); }


({DIGIT}+)      {currPos += yyleng; printf("NUMBER %s\n", yytext);}
[a-zA-Z0-9_]*\_ {printf("Error at line %d, column %d: identifier \"%s\" cannot end with an undederscore\n", currLine, currPos, yytext);}
[0-9_][a-zA-Z0-9_]+ {printf("Error at line %d, column %d: identifier \"%s\" must begin with a letter\n", currLine, currPos, yytext);}

"##".* {currLine ++; currPos = 0;}
[a-zA-Z0-9_]*  {currPos += yyleng; printf("IDENT %s\n", yytext);}
[ ]		{currPos += yyleng; printf("");}
[\t]		{currPos += yyleng; printf("");}
"\n"		{currLine += yyleng; currPos = 0; printf("");}	

.              {printf("Error at line %d, column %d: unrecognized symbol \"%s\"\n", currLine, currPos, yytext);}

%%
	/* C functions used in lexer */

int main(int argc, char ** argv)
{
   yylex();
}
