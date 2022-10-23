

import processing.video.*;

Movie movie;

void setup() {
  size(320, 240);
  movie = new Movie(this, "football.mp4");
  movie.play();
}

void draw() {

 
  float ratio = mouseX / (float) width;

    
  movie.jump(ratio * movie.duration()); 

  
  movie.read(); 
  
  image(movie, 0, 0);
}
