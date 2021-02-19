BITS 64

global memcpy

section .text

memcpy:
    xor rcx, rcx
_loop:
    cmp rcx, rdx
    je _end

    mov r8b, [rsi + rcx]
    mov [rdi + rcx], r8b

    inc rcx

    jmp _loop

_end:
    mov rax, rdi
    ret

; void *memcpy(void *dest, void *src, size_t n) {
;     for (size_t i = 0; i < n; i++) {
;         dest[i] = src[i];
;     }
;     return dest;
; }