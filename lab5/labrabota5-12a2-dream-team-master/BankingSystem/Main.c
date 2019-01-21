#include <sqlite3.h>
#include "Administrator.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "Operator.h"
#include "Client.h"
#include "BankSystem.h"
#define COM 0.05
#define OVER 200
extern int biChoice(char* firstOption, char* secondOption);
extern int getClientID(sqlite3*,int);
extern char* choose(char*,char **);
User currentUser;

int account;

int autorizationCallback(void *data, int argc, char **argv, char **azColName){
   if(strcmp(argv[0],""))   {
    strcpy(currentUser.firstname,argv[0]);
    strcpy(currentUser.secondname,argv[1]);
    strcpy(currentUser.lastname,argv[2]);
    strcpy(currentUser.login,argv[3]);
    strcpy(currentUser.type,argv[4]);
    currentUser.ID=atoi(argv[5]);   
    return 0;
   }
   return -1;
}
//не правильно - возвращает SQLITE_ABORT 
int authorization(sqlite3* db,char* login,char* password){
    char sql[MAX_QUERY_LENGTH];
    char *zErrMsg = 0;
    sprintf(sql,"SELECT firstname, secondname, lastname, login, type, id from BANK_USERS where login=\"%s\" AND password=\"%s\"",login,password);
    return sqlite3_exec(db, sql, autorizationCallback, 0, &zErrMsg);  
}


int chooseAccount(sqlite3* db,char* login){
    showClientAccounts(db,login);
    int option;
    int n=getAccountCount(db,login);
    int* accounts=getAccounts(db,login);
    do{
        printf("Choose account\n");
        for(int i=0;i<n;i++){
            printf("%d - id: %d\n",i+1,accounts[i]);
        }
        scanf("%d",&option);      
    }while(option<1 || option>n);  
    return accounts[option-1];
}
double comm(double sum){
        printf("Commission is %f. Continue?\n",sum*COM);
        if(biChoice("Yes","No")){
            return sum*COM;
        }
        return -1;
}
void clientMenu(sqlite3* db){
    char option;
    do{
        printf("1 - show balance\n");
        printf("2 - top up your balance\n");
        printf("3 - withdraw money\n");
        printf("4 - exit\n");
        printf("===========================\n");
        while(getchar()!='\n');
        option=getchar();
        double c;
        double sum;
        int acc;
        switch (option)
        {
            case '1': 
                showClientAccounts(db,currentUser.login);
                break;
            case '2':
                acc = chooseAccount(db,currentUser.login);
                printf("Enter sum\n");
                scanf("%lf",&sum);
                printf("%lf",sum);                
                if((c=comm(sum))!=-1){
                    credit(db,acc,sum-c);
                }
                break;
            case '3':
                
                acc = chooseAccount(db,currentUser.login);
                printf("Enter sum\n");
                scanf("%lf",&sum);
                printf("%lf %d ",sum,acc);   
                if((c=comm(sum))!=-1){
                    if(debit(db,acc,sum+c,OVER)==-1)
                        printf("Failed\n");
                }
                break;
        }
        printf("===========================\n");
    }while(option!='4');
}

int enterID(){
    int id;
    printf("Enter account id\n");
    scanf("%d",&id);
    return id;
}

void operatorMenu(sqlite3* db){
    char option;
    do{
        printf("1 - top up balance\n");
        printf("2 - withdraw money\n");
        printf("3 - transacion\n");
        printf("4 - exit\n");
        printf("===========================\n");
        while(getchar()!='\n');
        option=getchar();
        double c;
        double sum;
        int acc;
        int to;
        switch (option)
        {
            case '3': 
                acc = enterID();
                to = enterID();
                printf("Enter sum\n");
                scanf("%lf",&sum);
                if(transaction(db,acc,to,sum,OVER)!=0){
                    printf("Failed");
                }
                break;
            case '1':
                acc = enterID();
                printf("Enter sum\n");
                scanf("%lf",&sum);                
                if((c=comm(sum))!=-1){
                    credit(db,acc,sum-c);
                }
                break;
            case '2':                
                acc = enterID();
                printf("Enter sum\n");
                scanf("%lf",&sum);   
                if(debit(db,acc,sum,OVER)==-1)
                        printf("Failed\n");                
                break;
        }
        printf("===========================\n");
    }while(option!='4');

}
//==========================================ADMINISTRATOR============
void administratorMenu(sqlite3* db)
{
   
    char option;
    do{
        printf("2 - add user\n");
        printf("2 - add client\n");
        printf("3 - add account\n");
        printf("4 - close account\n");
        printf("5 - add/remove overdraft\n");
        printf("6 - change type of account\n");
        printf("7 - exit\n");
        printf("===========================\n");
        while(getchar()!='\n');
        option=getchar();
        int acc;
        int id;
        char* position[]={"OPERATOR","ADMINISTRATOR"};
        switch (option)
        {
            case '1':                
                addUser(db,enterUser(),choose("12",position));
                break;
            case '2':
                addClient(db,enterClient());
                break;
            case '3':
                id=enterID();
                openAccount(db,id);
                break;
            case '4':                
                id=enterID();
                printf("Are u sure?\n");
                if(biChoice("Yes","No"))
                closeAccount(db,id);
                break;
            case '5':
                id=enterID();           
                printf("Overdraft?\n");     
                setOverdraft(db,id,biChoice("Yes","No"));
                break;
            case '6':
                id=enterID();
                setAccountType(db,id,choose("12",types));
        }
        printf("===========================\n");
    }while(option!='7');  

}

void mainMenu(sqlite3* db){
    char login[FIELD_LENGTH];
    char password[FIELD_LENGTH];
    printf("Enter login\n");
    scanf("%s", login);
    printf("Enter password\n");
    scanf("%s", password);
    authorization(db,login,password);
    printf("============%s===========\n",currentUser.type);
    printf("===========================\n");
    if(!strcmp(currentUser.type,"CLIENT"))
        clientMenu(db);
    if(!strcmp(currentUser.type,"OPERATOR"))
        operatorMenu(db);    
    if(!strcmp(currentUser.type,"ADMINISTRATOR"))
        administratorMenu(db);
}


int main(){

    sqlite3 *db;
    int rc;
    rc = sqlite3_open("lab5_db.db", &db);

    if (rc != SQLITE_OK) {
        
        printf("1111");
        sqlite3_close(db);

        
        return 1;
    }
    mainMenu(db);
    //addClient(db,enterClient());
    //openAccount(db,1);
    //setAccountType(db,2,"SAVINGS");
    //setOverdraft(db,2,1);
    //showClientAccounts(db,"1");
    //changeBalance(db,3,-200);
    //closeAccount(db, 2);

    int* a;


    if (rc != SQLITE_OK ) {        
        printf("2222");
        sqlite3_close(db);
        return 1;
    } 
    sqlite3_close(db);
    return 0;
} 