#pragma once
#include <sqlite3.h>
#define FIELD_LENGTH 15
typedef struct User{
    int ID;
    char firstname[FIELD_LENGTH];
    char secondname[FIELD_LENGTH];
    char lastname[FIELD_LENGTH];
    char login[FIELD_LENGTH];
    char password[FIELD_LENGTH];
    char type[FIELD_LENGTH];
} User;

typedef struct Account{
    int ID;
    double balance;
} Account;

typedef struct Client{
    User user;
    char* address;
    char* phoneNumber;
    Account* accounts;
} Client;

int addClient(sqlite3* db, Client);
int addUser(sqlite3*,User,char*);
int openAccount(sqlite3*, int);
int closeAccount(sqlite3* db, int accountID);
int setAccountType(sqlite3* db, int accountID, char* type);
int setOverdraft(sqlite3* db, int accountID, int overdraft);
Client enterClient();
User enterUser();
int showClientInfo(sqlite3* db, char* login);
int showUserInfo(sqlite3* db, char* login);
