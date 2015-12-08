class Cube
{
  //delcare fields for object behaviour 
  int posX;
  int posY;
  int speedX;
  int speedY;
  int z;
  float hVal;
  float spin;
  
  //constructor
  Cube()
  { 
    //set the x and why positions to random pixels on screen
    posX = int(random(0, width));
    posY = int(random(0, height));
    //set the speed which the cubes will move at
    speedX = -1;
    speedY = -1;
    z = int(random(0));
    spin=0.0;
    hVal=0;
    
  }
  
  void update()
  {
    posX += speedX;
    posY += speedY;
    
    //keep cubes within the area of the screen width
    if(posX >= width-50 || posX <=0+50)
    {
      speedX *= -1;
    }
    //keep cubes within the area of the screen height
    if(posY >= height-50 || posY <=0+50)
    {
      speedY *= -1;
    }
      //run through hue colours
      hVal+=0.5;
      if(hVal>255)
      {
        hVal=0;
      }
     
   
  }
  
  void renderVisual4()
  {
    
     pushMatrix();
      //declare positions of cubes
     translate(posX, posY, z); 
     
     //Hue/Saturation/Brightness
     colorMode(HSB);
     //will run through hues at full saturation and brightness
     fill(hVal, 255, 255);
     colorMode(RGB);
     stroke(amplitude/3);
     
     //create a spin on cubes
     rotateY(frameCount/100.0 );
     
     /*intial size of cubes is ten. Add the amplitude
     for the specturm effect*/
     box(10+(amplitude/3));
     
     popMatrix();
   }
  
}