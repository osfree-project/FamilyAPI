@echo off
cd real
call make
cd ..
echo Building 16-bit memory subsystem
wmake -h
echo 16-bit memory subsystem build finished
