; #########################################################################

      .386
      .model flat, stdcall  ; 32 bit memory model
      option casemap :none  ; case sensitive

    .code

; #########################################################################

lcase proc text:DWORD

    ; -----------------------------
    ; converts string to lower case
    ; invoke lcase,ADDR szString
    ; -----------------------------

    push esi
    push edi

    mov esi, text
    mov edi, text
    
    cld

  lcSt:
    lodsb
    cmp al, 0       ; exit on zero terminator
    je lcOut
    cmp al, "A"
    jl @F
    cmp al, "Z"
    jg @F
    add al, 32
  @@:
    stosb
    jmp lcSt

  lcOut:
    stosb

    pop edi
    pop esi

    ret

lcase endp

; #########################################################################

end