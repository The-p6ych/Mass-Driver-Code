float Inital_Delay = 0.2;
float Delay_Multi = 0.5;
float Delay_Time = Inital_Delay;

void setup() {
  Serial.begin(9600);
  
  // Define a float array named Prox of size 6
  float Prox[6];
  
  // Initialize each value in the Prox array, Prox[0] to Prox[5], to 1020
  for (int i = 0; i < 6; i++) {
    Prox[i] = 1020.0;
  }
  
  // Set pins 2 to 7 to output
  for (int pin = 2; pin <= 7; pin++) {
    pinMode(pin, OUTPUT);
    digitalWrite(pin, LOW); // Write LOW (0) to pins 2,3,4,5,6,7
  }

  // Set pins A0 to A5 to input
  for (int pin = A0; pin <= A5; pin++) {
    pinMode(pin, INPUT);
  }
}

void loop() {
  float Prox[6]; // Ensure Prox array is defined in the loop if not global
  bool allLow = true; // Flag to check if all values in Prox are LOW
  
  // Repeat loop for i = 0 to 5
  for (int i = 0; i < 6; i++) {
    digitalWrite(i + 2, HIGH); // Write HIGH (1) to pin i+2
    
    while (true) { // Repeat until the condition is met
      Prox[i] = analogRead(A0 + i); // Read pin A-i and store the value in Prox-i
      
      if (Prox[i] < 500) { // If Prox-i is smaller than 500
        Delay_Time = Delay_Time * Delay_Multi;
        delay(Delay_Time); // Wait
        digitalWrite(i + 2, LOW); // Write LOW (0) to pin i+2
        break; // Exit the inner loop and increment i in the outer loop
      }
    }
  }
  
  // Check if all values in Prox array are LOW
  for (int i = 0; i < 6; i++) {
    if (Prox[i] >= 500) {
      allLow = false;
      break;
    }
  }
  
  if (allLow) {
    Serial.println("All values in the Proximity array have been changed to LOW. Terminating program.");
    while (true); // Terminate the program by entering an infinite loop
  }
}
