/*Stephen McGirr
  C14730095
  7/12/2015
  Audio visualiser
  and MP3 player*/
  



import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

//set variable to file name
String fname = "gui.csv";
String [] data;
//Create Array list of type GUI(the object) called buttons 
ArrayList<GUI> buttons = new ArrayList<GUI>();
int currVisual=1;




void setup()
{
  
  
  size(640, 480, P3D);
  smooth();
  //fullScreen(P3D);
  
  //intialize mimim object
  minim = new Minim(this);
  // specify 2048 for the length of the sample buffers
  song = minim.loadFile("Skrillex - Puppy.mp3", 2048);
  meta = song.getMetaData();
  song.play();
  
  /*intializa FFT object
  get length of audio buffers
  get the sample rate of audio*/
  fft = new FFT(song.bufferSize(), song.sampleRate());
  
  //Use log averags to space the frequencys 
  fft.logAverages(60, 7);
 
   background(0);
   
   /*for setting a stroke weight on visual 3(line)
   creates a bar effect of the lines */
   w = (width/fft.avgSize())+10;
   

  //initiallize objects
  cubes = new Cube[amount];
  visual = new Visual();
  dots = new Dots();
   
  for(int j=0; j < amount; j++)
  {
    cubes[j] = new Cube();
  }
  
  //call method
  processData();
    
}

//delcare minim object for controlling control the library
Minim minim;

AudioPlayer song;
AudioMetaData meta;
/*Create FFT(Fast Fourier transform) object. Splits a soundwave into a selection of bands for telling what the volume 
of different frequenceys in the sound signal are*/
FFT fft;

//Delcare classes and instances 
Visual visual;
Dots dots;
Cube [ ] cubes;

//amount of cubes
int amount=30;
//amplitude will equal average band 
float amplitude;
int w;
int c;
float expand;

//variables for GUI
float buttonX;
float buttonY;
float buttonW;
float buttonH;

void draw()
{
  
  
  
  
  background(0);
  
  // call method for displaying GUI
  for(GUI g : buttons)
  {
    g.displayButtons();
  }
  
  /*This mixes the left and right 
  channels of the audio input
  and performs the fft*/
  fft.forward(song.mix);
  
  
  switch(currVisual)
  {
    case 1:
    { 
      //iterate through the entire array of bands
      for(int i = 0; i<fft.avgSize(); i++)
      { 
       c=i;
       /*set amplidtude to the average bandwidth with a manipulation to
       to make the visual more befitting of the screen*/
       amplitude =((fft.getAvg(i)*4)/3);
       //call visual 3
       visual.renderVisual3();
      }
    break;
    }
    case 2:
    { //call update method to control behaviour of the visual
      visual.update();
      for(int i = 0; i<fft.avgSize(); i++)
      { 
      amplitude =((fft.getAvg(i)*4)/3);
      visual.renderVisual();
      }
    break;
    }
    case 3:
    {
      visual.update();
      for(int i = 0; i<fft.avgSize(); i++)
      { 
      c=i;
      amplitude =((fft.getAvg(i)*4)/3);
      visual.renderVisual2();
      }
    break;
    }
    case 4:
    {
      //iterate through all cubes to apply behaviour
      for(int j=0; j<cubes.length; j++)
      {
        cubes[j].update();
        for(int i = 0; i<fft.avgSize(); i++)
        { 
        amplitude =((fft.getAvg(i)*4)/3);
        cubes[j].renderVisual4();
        }
      }
    break;
    }
    case 5:
    {
      for(int i = 0; i<fft.avgSize(); i++)
      { 
      expand=fft.getAvg(i)*4;
      dots.renderVisual5();
      }
    break;
    }
  }//end switch
  
}



void mouseReleased()
{
  for(GUI g : buttons)
  { /*if mouse is in the bounds of the visual button update the currVisual 
     variable for use in the switch statement*/
    if(dist(mouseX, mouseY, g.button.x, g.button.y) < g.buttonSize/2)
    {
      currVisual = g.bNumbers;
    }
  }
}

void processData()
{
 
  data = loadStrings(fname);
  for(int i=0; i<data.length; i++)
  {
    // initialize GUI class
    GUI g = new GUI();
    String [] row = split(data[i], ",");
    g.bNumbers = int(row[0]);
    
    //save in collection of button objects (the array list)
    buttons.add(g);
  }
  
  //call the method
  for(GUI g : buttons)
  {
    g.setValues();
  }
  
  
}

void mouseClicked() 
{
  //if mouse is clicked withing the bounds of the button  allow user to select song
  if (mouseX>buttonX && mouseX < buttonX+buttonW && mouseY > buttonY && mouseY < buttonY+buttonH) 
  {
    selectInput("Import music file", "fileSelected");
  }
}


void fileSelected(File selection) 
{
  if (selection == null) 
  {
    println("Window was closed or user hit cancel");
  } 
  else 
  { 
    song.pause();
    //load new song into song about and resume play
    song = minim.loadFile(selection.getAbsolutePath(), 2048);
    song.play();
    println("User selected " + selection.getAbsolutePath());
  }
  
}

void keyPressed()
{
  if ( song.isPlaying() )
  {
    song.pause();
  }
  else
  {
    // simply call loop again to resume playing from where it was paused
    song.loop();
  }
}