#tag Class
Protected Class FTParagraphProxy
Inherits FTBase
	#tag Method, Flags = &h0
		Sub audit()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Does the parent exist?
		  if parent is nil then break
		  
		  ' Do we have a bad proxy?
		  if lineEnd < lineStart then break
		  
		  ' Is the page in range?
		  if (page < 0) or (page > (doc.getNumberOfPages - 1)) then break
		  
		  ' Is the end line passed the end?
		  if lineEnd > (parent.getLineCount - 1) then break
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub clear()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim p as FTPage
		  
		  ' Does the parent exist?
		  if not (parent is nil) then
		    
		    ' Remove it from the parent.
		    parent.removeProxy(id)
		    
		  end if
		  
		  ' Get the page.
		  p = doc.getPage(page)
		  
		  ' Did we get the page?
		  if not (p is nil) then
		    
		    ' Remove the proxy from the page.
		    p.removeProxy(id)
		    
		  end if
		  
		  ' Break the link.
		  parent = nil
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(parentControl as FormattedText, parent as FTParagraph, page as integer, lineStart as integer, lineEnd as integer, composePosition as double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the parent control.
		  super.Constructor(parentControl)
		  
		  ' Save the parent references.
		  me.parent = parent
		  
		  ' Was the page specified?
		  if page >= 0 then
		    
		    ' Save the page number.
		    me.page = page
		    
		  end if
		  
		  ' Save the display range.
		  me.lineStart = lineStart
		  me.lineEnd = lineEnd
		  
		  ' Save the composition position.
		  me.composePosition = composePosition
		  
		  ' Create an new ID.
		  me.id = FTUtilities.getNewID
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function containsPicture(pic as FTPicture) As boolean
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim line as FTLine
		  
		  ' Scan the page for the picture.
		  for i = lineStart to lineEnd
		    
		    ' Get a line.
		    line = parent.getLine(i)
		    
		    ' Is this the one we are looking for?
		    if line.containsPicture(pic) then
		      
		      ' We found it.
		      return true
		      
		    end if
		    
		  next
		  
		  ' Not found.
		  return false
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub drawBackground(g as graphics, x as integer, y as integer, printing as boolean, printScale as double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim scale as double
		  Dim width as integer
		  
		  ' Is this a non-white background?
		  if parent.getBackgroundColor <> &cFFFFFF then
		    
		    ' Set the background color.
		    g.ForeColor = parent.getBackgroundColor
		    
		    ' Are we printing?
		    if printing then
		      
		      ' Get the scale.
		      scale = printScale
		      
		    else
		      
		      ' Get the scale.
		      scale = parentControl.getDisplayScale
		      
		    end if
		    
		    ' Are we in single line mode?
		    if parentControl.isSingleViewMode then
		      
		      ' Use the entire width of the display.
		      x = parent.doc.getLeftMarginWidth
		      width = parentControl.getDisplayWidth
		      
		    else
		      
		      ' User the paragraph wrap width.
		      width = parent.getWrapWidth
		      
		    end if
		    
		    // Mantis Ticket 3917: Paragraphs Background Color ignores Hanging Indent
		    
		    ' Check for hanging indent.
		    If parent.getFirstIndent < 0 Then
		      
		      ' Get the hanging indent.
		      Dim firstIndent As Double = parent.getFirstIndent * 72
		      
		      ' Set new start position.
		      x = x + (firstIndent * scale)
		      
		      ' Update width (negativ to positive value using Abs function).
		      width = width + Abs(firstIndent)
		      
		    End If
		    
		    ' Draw the background color.
		    if parentControl.WordParagraphBackground then
		      
		      // Mantis Ticket 3750: Suggestion & comparison of the Office applications for the display optimization of the paragraph background color
		      // Mantis Ticket 3914: First Paragraph on Page with Background Color ignores Before Space
		      Dim beforeSpace As Double = parent.getBeforeParagraphSpaceLength * scale
		      Dim afterSpace As Double = parent.getAfterParagraphSpaceLength * scale
		      
		      g.FillRect(x, y + If(isFirstParagraphOnPage, 0, beforeSpace), _
		      width * scale, getHeight(False, scale) - If(isLastParagraphOnPage, 0, afterSpace))
		      
		    else
		      
		      // old way how FTC drawn Paragraph Background color
		      g.FillRect(x, y, width * scale, getHeight(drawBeforeSpace, scale))
		      
		    end if
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub drawInsertionPoint(g as graphics, xCaret as double, yCaret as double, rightLength as double, insertionPoint as FTInsertionPoint)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim xOffset as double
		  Dim yOffset as double
		  Dim caretAscent as double
		  Dim caretDescent as double
		  
		  ' Are we in the read only mode?
		  if parentControl.readOnly then return
		  
		  ' Are we printing?
		  if insertionPoint is nil then return
		  
		  ' Are we in resize mode?
		  if doc.isInResizeMode then return
		  
		  if not parentControl.getFocusState then
		    return
		  end if
		  
		  if insertionPoint.getCurrentProxyParagraph.getProxyId <> id then
		    return
		  end if
		  
		  if parentControl.getDoc.isSelected then
		    return
		  end if
		  
		  
		  
		  ' Find the location where to draw it.
		  parent.getInsertionPoint(lineStart, insertionPoint, xOffset, yOffset, caretAscent, caretDescent)
		  
		  ' Add in the offsets.
		  xCaret = xCaret + xOffset - 1
		  yCaret = yCaret + yOffset
		  
		  ' Is the caret positioned past the right edge?
		  if xCaret > (rightlength - 1) then
		    
		    ' Move it back to the right edge.
		    xCaret = rightlength - 1
		  end if
		  
		  ' Save the caret position because the Text Input Canvas might need it for other operations
		  Parent.parentControl.TIC_xCaret = xCaret
		  Parent.parentControl.TIC_yCaret = yCaret - caretAscent
		  
		  ' Do we need to draw the insertion caret?
		  if insertionPoint.getCaretState then
		    
		    ' Set the drawing characteristics.
		    g.ForeColor = parentControl.CaretColor
		    if parentControl.IsHiDPT then
		      g.PenHeight = 2
		      g.PenWidth = 2
		    else
		      g.PenHeight = 1
		      g.PenWidth = 1
		    end
		    
		    ' Draw the insertion caret.
		    g.drawLine(xCaret, yCaret + caretDescent  , xCaret, yCaret - caretAscent)
		    
		  end if
		  
		  'check to see if we're positioned at the end of a line
		  dim lineIndex, offsetIndex as integer
		  parent.findLine(lineStart, insertionPoint.getOffset.offset, insertionPoint.getOffset.bias, lineIndex, offsetIndex)
		  
		  if lineIndex<0 or lineIndex>=parent.getLineCount then
		    return
		  end if
		  
		  dim oLine as FTLine = parent.getLine(lineIndex)
		  
		  dim iLineOffset as integer = insertionPoint.getOffset.offset - oLine.getParagraphOffset + 1
		  
		  dim bEndOfLine as boolean = (iLineOffset>=oLine.getLength)
		  
		  if parentControl.AutoComplete and bEndOfLine then
		    dim sPrefix as string
		    dim arsOption() as string
		    
		    parentControl.getAutoCompleteOptions(sPrefix, arsOption)
		    
		    if arsOption.Ubound>=0 then
		      g.ForeColor = &c666666
		      g.DrawString("...", xCaret, yCaret)
		    end if
		    
		  end if
		  
		  if parentControl<>nil then
		    if parentControl.IsHiDPT then
		      parentControl.PositionAutoCompleteWindow(xCaret * .5, yCaret * .5 - caretAscent)
		    else
		      parentControl.PositionAutoCompleteWindow(xCaret, yCaret - caretAscent)
		    end
		  end if
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function drawLines(g as graphics, y as double, printing as boolean, printScale as double, insertionPoint as FTInsertionPoint) As integer
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim scale as double
		  Dim shiftedX as double
		  Dim lineLength as double
		  Dim wrapLength as double
		  Dim rightlength as double
		  Dim leftlength as double
		  Dim firstLength as double
		  Dim xCaret as double
		  Dim yCaret as double
		  Dim proxyHeight as integer
		  Dim lineHeight as integer
		  Dim endOfDoc as boolean
		  
		  ' Is there anything to do?
		  if parent.getLineCount = 0 then return 0
		  
		  '----------------------------------------------
		  ' Precalculate some values.
		  '----------------------------------------------
		  
		  ' Is this the last paragraph?
		  endOfDoc = (parent.getAbsoluteIndex = (doc.getParagraphCount - 1))
		  
		  ' Are we printing?
		  if printing then
		    
		    ' Use the print scale.
		    scale = printScale
		    
		  else
		    
		    ' Get the display scale.
		    scale = parentControl.getDisplayScale
		    
		  end if
		  
		  ' Calculate the lengths.
		  leftlength = (doc.getLeftMarginWidth + parent.getLeftMarginWidth) * scale
		  
		  ' Are we in the normal or single view mode?
		  if parentControl.isNormalViewMode or _
		    parentControl.isSingleViewMode then
		    
		    ' Add in the horizontal offset.
		    leftlength = leftlength + parentControl.getXDisplayPosition
		    
		  end if
		  
		  ' First length.
		  firstLength = parent.getFirstIndentWidth(scale)
		  
		  ' Right length.
		  rightlength = (doc.getPageWidthLength - doc.getRightMarginWidth) * scale
		  
		  ' Wrap length.
		  wrapLength = parent.getWrapWidth * scale
		  
		  ' Set the position of the paragraph.
		  setXPosition(leftlength)
		  
		  ' Are we in page view mode?
		  if parentControl.isPageViewMode then
		    
		    ' Save the Y position.
		    setYPosition(y)
		    
		  end if
		  
		  ' Are there any lines to draw.
		  if lineEnd >= lineStart then
		    
		    ' Draw the background color.
		    drawBackground(g, xPos, y, printing, printScale)
		    
		  end if
		  
		  ' Set the position of the top left corner of the paragraph.
		  xCaret = leftlength + 1
		  
		  // Mantis Ticket 3805: Wrong Caret y-Position in FTParagraph with BeforeSpace if Paragraph (continued Paragraph) breaks into two of more pages
		  // Mantis Ticket 3821: Wrong y-Caret Position in very last FTParagraph if BeforeSpace > 0
		  yCaret = y + parent.getLine(lineStart).getAscent(scale) _
		  - If(Me.getAbsolutePage > 0, parent.getBeforeParagraphSpaceLength * scale, 0) _
		  + If(Me.getAbsolutePage = 0, 0, parent.getBeforeParagraphSpaceLength * scale)
		  
		  '----------------------------------------------
		  ' Draw the lines.
		  '----------------------------------------------
		  
		  ' Are there any lines to draw?
		  if parent.getLineCount > 0 then
		    
		    select case parent.getAlignment
		      
		    case FTParagraph.Alignment_Type.Left
		      
		      ' Draw the content.
		      for i = lineStart to lineEnd
		        
		        ' Draw the item.
		        lineHeight = parent.getLine(i).draw(self, g, drawBeforeSpace, firstLength, _
		        page, leftlength, y, leftLength, rightLength, FTParagraph.Alignment_Type.Left, _
		        printing, printScale, endOfDoc, parent.selectPilcrow)
		        
		        ' Move to the next line.
		        y = y + lineHeight
		        
		        ' Add in the line height.
		        proxyHeight = proxyHeight + lineHeight
		        
		      next
		      
		      '---------------------
		      
		    case FTParagraph.Alignment_Type.Center
		      
		      ' Draw the content.
		      for i = lineStart to lineEnd
		        
		        ' Get the length of the line.
		        lineLength = parent.getLine(i).getWidth(scale)
		        
		        ' Is this the first line?
		        if i = lineStart then
		          
		          ' Center aligned.
		          shiftedX = (leftlength + firstLength) + _
		          (((wrapLength - firstLength) - lineLength) / 2)
		          
		        else
		          
		          ' Center aligned.
		          shiftedX = leftlength + ((wrapLength - lineLength) / 2)
		          
		        end if
		        
		        ' Are past the left margin?
		        if shiftedX < leftlength then shiftedX = leftlength
		        
		        ' Draw the item.
		        lineHeight = parent.getLine(i).draw(self, g, drawBeforeSpace, firstLength, _
		        page, shiftedX, y, leftLength, rightLength, FTParagraph.Alignment_Type.Center, _
		        printing, printScale, endOfDoc, parent.selectPilcrow)
		        
		        ' Move to the next line.
		        y = y + lineHeight
		        
		        ' Add in the line height.
		        proxyHeight = proxyHeight + lineHeight
		        
		      next
		      
		      '---------------------
		      
		    case FTParagraph.Alignment_Type.Right
		      
		      ' Draw the content.
		      for i = lineStart to lineEnd
		        
		        ' Get the length of the line.
		        lineLength = parent.getLine(i).getWidth(scale)
		        
		        ' Right aligned.
		        shiftedX = leftlength + (wrapLength - lineLength)
		        
		        ' Draw the item.
		        lineHeight = parent.getLine(i).draw(self, g, drawBeforeSpace, firstLength, _
		        page, shiftedX, y, leftLength, rightLength, FTParagraph.Alignment_Type.Right, _
		        printing, printScale, endOfDoc, parent.selectPilcrow)
		        
		        ' Move to the next line.
		        y = y + lineHeight
		        
		        ' Add in the line height.
		        proxyHeight = proxyHeight + lineHeight
		        
		      next
		      
		    end select
		    
		    ' Draw the insertion point.
		    drawInsertionPoint(g, xCaret, yCaret, rightLength, insertionPoint)
		    
		  end if
		  
		  ' Return the height of the proxy.
		  return proxyHeight
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function drawNormalView(g as graphics, drawBeforeSpace as boolean, y as double, insertionPoint as FTInsertionPoint) As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the space before state.
		  me.drawBeforeSpace = drawBeforeSpace
		  
		  ' Draw the lines.
		  return drawLines(g, y, false, 1.0, insertionPoint)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function drawPageView(g as graphics, drawBeforeSpace as boolean, y as double, insertionPoint as FTInsertionPoint, printing as boolean, printScale as double) As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the space before state.
		  me.drawBeforeSpace = drawBeforeSpace
		  
		  ' Draw the lines.
		  return drawLines(g, y, printing, printScale, insertionPoint)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function findLineHeightToOffset(targetOffset as integer, previousLine as boolean, scale as double) As double
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim currentOffset as integer
		  Dim lastOffset as integer
		  Dim currentHeight as double
		  Dim previousHeight as double
		  Dim ftl as FTLine
		  
		  ' Scan for the offset.
		  for i = lineStart to lineEnd
		    
		    ' Get a line.
		    ftl = parent.getLine(i)
		    
		    ' Add in the length of the line.
		    currentOffset = currentOffset + ftl.getLength
		    
		    ' Save the previous height.
		    previousHeight = currentHeight
		    
		    ' Add in the height of the line.
		    currentHeight = currentHeight + (ftl.getHeight * scale)
		    
		    ' Is this the line we are looking for?
		    if (targetOffset >= lastOffset) and (targetOffset < currentOffset) then
		      
		      ' We are done.
		      exit
		      
		    end if
		    
		    ' Save the offset.
		    lastOffset = currentOffset
		    
		  next
		  
		  ' Should we return the previous line height?
		  if previousLine then
		    
		    ' Return the previous height.
		    return previousHeight
		    
		  else
		    
		    ' Return the height.
		    return currentHeight
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function findOffset(x as integer, y as integer, lineStart as integer = 0, lineEnd as integer = - 1, ByRef bias as boolean) As integer
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim currentHeight as integer
		  Dim offset as integer
		  Dim ftl as FTLine
		  Dim adjustedX as integer
		  Dim scale as double
		  
		  '--------------------------------------------
		  ' Set up some values.
		  '--------------------------------------------
		  
		  ' Assume no bias.
		  bias = false
		  
		  ' Is the point beyond the end of the paragraph?
		  if isPointAfterParagraph(drawBeforeSpace, y) then
		    
		    ' Get the last line.
		    ftl = parent.getLine(parent.getLineCount - 1)
		    
		    ' Use the end offset.
		    return ftl.getParagraphOffset + ftl.getLength
		    
		  end if
		  
		  ' Get the scale.
		  scale = parentControl.getDisplayScale
		  
		  ' Are we in page view mode?
		  if parentControl.isPageViewMode then
		    
		    ' Convert to the paragraph coordinates.
		    x = x - xPos
		    y = y - yPos
		    
		  else
		    
		    ' Convert to the paragraph coordinates.
		    x = x + parentControl.getXDisplayPosition - xPos
		    y = y - yPos
		    
		  end if
		  
		  ' Is the first line involved?
		  if lineStart = 0 then
		    
		    ' Remove the before space.
		    currentHeight = parent.getBeforeParagraphSpaceLength * scale
		    
		    ' Are we in the before space?
		    if y < 0 then
		      
		      ' We are at the beginning of the line.
		      bias = true
		      
		      ' Set it to the beginning.
		      return 0
		      
		    end if
		    
		  end if
		  
		  ' Was the end line unspecified?
		  if lineEnd = -1 then
		    
		    ' Use all of the lines.
		    lineEnd = parent.getLineCount - 1
		    
		  end if
		  
		  '--------------------------------------------
		  ' Scan for the offset within the lines.
		  '--------------------------------------------
		  
		  ' Scan for the offset.
		  for i = lineStart to lineEnd
		    
		    ' Get a line.
		    ftl = parent.getLine(i)
		    
		    select case parent.getAlignment
		      
		      '--------------------
		      
		    case FTParagraph.Alignment_Type.Left
		      
		      ' Is this the first line?
		      if i = 0 then
		        
		        ' Adjust it for any indent.
		        adjustedX = x - parent.getFirstIndentWidth(scale)
		        
		      else
		        
		        ' No adjustment necessary.
		        adjustedX = x
		        
		      end if
		      
		      '--------------------
		      
		    Case FTParagraph.Alignment_Type.Center
		      
		      ' Is this the first line?
		      if i = 0 then
		        
		        ' Adjust it for any indent.
		        adjustedX = x - (Round((parent.getFirstLineWidth(scale) - ftl.getWidth(scale)) / 2) - _
		        parent.getFirstIndentWidth(scale))
		        
		      else
		        
		        ' Move it for center alignment.
		        adjustedX = x - Round((parent.getWrapWidth - ftl.getWidth(1.0)) / 2) * scale
		        
		      end if
		      
		      '--------------------
		      
		    case FTParagraph.Alignment_Type.Right
		      
		      ' Move it for right alignment.
		      adjustedX = x - ((parent.getWrapWidth - ftl.getWidth(1.0)) * scale)
		      
		    end select
		    
		    '--------------------------------------------
		    ' Add in the height of the line.
		    '--------------------------------------------
		    
		    #if TargetWindows then
		      
		      ' Add in the height of the line.
		      currentHeight = currentHeight + Round(ftl.getHeight * scale)
		      
		    #else
		      
		      ' Add in the height of the line.
		      currentHeight = currentHeight + (ftl.getHeight * scale)
		      
		    #endif
		    
		    '--------------------------------------------
		    ' Is this the line we are looking for?
		    '--------------------------------------------
		    
		    ' Is this the line we are looking for?
		    if ftl.isPointInLine(x, y + yPos, true) then
		      
		      ' Find the ending character on the line.
		      offset = ftl.getParagraphOffset + ftl.findOffset(adjustedX, scale) - 1
		      
		      ' Are we before the line?
		      if adjustedX < 0 then
		        
		        ' Adjust the offset to the beginning of the line.
		        offset = ftl.getParagraphOffset - 1
		        
		        ' We are to the left of the paragragh.
		        bias = true
		        
		        ' Are we past the end?
		      elseif adjustedX > ftl.getWidth(1.0) then
		        
		        ' We are to the right of the paragragh.
		        bias = false
		        
		      end if
		      
		      ' We are done.
		      exit
		      
		    end if
		    
		  next
		  
		  ' Range check the offset.
		  if offset < 0 then offset = 0
		  
		  ' Return the offset.
		  return offset
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function findPictureCoordinates(pic as FTPicture, ByRef picX as integer, ByRef picY as integer) As boolean
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim line as FTLine
		  Dim lastLine as integer
		  
		  ' Get the number of lines.
		  lastLine = parent.getLineCount - 1
		  
		  ' Scan the page for the picture.
		  for i = lineStart to lineEnd
		    
		    ' Is there anything to look at?
		    if i > lastLine then exit
		    
		    ' Get a line.
		    line = parent.getLine(i)
		    
		    ' Is this the one we are looking for?
		    if line.containsPicture(pic) then
		      
		      ' Get the picture coordinates.
		      return line.findPictureCoordinates(pic, picX, picY)
		      
		    end if
		    
		  next
		  
		  ' Not found.
		  picX = 0
		  picY = 0
		  
		  return false
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getAbsolutePage() As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the parent page.
		  return page
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getComposePosition() As double
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the composition position.
		  return composePosition
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getHeight(includeBeforeSpace as boolean, scale as double) As double
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Is this a 1.0 scale?
		  if scale = 1.0 then
		    
		    ' Has it been set?
		    if heightCache.scale = 0 then
		      
		      ' Save the results.
		      heightCache.scale = scale
		      heightCache.value = parent.getHeight(includeBeforeSpace, lineStart, lineEnd, scale)
		      
		    end if
		    
		    ' Return the value.
		    return floor(heightCache.value)
		    
		  else
		    
		    ' Return the value.
		    return floor(parent.getHeight(includeBeforeSpace, lineStart, lineEnd, scale))
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getLineCount() As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the number of lines in the proxy.
		  return lineEnd - lineStart + 1
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getLineEnd() As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the ending line.
		  return lineEnd
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getLineStart() As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the starting line.
		  return lineStart
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getPage() As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the page.
		  return page
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getParagraphStart() As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the vertical distance on the page.
		  return yPos
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getParent() As FTParagraph
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the parent.
		  return parent
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getParentId() As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the ID for the paragraph.
		  return parent.getId
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getProxyId() As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the ID of the proxy.
		  return id
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub getStartAndEndLines(ByRef startLine as integer, ByRef endLine as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Get the start and end lines.
		  startLine = lineStart
		  endLine = lineEnd
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getYPosition() As double
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the vertical position on the page.
		  return yPos
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isFirstParagraphOnPage() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Is this the first paragraph on the page?
		  return parentControl.getDoc.getPage(page).getParagraph(0) = self
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isLastParagraphOnPage() As Boolean
		  
		  #If Not DebugBuild
		    
		    #Pragma BoundsChecking FTC_BOUNDSCHECKING
		    #Pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #Pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #EndIf
		  
		  ' Get last Paragraph of the Page
		  Dim idx As Integer = parentControl.getDoc.getPage(page).getParagraphCount - 1
		  
		  ' Is this the last paragraph on the page?
		  Return parentControl.getDoc.getPage(page).getParagraph(idx) = Self
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isPointAfterParagraph(includeBeforeSpace as boolean, y as integer) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim linesHeight as integer
		  
		  ' Was the insertion point ever set?
		  if parent is nil then return false
		  
		  ' Get the height of the lines.
		  linesHeight = parent.getHeight(includeBeforeSpace, _
		  lineStart, lineEnd, parentControl.getDisplayScale)
		  
		  return (y > (yPos + linesHeight))
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isPointBeforeParagraph(y as integer) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Are we before the paragraph?
		  return (y < yPos)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isPointInParagraph(includeBeforeSpace as boolean, x as integer, y as integer, sloppyX as boolean, scale as double) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim linesHeight as double
		  
		  ' Was the insertion point ever set?
		  if parent is nil then return false
		  
		  ' Get the height of the lines.
		  linesHeight = Round(parent.getHeight(includeBeforeSpace, lineStart, lineEnd, scale))
		  
		  ' Do we care about the horizontal coordinate?
		  if sloppyX then
		    
		    ' Is the point within the paragraph?
		    return (y >= yPos) and (y <= (yPos + linesHeight))
		    
		  else
		    
		    ' Is the point within the paragraph?
		    return (x >= xPos) and (x <= (xPos + (parent.getWrapWidth * scale))) and _
		    (y >= yPos) and (y <= (yPos + linesHeight))
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isPointInPicture(x as integer, y as integer, scale as double) As FTPicture
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim lineIndex as integer
		  Dim line as FTLine
		  Dim item as FTObject
		  Dim offsetX as integer
		  Dim offsetY as integer
		  Dim lastLine as integer
		  Dim page as integer
		  
		  ' Get the number of lines.
		  lastLine = parent.getLineCount - 1
		  
		  ' Scan the lines.
		  for lineIndex = lineStart to lineEnd
		    
		    ' Is there anything to look at?
		    if lineIndex > lastLine then exit
		    
		    ' Get a line form the paragraph.
		    line = parent.getLine(lineIndex)
		    
		    ' Get the number of items on the line.
		    count = line.getItemCount - 1
		    
		    ' Scan the line.
		    for i = 0 to count
		      
		      ' Get an item off the line.
		      item = line.getItem(i)
		      
		      ' Is this a picture?
		      if item isa FTPicture then
		        
		        ' Get the last drawn coordinates of the picture.
		        item.getLastDrawnCoordinates(page, offsetX, offsetY)
		        
		        ' Are we scaling down?
		        if scale < 1.0 then
		          
		          ' Adjust the coordinates for the picture offset.
		          offsetX = x - offsetX
		          offsetY = y - (offsetY - item.getHeight(scale))
		          
		          ' Is the point within the picture?
		          if FTPicture(item).isPointWithin(offsetX, offsetY) then
		            
		            ' The point is in a picture.
		            return FTPicture(item)
		            
		          end if
		          
		        else
		          
		          ' Are we in page view mode?
		          if parentControl.isPageViewMode then
		            
		            ' Adjust the coordinates for the picture offset.
		            offsetX = x - offsetX
		            offsetY = y - (offsetY - item.getHeight(scale))
		            
		          else
		            
		            ' Adjust the coordinates for the picture offset.
		            offsetX = x + parentControl.getXDisplayPosition - offsetX
		            offsetY = y - (offsetY - item.getHeight(scale))
		            
		          end if
		          
		          ' Is the point within the picture?
		          if FTPicture(item).isPointWithin(offsetX / scale, offsetY / scale) then
		            
		            ' The point is in a picture.
		            return FTPicture(item)
		            
		          end if
		          
		        end if
		        
		      end if
		      
		    next
		    
		  next
		  
		  ' The point isn't in a picture.
		  return nil
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setPage(page as FTPage)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set the parent page.
		  me.page = page.getAbsolutePage
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setXPosition(x as double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  xPos = x
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setYPosition(y as double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the position of the paragraph on the page.
		  yPos = y
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private composePosition As double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private drawBeforeSpace As boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private heightCache As DoubleCache
	#tag EndProperty

	#tag Property, Flags = &h21
		Private id As integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private lineEnd As integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private lineStart As integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private my As integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private page As integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private parent As FTParagraph
	#tag EndProperty

	#tag Property, Flags = &h21
		Private xPos As double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private yPos As double
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
