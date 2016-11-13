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
