int numberOfLines = 12;
int lineLength = 250;
float lines[][] = new float[numberOfLines][4];
float x1 = 0;
float y1 = 0;
float x2 = 0;
float y2 = 0;
float a = -1;
float z = -1;
float x3 = 0;
float y3 = 0;
float x4 = 0;
float y4 = 0;
void setup() {
  size(720, 480);
  for (int i=0; i<numberOfLines; i++){
    lines[i][0] = random(100,width-100);
    lines[i][1] = (random(100,height-100));
    lines[i][2] = (random(-lineLength,lineLength));
    lines[i][3] = (random(0,1));
  }
}
void draw() {
  background(100, 200, 200);
  x1 = 0;
  y1 = 0;
  x2 = 0;
  y2 = 0;
  stroke(255, 255, 255);
  strokeWeight(3);
  for (int j=0; j<numberOfLines; j++){
    x1 = lines[j][0];
    y1 = lines[j][1];
    x2 = x1+lines[j][2];
    if (lines[j][3]>=0.5){
      y2 = y1+(sqrt((lineLength*lineLength)-(lines[j][2]*lines[j][2])));
    } else {
      y2 = y1-(sqrt((lineLength*lineLength)-(lines[j][2]*lines[j][2])));
    } 
    line(x1,y1,x2,y2); //<>//
  }
  strokeWeight(0);
  fill(50, 125, 125);
  for (int b=0; b<numberOfLines; b++){
    x1 = lines[b][0];
    y1 = lines[b][1];
    x2 = x1+lines[b][2];
    if (lines[b][3]>=0.5){
      y2 = y1+(sqrt((lineLength*lineLength)-(lines[b][2]*lines[b][2])));
    } else {
      y2 = y1-(sqrt((lineLength*lineLength)-(lines[b][2]*lines[b][2])));
    }
    for (int c=0; c<numberOfLines; c++){
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
        ellipse((x1+a*(x2-x1)),(y1+a*(y2-y1)),15,15);
      }
    }
  }
}

void mousePressed(){
  for (int i=0; i<numberOfLines; i++){
    lines[i][0] = random(100,width-100);
    lines[i][1] = (random(100,height-100));
    lines[i][2] = (random(-lineLength,lineLength));
    lines[i][3] = (random(0,1));
  }
}