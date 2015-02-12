// Wire Slave Sender
// by Nicholas Zambetti <http://www.zambetti.com>

// Demonstrates use of the Wire library
// Sends data as an I2C/TWI slave device
// Refer to the "Wire Master Reader" example for use with this

// Created 29 March 2006

// This example code is in the public domain.


#include <Wire.h>
int XX;

void setup()
{
  Wire.begin(15);                // join i2c bus with address #2
  Wire.onRequest(requestEvent); // register event
  Wire.onReceive(receiveEvent); // register event

  Serial.begin(115200);  
}

boolean receiveI2CReq  =  0;
boolean ESPDetect      =  0;

void loop()
{
//  delay(10);
  if (receiveI2CReq == 1)
  {
    Serial.println("Request received!");
    receiveI2CReq=0;
  }
  if (ESPDetect == 1)
  {
    Serial.println("\t\t\t\t\t\tRecieved data from ESP8266!");
    ESPDetect=0;
  }
  
}

// function that executes whenever data is requested by master
// this function is registered as an event, see setup()
void requestEvent()
{
  String str1="hello ";
  str1 += XX;
  char charbuf[10];
  str1.toCharArray(charbuf, 10);
  Wire.write(charbuf);  // respond with message of 6 bytes
  // as expected by master
  receiveI2CReq=1;
}
String STR1="";
void receiveEvent(int howMany)
{
//  while(Wire.available())
  while(1 < Wire.available()) // loop through all but the last
  {
    char c = Wire.read(); // receive byte as a character
    STR1 += c;
  }
  if (STR1=="ESP8266 ")
  {
    ESPDetect=1;
    XX=Wire.read();
    while(Wire.available())
    {
     byte tmp=Wire.read();  
    }
    STR1="";
  return;  
  }
  Serial.print("\r"+STR1); 
  STR1="";
  //Serial.println();
  int x = Wire.read();    // receive byte as an integer
  Serial.println(x);         // print the integer
}

