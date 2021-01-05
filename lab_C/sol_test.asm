bits 32 ; assembling for the 32 bits architecture

global _sol

; our data is declared here (the variables needed by our program)
segment data public data use32

; our code starts here
segment code public code use32
    _sol:
        push EBP
        mov EBP, ESP
        
        ; Incepem suma
        mov EAX, 0
        add EAX, [EBP + 8]  ; Avem in stiva parametrii, adresa de revenire, EBP - ul. Deci vom luat +8 primul parametru.
        add EAX, [EBP + 12]  ; +8 + 4 al doilea parametru. 
        
        mov ESP, EBP
        pop EBP
        ret