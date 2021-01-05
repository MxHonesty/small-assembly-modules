bits 32 

global start

extern exit
import exit msvcrt.dll

segment data use32 class = data
a dw 10

segment code use32 class = code 
start:
    
    mov AX, 30
    mul word [a]
    
    push dword 0
    call [exit]