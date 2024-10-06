Scriptname ARTH_LAL_CheskoPolygonScript extends Quest

Actor property PlayerRef auto
ARTH_LAL_RumorsOfWarScript Property ARTHLALRumorsOfWarQuest Auto
Worldspace Property Tamriel Auto

float[] HelgenTriggerzoneX
float[] HelgenTriggerzoneY

Event OnUpdate()
	;Managed to bypass this? Stop checking, or it'll just make a mess.
	if( ARTHLALRumorsOfWarQuest.GetStage() >= 206 )
		Stop()
		Return
	EndIf
	
	if( PlayerRef.GetWorldSpace() != Tamriel || PlayerRef.IsInInterior() )
		RegisterForSingleUpdate(3)
		Return
	EndIf
	
	;Is the player inside the polygon?
	bool AreWeThereYet = IsPointInPolygon(HelgenTriggerzoneX, HelgenTriggerzoneY, PlayerRef.GetPositionX(), PlayerRef.GetPositionY())

	if AreWeThereYet
		;debug.trace( "LAL: Helgen approach trigger activated." )
		ARTHLALRumorsOfWarQuest.PolygonTriggered = True
		ARTHLALRumorsOfWarQuest.SetStage(206)
		Stop()
	else
		RegisterForSingleUpdate(3)
	endif
endEvent

Function StartPolyCheck()
    ;Initialize the array
    HelgenTriggerzoneX = new float[5]
    HelgenTriggerzoneY = new float[5]

    ;Populate array values that describe the polygon. Start from upper left corner, marking clockwise.
    HelgenTriggerzoneX[0] = 10500
    HelgenTriggerzoneX[1] = 24000
    HelgenTriggerzoneX[2] = 24000
    HelgenTriggerzoneX[3] = 17500
	HelgenTriggerzoneX[4] = 10500

    HelgenTriggerzoneY[0] = -72500
    HelgenTriggerzoneY[1] = -72500
    HelgenTriggerzoneY[2] = -80000
    HelgenTriggerzoneY[3] = -90000
	HelgenTriggerzoneY[4] = -90000

    RegisterForSingleUpdate(3)
EndFunction

bool function IsPointInPolygon(float[] polyX, float[] polyY, float x, float y)

        ;-----------\
        ;Description \
        ;----------------------------------------------------------------
        ;Attempts to determine if a given point (x, y) lies inside the bounds of a polygon described as a series
        ;of ordered pairs described in the polyX[] and polyY[] arrays.
        ;If (x, y) lies exactly on one of the line segments, this functiom may return True or False.
        ;From http://alienryderflex.com/polygon/, converted to Papyrus by Chesko
        
        ;-------------\
        ;Return Values \
        ;----------------------------------------------------------------
        ;               True                            =                Point is inside polygon
        ;               False                            =              Point lies outside polygon OR polygon arrays are of different lengths

        ;float[] polyX = array that describes the polygon's x coordinates
        ;float[] polyY = array that describes the polygon's y coordinates
        ;float x           = the x coordinate under test
        ;float y           = the y coordinate under test
        
        ;Polygon arrays must be the same length
        if polyX.Length != polyY.Length
                return false
        endif
        
        int polySides = polyX.Length
        int i = 0
        int j = polySides - 1
        bool oddNodes = false

        while i < polySides
                if (((polyY[i] < y && polyY[j] >= y) || (polyY[j] < y && polyY[i] >= y)) && (polyX[i] <= x || polyX[j] <= x))
                        if (polyX[i] + (y- polyY[i]) / (polyY[j] - polyY[i]) * (polyX[j] - polyX[i])) < x
                                oddNodes = !oddNodes
                        endif
                endif
                j = i
                i += 1
        endWhile
        
        return oddNodes

endFunction
