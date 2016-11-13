//This code by Jacqui Fashimpaur for Golan Levin's class
//November 2016

public class Piece {
  float xPos;
  float yPos;
  float zPos;
  float side;
  PBvh bones;

  public Piece(float startX, float startY, float startZ, PBvh bone_file) {
    xPos = startX;
    yPos = startY;
    zPos = startZ;
    side = 0.01;
    bones = bone_file;
  }

  void draw() {
    set_side();
    if (side > 0.01) {
      noStroke();
      fill(getRed(), getGreen(), getBlue());
      translate(xPos, yPos, zPos);
      box(side);
      translate(-xPos, -yPos, -zPos);
    }
  }

  void set_side() {
    //POINT ONLY IMPLEMENTATION
    /*
    float head_dist = get_dist(bones.parser.getBones().get(48));
     float left_hand_dist = get_dist(bones.parser.getBones().get(31));
     float right_hand_dist = get_dist(bones.parser.getBones().get(12));
     float left_foot_dist = get_dist(bones.parser.getBones().get(6));
     float right_foot_dist = get_dist(bones.parser.getBones().get(3));
     float left_elbow_dist = get_dist(bones.parser.getBones().get(30));
     float right_elbow_dist = get_dist(bones.parser.getBones().get(11));
     float left_knee_dist = get_dist(bones.parser.getBones().get(5));
     float right_knee_dist = get_dist(bones.parser.getBones().get(2));
     float left_shoulder_dist = get_dist(bones.parser.getBones().get(29));
     float right_shoulder_dist = get_dist(bones.parser.getBones().get(10));
     
     boolean close_enough = ((head_dist<900) || (left_hand_dist<400) || (right_hand_dist<400) ||
     (left_foot_dist<400) || (right_foot_dist<400) || (left_elbow_dist < 200) ||
     (right_elbow_dist<200) || (left_knee_dist<200) || (right_knee_dist<200) || 
     (left_shoulder_dist<200) || (right_shoulder_dist<200));
     */

    //LINE-BASED FIGURE IMPLEMENTATION
    float head_dist = get_dist(bones.parser.getBones().get(48));
    float left_shin_dist = get_line_dist(bones.parser.getBones().get(5), bones.parser.getBones().get(6));
    float right_shin_dist = get_line_dist(bones.parser.getBones().get(3), bones.parser.getBones().get(2));
    float left_thigh_dist = get_line_dist(bones.parser.getBones().get(5), bones.parser.getBones().get(4));
    float right_thigh_dist = get_line_dist(bones.parser.getBones().get(3), bones.parser.getBones().get(4));
    float left_forearm_dist = get_line_dist(bones.parser.getBones().get(30), bones.parser.getBones().get(31));
    float right_forearm_dist = get_line_dist(bones.parser.getBones().get(11), bones.parser.getBones().get(12));
    float left_arm_dist = get_line_dist(bones.parser.getBones().get(29), bones.parser.getBones().get(30));
    float right_arm_dist = get_line_dist(bones.parser.getBones().get(10), bones.parser.getBones().get(11));
    float torso_dist = get_line_dist(bones.parser.getBones().get(0), bones.parser.getBones().get(8));

    boolean close_enough = ((head_dist<700) || (left_shin_dist<100) || (right_shin_dist<100) ||
                            (left_thigh_dist<100) || (right_thigh_dist<100) || (left_forearm_dist<100) ||
                            (right_forearm_dist<100) || (left_arm_dist<100) || (right_arm_dist<100) ||
                            (torso_dist<300));
    //POINT ONLY IMPLEMENTATION
    /* boolean close_enough = ((head_dist<900) || (left_hand_dist<400) || (right_hand_dist<400) ||
      (left_foot_dist<400) || (right_foot_dist<400) || (left_elbow_dist < 200) ||
      (right_elbow_dist<200) || (left_knee_dist<200) || (right_knee_dist<200) || 
      (left_shoulder_dist<200) || (right_shoulder_dist<200)); */

    //IMPLICIT SURFACE IMPLEMENTATION
    /*
    float sum = 1.0/(head_dist); 
     sum += 1.0/(left_hand_dist);
     sum += 1.0/(right_hand_dist);
     sum += 1.0/(left_foot_dist);
     sum += 1.0/(right_foot_dist);
     sum += 1.0/(left_elbow_dist);
     sum += 1.0/(right_elbow_dist);
     sum += 1.0/(left_knee_dist);
     sum += 1.0/(right_knee_dist);
     sum += 1.0/(left_shoulder_dist);
     sum += 1.0/(right_shoulder_dist);
     
     float K = 2000.0; 
     float newside = constrain(K * sum, 0, 10); 
     float A = 0.8; 
     float B = 1.0-A;
     side = (A * side) + (B * newside); 
     side = (side < 1) ? 0 : side; 
     */


     //TIME BLURRING IMPLEMENTATION
     /*
     float A = 0.7; 
     float B = 1.0-A;
     float newside = (close_enough) ? maxSide : 0.01; 
     side = (A * side) + (B * newside); 
     */

    //LINE-BASED OR POINT-ONLY IMPLEMENTATION
    if (!close_enough) {
      side *= 0.91;
    } else {
      //side *= 200;
      side = 7;
    }
    if (side < 0.01) {
      side = 0.01;
    }
    if (side >= maxSide){
      side = maxSide;
    }
  } 

  float get_dist(BvhBone b) {
    float x1 = b.absPos.x;
    float y1 = b.absPos.y;
    float z1 = b.absPos.z;
    float dist1 = abs(x1-xPos);
    float dist2 = abs(y1-yPos);
    float dist3 = abs(z1-zPos);
    return (dist1*dist1)+(dist2*dist2)+(dist3*dist3);
  }

  float get_line_dist(BvhBone b1, BvhBone b2) {
    float x1 = b1.absPos.x;
    float y1 = b1.absPos.y;
    float z1 = b1.absPos.z;
    float x2 = b2.absPos.x;
    float y2 = b2.absPos.y;
    float z2 = b2.absPos.z;
    float x3 = xPos;
    float y3 = yPos;
    float z3 = zPos;
    float dx = abs(x1-x2);
    float dy = abs(y1-y2);
    float dz = abs(z1-z2);
    float otherDist = sq(dx)+sq(dy)+sq(dz);
    if (otherDist == 0) otherDist = 0.001;
    float u = (((x3 - x1)*(x2 - x1)) + ((y3 - y1)*(y2 - y1)) + ((z3 - z1)*(z2 - z1)))/otherDist;
    if ((u >=0) && (u <= 1)) {
      float x = x1 + u*(x2 - x1);
      float y = y1 + u*(y2 - y1);
      float z = z1 + u*(z2 - z1);
      float dist4 = abs(x - xPos);
      float dist5 = abs(y - yPos);
      float dist6 = abs(z - zPos);
      return sq(dist4) + sq(dist5) + sq(dist6);
    }
    return 999999;
  }

  float getRed() {
    return map(xPos, -400, 100, 100, 200);
  }

  float getGreen() {
    //return map(xPos, -400, 100, 50, 150);
    return 100;
  }

  float getBlue() {
    return map(yPos, -50, 600, 250, 50);
  }
}