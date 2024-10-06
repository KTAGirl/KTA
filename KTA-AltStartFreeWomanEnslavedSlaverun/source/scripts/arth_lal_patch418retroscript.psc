ScriptName ARTH_LAL_Patch418RetroScript Extends Quest

ARTH_LAL_VersionTrackingScript Property LALTracking  Auto  

ARTH_LAL_StartQuest Property ChargenQuest Auto
Actor Property HousecarlWhiterunRef Auto
Faction Property PotentialMarriageFaction Auto

Function Process()
	if( !ChargenQuest.IsRunning() && ChargenQuest.PropertyMenuChoice >= 0 )
		Game.AddAchievement(31) ; Property Ownership achievement was never given.

		if( ChargenQuest.PropertyMenuChoice == 2 )
			HousecarlWhiterunRef.AddToFaction(PotentialMarriageFaction) ; Lydia is only added by dialogue to purchase Breezehome so this never got set when starting there.

			debug.trace( "Live Another Life: Patch 4.1.8 Applied" )
		endif
	endif

	LALTracking.LastVersion = 418
	Stop()
EndFunction
