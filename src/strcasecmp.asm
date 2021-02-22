BITS 64

global strcasecmp

section .text

strcasecmp:
      xor rcx, rcx
_loop:
    cmp BYTE [rdi + rcx], 0
    jne _convert_a
    cmp BYTE [rsi + rcx], 0
    je _end_eq

_convert_a:
    mov r8b, BYTE [rsi + rcx]
    cmp r8b, 'A'
    jl _convert_b
    cmp r8b, 'Z'
    jg _convert_b
    xor r8b, 0x20

_convert_b:
    mov r9b, BYTE [rdi + rcx]
    cmp r9b, 'A'
    jl _cmp_val
    cmp r9b, 'Z'
    jg _cmp_val
    xor r9b, 0x20

_cmp_val:
    cmp r9b, r8b
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

;int strcasecmp(const char *s1, const char *s2)
;{
;    for (int i = 0; s1[1] && s2[i]; i++) {
;         if (toupper(si[i]) != toupper(s2[i])) {
;             return s1[i] - s2[i];
;         }
;     }
;     return 0;
;}