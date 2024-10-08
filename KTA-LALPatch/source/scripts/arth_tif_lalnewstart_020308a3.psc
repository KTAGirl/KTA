;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname ARTH_TIF_LALNewStart_020308A3 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
ARTHLALRumorsOfWarQuest.AlvorTold = True
ARTHLALRumorsOfWarQuest.SetObjectiveCompleted(29)
ARTHLALRumorsOfWarQuest.SetObjectiveCompleted(31)
ARTHLALRumorsOfWarQuest.SetObjectiveCompleted(32)
if Alvor.GetActorReference().GetRelationshipRank(Game.GetPlayer()) >= 0
 Alvor.GetActorReference().SetRelationshipRank(Game.GetPlayer(), 1)
endif
MQ102Friend.ForceRefTo(Alvor.GetActorReference())
MQ102.SetStage(30)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Quest Property MQ102  Auto  
ARTH_LAL_RumorsOfWarScript Property ARTHLALRumorsOfWarQuest Auto

ReferenceAlias Property Alvor  Auto  

ReferenceAlias Property MQ102Friend  Auto  
