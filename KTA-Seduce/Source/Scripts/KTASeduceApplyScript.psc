Scriptname KTASeduceApplyScript extends activemagiceffect  

Spell Property KTASeduceSpell1 Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
       Debug.Notification("Seduce: Apply " + akTarget.GetActorBase().GetName() )
	akTarget.AddSpell(KTASeduceSpell1)
EndEvent