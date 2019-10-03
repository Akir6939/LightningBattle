public void setup(){
  background(0);
  size(500,500);
  strokeWeight(10);
  frameRate(30);
}

int clicks = 0;
int deaths = 0;

public class Bolt{
  int startx,starty,endx,endy;
  boolean offscreen = false;
  public Bolt(){
    startx=endx=0;
    starty=endy=250;
  }
  public void checkForOffscreen(){
    offscreen = (startx>500||starty>500||starty<0);
  }
  public void step(){
    if(!offscreen){
      while(startx<500){
      stroke((int)(Math.random()*256),(int)(Math.random()*256),(int)(Math.random()*256));
      endx = startx+(int)(Math.random()*10);
      endy = starty+(int)(Math.random()*19)-9;
      line(startx,starty,endx,endy);
      startx = endx;
      starty = endy;
      }
    }
  }
  public void hide(){
    startx=endx=starty=endy=1000;
  }
}

public class Baddie{
  int life,size;
  color col1,col2;
  public Baddie(int x,int y){
    life = x;
    size = y;
    col1 = color(210,180,140);
    col2 = color(255,255,255);
  }
  public boolean checkIfDead(int x){
    return x>=life;
  }
  public void show(){
    strokeWeight(5);
    stroke(col2);
    fill(col1);
    circle(400,250,size);
    col1 = color(210,180,140);
    col2 = color(255,255,255);
  }
  public void takeDamage(){
    col1 = color(255,0,0);
    col2 = color(255,0,0);
  }
  public void levelUp(){
    size+=20;
    life+=20;
  }
  public int getLife(){
    return life;
  }
}
  
ArrayList<Bolt> boltArray= new ArrayList<Bolt>();
Baddie enemy = new Baddie(10,200);

void mousePressed(){
  enemy.takeDamage();
  clicks++;
  Bolt b = new Bolt();
  boltArray.add(b);
}

void die(){
  background(0);
  boltArray.clear();
  deaths++;
  clicks = 0;
  enemy.levelUp();
}

void winner(){
  if(deaths>=10){
    background(0);
    textSize(18);
    fill(255,255,0);
    text("You win!",100,250);
    noLoop();
  }
}
void displayScore(){
  fill(255);
  textSize(16);
  text("Clicks left: "+(enemy.getLife()-clicks),10,15);
  text("Bosses left: "+(10-deaths),10,45);
}

void draw(){
  winner();
  fill(0);
  stroke(0);
  rect(0,0,300,60);
  for(Bolt b : boltArray){
    b.checkForOffscreen();
    b.step();
  }
  displayScore();
  if(enemy.checkIfDead(clicks))
  die();
  enemy.show();
}