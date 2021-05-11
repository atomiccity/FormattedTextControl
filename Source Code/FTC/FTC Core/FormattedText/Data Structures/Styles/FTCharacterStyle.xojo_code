#tag Class
Protected Class FTCharacterStyle
Inherits FTBase
	#tag Method, Flags = &h0
		Function clone() As FTCharacterStyle
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim style as FTCharacterStyle
		  
		  ' Create the clone.
		  style = new FTCharacterStyle(parentControl, styleName)
		  
		  ' Fill in the properties.
		  style.backgroundColor = backgroundColor
		  style.backgroundColorDefined = backgroundColorDefined
		  style.bold = bold
		  style.boldDefined = boldDefined
		  style.characterSpacing = characterSpacing
		  style.characterSpacingDefined = characterSpacingDefined
		  style.fontName = fontName
		  style.fontNameDefined = fontNameDefined
		  style.fontSize = fontSize
		  style.fontSizeDefined = fontSizeDefined
		  style.italic = italic
		  style.italicDefined = italicDefined
		  style.markColor = markColor
		  style.markColorDefined = markColorDefined
		  style.scriptLevel = scriptLevel
		  style.scriptLevelDefined = scriptLevelDefined
		  style.textColor = textColor
		  style.textColorDefined = textColorDefined
		  style.underline = underline
		  style.underlineDefined = underlineDefined
		  
		  style.shadow = shadow
		  style.shadowBlur = shadowBlur
		  style.shadowColor = shadowColor
		  style.shadowOffset = shadowOffset
		  
		  ' Return the clone.
		  return style
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(parentControl as FormattedText, style as FTStyleRun)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Initialize the base.
		  super.Constructor(parentControl)
		  
		  ' Load the attributes.
		  backgroundColor = style.getBackgroundColor
		  backgroundColorDefined = style.useBackgroundColor
		  
		  bold = style.bold
		  boldDefined = true
		  
		  characterSpacing = style.characterSpacing
		  characterSpacingDefined = true
		  
		  fontName = style.font
		  fontNameDefined = true
		  
		  fontSize = style.fontSize
		  fontSizeDefined = true
		  
		  italic = style.italic
		  italicDefined = true
		  
		  markColor = style.markColor
		  markOn = style.marked
		  markColorDefined = style.marked
		  
		  strikeThrough = style.strikeThrough
		  strikeThroughDefined = true
		  
		  scriptLevel = style.scriptLevel
		  scriptLevelDefined = true
		  
		  textColor = style.textColor
		  textColorDefined = true
		  
		  underline = style.underline
		  underlineDefined = true
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(parentControl as FormattedText, style as RTFCharacterStyle)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Initialize the base.
		  super.Constructor(parentControl)
		  
		  ' Load the attributes.
		  id = style.getStyleNumber
		  
		  backgroundColor = style.getBackgroundColor
		  backgroundColorDefined = style.isBackgroundColorDefined
		  
		  bold = style.getBold
		  boldDefined = style.isBoldDefined
		  
		  fontName = style.getFontName
		  fontNameDefined = style.isFontNameDefined
		  
		  fontSize = style.getFontSize
		  fontSizeDefined = style.isFontSizeDefined
		  
		  italic = style.getItalic
		  italicDefined = style.isItalicDefined
		  
		  markColorDefined = false
		  
		  strikeThrough = style.getStrikeThrough
		  strikeThroughDefined = true
		  
		  styleName = style.getStyleName
		  
		  scriptLevel = style.getScriptLevel
		  scriptLevelDefined = style.isScriptLevelDefined
		  
		  textColor = style.getTextColor
		  textColorDefined = style.isTextColorDefined
		  
		  underline = style.getUnderline
		  underlineDefined = style.isUnderlineDefined
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(parentControl as FormattedText, styleName as string)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Initialize the base.
		  super.Constructor(parentControl)
		  
		  ' Save the style name.
		  me.styleName = styleName
		  
		  ' Create an ID.
		  me.id = FTUtilities.getNewID
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1000
		Sub Constructor(parentControl as FormattedText, attributeList as XmlAttributeList)
		  //Issue 3797: Fixes for XML encoding and decoding of files
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Initialize the base. 
		  Super.Constructor(parentControl)
		  
		  ' Load the attributes.
		  styleName = attributeList.value(FTCxml.XML_STYLE_NAME) 
		  
		  id = Val(attributeList.value(FTCxml.XML_STYLE_ID))
		  
		  Dim s As String
		  
		  s = attributeList.value(FTCxml.XML_BACKGROUND_COLOR) 
		  
		  If s <> "" Then setBackgroundColor FTUtilities.stringToColor(s)
		  
		  s = attributeList.value(FTCxml.XML_BOLD) 
		  
		  If s <> "" Then setBold FTUtilities.stringToBoolean(s)
		  
		  s = attributeList.value(FTCxml.XML_FONT) 
		  
		  If s <> "" Then setFontName s
		  
		  s = attributeList.value(FTCxml.XML_SIZE) 
		  
		  If s <> "" Then setFontSize(s.Val)
		  
		  s = attributeList.value(FTCxml.XML_ITALIC) 
		  
		  if s <> "" Then setItalic FTUtilities.stringToBoolean(s)
		  
		  s = attributeList.value(FTCxml.XML_MARK_COLOR)
		  
		  If s <> "" Then setMarkColor FTUtilities.stringToColor(s) ' will also set markOn
		  
		  s = attributeList.value(FTCxml.XML_STRIKE_THROUGH) 
		  
		  if s <> "" Then setStrikeThrough FTUtilities.stringToBoolean(s)
		  
		  s = attributeList.value(FTCxml.XML_SCRIPT_LEVEL) 
		  
		  If s <> "" Then setScriptLevel(s.Val)
		  
		  s = attributeList.value(FTCxml.XML_TEXT_COLOR) 
		  
		  If s <> "" Then setTextColor FTUtilities.stringToColor(s)
		  
		  s = attributeList.value(FTCxml.XML_UNDERLINE) 
		  
		  if s <> "" Then setUnderline FTUtilities.stringToBoolean(s)
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
		  Super.Constructor(parentControl)
		  
		  ' Load the attributes.
		  id = Val(style.GetAttribute(FTCxml.XML_STYLE_ID)) 
		  
		  styleName = style.GetAttribute(FTCxml.XML_STYLE_NAME)
		  
		  Dim s As String
		  
		  s = style.GetAttribute(FTCxml.XML_BACKGROUND_COLOR) 
		  
		  If s <> "" Then setBackgroundColor FTUtilities.stringToColor(s)
		  
		  s = style.GetAttribute(FTCxml.XML_BOLD) 
		  
		  If s<> ""Then setBold FTUtilities.stringToBoolean(s)
		  
		  s = style.GetAttribute(FTCxml.XML_FONT) 
		  
		  If s <> "" Then setFontName s
		  
		  s = style.GetAttribute(FTCxml.XML_SIZE) 
		  
		  If s <> "" Then setFontSize(s.Val)
		  
		  s = style.GetAttribute(FTCxml.XML_ITALIC) 
		  
		  If s <> "" Then setItalic FTUtilities.stringToBoolean(s)
		  
		  s = style.GetAttribute(FTCxml.XML_MARK_COLOR)
		  
		  If s <> "" Then setMarkColor FTUtilities.stringToColor(s) ' will also set markOn
		  
		  s = style.GetAttribute(FTCxml.XML_STRIKE_THROUGH) 
		  
		  If s <> "" Then setStrikeThrough FTUtilities.stringToBoolean(s)
		  
		  s = style.GetAttribute(FTCxml.XML_SCRIPT_LEVEL) 
		  
		  If s <> "" Then setScriptLevel(s.Val)
		  
		  s = style.GetAttribute(FTCxml.XML_TEXT_COLOR) 
		  
		  If s <> "" Then setTextColor FTUtilities.stringToColor(s)
		  
		  s = style.GetAttribute(FTCxml.XML_UNDERLINE)
		  
		  If s <> "" Then setUnderline FTUtilities.stringToBoolean(s)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getBackgroundColor() As Color
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the background color attribute.
		  return backgroundColor
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getBold() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the bold attribute.
		  return bold
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getCharacterSpacing() As Integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the character spacing attribute.
		  return characterSpacing
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getFontName() As string
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the font name attribute.
		  return fontName
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getFontSize() As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the font size attribute.
		  return fontSize
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getId() As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the ID.
		  return id
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getItalic() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the italic attribute.
		  return italic
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getMarkColor() As Color
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the mark attribute.
		  return markColor
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub getRTF(rtf as RTFWriter, parentStyle as RTFParagraphStyle = nil)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim style as RTFCharacterStyle
		  
		  ' Was a paragraph style supplied?
		  if parentStyle is nil then
		    
		    ' Create a new style.
		    style = new RTFCharacterStyle(styleName)
		    
		  else
		    
		    ' Use the supplied style.
		    style = RTFCharacterStyle(parentStyle)
		    
		  end if
		  
		  ' Load the attributes.
		  style.setBold(bold)
		  style.setCharacterSpacing(characterSpacing)
		  style.setFontName(fontName)
		  style.setFontSize(fontSize)
		  style.setItalic(italic)
		  style.setStrikeThrough(strikeThrough)
		  style.setUnderline(underline)
		  
		  ' Was a background color specified?
		  if backgroundColorDefined then
		    
		    ' Set the background color.
		    style.setBackgroundColor(backgroundColor)
		    
		  end if
		  
		  ' Was a text color specified?
		  if textColorDefined then
		    
		    ' Set the text color.
		    style.setTextColor(textColor)
		    
		  end if
		  
		  ' Is this a character style?
		  if parentStyle is nil then
		    
		    ' Save the style.
		    rtf.addCharacterStyle(style)
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getScriptLevel() As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the script level attribute.
		  return scriptLevel
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getStrikeThrough() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the strike through attribute.
		  return strikeThrough
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getStyleName() As string
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the name of the style.
		  return styleName
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getTextColor() As Color
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the color attribute.
		  return textColor
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getUnderline() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the underline attribute.
		  return underline
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub getXML(style as XmlElement)
		  //Issue 3797: Fixes for XML encoding and decoding of files
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Load the attributes.
		  style.SetAttribute(FTCxml.XML_STYLE_NAME, styleName)
		  
		  style.SetAttribute(FTCxml.XML_STYLE_ID, Str(id))
		  
		  If isBackgroundColorDefined Then style.SetAttribute(FTCxml.XML_BACKGROUND_COLOR, FTUtilities.colorToString(backgroundColor)) 
		  
		  If isBoldDefined Then style.SetAttribute(FTCxml.XML_BOLD, FTUtilities.booleanToString(bold))
		  
		  If isCharacterSpacingDefined Then style.SetAttribute(FTCxml.XML_CHARACTER_SPACING, Str(characterSpacing))
		  
		  If isFontNameDefined Then style.SetAttribute(FTCxml.XML_FONT, fontName)
		  
		  If isFontSizeDefined Then style.SetAttribute(FTCxml.XML_SIZE, Str(fontSize))
		  
		  If isItalicDefined Then style.SetAttribute(FTCxml.XML_ITALIC, FTUtilities.booleanToString(italic))
		  
		  If markColorDefined Then style.SetAttribute(FTCxml.XML_MARK_COLOR, FTUtilities.colorToString(markColor))
		  
		  If isScriptLevelDefined Then style.SetAttribute(FTCxml.XML_SCRIPT_LEVEL, Str(scriptLevel))
		  
		  If isStrikeThroughDefined Then style.SetAttribute(FTCxml.XML_STRIKE_THROUGH, FTUtilities.booleanToString(strikeThrough))
		  
		  If isTextColorDefined Then style.SetAttribute(FTCxml.XML_TEXT_COLOR, FTUtilities.colorToString(TextColor))
		  
		  If isUnderlineDefined Then style.SetAttribute(FTCxml.XML_UNDERLINE, FTUtilities.booleanToString(underline))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isBackgroundColorDefined() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Has the background color been set?
		  return backgroundColorDefined
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isBoldDefined() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Has the attribute been set?
		  return boldDefined
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isCharacterSpacingDefined() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Has the character spacing been set?
		  return characterSpacingDefined
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isFontNameDefined() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Has the attribute been set?
		  return fontNameDefined
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isFontSizeDefined() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Has the font size been set?
		  return fontSizeDefined
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isItalicDefined() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Has the attribute been set?
		  return italicDefined
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isMarkDefined(ByRef markState as boolean) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set the mark state.
		  markState = markOn
		  
		  ' Has the mark been defined?
		  return markColorDefined
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isScriptLevelDefined() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Has the attribute been set?
		  return scriptLevelDefined
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isShadowDefined() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Has the attribute been set?
		  return shadow
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isStrikeThroughDefined() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Has the attribute been set?
		  return strikeThroughDefined
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isTextColorDefined() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Has the text color been set?
		  return textColorDefined
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isUnderlineDefined() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Has the attribute been set?
		  return underlineDefined
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub makeFontBigger()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set the font size.
		  fontSize = min(1000,fontSize + 1)
		  
		  ' The attribute has been defined.
		  'fontSizeDefined = true
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub makeFontSmaller()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set the font size.
		  fontSize = Max(1,fontSize - 1)
		  
		  ' The attribute has been defined.
		  'fontSizeDefined = true
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setBackgroundColor()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set the color.
		  backgroundColor = &cFFFFFF
		  
		  ' The color has been defined.
		  backgroundColorDefined = false
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setBackgroundColor(c as Color)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
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
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the state of the attribute.
		  bold = state
		  
		  ' The attribute has been defined.
		  boldDefined = true
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setCharacterSpacing(spacing As Integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set the character spacing.
		  characterSpacing = spacing
		  
		  ' The attribute has been defined.
		  characterSpacingDefined = true
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setFontName(fontName as string)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the font name.
		  me.fontName = fontName
		  
		  ' The attribute has been defined.
		  fontNameDefined = true
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setFontSize(size as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set the font size.
		  fontSize = size
		  
		  ' The attribute has been defined.
		  fontSizeDefined = true
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setId(id as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set the ID.
		  me.id = id
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setItalic(state as boolean = true)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the state of the attribute.
		  italic = state
		  
		  ' The attribute has been defined.
		  italicDefined = true
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setMarkColor()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Reset the color.
		  markColor = &cFFFFFF
		  
		  ' Set the mark on flag.
		  markOn = false
		  
		  ' The mark has been defined.
		  markColorDefined = true
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setMarkColor(c as Color)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the color.
		  markColor = c
		  
		  ' The mark is visible.
		  markOn = true
		  
		  ' The mark has been defined.
		  markColorDefined = true
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setPlain()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Reset the attributes.
		  backgroundColor = &cFFFFFF
		  backgroundColorDefined = true
		  
		  bold = false
		  boldDefined = true
		  
		  characterSpacing = 0
		  characterSpacingDefined = true
		  
		  italic = false
		  italicDefined = true
		  
		  strikeThrough = false
		  strikeThroughDefined = true
		  
		  scriptLevel = 0
		  scriptLevelDefined = true
		  
		  textColor = &c000000
		  textColorDefined = true
		  
		  underline = false
		  underlineDefined = true
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setScriptLevel(level as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the state of the attribute.
		  scriptLevel = level
		  
		  ' The attribute has been defined.
		  scriptLevelDefined = true
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setStrikeThrough(state as boolean = true)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the state of the attribute.
		  strikeThrough = state
		  
		  ' The attribute has been defined.
		  strikeThroughDefined = true
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setTextColor(c as Color)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the text color.
		  textColor = c
		  
		  ' The color has been defined.
		  textColorDefined = true
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setUnderline(state as boolean = true)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the state of the attribute.
		  underline = state
		  
		  ' The attribute has been defined.
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
		Private id As integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private italic As boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private italicDefined As boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private markColor As Color
	#tag EndProperty

	#tag Property, Flags = &h21
		Private markColorDefined As boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private markOn As boolean
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
		Private shadowOffset As Double
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
