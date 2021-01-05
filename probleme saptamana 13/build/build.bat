@echo off
cmd /k "nasm -fobj problema6.asm & nasm -fobj gaseste_prefix.asm & alink problema6.obj gaseste_prefix.obj -oPE -subsys console -entry start"
