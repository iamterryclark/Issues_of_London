class GetBoundries {
  PApplet applet;
  List<Feature>[] innerBoroughs;
  List<Feature>[] outerBoroughs;
  List<Marker> innerLondonBoroughMarkers;
  List<Marker> outerLondonBoroughMarkers;

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
    this.applet = applet;
    innerLondonBoroughMarkers = new ArrayList<Marker>();
    innerBoroughs = new List[innerBoroughTotal];

    outerLondonBoroughMarkers = new ArrayList<Marker>();
    outerBoroughs = new List[outerBoroughTotal];
  }

  void run() {
    outerBoroughs();
    innerBoroughs();
  }

  void outerBoroughs() {
    //Outer London Points
    for (int i = 0; i < outerBoroughs.length; i++) {
      outerBoroughs[i] = GeoJSONReader.loadData(applet, "data/GreaterLondon/outer-london/" + outerLondonList[i] + ".geo.json");

      outerLondonBoroughMarkers = MapUtils.createSimpleMarkers(outerBoroughs[i]);
      map.addMarkers(outerLondonBoroughMarkers);
      for (Marker marker : outerLondonBoroughMarkers) {
        marker.setId(outerLondonListMatch[i]);
        marker.setColor(color(255, 255, 255, 200));
        marker.setStrokeWeight(2);
      }
    }
  }

  void innerBoroughs() {
    
    //Inner London Markers
    for (int i = 0; i < innerBoroughs.length; i ++) {
      innerBoroughs[i] = GeoJSONReader.loadData(applet, "data/GreaterLondon/inner-london/" + innerLondonList[i] + ".geo.json");

      innerLondonBoroughMarkers = MapUtils.createSimpleMarkers(innerBoroughs[i]);
      map.addMarkers(innerLondonBoroughMarkers);
      for (Marker marker : innerLondonBoroughMarkers) {
        marker.setId(innerLondonListMatch[i]);
        marker.setColor(color(150, 174, 220, 90));
        marker.setStrokeWeight(2);
      }
    }
  }
}
