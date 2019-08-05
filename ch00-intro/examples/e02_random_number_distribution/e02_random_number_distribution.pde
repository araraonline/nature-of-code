int[] counts;

void setup() {
  size(640,240);
  counts = new int[20];
}

void draw() {
  // chose random number
  int randomNumber = int(random(counts.length));
  
  // add to counts
  counts[randomNumber] = counts[randomNumber]+1;

  // draw bars
  background(255);
  stroke(0);
  fill(175);
  int barWidth = width/counts.length;
  for (int i = 0; i < counts.length; i++) {
    int x = barWidth*i;
    int y = height-counts[i]+1;
    int barHeight = counts[i];
    rect(x,y,barWidth-1,barHeight); // without the -1, the bars come on top of each other (why?)
  }
}
