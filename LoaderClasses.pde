public interface JsonLoader {
  public JSONObject pop();
  public boolean isEmpty();
  public String[] getKeys(); //only really for dictonary but alas
}
public abstract class FeatureMaker {
  JsonLoader loader;
  public abstract void make();

  //Constant
  public Vector2 badCoordConvert(Vector2 badCoord) {
    return badCoord.add(coordOrigin).scale(coordinateSeperationScale);
  }
}

//
// LOADERS
//

public class JsonListLoader implements JsonLoader {

  int i = 0;
  int len = 2;

  JSONArray list;

  //
  public JsonListLoader(String fileName) {
    list = loadJSONArray(fileName);
    len = list.size();
  }

  //
  public JSONObject pop() {
    return list.getJSONObject(i++);
  }

  //
  public boolean isEmpty() {
    return i >= len;
  }

  public String[] getKeys() {
    String[] ret = {};
    return ret;
  }
}


public class JsonDictLoader implements JsonLoader {

  int i = 0;
  int len = 2;

  JSONObject json;
  String[] keys = {};

  //
  public JsonDictLoader(String fileName) {
    json = loadJSONObject(fileName);
    keys = (String[]) json.keys().toArray(new String[json.size()]);
    len = this.keys.length;
  }

  //
  public JSONObject pop() {
    String keyGetting = keys[i++];
    return json.getJSONObject(keyGetting);
  }

  //
  public boolean isEmpty() {
    return i >= len;
  }

  public String[] getKeys() {
    return keys;
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
