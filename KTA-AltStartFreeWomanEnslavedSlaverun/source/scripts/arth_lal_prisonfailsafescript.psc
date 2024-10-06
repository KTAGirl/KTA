Scriptname ARTH_LAL_PrisonFailsafeScript extends ObjectReference  
{Returns the player to the prison if they leave before using the bed.}

Quest Property ARTHLALChargenQuest Auto
ObjectReference Property ARTHLALNewStartMarker Auto

Event OnTriggerLeave( ObjectReference akPlayer )
	if( akPlayer == Game.GetPlayer() )
		if( ARTHLALChargenQuest.GetStage() < 20 )
			Utility.Wait(3)
			Game.GetPlayer().MoveTo(ARTHLALNewStartMarker)
		EndIf
	EndIf
EndEvent
