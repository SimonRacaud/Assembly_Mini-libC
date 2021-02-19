
%include "src/lib.asm"

BITS 64
global strlen

section .text

strlen:
    xor rax, rax ; rax = 0

    cmp BYTE [rdi], 0 ; *str == '\0' : stop
    je _strlen_stop
_strlen_loop:    
    inc rdi ; str++
    inc rax ; count++

    cmp BYTE [rdi], 0 ; *str != '\0' : loop
    jne _strlen_loop
_strlen_stop
    ret
