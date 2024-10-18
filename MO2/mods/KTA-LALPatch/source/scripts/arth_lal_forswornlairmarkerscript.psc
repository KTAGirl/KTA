Scriptname ARTH_LAL_ForswornLairMarkerScript extends ReferenceAlias  

ARTH_LAL_FriendlyFireScript Property FriendlyFire Auto
Location Property DruadachRedoubtLocation Auto

Event OnLoad()
	OnUpdate()
	;debug.Notification( "LAL: Entering Forsworn start location." )
EndEvent

Event OnUpdate()
	bool BeingBad = FriendlyFire.AssaultCheck( Game.GetPlayer() )

	if( BeingBad == True )
		GetOwningQuest().Stop()
	Else
		RegisterForSingleUpdate(0.5)
	EndIf
EndEvent

Event OnUnload()
	if( Game.GetPlayer().GetCurrentLocation() != DruadachRedoubtLocation )
		UnregisterForUpdate()
		;debug.Notification( "LAL: Leaving Forsworn start location." )
	EndIf
EndEvent
