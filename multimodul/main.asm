bits 32
global start

import printf msvcrt.dll
import exit msvcrt.dll
extern printf, exit

extern factorial
extern afisare

segment data use32
    a db "salut acesta este un test"

segment code use32 public code
start:
	push dword 6
	call factorial

    push EAX
	call afisare
	add esp, 2*4

	push 0
	call [exit]
