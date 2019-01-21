//
//  d.c
//  tp_test
//
//  Created by Ilya Sysoi on 03.03.2018.
//  Copyright © 2018 Ilya Sysoi. All rights reserved.
//

#include <stdio.h>

typedef int bool;
#define true 1
#define false 0
typedef struct seat {
    int id;
    int isReserved;
    char fullName[40];
} seat;


seat flight101[];
seat flight102[];
seat flight201[];
seat flight202[];


void reserveSeat()
{
    printf("Enter flight(101,102,201,202):");
    
    int flight;
    
    scanf("%d", &flight);
    
    printf("Enter number of place(from 0 to 11):");
    
    int number;
    
    scanf("%d", &number);
    
    getchar();
    
    printf("Enter your full name:");
    
    char fullname[50];
    
    gets(fullname);
    
    if (flight == 101)
    {
        strcpy(flight101[number].fullName, fullname);
        flight101[number].isReserved = true;
    }
    else if (flight == 102)
    {
        strcpy(flight102[number].fullName, fullname);
        flight102[number].isReserved = true;    }
    else if (flight == 201)
    {
        strcpy(flight201[number].fullName, fullname);
        flight201[number].isReserved = true;
    }
    else if (flight == 202)
    {
        strcpy(flight202[number].fullName, fullname);
        flight202[number].isReserved = true;
    }
    getchar();
}
