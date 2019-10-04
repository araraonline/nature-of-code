size(500,500);
background(0); // turn this off to see the shape of the squares


// EXPERIMENT 1
// odd strokeWeights produce crispier squares
// square disappears when strokeWeight >= side

rectMode(CENTER);

float sw = 1;
for (int y = 20; y < height - 20; y += 40) {
  strokeWeight(sw);
  rect(50,y,20,20);
  sw++;
}

for (int y = 20; y < height - 20; y += 40) {
  strokeWeight(sw);
  rect(100,y,20,20);
  sw++;
}


// EXPERIMENT 2
// the stroke goes half inside and half outside the square, but,
// if it gets big, it grows outwards only

noStroke();
fill(0,0,255);
rect(300,100,20,20);

stroke(255,100);
strokeWeight(5);
noFill();
rect(300,100,20,20);
