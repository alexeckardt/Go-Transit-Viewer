public ArrayList<Route> busRoutes;
public ArrayList<Route> trainRoutes;

public class Route {
  public String id; //The Id, custom and not really used
  public String name; //The Official Name ("Lakeshore West")
  public String shortname; //Abbreiv  ("LW")
  public int col;  //Color to draw the lines as
  public RouteType type; //Train or Bus?

  public float RouteWidthDrawMulti;

  public ArrayList<RouteEdge> edges; //All Edges

  public Route(String id, String name, String shortname, int col, RouteType type) {
    this.id = id;
    this.name = name;
    this.col = col;
    this.type = type;
    this.shortname = shortname;

    //Create List
    this.edges = new ArrayList<>();

    //
    if (this.type == RouteType.TRAIN) {
      this.RouteWidthDrawMulti = trainRouteWidthMulti;
    } else {
      this.RouteWidthDrawMulti = 1;
    }
  }

  //Add
  public void addEdge(RouteEdge edge) {
    this.edges.add(edge);
  }

  public void draw() {
    //Continue
    for (RouteEdge edge : edges) {
      edge.draw(this.col, this.RouteWidthDrawMulti);
    }
  }
  
  public String toString() {
    return shortname + " : " + name;
  }
}

//Draw
public void drawRoutes() {
  //Draw Bus Routes
  for (Route route : busRoutes) {
    route.draw();
  }

  //Draw Train Routes OVER Bus Routes
  for (Route route : trainRoutes) {
    route.draw();
  }
}
