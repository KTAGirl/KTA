Scriptname KTAPacifistScript extends activemagiceffect  

int incrementedDamage;

Event OnEffectStart(Actor akTarget, Actor akCaster)
; Debug.Notification("Pacifist Started!")
incrementedDamage = 0
RegisterForSingleUpdate(2.0)
EndEvent

Event OnUpdate()
;Debug.Notification("Pacifist!")
    bool BadGirl = False
    If Game.GetPlayer().GetEquippedWeapon() != None
        BadGirl = True
    EndIf
    If Game.GetPlayer().GetEquippedWeapon(True) != None
        BadGirl = True
    EndIf

    If BadGirl
         If incrementedDamage == 0
             Debug.Notification( "As a Pacifist, wielding a weapon starts to hurt you.")
         Endif
         incrementedDamage = incrementedDamage + 1
         Game.GetPlayer().DamageActorValue("Health", incrementedDamage)
    Else
         If incrementedDamage > 0
             Debug.Notification( "Pacifist: You are no longer wielding that weapon, and you're no longer hurt.")
             incrementedDamage = 0
         Endif
    EndIf

    RegisterForSingleUpdate(2.0)
EndEvent
