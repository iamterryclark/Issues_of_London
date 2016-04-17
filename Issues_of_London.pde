/* 

 Reference: 
 - Drawing maps : http://unfoldingmaps.org/tutorials/basic-how-to-use-unfolding.html
 - How to structure Data : http://geojson.org/
 - GEO JSON Data found @ : https://github.com/utisz/compound-cities
 - London Air Quality Data API : http://www.londonair.org.uk/LondonAir/API/
 - Council Tax Data : Baiba Fogele, a Sustainble Cities Student @ Kings College London
 - JSON parsing from the web : http://blog.blprnt.com/blog/blprnt/processing-json-the-new-york-times
                             : https://github.com/runemadsen/HTTP-Requests-for-Processing/blob/master/examples/jsonget/jsonget.pde
 -
 
 Description:  A Data Visualisation using:
              - Unfolding Maps, 
                - API Generated JSON Files via Kings Air Quality API
              - Manually created JSON file for Council tax data
              - GEO JSON found on Github
*/

import de.fhpotsdam.unfolding.*;
import de.fhpotsdam.unfolding.geo.*;
import de.fhpotsdam.unfolding.utils.*;
import de.fhpotsdam.unfolding.data.*;
import de.fhpotsdam.unfolding.marker.*;
import de.fhpotsdam.unfolding.providers.*;
import java.util.List;
import java.util.Map;


GetBoundries getBoundries;
UIBox uiBox;

GetCTData getCTData;// Council Tax Data
GetPolData getPolData;

CTDisplay ctDisplay;
//PolDisplay polDisplay;

Location londonLoc = new Location(51.5, -0.1);
UnfoldingMap map;

PFont fontReg = createFont("Lato-Regular-11.vlw", 14);
PFont fontBold = createFont("Lato-Bold-14.vlw", 16);


/* Global Variables */

int boroughTotal = 33;
int innerBoroughTotal = 13;
int outerBoroughTotal = 20;
int currentBoroughNum;
String currentBorough;

String[] boroughNameMatch = { 
  "Barking & Dagenham", "Barnet", "Bexley", "Brent", "Bromley", "Camden", "City of London", "Croydon", "Ealing", 
  "Enfield", "Greenwich", "Hackney", "Hammersmith & Fulham", "Haringey", "Harrow", "Havering", "Hillingdon", "Hounslow", 
  "Islington", "Kensington & Chelsea", "Kingston upon Thames", "Lambeth", "Lewisham", "Merton", "Newham", "Redbridge", 
  "Richmond upon Thames", "Southwark", "Sutton", "Tower Hamlets", "Waltham Forest", "Wandsworth", "Westminster"
};

boolean doItOnce = true;
boolean loadingData = true;;

void setup() {
  size(displayWidth, displayHeight, P3D);

  //Unfolding Map Parametes
  map = new UnfoldingMap(this, new StamenMapProvider.TonerBackground());
  map.zoomToLevel(11);
  map.panTo(londonLoc);
  //map.setTweening(true);
  map.setZoomRange(11, 17);
  map.setPanningRestriction(londonLoc, 10);
  MapUtils.createDefaultEventDispatcher(this, map);

  //My Classes
  
  getBoundries = new GetBoundries(this); // Geo Json Boundry Data
  uiBox = new UIBox(); // UI Box Class
  
  getCTData = new GetCTData(); //To get data from JSON file
  getPolData = new GetPolData(); //To get JSON Data from London Air Quality Netowork API

  ctDisplay = new CTDisplay();
  polDisplay = new PolDisplay();
  
  //Data processing (Run only once)
  getBoundries.run(); //Geo Data
  getCTData.run(); //Council Tax Data
}

void draw() {
  //Creating the main background colour
  color theColour = color(91, 142, 145);
  background(255); // This needs to be white to view map clearly
  tint(theColour, 255); // adding the colour through tint() function
  map.draw();
  uiBox.draw();
}

void mouseMoved() {
  Marker hitMarker = map.getFirstHitMarker(mouseX, mouseY);

  //This for loop unhighlights all other markers not under the the mouse.
  for (Marker marker : map.getMarkers ()) {
    marker.setSelected(false);
  }

  //This check whether any information is in the marker and then sets the
  //selected marker to true in order to highlight it. 
  if (hitMarker != null) {
    hitMarker.setSelected(true);
    currentBorough = hitMarker.getId();
  }
}

