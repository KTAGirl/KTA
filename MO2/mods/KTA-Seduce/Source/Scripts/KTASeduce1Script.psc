Scriptname KTASeduce1Script extends activemagiceffect  

Actor MySelf

Event OnEffectStart(Actor akTarget, Actor akCaster)
	MySelf = akTarget
       Debug.Notification("Seduce1: "+MySelf.GetActorBase().GetName())
	RegisterForSingleUpdate(2.0)
EndEvent

Event OnUpdate()
	MySelf.DamageAV("Stamina",10.0)
	float st = MySelf.GetActorValue("Stamina")
       Debug.Notification("Seduce1: "+MySelf.GetActorBase().GetName()+" st="+st)
	RegisterForSingleUpdate(2.0)
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	UnregisterForUpdate()
EndEvent