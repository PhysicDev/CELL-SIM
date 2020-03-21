
import java.util.Collections;

class Graphic{
  
  float x,y,w,h ;
  color fill_c = color(240);
  color stroke_c = color(70);
  color t_c = color(70);
  color f_t_c = color(150);
  float stroke_w = 1;
  int ratio = 1;
  Vector<Float> ordonee = new Vector<Float>();
  Vector<Float> abscice = new Vector<Float>();
  
  PFont t_f = createFont("Georgia",30);
  
  float lenght = 0;
  float start  = 0;
  
  String name,abs_unit,ord_unit;
  
  boolean absice_ponderee = false;
  
  boolean show_name = true;
  String name_pos = "CENTER";
  
  boolean Lsubdivide_1 = true;
  boolean Csubdivide_1 = true;
  
  float sub_Lsubdivide_ratio = 0.2;
  float sub_Csubdivide_ratio = 0.33;
  float pow_Lsubdivide_ratio = 1/sub_Lsubdivide_ratio;
  float pow_Csubdivide_ratio = 1/sub_Csubdivide_ratio;
  
  float unit_refC = 1;
  float unit_refL = 1;
  
  float subdivide_stroke = 3;
  
  color subdivision_color = color(20);
  color line_color = color(240,0,0);
  float line_weight = 1.5;
  
  Graphic(String Name, float x_, float y_ , float w_, float h_ ,color background){
   
     name = Name;
     x = x_;
     y = y_;
     w = w_;
     h = h_;
     fill_c = background;
    
  }
  
    
  Graphic(String Name, float x_, float y_ , float w_, float h_ ,color background, color stroke_color , color stroke_weight){
   
     name = Name;
     x = x_;
     y = y_;
     w = w_;
     h = h_;
     fill_c = background;
     stroke_c = stroke_color;
     stroke_w = stroke_weight;

    
  }
  
  void set_font( PFont font,color text_c , color fill_text_c){
    
    t_f = font;
    t_c = text_c;
    f_t_c = fill_text_c;
    
  }
  
  void reset(){
   
    lenght = 0;
    ordonee = new Vector<Float>();
    abscice = new Vector<Float>();
    
  }
  
  void set_lines(boolean O, boolean C , float ratio_subO , float ratio_subC , color div_c, float stroke_w, color line_c, float line_w,float refl,float refc,String unitl,String unitc){
    
      
    Lsubdivide_1 = O;
    Csubdivide_1 = C;
    
    sub_Lsubdivide_ratio = ratio_subO;
    sub_Csubdivide_ratio = ratio_subC;
    pow_Lsubdivide_ratio = 1/sub_Lsubdivide_ratio;
    pow_Csubdivide_ratio = 1/sub_Csubdivide_ratio;
    
    subdivide_stroke = stroke_w;
    
    subdivision_color = div_c;
    line_color = line_c;
    line_weight = line_w;
    
    
    unit_refC = refc;
    unit_refL = refl;
    
    
    abs_unit = unitl;
    ord_unit = unitc;
    
  }
  
  void set_style(color background, color stroke_color , float stroke_weight ){
    
     fill_c = background;
     stroke_c = stroke_color;
     stroke_w = stroke_weight;
     
  }
  
  void add(float value_1,float value_2){
    
    ordonee.add(value_1);
    abscice.add(value_2);
    lenght += 1;
    
  }
  
  void add(float value){
    
    ordonee.add(value);
    if(absice_ponderee){
      if(lenght == 0){
        abscice.add((float)0);
        start = millis();
      }else{
        abscice.add((float)(millis()-start));
      }
    }else{
        abscice.add((float)(lenght));
    }
    lenght += 1;
    
  }
  
  void simplify(int skipRate){
    int current_index = 0;
    while(abscice.size() > current_index){
      for(int i = 0; i < skipRate; i++){
          abscice.removeElementAt(i+current_index);
          ordonee.removeElementAt(i+current_index);
          lenght -= 1;
      }
      current_index ++;
    }
    
  }
  
  void show(){
   
    rectMode(CENTER);
    textFont(t_f);
    
    fill(fill_c);
    stroke(stroke_c);
    strokeWeight(stroke_w);
    
    rect(x,y,w,h);
    textAlign(CENTER,CENTER);
    if(lenght != 0){
      float max_A = Collections.max(abscice);
      float max_O = Collections.max(ordonee);
      float min_A = Collections.min(abscice);
      if(min_A > 0){
         min_A = 0;
      }
      float min_O = Collections.min(ordonee);
      if(min_O > 0){
         min_O = 0;
      }
      
      float plage_A = max_A - min_A;
      float plage_O = max_O - min_O;
      
      float ratio_A = w/plage_A;
      float ratio_O = h/plage_O;
      
      float origine_A = Math.abs(min_A) * ratio_A;
      float origine_O = Math.abs(min_O) * ratio_O;
      
      textSize(11);
      
      if(plage_A != 0){
        float ratio = (w)/plage_A;
        float base = 1;
        while(ratio < w){
           ratio *= pow_Lsubdivide_ratio;
           base *= pow_Lsubdivide_ratio;
        }
        while(ratio > 3){
            stroke(red(subdivision_color),green(subdivision_color),blue(subdivision_color),(float)Math.pow(500*(ratio/w),1.5));
            fill(red(subdivision_color),green(subdivision_color),blue(subdivision_color),(float)Math.pow(500*(ratio/w),1.5));
            strokeWeight(15*(ratio/w));
            if(15*(ratio/w) > subdivide_stroke){
              strokeWeight(subdivide_stroke);
            }
            for(int i = 1; i*ratio < w-origine_A; i++){
              if(ratio > 20){
                 float value_f = (i)*base;
                 
                 String pow_10 = "";
                 if(value_f > 10000000000.0){
                   value_f /= 10000000000.0; 
                   pow_10 = " x10^(10)";
                 }
                 
                
                 
                 String value = value_f + "";
                 
                 text(value+pow_10,i*ratio+x-w/2-origine_A,y+h/2+15);
              }
              line(i*ratio+x-w/2-origine_A,y-h/2,i*ratio+x-w/2-origine_A,y+h/2);
              
            }
            
            //negative columns
            for(int i = -1; i*ratio+origine_A > 0; i--){
              if(ratio > 20){
                 float value_f = (i)*base;
                 String pow_10 = "";
                 if(value_f > 10000000000.0){
                   value_f /= 10000000000.0; 
                   pow_10 = " x10^(10)";
                 }
                 
                
                 
                 String value = value_f + "";
                 
                 text(value+pow_10,i*ratio+x-w/2-origine_A,y+h/2+15);
              }
              line(i*ratio+x-w/2-origine_A,y-h/2,i*ratio+x-w/2-origine_A,y+h/2);
              
            }
            ratio *= sub_Lsubdivide_ratio;
            base *= sub_Lsubdivide_ratio;
        }
        
        
      }
      
      
      
      if(plage_O != 0){
        float ratio = (h)/plage_O;
        float base = 1;
        while(ratio < h){
           ratio *= pow_Csubdivide_ratio;
           base *= pow_Csubdivide_ratio;
        }
        while(ratio > 3){
            stroke(red(subdivision_color),green(subdivision_color),blue(subdivision_color),(float)Math.pow(500*(ratio/h),1.5));
            fill(red(subdivision_color),green(subdivision_color),blue(subdivision_color),(float)Math.pow(500*(ratio/h),1.5));
            strokeWeight(15*(ratio/h));
            if(15*(ratio/h) > subdivide_stroke){
              strokeWeight(subdivide_stroke);
            }
            
            //positive lines
            for(int i = 1; i*ratio < h-origine_O; i++){
              if(ratio > 20){
                 float value_f = (i)*base;
                 String value = value_f + "";
                 if(value.length() > 4){
                   // value = value.substring(0,4);
                 }
                 text(value,x-w/2-textWidth(value)-10,y+h/2-i*ratio-origine_O);
              }
              line(x-w/2,y+h/2-i*ratio-origine_O,x+w/2,y+h/2-i*ratio-origine_O);
              
            }
            
            // negative lines
            for(int i = -1; i*ratio+origine_O > 0; i--){
              if(ratio > 20){
                 float value_f = (i)*base;
                 String value = value_f + "";
                 if(value.length() > 4){
                   // value = value.substring(0,4);
                 }
                 text(value,x-w/2-textWidth(value)-10,y+h/2-i*ratio-origine_O);
              }
              line(x-w/2,y+h/2-i*ratio-origine_O,x+w/2,y+h/2-i*ratio-origine_O);
              
            }
            ratio *= sub_Csubdivide_ratio;
            base *= sub_Csubdivide_ratio;
        }
        
      }
      
      strokeWeight(2);
      stroke(red(line_color)/4,green(line_color)/4,blue(line_color)/4);
      line(x-w/2,y+h/2-origine_O,x+w/2,y+h/2-origine_O);
      line(x-w/2+origine_A,y+h/2,x-w/2+origine_A,y-h/2);
      
      
      
      strokeWeight(2);
      stroke(line_color);
      for(int i = 0; i + ratio < lenght; i+=ratio){
       
        
        line(abscice.get(i)*ratio_A+x-w/2-origine_A,y+h/2-ordonee.get(i)*ratio_O-origine_O,abscice.get(i+ratio)*ratio_A+x-w/2-origine_A,y+h/2-ordonee.get(i+ratio)*ratio_O-origine_O);
        
        
      }
    }
    if(show_name){
      if(name_pos == "CENTER"){
       
          fill(f_t_c);
          textSize(20);
          strokeWeight(0);
          rect(x,y-h/2+10,textWidth(name),20);
          stroke(t_c);
          fill(t_c);
          strokeWeight(1);
          text(name,x,y-h/2+10);
        
      }
    }
    rectMode(CORNER);
  }
  
  
}  
