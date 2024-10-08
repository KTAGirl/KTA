;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname ARTH_TIF_LALNewStart_000BCC9B Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
ARTHLALRumorsOfWarQuest.SvenTold = True
ARTHLALRumorsOfWarQuest.SetObjectiveCompleted(29)
ARTHLALRumorsOfWarQuest.SetObjectiveCompleted(31)
ARTHLALRumorsOfWarQuest.SetObjectiveCompleted(32)
MQ102.SetStage(30)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Quest Property MQ102 Auto
ARTH_LAL_RumorsOfWarScript Property ARTHLALRumorsOfWarQuest Auto 
