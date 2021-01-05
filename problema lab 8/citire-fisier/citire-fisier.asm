bits 32 
; Se da un fisier text. Sa se citeasca continutul fisierului, sa se determine caracterul special 
;(diferit de litera) cu cea mai mare frecventa si sa se afiseze acel caracter, impreuna cu frecventa acestuia. 
; Numele fisierului text este definit in segmentul de date. 

global start        

extern exit, fopen, fread, printf, fclose
import exit msvcrt.dll
import fclose msvcrt.dll
import fopen msvcrt.dll
import fread msvcrt.dll
import printf msvcrt.dll


segment data use32 class=data
    max dd 0
    max_aparitii db 0
    max_caracter db 0, 0
    
    nume_fisier db "input.txt", 0
    mod_acces db "r", 0
    len equ 256
    
    aparitii times len db 0
    element times len db 0
    caracter db 1, 0

    
    descriptor_fisier dd 0
    
    mesaj_esuare db "Fisierul nu a putut fi deschis", 0
    format_afisare db "%s", 0
    
    format_debug db "%s", 0
    
    format_mesaj_final db "Caracterul %s apare de %d ori.", 0

segment code use32 class=code
    start:
        
        ; Apelul functie fopen:
        push dword mod_acces
        push dword nume_fisier
        call [fopen]
        add ESP, 4 * 2  ; Eliberarea stivei
        mov [descriptor_fisier], EAX  ; Mutam descriptorul fisierului in descriptor_fisier
        cmp EAX, 0
        jz invalid
        ; Aici se ajunge daca fisierul a fost deschis corect
        repeta:
        push dword [descriptor_fisier]
        push dword 1  ; Count - Cate un caracter
        push dword 1  ; Size Byte
        push dword caracter  ; Caracterul citit se afla in variabila caracter
        call [fread]
        add ESP, 4 * 4
        cmp EAX, 0
        jz final_repeta

        ; Aici se executa verificarea caracterului. 
        ; Pentru fiecare element din element, pana la intalnirea primului 0, daca caracterul este egal, se adauga 1 
        ; in aparitii pe pozitia elementului. Daca nu este egal, se adauga noua valoare in element si pozitia aferenta din aparitii primeste valoarea 1.
        mov BL, [caracter]
        mov ECX, len
        mov EDX, 0
        pentru_fiecare_element:
            cmp [EDX + aparitii], byte 0
            jz gasit_spatiu ; Daca gasim spatiu gol
            
            cmp [EDX + element], BL
            jz gasit_caracter
            
            inc EDX

        loop pentru_fiecare_element
        terminat:
        jmp repeta
        
        gasit_spatiu:
            mov [EDX + element], BL
            mov [EDX + aparitii], byte 1
            mov [max], EDX
            jmp terminat
            
        gasit_caracter:
            add [EDX + aparitii] , byte 1
            jmp terminat
        
        final_repeta:
        ; Aici se ajunge dupa citirea intregului document. 
        ; In situatia in care suntem aici avem sirul de aparitii completat. Ramane sa gasim doar maximul care nu este o litera.
        ; max este ultima pozitie pe care s-a incarcat un caracter in sirul de aparitii.        
        mov ECX, [max]
        inc ECX  ; Repetam de max + 1 ori
        cmp ECX, 0
        jz sfarsit
        
        mov EDX, 0
        determina_maxim:
            ; Determinam daca caracterul dat este o litera, daca da, sarim peste, daca nu, il comparam cu maximul acual. 
            mov BL, [EDX + element]
            mov AL, [EDX + aparitii]  ; Elementul din BL a aparut in fisier de AL ori.
            cmp BL, 65  ; 65 - A
            jae peste_A
            done1:
            cmp BL, 97
            jae peste_a
            done2:  ; Daca nu este o litera
            cmp AL, [max_aparitii]
            jae new_max
            
            ignora:  ; Continua de aici daca valoarea apartine [A, Z] sau [a, z]
        inc EDX
        loop determina_maxim
        
        ; Afisare rezultat
        mov EAX, 0
        mov AL, [max_aparitii] ; Convertim max_aparitii de la byte la dword
        
        push EAX
        push dword max_caracter
        push dword format_mesaj_final
        call [printf]
        add ESP, 4 * 2
        
        push dword [descriptor_fisier]
        call [fclose]
        add ESP, 4
        sfarsit:
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

        
        invalid:  ; Daca fisierul nu a fost deschis corespunzator. 
        push dword mesaj_esuare
        push dword format_afisare
        call [printf]
        add ESP, 4 * 2 
        jmp sfarsit
        
        peste_A:
        cmp BL, 90  ; 90 - Z
        jbe ignora
        jmp done1
        peste_a:
        cmp BL, 122
        jbe ignora
        jmp done2
        
        new_max:
            mov [max_aparitii], AL
            mov [max_caracter], BL
            jmp ignora
        