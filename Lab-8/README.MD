# CMPE-310 Lab 9: Continuity Detector and DC Voltage Meter

## Overview
This project transforms an Arduino UNO into a dual-function electrical testing tool. It consists of two main tasks:
1. **Task 1: Continuity Detector** - Uses digital I/O and the Arduino's internal pull-up resistor to safely check for closed electrical paths, indicating continuity with an LED
2. **Task 2: DC Voltage Meter** - Uses dual analog inputs (A0 and A1) to perform differential DC voltage measurements across components in a 5V circuit, displaying the calculated voltage drop on an I2C 16x2 LCD

## Hardware Requirements
* Arduino UNO R3
* 16x2 I2C LCD Display
* 1x LED
* 1x 330 Ω Resistor (for LED current limiting)
* Solderless Breadboard
* Jumper Wires (acting as test probes)

## Circuit Wiring
### Task 1: Continuity Detector
* **Probe 1:** Connected to Digital Pin 2 (`INPUT_PULLUP`)
* **Probe 2:** Connected to GND
* **Indicator LED:** Anode connected to Digital Pin 13 via a 330 Ω resistor; Cathode connected to GND

### Task 2: Differential DC Voltage Meter
* **I2C LCD Display:** 
  * `GND` -> Arduino GND
  * `VCC` -> Arduino 5V
  * `SDA` -> Arduino A4
  * `SCL` -> Arduino A5
* **Positive Probe:** Connected to Analog Pin A0
* **Negative Probe:** Connected to Analog Pin A1

## How to Use
1. **Continuity Testing (Task 1):** Touch the Pin 2 probe and the GND probe together. The circuit closes, pulling Pin 2 `LOW`, which triggers the Pin 13 LED to turn ON. Separating the probes returns Pin 2 to `HIGH`, turning the LED OFF.
2. **DC Voltage Measurement (Task 2):** Power an external test circuit (e.g., an LED and resistor in series connected to 5V and GND). Touch the A0 probe to the higher voltage side of a component and the A1 probe to the lower voltage side. The absolute voltage drop across that specific component will be calculated and displayed on the I2C LCD.

## Libraries Used
* `<Wire.h>` - Handles the I2C communication protocol.
* `<LiquidCrystal_I2C.h>` - Controls the 16x2 LCD display output.
