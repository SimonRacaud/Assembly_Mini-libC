BITS 64

global strcspn

section .text

; size_t strcspn(const char *s, const char *reject);
strcspn:
    xor rax, rax
_loop:
    mov r8, [rdi + rax]
    cmp r8b, 0
    je _end

_search:
    mov rdx, rsi
_search_loop:
    cmp BYTE [rdx], 0
    je _post_search

    cmp BYTE [rdx], r8b
    je _end

    inc rdx
    jmp _search_loop

_post_search:
    inc rax

    jmp _loop

_end:
    ret