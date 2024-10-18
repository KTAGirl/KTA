Scriptname KTASeduceApplyScript extends activemagiceffect  

; Spell Property KTASeduceSpell1 Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
       Debug.Notification("Seduce: Apply " + akTarget.GetActorBase().GetName() )
	; akTarget.AddSpell(KTASeduceSpell1)
	float st = akTarget.GetActorValue("Stamina")
	akTarget.DamageAV("Stamina",st*0.25)
	st = akTarget.GetActorValue("Stamina")
       Debug.Notification("Seduce: "+akTarget.GetActorBase().GetName()+" st="+st)
EndEvent