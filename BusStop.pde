//Store
HashMap<String, BusStop> busstops;
String[] stopShortcutNames;
String hoveringBusStopId;

//Setup Class
class BusStop {

  String name;
  String busStopId;
  Vector2 coord;

  int drawWidth;

  //
  boolean drawName = false;
  boolean onAHighlightedEdge = false;

  //Constructor
  BusStop(String inName, Vector2 inCoords) {
    name = inName;
    coord = inCoords;
    busStopId = "None";
    drawWidth = 5;
  }

  //
  //Step
  void step() {

    //Stop Drawing Names
    this.drawName = false;

    //Check If Hovering
    boolean hovering = mouseInside();
    if (hovering) {
      hoveringBusStopId = this.busStopId;
    }

    float sc = clamp(cam.camScale, 0.5, 1.5);
    drawWidth = int (busStopWidth * sc);
    println(drawWidth);
  }

  //
  //Draw the Box (GUI)
  void drawBusstop() {

    boolean glow = (onAHighlightedEdge || hoveringBusStopId == this.busStopId);

    color c = (glow) ? cBusStop : cOffFocusBusStop;
    float size = (glow) ? drawWidth : drawWidth*0.75;

    //
    Vector2 guiCoord = cam.coord_to_gui_coord(coord);

    fill(c);
    noStroke();
    rect(guiCoord.x - size / 2, guiCoord.y - size / 2, size, size);
  }

  //
  // Draw the Name (GUI)
  void drawName() {

    Vector2 guicoord = cam.coord_to_gui_coord(coord);
    float visibleSize = drawWidth;

    textAlign(CENTER, BOTTOM);
    fill(cBusStop);
    textSize(fontSize);
    text(name, guicoord.x + visibleSize / 2, guicoord.y - 2);
  }

  //
  //
  public boolean mouseInside() {
    //
    Vector2 guiCoord = cam.coord_to_gui_coord(coord);
    Vector2 mouseCoords = new Vector2(mouseX, mouseY);

    float w = drawWidth/2;
    boolean xin = guiCoord.x-w < mouseCoords.x && mouseCoords.x < guiCoord.x+w;
    boolean yin = guiCoord.y-w < mouseCoords.y && mouseCoords.y < guiCoord.y+w;

    return xin && yin;
  }

  public String toString() {
    return this.name;
  }
}

//
//
//
void drawBusStops() {
  //Draw
  for (String busstopId : stopShortcutNames) {
    //
    BusStop busstop = busstops.get(busstopId);
    busstop.drawBusstop();
  }

  //Draw Name
  if (hoveringBusStopId != "None") {
    BusStop stop = busstops.get(hoveringBusStopId);
    stop.drawName();
  }
}

void stepBusStops() {
  //Draw
  hoveringBusStopId = "None";

  for (String busstopId : stopShortcutNames) {
    //
    BusStop busstop = busstops.get(busstopId);
    busstop.step();
  }
}

BusStop get_hoveringBusStop() {
  return busstops.get(hoveringBusStopId);
}

//
//
//
