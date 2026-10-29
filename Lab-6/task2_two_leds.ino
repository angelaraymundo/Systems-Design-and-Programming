#define LED1_PIN 12
#define LED2_PIN 8

#define LED1_INTERVAL 500UL
#define LED2_INTERVAL 1000UL

unsigned long prev1 = 0;
unsigned long prev2 = 0;
int led1State = LOW;
int led2State = LOW;

void setup() {
  pinMode(LED1_PIN, OUTPUT);
  pinMode(LED2_PIN, OUTPUT);
}

void loop() {
  unsigned long now = millis();

  if (now - prev1 >= LED1_INTERVAL) {
    prev1 = now;
    led1State = (led1State == LOW) ? HIGH : LOW;
    digitalWrite(LED1_PIN, led1State);
  }

  if (now - prev2 >= LED2_INTERVAL) {
    prev2 = now;
    led2State = (led2State == LOW) ? HIGH : LOW;
    digitalWrite(LED2_PIN, led2State);
  }
}
