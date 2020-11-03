NUMBER (DIGIT|[1-9][0-9]{1,})
IDENTIFIER [a-zA-Z]([0-9]|[a-zA-z]){1,}
DIGIT 	  [0-9]
OPERATORS "+"|"-"|"/"|"*"|"="|"=="|"!="|"<"|">"|"<="|">="
SEPARATOR ","|"{"|"}"|"("|")"|";"
STRING	'"'(NUMBER|IDENTIFIER|DIGIT|[a-zA-z]+)'"'
RESERVED_WORDS "if"|"else"|"main"|"for"|"while"|"do"|"while|"var"

%%

{NUMBER}+ {
		       printf("Digit: %s (%d)\n", yytext, atoi(yytext));
			writeToPIF(yytext, "NUMBER", 0);
		    }

{IDENTIFIER}+ {
		        printf("Identifier: %s (%d)\n", yytext, atoi(yytext));
			int position = writeToST(yytext);
			writeToPIF(yytext, "IDENTIFIER", position);
		    }
{DIGIT}+ {
		       printf("Digit: %s (%d)\n", yytext, atoi(yytext));
			writeToPIF(yytext, "DIGIT", 0);
		    }
{OPERATORS}+ {
		       printf("Operator: %s (%d)\n", yytext, atoi(yytext));
			writeToPIF(yytext, "OPERATORS", 0);
		    }
{SEPARATOR}+ {
		       printf("Separator: %s (%d)\n", yytext, atoi(yytext));
			writeToPIF(yytext, "SEPARATOR", 0);
		    }
{STRING}+ {
		       printf("String: %s (%d)\n", yytext, atoi(yytext));
			writeToPIF(yytext, "STRING", 0);
		    }


%%
#include <string.h>

int pozPIF;
int pozST;

void writeToPIF(char str[], char type[], int position) {
			FILE *pif_file;
			if (pif_file == NULL)
			{
    				printf("Error opening file!\n");
    				exit(1);
			}
			pif_file = fopen("pif.txt", "w");
			pif_file = freopen("pif.txt", "a", pif_file);
			

			if (strcmp(type, "NUMBER")==0)
				fprintf(pif_file, "%s       %d\n", str, pozPIF);
			if (strcmp(type, "DIGIT")==0)
				fprintf(pif_file, "%s       %d\n", str, pozPIF);
			if (strcmp(type, "IDENTIFIER")==0)
				fprintf(pif_file, "%d       %d\n", position, pozPIF);
			if (strcmp(type, "OPERATORS")==0)
				fprintf(pif_file, "%s       %d\n", str, pozPIF);
			if (strcmp(type, "SEPARATOR")==0)
				fprintf(pif_file, "%s       %d\n", str, pozPIF);
			if (strcmp(type, "STRING")==0)
				fprintf(pif_file, "%s       %d\n", str, pozPIF);
			pozPIF++;
			
}

int writeToST(char str[]) {
			FILE *st_file;
			char buff[1000];
			if (st_file == NULL)
			{
    				printf("Error opening file!\n");
    				exit(1);
			}
			st_file = fopen("st.txt", "r");
			while (fgets(buff, 1000, st_file)!=NULL) {}
			if (strstr(str, buff)!=NULL) {
				int ok=0;
				int pozSpace=0;
				for (int i=strstr(str, buff);i<1000 && ok==0;i++)
					if (buff[i]==' ')
						{ok=1; pozSpace=i;}
				return atoi(buff[pozSpace+1]);
				}
			else	
			{
				fclose(st_file);
				st_file = fopen("st.txt", "a");
				fprintf(st_file, "%s %d\n", str, pozST);
				pozST++;
				return pozST;
			}
}

main( argc, argv )
int argc;
char **argv;
    {
	pozST = 0;
	pozPIF = 0;
        ++argv, --argc;	
        if ( argc > 0 )
            yyin = fopen( argv[0], "r" );
        else
            yyin = stdin;
    yylex();
    }

#ifndef yywrap
   yywrap() { return 1; }
   #endif