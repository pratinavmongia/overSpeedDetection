
import processing.serial.*;
Serial myPort; // software serial port creation
Table dataTable; 

int numReadings = 300;
int readingCounter = 0; 
 
String fileName,val;
void setup()
{
  String portName = Serial.list()[0]; 
  dataTable = new Table();
  
  myPort = new Serial(this, portName, 115200); //listen to the serial port
   dataTable.addColumn("Reading No.");
  dataTable.addColumn("Latitude");
  dataTable.addColumn("Longitude");
  dataTable.addColumn("Speed");
  dataTable.addColumn("Date");
  dataTable.addColumn("Time");
 

}

void serialEvent(Serial myPort){
  val = myPort.readStringUntil('\n'); //The newline separator separates each Arduino loop.
  if (val!= null) { 
    val = trim(val); //gets rid of any whitespace or Unicode nonbreakable space
    println(val); 
    float sensorVals[] = float(split(val, ',')); //parses the packet from Arduino and places the valeus into the sensorVals array.
    TableRow newRow = dataTable.addRow(); //add a row for this new reading
    newRow.setInt("Reading No.", dataTable.lastRowIndex());//record a unique identifier (the row's index)

    
    //record sensor information. 
    newRow.setFloat("Latitude", sensorVals[0]);
    newRow.setFloat("Longitude", sensorVals[1]);
    newRow.setFloat("Speed", sensorVals[2]);
    newRow.setFloat("Date", sensorVals[3]);
    newRow.setFloat("Time", sensorVals[4]);
    
    readingCounter++;
    
    //saves the table as a csv in the same folder as the sketch every numReadings. 
    if (readingCounter % numReadings ==0)
    {
      fileName = str(year()) + str(month()) + str(day()) + str(dataTable.lastRowIndex())+".csv"; 
      saveTable(dataTable, fileName); 
    }
   }
}

void draw()
{
  serialEvent(myPort);
}
