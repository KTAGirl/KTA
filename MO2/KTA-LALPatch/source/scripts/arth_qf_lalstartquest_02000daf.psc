;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 150
Scriptname ARTH_QF_LALStartQuest_02000DAF Extends Quest Hidden

;BEGIN FRAGMENT Fragment_148
Function Fragment_148()
;BEGIN AUTOCAST TYPE arth_lal_startquest
Quest __temp = self as Quest
arth_lal_startquest kmyQuest = __temp as arth_lal_startquest
;END AUTOCAST
;BEGIN CODE
;Execute the expected quest module now.
;I know, odd that this is all by itself in this block, but things seem to work better this way.
kmyQuest.ExecuteAddonQuest()

;All Stages past 35 are for legacy support. Do not use them, and do not remove them!
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_123
Function Fragment_123()
;BEGIN CODE
;Stage is called from the statue dialogue scripts
SetObjectiveCompleted(1)
SetObjectiveDisplayed(2,true)
SetObjectiveDisplayed(3,false)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_12
Function Fragment_12()
;BEGIN CODE
ChargenMusic.Add()
Game.PrecacheCharGen()
game.ShowRaceMenu()
Utility.Wait(0.1)
SetStage(10)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_13
Function Fragment_13()
;BEGIN AUTOCAST TYPE arth_lal_startquest
Quest __temp = self as Quest
arth_lal_startquest kmyQuest = __temp as arth_lal_startquest
;END AUTOCAST
;BEGIN CODE
;This stage sets up the foundations for the main quest that must be completed.
;Afterwards the remaining conditions get triggered based on what the player chose at the statue.
ChargenMusic.Remove()

ARTHLALMaraStatue.Disable()
ARTHLALPrisonBreakMarker.Enable()
ARTHLALHelgenNPCKillerQuest.Start()
if( kMyQuest.MainMenuChoice != 22 )
  Player.RemoveItem(Lockpick,3,true)
  EscapeCellTrigger.Disable()
else
 SetObjectiveCompleted(3)
 ARTHLALRumorsOfWarQuest.RegisterForSingleUpdate(0.25)
endif

;Disable Alduin and then take over his start marker for MQ102 later.
AlduinRef.Disable()
MQ102.AlduinStartMarker = NewAlduinStartMarker

;MQ101 cleanup stages, so that things start the game in a proper manner.
MQ101.SetStage(20)
MQ101.SetStage(25)
MQ101.SetStage(26)
MQ101.SetStage(28)
MQ101.SetStage(30)
MQ101.SetStage(40)
MQ101.SetStage(70)
MQ101.SetStage(100)
MQ101.SetStage(145)
MQ101.SetStage(150)
MQ101.SetStage(180)
MQ101.SetStage(200)
MQ101.SetStage(250)
MQ101.SetStage(500)
MQ101.SetStage(800)
MQ101.SetStage(900)

; Imperial race perk (USKP - Should only apply to actual Imperials)
MQ00.SetStage(5) ;This starts up the HousePurchase quest so that properties will be available.
CW.SetStage(0) ;Kicks off the civil war properly.
CW.CWGarrisonEnableMarkerSonsCampFalkreath.enable() ;Makes sure field camps are enabled.
MQ101Collapse.mysound01 = None ;Stop the rock fall in Helgen Keep from playing sound.

;This block temporarily takes Hadvar and Ralof out of the way until needed.
kmyQuest.TakeGeneralsOutOfService()

;Performs the changes to make Helgen destroyed.
kmyQuest.CleanupHelgen()

;Make sure player's arms are free
kmyQuest.FixMyDamnArms()

;Helpful in case the user has survivalist mods installed.
Player.AddItem(FoodApple02, 5, true)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_14
Function Fragment_14()
;BEGIN CODE
;Bow out, start up vanilla MQ for those who for whatever reason still wish to see it.
SetObjectiveCompleted(2)
stop() ; Hey you, yes you, the guy at the keyboard. DONT MOVE THIS FROM HERE AGAIN!
ChargenMusic.Remove()
ARTHLALMaraStatue.Disable()
ARTHLALChoiceBed.Disable()
;SetObjectiveCompleted(2)
ARTHLALRumorsOfWarQuest.SetStage(99)
ARTHLALRumorsOfWarQuest.Stop()
Game.ForceFirstPerson()
MQQuickStart.SetValue(0)
VanillaStartQuest.SetStage(10)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_140
Function Fragment_140()
;BEGIN CODE
;Stage is called from the statue dialogue scripts
SetObjectiveCompleted(1)
SetObjectiveDisplayed(3,true)
SetObjectiveDisplayed(2,false)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_149
Function Fragment_149()
;BEGIN CODE
SetObjectiveCompleted(2)
SetObjectiveCompleted(3)
ARTHLALChoiceBed.Disable()
Stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_8
Function Fragment_8()
;BEGIN AUTOCAST TYPE arth_lal_startquest
Quest __temp = self as Quest
arth_lal_startquest kmyQuest = __temp as arth_lal_startquest
;END AUTOCAST
;BEGIN CODE
ARTHLALRumorsOfWarQuest.SetStage(0)
ARTHLALMaraStatue.EnableNoWait()
;enable full game control
Game.SetInChargen(false, false, false)
kmyQuest.AddRaceSpells()
SetActive()
SetObjectiveDisplayed(1)
Utility.Wait(2)
Game.RequestSave()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

;Basic properties
Quest Property VanillaStartQuest  Auto  
GlobalVariable Property MQQuickstart  Auto  
MusicType Property ChargenMusic  Auto 
Quest Property MQ101  Auto  
Quest Property MQ00  Auto  
CWScript Property CW Auto
QF_MQ102_0004E50D Property MQ102  Auto  
Quest Property MQ102A  Auto  
Quest Property MQ102B  Auto  
Actor Property Player  Auto  
Actor Property AlduinRef Auto
Quest Property ARTHLALHelgenNPCKillerQuest Auto
ObjectReference Property ARTHLALPrisonBreakMarker Auto
ObjectReference Property ARTHLALChoiceBed Auto
ObjectReference Property ARTHLALMaraStatue Auto
Quest Property ARTHLALRumorsOfWarQuest Auto

;Help out a starving player, won't you?
Potion Property FoodApple02  Auto  

;Take these away from the player if they're not using the cell escape option
MiscObject Property Lockpick  Auto  

;Used to make sure the escape trigger is only active for escape starts.
ObjectReference Property EscapeCellTrigger Auto

ObjectReference Property NewAlduinStartMarker Auto

HelgenHallCollapseScript Property MQ101Collapse Auto
