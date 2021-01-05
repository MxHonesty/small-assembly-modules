bits 32 

; Student: STOIAN STELIAN
; Grupa 216/2
; Tema Lab 3
; Exercitiu rezolvat: (b+b+d)-(c+a) 
;                      a - byte, b - word, c - double word, d - qword - Interpretare cu semn
global start

extern exit
import exit msvcrt.dll

segment data use32 class = data
a db 20
b dw -100
c dd 245
d dq 344

segment code use32 class = code 
start:
    ; b word -> qword
    mov EAX, 0
    mov AX, [b] ; AX = b
    cwde ; AX -> EAX
    cdq ; EAX -> EDX:EAX
    
    ; b + b
    add EAX, EAX
    adc EDX, EDX ; EDX:EAX = b + b (+ CF)
    
    ; b + b + d
    add EAX, dword [d] ; EAX = EAX + d.low
    adc EDX, dword [d+4] ; EDX = EDX + d.high (+ CF)
    mov ECX, EAX ; EDX:ECX = b + b + d
    mov EBX, EDX ; EBX:ECX = b + b + d 
    
    ; c + a
    mov EAX, 0
    mov AL, [a] ; AL = a
    cbw ; AX = a
    cwde ; EAX = a
    cdq ; EDX:EAX = a
    add EAX, dword [c] ; EAX = a + c
    adc EDX, 0 ; EDX:EAX = a + c 
    
    ; (b + b + d) - (c + a)
    sub ECX, EAX 
    sbb EBX, EDX ; EBX:ECX = (b + b + d) - (c + a)
                 ; Rezultat final EBX:ECX FFFFFFFF:FFFFFF87

    push dword 0
    call [exit]