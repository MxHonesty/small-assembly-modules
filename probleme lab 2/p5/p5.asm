; Problema Rezolvata: (a * d + e) / [c + h/(c - b)]
; Student: Stelian Stoian
; Grupa: 216

; Rezultat cautat pentru valorile date: AL = 01

bits 32 ;asamblare si compilare pentru arhitectura de 32 biti
; definim punctul de intrare in programul principal
global  start 

extern  exit ; indicam asamblorului ca exit exista, chiar daca noi nu o vom defini
import  exit msvcrt.dll; exit este o functie care incheie procesul, este definita in msvcrt.dll
        ; msvcrt.dll contine exit, printf si toate celelalte functii C-runtime importante
segment  data use32 class=data ; segmentul de date in care se vor defini variabilele 

    a db 16
    b db 12
    c db 67
    d db 53
    
    e dw 5316
    f dw 10
    g dw 2
    h dw 5312
    
segment  code use32 class=code ; segmentul de cod
start: 

    mov AL, [a]   ; AL = a
    mul byte [d]  ; AX = a * d
    add AX, [e]   ; AX = Prima parte a operatiei
    mov BX, AX    ; Eliberam AX, BX = Prima parte a operatiei
    
    mov CL, [c]   ; CL = c
    sub CL, [b]   ; CL = c - b
    
    mov AX, [h]   ; AX = h
    div CL        ; AL = AX / CL
                  ; AH = AX % CL
    add AL, [c]   ; AL = c + h/(c-b)
                  ; AL = A doua parte a operatiei
                  
    mov CL, AL
    mov AX, BX
    div CL        ; AL = Rezultat final
        
	push   dword 0 ; se pune pe stiva codul de retur al functiei exit
	call   [exit]  ; apelul functiei sistem exit pentru terminarea executiei programului	
