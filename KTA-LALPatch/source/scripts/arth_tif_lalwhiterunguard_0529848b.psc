;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname ARTH_TIF_LALWhiterunGuard_0529848B Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetStage(10)
;Added by LAL 3.1.0
if( ARTHLALRumorsOfWarQuest.GetStage() >= 201 && ARTHLALRumorsOfWarQuest.GetStage() < 206 && ARTHLALRumorsOfWarQuest.GetStageDone(202) == 0 )
  ARTHLALRumorsOfWarQuest.SetStage(202)
endif
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

favordialoguescript Property DialogueFavorGeneric  Auto  
Quest Property ARTHLALRumorsOfWarQuest Auto 
