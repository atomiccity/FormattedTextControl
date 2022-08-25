#tag Class
Protected Class FTStyleRun
Inherits FTObject
	#tag Event
		Function Ascent(scale as double) As double
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Check the scale.
		  checkScale(scale)
		  
		  ' Has it been computed?
		  if textAscent > -1 then
		    
		    ' Return the computed value.
		    return textAscent
		    
		  end if
		  
		  ' Compute the value.
		  textAscent = self.getStringAscent(scale)
		  
		  ' Return the height of the string.
		  return textAscent
		  
		End Function
	#tag EndEvent

	#tag Event
		Function Height(scale as double) As double
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Check the scale.
		  checkScale(scale)
		  
		  ' Has it been computed?
		  if textHeight > -1 then
		    
		    ' Return the computed value.
		    return textHeight
		    
		  end if
		  
		  ' Compute the value.
		  textHeight = self.getStringHeight(scale)
		  
		  ' Return the height of the string.
		  return textHeight
		  
		End Function
	#tag EndEvent

	#tag Event
		Sub PaintBackground(g as graphics, x as integer, y as integer, leftPoint as integer, rightPoint as integer, lineTop as double, lineHeight as double, printing as boolean, printScale as double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  #pragma Unused y
		  #pragma Unused leftPoint
		  
		  ' Draw the background.
		  drawObjectBackground(g, x, rightPoint, lineTop, lineHeight, printing, printScale)
		  
		  ' Draw the selected background.
		  drawSelectedBackground(g, x, rightPoint, lineTop, lineHeight, printing)
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub PaintForeground(g as graphics, x as integer, y as integer, leftPoint as integer, rightPoint as integer, beforeSpace as double, afterSpace as double, printing as boolean, printScale as double)
		  
		  #If Not DebugBuild
		    
		    #Pragma BoundsChecking FTC_BOUNDSCHECKING
		    #Pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #Pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #EndIf
		  
		  #Pragma Unused leftPoint
		  #Pragma Unused rightPoint
		  #Pragma Unused beforeSpace
		  #Pragma Unused afterSpace
		  
		  Dim drawWidth As Double
		  Dim scale As Double
		  
		  ' Are we printing?
		  If printing Then
		    
		    ' Use the print scale.
		    scale = printScale
		    
		  Else
		    
		    ' Use the display scale.
		    scale = parentControl.getDisplayScale
		    
		  End If
		  
		  '--------------------------------------------
		  ' Perform some set up.
		  '--------------------------------------------
		  
		  ' Is this a super or sub script?
		  If scriptLevel <> 0 Then
		    
		    ' Is this a superscript?
		    If scriptLevel > 0 Then
		      
		      ' Move the text to the top of the line.
		      y = y - (getOriginalAscent(scale) * SUPERSCRIPT_OFFSET)
		      
		    Else
		      
		      ' Move the text to the bottom of the line.
		      y = y + (getOriginalDescent(scale) * SUBSCRIPT_OFFSET)
		      
		    End If
		    
		  End If
		  
		  '--------------------------------------------
		  ' Draw the text.
		  '--------------------------------------------
		  //now support shadow, opacity and hyperlinks
		  
		  ' Are we drawing a underline, mark, strike through or hyperlink?
		  If underline Or marked Or strikeThrough Or HyperLink.LenB > 0 Or hasShadow Then
		    
		    ' Get the width to be drawn.
		    drawWidth = getWidth(scale)
		    
		  End If
		  
		  ' Draw the mark.
		  drawMark(g, drawWidth, x, y, printing, scale)
		  
		  
		  ' Draw the mispelled indicator.
		  drawMispelledIndicator(g, x, y, printing, scale)
		  
		  g.AntiAlias = True
		  ' Set the graphics characteristics.
		  g.FontName = Font
		  g.Bold = bold
		  g.Italic = italic
		  #If XojoVersion > 2015.03 Then
		    ' Set the character spacing.
		    g.CharacterSpacing = characterSpacing
		  #Endif
		  
		  
		  //opacity
		  If colorOpacity >0 Then
		    
		    If HyperLink.LenB>0 Then
		      g.ForeColor= RGB(hyperLinkColor.Red,hyperLinkColor.Green,hyperLinkColor.Blue,Round(colorOpacity/100 * 255))
		      
		    Else
		      g.ForeColor= RGB(TextColor.Red,TextColor.Green,TextColor.Blue,Round(colorOpacity/100 * 255))
		      
		    End
		    
		  Else
		    
		    If HyperLink.LenB>0 Then
		      g.ForeColor = getHyperLinkColor(0)
		      
		    Else
		      g.ForeColor = TextColor
		      
		    End If
		  End
		  
		  
		  g.TextSize = Round(fontSize * scale)
		  
		  'draw a shadow
		  // Issue 3700: Drop Shadow available on Windows and Linux
		  // If we are not selected don't try to draw the shadow.
		  If hasShadow And drawWidth > 0 And Not isSelected Then
		    
		    Dim mAngle, offsetX, offsety As Double
		    
		    mAngle = - (shadowAngle * Rads2DegMultiplier)
		    offsetX = shadowOffset * Cos(mAngle) //be careful of type conversions
		    offsetY = shadowOffset * Sin(mAngle)
		    
		    ' Buffer Picture
		    Dim p As New Picture(drawWidth + offsetX + 2 * shadowBlur, Me.getHeight(scale) + offsety + 2 * shadowBlur)
		    
		    ' fill with Shadow Color
		    p.graphics.ForeColor = shadowColor
		    p.graphics.FillRect(0, 0, p.Width, p.Height)
		    
		    ' Mask Picture
		    Dim shadowMask As New Picture(p.Width, p.Height)
		    
		    ' fill with white
		    shadowMask.Graphics.ForeColor = &cFFFFFF00
		    shadowMask.Graphics.FillRect(0, 0, shadowMask.Width, shadowMask.Height)
		    
		    ' draw Text for shadow
		    shadowMask.Graphics.FontName = Font
		    shadowMask.Graphics.Bold = bold
		    shadowMask.Graphics.Italic = italic
		    #If XojoVersion > 2015.03 Then
		      shadowMask.Graphics.CharacterSpacing = characterSpacing
		    #endif
		    
		    shadowMask.Graphics.ForeColor = RGB(shadowColor.Red, shadowColor.Green, shadowColor.Blue, shadowOpacity)
		    shadowMask.Graphics.FontSize = Round(fontSize * scale)
		    shadowMask.Graphics.DrawString(Text, 0 + offsetX, g.TextAscent - offsety)
		    
		    ' blur Mask Picture
		    If shadowBlur > 0 Then _
		    shadowMask = ImagePlayEffectsLibrary.Blur(shadowMask, shadowBlur/1.7, ImagePlayEffectsLibrary.kBlurModeAcurate)
		    
		    ' apply Mask to Buffer
		    p.ApplyMask(shadowMask)
		    
		    ' draw Buffer Picture
		    ' g.DrawPicture(p, x+offsetX, y - g.TextAscent - offsetY) //draws it in line with the actual text
		    
		    // Issue 3700: Drop Shadow available on Windows and Linux
		    g.DrawPicture(shadowMask, x+offsetX, y - g.TextAscent - offsetY)
		    
		  End
		  
		  ' Draw the string.
		  g.DrawString(Text, x, y)
		  
		  
		  ' Draw the underline.
		  drawUnderline(g.TextSize, g, drawWidth, x, y, printing, scale)
		  
		  ' Draw the strike through.
		  drawStrikethrough(g.TextSize, g, drawWidth, x, y, printing, scale)
		  
		  ' Draw the hyperlink ->changed by Paul
		  drawHyperLink(g.TextSize, g, drawWidth, x, y, printing, scale)
		  
		End Sub
	#tag EndEvent

	#tag Event
		Function PartialWidth(startIndex as integer, endIndex as integer, scale as double, startPosition as double) As double
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  #pragma Unused startPosition
		  
		  ' Look up the partial width.
		  return lookupWidth(startIndex, endIndex, scale)
		  
		End Function
	#tag EndEvent

	#tag Event
		Sub ScaleChanged()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Clear the caches.
		  reset
		  
		End Sub
	#tag EndEvent

	#tag Event
		Function Width(scale as double, startPosition as double) As double
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  #pragma Unused startPosition
		  
		  ' Look up the width.
		  return lookupWidth(1, length, scale)
		  
		End Function
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub appendText(s as string)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Add the text.
		  setText(text + s, length + s.len)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeCharacterSpacing(spacing As Integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set the character spacing.
		  characterSpacing = spacing
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeCharacterStyle(styleId as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim cs as FTCharacterStyle
		  
		  ' Is character style being undone?
		  if styleId = 0 then
		    
		    ' Use the default character style.
		    cs = defaultCharacterStyle
		    
		    //Issue 3796: FTStyleRun.copyStyleData does not copy background color
		    changeBackgroundColor ' sets background transparent
		    
		    ' Release the default character style.
		    defaultCharacterStyle = nil
		    
		  else
		    
		    ' Save the current settings.
		    saveDefaultCharacterStyle
		    
		    ' Get the character style.
		    cs = parentControl.getDoc.getCharacterStyle(styleId)
		    
		  end if
		  
		  ' Set the character style.
		  me.characterStyle = styleId
		  
		  ' Update the specific attributes.
		  updateWithStyle(cs)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeFont(fontName as string)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set the font name.
		  font = fontName
		  
		  ' Clear the caches.
		  reset
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeMisspelledWord(state as boolean)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Mark this word as misspelled.
		  misspelled = state
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeSize(size as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set the font size.
		  fontSize = size
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeStyle(style as integer, value as boolean)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Do the common styles.
		  super.changeStyle(style, value)
		  
		  ' Flip the attribute.
		  select case style
		    
		  case FTStyle.STYLE_BOLD
		    
		    bold = value
		    
		  case FTStyle.STYLE_ITALIC
		    
		    italic = value
		    
		  case FTStyle.SUPER_SCRIPT
		    
		    ' Are we non-super or sub scripted?
		    if scriptLevel = 0 then
		      
		      ' Save the original size.
		      originalFontSize = mfontSize
		      
		    end if
		    
		    ' Are we already in super script?
		    if value then
		      
		      ' Make it super script.
		      scriptLevel = 1
		      
		      ' Cut the font size in half.
		      mfontSize = originalFontSize * SCRIPT_SIZE
		      
		    else
		      
		      ' Remove the super script format.
		      scriptLevel = 0
		      
		      ' Reset the font size.
		      mfontSize = originalFontSize
		      
		    end if
		    
		  case FTStyle.SUB_SCRIPT
		    
		    ' Are we non-super or sub scripted?
		    if scriptLevel = 0 then
		      
		      ' Save the original size.
		      originalFontSize = mfontSize
		      
		    end if
		    
		    ' Are we already in sub script?
		    if value then
		      
		      ' Make it sub script.
		      scriptLevel = -1
		      
		      ' Cut the font size in half.
		      mfontSize = originalFontSize * SCRIPT_SIZE
		      
		    else
		      
		      ' Remove the sub script format.
		      scriptLevel = 0
		      
		      ' Reset the font size.
		      mfontSize = originalFontSize
		      
		    end if
		    
		  case FTStyle.STYLE_PLAIN
		    
		    ' Turn off all styling.
		    bold = false
		    characterSpacing = 0
		    italic = false
		    scriptLevel = 0
		    
		  end select
		  
		  ' Clear the caches.
		  reset
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeToLowerCase()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Change to lower case.
		  setText(Lowercase(text), length)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeToTitleCase(preText as string = "")
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Change to title case.
		  setText(Right(Titlecase(preText + text), length), length)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeToUpperCase()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Change to upper case.
		  setText(Uppercase(text), length)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub checkScale(scale as double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Did the scale change?
		  if scale <> textCacheScale then
		    
		    ' Clear the caches.
		    reset
		    
		    ' Save the new scale value.
		    textCacheScale = scale
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function clone() As FTObject
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim ftsr as FTStyleRun
		  
		  ' Create the clone.
		  ftsr = new FTStyleRun(parentControl, false)
		  
		  ' Copy the sub data.
		  copy(ftsr)
		  
		  ' Copy over the items.
		  ftsr.bold = bold
		  ftsr.characterSpacing = characterSpacing
		  ftsr.font = font
		  ftsr.fontSize = fontSize
		  ftsr.italic = italic
		  ftsr.originalFontSize = originalFontSize
		  ftsr.scriptLevel = scriptLevel
		  ftsr.misspelled = misspelled
		  ftsr.characterStyle = characterStyle
		  ftsr.setText(text, getLength)
		  
		  
		  ftsr.HyperLink = HyperLink
		  ftsr.hyperLinkColor = hyperLinkColor
		  ftsr.hyperLinkColorDisabled = hyperLinkColorDisabled
		  ftsr.hyperLinkColorRollover = hyperLinkColorRollover
		  ftsr.hyperLinkColorVisited = hyperLinkColorVisited
		  ftsr.useCustomHyperLinkColor = useCustomHyperLinkColor
		  ftsr.inNewWindow = inNewWindow
		  
		  ftsr.noHyperlinkUlNormal = noHyperlinkUlNormal
		  ftsr.noHyperlinkUlRollover = noHyperlinkUlRollover
		  ftsr.noHyperlinkUlVisited =noHyperlinkUlVisited
		  ftsr.noHyperlinkUlVisited = noHyperlinkUlVisited
		  
		  
		  ' Copy over the cache values.
		  ftsr.textCacheScale = textCacheScale
		  ftsr.textHeight = textHeight
		  ftsr.textAscent = textAscent
		  
		  ' Was the default character style define?
		  if not (defaultCharacterStyle is nil) then
		    
		    ' Copy over the default style.
		    ftsr.defaultCharacterStyle = defaultCharacterStyle.clone
		    
		  end if
		  
		  ' Return the clone.
		  return ftsr
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(parentControl as FormattedText, generateNewID as boolean = true)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Initialize the internals.
		  initialize
		  
		  ' Save the parent control.
		  super.Constructor(parentControl, generateNewId)
		  
		  ' Reset the flags.
		  reset
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(parentControl as FormattedText, s as string, generateNewID as boolean = true, stringLength as integer = - 1)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Initialize the internals.
		  initialize
		  
		  ' Save  the parent control.
		  super.Constructor(parentControl, generateNewID)
		  
		  ' Was the length of the string given?
		  if stringLength > -1 then
		    
		    ' Add the text.
		    setText(s, stringLength)
		    
		  else
		    
		    ' Add the text.
		    setText(s)
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1000
		Sub Constructor(parentControl as FormattedText, attributeList as XmlAttributeList, generateNewID as boolean = true)
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Initialize the internals.
		  initialize
		  
		  ' Save  the parent control.
		  super.Constructor(parentControl, attributeList, generateNewID)
		  
		  ' Load up the attributes.
		  bold = FTUtilities.stringToBoolean(attributeList.value(FTCxml.XML_BOLD))
		  characterSpacing = Val(attributeList.value(FTCxml.XML_CHARACTER_SPACING))
		  font = attributeList.value(FTCxml.XML_FONT)
		  italic = FTUtilities.stringToBoolean(attributeList.value(FTCxml.XML_ITALIC))
		  fontSize = Val(attributeList.value(FTCxml.XML_SIZE))
		  originalFontSize = Val(attributeList.value(FTCxml.XML_ORIGINAL_SIZE))
		  characterStyle = Val(attributeList.value(FTCxml.XML_CHARACTER_STYLE))
		  
		  
		  HyperLink = attributeList.value(FTCxml.XML_HYPERLINK)
		  hyperLinkColor =  FTUtilities.stringToColor(attributeList.value(FTCxml.XML_HYPERLINKCOLOR),parentControl.defaultHyperLinkColor)
		  hyperLinkColorRollover =  FTUtilities.stringToColor(attributeList.value(FTCxml.XML_HYPERLINKCOLORROLLOVER),parentControl.defaultHyperLinkColorRollover)
		  hyperLinkColorVisited =  FTUtilities.stringToColor(attributeList.value(FTCxml.XML_HYPERLINKCOLORVISITED),parentControl.defaultHyperLinkColorVisited)
		  hyperLinkColorDisabled =  FTUtilities.stringToColor(attributeList.value(FTCxml.XML_HYPERLINKCOLORDISABLED),parentControl.defaultHyperLinkColorDisabled)
		  useCustomHyperLinkColor = FTUtilities.stringToBoolean(attributeList.value(FTCxml.XML_HYPERLINKUSECUSTOMCOLOR))
		  
		  //link underlines
		  noHyperlinkUlNormal= FTUtilities.stringToBoolean(attributeList.value(FTCxml.XML_HYPERLINKULNORMAL))
		  noHyperlinkUlRollover= FTUtilities.stringToBoolean(attributeList.value(FTCxml.XML_HYPERLINKULROLLOVER))
		  noHyperlinkUlVisited= FTUtilities.stringToBoolean(attributeList.value(FTCxml.XML_HYPERLINKULVISITED))
		  noHyperlinkUlDisabled  = FTUtilities.stringToBoolean(attributeList.value(FTCxml.XML_HYPERLINKULDISABLED))
		  
		  colorOpacity = val(attributeList.value(FTCxml.XML_TEXT_OPACITY))
		  hasShadow = FTUtilities.stringToBoolean(attributeList.value(FTCxml.XML_SHADOW))
		  shadowBlur = Val(attributeList.value(FTCxml.XML_SHADOW_BLUR))
		  shadowOffset = Val(attributeList.value(FTCxml.XML_SHADOW_OFFSET))
		  shadowOpacity =  Val(attributeList.value(FTCxml.XML_SHADOW_OPACITY))
		  shadowAngle =  Val(attributeList.value(FTCxml.XML_SHADOW_ANGLE))
		  shadowColor = FTUtilities.stringToColor(attributeList.value(FTCxml.XML_SHADOW_COLOR), &c000000)
		  // End Add
		  
		  ' Is this a super script?
		  if FTUtilities.stringToBoolean(attributeList.value(FTCxml.XML_SUPERSCRIPT)) then
		    
		    ' Set it for super script.
		    scriptLevel = 1
		    
		    ' Is this a sub script?
		  elseif FTUtilities.stringToBoolean(attributeList.value(FTCxml.XML_SUBSCRIPT)) then
		    
		    ' Set it for sub script.
		    scriptLevel = -1
		    
		  end if
		  
		  ' Was the text base64 encoded?
		  if FTUtilities.stringToBoolean(attributeList.value(FTCxml.XML_TEXT_ENCODED)) then
		    
		    ' Decode the text and add it.
		    setText(DecodeBase64(attributeList.value(FTCxml.XML_TEXT), Encodings.UTF8))
		    
		  else
		    
		    ' Add the text.
		    setText(attributeList.value(FTCxml.XML_TEXT))
		    
		  end if
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(parentControl as FormattedText, obj as XmlElement, generateNewID as boolean = true)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Initialize the internals.
		  initialize
		  
		  ' Save  the parent control.
		  super.Constructor(parentControl, obj, generateNewID)
		  
		  ' Load up the attributes.
		  bold = FTUtilities.stringToBoolean(obj.GetAttribute(FTCxml.XML_BOLD))
		  characterSpacing = Val(obj.GetAttribute(FTCxml.XML_CHARACTER_SPACING))
		  font = obj.GetAttribute(FTCxml.XML_FONT)
		  italic = FTUtilities.stringToBoolean(obj.GetAttribute(FTCxml.XML_ITALIC))
		  fontSize = Val(obj.GetAttribute(FTCxml.XML_SIZE))
		  originalFontSize = Val(obj.GetAttribute(FTCxml.XML_ORIGINAL_SIZE))
		  characterStyle = Val(obj.GetAttribute(FTCxml.XML_CHARACTER_STYLE))
		  
		  
		  HyperLink = obj.GetAttribute(FTCxml.XML_HYPERLINK)
		  hyperLinkColor =  FTUtilities.stringToColor(obj.GetAttribute(FTCxml.XML_HYPERLINKCOLOR),parentControl.defaultHyperLinkColor)
		  hyperLinkColorRollover =  FTUtilities.stringToColor(obj.GetAttribute(FTCxml.XML_HYPERLINKCOLORROLLOVER),parentControl.defaultHyperLinkColorRollover)
		  hyperLinkColorVisited =  FTUtilities.stringToColor(obj.GetAttribute(FTCxml.XML_HYPERLINKCOLORVISITED),parentControl.defaultHyperLinkColorVisited)
		  hyperLinkColorDisabled =  FTUtilities.stringToColor(obj.GetAttribute(FTCxml.XML_HYPERLINKCOLORDISABLED),parentControl.defaultHyperLinkColorDisabled)
		  useCustomHyperLinkColor = FTUtilities.stringToBoolean(obj.GetAttribute(FTCxml.XML_HYPERLINKUSECUSTOMCOLOR))
		  
		  //link underlines
		  noHyperlinkUlNormal= FTUtilities.stringToBoolean(obj.GetAttribute(FTCxml.XML_HYPERLINKULNORMAL))
		  noHyperlinkUlRollover= FTUtilities.stringToBoolean(obj.GetAttribute(FTCxml.XML_HYPERLINKULROLLOVER))
		  noHyperlinkUlVisited= FTUtilities.stringToBoolean(obj.GetAttribute(FTCxml.XML_HYPERLINKULVISITED))
		  noHyperlinkUlDisabled  = FTUtilities.stringToBoolean(obj.GetAttribute(FTCxml.XML_HYPERLINKULDISABLED))
		  
		  colorOpacity = val(obj.GetAttribute(FTCxml.XML_TEXT_OPACITY))
		  hasShadow = FTUtilities.stringToBoolean(obj.GetAttribute(FTCxml.XML_SHADOW))
		  shadowBlur = Val(obj.GetAttribute(FTCxml.XML_SHADOW_BLUR))
		  shadowOffset = Val(obj.GetAttribute(FTCxml.XML_SHADOW_OFFSET))
		  shadowOpacity =  Val(obj.GetAttribute(FTCxml.XML_SHADOW_OPACITY))
		  shadowAngle =  Val(obj.GetAttribute(FTCxml.XML_SHADOW_ANGLE))
		  shadowColor = FTUtilities.stringToColor(obj.GetAttribute(FTCxml.XML_SHADOW_COLOR), &c000000)
		  // End Add
		  
		  ' Is this a super script?
		  if FTUtilities.stringToBoolean(obj.GetAttribute(FTCxml.XML_SUPERSCRIPT)) then
		    
		    ' Set it for super script.
		    scriptLevel = 1
		    
		    ' Is this a sub script?
		  elseif FTUtilities.stringToBoolean(obj.GetAttribute(FTCxml.XML_SUBSCRIPT)) then
		    
		    ' Set it for sub script.
		    scriptLevel = -1
		    
		  end if
		  
		  ' Was the text base64 encoded?
		  if FTUtilities.stringToBoolean(obj.GetAttribute(FTCxml.XML_TEXT_ENCODED)) then
		    
		    ' Decode the text and add it.
		    setText(DecodeBase64(obj.GetAttribute(FTCxml.XML_TEXT), Encodings.UTF8))
		    
		  else
		    
		    ' Add the text.
		    setText(obj.GetAttribute(FTCxml.XML_TEXT))
		    
		  end if
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub copyStyleData(style as FTCharacterStyle)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Copy the attributes.
		  style.setBold(bold)
		  style.setCharacterSpacing(characterSpacing)
		  style.setFontName(font)
		  style.setFontSize(fontSize)
		  style.setItalic(italic)
		  style.setTextColor(TextColor)
		  //Issue 3796: FTStyleRun.copyStyleData does not copy background color
		  style.setBackgroundColor(getBackgroundColor)
		  style.setUnderline(underline)
		  style.setStrikeThrough(strikeThrough)
		  style.setScriptLevel(scriptLevel)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub copyStyleData(obj as FTStyleRun)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Copy the attributes.
		  obj.bold = bold
		  obj.characterSpacing = characterSpacing
		  obj.font = font
		  obj.fontSize = fontSize
		  obj.originalFontSize = originalFontSize
		  obj.italic = italic
		  obj.textColor = textColor
		  obj.underline = underline
		  obj.strikeThrough = strikeThrough
		  obj.scriptLevel = scriptLevel
		  obj.misspelled = misspelled
		  
		  obj.HyperLink = HyperLink
		  obj.hyperLinkColor = hyperLinkColor
		  obj.hyperLinkColorDisabled = hyperLinkColorDisabled
		  obj.hyperLinkColorRollover = hyperLinkColorRollover
		  obj.hyperLinkColorVisited = hyperLinkColorVisited
		  obj.useCustomHyperLinkColor = useCustomHyperLinkColor
		  
		  obj.noHyperlinkUlNormal=noHyperlinkUlNormal
		  obj.noHyperlinkUlRollover =noHyperlinkUlRollover
		  obj.noHyperlinkUlVisited = noHyperlinkUlVisited
		  obj.noHyperlinkUlDisabled = noHyperlinkUlDisabled
		  
		  obj.hasShadow = hasShadow
		  obj.shadowColor = shadowColor
		  obj.shadowBlur = shadowBlur
		  obj.shadowOffset = shadowOffset
		  obj.shadowOpacity = shadowOpacity
		  obj.shadowAngle = shadowAngle
		  
		  obj.colorOpacity = colorOpacity
		  
		  
		  ' Clear the caches.
		  obj.reset
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub copyStyleData(obj as RTFStyleAttributes)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Copy the attributes.
		  bold = obj.bold
		  characterSpacing = obj.characterSpacing
		  characterStyle = obj.characterStyle
		  font = obj.font.font
		  italic = obj.italic
		  fontSize = obj.fontSize
		  originalFontSize = obj.fontSize
		  scriptLevel = obj.scriptLevel
		  HyperLink = obj.hyperlink
		  
		  hasShadow = obj.shadow
		  shadowBlur = obj.shadowBlur
		  shadowColor = obj.shadowColor
		  shadowOffset = obj.shadowOffset
		  shadowOpacity = obj.shadowOpacity
		  
		  ' Was a super or sub script specified?
		  if scriptLevel <> 0 then
		    
		    ' Set the font size.
		    fontSize = originalFontSize * SCRIPT_SIZE
		    
		  end if
		  
		  ' Copy the base attributes.
		  super.copyStyleData(obj)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub deleteLeft(startIndex as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Is there anything to do?
		  if (startIndex > 0) and (length > 0) then
		    
		    ' Delete the left portion of the string.
		    setText(mid(text, startIndex))
		    
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub deleteMid(startIndex as integer, endIndex as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Delete the mid portion of the string.
		  setText(mid(text, 1, startIndex - 1) + mid(text, endIndex + 1))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub deleteRight(startIndex as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Is there anything to do?
		  if length > 0 then
		    
		    ' Is there anything to do?
		    if startIndex > getLength then return
		    
		    ' Delete the right portion of the string.
		    setText(left(text, startIndex), startIndex)
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub deleteText(offset as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim pos as integer
		  
		  ' Convert to the local offset.
		  pos = offset - getStartPosition + 1
		  
		  ' Delete the text.
		  setText(mid(text, 1, pos - 1) + mid(text, pos + 1), length - 1)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub drawMispelledIndicator(g as Graphics, x as integer, y as integer, printing as boolean, scale as double)
		  
		  #pragma Unused scale
		  
		  Dim drawWidth as integer
		  Dim ypos as integer
		  
		  ' Is this word misspelled?
		  if misspelled and (not printing) then
		    
		    ' Is there anything to do?
		    if length <= 0 then return
		    
		    dim iMultiplier as integer
		    if parentControl.IsHiDPT then
		      iMultiplier = 4
		    else
		      iMultiplier = 1
		    end
		    
		    ' Set the pen height and width
		    g.PenHeight = INDICATOR_HEIGHT * iMultiplier
		    g.PenWidth = g.PenHeight
		    
		    ' Calculate where to draw the line.
		    ypos = y + INDICATOR_OFFSET
		    
		    ' Set the misspelled line color.
		    g.ForeColor = MISSPELLED_COLOR
		    
		    ' Get the width.
		    drawWidth = Round(getWidth(parentControl.getDisplayScale))
		    
		    ' Draw the indicator. //Moved drawing to this method.
		    ' parentControl.drawMisspelledIndicator(g, x, yPos, x + drawWidth, yPos)
		    
		    ' Draw the indicator.
		    g.DrawLine(x, yPos, x + drawWidth, yPos)
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub dump(sa() as string)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Header information.
		  sa.Append("Style Run")
		  sa.Append("")
		  
		  ' Get the base information.
		  super.dump(sa)
		  
		  ' Get the information.
		  sa.Append("text: """ + str(text) + """")
		  sa.Append("text length: " + str(text.len))
		  sa.Append("bold: " + str(bold))
		  sa.Append("characterSpacing: " + str(characterSpacing))
		  sa.Append("font: " + str(font))
		  sa.Append("italic: " + str(italic))
		  sa.Append("fontSize: " + str(fontSize))
		  sa.Append("textColor: " + str(textColor))
		  sa.Append("underline: " + str(underline))
		  sa.Append("scriptLevel: " + str(scriptLevel))
		  sa.Append("misspelled: " + str(misspelled))
		  sa.Append("strikeThrough: " + str(strikeThrough))
		  sa.Append("backgroundColor: " + str(getBackgroundColor))
		  
		  ' Blank line.
		  sa.Append("")
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function findDifference(ftsr as FTStyleRun) As string
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim markedState as boolean
		  Dim sa() as string
		  
		  ' Are these objects marked?
		  if marked and (ftsr.marked = marked) then
		    
		    ' Are the colors the same?
		    markedState = (ftsr.markColor = markColor)
		    
		  else
		    
		    ' Neither are marked.
		    markedState = true
		    
		  end if
		  
		  ' Compare the style settings.
		  sa.Append("bold: " + str(bold) + " " + str(ftsr.bold))
		  sa.Append("characterSpacing: " + str(characterSpacing) + " " + str(ftsr.characterSpacing))
		  sa.Append("font: " + str(font) + " " + str(ftsr.font))
		  sa.Append("italic: " + str(italic) + " " + str(ftsr.italic))
		  sa.Append("fontSize: " + str(fontSize) + " " + str(ftsr.fontSize))
		  sa.Append("textColor: " + str(textColor) + " " + str(ftsr.textColor))
		  sa.Append("underline: " + str(underline) + " " + str(ftsr.underline))
		  sa.Append("scriptLevel: " + str(scriptLevel) + " " + str(ftsr.scriptLevel))
		  sa.Append("misspelled: " + str(misspelled) + " " + str(ftsr.misspelled))
		  sa.Append("strikeThrough: " + str(strikeThrough) + " " + str(ftsr.strikeThrough))
		  sa.Append("backgroundColor: " + str(getBackgroundColor) + " " + str(ftsr.getBackgroundColor))
		  
		  sa.Append("hyperlink: " + HyperLink+ " " + (ftsr.HyperLink))
		  sa.Append("hyperlinkcolor: " + Str(hyperLinkColor)+ " " + Str(ftsr.hyperLinkColor))
		  
		  return join(sa, EndOfLine)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getCharacter(index as integer) As string
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the specified character.
		  return mid(text, index, 1)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getCharacterStyle() As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the character style ID.
		  return characterStyle
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getFontSize() As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the font size.
		  return fontSize
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getLength() As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the length of the text.
		  return length
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function getOriginalAscent(scale as double) As double
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim ascent as integer
		  Dim saveFontSize as integer
		  
		  ' Save the current font size.
		  saveFontSize = fontSize
		  
		  ' Restore the original font size.
		  fontSize = originalFontSize
		  
		  ' Calculate the ascent.
		  ascent = self.getStringAscent(scale)
		  
		  ' Restore the font size.
		  fontSize = saveFontSize
		  
		  ' Return the ascent.
		  return ascent
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function getOriginalDescent(scale as double) As double
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim descent as integer
		  Dim saveFontSize as integer
		  
		  ' Save the current font size.
		  saveFontSize = fontSize
		  
		  ' Restore the original font size.
		  fontSize = originalFontSize
		  
		  ' Calculate the descent.
		  descent = self.getStringHeight(scale) - self.getStringAscent(scale)
		  
		  ' Restore the font size.
		  fontSize = saveFontSize
		  
		  ' Return the ascent.
		  return descent
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub getRTF(rtf as RTFWriter)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim name as string
		  Dim style as FTCharacterStyle
		  
		  ' Create a new subcontext.
		  rtf.startGroup
		  
		  ' Was a character style specified?
		  if characterStyle <> 0 then
		    
		    ' Get the specified style.
		    style = parentControl.getDoc.getCharacterStyle(characterStyle)
		    
		    ' Does the style exist?
		    if not (style is nil) then
		      
		      ' Get the name of the style.
		      name = style.getStyleName
		      
		      ' Set the character style name.
		      rtf.setCharacterStyle(name)
		      
		    end if
		    
		  end if
		  
		  ' Set the attributes.
		  rtf.setFont(font)
		  rtf.setFontSize(fontSize)
		  if bold then rtf.setBold
		  ' Apple Pages shows wrong results, if character spacing was defined and gets zero,
		  ' thats why we always write the character spacing to RTF.
		  rtf.setCharacterSpacing(characterSpacing)
		  if italic then rtf.setItalic
		  
		  ' Was a super or sub script specified?
		  if scriptLevel <> 0 then
		    
		    ' Was this a super script?
		    if scriptLevel > 0 then
		      
		      ' Set the super script.
		      rtf.setSuperscript(originalFontSize)
		      
		    else
		      
		      ' Set the subscript.
		      rtf.setSubscript(originalFontSize)
		      
		    end if
		    
		  end if
		  
		  if HyperLink <> "" then
		    rtf.setHyperLink HyperLink
		  end
		  
		  ' Get the rest of the attributes.
		  super.getRTF(rtf)
		  
		  ' Save the text.
		  rtf.setText(text)
		  
		  ' Finish the context.
		  rtf.endGroup
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getText(showPictures as boolean = false) As string
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  #pragma Unused showPictures
		  
		  ' Return the text.
		  return text
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getText(startPosition as integer, endPosition as integer) As string
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the specified text.
		  return mid(text, startPosition, endPosition - startPosition + 1)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub getXML(xmlDoc as XmlDocument, paragraph as XmlElement)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim textNode as XmlElement
		  
		  ' Create the text node.
		  textNode = xmlDoc.CreateElement(FTCxml.XML_FTSTYLERUN)
		  
		  ' Load up the base attributes.
		  getBaseXML(xmlDoc, textNode)
		  
		  ' Was a character style specified?
		  if characterStyle <> 0 then
		    
		    ' load the character style name.
		    textNode.SetAttribute(FTCxml.XML_CHARACTER_STYLE, Str(characterStyle))
		    
		  end if
		  
		  ' Load up the boolean node attributes.
		  if bold then textNode.SetAttribute(FTCxml.XML_BOLD, FTUtilities.booleanToString(bold))
		  if characterSpacing <> 0 then textNode.SetAttribute(FTCxml.XML_CHARACTER_SPACING, Str(characterSpacing))
		  if italic then textNode.SetAttribute(FTCxml.XML_ITALIC, FTUtilities.booleanToString(italic))
		  if (scriptLevel > 0) then textNode.SetAttribute(FTCxml.XML_SUPERSCRIPT, FTUtilities.booleanToString(scriptLevel > 0))
		  if (scriptLevel < 0) then textNode.SetAttribute(FTCxml.XML_SUBSCRIPT, FTUtilities.booleanToString(scriptLevel < 0))
		  if characterStyle <> 0 then textNode.SetAttribute(FTCxml.XML_CHARACTER_STYLE, Str(characterStyle))
		  
		  ' Load up the rest of the node attributes.
		  textNode.SetAttribute(FTCxml.XML_FONT, font)
		  textNode.SetAttribute(FTCxml.XML_SIZE, str(fontSize))
		  textNode.SetAttribute(FTCxml.XML_ORIGINAL_SIZE, str(originalFontSize))
		  textNode.SetAttribute(FTCxml.XML_TEXT_ENCODED, FTUtilities.booleanToString(true))
		  textNode.SetAttribute(FTCxml.XML_TEXT, EncodeBase64(text, 0))
		  
		  ' Add the node to the paragraph.
		  paragraph.AppendChild(textNode)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub initialize()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set up the cache.
		  widthCache = new Dictionary
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub insertText(offset as integer, s as string)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim pos as integer
		  Dim sa(2) as string
		  Dim delta as integer
		  
		  ' Convert to the local offset.
		  pos = offset - getStartPosition + 1
		  
		  ' Set the first two parts of the string.
		  sa(0) = mid(text, 1, pos)
		  sa(1) = s
		  
		  ' Get the length that will be inserted.
		  delta = s.len
		  
		  ' Are we inserting in a different part of the string?
		  if offset <> textCacheOffset then
		    
		    ' Create the new cache.
		    textCache = mid(text, pos + 1)
		    
		  end if
		  
		  ' Add in the delta for the next time around.
		  textCacheOffset = offset + delta
		  
		  ' Assign the last part of the string.
		  sa(2) = textCache
		  
		  ' Set the text.
		  text = join(sa, "")
		  
		  ' Get the length of the text.
		  length = length + delta
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isEmpty(includeSpace as boolean) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Should we examine space characters?
		  if includeSpace then
		    
		    ' Is the run empty?
		    return (length = 0)
		    
		  else
		    
		    ' Is there anything to look at?
		    if length = 0 then
		      
		      return true
		      
		    end if
		    
		    ' Is the run empty?
		    return (Trim(text) = "")
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isHyperlink() As Boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  return Hyperlink <> ""
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isMonolithic() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' We can be broke into smaller parts.
		  return false
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isSame(obj as FTObject) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim ftsr as FTStyleRun
		  
		  ' Are the objects the same type?
		  if not (obj isa FTStyleRun) then return false
		  
		  ' Type cast the object.
		  ftsr = FTStyleRun(obj)
		  
		  ' Are they the same?
		  return isSameStyle(ftsr) and (text = ftsr.text)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isSameCharacterStyle(cs as FTCharacterStyle) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim ignore as boolean
		  
		  '----------------------------------------------
		  
		  if cs.isBackgroundColorDefined then
		    
		    ' This is a workaround for a strange bug.
		    ' Just doing if getBackgroundColor <> cs.getBackgroundColor then return false
		    ' Doesn't work!  No idea way.
		    dim c1 as color = getBackgroundColor
		    dim c2 as color = cs.getBackgroundColor
		    
		    if c1 <> c2 then return false
		    
		  end if
		  
		  '----------------------------------------------
		  
		  if cs.isBoldDefined then
		    
		    if bold <> cs.getBold then return false
		    
		  end if
		  
		  '----------------------------------------------
		  
		  if cs.isCharacterSpacingDefined then
		    
		    if characterSpacing <> cs.getCharacterSpacing then return false
		    
		  end if
		  
		  '----------------------------------------------
		  
		  if cs.isFontNameDefined then
		    
		    if font <> cs.getFontName then return false
		    
		  end if
		  
		  '----------------------------------------------
		  
		  if cs.isFontSizeDefined then
		    
		    if fontSize <> cs.getFontSize then return false
		    
		  end if
		  
		  '----------------------------------------------
		  
		  if cs.isItalicDefined then
		    
		    if italic <> cs.getItalic then return false
		    
		  end if
		  
		  '----------------------------------------------
		  
		  if cs.isMarkDefined(ignore) then
		    
		    if markColor <> cs.getMarkColor then return false
		    
		  end if
		  
		  '----------------------------------------------
		  
		  if cs.isScriptLevelDefined then
		    
		    if scriptLevel <> cs.getScriptLevel then return false
		    
		  end if
		  
		  '----------------------------------------------
		  
		  if cs.isStrikeThroughDefined then
		    
		    if strikeThrough <> cs.getStrikeThrough then return false
		    
		  end if
		  
		  '----------------------------------------------
		  
		  if cs.isTextColorDefined then
		    
		    dim c1 as color = textColor
		    dim c2 as color = cs.getTextColor
		    
		    if c1 <> c2 then return false
		    
		  end if
		  
		  '----------------------------------------------
		  
		  if cs.isUnderlineDefined then
		    
		    if underline <> cs.getUnderline then return false
		    
		  end if
		  
		  '----------------------------------------------
		  
		  ' They are the same.
		  return true
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isSameStyle(ftsr as FTStyleRun) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim markedState as boolean
		  Dim b as boolean
		  
		  ' Are they in the same marked state?
		  if marked <> ftsr.marked then return false
		  
		  ' Are these objects marked?
		  if marked then
		    
		    ' Are the colors the same?
		    markedState = (ftsr.markColor = markColor)
		    
		  else
		    
		    ' Neither are marked.
		    markedState = true
		    
		  end if
		  
		  
		  ' Compare the style settings.
		  b = (ftsr.bold = bold)
		  b = b and (ftsr.characterSpacing = characterSpacing)
		  b = b and (ftsr.font = font)
		  b = b and (ftsr.italic = italic)
		  b = b and (ftsr.fontSize = fontSize)
		  b = b and (ftsr.textColor = textColor)
		  b = b and (ftsr.underline = underline)
		  b = b and (ftsr.scriptLevel = scriptLevel)
		  b = b and markedState
		  b = b and (ftsr.misspelled = misspelled)
		  b = b and (ftsr.strikeThrough = strikeThrough)
		  b = b and (ftsr.getBackgroundColor = getBackgroundColor)
		  
		  
		  b=b and (ftsr.HyperLink= HyperLink)
		  
		  //we don't need all the hyperlink colors so im not including them here. Hyperlink colors shouldn't be different for on hyperlink
		  b=b and (ftsr.hasShadow= hasShadow)
		  b=b and (ftsr.shadowBlur= shadowBlur)
		  b=b and (ftsr.shadowColor= shadowColor)
		  b=b and (ftsr.shadowOffset= shadowOffset)
		  b=b and (ftsr.shadowOpacity= shadowOpacity)
		  b=b and (ftsr.shadowAngle= shadowAngle)
		  
		  b=b and (ftsr.colorOpacity= colorOpacity)
		  
		  ' Return the result.
		  return b
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isSaved() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Is this run to exempted from optimization?
		  return saveRun
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function lookupWidth(startIndex as integer, endIndex as integer, scale as double) As double
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim value as double
		  Dim hashValue as UInt64
		  
		  ' Calculate the has value.
		  hashValue = Bitwise.ShiftLeft(startIndex, 32) + endIndex
		  
		  ' Is the width in the cache?
		  if widthCache.HasKey(hashValue) then
		    
		    ' Look up the width.
		    value = widthCache.Value(hashValue)
		    
		  else
		    
		    ' Get the width.
		    value = self.getStringWidth(startIndex, endIndex, scale)
		    
		    ' Have we reached the upper bound?
		    if widthCache.Count <= MAX_CACHE_LOOKUP then
		      
		      ' Store it in the cache.
		      widthCache.Value(hashValue) = value
		      
		    end if
		    
		  end if
		  
		  ' Return the calculated width.
		  return value
		  
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
		  fontSize = max(1,fontSize - 1)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub removeLineEndings()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Remove any line endings.
		  setText(ReplaceLineEndings(text, ""))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub reset()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Reset the caches.
		  textHeight = -1
		  textAscent = -1
		  widthCache.Clear
		  
		  ' Is there any text that can be misspelled?
		  if length = 0 then misspelled = false
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub saveDefaultCharacterStyle()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Create a new character style.
		  defaultCharacterStyle = new FTCharacterStyle(parentControl, "")
		  
		  ' Copy over the style attributes.
		  copyStyleData(defaultCharacterStyle)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function seekEndPosition(startPosition as integer, width as integer) As integer
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim endPoint as integer
		  Dim segmentWidth as double
		  Dim target as integer
		  Dim endPosition as integer
		  Dim scaleFactor as double
		  
		  ' Is there anything to do?
		  if width <= 0 then return startPosition
		  
		  ' Get the testing length.
		  endPosition = length
		  
		  ' Get the maximum length.
		  segmentWidth = getWidth(startPosition, endPosition)
		  
		  ' Calculate the scale factor to guess where to start looking.
		  scaleFactor = CType(width, double) / CType(segmentWidth, double)
		  
		  ' Estimate the target position.
		  target = round(scaleFactor * (endPosition - startPosition)) + startPosition
		  
		  ' Get the length to the target position.
		  segmentWidth = getWidth(startPosition, target)
		  
		  ' Do we have to keep searching?
		  if segmentWidth <> width then
		    
		    ' Which way do we need to traverse?
		    if segmentWidth < width then
		      
		      ' Search to the right.
		      for endPoint = target + 1 to length
		        
		        ' Get the length of the segment.
		        segmentWidth = getWidth(startPosition, endPoint)
		        
		        ' Have we reached the correct width?
		        if segmentWidth >= width then
		          
		          ' Go back to the previous character.
		          endPoint = endPoint - 1
		          
		          ' We found it.
		          exit
		          
		        end if
		        
		      next
		      
		    else
		      
		      ' Search to the left.
		      for endPoint = target - 1 downto startPosition
		        
		        ' Get the length of the segment.
		        segmentWidth = getWidth(startPosition, endPoint)
		        
		        ' Have we reached the correct width?
		        if segmentWidth <= width then
		          
		          ' We found it.
		          exit
		          
		        end if
		        
		      next
		      
		    end if
		    
		  else
		    
		    ' Use the current end point.
		    endPoint = target
		    
		  end if
		  
		  ' Append spaces to the line.
		  while Mid(text, endPoint + 1, 1) = " "
		    
		    ' Add the space to the line.
		    endPoint = endPoint + 1
		    
		  wend
		  
		  ' Do we have a non-existant position?
		  if endPoint < startPosition then endPoint = startPosition
		  
		  ' Return the end point.
		  return endPoint
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setSaveState(state as boolean)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set the optimization save state.
		  saveRun = state
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setText(text as string, textLength as integer = - 1)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  'RAS: We need to set the encoding otherwise if we export (like for saving to disk)
		  'we may not get the same back
		  if Encoding(text)=nil then
		    text = DefineEncoding(text, Encodings.UTF8)
		  else
		    text = ConvertEncoding(text, Encodings.UTF8)
		  end if
		  
		  ' Remove the line endings and save the text.
		  me.text = text
		  
		  ' Was the text length given?
		  if textLength > -1 then
		    
		    ' Save the length of the string.
		    me.length = textLength
		    
		    #if DebugBuild
		      
		      ' Test the optimization.
		      if (textLength > -1) and (textLength <> text.len) then
		        
		        ' If you hit this break point, it means something was missed when
		        ' the text length value was sent in. If you are here because of the
		        ' FTC code, please let me know ASAP. If it is your own code, then
		        ' fix it!
		        break
		        
		      end if
		      
		    #endif
		    
		  else
		    
		    ' Get the length of the text.
		    me.length = text.len
		    
		  end if
		  
		  ' Reset the measurements.
		  reset
		  
		  ' Clear the text cache.
		  textCache = ""
		  textCacheOffset = -1
		  
		  ' This run has been used.
		  setSaveState(false)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function splitOnTabs() As FTObject()
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim sr as FTStyleRun
		  Dim tab as FTTab
		  Dim fto() as FTObject
		  Dim sa() as string
		  
		  ' Split the text on tabs.
		  sa = split(text, chr(9))
		  
		  ' Get the number of splits.
		  count = Ubound(sa)
		  
		  ' Were there any tabs?
		  if count = -1 then
		    
		    ' Add the style run.
		    fto.Append(me.clone)
		    
		  else
		    
		    ' Insert FTC tabs.
		    for i = 0 to count
		      
		      ' Make a clone of the original.
		      sr = FTStyleRun(me.clone)
		      
		      ' Set the text.
		      sr.setText(sa(i))
		      
		      ' Add the style run.
		      fto.Append(sr)
		      
		      ' Is this a spot where we should insert a tab?
		      if i < count then
		        
		        ' Create the tab.
		        tab = new FTTab(parentControl)
		        
		        ' Add the tab.
		        fto.Append(tab)
		        
		      end if
		      
		    next
		    
		  end if
		  
		  ' Return the list of objects.
		  return fto
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub updateWithStyle(style as FTCharacterStyle)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim markState as boolean
		  
		  ' Is there anything to do?
		  if style is nil then return
		  
		  ' Set the super class attributes.
		  super.updateWithStyle(style)
		  
		  '-----------------------------
		  ' Bold
		  '-----------------------------
		  
		  ' Has the attribute been defined?
		  if style.isBoldDefined then
		    
		    ' Set the attribute.
		    bold = style.getBold
		    
		  end if
		  
		  '-----------------------------
		  ' Character Spacing
		  '-----------------------------
		  
		  ' Has the attribute been defined?
		  if style.isCharacterSpacingDefined then
		    
		    ' Set the attribute.
		    characterSpacing = style.getCharacterSpacing
		    
		  end if
		  
		  '-----------------------------
		  ' Italic
		  '-----------------------------
		  
		  ' Has the attribute been defined?
		  if style.isItalicDefined then
		    
		    ' Set the attribute.
		    italic = style.getItalic
		    
		  end if
		  
		  '-----------------------------
		  ' Underline
		  '-----------------------------
		  
		  ' Has the attribute been defined?
		  if style.isUnderlineDefined then
		    
		    ' Set the attribute.
		    underline = style.getUnderline
		    
		  end if
		  
		  '-----------------------------
		  ' StrikeThrough
		  '-----------------------------
		  
		  ' Has the attribute been defined?
		  if style.isStrikeThroughDefined then
		    
		    ' Set the attribute.
		    strikeThrough = style.getStrikeThrough
		    
		  end if
		  
		  '-----------------------------
		  ' Sub/superscript
		  '-----------------------------
		  
		  ' Has the attribute been defined?
		  if style.isScriptLevelDefined then
		    
		    ' Set the attribute.
		    scriptLevel = style.getScriptLevel
		    
		  end if
		  
		  '-----------------------------
		  ' Font
		  '-----------------------------
		  
		  ' Has the attribute been defined?
		  if style.isFontNameDefined then
		    
		    ' Set the attribute.
		    font = style.getFontName
		    
		  end if
		  
		  '-----------------------------
		  ' Font size
		  '-----------------------------
		  
		  ' Has the attribute been defined?
		  if style.isFontSizeDefined then
		    
		    ' Set the attribute.
		    fontSize = style.getFontSize
		    
		  end if
		  
		  '-----------------------------
		  ' Text Color
		  '-----------------------------
		  
		  ' Has the attribute been defined?
		  if style.isTextColorDefined then
		    
		    ' Set the attribute.
		    textColor = style.getTextColor
		    
		  end if
		  
		  '-----------------------------
		  ' Marked
		  '-----------------------------
		  
		  ' Has the attribute been defined?
		  if style.isMarkDefined(markState) then
		    
		    ' Set the marked state.
		    marked = markState
		    
		    ' Set the attribute.
		    markColor = style.getMarkColor
		    
		  end if
		  
		  '-----------------------------
		  
		  ' Reset the flags.
		  reset
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub updateWithStyle(style as FTParagraphStyle)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Update the character style attributes.
		  updateWithStyle(FTCharacterStyle(style))
		  
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		bold As boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		characterSpacing As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private characterStyle As integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private defaultCharacterStyle As FTCharacterStyle
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  
			  #if not DebugBuild
			    
			    #pragma BoundsChecking FTC_BOUNDSCHECKING
			    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
			    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
			    
			  #endif
			  
			  ' Was a font assigned?
			  if mfont.lenB = 0 then
			    
			    ' Set the font.
			    mfont = parentControl.checkFontName("")
			    
			  end if
			  
			  ' Return the font.
			  return mfont
			  
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  
			  #if not DebugBuild
			    
			    #pragma BoundsChecking FTC_BOUNDSCHECKING
			    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
			    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
			    
			  #endif
			  
			  ' Set the font.
			  mfont = parentControl.checkFontName(value)
			End Set
		#tag EndSetter
		font As string
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  
			  #if not DebugBuild
			    
			    #pragma BoundsChecking FTC_BOUNDSCHECKING
			    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
			    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
			    
			  #endif
			  
			  ' Is this a bad size?
			  if mfontSize <= 0 then
			    
			    ' Set the default size.
			    mfontSize = parentControl.DefaultFontSize
			    
			  end if
			  
			  ' Return the font size.
			  return mfontSize
			  
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  
			  #if not DebugBuild
			    
			    #pragma BoundsChecking FTC_BOUNDSCHECKING
			    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
			    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
			    
			  #endif
			  
			  ' Is this a bad size?
			  if value <= 0 then
			    
			    ' Set the default size.
			    value = parentControl.DefaultFontSize
			    
			  end if
			  
			  ' Set the font size.
			  mfontSize = value
			  
			  ' Clear the caches.
			  reset
			  
			End Set
		#tag EndSetter
		fontSize As integer
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		italic As boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private length As integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mfont As string
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mfontSize As integer
	#tag EndProperty

	#tag Property, Flags = &h0
		misspelled As boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private originalFontSize As double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private saveRun As boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		scriptLevel As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private text As string
	#tag EndProperty

	#tag Property, Flags = &h21
		Private textAscent As double = -1
	#tag EndProperty

	#tag Property, Flags = &h21
		Private textCache As string
	#tag EndProperty

	#tag Property, Flags = &h21
		Private textCacheOffset As integer = -1
	#tag EndProperty

	#tag Property, Flags = &h0
		textCacheScale As double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private textHeight As double = -1
	#tag EndProperty

	#tag Property, Flags = &h21
		Private widthCache As Dictionary
	#tag EndProperty


	#tag Constant, Name = MAX_CACHE_LOOKUP, Type = Double, Dynamic = False, Default = \"20", Scope = Private
	#tag EndConstant

	#tag Constant, Name = MISSPELLED_COLOR, Type = Color, Dynamic = False, Default = \"&cFF7F7F", Scope = Public
	#tag EndConstant

	#tag Constant, Name = SCRIPT_SIZE, Type = Double, Dynamic = False, Default = \"0.66", Scope = Private
	#tag EndConstant

	#tag Constant, Name = SUBSCRIPT_OFFSET, Type = Double, Dynamic = False, Default = \"0.70", Scope = Private
	#tag EndConstant

	#tag Constant, Name = SUPERSCRIPT_OFFSET, Type = Double, Dynamic = False, Default = \"0.30", Scope = Private
	#tag EndConstant


	#tag Structure, Name = PartialCacheStructure, Flags = &h0
		partialWidthStartIndex as integer
		  partialWidthEndIndex as integer
		  partialWidthCache as double
		count as integer
	#tag EndStructure


	#tag ViewBehavior
		#tag ViewProperty
			Name="bold"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="colorOpacity"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="font"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="string"
			EditorType="MultiLineEditor"
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
			Name="hasShadow"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HyperLink"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="hyperLinkColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c0000ff"
			Type="color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="hyperLinkColorDisabled"
			Visible=false
			Group="Behavior"
			InitialValue="&cC0C0C0"
			Type="color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="hyperLinkColorRollover"
			Visible=false
			Group="Behavior"
			InitialValue="&cFF0000"
			Type="color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="hyperLinkColorVisited"
			Visible=false
			Group="Behavior"
			InitialValue="&c800080"
			Type="color"
			EditorType=""
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
			Name="inNewWindow"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
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
			Name="markColor"
			Visible=false
			Group="Behavior"
			InitialValue="&h000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="marked"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="misspelled"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="boolean"
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
			Name="shadowAngle"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="double"
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
			Type="Color"
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
			Type="Double"
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
			Name="textCacheScale"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="double"
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
			Name="useCustomHyperLinkColor"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
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
