scriptName ARTH_LAL_PostHelgenEnableScript extends ObjectReference

float property myDaysPassed auto
GlobalVariable property gGameDaysPassed auto
Location property myLocation auto
ObjectReference property myBridgeDebris auto
ObjectReference property myBridge auto
ObjectReference myLink
Quest Property MQ102 Auto

;****************************

Event onLoad()
	if( MQ102.GetStage() >= 5 )
		myLink = getLinkedRef() as ObjectReference
		if( myLink.IsDisabled() )
			if (myDaysPassed <= gGameDaysPassed.getValue()) && (game.getPlayer().IsInLocation(myLocation) == false)
				myLink.enable()
				myBridge.disable()
				myBridgeDebris.disable()
				disable()
			endif
		Else
			disable()
		EndIf
	endif
endEvent

;****************************