; post1d.asm - Ayala
ORG 100h

section .data
    cad1   db "NASM x86", 0
    cad2   db "NASM x86", 0
    cad3   db "NASM ARM", 0
    msgIg  db "Iguales.$"
    msgDif db "Diferentes.$"
    crlf   db 0Dh, 0Ah, "$"

section .text
start:
    mov ax, ds
    mov es, ax

    ; Caso 1: cad1 vs cad2
    mov si, cad1
    mov di, cad3
    mov cx, 8
    cld
    repe cmpsb          ; Comparar mientras sean iguales
    je .iguales1
    
    mov dx, msgDif
    jmp .mostrar1
.iguales1:
    mov dx, msgIg
.mostrar1:
    mov ah, 09h
    int 21h

    ; (Repetir lógica para cad1 vs cad3...)
    ; Al comparar con cad3, se detendrá en el 5to carácter ('x' vs 'A')
    
    mov ah, 4Ch
    int 21h