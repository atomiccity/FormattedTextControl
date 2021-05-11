#tag Class
Protected Class RTFContext
	#tag Method, Flags = &h0
		Sub addTabStop(tabLeader as Integer, tabStop as double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Add the tab stop.
		  tabstops.Append(Str(tabLeader) + ";" + Str(tabStop))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  
		  #if not DebugBuild
		    
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Assume no alignment.
		  alignment = RTFAlignment.ALIGN_NONE
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub copyAttributes(parent as RTFContext)
		  
		  #if not DebugBuild
		    
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Copy the attributes.
		  afterSpace = parent.afterSpace
		  alignment = parent.alignment
		  backgroundColor = parent.backgroundColor
		  beforeSpace = parent.beforeSpace
		  bold = parent.bold
		  characterSpacing = parent.characterSpacing
		  characterStyleName = parent.characterStyleName
		  font = parent.font
		  fontSize = parent.fontSize
		  paragraphBackgroundColor = parent.paragraphBackgroundColor
		  foreGroundColor = parent.foreGroundColor
		  italic = parent.italic
		  pageBreak = parent.pageBreak
		  paragraphStyleName = parent.paragraphStyleName
		  plain = parent.plain
		  strikeThrough = parent.strikeThrough
		  underline = parent.underline
		  useBackgroundColor = parent.useBackgroundColor
		  useForegroundColor = parent.useForegroundColor
		  useParagraphBackgroundColor = parent.useParagraphBackgroundColor
		  
		  shadow = parent.shadow
		  shadowBlur = parent.shadowBlur
		  shadowColor = parent.shadowColor
		  shadowOffset = parent.shadowOffset
		  shadowOpacity = parent.shadowOpacity
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function dump() As string
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  const INDENT = "  "
		  
		  Dim s as string
		  
		  if bold then s = s + INDENT + "bold" + EndOfLine
		  if italic then s = s + INDENT + "italic" + EndOfLine
		  if plain then s = s + INDENT + "plain" + EndOfLine
		  if strikeThrough then s = s + INDENT + "strikethrough" + EndOfLine
		  if underline then s = s + INDENT + "underline" + EndOfLine
		  if pictData <> "" then s = s + INDENT + "picture" + EndOfLine
		  
		  s = s + INDENT + "character spacing = " + Str(characterSpacing) + EndOfLine
		  s = s + INDENT + "font = " + font + EndOfLine
		  s = s + INDENT + "font size = " + Str(fontSize) + EndOfLine
		  s = s + INDENT + "before space = " + Str(beforeSpace) + EndOfLine
		  s = s + INDENT + "after space = " + Str(afterSpace) + EndOfLine
		  s = s + INDENT + "alignment = " + Str(alignment) + EndOfLine
		  s = s + INDENT + "character style name = " + characterStyleName + EndOfLine
		  s = s + INDENT + "paragraph style name = " + paragraphStyleName + EndOfLine
		  s = s + INDENT + "text = " + text + EndOfLine
		  
		  return s
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub findColors(colorsList as Dictionary)
		  
		  #Pragma DisableBackgroundTasks
		  
		  #If Not DebugBuild
		    
		    #Pragma BoundsChecking RTF_BOUNDSCHECKING
		    #Pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #Pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #EndIf
		  
		  Dim i As Integer
		  Dim count As Integer
		  
		  ' Was a background color specified?
		  If useBackgroundColor Then
		    
		    ' Save the color.
		    colorsList.value(RTFUtilities.colorToString(backgroundColor)) = ""
		    
		  End If
		  
		  ' Was a foreground color specified?
		  If useForegroundColor Then
		    
		    ' Save the color.
		    colorsList.value(RTFUtilities.colorToString(foregroundColor)) = ""
		    
		  End If
		  
		  ' Was a paragraph background color specified?
		  If useParagraphBackgroundColor Then
		    
		    ' Save the color.
		    colorsList.value(RTFUtilities.colorToString(paragraphBackgroundColor)) = ""
		    
		  End If
		  
		  ' Was a shadow color specified?
		  If shadow Then
		    
		    ' Save the color.
		    colorsList.value(RTFUtilities.colorToString(shadowColor)) = ""
		    
		  End If
		  
		  ' Get the number of contexts.
		  count = Ubound(contextList)
		  
		  ' Scan the contexts for colors.
		  For i = 0 To count
		    
		    ' Scan the context.
		    contextList(i).findColors(colorsList)
		    
		  Next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub findFontNames(fontList as Dictionary)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  
		  ' Was a font specified?
		  if font <> "" then
		    
		    ' Save the font name.
		    fontList.value(font) = ""
		    
		  end if
		  
		  ' Get the number of contexts.
		  count = Ubound(contextList)
		  
		  ' Scan the contexts for fonts.
		  for i = 0 to count
		    
		    ' Scan the context.
		    contextList(i).findFontNames(fontList)
		    
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getRTF(parent as RTFWriter) As string
		  
		  #Pragma DisableBackgroundTasks
		  
		  #If Not DebugBuild
		    
		    #Pragma BoundsChecking RTF_BOUNDSCHECKING
		    #Pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #Pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #EndIf
		  
		  Dim i As Integer
		  Dim count As Integer
		  Dim sa() As String
		  
		  '---------------------------------------------
		  ' Style settings.
		  '---------------------------------------------
		  
		  ' Was a page break specified?
		  If pageBreak Then
		    
		    ' Add a page break.
		    sa.Append("\page")
		    
		  End If
		  
		  ' Was the paragraph style specified?
		  If paragraphStyleName <> "" Then
		    
		    ' Add the paragraph style
		    sa.Append(parent.getParagraphStyle(paragraphStyleName))
		    
		  End If
		  
		  ' Was the character style specified?
		  If characterStyleName <> "" Then
		    
		    ' Add the character style
		    sa.Append(parent.getCharacterStyle(characterStyleName))
		    
		  End If
		  
		  '---------------------------------------------
		  ' Paragraph settings.
		  '---------------------------------------------
		  
		  ' Set the alignment.
		  Select Case alignment
		    
		  Case RTFAlignment.ALIGN_LEFT
		    
		    sa.Append("\ql ")
		    
		  Case RTFAlignment.ALIGN_CENTER
		    
		    sa.Append("\qc ")
		    
		  Case RTFAlignment.ALIGN_RIGHT
		    
		    sa.Append("\qr ")
		    
		  Case RTFAlignment.ALIGN_FULL
		    
		    sa.Append("\qf ")
		    
		  End Select
		  
		  ' Set the paragraph spacing.
		  If beforeSpace > 0 Then sa.Append("\sb" + Str(RTFUtilities.inchesToTWIPS(beforeSpace)) + " ")
		  If afterSpace > 0 Then sa.Append("\sa" + Str(RTFUtilities.inchesToTWIPS(afterSpace)) + " ")
		  If lineSpacing > 0 Then sa.Append("\sl" + Str(lineSpacing * 240) + " \slmult1 ")
		  If leftMargin <> 0 Then sa.Append("\li" + Str(RTFUtilities.inchesToTWIPS(leftMargin)) + " ")
		  If rightMargin <> 0 Then sa.Append("\ri" + Str(RTFUtilities.inchesToTWIPS(rightMargin)) + " ")
		  If firstIndent <> 0 Then sa.Append("\fi" + Str(RTFUtilities.inchesToTWIPS(firstIndent)) + " ")
		  
		  ' Set the paragraph background color.
		  If useParagraphBackgroundColor Then _
		  sa.Append("\cbpat" + parent.getColorNumber(paragraphBackgroundColor) + " ")
		  
		  '---------------------------------------------
		  ' Character settings.
		  '---------------------------------------------
		  
		  ' Set the attributes.
		  
		  If HyperLink = "" Then
		    If Font <> "" Then sa.Append(parent.getFontNumber(Font) + " ")
		    If fontSize > 0 Then sa.Append("\fs" + Str(fontSize * 2) + " ")
		    If bold Then sa.Append("\b ")
		    if characterSpacing <> 0 then
		      sa.Append("\expndtw" + Str((characterSpacing/100) * 240) + " ")
		    else
		      ' Apple Pages shows wrong results, thats why we write this command to RTF.
		      sa.Append("\kerning0 ")
		    end if
		    If italic Then sa.Append("\i ")
		    If underline Then sa.Append("\ul ")
		    If strikeThrough Then sa.Append("\strike ")
		    If useForegroundColor Then sa.Append("\cf" + parent.getColorNumber(foregroundColor) + " ")
		    
		    
		    If shadow Then
		      sa.Append("\shad ")
		      #Pragma Warning "FTC 3.2 - ToDo SHADOW ANGLE"
		      ' \shady SHADOW ANGLE
		      If shadowOffset > 0 Then sa.Append("\shadx" + Str(shadowOffset*20) + " ")
		      If shadowBlur > 0 Then sa.Append("\shadr" + Str(shadowBlur*20) + " ")
		      sa.Append("\shadc" + parent.getColorNumber(shadowColor) + " ")
		      sa.Append("\shado") + Str(255-shadowOpacity) + " " // 0 = transparent, = 50 % -> 100% = 256
		    End If
		    
		  Else
		    sa.Append "{\field{\*\fldinst{HYPERLINK " + Chr(34) + HyperLink + Chr(34) + "}}{\fldrslt \ul \cf" + Parent.GetHyperLinkColorNumber + " " + Text + "}}"
		  End
		  
		  ' Set a background color?
		  If useBackgroundColor Then
		    
		    ' Set the background color. "\chshdng0\chcbpat" is for Microsoft Word.
		    sa.Append("\chshdng0\chcbpat" + parent.getColorNumber(backgroundColor) + _
		    " \cb" + parent.getColorNumber(backgroundColor) + " ")
		    
		  End If
		  
		  ' Was a super or sub script specified?
		  If scriptLevel <> 0 Then
		    
		    ' Is this a super script?
		    If scriptLevel > 0 Then
		      
		      ' Super script.
		      sa.Append("\super ")
		      
		    Else
		      
		      ' Sub script.
		      sa.Append("\sub ")
		      
		    End If
		    
		  End If
		  
		  '---------------------------------------------
		  ' Tab stops.
		  '---------------------------------------------
		  
		  ' Get the number of tab stops.
		  count = Ubound(tabstops)
		  
		  ' Add all the tab stops.
		  For i = 0 To count
		    
		    ' Add the tab stop.
		    Dim currentTab() As String = tabstops(i).Split(";")
		    Dim tabLeader As Double = Val(currentTab(0))
		    Dim tabLength As Double = Val(currentTab(1))
		    Dim rtfTabLength As String = Str(RTFUtilities.inchesToTWIPS(tabLength))
		    
		    Select Case tabLeader
		    Case 1 ' Dot
		      
		      sa.Append("\tldot\tx" + rtfTabLength + " ")
		      
		    Case 2 ' Underscore
		      
		      sa.Append("\tlul\tx" + rtfTabLength + " ")
		      
		    Case 3 ' Hyphen
		      
		      sa.Append("\tlhyph\tx" + rtfTabLength + " ")
		      
		    Case 4 ' Middle Dots
		      
		      sa.Append("\tlmdot\tx" + rtfTabLength + " ")
		      
		    Else
		      
		      sa.Append("\tx" + rtfTabLength + " ")
		      
		    End Select
		    
		  Next
		  
		  '---------------------------------------------
		  ' Content.
		  '---------------------------------------------
		  
		  ' Is there a picture to add?
		  If pictData <> "" Then
		    
		    ' Add the picture.
		    sa.Append(pictData)
		    
		  Else
		    
		    ' Add the text.
		    If Text <> "" And Hyperlink = "" Then sa.Append(Text)
		    
		  End If
		  
		  '---------------------------------------------
		  ' Subcontexts.
		  '---------------------------------------------
		  
		  ' Get the number of sub contexts.
		  count = Ubound(contextList)
		  
		  ' Add all the sub contexts.
		  For i = 0 To count
		    
		    ' Start a new group.
		    sa.Append(EndOfLine + "{")
		    
		    ' Add the sub context.
		    sa.Append(contextList(i).getRTF(parent))
		    
		    ' End the group.
		    sa.Append("}")
		    
		  Next
		  
		  '---------------------------------------------
		  
		  ' Return the group.
		  return join(sa, "")
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function newSubcontext() As RTFContext
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim context as RTFContext
		  
		  ' Create a context.
		  context = new RTFContext
		  
		  ' Save the context.
		  contextList.Append(context)
		  
		  ' Return the context.
		  return context
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(target as RTFContext) As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim result as boolean
		  
		  ' Is the target just a tab?
		  if (text.lenb = 1) and (target.text.lenb = 1) and _
		  ((text = Chr(9)) or (target.text = Chr(9))) then return 0
		  
		  ' Are they the same styles?
		  result = (afterSpace = target.afterSpace) and _
		  (alignment = target.alignment) and _
		  (backgroundColor = target.backgroundColor) and _
		  (beforeSpace = target.beforeSpace) and _
		  (bold = target.bold) and _
		  (characterSpacing = target.characterSpacing) and _
		  (characterStyleName = target.characterStyleName) and _
		  (font = target.font) and _
		  (fontSize = target.fontSize) and _
		  (paragraphBackgroundColor = target.paragraphBackgroundColor) and _
		  (foreGroundColor = target.foreGroundColor) and _
		  (italic = target.italic) and _
		  (pageBreak = target.pageBreak) and _
		  (paragraphStyleName = target.paragraphStyleName) and _
		  (plain = target.plain) and _
		  (strikeThrough = target.strikeThrough) and _
		  (underline = target.underline) and _
		  (useBackgroundColor = target.useBackgroundColor) and _
		  (useForegroundColor = target.useForegroundColor) and _
		  (useParagraphBackgroundColor = target.useParagraphBackgroundColor)
		  
		  ' Are they the same?
		  if result then
		    
		    ' They are equal.
		    return 0
		    
		  else
		    
		    ' They are not equal.
		    return -1
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setSubscript(fontSize as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set it for sub script.
		  scriptLevel = -1
		  
		  ' Save the font size.
		  me.fontSize = fontSize
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setSuperscript(fontSize as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set it for super script.
		  scriptLevel = 1
		  
		  ' Save the font size.
		  me.fontSize = fontSize
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		afterSpace As double
	#tag EndProperty

	#tag Property, Flags = &h0
		alignment As RTFAlignment
	#tag EndProperty

	#tag Property, Flags = &h0
		backgroundColor As Color
	#tag EndProperty

	#tag Property, Flags = &h0
		beforeSpace As double
	#tag EndProperty

	#tag Property, Flags = &h0
		bold As boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		characterSpacing As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		characterStyleName As string
	#tag EndProperty

	#tag Property, Flags = &h21
		Private contextList() As RTFContext
	#tag EndProperty

	#tag Property, Flags = &h0
		firstIndent As double
	#tag EndProperty

	#tag Property, Flags = &h0
		font As string
	#tag EndProperty

	#tag Property, Flags = &h0
		fontSize As integer
	#tag EndProperty

	#tag Property, Flags = &h0
		foregroundColor As Color
	#tag EndProperty

	#tag Property, Flags = &h0
		HyperLink As String
	#tag EndProperty

	#tag Property, Flags = &h0
		italic As boolean
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
		paragraphBackgroundColor As color
	#tag EndProperty

	#tag Property, Flags = &h0
		paragraphStyleName As string
	#tag EndProperty

	#tag Property, Flags = &h0
		pictData As string
	#tag EndProperty

	#tag Property, Flags = &h0
		plain As boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		rightMargin As double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private scriptLevel As integer
	#tag EndProperty

	#tag Property, Flags = &h0
		shadow As boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		shadowBlur As Double
	#tag EndProperty

	#tag Property, Flags = &h0
		shadowColor As Color
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
		tabstops() As String
	#tag EndProperty

	#tag Property, Flags = &h0
		text As string
	#tag EndProperty

	#tag Property, Flags = &h0
		underline As boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		useBackgroundColor As boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		useForegroundColor As boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		useParagraphBackgroundColor As boolean
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="afterSpace"
			Group="Behavior"
			InitialValue="0"
			Type="double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="backgroundColor"
			Group="Behavior"
			InitialValue="&h000000"
			Type="Color"
		#tag EndViewProperty
		#tag ViewProperty
			Name="beforeSpace"
			Group="Behavior"
			InitialValue="0"
			Type="double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="bold"
			Group="Behavior"
			InitialValue="0"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="characterStyleName"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="firstIndent"
			Group="Behavior"
			InitialValue="0"
			Type="double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="font"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="fontSize"
			Group="Behavior"
			InitialValue="0"
			Type="integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="foregroundColor"
			Group="Behavior"
			InitialValue="&h000000"
			Type="Color"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HyperLink"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="italic"
			Group="Behavior"
			InitialValue="0"
			Type="boolean"
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
			Name="paragraphBackgroundColor"
			Group="Behavior"
			InitialValue="&h000000"
			Type="color"
		#tag EndViewProperty
		#tag ViewProperty
			Name="paragraphStyleName"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="pictData"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="plain"
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
			Name="strikeThrough"
			Group="Behavior"
			InitialValue="0"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="text"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="underline"
			Group="Behavior"
			InitialValue="0"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="useBackgroundColor"
			Group="Behavior"
			InitialValue="0"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="useForegroundColor"
			Group="Behavior"
			InitialValue="0"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="useParagraphBackgroundColor"
			Group="Behavior"
			InitialValue="0"
			Type="boolean"
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
			Name="shadow"
			Group="Behavior"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="shadowBlur"
			Group="Behavior"
			Type="Double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="shadowColor"
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
		#tag EndViewProperty
		#tag ViewProperty
			Name="shadowOffset"
			Group="Behavior"
			Type="Double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="shadowOpacity"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="characterSpacing"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
