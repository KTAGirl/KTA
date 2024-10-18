;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname ARTH_TIF_LALNewStart_0206A9B6 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
NewStartQuest.SetAddonQuestStage(3, ARTHLALRumorsOfWarQuest)
NewStartQuest.InnMenuChoice = 9
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ARTH_LAL_StartQuest Property NewStartQuest Auto 
Quest Property ARTHLALRumorsOfWarQuest Auto 