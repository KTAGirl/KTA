;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname ARTH_QF_LAL_FactionAssault_05284076 Extends Quest Hidden

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
FriendlyFire.AssaultCheck( Game.GetPlayer() )
Stop()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ARTH_LAL_FriendlyFireScript Property FriendlyFire Auto 
