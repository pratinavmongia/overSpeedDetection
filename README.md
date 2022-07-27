# overSpeedDetection

This device is made to check overspeeding using GPS coordinates.

Advantages
1. Doesn't require costly hardware.
2. Rule enforcement throughout the country rather than in selective cities.
3. GPS data can be used for other use cases also like charging a congestion charge,distance travelled based toll charge etc.



Working

GPS calibration file extracts data from GPS sensor and puts the data in the serial output. 
Processing is used to extract GPS data,speed,date and time from Serial Output and pass that data into a csv file. 
Python then extracts the data from the csv file and figures out the street using the reverse geocoding API(MapmyIndia). It then compares the speed limit of the vehicle with that of the database and checks for overspeeding. 

References
https://www.youtube.com/watch?v=TCPeZ3--Kd4&list=WL&index=1&t=58s

Powerpoint presentation credits Jainil Shah https://www.linkedin.com/in/jainil-shah-30873b20a/
