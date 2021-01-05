bits 32 

; Student: STOIAN STELIAN
; Grupa 216/2
; Tema Lab 3
; Exercitiu rezolvat: (8 - a * b * 100 + c) / d + x; 
;                      a, b, d - byte; c - doubleword; x - qword Interpretare fara semn
global start

extern exit
import exit msvcrt.dll

segment data use32 class = data
a db 2
b db 5
d db 2
c dd 1000
x dq 12412
segment code use32 class = code 
start:
    ; a * b
    mov AL, byte [a] ; AL = a
    mul byte [b] ; AX = AL * b
    
    ; a * b * 100
    mov DX, 100 ; DX = 100
    mul DX ; DX:AX = AX * DX = AX * 100
     
    ; 8 - a * b * 100 + c
    mov BX, 8 ; BX = 8
    mov CX, 0 ; CX = 0
    sub BX, AX ; BX = BX - AX = 8 - AX
    sbb CX, DX ; CX:BX = 8 - a * b * 100
    
    add BX, word [c]
    adc CX , word [c+2] ; CX:BX = 8 - a * b * 100 + c
    
    mov AX, BX
    mov DX, CX ; DX:AX = 8 - a * b * 100 + c
    
    ; ()/d
    mov BX, 0
    mov BL, [d]
    div BX ; AX = ()/d
           ; DX = ()%d
    
    ; + x
    mov EBX, dword [x] ; EBX = x.low
    mov EDX, dword [x+4] ; EDX = x.high
                   ; EDX:EBX = x
    
    mov CX, AX
    mov EAX, 0
    mov AX, CX ; EAX = ()/d
    
    add EBX, EAX 
    adc EDX, 0 ; Rezultat final EDX:EBX 00000000:00003080
    
    push dword 0
    call [exit]