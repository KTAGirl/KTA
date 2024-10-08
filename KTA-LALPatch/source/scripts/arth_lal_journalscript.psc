Scriptname ARTH_LAL_JournalScript extends ObjectReference  

Quest Property ARTHLALRumorsOfWarQuest Auto

Event OnRead()
	if( ARTHLALRumorsOfWarQuest.GetStage() < 220 )
		ARTHLALRumorsOfWarQuest.SetStage(220)
	endif
EndEvent
