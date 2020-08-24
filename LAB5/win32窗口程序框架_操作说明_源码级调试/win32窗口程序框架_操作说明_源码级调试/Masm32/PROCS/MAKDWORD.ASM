; MAKEDWORD

    mov  ecx,40  ; loword
    mov  eax,20  ; hiword
    shl  eax,16
    mov  ax, cx

    ; result in eax