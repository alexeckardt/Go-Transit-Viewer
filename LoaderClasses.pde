public interface JsonLoader {
  public PassBackFromLoad pop();
  public boolean isEmpty();
  public String[] getKeys(); //only really for dictonary but alas
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
  public PassBackFromLoad pop() {
    JSONObject obj = list.getJSONObject(i++);
    return new PassBackFromLoad(obj, i-1);
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
  public PassBackFromLoad pop() {
    String keyGetting = keys[i++];
    JSONObject obj = json.getJSONObject(keyGetting);
    return new PassBackFromLoad(obj, i-1);
  }

  //
  public boolean isEmpty() {
    return i >= len;
  }

  public String[] getKeys() {
    return keys;
  }
}

public class PassBackFromLoad {
 
  public JSONObject obj;
  public int i;
  
  //Constructor
  public PassBackFromLoad(JSONObject obj, int i) {
      this.obj = obj;
      this.i = i;
  }
}
