; #########################################################################

    ; Include & Lib files
    ; ~~~~~~~~~~~~~~~~~~~
    ; include    drv:\path\comdlg32.inc
    ; includelib drv:\path\comdlg32.lib

    ; Prototypes
    ; ~~~~~~~~~~
    ; GetFileName  PROTO :DWORD,:DWORD,:DWORD
    ; SaveFileName PROTO :DWORD,:DWORD,:DWORD
    ; FillBuffer   PROTO :DWORD,:DWORD,:BYTE

    ; in .data section for both Open & Save dlg procs
    ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    ; szFileName db 260 dup(0)
    ; ofn        OPENFILENAME <>  ; structure

    ; Example
    ; ~~~~~~~

    ;  jmp @@@1
    ;    szTitle   db "Open A File",0
    ;    szFilter  db "All files",0,"*.*",0,0
    ;  @@@1:

    ;  invoke FillBuffer,ADDR szFileName,length szFileName,0
    ;  invoke GetFileName,hWin,ADDR szTitle,ADDR szFilter

    ;  cmp szFileName[0],0  ;<< zero if cancel pressed in dlgbox
    ;  je @@nxt1

    ;  ; file name returned in szFileName
    ;  invoke MessageBox,hWin,ADDR szFileName,
    ;                    ADDR szDisplayName,MB_OK
    ;  @@nxt1:


; #########################################################################

GetFileName proc hParent:DWORD,lpTitle:DWORD,lpFilter:DWORD

    mov ofn.lStructSize,        sizeof OPENFILENAME
    m2m ofn.hWndOwner,          hParent
    m2m ofn.hInstance,          hInstance
    m2m ofn.lpstrFilter,        lpFilter
    m2m ofn.lpstrFile,          offset szFileName
    mov ofn.nMaxFile,           sizeof szFileName
    m2m ofn.lpstrTitle,         lpTitle
    mov ofn.Flags,              OFN_EXPLORER or OFN_FILEMUSTEXIST or \
                                OFN_LONGNAMES

    invoke GetOpenFileName,ADDR ofn

    ret

GetFileName endp

; #########################################################################

SaveFileName proc hParent:DWORD,lpTitle:DWORD,lpFilter:DWORD

    mov ofn.lStructSize,        sizeof OPENFILENAME
    m2m ofn.hWndOwner,          hParent
    m2m ofn.hInstance,          hInstance
    m2m ofn.lpstrFilter,        lpFilter
    m2m ofn.lpstrFile,          offset szFileName
    mov ofn.nMaxFile,           sizeof szFileName
    m2m ofn.lpstrTitle,         lpTitle
    mov ofn.Flags,              OFN_EXPLORER or OFN_LONGNAMES
                                
    invoke GetSaveFileName,ADDR ofn

    ret

SaveFileName endp

; ########################################################################

FillBuffer proc lpBuffer:DWORD,lenBuffer:DWORD,TheChar:BYTE

    push edi

    mov edi, lpBuffer   ; address of buffer
    mov ecx, lenBuffer  ; buffer length
    mov  al, TheChar    ; load al with character
    rep stosb           ; write character to buffer until ecx = 0

    pop edi

    ret

FillBuffer endp

; ########################################################################
