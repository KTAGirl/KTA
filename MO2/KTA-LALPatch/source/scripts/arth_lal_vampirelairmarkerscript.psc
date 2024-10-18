Scriptname ARTH_LAL_VampireLairMarkerScript extends ReferenceAlias  

ARTH_LAL_FriendlyFireScript Property FriendlyFire Auto
Faction Property ARTHLALBanditVampireFaction Auto
LocationAlias Property VampireLairLocation Auto
Location Property StartLoc Auto Hidden
bool DoOnce

Event OnLoad()
	OnUpdate()

	if( DoOnce == 0 )
		StartLoc = VampireLairLocation.GetLocation()
		DoOnce = 1
	EndIf

	Game.GetPlayer().AddToFaction(ARTHLALBanditVampireFaction)
	;debug.Notification( "LAL: Entering vampire start location." )
EndEvent

Event OnUnload()
	if( Game.GetPlayer().GetCurrentLocation() != StartLoc )
		Game.GetPlayer().RemoveFromFaction(ARTHLALBanditVampireFaction)
		UnregisterForUpdate()
		;debug.Notification( "LAL: Leaving vampire start location." )
	EndIf
EndEvent

Event OnUpdate()
	bool BeingBad = FriendlyFire.AssaultCheck( Game.GetPlayer() )

	if( BeingBad == True )
		GetOwningQuest().Stop()
	Else
		RegisterForSingleUpdate(0.5)
	EndIf
EndEvent
