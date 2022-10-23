import java.util.Map;

Vector2 baseCamDimentions;
Camera cam;

//
//
//

void setup() {

  //fullScreen();
  size(960, 540);
  baseCamDimentions = new Vector2(width, height);

  cam = new Camera();

  loadFeatures();
}

void draw() {

  //Draw Background
  background(bkgcol);

  step();

  drawGame();
  drawGUI();
}

public void step() {
  mouseClick = false;

  stepCities();
  stepBusStops();
}

public void drawGame() {

  //matrix transform
  pushMatrix();
  scale(cam.camScale);
  translate(cam.pos.x, cam.pos.y);
  
  drawCities();
  drawLakes();
  drawRoutes();

  popMatrix();
}

public void drawGUI() {

  //
  cam.drawStatsGUI();

  drawBusStops();

  drawCitiesName();
  
  drawInfoBox();
}
