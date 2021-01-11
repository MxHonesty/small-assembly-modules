bits 32
;Se da un fisier text. Sa se citeasca continutul fisierului, sa se contorizeze numarul de vocale si sa se afiseze aceasta valoare. Numele fisierului text este definit in segmentul de date. 

global start        

extern exit
extern printf, fread, fopen, fclose

import exit msvcrt.dll
import printf msvcrt.dll
import fread msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll

segment data use32 class=data
caracter db 0, 0
file db "input.txt", 0
access_mode db "r", 0
file_desc dd 0
vocale db "xaeiou"

contor dd 0

mesaj_eroare db "Fisierul nu a putu fi deschis.", 0
mesaj_final db "In fisier au fost gasite %d vocale.", 0
format_debug db "%c ", 0

segment code use32 class=code
    start:
        push access_mode
        push file
        call [fopen]
        
        cmp EAX, 0
        JZ eroare
        mov [file_desc], EAX  ; Mutam descriptorul de fisier in memorie.
        
        push dword [file_desc]
        push dword 1  ; count 
        push dword 1  ; size 1 - character at a time
        push caracter
        
        repeta:
            call [fread]
            cmp EAX, 0
            JZ terminat
            mov ECX, 5
            mov BL, [caracter]
            verificare:
                cmp BL, [vocale + ECX]
                JZ gasit
                inapoi:
                loop verificare
                jmp repeta
        terminat:
        add ESP, 4 * 4
        push dword [contor]
        push mesaj_final
        call [printf]
        add ESP, 4 * 2
        
        final:
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
        
        eroare:
        push mesaj_eroare
        call [printf]
        add ESP, 4
        jmp final
        
        gasit:
        add dword [contor], 1
        jmp inapoi