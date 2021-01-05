; Problema Rezolvata: d - (a + b) - ( c + c )
; Student: Stelian Stoian
; Grupa: 216

; Rezultat cautat pentru valorile date: AX = FFCE

bits 32 ;asamblare si compilare pentru arhitectura de 32 biti
; definim punctul de intrare in programul principal
global  start 

extern  exit ; indicam asamblorului ca exit exista, chiar daca noi nu o vom defini
import  exit msvcrt.dll; exit este o functie care incheie procesul, este definita in msvcrt.dll
        ; msvcrt.dll contine exit, printf si toate celelalte functii C-runtime importante
segment  data use32 class=data ; segmentul de date in care se vor defini variabilele 

    a dw 15
    b dw 30
    c dw 10
    d dw 15

segment  code use32 class=code ; segmentul de cod
start: 

	mov AX, [d] ; Mutam valoarea d in AX
    mov BX, [a] ; Mutam valoarea a in BX
    add BX, [b] ; BX = a + b
    sub AX, BX  ; AX = d - (a + b)
    
    mov BX, [c]
    add BX, [c] ; BX = c + c
    
    sub AX, BX  ; Rezultat final in AX
        
	push   dword 0 ; se pune pe stiva codul de retur al functiei exit
	call   [exit]  ; apelul functiei sistem exit pentru terminarea executiei programului	
