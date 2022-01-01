PImage origin;
PImage evo;
PFont p;
void setup(){
  p=createFont("ariel",20);
  textFont(p);
}
void settings() {
  origin=loadImage("img.jpg");
  evo=createImage(origin.width - (origin.width % 5),origin.height-(origin.height % 5),RGB);
  size(origin.width+200,origin.height);

  evo.loadPixels();
  for (int i=0;i<evo.width;i++){
    for (int j=0;j<evo.height;j++){
      int pos=i+j*evo.width;
      evo.pixels[pos]=color(random(0,255),random(0,255),random(0,255));
    }
  }
  evo.updatePixels();
}

void draw() {
  int best=500;
  int cbest=100000;
  background(100, 200, 70);
  
  image(evo,0,0);
  evo.loadPixels();
  for (int i=1;i<evo.pixels.length-24;i+=24){
      color [] place=new color[25];
      int [] places=new int[25];
      for (int m=i;m<i+24;m++){
          color a=evo.pixels[m];
          place[m-i]=a;
          
      }
      for (int m=1;m<25;m++){
          places[m]=m;
      }
      for (int m=0;m<24;m++){
        for (int n=m+1;n<25;n++){
          if (dis(place[m],origin.pixels[i+m-1])<dis(place[n],origin.pixels[i+n-1])){
            color t=place[n];
            place[n]=place[m];
            place[m]=t;
            int z=n;
            places[n]=m;
            places[m]=z;
          }
          
        }
      }
      for (int m=0;m<12;m++){
        evo.pixels[i+places[m]]=color(random(0,255),random(0,255),random(0,255));
      }
      for (int m=13;m<24;m++){
        float r  = red  (evo.pixels[i+places[m]]);
        float g  = green(evo.pixels[i+places[m]]);
        float b  = blue (evo.pixels[i+places[m]]);
        float rr = red  (origin.pixels[i+places[m]]);
        float gg = green(origin.pixels[i+places[m]]);
        float bb = blue (origin.pixels[i+places[m]]);
        if (r<rr){
           r=r+0.5;
        }else{
           r=r-0.5;
        }
        if (g<g){
           g=g+0.5;
        }else{
           g=g-0.5;
        }
        if (b<bb){
           b=b+0.5;
        }else{
           b=b-0.5;
        }
        evo.pixels[i+places[m]]=color(r,g,b);
      }
    }
    for (int i=10;i<evo.pixels.length;i++){
      if (dis(evo.pixels[i],origin.pixels[i])<cbest){
            cbest=dis(evo.pixels[i],origin.pixels[i]);
            best=i;
          }
    }
    evo.updatePixels();
    String bes="Best pixel: " /*+ red(cbest) + " " + blue(cbest) + " " + green(cbest) + " "*/ + best/width + "x" + best/height;
    rectMode(CORNERS);
    text(bes,width-180,40,width,200);
}
int dis(color a,color b){
  int m1=int(abs(red(a)-red(b)))+1;
  int m2=int(abs(blue(a)-blue(b)))+1;
  int m3=int(abs(green(a)-green(b)))+1;
  return(m1*m2*m3);
}
