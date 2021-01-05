; Problema 6: Se dau trei siruri de caractere. Sa se afiseze cel mai lung prefix comun pentru fiecare din cele trei perechi de cate doua siruri ce se pot forma.
; Folosim un modul extern care determina cel mai mare prefix comun. Acesta este transmis din modul spre main prin EAX si reprezinta lungimea prefixului.

bits 32
global start

extern exit, printf, prefix
import exit msvcrt.dll
import printf msvcrt

segment data use32 class=data
sir1 db "abcdefgh", 0
sir2 db "abcdsalut", 0
sir3 db "dasdas", 0

mesaj1 db "Sirurile 1 si 2 nu au prefix comun! ", 10, 0
mesaj2 db "Sirurile 2 si 3 nu au prefix comun! ", 10, 0
mesaj3 db "Sirurile 1 si 3 nu au prefix comun! ", 10, 0

format db "Cel mai mare prefix este: %.*s ", 10, 0 
; Scrierea unui numar dat de caractere din string folosind formatul.
; https://embeddedartistry.com/blog/2017/07/05/printf-a-limited-number-of-characters-from-a-string/

segment code use32 class=code
    start:
        ; Avem trei combinatii posibile.
        I:
        push dword sir2
        push dword sir1
        call prefix
        add ESP, 4 * 2  ; eliberam stiva.
        
        cmp EAX, 0
        JZ cazul_vidI
        jmp afisare1
       
        II:
        push dword sir2
        push dword sir3
        call prefix
        add ESP, 4 * 2
       
        cmp EAX, 0
        jz cazul_vidII
        jmp afisare2
       
        III:
        push dword sir1
        push dword sir3
        call prefix
        add ESP, 4 * 2
       
        cmp EAX, 0
        jz cazul_vidIII
        jmp afisare3
        
        final:
        push    dword 0
        call    [exit]
        
        
        cazul_vidI:
        push dword mesaj1
        call [printf]
        add ESP, 4
        jmp II
        
        cazul_vidII:
        push dword mesaj2
        call [printf]
        add ESP, 4
        jmp III
        
        cazul_vidIII:
        push dword mesaj3
        call [printf]
        add ESP, 4
        jmp final
        
        afisare1:
        push dword sir1
        push EAX
        push dword format
        call [printf]
        add ESP, 4 * 3

        jmp II
        
        afisare2:
        push dword sir2
        push EAX
        push dword format
        call [printf]
        add ESP, 4 * 3
        jmp III
        
        afisare3:
        push dword sir3
        push EAX
        push dword format
        call [printf]
        add ESP, 4 * 3
        jmp final