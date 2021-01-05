bits 32                         
segment code use32 public code
global afisare

extern printf


format_string db "factorial=%d", 10, 13, 0

afisare:
    push format_string
	call [printf]
	
    ret 1