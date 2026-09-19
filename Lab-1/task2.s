.section .bss
.globl ram
.lcomm ram, 256

.section .text
.globl fill_ram

fill_ram:
    # 0xFF into RAM positions 0x50 through 0x58 w/ indirect addressing
    lea ram+0x50, %rbx
    mov $9, %rcx

loop_label:
    movb $0xFF, (%rbx)
    incq %rbx
    decq %rcx
    jne loop_label
    ret

.section .note.GNU-stack,"", @progbits