Scriptname ARTH_LAL_KillHelgenNPCsScript extends ObjectReference  

Quest Property ARTHLALHelgenNPCKillerQuest Auto

Event OnTriggerEnter( ObjectReference akActor )
	if( akActor == Game.GetPlayer() )
		if( ARTHLALHelgenNPCKillerQuest.IsRunning() )
			ARTHLALHelgenNPCKillerQuest.SetStage(10)
		EndIf
		GetLinkedRef().Disable()
		Disable()
	EndIf
EndEvent
