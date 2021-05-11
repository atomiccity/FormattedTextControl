#tag Class
Protected Class RTFCharacterStyle
	#tag Method, Flags = &h21
		Private Sub constructor()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub constructor(style as RTFStyleAttributes)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the style name.
		  me.styleName = ""
		  
		  ' Copy over the style attributes.
		  if style.useBackgroundColor then setBackgroundColor(style.backgroundColor)
		  setBold(style.bold)
		  setCharacterSpacing(style.characterSpacing)
		  setFontName(style.font.font)
		  setFontSize(style.fontSize)
		  setItalic(style.italic)
		  setScriptLevel(style.scriptLevel)
		  setStrikeThrough(style.strikeThrough)
		  if style.useForegroundColor then setTextColor(style.textColor)
		  setUnderline(style.underline)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub constructor(styleName as string)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the style name.
		  me.styleName = styleName
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub findColors(colorList as Dictionary)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Is there a background color?
		  if backgroundColorDefined then
		    
		    ' Add the background color.
		    colorList.value(RTFUtilities.colorToString(backgroundColor)) = ""
		    
		  end if
		  
		  ' Is there a text color?
		  if textColorDefined then
		    
		    ' Add the text color.
		    colorList.value(RTFUtilities.colorToString(textColor)) = ""
		    
		  End If
		  
		  ' Is there a shadow color?
		  If shadowDefined Then
		    
		    ' Add the shadow color.
		    colorList.value(RTFUtilities.colorToString(shadowColor)) = ""
		    Break
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getAttributes(parent as RTFWriter) As string
		  
		  #If Not DebugBuild
		    
		    #Pragma BoundsChecking RTF_BOUNDSCHECKING
		    #Pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #Pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #EndIf
		  
		  Dim sa() As String
		  
		  ' Add the style attributes.
		  If getFontName <> "" Then sa.Append("\f" + getFontName + " ")
		  If getFontSize > 0 Then sa.Append("\fs" + Str(getFontSize * 2) + " ")
		  If getBold Then sa.Append("\b ")
		  if characterSpacing <> 0 then
		    sa.Append("\expndtw" + Str((characterSpacing/100) * 240) + " ")
		  else
		    ' Apple Pages shows wrong results, thats why we write this command to RTF.
		    sa.Append("\kerning0 ")
		  end if
		  If getItalic Then sa.Append("\i ")
		  If getUnderline Then sa.Append("\ul ")
		  If getStrikeThrough Then sa.Append("\strike ")
		  
		  If isTextColorDefined Then _
		  sa.Append("\cf" + Str(parent.getColorNumber(getTextColor)) + " ")
		  
		  If isBackgroundColorDefined Then _
		  sa.Append("\cb" + Str(parent.getColorNumber(getBackgroundColor)) + " ")
		  
		  If isShadowDefined Then
		    
		    sa.Append("\shad ")
		    sa.Append("\shadx" + Str(shadowOffset*20) + " ")
		    If isShadowDefined Then sa.Append("\shadc" + Str(parent.getColorNumber(getShadowColor)) + " ")
		    
		  End If
		  
		  ' Return the attributes list.
		  Return Join(sa, "")
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getBackgroundColor() As Color
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the background color attribute.
		  return backgroundColor
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getBold() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the bold attribute.
		  return bold
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getCharacterSpacing() As Integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the character spacing attribute.
		  return characterSpacing
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getFontName() As string
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the font name attribute.
		  return fontName
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getFontSize() As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the font size attribute.
		  return fontSize
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getItalic() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the italic attribute.
		  return italic
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getScriptLevel() As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the script level attribute.
		  return scriptLevel
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getShadow() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the shadow attribute.
		  return shadow
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getShadowBlur() As Double
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the shadow blur attribute.
		  return shadowBlur
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getShadowColor() As Color
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  
		  ' Return the shadow color attribute.
		  return shadowColor
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getShadowOffset() As Double
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the shadow offset attribute.
		  return shadowOffset
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getShadowOpacity() As Integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the shadow opacity attribute.
		  return shadowOpacity
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getStrikeThrough() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the strike through attribute.
		  return strikeThrough
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getStyleName() As string
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the name of the style.
		  return styleName
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getStyleNumber() As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the styleNumber.
		  return styleNumber
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getTextColor() As Color
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the color attribute.
		  return textColor
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getUnderline() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the underline attribute.
		  return underline
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isBackgroundColorDefined() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Has the background color been set?
		  return backgroundColorDefined
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isBoldDefined() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Has the bold been set?
		  return boldDefined
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isCharacterSpacingDefined() As Boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Has the character spacing been set?
		  return characterSpacingDefined
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isFontNameDefined() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Has the font name been set?
		  return fontNameDefined
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isFontSizeDefined() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Has the font name been set?
		  return fontSizeDefined
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isItalicDefined() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Has the italic been set?
		  return italicDefined
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isScriptLevelDefined() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Has the script level been set?
		  return scriptLevelDefined
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isShadowDefined() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Has the shadow been set?
		  return shadowDefined
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isStrikeThroughDefined() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Has the strike through been set?
		  return strikeThroughDefined
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isTextColorDefined() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Has the text color been set?
		  return textColorDefined
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isUnderlineDefined() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Has the underline been set?
		  return underlineDefined
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setBackgroundColor(c as Color)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set the color.
		  backgroundColor = c
		  
		  ' The color has been defined.
		  backgroundColorDefined = true
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setBold(state as boolean = true)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the state of the attribute.
		  bold = state
		  
		  ' The attribute has been set.
		  boldDefined = true
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setCharacterSpacing(spacing As Integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set the character spacing.
		  characterSpacing = spacing
		  
		  ' The attribute has been set.
		  characterSpacingDefined = true
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setFontName(fontName as string)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the font name.
		  me.fontName = fontName
		  
		  ' The attribute has been set.
		  fontNameDefined = true
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setFontSize(size as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set the font size.
		  fontSize = size
		  
		  ' The attribute has been set.
		  fontSizeDefined = true
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setItalic(state as boolean = true)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the state of the attribute.
		  italic = state
		  
		  ' The attribute has been set.
		  italicDefined = true
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setScriptLevel(level as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the state of the attribute.
		  scriptLevel = level
		  
		  ' The attribute has been set.
		  scriptLevelDefined = true
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setShadow(state as boolean = true)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the state of the attribute.
		  shadow = state
		  
		  ' The attribute has been set.
		  shadowDefined = true
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setShadowBlur(value As Double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the shadow blur.
		  shadowBlur = value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setShadowColor(c as Color)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the shadow color.
		  shadowColor = c
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setShadowOffset(value As Double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  
		  ' Save the shadow color.
		  shadowOffset = value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setShadowOpacity(value As Integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the shadow opacity.
		  shadowOpacity = value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setStrikeThrough(state as boolean = true)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the state of the attribute.
		  strikeThrough = state
		  
		  ' The attribute has been set.
		  strikeThroughDefined = true
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetStyleName(NewName as String)
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  me.styleName = newName
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setStyleNumber(styleNumber as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the style number.
		  me.styleNumber = styleNumber
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setTextColor(c as Color)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the text color.
		  textColor = c
		  
		  ' The attribute has been set.
		  textColorDefined = true
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setUnderline(state as boolean = true)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the state of the attribute.
		  underline = state
		  
		  ' The attribute has been set.
		  underlineDefined = true
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private backgroundColor As Color
	#tag EndProperty

	#tag Property, Flags = &h21
		Private backgroundColorDefined As boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private bold As boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private boldDefined As boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private characterSpacing As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private characterSpacingDefined As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private fontName As string
	#tag EndProperty

	#tag Property, Flags = &h21
		Private fontNameDefined As boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private fontSize As integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private fontSizeDefined As boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private italic As boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private italicDefined As boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private scriptLevel As integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private scriptLevelDefined As boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private shadow As boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private shadowBlur As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private shadowColor As Color
	#tag EndProperty

	#tag Property, Flags = &h21
		Private shadowDefined As boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private shadowOffset As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private shadowOpacity As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private strikeThrough As boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private strikeThroughDefined As boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private styleName As string
	#tag EndProperty

	#tag Property, Flags = &h21
		Private styleNumber As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private textColor As color
	#tag EndProperty

	#tag Property, Flags = &h21
		Private textColorDefined As boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private underline As boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private underlineDefined As boolean
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
