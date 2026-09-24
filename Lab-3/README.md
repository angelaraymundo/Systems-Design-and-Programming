# CMPE 310 - Project 2/Lab 3: Hamming Distance

## Description
This is an x86-64 assembly language program that calculates the Hamming distance between two user inputted strings. The Hamming distance is defined as the number of bit positions where the two strings differ. If the length of the two strings are unequal, the program will calculate the Hamming distance using the length of the shorter string.

## Requirements
* Linux environment
* GNU Assembler (`as`)
* GNU Linker (`ld`)

## How to Compile and Run
1. Open a terminal in the directory containing `hammingdistance.s`.
2. Assemble the code: 
   ```bash
   as -o hamming.o hammingdistance.s
3. Run using ./hamming