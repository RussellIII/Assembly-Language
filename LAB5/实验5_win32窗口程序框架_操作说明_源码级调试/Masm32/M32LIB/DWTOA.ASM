; #########################################################################

    ; -----------------------------------------
    ; This procedure was written by Tim Roberts
    ; -----------------------------------------

      .386
      .model flat, stdcall  ; 32 bit memory model
      option casemap :none  ; case sensitive

    .code

; #########################################################################

dwtoa proc public uses esi edi dwValue:DWORD, lpBuffer:PTR BYTE
	
    ; -------------------------------------------------------------
    ; convert DWORD to ascii string
    ; dwValue is value to be converted
    ; lpBuffer is the address of the receiving buffer
    ; EXAMPLE:
    ; invoke dwtoa,edx,ADDR buffer
    ;
    ; Uses: eax, ecx, edx.
    ; -------------------------------------------------------------

    mov	eax, dwValue
    mov edi, [lpBuffer]

  .if (eax != 0)

    ; Is the value negative?

    .if	(sdword ptr eax < 0)
      mov byte ptr [edi], '-'	; store a minus sign
      inc edi
      neg eax			; and invert the value
    .endif

    mov esi, edi		; save pointer to first digit

    mov ecx, 10
    .while (eax > 0)		; while there is more to convert...
      xor edx, edx
      div ecx			; put next digit in edx
      add dl, '0'		; convert to ASCII
      mov [edi], dl		; store it
      inc edi
    .endw

    mov byte ptr [edi], 0	; terminate the string

    ; We now have all the digits, but in reverse order.

    .while (esi < edi)
      dec edi
      mov al, [esi]
      mov ah, [edi]
      mov [edi], al
      mov [esi], ah
      inc esi
    .endw

  .else
    mov word ptr [edi], 0030H     ; string "0", 0 in little endian
  .endif

    ret

dwtoa endp

; #########################################################################

end
