// this code was made by physic gamer //
// ce code à été fait par physic gamer// 

public class Button{
  
  // nom du bouton
  String name;
  
  // position / taille / taille du texte / poids du stroke / taille d'ombre /position de l'ombre
  float x,y,w,h,t_s,s_w,s_s,s_x,s_y,x_d,y_d,f_o;
  
  
  // fill color
  color f_c =color(255);
  // stroke color
  
  PImage img;
  color s_c =color(0);
  // text color
  color t_c =color(0);
  // text font
  PFont t_f = createFont("Georgia",30);
  
  //button radius
  float[] radius = new float[4];
  
  //if clicked , if activate , click_effect active/not active , shadows (broken) , eneable : button can ba activate or not
  boolean click = false;
  boolean activate = false;
  boolean click_effect = false;
  boolean shadows = false;
  boolean eneable = true;
  boolean images = false;
 
  
  Button(String n, float pos_x, float pos_y, float wi, float he){
    name = n;
    x = pos_x;
    y = pos_y;
    w = wi;
    h = he;
    t_s = 10;
    f_o = 255;
    
  }
  
  Button(String n, float pos_x, float pos_y, float wi, float he, color fill_c, color stroke_c, color text_c, float text_s , PFont text_f,float stroke_w, float r){
    
    name = n;
    x = pos_x;
    y = pos_y;
    w = wi;
    h = he;
    f_c = fill_c;
    s_c = stroke_c;
    t_c = text_c;
    t_s = text_s;
    t_f = text_f;
    s_w = stroke_w;
    radius[0] = r;
    radius[1] = r;
    radius[2] = r;
    radius[3] = r;
    f_o = 255;
    
  }
  
  void set_image(PImage image){
    
    img = image;
    images = true;
    
  }
  
  void remove_image(){
    
    images = false;
    
  }
  
  void diseable(){
     eneable = false; 
  }
  
  void eneable(){
     eneable = true; 
  }
  
  void set_effect(boolean effect, boolean shadows, float shadows_s, float shadows_x, float shadows_y){
    
    
    click_effect = effect;
    //s = shadow;
    s_s = shadows_s;
    s_x = shadows_x;
    s_y = shadows_y;
    
    
  }
  
  void set_fill(color c_){
    
    f_c = c_;
    
  }
  
  void set_stroke(color c_, float stroke_w, float[] r){
    
    s_c = c_;
    s_w = stroke_w;
    radius = r;
    
  }
  
  void set_pos( float pos_x, float pos_y){
    
    x = pos_x;
    y = pos_y;
    
  }
  
  void set_size(  float wi, float he){
    
    w = wi;
    h = he;
    
  }
  
  void set_text(  color text_c, float text_s , PFont text_f , float x_decal, float y_decal){
    
    t_c = text_c;
    t_s = text_s;
    t_f = text_f;
    x_d = x_decal;
    y_d = y_decal;
    
  }
  
  void update(){
    
     if(activate){
        activate = false; 
     }
     if(eneable){
       maths_update();
     }
     graphics_update();
     
  }
  
  boolean hover(){
    boolean reponse = false;
    
    if(mouseX < x+w && mouseX > x && mouseY < y+h && mouseY > y){
      
      reponse = true;
      
    }
    
    return(reponse);
  }
  
  void maths_update(){
   if(activate){
      activate = false; 
   }
    
   if(mousePressed && !click && mouseButton == LEFT){
     if(hover()){
       click = true;
     }
   }
   if(!mousePressed && click || !hover()){
     if(hover()){
       activate = true;
     }
     click = false;
   }
   
   
    
  }
  
  void graphics_update(){
    noTint();
    rectMode(CORNER);
    float decal = 0;
    if(click_effect && click){
       decal = 2; 
    }
    if(!eneable){
         
       tint(250,250,250,150);
       }
       if(hover() && eneable){
         
       tint(255,255,255,200);
       }
       
     if(click && eneable){
       
        
       tint(255,255,255,180);
       
     }
  
    if(images){
      image(img,x-decal,y+decal,w,h);
    }else{
        
      strokeWeight(s_w);
      noStroke();
     // rect(x+s_x,y+s_y,w*s_s,h*s_s,radius[0],radius[1],radius[2],radius[3]);
      fill(red(f_c),green(f_c),blue(f_c),f_o);
      stroke(s_c);
      rect(x-decal,y+decal,w,h,radius[0],radius[1],radius[2],radius[3]);
      if(click && eneable){
        
        fill(255,50);
        stroke(180);
          
  
        rect(x-decal,y+decal,w,h,radius[0],radius[1],radius[2],radius[3]);
        
      }
      
    }
    fill(t_c);
    noStroke();
    textAlign(CENTER, CENTER);
    textFont(t_f);
    strokeWeight(1);
    textSize(t_s);
    text(name,x+w/2-decal+x_d,y+h/2+decal+y_d);
    stroke(0);
    if(!images){
        if(!eneable){
           fill(255,120);
           strokeWeight(s_w);
           stroke(180);
           rect(x-decal,y+decal,w,h,radius[0],radius[1],radius[2],radius[3]);
          
        }
          if(hover() && eneable){
          
          noStroke();
          fill(230,100);
          rect(x-decal-s_w/2,y+decal-s_w/2,w+s_w,h+s_w,radius[0]+s_w,radius[1]+s_w,radius[2]+s_w,radius[3]+s_w);
          
        }
    }
  }
}
