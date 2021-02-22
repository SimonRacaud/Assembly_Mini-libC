BITS 64

global strpbrk

section .text

; char *strpbrk(const char *s, const char *accept);
strpbrk:
        mov rax, rdi
_loop:
    cmp BYTE [rax], 0
    je _end_notfound

    jmp _cmp
_post_cmp:

    inc rax

    jmp _loop

_cmp:
    mov r8, rsi
_cmp_loop:
    cmp BYTE [r8], 0    ; search[j] == 0
    je _post_cmp

    mov rdx, [r8]
    cmp BYTE [rax], dl   ; str[i] == search[j]
    je _end_found

    inc r8 ; j++

    jmp _cmp_loop

_end_found:
    ret

_end_notfound:
    xor rax, rax
    ret