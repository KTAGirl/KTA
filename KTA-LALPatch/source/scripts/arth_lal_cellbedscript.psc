Scriptname ARTH_LAL_CellBedScript extends ObjectReference
{Use the Statue choices to place the player in their new starting area.}

ARTH_LAL_StartQuest Property ChargenQuest Auto
Armor Property ClothesPrisoner Auto
Armor Property ClothesPrisonerShoes Auto
Armor Property PrisonerCuffsPlayer Auto
Message Property BedMessage  Auto  
Actor Property Player Auto

Event OnActivate( ObjectReference  akActorRef )
	;Player hasn't picked anything yet, or chose the cell escape option.
	if( ChargenQuest.StartChosen == False || ChargenQuest.EscapeOptionUsed == True )
		BedMessage.Show()
	;Vanilla game start. It handles its own details.
	ElseIf( ChargenQuest.MainMenuChoice == 0 )
		Game.FadeOutGame(False, true, 12.0, 12.0)
		Player.EquipItem(PrisonerCuffsPlayer, abSilent = true) ; Fix by arranz
		ChargenQuest.SetStage(20)
	;Call LAL stage 30, which cleans up Helgen then calls the add-on quests.
	Else
		Game.FadeOutGame(False, true, 12.0, 12.0)
		Player.RemoveItem(ClothesPrisoner, abSilent = true)
		Player.RemoveItem(ClothesPrisonerShoes, abSilent = true)
		ChargenQuest.SetStage(30)
	endif
EndEvent
