//
//Constant Final Variables
final color bkgcol = #202125;
final float[] cameraScales = {0.25, 0.5, 1, 1.5, 2, 2.5, 3, 4, 5, 10, 20, 40, 80, 150, 250};
final color cInfoboxColour = #3a3b3e;

final color unhighlightedStateButtonCol = #3d4f3a;
final color highlightedStateButtonCol = #5c7c56;

final color cityradCol = #27282b;
final color cityTextCol = #6a7083;
final color cityHighlightedCol = #3a3c42;
final color cityHighlightedTextCol = #ffffff;

final color cBusStop = #2c6f38;
final color cOffFocusBusStop = #003217;

final int fontSize = 10;

final Vector2 coordOrigin = new Vector2(83, -42);
final Vector2 coordinateSeperationScale = new Vector2(3, -5).scale(60);

final float populationScale = 5000;
final float baseCityRadius = 15;
final float baseTownRadius = 10;

final float busStopWidth = 4;

final float routeEdgeBaseLineWidth = 2;

//
//
public static class Searcher<T> {  
  public boolean linear_search(ArrayList<T> in, T searching) {
    for (T item : in) {
       if (item == searching) {
          return true; 
       }
    }
    return false;
  } 
}



//
//Helper Functions
public float clamp(float x, float a, float b) {
   return min(max(x, a), b); 
}

color hexStrToCol(String colstr) {
  int c = Integer.parseInt(colstr, 16);
  return color(red(c), green(c), blue(c));
}

RouteType intToRouteType(int in) {
  switch (in) {
       default:
         return RouteType.NONE;
       case 1:
         return RouteType.BUS;
      case 2:
         return RouteType.TRAIN;
    }
}
