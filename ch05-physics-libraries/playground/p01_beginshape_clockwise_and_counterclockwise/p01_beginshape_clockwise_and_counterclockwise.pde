// Processing vertex() works in both clockwise and counter-clockwise order

size(200,200);
background(255);

// clockwise

fill(175);
stroke(0);

beginShape();
vertex(20,20);
vertex(40,20);
vertex(40,40);
vertex(20,40);
endShape(CLOSE);

// counter-clockwise

fill(175,0,0);
stroke(0);

translate(50,50);

beginShape();
vertex(20,20);
vertex(20,40);
vertex(40,40);
vertex(40,20);
endShape(CLOSE);
