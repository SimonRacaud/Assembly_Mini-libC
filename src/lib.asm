
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

;; my put str (rax)
%macro print 1
    mov rax, %1
    mov rbx, 0
%%printLoop:
    mov cl, [rax]
    cmp cl, 0
    je %%endPrintLoop
    inc rbx
    inc rax
    jmp %%printLoop
%%endPrintLoop:
    mov rax, SYS_WRITE
    mov rdi, STDIN
    mov rsi, %1
    mov rdx, rbx
    syscall
%endmacro

;; my print number (rax)
%macro printNumber 1:
    mov rax, %1
    mov rcx, digitSpace
    mov rbx, 10
    mov [rcx], rbx
    inc rcx
    mov [digitSpacePos], rcx
 
%%printRAXLoop:
    mov rdx, 0
    mov rbx, 10
    div rbx
    push rax
    add rdx, 48
 
    mov rcx, [digitSpacePos]
    mov [rcx], dl
    inc rcx
    mov [digitSpacePos], rcx
    
    pop rax
    cmp rax, 0
    jne %%printRAXLoop
 
%%printRAXLoop2:
    mov rcx, [digitSpacePos]
 
    mov rax, 1
    mov rdi, 1
    mov rsi, rcx
    mov rdx, 1
    syscall
 
    mov rcx, [digitSpacePos]
    dec rcx
    mov [digitSpacePos], rcx
 
    cmp rcx, digitSpace
    jge %%printRAXLoop2
%endmacro