#tag Class
Protected Class FTPicture
Inherits FTObject
	#tag Event
		Function Ascent(scale as double) As double
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Calculate the ascent.
		  return (currentHeight * scaledHeightFactor * scale) + descent
		  
		End Function
	#tag EndEvent

	#tag Event
		Function Height(scale as double) As double
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Calculate the height.
		  return (currentHeight * scaledHeightFactor * scale) + (2 * descent)
		  
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
		  #pragma Unused rightPoint
		  
		  Dim target as Picture
		  Dim scale as double
		  Dim lineWidth as integer
		  
		  ' Does the display picture exist?
		  if display is nil then return
		  
		  ' Get the scale.
		  scale = getObjectScale(printing, printScale)
		  
		  ' Has the picture been scaled?
		  if scaledPicture is nil then
		    
		    ' Use the original picture.
		    target = display
		    
		  else
		    
		    ' Use the scaled picture.
		    target = scaledPicture
		    
		  end if
		  
		  ' Is the item selected?
		  if isSelected and (not resizeMode) and (not printing) then
		    
		    ' Get the color.
		    g.ForeColor = getObjectColor
		    
		    ' Save the dimensions.
		    saveSelectDimensions(x, lineTop, target.width, lineHeight)
		    
		    ' Get the width.
		    lineWidth = target.width
		    
		    ' Should we paint a background color?
		  elseif useBackgroundColor then
		    
		    ' Use the background color.
		    g.ForeColor = getBackgroundColor
		    
		    ' Are we printing?
		    if printing then
		      
		      ' Scale the width for printing.
		      lineWidth = getWidth(printScale)
		      
		    else
		      
		      ' Get the width.
		      lineWidth = target.width
		      
		    end if
		    
		  end if
		  
		  ' Draw the background color.
		  g.FillRect(x, lineTop, lineWidth, lineHeight)
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub PaintForeground(g as graphics, x as integer, y as integer, leftPoint as integer, rightPoint as integer, beforeSpace as double, afterSpace as double, printing as boolean, printScale as double)
		  
		  #If Not DebugBuild
		    
		    #Pragma BoundsChecking FTC_BOUNDSCHECKING
		    #Pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #Pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #EndIf
		  
		  
		  Dim Right As Integer
		  Dim bottom As Integer
		  Dim horizontalMiddle As Integer
		  Dim verticalMiddle As Integer
		  Dim imageHeight As Integer
		  Dim imageWidth As Integer
		  Dim target As Picture
		  Dim scale As Double
		  Dim p As Picture
		  
		  ' Does the display picture exist?
		  If display Is Nil Then Return
		  
		  ' Get the scale.
		  scale = getObjectScale(printing, printScale)
		  
		  ' Has the picture been scaled?
		  If scaledPicture Is Nil Then
		    
		    ' Use the original picture.
		    target = display
		    
		  Else
		    
		    ' Use the scaled picture.
		    target = scaledPicture
		    
		  End If
		  
		  ' Should we highlite the image?
		  If Not (printing Or resizeMode) Then
		    
		    ' Set the selection state of the image.
		    target = selectImage(target, isSelected)
		    
		  End If
		  
		  ' Get the width of the image.
		  imageWidth = target.width
		  imageHeight = target.Height
		  
		  ' Are we printing?
		  If printing Then
		    
		    ' Scale the image.
		    imageWidth = currentWidth * scaledWidthFactor * scale
		    imageHeight = currentHeight * scaledHeightFactor * scale
		    
		  End If
		  
		  ' Get the top of the image.
		  iTop = y - imageHeight + (nudge * scale)
		  
		  ' Are we printing?
		  If printing Then
		    
		    ' Is this a custom object?
		    If Self IsA FTCustom Then
		      
		      ' Create a picture for the custom item to draw on.
		      p = New Picture(imageWidth, imageHeight, parentControl.BIT_DEPTH)
		      
		      ' Call the custom item event.
		      PaintForeground(p.Graphics, x, y, leftPoint, rightPoint, beforeSpace, afterSpace, printing, printScale)
		      
		      ' Copy it to the page.
		      g.DrawPicture(p, x, y - p.Height)
		      
		      ' Release the picture.
		      p = Nil
		      
		    Else
		      
		      ' Copy it to the page using the original picture.
		      g.DrawPicture(originalPicture, x, y - imageHeight, imageWidth, imageHeight, _
		      0, 0, originalPicture.width, originalPicture.height)
		      
		    End If
		    
		  Else
		    
		    ' Allow custom objects to draw the picture.
		    PaintForeground(target.Graphics, x, y, leftPoint, rightPoint, _
		    beforeSpace, afterSpace, printing, printScale)
		    
		    ' Copy it to the page.
		    g.DrawPicture(target, x, iTop, imageWidth, imageHeight, 0, 0, target.width, target.height)
		    
		  End If
		  
		  ' Should we draw the resize handles?
		  If resizeMode And (Not printing) Then
		    
		    ' Reset the pen dimensions.
		    g.PenHeight = 1
		    g.PenWidth = 1
		    
		    ' Should we draw the resize handles?
		    If drawHandles And isResizable Then
		      
		      ' to get the same Handle-Sizes in HiDPI-Mode
		      Dim HANDLE_SIZE2 As Integer = If(Self.paragraph.parentControl.IsHiDPT, HANDLE_SIZE * 2, HANDLE_SIZE)
		      
		      ' Do some calculations.
		      Right = x + imageWidth
		      bottom = iTop + imageHeight - HANDLE_SIZE2 //y - HANDLE_SIZE2
		      horizontalMiddle = x + ((imageWidth - HANDLE_SIZE2) / 2)
		      verticalMiddle = iTop + ((imageHeight - HANDLE_SIZE2) / 2)
		      
		      '-------------------------
		      
		      ' Set the drawing color.
		      g.ForeColor = HANDLE_FILL_COLOR
		      
		      ' Do we have room for the horizontal handle?
		      If imageWidth > (HANDLE_SIZE2 * 2) Then
		        
		        ' Fill the upper handle.
		        g.fillRect(horizontalMiddle, bottom, HANDLE_SIZE2, HANDLE_SIZE2)
		        
		      End If
		      
		      ' Fill the corner handle.
		      g.fillRect(Right - HANDLE_SIZE2, bottom, HANDLE_SIZE2, HANDLE_SIZE2)
		      
		      ' Do we have room for the vertical handle?
		      If imageHeight > (HANDLE_SIZE2 * 2) Then
		        
		        ' Fill the lower handle.
		        g.fillRect(Right - HANDLE_SIZE2, verticalMiddle, HANDLE_SIZE2, HANDLE_SIZE2)
		        
		      End If
		      
		      '-------------------------
		      
		      ' Set the drawing color.
		      g.ForeColor = HANDLE_COLOR
		      
		      ' Do we have room for the horizontal handle?
		      If imageWidth > (HANDLE_SIZE2 * 2) Then
		        
		        ' Draw the upper handle.
		        g.DrawRect(horizontalMiddle, bottom, HANDLE_SIZE2, HANDLE_SIZE2)
		        
		      End If
		      
		      ' Draw the corner handle.
		      g.DrawRect(Right - HANDLE_SIZE2, bottom, HANDLE_SIZE2, HANDLE_SIZE2)
		      
		      ' Do we have room for the vertical handle?
		      If imageHeight > (HANDLE_SIZE2 * 2) Then
		        
		        ' Draw the lower handle.
		        g.DrawRect(Right - HANDLE_SIZE2, verticalMiddle, HANDLE_SIZE2, HANDLE_SIZE2)
		        
		      End If
		      
		    End If
		    
		    ' Should we draw a border?
		    If drawBorder Then
		      
		      ' Set the border color.
		      g.ForeColor = borderColor
		      
		      ' Draw the enclosing rectangle.
		      g.DrawRect(x, iTop, imageWidth, imageHeight)
		      
		    End If
		    
		  End If
		  
		  ' Draw the underline.
		  drawUnderline(0, g, imageWidth, x, y, printing, printScale)
		  
		  ' Marked indicator.
		  drawMark(g, imageWidth, x, y, printing, printScale)
		  
		  ' Draw the strike through.
		  drawStrikethrough(0, g, imageWidth, x, y, printing, printScale)
		  
		End Sub
	#tag EndEvent

	#tag Event
		Function PartialWidth(startIndex as integer, endIndex as integer, scale as double, startPosition as double) As double
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  #pragma Unused startIndex
		  #pragma Unused endIndex
		  #pragma Unused startPosition
		  
		  ' Return the width of the scaled picture.
		  return currentWidth * scaledWidthFactor * scale
		  
		End Function
	#tag EndEvent

	#tag Event
		Sub ScaleChanged()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim scale as double
		  Dim pWidth as integer
		  Dim pHeight as integer
		  
		  ' Adjust the display.
		  scale = parentControl.getDisplayScale
		  
		  ' Compute the scaled dimensions.
		  pWidth = currentWidth * scale
		  pHeight = currentHeight * scale
		  
		  ' Create a new picture.
		  display = createNewPicture(pWidth, pHeight, parentControl.BIT_DEPTH)
		  
		  ' Update the display picture.
		  display.Graphics.DrawPicture(originalPicture, 0, 0, display.width, display.height, _
		  0, 0, originalPicture.Width, originalPicture.Height)
		  
		  ' Is this a scaled picture?
		  if not (scaledPicture is nil) then
		    
		    ' Compute the scaled dimensions.
		    pWidth = currentWidth * scaledWidthFactor * scale
		    pHeight = currentHeight * scaledHeightFactor * scale
		    
		    ' Create a new picture.
		    scaledPicture = createNewPicture(pWidth, pHeight, parentControl.BIT_DEPTH)
		    
		    ' Update the scaled picture.
		    scaledPicture.Graphics.DrawPicture(originalPicture, 0, 0, scaledPicture.Width, _
		    scaledPicture.Height, 0, 0, originalPicture.Width, originalPicture.Height)
		    
		  end if
		  
		  ' Call the event.
		  ScaleChanged(getPicture.Graphics)
		  
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
		  
		  ' Return the width of the scaled picture.
		  return currentWidth * scaledWidthFactor * scale
		  
		End Function
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub adjustDisplay(pic as Picture)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim scale as double
		  Dim maxWidth as integer
		  Dim maxHeight as integer
		  Dim pWidth as integer
		  Dim pHeight as integer
		  
		  ' Is there a source picture?
		  if pic is nil then
		    
		    ' Release the picture.
		    display = nil
		    
		    ' Release the scaled picture.
		    resetScaled
		    
		    ' Reset the slope.
		    slope = 1.0
		    
		  else
		    
		    ' Get the display scale.
		    scale = parentControl.getDisplayScale
		    
		    ' Calculate the constraining dimensions.
		    maxWidth = FTUtilities.getScaledLength(parentControl.getDoc.getMarginWidth, scale)
		    maxHeight = FTUtilities.getScaledLength(parentControl.getDoc.getMarginHeight, scale)
		    
		    ' Compute the target dimensions.
		    pWidth = pic.Width * scale
		    pHeight = pic.Height * scale
		    
		    ' Save the current slope.
		    slope = pic.height / pic.width
		    
		    ' Check the dimensions of the picture.
		    checkDimensions(pWidth, pHeight, maxWidth, maxHeight, true)
		    
		    ' Do we have to allocate the picture?
		    if (display is nil) or (display.Width <> pWidth) or (display.height <> pHeight) then
		      
		      ' Create a new picture.
		      display = createNewPicture(pWidth, pHeight, parentControl.BIT_DEPTH)
		      
		      ' Release the scaled picture.
		      resetScaled
		      
		    end if
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub calculateScaleFactor()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Does the scaled picture exist?
		  if scaledPicture is nil then
		    
		    ' Reset the scale.
		    scaledWidthFactor = 1.0
		    scaledHeightFactor = 1.0
		    
		  else
		    
		    ' Calculate the scale factor.
		    scaledWidthFactor = scaledPicture.Width / display.Width
		    scaledHeightFactor = scaledPicture.Height / display.Height
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub callGotFocus()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Virtual method.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function callKeyDown(key as string) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  #pragma Unused key
		  
		  ' We did not handle the key.
		  return false
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub callLostFocus()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Virtual method.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub callMouseDown(x as integer, y as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  #pragma Unused x
		  #pragma Unused y
		  
		  ' Virtual method.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function callMouseDrag(x as integer, y as integer) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  #pragma Unused x
		  #pragma Unused y
		  
		  ' Virtual method.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub callMouseMovement(x as integer, y as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  #pragma Unused x
		  #pragma Unused y
		  
		  ' Virtual method.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub callMouseUp(x as integer, y as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  #pragma Unused x
		  #pragma Unused y
		  
		  ' Virtual method.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function callMouseWheel(x as integer, y as integer, deltaX as integer, deltaY as integer) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  #pragma Unused x
		  #pragma Unused y
		  #pragma Unused deltaX
		  #pragma Unused deltaY
		  
		  ' Virtual method.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub callPaint(g as Graphics, print as boolean, printScale as double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  #pragma Unused g
		  #pragma Unused print
		  #pragma Unused printScale
		  
		  ' Virtual method.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub callResize()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Does the scaled picture exist?
		  if not (scaledPicture is nil) then
		    
		    ' Update the scaled picture.
		    scaledPicture.Graphics.DrawPicture(display, 0, 0, _
		    scaledPicture.width, scaledPicture.height, _
		    0, 0, display.width, display.height)
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub callResized()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Does the scaled picture exist?
		  if not (scaledPicture is nil) then
		    
		    ' Update the scaled picture.
		    scaledPicture.Graphics.DrawPicture(display, 0, 0, _
		    scaledPicture.width, scaledPicture.height, _
		    0, 0, display.width, display.height)
		    
		    ' The support data needs an update.
		    markForUpdate
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function callSaveRTF(rtf as RTFWriter) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  #pragma Unused rtf
		  
		  ' Virtual method.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function callSaveXML(xmlDoc as XmlDocument) As XmlElement
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  #pragma Unused xmlDoc
		  
		  ' Virtual method.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeStyle(style as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Flip the attribute.
		  select case style
		    
		  case FTStyle.STYLE_UNDERLINE
		    
		    underline = not underline
		    
		  case FTStyle.STYLE_STRIKE_THROUGH
		    
		    strikeThrough = not strikeThrough
		    
		  case FTStyle.STYLE_PLAIN
		    
		    ' Turn off all styling.
		    underline = false
		    strikeThrough = false
		    textColor = &c000000
		    
		  end select
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub checkDimensions(ByRef newWidth as integer, ByRef newHeight as integer, maxWidth as integer, maxHeight as integer, sizeProportionally as boolean)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Is there anything to check?
		  if (maxWidth <= 0) or (maxHeight <= 0) then return
		  
		  ' Are we sizing proportionally?
		  if sizeProportionally then
		    
		    '------------------------------------------------
		    ' Proportional.
		    '------------------------------------------------
		    
		    ' Are we below the minimum?
		    if (newWidth < MINIMUM_LENGTH) or (newHeight < MINIMUM_LENGTH) then
		      
		      ' Is the height the greater difference?
		      if newWidth > newHeight then
		        
		        ' Adjust the dimensions to fit the minimum.
		        newWidth = MINIMUM_LENGTH
		        newHeight = (MINIMUM_LENGTH * originalPicture.height) / originalPicture.width
		        
		      else
		        
		        ' Adjust the dimensions to fit the minimum.
		        newHeight = MINIMUM_LENGTH
		        newWidth = (MINIMUM_LENGTH * originalPicture.width) / originalPicture.height
		        
		      end if
		      
		    else
		      
		      ' Is there a dimension greater than the maximums?
		      if newWidth >= maxWidth then
		        
		        ' Reset the dimensions.
		        newWidth = maxWidth
		        newHeight = Round(slope * maxWidth)
		        
		      elseif newHeight >= maxHeight then
		        
		        ' Reset the dimensions.
		        newHeight = maxHeight
		        newWidth = Round(slope * newHeight)
		        
		      end if
		      
		    end if
		    
		  else
		    
		    '------------------------------------------------
		    ' Non-proportional.
		    '------------------------------------------------
		    
		    ' Are we below the minimum width?
		    if newWidth < MINIMUM_LENGTH then
		      
		      ' Reset to the minimum.
		      newWidth = MINIMUM_LENGTH
		      
		      ' Are we past the maximum width?
		    elseif newWidth > maxWidth then
		      
		      ' Reset to the maximum.
		      newWidth = maxWidth
		      
		    end if
		    
		    ' Are we below the minimum height?
		    if newHeight < MINIMUM_LENGTH then
		      
		      ' Reset to the minimum.
		      newHeight = MINIMUM_LENGTH
		      
		      ' Are we past the maximum height?
		    elseif newHeight > maxHeight then
		      
		      ' Reset to the maximum.
		      newHeight = maxHeight
		      
		    end if
		    
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
		  
		  Dim ftp as FTPicture
		  
		  ' Create the clone.
		  ftp = new FTPicture(parentControl, originalPicture, true, true)
		  
		  ' Copy over the cache data.
		  ftp.hexPictureCache = hexPictureCache
		  ftp.rtfPictData = rtfPictData
		  ftp.scaledWidthFactor = scaledWidthFactor
		  ftp.scaledHeightFactor = scaledHeightFactor
		  
		  ' Copy the sub data.
		  copy(ftp)
		  
		  ' Return the clone.
		  return ftp
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(parentControl as FormattedText, p as Picture, generateNewID as boolean = true, isClone as boolean = false)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Don't kick a data update.
		  me.inhibitUpdates = isClone
		  
		  ' Save the parent Control.
		  Super.Constructor(parentControl, generateNewID)
		  
		  ' Add the picture.
		  setPicture(p)
		  
		  ' Set it back to normal.
		  me.inhibitUpdates = false
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1000
		Sub Constructor(parentControl as FormattedText, attributeList as XmlAttributeList, generateNewID as boolean = true)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim width as integer
		  Dim height as integer
		  Dim data as string
		  Dim length as double
		  
		  ' Save the parent Control.
		  super.Constructor(parentControl, attributeList, generateNewID)
		  
		  ' Load up the node attributes.
		  width = Val(attributeList.value(FTCxml.XML_WIDTH))
		  height = Val(attributeList.value(FTCxml.XML_HEIGHT))
		  data = attributeList.value(FTCxml.XML_DATA)
		  nudge = val(attributeList.value(FTCxml.XML_NUDGE))
		  
		  ' Add the picture.
		  setPictureHexData(width, height, data)
		  
		  '---------------------------------------------
		  
		  ' Get the length of the dimension.
		  length = Val(attributeList.value(FTCxml.XML_SCALED_WIDTH))
		  
		  ' Was it specified?
		  if length > 0 then
		    
		    ' Get the scaled picture dimension.
		    scaledWidthFactor = length / originalPicture.width
		    
		  else
		    
		    ' Not scaled.
		    scaledWidthFactor = 1.0
		    
		  end if
		  
		  '---------------------------------------------
		  
		  ' Get the length of the dimension.
		  length = Val(attributeList.value(FTCxml.XML_SCALED_HEIGHT))
		  
		  ' Was it specified?
		  if length > 0 then
		    
		    ' Get the scaled picture dimension.
		    scaledHeightFactor = length / originalPicture.Height
		    
		  else
		    
		    ' Not scaled.
		    scaledHeightFactor = 1.0
		    
		  end if
		  
		  '---------------------------------------------
		  
		  ' Set the size of the picture.
		  setPictureSize(width * scaledWidthFactor, height * scaledHeightFactor)
		  
		  ' Make sure everything is scaled correctly.
		  callScaleChanged
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(parentControl as FormattedText, obj as XmlElement, generateNewID as boolean = true)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim width as integer
		  Dim height as integer
		  Dim data as string
		  Dim length as double
		  
		  ' Save the parent Control.
		  super.Constructor(parentControl, obj, generateNewID)
		  
		  ' Load up the node attributes.
		  width = Val(obj.GetAttribute(FTCxml.XML_WIDTH))
		  height = Val(obj.GetAttribute(FTCxml.XML_HEIGHT))
		  data = obj.GetAttribute(FTCxml.XML_DATA)
		  nudge = val(obj.GetAttribute(FTCxml.XML_NUDGE))
		  
		  ' Add the picture.
		  setPictureHexData(width, height, data)
		  
		  '---------------------------------------------
		  
		  ' Get the length of the dimension.
		  length = Val(obj.GetAttribute(FTCxml.XML_SCALED_WIDTH))
		  
		  ' Was it specified?
		  if length > 0 then
		    
		    ' Get the scaled picture dimension.
		    scaledWidthFactor = length / originalPicture.width
		    
		  else
		    
		    ' Not scaled.
		    scaledWidthFactor = 1.0
		    
		  end if
		  
		  '---------------------------------------------
		  
		  ' Get the length of the dimension.
		  length = Val(obj.GetAttribute(FTCxml.XML_SCALED_HEIGHT))
		  
		  ' Was it specified?
		  if length > 0 then
		    
		    ' Get the scaled picture dimension.
		    scaledHeightFactor = length / originalPicture.Height
		    
		  else
		    
		    ' Not scaled.
		    scaledHeightFactor = 1.0
		    
		  end if
		  
		  '---------------------------------------------
		  
		  ' Set the size of the picture.
		  setPictureSize(width * scaledWidthFactor, height * scaledHeightFactor)
		  
		  ' Make sure everything is scaled correctly.
		  callScaleChanged
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function createNewPicture(width as integer, height as integer, bitDepth as integer) As Picture
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Create a new picture.
		  return new Picture(Max(width, MINIMUM_LENGTH), Max(height, MINIMUM_LENGTH), bitDepth)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub dump(sa() as string)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Header information.
		  sa.Append("Picture")
		  sa.Append("")
		  
		  ' Get the base information.
		  super.dump(sa)
		  
		  ' Get the information.
		  
		  ' Blank line.
		  sa.Append("")
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub findDeltas(x as integer, y as integer, ByRef dx as integer, ByRef dy as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim width as integer
		  Dim height as integer
		  Dim b as double
		  Dim scale as double
		  
		  ' Get the current scale
		  scale = parentControl.getDisplayScale
		  
		  ' Compute the y offset.
		  b = -(y + (slope * x))
		  
		  ' Compute the point on the diagonal.
		  dx = -b / (2 * slope)
		  dy = slope * dx
		  
		  ' Get the current dimensions.
		  getCurrentSize(width, height)
		  
		  ' Convert to deltas to reflect the change in object size.
		  dx = dx - (width * scale)
		  dy = dy - (height * scale)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getCurrentCursor() As MouseCursor
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the current cursor.
		  return currentCursor
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub getCurrentSize(ByRef width as integer, ByRef height as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Get the dimensions.
		  width = getWidth(1.0)
		  height = getHeight(1.0)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function getHighlightPicture(width as integer, height as integer) As Picture
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim highlightPic as Picture
		  Dim g as Graphics
		  
		  ' Create the highlight picture.
		  highlightPic = new Picture(width, height, parentControl.BIT_DEPTH)
		  
		  ' Get the graphics object.
		  g = highlightPic.graphics
		  
		  ' Are we in focus?
		  if parentControl.getFocusState then
		    
		    ' Set the in focus selection color.
		    g.ForeColor = HighlightColor
		    
		  else
		    
		    ' Set the out of focus selection color.
		    g.ForeColor = FTUtilities.OUT_OF_FOCUS_COLOR
		    
		  end if
		  
		  ' Fill in the highlight color.
		  g.FillRect(0, 0, width, height)
		  
		  ' Get the graphics object.
		  g = highlightPic.mask.graphics
		  
		  ' Set the mask.
		  g.ForeColor = RGB(100, 100, 100)
		  g.FillRect(0, 0, width, height)
		  
		  ' Return the picture.
		  return highlightPic
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getLength() As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Is there a picture in this object?
		  if display is nil then return 0
		  
		  ' Default to one unit.
		  return 1
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getOriginalPicture() As Picture
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the original picture.
		  return originalPicture
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getPicture() As Picture
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Was the scaled picture specified?
		  if scaledPicture is nil then
		    
		    ' Return the original picture.
		    return display
		    
		  else
		    
		    ' Return the scaled picture.
		    return scaledPicture
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getPictureHeight() As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the current picture height.
		  return (currentHeight * scaledHeightFactor * parentControl.getDisplayScale)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function getPictureHexData() As string
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim size as integer
		  Dim width as integer
		  Dim height as integer
		  Dim x as integer
		  Dim y as integer
		  Dim surface as RGBSurface
		  Dim mb as MemoryBlock
		  Dim c as Color
		  
		  ' Has it been computed?
		  if hexPictureCache = "" then
		    
		    ' Get the RGB surface.
		    surface = originalPicture.RGBSurface
		    
		    ' Get the dimensions.
		    width = originalPicture.width - 1
		    height = originalPicture.height - 1
		    
		    ' Calculate the size of the data.
		    size = (width + 1) * (height + 1) * CHUNK_SIZE
		    
		    ' Allocate a scratch pad.
		    mb = new MemoryBlock(size)
		    
		    ' Make sure we use little endian.
		    mb.LittleEndian = true
		    
		    ' Encode all the pixels.
		    for x = 0 to width
		      for y = 0 to height
		        
		        ' Move the pixel into the memory block.
		        c = surface.Pixel(x, y)
		        mb.Byte(i) = c.Red
		        mb.Byte(i + 1) = c.Green
		        mb.Byte(i + 2) = c.Blue
		        
		        ' Move to the next entry.
		        i = i + CHUNK_SIZE
		        
		      next
		    next
		    
		    ' Cache the data.
		    hexPictureCache = EncodeBase64(mb.StringValue(0, size), 0)
		    
		  end if
		  
		  ' Return the encoded string.
		  return hexPictureCache
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function getPictureRTFData() As string
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim p as Picture
		  
		  ' Has the data been calculated?
		  if rtfPictData = "" then
		    
		    ' Is there a scaled picture?
		    'BK 07Aug2012  No check to see if scaled picture actually exists before using.
		    'if (scaledHeightFactor <> 1.0) or (scaledWidthFactor <> 1.0) then
		    if scaledPicture <> Nil and (scaledHeightFactor <> 1.0 or scaledWidthFactor <> 1.0) then
		      
		      ' Use the scaled version.
		      p = scaledPicture
		      
		    else
		      
		      ' Use the original version.
		      p = originalPicture
		      
		    end if
		    
		    ' Convert the picture.
		    rtfPictData = RTFUtilities.convertPNG(p)
		    
		  end if
		  
		  ' Return the picture data.
		  return rtfPictData
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub getRTF(rtf as RTFWriter)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim savedData as boolean
		  
		  ' Get the RTF data from the custom object.
		  savedData = callSaveRTF(rtf)
		  
		  ' Is there data from the custom object?
		  if not savedData then
		    
		    ' Create a new subcontext.
		    rtf.startGroup
		    
		    ' Get the rest of the attributes.
		    super.getRTF(rtf)
		    
		    ' Set the picture data
		    rtf.setPicture(getPictureRTFData)
		    
		    ' Finish the context.
		    rtf.endGroup
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getScaledPicture() As Picture
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the scaled picture.
		  return scaledPicture
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub getXML(xmlDoc as XmlDocument, paragraph as XmlElement)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim node as XmlElement
		  
		  ' Get the data from the custom object?
		  node = callSaveXML(xmlDoc)
		  
		  ' Did we get custom object data?
		  if node is nil then
		    
		    ' Create the picture node.
		    node = xmlDoc.CreateElement(FTCxml.XML_FTPICTURE)
		    
		    ' Add the picture.
		    node.SetAttribute(FTCxml.XML_DATA, getPictureHexData)
		    
		  end if
		  
		  ' Load up the node attributes.
		  node.SetAttribute(FTCxml.XML_WIDTH, str(originalPicture.width))
		  node.SetAttribute(FTCxml.XML_HEIGHT, str(originalPicture.height))
		  node.SetAttribute(FTCxml.XML_SCALED_WIDTH, str(currentWidth * scaledWidthFactor))
		  node.SetAttribute(FTCxml.XML_SCALED_HEIGHT, Str(currentHeight * scaledHeightFactor))
		  node.SetAttribute(FTCXML.XML_NUDGE, Str(nudge))
		  
		  ' Load up the base attributes.
		  getBaseXML(xmlDoc, node)
		  
		  ' Add the node to the paragraph.
		  paragraph.AppendChild(node)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isPointInHandle(x as integer, y as integer) As Handle_Type
		  //BK NOTE:  
		  //05Aug2018:  Y is coming back with different values in HiDPI vs Non-HiDPI mode.
		  //Even though X seems to work find.
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim right as integer
		  Dim bottom as integer
		  Dim horizontalMiddle as integer
		  Dim middle as integer
		  Dim target as Picture
		  
		  ' Is the picture resizable?
		  If Not isResizable Then Return Handle_Type.None
		  
		  ' Has the picture been scaled?
		  if scaledPicture is nil then
		    
		    ' Use the original picture.
		    target = display
		    
		  else
		    
		    ' Use the scaled picture.
		    target = scaledPicture
		    
		  End If
		  
		  Dim AdjHandleSize As Integer
		  If Self.paragraph.parentControl.IsHiDPT Then
		    AdjHandleSize = HANDLE_SIZE * 2
		  Else
		    AdjHandleSize = HANDLE_SIZE
		  End
		  
		  //BK Issue 3709: FTPicture ignores 'nudge' Property while drawing Handles and resizing
		  Dim dScale As Double = Self.paragraph.parentControl.getDisplayScale
		  Dim iNudgeAdj As Integer = Me.nudge * dscale
		  
		  ' Do some calculations.
		  Right = target.width
		  bottom = target.height + iNudgeAdj
		  middle = (bottom - AdjHandleSize) / 2
		  horizontalMiddle = (Right - AdjHandleSize) / 2
		  
		  '-------------------------------------------------------
		  ' Right column of handles.
		  '-------------------------------------------------------
		  
		  ' Are we in the right column?
		  If (x >= (Right - AdjHandleSize)) And (x <= Right) Then
		    
		    ' Are we in the bottom right handle?
		    If (y >= (bottom - AdjHandleSize)) And (y <= bottom) Then
		      
		      Return Handle_Type.Bottom_Right
		      
		    End If
		    
		    ' Are we in the middle right handle?
		    If (y >= middle) And (y <= (middle + AdjHandleSize)) Then
		      
		      Return Handle_Type.Middle_Right
		      
		    End If
		    
		    ' We are done looking.
		    Return Handle_Type.None
		    
		  End If
		  
		  '-------------------------------------------------------
		  ' Middle column of handle.
		  '-------------------------------------------------------
		  
		  ' Are we in the middle column?
		  If (x >= horizontalMiddle) And (x <= (horizontalMiddle + AdjHandleSize)) Then
		    
		    ' Are we in the bottom middle handle?
		    If (y >= (bottom - AdjHandleSize)) And (y <= bottom) Then
		      
		      Return Handle_Type.Bottom_Middle
		      
		    End If
		    
		    ' We are done looking.
		    Return Handle_Type.None
		    
		  End If
		  
		  '-------------------------------------------------------
		  
		  ' It is not in a handle.
		  return Handle_Type.None
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isPointWithin(x as integer, y as integer) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim target as Picture
		  
		  ' Has the picture been scaled?
		  if scaledPicture is nil then
		    
		    ' Use the original picture.
		    target = display
		    
		  else
		    
		    ' Use the scaled picture.
		    target = scaledPicture
		    
		  end if
		  
		  Dim dScale As Double = Self.paragraph.parentControl.getDisplayScale
		  //BK Issue 3709: FTPicture ignores 'nudge' Property while drawing Handles and resizing
		  
		  Dim iNudgeAdj As Integer = Me.nudge * dscale
		  
		  ' Is the point within the picture?
		  If Self.paragraph.parentControl.IsHiDPT Then
		    Return (x >= 0) And (x * dScale<= target.width) And _
		    (y >= iNudgeAdj) And (y * dScale  <= target.height + iNudgeAdj)
		  Else
		    Return (x >= 0) And (x <= target.width) And _
		    (y >= iNudgeAdj) And (y <= target.height + iNudgeAdj)
		  End
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isResizable() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the default value for pictures.
		  return true
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isResizeMode() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the current state.
		  return resizeMode
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub markForUpdate()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Do we need to do anything?
		  if not inhibitUpdates then
		    
		    ' Clear the caches.
		    hexPictureCache = ""
		    rtfPictData = ""
		    
		    ' The RTF needs to be updated.
		    needsUpdate = true
		    
		    ' Restart the update data timer.
		    doc.restartUpdateData
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub resetScaled()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Clear the scaled picture.
		  scaledPicture = nil
		  
		  ' Reset the scale factor.
		  calculateScaleFactor
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub resetSize()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Reset the picture size to the original dimensions.
		  setPictureSize(originalPicture.Width, originalPicture.Height)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub resizePictureMouseDrag(handle as Handle_Type, picX as integer, picY as integer, x as integer, y as integer, sizeProportionally as boolean)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim deltaX as integer
		  Dim deltaY as integer
		  Dim pWidth as integer
		  Dim pHeight as integer
		  Dim maxWidth as integer
		  Dim maxHeight as integer
		  Dim scale as double
		  Dim ignore as integer
		  
		  '--------------------------------------------
		  ' Compute the amount to scale.
		  '--------------------------------------------
		  
		  ' Get the scale.
		  scale = parentControl.getDisplayScale
		  
		  ' Convert to page coordinates.
		  parentControl.convertDisplayToPageCoordinates(x, y, ignore, x, y)
		  
		  ' Are we using a scaled picture?
		  if scaledPicture is nil then
		    
		    ' Use the original picture.
		    pWidth = display.width
		    pHeight = display.height
		    
		  else
		    
		    ' Use the scaled picture.
		    pWidth = scaledPicture.width
		    pHeight = scaledPicture.height
		    
		  end if
		  
		  ' Should we size the image proportionally?
		  if sizeProportionally then
		    
		    ' Set the delta movement.
		    select case handle
		      
		    case Handle_Type.Middle_Right
		      
		      ' Compute the amount to add to the picture.
		      findDeltas(x - picX, pHeight, deltaX, deltaY)
		      
		    case Handle_Type.Bottom_Middle
		      
		      ' Compute the amount to add to the picture.
		      findDeltas(pWidth, y - picY, deltaX, deltaY)
		      
		    else
		      
		      ' Compute the amount to add to the picture.
		      findDeltas(x - picX, y - picY, deltaX, deltaY)
		      
		    end select
		    
		  else
		    
		    ' Set the delta movement.
		    select case handle
		      
		    case Handle_Type.Middle_Right
		      
		      ' Compute the amount to add to the picture.
		      deltaX = x - (picX + pWidth)
		      
		    case Handle_Type.Bottom_Middle
		      
		      ' Compute the amount to add to the picture.
		      deltaY = y - (picY + pHeight)
		      
		    case Handle_Type.Bottom_Right
		      
		      ' Compute the amount to add to the picture.
		      deltaX = x - (picX + pWidth)
		      deltaY = y - (picY + pHeight)
		      
		    else
		      
		      ' Nothing to do.
		      return
		      
		    end select
		    
		  end if
		  
		  '--------------------------------------------
		  ' Scale the image.
		  '--------------------------------------------
		  
		  ' Calculate the constraining dimensions.
		  maxWidth = FTUtilities.getScaledLength(parentControl.getDoc.getMarginWidth, scale)
		  maxHeight = FTUtilities.getScaledLength(parentControl.getDoc.getMarginHeight, scale)
		  
		  ' Compute the target dimensions.
		  pWidth = pWidth + deltaX
		  pHeight = pHeight + deltaY
		  
		  ' Check the dimensions of the picture.
		  checkDimensions(pWidth, pHeight, maxWidth, maxHeight, sizeProportionally)
		  
		  ' Are we back to the original size?
		  if (pWidth = display.Width) and (pHeight = display.Height) then
		    
		    ' Clear the scaled picture.
		    resetSize
		    
		  else
		    
		    ' Create the scaled picture.
		    scaledPicture = createNewPicture(pWidth, pHeight, parentControl.BIT_DEPTH)
		    
		  end if
		  
		  ' Calculate the scale factor.
		  calculateScaleFactor
		  
		  ' Do we need to reset the slope?
		  if not sizeProportionally then
		    
		    ' Recalculate the slope.
		    slope = scaledPicture.height / scaledPicture.width
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub scalePicture(scale as double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim newWidth as integer
		  Dim newHeight as integer
		  Dim p as Picture
		  
		  ' Compute the new dimensions.
		  newWidth = display.width * scale
		  newHeight = display.height * scale
		  
		  ' Create the scaled picture.
		  p = new Picture(newWidth, newHeight, parentControl.BIT_DEPTH)
		  
		  ' Scale the picture.
		  p.Graphics.DrawPicture(display, 0, 0, newWidth, newHeight, 0, 0, display.width, display.height)
		  
		  ' Set the picture.
		  setPicture(p)
		  
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

	#tag Method, Flags = &h21
		Private Function selectImage(target as Picture, highlight as boolean) As Picture
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim tintedPicture as Picture
		  Dim g as Graphics
		  
		  ' Should we tint the image with the highlight color?
		  if highlight then
		    
		    ' Clone the picture.
		    tintedPicture = new Picture(target.Width, target.Height, parentControl.BIT_DEPTH)
		    
		    ' Get the graphics object.
		    g = tintedPicture.graphics
		    
		    ' Copy over the original picture.
		    g.DrawPicture(target, 0, 0)
		    
		    ' Tint the picture to the highlight color.
		    g.DrawPicture(getHighlightPicture(target.width, target.height), 0, 0)
		    
		    ' Return the tinted picture.
		    return tintedPicture
		    
		  end if
		  
		  ' Return the picture.
		  return target
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setCursor(cursor as MouseCursor)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Has the cursor changed?
		  if parentControl.MouseCursor <> cursor then
		    
		    ' Set the cursor.
		    parentControl.MouseCursor = cursor
		    
		    ' Save the cursor.
		    currentCursor = cursor
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setDescent(descent as double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the descent.
		  me.descent = descent
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setDrawBorder(state as boolean)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Should we draw a border?
		  me.drawBorder = state
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setDrawHandles(state as boolean)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Should we draw the handles.
		  drawHandles = state
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setNudge(amount as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the nudge--up (-) or down (+).
		  nudge = amount
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setPicture(p as picture)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Create a picture to store the original picture.
		  originalPicture = new Picture(p.Width, p.Height, parentControl.BIT_DEPTH)
		  
		  ' Save the original picture.
		  originalPicture.Graphics.DrawPicture(p, 0, 0)
		  
		  ' Set up the display.
		  adjustDisplay(p)
		  
		  ' Draw the picture into the display buffer.
		  display.Graphics.DrawPicture(originalPicture, 0, 0, display.width, display.height, _
		  0, 0, originalPicture.width, originalPicture.height)
		  
		  ' The RTF needs to be updated.
		  markForUpdate
		  
		  ' Save the current dimensions.
		  currentWidth = display.width / parentControl.getDisplayScale
		  currentHeight = display.Height / parentControl.getDisplayScale
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub setPictureHexData(width as integer, height as integer, data as string)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim size as integer
		  Dim x as integer
		  Dim y as integer
		  Dim surface as RGBSurface
		  Dim mb as MemoryBlock
		  Dim p as Picture
		  
		  ' Strip off the base64 encoding.
		  data = DecodeBase64(data)
		  
		  ' Create a new picture.
		  p = new Picture(width, height, parentControl.BIT_DEPTH)
		  
		  ' Get the RGB surface.
		  surface = p.RGBSurface
		  
		  ' Is there any data to restore?
		  if data.lenb > 0 then
		    
		    ' Is this a 2.x format size?
		    if data.lenb = (width * height * CHUNK_SIZE) then
		      
		      ' Calculate the size of the data. (2.x format)
		      size = width * height * CHUNK_SIZE
		      
		      ' Make them zero based.
		      width = width - 1
		      height = height - 1
		      
		    else
		      
		      ' Calculate the size of the data. (1.x format)
		      size = (width + 1) * (height + 1) * CHUNK_SIZE
		      
		    end if
		    
		    ' Allocate a scratch pad.
		    mb = new MemoryBlock(size)
		    
		    ' Make sure we use little endian.
		    mb.LittleEndian = true
		    
		    ' Load up the data in to a memory block.
		    mb.StringValue(0, size) = data
		    
		    ' Load all the pixels.
		    for x = 0 to width
		      for y = 0 to height
		        
		        ' Restore the pixel.
		        surface.Pixel(x, y) = rgb(mb.Byte(i), mb.Byte(i + 1), mb.Byte(i + 2))
		        
		        ' Move to the next entry.
		        i = i + CHUNK_SIZE
		        
		      next
		    next
		    
		  end if
		  
		  ' Set the picture.
		  setPicture(p)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setPictureSize(width as integer, height as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim scale as double
		  
		  ' Get the display scale.
		  scale = parentControl.getDisplayScale
		  
		  ' Are we back to the original size?
		  if ((width * scale) = display.Width) and ((height * scale) = display.Height) then
		    
		    ' Clear the scaled picture.
		    resetScaled
		    
		    ' Adjust the display.
		    adjustDisplay(originalPicture)
		    
		  else
		    
		    ' Create the scaled picture.
		    scaledPicture = createNewPicture(width * scale, height * scale, parentControl.BIT_DEPTH)
		    
		    ' Reset the scale factors.
		    calculateScaleFactor
		    
		    ' Scale the picture.
		    scaledPicture.Graphics.DrawPicture(display, 0, 0, scaledPicture.width, scaledPicture.height, _
		    0, 0, display.width, display.height)
		    
		    ' Save the current slope.
		    slope = height / width
		    
		  end if
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setResizeMode(state as boolean)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Is there anything to do?
		  if resizeMode = state then return
		  
		  ' Turn on the draw handles.
		  setDrawHandles(true)
		  
		  ' Put the picture into resize mode.
		  resizeMode = state
		  
		  ' Set the focus.
		  if state then
		    
		    ' We got the focus.
		    callGotFocus
		    
		  else
		    
		    ' We lost the focus.
		    callLostFocus
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub updateData(force as boolean)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Should we do the update now?
		  if force or needsUpdate then
		    
		    ' Convert the picture.
		    call getPictureRTFData
		    
		    ' Set the hex cache.
		    call getPictureHexData
		    
		    ' Clear the flag.
		    needsUpdate = false
		    
		  end if
		  
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event PaintBackground(g as graphics, x as integer, y as integer, leftPoint as integer, rightPoint as integer, lineTop as double, lineHeight as double, printing as boolean, printScale as double)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event PaintForeground(g as graphics, x as integer, y as integer, leftPoint as integer, rightPoint as integer, beforeSpace as double, afterSpace as double, printing as boolean, printScale as double)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ScaleChanged(g as graphics)
	#tag EndHook


	#tag Property, Flags = &h0
		associatedFolderItem As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h0
		borderColor As Color
	#tag EndProperty

	#tag Property, Flags = &h21
		Private currentCursor As MouseCursor
	#tag EndProperty

	#tag Property, Flags = &h21
		Private currentHeight As integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private currentWidth As integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private descent As double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private display As Picture
	#tag EndProperty

	#tag Property, Flags = &h21
		Private drawBorder As boolean = true
	#tag EndProperty

	#tag Property, Flags = &h21
		Private drawHandles As boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private hexPictureCache As string
	#tag EndProperty

	#tag Property, Flags = &h21
		Private inhibitUpdates As boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private iTop As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private needsUpdate As boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private nudge As double = 0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private originalPicture As Picture
	#tag EndProperty

	#tag Property, Flags = &h21
		Private resizeMode As boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private rtfPictData As string
	#tag EndProperty

	#tag Property, Flags = &h21
		Private scaledHeightFactor As double = 1.0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private scaledPicture As Picture
	#tag EndProperty

	#tag Property, Flags = &h21
		Private scaledWidthFactor As double = 1.0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private slope As double = 1.0
	#tag EndProperty


	#tag Constant, Name = CHUNK_SIZE, Type = Double, Dynamic = False, Default = \"3", Scope = Private
	#tag EndConstant

	#tag Constant, Name = HANDLE_COLOR, Type = Color, Dynamic = False, Default = \"&c000000", Scope = Public
	#tag EndConstant

	#tag Constant, Name = HANDLE_FILL_COLOR, Type = Color, Dynamic = False, Default = \"&cCACACA", Scope = Public
	#tag EndConstant

	#tag Constant, Name = HANDLE_SIZE, Type = Double, Dynamic = False, Default = \"10\r", Scope = Public
	#tag EndConstant

	#tag Constant, Name = MINIMUM_LENGTH, Type = Double, Dynamic = False, Default = \"3", Scope = Public
	#tag EndConstant


	#tag Structure, Name = Untitled, Flags = &h0
		c(29) as color
	#tag EndStructure


	#tag Enum, Name = Handle_Type, Type = Integer, Flags = &h0
		None
		  Top_Left
		  Top_Middle
		  Top_Right
		  Middle_Left
		  Middle_Right
		  Bottom_Left
		  Bottom_Middle
		Bottom_Right
	#tag EndEnum


	#tag ViewBehavior
		#tag ViewProperty
			Name="borderColor"
			Visible=false
			Group="Behavior"
			InitialValue="&h000000"
			Type="Color"
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
