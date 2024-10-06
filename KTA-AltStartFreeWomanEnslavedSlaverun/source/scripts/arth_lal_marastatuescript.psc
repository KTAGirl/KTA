Scriptname ARTH_LAL_MaraStatueScript extends ObjectReference  

ARTH_LAL_StartQuest Property ChargenQuest Auto
Sound Property MaraGreetSound Auto

Event OnActivate( ObjectReference akActor )
	if( akActor == Game.GetPlayer() )
		ChargenQuest.ResetMenuChoices()
		MaraGreetSound.Play(Self)
	EndIf
EndEvent
