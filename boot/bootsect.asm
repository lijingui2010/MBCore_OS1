;		 bootsect.asm	(C) Jim Lee
;
; Start the CPU: switch to 32-bit protected mode, jump into C.
; The BIOS loads this code from the first sector of the hard disk into
; memory at physical address 0x7c00 and starts executing in real mode
; with %cs=0 %ip=7c00.
;

bits 16

global start
start:
	mov ax, cs
	mov ds, ax
	mov es, ax
	mov ss, ax

print:
	mov cx, 0x0C
	mov dx, 0x1400
	mov bx, 0x000e
	mov bp, msg
	mov ax, 0x1301
	int 0x10

loop:
	jmp loop

msg:
	db "Hello World!",0
