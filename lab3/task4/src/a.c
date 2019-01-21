//
//  a.c
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


int countFreeSeats(seat plane[]) {
    int count = 0;
    for (int i = 0; i < 12; i++)
        if (!plane[i].isReserved)
            count++;
    return count;
}

void countAllAvailableSeats() {
    int count = countFreeSeats(flight101) + countFreeSeats(flight102) + countFreeSeats(flight201) + countFreeSeats(flight202);
    
    printf("Free places: %d\n", count);
    getchar();
}
