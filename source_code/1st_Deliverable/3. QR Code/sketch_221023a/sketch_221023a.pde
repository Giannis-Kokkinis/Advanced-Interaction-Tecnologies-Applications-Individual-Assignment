
PImage img; 

void setup() {
  size(320, 240);
 decoder = new Decoder(this);
  img = loadImage("qr-code.png");
}

void draw() {
  background(0);

  image(img, 0, 0, width, height);
  decoder.decodeImage(img);
}
void decoderEvent(Decoder decoder) {
  String statusMsg = decoder.getDecodedString(); 
  println(statusMsg);
}
void keyReleased() {
  // Depending on which key is hit, do different things:
  switch (key) {
  case 'H':link(decoder.getDecodedString());
  break;
  }
}
