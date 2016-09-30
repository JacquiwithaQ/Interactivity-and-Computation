/*
 cd /Users/classy/Desktop/AXIDRAW/cncserver
 node cncserver --botType=axidrawd
*/

CNCServer cnc;
boolean readyToDraw = false;
boolean doneDrawing = false;

class Branch {
  float v1;
  float v2;
  float v3;
  float v4;
  float v5;
  float v6;
  float v7;
  float v8;

  public Branch(float a, float b, float c, float d, float e, float f, float g, float h) {
    v1 = a;
    v2 = b;
    v3 = c;
    v4 = d;
    v5 = e;
    v6 = f;
    v7 = g;
    v8 = h;
  }

  void reduce(float ratio) {
    v1 *= ratio;
    v2 *= ratio;
    v3 *= ratio;
    v4 *= ratio;
    v5 *= ratio;
    v6 *= ratio;
    v7 *= ratio;
    v8 *= ratio;
  }

  void display() {
    int steps = 6;
    for (int i = 0; i <= steps; i++) {
      float t = i /float(steps);
      float x = curvePoint(v1, v3, v5, v7, t);
      float y = curvePoint(v2, v4, v6, v8, t);
      cnc.moveTo(x, y);
    }
  }
}

ArrayList<Branch> allBranches;

void setup() {
  size(800, 700); 
  cnc = new CNCServer("http://localhost:4242");
  cnc.penUp();
  readyToDraw = false;
  println("Press 'u' to unlock, 'z' to zero, 'd' to draw");
  doneDrawing = false;
  allBranches = new ArrayList<Branch>();
  makeAllTrees();
}

//

void makeAllTrees() {
  background(255);
  int[][] possibleTrees=new int[8][3];
  //listing all possible options;
  possibleTrees[0][0]=-1; 
  possibleTrees[0][1]=-1; 
  possibleTrees[0][2]=-1;
  possibleTrees[1][0]=1; 
  possibleTrees[1][1]=-1; 
  possibleTrees[1][2]=-1;
  possibleTrees[2][0]=-1; 
  possibleTrees[2][1]=1; 
  possibleTrees[2][2]=-1;
  possibleTrees[3][0]=-1; 
  possibleTrees[3][1]=-1; 
  possibleTrees[3][2]=1;
  possibleTrees[4][0]=1; 
  possibleTrees[4][1]=1; 
  possibleTrees[4][2]=-1;
  possibleTrees[5][0]=-1; 
  possibleTrees[5][1]=1; 
  possibleTrees[5][2]=1;
  possibleTrees[6][0]=1; 
  possibleTrees[6][1]=-1; 
  possibleTrees[6][2]=1;
  possibleTrees[7][0]=1; 
  possibleTrees[7][1]=1; 
  possibleTrees[7][2]=1;
  int[] usedTrees = new int[8];
  for (int t=0; t<8; t++) usedTrees[t]=-1;
  int numberOfTrees = 0;
  while (numberOfTrees<8) {
    int potentialTree = int(random(8));
    boolean treeIsGo = true;
    for (int j=0; j<8; j++) if (potentialTree == usedTrees[j]) treeIsGo = false;
    if (treeIsGo) {
      //dip
      makeTree((numberOfTrees%4)*(width/4), ((numberOfTrees%4)+1)*(width/4), int(numberOfTrees/4)*((height-100)/2), (int(numberOfTrees/4)+1)*((height-100)/2), 
        possibleTrees[potentialTree][0], possibleTrees[potentialTree][1], possibleTrees[potentialTree][2]);
      print("Made Tree "+potentialTree);
      usedTrees[numberOfTrees]=potentialTree;
      numberOfTrees += 1;
    }
  }
}

void makeTree(float xMin, float xMax, float yMin, float yMax, int choice1, int choice2, int choice3) {
  noFill();
  float y1 = random(((yMax-yMin)/20)+yMin, ((yMax-yMin)/10)+yMin);
  float y2 = random((6*(yMax-yMin)/25)+yMin, (9*(yMax-yMin)/25)+yMin);
  float y3 = random((11*(yMax-yMin)/25)+yMin, (14*(yMax-yMin)/25)+yMin);
  float y4 = random((16*(yMax-yMin)/25)+yMin, (19*(yMax-yMin)/25)+yMin);
  float y5 = random((21*(yMax-yMin)/25)+yMin, (24*(yMax-yMin)/25)+yMin);
  float x1 = ((xMax-xMin)/2)+xMin;
  float x2A = random(xMin, (((xMax-xMin)/2)+xMin));
  float x2B = random(x2A+(xMax-xMin)/5, xMax);
  float x3A = random(xMin, (((xMax-xMin)/2)+xMin));
  float x3B = random(x3A+(xMax-xMin)/5, xMax);
  float x4A = random(xMin, (((xMax-xMin)/2)+xMin));
  float x4B = random(x4A+(xMax-xMin)/5, xMax);
  float x5A = random(xMin, (((xMax-xMin)/2)+xMin));
  float x5B = random(x5A+(xMax-xMin)/5, xMax);
  //ellipse(x1, y1, 5, 5);
  Branch branchie = new Branch(random(xMin, xMax), random(yMin, yMax), x1, y1, x2A, y2, random(xMin, xMax), random(yMin, yMax));
  curve(branchie.v1, branchie.v2, branchie.v3, branchie.v4, branchie.v5, branchie.v6, branchie.v7, branchie.v8);
  allBranches.add(branchie);
  //line(x1,y1,x2A,y2);
  Branch branchie1 = new Branch(random(xMin, xMax), random(yMin, yMax), x1, y1, x2B, y2, random(xMin, xMax), random(yMin, yMax));
  curve(branchie1.v1, branchie1.v2, branchie1.v3, branchie1.v4, branchie1.v5, branchie1.v6, branchie1.v7, branchie1.v8);
  allBranches.add(branchie1);
  //line(x1,y1,x2B,y2);
  if (choice1 >0 ) {
    Branch branchie2 = new Branch(random(xMin, xMax), random(yMin, yMax), x2A, y2, x3A, y3, random(xMin, xMax), random(yMin, yMax));
    curve(branchie2.v1, branchie2.v2, branchie2.v3, branchie2.v4, branchie2.v5, branchie2.v6, branchie2.v7, branchie2.v8);
    allBranches.add(branchie2);
    //line(x2A,y2,x3A,y3);
    Branch branchie3 = new Branch(random(xMin, xMax), random(yMin, yMax), x2A, y2, x3B, y3, random(xMin, xMax), random(yMin, yMax));
    curve(branchie3.v1, branchie3.v2, branchie3.v3, branchie3.v4, branchie3.v5, branchie3.v6, branchie3.v7, branchie3.v8);
    allBranches.add(branchie3);
    //line(x2A,y2,x3B,y3);
    //ellipse(x2B,y2,5,5);
  } else {
    Branch branchie2 = new Branch(random(xMin, xMax), random(yMin, yMax), x2B, y2, x3A, y3, random(xMin, xMax), random(yMin, yMax));
    curve(branchie2.v1, branchie2.v2, branchie2.v3, branchie2.v4, branchie2.v5, branchie2.v6, branchie2.v7, branchie2.v8);
    allBranches.add(branchie2);
    //line(x2B,y2,x3A,y3);
    Branch branchie3 = new Branch(random(xMin, xMax), random(yMin, yMax), x2B, y2, x3B, y3, random(xMin, xMax), random(yMin, yMax));
    curve(branchie3.v1, branchie3.v2, branchie3.v3, branchie3.v4, branchie3.v5, branchie3.v6, branchie3.v7, branchie3.v8);
    allBranches.add(branchie3);
    //line(x2B,y2,x3B,y3);
    //ellipse(x2A,y2,5,5);
  }
  if (choice2 > 0) {
    Branch branchie4 = new Branch(random(xMin, xMax), random(yMin, yMax), x3A, y3, x4A, y4, random(xMin, xMax), random(yMin, yMax));
    curve(branchie4.v1, branchie4.v2, branchie4.v3, branchie4.v4, branchie4.v5, branchie4.v6, branchie4.v7, branchie4.v8);
    allBranches.add(branchie4);
    //line(x3A,y3,x4A,y4);
    Branch branchie5 = new Branch(random(xMin, xMax), random(yMin, yMax), x3A, y3, x4B, y4, random(xMin, xMax), random(yMin, yMax));
    curve(branchie5.v1, branchie5.v2, branchie5.v3, branchie5.v4, branchie5.v5, branchie5.v6, branchie5.v7, branchie5.v8);
    allBranches.add(branchie5);
    //line(x3A,y3,x4B,y4);
    //ellipse(x3B,y3,5,5);
  } else {
    Branch branchie4 = new Branch(random(xMin, xMax), random(yMin, yMax), x3B, y3, x4A, y4, random(xMin, xMax), random(yMin, yMax));
    curve(branchie4.v1, branchie4.v2, branchie4.v3, branchie4.v4, branchie4.v5, branchie4.v6, branchie4.v7, branchie4.v8);
    allBranches.add(branchie4);
    //line(x3B,y3,x4A,y4);
    Branch branchie5 = new Branch(random(xMin, xMax), random(yMin, yMax), x3B, y3, x4B, y4, random(xMin, xMax), random(yMin, yMax));
    curve(branchie5.v1, branchie5.v2, branchie5.v3, branchie5.v4, branchie5.v5, branchie5.v6, branchie5.v7, branchie5.v8);
    allBranches.add(branchie5);
    //line(x3B,y3,x4B,y4);
    //ellipse(x3A,y3,5,5);
  }
  if (choice3 > 0) {
    Branch branchie6 = new Branch(random(xMin, xMax), random(yMin, yMax), x4A, y4, x5A, y5, random(xMin, xMax), random(yMin, yMax));
    curve(branchie6.v1, branchie6.v2, branchie6.v3, branchie6.v4, branchie6.v5, branchie6.v6, branchie6.v7, branchie6.v8);
    allBranches.add(branchie6);
    //line(x4A,y4,x5A,y5);
    Branch branchie7 = new Branch(random(xMin, xMax), random(yMin, yMax), x4A, y4, x5B, y5, random(xMin, xMax), random(yMin, yMax));
    curve(branchie7.v1, branchie7.v2, branchie7.v3, branchie7.v4, branchie7.v5, branchie7.v6, branchie7.v7, branchie7.v8);
    allBranches.add(branchie7);
    //line(x4A,y4,x5B,y5);
    //ellipse(x4B,y4,5,5);
  } else {
    Branch branchie6 = new Branch(random(xMin, xMax), random(yMin, yMax), x4B, y4, x5A, y5, random(xMin, xMax), random(yMin, yMax));
    curve(branchie6.v1, branchie6.v2, branchie6.v3, branchie6.v4, branchie6.v5, branchie6.v6, branchie6.v7, branchie6.v8);
    allBranches.add(branchie6);
    //line(x4B,y4,x5A,y5);
    Branch branchie7 = new Branch(random(xMin, xMax), random(yMin, yMax), x4B, y4, x5B, y5, random(xMin, xMax), random(yMin, yMax));
    curve(branchie7.v1, branchie7.v2, branchie7.v3, branchie7.v4, branchie7.v5, branchie7.v6, branchie7.v7, branchie7.v8);
    allBranches.add(branchie7);
    //line(x4B,y4,x5B,y5);
    //ellipse(x4A,y4,5,5);
  }
  //ellipse(x5A,y5,5,5);
  //ellipse(x5B,y5,5,5);
}
int counter = 0;
void draw() {
  if (readyToDraw){
  if (counter < allBranches.size()) {
    delay(500);
    if (counter%8==0) {
      //println("Going for ink. Counter = " + counter);
      cnc.penUp();
      cnc.moveTo(50, 80);
      cnc.penDown();
      delay(3000);
      cnc.penUp();
    }
    //allBranches.get(counter).reduce(0.1);
    int steps = 6;
    for (int i = 0; i <= steps; i++) {
      if (i==0){
        cnc.penUp(); 
      } else if (i==1){
        cnc.penDown(); 
      }
      float t = i /float(steps);
      float x = curvePoint(allBranches.get(counter).v1/10, allBranches.get(counter).v3/10, allBranches.get(counter).v5/10, allBranches.get(counter).v7/10, t);
      float y = curvePoint(allBranches.get(counter).v2/10, allBranches.get(counter).v4/10, allBranches.get(counter).v6/10, allBranches.get(counter).v8/10, t);
      cnc.moveTo(x, y);
      //println("Moving to " + x + ", " + y);
    }
    counter++;
    println("Counter = " + counter);
  } else {
    println("Done!");
    doneDrawing = true;
    cnc.penUp();
    cnc.moveTo(0, 0);
  }
  }
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