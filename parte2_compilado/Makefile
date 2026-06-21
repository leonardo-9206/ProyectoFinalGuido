# Makefile del Proyecto Final UNIX
# compilando juego snake en C

#variables del compilador
CC = gcc
CFLAGS = -Wall -Wextra
LDFLAGS = -lncurses

#nombre del ejecutable final
TARGET = snake
SRC = snake.c

#si solo se pone make, regla principal
all: $(TARGET)

#para compilar C
$(TARGET): $(SRC)
	@echo "---------------------------------"
	@echo " Compilando el juego $(TARGET)..."
	@echo "----------------------------------"
	$(CC) $(CFLAGS) -o $(TARGET) $(SRC) $(LDFLAGS)

#para correr el juego asi directamente
run: $(TARGET)
	@echo "Arrancando el juego..."
	./$(TARGET)

#para limpiar los binarios antiguos
clean:
	@echo "Limpiando la carpeta de ejecutables..."
	rm -f $(TARGET)
.PHONY: all run clean
