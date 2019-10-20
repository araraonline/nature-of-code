size(200,200);

background(150);

translate(width/2,height/2);

// ears

noFill();
stroke(0);
strokeWeight(2);
ellipse(-41,-15,23,23);
ellipse(+41,-15,23,23);

// head oval

fill(255);
stroke(0);
strokeWeight(2);
ellipse(0,0,98,64);

// eyes

fill(255,69,0);
noStroke();
ellipse(-16,-5,16,16);
ellipse(+16,-5,16,16);

// mouth

noFill();
stroke(0);
strokeWeight(2);
arc(0,-7,54,54,radians(52.7),radians(180-52.7));


// antenna lines

stroke(0);
strokeWeight(2);
line(0,-32,8,-55);
line(8,-55,29,-51);

// antenna circle

noFill();
stroke(0);
strokeWeight(2);
ellipse(37,-49,16,16);
