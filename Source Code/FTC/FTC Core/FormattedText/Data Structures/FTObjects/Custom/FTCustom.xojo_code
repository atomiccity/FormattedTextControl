#tag Class
Protected Class FTCustom
Inherits FTPicture
	#tag Event
		Sub PaintBackground(g as graphics, x as integer, y as integer, leftPoint as integer, rightPoint as integer, lineTop as double, lineHeight as double, printing as boolean, printScale as double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  #pragma Unused g
		  #pragma Unused x
		  #pragma Unused y
		  #pragma Unused leftPoint
		  #pragma Unused rightPoint
		  #pragma Unused lineTop
		  #pragma Unused lineHeight
		  #pragma Unused printing
		  #pragma Unused printScale
		  
		  ' Do nothing.
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub PaintForeground(g as graphics, x as integer, y as integer, leftPoint as integer, rightPoint as integer, beforeSpace as double, afterSpace as double, printing as boolean, printScale as double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim target as Picture
		  
		  #pragma Unused x
		  #pragma Unused y
		  #pragma Unused leftPoint
		  #pragma Unused rightPoint
		  #pragma Unused beforeSpace
		  #pragma Unused afterSpace
		  
		  if printing then
		    
		    ' Call the event for the custom object.
		    callPaint(g, printing, printScale)
		    
		  else
		    
		    target = getPicture
		    
		    ' Call the event for the custom object.
		    callPaint(target.Graphics, printing, printScale)
		    
		  end if
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub callDropObject(obj as DragItem, action as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Call the event.
		  DropObject(obj, action)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub callGotFocus()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim interval as integer
		  
		  ' Call the event.
		  interval = GotFocus
		  
		  ' Was a timer specified?
		  if interval > 0 then
		    
		    ' Create the timer.
		    idleTimer = new FTCustomTimer(self)
		    
		    ' Set up the idle time.
		    idleTimer.Period = interval
		    
		    ' Turn on the timer.
		    idleTimer.Mode = Timer.ModeMultiple
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub callIdle()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim time as integer
		  
		  ' Call the event.
		  time = idle
		  
		  ' Was a new time specified?
		  if time > 0 then
		    
		    ' Set the time in ticks.
		    idleTimer.Period = time
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function callKeyDown(key as string) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Call the event.
		  return KeyDown(key)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub callLostFocus()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Was a timer running?
		  if not (idleTimer is nil) then
		    
		    ' Turn off the timer.
		    idleTimer.Mode = Timer.ModeOff
		    
		    ' Release the memory.
		    idleTimer = nil
		    
		  end if
		  
		  ' The mouse has left the building!
		  mouseInside = false
		  
		  ' Call the event.
		  LostFocus
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub callMouseDown(x as integer, y as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim page as integer
		  Dim localX as integer
		  Dim localY as integer
		  
		  ' Get the coordinates of the object on the screen.
		  getLastDrawnCoordinates(page, localX, localY)
		  
		  ' Call the event.
		  MouseDown(x - localX, y - localY + getPictureHeight)
		  
		  ' Have we timed out?
		  dim time as integer = ticks
		  
		  if (time - iLastClickTime) < FTUtilities.getDoubleClickTime then
		    //double click
		    me.parentControl.CallObjectDoubleClick self
		  else
		    iLastClickTime = time
		  end
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function callMouseDrag(x as integer, y as integer) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim page as integer
		  Dim localX as integer
		  Dim localY as integer
		  
		  ' Get the coordinates of the object on the screen.
		  getLastDrawnCoordinates(page, localX, localY)
		  
		  ' Call the general mouse movement events.
		  callMouseMovement(x, y)
		  
		  ' Call the event.
		  return MouseDrag(x - localX, y - localY + getPictureHeight)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub callMouseMovement(x as integer, y as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Is this point on the same page?
		  if not isPointOnSamePage(x, y) then return
		  
		  ' Convert to local coordinates.
		  convertToLocalCoordinates(x, y)
		  
		  ' Are we inside the object?
		  if (x >= 0) and (x <= getPicture.Width) and _
		    (y >= 0) and (y <= getPicture.Height) then
		    
		    ' Were we previously outside the object?
		    if not mouseInside then
		      
		      ' Flip the flag.
		      mouseInside = true
		      
		      ' Call the event.
		      MouseEnter
		      
		    end if
		    
		  else
		    
		    ' Were we previously inside the object?
		    if mouseInside then
		      
		      ' Flip the flag.
		      mouseInside = false
		      
		      ' Call the event.
		      MouseExit
		      
		    end if
		    
		  end if
		  
		  ' Call the event.
		  MouseMove(x, y)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub callMouseUp(x as integer, y as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim page as integer
		  Dim localX as integer
		  Dim localY as integer
		  
		  ' Get the coordinates of the object on the screen.
		  getLastDrawnCoordinates(page, localX, localY)
		  
		  ' Call the event.
		  MouseUp(x - localX, y - localY + getPictureHeight)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function callMouseWheel(x as integer, y as integer, deltaX as integer, deltaY as integer) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim page as integer
		  Dim localX as integer
		  Dim localY as integer
		  
		  ' Get the coordinates of the object on the screen.
		  getLastDrawnCoordinates(page, localX, localY)
		  
		  ' Call the event.
		  return MouseWheel(x - localX, y - localY + getPictureHeight, deltaX, deltaY)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub callPaint(g as Graphics, print as boolean, printScale as double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set the color to white.
		  g.ForeColor = &cFFFFFF
		  
		  ' Erase the picture.
		  g.FillRect(0, 0, g.width, g.height)
		  
		  ' Call the event.
		  Paint(g, print, printScale)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub callResize()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Call the event.
		  Resize(getPicture.Graphics)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub callResized()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Call the event.
		  Resized(getPicture.Graphics)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function callSaveRTF(rtf as RTFWriter) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Call the event.
		  return SaveRTF(rtf)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function callSaveXML(xmlDoc as XmlDocument) As XmlElement
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim node as XmlElement
		  
		  ' Call the event.
		  node = SaveXML(xmlDoc)
		  
		  ' Return the node.
		  return node
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(parentControl as FormattedText, width as integer, height as integer, generateNewID as boolean = true)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim p as Picture
		  
		  ' Create the picture.
		  p = createNewPicture(width, height, parentControl.BIT_DEPTH)
		  
		  ' Save the parent Control.
		  Super.Constructor(parentControl, p, generateNewID)
		  
		  ' Call the open event.
		  Open
		  
		  ' Call the paint event.
		  callPaint(getOriginalPicture.Graphics, false, 1.0)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(parentControl as FormattedText, obj as XmlElement, generateNewID as boolean = true)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Call the user event.
		  OpenXML(obj)
		  
		  ' Save the parent Control.
		  super.Constructor(parentControl, obj, generateNewID)
		  
		  ' Call the open event.
		  Open
		  
		  ' Call the paint event.
		  callPaint(getOriginalPicture.Graphics, false, 1.0)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub convertToLocalCoordinates(ByRef x as integer, ByRef y as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim localX as integer
		  Dim localY as integer
		  Dim scale as double
		  Dim localPage as integer
		  Dim page as integer
		  
		  ' Get the scale.
		  scale = parentControl.getScale
		  
		  ' Get the coordinates of the object on the screen.
		  getLastDrawnCoordinates(localPage, localX, localY)
		  
		  ' Are we in a page view mode?
		  if parentControl.isPageViewMode then
		    
		    ' Convert to page coordinates.
		    parentControl.convertDisplayToPageCoordinates(x, y, page, x, y)
		    
		  else
		    
		    ' Convert to page coordinates.
		    parentControl.convertDisplayToPageCoordinates(x, y, page, x, y)
		    
		    ' Are we scaled down?
		    if scale < 1.0 then
		      
		      ' Convert to page coordinates.
		      parentControl.convertDisplayToPageCoordinates(localX * scale, localY * scale, page, localX, localY)
		      
		    else
		      
		      ' Convert to page coordinates.
		      parentControl.convertDisplayToPageCoordinates(localX, localY, page, localX, localY)
		      
		    end if
		    
		  end if
		  
		  ' Convert to local coordinates.
		  x = x - localX
		  y = y - localY + getPictureHeight
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isMouseInsideControl() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the current mouse state.
		  return mouseInside
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function isPointOnSamePage(x as integer, y as integer) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim localX as integer
		  Dim localY as integer
		  Dim localPage as integer
		  Dim page as integer
		  
		  ' Is this a page mode?
		  if parentControl.isPageViewMode then
		    
		    ' Get the coordinates of the object on the screen.
		    getLastDrawnCoordinates(localPage, localX, localY)
		    
		    ' Convert to page coordinates.
		    parentControl.convertDisplayToPageCoordinates(x, y, page, x, y)
		    
		    ' Are they on the same page?
		    return (localPage = page)
		    
		  else
		    
		    ' We are always on the same page in a non page mode.
		    return true
		    
		  end if
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub resetSize()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Reset to the original size.
		  super.resetSize
		  
		  ' Call the paint event.
		  callPaint(getOriginalPicture.Graphics, false, 1.0)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub updateContents()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Call the paint event.
		  callPaint(getOriginalPicture.Graphics, false, 1.0)
		  
		  ' Update the display.
		  parentControl.update(true, true)
		  
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event DropObject(obj as DragItem, action as integer)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event GotFocus() As integer
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Idle() As integer
	#tag EndHook

	#tag Hook, Flags = &h0
		Event KeyDown(key as string) As boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event LostFocus()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event MouseDown(x as integer, y as integer)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event MouseDrag(x as integer, y as integer) As boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event MouseEnter()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event MouseExit()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event MouseMove(x as integer, y as integer)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event MouseUp(x as integer, y as integer)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event MouseWheel(x as integer, y as integer, deltaX as integer, deltaY as integer) As boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Open()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event OpenXML(node as XmlElement)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Paint(g as Graphics, print as boolean, printScale as double)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Resize(g as Graphics)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Resized(g as Graphics)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event SaveRTF(rtf as RTFWriter) As boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event SaveXML(xmlDoc as XmlDocument) As XmlElement
	#tag EndHook


	#tag Property, Flags = &h21
		Private idleTimer As FTCustomTimer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private iLastClickTime As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mouseInside As boolean
	#tag EndProperty


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
