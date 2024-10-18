Scriptname ARTH_LAL_BanditLairMarkerScript extends ReferenceAlias  

Faction Property ARTHLALBanditVampireFaction Auto
LocationAlias Property BanditLairLocation Auto
Location Property StartLoc Auto Hidden
bool DoOnce

Location property HaafingarHoldLocation auto
Location property ReachHoldLocation auto
Location property HjaalmarchHoldLocation auto
Location property WhiterunHoldLocation auto
Location property FalkreathHoldLocation auto
Location property PaleHoldLocation auto
Location property WinterholdHoldLocation auto
Location property EastmarchHoldLocation auto
Location property RiftHoldLocation auto
Location Property DLC2SolstheimLocation Auto

faction Property CrimeFactionHaafingar Auto					
faction Property CrimeFactionReach Auto					
faction Property CrimeFactionHjaalmarch Auto					
faction Property CrimeFactionWhiterun Auto					
faction Property CrimeFactionFalkreath Auto					
faction Property CrimeFactionPale Auto					
faction Property CrimeFactionWinterhold Auto					
faction Property CrimeFactionEastmarch Auto	
faction Property CrimeFactionRift Auto
Faction Property DLC2CrimeRavenRockFaction Auto

ARTH_LAL_FriendlyFireScript Property FriendlyFire Auto

Faction Function GetCrimeFactionForLoc( Location StartLocation )
	Faction ReturnFaction

	;debug.Trace( "LAL: StartLocation " + StartLocation )

	If HaafingarHoldLocation.IsChild(StartLocation)
		ReturnFaction = CrimeFactionHaafingar
	ElseIf ReachHoldLocation.IsChild(StartLocation)
		ReturnFaction = CrimeFactionReach
	ElseIf HjaalmarchHoldLocation.IsChild(StartLocation)
		ReturnFaction = CrimeFactionHjaalmarch
	ElseIf WhiterunHoldLocation.IsChild(StartLocation)
		ReturnFaction = CrimeFactionWhiterun
	ElseIf FalkreathHoldLocation.IsChild(StartLocation)
		ReturnFaction = CrimeFactionFalkreath
	ElseIf PaleHoldLocation.IsChild(StartLocation)
		ReturnFaction = CrimeFactionPale
	ElseIf WinterholdHoldLocation.IsChild(StartLocation)
		ReturnFaction = CrimeFactionWinterhold
	ElseIf EastmarchHoldLocation.IsChild(StartLocation)
		ReturnFaction = CrimeFactionEastmarch
	ElseIf RiftHoldLocation.IsChild(StartLocation)
		ReturnFaction = CrimeFactionRift
	ElseIf DLC2SolstheimLocation.IsChild(StartLocation)
		ReturnFaction = DLC2CrimeRavenRockFaction
	Else
		debug.Notification( "LAL: No valid bounty faction chosen." )
	EndIf

	;debug.Trace( "LAL: Setting bounty faction: " + ReturnFaction )
	return ReturnFaction
EndFunction

Event OnLoad()
	OnUpdate()

	if( DoOnce == 0 )
		StartLoc = BanditLairLocation.GetLocation()
		;debug.Trace( "LAL: StartLoc = " + StartLoc )
		DoOnce = 1
		
		Faction CFaction = GetCrimeFactionForLoc(StartLoc)
		
		if( CFaction )
			CFaction.SetCrimeGold(1500)
		EndIf
	EndIf

	Game.GetPlayer().AddToFaction(ARTHLALBanditVampireFaction)
	;debug.Notification( "LAL: Entering bandit start location." )
EndEvent

Event OnUnload()
	if( Game.GetPlayer().GetCurrentLocation() != StartLoc )
		Game.GetPlayer().RemoveFromFaction(ARTHLALBanditVampireFaction)
		UnregisterForUpdate()
		;debug.Notification( "LAL: Leaving bandit start location." )
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
