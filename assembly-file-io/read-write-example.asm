bits 32 
; Se dau un nume de fisier si un text (definite in segmentul de date). Textul contine litere mici si spatii. Sa se inlocuiasca toate literele de pe pozitii pare cu numarul pozitiei. Sa se creeze un fisier cu numele dat si sa se scrie textul obtinut in fisier. 
global start        

extern exit, fopen, fclose, fread, fprintf, printf
import printf msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
import fread msvcrt.dll
import fprintf msvcrt.dll
import exit msvcrt.dll    

segment data use32 class=data
filename db "data.txt", 0
mod_citire_citit db "r", 0
mod_citire_scris db "w", 0
new_text TIMES 500 db 0
pozitie_curent dd 0  ; Indica pozitia curenta in new_text.
mesaj_eroare db "Fisierul nu a putut fi deschis.", 0
descriptor dd 0
format_sciriere db "%s", 0
mesaj_eroare2 db "eroare debug", 0

caracter db 0


segment code use32 class=code
    start:
        push mod_citire_citit
        push filename
        call [fopen]
        add ESP, 4 * 2
        cmp EAX, 0
        JZ eroare
        mov [descriptor], EAX
        
        push dword [descriptor]
        push dword 1  ; count
        push dword 1  ; size
        push caracter
        repeta:
            call [fread]
            cmp EAX, 0
            JZ terminat
            mov BL, [caracter]
            ; Verificam daca pozitia este para
            mov EAX, [pozitie_curent]
            SHR EAX, 1
            mov EAX, [pozitie_curent]
            JNC par
            mov [EAX + new_text], BL
            inc EAX
            jmp endr
            
            par:
            add BL, '0'
            mov [EAX + new_text], BL
            inc EAX
            endr:
            inc dword [pozitie_curent]
            jmp repeta
        
        terminat:
        add ESP, 4 * 4
        push dword [descriptor]
        call [fclose]
        add ESP, 4
        
        push mod_citire_scris
        push filename
        call [fopen]
        add ESP, 4 * 2
        cmp EAX, 0
        JZ eroare2
        push new_text
        push format_sciriere
        push EAX
        call [fprintf]
        add ESP, 4 * 3
        
        final:
        push    dword 0    
        call    [exit]       

        eroare:
        push mesaj_eroare
        call [printf]
        add ESP, 4
        jmp final
        
        eroare2:
        push mesaj_eroare2
        call [printf]
        add ESP, 4
        jmp final