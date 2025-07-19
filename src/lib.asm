section .data
	msg db "hello world", 10, 0

	input db "a"

section .text
	global strlen
	global strput
	global chget
	call end

; extern strlen
; extern strput
; extern chget

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; > put pointer to str in ecx
; > call strlen
; < length in eax
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

strlen:
	xor eax, eax                                 ; clear eax
	push ecx                                     ; save the adress of the start of str
.loop:
	cmp byte [ecx], 0                            ; check if end of string
	je .end                                      ; if end of string jump to end
	inc ecx                                      ; go to next char
	inc eax                                      ; inc length
	jmp .loop                                    ; repeat
.end:
	pop ecx                                      ; return to the start of string
	ret                                          ; return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; > put pointer to str in ecx
; > call strput
; < string in stdout
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

strput:                                          ; (ecx: pointer to message)
	call strlen                                  ; get length of string
	mov edx, eax                                 ; put strlen in for syscall
	mov eax, 12;
	mov eax, 4                                   ; sys_write
	mov ebx, 1                                   ; file desc for stdout
	int 0x80                                     ; syscall
.end:
	ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; > call chget
; < char in ecx
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

chget:
	mov eax, 3          ; sys_read
	mov ebx, 0          ; file desc for stdin
	mov edx, 1          ; bytes to read
	int 0x80            ; make the system call to read input
.end:
	ret

end:
