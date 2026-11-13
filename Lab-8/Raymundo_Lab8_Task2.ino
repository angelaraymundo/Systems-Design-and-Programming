// Task 2: Differential DC Voltage Measurement (A0 and A1)
#include <Wire.h>
#include <LiquidCrystal_I2C.h>

LiquidCrystal_I2C lcd(0x27, 16, 2);

int probe1 = A0;
int probe2 = A1;

void setup() {
  pinMode(probe1, INPUT);
  pinMode(probe2, INPUT);
  lcd.init();
  lcd.backlight();
}

void loop() {
  // read both pins to extract raw data
  int rawdata1 = analogRead(probe1);
  int rawdata2 = analogRead(probe2);
  
  // convert both to voltage
  float voltage1 = (5.0 / 1023.0) * rawdata1;
  float voltage2 = (5.0 / 1023.0) * rawdata2;

  // calculate the voltage drop across the component
  float voltageDrop = abs(voltage1 - voltage2);

  // display on LCD
  lcd.setCursor(0, 0);
  lcd.print("Voltage: ");
  lcd.print(voltageDrop);
  lcd.print(" V   "); 

  delay(500); 
}
