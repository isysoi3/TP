#define  _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct mounth
{
	int days;
	int number;
	char short_name[4];
	char name[10];
} mounth;

mounth year_by_mounth[] = {
	{.name = "January",.days = 31,.short_name = "Jan",.number = 1 },
	{.name = "February",.days = 28,.short_name = "Feb",.number = 2 },
	{.name = "March",.days = 31,.short_name = "Mar",.number = 3 },
	{.name = "April",.days = 30,.short_name = "Apr",.number = 4 },
	{.name = "May",.days = 31,.short_name = "May",.number = 5 },
	{.name = "June",.days = 30,.short_name = "Jun",.number = 6 },
	{.name = "July",.days = 31,.short_name = "Jul",.number = 7 },
	{.name = "August",.days = 31,.short_name = "Aug",.number = 8 },
	{.name = "September",.days = 30,.short_name = "Sep",.number = 9 },
	{.name = "October",.days = 31,.short_name = "Oct",.number = 10 },
	{.name = "November",.days = 30,.short_name = "Nov",.number = 11 },
	{.name = "December",.days = 31,.short_name = "Dec",.number = 12 },
};

int is_leap(int year) {
	return  ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0);
}

int calculate(int mounth, int year)
{
	int days = 0;
	for (int i = 0; i < mounth-1; i++)
		days += year_by_mounth[i].days;
	if (mounth > 2 && is_leap(year))
		days++;
	return days;
}

int main()
{
	int day, mounth_number, year;
	char mounth_str[10];

	printf("Enter the day: ");
	scanf("%d", &day);
	printf("Enter the mount: ");
	scanf("%s", &mounth_str);
	printf("Enter the year: ");
	scanf("%d", &year);
	mounth_number = atoi(mounth_str);
	if (mounth_number == 0) {
		for (int i = 0; i < 12; i++)
		{
			if (strcmp(year_by_mounth[i].short_name, mounth_str) == 0 || strcmp(year_by_mounth[i].name, mounth_str) == 0)
			{
				mounth_number = year_by_mounth[i].number;
				break;
			}
		}
	}
	printf("Days since the beginig of the year is %d\n", calculate(mounth_number, year) + day);
	return 0;
}


