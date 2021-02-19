
BITS 64

SYS_READ equ 0
SYS_WRITE equ 1
SYS_EXIT equ 60

STDIN equ 0
STDOUT equ 1
STDERR equ 2

%macro exit 1
    mov rax, SYS_EXIT
    mov rdi, %1
    syscall
%endmacro

%macro print 1
    push rax
    mov rbx, 0
%%printLoop:
    inc rax
    inc rbx
    mov cl, [rax]
    cmp cl, 0
    jne %%printLoop

    mov rax, 1
    mov rdi, STDOUT
    pop rsi
    mov rdx, rbx
    syscall
%endmacro