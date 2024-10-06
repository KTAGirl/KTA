Scriptname ARTH_LAL_DGCheckTriggerScript extends ObjectReference  
{A one time check in the event the player picks the Vigilants and plays through to the Hall's destruction all in one sitting}

ARTH_LAL_StartQuest Property ChargenQuest Auto
ObjectReference Property DLC1HallRuinedState Auto
ObjectReference Property VigilantVanillaChest Auto
ObjectReference Property VigilantDGChest Auto

Event OnTriggerEnter(ObjectReference ActorRef)
	if( ActorRef == Game.GetPlayer() )
		if( DGVigilantsCheck() == true )
			disable()
			delete()
		EndIf
	EndIf
EndEvent

bool Function DGVigilantsCheck()
	if( ChargenQuest.MainMenuChoice == 15 )
		if( DLC1HallRuinedState.IsEnabled() )
			VigilantVanillaChest.RemoveAllItems(VigilantDGChest, true, true)
			
			return True
		EndIf
	EndIf
	
	return False
EndFunction
