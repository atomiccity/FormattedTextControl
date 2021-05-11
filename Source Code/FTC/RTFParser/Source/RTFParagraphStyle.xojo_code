#tag Class
Protected Class RTFParagraphStyle
Inherits RTFCharacterStyle
	#tag Method, Flags = &h0
		Function getAfterSpace() As double
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the after space.
		  return afterSpace
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getAlignment() As FTParagraph.Alignment_Type
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the alignment attribute.
		  Return alignment
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getAttributes(parent as RTFWriter) As string
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim sa() as string
		  
		  ' Add the paragraph specific attributes.
		  
		  if isAlignmentDefined then
		    
		    Select Case getAlignment
		      
		    Case FTParagraph.Alignment_Type.Left
		      
		      sa.Append("\ql ")
		      
		    Case FTParagraph.Alignment_Type.Center
		      
		      sa.Append("\qc ")
		      
		    case FTParagraph.Alignment_Type.Right
		      
		      sa.Append("\qr ")
		      
		    else
		      
		      sa.Append("\ql ")
		      
		    end select
		    
		  end if
		  
		  if isFirstIndentDefined then _
		  sa.Append("\fi" + Str(RTFUtilities.inchesToTWIPS(getFirstIndent)) + " ")
		  
		  if getBeforeSpace <> 0 then _
		  sa.Append("\sb" + Str(RTFUtilities.inchesToTWIPS(getBeforeSpace)) + " ")
		  
		  if getAfterSpace <> 0 then _
		  sa.Append("\sa" + Str(RTFUtilities.inchesToTWIPS(getAfterSpace)) + " ")
		  
		  if isLeftMarginDefined then _
		  sa.Append("\li" + Str(RTFUtilities.inchesToTWIPS(getLeftMargin)) + " ")
		  
		  if isRightMarginDefined then _
		  sa.Append("\ri" + Str(RTFUtilities.inchesToTWIPS(getRightMargin)) + " ")
		  
		  if getLineSpacing <> 0 then _
		  sa.Append("\sl" + Str(getLineSpacing * 240) + " \slmult1 ")
		  
		  ' Add in the basic attributes.
		  sa.Append(super.getAttributes(parent))
		  
		  ' Return the attributes list.
		  return join(sa, "")
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getBeforeSpace() As double
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the before space.
		  return beforeSpace
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getFirstIndent() As double
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the first indent.
		  return firstIndent
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getLeftMargin() As double
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the left margin attribute.
		  return leftMargin
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getLineSpacing() As double
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the line spacing.
		  return lineSpacing
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getParagraphBackgroundColor() As Color
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the paragraph background color attribute.
		  return paragraphBackgroundColor
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getRightMargin() As double
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the right margin attribute.
		  return rightMargin
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isAfterSpaceDefined() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Has the attribute been set?
		  return afterSpaceDefined
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isAlignmentDefined() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Has the alignment been set?
		  return alignmentDefined
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isBeforeSpaceDefined() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Has the attribute been set?
		  return beforeSpaceDefined
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isFirstIndentDefined() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Has the first indent been set?
		  return firstIndentDefined
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isLeftMarginDefined() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Has the left margin been set?
		  return leftMarginDefined
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isLineSpacingDefined() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Has the attribute been set?
		  return lineSpacingDefined
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isParagraphBackgroundColorDefined() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Has the the background color been set?
		  return paragraphBackgroundColorDefined
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isRightMarginDefined() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Has the right margin been set?
		  return rightMarginDefined
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setAfterSpace(space as double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set the after space.
		  afterSpace = space
		  
		  ' The attribute has been set.
		  afterSpaceDefined = true
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setAlignment(alignment as FTParagraph.Alignment_Type)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the alignment.
		  me.alignment = alignment
		  
		  ' The attribute has been set.
		  alignmentDefined = true
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setBeforeSpace(space as double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set the before space.
		  beforeSpace = space
		  
		  ' The attribute has been set.
		  beforeSpaceDefined = true
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setFirstIndent(indent as double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the indent.
		  firstIndent = indent
		  
		  ' The attribute has been set.
		  firstIndentDefined = true
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setLeftMargin(margin as double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the margin.
		  leftMargin = margin
		  
		  ' The attribute has been set.
		  leftMarginDefined = true
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setLineSpacing(lineSpacing as double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set the line spacing.
		  me.lineSpacing = lineSpacing
		  
		  ' The attribute has been set.
		  lineSpacingDefined = true
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setParagraphBackgroundColor(c as Color)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the color.
		  me.paragraphBackgroundColor = c
		  
		  ' The attribute has been set.
		  paragraphBackgroundColorDefined = true
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setRightMargin(margin as double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the margin.
		  rightMargin = margin
		  
		  ' The attribute has been set.
		  rightMarginDefined = true
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private afterSpace As double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private afterSpaceDefined As boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private alignment As FTParagraph.Alignment_Type
	#tag EndProperty

	#tag Property, Flags = &h21
		Private alignmentDefined As boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private beforeSpace As double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private beforeSpaceDefined As boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private firstIndent As double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private firstIndentDefined As boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private leftMargin As double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private leftMarginDefined As boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private lineSpacing As double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private lineSpacingDefined As boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private paragraphBackgroundColor As Color
	#tag EndProperty

	#tag Property, Flags = &h21
		Private paragraphBackgroundColorDefined As boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private rightMargin As double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private rightMarginDefined As boolean
	#tag EndProperty


	#tag ViewBehavior
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
	#tag EndViewBehavior
End Class
#tag EndClass
