#tag Class
Protected Class FTParagraphStyle
Inherits FTCharacterStyle
	#tag Method, Flags = &h0
		Sub Constructor(parentControl as FormattedText, style as RTFParagraphStyle)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Initialize the base.
		  super.Constructor(parentControl, style)
		  
		  afterSpace = style.getAfterSpace
		  afterSpaceDefined = style.isAfterSpaceDefined
		  
		  alignment = style.getAlignment
		  alignmentDefined = style.isAlignmentDefined
		  
		  beforeSpace = style.getBeforeSpace
		  beforeSpaceDefined = style.isBeforeSpaceDefined
		  
		  firstIndent = style.getFirstIndent
		  firstIndentDefined = style.isFirstIndentDefined
		  
		  leftMargin = style.getLeftMargin
		  leftMarginDefined = style.isLeftMarginDefined
		  
		  lineSpacing = style.getLineSpacing
		  lineSpacingDefined = style.isLineSpacingDefined
		  
		  rightMargin = style.getRightMargin
		  rightMarginDefined = style.isRightMarginDefined
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1000
		Sub Constructor(parentControl as FormattedText, attributeList as XmlAttributeList)
		  
		  #If Not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Initialize the base.
		  super.Constructor(parentControl, attributeList)
		  
		  
		  ' Load the attributes.
		  afterSpace = Val(attributeList.value(FTCxml.XML_AFTER_SPACE))
		  
		  Dim iValue As Integer = Val(attributeList.value(FTCxml.XML_ALIGNMENT))
		  Dim oTempAlignment As FTParagraph.Alignment_Type = FTParagraph.GetAlignmentFromValue(iValue)
		  alignment = oTempAlignment
		  
		  beforeSpace = Val(attributeList.value(FTCxml.XML_BEFORE_SPACE))
		  
		  firstIndent = Val(attributeList.value(FTCxml.XML_FIRST_INDENT))
		  firstIndentDefined = FTUtilities.stringToBoolean(attributeList.value(FTCxml.XML_FIRST_INDENT_DEFINED))
		  
		  leftMargin = Val(attributeList.value(FTCxml.XML_LEFT_MARGIN))
		  leftMarginDefined = FTUtilities.stringToBoolean(attributeList.value(FTCxml.XML_LEFT_MARGIN_DEFINED))
		  
		  rightMargin = Val(attributeList.value(FTCxml.XML_RIGHT_MARGIN))
		  rightMarginDefined = FTUtilities.stringToBoolean(attributeList.value(FTCxml.XML_RIGHT_MARGIN_DEFINED))
		  
		  lineSpacing = Val(attributeList.value(FTCxml.XML_LINE_SPACING))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(parentControl as FormattedText, style as XmlElement)
		  //Issue 3797: Fixes for XML encoding and decoding of files
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Initialize the base. 
		  Super.Constructor(parentControl, style)
		  
		  ' Load the attributes. 
		  
		  Dim s As String
		  
		  s = style.GetAttribute(FTCxml.XML_AFTER_SPACE) 
		  
		  If s <> "" Then setAfterSpace(s.Val)
		  
		  s = style.GetAttribute(FTCxml.XML_ALIGNMENT) 
		  
		  Dim oTempAlignment As FTParagraph.Alignment_Type = FTParagraph.GetAlignmentFromValue(s.Val)
		  setAlignment( oTempAlignment )
		  
		  s = style.GetAttribute(FTCxml.XML_BEFORE_SPACE) 
		  
		  If s <> "" Then setBeforeSpace(s.Val)
		  
		  s = style.GetAttribute(FTCxml.XML_FIRST_INDENT) 
		  
		  If s <> "" Then setFirstIndent(s.Val)
		  
		  s = style.GetAttribute(FTCxml.XML_LEFT_MARGIN) 
		  
		  If s <> "" Then setLeftMargin(s.Val)
		  
		  s = style.GetAttribute(FTCxml.XML_RIGHT_MARGIN) 
		  
		  If s <> "" Then setRightMargin(s.Val)
		  
		  s = style.GetAttribute(FTCxml.XML_LINE_SPACING) 
		  
		  If s <> "" Then setLineSpacing(s.Val)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(p as FTParagraph)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Get the paragraph characteristics.
		  afterSpace = p.getAfterParagraphSpace
		  alignment = p.getAlignment
		  beforeSpace = p.getBeforeParagraphSpace
		  firstIndent = p.getFirstIndent
		  leftMargin = p.getLeftMargin
		  lineSpacing = p.getLineSpacing
		  rightMargin = p.getRightMargin
		  setBackgroundColor(p.getBackgroundColor)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getAfterSpace() As double
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the after space.
		  return afterSpace
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getAlignment() As FTParagraph.Alignment_Type
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the alignment attribute.
		  return alignment
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getBeforeSpace() As double
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the before space.
		  return beforeSpace
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getFirstIndent() As double
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the first indent attribute.
		  return firstIndent
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getLeftMargin() As double
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the left margin attribute.
		  return leftMargin
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getLineSpacing() As double
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the line spacing attribute.
		  return lineSpacing
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getRightMargin() As double
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the right margin attribute.
		  return rightMargin
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub getRTF(rtf as RTFWriter)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim style as RTFParagraphStyle
		  
		  ' Create a new style.
		  style = new RTFParagraphStyle(getStyleName)
		  
		  ' Fill in the base attributes.
		  super.getRTF(rtf, style)
		  
		  ' Set the paragraph attributes.
		  style.setAfterSpace(afterSpace)
		  style.setAlignment(alignment)
		  style.setBeforeSpace(beforeSpace)
		  if firstIndentDefined then style.setFirstIndent(firstIndent)
		  if leftMarginDefined then style.setLeftMargin(leftMargin)
		  if rightMarginDefined then style.setRightMargin(rightMargin)
		  style.setLineSpacing(lineSpacing)
		  
		  ' Save the style.
		  rtf.addParagraphStyle(style)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub getXML(style as XmlElement)
		  //Issue 3797: Fixes for XML encoding and decoding of files
		  #If Not DebugBuild
		    
		    #Pragma BoundsChecking FTC_BOUNDSCHECKING
		    #Pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #Pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #EndIf
		  
		  ' Load up the base attributes. 
		  Super.getXML(style)
		  
		  ' Load the attributes.
		  If isAfterSpaceDefined Then style.SetAttribute(FTCxml.XML_AFTER_SPACE, Str(afterSpace))
		  
		  If isAlignmentDefined Then style.SetAttribute(FTCxml.XML_ALIGNMENT, Str(alignment))
		  
		  If isBeforeSpaceDefined Then style.SetAttribute(FTCxml.XML_BEFORE_SPACE, Str(beforeSpace)) 
		  
		  If isFirstIndentDefined Then style.SetAttribute(FTCxml.XML_FIRST_INDENT, Str(firstIndent))
		  
		  If isLeftMarginDefined Then style.SetAttribute(FTCxml.XML_LEFT_MARGIN, Str(leftMargin))
		  
		  If isRightMarginDefined Then style.SetAttribute(FTCxml.XML_RIGHT_MARGIN, Str(rightMargin))
		  
		  If isLineSpacingDefined Then style.SetAttribute(FTCxml.XML_LINE_SPACING, Str(lineSpacing))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isAfterSpaceDefined() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Has the attribute been set?
		  return afterSpaceDefined
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isAlignmentDefined() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Has the alignment been set?
		  return alignmentDefined
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isBeforeSpaceDefined() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Has the attribute been set?
		  return beforeSpaceDefined
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isFirstIndentDefined() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Has the first indent been set?
		  return firstIndentDefined
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isLeftMarginDefined() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Has the left margin been set?
		  return leftMarginDefined
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isLineSpacingDefined() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Has the attribute been set?
		  return lineSpacingDefined
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isRightMarginDefined() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Has the right margin been set?
		  return rightMarginDefined
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setAfterSpace(space as double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set the after space.
		  afterSpace = space
		  
		  ' The attribute has been defined.
		  afterSpaceDefined = true
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setAlignment(alignment as FTParagraph.Alignment_Type)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the alignment.
		  me.alignment = alignment
		  
		  ' The attribute has been defined.
		  alignmentDefined = true
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setBeforeSpace(space as double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set the before space.
		  beforeSpace = space
		  
		  ' The attribute has been defined.
		  beforeSpaceDefined = true
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setFirstIndent(margin as double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the indent.
		  firstIndent = margin
		  
		  ' The indent has been defined.
		  firstIndentDefined = true
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setLeftMargin(margin as double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the margin.
		  leftMargin = margin
		  
		  ' The margin has been defined.
		  leftMarginDefined = true
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setLineSpacing(lineSpacing as double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the line spacing.
		  me.lineSpacing = lineSpacing
		  
		  ' The attribute has been defined.
		  lineSpacingDefined = true
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setRightMargin(margin as double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the margin.
		  rightMargin = margin
		  
		  ' The margin has been defined.
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
		Private alignment As FTParagraph.Alignment_Type = FTParagraph.Alignment_Type.None
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
		Private lineSpacing As double = 1.0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private lineSpacingDefined As boolean
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
