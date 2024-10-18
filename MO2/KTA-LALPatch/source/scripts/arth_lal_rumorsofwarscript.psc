Scriptname ARTH_LAL_RumorsOfWarScript extends Quest Conditional

ARTH_LAL_StartQuest Property ChargenQuest Auto
ARTH_LAL_VersionTrackingScript Property DLCSupport Auto

; Tracker variables
bool Property SvenTold Auto Hidden Conditional
bool Property AlvorTold Auto Hidden Conditional
bool Property GerdurTold Auto Hidden Conditional
bool Property ToldInRW Auto Hidden Conditional
bool Property ToldByGuards Auto Hidden Conditional
bool Property GuardShouldConfront Auto Hidden Conditional
bool Property HostileIntent Auto Hidden Conditional
bool Property PolygonTriggered Auto Hidden Conditional

Scene Property SolitudeCrownScene Auto
Scene Property WindhelmCrownScene Auto
Quest Property StormCloakQuest Auto
Quest Property ImperialLegionQuest Auto

ReferenceAlias Property ShipwreckStart Auto
ReferenceAlias Property RedguardStart Auto

;Set up Solstheim starts that aren't the boat ride properly.
DLC2DialogueRRQuestScript Property RRShipRide Auto
Quest Property DLC2Init Auto
Quest Property DLC2RRArrivalScene Auto
Quest Property DLC2RR01 Auto
Quest Property DLC2RR03 Auto
ObjectReference Property DLC2InitTrigger Auto
GlobalVariable Property DLC2RRGjalundInit Auto
GlobalVariable Property DLC2RRASForce Auto

Function ConfigureSolstheimStart()
	DLC2RR01.SetStage(10)
	DLC2RR03.SetStage(10)
	DLC2Init.SetStage(100) ; Boat ride usually does this.
	DLC2RRArrivalScene.SetStage(200) ; Kill Adril's startup scene since we don't care.
	DLC2InitTrigger.Disable()
	DLC2InitTrigger.Delete()
	DLC2RRGjalundInit.SetValue(1)
	DLC2RRASForce.SetValue(1)
EndFunction

Event OnUpdateGameTime()
	if( ChargenQuest.MainMenuChoice == 8 )
		ShipwreckStart.TryToDisable()
	EndIf

	if( ChargenQuest.MainMenuChoice == 17 )
		RedguardStart.TryToDisable()
	EndIf
EndEvent

Event OnUpdate()
	if( GetStage() < 200 )
		SetStage(200)
		Return
	EndIf

	if( GetStage() == 200 )
		if( ChargenQuest.ArmyMenuChoice == 0 )
			if( SolitudeCrownScene.IsPlaying() )
				RegisterForSingleUpdate(2)
			Else
				ImperialLegionQuest.SetStage(160)
				ImperialLegionQuest.SetStage(200)
			EndIf
		elseif( ChargenQuest.ArmyMenuChoice == 1 )
			if( WindhelmCrownScene.IsPlaying() )
				RegisterForSingleUpdate(2)
			Else
				StormCloakQuest.SetStage(160)
				StormCloakQuest.SetStage(200)
			EndIf
		endif
	endif
EndEvent

;Toggle OCS gate trigger on or off as needed.
Function ToggleOCSGateTrigger( bool Enabled )
	if( DLCSupport.OCSInstalled == True )
		ObjectReference OCSGate = (Game.GetFormFromFile( 0x0001A760, "Open Cities Skyrim.esp" )) as ObjectReference
		ObjectReference OCSTrigger = (Game.GetFormFromFile( 0x0001A763, "Open Cities Skyrim.esp" )) as ObjectReference

		float x = OCSTrigger.GetPositionX()
		float y = OCSTrigger.GetPositionY()
		
		;Yep, I know, this looks rather stupid. It's because the gate trigger has an enable parent and can't be toggled on/off.
		if( !Enabled )
			OCSTrigger.SetPosition( x, y, 10000 )
			if( OCSGate.GetOpenState() != 3 )
				OCSGate.SetOpen(false)
			EndIf
			OCSGate.Lock(true)
		Else
			OCSTrigger.SetPosition( x, y, -3520 )
		EndIf
	EndIf
EndFunction
