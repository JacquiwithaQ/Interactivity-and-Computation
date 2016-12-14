//Written by Jacqui Fashimpaur for Golan Levin's class

CNCServer cnc;
boolean readyToDraw = false;
boolean doneDrawing = false;

BvhParser parserA = new BvhParser();
PBvh bvh1, bvh2, bvh3;
	
float maxX;
float minX;
float maxY;
float minY;
float mappedMaxY;
float heightConstant;
float widthConstant;
boolean wider;
int times;
float otherConstant;
float paperWidth = 1000;
float paperHeight = 900;
float color1X = 989;
float color1Y = 100;
float color2X = 989;
float color2Y = 330;
float color3X = 989;
float color3Y = 220;
float color4X = 989;
float color4Y = 450;
float waterX = 989;
float waterY = 560;
float paperX = 989;
float paperY = 710;


public void setup()
{
  size(1000, 900);
  cnc = new CNCServer("http://localhost:4242");
  cnc.penUp();
  readyToDraw = false;
  println("Press 'u' to unlock, 'z' to zero, 'd' to draw");
  doneDrawing = false;
  noStroke();
  frameRate( 70 );
  //noSmooth();
  times = 0;
  maxX = 1;
  maxY = 1;
  mappedMaxY = 0;
  minX = 1000;
  minY = 1000;
  otherConstant = 1;
  bvh1 = new PBvh( loadStrings( "More_Katia/Pirouette.bvh" ) );
  mapper();
  //noLoop();q
  background(255);
}

public void draw()
{ 
  if (readyToDraw){
    cnc.penUp();
    int[] all_joints = {3, 6, 13, 32};
    float old_X = 0;
    float old_Y = 0;
    for (int joint_index = 0; joint_index < all_joints.length; joint_index++){
      //println("Inside Loop.");
      strokeWeight(3);
      if (joint_index == 0){
        
         println("Here 0a"); 
         //fill(255, 0, 0);
         stroke(230, 0, 90);
         //println("Going to " + color1X + ", " + color1Y);
         cnc.moveTo(color1X/10, color1Y/10);
         delay(2000);
         println("Here 0b"); 
         cnc.penDown();
         println("Here 0c"); 
         delay(3000);
         println("Here 0d"); 
         cnc.penUp();
         println("Here 0e"); 
      } else if (joint_index == 1){
         //fill(0, 255, 0);
         println("Here 1a");
         stroke(200, 0, 100, 100);
         cnc.moveTo(color2X/10, color2Y/10);
         println("Here 1b");
         delay(2000);
         cnc.penDown();
         println("Here 1c");
         delay(3000);
         println("Here 1d");
         cnc.penUp();
         println("Here 1e");
         delay(2000);
      } else if (joint_index == 2){
         //fill(0, 0, 255);
         stroke(150, 0, 200, 100);
         cnc.moveTo(color3X/10, color3Y/10);
         delay(2000);
         cnc.penDown();
         delay(3000);
         cnc.penUp();
         delay(2000);
      } else {
         stroke(80, 0, 240, 100);
         cnc.moveTo(color4X/10, color4Y/10);
         delay(2000);
         cnc.penDown();
         delay(3000);
         cnc.penUp();
         delay(2000);
      }
      //println("There are " + bvh1.parser.getNbFrames() + " frames.");
      for (int frame = 0; frame < bvh1.parser.getNbFrames(); frame++){ 
        bvh1.update((frame*1000)/30);
        float myX = bvh1.parser.getBones().get(all_joints[joint_index]).absPos.x;
        float myY = bvh1.parser.getBones().get(all_joints[joint_index]).absPos.y;
        float mapped_X = myX;
        float mapped_Y = myY;
        if (!wider){
          mapped_Y = map(myY, minY, maxY, 50, paperHeight-50);
          mapped_X = (paperWidth/2)+(myX*widthConstant);
        } else {
          mapped_X = map(myX, minX, maxX, 100, paperWidth-100);
          mapped_Y = (paperHeight)-(heightConstant*myY);
        }
         //ellipse(mapped_X, mapped_Y, 20, 20); //RIGHTSIDE UP
         //ellipse(mapped_X, paperHeight-mapped_Y, 20, 20); //UPSIDE DOWN
         
         if (frame != 0){
           //ellipse(mapped_X, paperHeight-mapped_Y, 20, 20);
           line(old_X, paperHeight-old_Y, mapped_X, paperHeight-mapped_Y);
         }
         old_X = mapped_X;
         old_Y = mapped_Y;
         cnc.moveTo((mapped_X/10), ((paperHeight-mapped_Y)/10));
         if (frame==0){
           cnc.penDown(); 
         }
      }
      cnc.penUp();
      cnc.moveTo(waterX/10, waterY/10);
      delay(1000);
      cnc.penDown();
      delay(1000);
      cnc.penUp();
      delay(1000);
      cnc.moveTo(paperX/10, paperY/10);
      cnc.penDown();
      int moveX = int(random(20,40));
      int moveY = int(random(20,40));
      cnc.moveTo((paperX+moveX)/10, (paperY+moveY)/10);
      cnc.moveTo((paperX-moveX)/10, (paperY-moveY)/10);
      cnc.penUp();
    }
    cnc.moveTo(0, 0);
    readyToDraw= false;
  }
}

void mapper(){
  bvh1.parser._currentFrame = 0;
  for (int times = 0; times < bvh1.parser.getNbFrames(); times++){
    bvh1.update((times*1000)/30);
    for (int i = 0; i<=41; i++){
      float myX = bvh1.parser.getBones().get(i).absPos.x;
      float myY = bvh1.parser.getBones().get(i).absPos.y;
      if (myX > maxX) maxX = myX;
      if (myX < minX) minX = myX;
      if (myY > maxY) maxY = myY;
      if (myY < minY) minY = myY;
      heightConstant = 1;
      widthConstant = 1;
    }
  }
  bvh1.parser._currentFrame = 0;
  if ((maxY-minY) > (maxX-minX)*(9/10)){
    wider = false;
    widthConstant = (paperHeight-100)/(maxY-minY);
    //println("" + (paperHeight-100) + " / " + (maxY-minY) + " = " + widthConstant);
  } else {
    wider = true;
    heightConstant = ((paperWidth-200)/(maxX-minX))*((paperHeight-100)/paperHeight);
    //println("" + (paperWidth-200)/(maxX-minX) + " * " + ((paperHeight-100)/paperHeight) + " = " + heightConstant);
  }
}

void exit(){
  cnc.penUp();
  println("Goodbye!");
  super.exit();
}

void stop() {
  cnc.penUp();
  println("Goodbye!");
  super.exit();
}

void keyPressed() {
  if (key == '[') cnc.penUp();
  if (key == ']') cnc.penDown();
  if (key == 'u') {
    cnc.unlock();
    println("Pen unlocked ..... remember to zero!");
  }
  if (key == 'z') {
    cnc.zero();
    println("Pen zero'd");
  }
  if (key == 'd') {
    readyToDraw = !readyToDraw;
    if (readyToDraw) {
      println("Drawing");
    } else {
      cnc.penUp();
    }
  }
} 