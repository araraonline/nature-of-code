// take a look at multiplier 40!

int CELL_SIZE = 100;
int NROWS = 5;
int NCOLS = 10;

int N_PARTICLES = 50;
float PARTICLE_AMPLITUDE = 40;
float PARTICLE_SPEED = 0.015*2;

ArrayList<ParticleSystem> systems = new ArrayList<ParticleSystem>();

void settings() {
  size(CELL_SIZE*NCOLS,CELL_SIZE*NROWS);
}

void setup() {
  frameRate(30);
  background(1,0,1);
  
  for (int y = 0; y < CELL_SIZE*NROWS; y += CELL_SIZE) {
    for (int x = 0; x < CELL_SIZE*NCOLS; x += CELL_SIZE) {
      systems.add(new ParticleSystem(x+CELL_SIZE/2,y+CELL_SIZE/2,x/CELL_SIZE+y/CELL_SIZE*NCOLS));
    }
  }
}

void draw() {
  //background(1,0,1);
  
  for (ParticleSystem ps: systems)
    ps.display();
    
  for (ParticleSystem ps: systems)
    ps.update();
    
  if (frameCount % 20 == 0) println(frameRate);
}
