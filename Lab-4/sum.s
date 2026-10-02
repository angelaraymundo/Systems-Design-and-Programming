.section .text
    .globl sum_array      # make function visible to C program

sum_array:
    mov $0, %eax        # initialize sum (return value) to 0 using immediate addressing
    cmp $0, %rsi        # compare count with 0
    je end_loop         # jump to end if count is zero (Z=1)

sum_loop:
    # Add value at memory address in %rdi to %eax using register indirect addressing
    addl (%rdi), %eax     
    
    add $4, %rdi         # advance pointer by 4 bytes (size of int) to the next array element
    decq %rsi            # decrement the loop counter
    jne sum_loop          # If count != 0, jump back to sum_loop

end_loop:
    ret                   # return control back to C program

.section .note.GNU-stack,"",@progbits
