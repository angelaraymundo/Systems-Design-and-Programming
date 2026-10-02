# CMPE 310 - Lab 4: Assembly Array Summation

## Description
This lab demonstrates how to integrate C into x86-64 Assembly. A C wrapper reads a set of integers from a text file specified via the command line, dynamically allocates memory to hold them, and passes the array to an assembly function. The assembly function sums the integers and returns the total to the C program for printing.

## Files in folder
* `main.c`: The C program that handles command-line arguments, file I/O, and memory allocation.
* `sum.s`: The x86-64 AT&T syntax assembly program that computes the sum of the array.
* `data.txt`: Sample input file provided via Blackboard.

## How to Compile and Run
1. Run the following command in the terminal: 
   ```bash
   gcc -no-pie sum.s main.c -o lab4
2. Run using ./lab4 data.txt