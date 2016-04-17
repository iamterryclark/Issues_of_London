class CTDisplay {
  
  CTDisplay() {
    fill(0);
    textAlign(CENTER);
  }

  void dataCollate() {
    for (int i = 0; i < boroughTotal; i ++) {
      if (currentBorough == boroughNameMatch[i]) {
        currentBoroughNum = i; //Used to iterate through JSON data in getData and get the arrays. each index is linked to a borough 

        float totalNumberofBands = 
          getCTData.bandA[currentBoroughNum] +
          getCTData.bandB[currentBoroughNum] +
          getCTData.bandC[currentBoroughNum] +
          getCTData.bandD[currentBoroughNum] +
          getCTData.bandE[currentBoroughNum] +
          getCTData.bandF[currentBoroughNum] +
          getCTData.bandG[currentBoroughNum] +
          getCTData.bandH[currentBoroughNum];

        float[] bandAmount = {
          getCTData.bandA[currentBoroughNum], 
          getCTData.bandB[currentBoroughNum], 
          getCTData.bandC[currentBoroughNum], 
          getCTData.bandD[currentBoroughNum], 
          getCTData.bandE[currentBoroughNum], 
          getCTData.bandF[currentBoroughNum], 
          getCTData.bandG[currentBoroughNum], 
          getCTData.bandH[currentBoroughNum]
        };

        int[] listofBandPrices = { 
          (int)getCTData.bandAPrice[currentBoroughNum], 
          (int)getCTData.bandBPrice[currentBoroughNum], 
          (int)getCTData.bandCPrice[currentBoroughNum], 
          (int)getCTData.bandDPrice[currentBoroughNum], 
          (int)getCTData.bandEPrice[currentBoroughNum], 
          (int)getCTData.bandFPrice[currentBoroughNum], 
          (int)getCTData.bandGPrice[currentBoroughNum], 
          (int)getCTData.bandHPrice[currentBoroughNum]
        };

        String[] letters = { 
          "A", "B", "C", "D", "E", "F", "G", "H"
        };

        textSize(30);
        text("Council Tax Distribution", height/4, 30);

        textSize(27);
        text(currentBorough, height/4, 80);

        textSize(22);
        text("Households Per Band", height/4, 140);
        text("£ per Band", height/4, 500);

        textSize(16);
        doughnutChart(height/4, bandAmount, totalNumberofBands, letters);
        chart(50, height - height/3, listofBandPrices, letters);
      }
    }
  }

  void doughnutChart(float diameter, float[] data, float total, String[] letters) {
    float lastAngle = -HALF_PI; // Sets first angle to start vertically

    for (int i = 0; i < data.length; i++) {
      float percentage = data[i]/total * 100;
      float mapPercent = map(percentage, 0, 100, 0, 360);
      float mapCol = map(i, 0, data.length, 0, 255);
      int spacer = 30;
      int dataHeight = 180 + (i * spacer);

      //Chart
      noStroke();
      fill(mapCol, 40, 100);
      arc(150, 300, diameter, diameter, lastAngle, lastAngle+radians(mapPercent));
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
      int mapBandPrice = (int) map(data[i], 448.5, 2789.95, 0, 200);
      float mapCol = map(i, 0, letters.length, 0, 255);

      fill(0);
      textAlign(CENTER);

      text(letters[i], 80 + (i * 50), (height - height/3)+50);
      textSize(16);
      text("£" + data[i], 80 + (i * 50), (height - height/3) - mapBandPrice - 20);

      pushStyle();
      fill(mapCol, 40, 100);
      noStroke();
      rect(60 + (i * 50), (height - height/3), 40, -mapBandPrice);
      popStyle();
    }
  }
}

