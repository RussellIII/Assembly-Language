rem 请根据Masm32软件包的安装目录修改下面的Masm32Dir环境变量！
@echo off
set Masm32Dir=d:\Masm32
set include=%Masm32Dir%\Include;%include%
set lib=%Masm32Dir%\lib;%lib%
set path=%Masm32Dir%\Bin;%Masm32Dir%;%PATH%
set Masm32Dir=
echo on