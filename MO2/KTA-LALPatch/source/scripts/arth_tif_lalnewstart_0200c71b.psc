;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname ARTH_TIF_LALNewStart_0200C71B Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
NewStartQuest.SetAddonQuestStage(1, ARTHLALRumorsOfWarQuest)
NewStartQuest.ImmigrationMenuChoice = 2
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ARTH_LAL_StartQuest Property NewStartQuest Auto 
Quest Property ARTHLALRumorsOfWarQuest Auto 