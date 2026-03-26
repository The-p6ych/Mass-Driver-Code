const int delayTime = 5000;

const int threshold = 200;

const int stages = 1;
const int maxStages = 5;
int currentPin = maxStages - stages;

int sensor1;
int sensor2;
int sensor3;
int sensor4;
int sensor5;

void setup() {
  //Serial.begin(9600);
  //Serial.println("Program Activated. Power in 5 seconds ");

  for (int pin = 2; pin <= 6; pin++) {
    pinMode(pin, OUTPUT);
    digitalWrite(pin, LOW);
  }

  for (int pin = A0; pin <= A3; pin++) {
    pinMode(pin, INPUT);
  }

  delay(delayTime);
  //Serial.println("Starting first coil.");
  digitalWrite(currentPin + 2, HIGH);
}

void loop() {
  if (currentPin < maxStages) {

    sensor1 = analogRead(A0);
    sensor2 = analogRead(A1);
    sensor3 = analogRead(A2);
    sensor4 = analogRead(A3);
    sensor5 = analogRead(A4);

    int sensorValue = analogRead(A0 + currentPin);

    // Serial.print(currentPin);

    // Serial.print(" ");
    // Serial.print(String(sensor1));
    // Serial.print(" ");
    // Serial.print(String(sensor2));
    // Serial.print(" ");
    // Serial.print(String(sensor3));
    // Serial.print(" ");
    // Serial.print(String(sensor4));
    // Serial.println();
    

    if (sensorValue > threshold) {

        delayMicroseconds(delayTime);
        digitalWrite(currentPin + 2, LOW);
        //Serial.print("Coil ");
        //Serial.print(String(currentPin));
        //Serial.println(" deactivated.");
        currentPin++;
        digitalWrite(currentPin + 2, HIGH);
        //Serial.print("Coil ");
        //Serial.print(String(currentPin));
        //Serial.println(" activated.");
      }
  } 
  else {
    digitalWrite(currentPin + 2, LOW);
    //Serial.println("All coils deactivated, terminating program.");
    while (true);
  }
}
