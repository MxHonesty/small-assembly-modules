bits 32 

;(a+a+b*c*100+x)/(a+10)+e*a
; a,b,c-byte; e-doubleword
; x-qword reprezentarea cu semn

global start

extern exit
import exit msvcrt.dll

segment data use32 class = data
a db 1
b db 5
c db 25
e dd 125
x dq 44556677h

segment code use32 class = code 
start:
    
    ; b * c * 100
    mov AL, byte [b] ; AL = b
    imul byte [c] ; AX = AL * c adica AX = b * c
    mov BX, 100 ; BX = 100
    imul BX ; DX:AX = AX * BX adica DX:AX = b * c * 100
    push DX
    push AX ; Avem b * c * 100 in stiva (dword)
    
    ; a + a + x
    mov AL, byte [a] 
    add AL, byte [a] ; AL = a + a
    cbw ; AL -> AX
    cwde ; AX -> EAX
    cdq ; EAX => EDX:EAX
    mov ECX, dword [x]
    mov EBX, dword [x+4] ; EBX:ECX = x
    add ECX, EAX 
    adc EBX, EDX ; EBX:ECX = a + a + x
    
    ; a + a + b * c * 100 + x
    pop EAX ; EAX = b * c * 100
    cdq ; EAX -> EDX:EAX
    add EAX, ECX
    adc EDX, EBX ; EDX:EAX rezultat
    
    ; a + 10 ca dword
    push EAX 
    mov AL, byte [a]
    cbw ; AL -> AX
    cwde ; AX -> EAX
    add EAX, 10 ; EAX = a + 10
    mov EBX, EAX; EBX = a + 10
    pop EAX ; EDX:EAX = ()
    
    idiv EBX ; EAX = EDX:EAX / EBX (dword)
             ; EDX = EDX:EAX % EBX
             
    ; a * e
    push EAX ; ducem catul in stiva
    mov AL, byte [a] ; AL = a
    cbw ; AL -> AX
    cwde ; AX -> EAX = a
    imul dword [e] ; EDX:EAX = a*e
    
    mov EBX, EAX
    mov ECX, EDX ; ECX: EBX = a * e
    
    ; final
    pop EAX
    cdq ; EAX -> EDX:EAX
    add EAX, EBX
    adc EDX, ECX
    ;EDX:EAX rezultat final pentru datele de intrare : 00000000:0636540F
    
    push dword 0
    call [exit]