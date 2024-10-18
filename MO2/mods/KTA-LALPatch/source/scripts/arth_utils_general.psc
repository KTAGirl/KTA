Scriptname ARTH_UTILS_General Extends Quest

;Enable entries in a formlist
Function EnableFormlist( FormList EnableList )
	int idx = EnableList.GetSize()
	
	while( idx > 0 )
		idx -= 1
		
		ObjectReference Object = EnableList.GetAt(idx) as ObjectReference
		Object.EnableNoWait()
	EndWhile
EndFunction

;Disable entries in a formlist
Function DisableFormlist( FormList DisableList )
	int idx = DisableList.GetSize()
	
	while( idx > 0 )
		idx -= 1
		
		ObjectReference Object = DisableList.GetAt(idx) as ObjectReference
		Object.DisableNoWait()
	EndWhile
EndFunction
