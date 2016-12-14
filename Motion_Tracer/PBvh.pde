//Excuse the large ammount of commented code.
//This code is designed to be able to display
//in many different ways, depending on which code is active.
public class PBvh
{
  public BvhParser parser;  

  public PBvh(String[] data)
  {
    parser = new BvhParser();
    parser.init();
    parser.parse( data );
  }
  
  public void update( int ms )
  {
    parser.moveMsTo( ms );//30-sec loop 
    parser.update();
  }
  
  public void draw()
  {
    float x1;
    float y1;
    float z1;
    float x2;
    float y2;
    float z2;
    fill(255,245,240,255);
    BvhBone lastBone = parser.getBones().get(0);
    for( BvhBone b : parser.getBones())
    {
      /*noStroke();
      boolean isNormalJoint = (!(b==(parser.getBones().get(13))) && !(b==(parser.getBones().get(14))) &&
                               !(b==(parser.getBones().get(15))) && !(b==(parser.getBones().get(16))) &&
                               !(b==(parser.getBones().get(17))) && !(b==(parser.getBones().get(18))) &&
                               !(b==(parser.getBones().get(19))) && !(b==(parser.getBones().get(20))) &&
                               !(b==(parser.getBones().get(21))) && !(b==(parser.getBones().get(22))) &&
                               !(b==(parser.getBones().get(23))) && !(b==(parser.getBones().get(24))) &&
                               !(b==(parser.getBones().get(25))) && !(b==(parser.getBones().get(26))) &&
                               !(b==(parser.getBones().get(27))) && !(b==(parser.getBones().get(32))) &&
                               !(b==(parser.getBones().get(33))) && !(b==(parser.getBones().get(34))) &&
                               !(b==(parser.getBones().get(35))) && !(b==(parser.getBones().get(36))) &&
                               !(b==(parser.getBones().get(37))) && !(b==(parser.getBones().get(38))) &&
                               !(b==(parser.getBones().get(39))) && !(b==(parser.getBones().get(40))) &&
                               !(b==(parser.getBones().get(41))) && !(b==(parser.getBones().get(42))) &&
                               !(b==(parser.getBones().get(43))) && !(b==(parser.getBones().get(44))) &&
                               !(b==(parser.getBones().get(45))) && !(b==(parser.getBones().get(46))) &&
                               !(b==(parser.getBones().get(9))) && !(b==(parser.getBones().get(28))) &&
                               !(b==(parser.getBones().get(0))) && !(b==(parser.getBones().get(48))) &&
                               !(b==(parser.getBones().get(7))));
        boolean isHead = (b==parser.getBones().get(48));
        boolean isTorso = (b==parser.getBones().get(7));
        boolean isLimb = (b==parser.getBones().get(11) || b==parser.getBones().get(12) ||
                          b==parser.getBones().get(30) || b==parser.getBones().get(31) ||
                          b==parser.getBones().get(2) || b==parser.getBones().get(3) ||
                          b==parser.getBones().get(5) || b==parser.getBones().get(6));
        */
          //0 is center hip
          //1 is right hip
          //2 is right knee
          //3 is right foot
          //4 is left hip
          //5 is left knee
          //6 is left foot
          //7 is mid back
          //8 is base of neck
          //9 is right collar
          //10 is right shoulder
          //11 is right elbow
          //12 is right wrist
          //13-27 is right hand (more details later if needed)
          //28 is left collar
          //29 is left shoulder
          //30 is left elbow
          //31 is left wrist
          //32-46 is left hand (more details later if needed)
          // 47 is ?
          //48 is head
      /*pushMatrix();
      x1 = b.absPos.x;
      y1 = b.absPos.y;
      z1 = b.absPos.z;
      translate(x1, y1, z1);
      if (isNormalJoint){
        sphere(10);
      } else if (isHead){
        translate(0, 20, 0);
        scale(1, 1.2, 1);
        sphere(20);
        translate(0, -20, 0);
        scale(1, (1/1.2), 1);
      } else if (isTorso){
        /* 
        //upper Torso 
        beginShape(TRIANGLES);
        vertex(-30, 40, -15);
        vertex( 30, 40, -15);
        vertex(   0,  -30,  0);

        vertex( 30, 40, -15);
        vertex( 30,  40, 15);
        vertex(   0,    -30,  0);

        vertex( 30, 40, 15);
        vertex(-30, 40, 15);
        vertex(   0,   -30,  0);

        vertex(-30,  40, 15);
        vertex(-30, 40, -15);
        vertex(   0,    -30,  0);
        endShape();
        beginShape(QUAD);
        vertex(-30, 40, -15);
        vertex( 30, 40, -15);
        vertex( 30, 40, 15);
        vertex(-30, 40, 15);
        endShape();
        //Lower Torso
        beginShape(TRIANGLES);
        vertex(-30, -40, -15);
        vertex( 30, -40, -15);
        vertex(   0,  30,  0);

        vertex( 30, -40, -15);
        vertex( 30,  -40, 15);
        vertex(   0,    30,  0);

        vertex( 30, -40, 15);
        vertex(-30, -40, 15);
        vertex(   0,   30,  0);

        vertex(-30,  -40, 15);
        vertex(-30, -40, -15);
        vertex(   0,   30,  0);
        endShape();
        beginShape(QUAD);
        vertex(-30, -40, -15);
        vertex( 30, -40, -15);
        vertex( 30, -40, 15);
        vertex(-30, -40, 15);
        endShape();
      } else if (isLimb){
        //print("     " + b.absPos.x);
        float Xangle = get_Xrotate(b, lastBone);
        float Yangle = get_Yrotate(b, lastBone);
        float Zangle = get_Zrotate(b, lastBone);
        float limbX = get_Xmid(b, lastBone);
        float limbY = get_Ymid(b, lastBone);
        float limbZ = get_Zmid(b, lastBone);
        float limbLength = get_scale(b, lastBone);
        scale(1, limbLength, 1);
        rotateX(Xangle);
        rotateY(Yangle);
        rotateZ(Zangle);
        translate(limbX, limbY, limbZ);
        sphere(10);
        translate(limbX, limbY, limbZ);
        rotateZ(-Zangle);
        rotateY(-Yangle);
        rotateX(-Xangle);
        scale(1, (1/limbLength), 1);
      }
      popMatrix();
      if (!b.hasChildren())
      {
        pushMatrix();
        translate(-x1, -y1, -z1);
        //translate( b.absEndPos.x, b.absEndPos.y, b.absEndPos.z);
        x2 = b.absEndPos.x;
        y2 = b.absEndPos.y;
        z2 = b.absEndPos.z;
        popMatrix();
      } else {
        x2 = x1;
        y2 = y1;
        z2 = z1;
      }
      lastBone = b;
    } */
    
  }
}

float get_scale(BvhBone me, BvhBone you){
  float x1 = me.absPos.x;
  float y1 = me.absPos.y;
  float z1 = me.absPos.z;
  float x2 = you.absPos.x;
  float y2 = you.absPos.y;
  float z2 = you.absPos.z;
  float distX = abs(x1-x2);
  float distY = abs(y1-y2);
  float distZ = abs(z1-z2);
  float scale = sqrt((distX*distX)+(distY*distY)+(distZ*distZ))/10;
  return scale;
}

float get_Xrotate(BvhBone me, BvhBone you){
  float z1 = me.absPos.z;
  float y1 = me.absPos.y;
  float angle = atan2(z1,y1);
  return angle;
}

float get_Yrotate(BvhBone me, BvhBone you){
  float x1 = me.absPos.x;
  float z1 = me.absPos.z;
  float angle = atan2(x1,z1);
  return angle;
}

float get_Zrotate(BvhBone me, BvhBone you){
  float x1 = me.absPos.x;
  float y1 = me.absPos.y;
  float angle = atan2(x1,y1);
  return angle;
}

float get_Xmid(BvhBone me, BvhBone you){
  float x1 = me.absPos.x;
  float x2 = you.absPos.x;
  return ((x1+x2)/2)-x1;
}

float get_Ymid(BvhBone me, BvhBone you){
  float y1 = me.absPos.y;
  float y2 = you.absPos.y;
  return ((y1+y2)/2)-y1;
}

float get_Zmid(BvhBone me, BvhBone you){
  float z1 = me.absPos.z;
  float z2 = you.absPos.z;
  return ((z1+z2)/2)-z1;
}
}