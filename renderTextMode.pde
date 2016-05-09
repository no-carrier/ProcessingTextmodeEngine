// math for comments below is based on a 1024x768px screen with segSize variable set to 4.
// see initTextmode() method in other tab for more information.

// the tl;dr for this whole damn tab is this:
// we have a 256x192px off-screen buffer that we draw on
// we break that up into 4x4px segments, for a total of 64x48
// after we get the average RGB and brightness for each 4x4px segment
// we assign a colored 16x16px glyph and write it to our 1024x768px screen

// 1024x768 screen / 4 (for segment size) = 256x192px buffer
// 256x192px / 4 = 64x48 segments of 4x4px each
// 16x16px colored glyph assigned to each 64x48 4x4px segment = 1024x768px
// MATH CHECKS OUT - WOOHOO!
// (guess it wasn't really a tl;dr, but its shorter than what you see below...)


void renderTextMode() {
  b.loadPixels(); // this loads pixel data from the buffer into an array for faster access.

  // now we have to go through all of the pixels, analyzing their color and brightness to
  // assign an appropriate color and glyph. our buffer is currently 256x192px.

  for (int h=0; h<b.height/segSize; h++)  // this loop breaks up the buffer into 48 parts,
  {                                       // because 192 / 4 = 48.
    int startY = (h*segSize);             // we start at the top of the screen.
    for (int w=0; w<b.width/segSize; w++) // this nested loop breaks up the buffer in 64 parts,  
    {                                     // because 256 / 4 = 64.
      int startX = (w*segSize);           // we start at the left of the screen.

      // at this point, the 256x192px screen buffer is broken up into 4x4px
      // segments, making the resolution effectively 64x48.
      // startX and startY keep track of the upper left pixel in each 4x4px segment.

      float allR = 0;                    // these variables will be used to add and average
      float allG = 0;                    // the red, green, blue, and brightness of each pixel,
      float allB = 0;                    // in order to set a character and define hue for each segment.
      float allBri = 0;  

      // we go through each 4x4px segment, of which there are 3,072 (64x48, like we said above).

      for (int y=0; y<segSize; y++ )     // we analyze each pixel in the 4x4 segment (for a total of 16): 
      {                                  // the "y" interates over the rows
        for (int x=0; x<segSize; x++)    // and the "x" interates over the columns.
        {
          int cY = y + startY;           // cY and cX are our current x and y values, based on 
          int cX = x + startX;           // the loop we're currently in, offset by startY and startX,
                                         // which keep track of which segment we're in.

          color c = b.pixels[cY*b.width+cX]; // here we get the color of each pixel drawn to buffer,
                                             // from the pixels array we loaded previously.

          float currentR = red(c);           // we take the current red value for our pixel
          allR = (allR + currentR);          // and add it to the total red value for our segment.
          float currentG = green(c);         // now let's do the same for green...
          allG = (allG + currentG);
          float currentB = blue(c);          // ...and for blue, but don't forget...
          allB = (allB + currentB);
          float currentBri = brightness(c);  // ...to add up the brightness!
          allBri = (allBri + currentBri);
        }
      }

      // after the segment is analyzed, we divide by total number of pixels in a segment to get averages
      // for red, green, and blue
      
      float sr = (allR / (segSize * segSize) );     // sr, sg, and sb hold the average amount of
      float sg = (allG / (segSize * segSize) );     // red, green, and blue in each 4x4px segment.
      float sb = (allB / (segSize * segSize) );     
      
      fill(sr, sg, sb);                             // finally we assign a fill color for our glyph
                                                    // based on the average RGB values calculated above.

      float segb = (allBri / (segSize * segSize) ); // just like above, we get the average brightness
                                                    // of each 4x4 pixel segment and average it.
                                                    
      // we now have a fill color and brightness for our current 4x4px segment. next we have to use
      // the brightness value to assign a glyph to each 4x4px segment. since the color is already set
      // above, the code below will assign glyphs with more negative space to darker segments and 
      // less negative space to brighter segments. there is a block mode, with four characters (including
      // a space, which is 0 brightness) and ASCII mode which has ten characters (and also uses a space
      // for 0 brightness segments).
      
      // its important to note that we are assigning a color and a glyph to be written to our
      // screen, NOT our off-screen buffer. our off-screen 256x192 buffer is what we draw on, but
      // our 1024x768 screen is what we end up writing all 3,072 colored glyphs to every frame.

      if (blockMode) {                                   // if we are using block mode:
        if (sb > 204) {                                  // and the brightness is above 204
          text("█", startX * segSize, startY * segSize); // we assign this character.
        } else if (segb > 152) {                         // if its above 152, we assign it
          text("▓", startX * segSize, startY * segSize); // this character. and so on...
        } else if (segb > 100) {
          text("▒", startX * segSize, startY * segSize);
        } else if (segb > 48) {
          text("░", startX * segSize, startY * segSize); // and if the brightness for our segment
        }                                                // is under 48, we don't assign a glyph.
      } 
        else {                                            // here is our ASCII mode,
        if (sb > 230) {                                   // where we do the same as above,
          text("#", startX * segSize, startY * segSize);  // but we more characters!
        } else if (segb > 207) {
          text("&", startX * segSize, startY * segSize);
        } else if (segb > 184) {
          text("$", startX * segSize, startY * segSize);
        } else if (segb > 161) {
          text("X", startX * segSize, startY * segSize);
        } else if (segb > 138) {
          text("x", startX * segSize, startY * segSize);
        } else if (segb > 115) {
          text("=", startX * segSize, startY * segSize);
        } else if (segb > 92) {
          text("+", startX * segSize, startY * segSize);
        } else if (segb > 69) {
          text(";", startX * segSize, startY * segSize);
        } else if (segb > 46) {
          text(":", startX * segSize, startY * segSize);
        } else if (segb > 23) {
          text(".", startX * segSize, startY * segSize);  // again, if brightness is less than 23, we
        }                                                 // don't assign a glyph, which makes it black.
      }
    }
  }
}