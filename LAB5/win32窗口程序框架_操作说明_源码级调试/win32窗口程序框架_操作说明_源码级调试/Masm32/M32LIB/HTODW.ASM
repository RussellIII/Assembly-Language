; #########################################################################

    ; --------------------------------------
    ; This procedure was written by Iczelion
    ; --------------------------------------

      .386
      .model flat, stdcall  ; 32 bit memory model
      option casemap :none  ; case sensitive

      include \MASM32\INCLUDE\kernel32.inc

    .code

; #########################################################################

htodw proc uses ebx ecx edi edx esi String:DWORD

    ;------------------------------------
    ; Convert hex string into dword value
    ; Return value in eax
    ;------------------------------------

    LOCAL Result:DWORD

      mov Result, 0
      xor ecx, ecx
      mov edi, String
      invoke lstrlen, String
      mov ebx, 16
      mov esi, eax

      .while esi != 0
        mov al, [edi]
          .if al >= "0" && al <= "9"
            sub al, "0"
          .elseif al >= "a" && al <= "f"
            sub al, "a"
            add al, 10
          .else
            sub al, "A"
            add al, 10
          .endif
        movzx eax, al
        mov ecx, esi
        dec ecx
          .while ecx > 0
            mul ebx
            dec ecx
          .endw
        add Result, eax
        inc edi
        dec esi
      .endw

    mov eax, Result
    ret

htodw endp

; #########################################################################

end