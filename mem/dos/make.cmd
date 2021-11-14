@echo off
cd 16bit
call make
cd ..
echo Building memory subsystem
wmake -h
echo Memory subsystem build finished
