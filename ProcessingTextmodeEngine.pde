PFont font;       // textmode font
PGraphics b;      // screen buffer
PImage img;       // used for face.png

int segSize;      // segment size, see renderTextMode tab for (lots) more detail 
int display = 1;  // choose which demo to display, starts with face image
float tick;       // counter, used for sin calcuations for shape rotation

boolean doDraw = true;      // draw or pause
boolean blockMode = false;  // block mode or ASCII mode
boolean fps = false;        // show FPS or not
boolean textMode = true;    // show buffer (stretched to fit screen) or textmode

void setup() {
  size(1024, 768, P2D);     // need to use P2D as renderer, as we use P3D for buffer
  img = loadImage("face.png");
  noSmooth();               // keep it blocky :)
  noCursor();               // don't need this!
  initTextmode();           // set up buffer, load font for textmode output
}

void draw() {
  if (doDraw) {    
    tick = tick + 0.01;

    helloWorld();           // let's show off the textmode engine, shall we?

    // render options 
    if (textMode) {         // choose how to render:
      background(0);
      renderTextMode();     // display textmode...
    } else {
      background(0);
      image(b, 0, 0, width, height);  // ...or display buffer (stretched to fit screen)
    }
    if (fps) {
      fill(0); 
      rect(0, 0, 32, 16);
      fill(255);
      text(int(frameRate), 0, 0);
    }
  }
}

void initTextmode() {
  segSize = 4;
  //  800x600 / segSize of 4 = 200x150 buffer --- 1024x768 / segSize of 4 = 256x192 buffer
  // see renderTextMode about this whole buffer and segment size thing
  b = createGraphics(width/segSize, height/segSize, P3D);  // we need P3D for our shapes
  // 16x16 IBM Bios font from: http://int10h.org/oldschool-pc-fonts/readme/
  font = loadFont("Px437_IBM_BIOS-16.vlw"); 
  textFont(font, 16);   // size of font
  textAlign(LEFT, TOP); // helps line it all up
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

void drawImage()  // draws and rotates a face image
{
  b.translate(b.width/2, b.height/2);
  b.rotateY((tick*100)*TWO_PI/360);
  b.translate(-img.width/2, -img.height/2);
  b.image(img, 0, 0);
}

void drawBox() {  // draws a wireframe cube with simple lighting
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

void drawBoxFilled() {  // draws a filled cube with a spotlight
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

void drawSphere() {  // draws a filled sphere with a spotlight
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
  if (key == ' ') { // this is the spacebar ;)
    display++;
    if (display > 4) {
      display = 1;
    }
  }
}