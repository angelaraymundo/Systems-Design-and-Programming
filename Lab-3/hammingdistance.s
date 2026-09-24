.global _start

.section .data
prompt1: .ascii "Enter first string: "
prompt1_len = . - prompt1
prompt2: .ascii "Enter second string: "
prompt2_len = . - prompt2
result_msg: .ascii "Hamming distance: "
result_msg_len = . - result_msg

.section .bss
str1: .space 255
str2: .space 255
outbuf: .space 16

.section .text
_start:
    
    # --- I/O phase: System Calls ---
    mov $1, %rax           # write syscall
    mov $1, %rdi           # std out
    mov $prompt1, %rsi
    mov $prompt1_len, %rdx
    syscall

    mov $0, %rax           #read syscall
    mov $0, %rdi            #stdin
    mov $str1, %rsi
    mov $255, %rdx         # max length
    syscall
    mov %rax, %r8          # save length - string 1

    mov $1, %rax
    mov $1, %rdi
    mov $prompt2, %rsi
    mov $prompt2_len, %rdx
    syscall

    mov $0, %rax
    mov $0, %rdi
    mov $str2, %rsi
    mov $255, %rdx
    syscall
    mov %rax, %r9           #save length of string 2

    # --- Control Flow Phase ---
    cmp %r9, %r8
    jbe set_len             #jump if below or equal (Z=1 or C=1)
    mov %r9, %r8

set_len:
    dec %r8            #dec instruction
    mov %r8, %rcx        # set RCX for the loop instruction
    xor %r12, %r12       # clear distance accumulator
    
    cmp $0, %rcx       # compare the string length in rcx length to 0 
    je print_result    # jump if (Z==1) prevents crashing if the strings are empty

    mov $str1, %rsi
    mov $str2, %rdi

hamming_loop:
    movb (%rsi), %al
    movb (%rdi), %bl
    xor %bl, %al            # XOR operation to map differences

    mov $8, %r10

bit_count_loop:
    shr $1, %al           # logical shift right - inserts 0
    adc $0, %r12          #adds register + carry flag
    dec %r10
    jne bit_count_loop    # Jump if != (Z=0)

    inc %rsi              # inc instruction for pointers
    inc %rdi
    
    loop hamming_loop     #combination of decrement ecx and jnz

print_result:
    mov $1, %rax
    mov $1, %rdi
    mov $result_msg, %rsi
    mov $result_msg_len, %rdx
    syscall

    mov %r12, %rax
    mov $10, %rbx
    mov $outbuf+15, %rsi
    movb $'\n', (%rsi)
    dec %rsi
    mov $1, %rcx

convert_loop:
    xor %rdx, %rdx
    div %rbx           # unsigned division, remainder goes to RDX
    add $48, %dl
    movb %dl, (%rsi)
    dec %rsi
    inc %rcx
    cmp $0, %rax
    jne convert_loop      # Jump if != (Z=0)

    inc %rsi

    mov $1, %rax          #write syscall
    mov $1, %rdi
    mov %rcx, %rdx
    syscall

    mov $60, %rax
    xor %rdi, %rdi
    syscall