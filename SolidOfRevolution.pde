import gifAnimation.*;

PShape obj ;
boolean drawing, figureCreate;
int x, y, x0, y0, firstPress;
ArrayList<Coordinates> points;
String helpText;
GifMaker fileGIF;

void setup() { 
  size (800 ,800 ,P3D);
  drawing=true;
  figureCreate=false;
  firstPress = 1;
  points = new ArrayList();
  helpText = "Press space to redraw.";
  textSize(17);
  background(0);
  
  //fileGIF= new GifMaker(this,"animation.gif");
  //fileGIF.setRepeat(0);
}
 
void draw() {
  
  if(drawing){
    help();
    stroke(255);
    line(400, 0, 400, 800);
    stroke (0, 225, 0);
    
    if(mousePressed){
      if (mouseX<400){
        drawing=false;
        y0=mouseY;
        points.add(new Coordinates(0, y0));
      }
      else if (firstPress == 1) {
        firstPress = 0;
        x0=mouseX;
        y0=mouseY;
        point(x0, y0);
        points.add(new Coordinates(x0-400, y0));
      }
      else {   
        x=mouseX;
        y=mouseY;
        point(x, y);
        line(x0, y0, x, y);
        x0=x;
        y0=y;
        points.add(new Coordinates(x0-400, y0));
      }
    }
  } else if(!figureCreate){
    
    figureCreate=true;
    
    obj=createShape();
    obj.beginShape(TRIANGLE_STRIP);
    obj.fill(100) ;
    obj.stroke (0,225,0) ;
    obj.strokeWeight (1) ;
    
    Coordinates b, a=points.get(0);
    
    for(int i=1; i<points.size();i++){
      b=points.get(i);
      drawRotatedVortices(a.x, a.y, b.x, b.y, 100);
      a = b;
    }  
    obj.endShape();
    
  } else {
    background(0);
    help();
    translate (mouseX, mouseY-100);
    shape(obj);
  }
  //fileGIF.addFrame();
}

void keyPressed(){
  if (key == ' ')
  {
    points.clear();
    drawing=true;
    figureCreate=false;
    firstPress = 1;
    background(0);
  } else if(keyCode==ENTER){
    //fileGIF.finish();
  }
}

void drawRotatedVortices(int x_V1, int y_V1, int x_V2, int y_V2, int angle){
  
   int a_X=x_V1, a_Z=0;
   int b_X=x_V2, b_Z=0;
   int z=0;
    
   for(int i=0;i<1201;i=i+angle){
      
    obj.vertex(a_X, y_V1, a_Z);
  
    a_X=(int)(x_V1*Math.cos(i)-z*Math.sin(i));
    a_Z=(int)(x_V1*Math.sin(i)+z*Math.cos(i));
    
    obj.vertex(a_X ,y_V1 ,a_Z);
    obj.vertex(b_X, y_V2, b_Z);
    
    b_X=(int)(x_V2*Math.cos(i)-z*Math.sin(i));
    b_Z=(int)(x_V2*Math.sin(i)+z*Math.cos(i));
    
    obj.vertex(b_X ,y_V2 ,b_Z);
  }
}

void help(){
  fill(255, 255, 255);
  rect(10, 10, 150, 60);
  fill(50); 
  text(helpText, 15, 15, 150, 50);
}

class Coordinates{
  int x;
  int y;
  
  public Coordinates(int x, int y){
    this.x=x;
    this.y=y;
  }
}
