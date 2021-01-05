bits 32 
; Sa se citeasca de la tastatura doua numere a si b (in baza 10) si sa se calculeze: (a+b) / (a-b). Catul impartirii se va salva in memorie in variabila "rezultat" (definita in   
; segmentul de date). Valorile se considera cu semn.
; Student: Stelian Stoian
; Grupa: 216/2 

global start        

; declare external functions needed by our program
extern exit, scanf, printf            ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import scanf msvcrt.dll
import printf msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
rezultat resd 1
a dd 0  ; Initializam a si b cu 0 (word)
b dd 0
format_citire db "%d", 0
mesaj_afisare db "Catul impartirii din variablia rezultat este %d ", 0
mesaj_invalid db "Valorile date nu sunt valide! ", 0

mesaj_testare_1 db "a + b = %d   ", 0
mesaj_testare_2 db "a - b = %d   ", 0

; our code starts here
segment code use32 class=code
    start:
        
        ; Citim a:
        push dword a
        push dword format_citire
        call [scanf] ;scanf(format_citire, a)
        add ESP, 4 * 2 ; 4 - dword, 2 - doi parametrii
       
        push dword b
        push dword format_citire
        call [scanf]
        add ESP, 4 * 2
        
        mov EAX, [a]
        add EAX, [b]  ; EAX = a + b 
                
        mov EBX, [a]
        sub EBX, [b]  ; EBX = a - b
        
        ; Afisam valorile pentru test
        PUSHAD
        push EAX
        push mesaj_testare_1
        call [printf]
        add ESP, 4 * 2
        
        POPAD
        PUSHAD
        push EBX
        push mesaj_testare_2
        call [printf]
        add ESP, 4 * 2
        POPAD
        
        ; Sarim daca urmeaza o impartire la 0
        cmp EBX, 0
        jz invalid
        
        cdq  ; EAX -> EDX:EAX
        idiv EBX  ; EAX = CATUL
        mov [rezultat], EAX  ; Rezultatul in rezultat

        push dword [rezultat]
        push dword mesaj_afisare
        call [printf]
        add ESP, 4 * 2
        
        sfarsit:
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

        invalid:
        push dword mesaj_invalid
        call [printf]
        add ESP, 4
        jmp sfarsit