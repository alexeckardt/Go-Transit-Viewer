public class Camera {

  //Positional
  Vector2 pos = new Vector2();

  //Scales
  float camScale = 1;
  int scaleIndex;
  Vector2 viewPortSize = new Vector2();
  final Vector2 drawPos = new Vector2(5, 5);

  //Other Positions
  Vector2 dragStartPosition;

  //
  //
  public Camera() {

    //Center Camera Position at (0,0)
    pos = new Vector2();
    move(new Vector2(-139, 788));

    //Decide Scales
    scaleIndex = 2; //index of scale 1

    viewPortSize = get_viewport_dimentions();
  }

  //
  //METHODS
  //

  //
  //
  //
  //Move Method
  public void move(Vector2 newPosition) {
    println("Move:" + newPosition);
    pos = newPosition;
  }

  //
  public void center_at_pos(Vector2 center) {
    //Get Camera View Dimentions
    Vector2 viewport = this.get_viewport_dimentions();
    Vector2 offsetPos = center.subtract(viewport.scale(1/2));

    //Move Camera
    this.move(offsetPos);
  }

  //
  void move_by_drag() {
    Vector2 diff = new Vector2(mouseX, mouseY).scale(1/camScale);
    diff = diff.subtract(dragStartPosition);

    //
    pos = diff;
  }

  //
  //
  //
  //Get Camera's Visible Position (Right - Left coord = Camera Viewport Width);
  public Vector2 get_viewport_dimentions() {
    return baseCamDimentions.scale(1/camScale);
  }

  public void dragSetStartPosition() {
    dragStartPosition = mouse_gui_to_real_coords();
  }

  //
  //
  //
  //Update the Scale of the Camera
  public void update_scale(int scaleIndexIncreaseBy) {

    //Get Original Mouse Pos
    Vector2 scrollFromCoords = mouse_gui_to_real_coords();

    //Scale
    this.scaleIndex += scaleIndexIncreaseBy;
    this.scaleIndex = (int) clamp(scaleIndex, 0, cameraScales.length-1);

    //Set Goal
    camScale = cameraScales[scaleIndex];

    //Get Mouse Pos After Screen Zoomed from 0,0 screen pos
    Vector2 updatedMouseCoords = mouse_gui_to_real_coords();

    // Move To Make Scoll Happen from Mouse, Not 0,0 on screen
    Vector2 diff = updatedMouseCoords.subtract(scrollFromCoords);
    this.pos = pos.add(diff);

    //Update
    this.viewPortSize = baseCamDimentions.scale(1/this.camScale);
  }

  //
  //
  //
  //Convert Mouse GUI position to "Phyiscal" Coords
  Vector2 mouse_gui_to_real_coords() {
    return new Vector2(mouseX - pos.x*camScale, mouseY - pos.y*camScale).scale(1/camScale);
  }
  //
  //Convert Coords To GUI
  Vector2 coord_to_gui_coord(Vector2 in) {
    return in.add(pos).scale(camScale);
  }
  Vector2 gui_cord_to_coords(Vector2 in) {
    return in.subtract(pos).scale(1/camScale);
  }

  //
  public void drawStatsGUI() {

    //
    textAlign(LEFT, TOP);
    fill(#ffffff);
    textSize(fontSize);

    int line = 0;

    //
    Vector2 mpos = mouse_gui_to_real_coords();
    text(mpos.toString(), drawPos.x, drawPos.y + (line++)*fontSize);
    text(this.pos.toString(), drawPos.x, drawPos.y + (line++)*fontSize);
    text(this.camScale, drawPos.x, drawPos.y + (line++)*fontSize);
    text(this.viewPortSize.toString(), drawPos.x, drawPos.y + (line++)*fontSize);
  }
}
