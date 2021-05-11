#tag Class
Protected Class RTFParagraphAttributes
	#tag Method, Flags = &h0
		Sub reset()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Reset the attributes.
		  beforeSpace = 0
		  afterSpace = 0
		  alignment = RTFAlignment.ALIGN_NONE
		  lineSpacing = 0
		  backgroundColor = &cFFFFFF
		  leftMargin = 0
		  rightMargin = 0
		  firstIndent = 0
		  pageBreak = false
		  redim tabStops(-1)
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		afterspace As double
	#tag EndProperty

	#tag Property, Flags = &h0
		alignment As RTFAlignment
	#tag EndProperty

	#tag Property, Flags = &h0
		backgroundColor As Color = &cFFFFFF
	#tag EndProperty

	#tag Property, Flags = &h0
		beforeSpace As double
	#tag EndProperty

	#tag Property, Flags = &h0
		firstIndent As double
	#tag EndProperty

	#tag Property, Flags = &h0
		Leader As Tab_Leader_Type = Tab_Leader_Type.None
	#tag EndProperty

	#tag Property, Flags = &h0
		leftMargin As double
	#tag EndProperty

	#tag Property, Flags = &h0
		lineSpacing As double
	#tag EndProperty

	#tag Property, Flags = &h0
		pageBreak As boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		rightMargin As double
	#tag EndProperty

	#tag Property, Flags = &h0
		tabStops() As String
	#tag EndProperty


	#tag Enum, Name = Tab_Leader_Type, Flags = &h0
		None
		  Dot
		  Underscore
		  Hypen
		MiddleDot
	#tag EndEnum


	#tag ViewBehavior
		#tag ViewProperty
			Name="afterspace"
			Group="Behavior"
			InitialValue="0"
			Type="double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="backgroundColor"
			Group="Behavior"
			InitialValue="&cFFFFFF"
			Type="Color"
		#tag EndViewProperty
		#tag ViewProperty
			Name="beforeSpace"
			Group="Behavior"
			InitialValue="0"
			Type="double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="firstIndent"
			Group="Behavior"
			InitialValue="0"
			Type="double"
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
			Name="leftMargin"
			Group="Behavior"
			InitialValue="0"
			Type="double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="lineSpacing"
			Group="Behavior"
			InitialValue="0"
			Type="double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="pageBreak"
			Group="Behavior"
			InitialValue="0"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="rightMargin"
			Group="Behavior"
			InitialValue="0"
			Type="double"
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
			Name="alignment"
			Group="Behavior"
			Type="RTFAlignment"
			EditorType="Enum"
			#tag EnumValues
				"0 - ALIGN_LEFT"
				"1 - ALIGN_CENTER"
				"2 - ALIGN_RIGHT"
				"3 - ALIGN_FULL"
				"4 - ALIGN_NONE"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="Leader"
			Group="Behavior"
			InitialValue="Tab_Leader_Type.None"
			Type="Tab_Leader_Type"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
