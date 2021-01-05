bits 32 

; Student: STOIAN STELIAN
; Grupa 216/2
; Tema Lab 3
; Exercitiu rezolvat: (c+d)-(a+d)+b  
;                      a - byte, b - word, c - double word, d - qword - Interpretare fara semn
global start

extern exit
import exit msvcrt.dll

segment data use32 class = data
a db 0xA3
b dw 0xB230
c dd 0xBBAADDDD
d dq 0x2341FFFFFFFF

segment code use32 class = code 
start:
    
    ; c + d
    mov EAX, [c] ; Pregatim conversia din dw -> qw
    mov EDX, 0   ; Conversie fara semn EAX -> EDX:EAX
    
    add EAX, dword [d] ; EAX = EAX + d.low 
    adc EDX, dword [d+4] ; EDX = EDX + d.high
                   ; EDX:EAX = c + d
    
    ; a + d
    mov ECX, 0 ; ECX = 0
    mov CL, [a] ; CL = a => ECX = a
    mov EBX, 0 ; EBX:ECX = a
    
    add ECX, dword [d] ; ECX = ECX + d.low
    adc EBX, dword [d+4] ; EBX = EBX + d.high
                   ; EBX:ECX = a + d
    
    ; (c+d) - (a+d)
    sub EAX, ECX
    sbb EDX, EBX  ; EDX - High final
                  ; EAX - Low final
    
    ; +b
    mov EBX, 0
    mov BX, word [b]    ; EBX = b
    add EAX, EBX
    adc EDX, 0  ; +CF daca e cazul
    ; Rezultat final: EDX:EAX (00000000:BBAB8F6A)
    
    push dword 0
    call [exit]