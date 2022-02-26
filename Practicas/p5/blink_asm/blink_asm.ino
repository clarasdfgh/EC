/*
  Blink

  Turns an LED on for one second, then off for one second, repeatedly.

  Most Arduinos have an on-board LED you can control. On the UNO, MEGA and ZERO
  it is attached to digital pin 13, on MKR1000 on pin 6. LED_BUILTIN is set to
  the correct LED pin independent of which board is used.
  If you want to know what pin the on-board LED is connected to on your Arduino
  model, check the Technical Specs of your board at:
  https://www.arduino.cc/en/Main/Products

  modified 8 May 2014
  by Scott Fitzgerald
  modified 2 Sep 2016
  by Arturo Guadalupi
  modified 8 Sep 2016
  by Colby Newman

  This example code is in the public domain.

  http://www.arduino.cc/en/Tutorial/Blink
*/

void my_delay(uint16_t ms);

#define CPU_FREQUENCY 16000000UL
uint16_t delay_count = CPU_FREQUENCY / 4000;

// the setup function runs once when you press reset or power the board
void setup() {
  // initialize digital pin LED_BUILTIN as an output.
  // pinMode(LED_BUILTIN, OUTPUT);
  asm volatile (
    "sbi %0, %1 \n"
    : : "I" (_SFR_IO_ADDR(DDRB)), "I" (DDB7)
  );
}

// the loop function runs over and over again forever
void loop() {
  // digitalWrite(LED_BUILTIN, HIGH);// turn the LED on (HIGH is the voltage level)
  // digitalWrite(13         , HIGH);// turn the LED on (HIGH is the voltage level)

  asm volatile (
    "sbi %0, %1 \n"
    : : "I" (_SFR_IO_ADDR(PORTB)),"I" (PORTB7)
  );

  my_delay(100);   // wait for 10 ms   MODIFICADO A 100

  // digitalWrite(LED_BUILTIN, LOW); // turn the LED off by making the voltage LOW
  // digitalWrite(13         , LOW); // turn the LED off by making the voltage LOW

  asm volatile (
    "cbi %0, %1 \n"
    : : "I" (_SFR_IO_ADDR(PORTB)),"I" (PORTB7)
  );

  my_delay(1000);  // wait for 990 ms  MODIFICADO A 1000
}

void my_delay(uint16_t ms) {
  uint16_t cnt;

  asm volatile (
                      "\n"
    "loop_ms:"        "\n\t"
      "mov %A0, %A2"  "\n\t"
      "mov %B0, %B2"  "\n"

    "loop_cnt:"       "\n\t"
      "sbiw %A0, 1"   "\n\t"
      "brne loop_cnt" "\n\t"

      "sbiw %1,  1"   "\n\t"
      "brne loop_ms"  "\n\t"
 
    : "=&w" (cnt)
    : "w" (ms), "r" (delay_count)
  );
}
