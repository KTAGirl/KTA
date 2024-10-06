;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname ARTH_TIF_LALNewStart_0207477E Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
NewStartQuest.EscapeOptionUsed = true
NewStartQuest.SetAddonQuestStage(100, ARTHLALRumorsOfWarQuest)
ARTHLALPrisonBreakMarker.Enable()
EscapeCellTrigger.Enable()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ARTH_LAL_StartQuest Property NewStartQuest Auto 
Quest Property ARTHLALRumorsOfWarQuest Auto 
ObjectReference Property ARTHLALPrisonBreakMarker Auto 
ObjectReference Property EscapeCellTrigger Auto 