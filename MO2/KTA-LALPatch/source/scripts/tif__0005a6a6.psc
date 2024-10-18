;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF__0005A6A6 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetStage(220)
;Added by LAL 3.1.0
if( ARTHLALChargenQuest.GetStageDone(20) == 0 )
  if( ARTHLALRumorsOfWarQuest.GetStage() < 206 && ARTHLALWhiterunGuardConfrontationQuest.GetStage() < 10 )
    ARTHLALRumorsOfWarQuest.SetStage(201)
  endif
endif
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Quest Property ARTHLALChargenQuest Auto
Quest Property ARTHLALRumorsOfWarQuest Auto 
Quest Property ARTHLALWhiterunGuardConfrontationQuest Auto 