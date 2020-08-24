; #########################################################################

      .386
      .model flat, stdcall
      option casemap :none   ; case sensitive

; #########################################################################

    include \masm32\include\windows.inc

    ; include \masm32\include\user32.inc
    include \masm32\include\kernel32.inc
    include \masm32\include\masm32.inc

    .code

; #########################################################################

StdIn proc lpszBuffer:DWORD,bLen:DWORD

    LOCAL hInput :DWORD
    LOCAL bRead  :DWORD

    invoke GetStdHandle,STD_INPUT_HANDLE
    mov hInput, eax

    invoke SetConsoleMode,hInput,ENABLE_LINE_INPUT or \
                                 ENABLE_ECHO_INPUT or \
                                 ENABLE_PROCESSED_INPUT

    invoke ReadFile,hInput,lpszBuffer,bLen,ADDR bRead,NULL

    mov eax, bRead

    ret

StdIn endp

; #########################################################################

end
