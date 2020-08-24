; #########################################################################

      .386
      .model flat, stdcall  ; 32 bit memory model
      option casemap :none  ; case sensitive

    include masm32.inc

    .code

; ########################################################################

rstr proc source:DWORD, dest:DWORD, lnth:DWORD

    push esi
    push edi

    cld                 ; read forward

    invoke lnstr, source
    sub eax, lnth

    mov esi, source
    mov edi, dest
    add esi, eax
    mov ecx, lnth
    rep movsb

    mov al, 0
    stosb

    pop edi
    pop esi

    ret

rstr endp

; ########################################################################

end