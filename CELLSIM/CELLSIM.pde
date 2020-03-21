import java.util.Vector;

Vector<Cell> cells = new Vector<Cell>();
Vector<Food> foods = new Vector<Food>();

int pop = 80;
int foodN = 200;
int food_target = 200;
int loop = 0;
int foodPerMin = 220;
float foodPeriod = 60/foodPerMin;

boolean run = false;
boolean reset = true;

Button lanch_sim;
Button pause_sim;
Button stop_sim;


Radio food_mode;
Radio food_show;
Slider food_start;
Slider food_growth;


Slider cell_start;
Slider start_speed;
Slider start_size;
Slider start_cylcle;
Slider start_ratio;
Slider food_ratio;

PFont return_to_castle;

Graphic foodCurve;
Graphic cellCurve;

float loopTime;
float chrono = 0;

void setup(){
    foodCurve = new Graphic(" food population ",1600,225,600,450,color(80,90,80),color(0),0);
    foodCurve.set_font(createFont(dataPath("font/return_to_castle/return.ttf"),40),color(230),color(120));
    foodCurve.set_lines(true,true,0.1,0.1,color(240),2,color(240,0,0),3,1,1,"m","s");
    
    return_to_castle = createFont(dataPath("font/return_to_castle/return.ttf"),30);
    
    cellCurve = new Graphic(" cell population ",1600,775,600,450,color(80,90,80),color(0),0);
    cellCurve.set_font(createFont(dataPath("font/return_to_castle/return.ttf"),40),color(230),color(120));
    cellCurve.set_lines(true,true,0.1,0.1,color(240),2,color(240,0,0),3,1,1,"m","s");
  
  food_mode = new Radio("mode " , 22,140,20,color(90,90,90),color(80,80,80),1.5,"ROND");
  food_mode.set_cursor("CROIX",15,color(140,40,40));
  
  food_show = new Radio("show " , 222,1075,20,color(90,90,90),color(80,80,80),1.5,"ROND");
  food_show.set_cursor("CROIX",15,color(140,40,40));
  
  food_start = new Slider("nourriture de depart",10,185,180,40,140, color(230),2);
  food_start.set_text("nourriture de depart",color(230),16.0,createFont(dataPath("font/Spac3/Spac3.ttf"),30));
  food_start.set_cursor(1,5,20,color(100),color(200),3);
  food_start.set_grad(10,500,100,20,200);
  food_start.round_value = true;
  
  food_growth = new Slider("vitesse de croissance",10,255,180,40,140, color(230),2);
  food_growth.set_text("vitesse de croissance",color(230),16.0,createFont(dataPath("font/Spac3/Spac3.ttf"),30));
  food_growth.set_cursor(1,5,20,color(100),color(200),3);
  food_growth.set_grad(0,500,100,20,220);
  food_growth.round_value = true;
  
  
  
  
   cell_start = new Slider("nouriture de depart",10,185,180,40,140, color(230),2);
  cell_start.set_text("cellules de depart",color(230),16.0,createFont(dataPath("font/Spac3/Spac3.ttf"),30));
  cell_start.set_cursor(1,5,20,color(100),color(200),3);
  cell_start.set_grad(10,500,100,20,100);
  cell_start.round_value = true;
  
  start_speed = new Slider("vitesse de croissance",10,255,180,40,140, color(230),2);
  start_speed.set_text("vitesse de deplacement",color(230),14.0,createFont(dataPath("font/Spac3/Spac3.ttf"),30));
  start_speed.set_cursor(1,5,20,color(100),color(200),3);
  start_speed.set_grad(0,160,20,5,30);
  start_speed.round_value = true;
  
   start_size = new Slider("nouriture de depart",10,185,180,40,140, color(230),2);
  start_size.set_text("taille de depart",color(230),16.0,createFont(dataPath("font/Spac3/Spac3.ttf"),30));
  start_size.set_cursor(1,5,20,color(100),color(200),3);
  start_size.set_grad(10,100,20,5,30);
  start_size.round_value = true;
  
  start_cylcle = new Slider("vitesse de depart",10,255,180,40,140, color(230),2);
  start_cylcle.set_text("duree d'un cycle",color(230),16.0,createFont(dataPath("font/Spac3/Spac3.ttf"),30));
  start_cylcle.set_cursor(1,5,20,color(100),color(200),3);
  start_cylcle.set_grad(0,30,10,2,5);
  start_cylcle.round_value = true;
  
  start_ratio = new Slider("nouriture de depart",10,185,180,40,140, color(230),2);
  start_ratio.set_text("ressources de naissance",color(230),13.0,createFont(dataPath("font/Spac3/Spac3.ttf"),30));
  start_ratio.set_cursor(1,5,20,color(100),color(200),3);
  start_ratio.set_grad(0,1,0.1,0.025,0.3);
  //start_ratio.round_value = true;
  
  food_ratio = new Slider("demande en nourriture",10,255,180,40,140, color(230),2);
  food_ratio.set_text("besoin en nourriture",color(230),16.0,createFont(dataPath("font/Spac3/Spac3.ttf"),30));
  food_ratio.set_cursor(1,5,20,color(100),color(200),3);
  food_ratio.set_grad(0,0.005,0.001,0.00025,0.001);
  //food_ratio.round_value = true;
  
  
  
  lanch_sim = new Button("",12,15,50,50);
  lanch_sim.set_image(loadImage(dataPath("img/icon_play.png")));
  lanch_sim.click_effect = true;
  pause_sim = new Button("",76,15,50,50);
  pause_sim.set_image(loadImage(dataPath("img/icon_pause.png")));
  pause_sim.click_effect = true;
  stop_sim = new Button("",141,15,50,50);
  stop_sim.set_image(loadImage(dataPath("img/icon_stop.png")));
  stop_sim.click_effect = true;
  
  
  
   size(1900,1100); 
   
  
   
   textAlign(CENTER,CENTER);
   noStroke();
   ellipseMode(CENTER);
}

void draw(){
  
   
   noStroke();
   background(60); 
   fill(100,100,100);
   rect(200,0,1100,1100);
   if(run){
     float time = 1/frameRate;
     loopTime += time;
     chrono += time;
     if(!food_mode.activate){
       if(loopTime > foodPeriod){
         
         foods.add(new Food());
         foodN += 1;
         loopTime -= foodPeriod;
         
       }
     }else{
      
       while(foodN < food_target){
        
         foodN += 1;
         foods.add(new Food());
         
       }
       
     }
     
     
     for(int i = 0 ; i < foodN ; i++){
        foods.elementAt(i).update(); 
     }
     textSize(11);
     for(loop = 0 ; loop < pop ; loop++){
        cells.elementAt(loop).update(time); 
     }
     
     
     
     fill(250,250,250);
     textAlign(LEFT,TOP);
     textSize(12);
     text("foods : "+ foodN  + " || cells : " + pop,200,0);
     textAlign(CENTER);
     
     foodCurve.add(foodN,chrono);
     cellCurve.add(pop,chrono);
   }
   foodCurve.show();
   if(foodCurve.lenght/foodCurve.ratio > 5000){
       //foodCurve.simplify(1);
       foodCurve.ratio += 1;
   }
   
   cellCurve.show();
   if(cellCurve.lenght/cellCurve.ratio > 5000){
       //cellCurve.simplify(1);
       cellCurve.ratio += 1;
   }
   
   
   lanch_sim.update();
   pause_sim.update();
   stop_sim.update();
   
   if(lanch_sim.activate){
      run= true; 
      if(reset){
        chrono = 0;
       reset = false;
       foodCurve.reset();
       cellCurve.reset();
       cells.removeAllElements();
       foods.removeAllElements();
       pop = (int)cell_start.value;
       foodN = (int)food_start.value;
       food_target = foodN;
        for(int i = 0; i < pop ; i++){
          
            cells.add(new Cell()); 
           
         }
         for(int i = 0; i < foodN ; i++){
          
            foods.add(new Food()); 
           
         }
       
      }
   }
   
   if(pause_sim.activate){
     if(!reset){
       run = !run;
     }
   }
   
   if(stop_sim.activate){
    
     run = false;
     reset = true;
     
   }
   food_show.update();
   
   float decalage = 0;
   food_mode.update();
   food_start.update();
   
    
   
   textFont(return_to_castle);
   
  stroke(150,150,150);
  fill(150,150,150);
  textAlign(CENTER,TOP);
  textSize(20);
  strokeWeight(2);
  
  line(6,85,194,85);
  text("NOURITURE",100,100);
  text(round(food_start.value),100,205);
  if(!food_mode.activate){
    text(round(food_growth.value),100,275);
    text("mode : croissant",130,130);
    food_growth.update();
  }else{
    text("mode : constant",130,130);
    decalage = 70;
    
  }
  
  
    cell_start.y = 370 -decalage ;
    start_speed.y = 440 -decalage ;
    start_size.y = 510 -decalage ;
    start_cylcle.y = 580 -decalage ;
    start_ratio.y = 650 -decalage ;
    food_ratio.y = 720 -decalage ;
    
    cell_start.update();
    start_speed.update();
    start_size.update();
    start_cylcle.update();
    start_ratio.update();
    food_ratio.update();
    
    textFont(return_to_castle);
    stroke(150,150,150);
    fill(150,150,150);
    textAlign(CENTER,TOP);
    textSize(20);
    strokeWeight(2);
  
  
  line(6,295-decalage,194,295-decalage);
  text("CELLULES",100,310-decalage);
    text(round(cell_start.value),100,390-decalage );
    text(round(start_speed.value),100,450-decalage );
    text(round(start_size.value),100,520-decalage );
    text(round(start_cylcle.value),100,590-decalage );
    text(((float)round(start_ratio.value*100)/100),100,660-decalage );
    text(((float)round(food_ratio.value*1000000)/10000),100,730-decalage );
  
  
  
  

}

class Cell{
  
  
  //paramètres
  float x,y,s,tx = random(1100)+200,ty = random(1100);
  float cycle = 5 + random(1);
  float Ccycle = cycle -0.5 + random(1);
  float foodGive = 0.5;
  float speed = random(5)+20;
  
  //temps local
  float localTime;
  
  //food
  float calories = 100;
  
  
  Cell()
  {
    
      x = random(1100)+200;
      y = random(1100);
      s = random(5)-2.5+start_size.value;
      speed = random(5)-2.5+ start_speed.value;
      cycle = start_cylcle.value -0.5 + random(1);
      Ccycle = cycle -0.5 + random(1);
      foodGive = start_ratio.value;
  }
  
  Cell(Cell _cell, float food){
    calories = food;
    
    x = _cell.x + random(50)-25;
    y = _cell.y + random(50)-25;
    s = _cell.s + random(2)-1;
    if(s < 10){
       s = 10;
    }
    speed = _cell.speed + random(2)-1;
    cycle = _cell.cycle + random(1)-0.5;
    foodGive = _cell.foodGive * (random(0.1)+0.95);
   
   
    
    
  }
  
  
  void update(float time){
   
    
     //===========================================  Maths
     
     //birth
     localTime += time;
     if(localTime > Ccycle){
        localTime -= Ccycle;
        Ccycle = cycle - 0.5 + random(1);
        if(calories > 5*s){
          pop += 1;
          cells.add(new Cell(this,calories*foodGive));
          calories -= calories*foodGive*0.4;
        }
     }
     
     
     //move
     float D = dist(tx,ty,x,y);
     float ratio = (speed * time)/D;
     x += (tx - x) * ratio ;
     y += (ty - y) * ratio ;
     
     if(x < 200){
        x = 200;
     }
     if(y < 0){
        y = 0; 
     }
     if(x > 1300){
        x = 1300; 
     }
     if(y > 1100){
       y = 1100;
     }  
     
     
     
     //starve
     calories -= speed * time * food_ratio.value * pow(s/2,1.8)*PI;
     if(calories < 0){
       loop -= 1;
       pop -= 1;
       cells.removeElementAt(loop+1);
     }
     
     
     //food detector
     float nearFood = 999;
     float potentialTX = 0;
     float potentialTY = 0;
     
     for(int j = 0; j < foodN; j++){
       Food f = foods.elementAt(j);
       if(dist(x,y,f.x,f.y) < (s)/2){
         
         calories += 10;
         foods.removeElementAt(j);
         foodN -= 1;
         j -= 1;
         
       }
       
       if(dist(x,y,f.x,f.y) < nearFood){
         nearFood = dist(x,y,f.x,f.y);
         potentialTX = f.x;
         potentialTY = f.y;
       }
     }
     
     //cells collisions
     for(int j = 0; j < pop; j++){
       if(j != loop){
         Cell c = cells.elementAt(j);
         if(c.s > s * 0.8 && c.s < s * 1.2){
           if(dist(x,y,c.x,c.y) < (s+c.s)/2){
             
             float R = ((s+c.s)/2) / dist(x,y,c.x,c.y) -1;
            
             x += ((x-c.x)*R);
             y += ((y-c.y)*R);
             
           }
         }else{
           
           if(c.s <  s * 0.8){
             
             if(dist(x,y,c.x,c.y) < (s-(c.s*0.75))/2){
               
               calories += c.s*5+c.calories/10;
               cells.removeElementAt(j);
               pop -= 1;
               j -= 1;
               if(j < loop){
                  loop -= 1; 
               }
               
             }
             if(dist(x,y,c.x,c.y) < nearFood){
               nearFood = dist(x,y,c.x,c.y);
               potentialTX = c.x;
               potentialTY = c.y;
             }
             
           }
           
         }
       }
     }
     
     
     
     //si pas de nouriture trouvée
     if(nearFood > 900){
       if(round(x) == round(tx) && round(y) == round(ty)){
           tx = random(1100)+200;
           ty = random(1100);
       }
     }else{
       tx = potentialTX;
       ty = potentialTY;
     }
     
     
     
      
     //draw
     fill(calories,(calories-250),(calories-250));
     ellipse(x,y,s,s);
     fill(240,240,240);
     if(food_show.activate){
       text(round(calories),x,y);
     }
     
    
  }
  
}

class Food{
  
  float x,y;
  
  Food()
  {
      
      x = random(1100)+200;
      y = random(1100);
      
  }  
  
  void update(){
   
    
    //draw
    fill(0,240,0);
    ellipse(x,y,5,5);
    
  }
  
}
  
