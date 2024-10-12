Scriptname KTAFemaleSelfOppressionScript extends activemagiceffect  

string lastmsg = ""

Event OnEffectStart(Actor akTarget, Actor akCaster)
	RegisterForSingleUpdate(2.0)
EndEvent

Event OnUpdate()
       Location l = Game.GetPlayer().GetCurrentLocation()
       string msg = ""
       If l == None
          msg = "NOT Oppressed (NoLoc): Player"
          If msg != lastmsg
              Debug.Notification(msg)
              lastmsg = msg
          Endif
          RegisterForSingleUpdate(2.0)
          return
       EndIf
       If l.HasKeyword(LocTypeCity)
           msg = "Oppressed: Loc=City" 
       EndIf
       If l.HasKeyword(LocTypeTown)
           msg = "Oppressed: Loc=Town" 
       EndIf
       If l.HasKeyword(LocTypeDwelling)
           msg = "Oppressed: Loc=Dwelling"
       EndIf
       If l.HasKeyword(LocTypeJail)
           msg = "Oppressed: Loc=Jail" 
       EndIf
       If l.HasKeyword(LocTypeCity) == False && l.HasKeyword(LocTypeTown) == False &&  l.HasKeyword(LocTypeDwelling) == False && l.HasKeyword(LocTypeJail) == False
          msg = "NOT Oppressed: Player"
          If msg != lastmsg
              Debug.Notification(msg)
              lastmsg = msg
          Endif 
          RegisterForSingleUpdate(2.0)
           return
       EndIf
       If msg != lastmsg
           Debug.Notification(msg)
           lastmsg = msg
       Endif
       Form[] inventory = Game.GetPlayer().GetContainerForms()
       Int i = inventory.Length
       int bounty = 0
       bool violent = False
	While i 
	    i -= 1
	   Form e = inventory[i]
          Weapon w = e as Weapon
          If w
            Debug.Notification("Oppressed: you are reported for having " + w.GetName() + " in your inventory, Drop it ASAP if you don't want bounty to mount further.")  
            bounty += 1000
            violent = True
          EndIf
          Armor a = e as Armor
          If a
            If a.GetSlotMask() == 4 && a.GetAR() > 0 && a.HasKeywordString("zbf") == False
                Debug.Notification("Oppressed: you are reported for having " + a.GetName() + " in your inventory, Drop it ASAP if you don't want bounty to mount further.")  
                bounty += 100
            EndIf
          EndIf
       EndWhile

       If bounty > 0
           CrimeFactionWhiterun.ModCrimeGold(bounty,violent)
       Endif

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

Faction Property CrimeFactionWhiterun  Auto  
Keyword Property LocTypeJail  Auto  
