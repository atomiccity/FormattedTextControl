#tag Class
Protected Class FTLine
Inherits FTBase
	#tag Method, Flags = &h0
		Sub addObject(fto as FTObject)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Is there only one item?
		  if Ubound(items) = 0 then
		    
		    ' Is the item empty?
		    if items(0).isEmpty(true) then
		      
		      ' Clear the item.
		      Redim items(-1)
		      
		      ' Reset the length.
		      length = 0
		      
		    end if
		    
		  end if
		  
		  ' Set the paragraph and position in the paragraph.
		  fto.setParagraph(paragraph)
		  fto.setPosition(paragraphOffset + length)
		  
		  ' Add the item.
		  items.Append(fto)
		  
		  ' Add in the length.
		  length = length + fto.getLength
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub computeDecent()
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim item as FTObject
		  Dim descent as double
		  Dim pictureHeight as double
		  Dim scale as double
		  
		  ' Get the scale.
		  scale = parentControl.getDisplayScale
		  
		  '---------------------------------------
		  ' Look for the maximum height.
		  '---------------------------------------
		  
		  ' Scan the style runs.
		  for each item in items
		    
		    ' Is this a style run?
		    if item isa FTStyleRun then
		      
		      ' Is this new high water mark?
		      if FTStyleRun(item).getDescent(scale) > descent then
		        
		        ' Save the decent.
		        descent = FTStyleRun(item).getDescent(scale)
		        
		      end if
		      
		    else
		      
		      ' Is this new high water mark?
		      if FTPicture(item).getPictureHeight > pictureHeight then
		        
		        ' Save the picture height.
		        pictureHeight = FTPicture(item).getPictureHeight
		        
		      end if
		      
		    end if
		    
		  next
		  
		  '---------------------------------------
		  ' Adjust for pictures only.
		  '---------------------------------------
		  
		  ' Were there any style run descents?
		  if descent = 0 then
		    
		    ' Use a 5% space.
		    descent = pictureHeight * 0.05
		    
		  end if
		  
		  '---------------------------------------
		  ' Set the decent on the pictures.
		  '---------------------------------------
		  
		  ' Set all the picture decents.
		  for each item in items
		    
		    ' Is this a style run?
		    if item isa FTPicture then
		      
		      ' Set the decent for the picture.
		      FTPicture(item).setDescent(descent)
		      
		    end if
		    
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1021
		Private Sub Constructor()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(parentControl as FormattedText, paragraph as FTParagraph, offset as integer, lineSpacing as double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the reference
		  me.paragraph = paragraph
		  me.paragraphOffset = offset
		  
		  ' Get an ID for the line.
		  id = FTUtilities.getNewID
		  
		  ' Save the parent control.
		  super.Constructor(parentControl)
		  
		  ' Save the line type.
		  me.lineType = Line_Type.Middle
		  
		  ' Initialize the line.
		  addObject(new FTStyleRun(parentControl))
		  
		  ' Save the line spacing.
		  setLineSpacing(lineSpacing)
		  
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
		  Dim count as integer
		  Dim id as integer
		  
		  ' Get the target ID.
		  id = pic.getId
		  
		  ' Get the number of items.
		  count = Ubound(items)
		  
		  ' Scan the line for the picture.
		  for i = 0 to count
		    
		    ' Is this the one we are looking for?
		    if items(i).getId = id then
		      
		      ' We found it.
		      return true
		      
		    end if
		    
		  next
		  
		  ' Not found.
		  return false
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function draw(proxy as FTParagraphProxy, g as graphics, drawBeforeSpace as boolean, firstIndent as integer, page as integer, x as double, y as double, leftPoint as integer, rightPoint as integer, alignment as FTParagraph.Alignment_Type, printing as boolean, printScale as double, endOfDoc as boolean, selectPilcrow as boolean) As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim lineHeight as integer
		  Dim currentAscent as double
		  Dim scale as double
		  
		  ' Call the event.
		  parentControl.callDrawLine(proxy, self, g, drawBeforeSpace, firstIndent, _
		  page, x, y, leftPoint, rightPoint, alignment, printing, printScale)
		  
		  ' Is there anything to draw?
		  if Ubound(items) = -1 then return getLineHeight(drawBeforeSpace, 1.0)
		  
		  ' Save the drawing state.
		  me.drawBeforeSpace = drawBeforeSpace
		  me.selectPilcrow = selectPilcrow
		  me.endOfDoc = endOfDoc
		  
		  ' Are we printing?
		  if printing then
		    
		    ' Use the print scale.
		    scale = printScale
		    
		  else
		    
		    ' Use the display scale.
		    scale = parentControl.getDisplayScale
		    
		  end if
		  
		  ' Is this the first line?
		  if (lineType = Line_Type.First) or (lineType = Line_Type.Both_First_And_Last) then
		    
		    select case alignment
		      
		    Case FTParagraph.Alignment_Type.Left
		      
		      ' Add in the indent.
		      x = x + firstIndent
		      
		    end select
		    
		  end if
		  
		  ' Get the ascent of the line.
		  currentAscent = getAscent(scale)
		  
		  ' Should we add in the before space?
		  if drawBeforeSpace then
		    
		    ' Add the before space.
		    currentAscent = currentAscent + _
		    FTUtilities.getScaledLength(beforeSpace, scale)
		    
		  end if
		  
		  ' Draw the line.
		  lineHeight = drawBackgrounds(g, x, y, leftPoint, rightPoint, _
		  drawBeforeSpace, printing, printScale)
		  
		  drawForegrounds(g, page, x, y + currentAscent, leftPoint, _
		  rightPoint, printing, printScale)
		  
		  ' Save the drawn position.
		  xPos = x
		  yPos = y + currentAscent
		  
		  top = y
		  if not parentControl.isPageViewMode then top = top + abs(parentControl.getYDisplayPosition)
		  
		  bottom = top + lineHeight
		  
		  ' Return the height of the line.
		  return lineHeight
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function drawBackgrounds(g as graphics, x as double, y as double, leftPoint as integer, rightPoint as integer, drawBeforeSpace as boolean, printing as boolean, printScale as double) As integer
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim lineHeight as double
		  Dim scale as double
		  Dim lineStart as double
		  
		  ' Save the start of the line.
		  lineStart = x
		  
		  ' Get the number of items to draw.
		  count = Ubound(items)
		  
		  ' Is there anything to draw?
		  if count < -1 then return getLineHeight(drawBeforeSpace, scale)
		  
		  ' Are we printing?
		  if printing then
		    
		    ' Use the print scale.
		    scale = printScale
		    
		  else
		    
		    ' Use the display scale.
		    scale = parentControl.getDisplayScale
		    
		  end if
		  
		  ' Calculate the top and height of the line.
		  lineHeight = getLineHeight(drawBeforeSpace, scale)
		  
		  ' Draw the content.
		  for i = 0 to count
		    
		    ' Draw the item.
		    items(i).drawBackground(g, x, y, leftPoint, rightPoint, y, _
		    lineHeight, printing, printScale)
		    
		    ' Move to the next starting position.
		    x = x + items(i).getWidth(scale, x - lineStart)
		    
		  next
		  
		  ' Is this line before the end of the document?
		  if (not endOfDoc) and (not printing) then
		    
		    ' Take care of the pilcrow.
		    handlePilcrow(g, x, y, lineHeight, scale)
		    
		  end if
		  
		  ' Return the height of the line.
		  return lineHeight
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub drawForegrounds(g as graphics, page as integer, x as double, y as double, leftPoint as Integer, rightPoint as integer, printing as boolean, printScale as double)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim scale as double
		  Dim lineStart as double
		  
		  ' Save the start of the line.
		  lineStart = x
		  
		  ' Get the number of items to draw.
		  count = Ubound(items)
		  
		  ' Is there anything to draw?
		  if count < -1 then return
		  
		  ' Are we printing?
		  if printing then
		    
		    ' Use the print scale.
		    scale = printScale
		    
		  else
		    
		    ' Get the scale.
		    scale = parentControl.getDisplayScale
		    
		  end if
		  
		  ' Draw the content.
		  for i = 0 to count
		    
		    ' Draw the item.
		    items(i).drawForeground(g, page, x, y, leftPoint, _
		    rightPoint, beforeSpace, afterSpace, printing, printScale)
		    
		    ' Move to the next starting position.
		    x = x + items(i).getWidth(scale, x - lineStart)
		    
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function dump() As string
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim s as string
		  
		  ' Get the number of lines.
		  count = Ubound(items)
		  
		  ' Assemble the debug output.
		  for i = 0 to count
		    
		    ' Is this a tab?
		    if items(i) isa FTTab then
		      
		      ' Add the tab tag.
		      s = s + "<tab-" + Str(items(i).getWidth(parentControl.getDisplayScale)) + ">"
		      
		      ' Is this a picture?
		    elseif items(i) isa FTPicture then
		      
		      ' Add the picture tag.
		      s = s + "<picture>"
		      
		    else
		      
		      ' Add the text.
		      s = s + items(i).getText
		      
		    end if
		    
		  next
		  
		  ' Return the debug string.
		  return s
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub dumpRuns(sa() as String)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  
		  ' Get the number of lines.
		  count = Ubound(items)
		  
		  sa.Append("Paragraph offset: " + str(paragraphOffset))
		  sa.Append("")
		  
		  ' Assemble the debug output.
		  for i = 0 to count
		    
		    items(i).dump(sa)
		    
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function findOffset(offsetWidth as double, scale as double) As integer
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim high as double
		  Dim low as double
		  Dim center as double
		  Dim segmentWidth as double
		  Dim delta as double
		  Dim lineLength as integer
		  
		  ' Set the range of the search.
		  lineLength = getLength
		  high = lineLength
		  
		  ' Calculate the center.
		  center = Round(high / 2)
		  
		  ' Search for the character position.
		  while low <= high
		    
		    ' Get the length of the segment.
		    segmentWidth = Floor(getOffsetWidth(center, scale))
		    
		    ' Is the position above or below the center line.
		    if segmentWidth > offsetWidth then
		      
		      ' Move to the bottom half.
		      high = center - 1
		      
		    else
		      
		      ' Did we find an exact match?
		      if segmentWidth = offsetWidth then exit
		      
		      ' Move to the upper half.
		      low = center + 1
		      
		    end if
		    
		    ' Compute the new center line.
		    center = Round((high + low) / 2)
		    
		  wend
		  
		  ' Do we need to back up?
		  if center > high then center = high
		  
		  ' Get the exact measurement.
		  segmentWidth = getOffsetWidth(center, scale)
		  
		  ' Calculate the halfway point between the characters.
		  delta = (getOffsetWidth(center + 1, scale) - segmentWidth) / 2.0
		  
		  ' Do we need to move over to the next character?
		  if (offsetWidth - segmentWidth) >= delta then
		    
		    ' Bump up the offset.
		    center = center + 1
		    
		  end if
		  
		  ' Are we past the end?
		  if center > lineLength then
		    
		    ' Is this the last line in the paragraph?
		    if (lineType = Line_Type.Last) or (lineType = Line_Type.Both_First_And_Last) then
		      
		      ' Include the pilcrow.
		      center = lineLength + 1
		      
		    else
		      
		      ' Use the end of the line.
		      center = lineLength
		      
		    end if
		    
		  end if
		  
		  ' Return the character position.
		  return center
		  
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
		  Dim count as integer
		  Dim item as FTObject
		  Dim page as integer
		  
		  ' Get the number of items on the line.
		  count = Ubound(items)
		  
		  ' Scan the line for the picture.
		  for i = 0 to count
		    
		    ' Get an item.
		    item = items(i)
		    
		    ' Is this the one we are looking for?
		    if item.getId = pic.getId then
		      
		      ' Get the picture coordinates.
		      FTPicture(item).getLastDrawnCoordinates(page, picX, picY)
		      
		      ' We found it.
		      return true
		      
		    end if
		    
		  next
		  
		  ' Not found.
		  picX = 0
		  picY = 0
		  
		  ' Not found.
		  return false
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getAscent(scale as double = 1.0) As double
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim item as FTObject
		  Dim itemAscent as double
		  
		  ' Has the ascent been calculated?
		  if (ascent < 0) or (ascentScale <> scale) then
		    
		    ' Save the scale.
		    ascentScale = scale
		    
		    ' Zero out the ascent.
		    ascent = 0
		    
		    ' Scan for the largest ascent.
		    for each item in items
		      
		      ' Get the ascent of the object.
		      itemAscent = item.getAscent(scale)
		      
		      ' Is this a high water mark?
		      if itemAscent > ascent then
		        
		        ' Save the new ascent.
		        ascent = itemAscent
		        
		      end if
		      
		    next
		    
		  end if
		  
		  ' Return the ascent.
		  return ascent
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getDescent(scale as double = 1.0) As double
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the decent.
		  return Max((getHeight(scale) - getAscent(scale)), 0)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub getDrawnPosition(ByRef x as integer, ByRef y as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the position.
		  x = xPos
		  y = yPos
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getHeight(scale as double = 1.0) As double
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim item as FTObject
		  Dim itemHeight as double
		  
		  ' Has the total height been calculated?
		  if (height < 0) or (heightScale <> scale) then
		    
		    ' Save the scale.
		    heightScale = scale
		    
		    ' Reset the height.
		    height = 0
		    
		    ' Find the maximum height.
		    for each item in items
		      
		      ' Get the height of the object.
		      itemHeight = item.getHeight(scale)
		      
		      ' Is this a high water mark?
		      if itemHeight > height then
		        
		        ' Save the new high water mark.
		        height = itemHeight
		        
		      end if
		      
		    next
		    
		  end if
		  
		  ' Return the height.
		  return (height * lineSpacing)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getId() As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the ID for the line.
		  return id
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getItem(index as integer) As FTObject
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the specified item.
		  return items(index)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getItemCount() As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the number of items.
		  return Ubound(items) + 1
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getItemFromOffset(lineOffset as integer) As FTObject
		  
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim item as FTObject
		  
		  ' Get the number of items on the line.
		  count = Ubound(items)
		  
		  ' Scan the line for the picture.
		  for i = 0 to count
		    
		    ' Get an item.
		    item = items(i)
		    
		    ' Is this the one we are looking for?
		    if (lineOffset >= item.getStartPosition) and _
		      (lineOffset <= item.getEndPosition) then
		      
		      ' We found it.
		      return items(i)
		      
		    end if
		    
		  next
		  
		  ' Not found.
		  return nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getLength() As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the length in units.
		  return length
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getLineHeight(drawBeforeSpace as boolean, scale as double) As double
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Should we include the before space.
		  if drawBeforeSpace then
		    
		    ' Get the total height of the line.
		    return getHeight(scale) + FTUtilities.getScaledLength(beforeSpace, scale) + _
		    FTUtilities.getScaledLength(afterSpace, scale)
		    
		  else
		    
		    ' Get the total height of the line.
		    return getHeight(scale) + FTUtilities.getScaledLength(afterSpace, scale)
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getLineType() As Line_Type
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the current line type.
		  return lineType
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getOffsetAscent(offset as integer, scale as double) As double
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim currentLength as integer
		  
		  ' Get the number of items.
		  count = Ubound(items)
		  
		  ' Look for the particular ascent.
		  for i = 0 to count
		    
		    ' Add in the horizontal logical length.
		    currentLength = currentLength + items(i).getLength
		    
		    ' Are we within this item?
		    if offset <= currentLength then
		      
		      ' Return the ascent of this item.
		      return items(i).getAscent(scale)
		      
		    end if
		    
		  next
		  
		  ' Return the ascent of the first item on the line.
		  return items(0).getAscent(scale)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getOffsetDecent(offset as integer, scale as double) As double
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim currentLength as integer
		  
		  ' Get the number of items.
		  count = Ubound(items)
		  
		  ' Look for the particular ascent.
		  for i = 0 to count
		    
		    ' Add in the horizontal logical length.
		    currentLength = currentLength + items(i).getLength
		    
		    ' Are we within this item?
		    if offset <= currentLength then
		      
		      ' Return the descent of this item.
		      return items(i).getDescent(scale)
		      
		    end if
		    
		  next
		  
		  ' Return the descent of the first item on the line.
		  return items(0).getDescent(scale)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getOffsetWidth(offset as integer, scale as double = 1.0) As double
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim startItem as integer
		  Dim previousLength as integer
		  Dim currentLength as integer
		  Dim sumLength as double
		  
		  ' Are we before the beginning of the line?
		  if offset <= 0 then return 0
		  
		  ' Are we past the end of the line?
		  if offset > length then offset = length
		  
		  ' Get the number of items on the line.
		  count = Ubound(items)
		  
		  ' Calculate the length to the offset.
		  for i = startItem to count
		    
		    ' Save the previous length.
		    previousLength = currentLength
		    
		    ' Add in the length of the item.
		    currentLength = currentLength + items(i).getLength
		    
		    ' Are we within this item?
		    if offset <= currentLength then
		      
		      ' Return the partial length.
		      return sumLength + items(i).getWidth(1, offset - previousLength, scale, sumLength)
		      
		    else
		      
		      ' Add in the length of the item.
		      sumLength = sumLength + items(i).getWidth(scale, sumLength)
		      
		    end if
		    
		  next
		  
		  ' Return the length of the entire line.
		  return sumLength
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getParagraphOffset() As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the offset into the paragraph for the start of the line.
		  return paragraphOffset
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getSelectionDimensions(ByRef x as integer, ByRef y as integer, ByRef width as integer, ByRef height as integer) As boolean
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim item as FTObject
		  Dim itemX as integer
		  Dim itemY as integer
		  Dim itemWidth as integer
		  Dim itemHeight as integer
		  Dim result as boolean
		  
		  ' Initialize the variables.
		  x = 2147483647
		  y = 2147483647
		  width = 0
		  height = 0
		  
		  ' Get the number of items in the line.
		  count = Ubound(items)
		  
		  ' Scan the items.
		  for i = 0 to count
		    
		    ' Get an item from the line.
		    item = getItem(i)
		    
		    ' Is the item selected?
		    if item.isSelected then
		      
		      ' Get the selected item dimensions.
		      item.getSelectionDimensions(itemX, itemY, itemWidth, itemHeight)
		      
		      ' Save the starting point.
		      x = min(x, itemX)
		      y = min(y, itemY)
		      
		      ' Add in the lengths.
		      width = width + itemWidth
		      height = max(height, itemHeight)
		      
		      ' Set the flag.
		      result = true
		      
		    end if
		    
		  next
		  
		  ' Did this line have a selection?
		  return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getText() As string
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim sa() as string
		  
		  ' Do we need to get the text?
		  if not gotText then
		    
		    ' Get the number of items.
		    count = Ubound(items)
		    
		    ' Concatenate all the text.
		    for i = 0 to count
		      
		      ' Add the text to the line.
		      sa.Append(items(i).getText)
		      
		    next
		    
		    ' Create the text.
		    text = Join(sa, "")
		    
		  end if
		  
		  ' return the line of text.
		  return text
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getWidth(scale as double) As double
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim sum as double
		  
		  ' Do we need to calculate the width?
		  if (scale <> 1.0) or (width < 0) then
		    
		    ' Get the number of items.
		    count = Ubound(items)
		    
		    ' Get the total width.
		    for i = 0 to count
		      
		      ' Add in the width.
		      sum = sum + items(i).getWidth(scale, sum)
		      
		    next
		    
		    ' Save the width.
		    if scale = 1.0 then width = sum
		    
		  else
		    
		    ' Use the cached value.
		    sum = width
		    
		  end if
		  
		  ' Return the width.
		  return sum
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getYPos() As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the position.
		  return yPos
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function handleLeadingSpaces(target as integer) As boolean
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim targetItem as FTObject
		  Dim item as FTStyleRun
		  Dim spaceItem as FTStyleRun
		  Dim text as string
		  Dim index as integer
		  Dim length as integer
		  
		  ' Get the item.
		  targetItem = items(target)
		  
		  ' Is this a tab?
		  if targetItem isa FTTab then
		    
		    ' Clear the lines.
		    targetItem.clearLines
		    
		    ' Continue looking.
		    return false
		    
		  end if
		  
		  ' Is the first item a style run and has lines?
		  if (targetItem isa FTStyleRun) and targetItem.hasLines then
		    
		    ' Cast it to the correct type.
		    item = FTStyleRun(targetItem)
		    
		    ' Get the text of the first item.
		    text = item.getText
		    
		    ' Get the length of the text.
		    length = item.getLength
		    
		    ' Is the first character a space?
		    if mid(text, 1, 1) = " " then
		      
		      ' Search for a non-space.
		      for index = 2 to length
		        
		        ' Is this a non-space?
		        if mid(text, index, 1) <> " " then
		          
		          ' Create a clone.
		          spaceItem = FTStyleRun(item.clone)
		          
		          ' Delete the text from the space holder.
		          spaceItem.deleteRight(index - 1)
		          
		          ' Clear the drawn lines.
		          spaceItem.clearLines
		          
		          ' Set the paragraph and position in the paragraph.
		          spaceItem.setParagraph(paragraph)
		          spaceItem.setPosition(paragraphOffset + length)
		          
		          ' Insert the space item into the line.
		          items.Insert(target, spaceItem)
		          
		          ' Add in the length.
		          length = length + spaceItem.getLength
		          
		          ' Delete the space from the text item.
		          item.deleteLeft(index)
		          
		          ' We are done.
		          return true
		          
		        end if
		        
		      next
		      
		      ' Clear the lines on the item since it is all spaces.
		      item.clearLines
		      
		    else
		      
		      ' We are done.
		      return true
		      
		    end if
		    
		  end if
		  
		  ' Keep looking.
		  return false
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub handlePilcrow(g as Graphics, x as integer, y as integer, lineHeight as integer, scale as double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Is this the last line of the paragraph?
		  if (lineType = Line_Type.Last) or (lineType = Line_Type.Both_First_And_Last) then
		    
		    ' Set up the display font.
		    g.FontName = "Arial"
		    g.TextSize = PILCROW_SIZE * scale
		    g.bold = false
		    g.Italic = false
		    
		    ' Should we draw the selection?
		    if selectPilcrow then
		      
		      ' Are we in focus?
		      if parentControl.getFocusState then
		        
		        ' Set the in focus selection color.
		        g.ForeColor = HighlightColor
		        
		      else
		        
		        ' Set the out of focus selection color.
		        g.ForeColor = FTUtilities.OUT_OF_FOCUS_COLOR
		        
		      end if
		      
		      ' Draw the selection area for the end of paragraph symbol.
		      g.FillRect(x, y, g.StringWidth(FTUtilities.PILCROW) + 1, lineHeight)
		      
		    end if
		    
		    ' Are we showing pilcrows?
		    if parentControl.ShowPilcrows and (parentControl.ShowInvisibles or selectPilcrow) then
		      
		      ' Do we need to add in the before space?
		      if ((lineType = Line_Type.First) or (lineType = Line_Type.Both_First_And_Last)) and drawBeforeSpace then
		        
		        ' Add in the before space.
		        y = y + FTUtilities.getScaledLength(beforeSpace, scale)
		        
		      end if
		      
		      ' Draw the end of paragraph symbol.
		      g.ForeColor = parentControl.InvisiblesColor
		      g.DrawString(FTUtilities.PILCROW, x, y + getAscent(scale))
		      
		    end if
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function handleTrailingSpaces(target as integer) As boolean
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim targetItem as FTObject
		  Dim item as FTStyleRun
		  Dim spaceItem as FTStyleRun
		  Dim text as string
		  Dim index as integer
		  Dim length as integer
		  
		  ' Get the item.
		  targetItem = items(target)
		  
		  ' Is the last item a style run and has lines?
		  if (targetItem isa FTStyleRun) then
		    
		    ' Is there anything to do?
		    if not targetItem.hasLines then return true
		    
		    ' Cast it to the correct type.
		    item = FTStyleRun(targetItem)
		    
		    ' Get the text of the first item.
		    text = item.getText
		    
		    ' Get the length of the text.
		    length = item.getLength
		    
		    ' Is the last character a space?
		    if mid(text, length, 1) = " " then
		      
		      ' Search for a non-space.
		      for index = (length - 1) downto 1
		        
		        ' Is this a non-space?
		        if mid(text, index, 1) <> " " then
		          
		          ' Create a clone.
		          spaceItem = FTStyleRun(item.clone)
		          
		          ' Delete the text from the space holder.
		          spaceItem.deleteLeft(index + 1)
		          
		          ' Clear the drawn lines.
		          spaceItem.clearLines
		          
		          ' Append the space item to the line.
		          addObject(spaceItem)
		          
		          'add object adds to the length of the line, but we're deleting the spaces
		          'directly out of the item - adjust the length to make it correct
		          self.length = self.length - spaceItem.getLength
		          
		          ' Delete the space from the text item.
		          item.deleteRight(index)
		          
		          ' We are done.
		          return true
		          
		        end if
		        
		      next
		      
		      ' Clear the lines on the item since it is all spaces.
		      item.clearLines
		      
		    else
		      
		      ' We are done.
		      return true
		      
		    end if
		    
		  else
		    
		    ' Is non-picture?
		    if not (targetItem isa FTPicture) then
		      
		      ' Clear the lines.
		      targetItem.clearLines
		      
		    end if
		    
		  end if
		  
		  ' Keep looking.
		  return false
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function hasTabs() As boolean
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim fto as FTObject
		  
		  ' Scan for tabs.
		  for each fto in items
		    
		    ' Is this a tab?
		    if fto isa FTTab then
		      
		      ' We found a tab.
		      return true
		      
		    end if
		    
		  next
		  
		  ' No tabs found.
		  return false
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isEmpty(includeSpaces as boolean) As boolean
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim item as FTObject
		  
		  ' Is there anything present?
		  if getLength = 0 then
		    
		    return true
		    
		  end if
		  
		  ' Scan the items.
		  for each item in items
		    
		    ' Is this not empty?
		    if not item.isEmpty(includeSpaces) then
		      
		      return false
		      
		    end if
		    
		  next
		  
		  ' The line is empty.
		  return true
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isFirstPositionSelected() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Does the selection go to the beginning of the line?
		  return items(0).isFirstPositionSelected
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isLastPositionSelected() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Does the selection go to the end of the line?
		  return items(Ubound(items)).isLastPositionSelected
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isLineSelected() As boolean
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim item as FTObject
		  
		  ' Is the pilcrow selected?
		  if (lineType = Line_Type.Last) and selectPilcrow then return true
		  
		  ' Scan each item.
		  for each item in items
		    
		    ' Is the item selected?
		    if item.isSelected then
		      
		      ' Save the value.
		      return true
		      
		    end if
		    
		  next
		  
		  ' Nothing selected.
		  return false
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isPointInLine(x as integer, y as integer, sloppyX as boolean) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Do we care about the horizontal coordinate?
		  if sloppyX then
		    
		    ' Is the point within the paragraph?
		    return (y >= top) and (y <= bottom)
		    
		  else
		    
		    ' Is the point within the paragraph?
		    return (x >= xPos) and (x <= (xPos + Width)) and _
		    (y >= top) and (y <= bottom)
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setLineSpacing(lineSpacing as double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set the line spacing.
		  me.lineSpacing = lineSpacing
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setLineType(lineType as Line_Type, beforeSpace as double, afterSpace as double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the line type and space requirements.
		  Me.lineType = lineType
		  me.beforeSpace = beforeSpace
		  me.afterSpace = afterSpace
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub trim(alignment as FTParagraph.Alignment_Type)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  
		  ' Save the settings.
		  Me.alignment = alignment
		  
		  '----------------------------------------------
		  ' Handle leading spaces.
		  '----------------------------------------------
		  
		  ' Get the number of items.
		  count = Ubound(items)
		  
		  ' Scan for preceeding spaces.
		  for i = 0 to count
		    
		    ' Remove the lines (underline, strikethrough, and mark)
		    ' from the leading spaces.
		    if handleLeadingSpaces(i) then exit
		    
		  next
		  
		  '----------------------------------------------
		  ' Handle trailing spaces.
		  '----------------------------------------------
		  
		  ' Get the number of items.
		  count = Ubound(items)
		  
		  ' Scan for trailing spaces.
		  for i = count downto 0
		    
		    ' Remove the lines (underline, strikethrough, and mark)
		    ' from the trailing spaces.
		    if handleTrailingSpaces(i) then exit
		    
		  next
		  
		  ' Update the item positions on the line.
		  updateLinePositions
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub updateLinePositions()
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim currentPosition as integer
		  
		  ' Get the number of items in the line.
		  count = Ubound(items)
		  
		  currentPosition = paragraphOffset
		  
		  ' Set all the positions.
		  for i = 0 to count
		    
		    ' Set the position of the object.
		    items(i).setPosition(currentPosition)
		    
		    ' Get the next starting position.
		    currentPosition = currentPosition + items(i).getLength
		    
		  next
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private afterSpace As double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private alignment As FTParagraph.Alignment_Type
	#tag EndProperty

	#tag Property, Flags = &h21
		Private ascent As double = -1
	#tag EndProperty

	#tag Property, Flags = &h21
		Private ascentScale As double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private beforeSpace As double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private bottom As integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private drawBeforeSpace As boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private endOfDoc As boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private gotText As boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private height As double = -1
	#tag EndProperty

	#tag Property, Flags = &h21
		Private heightScale As double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private id As integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private items() As FTObject
	#tag EndProperty

	#tag Property, Flags = &h21
		Private length As integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private lineSpacing As double = 1.0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private lineType As Line_type
	#tag EndProperty

	#tag Property, Flags = &h21
		Private paragraph As FTParagraph
	#tag EndProperty

	#tag Property, Flags = &h21
		Private paragraphOffset As integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private selectPilcrow As boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private text As string
	#tag EndProperty

	#tag Property, Flags = &h21
		Private top As integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private width As double = -1
	#tag EndProperty

	#tag Property, Flags = &h21
		Private xPos As integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private yPos As integer
	#tag EndProperty


	#tag Constant, Name = PILCROW_SIZE, Type = Double, Dynamic = False, Default = \"10", Scope = Public
	#tag EndConstant


	#tag Enum, Name = Line_Type, Type = Integer, Flags = &h0
		First
		  Middle
		  Last
		Both_First_And_Last
	#tag EndEnum


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
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
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
