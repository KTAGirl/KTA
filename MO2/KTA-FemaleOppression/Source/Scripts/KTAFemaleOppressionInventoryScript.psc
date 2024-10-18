Scriptname KTAFemaleOppressionInventoryScript extends activemagiceffect  

int skyrimesmoffset = 0
string lastmsg2 = ""

Function calcOffsets()
       skyrimesmoffset = Game.GetFormFromFile(0xF,"skyrim.esm").GetFormId() - 0xF
       ; Debug.Notification("Oppressed: skyrim.esm offset = " + skyrimesmoffset)
EndFunction

Bool Function isInOppressedLocation(Actor akActor)
  Location l = akActor.GetCurrentLocation()
  If l == None
    return False
  EndIf
  If l.HasKeyword(LocTypeDwelling) || l.HasKeyword(LocTypeJail)
    return True
  EndIf
  If !l.HasKeyword(LocTypeCity) && !l.HasKeyword(LocTypeTown)
    return False
  EndIf
  int intraid = akActor.GetParentCell().GetFormId() - skyrimesmoffset
  If intraid > 107115 && intraid < 107140 ; Whiterun; noticed values are 107121 - 107135
      return True
  EndIf
  string msg2 = "Oppressed: Cell: " + akActor.GetParentCell().GetFormId() 
  If msg2 != lastmsg2
    Debug.Notification(msg2)
    lastmsg2 = msg2
  Endif 
  return False
EndFunction

Function setAndEquipOutfit(Actor akActor, Outfit oOutfit)
  akActor.GetActorBase().SetOutfit(oOutfit)
  int i = oOutfit.GetNumParts()
  While i
      i -= 1     
      Form a = oOutfit.GetNthPart(i)
      akActor.AddItem(a,1,True)
  EndWhile
  utility.wait(0.25)
  i = oOutfit.GetNumParts()
  While i
      i -= 1     
      Form a = oOutfit.GetNthPart(i)
      Debug.Notification("Equip: " + a.GetName())
      akActor.EquipItem(a,False,True)
  EndWhile
EndFunction

Actor oppressedFemale

Event OnEffectStart(Actor akTarget, Actor akCaster)
       oppressedFemale = akTarget
       calcOffsets()
	RegisterForSingleUpdate(2.0)
EndEvent

Event OnUpdate()
       ;/ Location l = oppressedFemale.GetCurrentLocation()
       If l == None
          ; Debug.Notification("NOT Oppressed (NoLoc): " + oppressedFemale.GetActorBase().GetName()  )
          RegisterForSingleUpdate(2.0) 
           return
       EndIf
       If l.HasKeyword(LocTypeCity) == False && l.HasKeyword(LocTypeTown) == False &&  l.HasKeyword(LocTypeDwelling) == False && l.HasKeyword(LocTypeJail) == False
          ; Debug.Notification("NOT Oppressed: " + oppressedFemale.GetActorBase().GetName()  )
          RegisterForSingleUpdate(2.0) 
           return
       EndIf
       /;

       Bool opp = isInOppressedLocation(oppressedFemale)
       If !opp
           RegisterForSingleUpdate(2.0) 
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
            ; Debug.Notification("Oppressed: " + oppressedFemale.GetActorBase().GetName() + " has never had " + w.GetName())  
             ; oppressedFemale.DropObject(w)
             oppressedFemale.RemoveItem(w)
             doneThisTime = True
          EndIf
          Armor a = e as Armor
          If a
            If a.GetSlotMask() == 4 && a.GetAR() > 0 && a.HasKeywordString("zbf") == False
                ; Debug.Notification("Oppressed: " + oppressedFemale.GetActorBase().GetName() + " has never had " + a.GetName())  
                ; oppressedFemale.DropObject(a)
                oppressedFemale.RemoveItem(a)
                If oppressedFemale.GetActorBase().GetOutfit() == ArmorLeatherNoHelmetOutfit
                     setAndEquipOutfit(oppressedFemale,KTAOppressedArmorLeatherNoHelmetOutfit)
                     Debug.Notification("Oppressed: Changed Outfit for" + oppressedFemale.GetActorBase().GetName())
                EndIf
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


Outfit Property ArmorLeatherNoHelmetOutfit  Auto  

Outfit Property KTAOppressedArmorLeatherNoHelmetOutfit  Auto  
