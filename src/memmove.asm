BITS 64

global memmove

section .text

memmove:
    xor rcx, rcx

    cmp rdi, rsi
    je _memmove_end
    jl _cp_low
    jg _cp_grt
_cp_low:
    xor rcx, rcx
_low_loop:
    cmp rcx, rdx
    je _memmove_end

    mov r8b, [rsi + rcx]
    mov [rdi + rcx], r8b

    inc rcx

    jmp _low_loop

_cp_grt:
    mov rcx, rdx
    dec rcx
_grt_loop:
    cmp rcx, 0
    jl _memmove_end

    mov r8b, [rsi + rcx]
    mov [rdi + rcx], r8b

    dec rcx

    jmp _grt_loop

_memmove_end:
    mov rax, rdi
    ret


; void *memmove(void *dest, const void *src, size_t n);