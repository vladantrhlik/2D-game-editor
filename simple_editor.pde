
int[][] pole;
int[][] rotate;
int[][] blokType;
int poleW, poleH;
int tileSize; //[px]
int poleX, poleY; // translate
boolean mouseClicked;
int mouseClickStartX, mouseClickStartY;
float scale;
int tileRealSize;
int type;

PImage[] texture;
PImage spike, glass, bomb, jumppad, finish;

String path;

void setup() {
  
  path = "dirt/";
  
  spike = loadImage("other/spike1.png");
  glass = loadImage("other/glass.png");
  bomb = loadImage("other/bomb.png");
  jumppad = loadImage("other/jumppad.png");
  finish = loadImage("other/finish.png");

  texture = new PImage[15];

  texture[0] = loadImage(path + "0.png");
  texture[1] = loadImage(path + "1.png");
  texture[2] = loadImage(path + "2.png");
  texture[3] = loadImage(path + "3.png");
  texture[4] = loadImage(path + "4.png");
  texture[5] = loadImage(path + "5.png");
  texture[6] = loadImage(path + "01.png");
  texture[7] = loadImage(path + "02.png");
  texture[8] = loadImage(path + "03.png");
  texture[9] = loadImage(path + "04.png");
  texture[10] = loadImage(path + "022.png");
  texture[11] = loadImage(path + "11.png");
  texture[12] = loadImage(path + "112.png");
  texture[13] = loadImage(path + "12.png");
  texture[14] = loadImage(path + "21.png");



  poleW = 50; //sirka pole
  poleH = 32; // vyska pole
  pole = new int[poleW][poleH];
  rotate = new int[poleW][poleH];
  blokType = new int[poleW][poleH];
  size(750, 750, P3D);
  clearPole();
  tileRealSize = 50;
  tileSize = tileRealSize;
  poleX = 0;
  poleY = 0;
  mouseClicked = false;
  mouseClickStartX = 0;
  mouseClickStartY = 0;
  scale = 1.0;
  type = 1;
}

void draw() {
  background(#00BBCE);

  tileSize = round(scale*tileRealSize);

  translate(poleX, poleY);
  vykresliPole();
  checkMouse();
  movePole();
  translate(-poleX, -poleY);

  println(type);
}



void clearPole() {
  for (int y = 0; y < poleH; y++) {
    for (int x = 0; x < poleW; x++) {
      rotate[x][y] = 0;
      blokType[x][y] = 0;

      if (x == 0) {
        pole[x][y] = 1;
        blokType[x][y] = 1;
        rotate[x][y] = 1;
      } else if (x == poleW-1) {
        pole[x][y] = 1;
        blokType[x][y] = 1;
        rotate[x][y] = 3;
      } else if (y == 0) {
        pole[x][y] = 1;
        blokType[x][y] = 1;
        rotate[x][y] = 2;
      } else if (y == poleH-1) {
        pole[x][y] = 1;
        blokType[x][y] = 1;
        rotate[x][y] = 0;
      } else {
        pole[x][y] = 2; //nic
      }
      
      
      
    }
  }
  blokType[0][0] = 6;
  blokType[poleW-1][0] = 6;
  blokType[0][poleH-1] = 6;
  blokType[poleW-1][poleH-1] = 6;
  
  rotate[0][0] = 2;
  rotate[poleW-1][0] = 3;
  rotate[0][poleH-1] = 1;
  rotate[poleW-1][poleH-1] = 0;
}

void vykresliPole() {
  for (int y = 0; y < poleH; y++) {
    for (int x = 0; x < poleW; x++) {
      strokeWeight(1);
      noStroke();
      switch(pole[x][y]) {

      case 0:  //spajk
        //fill(0, 255, 0);
        //stroke(255);
        //rect(x*tileSize, y*tileSize, tileSize, tileSize);
        image(spike,x*tileSize, y*tileSize, tileSize, tileSize);
        break;
      case 1:  //blok
        if (x>=1 && x<poleW-1 && y>=1 && y<poleH-1) {
          //ground
          if (pole[x-1][y] == 1 && pole[x+1][y] == 1 && pole[x][y-1] != 1 && pole[x][y+1] == 1) {
            blokType[x][y] = 1;
            rotate[x][y] = 0;
          }
          if (pole[x-1][y] == 1 && pole[x+1][y] != 1 && pole[x][y-1] == 1 && pole[x][y+1] == 1) {
            blokType[x][y] = 1;
            rotate[x][y] = 1;
          }
          if (pole[x-1][y] == 1 && pole[x+1][y] == 1 && pole[x][y-1] == 1 && pole[x][y+1] != 1) {
            blokType[x][y] = 1;
            rotate[x][y] = 2;
          }
          if (pole[x-1][y] != 1 && pole[x+1][y] == 1 && pole[x][y-1] == 1 && pole[x][y+1] == 1) {
            blokType[x][y] = 1;
            rotate[x][y] = 3;
          }
          //corners hhhhhhhh
          if (pole[x-1][y] == 1 && pole[x+1][y] == 1 && pole[x][y-1] != 1 && pole[x][y+1] == 1 && pole[x+1][y+1] != 1) {
            blokType[x][y] = 11;
            rotate[x][y] = 0;
          }
          if (pole[x-1][y] == 1 && pole[x+1][y] != 1 && pole[x][y-1] == 1 && pole[x][y+1] == 1 && pole[x-1][y+1] != 1) {
            blokType[x][y] = 11;
            rotate[x][y] = 1;
          }
          if (pole[x-1][y] == 1 && pole[x+1][y] == 1 && pole[x][y-1] == 1 && pole[x][y+1] != 1 && pole[x-1][y-1] != 1) {
            blokType[x][y] = 11;
            rotate[x][y] = 2;
          }
          if (pole[x-1][y] != 1 && pole[x+1][y] == 1 && pole[x][y-1] == 1 && pole[x][y+1] == 1 && pole[x+1][y-1] != 1) {
            blokType[x][y] = 11;
            rotate[x][y] = 3;
          }
          //-------------
          if (pole[x-1][y] == 1 && pole[x+1][y] == 1 && pole[x][y-1] != 1 && pole[x][y+1] == 1 && pole[x-1][y+1] != 1) {
            blokType[x][y] = 12;
            rotate[x][y] = 0;
          }
          if (pole[x-1][y] == 1 && pole[x+1][y] != 1 && pole[x][y-1] == 1 && pole[x][y+1] == 1 && pole[x-1][y-1] != 1) {
            blokType[x][y] = 12;
            rotate[x][y] = 1;
          }
          if (pole[x-1][y] == 1 && pole[x+1][y] == 1 && pole[x][y-1] == 1 && pole[x][y+1] != 1 && pole[x+1][y-1] != 1) {
            blokType[x][y] = 12;
            rotate[x][y] = 2;
          }
          if (pole[x-1][y] != 1 && pole[x+1][y] == 1 && pole[x][y-1] == 1 && pole[x][y+1] == 1 && pole[x+1][y+1] != 1) {
            blokType[x][y] = 12;
            rotate[x][y] = 3;
          }
          //-----------------
          if (pole[x-1][y] == 1 && pole[x+1][y] == 1 && pole[x][y-1] != 1 && pole[x][y+1] == 1 && pole[x-1][y+1] != 1 && pole[x+1][y+1] != 1) {
            blokType[x][y] = 13;
            rotate[x][y] = 0;
          }
          if (pole[x-1][y] == 1 && pole[x+1][y] != 1 && pole[x][y-1] == 1 && pole[x][y+1] == 1 && pole[x-1][y-1] != 1 && pole[x-1][y+1] != 1) {
            blokType[x][y] = 13;
            rotate[x][y] = 1;
          }
          if (pole[x-1][y] == 1 && pole[x+1][y] == 1 && pole[x][y-1] == 1 && pole[x][y+1] != 1 && pole[x-1][y-1] != 1 && pole[x+1][y-1] != 1) {
            blokType[x][y] = 13;
            rotate[x][y] = 2;
          }
          if (pole[x-1][y] != 1 && pole[x+1][y] == 1 && pole[x][y-1] == 1 && pole[x][y+1] == 1 && pole[x+1][y-1] != 1 && pole[x+1][y+1] != 1) {
            blokType[x][y] = 13;
            rotate[x][y] = 3;
          }
          //empty
          if (pole[x-1][y] == 1 && pole[x+1][y] == 1 && pole[x][y-1] == 1 && pole[x][y+1] == 1) {
            blokType[x][y] = 0;
            rotate[x][y] = 0;
          }
          //empty with corners
          if (pole[x-1][y] == 1 && pole[x+1][y] == 1 && pole[x][y-1] == 1 && pole[x][y+1] == 1     && pole[x-1][y-1] != 1) {
            blokType[x][y] = 6;
            rotate[x][y] = 0;
          }
          if (pole[x-1][y] == 1 && pole[x+1][y] == 1 && pole[x][y-1] == 1 && pole[x][y+1] == 1     && pole[x+1][y-1] != 1) {
            blokType[x][y] = 6;
            rotate[x][y] = 1;
          }
          if (pole[x-1][y] == 1 && pole[x+1][y] == 1 && pole[x][y-1] == 1 && pole[x][y+1] == 1     && pole[x+1][y+1] != 1) {
            blokType[x][y] = 6;
            rotate[x][y] = 2;
          }
          if (pole[x-1][y] == 1 && pole[x+1][y] == 1 && pole[x][y-1] == 1 && pole[x][y+1] == 1     && pole[x-1][y+1] != 1) {
            blokType[x][y] = 6;
            rotate[x][y] = 3;
          }
          //2
          if (pole[x-1][y] == 1 && pole[x+1][y] == 1 && pole[x][y-1] == 1 && pole[x][y+1] == 1     && pole[x-1][y-1] != 1 && pole[x+1][y-1] != 1) {
            blokType[x][y] = 7;
            rotate[x][y] = 0;
          }
          if (pole[x-1][y] == 1 && pole[x+1][y] == 1 && pole[x][y-1] == 1 && pole[x][y+1] == 1     && pole[x+1][y-1] != 1 && pole[x+1][y+1] != 1) {
            blokType[x][y] = 7;
            rotate[x][y] = 1;
          }
          if (pole[x-1][y] == 1 && pole[x+1][y] == 1 && pole[x][y-1] == 1 && pole[x][y+1] == 1     && pole[x+1][y+1] != 1 && pole[x-1][y+1] != 1) {
            blokType[x][y] = 7;
            rotate[x][y] = 2;
          }
          if (pole[x-1][y] == 1 && pole[x+1][y] == 1 && pole[x][y-1] == 1 && pole[x][y+1] == 1     && pole[x-1][y+1] != 1 && pole[x-1][y-1] != 1) {
            blokType[x][y] = 7;
            rotate[x][y] = 3;
          }
          //stridave
          if (pole[x-1][y] == 1 && pole[x+1][y] == 1 && pole[x][y-1] == 1 && pole[x][y+1] == 1     && pole[x-1][y-1] != 1 && pole[x+1][y+1] != 1) {
            blokType[x][y] = 10;
            rotate[x][y] = 0;
          }
          if (pole[x-1][y] == 1 && pole[x+1][y] == 1 && pole[x][y-1] == 1 && pole[x][y+1] == 1     && pole[x+1][y-1] != 1 && pole[x-1][y+1] != 1) {
            blokType[x][y] = 10;
            rotate[x][y] = 1;
          }
          //3
          if (pole[x-1][y] == 1 && pole[x+1][y] == 1 && pole[x][y-1] == 1 && pole[x][y+1] == 1     && pole[x-1][y-1] != 1 && pole[x+1][y-1] != 1 && pole[x+1][y+1] != 1) {
            blokType[x][y] = 8;
            rotate[x][y] = 0;
          }
          if (pole[x-1][y] == 1 && pole[x+1][y] == 1 && pole[x][y-1] == 1 && pole[x][y+1] == 1     && pole[x+1][y-1] != 1 && pole[x+1][y+1] != 1 && pole[x-1][y+1] != 1) {
            blokType[x][y] = 8;
            rotate[x][y] = 1;
          }
          if (pole[x-1][y] == 1 && pole[x+1][y] == 1 && pole[x][y-1] == 1 && pole[x][y+1] == 1     && pole[x+1][y+1] != 1 && pole[x-1][y+1] != 1 && pole[x-1][y-1] != 1 ) {
            blokType[x][y] = 8;
            rotate[x][y] = 2;
          }
          if (pole[x-1][y] == 1 && pole[x+1][y] == 1 && pole[x][y-1] == 1 && pole[x][y+1] == 1     && pole[x+1][y-1] != 1 && pole[x-1][y-1] != 1 && pole[x-1][y+1] != 1 ) {
            blokType[x][y] = 8;
            rotate[x][y] = 3;
          }
          //4
          if (pole[x-1][y] == 1 && pole[x+1][y] == 1 && pole[x][y-1] == 1 && pole[x][y+1] == 1     && pole[x+1][y-1] != 1 && pole[x-1][y-1] != 1 && pole[x-1][y+1] != 1 && pole[x+1][y+1] != 1 ) {
            blokType[x][y] = 9;
            rotate[x][y] = 0;
          }
          //corner
          if (pole[x-1][y] != 1 && pole[x+1][y] == 1 && pole[x][y-1] != 1 && pole[x][y+1] == 1) {
            blokType[x][y] = 2;
            rotate[x][y] = 0;
          }
          if (pole[x-1][y] == 1 && pole[x+1][y] != 1 && pole[x][y-1] != 1 && pole[x][y+1] == 1) {
            blokType[x][y] = 2;
            rotate[x][y] = 1;
          }
          if (pole[x-1][y] == 1 && pole[x+1][y] != 1 && pole[x][y-1] == 1 && pole[x][y+1] != 1) {
            blokType[x][y] = 2;
            rotate[x][y] = 2;
          }
          if (pole[x-1][y] != 1 && pole[x+1][y] == 1 && pole[x][y-1] == 1 && pole[x][y+1] != 1) {
            blokType[x][y] = 2;
            rotate[x][y] = 3;
          }
          //corners aaaaaaaaaaaaaaaaaaaaaaaaaaa
          if (pole[x-1][y] != 1 && pole[x+1][y] == 1 && pole[x][y-1] != 1 && pole[x][y+1] == 1 && pole[x+1][y+1] != 1) {
            blokType[x][y] = 14;
            rotate[x][y] = 0;
          }
          if (pole[x-1][y] == 1 && pole[x+1][y] != 1 && pole[x][y-1] != 1 && pole[x][y+1] == 1 && pole[x-1][y+1] != 1) {
            blokType[x][y] = 14;
            rotate[x][y] = 1;
          }
          if (pole[x-1][y] == 1 && pole[x+1][y] != 1 && pole[x][y-1] == 1 && pole[x][y+1] != 1 && pole[x-1][y-1] != 1) {
            blokType[x][y] = 14;
            rotate[x][y] = 2;
          }
          if (pole[x-1][y] != 1 && pole[x+1][y] == 1 && pole[x][y-1] == 1 && pole[x][y+1] != 1 && pole[x+1][y-1] != 1) {
            blokType[x][y] = 14;
            rotate[x][y] = 3;
          }


          //block
          if (pole[x-1][y] != 1 && pole[x+1][y]!= 1 && pole[x][y-1] != 1 && pole[x][y+1] != 1) {
            blokType[x][y] = 4;
            rotate[x][y] = 0;
          }
          //slope
          if (pole[x-1][y] != 1 && pole[x+1][y]!= 1 && pole[x][y-1] == 1 && pole[x][y+1] == 1) {
            blokType[x][y] = 5;
            rotate[x][y] = 0;
          }
          if (pole[x-1][y] == 1 && pole[x+1][y]== 1 && pole[x][y-1] != 1 && pole[x][y+1] != 1) {
            blokType[x][y] = 5;
            rotate[x][y] = 1;
          }
          //top
          if (pole[x-1][y] != 1 && pole[x+1][y] != 1 && pole[x][y-1] != 1 && pole[x][y+1] == 1) {
            blokType[x][y] = 3;
            rotate[x][y] = 0;
          }
          if (pole[x-1][y] == 1 && pole[x+1][y] != 1 && pole[x][y-1] != 1 && pole[x][y+1] != 1) {
            blokType[x][y] = 3;
            rotate[x][y] = 1;
          }
          if (pole[x-1][y] != 1 && pole[x+1][y] != 1 && pole[x][y-1] == 1 && pole[x][y+1] != 1) {
            blokType[x][y] = 3;
            rotate[x][y] = 2;
          }
          if (pole[x-1][y] != 1 && pole[x+1][y] == 1 && pole[x][y-1] != 1 && pole[x][y+1] != 1) {
            blokType[x][y] = 3;
            rotate[x][y] = 3;
          }
        } else {
          fill(200);
          noStroke();
          rect(x*tileSize, y*tileSize, tileSize, tileSize);
          noStroke();
        }

        break;
        
      case 2:  //nic
        noFill();
        rect(x*tileSize, y*tileSize, tileSize, tileSize);
        break;

      case 3:  //coina/checkpoint/finish
        image(finish,x*tileSize, y*tileSize, tileSize, tileSize);
        break;

      case 4:  //zviditelnujjici se blok
        
        image(glass,x*tileSize, y*tileSize, tileSize, tileSize);
        break;
        //5 je zabrana hrou :) (byl to pokus o zebrik a jsem linej to odstranovat)
      case 6:  //zviditelnujjici se blok
        fill(#FFDA05);
        rect(x*tileSize, y*tileSize, tileSize, tileSize);
        break;

      case 7:  //cirkularka
        
        image(bomb,x*tileSize, y*tileSize, tileSize, tileSize);
        break;

      case 8:  //jumppad
        image(jumppad,x*tileSize, y*tileSize, tileSize, tileSize);
        break;
      }

      //vykresleni textury
      if (pole[x][y] == 1) {
        translate(x*tileSize+tileSize/2, y*tileSize+tileSize/2);
        rotate(rotate[x][y] * PI/2);
        image(texture[blokType[x][y]], -tileSize/2, -tileSize/2, tileSize, tileSize);
        rotate(-rotate[x][y] * PI/2);
        translate(-(x*tileSize+tileSize/2), -(y*tileSize+tileSize/2));
      }
    }
  }
}



void checkMouse() {
  for (int y = 0; y < poleH; y++) {
    for (int x = 0; x < poleW; x++) {
      if (mouseX - poleX > x*tileSize && mouseX - poleX < x*tileSize+tileSize && mouseY - poleY > y*tileSize && mouseY - poleY < y*tileSize + tileSize) {
        noFill();
        stroke(255, 0, 0);
        strokeWeight(3);
        rect(x*tileSize, y*tileSize, tileSize, tileSize);
        if (mousePressed && mouseButton==LEFT) {
          pole[x][y] = type;
        } else if (mousePressed && mouseButton==RIGHT) {
          pole[x][y] = 2;
        }
      }
    }
  }
}

void movePole() {
  if (mousePressed && mouseButton==CENTER && !mouseClicked) {
    mouseClickStartX = mouseX - poleX;
    mouseClickStartY = mouseY - poleY;
    mouseClicked = true;
  } else if (mousePressed && mouseButton==CENTER) {
    poleX = - mouseClickStartX + mouseX;
    poleY = - mouseClickStartY + mouseY;
  }
}


void mouseReleased() {
  if (mouseButton == CENTER) {
    mouseClicked = false;
    mouseClickStartX = 0;
    mouseClickStartY = 0;
  }
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  println(e);
  scale-=e/20;
}
void keyPressed() {
  if (keyCode == ' ') {
    printThatShit();
  }
  if (key == 'z' || key == 'y') {
    type = 1;
  }

  if (key == 'x') {
    type = 0;
  }
  if (key == 'c') {
    type = 3;
  }
  if (key == 'v') {
    type = 4;
  }
  if (key == 'b') {
    type = 8;
  }
  if (key == 'n') {
    type = 7;
  }
}



void printThatShit() {
  PrintWriter output = createWriter("lvl.txt");
  for (int y = 0; y < poleH; y++) {
    for (int x = 0; x < poleW; x++) {
      if (pole[x][y] != 2) {
        output.println(x*20);
        output.println(y*20);
        output.println(20);
        output.println(20);
        output.println(pole[x][y]);
        output.println(blokType[x][y]);
        output.println(rotate[x][y]);
        
      }
    }
  }
  output.flush();
  output.close();
  //create .txt file :)
}
