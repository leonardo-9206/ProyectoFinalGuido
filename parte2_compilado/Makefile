CC = gcc
CFLAGS = -Wall -Wextra
LDFLAGS = -lncurses
TARGET = snake
SRC = snake.c

all: $(TARGET)

$(TARGET): $(SRC)
	@echo "Compilando $(TARGET)..."
	$(CC) $(CFLAGS) -o $(TARGET) $(SRC) $(LDFLAGS)

run: $(TARGET)
	@echo "Ejecutando $(TARGET)..."
	./$(TARGET)

clean:
	@echo "Limpiando archivos compilados..."
	rm -f $(TARGET)

.PHONY: all run clean
