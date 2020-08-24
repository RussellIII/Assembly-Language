@echo off

if not exist rsrc.rc goto over1
D:\MASM32\BIN\Rc.exe /v rsrc.rc
D:\MASM32\BIN\Cvtres.exe /machine:ix86 rsrc.res
:over1

if exist %1.obj del usemacro.obj
if exist %1.exe del usemacro.exe

D:\MASM32\BIN\Ml.exe /c /coff usemacro.asm
if errorlevel 1 goto errasm

if not exist rsrc.obj goto nores

D:\MASM32\BIN\Link.exe /SUBSYSTEM:WINDOWS usemacro.obj rsrc.obj
if errorlevel 1 goto errlink

dir usemacro
goto TheEnd

:nores
D:\MASM32\BIN\Link.exe /SUBSYSTEM:WINDOWS usemacro.obj
if errorlevel 1 goto errlink
dir %1
goto TheEnd

:errlink
echo _
echo Link error
goto TheEnd

:errasm
echo _
echo Assembly Error
goto TheEnd

:TheEnd

pause

