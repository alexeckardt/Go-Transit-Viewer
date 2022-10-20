//
// Input Functions
//

boolean mouseClick = false;
boolean mouseDragging = false;

void mousePressed()
{
  //Camera
  cam.dragStartPosition = cam.mouse_gui_to_real_coords();
  
  //Reset
  mouseDragging = false;
}

void mouseReleased() {
    if (!mouseDragging) {
      mouseClick = true; 
    }
}

void mouseDragged()
{
  mouseDragging = true;
  cam.move_by_drag();
}

void mouseWheel(MouseEvent event) {
  int wheelDir = event.getCount()*(-1);
  
  cam.update_scale(wheelDir);
}
