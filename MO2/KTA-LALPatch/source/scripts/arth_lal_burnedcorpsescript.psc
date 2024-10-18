Scriptname ARTH_LAL_BurnedCorpseScript extends ObjectReference  

Book Property Journal Auto
Book Property AltJournal Auto
Message Property JournalMessage Auto
Quest Property MQ102 Auto
Quest Property CW02A Auto
Quest Property CW02B Auto
Actor Property Player Auto
ARTH_LAL_RumorsOfWarScript Property ARTHLALRumorsOfWarQuest Auto

Event OnActivate( ObjectReference ActorRef )
	if( ActorRef == Player )
		if( CW02A.GetStageDone(30) == 0 && CW02B.GetStageDone(30) == 0 )
			Player.AddItem( Journal )
		Else
			Player.AddItem( AltJournal )
		EndIf
		Self.Disable()
		JournalMessage.Show()

		if( MQ102.GetStage() < 5 )
			MQ102.SetStage(5)
			MQ102.SetStage(14)
			ARTHLALRumorsOfWarQuest.SetStage(210)
		endif
		
		if( ARTHLALRumorsOfWarQuest.IsRunning() )
			ARTHLALRumorsOfWarQuest.SetObjectiveCompleted(29)
			ARTHLALRumorsOfWarQuest.SetObjectiveDisplayed(25)
		EndIf
		Self.DeleteWhenAble()
	EndIf
EndEvent
