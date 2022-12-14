public City hoveringCity = null;
public City selectedCity = null;
public ArrayList<City> cityList;

public boolean drawCityNames = true;
public boolean toggledDrawCityNames = false;

public class City implements Feature {
  //
  public String name;
  public Vector2 coord = new Vector2();
  public int population;
  public float radius = 5;
  public boolean isATown;
  public Vector2 geoCoords;

  public ArrayList<RouteEdge> edgesIPartIn;

  //Construct
  public City(String name, Vector2 coord) {
    this.name = name;
    this.coord = coord;
    this.population = 0;
    this.radius = 5;
    this.isATown = false;

    //
    this.edgesIPartIn = new ArrayList<>();
  }

  public void setPopulation(int pop, boolean atown) {
    this.population = pop;
    this.isATown = atown;

    float base = (atown) ? baseTownRadius : baseCityRadius;

    //Decide Radius
    float p = (float) Math.pow(population, 0.95);
    float w = p / populationScale / 2;
    this.radius = base + w;
  }

  //
  //
  public void draw() {

    boolean off = this.offScreen();

    if (!off) {
      boolean selected = ((hoveringCity == this) || (selectedCity == this));
      color c = (selected) ? cityHighlightedCol : cityradCol;  
      noStroke();
      fill(c);
      ellipse(coord.x, coord.y, radius, radius);
    }
  }

  //GUI
  public void drawName() {

    boolean selected = ((hoveringCity == this) || (selectedCity == this));
    float showValue = ((float) population / 3000.0);
    boolean shouldShow = showValue > 50/(cam.camScale*cam.camScale);

    if (selected || shouldShow) {

      //
      Vector2 guic = cam.coord_to_gui_coord(coord);
      color textc = (selected) ? cityHighlightedTextCol : cityTextCol;

      textAlign(CENTER, CENTER);
      fill(textc);
      textSize(fontSize);
      text(name, guic.x, guic.y);
    }
  }

  public float coordsDistance(Vector2 testcoords) {
    return this.coord.subtract(testcoords).magnitude();
  }

  public String toString() {
    return this.name + "(" + this.isATown + ") :" + this.coord;
  }

  public boolean offScreen() {

    Vector2 cp = cam.pos.scale(-1);

    boolean xoutside = (coord.x + radius < cp.x) || (coord.x - radius >= cp.x+cam.viewPortSize.x);
    boolean youtside = (coord.y + radius < cp.y) || (coord.y - radius >= cp.y+cam.viewPortSize.y);

    return xoutside || youtside;
  }
}

//
// Events
//

//
// Hover & Select
public void stepCities() {

  //Mouse Coords
  Vector2 mouseCoords = cam.mouse_gui_to_real_coords();

  //Decide
  hoveringCity = null;
  float hoveringCityCoordsDistance = 1000;

  //Loop Over
  for (int i = 0; i < cityList.size(); i++) {
    //Get
    City city = cityList.get(i);

    //Get the City Who's Center the Mouse is Nearest To.
    float dist = city.coordsDistance(mouseCoords);

    //Set
    if (dist < city.radius/2 && dist < hoveringCityCoordsDistance) {
      hoveringCity = city;
      hoveringCityCoordsDistance = dist;
    }
  }

  //Click
  if (mouseClick) {
    if (selectedBusStop == null) {
      selectedCity = hoveringCity;
    }
  }

  //
  //Info Box
  //

  //Selected City
  if (selectedCity != null) {
    drawingInfoBox = new CityInfoBox(selectedCity);
  }
  if (hoveringCity != null) {
    drawingInfoBox = new CityInfoBox(hoveringCity);
  }
}

//
// Draw
public void drawCities() {
  for (int i = 0; i < cityList.size(); i++) {
    //Get
    City city = cityList.get(i);
    city.draw();
  }

  //Draw Over All other Cities
  if (selectedCity != null) {
    selectedCity.draw();
  }

  //Draw Over All other Cities
  if (hoveringCity != null) {
    hoveringCity.draw();
  }
}

public void drawCitiesName() {
  if (!drawCityNames) {
     return; 
  }
  
  for (int i = 0; i < cityList.size(); i++) {
    //Get
    City city = cityList.get(i);
    city.drawName();
  }
}
