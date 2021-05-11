#tag Class
Protected Class RTFFont
	#tag Method, Flags = &h0
		Function clone() As RTFFont
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim f as RTFFont
		  
		  ' Create the clone.
		  f = new RTFFont
		  f.font = font
		  f.characterSet = characterSet
		  
		  ' Return the clone.
		  return f
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function hasCharSet() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Is the set available?
		  return (characterSet > -1)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub reset()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Reset the values.
		  font = ""
		  characterSet = -1
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		characterSet As integer = -1
	#tag EndProperty

	#tag Property, Flags = &h0
		font As string
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="characterSet"
			Group="Behavior"
			InitialValue="-1"
			Type="integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="font"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
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
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			InheritedFrom="Object"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
