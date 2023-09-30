#include <WiFi.h>
#include <HTTPClient.h>

#include "DHT.h"

#define DHTPIN 25   // Digital pin connected to the DHT sensor (GPIO34)
#define DHTTYPE DHT11   // DHT 22 (AM2302), AM2321

#define AOUT_PIN  32  // ESP32 pin GPIO36 (ADC0) that connects to AOUT pin of moisture sensor
#define THRESHOLD 5000 // Change your threshold here


const int pumpControlPin = 33; // GPIO 32
const int moistureThreshold = 5000;
const int pumpRunTime = 10000; // Run the pump for 10 seconds (10000 milliseconds)


DHT dht(DHTPIN, DHTTYPE);


const char* ssid = "KU-Hackfest";
const char* password = "hackfest@2023";

//Your Domain name with URL path or IP address with path
String serverName = "http://3153-202-166-219-119.ngrok.io/update_sensor";

// the following variables are unsigned longs because the time, measured in
// milliseconds, will quickly become a bigger number than can be stored in an int.
unsigned long lastTime = 0;
unsigned long timerDelay = 5000;

void setup() {
  Serial.begin(115200); 
  dht.begin();
  WiFi.begin(ssid, password);
  Serial.println("Connecting");
  while(WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("");
  Serial.print("Connected to WiFi network with IP Address: ");
  Serial.println(WiFi.localIP());
 
  Serial.println("Timer set to 5 seconds (timerDelay variable), it will take 5 seconds before publishing the first reading.");
  
  pinMode(pumpControlPin, OUTPUT);
  pinMode(AOUT_PIN, INPUT);
  digitalWrite(pumpControlPin, LOW); // Initialize the relay to be off (active low)
}

void loop() {
  
  
  //Send an HTTP GET request every 10 minutes
  if ((millis() - lastTime) > timerDelay) {
    //Check WiFi connection status
    if(WiFi.status()== WL_CONNECTED){
// Reading temperature or humidity takes about 250 milliseconds!
  // Sensor readings may also be up to 2 seconds 'old' (it's a very slow sensor)
  float h = dht.readHumidity();
  float t = dht.readTemperature();
  float f = dht.readTemperature(true);

  int moistureValue = analogRead(AOUT_PIN);

  if (isnan(h) || isnan(t) || isnan(f)) {
    Serial.println(F("Failed to read from DHT sensor!"));
    return;
  }

  if (moistureValue < THRESHOLD)
    Serial.print("The soil is DRY (");
  else
    Serial.print("The soil is WET (");

  Serial.print("Moisture Value: ");
  Serial.print(moistureValue);
  Serial.println(")");

  Serial.print(F("Humidity: "));
  Serial.print(h);
  Serial.print(F("%  Temperature: "));
  Serial.print(t);
  Serial.print(F("°C "));
  Serial.print(f);
  Serial.print(F("°F"));

  float hif = dht.computeHeatIndex(f, h);
  float hic = dht.computeHeatIndex(t, h, false);

  Serial.print(F("  Heat index: "));
  Serial.print(hic);
  Serial.print(F("°C "));
  Serial.print(hif);
  Serial.println(F("°F"));
  if (moistureValue < moistureThreshold) {
    // Soil is too dry, turn on the pump
    digitalWrite(pumpControlPin, LOW); // Activate the relay (active low)
    delay(pumpRunTime); // Run the pump for 10 seconds
    digitalWrite(pumpControlPin, HIGH); // Deactivate the relay (active low)
  }

  delay(5000); // Delay for a while before checking moisture again
  

      
      HTTPClient http;

      String serverPath = serverName + "?temperature="+t+"&humidity="+h+"&heatindex="+hic+"&moisturevalue="+moistureValue;
      Serial.println(serverPath);
      // Your Domain name with URL path or IP address with path
      http.begin(serverPath.c_str());
      
      // If you need Node-RED/server authentication, insert user and password below
      //http.setAuthorization("REPLACE_WITH_SERVER_USERNAME", "REPLACE_WITH_SERVER_PASSWORD");
      
      // Send HTTP GET request
      int httpResponseCode = http.GET();
      
      if (httpResponseCode>0) {
        Serial.print("HTTP Response code: ");
        Serial.println(httpResponseCode);
        String payload = http.getString();
        Serial.println(payload);
      }
      else {
        Serial.print("Error code: ");
        Serial.println(httpResponseCode);
      }
      // Free resources
      http.end();
    }
    else {
      Serial.println("WiFi Disconnected");
    }
    lastTime = millis();
  }
}
