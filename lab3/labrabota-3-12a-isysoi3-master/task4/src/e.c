//
//  e.c
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

void unreserveSeat()
{
    printf("Enter flight(101,102,201,202):");
    
    int flight;
    
    scanf("%d", &flight);
    
    printf("Enter number of place:");
    
    int number;
    
    scanf("%d", &number);
    
    getchar();
    
    if (flight == 101)
    {
        strcpy(flight101[number].fullName, "");
        flight101[number].isReserved = true;
    }
    else if (flight == 102)
    {
        strcpy(flight102[number].fullName, "");
        flight102[number].isReserved = true;
    }
    else if (flight == 201)
    {
        strcpy(flight201[number].fullName, "");
        flight201[number].isReserved = true;
    }
    else if (flight == 202)
    {
        strcpy(flight202[number].fullName, "");
        flight202[number].isReserved = true;
    }
    
    getchar();
}
