;
; AutoHotkey Version: 1.x
; Language:       English
; Original author (to paste):         Lowell Heddings | geek@howtogeek.com
; Fixed and extended by:    Alberto Buffolino | a.buffolino@gmail.com
;
; Script Function:
;	enable paste (ctrl+v), close (alt+f4) or duplicate (alt+d) shortcuts in Windows command prompt.

#NoTrayIcon
#SingleInstance, force
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode, Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir, %A_ScriptDir%  ; Ensures a consistent starting directory.

#IfWinActive ahk_class ConsoleWindowClass
^v::
CleanClip :=
StringReplace, CleanClip, Clipboard, `r, , All
StringReplace, CleanClip, CleanClip, `n, , All
KeyWait, Ctrl
SendInput, {Raw}%CleanClip%
return
!x::
SendInput, exit`n
return
!F4::
SendInput, exit`n
return
!D::
Run, AdvCmd.exe
return
