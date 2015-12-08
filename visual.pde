class Visual
{
  
  //fields
  int cubeSize;
  int sphereSize;
  float hVal;
  float spin;

  //constructors
  Visual()
  {
    cubeSize=140;
    sphereSize=100;
    spin=0.0;
    hVal=0;
  
  }
  
  //update method for behaviour of visuals
  void update()
  {
      /* control spin of visuals
      if greater tha 360, set back to zero*/
      if (spin <= 360) 
      {
        spin = spin + 0.01;
      }
      else 
      {
        spin = 0.0;
      }
 
      /*run through the hue colurs at 0.5 to 
      create slow colur changes of the visual and more colours*/
      hVal+=0.5;
      if(hVal>255)
      {
        hVal=0;
      }
     
   
  }
  
 
  //visual methods
  void renderVisual()
  {
    lights();
    pushMatrix();
    translate(width/2, height/2, 0.0);
    colorMode(HSB);
     //will run through hues at full saturation and brightness
    fill(hVal, 255, 255);
    colorMode(RGB);
    rotateY(spin);
    strokeWeight(3);
    /*apply the ampiltude to the stroke of the sphere which creates 
    flashing strobe effect*/
    stroke(amplitude*6);
    //set the intial sphere size plus expanion of the amplitude value
    sphere(sphereSize+(amplitude/5));
  
    
    popMatrix();
  }
  
  
  void renderVisual2()
  {
    lights();
    pushMatrix();
    translate(width/2, height/2, 0.0);
    colorMode(HSB);
    fill(hVal, 255, 255);
    colorMode(RGB);
    rotateY(spin);
    strokeWeight(2);
    stroke(amplitude*10);
    box(cubeSize+(amplitude/3));
  
    popMatrix();
    
  }
  
  
  void renderVisual3()
  {
   
   tint(255, 255, 255, 254);

   strokeWeight(w/2);
   
   //colorMode(HSB);
   stroke(amplitude*5);
   //colorMode(RGB);
    
    //draw lines with spacing from bottom of screen which will rise up in accordance with the frequencys
    //w=(width/fft.avgSize())+10
   line((c*w)+(w/2), height-50, (c*w)+(w/2), (height-amplitude*2)-50);
    
    
  }

}