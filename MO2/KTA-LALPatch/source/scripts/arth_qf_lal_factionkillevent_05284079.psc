;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname ARTH_QF_LAL_FactionKillEvent_05284079 Extends Quest Hidden

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
if( Game.GetPlayer().IsInFaction(ThalmorFaction) )
  Game.GetPlayer().RemoveFromFaction(ThalmorFaction)
  ARTHLALRumorsOfWarQuest.HostileIntent = true
endif
if( Game.GetPlayer().IsInFaction(PenitusOculatusFaction) )
  Game.GetPlayer().RemoveFromFaction(PenitusOculatusFaction)
  ARTHLALRumorsOfWarQuest.HostileIntent = true
endif
Stop()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Faction Property PenitusOculatusFaction Auto
Faction Property ThalmorFaction Auto 
ARTH_LAL_RumorsOfWarScript Property ARTHLALRumorsOfWarQuest Auto
