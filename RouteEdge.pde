HashMap<String, RouteEdge> routeEdges;

public class RouteEdge implements Feature {
  
  public BusStop stopA;
  public BusStop stopB;
  
  public float averageTime;
  public color col;
  public float wMulti;
  
  //Constructor
  public RouteEdge(BusStop stopA, BusStop stopB, float time) {
    this.stopA = stopA;
    this.stopB = stopB;
    this.averageTime = time;
    
    this.col = #ffffff;
    this.wMulti = 0f;
  }
  
  //Draw
  public void draw() {
    
    Vector2 from = stopA.coord;
    Vector2 to = stopB.coord;
    
    float lineWeight = min(routeEdgeBaseLineWidth, routeEdgeBaseLineWidth / cam.camScale) * wMulti;
    
    //Draw
    strokeWeight(lineWeight);
    stroke(col);
    fill(col);
    line(from.x, from.y, to.x, to.y);
  }
  
  public boolean offScreen() {
     return stopA.offScreen() && stopB.offScreen();
  }
}
