@echo off
title HOME Network Setup

set eth=Ethernet

echo Switching to HOME network (DHCP)...

netsh interface ip set address name="%eth%" dhcp
netsh interface ip set dns name="%eth%" dhcp

echo.
echo HOME network enabled successfully.
pause