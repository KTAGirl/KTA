Scriptname ARTH_LAL_VersionTrackingScript extends Quest Conditional

Int Property LastVersion Auto Hidden
ARTH_LAL_StartQuest Property ChargenQuest Auto
ARTH_QF_LALWhiterunGuard_0529847F Property ARTHLALWhiterunGuardConfrontationQuest Auto
Message Property ARTHLALUpgradeNotice Auto

ARTH_LAL_Patch402RetroScript Property ARTHLALPatch402Quest Auto
ARTH_LAL_Patch417RetroScript Property ARTHLALPatch417Quest Auto
ARTH_LAL_Patch418RetroScript Property ARTHLALPatch418Quest Auto

Faction Property DLC1VampireCompanionFaction Auto
Faction Property DLC1RadiantVampireBanditNecroAllys Auto
Faction Property VampireFaction Auto
Faction Property VampireThrallFaction Auto
Faction Property BanditFaction Auto
Faction Property WolfFaction Auto
Faction Property SkeletonFaction Auto
Faction Property DraugrFaction Auto
Faction Property ARTHLALBanditVampireFaction Auto

Potion property SnowberryExtract Auto Hidden ; Frostfall support
bool property FrostfallInstalled Auto Hidden ; Frostfall support

bool Property RTHInstalled Auto Hidden Conditional ; For Giskard's Return to Helgen - blocks Solitude start options.

bool Property KNInstalled Auto Hidden Conditional ; For Keld-Nar inn start
ObjectReference Property ARTHKeldNarInnStartMarker Auto Hidden

bool Property THInstalled Auto Hidden Conditional ; For Tundra Homestead CC start
Key Property THKey Auto Hidden
Quest Property THQuest Auto Hidden

bool Property SSInstalled Auto Hidden Conditional ; For Shadowfoot Sanctum CC start
Quest Property SSQuest Auto Hidden
ObjectReference Property SSStartMarker Auto Hidden

bool Property OldHroldanInstalled Auto Hidden Conditional ;For Shezrie's Old Hroldan Inn

bool Property TGInstalled Auto Hidden Conditional ;For Telengard
ObjectReference Property TGStartMarker Auto Hidden

bool Property GHInstalled Auto Hidden Conditional ;For Granite Hill
ObjectReference Property GHStartMarker Auto Hidden

bool Property OWInstalled Auto Hidden Conditional ;For Oakwood
ObjectReference Property OWStartMarker Auto Hidden

bool Property OCSInstalled Auto Hidden Conditional ;For OCS

Quest Property MQ101 Auto

Function DLCSupportCheck()
	BanditFaction.SetAlly(ARTHLALBanditVampireFaction)
	VampireFaction.SetAlly(ARTHLALBanditVampireFaction)
	VampireThrallFaction.SetAlly(ARTHLALBanditVampireFaction)
	WolfFaction.SetAlly(ARTHLALBanditVampireFaction)
	SkeletonFaction.SetAlly(ARTHLALBanditVampireFaction)
	DraugrFaction.SetAlly(ARTHLALBanditVampireFaction)
	DLC1VampireCompanionFaction.SetAlly(ARTHLALBanditVampireFaction)

	VampireFaction.SetAlly(DLC1VampireCompanionFaction)
	VampireThrallFaction.SetAlly(DLC1VampireCompanionFaction)

	BanditFaction.SetAlly(DLC1RadiantVampireBanditNecroAllys)
	VampireFaction.SetAlly(DLC1RadiantVampireBanditNecroAllys)
	VampireThrallFaction.SetAlly(DLC1RadiantVampireBanditNecroAllys)

	;Don't perform the checks if chargen is complete. MQ101 Stage 250 is as good a check as any.
	if( MQ101.GetStage() < 250 )
		debug.trace( "==== LAL: Mod support check - Ignore errors about missing files. ====" )

		int skseversion = SKSE.GetVersion()

		;Set all defaults.
		SnowberryExtract = None
		FrostfallInstalled = False
		RTHInstalled = False
		ARTHKeldNarInnStartMarker = None
		KNInstalled = False
		OldHroldanInstalled = False
		THKey = None
		THQuest = None
		THInstalled = False
		TGStartMarker = None
		TGInstalled = False
		SSQuest = None
		SSStartMarker = None
		SSInstalled = False
		GHStartMarker = None
		GHInstalled = False
		OWInstalled = False
		OWStartMarker = None
		OCSInstalled = False

		if( skseversion >= 2 )
			;Frostfall check, for shipwreck start to add 2 Strawberry Extract potions to the sack near the start area.
			if( Game.IsPluginInstalled( "Frostfall.esp" ) )
				FrostfallInstalled = True
			endif

			;Return to Helgen check - disables Solitude start options if it's active.
			if( Game.IsPluginInstalled( "teg_returntohelgen.esp" ) )
				RTHInstalled = True
			endif

			;Keld-Nar check - used for additional inn start if it's installed.
			if( Game.IsPluginInstalled( "Keld-Nar.esp" ) )
				KNInstalled = True
			endif

			;Old Hroldan Inn. Move player to adjusted location marker if Shezrie's version is present.
			if( Game.IsPluginInstalled( "ShezriesOldHroldan.esp" ) || Game.IsPluginInstalled( "ShezrieOldHroldanVer2.esp" ) )
				OldHroldanInstalled = True
			endif

			;Tundra Homestead CC check - used for additional property start if it's installed.
			if( Game.IsPluginInstalled( "ccEEJSSE001-Hstead.esm" ) )
				THInstalled = True
			endif

			;Telengard - used for additional inn start if it's installed.
			if( Game.IsPluginInstalled( "Telengard.esp" ) )
				TGInstalled = True
			endif
			
			;Shadowfoot Sanctum CC check - used for additional property start if it's installed.
			if( Game.IsPluginInstalled( "ccEEJSSE003-Hollow.esl" ) )
				SSInstalled = True
			endif

			;Fall of Granite Hill - used for additional inn start if it's installed.
			if( Game.IsPluginInstalled( "Fall of Granite Hill.esp" ) )
				GHInstalled = True
			endif

			;Oakwood - used for additional inn start if it's installed.
			if( Game.IsPluginInstalled( "Oakwood.esp" ) )
				OWInstalled = True
			endif

			;Open Cities check to deal with the Whiterun gate.
			if( Game.IsPluginInstalled( "Open Cities Skyrim.esp" ) )
				OCSInstalled = True
			endif
		else
			;Frostfall check, for shipwreck start to add 2 Strawberry Extract potions to the sack near the start area.
			if( Game.GetFormFromFile( 0x0001D430, "Frostfall.esp" ) )
				FrostfallInstalled = True
			EndIf

			;Return to Helgen check - disables Solitude start options if it's active.
			if( Game.GetFormFromFile( 0x000012CA, "teg_returntohelgen.esp" ) )
				RTHInstalled = True
			EndIf

			;Keld-Nar check - used for additional inn start if it's installed.
			if( Game.GetFormFromFile( 0x00013AD8, "Keld-Nar.esp" ) )
				KNInstalled = True
			EndIf

			;Old Hroldan Inn. Move player to adjusted location marker if Shezrie's version is present.
			if( Game.GetFormFromFile( 0x000149e6, "ShezriesOldHroldan.esp" ) || Game.GetFormFromFile( 0x000149e6, "ShezrieOldHroldanVer2.esp" ) )
				OldHroldanInstalled = True
			EndIf

			;Tundra Homestead CC check - used for additional property start if it's installed.
			if( Game.GetFormFromFile( 0x00047E3B, "ccEEJSSE001-Hstead.esm" ) )
				THInstalled = True
			EndIf

			;Telengard - used for additional inn start if it's installed.
			if( Game.GetFormFromFile( 0x0005706A, "Telengard.esp" ) )
				TGInstalled = True
			EndIf

			;Shadowfoot Sanctum CC check - used for additional property start if it's installed.
			if( Game.GetFormFromFile( 0x0000082A, "ccEEJSSE003-Hollow.esl" ) )
				SSInstalled = True
			EndIf

			;Fall of Granite Hill - used for additional inn start if it's installed.
			if( Game.GetFormFromFile( 0x000DFCA8, "Fall of Granite Hill.esp" ) )
				GHInstalled = True
			EndIf

			;Oakwood - used for additional inn start if it's installed.
			if( Game.GetFormFromFile( 0x00000A7F, "Oakwood.esp" ) )
				OWInstalled = True
			endif

			;Open Cities check to deal with the Whiterun gate.
			if( Game.GetFormFromFile( 0x0001A760, "Open Cities Skyrim.esp" ) )
				OCSInstalled = True
			endif
		endif

		if( FrostfallInstalled )
			SnowberryExtract = Game.GetFormFromFile( 0x0001D430, "Frostfall.esp" ) as Potion
		endif
		
		if( KNInstalled )
			ARTHKeldNarInnStartMarker = Game.GetFormFromFile( 0x00013AD8, "Keld-Nar.esp" ) as ObjectReference
		endif
		
		if( THInstalled )
			THKey = Game.GetFormFromFile( 0x00047E3B, "ccEEJSSE001-Hstead.esm" ) as Key
			THQuest = Game.GetFormFromFile( 0x00042D35, "ccEEJSSE001-Hstead.esm" ) as Quest
		endif
		
		if( TGInstalled )
			TGStartMarker = Game.GetFormFromFile( 0x0005706A, "Telengard.esp" ) as ObjectReference
		endif
		
		if( SSInstalled )
			SSQuest = Game.GetFormFromFile( 0x0000082A, "ccEEJSSE003-Hollow.esl" ) as Quest
			SSStartMarker = Game.GetFormFromFile( 0x000008CE, "ccEEJSSE003-Hollow.esl" ) as ObjectReference
		endif
		
		if( GHInstalled )
			GHStartMarker = Game.GetFormFromFile( 0x000DFCA8, "Fall of Granite Hill.esp" ) as ObjectReference
		endif

		if( OWInstalled )
			OWStartMarker = Game.GetFormFromFile( 0x00000A7F, "Oakwood.esp" ) as ObjectReference
		endif

		debug.trace( "==== LAL: Mod support check - Done. ====" )
	EndIf

	;Open Cities Skyrim - Alias forcing Whiterun gate
	if( ARTHLALWhiterunGuardConfrontationQuest.IsRunning() )
		ARTHLALWhiterunGuardConfrontationQuest.SetGateAlias()
	endif
EndFunction

Event OnInit()
	DLCSupportCheck()
	
	;OnInit will only fire once, initialize the version tracking number here.
	LastVersion = 418
	VersionCheck()
EndEvent

Function VersionCheck()
	if( LastVersion < 418 )
		if( ChargenQuest.GetStage() >= 10 && ChargenQuest.GetStage() < 20 )
			ARTHLALUpgradeNotice.Show()
			Return
		EndIf

		if( LastVersion < 402 )
			ARTHLALPatch402Quest.Process()
		Elseif( LastVersion < 417 )
			ARTHLALPatch417Quest.Process()
		Elseif( LastVersion < 418 )
			ARTHLALPatch418Quest.Process()
		EndIf
	EndIf
EndFunction
