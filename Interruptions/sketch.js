var angles = [];
var place = 0;
var x1 = 0;
var x2 = 0;
var y1 = 0;
var y2 = 0;
var numberOfInterruptions = 0;
var interruptions = [];
var interruptionSize = 0;

function setup() {
  createCanvas(680,680);
  for (var n=0; n<2500; n++){
      angles.push(random(-1*PI, PI));
  }
  interrupt();
}

function draw() {
  background(240,240,240);
  place = 0;
  stroke(0);
  strokeWeight(1);
  for (var i=0; i<49; i++){
    for (var j=0; j<49; j++){
      //this if statement tests that the line its about to draw hasn't been interrupted
      if (angles[place]<10){
        x1 = 24 + (13*i) + (12*cos(angles[place]));
        x2 = 24 + (13*i) - (12*cos(angles[place]));
        y1 = 24 + (13*j) + (12*sin(angles[place]));
        y2 = 24 + (13*j) - (12*sin(angles[place]));
        line(x1,y1,x2,y2);
      }
      place += 1;
    }
  }
}

function mousePressed(){
  angles = [];
  for (var n=0; n<2500; n++){
    if (random(0,10)>2){
      angles.push(random(-1*PI, PI));
    } else { 
      angles.push(5);
    }
  }
  interrupt();
}

function interrupt(){
  //this is an overcomplicated way to make sure that the interruptions form clumps
  numberOfInterruptions = int(random(10,30));
  for (var q=0; q<numberOfInterruptions; q++){
    interruptions = [int(random(1,2500))];
    interruptionSize = int(random(1,80));
    for (var w=1; w<interruptionSize; w++){
      if (random(0,1)<0.25){
        interruptions.push(interruptions[w-1]+49);
      } else if (random(0,1)<0.34){
        interruptions.push(interruptions[w-1]+1);
      } else if (random(0,1)<0.5){
        interruptions.push(interruptions[w-1]-49);
      } else{
        interruptions.push(interruptions[w-1]-1);
      }
    }
    for (var t=0; t<interruptions.length; t++){
      angles[interruptions[t]] = 100;
    }
  }
}