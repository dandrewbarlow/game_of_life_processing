


// factors of 1920:
// 1, 2, 3, 4, 5, 6, 8, 10, 12, 15, 16, 20, 24, 30, 32, 40, 48, 60, 64, 80, 96, 120, 128, 160, 192, 240, 320, 384, 480, 640, 960

// Factors of 1080
// 1, 2, 3, 4, 5, 6, 8, 9, 10, 12, 15, 18, 20, 24, 27, 30, 36, 40, 45, 54, 60, 72, 90, 108, 120, 135, 180, 216, 270, 360, 540

//Common factors:
// 1; 2; 3; 4; 5; 6; 8; 10; 12; 15; 20; 24; 30; 40; 60 and 120
int xMax = 1920;
int yMax = 1080;

// how big the squares are
int squareVal = 10;

int gridWidth = squareVal;
int gridHeight = squareVal;

// the number of squares in both dimentions
int w = xMax / gridWidth;
int h = yMax / gridWidth;

//which turn is it
int ticker = 0;

boolean recording = false;

// handle recording logic
void redLight() {
  if (recording) {
    // save the current frame
    saveFrame("./frames/frame_#####.png");
    // prep for a red coicle
    setRed();
  }
  else {
    // prep for green coicle
    setGreen();
  }
  ellipse(30, 30, 30, 30);
}


// Quick color shortcuts
void setRed() {
  fill(255, 0, 0);
}
void setBlue() {
  fill(0, 0, 255);
}
void setGreen() {
  fill(0, 255, 0);
}

class cells {
  // true = life
  // false = death
  boolean state;

  int x;
  int y;

  // pass value of neighbors and update cell status
  void update(int neighbors) {

    if (state == true) {
      // lonely death
      if (neighbors < 2) {
        state = false;
      }
      // overpopulation
      else if (neighbors > 3) {
        state = false;
      }
      else state = true;
    }
    else if (state == false) {
      // he is risen
      if (neighbors == 3) {
        state = true;
      }
      else state = false;
    }
  }
}

class board {
  cells[][] grid = new cells[w][h];
  cells[][] next = new cells[w][h];

  // init constructor
  void generate() {
    for (int i = 0; i < w; i++) {
      for (int j = 0; j < h; j++) {

        grid[i][j] = new cells();
        next[i][j] = new cells();

        grid[i][j].x = i;
        grid[i][j].y = j;

        next[i][j].x = i;
        next[i][j].y = j;


        if (random(10) > 5) {
          if (grid[i][j] != null) {
            grid[i][j].state = true;
            next[i][j].state = true;
          }
        }
        else {
          grid[i][j].state = false;
          next[i][j].state = false;
        }
      }
    }
  }

  // display gridlines
  void gridLines(boolean on) {
    if (on){
     stroke(0, 255, 0);

      for (int i = 0; i < xMax; i+=gridWidth) {
        line(i, 0, i, yMax);
      }
      for (int j = 0; j < xMax; j+=gridHeight) {
        line(0, j, xMax, j);
      }
    }
  }

  // abstract the rectangle drawing to an x-y coordinate system
  void drawRect(int x, int y) {
    rect(x * gridWidth, y * gridHeight, gridWidth, gridHeight);
  }

  // render the cells
  void gridDraw() {
    setGreen();

    for (int i = 0; i < w; i++) {
      for (int j = 0; j < h; j++) {

        if (grid[i][j] != null && grid[i][j].state) {
          drawRect(i, j);
        }

      }
    }

  }

  // update the cells
  void gridUpdate() {
      // go through grid
      for (int i = 0; i < w; i++) {
        for (int j = 0; j < h; j++) {

          // initialize value of neighbors at 0
          int neighbors = 0;

          // go through a 3x3 grid around the current cell and add the neighbors
          for (int k = -1; k <= 1; k++) {
            for (int l = -1; l <= 1; l++) {
              int x = i + k;
              int y = j + l;

              // check bounds b4 op
              if ( (x >= 0 && x < w) && (y >= 0 && y < h )) {

                // don't count the square itself as a neighbor
                if ( (grid[x][y].state == true) && (k != 0 || l != 0)) {
                  neighbors++;
              }}

          }}


          next[i][j].update(neighbors);
          
    }}
  }
  
  // go through and change the current board to the next val
  void gridSwap() {
    for (int i = 0; i < w; i++) {
      for (int j = 0; j < h; j++) {
        grid[i][j].state = next[i][j].state;
      }
    }
  }
  
}

board lifeBoard = new board();

void setup() {
  // referred as xMax and yMax in the code bc of weird stuff
  size(1920, 1080);
  lifeBoard.generate();
  noStroke();
}

// regenerate on the fly for testing and record the output
void keyPressed() {
  if (key == 'y' || key == 'Y') {
    lifeBoard.generate();
  }
  if (key == 'r' || key == 'R') {
    recording = !recording;
  }

}



void draw() {
  background(0);
  ticker++; //<>//

  lifeBoard.gridLines();
  lifeBoard.gridDraw();
  lifeBoard.gridUpdate();
  lifeBoard.gridSwap();
  redLight();

 }
