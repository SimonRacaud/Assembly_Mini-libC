BITS 64

global strncmp

section .text

strncmp:
    xor rcx, rcx
_loop:
    cmp rcx, rdx
    je _end_eq 
    cmp BYTE [rdi + rcx], 0
    jne _continue
    cmp BYTE [rsi + rcx], 0
    je _end_eq

_continue
    mov r8b, [rsi + rcx]
    cmp BYTE [rdi + rcx], r8b
    jg _end_great
    jl _end_low
    
    inc rcx

    jmp _loop

_end_eq:
    mov rax, 0
    ret

_end_low:
    mov rax, -1
    ret

_end_great:
    mov rax, 1
    ret

; int strncmp(const char *s1, const char *s2, size_t n)
; {
;     for (int i = 0; s1[1] && s2[i] && i < n; i++) {
;         if (si[i] != s2[i]) {
;             return s1[i] - s2[i];
;         }
;     }
;     return 0;
; }