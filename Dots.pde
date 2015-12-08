class Dots
{ 
  int amount =100;
  //delcare arrays for holding x, y, z positons
  float []x = new  float[amount];
  float []y = new float[amount];
  float []z = new float[amount];
  
  
  //constructor
  Dots()
  {
    //fill arrays with random numbers
    for(int i= 0; i<amount; i++)
    {
      x[i]=random(-300, 300);
      y[i]=random(-300, 300);
      z[i]=random(-300, 300);
    }
    
  }
  
  
  
  void renderVisual5()
  {
   stroke(255);
   
   /*set the stroke weight to the expand(amplitude
   for the specturm effect*/
   strokeWeight(expand/4);
 
   translate(width/2, height/2);
   rotateY(frameCount/100.0);
   
    //draw dots at the random positions
    for(int i= 0; i<amount; i++)
    {
      point(x[i], y[i], z[i]);
    }
  }
}