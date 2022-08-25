#tag Class
Protected Class RTFStyleAttributes
	#tag Method, Flags = &h0
		Sub Constructor(style as RTFStyleAttributes = nil)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Create the font container.
		  font = new RTFFont
		  
		  ' Is there anything to do?
		  if style is nil then return
		  
		  ' Copy over the style attributes.
		  setStyle(style)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub reset()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' reset the style attributes.
		  backgroundColor = RGB(255, 255, 255)
		  bold = false
		  characterSpacing = 0
		  characterStyle = 0
		  font.reset
		  fontSize = 0
		  italic = false
		  strikeThrough = false
		  textColor = RGB(0, 0, 0)
		  underline = false
		  useBackgroundColor = false
		  useForegroundColor = false
		  hyperlink = ""
		  
		  shadow = False
		  shadowBlur = 0
		  shadowColor = RGB(0, 0, 0)
		  shadowOffset = 0
		  shadowOpacity = 0
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setStyle(style as RTFStyleAttributes)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Copy over the style attributes.
		  backgroundColor = style.backgroundColor
		  bold = style.bold
		  characterSpacing = style.characterSpacing
		  characterStyle = style.characterStyle
		  font = style.font.clone
		  fontSize = style.fontSize
		  italic = style.italic
		  strikeThrough = style.strikeThrough
		  textColor = style.textColor
		  underline = style.underline
		  useBackgroundColor = style.useBackgroundColor
		  useForegroundColor = style.useForegroundColor
		  unicodeSkipCount = style.unicodeSkipCount
		  hyperlink = style.hyperlink
		  
		  shadow = style.shadow
		  shadowBlur = style.shadowBlur
		  shadowColor = style.shadowColor
		  shadowOffset = style.shadowOffset
		  shadowOpacity = style.shadowOpacity
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		backgroundColor As Color
	#tag EndProperty

	#tag Property, Flags = &h0
		bold As boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		characterSpacing As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		characterStyle As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		font As RTFFont
	#tag EndProperty

	#tag Property, Flags = &h0
		fontSize As integer
	#tag EndProperty

	#tag Property, Flags = &h0
		hyperlink As String
	#tag EndProperty

	#tag Property, Flags = &h0
		italic As boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		scriptLevel As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		shadow As boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		shadowBlur As Double
	#tag EndProperty

	#tag Property, Flags = &h0
		shadowColor As color
	#tag EndProperty

	#tag Property, Flags = &h0
		shadowOffset As Double
	#tag EndProperty

	#tag Property, Flags = &h0
		shadowOpacity As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		strikeThrough As boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		textColor As color
	#tag EndProperty

	#tag Property, Flags = &h0
		underline As boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		unicodeSkipCount As integer = 1
	#tag EndProperty

	#tag Property, Flags = &h0
		useBackgroundColor As boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		useForegroundColor As boolean
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="backgroundColor"
			Visible=false
			Group="Behavior"
			InitialValue="&h000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="bold"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="characterStyle"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="fontSize"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="hyperlink"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="italic"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="scriptLevel"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="strikeThrough"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="textColor"
			Visible=false
			Group="Behavior"
			InitialValue="&h000000"
			Type="color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="underline"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="unicodeSkipCount"
			Visible=false
			Group="Behavior"
			InitialValue="1"
			Type="integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="useBackgroundColor"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="useForegroundColor"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="shadow"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="shadowBlur"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="shadowColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="shadowOffset"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="shadowOpacity"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="characterSpacing"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
