bits 32
; Se citesc de la tastatura un numar natural n si n propozitii care contin cel putin n cuvinte (nu se fac validari).
; Sa se afiseze sirul format prin concatenarea cuvintelor de pe pozitia i din propozitia i, i=1,n (separate prin spatiu).

global start        

extern exit, printf, gets, scanf, get_word
import printf msvcrt.dll
import scanf msvcrt.dll
import gets msvcrt.dll  ; gets(*ptr)
import exit msvcrt.dll

segment data use32 class=data
text_citit TIMES 101 db 0  ; Aici se stocheaza pe rand fiecare propozitie
prop_final TIMES 1001 db 0  ; Aici se stocheaza propozitia FINALA.

n dd 0  ; numarul de propozitii. 
format_int db "%d", 0
mesaj_citire db "n = ", 0

format_afisare_text db "%s", 0

segment code use32 class=code
    start:
        
        push mesaj_citire
        call [printf]
        add ESP, 4
        
        push n
        push format_int
        call [scanf]
        add ESP, 4 * 2
        
        mov ECX, [n]
        mov EBX, 1  ; Indexul cuvantului curent
        mov EDI, prop_final
        
        CLD  ; DF = 0
        
        pentru:
            ; Pentru fiecare index de cuvant
            ; Citim propozitia cu index EBX
            
            pushad
            
            push text_citit
            call [gets]
            add ESP, 4
            
            popad 
            
            push ECX
            push EBX
            push EDI
            
            ; Obtinem cuvantul EBX din propozitie.
            push EBX
            push text_citit
            call [get_word]  ; Get word modifica toti registrii !!!
            add ESP, 4 * 2
            
            pop EDI
            pop EBX
            pop ECX
            
            ; In EAX avem acum adresa cuvantului.
            
            CLD 
            
            ; Adaugam cuvantul la prop_final, inlocuind caracterul de terminare cu 32 (spatiu)
            mov ESI, EAX
            cat_timp:
                LODSB  ; AL <- [ESI]
                cmp AL, 0
                jz final_cuvant
                ; Daca nu suntem la final
                STOSB  ; [EDI] <- AL
                jmp cat_timp
                final_cuvant:
                    ; Daca am ajuns la finalul cuvantului
                    mov AL, 32
                    STOSB  ; Adaugam spatiu dupa cuvant
                    ; Continuam in exteriorul loop-ului
            inc EBX  ; Trecem la urmatorul cuvant
        loop pentru
        
        push text_citit
        call [gets]
        add ESP, 4
        ; Avem o propozitie in text_citit
        
        
        
        
        push    dword 0
        call    [exit]
