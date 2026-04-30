; post1.asm - Ayala
ORG 100h

section .data
    origen  db "HOLA, MUNDO!", 0    ; 13 bytes (incluyendo el nulo)
    destino db 13 dup(0)
    msgCop  db "Copiado: $"
    crlf    db 0Dh, 0Ah, "$"

section .text
start:
    ; Preparar ES = DS para operaciones de cadena
    mov ax, ds
    mov es, ax

    ; --- PARTE OPTIMIZADA (Paso 2) ---
    mov si, origen
    mov di, destino
    mov cx, 13          ; Longitud total
    cld                 ; DF = 0: punteros incrementan

    mov ax, cx          ; Guardar longitud original
    shr cx, 1           ; Dividir por 2 (copiaremos Words)
    rep movsw           ; Copiar 6 words (12 bytes)

    and ax, 1           ; ¿Es longitud impar?
    jz .mostrar         ; Si es par, terminar
    movsb               ; Copiar el último byte (el número 13)

.mostrar:
    mov ah, 09h
    mov dx, msgCop
    int 21h
    mov dx, destino
    int 21h
    mov dx, crlf
    int 21h

    mov ah, 4Ch
    xor al, al
    int 21h