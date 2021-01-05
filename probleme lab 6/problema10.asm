bits 32 
; P10
; Sa se inlocuiasca bitii 0-3 ai octetului B cu bitii 8-11 ai cuvantului A. 
; Student: Stelian Stoian
; Grupa: 216/2

global start

extern exit
import exit msvcrt.dll

segment data use32 class = data
a dw 1111000011111111b
b db 11111111b

segment code use32 class = code 
start:
    
    mov AX, [a] ; AH = 1111(0000)
                ; AL = 11111111
    mov BL, [b] ; BL = 1111(1111)
    
    and AH, 00001111b ; AH = 0000(0000)
    and BL, 11110000b ; 1111(0000)
    
    or AH, BL ; AH Rezultat final
    
    push dword 0
    call [exit]