.section .bss
.globl ram
.lcomm ram, 256

.section .text
.globl fill_ram

fill_ram:
    # Clear RAM locations from 0x50 to 0x58
    lea ram+0x50, %rbx
    mov $9, %rcx

clear_loop:
    movb $0x00, (%rbx)
    incq %rbx
    decq %rcx
    jne clear_loop
    ret

.section .note.GNU-stack,"", @progbits  