; Problema Rezolvata: a * [ b + c + d/b ] + d
; Student: Stelian Stoian
; Grupa: 216

; Rezultat cautat pentru valorile date: AX = 0267

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
    d dw 15

segment  code use32 class=code ; segmentul de cod
start: 

    mov AX, [d] ; AX = d
    
    div byte [b]    ; AL = AX / b (in acest caz 0h)
                    ; AH = AX % b (in acest caz 0Fh
    
    mov BL, [b] ; BL = b
    add BL, [c] ; BL = b + c
    add BL, AL  ; BL = b + c + d/b
    
    mov AL, [a] ; AL = a
    mul BL      ; AX = AL * BL
    
    add AX, [d] ; Rezultat final in AX
    
    
        
	push   dword 0 ; se pune pe stiva codul de retur al functiei exit
	call   [exit]  ; apelul functiei sistem exit pentru terminarea executiei programului	
