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


// the number of squares in both dimentions
int w = 100;
int h = 60;

// how big the squares are
int gridWidth = width / w;
int gridHeight = height / h;


boolean[][] grid = new boolean[w] [h];


public void setup() {
  
  initializeGrid();
}


public void initializeGrid() {
  for (int i = 0; i < w; i++) {
    for (int j = 0; j < h; j++) {
      if (random(10) > 5) {
          grid[i][j] = true;
      }
      else {
        grid[i][j] = false;
      }
    }
  }
}

public void gridLines() {
  fill(0, 255, 0);
  for (int i = 0; i < width; i += gridWidth) {
    line(i, 0, i, height);
  }
  for (int j = 0; j < height; j += gridHeight) {
    line(0, j, width, j);
  }
}

public void gridDraw() {
  fill(0, 255, 0);

  for (int i = 0; i < w; i++) {
    for (int j = 0; j < h; j++) {
      if (grid[i][j]) {
        // remove repetitive calculations from rect
        int wPrime = i * gridWidth;
        int hPrime = j * gridHeight;

        rect(wPrime, hPrime, wPrime + gridWidth, hPrime + gridHeight);
      }
    }
  }
}


public void draw() {
  background(255, 255, 255);
  gridLines();
  // gridDraw();
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
