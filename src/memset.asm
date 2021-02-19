BITS 64

global memset

section .text

memset:
    xor rcx, rcx ; rcx = 0
_loop:
    cmp rcx, rdx ; i == n : stop
    je  _end

    mov [rdi + rcx], rsi ; s[i] = c

    inc rcx ; i++

    jmp _loop

_end:
    mov rax, rdi

; void *memset(void *s, int c, size_t n) {
;     for (size_t i = 0; i < n; i++) {
;         s[i] = c;
;     }
;     return s;
; }