bits 32 

; Se da un sir de octeti s. Sa se construiasca sirul de octeti d, care contine pe fiecare pozitie numarul de biti 1 ai octetului de pe pozitia corespunzatoare din s.
; Student: Stelian Stoian
; Grupa: 216/2

global start

extern exit
import exit msvcrt.dll

segment data use32 class = data
a db 5, 25, 55, 127 ; Sir de oceteti a
l equ $-a ; l = lungimea sirului
d times l db 0 ; Construim un sir de lungime egala cu a, initializat cu 0

segment code use32 class = code 
start:
    
    mov ESI, a ; Parcurgem sirul de pe pozitia 0 
    mov EDI, d ; Destinatia
    mov BH, l ; BH = numarul de elemente din sir
    CLD ; Parcurgem sirul ascendent 
    
    iteratie:
        LODSB ; AL = a[poz]
        mov BL, 0 ; BL = numarul de biti 1
        mov ECX, 7 ; O sa shiftam de 7 ori
        determina: ; Determianm aparitiile lui 1
            mov DL, AL
            and DL, 1 ; Este ultimul bit 1?
            add BL, DL ; Adunam rezultatul la BL 
            SHR AL, 1
        loop determina
        mov AL, BL
        STOSB ; d[poz] = AL
    dec BH ; Am parcurs un element
    cmp BH, 0
    jnz iteratie
    
    push dword 0
    call [exit]