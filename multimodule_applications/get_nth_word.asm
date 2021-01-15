bits 32
; Returns pointer to the nth word in the given string. 

global get_word  ; get_word(int nr_cuvant, char *propozitie)

segment data use32 public data
    new_string TIMES 101 db 0
segment code use32 public code
    get_word:
        mov ESI, [ESP + 4]  ; Extragem adresa de pe stiva.
        mov EDI, new_string
        mov EBX, [ESP + 8]  ; Extragem numarul cuvantului cautat.
        mov ECX, 0  ; Pastram in EDX adresa de cuvantului final.
        CLD  ; DF = 0
        sub ESP, 4  ; Local variable [ESP] for the new string address.
        
        ; completam cu 0 in loc de spatiu
        .repeta1:
            LODSB  ; AL = byte din ESI
            cmp AL, 0
            JZ .final1
            cmp AL, 32
            JNZ .mai_departe
            mov AL, 0  ; Daca AL == 32 atunci punem 0
            .mai_departe:
            STOSB  ; [EDI] <- AL
            jmp .repeta1
        .final1:
        ; Aici ajungem dupa completarea cu 0
        
        mov ESI, new_string
        mov [ESP], dword new_string
        mov EDI, 0  ; contor
        .cat_timp:
            cmp EBX, 1
            JZ .final2  ; We reached the word
            LODSB  ; AL <- [ESI]
            cmp AL, 0
            JNZ .next
                ; Aici se executa daca byte-ul curent este 0
                mov [ESP], ESI
                dec EBX
            .next:
            inc EDI  ; Incrementam pozitia
            jmp .cat_timp
        .final2:
        
        mov EAX, [ESP]  ; Mutam variabila locala in EAX
        add ESP, 4  ; Eliminam variabila locala
        ret  ; Ramane in EAX adresa cuvantului. 