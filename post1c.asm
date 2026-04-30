; post1c.asm - Ayala
ORG 100h

section .data
    cadena  db "Arquitectura de Computadores", 0
    longCad equ 29
    msgHall db "Hallado en posicion: $"
    msgNoH  db "No encontrado.$"

section .text
start:
    mov ax, ds
    mov es, ax

    mov di, cadena
    mov al, "u"         ; Carácter a buscar
    mov cx, longCad
    cld
    repne scasb         ; Buscar mientras no sea igual

    jne .noHallado      ; Si ZF=0 al final, no se encontró

    ; Calcular posición (DI quedó un byte adelante del hallazgo)
    mov bx, di
    sub bx, cadena
    dec bx              ; Ajustar a índice base-0

    mov ah, 09h
    mov dx, msgHall
    int 21h

    ; Imprimir posición (conversión simple para 0-9)
    mov dl, bl
    add dl, 30h
    mov ah, 02h
    int 21h
    jmp .fin

.noHallado:
    mov ah, 09h
    mov dx, msgNoH
    int 21h

.fin:
    mov ah, 4Ch
    int 21h