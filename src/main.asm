section .data
	msg db "hello world", 10, 0                  ; The message to print, followed by a newline (0xA)

	input db "a"

section .text
	global _start
	extern strlen
	extern strput
	extern chget

_start:
	mov ecx, msg
	call strput
	mov eax, 1                                   ; sys_exit
	xor ebx, ebx                                 ; stat 0
	int 0x80                                     ; syscall
