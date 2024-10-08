ScriptName ARTH_UTILS_LightSwitchToggle extends ObjectReference
{Controls a set of lights with a master enable parent marker with this
script attached to turn on and off at the times of the day specified
by the properties LightsOffTime and LightsOnTime. Script written by Cipscis.
Available on the CK Wiki: https://www.creationkit.com/index.php?title=Light_Switch}

float Property LightsOffTime = 6.0 auto
{The time at which lights should be turned off}
float Property LightsOnTime = 20.0 auto
{The time at which lights should be turned on}

bool Property SystemEnabled = true Auto
{Toggle to enable or disable the lighting system. Usually called by external scripts}

bool Property TurnOffIfDisabled = false auto
{Turn the lights to the off state if the system is set to be disabled. Useful if a location won't be populated after a certain point.}

float Function GetCurrentHourOfDay() global
{Returns the current time of day in hours since midnight}

	float Time = Utility.GetCurrentGameTime()
	Time -= Math.Floor(Time) ; Remove "previous in-game days passed" bit
	Time *= 24 ; Convert from fraction of a day to number of hours
	Return Time

EndFunction

Function RegisterForSingleUpdateGameTimeAt(float GameTime)
{Registers for a single UpdateGameTime event at the next occurrence
of the specified GameTime (in hours since midnight)}

	float CurrentTime = GetCurrentHourOfDay()
	If (GameTime < CurrentTime)
		GameTime += 24
	EndIf

	RegisterForSingleUpdateGameTime(GameTime - CurrentTime)

EndFunction

Function SystemSetup()
	If (GetCurrentHourOfDay() > LightsOffTime)
		GoToState("LightsOff")
	Else
		GoToState("LightsOn")
	EndIf
EndFunction

Function EnableSystem()
	SystemEnabled = True
	
	SystemSetup()
EndFunction

Function DisableSystem()
	SystemEnabled = False
	UnregisterForUpdateGameTime()

	if( TurnOffIfDisabled )
		GoToState("LightsOff")
	else
		GoToState("LightsOn")
	endif
EndFunction

Event OnInit()
	EnableSystem()
EndEvent

State LightsOff

	Event OnBeginState()
		Disable()

		if( SystemEnabled )
			RegisterForSingleUpdateGameTimeAt(LightsOnTime)
		endif
	EndEvent

	Event OnUpdateGameTime()
		if( SystemEnabled )
			GoToState("LightsOn")
		endif
	EndEvent

EndState

State LightsOn

	Event OnBeginState()
		Enable()

		if( SystemEnabled )
			RegisterForSingleUpdateGameTimeAt(LightsOffTime)
		EndIf
	EndEvent

	Event OnUpdateGameTime()
		if( SystemEnabled )
			GoToState("LightsOff")
		EndIf
	EndEvent

EndState
