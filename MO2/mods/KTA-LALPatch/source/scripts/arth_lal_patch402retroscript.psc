ScriptName ARTH_LAL_Patch402RetroScript Extends Quest

ARTH_LAL_VersionTrackingScript Property LALTracking  Auto  
ARTH_LAL_Patch417RetroScript Property ARTHLALPatch417Quest Auto

Quest Property ARTHLALWhiterunGuardConfrontationQuest Auto
ReferenceAlias Property Guard Auto

Function Process()
	;Make sure the Whiterun gate guard is alive when he should be.
	if( ARTHLALWhiterunGuardConfrontationQuest.IsRunning() )
		if( Guard.GetActorReference().IsDead() )
			Guard.GetActorReference().Resurrect()
			Guard.GetActorReference().Enable()
			Guard.GetActorReference().EvaluatePackage()

			debug.trace( "Live Another Life: Patch 4.0.2 Applied" )
		endif
	endif

	LALTracking.LastVersion = 410
	ARTHLALPatch417Quest.Process()
	Stop()
EndFunction
