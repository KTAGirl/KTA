Scriptname ARTH_LAL_ThalmorPartyTriggerFix extends ObjectReference  
{Failsafe to make sure the Thalmor party setup works properly.}

Quest Property ARTHLALRumorsOfWarQuest Auto
ObjectReference Property ThalmorBarracksDoor Auto
ObjectReference Property ThalmorEmbassyGate Auto
ObjectReference Property ElenwensDoor Auto
ObjectReference Property ARTHLALAltmerTrigsParent Auto
Faction Property ThalmorFaction Auto

Event OnTriggerEnter( ObjectReference TriggerRef )
	if( TriggerRef == Game.GetPlayer() )
		if( ARTHLALRumorsOfWarQuest.GetStageDone(108) == 1 )
			ThalmorBarracksDoor.SetLockLevel(255)
			ThalmorBarracksDoor.Lock(true)
			ThalmorEmbassyGate.SetOpen(false)
			ThalmorEmbassyGate.Lock(true)
			ElenwensDoor.SetLockLevel(20)
			ElenwensDoor.Lock(false)
			ARTHLALAltmerTrigsParent.Enable()
			Game.GetPlayer().RemoveFromFaction(ThalmorFaction)
		endif
	endif
Endevent
