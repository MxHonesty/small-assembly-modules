bits 32

; Student: Stelian Stoian
; Grupa: 216/2
; Marti, 12/01/2021, 16:00
; Se citeste de la tastatura un cuvant (sir de caractere de maxim 20 de caractere) si un numar reprezentat 
; pe un octet. Daca numarul este par se cere criptarea cuvantului prin adunarea la fiecare caracter a numarului 20.
; Daca numarul este impar se cere criptarea cuvantului prin adaugarea dupa fiecare vocala a gruparii "p"+vocala.
; Se cere afisarea cuvantului criptat.

global start        

extern exit, printf, scanf
import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll

segment data use32 class=data
cuvant_primit TIMES 21 db 0  ; Declaram 21 de bytes ca sa ne ramana si caracterul de final in cazul de 20 de caractere.
cuvant_criptat Times 61 db 0  ; Cel mai rau caz - triplarea numarului de caractere.
format_citire_cuvant db "%s", 0

numar_citit dd 0
format_citire_numar db "%d", 0

afisare_text db "Textul encriptat este: %s.", 0
afisare_numar db "Numarul citit este %d", 0

vocale db "xaeiou"  ; Folosit pentru a verifica daca un caracter este o vocala sau nu.
; Am pus un x la inceput pentru ca utilizez ECX ca index in formula de calcul al offsetului unui operand.
; Acest ECX scade intr-un loop pornind de la 5 (pozitia ultimei vocale din aceasta lista) si verificand
; ultima data pentru 1. Astfel am introdus un byte nou in vocale pentru a nu fi nevoie de a schimba
; metoda de loop. Deci in loop se va verifica pentru "vocale[5], vocale[4], vocale[3], vocale[2], vocale[1]".

segment code use32 class=code
    start:
        
        push cuvant_primit
        push format_citire_cuvant
        call [scanf]
        add ESP, 4 * 2  ; Citim sirul de caractere
        
        push numar_citit
        push format_citire_numar
        call [scanf]
        add ESP, 4 * 2  ; Citim numarul cerut
        
        ; Verificare daca este numar par
        ; Facem asta prin verificarea ultimului bit. daca este 0 - par, daca este 1 - impar
        mov EAX, [numar_citit]
        SHR EAX, 1  ; Mutam ultimul bit in carry
        JNC par  ; Daca ultimul bit era 0 inseamna ca numarul era par.
        ; Daca ajunge aici inseamna ca este impar
        CLD  ; DF = 0 (asiguram sensul)
        mov ESI, cuvant_primit
        mov EDI, cuvant_criptat
        repeta_impar:
            LODSB  ; AL = caracter din ESI
            cmp AL, 0
            JZ terminat_repeta  ; Daca se face saltul inseamna ca am ajuns la finalul cuvantului.
            mov ECX, 5  ; Pentru cele 5 vocale: a e i o u.
            verificare_vocala:
                cmp AL, [vocale + ECX]  ; Verificam pe rand fiecare vocala.
                JZ este_vocala
                loop verificare_vocala
            ; Aici se ajunge daca nu este vocala.
            STOSB  ; EDI <- AL.
            
            next: jmp repeta_impar
            
        este_vocala:
        ; Aici se ajunge daca este vocala.
            STOSB  ; Mutam vocala in EDI
            mov BL, AL  ; Salvam vocala
            mov AL, 'p'  ; Adaugam p
            STOSB
            mov AL, BL
            STOSB
            jmp next
        
        par:
        ; Daca ajunge aici inseamna ca este par
        CLD  ; DF = 0 (asiguram sensul)
        mov ESI, cuvant_primit
        mov EDI, cuvant_criptat
        repeta:
            LODSB  ; AL = caracter din ESI (cuvant_primit)
            cmp AL, 0
            JZ terminat_repeta
            add AL, 20
            STOSB  ; EDI <- byte din AL. 
            jmp repeta
        terminat_repeta:
        
        ; Aici se ajunge cand cuvantul e criptat
        push cuvant_criptat
        push afisare_text
        call [printf]
        add ESP, 4 * 2
        
        push    dword 0
        call    [exit]
