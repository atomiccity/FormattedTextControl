#tag Class
Protected Class FTInsertionPointTimer
Inherits Timer
	#tag Event
		Sub Action()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Update the display.
		  parentControl.blinkCaret(state)
		  
		  ' Flip the on off state.
		  state = not state
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub constructor(parentControl as FormattedText)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the reference to the parent control.
		  me.parentControl = parentControl
		  
		  ' Set the execution period.
		  period = BLINK_TIME
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub start()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Turn on the timer.
		  mode = Timer.ModeMultiple
		  
		  ' Update the display.
		  parentControl.blinkCaret(true)
		  
		  ' Set the state.
		  state = true
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub stop()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Turn off the timer.
		  mode = Timer.ModeOff
		  
		  ' Update the display.
		  parentControl.blinkCaret(false)
		  
		  ' Set the state.
		  state = false
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private parentControl As FormattedText
	#tag EndProperty

	#tag Property, Flags = &h21
		Private state As boolean
	#tag EndProperty


	#tag Constant, Name = BLINK_TIME, Type = Double, Dynamic = False, Default = \"333", Scope = Private
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			Type="Integer"
			InheritedFrom="Timer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			Type="Integer"
			InheritedFrom="Timer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Mode"
			Visible=true
			Group="Behavior"
			InitialValue="2"
			Type="Integer"
			EditorType="Enum"
			InheritedFrom="Timer"
			#tag EnumValues
				"0 - Off"
				"1 - Single"
				"2 - Multiple"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
			InheritedFrom="Timer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Period"
			Visible=true
			Group="Behavior"
			InitialValue="1000"
			Type="Integer"
			InheritedFrom="Timer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
			InheritedFrom="Timer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			Type="Integer"
			InheritedFrom="Timer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
