;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname ARTH_QF_LALWhiterunGuard_0529847F Extends Quest Hidden

;BEGIN ALIAS PROPERTY WhiterunCityGate
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_WhiterunCityGate Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY WhiterunGateGuard
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_WhiterunGateGuard Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY GateGuardMarker
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_GateGuardMarker Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
Alias_WhiterunGateGuard.GetReference().MoveTo(Alias_GateGuardMarker.GetReference())
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
WhiterunGate.Lock(false)
if( WhiterunMapMarker.IsDisabled() )
  WhiterunMapMarker.Enable()
  WhiterunDragonsReachMapMarker.Enable()
endif
ARTHLALRumorsOfWarQuest.ToggleOCSGateTrigger(true)
ARTHLALRumorsOfWarQuest.GuardShouldConfront = False
Alias_WhiterunGateGuard.TryToEvaluatePackage()
Stop()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Function SetGateAlias()
	if( DLCSupport.OCSInstalled == True )
		ObjectReference OCSGate = (Game.GetFormFromFile( 0x0001A760, "Open Cities Skyrim.esp" )) as ObjectReference
		Alias_WhiterunCityGate.ForceRefTo(OCSGate)
	else
		Alias_WhiterunCityGate.ForceRefTo(WhiterunGate)
	endif
Endfunction

ObjectReference Property WhiterunGate Auto  
ObjectReference Property WhiterunMapMarker Auto
ObjectReference Property WhiterunDragonsReachMapMarker Auto
ARTH_LAL_RumorsOfWarScript Property ARTHLALRumorsOfWarQuest Auto
ARTH_LAL_VersionTrackingScript Property DLCSupport Auto
