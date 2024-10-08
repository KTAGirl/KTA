Scriptname ARTH_LAL_SavlianAliasScript extends ReferenceAlias  

ARTH_LAL_FarmhouseProfitsScript Property ProfitsQuest Auto
Actor Property SavlianRef Auto

Event OnDeath( Actor akActor )
	if( SavlianRef && Self.GetActorReference() == SavlianRef )
		ProfitsQuest.SavlianDead = True
		SavlianRef = None
	endif
EndEvent
