//
// FaceOSC Baby written by Jacqueline Fashimpaur
// October 2016
//
// Based on a template for receiving face tracking osc messages from
// Kyle McDonald's FaceOSC https://github.com/kylemcdonald/ofxFaceTracker
//
// 2012 Dan Wilcox danomatika.com
// for the IACD Spring 2012 class at the CMU School of Art
//
// adapted from from Greg Borenstein's 2011 example
// http://www.gregborenstein.com/
// https://gist.github.com/1603230
//
import oscP5.*;
OscP5 oscP5;

int[] colors;// = new int[6]; 
/*
colors[0] = 0xfeebe2;
 colors[1] = 0xfcc5c0;
 colors[2] = 0xfa9fb5;
 colors[3] = 0xf768a1;
 colors[4] = 0xc51b8a;
 colors[5] = 0x7a0177;
 */

// num faces found
int found;

// pose
float poseScale;
PVector posePosition = new PVector();
PVector poseOrientation = new PVector();

// gesture
float mouthHeight;
float mouthWidth;
float eyeLeft;
float eyeRight;
float eyebrowLeft;
float eyebrowRight;
float jaw;
float nostrils;
int skin_color_index;
int eye_color_index;
int gender_index;
float happiness;
float eye_displacement = 0;
boolean eye_right;
float baby_center_x;
float baby_center_y;

void setup() {
  size(640, 640);
  frameRate(30);
  //sets all colors
  /*colors = new int[6]; 
  colors[0] = #feebe2;
  colors[1] = #fcc5c0;
  colors[2] = #fa9fb5;
  colors[3] = #f768a1;
  colors[4] = #c51b8a;
  colors[5] = #7a0177;*/
  skin_color_index = int(random(0,4));
  eye_color_index = int(random(0,4));
  gender_index = int(random(0,2));
  happiness = 0;
  eye_displacement = 0;
  eye_right = true;
  baby_center_x = 320;
  baby_center_y = 320;
  oscP5 = new OscP5(this, 8338);
  oscP5.plug(this, "found", "/found");
  oscP5.plug(this, "poseScale", "/pose/scale");
  oscP5.plug(this, "posePosition", "/pose/position");
  oscP5.plug(this, "poseOrientation", "/pose/orientation");
  oscP5.plug(this, "mouthWidthReceived", "/gesture/mouth/width");
  oscP5.plug(this, "mouthHeightReceived", "/gesture/mouth/height");
  oscP5.plug(this, "eyeLeftReceived", "/gesture/eye/left");
  oscP5.plug(this, "eyeRightReceived", "/gesture/eye/right");
  oscP5.plug(this, "eyebrowLeftReceived", "/gesture/eyebrow/left");
  oscP5.plug(this, "eyebrowRightReceived", "/gesture/eyebrow/right");
  oscP5.plug(this, "jawReceived", "/gesture/jaw");
  oscP5.plug(this, "nostrilsReceived", "/gesture/nostrils");
}

void display() {
  eye_displacement = (((70+baby_center_x)-posePosition.x)/25)+2;
  /*if (watched()){
    eye_displacement = ((250-posePosition.x)/25)+2;
  } else {
    if (eye_right){
      eye_displacement += 1;
    }
    else {
      eye_displacement -= 1;
    }
    if (eye_displacement<-15) {eye_displacement = -15; eye_right = true;}
    if (eye_displacement>15) {eye_displacement = 15; eye_right = false;}
  }*/
  int skin_r = 141;
  int skin_g = 85;
  int skin_b = 36;
  int eye_r = 00;
  int eye_g = 128;
  int eye_b = 192;
  int clothing_r = 255;
  int clothing_g = 187;
  int clothing_b = 218;
  if (skin_color_index == 0) {
    skin_r = 255;
    skin_g = 224;
    skin_b = 186;
  } else if (skin_color_index == 1) {
    skin_r = 241;
    skin_g = 194;
    skin_b = 125;
  } else if (skin_color_index == 2) {
    skin_r = 198;
    skin_g = 134;
    skin_b = 66;
  }
  if (eye_color_index == 0) {
    eye_r = 0;
    eye_g = 192;
    eye_b = 255;
  } else if (eye_color_index == 1) {
    eye_r = 0;
    eye_g = 192;
    eye_b = 0;
  } else if (eye_color_index == 2) {
    eye_r = 83;
    eye_g = 61;
    eye_b = 53;
  }
  if (gender_index == 1){
    clothing_r = 168;
    clothing_g = 204;
    clothing_b = 232;
  }
  //draw the body
  fill(clothing_r, clothing_g, clothing_b);
  noStroke();
  ellipse(baby_center_x, (210+baby_center_y), 500, 200);
  rect(baby_center_x-(500/2), (210+baby_center_y), 500, 300);
  //draw the face
  fill(skin_r, skin_g, skin_b);
  ellipse(baby_center_x,baby_center_y-40, 350, 350);
  ellipse(baby_center_x,baby_center_y+60, 300, 220);
  beginShape();
  vertex(baby_center_x-(350/2), baby_center_y-40);
  vertex(baby_center_x-(300/2), baby_center_y+60);
  vertex(baby_center_x+(300/2), baby_center_y+60);
  vertex(baby_center_x+(350/2), baby_center_y-40);
  endShape(CLOSE);
  //draw the eyes
  fill(#eeeeee);
  ellipse(baby_center_x - 60, baby_center_y - 40, 80, 80);
  ellipse(baby_center_x + 60, baby_center_y - 40, 80, 80);
  fill(eye_r, eye_g, eye_b);
  ellipse(baby_center_x-65+eye_displacement, baby_center_y -40, 50, 50);
  ellipse(baby_center_x+55+eye_displacement, baby_center_y -40, 50, 50);
  fill(0);
  ellipse(baby_center_x-65+eye_displacement, baby_center_y -40, 25, 25);
  ellipse(baby_center_x+55+eye_displacement, baby_center_y -40, 25, 25);
  //draw the nose
  noFill();
  strokeCap(ROUND);
  stroke(skin_r - 20, skin_g - 20, skin_b - 20);
  strokeWeight(3);
  arc(baby_center_x, baby_center_y + 20, 50, 30, 0, PI, OPEN);
  //draw the mouth
  strokeWeight(10);
  if (skin_color_index == 0) stroke(#ffcccc);
  if (happiness<0){
    //unhappy
    fill(#cc6666);
    ellipse(baby_center_x, baby_center_y+80, 60-(happiness/8), 0-happiness);
  } else if (happiness<=40){
    //happy
    noFill();
    arc(baby_center_x, baby_center_y+80-(happiness/5), 60+(happiness/4), happiness/2, 0, PI, OPEN);
  } else {
    strokeWeight(8);
    fill(#cc6666);
    arc(baby_center_x, baby_center_y+81-(happiness/5), 60+(happiness/4), happiness-20, 0, PI, OPEN);
    fill(skin_r, skin_g, skin_b);
    arc(baby_center_x, baby_center_y+79-(happiness/5), 60+(happiness/4), 20+((happiness-40)/10), 0, PI, OPEN);
  }
  //draw the cheeks (range 340-380)
  noStroke();
  fill(skin_r, skin_g, skin_b);
  if (happiness>30){
    ellipse(baby_center_x-90, baby_center_y+60-(happiness/2), 100, 70);
    ellipse(baby_center_x+90, baby_center_y+60-(happiness/2), 100, 70);
  }
  //draw the eyelids (range 200-240)
  if (happiness<0){
    ellipse(baby_center_x-90, baby_center_y-120-(happiness/3), 100, 90);
    ellipse(baby_center_x+90, baby_center_y-120-(happiness/3), 100, 90);
  }
  //draw a hair
  stroke(0);
  noFill();
  strokeWeight(2);
  curve(400,10,baby_center_x,baby_center_y-200,baby_center_x-20,baby_center_y-270,0,0);
  //draw a bow? If time...
  /* fill(clothing_r, clothing_g, clothing_b);
  noStroke();
  ellipse(320,120,60,60); */
}

void draw() {  
  background(#ccffff);
  happiness += 0.5;
  if (!watched()){
    happiness-= 2;
  } else if (funnyFace()){
    happiness++;
  } else if (happiness > 40){
    happiness-=2;
    if (happiness<40) happiness = 40;
  } else {
    happiness++;
    if (happiness>40) happiness = 40;
  }
  if (happiness>90) happiness = 90;
  if (happiness<-70) happiness = -70;
  stroke(0);
  baby_center_x += 1-(2*noise(millis()/1000));
  baby_center_y += 1-(2*noise((millis()+500)/800));
  if (baby_center_x < 260) baby_center_x = 260;
  if (baby_center_x > 380) baby_center_x = 380;
  if (baby_center_y < 300) baby_center_y = 300;
  if (baby_center_y > 340) baby_center_y = 340;
  display();
  println(eyebrowLeft);
}

// OSC CALLBACK FUNCTIONS

public void found(int i) {
  //println("found: " + i);
  found = i;
}

public void poseScale(float s) {
  //println("scale: " + s);
  poseScale = s;
}

public void posePosition(float x, float y) {
 // println("pose position\tX: " + x + " Y: " + y );
  posePosition.set(x, y, 0);
}

public void poseOrientation(float x, float y, float z) {
  //println("pose orientation\tX: " + x + " Y: " + y + " Z: " + z);
  poseOrientation.set(x, y, z);
}

public void mouthWidthReceived(float w) {
  //println("mouth Width: " + w);
  mouthWidth = w;
}

public void mouthHeightReceived(float h) {
  //println("mouth height: " + h);
  mouthHeight = h;
}

public void eyeLeftReceived(float f) {
  //println("eye left: " + f);
  eyeLeft = f;
}

public void eyeRightReceived(float f) {
  //println("eye right: " + f);
  eyeRight = f;
}

public void eyebrowLeftReceived(float f) {
  //println("eyebrow left: " + f);
  eyebrowLeft = f;
}

public void eyebrowRightReceived(float f) {
  //println("eyebrow right: " + f);
  eyebrowRight = f;
}

public void jawReceived(float f) {
  //println("jaw: " + f);
  jaw = f;
}

public void nostrilsReceived(float f) {
  //println("nostrils: " + f);
  nostrils = f;
}

// all other OSC messages end up here
void oscEvent(OscMessage m) {
  if (m.isPlugged() == false) {
    println("UNPLUGGED: " + m);
  }
}

boolean watched() {
  if (found==0) {
    return false;
  }
  float left_eye_height = 10;
  float right_eye_height = 10;
  if (left_eye_height < 10 && right_eye_height <10) {
    return false;
  }
  return true;
}

boolean funnyFace(){
  if (eyebrowLeft>8 || eyebrowRight>8) return true;
  if (mouthHeight>3) return true;
  return false;
}

boolean mouthOpen(){
  if (mouthHeight>2){
    return true;
  }
  return false;
}