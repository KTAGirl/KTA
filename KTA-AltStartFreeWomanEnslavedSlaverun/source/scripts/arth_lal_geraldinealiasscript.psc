Scriptname ARTH_LAL_GeraldineAliasScript extends ReferenceAlias  

ARTH_LAL_FarmhouseProfitsScript Property ProfitsQuest Auto

Event OnDeath( Actor akActor )
	ProfitsQuest.GeraldineDead = True
EndEvent
