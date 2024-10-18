scriptName dunPostHelgenEnableScript extends ObjectReference

float property myDaysPassed auto
GlobalVariable property gGameDaysPassed auto
Location property myLocation auto
ObjectReference property myBridgeDebris auto
ObjectReference property myBridge auto
ObjectReference myLink
Quest Property MQ102 Auto

;****************************

Event onLoad()
	if( MQ102.GetStage() >= 5 ) ; This should be the case once Helgen is properly destroyed so won't be an issue if no alt-start is in use.
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