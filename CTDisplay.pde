//Used to dislay information from the GetCTData Class

class CTDisplay {

  CTDisplay() {
    fill(0);
    textAlign(CENTER);
  }

  void dataCollate() {
    //Used to calculate degrees in chart
    float totalNumberofBands = 
      getCTData.bandA +
      getCTData.bandB +
      getCTData.bandC +
      getCTData.bandD +
      getCTData.bandE +
      getCTData.bandF +
      getCTData.bandG +
      getCTData.bandH;

    float[] bandAmount = {
      getCTData.bandA, 
      getCTData.bandB, 
      getCTData.bandC, 
      getCTData.bandD, 
      getCTData.bandE, 
      getCTData.bandF, 
      getCTData.bandG, 
      getCTData.bandH
    };

    int[] listofBandPrices = { 
      (int)getCTData.bandAPrice, 
      (int)getCTData.bandBPrice, 
      (int)getCTData.bandCPrice, 
      (int)getCTData.bandDPrice, 
      (int)getCTData.bandEPrice, 
      (int)getCTData.bandFPrice, 
      (int)getCTData.bandGPrice, 
      (int)getCTData.bandHPrice
    };

    String[] letters = { 
      "A", "B", "C", "D", "E", "F", "G", "H"
    };

    textSize(30);
    text("Council Tax Distribution", height/4, 40);

    textSize(27);
    text(currentBorough, height/4, 80);

    textSize(22);
    text("Households Per Band", height/4, 140);
    text("£ per Band", height/4, 560);

    textSize(16);
    pieChart(height/4, bandAmount, totalNumberofBands, letters);
    chart(50, height - height/4 + 50, listofBandPrices, letters);
  }

  void pieChart(float diameter, float[] data, float total, String[] letters) {
    float lastAngle = -HALF_PI; // Sets first angle to start vertically

    for (int i = 0; i < data.length; i++) {
      float percentage = data[i]/total * 100; //each percentage is calculated
      float mapPercent = map(percentage, 0, 100, 0, 360); //then mapped into 360 degrees
      float mapCol = map(i, 0, data.length, 0, 255); // colors are set and this will be the same for all band information
      int spacer = 35;
      int dataHeight = 215 + (i * spacer);

      //Chart
      noStroke();
      fill(mapCol, 40, 100);
      arc(150, 350, diameter, diameter, lastAngle, lastAngle+radians(mapPercent));
      lastAngle += radians(mapPercent);

      //Key
      rect(315, dataHeight, spacer, 25);
      fill(0);
      textAlign(LEFT);
      text(letters[i], 360, dataHeight + 20);
      text((int)percentage + " %", 390, dataHeight + 20);
    }
  }

  void chart(int xPos, int yPos, int[] data, String[] letters) {
    strokeWeight(1);
    stroke(0);
    line(xPos, yPos, xPos + 400, yPos);
    int[] xAxisLabels = { 
      0, 400, 800, 1200, 1600, 2000, 2400, 2800
    }; 

    for (int i = 0; i < letters.length; i++) {
      int mapBandPrice = (int)map(data[i], 448.5, 2789.95, 0, 200);
      float mapCol = map(i, 0, letters.length, 0, 255);

      fill(0);
      textAlign(CENTER);

      text(letters[i], xPos + 30 + (i * 50), yPos + 20);
      textSize(16);
      text("£" + data[i], 80 + (i * 50), yPos - mapBandPrice - 30);

      pushStyle();
      fill(mapCol, 40, 100);
      noStroke();
      rect(60 + (i * 50), yPos, 40, -mapBandPrice);
      popStyle();
    }
  }
}

