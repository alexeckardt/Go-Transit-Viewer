
public void loadFeatures() {
 
  //Load Cities
   FeatureMaker[] makers = {
                               new CityMaker("final_cities.json"),
                               new BusStopMaker("stations.json"),
                               new RouteEdgeMaker("route_edges.json"),
                               new RouteMaker("route_info.json"),
                           };
  
  //Loop Through Makers
  for (FeatureMaker maker : makers) {
     maker.make(); 
  }
  
  //Unneeded; Cleanup
  makers = null;
  
}
