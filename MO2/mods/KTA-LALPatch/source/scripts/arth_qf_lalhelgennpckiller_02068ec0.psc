;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname ARTH_QF_LALHelgenNPCKiller_02068EC0 Extends Quest Hidden

;BEGIN ALIAS PROPERTY PoolRoomImperial3
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_PoolRoomImperial3 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY TortureRoomImperialSoldier3
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_TortureRoomImperialSoldier3 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY TortureRoomImperialSoldier1
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_TortureRoomImperialSoldier1 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY StoreroomStormcloak1
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_StoreroomStormcloak1 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY TortureRoomStormcloak3
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_TortureRoomStormcloak3 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY TortureRoomImperialSoldier2
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_TortureRoomImperialSoldier2 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY TortureRoomStormcloak1
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_TortureRoomStormcloak1 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Torturer
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Torturer Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY PoolRoomStormcloak1
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_PoolRoomStormcloak1 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY PoolRoomStormcloak4
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_PoolRoomStormcloak4 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY PoolRoomImperial5
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_PoolRoomImperial5 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY TortureRoomStormcloak2
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_TortureRoomStormcloak2 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY StoreroomImperial2
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_StoreroomImperial2 Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
;Time to shut down!
Stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
;Nothing here, just start up and wait.
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
;Triggered when Player enters the keep from the front side while the LAL quest is still running.
Alias_StoreroomStormcloak1.TryToEnable()
Alias_StoreroomStormcloak1.TryToKill()

Alias_StoreroomImperial2.TryToEnable()
Alias_StoreroomImperial2.TryToKill()

Alias_Torturer.TryToKill()
Alias_TortureRoomImperialSoldier1.TryToKill()
Alias_TortureRoomImperialSoldier2.TryToKill()
Alias_TortureRoomImperialSoldier3.TryToKill()

Alias_TortureRoomStormcloak1.TryToKill()
Alias_TortureRoomStormcloak2.TryToKill()
Alias_TortureRoomStormcloak3.TryToKill()

Alias_PoolRoomStormcloak1.TryToEnable()
Alias_PoolRoomStormcloak4.TryToEnable()
Alias_PoolRoomStormcloak1.TryToKill()
Alias_PoolRoomStormcloak4.TryToKill()

Alias_PoolRoomImperial3.TryToEnable()
Alias_PoolRoomImperial5.TryToEnable()
Alias_PoolRoomImperial3.TryToKill()
Alias_PoolRoomImperial5.TryToKill()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
