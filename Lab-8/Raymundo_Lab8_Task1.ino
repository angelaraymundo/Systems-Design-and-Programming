// Task 1: Continuity Detector
int probePin = 2;
int ledPin = 8;

void setup() {
  pinMode(probePin, INPUT_PULLUP); // internal pull-up enabled
  pinMode(ledPin, OUTPUT);
}

void loop() {
  if (digitalRead(probePin) == LOW) {    // probes touching (it's connected to GND)
    digitalWrite(ledPin, HIGH);          // turn LED ON
  } else {                               // probes open
    digitalWrite(ledPin, LOW);           // turn LED OFF
  }
}
