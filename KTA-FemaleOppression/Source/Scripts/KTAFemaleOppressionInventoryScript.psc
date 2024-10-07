Scriptname KTAFemaleOppressionInventoryScript extends activemagiceffect  

Actor oppressedFemale

Event OnEffectStart(Actor akTarget, Actor akCaster)
       oppressedFemale = akTarget
	RegisterForSingleUpdate(2.0)
EndEvent

Event OnUpdate()
       Location l = oppressedFemale.GetCurrentLocation()
       If l.HasKeyword(LocTypeCity) == False && l.HasKeyword(LocTypeTown) == False && l.HasKeyword(LocTypeHabitation) == False &&  l.HasKeyword(LocTypeDwelling) == False && l.HasKeyword(LocTypeJail) == False
          Debug.Notification("NOT Oppressed: " + oppressedFemale.GetActorBase().GetName()  )
           return
       EndIf
       Form[] inventory = oppressedFemale.GetContainerForms()
       Int i = inventory.Length
       Bool doneThisTime = False
	While i && doneThisTime == False
	    i -= 1
	   Form e = inventory[i]
          Weapon w = e as Weapon
          If w
            Debug.Notification("Oppressed: " + oppressedFemale.GetActorBase().GetName() + " drops " + w.GetName())  
             oppressedFemale.DropObject(w)
             doneThisTime = True
          EndIf
          Armor a = e as Armor
          If a
            If a.GetSlotMask() == 4 && a.GetAR() > 0 && a.HasKeywordString("zbf") == False
                Debug.Notification("Oppressed: " + oppressedFemale.GetActorBase().GetName() + " drops " + a.GetName())  
                oppressedFemale.DropObject(a)
                doneThisTime = True
            EndIf
          EndIf
       EndWhile

       ; Debug.Notification("Oppressed: " + oppressedFemale.GetActorBase().GetName() + ":" + inventory.Length) 
	RegisterForSingleUpdate(2.0)
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	UnregisterForUpdate()
EndEvent

Keyword Property LocTypeCity  Auto  

Keyword Property LocTypeTown  Auto  

Keyword Property LocTypeHabitation  Auto  

Keyword Property LocTypeDwelling  Auto  

Keyword Property LocTypeJail  Auto  
