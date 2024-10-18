Scriptname ARTH_LAL_WhiterunGateLockScript extends ReferenceAlias  

ARTH_LAL_RumorsOfWarScript Property ARTHLALRumorsOfWarQuest Auto

event OnLoad()
	Utility.Wait(5) ; So the vanilla monitor script runs first.

	if( ARTHLALRumorsOfWarQuest.GuardShouldConfront == True )
		GetReference().Lock(True)
	Else
		GetReference().Lock(False)
	EndIf
endEvent
