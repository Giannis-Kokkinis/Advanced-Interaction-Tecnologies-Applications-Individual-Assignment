import processing.opengl.*;
import SimpleOpenNI.*;
import ddf.minim.*;

SimpleOpenNI kinect;
int [] userMap;

float rotation = 0;

// two AudioPlayer objects this time
Minim minim;
AudioPlayer t1;
AudioPlayer t2;
AudioPlayer t3;
AudioPlayer t4;
AudioPlayer t5;
AudioPlayer t6;

// declare our two hotpoint objects
Hotpoint t1Trigger;
Hotpoint t2Trigger;
Hotpoint t3Trigger;
Hotpoint t4Trigger;
Hotpoint t5Trigger;
Hotpoint t6Trigger;

float s = 1;

void setup() {
  
  size(640,480, OPENGL);
  kinect = new SimpleOpenNI(this);
  //kinect.enableDepth();
  
  if(kinect.isInit() == false)
  {
     println("Can't init SimpleOpenNI, maybe the camera is not connected!"); 
     exit();
     return;  
  }
  
  // enable depthMap generation 
  kinect.enableDepth();
 
  // enable RGB camera
  kinect.enableRGB(); 
 
  // enable skeleton generation for all joints
  kinect.enableUser();
 
  // turn on depth-color alignment 
  kinect.alternativeViewPointDepthToImage();
  
  noFill();
  float fov = PI/3.0;
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(5.37999992, float(width)/float(height),cameraZ/10.0, cameraZ*10.0);
  
  
  
  minim = new Minim(this);
  // load both audio files
  t1 = minim.loadFile("A4.mp3");
  t2 = minim.loadFile("Bb6.mp3");
  t3 = minim.loadFile("C7.mp3");
  t4 = minim.loadFile("E2.mp3");
  t5 = minim.loadFile("Eb1.mp3");
  t6 = minim.loadFile("Eb4.mp3");
  
  // initialize hotpoints with their origins (x,y,z) and their size
  t1Trigger = new Hotpoint(500, 250, 2000, 200);
  t2Trigger = new Hotpoint(-500, 250, 2000, 200);
  t3Trigger = new Hotpoint(200, 465, 2000, 200);
  t4Trigger = new Hotpoint(-200, 465, 2000, 200);
  t5Trigger = new Hotpoint(500, -250, 2000, 200);
  t6Trigger = new Hotpoint(-500, -250, 2000, 200);
  background(0);

}

void draw() {
  background(0);
  kinect.update();

 // get the Kinect color image
  PImage rgbImage = kinect.rgbImage(); 
  // prepare the color pixels 
  rgbImage.loadPixels();

  translate(width/2, height/2, 500);
  rotateX(radians(180));
  rotateZ(radians(180));
  
  translate(0, 0, 0);
  //rotateY(radians(map(mouseX, 0, width, -180, 180)));

  //translate(0, 0, s*-1000);
  scale(s);


  stroke(255,255,255,0);

  PVector[] depthPoints = kinect.depthMapRealWorld();

  int[] userList = kinect.getUsers();
  
  if(userList.length>0)
  {
    userMap = kinect.userMap();
    // load sketches pixels
    loadPixels();
   for(int i=0; i<userMap.length; i++)
    {
      // set the sketch pixel to the color pixel
      pixels[i] = rgbImage.pixels[i];
    }
   updatePixels();
  }
  
  for (int i = 0; i < depthPoints.length; i+=10) {
    PVector currentPoint = depthPoints[i];

    // have each hotpoint check to see
    // if it includes the currentPoint
    t1Trigger.check(currentPoint);
    t2Trigger.check(currentPoint);
    t3Trigger.check(currentPoint);
    t4Trigger.check(currentPoint);
    t5Trigger.check(currentPoint);
    t6Trigger.check(currentPoint);

    point(currentPoint.x, currentPoint.y, currentPoint.z);
  }

  println(t1Trigger.pointsIncluded);

  if(t1Trigger.isHit()) {
    t1.play();
  }  
  
  if(!t1.isPlaying()) {
    t1.rewind();
    t1.pause();
  }

  if (t2Trigger.isHit()) {
    t2.play();
  }  
  
  if(!t2.isPlaying()) {
    t2.rewind();
    t2.pause();
  } 
  
  if (t3Trigger.isHit()) {
    t3.play();
  }  
  
  if(!t3.isPlaying()) {
    t3.rewind();
    t3.pause();
  } 
  
  if (t4Trigger.isHit()) {
    t4.play();
  }  
  
  if(!t4.isPlaying()) {
    t4.rewind();
    t4.pause();
  } 
  
  if (t5Trigger.isHit()) {
    t5.play();
  }  
  
  if(!t5.isPlaying()) {
    t5.rewind();
    t5.pause();
  } 
  
  if (t6Trigger.isHit()) {
    t6.play();
  }  
  
  if(!t6.isPlaying()) {
    t6.rewind();
    t6.pause();
  }
  // display each hotpoint
  // and clear its points
  t1Trigger.draw();
  t1Trigger.clear();
  
  t2Trigger.draw();
  t2Trigger.clear();
  
  t3Trigger.draw();
  t3Trigger.clear();
  
  t4Trigger.draw();
  t4Trigger.clear();
  
  t5Trigger.draw();
  t5Trigger.clear();
  
  t6Trigger.draw();
  t6Trigger.clear();
}

void stop()
{
  // make sure to close
  // both AudioPlayer objects
  t1.close();
  t2.close();
  t3.close();
  t4.close();
  t5.close();
  t6.close();

  minim.stop();
  super.stop();
}

void keyPressed() {
  if (keyCode == 38) {
    s = s + 0.01;
  }
  if (keyCode == 40) {
    s = s - 0.01;
  }
}
