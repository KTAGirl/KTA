;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname TIF__000E2D03 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
getowningquest().setstage(200)
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