////Using Daniel Shiffman's HTTP Request library to pull information from a JSON file on a website
class PollutionAPIRequest {
  //This will hold individual JSON data before its saved
  JSONObject dailyMonitorBoroughPolJSON;
  JSONObject annualTargetBoroughPolJSON;
  
  //To catch any Boroughs with no information upon request
  IntList captureErrDailyMonitorBoroughNum; 
  IntList captureErrAnnualTargetBoroughNum;
  
  int boroughTotal = 33;
  
  //Same names set as the Issues_of_London Sketch to match Borough data together
  String[] boroughNameMatch = { 
      "Barking & Dagenham", "Barnet", "Bexley", "Brent", "Bromley", "Camden", "City of London", "Croydon", "Ealing", 
      "Enfield", "Greenwich", "Hackney", "Hammersmith & Fulham", "Haringey", "Harrow", "Havering", "Hillingdon", "Hounslow", 
      "Islington", "Kensington & Chelsea", "Kingston upon Thames", "Lambeth", "Lewisham", "Merton", "Newham", "Redbridge", 
      "Richmond upon Thames", "Southwark", "Sutton", "Tower Hamlets", "Waltham Forest", "Wandsworth", "Westminster"
  };

  PollutionAPIRequest() {
    captureErrDailyMonitorBoroughNum = new IntList();
    captureErrAnnualTargetBoroughNum = new IntList();
  }

  void run() { 
    println("");
    println("***********************************");
    println("Polution Data Collection In Progess");
    println("***********************************");
    println("");
    //Will try to retreive and save all JSON files
    JSONInfo(); 
    noData();
    println("");
    println("*********************************");
    println("Polution Data Collection Complete");
    println("*********************************");
  }

  //JSON Parsing functions
  //Seperate functions as the capture numbers may be different
  void JSONInfo() {
    for (int i = 1; i < boroughTotal; i ++) {
      
      //Set both URL's
      String dailyInfoURL = "http://api.erg.kcl.ac.uk/AirQuality/Daily/MonitoringIndex/Latest/LocalAuthorityId=" + i + "/Json";
      String annualInfoURL = "http://api.erg.kcl.ac.uk/AirQuality/Annual/MonitoringObjective/LocalAuthorityId=" + i + "/Year=2016/Json";
      
      //Init request
      GetRequest getDaily = new GetRequest(dailyInfoURL);
      GetRequest getAnnual = new GetRequest(annualInfoURL);
      
      //Send Request
      getDaily.send();
      getAnnual.send();

      //Program will wait until the request is completed
      try {
        //Try Daily URL and parse the JSON object storing it into a variable before then saving it to disk.
        //I felt that this was better to store in =to a variable for code readability and modularity
        dailyMonitorBoroughPolJSON = parseJSONObject(getDaily.getContent());
        saveJSONObject(dailyMonitorBoroughPolJSON, "data/Daily Monitoring/" + boroughNameMatch[i-1] + ".json");
        println("Stored Daily Monitor - JSON Data - " +  boroughNameMatch[i-1]);

        //Try Annual URL
        //Found suspicious charachter so needed to edit string and the parse to JSON.
        String tempJson = getAnnual.getContent();
        String editTempJson = tempJson.substring(1, tempJson.length());
        annualTargetBoroughPolJSON = parseJSONObject(editTempJson); 
        saveJSONObject(annualTargetBoroughPolJSON, "data/Annual Target/" + boroughNameMatch[i-1] + ".json");
        println("Stored Annual Target - JSON Data - " +  boroughNameMatch[i-1]);

      } 
      //Captures any strange errors from the above request
      //Stores the ID number for later
      catch(Throwable t) {
        captureErrDailyMonitorBoroughNum.append(i); // Capture the int which thorws an error on request
        println("Appended ID for Daily Monitor - JSON Data - " +  boroughNameMatch[i-1]);
        
        captureErrAnnualTargetBoroughNum.append(i); // Capture the int which thorws an error on request
        println("Appended ID for Annual Target - JSON Data - " +  boroughNameMatch[i-1]);
      }
    }
  }

  //XML Parsing Functions
  //Seperate functions as the capture numbers may be different
  void noData() {
    //Displays to the user via console log which borough could not be obtained
    for (int i = 0; i < captureErrDailyMonitorBoroughNum.size (); i++) {
      int boroughNumId = captureErrDailyMonitorBoroughNum.get(i);
      //boroughNumId is minus 1 due to order of String array above
      println("No Daily Monitor Information Collected for " +  boroughNameMatch[boroughNumId-1]);
    }
    for (int i = 0; i < captureErrAnnualTargetBoroughNum.size (); i++) {
      int boroughNumId = captureErrAnnualTargetBoroughNum.get(i);
      println("No Annual Target Information Collected for " +  boroughNameMatch[boroughNumId-1]);
    }
  }
}

