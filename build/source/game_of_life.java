import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class game_of_life extends PApplet {




// factors of 1920:
// 1, 2, 3, 4, 5, 6, 8, 10, 12, 15, 16, 20, 24, 30, 32, 40, 48, 60, 64, 80, 96, 120, 128, 160, 192, 240, 320, 384, 480, 640, 960

// Factors of 1080
// 1, 2, 3, 4, 5, 6, 8, 9, 10, 12, 15, 18, 20, 24, 27, 30, 36, 40, 45, 54, 60, 72, 90, 108, 120, 135, 180, 216, 270, 360, 540


// how big the squares are
int gridWidth = 120;
int gridHeight = 108;

// the number of squares in both dimentions
int w = width / gridWidth;
int h = height / gridWidth;


class cell {
  // true = life
  // false = death
  boolean state;

  // pass value of neighbors and update cell status
  public void update(int neighbors) {

    if (state == true) {
      // lonely death
      if (neighbors < 2) {
        state = false;
      }
      // overpopulation
      else if (neighbors > 3) {
        state = false;
      }
    }
    else if (state == false) {
      // he is risen
      if (neighbors == 3) {
        state = true;
      }
    }
  }
}

class board {
  cell[][] grid = new cell[w][h];
  cell[][] next = new cell [w][h];
  // init constructor
  public void board() {
    for (int i = 0; i < w; i++) {
      for (int j = 0; j < h; j++) {
        if (random(10) > 5) {
            grid[i][j].state = true;
            next[i][j].state = true;
        }
        else {
          grid[i][j].state = false;
          next[i][j].state = false;
        }
      }
    }
  }

  // display gridlines
  public void gridLines() {

    fill(0, 255, 0);
    stroke(0, 255, 0);

    for (int i = 0; i < width; i+=gridWidth) {
      line(i, 0, i, height);
    }
    for (int j = 0; j < height; j+=gridHeight) {
      line(0, j, width, j);
    }
  }

  // render the cells
  public void gridDraw() {
    fill(0, 255, 0);
    stroke(0, 255, 0);

    for (int i = 0; i < w; i++) {
      for (int j = 0; j < h; j++) {
        if (grid[i][j].state) {
          int x = i * gridWidth;
          int y = j * gridHeight;
          rect(x, y, gridWidth, gridHeight);
          circle(x, y, 500);
        }
      }
    }

  }

  // update the cells
  public void gridUpdate() {
      for (int i = 0; i < w; i++) {
        for (int j = 0; j < h; j++) {

          int neighbors = 0;
          for (int k = -1; k <= 1; k++) {
            for (int l = -1; k <= 1; k++) {
              if (grid[i+k][j+l].state) {
                neighbors++;
              }
            }
            if (grid[i][j].state) neighbors--;
            next[i][j].update(neighbors);
          }
        }
      }

      for (int i = 0; i < w; i++) {
        for (int j = 0; j < w; j++) {
          grid[i][j] = next[i][j];
        }
      }
    }

}

board lifeBoard = new board();

public void setup() {
  
}






public void draw() {
  background(0);
  lifeBoard.gridLines();
  lifeBoard.gridDraw();
  lifeBoard.gridUpdate();
}
  public void settings() {  size(1920, 1080); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "game_of_life" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
