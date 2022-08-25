#tag Class
Protected Class FTPage
Inherits FTBase
	#tag Method, Flags = &h0
		Sub addParagraph(p as FTParagraph, compositionPosition as double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Add the paragraph to the page.
		  paragraphs.append(new FTParagraphProxy(parentControl, p, _
		  getAbsolutePage, 0, p.getLineCount - 1, compositionPosition))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub addParagraph(p as FTParagraphProxy)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Add the paragraph to the page.
		  paragraphs.append(p)
		  
		  ' Set the parent page.
		  p.setPage(self)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub audit()
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  
		  '-----------------------------------------
		  ' Paragraphs.
		  '-----------------------------------------
		  
		  ' Get the number of paragraphs.
		  count = Ubound(paragraphs)
		  
		  ' Are there are any proxies on this page?
		  if count = -1 then break
		  
		  ' Audit the paragraphs.
		  for i = 0 to count
		    
		    ' Check the paragraph.
		    paragraphs(i).audit
		    
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub clear()
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Release the proxies.
		  Redim paragraphs(-1)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function computePositions() As double
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim j as integer
		  Dim count as integer
		  Dim height as double
		  Dim topMargin as double
		  Dim totalHeight as double
		  Dim paragraphHeight as double
		  Dim scale as double
		  
		  ' Get the number of paragraphs.
		  count = Ubound(paragraphs)
		  
		  ' Set the number of bins.
		  Redim positions(count / BIN_SIZE)
		  
		  ' Get the scale.
		  scale = parentControl.getDisplayScale
		  
		  ' Compute the top margin.
		  topMargin = FTUtilities.getScaledLength(doc.getTopMargin, scale)
		  
		  ' Fill in all the bins.
		  for i = 0 to count
		    
		    ' Is it time to add in the height of the block of paragraphs?
		    if (i mod BIN_SIZE) = 0 then
		      
		      ' Save the height in the positions list.
		      positions(j) = height
		      
		      ' Move to the next position entry.
		      j = j + 1
		      
		      ' Reset the height.
		      height = 0
		      
		    end if
		    
		    ' Set the vertical position on the page.
		    paragraphs(i).setYPosition(topMargin + totalHeight)
		    
		    ' Get the height of the paragraph.
		    paragraphHeight = paragraphs(i).getHeight(i <> 0, scale)
		    
		    ' Add in the height of the paragraph.
		    height = height + paragraphHeight
		    
		    ' Add in the cumulative height of the paragraphs.
		    totalHeight = totalHeight + paragraphHeight
		    
		  next
		  
		  ' Return the total height.
		  return totalHeight
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(parentControl as FormattedText)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the parent control.
		  super.Constructor(parentControl)
		  
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
		  
		  Dim item as FTParagraphProxy
		  
		  ' Scan the page for the picture.
		  for each item in paragraphs
		    
		    ' Is this the one we are looking for?
		    if item.containsPicture(pic) then
		      
		      ' We found it.
		      return true
		      
		    end if
		    
		  next
		  
		  ' Not found.
		  return false
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub destructor()
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' We need to do this because Redim causes
		  ' problems and we need to release the circular
		  ' references.
		  
		  Dim i as integer
		  Dim count as integer
		  
		  ' Get the number of paragraphs.
		  count = Ubound(paragraphs)
		  
		  ' Release all th references.
		  for i = 0 to count
		    
		    ' Release the reference.
		    paragraphs(i) = nil
		    
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub drawNormalViewMode(g as graphics, doc as FTDocument, pageLeft as integer, pageTop as integer, insertionPoint as FTInsertionPoint)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim y as double
		  Dim scale as double
		  Dim pageImageGraphics as Graphics
		  Dim topMargin as integer
		  Dim borderLeft as integer
		  Dim borderTop as integer
		  Dim borderHeight as integer
		  Dim borderWidth as integer
		  Dim startPosition as integer
		  Dim endPosition as integer
		  
		  ' Get the scale.
		  scale = parentControl.getScale
		  
		  ' Extract the graphics for the clipping corner.
		  pageImageGraphics = doc.getClippingPage.Graphics
		  
		  '---------------------------------------
		  ' Draw the page background.
		  '---------------------------------------
		  
		  ' Get the color for the page background.
		  pageImageGraphics.ForeColor = doc.getPageBackgroundColor
		  
		  ' Draw the page background.
		  pageImageGraphics.FillRect(0, 0, pageImageGraphics.width, pageImageGraphics.height)
		  
		  ' Call the user pre-page drawing event.
		  parentControl.callPrePageDraw(pageImageGraphics, self, false, 1.0)
		  
		  '---------------------------------------
		  ' Draw the content.
		  '---------------------------------------
		  
		  ' Compute the top margin.
		  topMargin = FTUtilities.getScaledLength(doc.getTopMargin, 1.0) * parentControl.getDisplayScale
		  
		  ' Set the starting position.
		  y = pageTop + topMargin
		  
		  ' Find the start and end paragraphs to draw.
		  startParagraphNormalMode = findParagraphIndex(Abs(y) - topMargin)
		  endParagraphNormalMode = findParagraphIndex(Abs(y) - topMargin + pageImageGraphics.height) + 2
		  
		  ' Check the range of the end paragraph.
		  if endParagraphNormalMode > Ubound(paragraphs) then endParagraphNormalMode = Ubound(paragraphs)
		  
		  ' Find the drawing offset of the starting paragraph.
		  y = y + findParagraphPosition(startParagraphNormalMode)
		  
		  ' Draw all the paragraphs.
		  for i = startParagraphNormalMode to endParagraphNormalMode
		    
		    ' Draw the paragraph.
		    y = y + paragraphs(i).drawNormalView(pageImageGraphics, (i <> 0), y, insertionPoint)
		    
		  next
		  
		  '---------------------------------------
		  ' Draw the margin guides.
		  '---------------------------------------
		  
		  ' Should we show the margin guides?
		  if doc.showMarginGuides then
		    
		    ' Set the margin guide color.
		    pageImageGraphics.ForeColor = parentControl.marginGuideColor
		    
		    ' Set the pen dimensions.
		    pageImageGraphics.PenWidth = 1
		    pageImageGraphics.PenHeight = 1
		    
		    ' Note, we have to do this next piece of code because there is
		    ' 16 bit limit to drawing lengths.
		    
		    ' Calculate some margin values.
		    borderLeft = FTUtilities.getScaledLength(doc.getLeftMargin, parentControl.getDisplayScale)
		    borderTop = pageTop + FTUtilities.getScaledLength(doc.getTopMargin, parentControl.getDisplayScale)
		    borderWidth = FTUtilities.getScaledLength(doc.getMarginWidth, parentControl.getDisplayScale)
		    borderHeight = doc.getPageHeightLength
		    
		    ' Are we in the normal view mode?
		    if parentControl.isNormalViewMode then
		      
		      ' Adjust the display.
		      borderLeft = borderLeft + parentControl.getXDisplayPosition
		      
		    end if
		    
		    ' Have we exceeded the drawing limit?
		    if borderHeight > pageImageGraphics.height then
		      
		      ' Compute the end of the guide.
		      startPosition = borderTop
		      endPosition = startPosition + borderHeight
		      
		      ' Do we need to shift down the top of guide?
		      if startPosition < 0 then
		        
		        ' Put the top of the guide just above the top of the visible display.
		        borderTop = -1
		        borderHeight = endPosition + 1
		        
		      end if
		      
		      ' Do we need to up down the bottom of guide?
		      if endPosition > pageImageGraphics.height then
		        
		        ' Put the bottom of the guide just below the bottom of the visible display.
		        borderHeight = borderTop + pageImageGraphics.height + 3
		        
		      end if
		      
		    end if
		    
		    ' Draw the margin guides.
		    pageImageGraphics.DrawRect(borderLeft - BORDER_OFFSET, borderTop - BORDER_OFFSET, _
		    borderWidth + (2 * BORDER_OFFSET), borderHeight + (2 * BORDER_OFFSET))
		    
		  end if
		  
		  ' Call the user post-page drawing event.
		  parentControl.callPostPageDraw(pageImageGraphics, self, false, 1.0)
		  
		  ' Copy the picture to the display.
		  drawPage(g, doc.getClippingPage, pageLeft, 0, scale)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub drawPage(g as Graphics, p as Picture, pageLeft as integer, pageTop as integer, scale as double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Are we in a non-page view mode?
		  if parentControl.isPageViewMode then
		    
		    ' Are we scaling down?
		    if scale < 1.0 then
		      
		      ' Copy the picture to the display.
		      g.drawPicture(p, pageLeft, pageTop, p.Width * scale, p.Height * scale, 0, 0, p.Width, p.Height)
		      
		    else
		      
		      ' Copy the picture to the display.
		      g.drawPicture(p, pageLeft, pageTop)
		      
		    end if
		    
		  else
		    
		    ' Set the background color.
		    g.ForeColor = doc.getPageBackgroundColor
		    
		    ' Fill the background.
		    g.FillRect(0, 0, g.width, g.height)
		    
		    ' Are we scaling down?
		    if scale < 1.0 then
		      
		      ' Copy the picture to the display.
		      g.drawPicture(p, pageLeft, 0, g.Width, g.Height, 0, 0, p.Width, p.Height)
		      
		    else
		      
		      ' Copy the picture to the display.
		      g.drawPicture(p, pageLeft, 0)
		      
		    end if
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function drawPageToPDF(g As PDFgraphics, doc As FTDocument, printScale As double, pTop As Double) As Double
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim width as double
		  Dim height as double
		  Dim y As Double = pTop
		  Dim pageImageGraphics As Graphics
		  Dim scale as double
		  Dim displayScale as double
		  
		  ' Are we printing?
		  'if printing then
		  
		  ' Use the scale.
		  scale = printScale
		  displayScale = printScale
		  
		  ' else
		  ' 
		  ' ' Use the display scale.
		  ' scale = parentControl.getScale
		  ' displayScale = parentControl.getDisplayScale
		  ' 
		  ' end if
		  
		  '---------------------------------------
		  ' Draw the page border.
		  '---------------------------------------
		  
		  ' Has the display been scrolled?
		  // Mantis Ticket 3777: Implement Page Shadow Property in Formatted Text
		  ' if parentControl.displayMoved and (not printing) and parentControl.UsePageShadow then
		  ' 
		  ' ' Get the dimensions of the page.
		  ' width = doc.getPageWidthLength * scale
		  ' height = doc.getPageHeightLength * scale
		  ' 
		  ' ' Draw the gradient shadow.
		  ' For i = 0 To 6 ' for i = 0 to 6
		  ' 
		  ' ' Get the border color.
		  ' g.ForeColor = doc.getPageBorderColor(i)
		  ' 
		  ' ' Draw the step of the border.
		  ' g.DrawRect(pageLeft- i, pageTop - i, width + (i*2), height + (i*2))
		  ' 
		  ' Next
		  ' 
		  ' ' Set the pen width.
		  ' g.PenHeight = 1
		  ' g.PenWidth = 1
		  ' 
		  ' end if
		  
		  '---------------------------------------
		  ' Draw the page background.
		  '---------------------------------------
		  
		  ' Are we printing?
		  'if printing then
		  
		  ' ' Just use the provided printing port.
		  ' pageImageGraphics = g
		  
		  ' else
		  ' 
		  ' ' Extract the graphics for the clipping corner.
		  ' pageImageGraphics = doc.getClippingPage.Graphics
		  ' 
		  ' end if
		  
		  ' ' Get the color for the page background.
		  ' pageImageGraphics.ForeColor = doc.getPageBackgroundColor
		  ' 
		  ' ' Draw the page background.
		  ' pageImageGraphics.FillRect(0, 0, pageImageGraphics.width, pageImageGraphics.height)
		  
		  ' Call the user pre-page drawing event.
		  'parentControl.callPrePageDraw(pageImageGraphics, self, printing, printScale)
		  ' 
		  '---------------------------------------
		  ' Draw the content.
		  '---------------------------------------
		  
		  ' Set the starting position.
		  'y = FTUtilities.getScaledLength(doc.getTopMargin, displayScale)
		  
		  ' Get the number of paragraphs.
		  count = Ubound(paragraphs)
		  
		  ' Draw all the paragraphs.
		  For i = 0 To count
		    
		    ' Draw the paragraph.
		    y = y + paragraphs(i).drawPageViewToPDF(g, (i <> 0), y, displayScale)
		    
		  next
		  
		  '---------------------------------------
		  ' Draw the margin guides.
		  '---------------------------------------
		  
		  ' Should we show the margin guides?
		  ' if doc.showMarginGuides and (not printing) then
		  ' 
		  ' ' Set the margin guide color.
		  ' pageImageGraphics.ForeColor = parentControl.marginGuideColor
		  ' 
		  ' ' Set the pen dimensions.
		  ' pageImageGraphics.PenWidth = 1
		  ' pageImageGraphics.PenHeight = 1
		  ' 
		  ' ' Draw the margin guides slightly wider than the content.
		  ' pageImageGraphics.DrawRect(FTUtilities.getScaledLength(doc.getLeftMargin, parentControl.getDisplayScale) - BORDER_OFFSET, _
		  ' FTUtilities.getScaledLength(doc.getTopMargin, parentControl.getDisplayScale) - BORDER_OFFSET, _
		  ' FTUtilities.getScaledLength(doc.getMarginWidth, parentControl.getDisplayScale) + (2 * BORDER_OFFSET), _
		  ' FTUtilities.getScaledLength(doc.getMarginHeight, parentControl.getDisplayScale) + (2 * BORDER_OFFSET))
		  ' 
		  ' end if
		  
		  ' Call the user post-page drawing event.
		  'parentControl.callPostPageDraw(pageImageGraphics, self, printing, printScale)
		  ' 
		  '---------------------------------------
		  ' Copy over the page.
		  '---------------------------------------
		  
		  ' Are we outputting to the display?
		  ' if not printing then
		  ' 
		  ' ' Copy the picture to the display.
		  ' drawPage(g, doc.getClippingPage, pageLeft, pageTop, scale)
		  ' 
		  ' end if
		  
		  Return y
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub drawPageViewMode(g as graphics, doc as FTDocument, pageLeft as integer, pageTop as integer, insertionPoint as FTInsertionPoint, printing as boolean, printScale as double)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim width as double
		  Dim height as double
		  Dim y as double
		  Dim pageImageGraphics as Graphics
		  Dim scale as double
		  Dim displayScale as double
		  
		  ' Are we printing?
		  if printing then
		    
		    ' Use the scale.
		    scale = printScale
		    displayScale = printScale
		    
		  else
		    
		    ' Use the display scale.
		    scale = parentControl.getScale
		    displayScale = parentControl.getDisplayScale
		    
		  end if
		  
		  '---------------------------------------
		  ' Draw the page border.
		  '---------------------------------------
		  
		  ' Has the display been scrolled?
		  // Mantis Ticket 3777: Implement Page Shadow Property in Formatted Text
		  if parentControl.displayMoved and (not printing) and parentControl.UsePageShadow then
		    
		    ' Get the dimensions of the page.
		    width = doc.getPageWidthLength * scale
		    height = doc.getPageHeightLength * scale
		    
		    ' Draw the gradient shadow.
		    For i = 0 To 6 ' for i = 0 to 6
		      
		      ' Get the border color.
		      g.ForeColor = doc.getPageBorderColor(i)
		      
		      ' Draw the step of the border.
		      g.DrawRect(pageLeft- i, pageTop - i, width + (i*2), height + (i*2))
		      
		    Next
		    
		    ' Set the pen width.
		    g.PenHeight = 1
		    g.PenWidth = 1
		    
		  end if
		  
		  '---------------------------------------
		  ' Draw the page background.
		  '---------------------------------------
		  
		  ' Are we printing?
		  if printing then
		    
		    ' Just use the provided printing port.
		    pageImageGraphics = g
		    
		  else
		    
		    ' Extract the graphics for the clipping corner.
		    pageImageGraphics = doc.getClippingPage.Graphics
		    
		  end if
		  
		  ' Get the color for the page background.
		  pageImageGraphics.ForeColor = doc.getPageBackgroundColor
		  
		  ' Draw the page background.
		  pageImageGraphics.FillRect(0, 0, pageImageGraphics.width, pageImageGraphics.height)
		  
		  ' Call the user pre-page drawing event.
		  parentControl.callPrePageDraw(pageImageGraphics, self, printing, printScale)
		  ' 
		  '---------------------------------------
		  ' Draw the content.
		  '---------------------------------------
		  
		  ' Set the starting position.
		  y = FTUtilities.getScaledLength(doc.getTopMargin, displayScale)
		  
		  ' Get the number of paragraphs.
		  count = Ubound(paragraphs)
		  
		  ' Draw all the paragraphs.
		  for i = 0 to count
		    
		    ' Draw the paragraph.
		    y = y + paragraphs(i).drawPageView(pageImageGraphics, (i <> 0), y, insertionPoint, printing, displayScale)
		    
		  next
		  
		  '---------------------------------------
		  ' Draw the margin guides.
		  '---------------------------------------
		  
		  ' Should we show the margin guides?
		  if doc.showMarginGuides and (not printing) then
		    
		    ' Set the margin guide color.
		    pageImageGraphics.ForeColor = parentControl.marginGuideColor
		    
		    ' Set the pen dimensions.
		    pageImageGraphics.PenWidth = 1
		    pageImageGraphics.PenHeight = 1
		    
		    ' Draw the margin guides slightly wider than the content.
		    pageImageGraphics.DrawRect(FTUtilities.getScaledLength(doc.getLeftMargin, parentControl.getDisplayScale) - BORDER_OFFSET, _
		    FTUtilities.getScaledLength(doc.getTopMargin, parentControl.getDisplayScale) - BORDER_OFFSET, _
		    FTUtilities.getScaledLength(doc.getMarginWidth, parentControl.getDisplayScale) + (2 * BORDER_OFFSET), _
		    FTUtilities.getScaledLength(doc.getMarginHeight, parentControl.getDisplayScale) + (2 * BORDER_OFFSET))
		    
		  end if
		  
		  ' Call the user post-page drawing event.
		  parentControl.callPostPageDraw(pageImageGraphics, self, printing, printScale)
		  ' 
		  '---------------------------------------
		  ' Copy over the page.
		  '---------------------------------------
		  
		  ' Are we outputting to the display?
		  if not printing then
		    
		    ' Copy the picture to the display.
		    drawPage(g, doc.getClippingPage, pageLeft, pageTop, scale)
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function findParagraph(pageX as integer, pageY as integer, scale as double, sloppyX as boolean = false) As FTParagraphProxy
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  Try
		    Dim i as integer
		    Dim startParagraph as integer
		    Dim endParagraph as integer
		    
		    ' Are we in page view mode?
		    if parentControl.isPageViewMode then
		      
		      ' Get the number of paragraphs on the page.
		      endParagraph = Ubound(paragraphs)
		      
		    else
		      
		      ' Get the range of paragraphs to test.
		      startParagraph = startParagraphNormalMode
		      endParagraph = endParagraphNormalMode
		      
		    end if
		    
		    ' Scan the paragraphs.
		    for i = startParagraph to endParagraph
		      
		      ' Does this paragraph contain the point?
		      if paragraphs(i).isPointInParagraph((i <> 0), pageX, pageY, sloppyX, scale) then
		        
		        ' Return the paragraph.
		        return paragraphs(i)
		        
		      end if
		      
		    next
		    
		    ' Are we before the starting paragrapgh?
		    if paragraphs(startParagraph).isPointBeforeParagraph(pageY) then
		      
		      ' Scan the paragraphs.
		      for i = (startParagraph - 1) downto 0
		        
		        ' Does this paragraph contain the point?
		        if paragraphs(i).isPointInParagraph((i <> 0), pageX, pageY, sloppyX, scale) then
		          
		          ' Return the paragraph.
		          return paragraphs(i)
		          
		        end if
		        
		      next
		      
		      ' Are we after the ending paragraph?
		    elseif paragraphs(endParagraph).isPointAfterParagraph(true, pageY) then
		      
		      ' Reset the range to check.
		      startParagraph = endParagraph + 1
		      endParagraph = Ubound(paragraphs)
		      
		      ' Scan the paragraphs.
		      for i = startParagraph to endParagraph
		        
		        ' Does this paragraph contain the point?
		        if paragraphs(i).isPointInParagraph((i <> 0), pageX, pageY, sloppyX, scale) then
		          
		          ' Return the paragraph.
		          return paragraphs(i)
		          
		        end if
		        
		      next
		      
		    end if
		  Catch err As OutOfBoundsException
		    return nil
		  End try
		  ' We did not find it.
		  return nil
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function findParagraphIndex(y as integer) As integer
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim slot as integer
		  Dim height as double
		  Dim scale as double
		  
		  ' Find the starting slot.
		  slot = findPositionSlot(y, height)
		  
		  ' Get the number of paragraphs on the page.
		  count = Ubound(paragraphs)
		  
		  ' Get the scale.
		  scale = parentControl.getDisplayScale
		  
		  ' Scan the paragraphs.
		  for i = (slot * BIN_SIZE) to count
		    
		    ' Are we past the target?
		    if height >= y then return max(i - 1, 0)
		    
		    ' Add in the height of the paragraph.
		    height = height + paragraphs(i).getHeight(true, scale)
		    
		  next
		  
		  ' We did not find it.
		  return Max(count, 0)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function findParagraphPosition(position as integer) As integer
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim height as double
		  Dim scale as double
		  
		  ' Compute the number of blocks to add in.
		  count = position / BIN_SIZE
		  
		  ' Get the scale.
		  scale = parentControl.getDisplayScale
		  
		  ' Add in the blocks of paragraphs.
		  for i = 1 to count
		    
		    ' Add in the height of the block of paragraphs.
		    height = height + positions(i)
		    
		  next
		  
		  ' Add in the left over paragraphs.
		  for i = ((count * BIN_SIZE) + 1) to position
		    
		    ' Add in the height of the paragraph.
		    height = height + paragraphs(i - 1).getHeight((i - 1) <> 0, scale)
		    
		  next
		  
		  ' Return the starting height.
		  return height
		  
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
		  
		  Dim item as FTParagraphProxy
		  
		  ' Scan the page for the picture.
		  for each item in paragraphs
		    
		    ' Is this the one we are looking for?
		    if item.containsPicture(pic) then
		      
		      ' Get the picture coordinates.
		      return item.findPictureCoordinates(pic, picX, picY)
		      
		    end if
		    
		  next
		  
		  ' Not found.
		  picX = 0
		  picY = 0
		  
		  return false
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function findPositionSlot(y as integer, ByRef height as double) As integer
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  
		  ' Get the number of slots.
		  count = Ubound(positions)
		  
		  ' Initialize the height.
		  height = 0
		  
		  ' Find the slot.
		  for i = 1 to count
		    
		    ' Add in the height of the next slot.
		    height = height + positions(i)
		    
		    ' Is this height within this slot?
		    if y < height then
		      
		      ' Move back to the previous position.
		      height = height - positions(i)
		      
		      ' Return the slot number.
		      return Max(i - 1, 0)
		      
		    end if
		    
		  next
		  
		  ' Return the last slot.
		  return Max(count, 0)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getAbsolutePage() As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the absolute page number.
		  return absolutePage
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getBeginOffset() As FTInsertionOffset
		  'Return offset for the beginning of the page
		  Dim p As FTParagraph = paragraphs(0).getParent
		  Dim offset As Integer = p.getLineLength(0, paragraphs(0).getLineStart - 1)
		  return new FTInsertionOffset(doc, 0, offset, False)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getEndOffset() As FTInsertionOffset
		  'Return offset for the end of the page
		  Dim p As FTParagraph = paragraphs(UBound(paragraphs)).getParent
		  Dim offset As Integer = p.getLineLength(0, paragraphs(Ubound(paragraphs)).getLineEnd)
		  If paragraphs(UBound(paragraphs)).getLineEnd < (p.getLineCount - 1) Then
		    offset = offset - 1
		  End If
		  Return New FTInsertionOffset(doc, p.getAbsoluteIndex, offset, False)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getFirstLineId() As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim pp as FTParagraphProxy
		  Dim line as FTLine
		  
		  ' Is there anything to look at?
		  if Ubound(paragraphs) = -1 then return -1
		  
		  ' Get the proxy of the first paragraph.
		  pp = paragraphs(0)
		  
		  ' Does it contain a parent?
		  if pp.getParent is nil then return -1
		  
		  ' Are there any lines to look at?
		  if pp.getParent.getLineCount <= 0 then return -1
		  
		  ' Get the line.
		  line = pp.getParent.getLine(pp.getLineStart)
		  
		  ' Are we past the end of the lines?
		  if line is nil then return -1
		  
		  ' Return the ID of the first line on the page.
		  return pp.getParent.getLine(pp.getLineStart).getId
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getPageLineCount() As integer
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim sum as integer
		  
		  ' Get the number of paragraphs.
		  count = Ubound(paragraphs)
		  
		  ' Sum up the number of lines on a page.
		  for i = 0 to count
		    
		    ' Add in the lines from the proxy.
		    sum = sum + paragraphs(i).getLineCount
		    
		  next
		  
		  ' Return the number of lines on the page.
		  return sum
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getParagraph(index as integer) As FTParagraphProxy
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Are we in range?
		  if (index < 0) or (index > Ubound(paragraphs)) then return nil
		  
		  ' Return the paragraph.
		  return paragraphs(index)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getParagraphCount() As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the number of paragraphs.
		  return Ubound(paragraphs) + 1
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isPointAfterParagraphs(y as integer) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim count as integer
		  
		  ' Get the number of paragraphs on the page.
		  count = Ubound(paragraphs)
		  
		  ' Are there any paragraphs?
		  if count > -1 then
		    
		    ' Are we after the last paragraph?
		    return paragraphs(count).isPointAfterParagraph((count <> 0), y)
		    
		  else
		    
		    ' Return the default.
		    return false
		    
		  end if
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isPointBeforeParagraphs(y as integer) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Are there any paragraphs?
		  if Ubound(paragraphs) > -1 then
		    
		    ' Are we before the first paragraph?
		    return paragraphs(0).isPointBeforeParagraph(y)
		    
		  else
		    
		    ' Return the default.
		    return false
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub markAllParagraphsDirty()
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim pp as FTParagraphProxy
		  
		  ' Mark all the parent paragraphs as dirty.
		  for each pp in paragraphs
		    
		    ' Mark the parent paragraph as dirty.
		    pp.getParent.makeDirty
		    
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub markVisibleNormalModeParagraphsDirty()
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  
		  ' Mark all the parent paragraphs as dirty.
		  for i = startParagraphNormalMode to endParagraphNormalMode
		    
		    ' Mark the parent paragraph as dirty.
		    paragraphs(i).getParent.makeDirty
		    
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub removeParagraph(index as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Release the internal links.
		  paragraphs(index).clear
		  
		  ' Remove the paragraph.
		  paragraphs.remove(index)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub removeProxy(id as integer)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  
		  ' Get the number of proxies.
		  count = Ubound(paragraphs)
		  
		  ' Scan the list.
		  for i = 0 to count
		    
		    ' Is this the one we are looking for?
		    if paragraphs(i).getProxyId = id then
		      
		      ' Remove the proxy.
		      paragraphs.Remove(i)
		      
		      ' We are done.
		      return
		      
		    end if
		    
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setAbsolutePage(absolutePageNumber as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the page number.
		  absolutePage = absolutePageNumber
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setInsertionPointToEnd(beginning as boolean)
		  'Set the insertion point to either the beginning or end of the page
		  if beginning then
		    doc.setInsertionPoint(self.getBeginOffset, true)
		  else
		    doc.setInsertionPoint(self.getEndOffset, true)
		  end if
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private absolutePage As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private endParagraphNormalMode As integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private paragraphs() As FTParagraphProxy
	#tag EndProperty

	#tag Property, Flags = &h21
		Private positions() As integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private startParagraphNormalMode As integer
	#tag EndProperty


	#tag Constant, Name = BIN_SIZE, Type = Double, Dynamic = False, Default = \"25", Scope = Private
	#tag EndConstant

	#tag Constant, Name = BORDER_OFFSET, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant


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
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
