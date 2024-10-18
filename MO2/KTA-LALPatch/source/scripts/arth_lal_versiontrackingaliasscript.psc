Scriptname ARTH_LAL_VersionTrackingAliasScript extends ReferenceAlias

ARTH_LAL_VersionTrackingScript Property LALTracking Auto

Event OnPlayerLoadGame()
	LALTracking.DLCSupportCheck()
	LALTracking.VersionCheck()
EndEvent
