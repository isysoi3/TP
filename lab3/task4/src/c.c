//
//  c.c
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

void printListOfReserved(seat plane[]) {
    for (int i = 0; i < 12; i++)
    {
        if (plane[i].isReserved)
        {
            printf("%d\n", plane[i].id);
        }
    }
}

void showReservedSeats() {
    printf("List of reserved seats of flight 101:\n");
    printListOfAvailableSetsForPlane(flight101);
    
    printf("\nList of reserved seats of flight 102:\n");
    printListOfAvailableSetsForPlane(flight102);
    
    printf("\nList of reserved seats of flight 201:\n");
    printListOfAvailableSetsForPlane(flight201);
    
    printf("\nList of reserved seats of flight 202:\n");
    printListOfAvailableSetsForPlane(flight202);
}
