@echo off

\masm32\bin\ml /c /coff /Cp mhook.asm

\masm32\bin\Link /SECTION:.bss,S  /DLL /DEF:mhook.def /SUBSYSTEM:WINDOWS /LIBPATH:\masm32\lib mhook.obj

pause