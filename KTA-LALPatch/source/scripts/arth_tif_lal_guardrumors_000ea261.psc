;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname ARTH_TIF_LAL_GuardRumors_000EA261 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
if( ARTHLALRumorsOfWarQuest.GetStageDone(206) == 0 && MQ102.GetStage() < 5 )
  ARTHLALRumorsOfWarQuest.SetStage(206)
endif
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Quest Property ARTHLALRumorsOfWarQuest Auto 
Quest Property MQ102 Auto 