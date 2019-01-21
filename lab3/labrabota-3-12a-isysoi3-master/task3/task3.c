#define  _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <stdlib.h>

int main()
{
	char ch;
	FILE * fin = fopen("input.txt", "r");
	FILE* fout = fopen("output.txt", "w");

	if (fin != NULL)
	{
		while (!feof(fin))
		{
			ch = getc(fin);
			if (ch == 'M')
			{
				putc('m', fout);
			} else
			{
				putc(ch, fout);
			}
		}
	} else {
		printf("input file doesn`t exist\n");
		
        }

	fclose(fin);
	fclose(fout);

	return 0;
}


