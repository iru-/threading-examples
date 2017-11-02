;
; Subroutine Threaded Forth
;

;
; Register allocation
; REG    FUNCTION
; rsp    R
; rbp    PSP

;
; Initialization
;

section .data
stack:			times 8192 db 0
stacktop:

global _start
section .text
_start:
	mov rbp, stacktop    ; setup parameter stack
	call test0
	call bye

;
; Words
;
test0:
	call test1
	ret

test1:
	call test2
	ret

test2:
	mov rax, 1      ; write syscall
	mov rdi, 1      ; stdout
	mov rsi, str    ; str
	mov rdx, len
	syscall
	ret

str: db 'test string', 0Ah
len: equ $ - str

bye:
	mov rax, 60      ; exit syscall
	mov rdi, 0       ; status
	syscall

