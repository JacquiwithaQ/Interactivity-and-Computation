var nFramesInLoop = 240;
var nElapsedFrames;
var nExportedFrameImages;
var rotatingArmAngle;
var pauser;
var pauseLength = 30;
var cy;
var cx;
var py;
var px;
var newRotatingArmAngle;
var bRecording;

function setup() {
  createCanvas(600, 600);
  nElapsedFrames = 0;
  nExportedFrameImages= 0; 
  bRecording = false;
  pauser = 0;
}

function draw() {
  var percentCompleteFraction = 0;
  percentCompleteFraction = (nElapsedFrames % nFramesInLoop) / (nFramesInLoop);
  displayDesign(percentCompleteFraction);
  
  if (((percentCompleteFraction * 8) % 2 == 0) && (pauser < pauseLength)) {
    pauser += 1;
  } else {
    nElapsedFrames += 1;
    pauser = 0;
  }

  /*if (bRecording) {
    var frameOutputFilename = "jaqaur-loop-" + nf(nExportedFrameImages) + ".png";
    println("Saving output image: " + frameOutputFilename);
    saveCanvas(frameOutputFilename);
    nExportedFrameImages++; 

    if (nElapsedFrames >= nFramesInLoop) {
      bRecording = false;
    }
  }*/
   
}

function displayDesign(pointInTime) {
  background(0, 0, 0, 200);
  fill(0);
  strokeWeight(10);
  //The columns of stationary lines
  var rows = 0;
  while (rows < 7) {
    cx = 50;
    cy = 50 + (100 * rows);
    stroke(0, (cy / 600) * 200, ((600 - cy) / 600) * 255);
    line(cx, cy, cx + 100, cy);
    rows += 1;
  }
  rows = 0;
  while (rows < 7) {
    cx = 250;
    cy = 50 + (100 * rows);
    stroke(0, (cy / 600) * 200, ((600 - cy) / 600) * 255);
    line(cx, cy, cx + 100, cy);
    rows += 1;
  }
  rows = 0;
  while (rows < 7) {
    cx = 450;
    cy = 50 + (100 * rows);
    stroke(0, (cy / 600) * 200, ((600 - cy) / 600) * 255);
    line(cx, cy, cx + 100, cy);
    rows += 1;
  }
  //Moving Line 1;
  var radius = 100;
  var rotatingArmAngle = pointInTime * TWO_PI;
  rotatingArmAngle -= (PI / 2);
  var cols = 0;
  while (cols <= 3) {
    var arms = 0;
    while (arms <= 6) {
      if (rotatingArmAngle < (PI / 2) || (-1 * PI / 2) > rotatingArmAngle) {
        cx = -50 + (200 * cols);
        if (cols % 2 == 1) {
          cy = -50 + (200 * arms);
        } else {
          cy = -150 + (200 * arms);
        }
        px = cx + radius * cos(rotatingArmAngle);
        py = cy + radius * sin(rotatingArmAngle);
        stroke(0, (py / 600) * 200, ((600 - py) / 600) * 255);
        line(cx, cy, px, py);
        ellipse(px, py, 10, 10);
        ellipse(cx, cy, 10, 10);
      } else {
        cx = -50 + (200 * cols);
        if (cols % 2 == 1) {
          cy = 50 + (200 * arms);
        } else {
          cy = -50 + (200 * arms);
        }
        newRotatingArmAngle = rotatingArmAngle - PI;
        px = cx + radius * cos(newRotatingArmAngle);
        py = cy + radius * sin(newRotatingArmAngle);
        stroke(0, (cy / 600) * 200, ((600 - cy) / 600) * 255);
        line(cx, cy, px, py);
        ellipse(px, py, 10, 10);
        ellipse(cx, cy, 10, 10);
      }
      arms += 1;
    }
    cols += 1;
  }
  cols = 0;
  while (cols <= 4) {
    var arms = 0;
    while (arms <= 6) {
      if (rotatingArmAngle < (PI / 2) || (-1 * PI / 2) > rotatingArmAngle) {
        cx = -150 + (200 * cols);
        if (cols % 2 == 1) {
          cy = -50 + (200 * arms);
        } else {
          cy = -150 + (200 * arms);
        }
        px = cx - radius * cos(rotatingArmAngle);
        py = cy + radius * sin(rotatingArmAngle);
        stroke(0, (cy / 600) * 200, ((600 - cy) / 600) * 255);
        line(cx, cy, px, py);
        ellipse(px, py, 10, 10);
        ellipse(cx, cy, 10, 10);
      } else {
        cx = -150 + (200 * cols);
        if (cols % 2 == 1) {
          cy = 50 + (200 * arms);
        } else {
          cy = -50 + (200 * arms);
        }
        newRotatingArmAngle = rotatingArmAngle - PI;
        px = cx - radius * cos(newRotatingArmAngle);
        py = cy + radius * sin(newRotatingArmAngle);
        stroke(0, (py / 600) * 200, ((600 - py) / 600) * 255);
        line(cx, cy, px, py);
        ellipse(px, py, 10, 10);
        ellipse(cx, cy, 10, 10);
      }
      arms += 1;
    }
    cols += 1;
  }
}
/*
function keyPressed() {
  bRecording = true;
  nElapsedFrames = 0;
}
*/
