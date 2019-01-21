//
//  main.c
//  tp_test
//
//  Created by Ilya Sysoi on 02.03.2018.
//  Copyright © 2018 Ilya Sysoi. All rights reserved.
//


#include <stdio.h>
#include "string.h"

typedef int bool;
#define true 1
#define false 0
#define a 97
#define b 98
#define c 99
#define d 100
#define e 101
#define f 102

typedef struct seat {
    int id;
    int isReserved;
    char fullName[40];
} seat;

FILE *flight101read, *flight102read, *flight201read, *flight202read;
FILE *flight101write, *flight102write, *flight201write, *flight202write;

seat flight101[] = {
    {.id = 0, .isReserved = false, .fullName = ""},
    {.id = 1, .isReserved = false, .fullName = ""},
    {.id = 2, .isReserved = false, .fullName = ""},
    {.id = 3, .isReserved = false, .fullName = ""},
    {.id = 4, .isReserved = false, .fullName = ""},
    {.id = 5, .isReserved = false, .fullName = ""},
    {.id = 6, .isReserved = false, .fullName = ""},
    {.id = 7, .isReserved = false, .fullName = ""},
    {.id = 8, .isReserved = false, .fullName = ""},
    {.id = 9, .isReserved = false, .fullName = ""},
    {.id = 10, .isReserved = false, .fullName = ""},
    {.id = 11, .isReserved = false, .fullName = ""},
};

seat flight102[] = {
    {.id = 0, .isReserved = false, .fullName = ""},
    {.id = 1, .isReserved = false, .fullName = ""},
    {.id = 2, .isReserved = false, .fullName = ""},
    {.id = 3, .isReserved = false, .fullName = ""},
    {.id = 4, .isReserved = false, .fullName = ""},
    {.id = 5, .isReserved = false, .fullName = ""},
    {.id = 6, .isReserved = false, .fullName = ""},
    {.id = 7, .isReserved = false, .fullName = ""},
    {.id = 8, .isReserved = false, .fullName = ""},
    {.id = 9, .isReserved = false, .fullName = ""},
    {.id = 10, .isReserved = false, .fullName = ""},
    {.id = 11, .isReserved = false, .fullName = ""},
};

seat flight201[] = {
    {.id = 0, .isReserved = false, .fullName = ""},
    {.id = 1, .isReserved = false, .fullName = ""},
    {.id = 2, .isReserved = false, .fullName = ""},
    {.id = 3, .isReserved = false, .fullName = ""},
    {.id = 4, .isReserved = false, .fullName = ""},
    {.id = 5, .isReserved = false, .fullName = ""},
    {.id = 6, .isReserved = false, .fullName = ""},
    {.id = 7, .isReserved = false, .fullName = ""},
    {.id = 8, .isReserved = false, .fullName = ""},
    {.id = 9, .isReserved = false, .fullName = ""},
    {.id = 10, .isReserved = false, .fullName = ""},
    {.id = 11, .isReserved = false, .fullName = ""},
};

seat flight202[] = {
    {.id = 0, .isReserved = false, .fullName = ""},
    {.id = 1, .isReserved = false, .fullName = ""},
    {.id = 2, .isReserved = false, .fullName = ""},
    {.id = 3, .isReserved = false, .fullName = ""},
    {.id = 4, .isReserved = false, .fullName = ""},
    {.id = 5, .isReserved = false, .fullName = ""},
    {.id = 6, .isReserved = false, .fullName = ""},
    {.id = 7, .isReserved = false, .fullName = ""},
    {.id = 8, .isReserved = false, .fullName = ""},
    {.id = 9, .isReserved = false, .fullName = ""},
    {.id = 10, .isReserved = false, .fullName = ""},
    {.id = 11, .isReserved = false, .fullName = ""},
};

void printMenu() {
    printf("a)Show number of available seats.\n");
    printf("b)Show available seats.\n");
    printf("c)Show booked places in alphabetical order.\n");
    printf("d)Reserve a seat for a passenger.\n");
    printf("e)Unreserve seat.\n");
    printf("f)Exit.\n");
}

void initReadFiles() {
    flight101read = fopen("101.txt", "r");
    flight102read = fopen("102.txt", "r");
    flight201read = fopen("201.txt", "r");
    flight202read = fopen("202.txt", "r");
}

void closeReadFiles() {
    fclose(flight101read);
    fclose(flight102read);
    fclose(flight201read);
    fclose(flight202read);
}

void wrirteToFileInfo(FILE* file, seat plane[]) {
    for (int i = 0; i < 12; i++)
    {
        fprintf(file, "%d %d %s\n", plane[i].id, plane[i].isReserved, plane[i].fullName);
    }
}

void backup() {
    flight101write = fopen("101.txt", "w");
    flight102write = fopen("102.txt", "w");
    flight201write = fopen("201.txt", "w");
    flight202write = fopen("202.txt", "w");
    
    wrirteToFileInfo(flight101write, flight101);
    wrirteToFileInfo(flight102write, flight102);
    wrirteToFileInfo(flight201write, flight201);
    wrirteToFileInfo(flight202write, flight202);
    
    fclose(flight101write);
    fclose(flight102write);
    fclose(flight201write);
    fclose(flight202write);
    
    
}

void readFromFileFlightInfo(FILE *file, seat plane[]) {
    int k = 0;
    
    while (fscanf(file, "%d %d %s", &plane[k].id, &plane[k].isReserved, plane[k].fullName) > 0 && k < 12)
    {
        k++;
    }
}

int main(int argc, const char * argv[]) {
    char choose;
    bool flag = true;
    initReadFiles();
    readFromFileFlightInfo(flight101read, flight101);
    readFromFileFlightInfo(flight102read, flight102);
    readFromFileFlightInfo(flight201read, flight201);
    readFromFileFlightInfo(flight202read, flight202);

    
    while (flag == true) {
        printMenu();
        choose = getchar();
        switch (choose) {
            case a:
                countAllAvailableSeats();
                break;
            case b:
                showAvailableSeats();
                break;
            case c:
                showReservedSeats();
                break;
            case d:
                reserveSeat();
                break;
            case e:
                unreserveSeat();
                break;
            case f:
                flag = false;
                closeReadFiles();
                break;
            case EOF:
                printf("EOF error\n");
                flag = false;
                closeReadFiles();
                break;
        }
    }
    
    backup();
    
    return 0;
}
