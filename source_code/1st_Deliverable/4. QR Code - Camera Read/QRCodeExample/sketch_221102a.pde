
    
   import processing.video.*;
   import qrcodeprocessing.*;

Capture video;                                 // instance of the video capture library
String statusMsg = "Waiting for an image";     // a string to return messages:


Decoder decoder;

void setup() {
  size(400, 320);
  video = new Capture(this, 320, 240);
  video.start();

 
  decoder = new Decoder(this);
}


void decoderEvent(Decoder decoder) {
  statusMsg = decoder.getDecodedString();
}

void captureEvent(Capture video) {
  video.read();
}

void draw() {
  background(0);

  
  image(video, 0, 0);
  
  text(statusMsg, 10, height-4);

  
  if (decoder.decoding()) {
    
    PImage show = decoder.getImage();
    image(show, 0, 0, show.width/4, show.height/4); 
    statusMsg = "Decoding image";
    for (int i = 0; i < (frameCount/2) % 10; i++) statusMsg += ".";
  }
}

void keyReleased() {
  
  switch (key) {
  case ' ':        
   
    PImage savedFrame = createImage(video.width, video.height, RGB);
    savedFrame.copy(video, 0, 0, video.width, video.height, 0, 0, video.width, video.height);
    savedFrame.updatePixels();
    // Decode savedFrame
    decoder.decodeImage(savedFrame);
    break;
  case 'f':    
    PImage preservedFrame = loadImage("qr-code.png");
    // Decode file
    decoder.decodeImage(preservedFrame);
    break;
    case 'g':    
    link(decoder.getDecodedString());
    break;
  }
} 
