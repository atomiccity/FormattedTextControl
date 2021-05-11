#tag Class
Protected Class FTTabStop
Inherits FTbase
	#tag Method, Flags = &h0
		Function clone() As FTTabStop
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Create a clone.
		  return new FTTabStop(parentControl, tabType, tabStop, default)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(parentControl as FormattedText, tabType as FTTabStop.TabStopType, tabStop as double, default as boolean, tabLeader as FTTab.Tab_Leader_Type = FTTab.Tab_Leader_Type.None)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the parent control.
		  super.Constructor(parentControl)
		  
		  ' Save the attributes.
		  me.tabType = tabType
		  me.tabStop = tabStop
		  Me.default = default
		  Me.tabLeader = tabLeader
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetTabLeader() As FTTab.Tab_Leader_Type
		  #If Not DebugBuild
		    
		    #Pragma BoundsChecking FTC_BOUNDSCHECKING
		    #Pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #Pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #EndIf
		  
		  ' Return the tab leader.
		  Return tabLeader
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getTabStop() As double
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the tab stop.
		  return tabStop
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getTabType() As TabStopType
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the tab type.
		  return tabType
		  
		End Function
	#tag EndMethod


	#tag Note, Name = Untitled
		
		
	#tag EndNote


	#tag Property, Flags = &h0
		default As boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		tabLeader As FTTab.Tab_Leader_Type
	#tag EndProperty

	#tag Property, Flags = &h21
		Private tabStop As double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private tabType As TabStopType
	#tag EndProperty


	#tag Enum, Name = TabStopType, Type = Integer, Flags = &h0
		None
		  Left
		  Center
		Right
	#tag EndEnum


	#tag ViewBehavior
		#tag ViewProperty
			Name="default"
			Group="Behavior"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="tabLeader"
			Group="Behavior"
			Type="FTTab.Tab_Leader_Type"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
