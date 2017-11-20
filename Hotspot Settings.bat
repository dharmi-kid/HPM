@echo off  
title Hotspot Manager
set /a col=%random% %% 9-0
if %col%==7 (goto special)
if %col%==8 (goto special)
color %col%f
call:begin
:special
color %col%1
:begin
%extd% /messageboxcheck "Alert" "PLEASE CHECK HOTSPOT COMPATIBILITY BEFORE ATTEMPTING TO CREATE HOTSPOT" 0 {73E8105A-7AD2-4335-B694-94F837A38E79}
:beg

ECHO 				[                                                           ]
ECHO 				[        Date: %date%  Time: %TIME%            /
ECHO 				[                                                           ]
ECHO 				[ ========================================================= ]
ECHO 				[                                                           ]
ECHO 				[                   Wifi Hotspot Manager                    ]
ECHO 				[                    Written by Dharmy                      ]
ECHO 				[                                                           ]
ECHO 				[========================================================== ]
echo .

%extd% /getcomputername
if %result%=="" (set usernake="Random User") else (set usernake=%result%)




echo Welcome %usernake%
echo ===================================================
echo Please choose an Option 						   
echo .
echo [1] Create New hotspot 
echo *						   
echo [2] Switch Hotspot On
echo *        					   
echo [3] Switch Hotspot Off
echo *
echo [4] Check Hotspot Details
echo *
echo [5] Check Hotspot Password 
echo *
echo [6] Check Hotspot Compatibility [New Users Only!]
echo *
echo [7] exit 										   
echo ========
echo .
set /p opt="Your Option Here: "

if %opt%=="" (goto warning)
if %opt%=== (goto warning)
if %opt%==1 (goto startt)
if %opt%==2 (goto secopt)
if %opt%==3 (goto Thirdopt)
if %opt%==4 (goto Det)
if %opt%==5 (goto Passdet)

if %opt%==6 (goto test)
if %opt%==7 (goto Killswitch)
:warning
%extd% /messagebox "error" "Please enter a valid option" 16
cls
goto beg


:startt
(%extd% /inputbox "Input Name" "Input Desired Hotspot Name")
if "%result%"=="" (%extd% /messagebox "Error" "Please Enter a name") else (goto cont)
goto startt
:cont
(set Hname="%result%")

:Password
%extd% /maskedinputbox "Input Name" "Input Desired Password" 
if "%result%"=="" (%extd% /messagebox "Error" "Invalid Password") else (goto pass)
goto Password
:pass 
set Pass="%result%"
%extd% /maskedinputbox "Input Name" "Confirm Password" 
set conf="%result%"
if %Pass% EQU %conf% (goto Confirm) else (%extd% /messagebox error "Passwords dont match" 16)
goto :Password
:Confirm
%extd% /messagebox "Confirmation" "Create Hotspot?" 1
if %result% EQU 1 goto Hps
if %result% EQU 2 %extd% /messagebox "Prompt" "Hotspot not created"
cls
call:beg
:Hps
netsh wlan set hostednetwork mode=allow ssid=%Hname% key=%Pass%
%extd% /messagebox "Info" "Done, please use start hotspot to enable hotspot"
cls
Call:beg

:secopt
if %opt%==2 (%extd% /messagebox "Prompt" "You are about to start hotspot" 1)
if %result% EQU 1 goto StartH
if %result% EQU 2 %extd% /messagebox "Prompt" "You cancelled the operation"
cls
call:beg

:StartH
netsh wlan start hostednetwork
%extd% /messagebox "Prompt" "Hotspot service started"
cls
call:beg

:Thirdopt
if %opt%==3 (%extd% /messagebox "Prompt" "You are about to stop hotspot" 1)
if %result% EQU 1 goto StopH
if %result% EQU 2 %extd% /messagebox "Prompt" "You cancelled the operation"
cls
call:beg

:stopH
netsh wlan stop hostednetwork
%extd% /messagebox "Prompt" "Hotspot Service stopped"
cls
call:beg


:Det
netsh wlan show hostednetwork
echo Press enter to continue
pause > nul
cls 
call:beg

:Passdet
netsh wlan show hostednetwork setting=security
echo press enter to continue
pause > nul
cls
call:beg

 

:test
%extd% /messagebox "Prompt" "This will create a temporary file on desktop" 1
if %result% equ 1 (call:conT)
if %result% equ 2 (%extd% /messagebox "Error" "operation cancelled by User" 16)
call:beg

:conT 
netsh wlan show drivers >> "%systemdrive%\users\%username%\Desktop\temp.txt"
find /i "hosted" "%systemdrive%\users\%username%\Desktop\temp.txt" 
%extd% /messagebox "Prompt" "Is Hosted Network = Yes ?" 4
if %result% equ 6 (%extd% /messagebox "Prompt" "Your Laptop is an Hotspot Supported Device " ) &&del "%systemdrive%\users\%username%\Desktop\temp.txt" && cls && call:beg
if %result% equ 7 (%extd% /messagebox "Error" "Your Device cannot create hotspot, Exiting Application" 16)
del "%systemdrive%\users\%username%\Desktop\temp.txt"





:Killswitch
taskkill /im cmd.exe /f 