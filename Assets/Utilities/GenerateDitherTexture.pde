// Resolution of the texture
final int RESOLUTION = 256;
final float HALF_RESOLUTION = RESOLUTION / 2.0f;

// The number of dithering steps
final int STEPS = 100;

// Colors to interpolate between
final color MIN_COLOR = color(0,0,0);
final color MAX_COLOR = color(255,255,255);

// The max radius of the circle required
// to encompass the whole texture
float maxDiameter = RESOLUTION / sin(radians(45));


void settings() {
  size(RESOLUTION, RESOLUTION);
  noLoop();
}

void draw() {
  noStroke();
  
  // Single Dot
  for(int i = STEPS - 1; i >= 0; i--) {
    float ratio = (float) i / (STEPS - 1);
    
    println(ratio);
    float diameter = lerp(0, maxDiameter, ratio);
    color col = lerpColor(MIN_COLOR, MAX_COLOR, ratio);

    fill(col);
    ellipse(HALF_RESOLUTION, HALF_RESOLUTION, diameter, diameter);
  }
  
  
  
  save("../dither-sample.png");
  
  // Five Dot
  for(int i = STEPS - 1; i >= 0; i--) {
    float ratio = (float) i / (STEPS - 1);
    float diameter = lerp(0, maxDiameter, ratio);
    color col = lerpColor(MIN_COLOR, MAX_COLOR, ratio * 1.35f);
    fill(col);
  
    ellipse(HALF_RESOLUTION, HALF_RESOLUTION, diameter, diameter);
    ellipse(0, 0, diameter, diameter);
    ellipse(RESOLUTION, RESOLUTION, diameter, diameter);
    ellipse(0, RESOLUTION, diameter, diameter);
    ellipse(RESOLUTION, 0, diameter, diameter);
  }

  save("../check-dot-dither-sample.png");
    
}