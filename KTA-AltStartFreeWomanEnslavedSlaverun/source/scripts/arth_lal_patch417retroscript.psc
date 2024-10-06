ScriptName ARTH_LAL_Patch417RetroScript Extends Quest

ARTH_LAL_VersionTrackingScript Property LALTracking  Auto  
ARTH_LAL_Patch418RetroScript Property ARTHLALPatch418Quest Auto

ReferenceAlias Property Foreman Auto
ReferenceAlias Property Geraldine Auto
Actor Property SavlianRef Auto
Actor Property GeraldineRef Auto
ARTH_LAL_FarmhouseProfitsScript Property ProfitsQuest Auto
ARTH_LAL_StartQuest Property ChargenQuest Auto

Function Process()
	if( SavlianRef.IsDead() )
		if( !GeraldineRef.IsDead() )
			if( ChargenQuest.PropertyMenuChoice == 4 )
				ProfitsQuest.Start()
				Foreman.ForceRefTo( GeraldineRef )
				ProfitsQuest.Collecting = True
				ProfitsQuest.RegisterForSingleUpdateGameTime(168)

				debug.trace( "Live Another Life: Patch 4.1.7 Applied" )
			endif
		endif
	endif

	if( !SavlianRef.IsDead() )
		Foreman.ForceRefTo( SavlianRef )
	endif

	if( !GeraldineRef.IsDead() )
		Geraldine.ForceRefTo( GeraldineRef )
	endif

	SavlianRef = None
	GeraldineRef = None

	LALTracking.LastVersion = 417
	ARTHLALPatch418Quest.Process()
	Stop()
EndFunction
