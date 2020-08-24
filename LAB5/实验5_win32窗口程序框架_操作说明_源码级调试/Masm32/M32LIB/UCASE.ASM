; #########################################################################

      .386
      .model flat, stdcall  ; 32 bit memory model
      option casemap :none  ; case sensitive

    .code

; #########################################################################

ucase proc text:DWORD

    ; -----------------------------
    ; converts string to upper case
    ; invoke ucase,ADDR szString
    ; -----------------------------

    push esi
    push edi

    mov esi, text
    mov edi, text
    
    cld

  ucSt:
    lodsb
    cmp al, 0       ; exit on zero terminator
    je ucOut
    cmp al, "a"
    jl @F
    cmp al, "z"
    jg @F
    sub al, 32
  @@:
    stosb
    jmp ucSt

  ucOut:
    stosb

    pop edi
    pop esi

    ret

ucase endp

; #########################################################################

end