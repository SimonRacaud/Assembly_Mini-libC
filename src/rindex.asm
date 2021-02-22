BITS 64
global rindex

section .text

rindex:
    mov rax, rdi

    cmp BYTE [rax], 0
    je _loop
_loop_to_end:
    inc rax

    cmp BYTE [rax], 0
    jne _loop_to_end

_loop:
    cmp BYTE [rax], sil ; search found
    je _end_found
    
    cmp rax, rdi ; end of str
    je _end_not_found

    dec rax

    jmp _loop
_end_found:
    ret
_end_not_found:
    xor rax, rax
    ret

; char *rindex(const char *s, int c) {
;     size_t i;
;
;     for (i = 0; str[i]; i++);
;     for (j = i - 1; j >= 0; j--) {
;         if (str[j] == search) {
;             return str + j;
;         }
;     }
; }