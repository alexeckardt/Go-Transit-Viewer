
public void loadFeatures() {
 
  //Load Cities
   FeatureMaker[] makers = {
                               new CityMaker("final_cities.json"),
                               new BusStopMaker("stations.json"),
                               new RouteEdgeMaker("route_edges.json"),
                           };
  
  //Loop Through Makers
  for (FeatureMaker maker : makers) {
     maker.make(); 
  }
  
}
