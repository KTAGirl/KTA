Scriptname ARTH_LAL_HelgenCaveTriggerScript extends ObjectReference

ARTH_LAL_RumorsOfWarScript Property ARTHLALRumorsOfWarQuest Auto
Quest Property CW02A Auto
Quest Property CW02B Auto

Event OnTriggerEnter( ObjectReference ActorRef )
	if( Game.GetPlayer() == ActorRef )
		if( ARTHLALRumorsOfWarQuest.GetStage() >= 200 && ARTHLALRumorsOfWarQuest.GetStage() <= 220 )
			;If the player has not yet been told to go to Korvunjund, execute moving Hadvar and Ralof into the cave.
			if( CW02A.GetStageDone(10) == 0 && CW02B.GetStageDone(10) == 0 )
				if( ARTHLALRumorsOfWarQuest.GetStageDone(206) == 0 )
					ARTHLALRumorsOfWarQuest.PolygonTriggered = False
					ARTHLALRumorsOfWarQuest.SetStage(206)
				EndIf
				ARTHLALRumorsOfWarQuest.SetStage(221)
			EndIf
		EndIf
	EndIf
EndEvent

Event OnTriggerLeave( ObjectReference ActorRef )
	if( Game.GetPlayer() == ActorRef )
		if( ARTHLALRumorsOfWarQuest.GetStage() == 221 )
			ARTHLALRumorsOfWarQuest.SetStage(222)
		EndIf

		Self.Disable()
	EndIf
EndEvent
