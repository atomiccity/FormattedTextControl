#tag Class
Protected Class TextAreaRTFReader
Inherits RTFReader
	#tag Event
		Sub EscapedCharacter(ch as string)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Add the escaped character.
		  addString(ConvertEncoding(ch, Encodings.UTF8))
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub NewParagraph()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Add the new paragraph.
		  ta.AppendText(EndOfLine.Macintosh)
		  
		  ' Move to the next insertion position.
		  startIndex = startIndex +  1
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub NonbreakingHyphen()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Add a hyphen.
		  addString("-")
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub NonbreakingSpace()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Add the space.
		  addString(" ")
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub StartOfParsing()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the starting caret offset.
		  startIndex = ta.SelStart
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub TextSegment(s as string)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Is this regular text data?
		  ' if not getPictureFlag then
		  
		  ' Add the string to the document.
		  addString(s)
		  
		  ' Set the alignment on the paragraph.
		  setParagraphAlignment(st.ParagraphCount - 1)
		  
		  ' end if
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub addString(s as string)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim rsa as RTFStyleAttributes
		  Dim length as integer
		  Dim si as integer
		  Dim sl as integer
		  
		  ' Get the length of the string.
		  length = s.len
		  
		  ' Get the current style run attributes.
		  rsa = getCurrentStyle
		  
		  ' Add the text to the control.
		  ta.SelText = s
		  
		  ' Save the selection information.
		  si = ta.SelStart
		  sl = ta.SelLength
		  
		  ' Select the text just added.
		  ta.SelStart = startIndex
		  ta.SelLength = length
		  
		  ' Set the font information.
		  ta.SelTextFont = rsa.font.font
		  ta.SelTextSize = rsa.fontSize
		  
		  ' Set the style characteristics.
		  ta.SelBold = rsa.bold
		  ta.SelItalic = rsa.italic
		  ta.SelUnderline = rsa.underline
		  
		  ' Was a text color specified?
		  if rsa.useForegroundColor then
		    
		    ' Use the specified color.
		    ta.SelTextColor = rsa.textColor
		    
		  else
		    
		    ' Use black.
		    ta.SelTextColor = &c000000
		    
		  end if
		  
		  ' Restore the previous settings.
		  ta.SelStart = si
		  ta.SelLength = sl
		  
		  ' Move to the next insertion position.
		  startIndex = startIndex + length
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1000
		Sub Constructor(ta as TextArea, applyStyles as boolean)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Initialize the base class.
		  Super.Constructor(applyStyles)
		  
		  ' Save the references.
		  me.ta = ta
		  st = ta.StyledText
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setParagraphAlignment(index as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set the paragraph alignment.
		  select case getCurrentParagraphAttributes.alignment
		    
		  case RTFAlignment.ALIGN_LEFT
		    
		    st.ParagraphAlignment(index) = TextArea.AlignLeft
		    
		  case RTFAlignment.ALIGN_CENTER
		    
		    st.ParagraphAlignment(index) = TextArea.AlignCenter
		    
		  case RTFAlignment.ALIGN_RIGHT
		    
		    st.ParagraphAlignment(index) = TextArea.AlignRight
		    
		  else
		    
		    st.ParagraphAlignment(index) = TextArea.AlignLeft
		    
		  end select
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		currentAlignment As integer = 1
	#tag EndProperty

	#tag Property, Flags = &h0
		paragraphCount As integer
	#tag EndProperty

	#tag Property, Flags = &h0
		st As StyledText
	#tag EndProperty

	#tag Property, Flags = &h0
		startIndex As integer
	#tag EndProperty

	#tag Property, Flags = &h0
		ta As TextArea
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="currentAlignment"
			Group="Behavior"
			InitialValue="1"
			Type="integer"
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
			Name="paragraphCount"
			Group="Behavior"
			Type="integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="startIndex"
			Group="Behavior"
			Type="integer"
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
	#tag EndViewBehavior
End Class
#tag EndClass
