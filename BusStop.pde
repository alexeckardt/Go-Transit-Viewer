//Store
HashMap<String, BusStop> busstops;
String[] stopShortcutNames;
String hoveringBusStopId;
BusStop selectedBusStop;

//Setup Class
class BusStop implements Feature {

  String name;
  String busStopId;
  Vector2 coord;

  int drawWidth;

  //
  boolean drawName = false;
  boolean onAHighlightedEdge = false;

  ArrayList<Route> routesThatStopHere;

  //Constructor
  BusStop(String inName, Vector2 inCoords) {
    name = inName;
    coord = inCoords;
    busStopId = "None";
    drawWidth = 5;
    
    routesThatStopHere = new ArrayList<>();
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

    if (cam.camScale >= 5) {
      float sc = clamp(cam.camScale, 0.5, 1.5);
      drawWidth = int (busStopWidth * sc);
    } else {
        drawWidth = (int) (3*min(1, cam.camScale));
    };
  }

  //
  //Draw the Box (GUI)
  void draw() {

    if (!offScreen()) {
      boolean glow = (onAHighlightedEdge || hoveringBusStopId == this.busStopId || selectedBusStop == this);
  
      color c = (glow) ? cBusStop : cOffFocusBusStop;
      float size = (glow) ? drawWidth : drawWidth*0.75;
  
      //
      Vector2 guiCoord = cam.coord_to_gui_coord(coord);
  
      fill(c);
      noStroke();
      rect(guiCoord.x - size / 2, guiCoord.y - size / 2, size, size);
    }
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
  
  public void addRoute(Searcher search, Route route) {   
    if (!search.linear_search(routesThatStopHere, route)) {
      routesThatStopHere.add(route);
    }
  }
  
  public boolean offScreen() {
   
      Vector2 cp = cam.pos.scale(-1);

      boolean xoutside = (coord.x + drawWidth < cp.x) || (coord.x - drawWidth >= cp.x+cam.viewPortSize.x);
      boolean youtside = (coord.y + drawWidth < cp.y) || (coord.y - drawWidth >= cp.y+cam.viewPortSize.y);

      return xoutside || youtside;
    
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
    busstop.draw();
  }

  //Draw Name
  if (hoveringBusStopId != "None" || selectedBusStop != null) {
  
    //Get Stop
    BusStop stop = busstops.get(hoveringBusStopId);
    if (stop == null) {
       stop = selectedBusStop; 
    }
    
    //Draw Name
    stop.drawName();
    
    //Create Info Box
    drawingInfoBox = new RouteListInfoBox(stop.name, stop.routesThatStopHere, cBusStop, cBusStop);
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
  
  if (mouseClick) {
     if (hoveringBusStopId != "None") {
         selectedBusStop = get_hoveringBusStop();
     } else {
         selectedBusStop = null;
     }
  }
}

BusStop get_hoveringBusStop() {
  if (hoveringBusStopId == "None") {
     return null; 
  }
  return busstops.get(hoveringBusStopId);
}

//
//
//
