Scriptname ARTH_LAL_ThrallStartTriggerScript extends ObjectReference  

Location Property BoulderfallCaveLocation Auto
Faction Property NecromancerFaction Auto

Event OnTriggerLeave( ObjectReference akActor )
	if( akActor == Game.GetPlayer() )
		if( Game.GetPlayer().GetCurrentLocation() != BoulderfallCaveLocation )
			Game.GetPlayer().RemoveFromFaction(NecromancerFaction)
			Self.Disable()
			Self.Delete()
		EndIf
	EndIf
EndEvent
