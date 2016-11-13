//Adapted by Jacqui Fashimpaur from in-class example

BvhParser parserA = new BvhParser();
PBvh bvh1, bvh2, bvh3;
final int maxSide = 7;

ArrayList<Piece> allPieces;
	
public void setup()
{
  size( 1280, 720, P3D );
  background(0);
  noStroke();
  frameRate( 70 );
  //noSmooth();
  
  bvh1 = new PBvh( loadStrings( "Katia_Dance_1_body1.bvh" ) );
  allPieces = new ArrayList<Piece>();
  for (int x=-400; x<100; x+=7){
    for (int y=-50; y<600; y+=7){
       for (int z=-400; z<100; z+=7){
         Piece myPiece = new Piece(x,y,z,bvh1);
         allPieces.add(myPiece);
       }
    }
  }
  loop();
}

public void draw()
{
  background(0);
  //camera
  float t = millis()/2000.0f;
  float xCenter = width/2.0 + 150;
  float zCenter = 300;
  float camX = (xCenter + 500*cos(t));
  float camZ = (zCenter + 500*sin(t));
  //moving camera
  camera(camX, height/2.0 - 300, camZ, width/2.0 + 150, height/2.0 - 200, 300, 0, 1, 0);
  //still camera
  //camera(xCenter, height/2.0 - 300, -300, width/2.0 + 150, height/2.0 - 200, 300, 0, 1, 0);
  
  pushMatrix();
  translate( width/2, height/2-10, 0);
  scale(-1, -1, -1);
  
  ambientLight(102, 102, 102);
  directionalLight(126, 100, 200, 0, 0, -1);
  directionalLight(180, 100, 126, 0, 0, 1);
  //model
  bvh1.update( millis() );
  //bvh1.draw();
  for (int i=0; i<allPieces.size(); i++){
    Piece p = allPieces.get(i);
    p.draw();
  }
  popMatrix();
}