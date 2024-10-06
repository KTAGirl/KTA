Scriptname ARTH_LAL_MQ102DragonsReachScript extends ObjectReference  
{Triggers the scene in Dragonsreach between Balgruuf and Avanecci}

Quest Property MQ102 Auto
Quest Property MQ102A Auto
Quest Property MQ102B Auto
Quest Property CW03 Auto
ARTH_LAL_RumorsOfWarScript Property ARTHLALRumorsOfWarQuest Auto
Quest Property CWSiege Auto
Quest Property DialogueWhiterunGuardGateStop Auto
Quest Property ARTHLALWhiterunGuardConfrontationQuest Auto
ReferenceAlias Property Balgruuf Auto
ReferenceAlias Property Irileth Auto
ReferenceAlias Property Proventus Auto
ObjectReference Property JarlThroneWhiterun Auto
ObjectReference Property WhiterunMapMarker Auto
ObjectReference Property WhiterunDragonsReachMapMarker Auto

Event OnTriggerEnter( ObjectReference ActorRef )
	if( ActorRef == Game.GetPlayer() )
		if( CW03.GetStage() == 10 && ARTHLALRumorsOfWarQuest.GetStage() >= 202 && ARTHLALRumorsOfWarQuest.GetStage() < 206 )
			ARTHLALRumorsOfWarQuest.SetStage(206)
			Utility.Wait(1)
		EndIf

		if( MQ102.GetStage() >= 5 )
			if( !(MQ102A.IsRunning()) && !(MQ102B.IsRunning()) )
				;debug.trace( "LAL: Dragonsreach MQ102 Box triggered" )
				if( Balgruuf.GetActorReference().GetDistance(JarlThroneWhiterun) > 256 )
					Balgruuf.GetActorReference().MoveToMyEditorLocation()
				EndIf
				if( Irileth.GetActorReference().GetDistance(JarlThroneWhiterun) > 384 )
					Irileth.GetActorReference().MoveToMyEditorLocation()
				EndIf
				if( Proventus.GetActorReference().GetDistance(JarlThroneWhiterun) > 256 )
					Proventus.GetActorReference().MoveToMyEditorLocation()
				EndIf
				MQ102.SetStage(75)
			EndIf

			;Failsafe step in the event the gate confrontation got bypassed somehow.
			if( DialogueWhiterunGuardGateStop.GetStage() != 10 )
				DialogueWhiterunGuardGateStop.SetStage(10)
			EndIf
			if( ARTHLALWhiterunGuardConfrontationQuest.GetStage() != 10 )
				ARTHLALWhiterunGuardConfrontationQuest.SetStage(10)
			endif

			;Double failsafe to bring back the map markers.
			WhiterunMapMarker.Enable()
			WhiterunDragonsReachMapMarker.Enable()
			ARTHLALRumorsOfWarQuest.ToggleOCSGateTrigger(true)
			ARTHLALRumorsOfWarQuest.GuardShouldConfront = false

			;If the CW Siege is running, disable them again because the battle scripts take care of this on their own.
			if( CWSiege.IsRunning() )
				WhiterunMapMarker.Disable()
				WhiterunDragonsReachMapMarker.Disable()
			EndIf

			Disable()
			DeleteWhenAble()
		EndIf
	EndIf
EndEvent
