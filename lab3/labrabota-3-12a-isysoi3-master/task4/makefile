# Makefile for MinskAirLines

CC=gcc
SRC=./src
BIN=./bin
BUILD=./build
MKDIR_P = mkdir -p

all: directories $(BIN)/task4 

directories: $(BUILD) $(BIN)

$(BIN):
	${MKDIR_P} $(BIN)

$(BUILD):
	${MKDIR_P} $(BUILD)

$(BIN)/task4: $(BUILD)/main.o $(BUILD)/a.o $(BUILD)/b.o $(BUILD)/c.o $(BUILD)/d.o $(BUILD)/e.o 
	$(CC) $(SRC)/main.c $(SRC)/a.c $(SRC)/b.c $(SRC)/c.c $(SRC)/d.c $(SRC)/e.c -o $(BIN)/task4

$(BUILD)/a.o: $(SRC)/a.c
	$(CC) -c $(SRC)/a.c -o $(BUILD)/a.o

$(BUILD)/b.o: $(SRC)/b.c
	$(CC) -c $(SRC)/b.c -o $(BUILD)/b.o

$(BUILD)/c.o: $(SRC)/c.c
	$(CC) -c $(SRC)/c.c -o $(BUILD)/c.o

$(BUILD)/d.o: $(SRC)/d.c
	$(CC) -c $(SRC)/d.c -o $(BUILD)/d.o

$(BUILD)/e.o: $(SRC)/e.c
	$(CC) -c $(SRC)/e.c -o $(BUILD)/e.o

$(BUILD)/main.o: $(SRC)/main.c
	$(CC) -c $(SRC)/main.c -o $(BUILD)/main.o

clean:
	rm -rf $(BUILD)/*.o $(BIN)/task4