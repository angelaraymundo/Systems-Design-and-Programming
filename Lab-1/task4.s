.section .bss
.globl ram
.lcomm ram, 256

.section .text
.globl fill_ram

fill_ram:
    # Series 1+2+...+N where N=10,
    mov $10, %rcx #loop counter to 10
    xorb %al, %al #clear AL to 0
    movb $1, %bl #start adding from 1

sum_loop:
    addb %bl, %al 
    incb %bl
    decq %rcx
    jne sum_loop

    movb %al, ram+0x50
    ret

.section .note.GNU-stack,"", @progbits  
    
