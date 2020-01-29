%option yylineno
array                                 array
return                                return
digit                                 [0-9]
sign                                  [+-]
letter                                [A-Za-z]
newline                               \n
lp                                    \(
rp                                    \)
lc                                    \{
rc                                    \}
lb                                    \[
rb                                    \]
quote                                 \~
alphanumeric                         ({letter}|{digit})
semicolon                             \;
whitespace                           [ \t\n]
 

true                                 #T
false                                #F

assignment_operator                  \:\-\>      
or_operator                          \|
and_operator                         \&
greater_operator                     \:\>             
greater_or_equal_operator            \:\?\>  
not_operator                         \:\<\>      
equal_operator                       \:\?        
less_or_equal_operator               \:\?\<
less_operator                        \:\<

plus_operator                        \+
minus_operator                       \-
multiplication_operator              \*
division_operator                    \/
mod_operator                         \^
exponential_operator                 \*\*
%%

{array} return(ARRAY);
{return} return(RETURN);
{or_operator} return(OR_OPERATOR );
{and_operator} return(AND_OPERATOR );
{not_operator} return(NOT_OPERATOR);
{equal_operator} return(EQUAL_OPERATOR);
{less_operator} return(LESS_OPERATOR);
{less_or_equal_operator} return(LESS_OR_EQUAL_OPERATOR);
{greater_operator} return(GREATER_OPERATOR);
{greater_or_equal_operator} return(GREATER_OR_EQUAL_OPERATOR);
{assignment_operator} return(ASSIGNMENT_OPERATOR);


{lp} return(LEFT_PARENTHESIS);
{rp} return(RIGHT_PARENTHESIS);
{lc} return(LEFT_CURLY);
{rc} return(RIGHT_CURLY);
{lb} return(LEFT_BRACKET);
{rb} return(RIGHT_BRACKET);

{plus_operator} return(PLUS);
{minus_operator} return(MINUS);
{multiplication_operator} return(MULTIPLICATION);
{division_operator} return(DIVISION);
{exponential_operator} return(EXPONENTIAL);
{mod_operator} return(MOD);

{true} return(TRUE);
{false} return(FALSE);

program return(PROGRAM);
while return(WHILE);
for return(FOR);
if return(IF);
else return(ELSE);

push return(PUSH);
pull return(PULL);

int return(INT_TYPE);
float return(FLOAT_TYPE);
string return(STRING_TYPE);
void return(VOID_TYPE);
boolean return(BOOLEAN_TYPE);
graph  return(GRAPH_TYPE);

{sign}{digit}+ return(INTEGER);
{sign}{digit}+\.{digit}+ return(FLOAT);
{letter}+{alphanumeric}* return(STRING);

\, return(COMMA);
\. return(POINT);
{quote} return(QUOTE);
{semicolon} return(SEMICOLON);
\n { extern int lineno; lineno++;
                  return NEW_LINE;
                }
. return(INVALID);	
%%
int yywrap(void){	return 1;}