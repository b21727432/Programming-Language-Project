%token OR_OPERATOR AND_OPERATOR NOT_OPERATOR EQUAL_OPERATOR LESS_OPERATOR LESS_OR_EQUAL_OPERATOR GREATER_OPERATOR GREATER_OR_EQUAL_OPERATOR LEFT_PARENTHESIS 
%token RIGHT_PARENTHESIS LEFT_CURLY RIGHT_CURLY LEFT_BRACKET RIGHT_BRACKET PLUS MINUS MULTIPLICATION DIVISION EXPONENTIAL MOD TRUE FALSE FOR WHILE IF ELSE PUSH
%token PULL INT_TYPE FLOAT_TYPE STRING_TYPE VOID_TYPE BOOLEAN_TYPE INTEGER FLOAT STRING NEW_LINE INVALID ASSIGNMENT_OPERATOR PROGRAM COMMA RETURN COMMENT SEMICOLON
%token GRAPH_TYPE QUOTE POINT ARRAY

%start program

%%
		
types : INT_TYPE | STRING_TYPE | BOOLEAN_TYPE | FLOAT_TYPE | GRAPH_TYPE
		;
primitive_types : INTEGER| FLOAT| STRING | TRUE | FALSE | QUOTE STRING QUOTE
		;
operators : EQUAL_OPERATOR | NOT_OPERATOR | LESS_OPERATOR | LESS_OR_EQUAL_OPERATOR | GREATER_OPERATOR | GREATER_OR_EQUAL_OPERATOR  
		;
array_declaration : types ARRAY LEFT_BRACKET INTEGER RIGHT_BRACKET



program : VOID_TYPE PROGRAM LEFT_PARENTHESIS RIGHT_PARENTHESIS LEFT_CURLY statements RIGHT_CURLY
		;
statements : statements SEMICOLON statement
		| statements NEW_LINE
		| statement SEMICOLON
		| NEW_LINE
		; 
statement :  push_statement    	
		| for
		| while
		| if_else	
		| function_declaration			
		| function_call
		| variable_declaration 
		| assignment
		| return
		| array_declaration
		;
push_statement : PUSH LEFT_PARENTHESIS expression RIGHT_PARENTHESIS
		;
pull_statement : PULL LEFT_PARENTHESIS RIGHT_PARENTHESIS
			;
for : FOR LEFT_PARENTHESIS assignment SEMICOLON expression operators expression SEMICOLON expression RIGHT_PARENTHESIS LEFT_CURLY statements RIGHT_CURLY
	;
while : WHILE LEFT_PARENTHESIS expression operators expression RIGHT_PARENTHESIS LEFT_CURLY statements RIGHT_CURLY
	;
if_else : matched
		| unmatched
		;			
matched : IF LEFT_PARENTHESIS expression operators expression RIGHT_PARENTHESIS matched ELSE matched
		| LEFT_CURLY statements RIGHT_CURLY
		;
unmatched : IF LEFT_PARENTHESIS expression operators expression RIGHT_PARENTHESIS if_else
		| IF LEFT_PARENTHESIS expression matched ELSE unmatched
		;
	

expression : expression MINUS expression_term
		| expression PLUS expression_term
		| expression OR_OPERATOR expression_term
		| expression_term
		;
expression_term : expression_term MULTIPLICATION expression_factor
		| expression_term DIVISION expression_factor
		| expression_term AND_OPERATOR expression_factor
		| expression_factor
		;
expression_factor : expression_factor MOD expression_factor2
		| expression_factor2;
expression_factor2 : LEFT_PARENTHESIS expression RIGHT_PARENTHESIS
		| primitive_types
		;

function_declaration : types STRING LEFT_PARENTHESIS function_declaration_argument_list RIGHT_PARENTHESIS LEFT_CURLY statements RIGHT_CURLY
		;
function_declaration_argument_list : STRING 
		| function_declaration_argument_list COMMA STRING 
		| empty
		;
function_call : STRING LEFT_PARENTHESIS function_call_argument_list RIGHT_PARENTHESIS
		;
function_call_argument_list : expression
		| function_call_argument_list COMMA expression
		| empty
		;
empty : ;


variable_declaration : ASSIGNMENT_OPERATOR types variable_declaration_argument_list 
		;
variable_declaration_argument_list : STRING 
		| variable_declaration_argument_list COMMA STRING
		;	
variable_accessing_value : STRING 
		| variable_accessing_value POINT STRING
	    ;

return : RETURN variable_accessing_value
	;		
assignment : pull_statement ASSIGNMENT_OPERATOR types STRING
		| pull_statement ASSIGNMENT_OPERATOR STRING
		| expression ASSIGNMENT_OPERATOR types STRING 
		| expression ASSIGNMENT_OPERATOR variable_accessing_value
		| function_call ASSIGNMENT_OPERATOR types STRING
		| function_call ASSIGNMENT_OPERATOR STRING
		;
	
		
%%
#include "lex.yy.c"
int lineno;
int main(void){
 return yyparse();
}
yyerror( char *s ) { fprintf( stderr, "%s in line: %d\n", s, lineno); };

 







