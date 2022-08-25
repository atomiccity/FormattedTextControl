#tag Class
Protected Class FTObject
Inherits FTBase
	#tag Method, Flags = &h0
		Function callConstructContextualMenu(base as DesktopMenuItem, x as integer, y as integer) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Call the event.
		  return ConstructContextualMenu(base, x, y)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function callContextualMenuAction(selectedItem as DesktopMenuItem) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Call the event.
		  return ContextualMenuAction(selectedItem)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub callScaleChanged()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Call the event.
		  ScaleChanged
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeBackgroundColor()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Don't use a background color.
		  useBackgroundColorFlag = false
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeBackgroundColor(c as Color)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the background color.
		  backgroundColor = c
		  
		  ' Use a background color.
		  useBackgroundColorFlag = true
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeColor(c as Color)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the text color.
		  textColor = c
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ChangeHyperLink(mhyperLink As String, newWindow as Boolean)
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  '' Assign our hyperlink
		  hyperLink = mhyperLink
		  inNewWindow = newWindow
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ChangeHyperLinkColor(mHyperLinkColor As Color, mHyperLinkColorRollover As Color, mHyperLinkColorVisited As Color, mHyperLinkColorDisabled As Color, ulNormal As Boolean, ulRollover As Boolean, ulVisited as Boolean, ulDisabled as Boolean)
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ''first let's see if our assigned colors are any different from the default from the parent formattedtext control
		  ''if they are, we set the useCustomHyperLinkColor to true new 3b1
		  
		  if mHyperLinkColor<> hyperLinkColor _
		    or mhyperLinkColorVisited<> hyperLinkColorVisited _
		    or mHyperLinkColorRollover<> hyperLinkColorRollover _
		    or mHyperLinkColorDisabled<> hyperLinkColorDisabled then
		    
		    useCustomHyperLinkColor  = TRUE
		    
		    ' Assign our hyperlink color
		    hyperLinkColor = mHyperLinkColor
		    hyperLinkColorVisited = mHyperLinkColorVisited
		    hyperLinkColorRollover = mHyperLinkColorRollover
		    hyperLinkColorDisabled = mHyperLinkColorDisabled
		    
		  else
		    useCustomHyperLinkColor  = FALSE//don't use custom hyperlink colors
		    
		  end
		  
		  //copy overhyperlink Underline settings
		  noHyperlinkUlNormal= NOT ulNormal
		  noHyperlinkUlDisabled =NOT ulDisabled
		  noHyperlinkUlRollover =NOT ulRollover
		  noHyperlinkUlVisited =NOT ulVisited
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeMark()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Turn off the mark.
		  marked = false
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeMark(c as Color)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Turn on the mark.
		  marked = true
		  
		  ' Save the text color.
		  markColor = c
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ChangeOpacity(mOpacity As Double)
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  colorOpacity = mOpacity
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ChangeShadow(mHasShadow As Boolean, col as color, offset as double, blur as Double, opacity as double, angle as double)
		  #If Not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' shadow setting
		  hasShadow = mHasShadow
		  shadowColor = col
		  shadowOffset = offset
		  shadowBlur = blur
		  shadowOpacity = opacity
		  shadowAngle = angle
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeStyle(style as integer, value as boolean)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Flip the attribute.
		  select case style
		    
		  case FTStyle.STYLE_UNDERLINE
		    
		    underline = value
		    
		  case FTStyle.STYLE_STRIKE_THROUGH
		    
		    strikeThrough = value
		    
		  case FTStyle.STYLE_PLAIN
		    
		    ' Turn off all styling.
		    underline = false
		    strikeThrough = false
		    textColor = &c000000
		    
		  end select
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub clearLines()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Clear the lines through the text.
		  underline = false
		  strikeThrough = false
		  marked = false
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function clone() As FTObject
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' We should not get here.
		  break
		  
		  ' Do nothing.
		  return self
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(parentControl as FormattedText, generateNewID as boolean)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Do we need to create a new ID?
		  if generateNewId then
		    
		    ' Create an ID for this object.
		    id = FTUtilities.getNewID
		    
		  end if
		  
		  ' Save the parent control.
		  super.Constructor(parentControl)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1000
		Sub Constructor(parentControl as FormattedText, attributeList as XmlAttributeList, generateNewID as boolean)
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the reference.
		  me.paragraph = paragraph
		  
		  ' Do we need to create a new ID?
		  if generateNewId then
		    
		    ' Create an ID for this object.
		    id = FTUtilities.getNewID
		    
		  end if
		  
		  ' Save the parent control.
		  super.Constructor(parentControl)
		  
		  ' Load up the attributes.
		  backgroundColor = FTUtilities.stringToColor(attributeList.value(FTCxml.XML_BACKGROUND_COLOR), &cFFFFFF)
		  useBackgroundColorFlag = FTUtilities.stringToBoolean(attributeList.value(FTCxml.XML_BACKGROUND_COLOR_DEFINED))
		  markColor = FTUtilities.stringToColor(attributeList.value(FTCxml.XML_MARK_COLOR))
		  marked = FTUtilities.stringToBoolean(attributeList.value(FTCxml.XML_MARKED))
		  strikeThrough = FTUtilities.stringToBoolean(attributeList.value(FTCxml.XML_STRIKE_THROUGH))
		  textColor = FTUtilities.stringToColor(attributeList.value(FTCxml.XML_TEXT_COLOR), &c000000)
		  underline = FTUtilities.stringToBoolean(attributeList.value(FTCxml.XML_UNDERLINE))
		  parentControl.callXmlDecodeTag(attributeList.value(FTCxml.XML_TAG), self)
		  
		  
		  HyperLink = (attributeList.value(FTCxml.XML_HYPERLINK))
		  hyperLinkColor  = FTUtilities.stringToColor(attributeList.value(FTCxml.XML_HYPERLINKCOLOR))
		  hyperLinkColorRollover  = FTUtilities.stringToColor(attributeList.value(FTCxml.XML_HYPERLINKCOLORROLLOVER))
		  hyperLinkColorVisited  = FTUtilities.stringToColor(attributeList.value(FTCxml.XML_HYPERLINKCOLORVISITED))
		  hyperLinkColorDisabled  = FTUtilities.stringToColor(attributeList.value(FTCxml.XML_HYPERLINKCOLORDISABLED))
		  
		  hasShadow = FTUtilities.stringToBoolean(attributeList.value(FTCxml.XML_SHADOW))
		  shadowColor = FTUtilities.stringToColor(attributeList.value(FTCxml.XML_SHADOW_COLOR),&c000000)
		  shadowBlur = Val(attributeList.value(FTCxml.XML_SHADOW_BLUR))
		  shadowOffset = Val(attributeList.value(FTCxml.XML_SHADOW_OFFSET))
		  shadowOpacity = Val(attributeList.value(FTCxml.XML_SHADOW_OPACITY))
		  shadowAngle = Val(attributeList.value(FTCxml.XML_SHADOW_ANGLE))
		  colorOpacity = Val(attributeList.value(FTCxml.XML_TEXT_OPACITY))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(parentControl as FormattedText, obj as XmlElement, generateNewID as boolean)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the reference.
		  me.paragraph = paragraph
		  
		  ' Do we need to create a new ID?
		  if generateNewId then
		    
		    ' Create an ID for this object.
		    id = FTUtilities.getNewID
		    
		  end if
		  
		  ' Save the parent control.
		  super.Constructor(parentControl)
		  
		  ' Load up the attributes.
		  backgroundColor = FTUtilities.stringToColor(obj.GetAttribute(FTCxml.XML_BACKGROUND_COLOR), &cFFFFFF)
		  useBackgroundColorFlag = FTUtilities.stringToBoolean(obj.GetAttribute(FTCxml.XML_BACKGROUND_COLOR_DEFINED))
		  markColor = FTUtilities.stringToColor(obj.GetAttribute(FTCxml.XML_MARK_COLOR))
		  marked = FTUtilities.stringToBoolean(obj.GetAttribute(FTCxml.XML_MARKED))
		  strikeThrough = FTUtilities.stringToBoolean(obj.GetAttribute(FTCxml.XML_STRIKE_THROUGH))
		  textColor = FTUtilities.stringToColor(obj.GetAttribute(FTCxml.XML_TEXT_COLOR), &c000000)
		  underline = FTUtilities.stringToBoolean(obj.GetAttribute(FTCxml.XML_UNDERLINE))
		  parentControl.callXmlDecodeTag(obj.GetAttribute(FTCxml.XML_TAG), self)
		  
		  
		  HyperLink = (obj.GetAttribute(FTCxml.XML_HYPERLINK))
		  hyperLinkColor  = FTUtilities.stringToColor(obj.GetAttribute(FTCxml.XML_HYPERLINKCOLOR))
		  hyperLinkColorRollover  = FTUtilities.stringToColor(obj.GetAttribute(FTCxml.XML_HYPERLINKCOLORROLLOVER))
		  hyperLinkColorVisited  = FTUtilities.stringToColor(obj.GetAttribute(FTCxml.XML_HYPERLINKCOLORVISITED))
		  hyperLinkColorDisabled  = FTUtilities.stringToColor(obj.GetAttribute(FTCxml.XML_HYPERLINKCOLORDISABLED))
		  
		  hasShadow = FTUtilities.stringToBoolean(obj.GetAttribute(FTCxml.XML_SHADOW))
		  shadowColor = FTUtilities.stringToColor(obj.GetAttribute(FTCxml.XML_SHADOW_COLOR),&c000000)
		  shadowBlur = Val(obj.GetAttribute(FTCxml.XML_SHADOW_BLUR))
		  shadowOffset = Val(obj.GetAttribute(FTCxml.XML_SHADOW_OFFSET))
		  shadowOpacity = Val(obj.GetAttribute(FTCxml.XML_SHADOW_OPACITY))
		  shadowAngle = Val(obj.GetAttribute(FTCxml.XML_SHADOW_ANGLE))
		  colorOpacity = Val(obj.GetAttribute(FTCxml.XML_TEXT_OPACITY))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub copy(fto as FTObject)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Copy the base object.
		  super.copy(fto)
		  
		  ' Copy over the data.
		  fto.endPosition = endPosition
		  fto.startPosition = startPosition
		  fto.backgroundColor = backgroundColor
		  fto.useBackgroundColorFlag = useBackgroundColorFlag
		  fto.id = id
		  fto.trimSide = trimSide
		  fto.markColor = markColor
		  fto.marked = marked
		  fto.strikeThrough = strikeThrough
		  fto.textColor = textColor
		  fto.underline = underline
		  fto.selectX = selectX
		  fto.selectY = selectY
		  fto.selectWidth = selectWidth
		  fto.selectHeight = selectHeight
		  
		  
		  fto.HyperLink = HyperLink
		  fto.hyperLinkColor = hyperLinkColor
		  fto.hyperLinkColorDisabled = hyperLinkColorDisabled
		  fto.hyperLinkColorRollover = hyperLinkColorRollover
		  fto.hyperLinkColorVisited = hyperLinkColorVisited
		  fto.inNewWindow = inNewWindow
		  fto.useCustomHyperLinkColor = useCustomHyperLinkColor
		  fto.noHyperlinkUlNormal = noHyperlinkUlNormal
		  fto.noHyperlinkUlRollover = noHyperlinkUlRollover
		  fto.noHyperlinkUlVisited = noHyperlinkUlVisited
		  fto.noHyperlinkUlDisabled = noHyperlinkUlDisabled
		  
		  
		  fto.colorOpacity = colorOpacity
		  fto.hasShadow = hasShadow
		  fto.shadowColor = shadowColor
		  fto.shadowBlur = shadowBlur
		  fto.shadowOffset = shadowOffset
		  fto.shadowAngle = shadowAngle
		  fto.shadowOpacity = shadowOpacity
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
		  strikeThrough = obj.strikeThrough
		  underline = obj.underline
		  if obj.useForegroundColor then changeColor(obj.textColor)
		  if obj.useBackgroundColor then changeBackgroundColor(obj.backgroundColor)
		  
		  ' Clear the caches.
		  reset
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub deleteLeft(startIndex as integer)
		  
		  #pragma unused startIndex
		  
		  ' Do nothing.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub deleteMid(startIndex as integer, endIndex as integer)
		  
		  #pragma unused startIndex
		  #pragma unused endIndex
		  
		  ' Do nothing.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub deleteRight(startIndex as integer)
		  
		  #pragma unused startIndex
		  
		  ' Do nothing.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub deleteText(offset as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  #pragma Unused offset
		  
		  ' Virtual method.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub drawBackground(g as graphics, x as integer, y as integer, leftPoint as integer, rightPoint as integer, lineTop as double, lineHeight as double, printing as boolean, printScale as double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Draw the background.
		  call paintBackground(g, x, y, leftPoint, rightPoint, lineTop, lineHeight, printing, printScale)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub drawBackgroundToPDF(g as PDFgraphics, x as integer, y as integer, leftPoint as integer, rightPoint as integer, lineTop as double, lineHeight as double, printScale as double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Draw the background.
		  Call paintBackground(g, x, y, leftPoint, rightPoint, lineTop, lineHeight, True, printScale)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub drawForeground(g as graphics, page as integer, x as integer, y as integer, leftPoint as integer, rightPoint as integer, beforeSpace as double, afterSpace as double, printing as boolean, printScale as double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Draw the object.
		  call paintForeground(g, x, y, _
		  leftPoint, rightPoint, beforeSpace, afterSpace, printing, printScale)
		  
		  ' Save the drawing coordinates.
		  lastDrawnPage = page
		  lastDrawnX = x
		  lastDrawnY = y
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub drawForegroundToPDF(g as graphics, page as integer, x as integer, y as integer, leftPoint as integer, rightPoint as integer, beforeSpace as double, afterSpace as double, printScale as double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Draw the object.
		  call paintForeground(g, x, y, _
		  leftPoint, rightPoint, beforeSpace, afterSpace, True, printScale)
		  
		  ' Save the drawing coordinates.
		  lastDrawnPage = page
		  lastDrawnX = x
		  lastDrawnY = y
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub drawHyperLink(size as Double, g as graphics, width as integer, x as integer, y as integer, printing as boolean, scale as double)
		  #If Not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim yPos as integer
		  Dim saveColor as Color
		  
		  ' Is there anything to draw?
		  if getLength = 0 then return
		  
		  ' Is this item underlined?
		  if Not noHyperlinkUlNormal AND HyperLink.lenb>0 then
		    
		    ' Is there anything to draw?
		    if width <= 0 then return
		    
		    ' Are we printing?
		    if printing then
		      
		      ' Set the pen height.
		      g.PenHeight = (size / 10) * 0.55 ' scale * 0.75
		      g.PenWidth = 1 * scale ' g.PenHeight
		      
		      ' Calculate where to draw the line.
		      ypos = y + (0.75 * scale) + (size / 10) ' y + (2 * scale)
		      
		    else
		      
		      ' Set the pen height.
		      g.PenHeight = (size / 10) * 0.55 ' 1
		      g.PenWidth = y + (0.75 * scale) + (size / 10) ' 1
		      
		      ' Calculate where to draw the line.
		      ypos = y + (0.75 * scale) + (size / 10) ' y + 1
		      
		    end if
		    
		    ' Save the current color.
		    saveColor = g.DrawingColor
		    
		    ' Set the underline line color.
		    if colorOpacity >0 then
		      dim c as color = me.getHyperLinkColor(0)
		      g.DrawingColor= RGB(c.Red,c.Green,c.Blue,colorOpacity/100 * 255)
		    else
		      g.DrawingColor = me.getHyperLinkColor(0)
		    end
		    
		    ' Draw the line.
		    g.FillRectangle(x, yPos, width, If(g.PenHeight < 1, 1 * scale, g.PenHeight))
		    
		    ' Restore the color.
		    g.DrawingColor = saveColor
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub drawMark(g as graphics, width as integer, x as integer, y as integer, printing as boolean, scale as double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  #pragma Unused scale
		  
		  Dim yPos as integer
		  Dim saveColor as Color
		  
		  ' Is there anything to draw?
		  if getLength = 0 then return
		  
		  ' Is this item marked?
		  if marked then
		    
		    ' Are we printing?
		    if printing then
		      
		      ' Set the pen height.
		      g.PenHeight = INDICATOR_HEIGHT * scale
		      g.PenWidth = g.PenHeight
		      
		      ' Calculate where to draw the line.
		      ypos = y + (INDICATOR_OFFSET * scale)
		      
		    else
		      
		      ' Set the pen height.
		      g.PenHeight = INDICATOR_HEIGHT
		      
		      ' Calculate where to draw the line.
		      ypos = y + INDICATOR_OFFSET
		      
		    end if
		    
		    ' Save the current color.
		    saveColor = g.DrawingColor
		    
		    ' Set the underline line color.
		    g.DrawingColor = markColor
		    
		    ' Draw the line.
		    g.DrawLine(x, yPos, x + width, yPos)
		    
		    ' Restore the color.
		    g.DrawingColor = saveColor
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub drawObjectBackground(g as graphics, x as integer, rightPoint as integer, lineTop as double, lineHeight as double, printing as boolean, printScale as double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim lineWidth as integer
		  Dim scale as double
		  
		  ' Should we draw the background color?
		  if not useBackgroundColor then return
		  
		  ' Get the scale.
		  scale = getObjectScale(printing, printScale)
		  
		  ' Get the whole text width.
		  lineWidth = getWidth(scale)
		  
		  ' Is this the end of the line?
		  if (x + lineWidth) > rightPoint then
		    
		    ' Limit the selection length.
		    lineWidth = rightPoint - x
		    
		  end if
		  
		  ' Make the selection visible if needed.
		  if lineWidth = 0 then lineWidth = BLANK_SPACE
		  
		  ' Set the color.
		  g.DrawingColor = getBackgroundColor
		  
		  ' Draw the background.
		  g.FillRectangle(x, lineTop, lineWidth, lineHeight)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub drawSelectedBackground(g as graphics, x as integer, rightPoint as integer, lineTop as double, lineHeight as double, printing as boolean)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim xPos as integer
		  Dim lineWidth as integer
		  Dim runWidth as integer
		  Dim selectStart as integer
		  Dim selectEnd as integer
		  Dim c as Color
		  Dim scale as double
		  
		  ' Are we printing?
		  if printing then return
		  
		  ' Is there anything selected?
		  if not isSelected then return
		  
		  ' Get the selection.
		  getSelection(selectStart, selectEnd)
		  
		  ' Get the scale.
		  scale = parentControl.getDisplayScale
		  
		  '--------------------------------------------
		  ' Make some calculations.
		  '--------------------------------------------
		  
		  ' Get the starting position.
		  If g IsA PDFGraphics Then
		    xPos = x + getWidth(PDFGraphics(g), 1, selectStart - 1, scale)
		  Else
		    xPos = x + getWidth(1, selectStart - 1, scale)
		  End If
		  
		  ' Is this an empty paragraph item?
		  if emptySelect then
		    
		    ' Use the default width.
		    lineWidth = BLANK_SPACE
		    
		  else
		    
		    ' Do we need a partial width?
		    if ((selectStart <> 1) or (selectEnd <> getLength)) then
		      
		      ' Get the partial text width.
		      If g IsA PDFGraphics Then
		        lineWidth = getWidth(PDFGraphics(g), selectStart, selectEnd, scale)
		      Else
		        lineWidth = getWidth(selectStart, selectEnd, scale)
		      End If
		    else
		      
		      ' Get the whole text width.
		      lineWidth = getWidth(scale)
		      
		    end if
		    
		    ' Make the width match the object background.
		    lineWidth = lineWidth + 1
		    
		    ' Is this the end of the line?
		    if (x + lineWidth) > rightPoint then
		      
		      ' Limit the selection length.
		      lineWidth = rightPoint - x
		      
		    end if
		    
		  end if
		  
		  '--------------------------------------------
		  ' Set the color.
		  '--------------------------------------------
		  
		  ' Are we in focus?
		  if parentControl.getFocusState then
		    
		    ' Set the in focus selection color.
		    g.DrawingColor = HighlightColor
		    
		  else
		    
		    ' Set the out of focus selection color.
		    g.DrawingColor = FTUtilities.OUT_OF_FOCUS_COLOR
		    
		  end if
		  
		  ' Should we make it darker?
		  if useBackgroundColor then
		    
		    ' Get the color.
		    c = g.DrawingColor
		    
		    ' Set the color.
		    g.DrawingColor = RGB(c.Red - HIGHLIGHT_COLOR_TINT, _
		    c.Green - HIGHLIGHT_COLOR_TINT, _
		    c.Blue - HIGHLIGHT_COLOR_TINT)
		    
		  end if
		  
		  '--------------------------------------------
		  ' Draw the selected background.
		  '--------------------------------------------
		  
		  #if TargetMacOS
		    
		    ' Is something real selected?
		    if not emptySelect then
		      
		      ' Calculate the theoretical selection length.
		      runWidth = getWidth(scale) - (xPos - x + 1) + 1
		      
		      ' On the Mac the string width can vary slightly depending
		      ' on the content, so we need to trim it.
		      lineWidth = Min(runWidth, lineWidth)
		      
		      ' Are we slightly short?
		      if lineWidth = (runWidth - 1) then
		        
		        ' Use fuzzy logic and bump it up.
		        lineWidth = runWidth
		        
		      end if
		      
		    end if
		    
		  #endif
		  
		  ' Save the dimensions.
		  saveSelectDimensions(xPos, lineTop, lineWidth, lineHeight)
		  
		  ' Draw the selection.
		  g.FillRectangle(selectX, selectY, selectWidth, selectHeight)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub drawStrikethrough(size as Double, g as graphics, width as integer, x as integer, y as integer, printing as boolean, scale as double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim yPos as integer
		  Dim saveColor as Color
		  
		  ' Is there anything to draw?
		  if getLength = 0 then return
		  
		  ' Should we draw the strike through line?
		  if strikeThrough then
		    
		    ' Are we printing?
		    If printing Then
		      
		      ' Set the pen height.
		      g.PenHeight = (size / 10) * 0.55 ' scale
		      g.PenWidth = 1 ' scale
		      
		    Else
		      
		      ' Set the pen height.
		      g.PenHeight = (size / 10) * 0.55 ' 1
		      
		    End If
		    
		    ' Calculate where to draw the line.
		    ypos = y - (getAscent(scale) / 3)
		    
		    ' Save the current color.
		    saveColor = g.DrawingColor
		    
		    ' Set the underline line color.
		    ' g.DrawingColor = textColor  //Removed.  Not setting it will make sure it uses the same opacity setting as our text
		    
		    ' Draw the strike through line.
		    g.FillRectangle(x, yPos, width, If(g.PenHeight < 1, 1 * scale, g.PenHeight))
		    
		    ' Restore the color.
		    g.DrawingColor = saveColor
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub drawUnderline(size as Double, g as graphics, width as integer, x as integer, y as integer, printing as boolean, scale as double)
		  
		  #If Not DebugBuild
		    
		    #Pragma BoundsChecking FTC_BOUNDSCHECKING
		    #Pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #Pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #EndIf
		  
		  Dim yPos As Integer
		  Dim saveColor As Color
		  
		  ' Is there anything to draw?
		  If getLength = 0 Then Return
		  
		  ' Is this item underlined?
		  If underline Then
		    
		    ' Is there anything to draw?
		    If width <= 0 Then Return
		    
		    ' Are we printing?
		    If printing Then
		      
		      ' Set the pen height.
		      g.PenHeight = (size / 10) * 0.55 // scale * 0.75
		      g.PenWidth = 1 * scale // g.PenHeight
		      
		      ' Calculate where to draw the line.
		      ypos = y + (0.75 * scale) + (size / 10) // y + (2 * scale)
		      
		    Else
		      
		      ' Set the pen height.
		      g.PenHeight = (size / 10) * 0.55 // g.PenHeight = 1
		      g.PenWidth = 1 * scale // g.PenWidth = 1
		      
		      ' Calculate where to draw the line.
		      ypos = y + (0.75 * scale) + (size / 10) // ypos = y + 1
		      
		    End If
		    
		    ' Save the current color.
		    saveColor = g.DrawingColor
		    
		    ' Set the underline line color.
		    ' g.DrawingColor = textColor  //Removed.  Not setting it will make sure it uses the same opacity setting as our text
		    
		    ' Draw the line.
		    g.FillRectangle(x, yPos, width, If(g.PenHeight < 1, 1 * scale, g.PenHeight))
		    
		    ' Restore the color.
		    g.DrawingColor = saveColor
		    
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub dump(sa() as string)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Position.
		  sa.Append("Start Position: " + str(startPosition))
		  sa.Append("End Position: " + str(endPosition))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getAscent(scale as double) As double
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the ascent of the object.
		  return Ascent(scale)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getBackgroundColor() As Color
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the background color.
		  Return backgroundColor
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub getBaseXML(xmlDoc as XmlDocument, node as XmlElement)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  #pragma Unused xmlDoc
		  
		  ' Was it set?
		  if useBackgroundColorFlag then
		    
		    ' Save the background color attributes.
		    node.SetAttribute(FTCxml.XML_BACKGROUND_COLOR, FTUtilities.colorToString(backgroundColor))
		    node.SetAttribute(FTCxml.XML_BACKGROUND_COLOR_DEFINED, FTUtilities.booleanToString(useBackgroundColorFlag))
		    
		  end if
		  
		  ' Load up the boolean node attributes.
		  if marked then node.SetAttribute(FTCxml.XML_MARKED, FTUtilities.booleanToString(marked))
		  if marked then node.SetAttribute(FTCxml.XML_MARK_COLOR, FTUtilities.colorToString(markColor))
		  if strikeThrough then node.SetAttribute(FTCxml.XML_STRIKE_THROUGH, FTUtilities.booleanToString(strikeThrough))
		  if textColor <> &c000000 then node.SetAttribute(FTCxml.XML_TEXT_COLOR, FTUtilities.colorToString(textColor))
		  if underline then node.SetAttribute(FTCxml.XML_UNDERLINE, FTUtilities.booleanToString(underline))
		  
		  if HyperLink.lenb>0 then
		    node.SetAttribute(FTCxml.XML_HYPERLINK,HyperLink)
		    node.SetAttribute(FTCxml.XML_HYPERLINKCOLOR,FTUtilities.colorToString(HyperLinkColor))
		    node.SetAttribute(FTCxml.XML_HYPERLINKCOLORROLLOVER,FTUtilities.colorToString(hyperLinkColorRollover))
		    node.SetAttribute(FTCxml.XML_HYPERLINKCOLORVISITED,FTUtilities.colorToString(hyperLinkColorVisited))
		    node.SetAttribute(FTCxml.XML_HYPERLINKCOLORDISABLED,FTUtilities.colorToString(hyperLinkColorDisabled))
		    
		    
		    node.SetAttribute(FTCxml.XML_HYPERLINKULNORMAL,FTUtilities.booleanToString(noHyperlinkUlNormal))
		    node.SetAttribute(FTCxml.XML_HYPERLINKULROLLOVER,FTUtilities.booleanToString(noHyperlinkUlRollover))
		    node.SetAttribute(FTCxml.XML_HYPERLINKULVISITED,FTUtilities.booleanToString(noHyperlinkUlVisited))
		    node.SetAttribute(FTCxml.XML_HYPERLINKULDISABLED,FTUtilities.booleanToString(noHyperlinkUlDisabled))
		  end
		  
		  node.SetAttribute(FTCxml.XML_TEXT_OPACITY,str(colorOpacity))
		  if hasShadow then
		    NODE.SetAttribute(FTCxml.XML_SHADOW,FTUtilities.booleanToString(hasShadow))
		    NODE.SetAttribute(FTCxml.XML_SHADOW_COLOR,FTUtilities.colorToString(shadowColor))
		    NODE.SetAttribute(FTCxml.XML_SHADOW_BLUR,Str(shadowBlur))
		    NODE.SetAttribute(FTCxml.XML_SHADOW_OFFSET,Str(shadowOffset))
		    NODE.SetAttribute(FTCxml.XML_SHADOW_OPACITY,Str(shadowOpacity))
		    NODE.SetAttribute(FTCxml.XML_SHADOW_ANGLE,Str(shadowAngle))
		  end
		  
		  ' Get the tag data.
		  super.getXMLTagData(node)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getCharacter(index as integer) As string
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  #pragma Unused index
		  
		  ' Default to nothing.
		  return "@"
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getDescent(scale as double) As double
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the descent.
		  return getHeight(scale) - getAscent(scale)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getEndPosition() As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the end position.
		  return endPosition
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getHeight(scale as double) As double
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the height of the object.
		  return Height(scale)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getHyperLinkColor(State As Integer) As Color
		  //Do we want to use custom hyperlink colors?
		  if useCustomHyperLinkColor then
		    select case state
		    case 0
		      Return me.hyperLinkColor
		    case 1
		      Return me.hyperLinkColorRollover
		    case 2
		      Return me.hyperLinkColorVisited
		    case 3
		      Return me.hyperLinkColorDisabled
		      
		    end select
		    
		    
		  else
		    
		    select case state
		    case 0
		      Return parentControl.defaultHyperLinkColor
		    case 1
		      Return parentControl.defaultHyperLinkColorRollover
		    case 2
		      Return parentControl.defaultHyperLinkColorVisited
		    case 3
		      Return parentControl.defaultHyperLinkColorDisabled
		      
		    end select
		    
		  end
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub getHyperLinkColorAndUnderline(byref mhyperlinkColor As Color, byref mhyperlinkColorRollover As Color, byref mhyperlinkColorVisited As Color, byref mhyperLinkColorDisabled As Color, byref ulNormal As Boolean, byref ulRollover As Boolean, byref ulVisited as Boolean, byref ulDisabled as Boolean)
		  mhyperLinkColor = hyperLinkColor
		  mhyperlinkColorRollover = hyperLinkColorRollover
		  mhyperlinkColorVisited = hyperLinkColorVisited
		  mhyperLinkColorDisabled = hyperLinkColorDisabled
		  
		  ulNormal = not noHyperlinkUlNormal
		  ulRollover = not noHyperlinkUlRollover
		  ulVisited = not noHyperlinkUlVisited
		  ulDisabled = not noHyperlinkUlDisabled
		End Sub
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
		Sub getLastDrawnCoordinates(ByRef page as integer, ByRef x as integer, ByRef y as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the coordinates.
		  page = lastDrawnPage
		  x = lastDrawnX
		  y = lastDrawnY
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getLength() As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Default to one unit.
		  return 1
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getObjectColor() As color
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim c as Color
		  
		  ' Are we in focus?
		  if parentControl.getFocusState then
		    
		    ' Set the in focus selection color.
		    c = HighlightColor
		    
		  else
		    
		    ' Set the out of focus selection color.
		    c = FTUtilities.OUT_OF_FOCUS_COLOR
		    
		  end if
		  
		  ' Should we make it darker?
		  if useBackgroundColor then
		    
		    ' Are we in focus?
		    if parentControl.getFocusState then
		      
		      ' Set the in focus selection color.
		      c = HighlightColor
		      
		    else
		      
		      ' Set the out of focus selection color.
		      c = FTUtilities.OUT_OF_FOCUS_COLOR
		      
		    end if
		    
		    ' Set the color.
		    c = RGB(c.Red - HIGHLIGHT_COLOR_TINT, _
		    c.Green - HIGHLIGHT_COLOR_TINT, _
		    c.Blue - HIGHLIGHT_COLOR_TINT)
		    
		  end if
		  
		  ' Return the color.
		  return c
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getObjectScale(printing as boolean, printScale as double) As double
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Are we printing?
		  if printing then
		    
		    ' Use the print scale.
		    return printScale
		    
		  else
		    
		    ' Get the display scale.
		    return parentControl.getDisplayScale
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getParagraph() As FTParagraph
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Default to nothing.
		  return paragraph
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getRTF(startPosition as integer, endPosition as integer) As string
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  #pragma Unused startPosition
		  #pragma Unused endPosition
		  
		  ' Default to nothing.
		  return ""
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub getRTF(rtf as RTFWriter)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Add the base attributes.
		  if useBackgroundColor then rtf.setBackgroundColor(backgroundColor)
		  if strikeThrough then rtf.setStrikeThrough
		  if underline then rtf.setUnderline
		  if (TextColor.Red  <> 0) or (TextColor.Green  <> 0) or _
		  (TextColor.Blue  <> 0) then rtf.setForegroundColor(TextColor)
		  
		  If hasShadow Then
		    rtf.setShadow
		    rtf.setShadowColor(shadowColor)
		    rtf.setShadowBlur(shadowBlur)
		    rtf.setShadowOffset(shadowOffset)
		    rtf.setShadowOpacity(shadowOpacity)
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub getSelection(ByRef selectStart as integer, ByRef selectEnd as Integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim index as integer
		  Dim so as FTInsertionOffset
		  Dim eo as FTInsertionOffset
		  Dim startOffset as integer
		  Dim endOffset as integer
		  
		  ' Set default values.
		  selectStart = -1
		  selectEnd = -1
		  emptySelect = false
		  
		  ' Get the current selection range.
		  parentControl.getDoc.getSelectionRange(so, eo)
		  
		  ' Make them one based.
		  startOffset = so.offset + 1
		  endOffset = eo.offset
		  
		  ' Get the paragraph index.
		  index = paragraph.getAbsoluteIndex
		  
		  ' Are we in the selction range?
		  if (index >= so.paragraph) and (index <= eo.paragraph) then
		    
		    ' Is this an empty paragraph?
		    if paragraph.getLength = 0 then
		      
		      ' Set up for an empty paragraph selection.
		      emptySelect = true
		      
		      ' We are done.
		      return
		      
		    end if
		    
		    ' Is the whole paragraph selected?
		    if (index > so.paragraph) and (index < eo.paragraph) then
		      
		      ' Use the entire run.
		      selectStart = 1
		      selectEnd = getLength
		      
		      ' Are we selected in only a single paragraph?
		    elseif so.paragraph = eo.paragraph then
		      
		      ' Are we within this run?
		      if ((startOffset <= startPosition) and (endOffset >= endPosition)) or _
		        ((startOffset >= startPosition) and (startOffset <= endPosition)) or _
		        ((endOffset >= startPosition) and (endOffset <= endPosition)) then
		        
		        ' Calucate the selected text within the run.
		        selectStart = startOffset - startPosition + 1
		        selectEnd = endOffset - startPosition + 1
		        
		      end if
		      
		      ' Is this run in the starting paragraph?
		    elseif index = so.paragraph then
		      
		      ' Use the starting point to the end of the run.
		      selectStart = startOffset - startPosition + 1
		      selectEnd = getLength
		      
		    else
		      
		      ' Use the beginning of the run to the end of the selection.
		      selectStart = 1
		      selectEnd = endOffset - startPosition + 1
		      
		    end if
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub getSelectionDimensions(ByRef x as integer, ByRef y as integer, ByRef width as integer, ByRef height as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the selection dimensions.
		  x = selectX
		  y = selectY
		  width = selectWidth
		  height = selectHeight
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getStartPosition() As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the starting position.
		  return startPosition
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getText(showPictures as boolean = false) As string
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' How should we represent non text?
		  if showPictures then
		    
		    ' Default to a null character.
		    return Chr(0)
		    
		  else
		    
		    ' Default to a space.
		    return " "
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getText(startPosition as integer, endPosition as integer) As string
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  #pragma Unused startPosition
		  #pragma Unused endPosition
		  
		  ' Default to nothing.
		  return " "
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getTrimSide() As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the side to trim white space from.
		  return trimSide
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getWidth(scale as double, currentWidth as double = 0.0) As double
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the width of the object.
		  return Width(scale, currentWidth)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getWidth(startIndex as integer, endIndex as integer, scale as double = 1.0, currentWidth as double = 0.0) As double
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the partial width of the object.
		  Return partialWidth(startIndex, endIndex, scale, currentWidth)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getWidth(g as PDFgraphics, scale as double, currentWidth as double = 0.0) As double
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the width of the object.
		  return WidthPDF(g, scale, currentWidth)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getWidth(g as PDFgraphics, startIndex as integer, endIndex as integer, scale as double = 1.0, currentWidth as double = 0.0) As double
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the partial width of the object.
		  return PartialWidthPDF(g, startIndex, endIndex, scale, currentWidth)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub getXML(xmlDoc as XmlDocument, paragraph as XmlElement)
		  
		  #pragma Unused xmlDoc
		  #pragma Unused paragraph
		  
		  ' Virtual.
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function hasLines() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Are there any lines in this run?
		  return underline or strikeThrough or marked
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub insertText(offset as integer, s as string)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  #pragma Unused offset
		  #pragma Unused s
		  
		  ' Virtual method.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isEmpty(includeSpace as boolean) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  #pragma Unused includeSpace
		  
		  ' Default value.
		  return false
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isFirstPositionSelected() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim selectStart as integer
		  Dim selectEnd as integer
		  
		  ' Get the selection.
		  getSelection(selectStart, selectEnd)
		  
		  ' Is the first position selected?
		  return (selectStart = 1)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isLastPositionSelected() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim selectStart as integer
		  Dim selectEnd as integer
		  
		  ' Get the selection.
		  getSelection(selectStart, selectEnd)
		  
		  ' Is the last position selected?
		  return (selectEnd >= getLength)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isMonolithic() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Assume it is one big thing.
		  return true
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isResizable() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the default value.
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
		  
		  #pragma Unused obj
		  
		  ' Default value.
		  return true
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isSelected() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim index as integer
		  Dim so as FTInsertionOffset
		  Dim eo as FTInsertionOffset
		  Dim startOffset as integer
		  Dim endOffset as integer
		  
		  ' Get the current selection range.
		  parentControl.getDoc.getSelectionRange(so, eo)
		  
		  ' Is anything selected?
		  if so = eo then return false
		  
		  ' Make them one based.
		  startOffset = so.offset + 1
		  endOffset = eo.offset
		  
		  ' Get our paragraph index.
		  index = paragraph.getAbsoluteIndex
		  
		  ' Are we in the selection range?
		  if (index >= so.paragraph) and (index <= eo.paragraph) then
		    
		    ' Is the entire paragraph selected?
		    if (index > so.paragraph) and (index < eo.paragraph) then
		      
		      if index = 0 then break
		      
		      ' No further checking needed.
		      return true
		      
		      ' Is only one paragraph selected?
		    elseif so.paragraph = eo.paragraph then
		      
		      ' Are we in the selected range?
		      return ((startOffset < startPosition) and (endOffset > endPosition)) or _
		      ((startOffset >= startPosition) and (startOffset <= endPosition)) or _
		      ((endOffset >= startPosition) and (endOffset <= endPosition))
		      
		      ' Is this the beginning paragraph?
		    elseif index = so.paragraph then
		      
		      if getLength = 0 then return true
		      
		      ' Does the start of the selection fall in this run?
		      return (startOffset <= endPosition)
		      
		    else
		      
		      if getLength = 0 then return true
		      
		      ' Does the end of the selection fall past the start of this run?
		      return (endOffset >= startPosition)
		      
		    end if
		    
		  end if
		  
		  ' Not selected.
		  return false
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub removeHyperlinks()
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  '' Assign our hyperlink
		  hyperLink = ""
		  
		  //set our link colors to default
		  hyperLinkColor = parentControl.defaultHyperLinkColor
		  hyperLinkColorDisabled = parentControl.defaultHyperLinkColorDisabled
		  hyperLinkColorRollover= parentControl.defaultHyperLinkColorRollover
		  hyperLinkColorVisited = parentControl.defaultHyperLinkColorVisited
		  useCustomHyperLinkColor = FALSE
		  noHyperlinkUlNormal = FALSE
		  noHyperlinkUlRollover = FALSE
		  noHyperlinkUlVisited = FALSE
		  noHyperlinkUlDisabled = FALSE
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub reset()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Virtual method.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub saveSelectDimensions(x as integer, y as integer, width as integer, height as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the dimensions.
		  selectX = x
		  selectY = y
		  selectWidth = width
		  selectHeight = height
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function seekEndPosition(startPosition as integer, width as integer) As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  #pragma Unused startPosition
		  #pragma Unused width
		  
		  ' Return the default value.
		  return 0
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setParagraph(p as FTParagraph)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the reference.
		  paragraph = p
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setPosition(startPosition as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set the starting position.
		  me.startPosition = startPosition
		  
		  ' Set the end position.
		  me.endPosition = startPosition + getLength - 1
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setTrimSide(trimSide as integer = 0)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set the trim for the object.
		  me.trimSide = trimSide
		  
		  ' Reset the object.
		  reset
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub updateWithStyle(style as FTCharacterStyle)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Has the background color been defined?
		  // Mantis 3637: FTCParagraphStyle.backgroundColor won’t set correctly
		  If style.isBackgroundColorDefined And Not style IsA FTParagraphStyle Then
		    
		    ' Set the color.
		    changeBackgroundColor(style.getBackgroundColor)
		    
		  End If
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function useBackgroundColor() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the flag.
		  return useBackgroundColorFlag
		  
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Ascent(scale as double) As double
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ConstructContextualMenu(base as DesktopMenuItem, x as integer, y as integer) As boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ContextualMenuAction(selectedItem As DesktopMenuItem) As boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Height(scale as double) As double
	#tag EndHook

	#tag Hook, Flags = &h0
		Event PaintBackground(g as graphics, x as integer, y as integer, leftPoint as integer, rightPoint as integer, lineTop as double, lineHeight as double, printing as boolean, printScale as double)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event PaintForeground(g as graphics, x as integer, y as integer, leftPoint as integer, rightPoint as integer, beforeSpace as double, afterSpace as double, printing as boolean, printScale as double)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event PartialWidth(startIndex as integer, endIndex as integer, scale as double, startPosition as double) As double
	#tag EndHook

	#tag Hook, Flags = &h0
		Event PartialWidthPDF(g as PDFgraphics, startIndex as integer, endIndex as integer, scale as double, startPosition as double) As double
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ScaleChanged()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Width(scale as double, startPosition as double) As double
	#tag EndHook

	#tag Hook, Flags = &h0
		Event WidthPDF(g as PDFgraphics, scale as double, startPosition as double) As double
	#tag EndHook


	#tag Property, Flags = &h21
		Private backgroundColor As Color = &cFFFFFF
	#tag EndProperty

	#tag Property, Flags = &h0
		colorOpacity As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private emptySelect As boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private endPosition As integer
	#tag EndProperty

	#tag Property, Flags = &h0
		hasShadow As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			- stores a hyper link
		#tag EndNote
		HyperLink As String
	#tag EndProperty

	#tag Property, Flags = &h0
		hyperLinkColor As color = &c0000ff
	#tag EndProperty

	#tag Property, Flags = &h0
		hyperLinkColorDisabled As color = &cC0C0C0
	#tag EndProperty

	#tag Property, Flags = &h0
		hyperLinkColorRollover As color = &cFF0000
	#tag EndProperty

	#tag Property, Flags = &h0
		hyperLinkColorVisited As color = &c800080
	#tag EndProperty

	#tag Property, Flags = &h21
		Private id As integer
	#tag EndProperty

	#tag Property, Flags = &h0
		inNewWindow As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private lastDrawnPage As integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private lastDrawnX As Integer = -11
	#tag EndProperty

	#tag Property, Flags = &h21
		Private lastDrawnY As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		markColor As Color
	#tag EndProperty

	#tag Property, Flags = &h0
		marked As boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected noHyperlinkUlDisabled As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected noHyperlinkUlNormal As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected noHyperlinkUlRollover As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected noHyperlinkUlVisited As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected paragraph As FTParagraph
	#tag EndProperty

	#tag Property, Flags = &h21
		Private selectHeight As integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private selectWidth As integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private selectX As integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private selectY As integer
	#tag EndProperty

	#tag Property, Flags = &h0
		shadowAngle As double
	#tag EndProperty

	#tag Property, Flags = &h0
		shadowBlur As Double
	#tag EndProperty

	#tag Property, Flags = &h0
		shadowColor As Color = &c000000
	#tag EndProperty

	#tag Property, Flags = &h0
		shadowOffset As Double
	#tag EndProperty

	#tag Property, Flags = &h0
		shadowOpacity As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private startPosition As integer
	#tag EndProperty

	#tag Property, Flags = &h0
		strikeThrough As boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		textColor As color
	#tag EndProperty

	#tag Property, Flags = &h21
		Private trimSide As integer
	#tag EndProperty

	#tag Property, Flags = &h0
		underline As boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private useBackgroundColorFlag As boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		useCustomHyperLinkColor As Boolean
	#tag EndProperty


	#tag Constant, Name = BLANK_SPACE, Type = Double, Dynamic = False, Default = \"5", Scope = Public
	#tag EndConstant

	#tag Constant, Name = HIGHLIGHT_COLOR_TINT, Type = Double, Dynamic = False, Default = \"50", Scope = Public
	#tag EndConstant

	#tag Constant, Name = INDICATOR_HEIGHT, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = INDICATOR_OFFSET, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = PRINT_LINE_HEIGHT, Type = Double, Dynamic = False, Default = \"10", Scope = Public
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="colorOpacity"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
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
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
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
	#tag EndViewBehavior
End Class
#tag EndClass
