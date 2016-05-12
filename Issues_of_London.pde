/* 
 
 Reference: 
 - Drawing maps : http://unfoldingmaps.org/tutorials/basic-how-to-use-unfolding.html
 - How to structure Data : http://geojson.org/
 - GEO JSON Data found @ : https://github.com/utisz/compound-cities
 - London Air Quality Data API : http://www.londonair.org.uk/LondonAir/API/
 - Council Tax Data converted to JSON : Baiba Fogele, a Sustainble Cities Student @ Kings College London
 - JSON parsing from the web : http://blog.blprnt.com/blog/blprnt/processing-json-the-new-york-times
 : https://github.com/runemadsen/HTTP-Requests-for-Processing/blob/master/examples/jsonget/jsonget.pde
 - PieChart                  : https://processing.org/examples/piechart.html
 
 Description: 
 A data visualisation built with:
 - Processing v2.0
 - Unfolding Maps
 - Converted CSV Information to JSON regarding Council Tax Distribution (thanks to @baibaff, original source to be provided later)
 - London Air Quality API
 - Geo JSON information of all London Borough thanks to @utisz
 
 */

import de.fhpotsdam.unfolding.*;
import de.fhpotsdam.unfolding.geo.*;
import de.fhpotsdam.unfolding.utils.*;
import de.fhpotsdam.unfolding.data.*;
import de.fhpotsdam.unfolding.marker.*;
import de.fhpotsdam.unfolding.providers.*;
import java.util.List;
import java.util.Map;

GetBoundries getBoundries;//Will take all GeoJSON data
UIBox uiBox; // WIll show all UI Elements

GetCTData getCTData; // Council Tax Data
GetPolData getPolData; // Pollution Data * Run Kings AirQuality API First *

CTDisplay ctDisplay; // Shows all data collated for councilTax
PolDisplay polDisplay; // Shows all data collated for councilTax

Location londonLoc = new Location(51.5, -0.27); // Location for Center of London
UnfoldingMap map; //Mapping Library

PFont fontReg = createFont("Lato-Regular-11.vlw", 14);
PFont fontBold = createFont("Lato-Bold-14.vlw", 16);

/* Global Variables */
int boroughTotal = 33;
int innerBoroughTotal = 13;
int outerBoroughTotal = 20;

//Sets first piece of data shown to user
int currentBoroughNum = 0; //Will be used to help match ID to borough name
String currentBorough = "Barking & Dagenham";

String[] boroughNameMatch = { 
  "Barking & Dagenham", "Barnet", "Bexley", "Brent", "Bromley", "Camden", "City of London", "Croydon", "Ealing", 
  "Enfield", "Greenwich", "Hackney", "Hammersmith & Fulham", "Haringey", "Harrow", "Havering", "Hillingdon", "Hounslow", 
  "Islington", "Kensington & Chelsea", "Kingston upon Thames", "Lambeth", "Lewisham", "Merton", "Newham", "Redbridge", 
  "Richmond upon Thames", "Southwark", "Sutton", "Tower Hamlets", "Waltham Forest", "Wandsworth", "Westminster"
};

void setup() {
  size(displayWidth, displayHeight, P3D);

  //Unfolding Map Parameters
  //Stamen map tiles and toner added
  map = new UnfoldingMap(this, new StamenMapProvider.TonerBackground());
  map.zoomToLevel(11); //Sets inital zoom level
  map.panTo(londonLoc); //Sets Centerng from start of application
  //map.setTweening(true); // Creates smooth scroling effects but has other issues with panning
  map.setZoomRange(11, 17); // Set total zoom range
  map.setPanningRestriction(londonLoc, 30); //Resrticts panning left and right
  MapUtils.createDefaultEventDispatcher(this, map); //Captures mount events for scrolling

  //My Classes
  getBoundries = new GetBoundries(this); // Geo Json Boundry Data
  uiBox = new UIBox(); // UI Box Class

  getCTData = new GetCTData(); //To get data from manually created JSON file
  getPolData = new GetPolData(); //To get data from Kings_AirQuality_API collected JSON

  ctDisplay = new CTDisplay();
  polDisplay = new PolDisplay();

  //Data processing (Run only once)
  getBoundries.run(); //Geo Data
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
  Marker hitMarker = map.getFirstHitMarker(mouseX, mouseY); // boolean is true if mouse is over a marker

  //This for loop unhighlights all other markers not under the the mouse.
  for (Marker marker : map.getMarkers ()) {
    marker.setSelected(false);
  }

  //This checks whether any information is in the marker and then sets the
  //selected marker to true in order to highlight it. 

  if (hitMarker != null) {
    hitMarker.setSelected(true);
    currentBorough = hitMarker.getId();//ID Capture to send borough name to match with all other data
    for (int i = 0; i < boroughTotal; i ++) {
      //Data will only display if mouse is over a borough.
      if (currentBorough == boroughNameMatch[i]) {
        currentBoroughNum = i; //Used to Capture borough ID. each Id is linked to a borough
      }
    }
  }
}

