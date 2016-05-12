class GetBoundries {
  PApplet applet;
  
  //Features from unfolding map
  List<Feature> innerBoroughs; //Holds all GEOJSON Info for inner boroughs
  List<Feature> outerBoroughs; //Holds all GEOJSON Info for outer boroughs
  List<Marker> innerLondonBoroughMarkers; //Plots all points for inner boroughs from GEOJSON
  List<Marker> outerLondonBoroughMarkers; //Plots all points for outer boroughs from GEOJSON

  //Inner London lists for getting geo.json files 
  String[] innerLondonList = { 
    "camden", "city-of-london", "city-of-westminster", "greenwich", "hackney", 
    "hammersmith-and-fulham", "islington", "kensington-and-chelsea", "lambeth", 
    "lewisham", "southwark", "tower-hamlets", "wandsworth"
  };

  //Inner London matching to data JSON
  String[] innerLondonListMatch = { 
    "Camden", "City of London", "Westminster", "Greenwich", "Hackney", 
    "Hammersmith & Fulham", "Islington", "Kensington & Chelsea", "Lambeth", 
    "Lewisham", "Southwark", "Tower Hamlets", "Wandsworth"
  };

  //Outer London lists for getting geo.json files 
  String[] outerLondonList = { 
    "barking-and-dagenham", "barnet", "bexley", "brent", "bromley", "croydon", 
    "ealing", "enfield", "haringey", "harrow", "havering", "hillingdon", 
    "hounslow", "kingston-upon-thames", "merton", "newham", "redbridge", 
    "richmond-upon-thames", "sutton", "waltham-forest"
  };

  //Outer London matching to data JSON
  String[] outerLondonListMatch = { 
    "Barking & Dagenham", "Barnet", "Bexley", "Brent", "Bromley", "Croydon", 
    "Ealing", "Enfield", "Haringey", "Harrow", "Havering", "Hillingdon", 
    "Hounslow", "Kingston upon Thames", "Merton", "Newham", "Redbridge", 
    "Richmond upon Thames", "Sutton", "Waltham Forest"
  };

  GetBoundries(PApplet applet) {
    this.applet = applet; //Links this module to the application's directory so it can locate files
  }

  void run() {
    outerBoroughs();
    innerBoroughs();
  }

  void outerBoroughs() {
    //Outer London Points
    for (int i = 0; i < outerBoroughTotal; i++) {
      //Reads each of the GEOJSON Files
      outerBoroughs = GeoJSONReader.loadData(applet, "data/GreaterLondon/outer-london/" + outerLondonList[i] + ".geo.json");

      //Inits markers on the map
      outerLondonBoroughMarkers = MapUtils.createSimpleMarkers(outerBoroughs);
      //Adds markers to the map
      map.addMarkers(outerLondonBoroughMarkers);
      for (Marker marker : outerLondonBoroughMarkers) {
        marker.setId(outerLondonListMatch[i]); //Used to identify borough
        marker.setColor(color(255, 255, 255, 200)); // Used to color borough
        marker.setStrokeWeight(2); //boundry stroke
      }
    }
  }

  void innerBoroughs() {
    //Inner London Markers
    for (int i = 0; i < innerBoroughTotal; i ++) {
      innerBoroughs = GeoJSONReader.loadData(applet, "data/GreaterLondon/inner-london/" + innerLondonList[i] + ".geo.json");

      innerLondonBoroughMarkers = MapUtils.createSimpleMarkers(innerBoroughs);
      map.addMarkers(innerLondonBoroughMarkers);
      for (Marker marker : innerLondonBoroughMarkers) {
        marker.setId(innerLondonListMatch[i]);
        marker.setColor(color(150, 174, 220, 90));
        marker.setStrokeWeight(2);
      }
    }
  }
  

}
