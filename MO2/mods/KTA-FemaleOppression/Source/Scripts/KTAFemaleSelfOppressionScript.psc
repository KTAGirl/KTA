Scriptname KTAFemaleSelfOppressionScript extends activemagiceffect  

int skyrimesmoffset = 0
string lastmsg2 = ""

Function calcOffsets()
       skyrimesmoffset = Game.GetFormFromFile(0xF,"skyrim.esm").GetFormId() - 0xF
       Debug.Notification("Oppressed: skyrim.esm offset = " + skyrimesmoffset)
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

string lastmsg = ""

Event OnEffectStart(Actor akTarget, Actor akCaster)
       calcOffsets()
	RegisterForSingleUpdate(2.0)
EndEvent

Event OnUpdate()
       ;/ Location l = Game.GetPlayer().GetCurrentLocation()
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
       
      string msg2 = ""
      If WhiterunLocation.isChild(l)
          msg2 = "Oppressed: in Whiterun: " + l.GetFormId() + "/" + l.GetName() + "Cell: " + Game.GetPlayer().GetParentCell().GetFormId() + "/" + Game.GetPlayer().GetParentCell().GetName()
      Else
         msg2 = "Oppressed: not it Whiterun: "  + l.GetFormId() + "/" + l.GetName() + "Cell: " + Game.GetPlayer().GetParentCell().GetFormId() + "/" + Game.GetPlayer().GetParentCell().GetName()
      EndIf
       If msg2 != lastmsg2
           Debug.Notification(msg2)
           lastmsg2 = msg2
       Endif
       /;

      Bool opp = isInOppressedLocation(Game.GetPlayer())
       string msg = ""
      If !opp
          msg = "NOT Oppressed: Player"
          If msg != lastmsg
              Debug.Notification(msg)
              lastmsg = msg
          Endif 
          RegisterForSingleUpdate(2.0)
           return
       EndIf
       msg = "Oppressed: Player"
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
            Game.GetPlayer().DropObject(w)
            bounty += 1000
            violent = True
          EndIf
          Armor a = e as Armor
          If a
            If a.GetSlotMask() == 4 && a.GetAR() > 0 && a.HasKeywordString("zbf") == False
                Debug.Notification("Oppressed: you are reported for having " + a.GetName() + " in your inventory, Drop it ASAP if you don't want bounty to mount further.")  
                Game.GetPlayer().DropObject(a)
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
Location Property WhiterunLocation Auto
