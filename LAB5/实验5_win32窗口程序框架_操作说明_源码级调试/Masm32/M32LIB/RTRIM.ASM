; #########################################################################

      .386
      .model flat, stdcall  ; 32 bit memory model
      option casemap :none  ; case sensitive

    .code

; ########################################################################

rtrim proc source:DWORD,dest:DWORD

    push esi
    push edi

    mov esi, source
    xor ecx, ecx    ; zero ecx to use as counter

    cld             ; read forward

    @@:
      lodsb
      cmp al, 0         ; exit loop on zero
      je @F
      inc ecx           ; get string length excluding zero
      jmp @B
    @@:

    lea esi, [esi-2]    ; correct esi count

    std                 ; read backwards

    @@:
      lodsb
      dec ecx
      cmp al, 32        ; loop if space
      je  @B
      cmp al, 9         ; loop if tab
      je @B

    cld             ; read forward

    inc ecx
    mov esi, source
    mov edi, dest
    rep movsb

    mov al, 0
    stosb           ; put terminator on string

    pop edi
    pop esi

    ret

rtrim endp

; ########################################################################

end