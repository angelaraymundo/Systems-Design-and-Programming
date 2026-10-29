# CMPE 310 - Lab 6: Arduino External LED Blink and Asynchronous Timing

## Description
This lab demonstrates microcontroller programming using an Arduino Uno. It covers wiring LEDs in series with 330 Ω current-limiting resistors, configuring digital I/O pins, and implementing both basic blocking delays and advanced non-blocking asynchronous timing loops via `millis()` to control multiple LEDs at independent intervals.

## Files in Folder
- `task1_blink.ino`: The Arduino program that blinks a single external LED once per second using basic delays.
- `task2_two_leds.ino`: The Arduino program utilizing `millis()` to control two LEDs asynchronously at different blink rates (500ms and 1000ms intervals).
- `README.md`: Project documentation and submission instructions.

## How to Compile and Upload
1. Open the Arduino IDE on your computer.
2. Connect your Arduino Uno via a USB A to B cable and select your board and port from the **Tools** menu.
3. Open either sketch (`.ino`), verify the code, and click the **Upload** button to send it to the microcontroller.
