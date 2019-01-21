#include <sqlite3.h>
#include "BankSystem.h"
#include "Administrator.h"
#include <sqlite3.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

int getAccountCount(sqlite3* db,char* login){
    int n=0;  
    sqlite3_stmt *res;
    sqlite3_prepare_v2(db, "SELECT BANK_ACCOUNTS.id FROM  BANK_USERS INNER JOIN BANK_ACCOUNTS  ON BANK_USERS.client_id = BANK_ACCOUNTS.user_id WHERE    ( BANK_USERS.login = ?  )", -1, &res, 0);
    sqlite3_bind_text(res, 1, login,strlen(login),0);
    while(sqlite3_step(res)==SQLITE_ROW){
        
            n++;
    };  
    return n;
}
//эта штука не работает, не правильно число счета n находится.
int* getAccounts(sqlite3* db,char* login){
    char sql[MAX_QUERY_LENGTH];   
    char *zErrMsg = 0;
    sqlite3_stmt *res;
    int* accounts;
    
    sqlite3_prepare_v2(db, "SELECT BANK_ACCOUNTS.id FROM  BANK_USERS INNER JOIN BANK_ACCOUNTS  ON BANK_USERS.client_id = BANK_ACCOUNTS.user_id WHERE    ( BANK_USERS.login = ?  )", -1, &res, 0);
    sqlite3_bind_text(res, 1, login,strlen(login),0);
    
    int n=getAccountCount(db,login);
    accounts = calloc(n,sizeof(int));
    for(int i=0;i<n;i++){
        if(sqlite3_step(res)==SQLITE_ROW)   
            accounts[i]=sqlite3_column_int(res,0);
    };    
    return accounts;
}
int callbackAccountView(void *data, int argc, char **argv, char **azColName){
   int i;
   for(i = 0; i<argc; i++){
      printf("%s = %s ", azColName[i], argv[i] ? argv[i] : "NULL");
   }

   printf("\n");
   return 0;
}
int showClientAccounts(sqlite3* db, char* login){
    char sql[MAX_QUERY_LENGTH];
    sprintf(sql, "SELECT BANK_ACCOUNTS.id, balance from BANK_ACCOUNTS inner join BANK_USERS on BANK_ACCOUNTS.user_id=BANK_USERS.client_id where login=%s;", login);
    char* err_msg = 0;
    sqlite3_exec(db, sql, callbackAccountView, 0, &err_msg);
    return 0;
}
