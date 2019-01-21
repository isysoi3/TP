#include <time.h>
#include <stdio.h>


int main() {
    int day, mon, year, hour, mins;
    struct tm birthday;
    time_t rawtime;
    int result;
    
    printf("Enter the date of your birtday in format dd.mm.yyyy hh:mm\n");
    scanf("%d.%d.%d %d:%d", &day, &mon, &year, &hour, &mins);
    time(&rawtime);
    birthday = *localtime(&rawtime);
    birthday.tm_year = year - 1900;
    birthday.tm_mon = mon - 1;
    birthday.tm_mday = day;
    birthday.tm_hour = hour;
    birthday.tm_min = mins;
    mktime(&birthday);
    result = (int)difftime(rawtime, mktime(&birthday));

    printf("You are living %d seconds\n", result);

    return 0;
}