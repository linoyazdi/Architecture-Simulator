Menu, MyMenu, Add, 0, MenuHandler
Menu, MyMenu, Add, 1, MenuHandler
Menu, MyMenu, Add, 2, MenuHandler
Menu, MyMenu, Add, 3, MenuHandler
Menu, MyMenu, Add, 5, MenuHandler

Menu, MyMenu, Show
return  ; End of script's auto-execute section.

MenuHandler:
MsgBox You selected Task %A_ThisMenuItem%  
MsgBox Please do not touch the computer until the proccess is finished 


Loop Files, %A_WorkingDir%\Projects\*.CircuitProject, R  ; Recurse into subfolders.
{

	Run, "%A_WorkingDir%\LogicCircuit\LogicCircuit.exe" "%A_LoopFileFullPath%"  /r execfile(r"'%A_WorkingDir%\test.py'")
	WinWaitActive, IronPython Console, , 10
	if ErrorLevel
	{
		MsgBox, WinWait timed out.
		return
	}
	else
	{
		sleep 1000
		SplitPath, A_LoopFileLongPath, OutFileName, OutDir, OutExtension, OutNameNoExt, OutDrive
		sleep 2000
		Send Test(%A_ThisMenuItem% ,'%A_WorkingDir%\Reports\T%A_ThisMenuItem% -','%OutNameNoExt%')
		sleep 2000
		Send {Enter}
		WinWaitClose  
	}
	}
	
	MsgBox Finished Task %A_ThisMenuItem% 
	ExitApp