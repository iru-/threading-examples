;
; Direct Threaded Forth
;

;
; Register allocation
; REG    FUNCTION
; r8     IP
; r9     W
; rsp    R
;

; inner interpreter
%macro next 0
	mov r9, [r8]    ; load CFA into W
	add r8, 8       ; advance IP to next word in thread
	jmp r9
%endmacro


; enter the execution of a forth word
enter:
	push r8         ; push IP onto R
	lea r8, [r9+5]  ; move IP to the word's body
	                ; (E9h + displacement (4 bytes))
	next

; return from a forth word
exit:
	pop r8          ; pop R onto IP
	next

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
	mov r8, main0        ; run the first forth word
	next

main0:
	dq main

main:
	jmp qword enter
_main:
	dq test0
	dq bye

;
; Words
;
test0:
	jmp qword enter        ; CFA
_test0:
	dq test1
	dq exit

test1:
	jmp qword enter        ; CFA: code field address
_test1:
	dq test2
	dq exit

test2:
	mov rax, 1      ; write syscall
	mov rdi, 1      ; stdout
	mov rsi, str    ; str
	mov rdx, len
	syscall
	next

str: db 'test string', 0Ah
len: equ $ - str

bye:
	mov rax, 60      ; exit syscall
	mov rdi, 0       ; status
	syscall
	next
