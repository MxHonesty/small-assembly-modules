; Problema Rezolvata: 2 - (c + d) + (a + b - c)
; Student: Stelian Stoian
; Grupa: 216

; Rezultat cautat pentru valorile date: AL = 0C

bits 32 ;asamblare si compilare pentru arhitectura de 32 biti
; definim punctul de intrare in programul principal
global  start 

extern  exit ; indicam asamblorului ca exit exista, chiar daca noi nu o vom defini
import  exit msvcrt.dll; exit este o functie care incheie procesul, este definita in msvcrt.dll
        ; msvcrt.dll contine exit, printf si toate celelalte functii C-runtime importante
segment  data use32 class=data ; segmentul de date in care se vor defini variabilele 

    a db 15
    b db 30
    c db 10
    d db 15

segment  code use32 class=code ; segmentul de cod
start: 
	mov AL, 2 ; Mutam valoarea 2 in AL
    
    mov BL, [c] ; Mutam valoarea lui c in BL pentru adunarea cu d
    add BL, [d] ; Adunam valoarea lui d in BL
                ; Acum in BL avem c + d
    sub AL, BL  ; Acum in AL avem 2 - (c + d)
    mov BL, [a]
    add BL, [b]
    sub BL, [c] ; Acum in BL avem a + b - c
    
    add AL, BL  ; Rezultat final in AL
    
	push   dword 0 ; se pune pe stiva codul de retur al functiei exit
	call   [exit]  ; apelul functiei sistem exit pentru terminarea executiei programului	
