# CMPE 310 - Lab 7: Arduino Voltage Meter

## Description
This lab demonstrates how to design and develop a voltage measurement device using an Arduino UNO (ATmega328P). It utilizes a resistor-based voltage divider network to safely step down external DC test voltages so they can be read by the Arduino's 5V analog pins. The Arduino's ADC reads the attenuated voltage, scales it back to the true source voltage in software using a calibration multiplier, and outputs the result in real-time to a 16x2 I2C LCD display.

## Files in folder
- `VoltegeMeas_Case1/VoltegeMeas_Case1.ino`: The Arduino sketch configured for the two-resistor voltage divider circuit (multiplier of 2.0).
- `VoltegeMeas_Case2/VoltegeMeas_Case2.ino`: The Arduino sketch configured for the three-resistor voltage divider circuit (multiplier of 3.0).

## How to Compile and Run
1. Open the desired `.ino` file in the Arduino IDE.
2. Go to **Sketch > Include Library > Manage Libraries** and ensure the `LiquidCrystal_I2C` library is installed.
3. Wire the breadboard circuit according to the specific case:
   - **I2C LCD:** Connect VCC to 5V, GND to GND, SDA to A4, and SCL to A5.
   - **Voltage Divider:** Connect the bottom resistor to GND, apply the test voltage to the top resistor, and connect the measurement junction to pin A0.
4. Connect the Arduino UNO to your computer via USB.
5. In the Arduino IDE, select the correct Board (Arduino Uno) and COM Port from the **Tools** menu.
6. Click the **Upload** button (right arrow icon) to compile the code and flash it to the microcontroller.
