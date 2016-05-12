class UIBox {
  PShape iBUI, iBbg; // Information Board
  boolean UIOpen = true; //switch to turn on and off data
  boolean answer;
  int xOffset = 17;
  int yOffset = 40;
  int state = 1;// 1 = Council Tax 2 = Pollution Data

  UIBox() {
    shapeCreate();
  }

  void draw() {
    shape(iBUI);

    if (UIOpen) {
      openButtons();
      openInfo();
      if (mouseX > height/2 && mouseX < height/2 + yOffset && mouseY > 0 && mouseY < yOffset) { // Mouse is over Open Button
        cursor(CROSS);
        if (mousePressed) {
          iBUI.translate(-height/2, 0);
          UIOpen = false;
        }
      } else if (mouseX > height/2 - 40 && mouseX < height/2 - 20 && mouseY > height - 70 && mouseY < height - 40) { // Mouse is on Next button
        cursor(CROSS);
        if (mousePressed) {
          state++;
          if (state > 2) {
            state = 1;
          }
        }
      } else if (mouseX > height/2 - 70 && mouseX < height/2 - 50 && mouseY > height - 70 && mouseY < height - 40) { // Mouse is on Previous button
        cursor(CROSS);
        if (mousePressed) {
          state--;
          if (state < 1) {
            state = 1;
          }
        }
      } else {
        cursor(ARROW);
      }
    }

    if (!UIOpen) {
      closedButtons();
      if (mouseX > 0 && mouseX < yOffset && mouseY > 0 && mouseY < yOffset ) { // Mouse is on Close button
        cursor(CROSS);
        if (mousePressed) {
          iBUI.translate(height/2, 0);
          UIOpen = true;
        }
      } else {
        cursor(ARROW);
      }
    }
  }

  void shapeCreate() {
    //Create the main shape of the UI Area
    iBUI = createShape(GROUP); //Holds all UI shapes
    PVector[] iBShape = {  //Vectors for main background
      new PVector(0, 0), 
      new PVector(0, height), 
      new PVector(height/2, height), 
      new PVector(height/2, yOffset), 
      new PVector(height/2 + yOffset, yOffset), 
      new PVector(height/2 + yOffset, 0)
      };

      //Draws Info Board
      iBbg = createShape();

    iBbg.beginShape();
    for (int i = 0; i < iBShape.length; i ++) {
      iBbg.vertex(iBShape[i].x, iBShape[i].y);
    }
    iBbg.endShape(CLOSE);

    iBbg.setFill(color(255, 255, 255, 200));
    iBbg.setStroke(false);

    //Add elements to group
    iBUI.addChild(iBbg);
  }

  void openButtons() {
    textSize(22);
    text("<", height/2 + xOffset, 25); // Open/Close Indicator

    text("<", height/2 - 60, height - 60); //Previous Button
    text(">", height/2 - 30, height - 60); //Next Button
  }

  void closedButtons() {
    textSize(22);
    text(">", 20, 25); // Open/Close Indicator
  }

  void openInfo() {
    if (state == 1) {
      getCTData.run(); //Council Tax Data
      ctDisplay.dataCollate(); //Display Council Tax data from GetCTData
    }
    if (state == 2) {
      getPolData.runDaily(); // Pollution Data
      getPolData.runAnnual();
      polDisplay.dataCollate();//Display Pollution data from GetPolData
    }
  }
}
