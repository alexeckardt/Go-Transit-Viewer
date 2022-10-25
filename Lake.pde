ArrayList<Lake> lakes;

public class Lake implements Feature {

  //
  public final PShape myshape;
  Vector2 topLeft;
  Vector2 bottomRight;


  //
  public Lake(JSONArray coordPoints) {

    //
    // Set mins and Maxs
    //
    
    JSONArray coordTuple = coordPoints.getJSONArray(0);
    //Decide Coordinate
    Vector2 initcoord = new Vector2(coordTuple);
    topLeft = new Vector2(initcoord);
    bottomRight = new Vector2(initcoord);

    //
    myshape = createShape();
    myshape.beginShape();

    //Loop Through
    for (int j = 0; j < coordPoints.size(); j++) {
      coordTuple = coordPoints.getJSONArray(j);

      //Decide Coordinate
      Vector2 coord = new Vector2(coordTuple);
      coord = coord.add(coordOrigin).scale(coordinateSeperationScale);

      //Set Bounding Box
      if (coord.x < topLeft.x) {
         topLeft = new Vector2(coord.x, topLeft.y); 
      }
      if (coord.y < topLeft.y) {
         topLeft = new Vector2(topLeft.x, coord.y); 
      }
      if (coord.x > bottomRight.x) {
         bottomRight = new Vector2(coord.x, bottomRight.y); 
      }
      if (coord.y > bottomRight.x) {
         bottomRight = new Vector2(bottomRight.x, coord.y); 
      }

      //Add to Shape
      myshape.vertex(coord.x, coord.y);
    }

    //End
    myshape.endShape(CLOSE);

    myshape.setStroke(lakecol);
    myshape.setFill(lakecol);
  }

  public void draw() {
    if (!offScreen()) {
      shape(myshape);
    }
  }

  public boolean offScreen() {
    
    Vector2 cp = cam.pos.scale(-1);

    boolean xoutside = (bottomRight.x < cp.x) || (topLeft.x >= cp.x+cam.viewPortSize.x);
    boolean youtside = (bottomRight.y < cp.y) || (topLeft.y >= cp.y+cam.viewPortSize.y);

    return xoutside || youtside;
    
  }
}

void drawLakes() {
  for (Lake lake : lakes) {
    lake.draw();
  }
}
