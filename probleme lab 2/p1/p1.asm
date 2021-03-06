; Problema Rezolvata: 4-5
; Student: Stelian Stoian
; Grupa: 216

; Rezultat cautat pentru valorile date: AL = FF

bits 32 ;asamblare si compilare pentru arhitectura de 32 biti
; definim punctul de intrare in programul principal
global  start 

extern  exit ; indicam asamblorului ca exit exista, chiar daca noi nu o vom defini
import  exit msvcrt.dll; exit este o functie care incheie procesul, este definita in msvcrt.dll
        ; msvcrt.dll contine exit, printf si toate celelalte functii C-runtime importante
segment  data use32 class=data ; segmentul de date in care se vor defini variabilele 


segment  code use32 class=code ; segmentul de cod
start: 
	mov AL, 4   ; mutam valoarea 4 in registrul AL
    sub AL, 5   ; scadem 5 din AL
	
	push   dword 0 ; se pune pe stiva codul de retur al functiei exit
	call   [exit]  ; apelul functiei sistem exit pentru terminarea executiei programului	
