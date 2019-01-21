#include "BankSystem.h"
#include <sqlite3.h>
#include <stdlib.h>
#include <stdio.h>

extern int callback(void *data, int argc, char **argv, char **azColName);


int changeBalance(sqlite3* db, int accountID, double value){
    char sql[MAX_QUERY_LENGTH];
    sprintf(sql, "UPDATE BANK_ACCOUNTS SET balance=balance+%f where id=%d;", value, accountID);    
    char* mes;
    sqlite3_exec(db, sql, NULL, 0, &mes);
    printf("%s",mes);
    return 0;
}

// Проверяет наличие аккаунта в базе
int isAccountExist(sqlite3* db,int accountID){
    sqlite3_stmt *res;
    sqlite3_prepare_v2(db, "SELECT * from BANK_ACCOUNTS where id=?;", -1, &res, 0);
    sqlite3_bind_int(res, 1, accountID);
    sqlite3_step(res);
    int isExist=sqlite3_data_count(res);
    sqlite3_finalize(res);
    return isExist;
}
//возвращает 0, если аккаунта не существует, поэтому аккуратно
double getBalance(sqlite3* db,int accountID){
    sqlite3_stmt *res;
    sqlite3_prepare_v2(db, "SELECT balance from BANK_ACCOUNTS where ID=?;", -1, &res, 0);
    sqlite3_bind_int(res, 1, accountID);
   //если аккаунт существует возвращает SQLITE3_ROW
    double balance = sqlite3_column_double(res, 0);
    sqlite3_finalize(res);
    return balance;
}
//
int canOverdraft(sqlite3* db,int accountID){
    sqlite3_stmt *res;
    sqlite3_prepare_v2(db, "SELECT overdraft from BANK_ACCOUNTS where ID=?;", -1, &res, 0);
    sqlite3_bind_int(res, 1, accountID);
    sqlite3_step(res);//если аккаунт существует возвращает SQLITE_ROW
    int overdraft = sqlite3_column_int(res, 0);
    sqlite3_finalize(res);
    return overdraft;
}
double getBalanceSum(sqlite3* db,int clientID){
    sqlite3_stmt *res;
    sqlite3_prepare_v2(db, "SELECT SUM (balance) from BANK_ACCOUNTS inner join BANK_CLIENTS on BANK_ACCOUNTS.user_id=BANK_CLIENTS.id where BANK_CLIENTS.id=?;", -1, &res, 0);
    sqlite3_bind_int(res, 1, clientID);
    if(sqlite3_step(res)!=SQLITE_ROW)
    return -1;//если аккаунт существует возвращает SQLITE_ROW
    double overdraft = sqlite3_column_double(res, 0);
    sqlite3_finalize(res);
    return overdraft;
}
int getClientID(sqlite3* db,int accountID){
    sqlite3_stmt *res;
    sqlite3_prepare_v2(db, "SELECT user_id from BANK_ACCOUNTS where id=?;", -1, &res, 0);
    sqlite3_bind_int(res, 1, accountID);
    sqlite3_step(res);//если аккаунт существует возвращает SQLITE3_ROW
    int ID = sqlite3_column_int(res, 0);
    sqlite3_finalize(res);
    return ID;
}
//====================================================================================================================
//Сумма должна быть положительна, аккаунт сществовать, денег хватать. Возвращает 0 если все ок.
// Возможно, лучше поместить эти проверки в changeBalance(),тк как они проверяются в трех следующих методах,но это на любителя=)
int debit(sqlite3* db, int accountID, double value,double maxOverdrive){    
    int userID=getClientID(db,accountID);
    if(value>0 && isAccountExist(db, accountID)){
        double balance = getBalanceSum(db,userID);
        if(balance>=value){
            changeBalance(db,accountID,-value);
            return 0;
        }
        else{

            if(canOverdraft(db,accountID) && (getBalanceSum(db,getClientID(db,accountID))-value) >= -maxOverdrive){                          
                changeBalance(db,accountID,-value);   
                return 0;
            }
        }
    }
    return -1;
}
// Аналогичные требования, что и к debit()
int transaction(sqlite3* db, int fromID,int toID,double value,double maxOverdrive){
    if(value>0 && isAccountExist(db, toID) && debit(db,fromID,value,maxOverdrive)==0){
        changeBalance(db,toID,value);
        return 0;
    }
    return -1;
}
// Без коментариев=)
int credit(sqlite3* db,int accountID,double value){
    if(value>0 && isAccountExist(db, accountID)){
        changeBalance(db,accountID,value);
        return 0;
    }
    return -1;
}
//=========================================================================================================