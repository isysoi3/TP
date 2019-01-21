#include "Administrator.h"
#include "BankSystem.h"
#include <sqlite3.h>
#include <stdio.h>
#include <string.h>

char* types[2]={"CHECKING","SAVINGS"};

int callback(void *data, int argc, char **argv, char **azColName){
   int i;
   for(i = 0; i<argc; i++){
      printf("%s = %s\n", azColName[i], argv[i] ? argv[i] : "NULL");
   }

   printf("\n");
   return 0;
}

User enterUser(){
    User newUser;
    printf("Enter firstname\n");
    scanf("%s",newUser.firstname);
    printf("Enter secondname\n");
    scanf("%s",newUser.secondname);
    printf("Enter lastname\n");
    scanf("%s",newUser.lastname);
    printf("Enter login\n");
    scanf("%s",newUser.login);
    printf("Enter password\n");
    scanf("%s",newUser.password);
    return newUser;
}

Client enterClient(){
    Client newClient;
    newClient.user=enterUser();
    strcpy(newClient.user.type,"CLIENT");
     //scanf("%s",newClient->address);
    //scanf("%s",newClient->phoneNumber);
    newClient.accounts = NULL;
    //TODO: add photo
    //вставить фото
    //FILE *fp = fopen("/Users/home/Documents/Misha/PrTech/labs/lab4/task5/user.jpg", "rb");
    //пока так
    return newClient;
}

int addClient(sqlite3* db, Client newClient){
    char sql[MAX_QUERY_LENGTH];
    char *zErrMsg = 0;
    sqlite3_exec(db, "INSERT INTO BANK_CLIENTS (photo) VALUES (NULL) ", callback, 0, &zErrMsg);
    int last = sqlite3_last_insert_rowid(db);
    sprintf(sql,"INSERT INTO BANK_USERS (client_id, firstname, secondname, lastname, login, password, type) VALUES (%d, \"%s\", \"%s\", \"%s\", \"%s\", \"%s\", \"%s\");", last, newClient.user.firstname, newClient.user.secondname, newClient.user.lastname, newClient.user.login, newClient.user.password, "CLIENT");
    return sqlite3_exec(db, sql, callback, 0, &zErrMsg);
}

int addUser(sqlite3* db, User newClient,char* type){
    char sql[MAX_QUERY_LENGTH];
    char *zErrMsg = 0;
    sprintf(sql,"INSERT INTO BANK_USERS (firstname, secondname, lastname, login, password, type) VALUES ( \"%s\", \"%s\", \"%s\", \"%s\", \"%s\", \"%s\");", newClient.firstname, newClient.secondname, newClient.lastname, newClient.login, newClient.password, type);
    return sqlite3_exec(db, sql, callback, 0, &zErrMsg);
}

char* choose(char* buttons, char** values){
    int length = strlen(buttons);
    char c = '0';
    char* cp;
    do {
    for(int i = 0; i < length; i++)
        printf("%c - %s\n",buttons[i],values[i]);
        while(getchar()!='\n');
        c = getchar();
    } while((cp = strchr(buttons,c)) == NULL);
    return values[cp-buttons];
}

int biChoice(char* firstOption, char* secondOption){
    char c;
    do {
        printf("%c - %s\n",'1',firstOption);
        printf("%c - %s\n",'1',secondOption);
        while(getchar() != '\n');
        c = getchar();
    } while(c != '1' && c != '2');
    return c == '1';
}

void showError(char* err_msg){
    printf("SQL error: %s\n", err_msg);
}

int openAccount(sqlite3* db, int userID){
    printf("Enter type of account\n");
    char* type = choose("12",types);
    printf("Overdraft?\n");
    int isOverdraft = biChoice("Yes","No");
    char sql[MAX_QUERY_LENGTH];
    sprintf(sql,"INSERT INTO BANK_ACCOUNTS (user_id, type, balance, overdraft,percentage_id) VALUES (%d, \"%s\", \"%d\", \"%d\", \"%d\");",userID,type,0,isOverdraft,0);
    char* err_msg = 0;
    return sqlite3_exec(db, sql, callback, 0, &err_msg);
 }

int closeAccount(sqlite3* db, int accountID)
{
    char sql[MAX_QUERY_LENGTH];
    sprintf(sql, "DELETE from BANK_ACCOUNTS where id=%d;", accountID);
    char* err_msg = 0;
    sqlite3_exec(db, sql, callback, 0, &err_msg);
    showError(err_msg);
    return 0;
}

//Тут нет проверки, существует ли вообще передаваемый тип
int setAccountType(sqlite3* db, int accountID, char* type){
    char sql[MAX_QUERY_LENGTH];

    sprintf(sql, "UPDATE BANK_ACCOUNTS SET type=\"%s\" where ID=%d;", type, accountID);
    char* err_msg = 0;
    return sqlite3_exec(db, sql, callback, 0, &err_msg);
}

int setOverdraft(sqlite3* db, int accountID, int overdraft){
    char sql[MAX_QUERY_LENGTH];
    sprintf(sql, "UPDATE BANK_ACCOUNTS SET overdraft=%d where ID=%d;", overdraft, accountID);
    char* err_msg = 0;
    return sqlite3_exec(db, sql, callback, 0, &err_msg);
}

int showUserInfo(sqlite3* db, char* login){
    char sql[MAX_QUERY_LENGTH];
    sprintf(sql, "SELECT firstname, secondname, lastname from BANK_USERS where login=\"%s\";", login);
    char* err_msg = 0;
    sqlite3_exec(db, sql, callback, 0, &err_msg);
    showError(err_msg);
    return 0;
}

int showClientInfo(sqlite3* db, char* login){
    char sql[MAX_QUERY_LENGTH];
    sprintf(sql, "SELECT firstname, secondname, lastname, photo from BANK_USERS inner join BANK_CLIENTS on BANK_USERS.client_id=BANK_CLIENTS.id where login=\"%s\";", login);
    char* err_msg = 0;
    sqlite3_exec(db, sql, callback, 0, &err_msg);
    showError(err_msg);
    return 0;
}

//

