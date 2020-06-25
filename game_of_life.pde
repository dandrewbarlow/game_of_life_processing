
// the number of squares in both dimentions
int w = 100;
int h = 60;

// how big the squares are
int gridWidth = width / w;
int gridHeight = height / h;


boolean[][] grid = new boolean[w] [h];


void setup() {
  size(1920, 1080);
  initializeGrid();
}


void initializeGrid() {
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

void gridLines() {
  fill(0, 255, 0);
  for (int i = 0; i < width; i += gridWidth) {
    line(i, 0, i, height);
  }
  for (int j = 0; j < height; j += gridHeight) {
    line(0, j, width, j);
  }
}

void gridDraw() {
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


void draw() {
  background(255, 255, 255);
  gridLines();
  // gridDraw();
}
