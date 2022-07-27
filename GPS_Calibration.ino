#include <TinyGPS.h>
#include <SoftwareSerial.h>
TinyGPS gps;

SoftwareSerial gps_port(2,3);

void setup()
{
  Serial.begin(115200);
  gps_port.begin(4800);
  delay(2000);
}

void getgps(TinyGPS &gps)
{
 float latitude, longitude;
 unsigned long fix_age,time,date;

 gps.f_get_position(&latitude, &longitude);
// Serial.print("GPS Location: ");  
 Serial.print(latitude,6);
 Serial.print(",");
 Serial.print(longitude,6); 
 Serial.println(",");

// Serial.print("Speed: ");
 Serial.print(gps.f_speed_kmph());
 Serial.print(", ");
// Serial.print("Current Date & Time: ");
 gps.get_datetime(&date, &time, &fix_age);
 Serial.print(date);
 Serial.print(",");
 Serial.println(time);
 delay(1000);
}
void loop()
{
  for (unsigned long start = millis(); millis() - start < 1000;)
  {
    while (gps_port.available())
    {
      char a = gps_port.read();
//       Serial.print(a); 
      if(gps.encode(a)) 
       {
        getgps(gps); 
       }
    }
  }
} 
