bits 32 

global start

extern exit
import exit msvcrt.dll

segment data use32 class = data
S db 1, 2, 3, 4, 5, 6, 7, 8
l equ $-S
D times l db 0

segment code use32 class = code 
start:
    
    
    mov ECX, l ; Pentru 8 elemente
    mov ESI, 0 ; Incepem de la inceputul sirului
    mov EBX, 0 ; EBX arata urmatoarea pozitie din D in care vom pune elementul
    
    repeta:
    
    repeta_pare:
        ;[S + ESI] ; Elementul curent din sir
        test ESI, 1 ; Verificam daca ultimul bit al numarului este 1 sau 0
                    ; Daca este 1 - numar impar
                    ; Daca este 0 - numar par
        jnz evita_pare
            mov AL, [S + ESI] ; Elementul curent din S in EAX
            mov [D + EBX], AL  ; Elementul curent din S in D
            inc EBX ; Trecem la urmatoarea pozitie din D
        evita_pare:
        inc ESI
    loop repeta_pare
    
    mov ESI, 0 ; Resetam ESI
    mov ECX, l ; Resetam ECX
    
    repeta_impare:
    test ESI, 1 
    jz evita_impare
        mov AL, [S + ESI]
        mov [D + EBX], AL    
        inc EBX
    evita_impare:
    inc ESI
    loop repeta_impare

   
    push dword 0
    call [exit]