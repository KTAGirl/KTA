Scriptname ARTH_LAL_CheatDetectionScript extends ObjectReference  

ObjectReference Property ARTHLALStopCheatingMarker Auto
ObjectReference Property ARTHLALRalofHadvarBox Auto
Message Property ARTHLALNoConsoleCommandsMessage Auto
Quest Property ChargenQuest Auto
Quest Property MQ102 Auto

Event OnTriggerEnter( ObjectReference akActor )
	if( ChargenQuest.GetStageDone(20) == 0 )
		if( akActor == Game.GetPlayer() )
			if( ARTHLALRalofHadvarBox.IsEnabled() )
				ARTHLALNoConsoleCommandsMessage.Show()
				Game.GetPlayer().MoveTo( ARTHLALStopCheatingMarker )
			endif
		endif
	endif
EndEvent

Event OnLoad()
	if( ChargenQuest.GetStage() >= 222 || MQ102.GetStage() >= 20 )
		ARTHLALRalofHadvarBox.Disable()
	endif
EndEvent
