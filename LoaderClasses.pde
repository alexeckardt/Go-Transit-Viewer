public interface JsonLoader {
  public JSONObject pop();
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
