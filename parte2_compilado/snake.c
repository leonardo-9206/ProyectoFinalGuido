/* 
 * Simple Snake Game in C using ncurses
 * Original concept widely available on GitHub
 * Adapted for UNIX Final Project
 */

#include <ncurses.h>
#include <stdlib.h>
#include <unistd.h>
#include <time.h>

#define DELAY 100000 // Microseconds

int x, y, fruitX, fruitY, score;
int tailX[100], tailY[100];
int nTail;
int gameOver;

// Enum for directions
typedef enum { STOP = 0, LEFT, RIGHT, UP, DOWN } Direction;
Direction dir;

void Setup() {
    initscr();
    clear();
    noecho();
    cbreak();
    curs_set(0);
    nodelay(stdscr, TRUE);
    keypad(stdscr, TRUE);

    gameOver = 0;
    dir = STOP;
    x = COLS / 2;
    y = LINES / 2;
    srand(time(NULL));
    fruitX = rand() % COLS;
    fruitY = rand() % LINES;
    score = 0;
    nTail = 0;
}

void Draw() {
    clear();
    
    // Draw Top Wall
    for (int i = 0; i < COLS; i++) mvprintw(0, i, "#");

    for (int i = 1; i < LINES - 1; i++) {
        for (int j = 0; j < COLS; j++) {
            if (j == 0 || j == COLS - 1) {
                mvprintw(i, j, "#");
            } else if (i == y && j == x) {
                mvprintw(i, j, "O");
            } else if (i == fruitY && j == fruitX) {
                mvprintw(i, j, "F");
            } else {
                int printTail = 0;
                for (int k = 0; k < nTail; k++) {
                    if (tailX[k] == j && tailY[k] == i) {
                        mvprintw(i, j, "o");
                        printTail = 1;
                    }
                }
                if (!printTail) {
                    mvprintw(i, j, " ");
                }
            }
        }
    }

    // Draw Bottom Wall
    for (int i = 0; i < COLS; i++) mvprintw(LINES - 1, i, "#");

    mvprintw(LINES, 0, "Score: %d | Use Arrows to move, 'q' to quit", score);
    refresh();
}

void Input() {
    int ch = getch();
    switch (ch) {
        case KEY_LEFT:
            if (dir != RIGHT) dir = LEFT;
            break;
        case KEY_RIGHT:
            if (dir != LEFT) dir = RIGHT;
            break;
        case KEY_UP:
            if (dir != DOWN) dir = UP;
            break;
        case KEY_DOWN:
            if (dir != UP) dir = DOWN;
            break;
        case 'q':
        case 'Q':
            gameOver = 1;
            break;
    }
}

void Logic() {
    int prevX = tailX[0];
    int prevY = tailY[0];
    int prev2X, prev2Y;
    tailX[0] = x;
    tailY[0] = y;

    for (int i = 1; i < nTail; i++) {
        prev2X = tailX[i];
        prev2Y = tailY[i];
        tailX[i] = prevX;
        tailY[i] = prevY;
        prevX = prev2X;
        prevY = prev2Y;
    }

    switch (dir) {
        case LEFT:  x--; break;
        case RIGHT: x++; break;
        case UP:    y--; break;
        case DOWN:  y++; break;
        default: break;
    }

    // Wall collision (wrap around or die, let's wrap around for now)
    if (x >= COLS - 1) x = 1; else if (x < 1) x = COLS - 2;
    if (y >= LINES - 1) y = 1; else if (y < 1) y = LINES - 2;

    // Tail collision
    for (int i = 0; i < nTail; i++) {
        if (tailX[i] == x && tailY[i] == y) {
            gameOver = 1;
        }
    }

    // Eat fruit
    if (x == fruitX && y == fruitY) {
        score += 10;
        fruitX = (rand() % (COLS - 2)) + 1;
        fruitY = (rand() % (LINES - 2)) + 1;
        nTail++;
    }
}

int main() {
    Setup();
    while (!gameOver) {
        Draw();
        Input();
        Logic();
        usleep(DELAY);
    }
    endwin();
    printf("Game Over! Final Score: %d\n", score);
    return 0;
}
