void Intro() {
ani.show();
 
  introButton.show();
 textSize(60);
 fill(white);
 text("JUMPER", 200, 200);
 text("MUMPER", 200, 260);
 
 if (introButton.clicked) {
  mode = LEVELONE; 
 }
 
  
}
