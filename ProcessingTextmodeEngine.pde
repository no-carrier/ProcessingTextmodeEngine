PFont font; // textMode font
PGraphics b; // screen buffer
PShape s;  // shape
PImage img;

int segSize; // segment size that screen is divided by 
int display = 1;
float tick; // counter

boolean doDraw = true;
boolean blockMode = false; 
boolean fps = false;   
boolean textMode = true; 

void setup() {
  size(1024, 768, P2D);
  img = loadImage("face.png");
  noSmooth();
  noCursor();
  initTextmode(); // set up buffer, load font for textmode output
}

void draw() {
  if (doDraw) {
    tick = tick + 0.01;

    helloWorld(); // simple demo

    // render options 
    if (textMode) { // choose how to render
      background(0);
      renderTextMode(); // display textmode...
    } else {
      background(0);
      image(b, 0, 0, width, height);   // ...or display buffer (stretched to fit screen)
    }
    if (fps) { // display FPS if toggled
      fill(0); // draw a box to make FPS easier to read ;)
      rect(0, 0, 32, 16);
      fill(255); // display FPS in upper left corner
      text(int(frameRate), 0, 0);
    }
  }
}

void initTextmode() {
  segSize = 4;
  //  800x600 / segSize of 4 = 200x150 buffer --- 1024x768 / segSize of 4 = 256x192 buffer
  b = createGraphics(width/segSize, height/segSize, P3D);
  font = loadFont("Px437_IBM_BIOS-16.vlw");
  textFont(font, 16); // size of font
  textAlign(LEFT, TOP);
}

void helloWorld() {
  b.beginDraw();
  b.background(0);
  switch(display) {
  case 1: 
    drawImage();
    break;
  case 2:
    drawBox();    
    break;
  case 3:
    drawBoxFilled();    
    break;
  case 4:
    drawSphere();
    break;
  }
  b.endDraw();
}

void drawImage()
{
  b.translate(b.width/2, b.height/2);
  b.rotateY((tick*100)*TWO_PI/360);
  b.translate(-img.width/2, -img.height/2);
  b.image(img, 0, 0);
}

void drawBox() {
  b.lights();
  b.pushMatrix();
  b.translate(b.width/2, b.height/2, 0); 
  b.rotateY(tick);
  b.rotateX(-tick);
  b.noFill();
  b.strokeWeight(6);
  b.stroke(255, 255, 0);
  b.box(100);
  b.popMatrix();
}

void drawBoxFilled() {
  b.spotLight(0, 255, 0, b.width/2, b.height/2, 400, 0, 0, -1, PI/4, 2);
  b.pushMatrix();
  b.translate(b.width/2, b.height/2, 0); 
  b.rotateY(tick);
  b.rotateX(-tick);
  b.fill(255);
  b.strokeWeight(6);
  b.stroke(255, 255, 0);
  b.box(100);
  b.popMatrix();
}

void drawSphere() {
  b.spotLight(255, 0, 0, b.width/2, b.height/2, 400, 0, 0, -1, PI/4, 2);
  b.pushMatrix();
  b.translate(b.width/2, b.height/2, 0);
  b.rotateY(-tick);
  b.rotateX(+tick);
  b.strokeWeight(4);
  b.stroke(255, 165, 0);
  b.fill(255);
  b.sphereDetail(10);
  b.sphere(80);
  b.popMatrix();
}

void keyPressed() {
  if (key == 'q') { 
    fps = !fps;
  }
  if (key == 'a') {
    blockMode = !blockMode;
  } 
  if (key == 'z') { 
    textMode = !textMode;
  }
  if (key == 'p') { 
    doDraw = !doDraw;
  }
  if (key == ' ') { 
    display++;
    if (display > 4) {
      display = 1;
    }
  }
}