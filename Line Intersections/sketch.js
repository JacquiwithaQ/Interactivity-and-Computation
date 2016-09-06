var numberOfLines = 12;
var lineLength = 250;
var lines = [];
var details = [];
var x1 = 0;
var y1 = 0;
var x2 = 0;
var y2 = 0;
var a = -1;
var z = -1;
var x3 = 0;
var y3 = 0;
var x4 = 0;
var y4 = 0;
function setup() {
  createCanvas(720, 480);
  for (var i=0; i<numberOfLines; i++){
    details.push(random(100,width-100));
    details.push(random(100,height-100));
    details.push(random(-lineLength,lineLength));
    details.push(random(0,1));
    lines.push(details);
    details = [];
  }
}

function draw() {
  background(255, 220, 235);
  x1 = 0;
  y1 = 0;
  x2 = 0;
  y2 = 0;
  stroke(200, 100, 150);
  strokeWeight(3);
  for (var j=0; j<lines.length; j++){
    x1 = lines[j][0];
    y1 = lines[j][1];
    x2 = x1+lines[j][2];
    if (lines[j][3]>=0.5){
      y2 = y1+(sqrt((lineLength*lineLength)-(lines[j][2]*lines[j][2])));
    } else {
      y2 = y1-(sqrt((lineLength*lineLength)-(lines[j][2]*lines[j][2])));
    }
    line(x1,y1,x2,y2);
  }
  strokeWeight(0);
  fill(255, 255, 255);
  for (var b=0; b<lines.length; b++){
    x1 = lines[b][0];
    y1 = lines[b][1];
    x2 = x1+lines[b][2];
    if (lines[b][3]>=0.5){
      y2 = y1+(sqrt((lineLength*lineLength)-(lines[b][2]*lines[b][2])));
    } else {
      y2 = y1-(sqrt((lineLength*lineLength)-(lines[b][2]*lines[b][2])));
    }
    for (var c=0; c<lines.length; c++){
      x3 = lines[c][0];
      y3 = lines[c][1];
      x4 = x3+lines[c][2];
      if (lines[c][3]>=0.5){
         y4 = y3+(sqrt((lineLength*lineLength)-(lines[c][2]*lines[c][2])));
      } else {
         y4 = y3-(sqrt((lineLength*lineLength)-(lines[c][2]*lines[c][2])));
      }
      if (((y4-y3)*(x2-x1)-(x4-x3)*(y2-y1))!=0){
        a = ((x4-x3)*(y1-y3)-(y4-y3)*(x1-x3))/((y4-y3)*(x2-x1)-(x4-x3)*(y2-y1));
        z = ((x2-x1)*(y1-y3)-(y2-y1)*(x1-x3))/((y4-y3)*(x2-x1)-(x4-x3)*(y2-y1));
      } else {
        a = -1;
        z = -1;
      }
      if (0<=a && a<=1 && 0<=z && z<=1){
        ellipse((x1+a*(x2-x1)),(y1+a*(y2-y1)),15);
      }
    }
  }
}

function mousePressed(){
  lines = [];
  for (var i=0; i<numberOfLines; i++){
    details.push(random(100,width-100));
    details.push(random(100,height-100));
    details.push(random(-lineLength,lineLength));
    details.push(random(0,1));
    lines.push(details);
    details = [];
  }
}