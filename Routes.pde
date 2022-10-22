public ArrayList<Route> routes;

public class Route {
    public String id; //The Id, custom and not really used
    public String name; //The Official Name ("Lakeshore West")
    public String shortname; //Abbreiv  ("LW")
    public int col;  //Color to draw the lines as
    public RouteType type; //Train or Bus?
    
    public ArrayList<RouteEdge> edges; //All Edges
    
    public Route(String id, String name, String shortname, int col, RouteType type) {
        this.id = id;
        this.name = name;
        this.col = col;
        this.type = type;
        this.shortname = shortname;
        
        //Create List
        this.edges = new ArrayList<>();
    }
    
    //Add
    public void addEdge(RouteEdge edge) {
        this.edges.add(edge);
    }
}
