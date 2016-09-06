var numberOfLines = 12; //number of lines to be drawn
var lineLength = 250; //length of lines to be drawn
var lines = []; //array of lines
var details = []; //array of information about a specific line
//the following are all variable to be used in the placement of lines/ellipses
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
////////////////SETUP/////////////////
function setup() {
  createCanvas(720, 480);
  for (var i=0; i<numberOfLines; i++){
    details.push(random(100,width-100)); //x coordinate of starting point
    details.push(random(100,height-100)); //y coordinate of starting point
    details.push(random(-lineLength,lineLength)); //horizontal displacement of ending point
    details.push(random(0,1)); //assists in determining orientation of line
    lines.push(details); //adds this line to array of lines
    details = []; //empties the array so it can get new information next time the loop iterates
  }
}
/////////////////DRAW///////////////
function draw() {
  background(255, 220, 235); //pink!
  stroke(200, 100, 150); //dark pink!
  strokeWeight(3);
  for (var j=0; j<lines.length; j++){
    x1 = lines[j][0]; //sets x coordinate of starting point
    y1 = lines[j][1]; //sets y coordinate of starting point
    x2 = x1+lines[j][2]; //uses a little addition to determine x coordinate of ending point
    if (lines[j][3]>=0.5){
      y2 = y1+(sqrt((lineLength*lineLength)-(lines[j][2]*lines[j][2]))); //uses Pythagorean Theorem to determine y coordinate of ending point
    } else {
      y2 = y1-(sqrt((lineLength*lineLength)-(lines[j][2]*lines[j][2]))); //uses Pythagorean Theorem to determine y coordinate of ending point
    }
    line(x1,y1,x2,y2); //makes the line
  }
  strokeWeight(0); //no border
  fill(255, 255, 255); //makes the circles white
  // the following nested loops check each line against each other line, and use Dr. Bourke's formula to find the intersection point
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
        ellipse((x1+a*(x2-x1)),(y1+a*(y2-y1)),15); //draws the little circle at the intersection point
      }
    }
  }
}

function mousePressed(){
  lines = []; //clears out the old list of lines so we don't just add new lines on top of the old ones. Not that I'd ever make that mistake...
  for (var i=0; i<numberOfLines; i++){
    details.push(random(100,width-100)); //x coordinate of starting point
    details.push(random(100,height-100)); //y coordinate of starting point
    details.push(random(-lineLength,lineLength)); //horizontal displacement of ending point
    details.push(random(0,1)); //assists in determining orientation of line
    lines.push(details); //adds this line to array of lines
    details = []; //empties the array so it can get new information next time the loop iterates
  }
}