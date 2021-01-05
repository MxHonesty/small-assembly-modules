bits 32 

; Student: STOIAN STELIAN
; Grupa 216/2
; Tema Lab 3
; Exercitiu rezolvat: (8 - a * b * 100 + c) / d + x; 
;                      a, b, d - byte; c - doubleword; x - qword Interpretare cu semn
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
    ; a * b * 100
    mov AL, byte [a]
    imul byte [b] ; AX = a * b
    mov BX, 100
    imul BX ; DX:AX = a * b * 100
    
    ; 8 - a * b * 100 + c
    mov CX, 8
    mov BX, 0 ; BX:CX = 8
    
    sub CX, AX
    sbb BX, DX ; BX:CX = 8 - a * b * 100
    
    mov AX, word [c]
    mov DX, word [c+2]   ; DX:AX = c
    
    add CX, AX 
    adc BX, DX ; BX:CX = 8 - a * b * 100 + c
    
    ; () / d
    mov AL, byte [d] ; AL = d
    cbw ; AL -> AX
    
    push AX ; STIVA = AX
    mov AX, CX
    mov DX, BX ; DX:AX = ()
    pop CX ; CX = d
    
    idiv CX ; DX:AX / CX 
            ; AX = cat
            ; DX = rest
            
    ; cat + x
    
    cwde ; AX -> EAX
    cdq ; EAX -> EDX:EAX
    mov EBX, dword [x]
    mov ECX, dword [x+4] ; ECX:EBX = x
    
    
    
    add EBX, EAX
    adc ECX, EDX ; ECX:EBX rezultat final 00000000:00003080
    
    
    push dword 0
    call [exit]