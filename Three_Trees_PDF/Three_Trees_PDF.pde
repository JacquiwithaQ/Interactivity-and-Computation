import processing.pdf.*;
boolean bRecordingPDF;
int pdfOutputCount = 0;

void setup(){
 size(1200,900); 
 bRecordingPDF = true;
 makeAllTrees();
}

void keyPressed(){
  bRecordingPDF = true;
}

void makeAllTrees(){
 if (bRecordingPDF){
   background(255);
   beginRecord(PDF, "jaqaur_" + pdfOutputCount + ".pdf");
   int[][] possibleTrees=new int[8][3];
   //listing all possible options;
   possibleTrees[0][0]=-1; possibleTrees[0][1]=-1; possibleTrees[0][2]=-1;
   possibleTrees[1][0]=1; possibleTrees[1][1]=-1; possibleTrees[1][2]=-1;
   possibleTrees[2][0]=-1; possibleTrees[2][1]=1; possibleTrees[2][2]=-1;
   possibleTrees[3][0]=-1; possibleTrees[3][1]=-1; possibleTrees[3][2]=1;
   possibleTrees[4][0]=1; possibleTrees[4][1]=1; possibleTrees[4][2]=-1;
   possibleTrees[5][0]=-1; possibleTrees[5][1]=1; possibleTrees[5][2]=1;
   possibleTrees[6][0]=1; possibleTrees[6][1]=-1; possibleTrees[6][2]=1;
   possibleTrees[7][0]=1; possibleTrees[7][1]=1; possibleTrees[7][2]=1;
   int[] usedTrees = new int[8];
   for (int t=0; t<8; t++) usedTrees[t]=-1;
   int numberOfTrees = 0;
   while (numberOfTrees<8){
     int potentialTree = int(random(8));
     boolean treeIsGo = true;
     for (int j=0; j<8; j++) if (potentialTree == usedTrees[j]) treeIsGo = false;
     if (treeIsGo){
         //dip
         makeTree((numberOfTrees%4)*(width/4),((numberOfTrees%4)+1)*(width/4),int(numberOfTrees/4)*((height-100)/2),(int(numberOfTrees/4)+1)*((height-100)/2), 
                  possibleTrees[potentialTree][0], possibleTrees[potentialTree][1],possibleTrees[potentialTree][2]);
         print("Made Tree "+potentialTree);
       usedTrees[numberOfTrees]=potentialTree;
       numberOfTrees += 1;
     }
   }
   endRecord();
   bRecordingPDF = false;
   pdfOutputCount++;
 }
}

void makeTree(float xMin, float xMax, float yMin, float yMax, int choice1, int choice2, int choice3){
    noFill();
    float y1 = random(((yMax-yMin)/20)+yMin,((yMax-yMin)/10)+yMin);
    float y2 = random((6*(yMax-yMin)/25)+yMin,(9*(yMax-yMin)/25)+yMin);
    float y3 = random((11*(yMax-yMin)/25)+yMin,(14*(yMax-yMin)/25)+yMin);
    float y4 = random((16*(yMax-yMin)/25)+yMin,(19*(yMax-yMin)/25)+yMin);
    float y5 = random((21*(yMax-yMin)/25)+yMin,(24*(yMax-yMin)/25)+yMin);
    float x1 = ((xMax-xMin)/2)+xMin;
    float x2A = random(xMin,(((xMax-xMin)/2)+xMin));
    float x2B = random(x2A+(xMax-xMin)/5,xMax);
    float x3A = random(xMin,(((xMax-xMin)/2)+xMin));
    float x3B = random(x3A+(xMax-xMin)/5,xMax);
    float x4A = random(xMin,(((xMax-xMin)/2)+xMin));
    float x4B = random(x4A+(xMax-xMin)/5,xMax);
    float x5A = random(xMin,(((xMax-xMin)/2)+xMin));
    float x5B = random(x5A+(xMax-xMin)/5,xMax);
    curve(random(xMin,xMax),random(yMin,yMax),x1,y1,x2A,y2,random(xMin,xMax),random(yMin,yMax));
    //line(x1,y1,x2A,y2);
    curve(random(xMin,xMax),random(yMin,yMax),x1,y1,x2B,y2,random(xMin,xMax),random(yMin,yMax));
    //line(x1,y1,x2B,y2);
    if (choice1 >0 ){
      curve(random(xMin,xMax),random(yMin,yMax),x2A,y2,x3A,y3,random(xMin,xMax),random(yMin,yMax));
      //line(x2A,y2,x3A,y3);
      curve(random(xMin,xMax),random(yMin,yMax),x2A,y2,x3B,y3,random(xMin,xMax),random(yMin,yMax));
      //line(x2A,y2,x3B,y3);
      //ellipse(x2B,y2,5,5);
    } else {
      curve(random(xMin,xMax),random(yMin,yMax),x2B,y2,x3A,y3,random(xMin,xMax),random(yMin,yMax));
      //line(x2B,y2,x3A,y3);
      curve(random(xMin,xMax),random(yMin,yMax),x2B,y2,x3B,y3,random(xMin,xMax),random(yMin,yMax));
      //line(x2B,y2,x3B,y3);
      //ellipse(x2A,y2,5,5);
    }
    if (choice2 > 0){
      curve(random(xMin,xMax),random(yMin,yMax),x3A,y3,x4A,y4,random(xMin,xMax),random(yMin,yMax));
      //line(x3A,y3,x4A,y4);
      curve(random(xMin,xMax),random(yMin,yMax),x3A,y3,x4B,y4,random(xMin,xMax),random(yMin,yMax));
      //line(x3A,y3,x4B,y4);
      //ellipse(x3B,y3,5,5);
    } else {
      curve(random(xMin,xMax),random(yMin,yMax),x3B,y3,x4A,y4,random(xMin,xMax),random(yMin,yMax));
      //line(x3B,y3,x4A,y4);
      curve(random(xMin,xMax),random(yMin,yMax),x3B,y3,x4B,y4,random(xMin,xMax),random(yMin,yMax));
      //line(x3B,y3,x4B,y4);
      //ellipse(x3A,y3,5,5);
    }
    if (choice3 > 0){
      curve(random(xMin,xMax),random(yMin,yMax),x4A,y4,x5A,y5,random(xMin,xMax),random(yMin,yMax));
      //line(x4A,y4,x5A,y5);
      curve(random(xMin,xMax),random(yMin,yMax),x4A,y4,x5B,y5,random(xMin,xMax),random(yMin,yMax));
      //line(x4A,y4,x5B,y5);
      //ellipse(x4B,y4,5,5);
    } else {
      curve(random(xMin,xMax),random(yMin,yMax),x4B,y4,x5A,y5,random(xMin,xMax),random(yMin,yMax));
      //line(x4B,y4,x5A,y5);
      curve(random(xMin,xMax),random(yMin,yMax),x4B,y4,x5B,y5,random(xMin,xMax),random(yMin,yMax));
      //line(x4B,y4,x5B,y5);
      //ellipse(x4A,y4,5,5);
    }
    //ellipse(x5A,y5,5,5);
    //ellipse(x5B,y5,5,5);
}