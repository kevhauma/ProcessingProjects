import java.util.*;
String[] lines;
long currentStep;
Config config;
float gridsizeX;
float gridsizeY;
ArrayList<Ride> rides;
ArrayList<Car> fleet;
PGraphics backG;
int currentstep = -1;

int interval = 150;



void setup() {
  size(1920, 1080);
  background(255);
  
  //read file
  lines = loadStrings("metro.in");
  //read configs
  String[] configl= lines[0].split(" ");  
  config = new Config();
  config.rows = Integer.parseInt(configl[0]);
  config.columns = Integer.parseInt(configl[1]);
  config.fleetsize = Integer.parseInt(configl[2]);
  config.rideCount = Integer.parseInt(configl[3]);
  config.bonus = Integer.parseInt(configl[4]);
  config.finalstep =Long.parseLong(configl[5]);
  
  gridsizeX =  (float)height/(float)config.columns;
  gridsizeY = (float)(width)/(float)config.rows;
  println(gridsizeX);
  println(gridsizeY);
  println(config.finalstep);
  
  //create ride and car list
  fleet = new ArrayList();
  rides = new ArrayList();
  //create rides
  for(int i = 1; i < lines.length;i++){
    String[] data = lines[i].split(" ");
    Ride rit = new Ride();
    rit.id = i-1;
    rit.start = new Point(Integer.parseInt(data[0]),Integer.parseInt(data[1]));
    rit.stop = new Point(Integer.parseInt(data[2]),Integer.parseInt(data[3]));
    rit.duration = stepsBetween(rit.start,rit.stop);
    rit.startStep = Integer.parseInt(data[4]);
    rit.deadline = Integer.parseInt(data[5]);
    rit.inProgress= false;
    rides.add(rit);
  }
  
  Collections.sort(rides);
  //create cars
  for (int i = 0; i< config.fleetsize;i++){
    Car car = new Car();
    car.id = i;
    fleet.add(car);
  }
  
  backG = createGraphics(width,height);
  
  
  
}

void draw(){
  background(255);
  translate(0,10);
  image(backG,0,0);
  for(int p = 0; p < interval; p++){
  currentStep++;
  ArrayList<Car> availablecars = getAvailableCars(); //get cars without currentride
  for(int carCount = 0; carCount < availablecars.size(); carCount++){ //loop over those cars
      Car car = availablecars.get(carCount); //rename the car on the index
      ArrayList<Ride> freeRides = getFreeRides(); //get rides that aren't busy    
      for (int rideCount = 0; rideCount < freeRides.size();rideCount++){
          Ride ride = freeRides.get(rideCount);
          ride.priority= config.rows + config.columns;
          int steps = stepsBetween(car.cLocation,ride.start);
          long arriveAtStart =  currentStep + steps;
          long waitTime = ride.startStep - arriveAtStart;
          if (waitTime < 0) waitTime = 0;
          ride.priority = waitTime + steps; 
          if (ride.deadline - ride.duration >= arriveAtStart){            
              if (car.cRide != null){
                  if (car.cRide.priority > ride.priority)
                      car.cRide = ride;
               }
               else
                  car.cRide = ride;            
          }
      }
      if(car.cRide != null)
      car.cRide.inProgress = true;       
  }  
  
  for(int carCount = 0; carCount < fleet.size(); carCount++){
      fleet.get(carCount).move();
  }
}
  fill(0);
  text(frameCount * interval,width*0.8, 50);
  
  for(int carCount = 0; carCount < fleet.size(); carCount++){       
      fleet.get(carCount).show();
      fleet.get(carCount).move();
  }   
  if(frameCount*interval > config.finalstep)
      noLoop();  
}

//calculates distance from one point to another
int stepsBetween(Point p1,Point p2){
  return abs(p1.x-p2.x) + abs(p1.y-p2.y);
}

ArrayList<Car> getAvailableCars(){
  ArrayList<Car> list = new ArrayList();
  for(Car c : fleet){
    if (c.cRide == null) list.add(c);
  }
  return list;
}
ArrayList<Car> getBusyCars(){
  ArrayList<Car> list = new ArrayList();
  for(Car c : fleet){
    if (c.cRide != null) list.add(c);
  }
  return list;
}
ArrayList<Ride> getFreeRides(){
  ArrayList<Ride> list = new ArrayList();
  for(Ride r : rides){
    if(!r.inProgress && currentStep < r.deadline){
      list.add(r);
    }
  }
  return list;
}

class Config{
    int rows;
    int columns;
    int fleetsize;
    int rideCount;
    int bonus;
    long finalstep;
}

class Point{
    int x;
    int y;
    Point(int _x, int _y){
        this.x = _x;
        this.y=_y;
    }
    boolean equals(Point p){
        return (this.x == p.x && this.y == p.y);
    }
}
class Ride implements Comparable<Ride>{
    int id;
    Point start;
    Point stop;
    long startStep;
    long deadline;
    boolean inProgress;
    int duration;
    long priority;
    int compareTo(Ride o1){
        return floor(this.startStep - o1.startStep);
    }
}
class Car{
     long id;
     Point prevLoc;
     Point cLocation;
     Ride cRide;
     Point target;
     boolean hasPassedStart;
     boolean waiting;
     Car(){
       prevLoc =new Point(0,0);
         cRide = null;
         cLocation = new Point(0,0);
     }
     void move(){
       if (this.cRide != null){
         //setTarget of car
         if(!this.hasPassedStart)
             this.target = cRide.start;
         if(this.cLocation.equals(cRide.start)){
             this.hasPassedStart = true;
             this.waiting= true;
             if (currentStep >= this.cRide.startStep){
                 this.target = this.cRide.stop;
                 this.waiting = false;
            }
         }
         if (this.cLocation.equals(this.cRide.stop)){
            this.cRide.inProgress = false;                   
            this.cRide = null;
            this.target = null;
         }        
     }
     //moving if target
     if (target != null){
         int differentX = target.x - this.cLocation.x;
         int differentY = target.y - this.cLocation.y;     
         if(differentX != 0){
             if(differentX >= 0)
                this.cLocation.x++;
             else
                this.cLocation.x--;
         }
         else if(differentY != 0){
             if(differentY >= 0)
                this.cLocation.y++;
             else
                 this.cLocation.y--;
         }
     }   
   } 
   void show(){
      rectMode(CENTER);
      
      backG.beginDraw();
      backG.strokeWeight(0);
      if(this.cRide==null && !this.waiting){
          fill(0);
      }
      else if(this.target != null && !this.waiting && !this.hasPassedStart){
          fill(255,255,0);
          backG.strokeWeight(0);
          backG.stroke(0);
      }
      else if(this.hasPassedStart && !this.waiting && this.target != null){
        fill(0,255,0);
          backG.strokeWeight(4);
          backG.stroke(0,255,0);
          backG.line(this.cLocation.x * gridsizeX,this.cLocation.y*gridsizeY, this.prevLoc.x*gridsizeX,this.prevLoc.y*gridsizeY);
      }
      else if (this.waiting){
          fill(255,0,0);
      }      
    
    
    backG.endDraw();
    rect(this.cLocation.x * gridsizeX,this.cLocation.y* gridsizeY,15,15);   
    this.prevLoc.x= this.cLocation.x;
    this.prevLoc.y= this.cLocation.y;
   }  
}