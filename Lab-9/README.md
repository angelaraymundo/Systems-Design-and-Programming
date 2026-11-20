# CMPE-310 Lab 9: Programming the 8255 PPI
 
## Overview
 
This project programs an Intel 8255 Programmable Peripheral Interface (82C55) from 8086 GNU assembly (GAS, AT&T syntax) to drive an 8-digit 7-segment display. The program scrolls the word "SHE" back and forth across the display:
 
1. **8255 Initialization** - Writes control word `0x80` to configure Port A, Port B, and Port C as Mode 0 outputs
2. **Display Multiplexing** - Lights one letter at a time (S, H, E) by sending its segment pattern to Port B and an active-low digit select to Port A, repeating fast enough that all three letters appear lit
3. **Scrolling** - Moves the starting digit between dig-2 and dig-7, reversing direction at each end so "SHE" bounces across the display
## Hardware Requirements
 
* 8086-based system (or 8086 simulator) with I/O port access
* 8255 / 82C55 PPI decoded at I/O address `0x640`
* 8-digit 7-segment display interface (Figure A of the lab handout)
* GNU assembler (`as`) for assembling the source
## Circuit Wiring
 
| 8255 Register | I/O Address | Function |
|---|---|---|
| Port A | `0x640` | Digit select (active-low, PNP transistors) |
| Port B | `0x641` | Segment data (active-high, NPN transistors) |
| Port C | `0x642` | Unused |
| Control | `0x643` | Mode and direction control word |
 
* **Port B:** B0-B6 drive segments a-g; B7 is not connected
* **Port A:** A0-A7 select dig-0 (rightmost) through dig-7 (leftmost); writing a 0 turns a digit on, `0xFF` blanks the display
### Segment Patterns (Port B)
 
| Letter | Segments | Byte |
|---|---|---|
| S | a, c, d, f, g | `0x6D` |
| H | b, c, e, f, g | `0x76` |
| E | a, d, e, f, g | `0x79` |
 
## How to Use
 
1. **Assemble:** `as -o lab9.o lab9.s`
2. **Inspect (optional):** `objdump -d -M i8086 lab9.o` to view the generated machine code
3. **Run:** Load the program on an 8086 system or simulator with the display at `0x640`. The word "SHE" appears at the right side of the display, scrolls left until "S" reaches dig-7, then scrolls back right until "E" reaches dig-0, and repeats
The program uses `out` instructions to access I/O ports and 16-bit code, so it cannot be executed as a normal Linux program; assembling it only checks the syntax.
 
## Register Usage
 
| Register | Purpose |
|---|---|
| AL | 8-bit data sent to the 8255 |
| BL | Segment pattern for S, H, or E |
| DX | I/O port address |
| SI | Starting position of SHE |
| BP | Movement direction (+1 or -1) |
| DI | Counts how many times to refresh the display |
| CX | Digit position or delay count |
| CL | Lower 8 bits of CX, used for shifting |
 
## Timing
 
* Each digit is lit for about 1 ms (`DELAY = 300`, based on an assumed 5 MHz 8086 where `LOOP` takes 17 clocks)
* Each scroll step refreshes the display 100 times (`FRAMES = 100`, about 0.3 s)
* Both constants can be adjusted for a different clock speed
## References
 
* Brey, Barry, *Intel Microprocessors: Architecture, Programming, and Interfacing*, 8th Edition, Pearson, 2009 (Chapter 11, Examples 11-9 and 11-10)
* Intel Corporation, *Intel 8255A/8255A-5 Programmable Peripheral Interface Specification*, August 1991
