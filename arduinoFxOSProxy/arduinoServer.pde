import processing.serial.*;
import processing.net.*;

Server server;
Client client;
Serial arduino;
int portNumber = 9750;
void setup() {
  size(500, 500);
  String portName = Serial.list()[5];
  println(portName);
  arduino = new Serial(this, portName, 9600);
  server = new Server(this, portNumber);
}

void draw() {
  client = server.available();
  if (client != null) {
    background(255);
    if (client.available () > 0) {
      String buf = client.readString();
      if (buf != null)println(buf);
      if (buf != null)arduino.write(buf);
      background(120);
    }
    if (arduino.available() > 0) {
      print("arduino------  ");
      String buf = arduino.readString();
      println(buf);
      background(0);

      if (client != null) {
        println("===========");
        client.write(buf);
        client.write("\r\n\r\n");
      }
    }
  }
  background(0);
}

