class GetCTData {
  JSONObject json;
  int bandA, bandB, bandC, bandD, bandE, bandF, bandG, bandH;
  float bandAPrice, bandBPrice, bandCPrice, bandDPrice, bandEPrice, bandFPrice, bandGPrice, bandHPrice;  

  GetCTData() {
    //Loading the JSON data file and setting all array lengths. 
    json = loadJSONObject("CouncilTaxDistribution.json");
  }

  void run() {
    //Data is put into Arrays
    JSONObject borough = json.getJSONObject(currentBorough);

    //Number of household within each band
    bandA = borough.getInt("Band A");
    bandB = borough.getInt("Band B");
    bandC = borough.getInt("Band C");
    bandD = borough.getInt("Band D");
    bandE = borough.getInt("Band E");
    bandF = borough.getInt("Band F");
    bandG = borough.getInt("Band G");
    bandH = borough.getInt("Band H");

    //Price average of each band
    bandAPrice = borough.getFloat("£ Band A");
    bandBPrice = borough.getFloat("£ Band B");
    bandCPrice = borough.getFloat("£ Band C");
    bandDPrice = borough.getFloat("£ Band D");
    bandEPrice = borough.getFloat("£ Band E");
    bandFPrice = borough.getFloat("£ Band F");
    bandGPrice = borough.getFloat("£ Band G");
    bandHPrice = borough.getFloat("£ Band H");
  }
}

