
public void loadFeatures() {
 
  //Load Cities
   FeatureMaker[] makers = {
                               new CityMaker("final_cities.json"),
                               new BusStopMaker("stations.json"),
                           };
  
  //Loop Through Makers
  for (FeatureMaker maker : makers) {
     maker.make(); 
  }
  
}
