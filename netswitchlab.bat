@echo off
title LAB Network Setup

set eth=Ethernet

echo Switching to LAB network...

netsh interface ip set address name="%eth%" static 10.2.11.80 255.255.252.0 10.2.8.1
netsh interface ip set dns name="%eth%" static 8.8.8.8

echo.
echo LAB network configured successfully.
pause