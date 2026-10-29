// Voltage Measurement using Arduino UNO - Case 1

#include <LiquidCrystal_I2C.h>
#include <Wire.h>

LiquidCrystal_I2C lcd(0x27, 16, 2);   // try 0x3F if blank

int voltageV = A0;   // it is the input pin

void setup() {
  pinMode(voltageV, INPUT);
  lcd.init();
  lcd.backlight();
}

void loop() {
  int VoltageMsmt = analogRead(voltageV);
  float Vcalc = (5.0 / 1023) * VoltageMsmt;
  Vcalc = Vcalc * 2.0;   // theoretical (10k+10k)/10k; replace with your calibrated value

  lcd.setCursor(0, 0);
  lcd.print("BATT ");
  lcd.print(Vcalc);
  lcd.print(" V   ");   // spaces clear leftover digits
  
  delay(500);  // Added to stabilize screen fluctuations
}