class GetCTData {
  JSONObject json;
     int[] bandA, bandB, bandC, bandD, bandE, bandF, bandG, bandH;
   float[] bandAPrice, bandBPrice, bandCPrice, bandDPrice, bandEPrice, bandFPrice, bandGPrice, bandHPrice;  

  GetCTData() {
    //Setting all array lengths and loading the JSON data file 
    json = loadJSONObject("CouncilTaxDistribution.json");

    bandA = new int[boroughTotal];
    bandB = new int[boroughTotal];
    bandC = new int[boroughTotal];
    bandD = new int[boroughTotal];
    bandE = new int[boroughTotal];
    bandF = new int[boroughTotal];
    bandG = new int[boroughTotal];
    bandH = new int[boroughTotal];

    bandAPrice = new float[boroughTotal];
    bandBPrice = new float[boroughTotal];
    bandCPrice = new float[boroughTotal];
    bandDPrice = new float[boroughTotal];
    bandEPrice = new float[boroughTotal];
    bandFPrice = new float[boroughTotal];
    bandGPrice = new float[boroughTotal];
    bandHPrice = new float[boroughTotal];
  }

  void run() {
    //Data is put into Arrays
    for (int i = 0; i < boroughTotal; i++) {
      JSONObject borough = json.getJSONObject(boroughNameMatch[i]);

      //Number of household within each band
      bandA[i] = borough.getInt("Band A");
      bandB[i] = borough.getInt("Band B");
      bandC[i] = borough.getInt("Band C");
      bandD[i] = borough.getInt("Band D");
      bandE[i] = borough.getInt("Band E");
      bandF[i] = borough.getInt("Band F");
      bandG[i] = borough.getInt("Band G");
      bandH[i] = borough.getInt("Band H");

      //Price average of each band
      bandAPrice[i] = borough.getFloat("£ Band A");
      bandBPrice[i] = borough.getFloat("£ Band B");
      bandCPrice[i] = borough.getFloat("£ Band C");
      bandDPrice[i] = borough.getFloat("£ Band D");
      bandEPrice[i] = borough.getFloat("£ Band E");
      bandFPrice[i] = borough.getFloat("£ Band F");
      bandGPrice[i] = borough.getFloat("£ Band G");
      bandHPrice[i] = borough.getFloat("£ Band H");
    }
    println("************************************");
    println("Council Tax Data Collection Complete");
    println("************************************");

  }
}
