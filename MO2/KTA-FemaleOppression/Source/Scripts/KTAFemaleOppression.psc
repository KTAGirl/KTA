Scriptname KTAFemaleOppression extends activemagiceffect  

Spell Property MonitorInventory Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	akTarget.AddSpell(MonitorInventory)
EndEvent