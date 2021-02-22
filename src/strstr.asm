BITS 64

global strstr

section .text

strstr:
    mov rax, rdi
_loop:
    cmp BYTE [rax], 0
    je _end_notfound

    jmp _cmp
_post_cmp:

    inc rax

    jmp _loop

_cmp:
    mov r9, rax
    mov r8, rsi
_cmp_loop:
    cmp BYTE [r8], 0    ; search[j] == 0
    je _end_found

    mov rdx, [r8]
    cmp BYTE [r9], dl   ; str[i] != search[j]
    jne _post_cmp

    inc r8
    inc r9

    jmp _cmp_loop

_end_found:
    ret

_end_notfound:
    xor rax, rax
    ret

; char *strstr(const char *haystack, const char *needle);