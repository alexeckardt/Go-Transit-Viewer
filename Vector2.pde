public class Vector2 {
 
  //Attributes
  public float x;
  public float y;
  
  //Constructor
  public Vector2(float x, float y) {
    this.x = x;
    this.y = y;
  }
  public Vector2(Vector2 x) {
    this.x = x.x;
    this.y = x.y;
  }
  public Vector2() {
    this.x = 0;
    this.y = 0;
  }
  public Vector2(JSONArray arr) {
    this.x = arr.getFloat(0);
    this.y = arr.getFloat(1);
  }
  
  //
  //Methods
  //
  
  //Add
  Vector2 add(Vector2 vec) {
     float xx = x + vec.x;
     float yy = y + vec.y;
     
     return new Vector2(xx, yy);
  }
  
  //Subtract
  Vector2 subtract(Vector2 vec) {
     return add(vec.scale(-1)); 
  }
  
  //Scale
  Vector2 scale(float s) {
      float xx = x*s;
      float yy = y*s;
      
      return new Vector2(xx, yy);
  }  
  
  //Scale (Vector)
  Vector2 scale(Vector2 s) {
      float xx = x*s.x;
      float yy = y*s.y;
      
      return new Vector2(xx, yy);
  }  
  
  //Magnitude
  float magnitude() {
    return (float) Math.sqrt(x*x + y*y);
  }
  
  //
  //Print
  //
  
  public String toString() {
     return "(" + x + ", " + y + ")";
  }
  
  public void print() {
     println(this); 
  }
}
