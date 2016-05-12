/* 
 IMPORTANT: Some borough information was not collected from the API as it was not present.
            Barnet, Hounslow, Waltham Forest, Bromley, Newham and Westminster are all included in this exemption.

 Due to the many variations of the information it was difficult for me to understand how to display it to screen.
 A borough had many or one sites and a site had many or one pollutant(s). This created a very tough linearly 
 thinking arrangement. I opted to try a marker based interaction with the individual sites. so that when the mouse is
 over the borough individual marker using the .isInside() function you are able to then use a boolean if the  mouse is inside the marker position.
 
 However due to reason expain in getPolData, and the convuluted data structure along with an intense linear thought process,
 I was unable to complete this section fully before the deadline and unfortunately, boroughs with one site i.e Hillingdon create a nullpointer error.

*/
class PolDisplay {
  PImage[] icons;
  int airQualityIndex;

  PolDisplay() {
    fill(0);
    textAlign(CENTER);
    icons = new PImage[5];

    icons[0] = loadImage("data/icons/sites.png");
    icons[1] = loadImage("data/icons/species.png");
    icons[2] = loadImage("data/icons/target.png");
    icons[3] = loadImage("data/icons/targetMet.png");
    icons[4] = loadImage("data/icons/targetNotMet.png");
  }

  void dataCollate() {
    textSize(30);
    text("Pollution Data", height/4, 40);

    textSize(27);
    text(currentBorough, height/4, 80);

    if (getPolData.dailyHasData) {
      textSize(22);
      String date = getPolData.day + "/" + getPolData.month + "/" + getPolData.year;
      text("Date Last Updated: " + date, height/4, 110);    

      for (int i = 0; i < 3; i ++) {
        image(icons[i], 50, (i + 2) * 100, icons[0].width/5, icons[0].height/5);
      }
      
      //Creates a null pointer - unable to rectify due to project timescale
      if (getPolData.sitesNum > 1) {
        for (int i = 0; i < getPolData.sitesNum; i++) {
          if (getPolData.siteMarkers[i].isInside(map, mouseX, mouseY)) {
            println(getPolData.siteMarkers[i].getId());
          }
        }
      } else if (getPolData.sitesNum == 1) {//Null pointer error on boroughs with only 1 site
        if (getPolData.siteMarkers[0].isInside(map, mouseX, mouseY)) {
          println(getPolData.siteMarkers[0].getId());
        }
      }
      
    } else if (!getPolData.dailyHasData) {
      textSize(30);
      text("No Data Collected", height/4, 400);
      text("for " + currentBorough, height/4, 450);
    }
  }
}

