Scriptname ARTH_LAL_TriggerScript extends ObjectReference  
{Takes the player out of a normally hostile faction upon leaving the area. Puts them back if they return.}

ARTH_LAL_RumorsOfWarScript Property ARTHLALRumorsOfWarQuest Auto
ARTH_LAL_StartQuest Property ChargenQuest Auto
Faction Property ARTHLALBanditVampireFaction Auto
Actor Property Player Auto
Int Property MenuChoice Auto
Int Property BanditCamp Auto

Event OnTriggerLeave ( ObjectReference ActorRef )
	if( ActorRef == Player )
		if( ARTHLALRumorsOfWarQuest.HostileIntent == false )
			if( ChargenQuest.MainMenuChoice == MenuChoice )
				Player.RemoveFromFaction(ARTHLALBanditVampireFaction)
			EndIf
		Else
			Self.Disable()
			Self.Delete()
		EndIf
	endif
EndEvent

Event OnTriggerEnter ( ObjectReference ActorRef )
	if( ActorRef == Player )
		if( ARTHLALRumorsOfWarQuest.HostileIntent == false )
			if( ChargenQuest.MainMenuChoice == MenuChoice && (BanditCamp == -1 || BanditCamp == ChargenQuest.BanditRandom) )
				Player.AddToFaction(ARTHLALBanditVampireFaction)
			EndIf
		Else
			Self.Disable()
			Self.Delete()
		EndIf
	EndIf
EndEvent
