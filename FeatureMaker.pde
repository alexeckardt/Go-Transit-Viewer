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
      JSONObject cityJson = this.loader.pop();

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
    int i = 0;
    String[] keys = this.loader.getKeys();
    
    //Construct The Data Structure
    busstops = new HashMap<String, BusStop>();
    stopShortcutNames = keys;
    
    //Load In Stops
    while (!this.loader.isEmpty()) {

      //Load
      JSONObject busstopJson = this.loader.pop();

      //Unpack
      String name = busstopJson.getString("name");
      //Decide Coords
      Vector2 coord = new Vector2(busstopJson.getJSONArray("coords"));
      coord = badCoordConvert(coord);

      //Create
      BusStop newstop = new BusStop(name, coord);

      //Get Key
      String stopkey = keys[i++];
      newstop.busStopId = stopkey;
      
      //Put
      busstops.put(stopkey, newstop);
    }
  }
}
