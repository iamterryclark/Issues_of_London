/* 
 Created by:
   Terry Clark - www.terrylewisclark.me
            
 Reference: 
 - London Air Quality Data API : http://www.londonair.org.uk/LondonAir/API/
 - Council Tax Data : Baiba Fogele, a Sustainble Cities Student @ Kings College London
 - JSON parsing from the web : http://blog.blprnt.com/blog/blprnt/processing-json-the-new-york-times
                             : https://github.com/runemadsen/HTTP-Requests-for-Processing/blob/master/examples/jsonget/jsonget.pde
 - Processing Reference for string manipulation and saving JSON Files.
 
 Description: Pollution API Program, 
              Run this once to collect all up to date daily monitoring information from the London Air Polution API and annual target information
              This is to be used with the Issues_of_London Sketch
              
 Issues: I wanted to try and display text to show the user that the data was loading however becuase the http request seem to freeze the program I was only able to display 
         progress this in the console. The numbers indicate the LocalAuthorityID within the API 1 = Barking and Dagenham etc.
 */

//This Library send out a http request to a URL and then returns a string to later parse through as a JSON object
import http.requests.*;

//Running a class to hold all funcationality of the API Request
PollutionAPIRequest pollutionAPIRequest;

void setup() {
  //Everything is running in setup so that it only makes all the calls to the API once
  pollutionAPIRequest = new PollutionAPIRequest();
  pollutionAPIRequest.run();
  
  //Instructions to the user that all processing is complete
  size(900, 400);
  background(0);
  textSize(40);
  textAlign(CENTER);
  text("Saved All JSON and XML Data", width/2, height/3 - 40);
  text("Data Collection Complete", width/2, 2 * height/3 - 60);
  text("Please run Issues_of_London program", width/2, 3 * height/3 - 80);
}

void draw() {

}

