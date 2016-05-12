/* 
 IMPORTANT: Some borough information was not collected from the API as it was not present.
            Barnet, Hounslow, Waltham Forest, Bromley, Newham and Westminster are all included in this exemption.
            
 The aim here was to process all JSON data from the London Air Quality API, unfortunately the more I delved into the data the more complex the data structures were and thus
 did not complete the full data visualisation for pollution levels around London.
 
 Each Borough has 1 or many sites and each site mesasures 1 or many species.
 
 I used a number of nested try catch methods in order to capture all present information storing it into a 2d array where necessary.
 
 myArray[site][pollutant/species]
 
 I struggled with PolDisplay as this required further linear thinking and processing and I found a slight issues when the borough had only 1 site. a null pointer exsists.
 Also in the data exsists multiple sites at 1 latitude and longitiude location makeing this even more complex as i would then need to display 1 or two bits of informtion to screen
 depending on this.
 
 I was unable to complete the pollution part of the program but was able to have all information stored how I wanted it to.
 
 Note: Object means singular in site or species
 Array means many sites or species
 
 */

class GetPolData {
  JSONObject dailyMonitorPerBorough, annualTargetPerBorough;

  int sitesNum = 0;
  int speciesNum, objectiveNum, airQualityIndex;
  boolean dailyHasData, annualHasData, dailyHasManySites;
  String day, month, year, dateCollected, speciesDesc, speciesCode;

  int[][] airQualityIndexArr, speciesAnnualValueArr, valueAnnualArr;
  boolean[][] dailyHasManySpecies;
  String[][] speciesDescArr, speciesCodeDailyArr, speciesCodeAnnualArr, objectiveDesc, targetAchived;
  
  SimplePointMarker[] siteMarkers;
  SimplePointMarker siteMarker;
  
  GetPolData() {
  }

  void runDaily() {
    //These need to be drawn as the size of the array will vary per borough
    //Using an arraylist may have ended up having unnecessary data filled within arrays. 
    airQualityIndexArr    = new int[sitesNum][speciesNum];
    speciesAnnualValueArr = new int[sitesNum][speciesNum];
    valueAnnualArr        = new int[sitesNum][speciesNum];

    dailyHasManySpecies   = new boolean[sitesNum][speciesNum];

    speciesDescArr        = new String[sitesNum][speciesNum];
    speciesCodeDailyArr   = new String[sitesNum][speciesNum];
    speciesCodeAnnualArr  = new String[sitesNum][speciesNum];
    objectiveDesc         = new String[sitesNum][speciesNum];
    targetAchived         = new String[sitesNum][speciesNum];
    
    siteMarkers = new SimplePointMarker[sitesNum];
    

    //Data is put into above Arrays
    try { //TEST: all available JSON Files 
      dailyMonitorPerBorough = loadJSONObject("../Kings_AirQuality_API/data/Daily Monitoring/" + currentBorough + ".json");
      JSONObject airQuality = dailyMonitorPerBorough.getJSONObject("DailyAirQualityIndex"); // Go to the next level down in the JSON file
      JSONObject locAuth = airQuality.getJSONObject("LocalAuthority");//Go one more level down in the JSON file
      dailyHasData = true; // If it has data then set to true
      try {  //TEST: If there is more than 1 site
        dailyHasManySites = true;
        JSONArray siteArray = locAuth.getJSONArray("Site"); //Get the array of sites
        sitesNum = siteArray.size(); // Store the total number of sites to the array above
        //Get date that data was updated from site information only get first in siteArray
        JSONObject siteInfo = siteArray.getJSONObject(0); //only 0 is used to pick first site date as they are all the same
        String dateCollected = siteInfo.getString("@BulletinDate");

        //strip the data and collect only day month and year storing them 
        day   = dateCollected.substring(8, 10);
        month = dateCollected.substring(5, 7);
        year  = dateCollected.substring(0, 4);

        //Get all other site information
        for (int i = 0; i < sitesNum; i++) {  
          JSONObject sitesObject = siteArray.getJSONObject(i);// Within the site array gather each object
          float latitude = sitesObject.getFloat("@Latitude");
          float longitude = sitesObject.getFloat("@Longitude");
          Location siteLocation = new Location(latitude, longitude);
          siteMarkers[i] = new SimplePointMarker(siteLocation);
          map.addMarker(siteMarkers[i]);
          siteMarkers[i].setColor(255);
          siteMarkers[i].setId(currentBorough + i); //This will be used to match the individual site markers to present information to screen
          try { //TEST: If it has more than one species and more than one site
            JSONArray speciesArray = sitesObject.getJSONArray("Species"); //If it does then get the array
            speciesNum = speciesArray.size();  //Store the total number of species in an array
            for (int j = 0; j < speciesNum; j ++) { //Cycle through all species within the array
              dailyHasManySpecies[i][j] = true;
              JSONObject speciesObject = speciesArray.getJSONObject(j); //Get each of the species for each site
              airQualityIndexArr[i][j]  = speciesObject.getInt("@AirQualityIndex");
              speciesDescArr[i][j]      = speciesObject.getString("@SpeciesDescription");
              speciesCodeDailyArr[i][j] = speciesObject.getString("@SpeciesCode");
            }
          } 
          catch (Throwable t) { //TEST: If only one species but many sites
            dailyHasManySpecies[i][0] = false;
            JSONObject speciesObject = sitesObject.getJSONObject("Species");
            airQualityIndex = speciesObject.getInt("@AirQualityIndex");
            speciesDesc =  speciesObject.getString("@SpeciesDescription"); //Used to match all possible values and only to display the value once.
            speciesCode = speciesObject.getString("@SpeciesCode"); //Used to display which pollutants are being measured at each site
          }
        }
      } 
      catch (Throwable t) { //TEST: If only has 1 site
        dailyHasManySites = false;
        JSONObject sitesObject = locAuth.getJSONObject("Site");
        float latitude = sitesObject.getFloat("@Latitude");
        float longitude = sitesObject.getFloat("@Longitude");
        Location siteLocation = new Location(latitude, longitude);
        siteMarker = new SimplePointMarker(siteLocation);
        map.addMarker(siteMarker);
        siteMarker.setColor(255);
        siteMarker.setId(currentBorough + 0);
      }
    }
    catch(Throwable t) {
      //If there is no JSON
      dailyHasData = false;
    }
  }

  void runAnnual() {
    //    try {//All Annual JSON files
    //      annualTargetPerBorough = loadJSONObject("../Kings_AirQuality_API/data/Annual Target/" + currentBorough + ".json");
    //      JSONObject siteObjOverallAnnual = annualTargetPerBorough.getJSONObject("SiteObjectives");
    //      JSONArray sitesAnnual = siteObjOverallAnnual.getJSONArray("Site");
    //      annualHasData = true;
    //      try { // if has more than one site
    //        for (int i = 0; i < sitesNum; i ++) {
    //          JSONObject sitesAnnualArr = sitesAnnual.getJSONObject(i);
    //          JSONArray siteObjective = sitesAnnualArr.getJSONArray("Objective");
    //          objectiveNum = sitesAnnualArr.size();
    //          for (int j = 0; j < objectiveNum; j++) { //more than one objective
    //            objectiveDesc[i][j] = sitesAnnualArr.getString("@ObjectiveName");
    //            speciesCodeAnnualArr[i][j]= sitesAnnualArr.getString("@SpeciesCode");
    //            targetAchived[i][j] = sitesAnnualArr.getString("@Achieved");
    //            valueAnnualArr[i][j] = sitesAnnualArr.getInt("@Value");
    //          }
    //        }
    //      } 
    //      catch(Throwable t) {//if only 1 site
    //        //Incomplete section
    //      }
    //    }
    //    catch (Throwable t) { //If any JSON file do not exsist
    //      annualHasData = false;
    //    }
  }
}

