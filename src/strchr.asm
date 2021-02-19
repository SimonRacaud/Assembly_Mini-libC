
%include "src/lib.asm"

BITS 64
global strchr

section .text

strchr:
    mov rax, rdi
_loop:
    cmp BYTE [rax], sil
    je _end_found
    
    cmp BYTE [rax], 0
    je _end_not_found

    inc rax

    jmp _loop
_end_found:
    ret
_end_not_found:
    xor rax, rax
    ret

; for (size_t i = 0; str[i]; i++) {
;     if (str[i] == search) {
;         return str + i;
;     }
; }