public final float titleFontSizeScale = 2;
public final float infoBoxSpacing = 1.5;
public final float baseBoxWidth = 200;
public final float boxEdgeBuffer = 20;

public InfoBox drawingInfoBox = null;

public interface InfoBox {
  public float getHeight();
  public float getWidth();
  public void draw();
}

public class RouteListInfoBox implements InfoBox {
  String title;
  ArrayList<Route> body;
  color title_col;
  color body_col;

  float boxWidth;

  //Generic
  public RouteListInfoBox(String title, ArrayList<Route> body, color title_col, color body_col) {
    this.title = title;
    this.title_col = title_col;
    this.body_col = body_col;
    this.body = body;

    boxWidth = getWidth();
  }

  //
  public float getHeight() {
    return fontSize*infoBoxSpacing*(titleFontSizeScale + body.size());
  }

  public float getWidth() {
    //Base
    float maxW = baseBoxWidth;

    //Check Title W
    textSize(fontSize*titleFontSizeScale);
    maxW = max(maxW, textWidth(title));

    //Check Body
    textSize(fontSize);
    for (Route route : body) {
      maxW = max(maxW, textWidth(route.toString()));
    }

    return maxW;
  }

  //
  public void draw() {

    //"Contants"
    color white = #ffffff;
    float drawy = boxEdgeBuffer;
    //Align Text
    textAlign(LEFT, TOP);


    //Draw Background
    fill(cInfoboxColour);
    noStroke();
    rect(0, 0, boxWidth + boxEdgeBuffer*2, getHeight() + boxEdgeBuffer*2);

    //Draw Title
    fill(title_col);
    textSize(fontSize*titleFontSizeScale);
    text(title, boxEdgeBuffer, drawy);
    drawy += fontSize*titleFontSizeScale*infoBoxSpacing;

    //Draw Lines
    textSize(fontSize);
    for (Route route : body) {
      color c = lerpColor(route.col, white, 0.25);
      fill(c);
      text(route.toString(), boxEdgeBuffer, drawy);
      drawy += fontSize*infoBoxSpacing;
    }
  }
}
//
//
public class CityInfoBox implements InfoBox {
  String title;
  ArrayList<String> body;
  color title_col;
  color body_col;

  float boxWidth;

  //Generic
  public CityInfoBox(City targetCity) {
    this.title = targetCity.name;
    this.title_col = cityHighlightedTextCol;
    this.body_col = cityTextCol;
    this.body = constructBody(targetCity);

    boxWidth = getWidth();
  }

  public ArrayList<String> constructBody(City targetCity) {
    ArrayList<String> arr = new ArrayList<>();
    
    //
    String p = Integer.toString(targetCity.population);
    if (p.equals("10000")) {
        p = "Around 10,000";
    }
    
    //Add
    arr.add("Coordinates: " + new Vector2(targetCity.geoCoords.y,  targetCity.geoCoords.x));
    arr.add("CoordinatesInternal: " + targetCity.coord);
    arr.add("Population: " + p);
    
    //Return
    return arr;
  }

  //
  public float getHeight() {
    return fontSize*infoBoxSpacing*(titleFontSizeScale + body.size());
  }

  public float getWidth() {
    //Base
    float maxW = baseBoxWidth;

    //Check Title W
    textSize(fontSize*titleFontSizeScale);
    maxW = max(maxW, textWidth(title));

    //Check Body
    textSize(fontSize);
    for (String line : body) {
      maxW = max(maxW, textWidth(line));
    }

    return maxW;
  }

  //
  public void draw() {

    //"Contants"
    float drawy = boxEdgeBuffer;
    //Align Text
    textAlign(LEFT, TOP);


    //Draw Background
    fill(cInfoboxColour);
    noStroke();
    rect(0, 0, boxWidth + boxEdgeBuffer*2, getHeight() + boxEdgeBuffer*2);

    //Draw Title
    fill(title_col);
    textSize(fontSize*titleFontSizeScale);
    text(title, boxEdgeBuffer, drawy);
    drawy += fontSize*titleFontSizeScale*infoBoxSpacing;

    //Draw Lines
    textSize(fontSize);
    fill(body_col);
    for (String line : body) {
      text(line, boxEdgeBuffer, drawy);
      drawy += fontSize*infoBoxSpacing;
    }
  }
}



//
//
void drawInfoBox() {
  //
  if (drawingInfoBox != null) {
    drawingInfoBox.draw();
  }
  drawingInfoBox = null;
}
