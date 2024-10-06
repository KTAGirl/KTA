Scriptname ARTH_LAL_StartQuest extends Quest Conditional

; Choices made at the statue - technically obsolete but too much is referring to them to dump them.
int Property MainMenuChoice Auto Hidden Conditional
int Property ImmigrationMenuChoice Auto Hidden Conditional
int Property PropertyMenuChoice Auto Hidden Conditional
int Property GuildMenuChoice Auto Hidden Conditional
int Property InnMenuChoice Auto Hidden Conditional
int Property ArmyMenuChoice Auto Hidden Conditional

; Random value for bandit start
int Property BanditRandom Auto Hidden
bool Property HostileIntent Auto Hidden Conditional

; Random value for Left for Dead
int Property DeadRandom Auto Hidden Conditional

; Chargen tracker variables
bool property EscapeOptionUsed Auto Hidden Conditional
bool Property StartChosen Auto Hidden Conditional
bool Property SolstheimStart Auto Hidden Conditional

; player races
MQ101QuestScript Property MQ101QScript Auto
Race Property ArgonianRace  Auto  
Race Property BretonRace  Auto  
Race Property DarkElfRace  Auto  
Race Property HighElfRace  Auto  
Race Property ImperialRace  Auto  
Race Property KhajiitRace  Auto  
Race Property NordRace  Auto  
Race Property OrcRace  Auto  
Race Property RedguardRace  Auto  
Race Property WoodElfRace  Auto  

Actor Property Player Auto
Faction Property PlayerFaction Auto

Idle Property IdleWalkingCameraEnd  Auto  
Idle Property OffsetStop  Auto  

Quest Property ARTHLALRumorsOfWarQuest Auto 
Quest Property RelationshipAdoptable Auto
ARTH_UTILS_General Property Utils Auto

;Called when activating the Mara statue in the prison.
function ResetMenuChoices()
	MainMenuChoice = -1
	ImmigrationMenuChoice = -1
	PropertyMenuChoice = -1
	GuildMenuChoice = -1
	InnMenuChoice = -1
	ArmyMenuChoice = -1
	DeadRandom = -1
	StartChosen = False
	EscapeOptionUsed = False
	SolstheimStart = False
endfunction

ARTH_LAL_VersionTrackingScript Property DLCSupport Auto

;Pick a random ship arrival for Immigration.
int Function PickRandomImmigration()
	int ImmigrationChoice = Utility.RandomInt(0,3)

	if( DLCSupport.RTHInstalled == 1 && ImmigrationChoice == 0 )
		ImmigrationChoice = 1
	EndIf
	
	return ImmigrationChoice
EndFunction

;Pick a random property for Property Owner.
int Function PickRandomProperty()
	int PropertyChoice = Utility.RandomInt(0,7)

	;Return to Helgen, blocks Solitude starts
	if( DLCSupport.RTHInstalled == 1 && PropertyChoice == 0 )
		PropertyChoice = 1
	EndIf
	
	return PropertyChoice
EndFunction

;Pick a random inn for Inn Patron.
int Function PickRandomInn()
	int InnChoice = Utility.RandomInt(0,17)

	;Keld-Nar - jumps back to Moorside Inn, in Morthal, if the mod is not installed.
	if( !DLCSupport.KNInstalled && InnChoice == 10 )
		InnChoice = 8
	EndIf
	
	return InnChoice
EndFunction

;Pick a random guild for Guild Member.
int Function PickRandomGuild()
	int GuildRandom = Utility.RandomInt(4,9)

	return GuildRandom
EndFunction

;Rewritten to use the new stage setup, old menu choice vars are still in use by Stage 40 so they need to be assigned.
function Randomize()
	int RandomStage = Utility.RandomInt(0,19)
	
	; Zero should be converted into a race start.
	if( RandomStage == 0 )
		Race playerRace = Player.GetActorBase().GetRace()

		if( playerRace == OrcRace )
			MainMenuChoice = 9
			RandomStage = 101
		ElseIf( playerRace == KhajiitRace )
			MainMenuChoice = 11
			RandomStage = 102
		ElseIf( playerRace == BretonRace )
			MainMenuChoice = 14
			RandomStage = 103
		ElseIf( playerRace == ArgonianRace )
			MainMenuChoice = 16
			RandomStage = 104
		ElseIf( playerRace == RedguardRace )
			MainMenuChoice = 17
			RandomStage = 105
		ElseIf( playerRace == DarkElfRace )
			RandomStage = Utility.RandomInt(106,107)
			MainMenuChoice = 18
		ElseIf( playerRace == HighElfRace )
			MainMenuChoice = 19
			RandomStage = 108
		ElseIf( playerRace == NordRace )
			MainMenuChoice = 21
			RandomStage = 109
		Elseif( playerRace == ImperialRace )
			MainMenuChoice = 22
			RandomStage = 110
		Else
			;No start exists for the player's race, shipwreck them instead.
			MainMenuChoice = 8
			RandomStage = 14
		EndIf
	endif

	;Immigration by boat
	if( RandomStage == 1 )
		ImmigrationMenuChoice = PickRandomImmigration()
	;Own property in city
	elseif( RandomStage == 2 )
		PropertyMenuChoice = PickRandomProperty()
	;Inn patron
	elseif( RandomStage == 3 )
		InnMenuChoice = PickRandomInn()
	;Guild Member - does not need an entry, random stage is already selected.
	;Left for Dead (Stage 19) - No longer needs a random number. System is randomized via radiant quest.
	endif

	SetAddonQuestStage(RandomStage, ARTHLALRumorsOfWarQuest)
EndFunction

; add racial spells to player - calls the vanilla copy on MQ101QuestScritpt now.
function AddRaceSpells()
	; remove all racial spells first, just in case
	MQ101QScript.RemoveRaceSpells(Player)

	; add race spells
	MQ101QScript.AddRaceSpells()

endFunction

;House Markers
HousePurchaseScript Property HousePurchaseQuest  Auto  

FormList Property ARTHLALSolitudeHouseEnableList Auto
FormList Property ARTHLALMarkarthHouseEnableList Auto
FormList Property ARTHLALMarkarthHouseDisableList Auto
FormList Property ARTHLALWhiterunHouseEnableList Auto
FormList Property ARTHLALWhiterunHouseDisableList Auto
FormList Property ARTHLALRiftenHouseEnableList Auto
FormList Property ARTHLALRiftenHouseDisableList Auto
Actor Property HousecarlWhiterunRef Auto
Faction Property PotentialMarriageFaction Auto

function PurchaseHouse(cell HouseInterior, key HouseKey, book DecoratingGuide)
	Player.AddItem(HouseKey, abSilent = true)
	Player.AddItem(DecoratingGuide, abSilent = true)
	HouseInterior.SetFactionOwner(playerfaction)
	game.IncrementStat( "Houses Owned" )
	Game.AddAchievement(31)

	if( PropertyMenuChoice == 0 )
		Utils.EnableFormList( ARTHLALSolitudeHouseEnableList )

		While( !HousePurchaseQuest.IsRunning() )
			Utility.Wait(0.5)
		EndWhile

		HousePurchaseQuest.solitudehousevar = 2
		HousePurchaseQuest.SetObjectiveCompleted(20,1)
	elseif( PropertyMenuChoice == 1 )
		Utils.EnableFormList( ARTHLALMarkarthHouseEnableList )
		Utils.DisableFormList( ARTHLALMarkarthHouseDisableList )
		
		While( !HousePurchaseQuest.IsRunning() )
			Utility.Wait(0.5)
		EndWhile
		HousePurchaseQuest.markarthhousevar = 2
		HousePurchaseQuest.SetObjectiveCompleted(40,1)
	elseif( PropertyMenuChoice == 2 )
		Utils.EnableFormList( ARTHLALWhiterunHouseEnableList )
		Utils.DisableFormList( ARTHLALWhiterunHouseDisableList )

		While( !HousePurchaseQuest.IsRunning() )
			Utility.Wait(0.5)
		EndWhile
		
		HousePurchaseQuest.whiterunhousevar = 2
		HousePurchaseQuest.SetObjectiveCompleted(10,1)
		HousecarlWhiterunRef.AddToFaction(PotentialMarriageFaction)
	elseif( PropertyMenuChoice == 3 )
		Utils.EnableFormList( ARTHLALRiftenHouseEnableList )
		Utils.DisableFormList( ARTHLALRiftenHouseDisableList )

		While( !HousePurchaseQuest.IsRunning() )
			Utility.Wait(0.5)
		EndWhile
		
		HousePurchaseQuest.riftenhousevar = 2
		HousePurchaseQuest.SetObjectiveCompleted(30,1)
	endif

	;Need to ping the Hearthfire adoption quest because you just acquired a new home.
	(RelationshipAdoptable as BYOHRelationshipAdoptableScript).UpdateHouseStatus()
endfunction

;Exterior house part properties. HF is weird, does things via crafting. So all kinds of hoops get jumped.
BYOHHouseBuildingScript Property HouseBuilding Auto

MiscObject[] Property ExteriorHouseParts Auto
ObjectReference[] Property ExteriorPartsHoldingChest Auto
FormList Property ARTHLALHFHousePartsMasterList Auto
MiscObject Property BYOHHouseExteriorPart07Apiary Auto ;Only for Falkreath
MiscObject Property BYOHHouseExteriorPart09FishHatchery Auto ;Only for Hjaalmarch
MiscObject Property BYOHHouseExteriorPart08Mill Auto ;Only for Pale

Function OccupyHFHome( BYOHHouseScript HouseScript, ObjectReference StartMarker, int HouseLocation )
	int loopindex = 0
	game.IncrementStat( "Houses Owned" )
	Game.AddAchievement(31)

	;debug.trace( "OccupyHFHome: Entering function. HouseScript: " + HouseScript + " HouseLocation: " + HouseLocation )

	HouseScript.SetStage(100)
	HouseScript.SetStage(110)
	HouseScript.SetStage(120)
	HouseScript.SetStage(130)
	HouseScript.SetStage(1010)
	HouseScript.SetStage(1020)
	HouseScript.SetStage(1120)
	HouseScript.numRoomsCompleted = 3
	HouseScript.bBoughtCarriage = true
	HouseScript.numCows = 1
	HouseScript.numChickens = 3
	HouseScript.bBoughtHorse = True

	;debug.trace( "OccupyHFHome: Stages and variables set." )

	;Entry way + main hall exterior pieces
	HouseScript.DisableList[11].DisableNoWait()  ;Small House interior mesh. Will cause Entry Way version to turn on.
	if( HouseScript.DisableList2[12] )
		HouseScript.DisableList2[12].DisableNoWait() ;Main Hall Foundation marker. Gets rid of some exterior clutter.
	EndIf
	HouseScript.EnableList2[1].EnableNoWait()    ;Main Hall exterior navmesh cutter.
	HouseScript.EnableList2[12].EnableNoWait()   ;Entry way exterior navmesh cutter.
	HouseScript.EnableList[7].EnableNoWait()     ;Exterior Door into Entry Way.
	HouseScript.EnableList2[7].EnableNoWait()    ;Exterior Mesh for Entry Way.
	HouseScript.EnableList[18].EnableNoWait()    ;Main Hall Roof. Causes other misc clutter to enable as well.
	HouseScript.EnableList[15].EnableNoWait()    ;Main Hall exterior piece.
	HouseScript.EnableList[16].EnableNoWait()    ;Main Hall exterior piece.
	HouseScript.EnableList2[15].EnableNoWait()   ;Main Hall exterior piece.
	HouseScript.EnableList2[16].EnableNoWait()   ;Main Hall exterior piece.
	HouseScript.EnableList2[18].EnableNoWait()   ;Main Hall exterior piece.
	HouseScript.EnableList2[15].EnableNoWait()   ;Main Hall exterior piece.
	HouseScript.EnableList3[15].EnableNoWait()   ;Main Hall exterior piece.
	HouseScript.EnableList4[15].EnableNoWait()   ;Main Hall exterior piece.
	HouseScript.EnableList4[16].EnableNoWait()   ;Main Hall exterior piece.
	HouseScript.EnableList[134].EnableNoWait()   ;Door to cellar.

	;Interior main hall navmesh blocker
	HouseScript.RoomDisableList[1].DisableNoWait()

	;debug.trace( "OccupyHFHome: Exterior house pieces enabled." )
	
	;Enable all relevant exterior decorations using the pseudo-crafting system to make sure it does the enables properly.
	loopindex = 0
	while( loopindex < ExteriorHouseParts.Length )
		HouseBuilding.BuildHouseExteriorPart( HouseLocation, loopindex + 1, ExteriorHouseParts[loopindex] )
		ExteriorPartsHoldingChest[HouseLocation].AddItem( ExteriorHouseParts[loopindex] )
		loopindex += 1
	EndWhile

	;debug.trace( "OccupyHFHome: Exterior add-ons enabled." )

	;Flag finished rooms.
	(HouseScript.RoomDoneFlags.GetAt(1) as GlobalVariable).SetValueInt(1)
	(HouseScript.RoomDoneFlags.GetAt(2) as GlobalVariable).SetValueInt(1)
	(HouseScript.RoomDoneFlags.GetAt(12) as GlobalVariable).SetValueInt(1)

	;debug.trace( "OccupyHFHome: Finished rooms flagged." )

	if( HouseLocation == 0 ) ;Falkreath
		HouseBuilding.BuildHouseExteriorPart( HouseLocation, 7, BYOHHouseExteriorPart07Apiary )
		ExteriorPartsHoldingChest[HouseLocation].AddItem( BYOHHouseExteriorPart07Apiary )
		HouseBuilding.SetStage(1)
	elseif( HouseLocation == 1 ) ;Hjaalmarch
		HouseBuilding.BuildHouseExteriorPart( HouseLocation, 9, BYOHHouseExteriorPart09FishHatchery )
		ExteriorPartsHoldingChest[HouseLocation].AddItem( BYOHHouseExteriorPart09FishHatchery )
		HouseBuilding.SetStage(2)
	Else ;Pale
		HouseBuilding.BuildHouseExteriorPart( HouseLocation, 8, BYOHHouseExteriorPart08Mill )
		ExteriorPartsHoldingChest[HouseLocation].AddItem( BYOHHouseExteriorPart08Mill )
		HouseBuilding.SetStage(3)
	EndIf

	;debug.trace( "OccupyHFHome: Interior furnishings enabled." )

	ExteriorPartsHoldingChest[HouseLocation].AddItem(ARTHLALHFHousePartsMasterList)

	;debug.trace( "OccupyHFHome: Drafting table menu updated." )

	HouseScript.RemodelEntryRoom(1)

	;debug.trace( "OccupyHFHome: Entry room remodeled." )

	HouseScript.Room12EnableList[39].Disable() ;Vampire coffin in cellar. Should only exist for actual vampires.

	;debug.trace( "OccupyHFHome: Vampire coffin disabled. Player moves next." )

	Player.MoveTo(StartMarker)
EndFunction

Function FixMyDamnArms()
	Game.ShowFirstPersonGeometry(true)
	Game.SetPlayerAIDriven(false)
	If( ImmigrationMenuChoice != 3 ) ; Leave player controls locked for boat ride to Solstheim. The boat script will enable them when it's done. Fix by arranz.
		Game.EnablePlayerControls()
	EndIf
	Player.SetRestrained(false)
	Game.SetHudCartMode(false)
	Player.PlayIdle(OffsetStop)
	Player.PlayIdle(IdleWalkingCameraEnd)
EndFunction

;Stuff below is for cleaning up Helgen since MQ101DragonAttack can't fill its aliases for some reason.
FormList Property ARTHLALHelgenEnableList Auto
FormList Property ARTHLALHelgenDisableList Auto

Function CleanupHelgen()
	Utils.EnableFormList( ARTHLALHelgenEnableList )
	Utils.DisableFormList( ARTHLALHelgenDisableList )
EndFunction

;Specifics used for the vampire start.
PlayerVampireQuestScript Property VampireQuest Auto
GlobalVariable Property VampireFeedReady Auto
GlobalVariable Property GameHour  Auto  

Function MakePlayerVampire()
	VampireQuest.VampireChange(Player)
	VampireQuest.FeedTimer = 4
	Utility.Wait(2)
	GameHour.SetValue(19)
	VampireFeedReady.SetValue(2)
	VampireQuest.VampireStatus = 3
	VampireQuest.VampireProgression(Player, 3)
EndFunction

Quest Property ARTHLALCheskoPolygonQuest Auto
ReferenceAlias Property Hadvar Auto
ReferenceAlias Property Ralof Auto
ReferenceAlias Property HelgenCaveObjective Auto
ObjectReference Property ARTHLALKillThemAllTrigger1 Auto
ObjectReference Property ARTHLALKillThemAllTrigger2 Auto

Function TakeGeneralsOutOfService()
	if( MainMenuChoice != 7 )
		ARTHLALCheskoPolygonQuest.Start()
	EndIf
		
	if( ArmyMenuChoice == -1 )
		Hadvar.GetActorReference().MoveTo(HelgenCaveObjective.GetReference())
		Ralof.GetActorReference().MoveTo(HelgenCaveObjective.GetReference())
		ARTHLALKillThemAllTrigger1.Enable()
		ARTHLALKillThemAllTrigger2.Enable()
	endif
EndFunction

;Quest hook for semi-modular start system. Quest and Stage variables are set from the individual dialogue options.
Quest Property StartupQuest Auto Hidden
Int Property QuestStage Auto Hidden

Function SetAddonQuestStage( int QStage, Quest SQuest = None )
	StartupQuest = SQuest
	QuestStage = QStage
	StartChosen = True
	
	;Display the objective to use the bed.
	if( EscapeOptionUsed == True )
		SetStage(16)
	Else
		SetStage(15)
	EndIf
EndFunction

Function ExecuteAddonQuest()
	if( StartupQuest == None )
		debug.tracestack( "Live Another Life: StartupQuest has not been set by dialogue." )
		debug.MessageBox( "Live Another Life: An error occurred - No valid quest was set. Unable to move you to a destination." )
		Return
	EndIf

	if( QuestStage <= 0 )
		debug.tracestack( "Live Another Life: Startup quest stage cannot be <= 0." )
		debug.MessageBox( "Live Another Life: An error occurred - No valid quest stage was set. Unable to move you to a destination." )
		Return
	EndIf

	StartupQuest.SetStage(QuestStage)
EndFunction
