;ControlFocus("title","text",controlID) Edit1=Edit instance 1
ControlFocus("����Ϊ", "","Edit1")


; Wait 10 seconds for the Upload window to appear
WinWait("[CLASS:#32770]","",10)
Sleep(1500)
; Set the File name text on the Edit field

ControlSetText("����Ϊ", "", "Edit1", $CmdLine[1])

Sleep(1500)

; Click on the Open button

ControlClick("����Ϊ", "","Button2");