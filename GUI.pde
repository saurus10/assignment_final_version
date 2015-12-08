class GUI
{
  //delcare fields
  int bNumbers;
  //PVector for holding x and y position of visual buttons
  PVector button = new PVector();
  int buttonSize;
  float bPosX;
  float bPosY;
  
  //constructor
  GUI()
  {  //intiliaze fields
     buttonSize = 20;
     bPosX=(width/2)+100;
     bPosY= height-15;
     
     buttonW = 80;
     buttonH = 20;
     buttonX = (width/2)-125;
     buttonY = height-25;
    
  }
  
  
  
  void setValues()
  {
   
    
  
    //from 0 move 250 over and then every 40 pixels draw a button
    button.x = bPosX + ((bNumbers) * 40);
    button.y = bPosY;
    
    
   }

  
  void displayButtons()
  { 
    //display visual buttons
    if(currVisual == bNumbers)
    {
      //draw buttons with fill if button selected
     fill(255);
     ellipse(button.x, button.y, buttonSize, buttonSize);
     fill(255);
     text(bNumbers, button.x-4, button.y+4);
     }
     else
     {
     noFill();
     strokeWeight(0.7);
     stroke(28,245,87);
     ellipse(button.x, button.y, buttonSize, buttonSize);
     fill(255);
     text(bNumbers, button.x-4, button.y+4);
     }
     
     //display load song button
     fill(41, 237, 15);
     rect(buttonX, buttonY, buttonW, buttonH, 7);
     fill(245, 31, 7);
     textAlign(LEFT);
     text("Load Song", buttonX+10, buttonY+14);
     noFill();
     
     
    
    int maxBin = -1;
    float maxValue = -1;
    float bass = 0;
    
    //calculate the frequecny and bass of each band
    for (int i = 0; i < fft.specSize (); i ++)
    {
      if (i  < 3)
      {
        bass += fft.getBand(i);
      }
      if (fft.getBand(i) > maxValue)
      {
        maxValue = fft.getBand(i);
        maxBin = i;
      }
     
    }

    float binWidth = 86;
    text("Frequency: " + binWidth * maxBin, 10, height-22);
    text("Bass: " + bass, 10, height-10);
    text("Select Visual", (width/2)+30, height-10);
    //displays song name 
    fill(72, 245,104);
    text(meta.fileName(), 10, 15);
    fill(236, 245, 7);
    text("Hit space to ||/Play", width-150, 20);
    
   }//end method
    
}
//end class