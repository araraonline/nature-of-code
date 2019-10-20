size(400,400);

background(150);

translate(width/2,height/2);

// ears

noFill();
stroke(0);
strokeWeight(2);
ellipse(-20.1,-8,12,12);
ellipse(+20.1,-8,12,12);

// head oval

fill(255);
stroke(0);
strokeWeight(2);
ellipse(0,0,49,32);

// eyes

fill(255,69,0);
noStroke();
ellipse(-8,-2.5,8,8);
ellipse(+8,-2.5,8,8);

// mouth

noFill();
stroke(0);
strokeWeight(2);
arc(0,-3.5,27,27,radians(52.7),radians(180-52.7));


// antenna lines

stroke(0);
strokeWeight(2);
line(0,-16,4,-27.5);
line(4,-27.5,14.5,-25.5);

// antenna circle

noFill();
stroke(0);
strokeWeight(2);
ellipse(18.5,-24.5,8,8);
