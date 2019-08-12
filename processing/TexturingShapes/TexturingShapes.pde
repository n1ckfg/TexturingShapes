PImage img;
boolean isDrawing = false;
ArrayList<PShape> shapes;
PShape shp;
ArrayList<PVector> points;
PVector wh, iwh;
float spread = 100;

void setup() {
  size(800, 600, P2D);
  img = loadImage("tiger.jpg");
  shapes = new ArrayList<PShape>();
  
  wh = new PVector(width, height);
  iwh = new PVector(img.width, img.height);
} 

void draw() {
  background(0);
  if (isDrawing) {
    points.add(new PVector(mouseX, mouseY));
    
    shp.beginShape();
    shp.noStroke();
    shp.noFill();
    shp.texture(img);
    for (int i=0; i<points.size(); i++) {
      PVector point = points.get(i);
      PVector uv = getUvs(point);
      shp.vertex(point.x, point.y, uv.x, uv.y);
    }
    shp.endShape();
  }
  
  for (int i=0; i<shapes.size(); i++) {
    shape(shapes.get(i));
  }

  if (isDrawing) shape(shp);
  
  surface.setTitle("" + frameRate);
}

void mousePressed() {
  isDrawing = true;
  shp = createShape();
  points = new ArrayList<PVector>();
}

void mouseReleased() {
  isDrawing = false;
  shapes.add(shp);
}

PVector getUvs(PVector p) {
  float x = constrain(((p.x/wh.x) * iwh.x) + random(spread) - random(spread), 0, iwh.x);
  float y = constrain(((p.y/wh.y) * iwh.y) + random(spread) - random(spread), 0, iwh.y);
  println(x + " " + y);
  return new PVector(x, y);
}
