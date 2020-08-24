; ########################################################################

;   This module was written by f0dder. f0dder is a student from Denmark.

; ########################################################################

    .386
    .model flat, stdcall
    option casemap :none   ; case sensitive

    .code

; ########################################################################

dw2hex proc source:DWORD, lpBuffer:DWORD

    push esi
    push edi

    mov esi, source
    mov edi, lpBuffer

  ; this is one byte shorter than "mov ecx, 7".

    xor    ecx, ecx
    mov    cl, 7            ; length of hexstring - 1

  hexloop:
    mov    eax, esi         ; we're going to work on AL
    and    al, 00001111b    ; mask out high nibble

  ; do the black magic, this converts byte(AL) into asciihex(AL)

    add    al, 90h
    daa
    adc    al, 40h
    daa

    mov    [edi + ecx], al  ; store the asciihex(AL) in the string
    shr    esi, 4           ; next nibble
    dec    ecx              ; decrease counter (one byte less than dec cl :-)
    jns    hexloop          ; eat them if there's any more

    pop edi
    pop esi

    ret

dw2hex endp

; #########################################################################

end