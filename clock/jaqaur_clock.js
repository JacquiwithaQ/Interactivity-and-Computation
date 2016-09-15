//The function called "collision" is based on the code from "Bouncing Bubbles" by Keith Peters, Ira Greenberg, and Dan Shiffman.
//The functions "update," "bouncy," and "applyForce" are based on the "Forces example code from the p5.js website.

//These RGB values will be changed before being used anyway.
var r = 200;
var g = 150;
var b = 100;
var radius = 40; //minimum radius of all balls
var growth = 100; //universal growth factor
var hourGrow = 3; //growth factor for hours (max size is hourGrow * growth)
var minuteGrow = 1.6; //growth factor for minutes (max size is minuteGrow * growth)
var secondGrow = 0.8; //growth factor for seconds (max size is secondGrow * growth)
//Here are some temporary variables to be used here and there
var tempX = 0;
var tempY = 0;
var hours = [];
var mins = [];
var secs = [];
var tempHour = 0;
var numName = "";
var minDist = 1;
//Here ends the temporary variables
var grav = 1; //force of gravity
var damper = 0.9; //how much the balls' velocity slows every step
var spring = 0.95; //how much the balls are allowed to overlap (functions very similarly to damper, but is not quite the same)
var buffer = 5; //mandatory space between balls

function setup() {
  createCanvas(700,700);
  //This little formula makes sure that whatever random color the numbers are, it isn't too dark or too ugly.
  r = random(50,205);
  g = (255-r);
  if (115<r && r<135){
    b = random(185,205);
    if (random(0,1)>=0.5){
      r = r-30;
    } else {
      g = g-30;
    }
  } else if (90<r&& r<170){
    b = random(155,205);
  } else{
    b = random(80,125);
  }
  dropNumbers();
}

function draw() {
  background(0,0,0);
  if (hour()>12){
    tempHour = hour()-12;
  } else if (hour()==0 || hour()==24){
    tempHour = 12;
  }else{
    tempHour = hour();
  }
  for (var pos=0; pos<12; pos++){
    // Tells things to grow or shrink if needed
    if (tempHour==pos+1){
      if (hours[pos].size < radius+(growth*hourGrow)){
        hours[pos].growing = true;
        hours[pos].shrinking = false;
      } else {
        hours[pos].shrinking = false;
        hours[pos].growing = false;
      }
    }else{
      if (hours[pos].size > radius){
        hours[pos].shrinking = true;
        hours[pos].growing = false;
      } else {
        hours[pos].shrinking = false;
        hours[pos].growing = false;
      }
    } 
    //Applies growing and shrinking
    if (hours[pos].shrinking){
      hours[pos].size = hours[pos].size*0.997;
    }
    if (hours[pos].growing){
      hours[pos].size = hours[pos].size*(1/0.997);
    }
    var gravity = createVector(0, 1);
    // Apply gravity
    hours[pos].applyForce(gravity);
    // Update and display
    hours[pos].update();
    hours[pos].display(str(pos+1));
    hours[pos].bouncy();
    //Here we make everything bounce off of everything else
    for (var place=0; place<12; place++){
      if (place!=pos){
        collision (hours[pos], hours[place]);
      }
    }
    for (var place=0; place<=59; place++){
      collision (hours[pos], mins[place]);
    }
    for (var place=0; place<=59; place++){
        collision (hours[pos], secs[place]);
    }
  }
  for (var pos=0; pos<=59; pos++){
    // Tells things to grow or shrink if needed
    if (minute()==pos){
      if (mins[pos].size < radius+(growth*minuteGrow)){
        mins[pos].growing = true;
        mins[pos].shrinking = false;
      } else {
        mins[pos].shrinking = false;
        mins[pos].growing = false;
      }
    }else {
      if (mins[pos].size > radius){
        mins[pos].shrinking = true;
        mins[pos].growing = false;
      } else{
        mins[pos].shrinking = false;
        mins[pos].growing = false;
      }
    }
    //Applies growing and shrinking
    if (mins[pos].shrinking){
      mins[pos].size = mins[pos].size*0.995;
    }
    if (mins[pos].growing){
      mins[pos].size = mins[pos].size*(1/0.995);
    }
    var gravity = createVector(0, grav);
    // Apply gravity
    mins[pos].applyForce(gravity);
    // Update and display
    mins[pos].update();
    if (pos<10){
      numName = "0" + str(pos);
    } else {
      numName = str(pos);
    }
    mins[pos].display(numName);
    mins[pos].bouncy();
    //Here we make everything bounce off of everything else
    for (var place=0; place<12; place++){
      collision (mins[pos], hours[place]);
    }
    for (var place=0; place<=59; place++){
      if (place!=pos){
        collision (mins[pos], mins[place]);
      }
    }
    for (var place=0; place<=59; place++){
        collision (mins[pos], secs[place]);
    }
  }
  for (var pos=0; pos<=59; pos++){
    // Tells things to grow or shrink if needed
    if (second()==pos){
      if (secs[pos].size < (radius+(growth*secondGrow))){
        secs[pos].growing = true;
        secs[pos].shrinking = false;
      } else {
        secs[pos].shrinking = false;
        secs[pos].growing = false;
      }
    }else {
      if (secs[pos].size > radius){
        secs[pos].shrinking = true;
        secs[pos].growing = false;
      } else {
        secs[pos].shrinking = false;
        secs[pos].growing = false;
      }
    }
    //Applies growing and shrinking
    if (secs[pos].shrinking){
      //secs[pos].size = secs[pos].size-1;
      secs[pos].size *= 0.95;
    }
    if (secs[pos].growing){
      secs[pos].size *= 1.0/0.95; 
      //secs[pos].size = secs[pos].size+1;
    }
    var gravity = createVector(0, 1);
    // Apply gravity
    secs[pos].applyForce(gravity);
    // Update and display
    secs[pos].update();
    if (pos<10){
      numName = "0" + str(pos);
    } else {
      numName = str(pos);
    }
    secs[pos].display(numName);
    secs[pos].bouncy();
    //Here we make everything bounce off of everything else
    for (var place=0; place<12; place++){
      collision (secs[pos], hours[place]);
    }
    for (var place=0; place<=59; place++){
      collision (secs[pos], mins[place]);
    }
    for (var place=0; place<=59; place++){
      if (place!=pos){
        collision (secs[pos], secs[place]);
      }
    }
  }
}

function dropNumbers(){
  hours = [];
  mins = [];
  secs = [];
  //makes sure we are in 12 hour time #'MURICA!
  if (hour()>12){
    tempHour = hour()-12;
  } else if (hour()==0){
    tempHour = 12;
  }else{
    tempHour = hour();
  }
  //creates all of the hour balls at ta random location above the canvas
  for (var h=1; h<=12; h++){
    tempX = random(50, 650);
    tempY = random(-500, -20);
    if (tempHour==h){
      tempSize = radius + (growth*2.4);
    }  else {
      tempSize = radius;
    }
    hours.push(new Ball("hour", tempX, tempY, tempSize));
  }
  //creates all of the minute balls at ta random location above the canvas
  for (var m=0; m<=59; m++){
    tempX = random(50, 650);
    tempY = random(-500, -20);
    if (minute()==m){
      tempSize = radius + (growth*1.6);
    }  else {
      tempSize = radius;
    }
    mins.push(new Ball("min", tempX, tempY, tempSize));
  }
  //creates all of the second balls at ta random location above the canvas
  for (var s=0; s<=59; s++){
    tempX = random(50, 650);
    tempY = random(-500, -20);
    if (second()==s){
      tempSize = radius + (growth*0.6);
    }  else {
      tempSize = radius;
    }
    secs.push(new Ball("sec", tempX, tempY, tempSize));
  }
}

function Ball(kind, x, y, size){
  this.kind = kind;
  this.size = size;
  this.growing = false;
  this.shrinking = false;
  this.position = createVector(x,y);
  this.velocity = createVector(0,0);
  this.acceleration = createVector(0,0);
}

Ball.prototype.applyForce = function(force) {
  var f = p5.Vector.div(force,1);
  this.acceleration.add(f);
};

Ball.prototype.display = function(number){
    drawTextSize = 30;
    strokeWeight(0);
    var fillValue = 0;
    fill(25,25,25,255);
    ellipse(this.position.x,this.position.y,this.size,this.size);
    var drawTextSize = 1.0; 
    if (this.kind=="hour"){
      //the hours are lightest-colored
      fill(r+50, g+50, b+50);
    } else if (this.kind=="min"){
      //the minutes are medium-colored
      fill(r,g,b);
    } else {
      //the seconds are darkest
      fill(r-50,g-50,b-50);
    }
    drawTextSize = 50;
    textSize(drawTextSize);
    //this little section of code decides what font size the number should be written in based on the size of its ball
    if (number.length<2){
    while(textWidth(number)<this.size*0.6){
        //when I incremented by just 1, the whole thing ran much slower
        drawTextSize += 2;
        textSize(drawTextSize);
      }
      while(textWidth(number)>this.size*0.6){
        drawTextSize -= 2;
        textSize(drawTextSize);
      }
    } else {
        while(textWidth(number)<this.size*0.8){
        drawTextSize += 2;
        textSize(drawTextSize);
      }
      while(textWidth(number)>this.size*0.8){
        drawTextSize -= 2;
        textSize(drawTextSize);
      }
    }
    textSize(drawTextSize*0.8);
    textAlign(CENTER, CENTER);
    text(number, this.position.x, this.position.y);
    //the following commented out part was/is for debugging.
   // if (((mouseX > this.position.x-10)&&(mouseX < this.position.x+10)) && ((mouseY > this.position.y-10)&&(mouseY < this.position.y+10))){
    //  console.log("The number is " + number + ". The size is " + str(this.size) + ". The velocities are " +this.velocity.x + "and " +this.velocity.y);
    //}
  };

Ball.prototype.update = function(){
  // Velocity changes according to acceleration
  this.velocity.add(this.acceleration);
  if (this.velocity.x<-2){
    this.velocity.x = -2;
  } else if (this.velocity.x>2){
    this.velocity.x = 2;
  }
  if (this.velocity.y<-2){
    this.velocity.y = -2;
  } else if (this.velocity.y>40){
    this.velocity.y = 40;
  }
  // position changes by velocity
  this.position.add(this.velocity);
  // We must clear acceleration each frame
  this.acceleration.mult(0);
};

Ball.prototype.bouncy = function() {
  if (this.position.y > (700 - this.size/2)) {
     //A little dampening when hitting the bottom
    this.velocity.y *= -0.3;
    this.position.y = (700 - this.size/2);
  }
  if (this.position.x > (700 - this.size/2)) {
    // A little dampening when hitting the right side
    this.velocity.x *= -0.3;
    this.position.x = (700 - this.size/2);
  }
  if (this.position.x < (this.size/2)) {
    // A little dampening when hitting the left side
    this.velocity.x *= -0.3;
    this.position.x = (this.size/2);
  }
};

function collision(me, you){
  var distance = sqrt(((me.position.x-you.position.x)*(me.position.x-you.position.x))+((me.position.y-you.position.y)*(me.position.y-you.position.y)));
  var minDist = ((you.size+me.size)/2)+buffer;
  if (distance<=(minDist)){
    var angle = atan2((you.position.y-me.position.y), (you.position.x-me.position.x));
    var targetX = me.position.x + cos(angle) * minDist;
    var targetY = me.position.y + sin(angle) * minDist;
    var ax = (targetX - you.position.x) * spring;
    var ay = (targetY - you.position.y) * spring;
    me.velocity.x -= ax; 
    me.velocity.y -= ay;
    you.velocity.x += ax;
    you.velocity.y += ay;
    
    me.velocity.x *= damper;
    you.velocity.x *= damper;
    if (me.position.y<you.position.y){
      me.velocity.y *= damper;
    }
    if (you.position.y<me.position.y){
      you.velocity.y *= damper;
    }
  }
}

//When you click on the clock, the balls drop again with a new color
function mousePressed(){
  //This little formula makes sure that whatever random color the numbers are, it isn't too dark or too ugly.
  r = random(50,205);
  g = (255-r);
  if (115<r && r<135){
    b = random(185,205);
    if (random(0,1)>=0.5){
      r = r-30;
    } else {
      g = g-30;
    }
  } else if (90<r&& r<170){
    b = random(155,205);
  } else{
    b = random(80,125);
  }
  //the following was/is for debugging.
  //console.log ("The RGB values are " + r + ", " + g + ", and " + b);
  dropNumbers();
}
