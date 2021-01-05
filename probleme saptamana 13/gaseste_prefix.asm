bits 32

segment code use32 public code
global prefix

; int prefix(char *sir1, char *sir2) -> lungimea celui mai lung prefix comun.
prefix: 
    mov EAX, 0  ; Initializam lungimea cu 0.
    
    mov EDI, [ESP + 4]  ; ESP = adresa de revenire, ESP + 4 = al doilea sir
    mov ESI, [ESP + 8]  ; primul sir.
    
    ; Cat timp cele doua caractere sunt egale.
    CLD  ; DF = 0
    .cat_timp:
    ; Verificam daca nu s-a terminat deja sirul.
    cmp [EDI], byte 0
    JZ .final
    cmp [ESI], byte 0
    JZ .final
    
    
    CMPSB  ; CMP [EDI], [ESI] si incrementeaza
    JNZ .final
    inc EAX
    jmp .cat_timp
    .final:
    
    ret