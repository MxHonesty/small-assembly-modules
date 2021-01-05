bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, scanf, printf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import scanf msvcrt.dll
import printf msvcrt
                          
; our data is declared here (the variables needed by our program)
segment data use32 class=data
   a dd -1  ; FF
   format db "%d", 0

 
segment code use32 class=code
    start:
        push dword a
        push dword format
        call [scanf]
        add ESP, 8

        mov EAX, [a]  ; AL = a
        cmp EAX, 0
        JS modul
        
        
        final:
        push EAX
        push dword format
        call [printf]
        add ESP, 8

        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
        
        modul:
        xor EAX, 0xFFFFFFFF 
        add EAX, 1
        jmp final
