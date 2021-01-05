bits 32
; Se citesc trei siruri de caractere. Sa se determine si sa se afiseze rezultatul concatenarii lor.

global _concatenare

segment data public data use32
    sir_concatenat times 30 db 0  ; Un sir de 30 de pozitii initializat cu valoarea 0.
    
segment code public code use32
    ;char *concatenare(char sir1[], char sir2[], char sir3[])
    _concatenare:
        ; Creare cadru de stiva.
        push ebp
        mov ebp, esp
        
        ; mutam in EAX, EBX, EDX adresele sirurilor. 
        mov EAX, [EBP + 8]
        mov EBX, [EBP + 12]
        mov EDX, [EBP + 16]
        
        mov EDI, sir_concatenat
        mov ESI, EAX  ; Incepem cu EAX
        .repeta1:
        LODSB  ; AL = BYTE [ESI]
        cmp AL, 0
        JZ .next2
        STOSB  ; Mutam in sir_concatenat byte-ul din AL.
        jmp .repeta1
        
        .next2:
        mov ESI, EBX  ; Al doilea sir.
        .repeta2:
        LODSB
        cmp AL, 0
        JZ .next3
        STOSB
        jmp .repeta2
        
        .next3:
        mov ESI, EDX
        .repeta3:
        LODSB
        cmp AL, 0
        JZ .next4
        STOSB
        jmp .repeta3
        
        .next4
        mov AL, 0
        STOSB  ; Mutam 0 la finalul sirului construit.
        mov ESP, EBP
        pop EBP
        mov EAX, sir_concatenat
        ret