HashMap<String, RouteEdge> routeEdges;

public class RouteEdge {
  
  public BusStop stopA;
  public BusStop stopB;
  
  public float averageTime;
  
  //Constructor
  public RouteEdge(BusStop stopA, BusStop stopB, float time) {
    this.stopA = stopA;
    this.stopB = stopB;
    this.averageTime = time;
  }
  
  //Draw
  public void draw(color col, float wMulti) {
    
    Vector2 from = stopA.coord;
    Vector2 to = stopB.coord;
    
    float lineWeight = min(routeEdgeBaseLineWidth, routeEdgeBaseLineWidth / cam.camScale) * wMulti;
    
    //Draw
    strokeWeight(lineWeight);
    stroke(col);
    fill(col);
    line(from.x, from.y, to.x, to.y);
  }
}
