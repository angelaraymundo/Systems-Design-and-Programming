#define LED_PIN 12

void setup() {
  pinMode(LED_PIN, OUTPUT);
}

void loop() {
  digitalWrite(LED_PIN, HIGH);
  delay(500);   // on 0.5 s
  digitalWrite(LED_PIN, LOW);
  delay(500);   // off 0.5 s  -> one full blink per second
}
