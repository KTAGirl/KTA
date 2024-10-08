Scriptname ARTH_LAL_FarmhouseProfitsScript extends Quest Conditional

bool Property Collecting Auto Hidden Conditional
int Property FarmGold Auto Hidden Conditional
MiscObject Property Gold001 Auto
bool Property SavlianDead Auto Hidden
bool Property GeraldineDead Auto hidden

Event OnUpdateGameTime()
	if( SavlianDead && GeraldineDead )
		if( IsObjectiveDisplayed(10) )
			SetObjectiveFailed(10)
		EndIf
		Stop()
	else
		FarmGold += ( 250 + Utility.RandomInt(0,250) )
		SetObjectiveDisplayed(10, abForce = true)
		RegisterForSingleUpdateGameTime(168)
	EndIf
EndEvent

Function GiveGold()
	SetObjectiveCompleted(10)
	Game.GetPlayer().AddItem(Gold001, FarmGold)
	FarmGold = 0
EndFunction
