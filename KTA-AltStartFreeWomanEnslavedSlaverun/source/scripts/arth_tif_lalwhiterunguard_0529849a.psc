;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname ARTH_TIF_LALWhiterunGuard_0529849A Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
if( ARTHLALRumorsOfWarQuest.GetStageDone(205) == 0 )
  ARTHLALRumorsOfWarQuest.ToldByGuards = True
  ARTHLALRumorsOfWarQuest.SetStage(205)
endif
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ARTH_LAL_RumorsOfWarScript Property ARTHLALRumorsOfWarQuest Auto 
