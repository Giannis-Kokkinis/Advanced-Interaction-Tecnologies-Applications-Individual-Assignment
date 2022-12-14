import gab.opencv.*;
import processing.video.*;


OpenCV opencv;
Capture video;

void setup() {
  size(720, 480);
  println(Capture.list());
  
  video = new Capture(this, 720, 480);
  video.start();
  opencv = new OpenCV(this, 720, 480);

  opencv.startBackgroundSubtraction(5, 3, 0.5);


}

void draw() {
  image(video, 0, 0);

  if (video.width == 0 || video.height == 0)
    return;

  opencv.loadImage(video);
  opencv.updateBackground();

  opencv.dilate();
  opencv.erode();

  noFill();
  stroke(0, 150, 0);
  strokeWeight(3);
  for (Contour contour : opencv.findContours()) {
    contour.draw();
  }
}

void captureEvent(Capture video) {
  // Step 4. Read the image from the camera.
  video.read();
}

void movieEvent(Movie m) {
  m.read();
}
