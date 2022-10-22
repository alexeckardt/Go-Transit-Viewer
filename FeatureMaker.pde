//
// Base Abstract Class
//
public abstract class FeatureMaker {
  JsonLoader loader;
  public abstract void make();

  //Constant
  public Vector2 badCoordConvert(Vector2 badCoord) {
    return badCoord.add(coordOrigin).scale(coordinateSeperationScale);
  }
}

//
// FEATURE MAKERS
//

public class CityMaker extends FeatureMaker {

  //
  public CityMaker(String fileName) {
    this.loader = new JsonListLoader(fileName);
  }
  //
  public void make() {

    //Construct The Data Structure
    cityList = new ArrayList<>();

    while (!this.loader.isEmpty()) {

      //Load
      JSONObject cityJson = this.loader.pop().obj;

      //Get
      String name = cityJson.getString("name");
      int population = cityJson.getInt("population");
      boolean istown = cityJson.getString("place").equals("town");

      //Decide Coordinate
      Vector2 coord = new Vector2(cityJson.getJSONArray("coods"));
      coord = badCoordConvert(coord);

      //Store Infomation
      City newcity = new City(name, coord);
      newcity.setPopulation(population, istown);

      println(newcity.toString());
      cam.center_at_pos(coord);

      //Store In Struct
      cityList.add(newcity);
    }
  }
}

public class BusStopMaker extends FeatureMaker {

  //
  public BusStopMaker(String fileName) {
    this.loader = new JsonDictLoader(fileName);
  }
  //
  public void make() {

    //keys
    String[] keys = this.loader.getKeys();
    
    //Construct The Data Structure
    busstops = new HashMap<String, BusStop>();
    stopShortcutNames = keys;
    
    //Load In Stops
    while (!this.loader.isEmpty()) {

      //Load
      PassBackFromLoad fromLoad = this.loader.pop();
      JSONObject busstopJson = fromLoad.obj;
      int i = fromLoad.i;
      
      //Unpack
      String name = busstopJson.getString("name");
      //Decide Coords
      Vector2 coord = new Vector2(busstopJson.getJSONArray("coords"));
      coord = badCoordConvert(coord);

      //Create
      BusStop newstop = new BusStop(name, coord);

      //Get Key
      String stopkey = keys[i];
      newstop.busStopId = stopkey;
      
      //Put
      busstops.put(stopkey, newstop);
    }
  }
}

public class RouteEdgeMaker extends FeatureMaker {

  //
  public RouteEdgeMaker(String fileName) {
    this.loader = new JsonDictLoader(fileName);
  }
  
  //
  public void make() {
    
    //Create HashMap
    routeEdges = new HashMap<>();
    
    //Get All Keys
    String[] keys = this.loader.getKeys();
    
    //Load In Edges
    while (!this.loader.isEmpty()) {
      
      //Load
      PassBackFromLoad fromLoad = this.loader.pop();
      JSONObject json = fromLoad.obj;
      int i = fromLoad.i;
      
      //Get Route Edge Name
      String routeEdgeName = keys[i];
      
      //Create And Set Object
      String Node1id = json.getString("node1");
      String Node2id = json.getString("node2");
      float timeMinutes = json.getFloat("time_minutes");
      
      //Get Stops
      BusStop stopA = busstops.get(Node1id);
      BusStop stopB = busstops.get(Node1id);
      
      //Create Route
      RouteEdge routeEdge = new RouteEdge(stopA, stopB, timeMinutes);

      //Store
      routeEdges.put(routeEdgeName, routeEdge);
      
    }
    
  }
}
