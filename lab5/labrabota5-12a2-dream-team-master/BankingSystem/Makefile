main: Main.o Administrator.o Operator.o Client.o
	gcc -o Main Main.o Administrator.o Operator.o Client.o -lsqlite3
Administrator.o: Administrator.c Administrator.h
	gcc -c -o Administrator.o Administrator.c
Main.o: Main.c
	gcc -c -o Main.o Main.c	
Operator.o: Operator.c Operator.h
	gcc -c -o Operator.o Operator.c	
Client.o: Client.c Client.h
	gcc -c -o Client.o Client.c	
Clear:
	rm -f *.o
