Scriptname ARTH_LAL_FriendlyFireScript extends Quest  
{Script for removing the player from their startup faction if they turn against them.}

Faction Property ArthFriendlies Auto
Keyword Property LocTypeBanditCamp Auto
Keyword Property LocTypeVampireLair Auto
Faction Property Vigilants Auto
Faction Property ThalmorFaction Auto
Faction Property PenitusOculatusFaction Auto
Faction Property DruadachRedoubtFaction Auto
ARTH_LAL_RumorsOfWarScript Property ARTHLALRumorsOfWarQuest Auto

bool Function AssaultCheck( Actor Player )
	if( ARTHLALRumorsOfWarQuest.HostileIntent == false )
		Actor CombatTarget = Player.GetCombatTarget()
		
		if( CombatTarget )
			debug.trace( "Those fools are actually fighting! " + Player + " " + CombatTarget )

			if( CombatTarget.IsInFaction(Vigilants) && Player.IsInFaction(Vigilants) )
				ARTHLALRumorsOfWarQuest.HostileIntent = true
				Player.RemoveFromFaction(Vigilants)
				return True
			ElseIf( CombatTarget.IsInFaction(ThalmorFaction) && Player.IsInFaction(ThalmorFaction) )
				ARTHLALRumorsOfWarQuest.HostileIntent = true
				Player.RemoveFromFaction(ThalmorFaction)
				return True
			ElseIf( CombatTarget.IsInFaction(PenitusOculatusFaction) && Player.IsInFaction(PenitusOculatusFaction) )
				ARTHLALRumorsOfWarQuest.HostileIntent = true
				Player.RemoveFromFaction(PenitusOculatusFaction)
				return True
			ElseIf( CombatTarget.IsInFaction(DruadachRedoubtFaction) && Player.IsInFaction(DruadachRedoubtFaction) )
				ARTHLALRumorsOfWarQuest.HostileIntent = true
				Player.RemoveFromFaction(DruadachRedoubtFaction)
				return True
			ElseIf( Player.IsInFaction(ArthFriendlies) )
				Location PlayerLoc = Player.GetCurrentLocation()

				if( PlayerLoc.HasKeyword(LocTypeBanditCamp) || PlayerLoc.HasKeyword(LocTypeVampireLair) )
					ARTHLALRumorsOfWarQuest.HostileIntent = true
					Player.RemoveFromFaction(ArthFriendlies)
					return True
				EndIf
			EndIf
		endif
	endif
	
	return False
EndFunction
