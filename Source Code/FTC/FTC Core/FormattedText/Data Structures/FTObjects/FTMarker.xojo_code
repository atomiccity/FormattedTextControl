#tag Class
Protected Class FTMarker
Inherits FTObject
	#tag Method, Flags = &h0
		Function clone() As FTObject
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Create a clone.
		  return new FTMarker(parentControl)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1000
		Sub Constructor(parentControl as FormattedText, type as integer)
		  
		  super.Constructor(parentControl)
		  
		  me.type = type
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getLength() As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Default to one unit.
		  return 0
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private type As integer
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="colorOpacity"
			Group="Behavior"
			Type="Double"
			InheritedFrom="FTObject"
		#tag EndViewProperty
		#tag ViewProperty
			Name="hasShadow"
			Group="Behavior"
			Type="Boolean"
			InheritedFrom="FTObject"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HyperLink"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
			InheritedFrom="FTObject"
		#tag EndViewProperty
		#tag ViewProperty
			Name="hyperLinkColor"
			Group="Behavior"
			InitialValue="&c0000ff"
			Type="color"
			InheritedFrom="FTObject"
		#tag EndViewProperty
		#tag ViewProperty
			Name="hyperLinkColorDisabled"
			Group="Behavior"
			InitialValue="&cC0C0C0"
			Type="color"
			InheritedFrom="FTObject"
		#tag EndViewProperty
		#tag ViewProperty
			Name="hyperLinkColorRollover"
			Group="Behavior"
			InitialValue="&cFF0000"
			Type="color"
			InheritedFrom="FTObject"
		#tag EndViewProperty
		#tag ViewProperty
			Name="hyperLinkColorVisited"
			Group="Behavior"
			InitialValue="&c800080"
			Type="color"
			InheritedFrom="FTObject"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="inNewWindow"
			Group="Behavior"
			Type="Boolean"
			InheritedFrom="FTObject"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="markColor"
			Group="Behavior"
			InitialValue="&h000000"
			Type="Color"
			InheritedFrom="FTObject"
		#tag EndViewProperty
		#tag ViewProperty
			Name="marked"
			Group="Behavior"
			InitialValue="0"
			Type="boolean"
			InheritedFrom="FTObject"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="shadowAngle"
			Group="Behavior"
			Type="double"
			InheritedFrom="FTObject"
		#tag EndViewProperty
		#tag ViewProperty
			Name="shadowBlur"
			Group="Behavior"
			Type="Double"
			InheritedFrom="FTObject"
		#tag EndViewProperty
		#tag ViewProperty
			Name="shadowColor"
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
			InheritedFrom="FTObject"
		#tag EndViewProperty
		#tag ViewProperty
			Name="shadowOffset"
			Group="Behavior"
			Type="Double"
			InheritedFrom="FTObject"
		#tag EndViewProperty
		#tag ViewProperty
			Name="shadowOpacity"
			Group="Behavior"
			Type="Double"
			InheritedFrom="FTObject"
		#tag EndViewProperty
		#tag ViewProperty
			Name="strikeThrough"
			Group="Behavior"
			InitialValue="0"
			Type="boolean"
			InheritedFrom="FTObject"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="textColor"
			Group="Behavior"
			InitialValue="&h000000"
			Type="color"
			InheritedFrom="FTObject"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="underline"
			Group="Behavior"
			InitialValue="0"
			Type="boolean"
			InheritedFrom="FTObject"
		#tag EndViewProperty
		#tag ViewProperty
			Name="useCustomHyperLinkColor"
			Group="Behavior"
			Type="Boolean"
			InheritedFrom="FTObject"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
