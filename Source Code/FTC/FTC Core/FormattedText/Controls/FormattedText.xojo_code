#tag Class
Protected Class FormattedText
Inherits TextInputCanvas
	#tag Event
		Function BaselineAtIndex(index as integer) As integer
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  dim io as FTInsertionOffset
		  io = TIC_GetInsertionOffsetFromOffset(index)
		  
		  if io is nil then
		    return 0
		  end if
		  
		  if doc is nil then
		    return 0
		  end if
		  
		  dim p as FTParagraph = doc.getParagraph(io.paragraph)
		  if p is nil then
		    return 0
		  end if
		  
		  dim lineIndex as integer
		  dim offsetIndex as integer
		  
		  p.findLine(0, io.offset, true, lineIndex, offsetIndex)
		  
		  dim oLine as FTLine = p.getLine(lineIndex)
		  
		  if oLine is nil then
		    return 0
		  end if
		  
		  dim yPos as integer = oLine.getYPos
		  
		  Return yPos
		End Function
	#tag EndEvent

	#tag Event
		Function CharacterAtPoint(x as integer, y as integer) As integer
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  dim io as FTInsertionOffset
		  
		  io = doc.findCharacterOffset(x, y)
		  
		  if io is nil then
		    return -1
		  end if
		  
		  dim offset as integer = TIC_GetOffsetFromInsertionOffset(io)
		  
		  return offset
		End Function
	#tag EndEvent

	#tag Event
		Sub Close()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Is there anything to do?
		  if doc is nil then return
		  
		  ' Turn off the threads.
		  doc.releaseThreads
		  
		  ' Call the user event.
		  Close
		  
		  ' Release all the data.
		  doc.dispose
		  undo.dispose
		  anchorLeft = nil
		  anchorOffset = nil
		  anchorRight = nil
		  currentInsertionOffset = nil
		  picDisplay = nil
		  doc = nil
		  imageResizeOffset = nil
		  insertionPointTimer = nil
		  lastEndPosition = nil
		  contextualInsertionOffset = nil
		  styleBinding = nil
		  undo = nil
		  updateTimer = nil
		  
		  ' Show the cursor.
		  setVisibleCursorState(true)
		  
		End Sub
	#tag EndEvent

	#tag Event
		Function ConstructContextualMenu(base as MenuItem, x as Integer, y as Integer) As Boolean
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Construct the contextual menu.
		  if IsHiDPT then
		    return callConstructContexualMenu(base, x * 2, y * 2)
		  else
		    return callConstructContexualMenu(base, x, y)
		  end
		End Function
	#tag EndEvent

	#tag Event
		Function ContextualMenuAction(hitItem as MenuItem) As Boolean
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Process the contextual menu event.
		  return callContextualMenuAction(hitItem)
		  
		End Function
	#tag EndEvent

	#tag Event
		Sub DiscardIncompleteText()
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  TIC_DeleteText( TIC_m_incompleteTextRange )
		  
		  TIC_m_incompleteTextRange = nil
		End Sub
	#tag EndEvent

	#tag Event
		Function DoCommand(command as string) As boolean
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  if RaiseEvent DoCommand(command) = true then
		    Return true
		  end if
		  
		  return TIC_DoCommand(command)
		End Function
	#tag EndEvent

	#tag Event
		Function DragEnter(obj As DragItem, action As Integer) As Boolean
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  #if TargetMacOS
		    
		    ' Turn off updates.
		    call setInhibitUpdates(true)
		    
		  #endif
		  
		  ' Call the user event.
		  return DragEnter(obj, action)
		  
		End Function
	#tag EndEvent

	#tag Event
		Sub DragExit(obj As DragItem, action As Integer)
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  #if TargetMacOS
		    
		    ' Turn on updates.
		    call setInhibitUpdates(false)
		    
		  #endif
		  
		  ' Call the user event.
		  DragExit(obj, action)
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub DropObject(obj As DragItem, action As Integer)
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  #if TargetMacOS
		    
		    ' Turn off updates.
		    call setInhibitUpdates(false)
		    
		  #endif
		  
		  ' Process the drop event.
		  callDropObject(obj, action)
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub EnableMenuItems()
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Process the enable menu items event.
		  callEnableMenuItems
		  
		End Sub
	#tag EndEvent

	#tag Event
		Function FontNameAtLocation(location as integer) As string
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  dim sr as FTStyleRun = TIC_GetStyleRunAtOffset(location)
		  
		  if sr is nil then
		    return ""
		  else
		    return sr.font
		  end if
		End Function
	#tag EndEvent

	#tag Event
		Function FontSizeAtLocation(location as integer) As integer
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  dim sr as FTStyleRun = TIC_GetStyleRunAtOffset(location)
		  
		  if sr is nil then
		    return 0
		  else
		    return sr.fontSize
		  end if
		End Function
	#tag EndEvent

	#tag Event
		Sub GotFocus()
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Process the focus event.
		  callGotFocus
		  
		End Sub
	#tag EndEvent

	#tag Event
		Function IncompleteTextRange() As TextRange
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  return TIC_m_incompleteTextRange
		End Function
	#tag EndEvent

	#tag Event
		Sub InsertText(text as string, range as TextRange)
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  if range = nil and TIC_m_incompleteTextRange <> nil then
		    range = TIC_m_incompleteTextRange
		  end if
		  
		  TIC_InsertText( text, range )
		  
		  TIC_m_incompleteTextRange = nil
		End Sub
	#tag EndEvent

	#tag Event
		Function IsEditable() As boolean
		  return true
		End Function
	#tag EndEvent

	#tag Event
		Sub LostFocus()
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  if AutoComplete then
		    if m_bAutoCompleteVisible then
		      return
		    end if
		  end if
		  
		  ' Process the lost focus event.
		  callLostFocus
		  
		End Sub
	#tag EndEvent

	#tag Event
		Function MouseDown(x as Integer, y as Integer) As Boolean
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Process the mouse down event.
		  if IsHiDPT then
		    return callMouseDown(x * 2, y * 2)
		  else
		    return callMouseDown(x, y)
		  end
		  
		End Function
	#tag EndEvent

	#tag Event
		Sub MouseDrag(x as Integer, y as Integer)
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Process the mouse drag event.
		  if IsHiDPT then
		    callMouseDrag(x * 2, y * 2)
		  else
		    callMouseDrag(x, y)
		  end
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseEnter()
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Process the mouse enter event.
		  callMouseEnter
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseExit()
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Process the mouse exit event.
		  callMouseExit
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseMove(X As Integer, Y As Integer)
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Process the mouse move event.
		  if IsHiDPT then
		    callMouseMove(x * 2, y * 2)
		  else
		    callMouseMove(x, y)
		  end
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseUp(x as Integer, y as Integer)
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Process the mouse up event.
		  if IsHiDPT then
		    callMouseUp(x * 2, y * 2)
		  else
		    callMouseUp(x, y)
		  end
		  
		End Sub
	#tag EndEvent

	#tag Event
		Function MouseWheel(X As Integer, Y As Integer, deltaX as Integer, deltaY as Integer) As Boolean
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Process the mouse wheel event.
		  if IsHiDPT then
		    return callMouseWheel(x*2, y*2, deltaX*2, deltaY*2)
		  else
		    return callMouseWheel(x, y, deltaX, deltaY)
		  end
		  
		End Function
	#tag EndEvent

	#tag Event
		Sub Open()
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Initialize the utilities module.
		  FTUtilities.initialize
		  
		  #if DebugBuild
		    
		    ' Set up the ID.
		    objectCountId = FTUtilities.getNewID
		    
		  #endif
		  
		  ' Turn off any updates.
		  call setInhibitUpdates(true)
		  
		  ' Get the double click time.
		  tripleClickTime = FTUtilities.getDoubleClickTime * 2
		  
		  #if false
		    ' Turn off erasure of the background to prevent
		    ' flickering under Win32.
		    EraseBackground = false
		    
		    ' Ignore scrollbar events during initialization.
		    inhibitScroll = true
		    
		    ' Adjust the display picture.
		    adjustDisplayPicture
		    
		    ' Set Accept Tabs = true
		    AcceptTabs = true
		    
		    ' Set AcceptFocus = true
		    AcceptFocus = true
		  #else
		    ' Ignore scrollbar events during initialization.
		    inhibitScroll = true
		    
		    ' Adjust the display picture.
		    adjustDisplayPicture
		  #endif
		  
		  ' Get the custom document.
		  doc = newDocument
		  
		  ' Was a custom document created?
		  if doc is nil then
		    
		    ' Create the document.
		    doc = new FTDocument(self, backgroundColor)
		    
		  end if
		  
		  ' Create the anchors.
		  anchorLeft = doc.newInsertionOffset(0, 0)
		  anchorRight = doc.newInsertionOffset(0, 0)
		  anchorOffset = doc.newInsertionOffset(0, 0)
		  lastEndPosition = doc.newInsertionOffset(0, 0)
		  
		  ' Create the undo manager.
		  undo = new FTCUndoManager(self, UndoLimit)
		  
		  ' Get the scrollbars.
		  openScrollbars
		  
		  ' Set up the mode.
		  checkDisplayMode
		  
		  ' Move the scrollbars into position.
		  adjustScrollbars
		  
		  ' Set the scrollbar parameters.
		  adjustScrollbarParameters
		  
		  ' Set up drop items.
		  setUpAcceptDrops
		  
		  ' Create an empty page.
		  doc.deleteAll
		  
		  ' Update the display.
		  draw
		  
		  ' Allow scrollbar events.
		  inhibitScroll = false
		  
		  ' Set the default tab stops.
		  getDoc.addDefaultTabStops(FTTabStop.TabStopType.Left, DefaultTabStop)
		  
		  ' Turn on updates.
		  call setInhibitUpdates(false)
		  
		  ' Create the insertion point timer to blink the insertion caret.
		  insertionPointTimer = new FTInsertionPointTimer(self)
		  
		  ' Create the update timer.
		  updateTimer = new FTUpdateTimer(self)
		  
		  ' Make sure the caret is off.
		  blinkCaret(false)
		  
		  ' Clear any undo activity.
		  undo.clear
		  
		  ' Set up an undo object for typing.
		  undo.startNewInsertion
		  
		  ' Flag the initialization period is over.
		  initialized = true
		  
		  ' Get everything started.
		  doc.markAllParagraphsDirty
		  doc.compose
		  doc.resetInsertionCaret
		  
		  ' Call the event.
		  Open
		  
		  ' Make sure the scrollbars and contents are up to date.
		  resize
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub Paint(g as Graphics, areas() as object)
		  #pragma unused areas
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  // -- Code modified by Sam Rowlands on May 2nd
		  Try
		    Dim isHIDPIMode as boolean = g.ScalingFactor <> 1
		    if isHIDPIMode <> isHIDPT then
		      // -- When changing, this is a bit of a nightmare, took me ages to track down
		      //    that the doc.resolution also needed updating. But finally it's done and
		      //    now it works correctly for me :)
		      
		      isHIDPT = isHIDPIMode
		      doc.setMonitorPixelsPerInch GetMonitorPixelsPerInch
		      resize
		    end if
		  end Try
		  // -- End Sam's modification
		  
		  ' Update the display.
		  if IsHiDPT then
		    'scale down the picture for rendering.
		    'Since adjustDisplayPicture scales by 2 for retina displays, we're always guaranteed
		    'to get an integer result when we divide by 2 here.
		    g.DrawPicture(picDisplay, 1, 1, picDisplay.Width/2, picDisplay.Height/2, 0, 0, picDisplay.Width, picDisplay.Height)
		  else
		    g.DrawPicture(picDisplay, 1, 1)
		  end
		  
		  ' Fill in the corner between the scrollbars.
		  drawCorner(g)
		  
		  ' Draw the border.
		  drawBorder(g)
		  
		  ' Call the user event.
		  Paint(g)
		  
		End Sub
	#tag EndEvent

	#tag Event
		Function RectForRange(byref range as TextRange) As REALbasic.Rect
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  if range is nil then
		    return nil
		  end if
		  
		  dim oLine as FTLine
		  dim lineOffset as integer
		  
		  if not TIC_GetLineAtCharacterIndex(doc, range.Location, oLine, lineOffset) then
		    return nil
		  end if
		  
		  if oLine = nil then
		    return nil
		  end
		  
		  dim iLineRemaining as integer = oLine.getLength - lineOffset
		  if iLineRemaining<range.Length then
		    range.Length = iLineRemaining
		  end if
		  
		  dim io as FTInsertionOffset
		  io = TIC_GetInsertionOffsetFromOffset(range.Location)
		  if io is nil then
		    return nil
		  end if
		  
		  dim p as FTParagraph = doc.getParagraph(io.paragraph)
		  if p is nil then
		    return nil
		  end if
		  
		  // NOTE:  A ton of work done in this section for the candiate window.
		  //        If you find an instance where it doesn't work please let us know!  - BKeeney Software
		  
		  Dim x, y As Integer
		  dim r as new REALbasic.Rect
		  
		  // Get the page.
		  Dim iPage As Integer = doc.getInsertionPoint.getCurrentProxyParagraph.getAbsolutePage
		  
		  ' Get the display coordinates based on the X, Y of the Caret
		  convertPageToDisplayCoordinates(iPage, TIC_xCaret, TIC_yCaret, x, y)
		  
		  If isPageViewMode Then
		    //PAGE VIEW MODE
		    x = x * Me.scale
		    y = y * Me.scale
		    
		    If Me.scale <= 1.0 Then
		      x = x + Self.xDisplayAlignmentOffset/Me.getDisplayScale
		    Else
		      x = x + Self.xDisplayAlignmentOffset/Me.getDisplayScale*Me.getScale
		      y = y - (5 * Me.getScale) //5 is an adjustment number that seems to work.
		    End
		    
		    
		  Elseif isNormalViewMode Then
		    //NORMAL VIEW
		    x = x * Me.scale
		    y = y * Me.scale
		    
		    If Me.scale <= 1.0 Then
		      x = x + Self.xDisplayAlignmentOffset/Me.getDisplayScale
		      y = y - (vScrollValue/Me.getDisplayScale) //vScrollValue is a negative value
		    Else
		      x = x + Self.xDisplayAlignmentOffset/Me.getDisplayScale*Me.getScale
		      y = y - (vScrollValue/Me.getDisplayScale*Me.getScale)//vScrollValue is a negative value
		      y = y - (5 * Me.getScale) //5 is an adjustment number that seems to work.
		    End
		    
		  Else
		    //OTHERS
		    x = x + Self.xDisplayAlignmentOffset/Me.getDisplayScale
		    y = y - (vScrollValue/Me.getDisplayScale) //vScrollValue is a negative value
		    
		  End
		  
		  r.top = y
		  r.Left = x
		  
		  
		  //Do not need a width.
		  r.Width = 0
		  
		  r.Height = oLine.getLineHeight(false, displayScale)
		  
		  return r
		End Function
	#tag EndEvent

	#tag Event
		Function SelectedRange() As TextRange
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  '
		  dim ioStart as FTInsertionOffset
		  dim ioEnd as FTInsertionOffset
		  
		  ' Was something selected?
		  if doc.isSelected then
		    
		    ' Get the selection range.
		    doc.getSelectionRange(ioStart, ioEnd)
		    
		  else
		    
		    ioStart = doc.getInsertionOffset.clone
		    ioEnd = ioStart.clone
		    
		  end
		  
		  
		  dim iStart as integer = TIC_GetOffsetFromInsertionOffset(ioStart)
		  
		  dim iEnd as integer = TIC_GetOffsetFromInsertionOffset(ioEnd)
		  
		  return new TextRange(iStart + 1, iEnd - iStart + 1)
		End Function
	#tag EndEvent

	#tag Event
		Sub SetIncompleteText(text as string, replacementRange as TextRange, relativeSelection as TextRange)
		  #pragma Unused replacementRange
		  #pragma Unused relativeSelection
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  if replacementRange = nil and TIC_m_incompleteTextRange <> nil then
		    replacementRange = TIC_m_incompleteTextRange
		  end if
		  
		  TIC_InsertText( text, replacementRange )
		  
		  if replacementRange <> nil then
		    TIC_m_incompleteTextRange = new TextRange( replacementRange.Location, text.len )
		  else
		    dim offset as integer = TIC_GetOffsetFromInsertionOffset(doc.getInsertionOffset)
		    TIC_m_incompleteTextRange = new TextRange( offset, text.len )
		  end if
		End Sub
	#tag EndEvent

	#tag Event
		Function TextForRange(range as TextRange) As string
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  if range is nil then
		    return ""
		  end if
		  
		  dim ioStart as FTInsertionOffset = TIC_GetInsertionOffsetFromOffset(range.Location)
		  
		  dim ioEnd as FTInsertionOffset = TIC_GetInsertionOffsetFromOffset(range.EndLocation)
		  
		  if ioStart is nil or ioEnd is nil then
		    return ""
		  end if
		  
		  return doc.getText(ioStart, ioEnd)
		End Function
	#tag EndEvent

	#tag Event
		Function TextLength() As integer
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  dim ctParagraph as integer = doc.getParagraphCount
		  
		  dim iLength as integer = doc.getLength
		  
		  if ctParagraph >1 then
		    iLength = iLength + ctParagraph - 1
		  end if
		  
		  return iLength
		End Function
	#tag EndEvent


	#tag MenuHandler
		Function EditClear() As Boolean Handles EditClear.Action
			
			#if not DebugBuild
			
			#pragma BoundsChecking FTC_BOUNDSCHECKING
			#pragma NilObjectChecking FTC_NILOBJECTCHECKING
			#pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
			
			#endif
			
			' Perform the clear action.
			editClearAction
			
			' We handled the event.
			return true
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function EditCopy() As Boolean Handles EditCopy.Action
			
			#if not DebugBuild
			
			#pragma BoundsChecking FTC_BOUNDSCHECKING
			#pragma NilObjectChecking FTC_NILOBJECTCHECKING
			#pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
			
			#endif
			
			' Perform the copy action.
			editCopyAction
			
			' We handled the event.
			return true
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function EditCut() As Boolean Handles EditCut.Action
			
			#if not DebugBuild
			
			#pragma BoundsChecking FTC_BOUNDSCHECKING
			#pragma NilObjectChecking FTC_NILOBJECTCHECKING
			#pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
			
			#endif
			
			' Perform the cut action.
			editCutAction
			
			' We handled the event.
			return true
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function EditPaste() As Boolean Handles EditPaste.Action
			
			#if not DebugBuild
			
			#pragma BoundsChecking FTC_BOUNDSCHECKING
			#pragma NilObjectChecking FTC_NILOBJECTCHECKING
			#pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
			
			#endif
			
			' Perform the paste action.
			editPasteAction
			
			' We handled the event.
			return true
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function EditRedo() As Boolean Handles EditRedo.Action
			
			#if not DebugBuild
			
			#pragma BoundsChecking FTC_BOUNDSCHECKING
			#pragma NilObjectChecking FTC_NILOBJECTCHECKING
			#pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
			
			#endif
			
			' Perform the redo action.
			editRedoAction
			
			' We handled the event.
			return true
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function EditUndo() As Boolean Handles EditUndo.Action
			
			#if not DebugBuild
			
			#pragma BoundsChecking FTC_BOUNDSCHECKING
			#pragma NilObjectChecking FTC_NILOBJECTCHECKING
			#pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
			
			#endif
			
			' Perform the undo action.
			editUndoAction
			
			' We handled the event.
			return true
			
		End Function
	#tag EndMenuHandler


	#tag Method, Flags = &h1
		Protected Sub adjustDisplayPicture()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim vWidth as integer
		  Dim hHeight as integer
		  Dim picWidth as integer
		  Dim picHeight as integer
		  
		  const DISPLAY_ADJUST = 2
		  
		  if self.Window.ScalingFactor <> 1 then
		    IsHiDPT = true
		  else
		    IsHiDPT = false
		  end
		  
		  '---------------------------------------------
		  ' Check the scrollbars.
		  '---------------------------------------------
		  
		  ' Does the vertical scrollbar exist?
		  if not (vScrollbar is nil) then
		    
		    ' Is the vertical scrollbar visible?
		    if vScrollbar.visible then
		      
		      ' Use the scrollbar dimension.
		      vWidth = (me.left + me.width) - vScrollbar.left - 1
		      
		    end if
		    
		  end if
		  
		  ' Does the horizontal scrollbar exist?
		  if not (hScrollbar is nil) then
		    
		    ' Is the horizontal scrollbar visible?
		    if hScrollbar.visible then
		      
		      ' Use the scrollbar dimension.
		      hHeight = (me.top + me.height) - hScrollbar.top - 1
		      
		    end if
		    
		  end if
		  
		  '---------------------------------------------
		  ' Adjust the display.
		  '---------------------------------------------
		  
		  ' Do we have to allocate the picture?
		  if picDisplay is nil then
		    
		    ' Calculate the sizes.
		    picWidth = Max(width - vWidth - DISPLAY_ADJUST, 1)
		    picHeight = Max(height - hHeight - DISPLAY_ADJUST, 1)
		    
		    ' Create a new picture.
		    if IsHiDPT then
		      picDisplay = new Picture(picWidth * 2, picHeight * 2, BIT_DEPTH)
		    else
		      picDisplay = new Picture(picWidth, picHeight, BIT_DEPTH)
		    end
		    
		  else
		    
		    ' Do we need to resize the picture?
		    if (picDisplay.Graphics.Width <> (width - vWidth)) or _
		      (picDisplay.Graphics.height <> (height - hHeight)) then
		      
		      ' Calculate the sizes.
		      picWidth = Max(width - vWidth - DISPLAY_ADJUST, 1)
		      picHeight = Max(height - hHeight - DISPLAY_ADJUST, 1)
		      
		      ' Create a new picture.
		      if IsHiDPT then
		        picDisplay = new Picture(picWidth * 2, picHeight * 2, BIT_DEPTH)
		      else
		        picDisplay = new Picture(picWidth, picHeight, BIT_DEPTH)
		      end
		      
		    end if
		    
		  end if
		  
		  ' Is there anything to do?
		  if doc is nil then return
		  
		  ' Reset the clipping page.
		  doc.adjustClippingPage
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub adjustScrollbarParameters()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim total as double
		  Dim forceUpdate as boolean
		  
		  '---------------------------------------------
		  ' Vertical scrollbar.
		  '---------------------------------------------
		  
		  ' Does the vertical scrollbar exist?
		  if not (vScrollbar is nil) then
		    
		    ' Get the total height of the display area.
		    total = doc.getTotalPageLength
		    
		    ' Is there anything to scroll?
		    if total > picDisplay.height then
		      
		      ' Set the vertical scrollbar limits.
		      vScrollbar.Maximum = total - picDisplay.height
		      vScrollbar.PageStep = picDisplay.height * 0.75
		      
		      ' Is the scrollbar invisible?
		      if VScrollbarAutoHide and (not VScrollbar.Visible) then
		        
		        ' Show the scrollbar.
		        VScrollbar.Visible = true
		        forceUpdate = true
		        
		      end if
		      
		    else
		      
		      ' Turn off the scroll bar.
		      vScrollbar.Maximum = 0
		      vScrollbar.PageStep = 0
		      
		      ' Are we hiding the scrollbar?
		      if VScrollbarAutoHide then
		        
		        ' Is the scrollbar visible?
		        if VScrollbar.Visible then
		          
		          ' Hide the scrollbar.
		          VScrollbar.Visible = false
		          forceUpdate = true
		          
		        end if
		        
		      end if
		      
		    end if
		    
		  end if
		  
		  '---------------------------------------------
		  ' Horizontal scrollbar.
		  '---------------------------------------------
		  
		  ' Does the horizontal scrollbar exist?
		  if not (hScrollbar is nil) then
		    
		    ' Get the total width of the display area.
		    total = (scale * doc.getPageWidthLength) + doc.getPageSpace
		    
		    ' Is there anything to scroll?
		    if total > picDisplay.width then
		      
		      ' Set the horizontal scrollbar limits.
		      hScrollbar.Maximum = total - picDisplay.width
		      hScrollbar.PageStep = total / 2
		      
		      ' Is the scrollbar invisible?
		      if HScrollbarAutoHide and (not HScrollbar.Visible) then
		        
		        ' Show the scrollbar.
		        HScrollbar.Visible = true
		        forceUpdate = true
		        
		      end if
		      
		    else
		      
		      ' Turn off the scroll bar.
		      hScrollbar.Maximum = 0
		      hScrollbar.PageStep = 0
		      
		      ' Are we hiding the scrollbar?
		      if HScrollbarAutoHide then
		        
		        ' Is the scrollbar visible?
		        if HScrollbar.Visible then
		          
		          ' Hide the scrollbar.
		          HScrollbar.Visible = false
		          forceUpdate = true
		          
		        end if
		        
		      end if
		      
		    end if
		    
		  end if
		  
		  '---------------------------------------------
		  
		  ' Do we need to update the contents?
		  if forceUpdate then resize
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub adjustScrollbars()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim h as boolean
		  Dim v as boolean
		  Dim delta as integer
		  
		  #if TargetMacOS
		    
		    Dim ignore as integer
		    Dim version as integer
		    
		    ' Get the Mac system version.
		    FTUtilities.getMacSystemVersion(ignore, version, ignore)
		    
		  #endif
		  
		  '---------------------------------------------
		  ' Get the scrollbar states.
		  '---------------------------------------------
		  
		  ' Does the vertical scrollbar exist?
		  if not (vScrollbar is nil) then
		    
		    ' Get the scrollbar state.
		    v = vScrollbar.visible
		    
		  else
		    
		    ' Scrollbar doesn't exist?
		    v = false
		    
		  end if
		  
		  ' Does the horizontal scrollbar exist?
		  if not (hScrollbar is nil) then
		    
		    ' Get the scrollbar state.
		    h = hScrollbar.visible
		    
		  else
		    
		    ' Scrollbar doesn't exist?
		    h = false
		    
		  end if
		  
		  '---------------------------------------------
		  ' Vertical scrollbar.
		  '---------------------------------------------
		  
		  ' Does the vertical scrollbar exist?
		  if not (vScrollbar is nil) then
		    
		    ' Move it into position.
		    vScrollbar.Top = me.Top + 1
		    vScrollbar.Left = me.Left + me.Width - vScrollbar.width - 1
		    
		    ' Does the horizontal scrollbar exist?
		    if h then
		      
		      ' Make room for the other scrollbar.
		      vScrollbar.Height = me.Height - hScrollbar.height
		      
		      #if TargetMacOS
		        
		        ' Is this Lion or greater?
		        if version >= 7 then
		          
		          ' Make it fit better.
		          vScrollbar.Height = vScrollbar.Height - 1
		          
		        end if
		        
		      #endif
		      
		      ' Add in the scrollbar.
		      delta = hScrollbar.height
		      
		    else
		      
		      ' Use a default.
		      vScrollbar.Height = me.Height - 2
		      
		      ' No scrollbar present.
		      delta = 0
		      
		    end if
		    
		    #If TargetWindows Or TargetLinux Then
		      
		      ' Make an adjustment
		      vScrollbar.Top = me.Top + 2
		      vScrollbar.Left = me.Left + me.Width - vScrollbar.width - 2
		      vScrollbar.Height = me.Height - delta - 4
		      
		    #endif
		    
		  end if
		  
		  '---------------------------------------------
		  ' Horizontal scrollbar.
		  '---------------------------------------------
		  
		  ' Does the horizontal scrollbar exist?
		  if not (hScrollbar is nil) then
		    
		    ' Move it into position.
		    hScrollbar.Top = me.Top + me.Height - hScrollbar.height
		    
		    #if TargetMacOS
		      
		      ' Is this Lion or greater?
		      if version >= 7 then
		        
		        ' Make it fit better.
		        hScrollbar.Top = hScrollbar.Top - 1
		        
		      end if
		      
		    #endif
		    
		    hScrollbar.Left = me.left + 1
		    
		    ' Does the vertical scrollbar exist?
		    if v then
		      
		      ' Make room for the other scrollbar.
		      hScrollbar.Width = me.Width - vScrollbar.width
		      
		      ' Add in the scrollbar.
		      delta = vScrollbar.width
		      
		    else
		      
		      ' Use a default.
		      hScrollbar.Width = me.width - 2
		      
		      ' No scrollbar present.
		      delta = 0
		      
		    end if
		    
		    #If TargetWindows Or TargetLinux Then
		      
		      ' Make an adjustment
		      hScrollbar.Top = me.Top + me.Height - hScrollbar.height - 2
		      hScrollbar.Left = me.left + 2
		      hScrollbar.width = me.Width - delta - 4
		      
		    #endif
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub appendFTC(target as FormattedText)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Add the data.
		  doc.appendFTC(target)
		  
		  ' Update the display.
		  update(true, true)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub audit()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  #if FTCConfiguration.FTC_AUDIT
		    
		    ' Perform an audit on the document.
		    doc.audit
		    
		  #endif
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub blinkCaret(state as boolean)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Are we in the read only mode?
		  if readOnly then return
		  
		  ' Is the control active?
		  if not focusState then return
		  
		  ' Should we disable the caret?
		  if doc.isSelected or inMouseDrag then return
		  
		  ' Are we in a picture resize mode?
		  if doc.isInResizeMode then return
		  
		  ' Set the caret state.
		  doc.blinkCaret(state)
		  
		  ' Update the display.
		  update
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function calculateDisplayAlignmentOffset(alignment as Display_Alignment) As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim offset as integer
		  
		  select case alignment
		    
		  Case Display_Alignment.CENTER
		    
		    ' Split the difference.
		    offset = (picDisplay.Width - (doc.getPageWidthLength * getScale)) / 2
		    
		    ' Make sure we are not negative.
		    return Max(offset, 0)
		    
		  Case Display_Alignment.Right
		    
		    ' Split the difference.
		    offset = picDisplay.Width - (doc.getPageWidthLength * getScale)
		    
		    ' Make sure we are not negative.
		    return Max(offset, 0)
		    
		  end select
		  
		  ' Left or unknown display alignment.
		  return 0
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function callBaseLineAtIndex(index as integer) As integer
		  dim io as FTInsertionOffset
		  io = TIC_GetInsertionOffsetFromOffset(index)
		  if io is nil then
		    return 0
		  end if
		  
		  if doc is nil then
		    return 0
		  end if
		  dim p as FTParagraph = doc.getParagraph(io.paragraph)
		  if p is nil then
		    return 0
		  end if
		  
		  dim lineIndex as integer
		  dim offsetIndex as integer
		  p.findLine(0, io.offset, true, lineIndex, offsetIndex)
		  dim oLine as FTLine = p.getLine(lineIndex)
		  if oLine is nil then
		    return 0
		  end if
		  
		  dim yPos as integer = oLine.getYPos
		  Return yPos
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CallCharacterAtPoint(x as integer, y as integer) As integer
		  dim io as FTInsertionOffset
		  io = doc.findCharacterOffset(x, y)
		  if io is nil then
		    return -1
		  end if
		  dim offset as integer = TIC_GetOffsetFromInsertionOffset(io)
		  return offset
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function callConstructContexualMenu(base as MenuItem, x as integer, y as integer) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim pic as FTObject
		  Dim p as FTParagraph
		  Dim offset as integer
		  Dim page as integer
		  Dim pageX as integer
		  Dim pageY as integer
		  Dim bias as boolean
		  Dim io as FTInsertionOffset
		  
		  ' Clear the target.
		  targetContextualMenuPicture = nil
		  
		  ' Save the insertion point.
		  contextualInsertionOffset = doc.getInsertionOffset
		  
		  ' Get the current insertion offset.
		  io = doc.getInsertionOffset
		  
		  ' Find the insertion point.
		  call doc.findInsertionPoint(x, y, bias)
		  
		  ' Convert to page coordinates.
		  convertDisplayToPageCoordinates(x, y, page, pageX, pageY)
		  
		  ' Get the offset info.
		  p = doc.getInsertionPoint.getCurrentParagraph
		  offset = doc.getInsertionPoint.getOffset.offset
		  
		  ' Restore the insertion offset.
		  doc.setInsertionPoint(io, false)
		  
		  ' Get the target picture.
		  pic = p.findPictureItem(pageX, pageY)
		  
		  ' Is this a picture?
		  if pic isa FTPicture then
		    
		    ' Save the target picture.
		    targetContextualMenuPicture = FTPicture(pic)
		    
		    ' Call the event on the object.
		    if pic.callConstructContextualMenu(base, x, y) then
		      
		      ' We are done.
		      return true
		      
		    end if
		    
		  end if
		  
		  ' Pass the call through.
		  return ConstructContextualMenu(base, x, y)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function callContextualMenuAction(hitItem as MenuItem) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim p as FTParagraph
		  Dim io as FTInsertionOffset
		  Dim result as boolean
		  
		  ' Get the offset info.
		  io = doc.getInsertionPoint.getOffset
		  
		  ' Get the paragraph.
		  p = doc.getParagraph(io.paragraph)
		  
		  ' Is there anything to do?
		  if p is nil then return false
		  
		  ' Is this a picture?
		  if not (targetContextualMenuPicture is nil) then
		    
		    ' Call the event on the object.
		    if targetContextualMenuPicture.callContextualMenuAction(hitItem) then return true
		    
		  end if
		  
		  ' Restore the insertion point.
		  doc.setInsertionPoint(contextualInsertionOffset, false)
		  
		  ' Pass the call through.
		  result = ContextualMenuAction(hitItem)
		  
		  ' We are done doing the mouse event.
		  inMouseDownEvent = false
		  
		  ' Clear the reference.
		  targetContextualMenuPicture = nil
		  
		  ' Return the result.
		  return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function callDefaultParagraphStyle() As FTParagraphStyle
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Call the user event.
		  return DefaultParagraphStyle
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub callDiscardIncompleteText()
		  TIC_DeleteText( TIC_m_incompleteTextRange )
		  TIC_m_incompleteTextRange = nil
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function callDoCommand(command as string) As Boolean
		  if not TIC_DoCommand(command) then
		    return false
		  end if
		  return true
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub callDrawLine(proxy as FTParagraphProxy, line as FTLine, g as graphics, drawBeforeSpace as boolean, firstIndent as integer, page as integer, x as double, y as double, leftPoint as integer, rightPoint as integer, alignment as FTParagraph.Alignment_Type, printing as boolean, printScale as double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' A line is being drawn.
		  DrawLine(proxy, line, g, drawBeforeSpace, firstIndent, page, _
		  x, y, leftPoint, rightPoint, alignment, printing, printScale)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub callDropObject(obj as DragItem, action as integer)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim targetOffset as FTInsertionOffset
		  Dim offset as FTInsertionOffset
		  Dim endOffset as FTInsertionOffset
		  Dim content as string
		  Dim selectStart as FTInsertionOffset
		  Dim selectEnd as FTInsertionOffset
		  Dim params() as string
		  Dim p as FTParagraph
		  Dim pic as FTPicture
		  Dim x as integer
		  Dim y as integer
		  Dim bias As Boolean
		  Dim bMovingCustomObject As Boolean
		  
		  ' Are we in read only mode?
		  if readOnly then return
		  
		  ' Was the drop handled?
		  if DropObject(obj, action) then return
		  
		  ' Compute the position.
		  if IsHiDPT then
		    //BK TODO
		    'RAS: 9 Jan 15 We need to offset the control from the mouse position
		    x = (me.MouseX * 2) - (me.left * 2)
		    y = (me.MouseY * 2) - (me.Top * 2)
		  else
		    'RAS: 9 Jan 15 We need to offset the control from the mouse position
		    x = me.MouseX - me.left
		    y = me.MouseY - me.Top
		  end if
		  
		  ' Are we in a picture?
		  if doc.isPointInPicture(x, y, vScrollValue, getDisplayHeight, p, pic) then
		    
		    ' Is this a custom object?
		    if pic isa FTCustom then
		      
		      ' Call the event.
		      FTCustom(pic).callDropObject(obj, action)
		      
		    end if
		    
		    ' We are done.
		    return
		    
		  end if
		  
		  ' Get the currently selected text.
		  doc.getSelectionRange(selectStart, selectEnd)
		  
		  ' Split the private data type.
		  params = split(obj.PrivateRawData(PRIVATE_DROP_TYPE), "/")
		  
		  ' Find the insertion offset.
		  call doc.findInsertionPoint(x, y, bias)
		  
		  ' Get the offset.
		  targetOffset = doc.getInsertionOffset
		  
		  ' Are we dropping on a selection?
		  if doc.isPositionSelected(targetOffset) then
		    
		    ' Is this drop from a FTC?
		    if obj.RawDataAvailable(PRIVATE_DROP_TYPE) then
		      
		      ' Is it from this control?
		      if params(0) = Str(me.Handle) then
		        
		        ' Ignore the drop.
		        return
		        
		      end if
		      
		    end if
		    
		  end if
		  
		  '----------------------------------------------------
		  
		  do
		    
		    ' Is there XML?
		    if obj.RawDataAvailable(XML_DATA_TYPE) then
		      
		      ' Is it from this control?
		      if params(0) = Str(me.Handle) then
		        
		        '----------------------------------------------------
		        ' Internal Move
		        '----------------------------------------------------
		        
		        ' Are we moving a custom object or picture?
		        if Ubound(params) > 0 then
		          
		          ' Create the from offset.
		          offset = doc.newInsertionOffset(Val(params(1)), Val(params(2)))
		          
		          ' Move the picture.
		          handleMovePicture(offset, targetOffset)
		          
		        else
		          
		          ' Move the text.
		          handleMoveContent(selectStart, selectEnd, targetOffset)
		          
		        end if
		        
		        ' Move on.
		        //Issue 4196: Remove GOTO Keywords from FTC
		        bMovingCustomObject = True
		        
		      else
		        
		        '----------------------------------------------------
		        ' XML Drop
		        '----------------------------------------------------
		        
		        ' Turn off any selected text.
		        doc.deselectAll
		        
		        ' Move the insertion pointer.
		        setInsertionPoint(targetOffset, true)
		        
		        ' Insert the XML.
		        insertXML(obj.RawData(XML_DATA_TYPE))
		        
		        ' Get the end offset.
		        endOffset = doc.getInsertionOffset
		        
		      end if
		      
		    elseif obj.PictureAvailable then
		      
		      '----------------------------------------------------
		      ' Picture Drop
		      '----------------------------------------------------
		      
		      ' Turn off any selected text.
		      doc.deselectAll
		      doc.deselectResizePictures
		      
		      ' Move the insertion pointer.
		      setInsertionPoint(targetOffset, true)
		      
		      ' Insert the picture.
		      insertPicture(obj.Picture, obj.FolderItem)
		      
		      ' Is there RTF?
		    elseif obj.RawDataAvailable(RTF_DATA_TYPE) then
		      
		      '----------------------------------------------------
		      ' RTF Drop
		      '----------------------------------------------------
		      
		      ' Turn off any selected text.
		      doc.deselectAll
		      
		      ' Move the insertion pointer.
		      setInsertionPoint(targetOffset, true)
		      
		      ' Insert the RTF.
		      insertRTF(obj.RawData(RTF_DATA_TYPE))
		      
		      ' Is there text?
		    elseif obj.TextAvailable then
		      
		      '----------------------------------------------------
		      ' Text Drop
		      '----------------------------------------------------
		      
		      ' Turn off any selected text.
		      doc.deselectAll
		      
		      ' Move the insertion pointer.
		      setInsertionPoint(targetOffset, true)
		      
		      ' Insert the text.
		      insertText(obj.Text)
		      
		    elseif obj.FolderItemAvailable then
		      
		      '----------------------------------------------------
		      ' File Drop
		      '----------------------------------------------------
		      
		      ' Can we handle it?
		      if not handleFolderDrop(obj.FolderItem, targetOffset) then
		        
		        ' Pass it on.
		        DropFolderItem(obj.FolderItem, targetOffset)
		        
		      end if
		      
		    end if
		    
		    '----------------------------------------------------
		    ' Finish Up
		    '----------------------------------------------------
		    
		    //Issue 4196: Remove GOTO Keywords from FTC
		    If bMovingCustomObject = False Then
		      //Do not call this code if moving a customobject.
		      
		      ' Get the end offset.
		      endOffset = doc.getInsertionOffset
		      
		      ' Get the content that was inserted.
		      content = doc.getXML(targetOffset, endOffset)
		      
		      ' Set up the drop undo.
		      undo.saveDrop(targetOffset, endOffset, content, selectStart, selectEnd)
		    End
		    
		    ' bottom:
		    
		    ' Are there more items to add?
		  loop until not obj.NextItem
		  
		  ' Send notification of the change.
		  TextChanged
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub callEnableMenuItems()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  '--------------------------------------
		  ' Edit menu items.
		  '--------------------------------------
		  
		  ' Enable the menu items.
		  if isClearActionAvailable then EditClear.Enable
		  if isCopyActionAvailable then EditCopy.Enable
		  if isCutActionAvailable then EditCut.Enable
		  if isPasteActionAvailable then EditPaste.Enable
		  
		  '--------------------------------------
		  ' Undo.
		  '--------------------------------------
		  
		  ' Can we do undo?
		  if isUndoActionAvailable then
		    
		    ' Enable the menu item.
		    EditUndo.Enable
		    
		    ' Set up the name of the undo menu item.
		    EditUndo.Text = Trim(FTCStrings.UNDO + " " + undo.getUndoName)
		    
		  else
		    
		    ' Reset the undo text.
		    EditUndo.Text = FTCStrings.UNDO
		    
		  end if
		  
		  '--------------------------------------
		  ' Redo.
		  '--------------------------------------
		  
		  'NOTE:  GETTING A COMPILE ERROR HERE?
		  'You are getting this error because your Menubar does not have
		  'a Redo command in the Edit menu.
		  'Solutions:
		  '1 - Add a Redo menu command in the Edit Menu, making sure it's is named EditRedo
		  '2 - Comment out the following bit of code.  Comment out to <End>
		  
		  ' Can we do redo?
		  if isRedoActionAvailable then
		    
		    ' Enable the menu item.
		    EditRedo.Enable
		    
		    ' Set up the name of the redo menu item.
		    EditRedo.Text = Trim(FTCStrings.REDO + " " + undo.getRedoName)
		    
		  else
		    
		    ' Reset the redo text.
		    EditRedo.Text = FTCStrings.REDO
		    
		  end if
		  
		  '<End>
		  
		  '--------------------------------------
		  
		  ' Call the user event.
		  EnableMenuItems
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CallFontNameAtLocation(location As Integer) As String
		  dim sr as FTStyleRun
		  sr = TIC_GetStyleRunAtOffset(location)
		  if sr is nil then
		    return ""
		  else
		    return sr.font
		  end If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function callFontSizeAtLocation(location as Integer) As integer
		  dim sr as FTStyleRun
		  sr = TIC_GetStyleRunAtOffset(location)
		  if sr is nil then
		    return 0
		  else
		    return sr.fontSize
		  end if
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub callGotFocus()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim fto as FTObject
		  
		  ' Show the cursor.
		  setVisibleCursorState(true)
		  
		  ' Turn off the auto enable state.
		  setEditMenuAutoEnable(false)
		  
		  ' Start the timers.
		  insertionPointTimer.start
		  updateTimer.start
		  
		  ' We have the focus.
		  focusState = true
		  
		  ' Get the current resize item.
		  fto = doc.getResizePicture
		  
		  ' Is this a custom object?
		  if (not (fto is nil)) and (fto isa FTCustom) then
		    
		    ' Inform the custom object.
		    FTCustom(fto).callGotFocus
		    
		  end if
		  
		  ' Turn the caret on.
		  blinkCaret(true)
		  
		  ' Call the user event.
		  GotFocus
		  
		  ' Update the display.
		  update(false, true)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub callInsertionPointChangedEvent(previousOffset as FTInsertionOffset, currentOffset as FTInsertionOffset)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Are we ready to call the event?
		  if initialized then
		    
		    ' Call the event.
		    InsertionPointChanged(previousOffset, currentOffset)
		    
		    ' Perform live spell checking.
		    checkSpellingLive(previousOffset, currentOffset)
		    
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub callInsertTextEvent(text as string, range as TextRange)
		  if range = nil and TIC_m_incompleteTextRange <> nil then
		    range = TIC_m_incompleteTextRange
		  end if
		  
		  TIC_InsertText( text, range )
		  TIC_m_incompleteTextRange = nil
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function callKeyDown(key as string) As boolean
		  
		  ' Note, this part of the software is the most critical for
		  ' determining the speed of the system. Be careful how you handle
		  ' key strokes!
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim saveUpdate As Boolean
		  Dim io as FTInsertionOffset
		  Dim startPosition as FTInsertionOffset
		  Dim endPosition as FTInsertionOffset
		  Dim p as FTParagraph
		  Dim menuKey as boolean
		  Dim time As Double
		  
		  ' Are we currently handling a mouse event?
		  if inMouseDownEvent then return true
		  
		  #if DebugBuild
		    
		    ' Save the total number of key strokes for optimization purposes.
		    keyStrokesTotal = keyStrokesTotal + 1
		    
		    ' Time the key stroke update.
		    time = Microseconds
		    
		  #endif
		  
		  ' Hide the cursor.
		  setVisibleCursorState(false)
		  
		  ' Turn off updates.
		  saveUpdate = setInhibitUpdates(true)
		  
		  '----------------------------------------------
		  ' Adjust the insertion point.
		  '----------------------------------------------
		  
		  ' Get the paragraph with the insertion point.
		  p = doc.getInsertionPoint.getCurrentParagraph
		  
		  ' Are we past the end of the paragraph?
		  if doc.getInsertionOffset.offset > p.getLength then
		    
		    ' Bring it back into the paragraph.
		    doc.setInsertionPoint(p, p.getLength, false)
		    
		  end if
		  
		  '----------------------------------------------
		  ' Menu keys.
		  '----------------------------------------------
		  
		  ' Are any of the arrow keys being pressed?
		  if not isArrowKeyPressed then
		    
		    #if TargetMacOS
		      
		      ' Is the menu accelerator pressed?
		      menuKey = Keyboard.CommandKey
		      
		    #elseif TargetWindows or TargetLinux
		      
		      ' Is the menu accelerator pressed?
		      menuKey = Keyboard.ControlKey and (not Keyboard.AltKey)
		      
		    #endif
		    
		    ' Was a menu accelerator being pressed?
		    if menuKey and not ((asc(Key) = 8) or (asc(Key) = 127)) then
		      
		      ' Turn on updates.
		      call setInhibitUpdates(saveUpdate)
		      
		      ' We didn't handle it.
		      return false
		      
		    end if
		    
		  end if
		  
		  '----------------------------------------------
		  ' AutoComplete processing.
		  '----------------------------------------------
		  if AutoComplete then
		    if key=Chr(9) then
		      handleAutoCompleteKey
		      //BKS Issue 4196: Remove GOTO Keywords from FTC 
		      Return callKeyDownExit(saveUpdate, time)
		    end if
		  end if
		  
		  '----------------------------------------------
		  ' Arrow and page key processing.
		  '----------------------------------------------
		  
		  ' Arrow keys.
		  if handleArrowKeys then
		    callSelectionChangedEvent()
		    //BKS Issue 4196: Remove GOTO Keywords from FTC 
		    Return callKeyDownExit(saveUpdate, time)
		  end
		  
		  ' Page keys.
		  if handlePageKeys(saveUpdate) then
		    
		    ' We handled it.
		    return true
		    
		  end if
		  
		  '----------------------------------------------
		  ' Picture processing.
		  '----------------------------------------------
		  
		  ' Is a picture selected?
		  if doc.isInResizeMode then
		    
		    ' Send the key to the object.
		    if doc.getResizePicture.callKeyDown(key) then
		      
		      ' Exit the event.
		      //BKS Issue 4196: Remove GOTO Keywords from FTC 
		      Return callKeyDownExit(saveUpdate, time)
		      
		    else
		      
		      ' Is the the delete key?
		      if asc(Key) = 8 or asc(Key) = 127 then
		        
		        ' Is this the normal delete key?
		        if asc(Key) = 8 then
		          
		          ' Move the insertion point to allow the delete.
		          doc.setInsertionPoint(doc.getInsertionOffset + 1, false)
		          
		        end if
		        
		      else
		        
		        ' Move the insertion point to allow the delete.
		        doc.setInsertionPoint(doc.getInsertionOffset + 1, false)
		        
		        ' Delete the content.
		        call handleDeleteKeys(Chr(8))
		        
		        ' Clear the resize picture.
		        doc.setResizePicture
		        
		      end if
		      
		    end if
		    
		  end if
		  
		  '----------------------------------------------
		  ' Delete key processing.
		  '----------------------------------------------
		  
		  ' Delete keys.
		  if handleDeleteKeys(key) then
		    
		    ' Exit out.
		    //BKS Issue 4196: Remove GOTO Keywords from FTC 
		    Return callKeyDownExit(saveUpdate, time)
		    
		  end if
		  
		  '----------------------------------------------
		  ' Enter key processing.
		  '----------------------------------------------
		  
		  ' Is this the enter key?
		  if Keyboard.AsyncKeyDown(&h04C) then
		    
		    ' Translate to an end of line character.
		    key = EndOfLine.Macintosh
		    
		  else
		    
		    ' Filter out unused keys.
		    If filterKeys(key) Then 
		      //BKS Issue 4196: Remove GOTO Keywords from FTC 
		      Return callKeyDownExit(saveUpdate, time)
		    end
		    
		  end if
		  
		  '----------------------------------------------
		  ' Normal key processing.
		  '----------------------------------------------
		  
		  ' Are we in the read only mode?
		  If readOnly Then 
		    //BKS Issue 4196: Remove GOTO Keywords from FTC 
		    Return callKeyDownExit(saveUpdate, time)
		  End
		  
		  ' Is something selected?
		  if doc.isSelected then
		    
		    ' Check for selected text being deleted.
		    saveUndoDelete(FTCStrings.DELETE)
		    
		    ' Get the selection range.
		    doc.getSelectionRange(startPosition, endPosition)
		    
		    ' Use the start position.
		    io = startPosition
		    
		  else
		    
		    ' Use the insertion point.
		    io = doc.getInsertionPoint.getOffset
		    
		  end if
		  
		  ' Move the insertion point for the undo.
		  undo.saveTyping(key, io)
		  
		  
		  if key=EndOfLine then
		    doc.compose
		  end if
		  
		  ' Allow filtering of the key press.
		  KeyPress(key)
		  
		  ' set that we are typing
		  me.doc.isTyping = true
		  
		  ' Insert the key press.
		  doc.insertString(key, styleBinding)
		  
		  ' Reset that we are typing
		  me.doc.isTyping = false
		  
		  ' Reset the style binding.
		  setStyleBinding
		  
		  ' Send notification of the change.
		  TextChanged
		  
		  '----------------------------------------------
		  ' Exit code.
		  '----------------------------------------------
		  
		  Return callKeyDownExit(saveUpdate, time)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function callKeyDownExit(saveUpdate as boolean, time as double) As boolean
		  '----------------------------------------------
		  ' Exit code.
		  '----------------------------------------------
		  //BKS Issue 4196: Remove GOTO Keywords from FTC 
		  //This method created to easily get rid of GoTo statements
		  //that were in callKeyDown method
		  
		  
		  ' Make sure the insertion caret is showing.
		  doc.blinkCaret(true)
		  
		  ' Turn on updates.
		  Call setInhibitUpdates(saveUpdate)
		  
		  ' Update the display.
		  updateFlag = true
		  scrollToCaretFlag = true
		  
		  #if DebugBuild
		    
		    ' Save the total key stroke time.
		    keyTimeTotal = keyTimeTotal + (Microseconds - time)
		    
		  #endif
		  
		  ' We handled the key.
		  return true
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub callLostFocus()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim fto as FTObject
		  
		  ' Stop the timers.
		  insertionPointTimer.stop
		  updateTimer.stop
		  
		  ' Turn the caret off.
		  blinkCaret(false)
		  
		  ' Get the current resize item.
		  fto = doc.getResizePicture
		  
		  ' Is this a custom object?
		  if (not (fto is nil)) and (fto isa FTCustom) then
		    
		    ' Inform the custom object.
		    FTCustom(fto).callLostFocus
		    
		  end if
		  
		  ' We lost the focus.
		  focusState = false
		  
		  ' Reset the auto enable state.
		  setEditMenuAutoEnable(true)
		  
		  ' Call the user event.
		  LostFocus
		  
		  ' Update the display.
		  update(false, true)
		  
		  ' Show the cursor.
		  setVisibleCursorState(true)
		  
		  ' Set the arrow cursor.
		  setMouseCursor(nil)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function callMouseDown(x as integer, y as integer) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim p as FTParagraph
		  Dim pic as FTPicture
		  
		  ' Clear the custom object reference.
		  targetCustomObject = nil
		  
		  ' Call the user event.
		  if MouseDown(x, y) then return false
		  
		  ' Signal we are in a mouse down sequence.
		  inMouseDownEvent = true
		  
		  ' Is something selectd?
		  if (not doc.isSelected) then
		    
		    ' Record when the mouse was clicked down.
		    absoluteMouseDownTime = ticks
		    
		  end if
		  
		  ' Make sure we got the focus.
		  me.SetFocus
		  
		  ' Clear the flags.
		  inMouseDrag = false
		  inDragAndDrop = false
		  
		  ' Initialize the resize picture references.
		  currentResizePicture = doc.getResizePicture
		  targetResizePicture = nil
		  
		  ' Is this a contextual menu click?
		  if IsContextualClick then return false
		  
		  ' Initialize the image size containers.
		  imageResizeWidthOld = -1
		  imageResizeHeightOld = -1
		  imageResizeWidthNew = -1
		  imageResizeHeightNew = -1
		  imageResizeOffset = nil
		  
		  ' Clear the multi-click anchors.
		  anchorLeft.clear
		  anchorRight.clear
		  anchorType = 0
		  
		  ' Handle picture resize mode.
		  if handlePictureResize(x, y) then
		    
		    ' Process the mouse down.
		    handleMouseDown(x, y)
		    
		  end if
		  
		  ' Set up double and triple click timing.
		  handleClickCount(x, y)
		  
		  ' Handle the clicks.
		  handleClicks(x, y)
		  
		  ' Are we in resize mode and this is in a picture?
		  if doc.isInResizeMode and _
		    doc.isPointInPicture(x, y, vScrollValue, picDisplay.height, p, pic) then
		    
		    ' Save the resize picture.
		    if not ReadOnly then targetResizePicture = pic
		    
		    ' Has picture changed?
		    if not (pic is doc.getResizePicture) then
		      
		      ' Deselect all the pictures.
		      doc.deselectResizePictures
		      
		      ' Set the picture in resize mode.
		      doc.setResizePicture(pic, p, x, y)
		      
		    end if
		    
		    ' Is this a custom object?
		    if pic isa FTCustom then
		      
		      ' Save the reference.
		      targetCustomObject = FTCustom(pic)
		      
		    end if
		    
		  else
		    
		    ' Are we in resize mode?
		    if doc.isInResizeMode then
		      
		      ' Deselect all the pictures.
		      doc.deselectResizePictures
		      
		    elseif (not doc.isSelected) and _
		      doc.isPointInPicture(x, y, vScrollValue, picDisplay.height, p, pic) then
		      
		      ' Save the resize picture.
		      if not ReadOnly then targetResizePicture = pic
		      
		      ' Has picture changed?
		      if not (pic is doc.getResizePicture) then
		        
		        ' Deselect all the pictures.
		        doc.deselectResizePictures
		        
		        ' Set the picture in resize mode.
		        doc.setResizePicture(pic, p, x, y)
		        
		      end if
		      
		      ' Is this a custom object?
		      if pic isa FTCustom then
		        
		        ' Save the reference.
		        targetCustomObject = FTCustom(pic)
		        
		      end if
		      
		    end if
		    
		  end if
		  
		  ' Was the click in a custom object?
		  if not (targetCustomObject is nil) then _
		  targetCustomObject.callMouseDown(x, y)
		  
		  ' Save the original mouse down coordinates.
		  mouseDownX = x
		  mouseDownY = y
		  mouseDragX = x
		  mouseDragY = y
		  
		  ' Set up an undo object for typing.
		  undo.startNewInsertion(doc.getInsertionPoint.getOffset)
		  
		  ' We will handle the event.
		  return true
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub callMouseDrag(x as integer, y as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim left as integer
		  Dim top as integer
		  Dim newTop as integer
		  Dim oldPage as FTPage
		  Dim page as FTPage
		  
		  ' Scroll it into view.
		  scrollToMouse(x, y)
		  
		  ' Save the current position.
		  mouseDragX = x
		  mouseDragY = y
		  
		  ' Turn off the caret.
		  doc.blinkCaret(false)
		  
		  ' Call the user event.
		  MouseDrag(x, y)
		  
		  ' Set the mouse pointer.
		  setMousePointer(x, y)
		  
		  ' Is a picture in resize mode?
		  If doc.isInResizeMode Then
		    
		    ' Has one of the handles been grabbed?
		    if doc.getResizeHandle <> FTPicture.Handle_Type.None then
		      
		      ' Has the original image size been set?
		      if imageResizeOffset is nil then
		        
		        ' Save the original dimensions of the picture.
		        imageResizeWidthOld = doc.getResizePicture.getWidth(1.0)
		        imageResizeHeightOld = doc.getResizePicture.getHeight(1.0)
		        imageResizeWidthNew = imageResizeWidthOld
		        imageResizeHeightNew = imageResizeHeightOld
		        imageResizeOffset = doc.getInsertionOffset
		        
		      else
		        
		        ' Update the new image size.
		        imageResizeWidthNew = doc.getResizePicture.getWidth(1.0)
		        imageResizeHeightNew = doc.getResizePicture.getHeight(1.0)
		        
		      end if
		      
		      ' Find the coordinates of the picture.
		      call findPictureCoordinates(doc.getResizePicture, oldPage, left, top)
		      
		      ' Are we in edit mode?
		      if not isPageViewMode then
		        
		        ' Adjust the coordinates of the picture.
		        top = top - vScrollValue
		        left = left - hScrollValue
		        
		      end if
		      
		      ' Process the drag event on the picture.
		      doc.getResizePicture.resizePictureMouseDrag(doc.getResizeHandle, left, top, _
		      x, y, not Keyboard.AsyncOptionKey)
		      
		      ' Has the original image size been set?
		      if imageResizeOffset is nil then
		        
		        ' Save the original dimensions of the picture.
		        imageResizeWidthOld = doc.getResizePicture.getWidth(1.0)
		        imageResizeHeightOld = doc.getResizePicture.getHeight(1.0)
		        imageResizeWidthNew = imageResizeWidthOld
		        imageResizeHeightNew = imageResizeHeightOld
		        imageResizeOffset = doc.getInsertionOffset
		        
		      else
		        
		        ' Update the new image size.
		        imageResizeWidthNew = doc.getResizePicture.getWidth(1.0)
		        imageResizeHeightNew = doc.getResizePicture.getHeight(1.0)
		        
		      end if
		      
		      ' Signal the picture was resized.
		      doc.getResizePicture.callResize
		      
		      ' Update the display.
		      updatePartial(1, 1)
		      
		      ' Find the coordinates of the picture.
		      call findPictureCoordinates(doc.getResizePicture, page, left, newTop)
		      
		      ' Was the page found?
		      if not (page is nil) then
		        
		        ' Has the picture position changed?
		        if oldPage.getAbsolutePage <> page.getAbsolutePage then
		          
		          ' Scroll to the new page.
		          vScrollTo(doc.getPageTop(page.getAbsolutePage, getScale))
		          
		        end if
		        
		      end if
		      
		    else
		      
		      ' Call the mouse drag event.
		      if not doc.getResizePicture.callMouseDrag(x, y) then
		        
		        ' Should we drag the picture?
		        if (not inMouseDrag) and _
		          ((ticks - absoluteMouseDownTime) > DRAG_THRESHOLD) and _
		          (clickCount = 1) then
		          
		          ' Drag the picture.
		          handlePictureDrag(x, y)
		          
		        end if
		        
		      end if
		      
		    end if
		    
		  else
		    
		    ' Should we drag the selection?
		    if (not inMouseDrag) and doc.isSelected and _
		      ((ticks - absoluteMouseDownTime) > DRAG_THRESHOLD) and _
		      (clickCount = 1) then
		      
		      ' Handle the content drag.
		      call handleContentDrag(x, y)
		      
		    else
		      
		      ' Normal mouse drag selection.
		      mouseDragSelection(x, y)
		      
		    end if
		    
		  end if
		  
		  ' Turn on the caret.
		  doc.blinkCaret(true)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub callMouseEnter()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Call the user event.
		  MouseEnter
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub callMouseExit()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Show the cursor.
		  setVisibleCursorState(true)
		  
		  ' Reset the cursor.
		  setMouseCursor(nil)
		  
		  ' Call the user event.
		  MouseExit
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub callMouseMove(x as integer, y as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Show the cursor.
		  setVisibleCursorState(true)
		  
		  ' Call the user event.
		  MouseMove(x, y)
		  
		  ' Set the mouse pointer.
		  setMousePointer(x, y)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub callMouseUp(x as integer, y as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Did we just handle a drop?
		  if not inDragAndDrop then
		    
		    ' Is this a single click?
		    if (clickCount = 1) and ((targetResizePicture = nil) or _
		      (currentResizePicture <> targetResizePicture)) then
		      
		      ' Should we do something with the single click?
		      call handleSingleClick(x, y)
		      
		    end if
		    
		    ' Are we in resize mode?
		    if (not (targetResizePicture is nil)) and doc.isInResizeMode then
		      
		      ' Turn on the handles.
		      targetResizePicture.setDrawHandles(true)
		      
		      ' Set the appropriate cursor.
		      setHandleCursor(FTPicture.Handle_Type.None)
		      
		      ' Signal the picture was resized.
		      targetResizePicture.callResized
		      
		      ' Mark the paragraph as dirty.
		      doc.getResizeParagraph.makeDirty
		      
		      ' Send notification of the change.
		      TextChanged
		      
		      ' Update the display.
		      update(true, true)
		      
		    end if
		    
		    ' Has the picture resize been set?
		    if not (imageResizeOffset is nil) then
		      
		      ' Save the image change.
		      undo.saveImageChange(imageResizeOffset, _
		      imageResizeWidthOld, imageResizeHeightOld, _
		      doc.getResizePicture.getWidth(1.0), doc.getResizePicture.getHeight(1.0))
		      
		    end if
		    
		    ' Set the mouse pointer.
		    setMousePointer(x, y)
		    
		    ' Was a custom object clicked on?
		    if not (targetCustomObject is nil) then _
		    targetCustomObject.callMouseUp(x, y)
		    
		    ' Call the user event.
		    MouseUp(x, y)
		    
		  end if
		  
		  ' Set the anchor on the selection.
		  doc.setAnchor
		  
		  ' We are done doing the mouse event.
		  inMouseDownEvent = false
		  currentResizePicture = nil
		  targetResizePicture = nil
		  inMouseDrag = false
		  inDragAndDrop = false
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function callMouseWheel(x as integer, y as integer, deltaX as integer, deltaY as integer) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Are we in picture resize mode?
		  if doc.isInResizeMode then
		    
		    ' Call the mouse wheel event.
		    if doc.getResizePicture.callMouseWheel(x, y, deltaX, deltaY) then
		      
		      ' We are done.
		      return true
		      
		    end if
		    
		  end if
		  
		  ' Scroll the canvas.
		  mouseWheelScroll(hScrollbar, vScrollbar, deltaX, deltaY)
		  
		  ' Call the user event.
		  return MouseWheel(x, y, deltaX, deltaY)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function callNewPage() As FTPage
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Call the user event.
		  return NewPage
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CallObjectDoubleClick(obj as FTObject)
		  RaiseEvent ObjectDoubleClick obj
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub callPostPageDraw(g as graphics, p as FTPage, printing as boolean, printScale as double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Call the user event.
		  PostPageDraw(g, p, printing, printScale)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub callPrePageDraw(g as graphics, p as FTPage, printing as boolean, printScale as double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Call the user event.
		  PrePageDraw(g, p, printing, printScale)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub callSelectionChangedEvent()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Call the event.
		  SelectionChanged
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CallSetIncompleteText(text as string, replacementRange as TextRange, relativeSelection as TextRange)
		  #Pragma Unused relativeSelection
		  
		  if replacementRange = nil and TIC_m_incompleteTextRange <> nil then
		    replacementRange = TIC_m_incompleteTextRange
		  end if
		  
		  TIC_InsertText( text, replacementRange )
		  
		  if replacementRange <> nil then
		    TIC_m_incompleteTextRange = new TextRange( replacementRange.Location, text.len )
		  else
		    dim offset as integer = TIC_GetOffsetFromInsertionOffset(doc.getInsertionOffset)
		    TIC_m_incompleteTextRange = new TextRange( offset, text.len )
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function callSpellCheckParagraphEvent(text as string) As FTSpellCheckWord()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim words() as FTSpellCheckWord
		  Dim empty() as FTSpellCheckWord
		  
		  ' Spell check the paragraph.
		  words = SpellCheckParagraph(text)
		  
		  ' Did we get a result?
		  if words is nil then
		    
		    ' Return an empty list.
		    return empty
		    
		  end if
		  
		  ' Return the words.
		  return words
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub callTextChanged()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Call the text changed event.
		  TextChanged
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function callTextForRange(range as TextRange) As string
		  if range is nil then
		    return ""
		  end if
		  dim ioStart as FTInsertionOffset = TIC_GetInsertionOffsetFromOffset(range.Location)
		  dim ioEnd as FTInsertionOffset = TIC_GetInsertionOffsetFromOffset(range.EndLocation)
		  if ioStart is nil or ioEnd is nil then
		    return ""
		  end if
		  return doc.getText(ioStart, ioEnd)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function callTextLength() As integer
		  dim ctParagraph as integer = doc.getParagraphCount
		  dim iLength as integer = doc.getLength
		  if ctParagraph>1 then
		    iLength = iLength + ctParagraph - 1
		  end if
		  return iLength
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub callUnrecognizedXmlObject(attributeList as XmlAttributeList)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Handle the unrecognized object.
		  UnrecognizedXmlObjectFromAttributeList(attributeList)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub callUnrecognizedXmlObject(obj as XmlElement)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Handle the unrecognized object.
		  UnrecognizedXmlObject(obj)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub callXmlDecodeTag(data as string, obj as FTBase)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Is there anything to do?
		  if data <> "" then
		    
		    ' Decode the tag.
		    XmlDecodeTag(DecodeBase64(data), obj)
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function callXmlEncodeTag(obj as FTBase) As string
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Encode the tag.
		  return XmlEncodeTag(obj)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function callXmlObjectCreate(attributeList as XmlAttributeList) As FTObject
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim fto as FTObject
		  
		  ' Create the custom object.
		  ' RaiseEvent for user to handle.
		  fto = XmlObjectCreateFromAttributeList(attributeList)
		  
		  ' Return the new display object.
		  return fto
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function callXmlObjectCreate(obj as XmlElement) As FTObject
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim fto as FTObject
		  
		  ' Create the custom object.
		  ' RaiseEvent for user to handle.
		  fto = XmlObjectCreate(obj)
		  
		  ' Return the new display object.
		  return fto
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeBackgroundColor()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim startPosition as FTInsertionOffset
		  Dim endPosition as FTInsertionOffset
		  Dim sr as FTStyleRun
		  Dim style as FTCharacterStyle
		  Dim originalContent as string
		  Dim newContent as string
		  
		  ' Are we in the read only mode?
		  if readOnly then return
		  
		  ' Is there anything selected?
		  if doc.isSelected then
		    
		    ' Get the selection range.
		    doc.getSelectionRange(startPosition, endPosition)
		    
		    ' Get the original content.
		    originalContent = doc.getXML(startPosition, endPosition)
		    
		    ' Toggle the selected text state.
		    doc.changeBackgroundColor(startPosition, endPosition)
		    
		    ' Get the updated content.
		    newContent = doc.getXML(startPosition, endPosition)
		    
		    ' Save the style change.
		    undo.saveContent(FTCStrings.BACKGROUND_COLOR, startPosition, endPosition, originalContent, newContent)
		    
		  else
		    
		    ' Are we in the middle of a word?
		    if doc.findWordBoundaryAtInsertion(startPosition, endPosition) then
		      
		      ' Get the original content.
		      originalContent = doc.getXML(startPosition, endPosition)
		      
		      ' Toggle the selected text state.
		      doc.changeBackgroundColor(startPosition, endPosition)
		      
		      ' Get the updated content.
		      newContent = doc.getXML(startPosition, endPosition)
		      
		      ' Save the style change.
		      undo.saveContent(FTCStrings.BACKGROUND_COLOR, startPosition, endPosition, originalContent, newContent)
		      
		    else
		      
		      ' Get the current insertion style and the current style run.
		      findInsertionReferences(style, sr)
		      
		      ' Set the attribute.
		      style.setBackgroundColor
		      
		    end if
		    
		  end if
		  
		  ' Send notification of the change.
		  TextChanged
		  
		  ' Update the display.
		  update(true, true)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeBackgroundColor(c as Color)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim startPosition as FTInsertionOffset
		  Dim endPosition as FTInsertionOffset
		  Dim sr as FTStyleRun
		  Dim style as FTCharacterStyle
		  Dim originalContent as string
		  Dim newContent as string
		  
		  ' Are we in the read only mode?
		  if readOnly then return
		  
		  ' Is there anything selected?
		  if doc.isSelected then
		    
		    ' Get the selection range.
		    doc.getSelectionRange(startPosition, endPosition)
		    
		    ' Get the original content.
		    originalContent = doc.getXML(startPosition, endPosition)
		    
		    ' Toggle the selected text italic state.
		    doc.changeBackgroundColor(startPosition, endPosition, c)
		    
		    ' Get the updated content.
		    newContent = doc.getXML(startPosition, endPosition)
		    
		    ' Save the style change.
		    undo.saveContent(FTCStrings.BACKGROUND_COLOR, startPosition, endPosition, originalContent, newContent)
		    
		  else
		    
		    ' Are we in the middle of a word?
		    if doc.findWordBoundaryAtInsertion(startPosition, endPosition) then
		      
		      ' Get the original content.
		      originalContent = doc.getXML(startPosition, endPosition)
		      
		      ' Toggle the selected text state.
		      doc.changeBackgroundColor(startPosition, endPosition, c)
		      
		      ' Get the updated content.
		      newContent = doc.getXML(startPosition, endPosition)
		      
		      ' Save the style change.
		      undo.saveContent(FTCStrings.BACKGROUND_COLOR, startPosition, endPosition, originalContent, newContent)
		      
		    else
		      
		      ' Get the current insertion style and the current style run.
		      findInsertionReferences(style, sr)
		      
		      ' Set the attribute.
		      style.setBackgroundColor(c)
		      
		    end if
		    
		  end if
		  
		  ' Send notification of the change.
		  TextChanged
		  
		  ' Update the display.
		  update(true, true)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeBoldStyle()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim startPosition as FTInsertionOffset
		  Dim endPosition as FTInsertionOffset
		  Dim sr as FTStyleRun
		  Dim style as FTCharacterStyle
		  Dim originalContent as string
		  Dim newContent as string
		  Dim value as boolean
		  
		  ' Are we in the read only mode?
		  if readOnly then return
		  
		  ' Get the proper state change value.
		  value = not selectionBold
		  
		  ' Is there anything selected?
		  if doc.isSelected then
		    
		    ' Get the selection range.
		    doc.getSelectionRange(startPosition, endPosition)
		    
		    ' Get the original content.
		    originalContent = doc.getXML(startPosition, endPosition)
		    
		    ' Toggle the selected text bold state.
		    doc.changeBoldStyle(startPosition, endPosition, value)
		    
		    ' Get the updated content.
		    newContent = doc.getXML(startPosition, endPosition)
		    
		    ' Save the style change.
		    undo.saveContent(FTCStrings.BOLD, startPosition, endPosition, originalContent, newContent)
		    
		  else
		    
		    ' Are we in the middle of a word?
		    if doc.findWordBoundaryAtInsertion(startPosition, endPosition) then
		      
		      ' Get the original content.
		      originalContent = doc.getXML(startPosition, endPosition)
		      
		      ' Toggle the selected text state.
		      doc.changeBoldStyle(startPosition, endPosition, value)
		      
		      ' Get the updated content.
		      newContent = doc.getXML(startPosition, endPosition)
		      
		      ' Save the style change.
		      undo.saveContent(FTCStrings.BOLD, startPosition, endPosition, originalContent, newContent)
		      
		    else
		      
		      ' Get the current insertion style and the current style run.
		      findInsertionReferences(style, sr)
		      
		      ' Set the attribute.
		      style.setBold(not style.getBold)
		      
		    end if
		    
		  end if
		  
		  ' Send notification of the change.
		  TextChanged
		  
		  ' Update the display.
		  update(true, true)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeCenterAlignment()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Are we in the read only mode?
		  if readOnly then return
		  
		  ' Save the original content.
		  undo.saveOriginalParagraph(FTCStrings.CENTER_ALIGNMENT)
		  
		  ' Set the alignment.
		  doc.setParagraphAlignment(FTParagraph.Alignment_Type.Center)
		  
		  ' Save the changed content.
		  undo.saveNewParagraph
		  
		  ' Send notification of the change.
		  TextChanged
		  
		  ' Update the display.
		  update(true, true)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeCharacterSpacing(spacing As Integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim startPosition as FTInsertionOffset
		  Dim endPosition as FTInsertionOffset
		  Dim sr as FTStyleRun
		  Dim style as FTCharacterStyle
		  Dim originalContent as string
		  Dim newContent as string
		  
		  ' Are we in the read only mode?
		  if readOnly then return
		  
		  ' Is there anything selected?
		  if doc.isSelected then
		    
		    ' Get the selection range.
		    doc.getSelectionRange(startPosition, endPosition)
		    
		    ' Get the original content.
		    originalContent = doc.getXML(startPosition, endPosition)
		    
		    ' Change the font size.
		    doc.changeCharacterSpacing(spacing, startPosition, endPosition)
		    
		    ' Get the updated content.
		    newContent = doc.getXML(startPosition, endPosition)
		    
		    ' Save the style change.
		    undo.saveContent(FTCStrings.SPACING, startPosition, endPosition, originalContent, newContent)
		    
		  else
		    
		    ' Are we in the middle of a word?
		    if doc.findWordBoundaryAtInsertion(startPosition, endPosition) then
		      
		      ' Get the original content.
		      originalContent = doc.getXML(startPosition, endPosition)
		      
		      ' Toggle the selected text state.
		      doc.changeCharacterSpacing(spacing, startPosition, endPosition)
		      
		      ' Get the updated content.
		      newContent = doc.getXML(startPosition, endPosition)
		      
		      ' Save the style change.
		      undo.saveContent(FTCStrings.SPACING, startPosition, endPosition, originalContent, newContent)
		      
		    else
		      
		      ' Get the current insertion style and the current style run.
		      findInsertionReferences(style, sr)
		      
		      ' Set the attribute.
		      style.setCharacterSpacing(spacing)
		      
		    end if
		    
		  end if
		  
		  ' Send notification of the change.
		  TextChanged
		  
		  ' Update the display.
		  update(true, true)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeCharacterStyle(styleId as integer = 0)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim startPosition as FTInsertionOffset
		  Dim endPosition as FTInsertionOffset
		  Dim style as FTCharacterStyle
		  Dim sr as FTStyleRun
		  Dim originalContent as string
		  Dim newContent as string
		  
		  ' Are we in the read only mode?
		  if readOnly then return
		  
		  ' Is there anything selected?
		  if doc.isSelected then
		    
		    ' Get the selection range.
		    doc.getSelectionRange(startPosition, endPosition)
		    
		    ' Get the original content.
		    originalContent = doc.getXML(startPosition, endPosition)
		    
		    ' Set the character style for the selected text.
		    doc.changeCharacterStyle(startPosition, endPosition, styleId)
		    
		    ' Get the updated content.
		    newContent = doc.getXML(startPosition, endPosition)
		    
		    ' Save the style change.
		    undo.saveContent(FTCStrings.CHARACTER_STYLE, startPosition, endPosition, originalContent, newContent)
		    
		  else
		    
		    ' Are we in the middle of a word?
		    if doc.findWordBoundaryAtInsertion(startPosition, endPosition) then
		      
		      ' Get the original content.
		      originalContent = doc.getXML(startPosition, endPosition)
		      
		      ' Toggle the selected text state.
		      doc.changeCharacterStyle(startPosition, endPosition, styleId)
		      
		      ' Get the updated content.
		      newContent = doc.getXML(startPosition, endPosition)
		      
		      ' Save the style change.
		      undo.saveContent(FTCStrings.CHARACTER_STYLE, startPosition, endPosition, originalContent, newContent)
		      
		    else
		      
		      ' Get the current insertion style and the current style run.
		      findInsertionReferences(style, sr)
		      
		      ' Set the attribute.
		      style.setId(styleId)
		      
		    end if
		    
		  end if
		  
		  ' Send notification of the change.
		  TextChanged
		  
		  ' Update the display.
		  update(true, true)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeFont(fontName as string)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim startPosition as FTInsertionOffset
		  Dim endPosition as FTInsertionOffset
		  Dim sr as FTStyleRun
		  Dim style as FTCharacterStyle
		  Dim originalContent as string
		  Dim newContent as string
		  
		  ' Are we in the read only mode?
		  if readOnly then return
		  
		  ' Is there anything selected?
		  if doc.isSelected then
		    
		    ' Get the selection range.
		    doc.getSelectionRange(startPosition, endPosition)
		    
		    ' Get the original content.
		    originalContent = doc.getXML(startPosition, endPosition)
		    
		    ' Change the font.
		    doc.changeFont(fontName, startPosition, endPosition)
		    
		    ' Get the updated content.
		    newContent = doc.getXML(startPosition, endPosition)
		    
		    ' Save the style change.
		    undo.saveContent(FTCStrings.FONT, startPosition, endPosition, originalContent, newContent)
		    
		  else
		    
		    ' Are we in the middle of a word?
		    if doc.findWordBoundaryAtInsertion(startPosition, endPosition) then
		      
		      ' Get the original content.
		      originalContent = doc.getXML(startPosition, endPosition)
		      
		      ' Toggle the selected text state.
		      doc.changeFont(fontName, startPosition, endPosition)
		      
		      ' Get the updated content.
		      newContent = doc.getXML(startPosition, endPosition)
		      
		      ' Save the style change.
		      undo.saveContent(FTCStrings.FONT, startPosition, endPosition, originalContent, newContent)
		      
		    else
		      
		      ' Get the current insertion style and the current style run.
		      findInsertionReferences(style, sr)
		      
		      ' Set the attribute.
		      style.setFontName(fontName)
		      
		    end if
		    
		  end if
		  
		  ' Send notification of the change.
		  TextChanged
		  
		  ' Update the display.
		  update(true, true)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeHyperLink(hyperlink As String, newWindow As Boolean)
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim startPosition as FTInsertionOffset
		  Dim endPosition as FTInsertionOffset
		  Dim originalContent as string
		  Dim newContent as string
		  
		  ' Are we in the read only mode?
		  if readOnly then return
		  
		  ' Is there anything selected?
		  if doc.isSelected then
		    
		    ' Get the selection range.
		    doc.getSelectionRange(startPosition, endPosition)
		    
		    ' Get the original content.
		    originalContent = doc.getXML(startPosition, endPosition)
		    
		    ' Set the hyperlink
		    doc.ChangeHyperLink(startPosition, endPosition, hyperlink, newWindow)
		    
		    ' Get the updated content.
		    newContent = doc.getXML(startPosition, endPosition)
		    
		    ' Save the style change.
		    undo.saveContent(FTCStrings.HYPERLINK, startPosition, endPosition, originalContent, newContent)
		    
		  else
		    Dim io As FTInsertionOffset = getdoc.getInsertionOffset
		    ' Are we in the middle of a hyperlink?
		    if doc.findHyperLinkBoundaryAtOffset(io, startPosition, endPosition) then
		      
		      ' Get the original content.
		      originalContent = doc.getXML(startPosition, endPosition)
		      
		      ' Toggle the selected text state.
		      doc.ChangeHyperLink(startPosition, endPosition, hyperlink, newWindow)
		      
		      ' Get the updated content.
		      newContent = doc.getXML(startPosition, endPosition)
		      
		      ' Save the style change.
		      undo.saveContent(FTCStrings.HYPERLINK, startPosition, endPosition, originalContent, newContent)
		      
		      
		    end if
		    
		  end if
		  
		  
		  ' Update the display.
		  update(true, true)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeHyperLinkColor(hyperlinkColor As Color, hyperlinkColorRollover As Color, hyperlinkColorVisited As Color, hyperLinkColorDisabled As Color, ulNormal As Boolean, ulRollover As Boolean, ulVisited as Boolean, ulDisabled as Boolean)
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim startPosition as FTInsertionOffset
		  Dim endPosition as FTInsertionOffset
		  Dim originalContent as string
		  Dim newContent as string
		  Dim io as FTInsertionOffset
		  
		  ' Are we in the read only mode?
		  if readOnly then return
		  
		  
		  ' Get the insertion offset.
		  io = getdoc.getInsertionPoint.getOffset
		  
		  ' Get our offset for our hyperlink
		  if doc.findHyperLinkBoundaryAtOffset(io,startPosition, endPosition) then
		    
		    ' Get the original content.
		    originalContent = doc.getXML(startPosition, endPosition)
		    
		    ' Toggle the selected text state.
		    doc.ChangeHyperLinkColor(startPosition, endPosition, hyperlinkColor, hyperlinkColorRollover, hyperlinkColorVisited, hyperLinkColorDisabled,ulNormal , ulRollover , ulVisited , ulDisabled)
		    
		    ' Get the updated content.
		    newContent = doc.getXML(startPosition, endPosition)
		    
		    ' Save the style change.
		    undo.saveContent(FTCStrings.HYPERLINKCOLOR, startPosition, endPosition, originalContent, newContent)
		    
		  end if
		  
		  '' Send notification of the change.
		  'TextChanged
		  
		  ' Update the display.
		  update(true, true)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeItalicStyle()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim startPosition as FTInsertionOffset
		  Dim endPosition as FTInsertionOffset
		  Dim sr as FTStyleRun
		  Dim style as FTCharacterStyle
		  Dim originalContent as string
		  Dim newContent as string
		  Dim value as boolean
		  
		  ' Are we in the read only mode?
		  if readOnly then return
		  
		  ' Get the proper state change value.
		  value = not selectionItalic
		  
		  ' Is there anything selected?
		  if doc.isSelected then
		    
		    ' Get the selection range.
		    doc.getSelectionRange(startPosition, endPosition)
		    
		    ' Get the original content.
		    originalContent = doc.getXML(startPosition, endPosition)
		    
		    ' Toggle the selected text italic state.
		    doc.changeItalicStyle(startPosition, endPosition, value)
		    
		    ' Get the updated content.
		    newContent = doc.getXML(startPosition, endPosition)
		    
		    ' Save the style change.
		    undo.saveContent(FTCStrings.ITALIC, startPosition, endPosition, originalContent, newContent)
		    
		  else
		    
		    ' Are we in the middle of a word?
		    if doc.findWordBoundaryAtInsertion(startPosition, endPosition) then
		      
		      ' Get the original content.
		      originalContent = doc.getXML(startPosition, endPosition)
		      
		      ' Toggle the selected text state.
		      doc.changeItalicStyle(startPosition, endPosition, value)
		      
		      ' Get the updated content.
		      newContent = doc.getXML(startPosition, endPosition)
		      
		      ' Save the style change.
		      undo.saveContent(FTCStrings.ITALIC, startPosition, endPosition, originalContent, newContent)
		      
		    else
		      
		      ' Get the current insertion style and the current style run.
		      findInsertionReferences(style, sr)
		      
		      ' Set the attribute.
		      style.setItalic(not style.getItalic)
		      
		    end if
		    
		  end if
		  
		  ' Send notification of the change.
		  TextChanged
		  
		  ' Update the display.
		  update(true, true)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeLeftAlignment()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Are we in the read only mode?
		  if readOnly then return
		  
		  ' Save the original content.
		  undo.saveOriginalParagraph(FTCStrings.LEFT_ALIGNMENT)
		  
		  ' Set the alignment.
		  doc.setParagraphAlignment(FTParagraph.Alignment_Type.Left)
		  
		  ' Save the changed content.
		  undo.saveNewParagraph
		  
		  ' Send notification of the change.
		  TextChanged
		  
		  ' Update the display.
		  update(true, true)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeLineSpacing(lineSpacing as double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Are we in the read only mode?
		  if readOnly then return
		  
		  ' Save the original content.
		  undo.saveOriginalParagraph(FTCStrings.LINE_SPACING)
		  
		  ' Set the line spacing.
		  doc.setLineSpacing(lineSpacing)
		  
		  ' Save the changed content.
		  undo.saveNewParagraph
		  
		  ' Send notification of the change.
		  TextChanged
		  
		  ' Update the display.
		  update(true, true)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeMarginGuides(state as boolean)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set the flag.
		  showMarginGuides = state
		  
		  ' Update the display.
		  update(true, true)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeMark()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim startPosition as FTInsertionOffset
		  Dim endPosition as FTInsertionOffset
		  Dim sr as FTStyleRun
		  Dim style as FTCharacterStyle
		  Dim originalContent as string
		  Dim newContent as string
		  
		  ' Are we in the read only mode?
		  if readOnly then return
		  
		  ' Is there anything selected?
		  if doc.isSelected then
		    
		    ' Get the selection range.
		    doc.getSelectionRange(startPosition, endPosition)
		    
		    ' Get the original content.
		    originalContent = doc.getXML(startPosition, endPosition)
		    
		    ' Set the color of the mark.
		    doc.changeMark(startPosition, endPosition)
		    
		    ' Get the updated content.
		    newContent = doc.getXML(startPosition, endPosition)
		    
		    ' Save the style change.
		    undo.saveContent(FTCStrings.MARK, startPosition, endPosition, originalContent, newContent)
		    
		  else
		    
		    ' Are we in the middle of a word?
		    if doc.findWordBoundaryAtInsertion(startPosition, endPosition) then
		      
		      ' Get the original content.
		      originalContent = doc.getXML(startPosition, endPosition)
		      
		      ' Toggle the selected text state.
		      doc.changeMark(startPosition, endPosition)
		      
		      ' Get the updated content.
		      newContent = doc.getXML(startPosition, endPosition)
		      
		      ' Save the style change.
		      undo.saveContent(FTCStrings.MARK, startPosition, endPosition, originalContent, newContent)
		      
		    else
		      
		      ' Get the current insertion style and the current style run.
		      findInsertionReferences(style, sr)
		      
		      ' Set the attribute.
		      style.setMarkColor
		      
		    end if
		    
		  end if
		  
		  ' Send notification of the change.
		  TextChanged
		  
		  ' Update the display.
		  update(true, true)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeMark(c as Color)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim startPosition as FTInsertionOffset
		  Dim endPosition as FTInsertionOffset
		  Dim sr as FTStyleRun
		  Dim style as FTCharacterStyle
		  Dim originalContent as string
		  Dim newContent as string
		  
		  ' Are we in the read only mode?
		  if readOnly then return
		  
		  ' Is there anything selected?
		  if doc.isSelected then
		    
		    ' Get the selection range.
		    doc.getSelectionRange(startPosition, endPosition)
		    
		    ' Get the original content.
		    originalContent = doc.getXML(startPosition, endPosition)
		    
		    ' Set the color of the mark.
		    doc.changeMark(startPosition, endPosition, c)
		    
		    ' Get the updated content.
		    newContent = doc.getXML(startPosition, endPosition)
		    
		    ' Save the style change.
		    undo.saveContent(FTCStrings.MARK, startPosition, endPosition, originalContent, newContent)
		    
		  else
		    
		    ' Are we in the middle of a word?
		    if doc.findWordBoundaryAtInsertion(startPosition, endPosition) then
		      
		      ' Get the original content.
		      originalContent = doc.getXML(startPosition, endPosition)
		      
		      ' Toggle the selected text state.
		      doc.changeMark(startPosition, endPosition, c)
		      
		      ' Get the updated content.
		      newContent = doc.getXML(startPosition, endPosition)
		      
		      ' Save the style change.
		      undo.saveContent(FTCStrings.MARK, startPosition, endPosition, originalContent, newContent)
		      
		    else
		      
		      ' Get the current insertion style and the current style run.
		      findInsertionReferences(style, sr)
		      
		      ' Set the attribute.
		      style.setMarkColor(c)
		      
		    end if
		    
		  end if
		  
		  ' Send notification of the change.
		  TextChanged
		  
		  ' Update the display.
		  update(true, true)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ChangeOpacity(opacity as double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim startPosition as FTInsertionOffset
		  Dim endPosition as FTInsertionOffset
		  Dim sr as FTStyleRun
		  Dim style as FTCharacterStyle
		  Dim originalContent as string
		  Dim newContent as string
		  
		  ' Are we in the read only mode?
		  if readOnly then return
		  
		  ' Is there anything selected?
		  if doc.isSelected then
		    
		    ' Get the selection range.
		    doc.getSelectionRange(startPosition, endPosition)
		    
		    ' Get the original content.
		    originalContent = doc.getXML(startPosition, endPosition)
		    
		    ' Change the opacity
		    doc.changeOpacity(opacity, startPosition, endPosition)
		    
		    ' Get the updated content.
		    newContent = doc.getXML(startPosition, endPosition)
		    
		    ' Save the style change.
		    undo.saveContent(FTCStrings.OPACITY, startPosition, endPosition, originalContent, newContent)
		    
		  else
		    
		    ' Are we in the middle of a word?
		    if doc.findWordBoundaryAtInsertion(startPosition, endPosition) then
		      
		      ' Get the original content.
		      originalContent = doc.getXML(startPosition, endPosition)
		      
		      ' Toggle the selected text state.
		      doc.changeOpacity(opacity, startPosition, endPosition)
		      
		      ' Get the updated content.
		      newContent = doc.getXML(startPosition, endPosition)
		      
		      ' Save the style change.
		      undo.saveContent(FTCStrings.OPACITY, startPosition, endPosition, originalContent, newContent)
		      
		    else
		      
		      ' Get the current insertion style and the current style run.
		      findInsertionReferences(style, sr)
		      
		      ' Set the attribute.
		      //style.s(size)
		      
		    end if
		    
		  end if
		  
		  ' Send notification of the change.
		  TextChanged
		  
		  ' Update the display.
		  update(true, true)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeParagraphBackgroundColor()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim startPosition as FTInsertionOffset
		  Dim endPosition as FTInsertionOffset
		  
		  ' Are we in the read only mode?
		  if readOnly then return
		  
		  ' Is there anything selected?
		  if doc.isSelected then
		    
		    ' Get the selection range.
		    doc.getSelectionRange(startPosition, endPosition)
		    
		  else
		    
		    ' Get the insertion point.
		    startPosition = doc.getInsertionOffset
		    endPosition = startPosition
		    
		  end if
		  
		  ' Save the original content.
		  undo.saveOriginalParagraph(FTCStrings.PARAGRAPH_COLOR)
		  
		  ' Set the alignment.
		  doc.changeParagraphBackgroundColor(startPosition, endPosition)
		  
		  ' Save the changed content.
		  undo.saveNewParagraph
		  
		  ' Send notification of the change.
		  TextChanged
		  
		  ' Update the display.
		  update(true, true)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeParagraphBackgroundColor(c as Color)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim startPosition as FTInsertionOffset
		  Dim endPosition as FTInsertionOffset
		  
		  ' Are we in the read only mode?
		  if readOnly then return
		  
		  ' Is there anything selected?
		  if doc.isSelected then
		    
		    ' Get the selection range.
		    doc.getSelectionRange(startPosition, endPosition)
		    
		  else
		    
		    ' Get the insertion point.
		    startPosition = doc.getInsertionOffset
		    endPosition = startPosition
		    
		  end if
		  
		  ' Save the original content.
		  undo.saveOriginalParagraph(FTCStrings.PARAGRAPH_COLOR)
		  
		  ' Set the background color.
		  doc.changeParagraphBackgroundColor(startPosition, endPosition, c)
		  
		  ' Save the changed content.
		  undo.saveNewParagraph
		  
		  ' Send notification of the change.
		  TextChanged
		  
		  ' Update the display.
		  update(true, true)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeParagraphMargins(p as FTParagraph, firstIndent as double, leftMargin as double, rightMargin as double, beforeSpace as double, afterSpace as double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Are the new settings valid?
		  if isValidParagraphMargins(leftMargin, rightMargin, firstIndent) then
		    
		    ' Save the original content.
		    undo.saveOriginalParagraph(FTCStrings.PARAGRAPH_MARGINS)
		    
		    ' Set the margins.
		    p.setFirstIndent(firstIndent)
		    p.setLeftMargin(leftMargin)
		    p.setRightMargin(rightMargin)
		    p.setBeforeSpace(beforeSpace)
		    p.setAfterSpace(afterSpace)
		    
		    ' Save the changed content.
		    undo.saveNewParagraph
		    
		    ' Send notification of the change.
		    TextChanged
		    
		    ' Update the display.
		    update(true, true)
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeParagraphMargins(startIndex as integer, endIndex as integer, firstIndent as double, leftMargin as double, rightMargin as double, beforeSpace as double, afterSpace as double)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim p as FTParagraph
		  
		  ' Are the new settings valid?
		  if isValidParagraphMargins(leftMargin, rightMargin, firstIndent) then
		    
		    ' Save the original content.
		    undo.saveOriginalParagraph(FTCStrings.PARAGRAPH_MARGINS)
		    
		    ' Change all the paragraphs.
		    for i = startIndex to endIndex
		      
		      ' Get the paragraph.
		      p = doc.getParagraph(i)
		      
		      ' Does the paragraph exist?
		      if p is nil then exit
		      
		      ' Set the margins.
		      p.setFirstIndent(firstIndent)
		      p.setLeftMargin(leftMargin)
		      p.setRightMargin(rightMargin)
		      p.setBeforeSpace(beforeSpace)
		      p.setAfterSpace(afterSpace)
		      
		    next
		    
		    ' Save the changed content.
		    undo.saveNewParagraph
		    
		    ' Send notification of the change.
		    TextChanged
		    
		    ' Update the display.
		    update(true, true)
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changePlainStyle()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim startPosition as FTInsertionOffset
		  Dim endPosition as FTInsertionOffset
		  Dim sr as FTStyleRun
		  Dim style as FTCharacterStyle
		  Dim originalContent as string
		  Dim newContent as string
		  Dim value as boolean
		  
		  ' Are we in the read only mode?
		  if readOnly then return
		  
		  ' Is there anything selected?
		  if doc.isSelected then
		    
		    ' Get the selection range.
		    doc.getSelectionRange(startPosition, endPosition)
		    
		    ' Get the original content.
		    originalContent = doc.getXML(startPosition, endPosition)
		    
		    ' Remove styling from the text.
		    doc.changePlainStyle(startPosition, endPosition, value)
		    
		    ' Get the updated content.
		    newContent = doc.getXML(startPosition, endPosition)
		    
		    ' Save the style change.
		    undo.saveContent(FTCStrings.PLAIN, startPosition, endPosition, originalContent, newContent)
		    
		  else
		    
		    ' Are we in the middle of a word?
		    if doc.findWordBoundaryAtInsertion(startPosition, endPosition) then
		      
		      ' Get the original content.
		      originalContent = doc.getXML(startPosition, endPosition)
		      
		      ' Toggle the selected text state.
		      doc.changePlainStyle(startPosition, endPosition, value)
		      
		      ' Get the updated content.
		      newContent = doc.getXML(startPosition, endPosition)
		      
		      ' Save the style change.
		      undo.saveContent(FTCStrings.PLAIN, startPosition, endPosition, originalContent, newContent)
		      
		    else
		      
		      ' Get the current insertion style and the current style run.
		      findInsertionReferences(style, sr)
		      
		      ' Set the attribute.
		      style.setPlain
		      
		    end if
		    
		  end if
		  
		  ' Send notification of the change.
		  TextChanged
		  
		  ' Update the display.
		  update(true, true)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeRightAlignment()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Are we in the read only mode?
		  if readOnly then return
		  
		  ' Save the original content.
		  undo.saveOriginalParagraph(FTCStrings.RIGHT_ALIGNMENT)
		  
		  ' Set the alignment.
		  doc.setParagraphAlignment(FTParagraph.Alignment_Type.Right)
		  
		  ' Save the changed content.
		  undo.saveNewParagraph
		  
		  ' Send notification of the change.
		  TextChanged
		  
		  ' Update the display.
		  update(true, true)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ChangeShadow(hasShadow as Boolean, shadowColor as Color, ShadowOffset as Double, ShadowBlur as Double, ShadowOpacity as double, ShadowAngle as Double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim startPosition as FTInsertionOffset
		  Dim endPosition as FTInsertionOffset
		  Dim sr as FTStyleRun
		  Dim style as FTCharacterStyle
		  Dim originalContent as string
		  Dim newContent as string
		  
		  ' Are we in the read only mode?
		  if readOnly then return
		  
		  ' Is there anything selected?
		  if doc.isSelected then
		    
		    ' Get the selection range.
		    doc.getSelectionRange(startPosition, endPosition)
		    
		    ' Get the original content.
		    originalContent = doc.getXML(startPosition, endPosition)
		    
		    ' Change the Shadow
		    doc.ChangeShadow(hasShadow,shadowColor,ShadowOffset,ShadowBlur, ShadowOpacity,ShadowAngle,startPosition, endPosition)
		    
		    ' Get the updated content.
		    newContent = doc.getXML(startPosition, endPosition)
		    
		    ' Save the style change.
		    undo.saveContent(FTCStrings.SHADOW, startPosition, endPosition, originalContent, newContent)
		    
		  else
		    
		    ' Are we in the middle of a word?
		    if doc.findWordBoundaryAtInsertion(startPosition, endPosition) then
		      
		      ' Get the original content.
		      originalContent = doc.getXML(startPosition, endPosition)
		      
		      ' Toggle the selected text state.
		      doc.ChangeShadow(hasShadow,shadowColor,ShadowOffset,ShadowBlur, ShadowOpacity,ShadowAngle,startPosition, endPosition)
		      
		      ' Get the updated content.
		      newContent = doc.getXML(startPosition, endPosition)
		      
		      ' Save the style change.
		      undo.saveContent(FTCStrings.SHADOW, startPosition, endPosition, originalContent, newContent)
		      
		    else
		      Break
		      ' Get the current insertion style and the current style run.
		      findInsertionReferences(style, sr)
		      
		      ' Set the attribute.
		      //style.s(size)
		      
		    end if
		    
		  end if
		  
		  ' Send notification of the change.
		  TextChanged
		  
		  ' Update the display.
		  update(true, true)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeSize(size as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim startPosition as FTInsertionOffset
		  Dim endPosition as FTInsertionOffset
		  Dim sr as FTStyleRun
		  Dim style as FTCharacterStyle
		  Dim originalContent as string
		  Dim newContent as string
		  
		  ' Are we in the read only mode?
		  if readOnly then return
		  
		  ' Is there anything selected?
		  if doc.isSelected then
		    
		    ' Get the selection range.
		    doc.getSelectionRange(startPosition, endPosition)
		    
		    ' Get the original content.
		    originalContent = doc.getXML(startPosition, endPosition)
		    
		    ' Change the font size.
		    doc.changeSize(size, startPosition, endPosition)
		    
		    ' Get the updated content.
		    newContent = doc.getXML(startPosition, endPosition)
		    
		    ' Save the style change.
		    undo.saveContent(FTCStrings.SIZE, startPosition, endPosition, originalContent, newContent)
		    
		  else
		    
		    ' Are we in the middle of a word?
		    if doc.findWordBoundaryAtInsertion(startPosition, endPosition) then
		      
		      ' Get the original content.
		      originalContent = doc.getXML(startPosition, endPosition)
		      
		      ' Toggle the selected text state.
		      doc.changeSize(size, startPosition, endPosition)
		      
		      ' Get the updated content.
		      newContent = doc.getXML(startPosition, endPosition)
		      
		      ' Save the style change.
		      undo.saveContent(FTCStrings.SIZE, startPosition, endPosition, originalContent, newContent)
		      
		    else
		      
		      ' Get the current insertion style and the current style run.
		      findInsertionReferences(style, sr)
		      
		      ' Set the attribute.
		      style.setFontSize(size)
		      
		    end if
		    
		  end if
		  
		  ' Send notification of the change.
		  TextChanged
		  
		  ' Update the display.
		  update(true, true)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeStrikeThrough()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim startPosition as FTInsertionOffset
		  Dim endPosition as FTInsertionOffset
		  Dim sr as FTStyleRun
		  Dim style as FTCharacterStyle
		  Dim originalContent as string
		  Dim newContent as string
		  Dim value as boolean
		  
		  ' Are we in the read only mode?
		  if readOnly then return
		  
		  ' Get the proper state change value.
		  value = not selectionStrikethrough
		  
		  ' Is there anything selected?
		  if doc.isSelected then
		    
		    ' Get the selection range.
		    doc.getSelectionRange(startPosition, endPosition)
		    
		    ' Get the original content.
		    originalContent = doc.getXML(startPosition, endPosition)
		    
		    ' Toggle the selected text italic state.
		    doc.changeStrikeThrough(startPosition, endPosition, value)
		    
		    ' Get the updated content.
		    newContent = doc.getXML(startPosition, endPosition)
		    
		    ' Save the style change.
		    undo.saveContent(FTCStrings.STRIKETHROUGH, startPosition, endPosition, originalContent, newContent)
		    
		  else
		    
		    ' Are we in the middle of a word?
		    if doc.findWordBoundaryAtInsertion(startPosition, endPosition) then
		      
		      ' Get the original content.
		      originalContent = doc.getXML(startPosition, endPosition)
		      
		      ' Toggle the selected text state.
		      doc.changeStrikeThrough(startPosition, endPosition, value)
		      
		      ' Get the updated content.
		      newContent = doc.getXML(startPosition, endPosition)
		      
		      ' Save the style change.
		      undo.saveContent(FTCStrings.STRIKETHROUGH, startPosition, endPosition, originalContent, newContent)
		      
		    else
		      
		      ' Get the current insertion style and the current style run.
		      findInsertionReferences(style, sr)
		      
		      ' Set the attribute.
		      style.setStrikeThrough(not style.getStrikeThrough)
		      
		    end if
		    
		  end if
		  
		  ' Send notification of the change.
		  TextChanged
		  
		  ' Update the display.
		  update(true, true)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeSubscript()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim startPosition as FTInsertionOffset
		  Dim endPosition as FTInsertionOffset
		  Dim sr as FTStyleRun
		  Dim style as FTCharacterStyle
		  Dim originalContent as string
		  Dim newContent as string
		  Dim value as boolean
		  
		  ' Are we in the read only mode?
		  if readOnly then return
		  
		  ' Get the proper state change value.
		  value = not selectionSubscript
		  
		  ' Is there anything selected?
		  if doc.isSelected then
		    
		    ' Get the selection range.
		    doc.getSelectionRange(startPosition, endPosition)
		    
		    ' Get the original content.
		    originalContent = doc.getXML(startPosition, endPosition)
		    
		    ' Toggle the selected text subscript state.
		    doc.changeSubscript(startPosition, endPosition, value)
		    
		    ' Get the updated content.
		    newContent = doc.getXML(startPosition, endPosition)
		    
		    ' Save the style change.
		    undo.saveContent(FTCStrings.SUBSCRIPT, startPosition, endPosition, originalContent, newContent)
		    
		  else
		    
		    ' Are we in the middle of a word?
		    if doc.findWordBoundaryAtInsertion(startPosition, endPosition) then
		      
		      ' Get the original content.
		      originalContent = doc.getXML(startPosition, endPosition)
		      
		      ' Toggle the selected text state.
		      doc.changeSubscript(startPosition, endPosition, value)
		      
		      ' Get the updated content.
		      newContent = doc.getXML(startPosition, endPosition)
		      
		      ' Save the style change.
		      undo.saveContent(FTCStrings.SUBSCRIPT, startPosition, endPosition, originalContent, newContent)
		      
		    else
		      
		      ' Get the current insertion style and the current style run.
		      findInsertionReferences(style, sr)
		      
		      ' Set the attribute.
		      style.setScriptLevel(FTUtilities.flipScriptLevel(style.getScriptLevel, true))
		      
		    end if
		    
		  end if
		  
		  ' Send notification of the change.
		  TextChanged
		  
		  ' Update the display.
		  update(true, true)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeSuperscript()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim startPosition as FTInsertionOffset
		  Dim endPosition as FTInsertionOffset
		  Dim sr as FTStyleRun
		  Dim style as FTCharacterStyle
		  Dim originalContent as string
		  Dim newContent as string
		  Dim value as boolean
		  
		  ' Are we in the read only mode?
		  if readOnly then return
		  
		  ' Get the proper state change value.
		  value = not selectionSuperscript
		  
		  ' Is there anything selected?
		  if doc.isSelected then
		    
		    ' Get the selection range.
		    doc.getSelectionRange(startPosition, endPosition)
		    
		    ' Get the original content.
		    originalContent = doc.getXML(startPosition, endPosition)
		    
		    ' Toggle the selected text superscript state.
		    doc.changeSuperscript(startPosition, endPosition, value)
		    
		    ' Get the updated content.
		    newContent = doc.getXML(startPosition, endPosition)
		    
		    ' Save the style change.
		    undo.saveContent(FTCStrings.SUPERSCRIPT, startPosition, endPosition, originalContent, newContent)
		    
		  else
		    
		    ' Are we in the middle of a word?
		    if doc.findWordBoundaryAtInsertion(startPosition, endPosition) then
		      
		      ' Get the original content.
		      originalContent = doc.getXML(startPosition, endPosition)
		      
		      ' Toggle the selected text state.
		      doc.changeSuperscript(startPosition, endPosition, value)
		      
		      ' Get the updated content.
		      newContent = doc.getXML(startPosition, endPosition)
		      
		      ' Save the style change.
		      undo.saveContent(FTCStrings.SUPERSCRIPT, startPosition, endPosition, originalContent, newContent)
		      
		    else
		      
		      ' Get the current insertion style and the current style run.
		      findInsertionReferences(style, sr)
		      
		      ' Set the attribute.
		      style.setScriptLevel(FTUtilities.flipScriptLevel(style.getScriptLevel, false))
		      
		    end if
		    
		  end if
		  
		  ' Send notification of the change.
		  TextChanged
		  
		  ' Update the display.
		  update(true, true)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeTextColor(c as Color)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim startPosition as FTInsertionOffset
		  Dim endPosition as FTInsertionOffset
		  Dim sr as FTStyleRun
		  Dim style as FTCharacterStyle
		  Dim originalContent as string
		  Dim newContent as string
		  
		  ' Are we in the read only mode?
		  if readOnly then return
		  
		  ' Is there anything selected?
		  if doc.isSelected then
		    
		    ' Get the selection range.
		    doc.getSelectionRange(startPosition, endPosition)
		    
		    ' Get the original content.
		    originalContent = doc.getXML(startPosition, endPosition)
		    
		    ' Set the color of the text.
		    doc.changeTextColor(startPosition, endPosition, c)
		    
		    ' Get the updated content.
		    newContent = doc.getXML(startPosition, endPosition)
		    
		    ' Save the style change.
		    undo.saveContent(FTCStrings.TEXT_COLOR, startPosition, endPosition, originalContent, newContent)
		    
		  else
		    
		    ' Are we in the middle of a word?
		    if doc.findWordBoundaryAtInsertion(startPosition, endPosition) then
		      
		      ' Get the original content.
		      originalContent = doc.getXML(startPosition, endPosition)
		      
		      ' Toggle the selected text state.
		      doc.changeTextColor(startPosition, endPosition, c)
		      
		      ' Get the updated content.
		      newContent = doc.getXML(startPosition, endPosition)
		      
		      ' Save the style change.
		      undo.saveContent(FTCStrings.TEXT_COLOR, startPosition, endPosition, originalContent, newContent)
		      
		    else
		      
		      ' Get the current insertion style and the current style run.
		      findInsertionReferences(style, sr)
		      
		      ' Set the attribute.
		      style.setTextColor(c)
		      
		    end if
		    
		  end if
		  
		  ' Send notification of the change.
		  TextChanged
		  
		  ' Update the display.
		  update(true, true)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeToLowerCase()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim startPosition as FTInsertionOffset
		  Dim endPosition as FTInsertionOffset
		  Dim originalContent as string
		  Dim newContent as string
		  
		  ' Are we in the read only mode?
		  if readOnly then return
		  
		  ' Is there anything selected?
		  if doc.isSelected then
		    
		    ' Get the selection range.
		    doc.getSelectionRange(startPosition, endPosition)
		    
		    ' Get the original content.
		    originalContent = doc.getXML(startPosition, endPosition)
		    
		    ' Change the case to lower.
		    doc.changeToLowerCase(startPosition, endPosition)
		    
		    ' Get the updated content.
		    newContent = doc.getXML(startPosition, endPosition)
		    
		    ' Save the style change.
		    undo.saveContent(FTCStrings.TO_LOWER_CASE, startPosition, endPosition, originalContent, newContent)
		    
		  else
		    
		    ' Are we in the middle of a word?
		    if doc.findWordBoundaryAtInsertion(startPosition, endPosition) then
		      
		      ' Get the original content.
		      originalContent = doc.getXML(startPosition, endPosition)
		      
		      ' Change the case to lower.
		      doc.changeToLowerCase(startPosition, endPosition)
		      
		      ' Get the updated content.
		      newContent = doc.getXML(startPosition, endPosition)
		      
		      ' Save the style change.
		      undo.saveContent(FTCStrings.TO_LOWER_CASE, startPosition, endPosition, originalContent, newContent)
		      
		    end if
		    
		  end if
		  
		  ' Send notification of the change.
		  TextChanged
		  
		  ' Update the display.
		  update(true, true)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeToTitleCase()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim startPosition as FTInsertionOffset
		  Dim endPosition as FTInsertionOffset
		  Dim originalContent as string
		  Dim newContent as string
		  
		  ' Are we in the read only mode?
		  if readOnly then return
		  
		  ' Is there anything selected?
		  if doc.isSelected then
		    
		    ' Get the selection range.
		    doc.getSelectionRange(startPosition, endPosition)
		    
		    ' Get the original content.
		    originalContent = doc.getXML(startPosition, endPosition)
		    
		    ' Change the case to title.
		    doc.changeToTitleCase(startPosition, endPosition)
		    
		    ' Get the updated content.
		    newContent = doc.getXML(startPosition, endPosition)
		    
		    ' Save the style change.
		    undo.saveContent(FTCStrings.TO_TITLE_CASE, startPosition, endPosition, originalContent, newContent)
		    
		  else
		    
		    ' Are we in the middle of a word?
		    if doc.findWordBoundaryAtInsertion(startPosition, endPosition) then
		      
		      ' Get the original content.
		      originalContent = doc.getXML(startPosition, endPosition)
		      
		      ' Change the case to title.
		      doc.changeToTitleCase(startPosition, endPosition)
		      
		      ' Get the updated content.
		      newContent = doc.getXML(startPosition, endPosition)
		      
		      ' Save the style change.
		      undo.saveContent(FTCStrings.TO_TITLE_CASE, startPosition, endPosition, originalContent, newContent)
		      
		    end if
		    
		  end if
		  
		  ' Send notification of the change.
		  TextChanged
		  
		  ' Update the display.
		  update(true, true)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeToUpperCase()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim startPosition as FTInsertionOffset
		  Dim endPosition as FTInsertionOffset
		  Dim originalContent as string
		  Dim newContent as string
		  
		  ' Are we in the read only mode?
		  if readOnly then return
		  
		  ' Is there anything selected?
		  if doc.isSelected then
		    
		    ' Get the selection range.
		    doc.getSelectionRange(startPosition, endPosition)
		    
		    ' Get the original content.
		    originalContent = doc.getXML(startPosition, endPosition)
		    
		    ' Change the case to upper.
		    doc.changeToUpperCase(startPosition, endPosition)
		    
		    ' Get the updated content.
		    newContent = doc.getXML(startPosition, endPosition)
		    
		    ' Save the style change.
		    undo.saveContent(FTCStrings.TO_UPPER_CASE, startPosition, endPosition, originalContent, newContent)
		    
		  else
		    
		    ' Are we in the middle of a word?
		    if doc.findWordBoundaryAtInsertion(startPosition, endPosition) then
		      
		      ' Get the original content.
		      originalContent = doc.getXML(startPosition, endPosition)
		      
		      ' Change the case to upper.
		      doc.changeToUpperCase(startPosition, endPosition)
		      
		      ' Get the updated content.
		      newContent = doc.getXML(startPosition, endPosition)
		      
		      ' Save the style change.
		      undo.saveContent(FTCStrings.TO_UPPER_CASE, startPosition, endPosition, originalContent, newContent)
		      
		    end if
		    
		  end if
		  
		  ' Send notification of the change.
		  TextChanged
		  
		  ' Update the display.
		  update(true, true)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeUnderlineStyle()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim startPosition as FTInsertionOffset
		  Dim endPosition as FTInsertionOffset
		  Dim sr as FTStyleRun
		  Dim style as FTCharacterStyle
		  Dim originalContent as string
		  Dim newContent as string
		  Dim value as boolean
		  
		  ' Are we in the read only mode?
		  if readOnly then return
		  
		  ' Get the proper state change value.
		  value = not selectionUnderline
		  
		  ' Is there anything selected?
		  if doc.isSelected then
		    
		    ' Get the selection range.
		    doc.getSelectionRange(startPosition, endPosition)
		    
		    ' Get the original content.
		    originalContent = doc.getXML(startPosition, endPosition)
		    
		    ' Toggle the selected text underline state.
		    doc.changeUnderlineStyle(startPosition, endPosition, value)
		    
		    ' Get the updated content.
		    newContent = doc.getXML(startPosition, endPosition)
		    
		    ' Save the style change.
		    undo.saveContent(FTCStrings.UNDERLINE, startPosition, endPosition, originalContent, newContent)
		    
		  else
		    
		    ' Are we in the middle of a word?
		    if doc.findWordBoundaryAtInsertion(startPosition, endPosition) then
		      
		      ' Get the original content.
		      originalContent = doc.getXML(startPosition, endPosition)
		      
		      ' Toggle the selected text state.
		      doc.changeUnderlineStyle(startPosition, endPosition, value)
		      
		      ' Get the updated content.
		      newContent = doc.getXML(startPosition, endPosition)
		      
		      ' Save the style change.
		      undo.saveContent(FTCStrings.UNDERLINE, startPosition, endPosition, originalContent, newContent)
		      
		    else
		      
		      ' Get the current insertion style and the current style run.
		      findInsertionReferences(style, sr)
		      
		      ' Set the attribute.
		      style.setUnderline(not style.getUnderline)
		      
		    end if
		    
		  end if
		  
		  ' Send notification of the change.
		  TextChanged
		  
		  ' Update the display.
		  update(true, true)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub checkDisplayMode()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set the page dimensions.
		  doc.setPageSize(PageWidth, PageHeight)
		  
		  ' Set the display mode.
		  Select Case Mode
		    
		  Case Display_Mode.Page
		    
		    ' Set the margins.
		    doc.setLeftMargin(LeftMargin)
		    doc.setRightMargin(RightMargin)
		    doc.setTopMargin(TopMargin)
		    doc.setBottomMargin(BottomMargin)
		    
		    ' Set up for page view mode.
		    setPageViewMode
		    
		  Case Display_Mode.Normal
		    
		    ' Set the margins.
		    doc.setLeftMargin(LeftMargin)
		    doc.setRightMargin(RightMargin)
		    doc.setTopMargin(TopMargin)
		    doc.setBottomMargin(BottomMargin)
		    
		    ' Set up for normal view mode.
		    setNormalViewMode
		    
		  case Display_Mode.Edit
		    
		    ' Set up for edit view mode.
		    setEditViewMode(EditViewMargin)
		    
		  else
		    
		  end select
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function checkFontName(value as string) As string
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Trim off white space.
		  value = Trim(value)
		  
		  ' Is this an invalid font specification?
		  if (value = "") or (value = "System") or (value = "SmallSystem") then value = "Arial"
		  
		  ' Return the font name.
		  return value
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function checkPicture(pic as FTPicture) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Call the event.
		  return InsertImage(pic)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub checkSpelling(background as boolean = true)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Initiate a spell check run.
		  doc.checkSpelling(background)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub checkSpellingLive(previousOffset as FTInsertionOffset, currentOffset as FTInsertionOffset)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Are we spell checking while we type?
		  if SpellCheckWhileTyping and previousOffset.isSet then
		    
		    ' If something is selected then there is nothing to check.
		    if doc.isSelected then return
		    
		    ' Should we spell check this word?
		    if not doc.inSameWord(previousOffset, currentOffset) then
		      
		      ' Get the word at the previous offset.
		      checkSpellingLiveWord(previousOffset - 1)
		      
		      ' Check the following offset.
		      checkSpellingLiveWord(previousOffset + 1)
		      
		    end if
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub checkSpellingLiveWord(offset as FTInsertionOffset)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim word as string
		  Dim startOffset as FTInsertionOffset
		  Dim endOffset as FTInsertionOffset
		  
		  ' Is there anything to do?
		  if offset is nil then return
		  
		  ' Are we in range?
		  if offset.paragraph >= doc.getParagraphCount then return
		  
		  ' Is there anything to check?
		  if offset.getParagraph.getLength = 0 then return
		  
		  ' Get the word at the previous offset.
		  if doc.findWordBoundaryAtOffset(offset, startOffset, endOffset) then
		    
		    ' Extract the word.
		    word = doc.getText(startOffset, endOffset)
		    
		    ' Call the spell check word event.
		    if SpellCheckWord(word) then
		      
		      ' The word is misspelled.
		      doc.getParagraph(startOffset.paragraph).changeMisspelledWord _
		      (startOffset.offset + 1, endOffset.offset, true)
		      
		    else
		      
		      ' The word is not misspelled.
		      doc.getParagraph(startOffset.paragraph).changeMisspelledWord _
		      (startOffset.offset + 1, endOffset.offset, false)
		      
		    end if
		    
		  end if
		  
		  exception
		    
		    ' Do nothing.
		    
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub clearKeyStrokeTiming()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Clear the key stroke data.
		  keyStrokesTotal = 0
		  keyTimeTotal = 0
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub clearMisspelledIndicators()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Clear any misspelling indicators.
		  doc.clearMisspelledIndicators
		  
		  doc.optimizeAllParagraphs
		  
		  ' Update the display.
		  update(true, true)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function clone(parentControl as FormattedText) As FTDocument
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return a clone of the contents.
		  return doc.clone(parentControl)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub constrainToDisplay(ByRef x as integer, ByRef y as integer, ByRef width as integer, ByRef height as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim scrollbarSpace as integer
		  
		  ' Are we off the left?
		  if x < 0 then
		    
		    ' Adjust the width.
		    width = width + x - me.left
		    
		    ' Set the left side to the side of the control.
		    x = me.left
		    
		  end if
		  
		  '------------------
		  
		  ' Are we off the top?
		  if y < 0 then
		    
		    ' Adjust the height.
		    height = height + y - me.top
		    
		    ' Set the top side to the side of the control.
		    y = me.top
		    
		  end if
		  
		  '------------------
		  
		  ' Do we have a vertical scrollbar?
		  if not (vScrollbar is nil) then
		    
		    ' Get the scrollbar width.
		    if vScrollbar.Visible then scrollbarSpace = vScrollbar.Width
		    
		  end if
		  
		  ' Are we off the right?
		  if (x + width) > (me.left + (me.width - scrollbarSpace)) then
		    
		    ' Adjust the width.
		    width = (me.left + (me.width - scrollbarSpace)) - x
		    
		  end if
		  
		  '------------------
		  
		  ' Reset the space.
		  scrollbarSpace = 0
		  
		  ' Do we have a horizontal scrollbar?
		  if not (hScrollbar is nil) then
		    
		    ' Get the scrollbar height.
		    if vScrollbar.Visible then scrollbarSpace = hScrollbar.Height
		    
		  end if
		  
		  ' Are we off the bottom?
		  if (y + height) > (me.top + (me.height - scrollbarSpace)) then
		    
		    ' Adjust the height.
		    height = (me.top + (me.height - scrollbarSpace)) - y
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function convertDisplayToAbsoluteCoordinates(y as integer) As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Get the total Y distance.
		  return Abs(vScrollValue) + y
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub convertDisplayToPageCoordinates(x as integer, y as integer, ByRef page as integer, ByRef pageX as integer, ByRef pageY as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim totalY as integer
		  
		  ' Are we in page view mode?
		  if isPageViewMode then
		    
		    ' Get the total Y distance.
		    totalY = Abs(vScrollValue) + y
		    
		    ' Get the page.
		    page = totalY / ((doc.getPageHeightLength * scale) + doc.getPageSpace)
		    
		    ' Are we scaled down?
		    if scale < 1.0 then
		      
		      ' Change to page coordinates.
		      pageX = (Abs(hScrollValue) - xDisplayAlignmentOffset + x) / scale
		      pageY = (totalY - doc.getPageTop(page, scale)) / scale
		      
		    else
		      
		      ' Change to page coordinates.
		      pageX = Abs(hScrollValue) - xDisplayAlignmentOffset + x
		      pageY = totalY - doc.getPageTop(page, scale)
		      
		    end if
		    
		  else
		    
		    ' Get the page.
		    page = 0
		    
		    ' Are we scaled down?
		    if scale < 1.0 then
		      
		      ' Change to page coordinates at 100%.
		      pageX = Abs(hScrollValue) + ((x - xDisplayAlignmentOffset) / scale)
		      pageY = Abs(vScrollValue) + (y / scale)
		      
		    else
		      
		      ' Change to page coordinates.
		      pageX = Abs(hScrollValue) - xDisplayAlignmentOffset + x
		      pageY = Abs(vScrollValue) + y
		      
		    end if
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub convertPageToDisplayCoordinates(page as integer, pageX as integer, pageY as integer, ByRef x as integer, ByRef y as integer)
		  #if not DebugBuild
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Are we scaled down?
		  if scale < 1.0 then
		    ' Convert the coordinates.
		    x = pageX + hScrollValue
		    y = ((page * (doc.getPageHeightLength + doc.getPageSpace)) + pageY) + (vScrollValue / scale)
		    
		  else
		    ' Convert the coordinates.
		    x = pageX + hScrollValue
		    y = ((page * ((scale * doc.getPageHeightLength) + doc.getPageSpace)) + pageY) + vScrollValue
		    
		  end if
		  
		  // Position correction for HiDPI
		  dim dDisplayScale as double = getDisplayScale
		  x = (x / dDisplayScale)
		  y = (y / dDisplayScale)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub copySelected()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim cb as Clipboard
		  Dim startPosition as FTInsertionOffset
		  Dim endPosition as FTInsertionOffset
		  Dim dataString as string
		  
		  ' Is there anything to copy to the clipboard?
		  if not doc.isSelected then return
		  
		  ' Create a clipboard object.
		  cb = new Clipboard
		  
		  ' Get the range of selected text.
		  doc.getSelectionRange(startPosition, endPosition)
		  
		  '----------------------------------------------------
		  ' Native XML.
		  '----------------------------------------------------
		  
		  ' Get the XML data.
		  dataString = doc.getXML(startPosition, endPosition)
		  
		  ' Add the XML data to the clipboard.
		  cb.AddRawData(dataString, XML_DATA_TYPE)
		  
		  ' Are we in resize mode?
		  if doc.isInResizeMode then
		    
		    '----------------------------------------------------
		    ' Picture.
		    '----------------------------------------------------
		    
		    ' Get the picture.
		    cb.Picture = doc.getResizePicture.getOriginalPicture
		    
		  else
		    
		    '----------------------------------------------------
		    ' RTF.
		    '----------------------------------------------------
		    
		    ' Get the RTF data.
		    dataString = doc.getRTF(startPosition, endPosition)
		    
		    ' Add the RTF data to the clipboard.
		    cb.AddRawData(dataString, RTF_DATA_TYPE)
		    
		    '----------------------------------------------------
		    ' Plain text.
		    '----------------------------------------------------
		    
		    dim xxx as string
		    xxx = ReplaceLineEndings(doc.getText(startPosition, endPosition), EndOfLine)
		    ' Put the text on the clipboard.
		    cb.text = ReplaceLineEndings(doc.getText(startPosition, endPosition), EndOfLine)
		    
		  end if
		  
		  ' Close the clipboard.
		  cb.close
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub deleteAll()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Delete all the text.
		  doc.deleteAll
		  
		  ' Clear the style binding.
		  setStyleBinding
		  
		  ' Make sure everything is lined up.
		  resize
		  vScrollTo(0)
		  hScrollTo(0)
		  
		  ' Send notification of the change.
		  TextChanged
		  
		  ' Update the display.
		  updateFull
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub deleteSelected()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Is anything selected?
		  if not doc.isSelected then return
		  
		  ' Delete the selected text.
		  doc.deleteSelected
		  
		  ' Send notification of the change.
		  TextChanged
		  
		  ' Update the display.
		  update(true, true)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub deselectAll()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Is anything selected?
		  if doc.isSelected then
		    
		    ' Deselect all the text.
		    doc.deselectAll
		    
		    ' Update the display.
		    update(true, true)
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function displayMoved() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the display moved state.
		  return hasMoved
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub draw()
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Are we blocked?
		  if inhibitUpdates then return
		  
		  ' Has the display changed position?
		  hasMoved = (LastVScrollValue <> vScrollValue) or _
		  (LastHScrollValue <> hScrollValue) or hasMoved
		  
		  ' Draw the background.
		  drawBackground
		  
		  ' Allow subclasses to draw.
		  PreDisplayDraw(getDisplay)
		  
		  ' Update the display alignement offset.
		  xDisplayAlignmentOffset = calculateDisplayAlignmentOffset(DisplayAlignment)
		  
		  ' Are we in single view mode?
		  if isSingleViewMode then
		    
		    ' Draw the contents.
		    doc.draw(xDisplayAlignmentOffset, vScrollValue, picDisplay.height)
		    
		  else
		    
		    ' Draw the contents.
		    doc.draw(hScrollValue + xDisplayAlignmentOffset, vScrollValue, picDisplay.height)
		    
		  end if
		  
		  ' Allow subclasses to draw.
		  PostDisplayDraw(getDisplay)
		  
		  ' Save the positions.
		  LastVScrollValue = vScrollValue
		  LastHScrollValue = hScrollValue
		  
		  ' Clear the moved flag.
		  hasMoved = false
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub drawBackground()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim g as Graphics
		  
		  ' Has the display been scrolled?
		  if hasMoved or (not isPageViewMode) then
		    
		    ' Get the graphics object.
		    g = picDisplay.graphics
		    
		    ' Should we use the normal view background?
		    if not isPageViewMode then
		      
		      ' Set the background color to white.
		      g.ForeColor = &cFFFFFF
		      
		    else
		      
		      ' Set the background color.
		      g.ForeColor = backgroundColor
		      
		    end if
		    
		    ' Draw the background.
		    g.FillRect(0, 0, picDisplay.width, picDisplay.height)
		    
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub drawBorder(g as graphics)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Should we draw the border?
		  if DrawControlBorder then
		    
		    ' Set up the drawing characteristics.
		    g.PenWidth = 1
		    g.PenHeight = 1
		    g.ForeColor = borderColor
		    
		    ' Draw the border.
		    g.DrawRect(0, 0, g.width, g.height)
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub drawCorner(g as graphics)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim leftPos as integer
		  Dim topPos as integer
		  
		  ' Do both scrollbars exist?
		  if (not (vScrollbar is nil)) and (not (hScrollbar is nil)) then
		    
		    ' Are both scrollbars visible?
		    if vScrollbar.visible and hScrollbar.visible then
		      
		      ' Set the color to white.
		      // Mantis Ticket 3775: Implement Corner Color Property in Formatted Text
		      g.ForeColor = CornerColor
		      
		      ' Calculate where to draw the box.
		      leftPos = (hScrollbar.left - me.left) + hScrollbar.width
		      topPos = (vScrollbar.top - me.top) + vScrollbar.height
		      
		      ' Fill in the bottom corner.
		      g.fillRect(leftPos, topPos, width - leftPos, height - topPos)
		      
		    end if
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub editClearAction()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim startOffset as FTInsertionOffset
		  Dim endOffset as FTInsertionOffset
		  Dim fto as FTBase
		  Dim state as boolean
		  
		  ' Is there anything to do?
		  if ReadOnly or not doc.isSelected then return
		  
		  ' Turn off updates.
		  state = setInhibitUpdates(true)
		  
		  ' Check for selected text being deleted.
		  saveUndoDelete(FTCStrings.CLEAR)
		  
		  ' Delete the selected text.
		  deleteSelected
		  
		  ' Get the selection range.
		  doc.getSelectionRange(startOffset, endOffset)
		  
		  ' Get the first item in the selection.
		  fto = doc.getObjectAtOffset(startOffset)
		  
		  ' Is this a style run?
		  if fto isa FTStyleRun then
		    
		    ' Set up the style binding.
		    setStyleBinding(fto)
		    
		  end if
		  
		  ' Restore the update state.
		  call setInhibitUpdates(state)
		  
		  ' Update the display.
		  update(true, true)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub editCopyAction()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Is there anything to do?
		  if not doc.isSelected then return
		  
		  ' Copy the selected text to the clipboard.
		  copySelected
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub editCutAction()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim startOffset as FTInsertionOffset
		  Dim endOffset as FTInsertionOffset
		  Dim fto as FTBase
		  
		  ' Is there anything to do?
		  if ReadOnly or (not doc.isSelected) then return
		  
		  ' Copy the selected text to the clipboard.
		  copySelected
		  
		  ' Check for selected text being deleted.
		  saveUndoDelete(FTCStrings.CUT)
		  
		  ' Get the selection range.
		  doc.getSelectionRange(startOffset, endOffset)
		  
		  ' Get the first item in the selection.
		  fto = doc.getObjectAtOffset(startOffset)
		  
		  ' Is this a style run?
		  if fto isa FTStyleRun then
		    
		    ' Set up the style binding.
		    setStyleBinding(fto)
		    
		  end if
		  
		  ' Delete the selected text.
		  deleteSelected
		  
		  ' Update the display.
		  update(true, true)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub editPasteAction()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim cb as Clipboard
		  Dim newContent as string
		  Dim selectedContent as string
		  Dim selectStart as FTInsertionOffset
		  Dim selectEnd as FTInsertionOffset
		  Dim newOffset as FTInsertionOffset
		  Dim firstPa as ParagraphAttributes
		  Dim delta as integer
		  
		  ' Is there anything to do?
		  if ReadOnly then return
		  
		  ' Set the Mouse Cursor
		  'BK 08August12 Lengthy paste needs wait cursor
		  self.MouseCursor = system.Cursors.Wait
		  
		  ' Get the selected content and range.
		  selectedContent = doc.getSelectedXML(selectStart, selectEnd)
		  
		  ' Save the first paragraphs attributes.
		  firstPa = doc.getParagraph(selectStart.paragraph).getParagraphAttributes
		  
		  ' Did the subclass handle the paste?
		  if not PasteAction then
		    
		    ' Create a clipboard object.
		    cb = new Clipboard
		    
		    '--------------------------------------------
		    
		    ' Is FTC XML data available?
		    if cb.RawDataAvailable(XML_DATA_TYPE) then
		      
		      '--------------------------------------------
		      ' Native XML.
		      '--------------------------------------------
		      
		      insertXML(cb.RawData(XML_DATA_TYPE))
		      
		      ' Is RTF data available?
		    elseif cb.RawDataAvailable(RTF_DATA_TYPE) then
		      
		      '--------------------------------------------
		      ' RTF.
		      '--------------------------------------------
		      
		      insertRTF(cb.RawData(RTF_DATA_TYPE))
		      
		    elseif cb.RawDataAvailable("public.file-url") then
		      '--------------------------------------------
		      ' It's a file
		      '--------------------------------------------
		      
		      //doesn't support multiple files. That will actually be very difficult
		      dim f as FolderItem = GetFolderItem( cb.RawData("public.file-url"), FolderItem.PathTypeURL)
		      
		      if f<> nil and f.Exists  then
		        if FTUtilities.isPictureFile(f) then
		          Dim pic As Picture
		          pic = Picture.Open(f)
		          insertPicture(pic)
		          
		        elseif FTUtilities.isTextfile(f) then
		          dim t as TextInputStream
		          t = TextInputStream.Open(f)
		          if t<> nil then
		            Dim content As String = t.readall
		            if content.left(5) ="{\rtf" then
		              insertRTF(content)
		            else
		              insertText(content)
		            end
		            
		          else
		            insertText(f.name)
		          end if
		        else
		          insertText(f.name)
		        end if
		        
		      end if
		      
		      
		      ' Is there text available?
		    elseif cb.TextAvailable then
		      
		      '--------------------------------------------
		      ' Text.
		      '--------------------------------------------
		      
		      insertText(cb.text)
		      
		      ' Is there a picture available?
		    elseif cb.PictureAvailable then
		      
		      '--------------------------------------------
		      ' Picture.
		      '--------------------------------------------
		      
		      insertPicture(cb.Picture)
		      
		    end if
		    
		    ' Close the clipboard.
		    cb.close
		    
		    '--------------------------------------------
		    
		  end if
		  
		  ' Get the new offset for the inserted text.
		  newOffset = doc.getInsertionOffset
		  
		  ' Compute the position compared to the end of the paragraph.
		  delta = newOffset.offset - newOffset.getParagraph.getLength
		  
		  ' Are we past the end?
		  if delta > 0 then
		    
		    ' Readjust the offsets.
		    newOffset.offset = newOffset.offset - delta
		    selectStart.offset = selectStart.offset - delta
		    
		  end if
		  
		  ' Get the inserted content.
		  newContent = doc.getXml(selectStart, newOffset)
		  
		  ' Save the undo paste action.
		  undo.savePaste(selectStart, selectEnd, newOffset, _
		  selectedContent, newContent, firstPa)
		  
		  ' Send notification of the change.
		  TextChanged
		  
		  ' Set the Mouse Cursor
		  'BK 08August12 Lengthy paste needs wait cursor
		  self.MouseCursor = nil
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub editRedoAction()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Is there anything to do?
		  if ReadOnly then return
		  
		  ' Perform the redo operation.
		  undo.redo
		  
		  ' Send notification of the change.
		  TextChanged
		  
		  ' Update the display.
		  update(true, true)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub editUndoAction()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Is there anything to do?
		  if ReadOnly then return
		  
		  ' Perform the undo operation.
		  undo.undo
		  
		  ' Send notification of the change.
		  TextChanged
		  
		  ' Update the display.
		  update(true, true)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function filterKeys(key as string) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim keyValue as integer
		  
		  ' Get the key value.
		  keyValue = asc(key)
		  
		  ' Handle the normal characters.
		  if (keyValue >= 32) and (keyValue <= 127) then return false
		  
		  ' Handle the return and tab characters.
		  if (keyValue = 13) or (keyValue = 9) then return false
		  
		  ' Exclude lower value ascii characters.
		  if keyValue <= 31 then return true
		  
		  ' Exclude the F1-F16 keys.
		  if Keyboard.AsyncKeyDown(&h60) then return true
		  if Keyboard.AsyncKeyDown(&h61) then return true
		  if Keyboard.AsyncKeyDown(&h62) then return true
		  if Keyboard.AsyncKeyDown(&h63) then return true
		  if Keyboard.AsyncKeyDown(&h64) then return true
		  if Keyboard.AsyncKeyDown(&h65) then return true
		  if Keyboard.AsyncKeyDown(&h67) then return true
		  if Keyboard.AsyncKeyDown(&h69) then return true
		  if Keyboard.AsyncKeyDown(&h6A) then return true
		  if Keyboard.AsyncKeyDown(&h6B) then return true
		  if Keyboard.AsyncKeyDown(&h6D) then return true
		  if Keyboard.AsyncKeyDown(&h6F) then return true
		  if Keyboard.AsyncKeyDown(&h71) then return true
		  if Keyboard.AsyncKeyDown(&h76) then return true
		  if Keyboard.AsyncKeyDown(&h78) then return true
		  if Keyboard.AsyncKeyDown(&h7A) then return true
		  
		  ' Exclude the clear key.
		  if Keyboard.AsyncKeyDown(&h47) then return true
		  
		  ' Exclude the help key.
		  if Keyboard.AsyncKeyDown(&h72) then return true
		  
		  ' We do handle it.
		  return false
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function findAnchorPosition(anchorType as integer, position as FTInsertionOffset, forward as boolean) As FTInsertionOffset
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim p as FTParagraph
		  Dim offset as integer
		  Dim text as string
		  
		  ' Get the paragraph.
		  p = doc.getParagraph(position.paragraph)
		  
		  ' Is there anything to look at?
		  if p is nil then return nil
		  
		  ' Is this a double click?
		  if anchorType = 2 then
		    
		    ' Get the text.
		    text = p.getText
		    
		    ' Convert to paragraph position.
		    position = position - offset
		    
		    ' Find the word boundary.
		    offset = FTUtilities.findEndOfWord(text, position.offset, forward)
		    
		    ' Do we need to make an adjustment?
		    if not forward then offset = max(offset - 1, 0)
		    
		    ' Return the adjusted offset.
		    return doc.newInsertionOffset(position.paragraph, offset)
		    
		    ' Is this a triple click?
		  elseif anchorType = 3 then
		    
		    ' Are we doing a forward extension of the selection?
		    if forward then
		      
		      ' Set the selection to the end of the paragraph.
		      return doc.newInsertionOffset(position.paragraph, p.getLength)
		      
		    else
		      
		      ' Set the selection to the beginning of the paragraph.
		      return doc.newInsertionOffset(position.paragraph, 0)
		      
		    end if
		    
		  end if
		  
		  ' No adjustment needed.
		  return doc.newInsertionOffset(position)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub findInsertionReferences(ByRef style as FTCharacterStyle, ByRef sr as FTStyleRun)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim offset as FTInsertionOffset
		  Dim p as FTParagraph
		  
		  ' Get the current style run.
		  sr = doc.getCurrentStyleRun
		  
		  ' Does it exist?
		  if sr is nil then
		    
		    ' Get the insertion offset.
		    offset = doc.getInsertionOffset
		    
		    ' Get the target paragraph.
		    p = doc.getParagraph(offset.paragraph)
		    
		    ' Create a new style run.
		    sr = new FTStyleRun(self)
		    
		    ' Are we at the beginning of the paragraph?
		    if offset.offset = 0 then
		      
		      ' Insert the style run.
		      p.insertObject(0, sr)
		      
		    else
		      
		      ' Append the style run.
		      p.addObject(sr)
		      
		    end if
		    
		  end if
		  
		  ' Was a style binding set
		  if styleBinding is nil then
		    
		    ' Create the style binding.
		    setStyleBinding(sr)
		    
		  end if
		  
		  ' Return the style binding.
		  style = styleBinding
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function findPictureCoordinates(pic as FTPicture, ByRef page as FTPage, ByRef picX as integer, ByRef picY as integer) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Find the page containing the picture.
		  page = doc.findPageContainingPicture(pic)
		  
		  ' Is there anything to look at?
		  if page is nil then
		    
		    ' Reset the coordinates.
		    picX = 0
		    picY = 0
		    
		    ' Not found.
		    return false
		    
		  end if
		  
		  ' Get the coordinates of the picture on the page.
		  call page.findPictureCoordinates(pic, picX, picY)
		  
		  ' Adjust to the top left corner.
		  picY = picY - (pic.getHeight(displayScale) * getDisplayScale)
		  
		  ' We found the picture.
		  return true
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub findSelectionRectangle(ByRef x as integer, ByRef y as integer, ByRef width as integer, ByRef height as integer)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim j as integer
		  Dim k as integer
		  Dim paragraphCount as integer
		  Dim proxyCount as integer
		  Dim firstLine as integer
		  Dim lastLine as integer
		  Dim lineX as integer
		  Dim lineY as integer
		  Dim lineWidth as integer
		  Dim lineHeight as integer
		  Dim rightSide as integer
		  Dim leftSide as integer
		  Dim pa() as FTParagraph
		  Dim p as FTParagraph
		  Dim pp as FTParagraphProxy
		  Dim firstFlag as boolean
		  Dim page as integer
		  Dim firstPage as integer
		  Dim lastPage as integer
		  Dim pageSpace as integer
		  Dim pic as FTPicture
		  Dim dLocalScale As Double
		  Dim topY as integer
		  Dim bottomY as integer
		  Dim ignore as integer
		  
		  const MAX_INT = 2147483647
		  
		  '----------------------------------------
		  ' Do we need to do anything?
		  '----------------------------------------
		  
		  ' Is there something selected?
		  if not doc.isSelected then
		    
		    ' Use the size of the control.
		    x = me.left
		    y = me.top
		    width = me.width
		    height = me.height
		    
		    ' We are done.
		    return
		    
		  end if
		  
		  '----------------------------------------
		  ' Are we in resize mode?
		  '----------------------------------------
		  
		  ' Are we in resize mode?
		  if doc.isInResizeMode then
		    
		    ' Get the resize picture.
		    pic = doc.getResizePicture
		    
		    ' Get the drawn coordinates.
		    pic.getLastDrawnCoordinates(page, x, y)
		    
		    ' Are we page view mode?
		    if isPageViewMode then
		      
		      ' Get the page.
		      firstPage = doc.getInsertionPoint.getCurrentProxyParagraph.getAbsolutePage
		      
		      ' Convert the coordinates.
		      convertPageToDisplayCoordinates(firstPage, x, y, x, y)
		      
		    end if
		    
		    ' Are we scaled down?
		    if getScale < 1.0 then
		      
		      ' Adjust the coordinates for the scale.
		      x = x * getScale
		      y = y * getScale
		      
		    end if
		    
		    ' Adjust to the global coordinates.
		    x = x + me.left
		    y = y + me.top
		    
		    ' Get the picture dimensions.
		    width = pic.getWidth(getScale)
		    height = pic.getHeight(getScale)
		    
		    ' Move the vertical coordinate to the top of the picture.
		    y = y - height
		    
		    ' Adjust for the display alignment (left, center, or right).
		    x = x + xDisplayAlignmentOffset
		    
		    ' Constrain the rectangle to the display.
		    constrainToDisplay(x, y, width, height)
		    
		    ' We are done.
		    return
		    
		  end if
		  
		  '----------------------------------------
		  ' Do some set up.
		  '----------------------------------------
		  
		  ' Initialize the variables.
		  x = 0
		  y = 0
		  width = 0
		  height = 0
		  firstFlag = true
		  leftSide = MAX_INT
		  rightSide = -MAX_INT
		  firstPage = MAX_INT
		  lastPage = 0
		  
		  ' Get the selected paragraphs.
		  pa = doc.getSelectedParagraphs
		  
		  ' Get the number of paragraphs.
		  paragraphCount = Ubound(pa)
		  
		  '----------------------------------------
		  ' Find the selection rectangle.
		  '----------------------------------------
		  
		  ' Scan the paragraphs.
		  for i = 0 to paragraphCount
		    
		    ' Get the paragraph.
		    p = pa(i)
		    
		    ' Get the number of proxies.
		    proxyCount = p.getProxyItemCount - 1
		    
		    ' Scan the proxies.
		    for j = 0 to proxyCount
		      
		      ' Get the proxy.
		      pp = p.getProxyItem(j)
		      
		      ' Get the line range
		      firstLine = pp.getLineStart
		      lastLine = pp.getLineEnd
		      
		      ' Scan the lines.
		      for k = firstLine to lastLine
		        
		        ' Get the selection dimensions.
		        if p.getLine(k).getSelectionDimensions(lineX, lineY, lineWidth, lineHeight) then
		          
		          ' Is this the first line in the selection?
		          if firstFlag then
		            
		            ' Save the top of the line.
		            topY = lineY
		            
		            ' We are done looking for the line.
		            firstFlag = false
		            
		          end if
		          
		          ' Save the bottom of the selection.
		          bottomY = lineY + lineHeight
		          
		          ' Did the rectangle grow?
		          leftSide = min(leftSide, lineX)
		          rightSide = max(rightSide, lineX + lineWidth)
		          
		          ' Get the page the proxy is on.
		          page = pp.getPage
		          
		          ' Update the page range.
		          if page < firstPage then firstPage = page
		          if page > lastPage then lastPage = page
		          
		        end if
		        
		      next
		      
		    next
		    
		  next
		  
		  '----------------------------------------
		  ' Make some adjustments.
		  '----------------------------------------
		  
		  ' Get the current scale.
		  dLocalScale = getScale
		  
		  ' Convert to display coordinates.
		  convertPageToDisplayCoordinates(firstPage, ignore, topY, ignore, topY)
		  convertPageToDisplayCoordinates(lastPage, ignore, bottomY, ignore, bottomY)
		  
		  ' Set the top.
		  x = leftSide
		  y = topY
		  
		  ' Are we in page mode?
		  if isPageViewMode then
		    
		    '---------------------------
		    ' Page mode.
		    '---------------------------
		    
		    ' Are we scaled down?
		    If dLocalScale < 1.0 Then
		      
		      ' Calculate the space between pages.
		      pageSpace = doc.getPageSpace * firstPage
		      
		      ' Adjust the coordinates for the scale.
		      x = x * dLocalScale
		      y = ((y - pageSpace) * dLocalScale) + pageSpace
		      
		    end if
		    
		    ' Adjust for global coordinates.
		    x = me.left + x + hScrollValue
		    y = me.top + y
		    
		    ' Calculate the dimensions.
		    width = rightSide - leftSide
		    height = (bottomY - topY) * getDisplayScale
		    
		    ' Are we scaled down?
		    If dLocalScale < 1.0 Then
		      
		      ' Calculate the space between all the pages.
		      pageSpace = doc.getPageSpace * (lastPage - firstPage)
		      
		      ' Adjust the lengths for the scale.
		      width = width * dLocalScale
		      height = ((height - pageSpace) * dLocalScale) + pageSpace
		      
		    end if
		    
		  else
		    
		    '---------------------------
		    ' Normal mode.
		    '---------------------------
		    
		    ' Are we scaled down?
		    If dLocalScale < 1.0 Then
		      
		      ' Adjust the coordinates for the scale.
		      x = x * dLocalScale
		      y = y * dLocalScale
		      
		    end if
		    
		    ' Adjust for global coordinates.
		    x = me.left + x
		    y = me.top - vScrollValue + y
		    
		    ' Calculate the dimensions.
		    width = rightSide - leftSide
		    height = bottomY - topY
		    
		    ' Are we scaled down?
		    If dLocalScale < 1.0 Then
		      
		      ' Adjust the lengths for the scale.
		      width = width * dLocalScale
		      height = height * dLocalScale
		      
		    end if
		    
		  end if
		  
		  ' Adjust for the display alignment (left, center, or right).
		  x = x + xDisplayAlignmentOffset
		  
		  '---------------------------
		  
		  ' Constrain the rectangle to the display.
		  'constrainToDisplay(x, y, width, height)  //Don't believe we actually need this.
		  
		  if IsHiDPT then
		    x = x/2 + me.left/2 //BK  This is not accurate.
		    y = y/2 + me.top/2 //BK  This is not accurate.
		    width = width/2
		    height = height/2
		  end
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub getAutoCompleteOptions(byref sPrefix as string, arsOption() as string)
		  Const kSeparator = "."
		  
		  dim ip as FTInsertionPoint = doc.getInsertionPoint
		  if RaiseEvent AutoCompleteOptions(ip, sPrefix, arsOption) then
		    return
		  end if
		  
		  redim arsOption(-1)
		  
		  sPrefix = getAutoCompletePrefix(ip, "\w", kSeparator)
		  if sPrefix="" then
		    return 'nothing to complete
		  end if
		  
		  dim ixFirst as integer = -1
		  
		  ixFirst = PrefixBinarySearch(m_arsAutoCompleteOption, sPrefix)
		  if ixFirst<0 then
		    return
		  end if
		  
		  'check the case
		  dim bUppercase as boolean
		  select case Asc(sPrefix.Right(1))
		  case 65 to 90
		    bUppercase = true
		  end select
		  
		  dim iMax as integer = m_arsAutoCompleteOption.Ubound
		  for i as integer = ixFirst to iMax
		    if m_arsAutoCompleteOption(i).Left(sPrefix.Len) = sPrefix then
		      if m_arsAutoCompleteOption(i)<>sPrefix then
		        dim sOption as string = m_arsAutoCompleteOption(i)
		        if bUppercase then
		          sOption = Uppercase(sOption)
		        else
		          sOption = Lowercase(sOption)
		        end if
		        
		        arsOption.Append(sOption)
		      end if
		    else
		      exit for
		    end if
		  next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function getAutoCompletePrefix(ip as FTInsertionPoint, sIdentifierExp as string, sSeparatorChar as string) As string
		  dim io as FTInsertionOffset = ip.getOffset
		  dim text as string = ip.getCurrentParagraph.getText(true)
		  if text="" then
		    return ""
		  end if
		  dim startOffset as integer = io.offset
		  if startOffset>text.Len then
		    startOffset = text.Len
		  end if
		  dim endOffset as integer = startOffset
		  
		  dim rxIdentifierChar as new RegEx
		  rxIdentifierChar.SearchPattern = sIdentifierExp
		  
		  sSeparatorChar = sSeparatorChar.Left(1)
		  
		  while startOffset > 0
		    dim c as string = mid(text, startOffset, 1)
		    if c<>sSeparatorChar and rxIdentifierChar.Search(c)=nil then
		      startOffset = startOffset + 1
		      exit while
		    end if
		    startOffset = startOffset - 1
		  wend
		  
		  return text.Mid(startOffset, endOffset-startOffset+1)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getCurrentStyleBinding() As FTCharacterStyle
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the current style binding.
		  return styleBinding
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getDisplay() As Graphics
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the display.
		  return picDisplay.Graphics
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getDisplayAlignment() As Display_Alignment
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the current display alignment.
		  return DisplayAlignment
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getDisplayHeight() As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the height of the display area.
		  return picDisplay.Height
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getDisplayPicture() As Picture
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the display picture.
		  return picDisplay
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getDisplayScale() As double
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the display scale.
		  if IsHiDPT then
		    return displayScale * 2
		  else
		    return displayScale
		  end
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getDisplayWidth() As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the width of the display area.
		  return picDisplay.Width
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getDoc() As FTDocument
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the document.
		  return doc
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getFocusState() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the state of focus for the control.
		  return focusState
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getHScrollbar() As FTScrollbar
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the horizontal scrollbar.
		  return hScrollbar
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub getMacSystemVersion(ByRef sys1 as integer, ByRef sys2 as integer, ByRef sys3 as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Initialize the variables.
		  sys1 = 0
		  sys2 = 0
		  sys3 = 0
		  
		  #if TargetMacOS
		    
		    ' Get the system version for the mac.
		    if System.Gestalt("sys1", sys1) and _
		      System.Gestalt("sys2", sys2) and _
		      System.Gestalt("sys3", sys3) then
		    end if
		    
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetMonitorPixelsPerInch() As Double
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the resolution.
		  if IsHiDPT then
		    return 144.0
		  else
		    return 72.0
		  end
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getOptimizationData() As string
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim s as string
		  
		  ' Get the key strokes.
		  s = "Key strokes = " + str(keyStrokesTotal) + _
		  " Total time = " + Format(keyTimeTotal / 1000000, "0.000000000") + _
		  " Average Time = " + Format((keyTimeTotal / keyStrokesTotal) / 1000000, "0.000000000") + EndOfLine
		  
		  ' Get the update data.
		  s = s + "Updates = " + str(updateCallsTotal) + _
		  " Total time = " + Format(updateTimeTotal / 1000000, "0.000000000") + _
		  " Average Time = " + Format((updateTimeTotal / updateCallsTotal) / 1000000, "0.000000000") + EndOfLine
		  
		  ' Return the timing data.
		  return s
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getScale() As double
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the current scale.
		  return scale
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getScaledValue(value as double) As double
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the scaled value.
		  return value * scale
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getTripleClickTime() As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the triple click time.
		  return tripleClickTime
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getUndoManager() As FTCUndoManager
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the undo manager.
		  return undo
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getVScrollbar() As FTScrollbar
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the vertical scrollbar.
		  return vScrollbar
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getWordCount() As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the number of words.
		  return doc.getWordCount
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getXDisplayPosition() As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the X position.
		  return hScrollValue
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getYDisplayPosition() As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the Y position.
		  return vScrollValue
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function handleArrowKeys() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  '-------------------------------------------
		  ' Left arrow key.
		  '-------------------------------------------
		  
		  ' Was the left arrow key pressed?
		  if Keyboard.AsyncKeyDown(&h07B) then
		    
		    ' Handle the arrow key.
		    handleLeftArrowKey
		    
		    ' We handled the key.
		    return true
		    
		  end if
		  
		  '-------------------------------------------
		  ' Right arrow key.
		  '-------------------------------------------
		  
		  ' Was the right arrow key pressed?
		  if Keyboard.AsyncKeyDown(&h07C) then
		    
		    ' Handle the arrow key.
		    handleRightArrowKey
		    
		    ' We handled the key.
		    return true
		    
		  end if
		  
		  '-------------------------------------------
		  ' Down arrow key.
		  '-------------------------------------------
		  
		  ' Was the down arrow key pressed?
		  if Keyboard.AsyncKeyDown(&h07D) then
		    
		    ' Handle the arrow key.
		    handleDownArrowKey
		    
		    ' We handled the key.
		    return true
		    
		  end if
		  
		  '-------------------------------------------
		  ' Up arrow key.
		  '-------------------------------------------
		  
		  ' Was the up arrow key pressed?
		  if Keyboard.AsyncKeyDown(&h07E) then
		    
		    ' Handle the arrow key.
		    handleUpArrowKey
		    
		    ' We handled the key.
		    return true
		    
		  end if
		  
		  '-------------------------------------------
		  
		  ' We did not handle it.
		  return false
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub handleAutoCompleteKey()
		  dim sPrefix as string
		  dim arsOption() as string
		  getAutoCompleteOptions(sPrefix, arsOption)
		  
		  if arsOption.Ubound = -1 then
		    //Contributed by Marco Bambini
		    self.insertTab
		  elseif arsOption.Ubound=0 then
		    self.insertText(arsOption(0).Mid(Len(sPrefix)+1))
		  elseif arsOption.Ubound>0 then
		    showAutoComplete(sPrefix, arsOption)
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub handleBackwardDelete()
		  Dim fto as FTBase
		  Dim p as FTParagraph
		  
		  ' Are we in read only mode?
		  if ReadOnly then
		    return
		  end if
		  
		  ' Is there anything selected?
		  if doc.isSelected then
		    
		    ' Check for selected text being deleted.
		    saveUndoDelete(FTCStrings.DELETE)
		    
		    ' Check the style binding for the selection.
		    setSelectStyleBinding
		    
		    ' Delete the selected text.
		    deleteSelected
		    
		    ' Was everything deleted?
		    if doc.getLength = 0 then
		      
		      ' Clear the style binding.
		      setStyleBinding
		      
		    end if
		    
		  else
		    
		    ' Was the option key pressed?
		    if isOptionKeyPressed then
		      
		      ' Perform a backwards delete of the word.
		      handleOptionDeleteWord(false)
		      
		    else
		      
		      ' Get the deleted item.
		      fto = doc.getObjectAtOffset(doc.getInsertionOffset)
		      
		      ' Is this a style run?
		      if fto isa FTStyleRun then
		        
		        ' Set up the style binding.
		        setStyleBinding(fto)
		        
		      end if
		      
		      ' Delete a character.
		      updateFlag = doc.deleteCharacter(false, p)
		      
		      ' Clear the resize picture.
		      doc.clearResizePicture
		      
		      ' Did we combine a paragraph?
		      if not (p is nil) then fto = p
		      
		      ' Was something deleted?
		      if not (fto is nil) then
		        
		        ' Save the backspace item.
		        undo.saveBackspace(fto, doc.getInsertionPoint)
		        
		      end if
		      
		    end if
		    
		  end if
		  
		  ' Send notification of the change.
		  TextChanged
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub handleClickCount(x as integer, y as integer)
		  #pragma unused x
		  #pragma unused y
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim time as integer
		  
		  ' Get the time the mouse button was pressed.
		  time = ticks
		  
		  ' Have we timed out?
		  if (time - mouseDownStartTime) > getTripleClickTime then
		    
		    ' Record the starting offset.
		    lastClickOffset = anchorOffset
		    
		    ' Record the time the mouse button was pressed.
		    mouseDownStartTime = time
		    
		    ' Reset the click count.
		    clickCount = 1
		    
		    ' Are we in the click range and are we still over the last click point?
		  elseif clickCount >= 1 and clickcount <= 3 and (anchorOffset = lastClickOffset) then
		    
		    ' Bump up the click count.
		    clickCount = clickCount + 1
		    
		  else
		    
		    ' Record the starting offset.
		    lastClickOffset = anchorOffset
		    
		    ' Record the time the mouse button was pressed.
		    mouseDownStartTime = time
		    
		    ' Reset the click count.
		    clickCount = 1
		    
		  end if
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub handleClicks(x as integer, y as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Was there a double or triple click?
		  if clickCount > 1 then
		    
		    ' Was this a double click?
		    if clickCount = 2 then
		      
		      ' Handle the double click.
		      handleDoubleClick(x, y)
		      
		      ' Was this a triple click.
		    elseif clickCount = 3 then
		      
		      ' Handle the triple click.
		      handleTripleClick(x, y)
		      
		    end if
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function handleContentDrag(x as integer, y as integer, testing as boolean = false) As DragItem
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim startPosition as FTInsertionOffset
		  Dim endPosition as FTInsertionOffset
		  Dim d as DragItem
		  Dim recX as integer
		  Dim recY as integer
		  Dim width as integer
		  Dim height as integer
		  
		  ' Are we handling drags?
		  if not DragAndDrop then return nil
		  
		  ' Get the selection rectangle.
		  findSelectionRectangle(recX, recY, width, height)
		  
		  ' Adjust the coordinates.
		  x = x + (recX - mouseDownX)
		  y = y + (recY - mouseDownY)
		  
		  ' Are we doing an actual drag?
		  if testing then
		    
		    ' Create a test item for regression testing.
		    d = new FTTestDragItem
		    
		  else
		    
		    ' Create the drag item.
		    d = New DragItem(self.TrueWindow, x, y, width, height)
		    
		  end if
		  
		  ' Get the range of the selection.
		  doc.getSelectionRange(startPosition, endPosition)
		  
		  ' Set the data for the drop.
		  d.Text = doc.getText(startPosition, endPosition)
		  d.RawData(XML_DATA_TYPE) = doc.getXML(startPosition, endPosition)
		  d.RawData(RTF_DATA_TYPE) = doc.getRTF(startPosition, endPosition)
		  
		  ' Put in a flag to indicate it came from the FTC.
		  d.PrivateRawData(PRIVATE_DROP_TYPE) = Str(me.Handle)
		  
		  ' Set the mouse cursor.
		  d.MouseCursor = System.Cursors.StandardPointer
		  
		  ' Drag the item.
		  d.Drag
		  
		  ' Signal we are in a drag and drop situation.
		  inDragAndDrop = true
		  
		  ' Return the drag object for regression testing.
		  return d
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function handleDeleteKeys(key as string) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim fto as FTBase
		  Dim p as FTParagraph
		  
		  '-----------------------------------------------
		  ' Backwards delete key.
		  '-----------------------------------------------
		  
		  ' Was the backwards delete key pressed?
		  if asc(Key) = 8 then
		    handleBackwardDelete
		    return true
		  end if
		  
		  '-----------------------------------------------
		  ' Forwards delete key.
		  '-----------------------------------------------
		  
		  ' Was the Forwards delete key pressed?
		  if asc(Key) = 127 then
		    
		    ' Are we in read only mode?
		    if ReadOnly then return true
		    
		    ' Is there anything selected?
		    if doc.isSelected then
		      
		      ' Check for selected text being deleted.
		      saveUndoDelete(FTCStrings.DELETE)
		      
		      ' Check the style binding for the selection.
		      setSelectStyleBinding
		      
		      ' Delete the selected text.
		      deleteSelected
		      
		      ' Was everything deleted?
		      if doc.getLength = 0 then
		        
		        ' Clear the style binding.
		        setStyleBinding
		        
		      end if
		      
		    else
		      
		      ' Was the option key pressed?
		      if isOptionKeyPressed then
		        
		        ' Perform a forwards delete of the word.
		        handleOptionDeleteWord(true)
		        
		      else
		        
		        ' Are we deleting a picture?
		        if doc.isInResizeMode then
		          
		          ' Get the deleted item.
		          fto = doc.getObjectAtOffset(doc.getInsertionOffset)
		          
		        else
		          
		          ' Get the deleted item.
		          fto = doc.getObjectAtOffset(doc.getInsertionOffset + 1)
		          
		        end if
		        
		        ' Is this a style run?
		        if fto isa FTStyleRun then
		          
		          ' Set up the style binding.
		          setStyleBinding(fto)
		          
		        end if
		        
		        ' Delete a character.
		        updateFlag = doc.deleteCharacter(true, p)
		        
		        ' Clear the resize picture.
		        doc.clearResizePicture
		        
		        ' Did we combine a paragraph?
		        if not (p is nil) then fto = p
		        
		        ' Was something deleted?
		        if not (fto is nil) then
		          
		          ' Save the forward delete item.
		          undo.saveForwardDelete(fto, doc.getInsertionPoint)
		          
		        end if
		        
		      end if
		      
		    end if
		    
		    ' Send notification of the change.
		    TextChanged
		    
		    ' We handled the key.
		    return true
		    
		  end if
		  
		  '-------------------------------------------
		  
		  ' We did not handle it.
		  return false
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub handleDoubleClick(x as integer, y as integer)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim io as FTInsertionOffset
		  Dim startOffset as integer
		  Dim endOffset as integer
		  Dim p as FTParagraph
		  Dim text as string
		  Dim length as integer
		  Dim page as FTPage
		  Dim pageIndex as integer
		  Dim picX as integer
		  Dim picY as integer
		  Dim x1 as integer
		  Dim y1 as integer
		  Dim pic as FTPicture
		  
		  '-----------------------------------------------
		  ' Is this a double click in a picture?
		  '-----------------------------------------------
		  
		  ' Are we in resize mode?
		  if doc.isInResizeMode then
		    
		    ' Get the resize picture.
		    pic = doc.getResizePicture
		    
		    ' Find the relative picture coordinates.
		    call findPictureCoordinates(pic, page, picX, picY)
		    
		    ' Convert to page coordinates.
		    convertDisplayToPageCoordinates(x, y, pageIndex, x1, y1)
		    
		    ' Is the point within the picture?
		    if (pageIndex = page.getAbsolutePage) and _
		      pic.isPointWithin(x1 - picX, y1 - picY) then
		      
		      ' Do nothing.
		      return
		      
		    end if
		    
		  end if
		  
		  '-----------------------------------------------
		  ' Get some info.
		  '-----------------------------------------------
		  
		  ' Get the paragraph with the caret in it.
		  p = doc.getInsertionPoint.getCurrentParagraph
		  
		  ' Get the offset into the paragraph
		  io = doc.getInsertionPoint.getOffset
		  
		  ' Get the start of the paragraph.
		  startOffset = io.offset
		  endOffset = startOffset + 1
		  
		  ' Get the text from the paragraph.
		  text = p.getText(true)
		  
		  ' Get the length of the text.
		  length = p.getLength + 1
		  
		  '-----------------------------------------------
		  ' Scan for the word.
		  '-----------------------------------------------
		  
		  ' Scan backwards for white space.
		  while startOffset > 0
		    
		    ' Is this a space?
		    if FTUtilities.isWordDivider(mid(text, startOffset, 1)) then
		      
		      ' Trim the offset.
		      startOffset = startOffset + 1
		      
		      ' We found the beginning of the selection
		      exit
		      
		    end if
		    
		    ' Move to the next character.
		    startOffset = startOffset - 1
		    
		  wend
		  
		  '-----------------------
		  
		  ' Scan forwards for white space.
		  while endOffset <= length
		    
		    ' Is this a space?
		    if FTUtilities.isWordDivider(mid(text, endOffset, 1)) then
		      
		      ' Trim the offset.
		      endOffset = endOffset - 1
		      
		      ' We found the end of the selection
		      exit
		      
		    end if
		    
		    ' Move to the next character.
		    endOffset = endOffset + 1
		    
		  wend
		  
		  ' Range check the values.
		  if startOffset < 1 then startOffset = 1
		  if endOffset > length then endOffset = length
		  
		  '-----------------------------------------------
		  ' Select the word.
		  '-----------------------------------------------
		  
		  ' Do we have a valid selection range?
		  if endOffset >= startOffset then
		    
		    ' Is this a picture?
		    if (startOffset = endOffset) and _
		      p.isOffsetPicture(startOffset) then
		      
		      ' Deselect all the text.
		      doc.deselectAll
		      
		      ' Should we put it in resize mode?
		      if isOptionKeyPressed then
		        
		        ' Turn on resizing for the picture.
		        FTPicture(p.getItem(p.findItem(startOffset))).setResizeMode(true)
		        
		      end if
		      
		      ' Adjust the start offset.
		      startOffset = startOffset - 1
		      
		      ' Select the paragraph.
		      doc.selectSegment(io.paragraph, startOffset, io.paragraph, endOffset)
		      
		      ' Save the multi-click anchors.
		      anchorLeft.set(io.paragraph, startOffset)
		      anchorRight.set(io.paragraph, endOffset)
		      anchorType = 2
		      
		      ' Update the display.
		      update(true, true)
		      
		    else
		      
		      ' Is this an empty word?
		      if Trim(mid(text, startOffset, endOffset - startOffset + 1)) <> "" then
		        
		        ' Deselect all the text.
		        doc.deselectAll
		        
		        ' Adjust the start offset.
		        startOffset = startOffset - 1
		        
		        ' Select the paragraph.
		        doc.selectSegment(io.paragraph, startOffset, io.paragraph, endOffset)
		        
		        ' Save the multi-click anchors.
		        anchorLeft = doc.newInsertionOffset(io.paragraph, startOffset)
		        anchorRight = doc.newInsertionOffset(io.paragraph, endOffset)
		        anchorType = 2
		        
		        ' Update the display.
		        update(true, true)
		        
		      end if
		      
		    end if
		    
		  end if
		  
		  ' Call the double click event.
		  DoubleClick(x, y)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub handleDownArrowKey()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim selectStart as FTInsertionOffset
		  Dim selectEnd as FTInsertionOffset
		  Dim io as FTInsertionOffset
		  
		  ' Is the shift key pressed?
		  if Keyboard.ShiftKey then
		    
		    ' Is the option key pressed?
		    if isOptionKeyPressed then
		      
		      ' Handle the key combination.
		      handleShiftOptionDownArrowKey
		      
		    else
		      
		      ' Extend the selection to the next line.
		      doc.addToSelectionByLine(1)
		      
		    end if
		    
		  else
		    
		    ' Was something selected?
		    if doc.isSelected then
		      
		      ' Get the selection range.
		      doc.getSelectionRange(selectStart, selectEnd)
		      
		      ' Deselect any selection.
		      deselectAll
		      
		      ' Move the insertion point.
		      doc.setInsertionPoint(selectEnd, true)
		      
		    end if
		    
		    ' Is the option key pressed?
		    if isOptionKeyPressed then
		      
		      ' Get the current insertion offset.
		      io = doc.getInsertionPoint.getOffset
		      
		      ' Are we at the end of the paragraph?
		      if io.offset = doc.getParagraph(io.paragraph).getLength then
		        
		        ' Move to the next paragraph.
		        io.paragraph = min(io.paragraph + 1, doc.getParagraphCount - 1)
		        
		      end if
		      
		      ' Set the offset to the end.
		      io.offset = doc.getParagraph(io.paragraph).getLength
		      io.bias = false
		      
		      ' Set the insertion point.
		      setInsertionPoint(io, true)
		      
		    else
		      
		      ' Move the insertion point down one line.
		      doc.moveInsertionPointByLine(1, doc.getInsertionPoint.getCaretOffset, getDisplayScale)
		      
		    end if
		    
		    ' Reset the anchor.
		    doc.setAnchor
		    
		    ' Set up an undo object for typing.
		    undo.startNewInsertion(doc.getInsertionPoint.getOffset)
		    
		  end if
		  
		  ' Make sure the insertion point is visible.
		  call scrollToCaret
		  
		  ' Clear the style binding.
		  setStyleBinding
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub handleEndKey()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim selectStart as FTInsertionOffset
		  Dim selectEnd as FTInsertionOffset
		  Dim p as FTParagraph
		  Dim count as integer
		  
		  //End scrolls to end of document
		  //Holding Shift key selects from current position to end
		  //Option does nothing
		  if isOptionKeyPressed then return //Does nothing
		  
		  ' Is the shift key in play?
		  if Keyboard.ShiftKey then
		    
		    ' Use the current insertion point.
		    selectStart = doc.getInsertionPoint.getOffset
		    
		    ' Get the last paragraph index.
		    count = doc.getParagraphCount - 1
		    
		    ' Get the last paragraph.
		    p = doc.getParagraph(count)
		    
		    ' Set the end of the selection to the end of the document.
		    selectEnd = new FTInsertionOffset(doc, count, p.getLength)
		    
		    ' Select the segment.
		    doc.selectSegment(selectStart, selectEnd)
		    
		    ' Update the display.
		    update(true, true)
		    
		  elseif isCommandKeyPressed then ' Is the command key pressed?
		    
		    // Mantis Ticket 3802/1456: Command + (Shift Key) + Arrow Keys doesn't move insertion point correctly
		    
		    ' Move the insertion point to the end of the document.
		    doc.moveInsertionPointToEnd(true)
		    
		  else
		    ' No shift key.  Just scroll to end
		    
		    ' Move to the last page.
		    doc.moveToPage(doc.getNumberOfPages)
		  end
		  
		  //=========================
		  
		  //BK New functionality in Cocoa
		  ' ' Should we select to the end of the document?
		  ' if Keyboard.ShiftKey and isOptionKeyPressed then
		  '
		  ' '----------------------------------------------
		  ' ' shift-option-end
		  ' '----------------------------------------------
		  '
		  ' ' Is anything selected?
		  ' if doc.isSelected then
		  '
		  ' ' Get the selection range.
		  ' doc.getSelectionRange(selectStart, selectEnd)
		  '
		  ' else
		  '
		  ' ' Use the current insertion point.
		  ' selectStart = doc.getInsertionPoint.getOffset
		  '
		  ' end if
		  '
		  ' ' Get the last paragraph index.
		  ' count = doc.getParagraphCount - 1
		  '
		  ' ' Get the last paragraph.
		  ' p = doc.getParagraph(count)
		  '
		  ' ' Set the end of the selection to the end of the document.
		  ' selectEnd = new FTInsertionOffset(doc, count, p.getLength)
		  '
		  ' ' Select the segment.
		  ' doc.selectSegment(selectStart, selectEnd)
		  '
		  ' ' Update the display.
		  ' update(true, true)
		  '
		  ' elseif Keyboard.ShiftKey then
		  '
		  ' '----------------------------------------------
		  ' ' shift-end
		  ' '----------------------------------------------
		  '
		  ' ' Is anything selected?
		  ' if doc.isSelected then
		  '
		  ' ' Get the selection range.
		  ' doc.getSelectionRange(selectStart, selectEnd)
		  '
		  ' else
		  '
		  ' ' Use the current insertion point.
		  ' selectStart = doc.getInsertionPoint.getOffset
		  ' selectEnd = selectStart.clone
		  '
		  ' end if
		  '
		  ' ' Make sure the bias is set correctly.
		  ' selectEnd.bias = false
		  '
		  ' ' Set the insertion point to the end of the selection.
		  ' doc.setInsertionPoint(selectEnd, false)
		  '
		  ' ' Move to the end of the line.
		  ' doc.moveInsertionPointToLineEnd(true)
		  '
		  ' ' Set the end of the selection to the end of the line.
		  ' selectEnd = doc.getInsertionPoint.getOffset
		  '
		  ' ' Select the segment.
		  ' doc.selectSegment(selectStart, selectEnd)
		  '
		  ' ' Update the display.
		  ' update(true, true)
		  '
		  ' ' Should we move to the beginning of the document?
		  ' elseif isOptionKeyPressed then
		  '
		  ' '----------------------------------------------
		  ' ' option-end
		  ' '----------------------------------------------
		  '
		  ' ' Deselect the text.
		  ' doc.deselectAll
		  '
		  ' ' Move to the end of the document.
		  ' doc.moveInsertionPointToEnd(true)
		  '
		  ' ' Move to the last page.
		  ' doc.moveToPage(doc.getNumberOfPages)
		  '
		  ' ' Set up an undo object for typing.
		  ' undo.startNewInsertion(doc.getInsertionPoint.getOffset)
		  '
		  ' else
		  '
		  ' '----------------------------------------------
		  ' ' end
		  ' '----------------------------------------------
		  '
		  ' ' Deselect the text.
		  ' doc.deselectAll
		  '
		  ' ' Move to the end of the line.
		  ' doc.moveInsertionPointToLineEnd(true)
		  '
		  ' ' Set up an undo object for typing.
		  ' undo.startNewInsertion(doc.getInsertionPoint.getOffset)
		  '
		  ' end if
		  '
		  ' ' Reset the anchor.
		  ' doc.setAnchor
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function handleFolderDrop(fi as FolderItem, io as FTInsertionOffset) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim p as Picture
		  Dim s as string
		  
		  ' Attempt to open it as a picture.
		  p = Picture.Open(fi)
		  
		  ' Were we able to open it?
		  if not (p is nil) then
		    
		    ' Turn off any selected text.
		    doc.deselectAll
		    
		    ' Move the insertion pointer.
		    setInsertionPoint(io, true)
		    
		    ' Insert the picture.
		    insertPicture(p, fi)
		    
		    ' We were able to handle it.
		    return true
		    
		  end if
		  
		  ' Parse the suffix.
		  select case FTUtilities.getSuffix(fi.name)
		    
		  case "txt"
		    
		    ' Read the text file.
		    if not FTUtilities.readTextFile(fi, s) then return false
		    
		    ' Turn off any selected text.
		    doc.deselectAll
		    
		    ' Move the insertion pointer.
		    setInsertionPoint(io, true)
		    
		    ' Insert the text.
		    insertText(s)
		    
		    ' We were able to handle it.
		    return true
		    
		  case "rtf"
		    
		    ' Read the text file.
		    if not FTUtilities.readTextFile(fi, s) then return false
		    
		    ' Turn off any selected text.
		    doc.deselectAll
		    
		    ' Move the insertion pointer.
		    setInsertionPoint(io, true)
		    
		    ' Insert the rtf.
		    insertRTF(s)
		    
		    ' We were able to handle it.
		    return true
		    
		  end select
		  
		  ' We were not able to handle it.
		  return false
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub handleForwardDelete()
		  Dim fto as FTBase
		  Dim p as FTParagraph
		  
		  ' Are we in read only mode?
		  if ReadOnly then
		    return
		  end if
		  
		  ' Is there anything selected?
		  if doc.isSelected then
		    
		    ' Check for selected text being deleted.
		    saveUndoDelete(FTCStrings.DELETE)
		    
		    ' Check the style binding for the selection.
		    setSelectStyleBinding
		    
		    ' Delete the selected text.
		    deleteSelected
		    
		    ' Was everything deleted?
		    if doc.getLength = 0 then
		      
		      ' Clear the style binding.
		      setStyleBinding
		      
		    end if
		    
		  else
		    
		    ' Was the option key pressed?
		    if isOptionKeyPressed then
		      
		      ' Perform a forwards delete of the word.
		      handleOptionDeleteWord(true)
		      
		    else
		      
		      ' Are we deleting a picture?
		      if doc.isInResizeMode then
		        
		        ' Get the deleted item.
		        fto = doc.getObjectAtOffset(doc.getInsertionOffset)
		        
		      else
		        
		        ' Get the deleted item.
		        fto = doc.getObjectAtOffset(doc.getInsertionOffset + 1)
		        
		      end if
		      
		      ' Is this a style run?
		      if fto isa FTStyleRun then
		        
		        ' Set up the style binding.
		        setStyleBinding(fto)
		        
		      end if
		      
		      ' Delete a character.
		      updateFlag = doc.deleteCharacter(true, p)
		      
		      ' Clear the resize picture.
		      doc.clearResizePicture
		      
		      ' Did we combine a paragraph?
		      if not (p is nil) then fto = p
		      
		      ' Was something deleted?
		      if not (fto is nil) then
		        
		        ' Save the forward delete item.
		        undo.saveForwardDelete(fto, doc.getInsertionPoint)
		        
		      end if
		      
		    end if
		  end if
		  
		  
		  ' Send notification of the change.
		  TextChanged
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub handleHomeKey()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim selectStart as FTInsertionOffset
		  Dim selectEnd as FTInsertionOffset
		  
		  //Home scrolls to top of document
		  //Holding Shift key selects from current position to home/end
		  //Option does nothing
		  if isOptionKeyPressed then return //Does nothing
		  
		  ' Is the shift key in play?
		  if Keyboard.ShiftKey then
		    
		    ' Use the current insertion point.
		    selectEnd = doc.getInsertionPoint.getOffset
		    
		    ' Set the start of the selection to the beginning of the document.
		    selectStart = new FTInsertionOffset(doc, 0, 0)
		    
		    ' Select the segment.
		    doc.selectSegment(selectStart, selectEnd)
		    
		    ' Update the display.
		    update(true, true)
		    
		  else
		    ' No shift key.  Just scroll to beginning
		    
		    ' Move to the beginning of the document.
		    doc.moveInsertionPointToBeginning(true)
		    
		    ' Move to the first page.
		    doc.moveToPage(0)
		  end
		  
		  //BK:  Functionality appears to be different in Cocoa now.  Home/End keys don't quite to the same things.
		  ' ' Should we select to the beginning of the document?
		  ' if Keyboard.ShiftKey and isOptionKeyPressed then
		  '
		  ' '----------------------------------------------
		  ' ' shift-option-home
		  ' '----------------------------------------------
		  '
		  ' ' Is anything selected?
		  ' if doc.isSelected then
		  '
		  ' ' Get the selection range.
		  ' doc.getSelectionRange(selectStart, selectEnd)
		  '
		  ' else
		  '
		  ' ' Use the current insertion point.
		  ' selectEnd = doc.getInsertionPoint.getOffset
		  '
		  ' end if
		  '
		  ' ' Set the start of the selection to the beginning of the document.
		  ' selectStart = new FTInsertionOffset(doc, 0, 0)
		  '
		  ' ' Select the segment.
		  ' doc.selectSegment(selectStart, selectEnd)
		  '
		  ' ' Update the display.
		  ' update(true, true)
		  '
		  ' elseif Keyboard.ShiftKey then
		  '
		  ' '----------------------------------------------
		  ' ' shift-home
		  ' '----------------------------------------------
		  '
		  ' ' Is anything selected?
		  ' if doc.isSelected then
		  '
		  ' ' Get the selection range.
		  ' doc.getSelectionRange(selectStart, selectEnd)
		  '
		  ' else
		  '
		  ' ' Use the current insertion point.
		  ' selectStart = doc.getInsertionPoint.getOffset
		  ' selectEnd = selectStart.clone
		  '
		  ' end if
		  '
		  ' ' Set the insertion point to the start of the selection.
		  ' doc.setInsertionPoint(selectStart, false)
		  '
		  ' ' Move to the beginning of the line.
		  ' doc.moveInsertionPointToLineStart(true)
		  '
		  ' ' Set the start of the selection to the beginning of the line.
		  ' selectStart = doc.getInsertionPoint.getOffset
		  '
		  ' ' Select the segment.
		  ' doc.selectSegment(selectStart, selectEnd)
		  '
		  ' ' Update the display.
		  ' update(true, true)
		  '
		  ' ' Should we move to the beginning of the document?
		  ' elseif isOptionKeyPressed then
		  '
		  ' '----------------------------------------------
		  ' ' option-home
		  ' '----------------------------------------------
		  '
		  ' ' Deselect the text.
		  ' doc.deselectAll
		  '
		  ' ' Move to the beginning of the document.
		  ' doc.moveInsertionPointToBeginning(true)
		  '
		  ' ' Move to the first page.
		  ' doc.moveToPage(0)
		  '
		  ' ' Set up an undo object for typing.
		  ' undo.startNewInsertion(doc.getInsertionPoint.getOffset)
		  '
		  ' else
		  '
		  ' '----------------------------------------------
		  ' ' home
		  ' '----------------------------------------------
		  '
		  ' ' Deselect the text.
		  ' doc.deselectAll
		  '
		  ' ' Move to the beginning of the line.
		  ' doc.moveInsertionPointToLineStart(true)
		  '
		  ' ' Set up an undo object for typing.
		  ' undo.startNewInsertion(doc.getInsertionPoint.getOffset)
		  '
		  ' end if
		  '
		  ' ' Reset the anchor.
		  ' doc.setAnchor
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub handleLeftArrowKey()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim selectStart as FTInsertionOffset
		  Dim selectEnd as FTInsertionOffset
		  Dim io as FTInsertionOffset
		  
		  ' Is the shift key pressed?
		  if Keyboard.ShiftKey then
		    
		    ' Is the option key pressed?
		    if isOptionKeyPressed then
		      
		      ' Handle the key combination.
		      handleShiftOptionLeftArrowKey
		      
		    elseif isCommandKeyPressed then
		      
		      // Mantis Ticket 3802/1456: Command + (Shift Key) + Arrow Keys doesn't move insertion point correctly
		      
		      ' Select all until the beginning of the line.
		      selectStart = doc.getInsertionPoint.getOffset
		      
		      ' Move to the beginning of the line.
		      doc.moveInsertionPointToLineStart(true)
		      
		      ' Set the end of the selection to the beginning of the line.
		      selectEnd = doc.getInsertionPoint.getOffset
		      
		      ' Select the segment.
		      doc.selectSegment(selectStart, selectEnd)
		      
		    else
		      
		      ' Select left.
		      doc.addToSelection(-1)
		      
		    end if
		    
		  elseif isCommandKeyPressed then ' Is the command key pressed?
		    
		    // Mantis Ticket 3802/1456: Command + (Shift Key) + Arrow Keys doesn't move insertion point correctly
		    
		    ' Move the insertion point to the beginning of the line.
		    doc.moveInsertionPointToLineStart(false)
		    
		  else
		    
		    ' Was something selected?
		    if doc.isSelected then
		      
		      ' Get the selection range.
		      doc.getSelectionRange(selectStart, selectEnd)
		      
		      ' Deselect any selection.
		      deselectAll
		      
		      ' Move the insertion point.
		      doc.setInsertionPoint(selectStart, false)
		      
		    else
		      
		      ' Is the option key pressed?
		      if isOptionKeyPressed then
		        
		        ' Find the insertion offset for the next word boundary.
		        io = doc.findWordBoundaryAtInsertion(false, false)
		        
		        ' Set the insertion point.
		        setInsertionPoint(io, false)
		        
		      else
		        
		        ' Move the insertion point backwards.
		        doc.moveInsertionPoint(-1, true)
		        
		      end if
		      
		    end if
		    
		    ' Reset the anchor.
		    doc.setAnchor
		    
		    ' Set up an undo object for typing.
		    undo.startNewInsertion(doc.getInsertionPoint.getOffset)
		    
		  end if
		  
		  ' Make sure the insertion point is visible.
		  call scrollToCaret
		  
		  ' Clear the style binding.
		  setStyleBinding
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub handleMouseDown(x as integer, y as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim bias as boolean
		  
		  ' Save the current insertion point.
		  currentInsertionOffset = doc.getInsertionOffset
		  
		  ' Was the shift key held down?
		  if Keyboard.AsyncShiftKey then
		    
		    ' Shift drag selection.
		    mouseShiftDragSelection(x, y)
		    
		  else
		    
		    ' Should we change the insertion point?
		    if doc.findInsertionPoint(x, y, bias) then
		      
		      ' Get the mouse starting insertion position.
		      anchorOffset = doc.getInsertionOffset
		      lastEndPosition.clear
		      
		      ' Was something selected?
		      if doc.isSelected then
		        
		        ' Are we dragging a selection?
		        //BK 30Aug14 Added DRAGTIMEOUT.
		        if doc.isPositionSelected(anchorOffset) = false OR ((ticks - absoluteMouseDownTime) > DRAG_TIMEOUT) then
		          
		          
		          ' Deselect all the text.
		          doc.deselectAll
		          
		          ' Update the display.
		          update(true, true)
		          
		        end if
		        
		        
		      else
		        
		        ' Check to see if it's a Hyperlink
		        dim oOffset as FTInsertionOffset = GetDoc.findXYOffset(x, y)
		        if oOffset <> nil then
		          dim fto as FTObject = GetDoc.getObjectAtOffset(oOffset)
		          if fto isa FTStyleRun then
		            if FTStyleRun(fto).HyperLink <> "" then
		              ' Set the cursor to the Finger Pointer.
		              RaiseEvent HyperlinkClick FTStyleRun(fto).HyperLink
		              
		            end
		          end
		        end
		        
		        
		        ' Refresh the page.
		        blinkCaret(true)
		        
		      end if
		      
		    end if
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub handleMoveContent(selectStart as FTInsertionOffset, selectEnd as FTInsertionOffset, offset as FTInsertionOffset)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim content as string
		  Dim endOffset as FTInsertionOffset
		  Dim firstParagraphAttributes as ParagraphAttributes
		  Dim lastParagraphAttributes as ParagraphAttributes
		  
		  ' Mark the selected paragraphs as dirty.
		  doc.markDirtySelectedParagraphs
		  
		  ' Get the attributes of the last paragraph.
		  firstParagraphAttributes = doc.getParagraph(selectStart.paragraph).getParagraphAttributes
		  lastParagraphAttributes = doc.getParagraph(selectEnd.paragraph).getParagraphAttributes
		  
		  ' Get the selected content.
		  content = doc.getXML(selectStart, selectEnd)
		  
		  ' Are we moving the content after the current selection?
		  if offset > selectEnd then
		    
		    ' Move it down.
		    handleMoveContentDown(content, selectStart, selectEnd, offset)
		    
		  else
		    
		    ' Move it up.
		    handleMoveContentUp(content, offset)
		    
		  end if
		  
		  ' Update the display.
		  update(true, true)
		  
		  ' Set up the move undo.
		  doc.getSelectionRange(offset, endOffset)
		  undo.saveMove(selectStart, offset, endOffset, content, _
		  firstParagraphAttributes, lastParagraphAttributes)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub handleMoveContentDown(content as string, selectStart as FTInsertionOffset, selectEnd as FTInsertionOffset, offset as FTInsertionOffset)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim selectStartOffset as FTInsertionOffset
		  Dim selectEndOffset as FTInsertionOffset
		  Dim startMarker as FTMarker
		  Dim endMarker as FTMarker
		  
		  selectStartOffset = new FTInsertionOffset(getDoc)
		  selectEndOffset = new FTInsertionOffset(getDoc)
		  
		  ' Deselect everything.
		  doc.deselectAll
		  
		  ' Clear the resize picture.
		  doc.setResizePicture
		  
		  ' Are we past the end of the paragraph?
		  if offset.offset > offset.getParagraph.getLength then
		    
		    ' Reset to the end of the paragraph.
		    offset.offset = offset.getParagraph.getLength
		    
		  end if
		  
		  '-----------------------------------------------------
		  
		  ' Move the insertion pointer.
		  offset = offset - 1 'put dropped object to the left of the drop point
		  setInsertionPoint(offset, false)
		  
		  ' Insert a start of selection marker.
		  startMarker = new FTMarker(self, 1)
		  startMarker.setParagraph(offset.getParagraph)
		  doc.insertObject(startMarker)
		  
		  ' Insert the XML.
		  doc.insertXML(content, false, false)
		  
		  ' Compose the paragraphs.
		  doc.compose
		  
		  ' Get the end of the content insertion.
		  selectEndOffset = doc.getInsertionOffset
		  
		  ' Insert an end of selection marker.
		  endMarker = new FTMarker(self, 2)
		  endMarker.setParagraph(selectEndOffset.getParagraph)
		  doc.insertObject(endMarker)
		  
		  ' Compose the paragraphs.
		  doc.compose
		  
		  '-----------------------------------------------------
		  
		  ' Delete the original text.
		  doc.deleteSegment(selectStart, selectEnd)
		  
		  ' Compose the paragraphs.
		  doc.compose
		  
		  '-----------------------------------------------------
		  
		  ' Set up the start of the selection.
		  selectStartOffset.paragraph = startMarker.getParagraph.getAbsoluteIndex
		  selectStartOffset.offset = startMarker.getEndPosition + 1
		  
		  ' Set up the end of the selection.
		  selectEndOffset.paragraph = endMarker.getParagraph.getAbsoluteIndex
		  selectEndOffset.offset = endMarker.getEndPosition
		  
		  ' Get rid of the temporary markers.
		  startMarker.getParagraph.removeMarkers
		  endMarker.getParagraph.removeMarkers
		  
		  ' Reset the selection range.
		  doc.selectSegment(selectStartOffset, selectEndOffset)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub handleMoveContentUp(content as string, offset as FTInsertionOffset)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim endOffset as FTInsertionOffset
		  
		  ' Delete the original text.
		  doc.deleteSelected
		  
		  ' Move the insertion pointer.
		  setInsertionPoint(offset, false)
		  
		  ' Insert the XML.
		  insertXML(content)
		  
		  ' Get the end offset after insert the content.
		  endOffset = doc.getInsertionOffset
		  
		  ' Select the text.
		  doc.selectSegment(offset, endOffset)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub handleMovePicture(fromOffset as FTInsertionOffset, toOffset as FTInsertionOffset)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim selectStart as FTInsertionOffset
		  Dim selectEnd as FTInsertionOffset
		  Dim state as boolean
		  Dim pic as FTPicture
		  
		  ' Was the picture moved at all?
		  if fromOffset = (toOffset + 1) then return
		  
		  ' Turn off updates.
		  state = setInhibitUpdates(true)
		  
		  ' Get the picture.
		  pic = doc.getPictureAtOffset(fromOffset)
		  
		  ' Did we get a picture?
		  if not (pic is nil) then
		    
		    ' Clear the resize picture for the move.
		    doc.setResizePicture
		    
		    ' Select the picture.
		    doc.selectSegment(fromOffset - 1, fromOffset)
		    
		    ' Move the picture.
		    handleMoveContent(fromOffset - 1, fromOffset, toOffset)
		    
		    ' Get the current selection.
		    doc.getSelectionRange(selectStart, selectEnd)
		    
		    ' Turn off all the resize pictures.
		    doc.deselectResizePictures
		    
		    ' Reselect it as in resize mode.
		    doc.setResizePictureAtOffset(selectStart)
		    
		    ' Turn off the selection but leave it in resize mode.
		    doc.deselectAll
		    
		  end if
		  
		  ' Restore the previous update state.
		  call setInhibitUpdates(state)
		  
		  ' Update the display
		  update(true, true)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub handleOptionDeleteWord(forwards as boolean)
		  //Issue 4196: Remove GOTO Keywords from FTC
		  //BK:  Goto's removed from this method.  I think I have correct functionality
		  //If something is amiss, please report it.
		  
		  #Pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim length as integer
		  Dim index as integer
		  Dim paragraphIndex as integer
		  Dim io as FTInsertionOffset
		  Dim selectStart as FTInsertionOffset
		  Dim selectEnd as FTInsertionOffset
		  Dim delta as integer
		  Dim text as string
		  Dim ch as string
		  
		  ' Won't work when there is something selected.
		  if doc.isSelected then return
		  
		  ' Get the current offset.
		  io = doc.getInsertionOffset
		  
		  ' Initialize the indexes.
		  paragraphIndex = io.paragraph
		  index = io.offset
		  
		  ' Which direction are we going?
		  if forwards then
		    
		    ' Go forwards.
		    delta = 1
		    
		  else
		    
		    ' Make it zero based.
		    index = index - 1
		    
		    ' Go backwards.
		    delta = -1
		    
		  end if
		  
		  '-----------------------------------------
		  ' Go through the white space.
		  '-----------------------------------------
		  
		  Dim bLoop1 As Boolean = True
		  Dim bExitingLoop1 As Boolean
		  While bLoop1
		    
		    ' Get the text from the paragraph.
		    text = doc.getParagraph(paragraphIndex).getText(true)
		    
		    ' Get the length of the text.
		    length = text.len
		    
		    ' Get the first character.
		    ch = mid(text, index, 1)
		    
		    ' Are starting with a non-space character.
		    If Not FTUtilities.isWordDivider(ch) Then 
		      bExitingLoop1 = True
		      Exit
		    End
		    
		    ' Scan the text.
		    while (index >= 0) and (index <= length)
		      
		      ' Is this a word divider character?
		      if FTUtilities.isWordDivider(ch) then
		        
		        ' Move the index to the next character.
		        index = index + delta
		        
		        ' Have we gone off the edge of the paragraph?
		        if (index < 1) and (index > length) then
		          
		          ' Move to the next paragraph.
		          paragraphIndex = paragraphIndex + delta
		          
		          ' Are we going up?
		          if delta > 0 then
		            
		            ' Move to the start of the paragraph.
		            index = 1
		            
		          else
		            
		            ' Move to the end of the paragraph.
		            index = doc.getParagraph(paragraphIndex).getLength
		            
		          end if
		          
		        end if
		        
		        ' Move on to the next step.
		        bExitingLoop1 = True
		        Exit
		        
		      end if
		      
		      ' Move the character index.
		      index = index + delta
		      
		      ' Get the next character.
		      ch = mid(text, index, 1)
		      
		    wend
		    
		    If bExitingLoop1 = False Then
		      ' Move to the next paragraph.
		      paragraphIndex = paragraphIndex + delta
		      
		      ' Are we going up?
		      If delta > 0 Then
		        
		        ' Move to the start of the paragraph.
		        index = 1
		        
		      Else
		        
		        ' Move to the end of the paragraph.
		        index = doc.getParagraph(paragraphIndex).getLength
		        
		      End If
		    End
		    ' Go to the next paragraph.
		  Wend
		  
		  ' Move on.
		  
		  
		  '-----------------------------------------
		  ' Go through the non-white space.
		  '-----------------------------------------
		  
		  Dim bLoop2 As Boolean = True
		  Dim bExitingLoop2 As Boolean
		  While bLoop2
		    
		    ' Are we past the end of the paragraphs?
		    If paragraphIndex >= doc.getParagraphCount Then 
		      bLoop2 = False
		      bExitingLoop2 = True
		      Exit
		    End
		    
		    ' Get the text from the paragraph.
		    text = doc.getParagraph(paragraphIndex).getText(true)
		    
		    ' Get the length of the text.
		    length = text.len
		    
		    ' Get the first character.
		    ch = mid(text, index, 1)
		    
		    ' Scan the text.
		    While (index >= 0) And (index <= length)
		      
		      ' Did we find a white space?
		      If FTUtilities.isWordDivider(ch) Then 
		        bLoop2 = False
		        bExitingLoop2 = True
		        Exit
		      End
		      
		      ' Move the character index.
		      index = index + delta
		      
		      ' Get the next character.
		      ch = mid(text, index, 1)
		      
		    wend
		    
		    If bExitingLoop2 = False Then
		      
		      ' Move to the next paragraph.
		      paragraphIndex = paragraphIndex + delta
		      
		      ' Have we gone past the beginning?
		      If paragraphIndex < 0 Then
		        
		        ' Reset the indexes.
		        paragraphIndex = 0
		        index = 0
		        
		        ' Continue with the rest of the process.
		        Exit
		        bExitingLoop2 = True
		        
		      end if
		      
		      ' Are we going up?
		      if delta > 0 then
		        
		        ' Move to the start of the paragraph.
		        index = 1
		        
		      else
		        
		        ' Move to the end of the paragraph.
		        index = doc.getParagraph(paragraphIndex).getLength
		        
		      End If
		      
		    End
		    
		    ' Go to the next paragraph.
		  Wend
		  
		  '-----------------------------------------
		  
		  ' Move on.
		  
		  '-----------------------------------------
		  ' Delete the text.
		  '-----------------------------------------
		  
		  ' Get the selection range.
		  selectStart = new FTInsertionOffset(doc, io.paragraph, io.offset)
		  selectEnd = new FTInsertionOffset(doc, paragraphIndex, index)
		  
		  ' Is there anything to do?
		  if selectStart = selectEnd then return
		  
		  ' Do we need to swap the points?
		  if selectStart > selectEnd then
		    
		    ' Swap the points.
		    io = selectStart
		    selectStart = selectEnd
		    selectEnd = io
		    
		  end if
		  
		  ' Are we past the end of the paragraphs?
		  if selectEnd.paragraph >= doc.getParagraphCount then
		    
		    ' Reset to the end of the document.
		    selectEnd.paragraph = doc.getParagraphCount - 1
		    selectEnd.offset = doc.getParagraph(selectEnd.paragraph).getLength
		    
		    ' Is there anything to do?
		    if selectStart = selectEnd then return
		    
		  end if
		  
		  ' Select the word.
		  doc.selectSegment(selectStart, selectEnd)
		  
		  ' Is this a forwards delete?
		  if delta > 0 then
		    
		    ' Set up the undo.
		    saveUndoDelete(FTCStrings.FORWARD_DELETE)
		    
		  else
		    
		    ' Set up the undo.
		    saveUndoDelete(FTCStrings.DELETE)
		    
		  end if
		  
		  ' Delete the selected word.
		  deleteSelected
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub HandlePageDown(saveUpdate as boolean)
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Turn on updates.
		  call setInhibitUpdates(saveUpdate)
		  
		  ' Move back one page.
		  dim position as integer = vScrollbar.value + picDisplay.height
		  
		  ' Check the page range.
		  if position > vScrollbar.maximum then position = vScrollbar.maximum
		  
		  ' Set flag so we don't scroll back to cursor position
		  scrollToCaretFlag = false
		  
		  ' Move up on page.
		  VScrollTo position
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function handlePageKeys(saveUpdate as boolean) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim position as integer
		  
		  '-------------------------------------------
		  ' Home key.
		  '-------------------------------------------
		  
		  ' Was the home key pressed?
		  if Keyboard.AsyncKeyDown(&h073) then
		    
		    ' Turn on updates.
		    call setInhibitUpdates(saveUpdate)
		    
		    ' Handle the home key.
		    handleHomeKey
		    
		    ' We handled it.
		    return true
		    
		  end if
		  
		  '-------------------------------------------
		  ' End key.
		  '-------------------------------------------
		  
		  ' Was the end key pressed?
		  if Keyboard.AsyncKeyDown(&h077) then
		    
		    ' Turn on updates.
		    call setInhibitUpdates(saveUpdate)
		    
		    ' Handle the end key.
		    handleEndKey
		    
		    ' We handled the key.
		    return true
		    
		  end if
		  
		  '-------------------------------------------
		  ' Page up key.
		  '-------------------------------------------
		  
		  ' Was the page up key pressed?
		  if Keyboard.AsyncKeyDown(&h074) then
		    
		    ' Turn on updates.
		    call setInhibitUpdates(saveUpdate)
		    
		    ' Move back one page.
		    position = vScrollbar.value - picDisplay.height
		    
		    ' Check the scroll range.
		    if position < 0 then position = 0
		    
		    ' Move up on page.
		    vScrollbar.value = position
		    
		    ' We handled the key.
		    return true
		    
		  end if
		  
		  '-------------------------------------------
		  ' Page down key.
		  '-------------------------------------------
		  
		  ' Was the page down key pressed?
		  if Keyboard.AsyncKeyDown(&h079) then
		    
		    ' Turn on updates.
		    call setInhibitUpdates(saveUpdate)
		    
		    ' Move back one page.
		    position = vScrollbar.value + picDisplay.height
		    
		    ' Check the page range.
		    if position > vScrollbar.maximum then position = vScrollbar.maximum
		    
		    ' Move up on page.
		    vScrollbar.value = position
		    
		    ' We handled the key.
		    return true
		    
		  end if
		  
		  '-------------------------------------------
		  
		  ' We did not handle it.
		  return false
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub HandlePageUp(saveUpdate as boolean)
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Turn on updates.
		  call setInhibitUpdates(saveUpdate)
		  
		  ' Move back one page.
		  dim position as integer
		  
		  if vScrollbar <> nil then
		    position = vScrollbar.value - picDisplay.height
		  end
		  
		  ' Check the scroll range.
		  if position < 0 then position = 0
		  
		  ' Set flag so we don't scroll back to cursor position
		  scrollToCaretFlag = false
		  
		  ' Move up on page.
		  VScrollTo position
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub handlePictureDrag(x as integer, y as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim offset as FTInsertionOffset
		  Dim d as DragItem
		  Dim p as FTPicture
		  Dim recX as integer
		  Dim recY as integer
		  Dim width as integer
		  Dim height as integer
		  
		  ' Are we handling drags?
		  if not DragAndDrop then return
		  
		  ' Get the picture.
		  p = doc.getResizePicture
		  
		  ' Did we get the picture?
		  if p is nil then return
		  
		  ' Get the selection rectangle.
		  findSelectionRectangle(recX, recY, width, height)
		  
		  ' Adjust the coordinates.
		  x = x + (recX - mouseDownX)
		  y = y + (recY - mouseDownY)
		  
		  ' Create the drag item.
		  d = New DragItem(self.trueWindow, x, y, width, height)
		  
		  ' Get the picture offset.
		  offset = doc.getInsertionOffset
		  offset.offset = doc.getParagraph(offset.paragraph).findOffsetOfPicture(p) - 1
		  
		  ' Set the data for the drop.
		  d.Picture = p.getOriginalPicture
		  d.RawData(XML_DATA_TYPE) = doc.getXML(offset, offset + 1)
		  d.RawData(RTF_DATA_TYPE) = doc.getRTF(offset, offset + 1)
		  
		  ' Put in a flag to indicate it came from the FTC and is a picture.
		  d.PrivateRawData(PRIVATE_DROP_TYPE) = Str(me.Handle) + "/" + _
		  Str(offset.paragraph) +  "/" + Str(offset.offset + 1)
		  
		  ' Set the mouse cursor.
		  d.MouseCursor = System.Cursors.StandardPointer
		  
		  ' Drag the item.
		  d.Drag
		  
		  ' Signal we are in a drag and drop situation.
		  inDragAndDrop = true
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function handlePictureResize(x as integer, y as integer) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Is a picture in resize mode?
		  doc.findResizeModePicture(x, y)
		  
		  ' Is a picture selected?
		  if doc.isInResizeMode then
		    
		    ' Are we in a handle?
		    if doc.getResizeHandle <> FTPicture.Handle_Type.None then
		      
		      ' Set the appropriate cursor.
		      setHandleCursor(doc.getResizeHandle)
		      
		      ' Turn off the handles.
		      doc.getResizePicture.setDrawHandles(false)
		      
		      ' Mark the paragraph as dirty.
		      doc.getResizeParagraph.makeDirty
		      
		      ' Update the display.
		      update(true, true)
		      
		      ' We handled the click.
		      return false
		      
		    end if
		    
		  end if
		  
		  ' We did not handle the click.
		  return true
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub handleRightArrowKey()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim selectStart as FTInsertionOffset
		  Dim selectEnd as FTInsertionOffset
		  Dim io as FTInsertionOffset
		  
		  ' Is the shift key pressed?
		  if Keyboard.ShiftKey then
		    
		    '--------------------------------------------------
		    ' Shift key.
		    '--------------------------------------------------
		    
		    ' Is the option key pressed?
		    if isOptionKeyPressed then
		      
		      ' Handle the key combination.
		      handleShiftOptionRightArrowKey
		      
		    elseif isCommandKeyPressed then
		      
		      // Mantis Ticket 3802/1456: Command + (Shift Key) + Arrow Keys doesn't move insertion point correctly
		      
		      ' Select all until the end of the line.
		      selectStart = doc.getInsertionPoint.getOffset
		      
		      ' Move to the end of the line.
		      doc.moveInsertionPointToLineEnd(true)
		      
		      ' Set the end of the selection to the end of the line.
		      selectEnd = doc.getInsertionPoint.getOffset
		      
		      ' Select the segment.
		      doc.selectSegment(selectStart, selectEnd)
		      
		    else
		      
		      ' Select right.
		      doc.addToSelection(1)
		      
		    end if
		    
		  elseif isCommandKeyPressed then ' Is the command key pressed?
		    
		    // Mantis Ticket 3802/1456: Command + (Shift Key) + Arrow Keys doesn't move insertion point correctly
		    
		    ' Move the insertion point to the end of the line.
		    doc.moveInsertionPointToLineEnd(false)
		    
		  else
		    
		    '--------------------------------------------------
		    ' Non-shift key.
		    '--------------------------------------------------
		    
		    ' Was something selected?
		    if doc.isSelected then
		      
		      ' Get the selection range.
		      doc.getSelectionRange(selectStart, selectEnd)
		      
		      ' Deselect any selection.
		      deselectAll
		      
		      ' Move the insertion point.
		      doc.setInsertionPoint(selectEnd, true)
		      
		    else
		      
		      ' Is the option key pressed?
		      if isOptionKeyPressed then
		        
		        ' Find the insertion offset for the next word boundary.
		        io = doc.findWordBoundaryAtInsertion(true, false)
		        
		        ' Set the insertion point.
		        setInsertionPoint(io, false)
		        
		      else
		        
		        ' Move the insertion point forwards.
		        doc.moveInsertionPoint(1, true)
		        
		      end if
		      
		    end if
		    
		    ' Reset the anchor.
		    doc.setAnchor
		    
		    ' Set up an undo object for typing.
		    undo.startNewInsertion(doc.getInsertionPoint.getOffset)
		    
		  end if
		  
		  '--------------------------------------------------
		  
		  ' Make sure the insertion point is visible.
		  call scrollToCaret
		  
		  ' Clear the style binding.
		  setStyleBinding
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub handleShiftOptionDownArrowKey()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #EndIf
		  
		  Dim selectStart as FTInsertionOffset
		  Dim selectEnd as FTInsertionOffset
		  Dim currentIo as FTInsertionOffset
		  Dim io as FTInsertionOffset
		  
		  ' Get the current insertion offset.
		  currentIo = doc.getInsertionOffset
		  
		  ' Is something selected?
		  if doc.isSelected then
		    
		    ' Get the current selection range.
		    doc.getSelectionRange(selectStart, selectEnd)
		    
		    ' Create a copy.
		    io = currentIo.clone
		    
		    ' Are we at the end of a paragraph?
		    if io.offset = doc.getParagraph(io.paragraph).getLength then
		      
		      ' Move to the next paragraph.
		      io.paragraph = min(io.paragraph + 1, doc.getParagraphCount - 1)
		      
		    end if
		    
		    ' Set it to the end of the paragraph.
		    io.offset = doc.getParagraph(io.paragraph).getLength
		    
		    ' Set the insertion point for the next time around.
		    doc.setInsertionPoint(io, false)
		    
		    ' Is the current insertion point at the beginning?
		    if currentIo = selectStart then
		      
		      ' Select the segment.
		      doc.selectSegment(io, selectEnd)
		      
		    else
		      
		      ' Select the segment.
		      doc.selectSegment(selectStart, io)
		      
		    end if
		    
		  else
		    
		    ' Create a copy.
		    io = currentIo.clone
		    
		    ' Are we at the end of a paragraph?
		    if io.offset = doc.getParagraph(io.paragraph).getLength then
		      
		      ' Move to the next paragraph.
		      io.paragraph = min(io.paragraph + 1, doc.getParagraphCount - 1)
		      
		    end if
		    
		    ' Set it to the end of the paragraph.
		    io.offset = doc.getParagraph(io.paragraph).getLength
		    
		    ' Set the insertion point for the next time around.
		    doc.setInsertionPoint(io, false)
		    
		    ' Select the segment.
		    doc.selectSegment(currentIo, io)
		    
		  end if
		  
		  ' Reset the anchor.
		  doc.setAnchor
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub handleShiftOptionLeftArrowKey()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim selectStart as FTInsertionOffset
		  Dim selectEnd as FTInsertionOffset
		  Dim currentIo as FTInsertionOffset
		  Dim io as FTInsertionOffset
		  
		  ' Get the current insertion offset.
		  currentIo = doc.getInsertionOffset
		  
		  ' Is something selected?
		  if doc.isSelected then
		    
		    ' Get the current selection range.
		    doc.getSelectionRange(selectStart, selectEnd)
		    
		    ' Find the insertion offset for the next word boundary.
		    io = doc.findWordBoundaryAtInsertion(false, currentIo = selectEnd)
		    
		    ' Did we flip the ends?
		    if io < selectStart then
		      
		      ' Look for the boundary again.
		      io = doc.findWordBoundaryAtInsertion(false, false)
		      
		    end if
		    
		    ' Set the insertion point for the next time around.
		    doc.setInsertionPoint(io, false)
		    
		    ' Is the current insertion point at the beginning?
		    if currentIo = selectStart then
		      
		      ' Select the segment.
		      doc.selectSegment(io, selectEnd)
		      
		    else
		      
		      ' Select the segment.
		      doc.selectSegment(selectStart, io)
		      
		    end if
		    
		  else
		    
		    ' Find the insertion offset for the next word boundary.
		    io = doc.findWordBoundaryAtInsertion(false, false)
		    
		    ' Set the insertion point for the next time around.
		    doc.setInsertionPoint(io, false)
		    
		    ' Select the segment.
		    doc.selectSegment(currentIo, io)
		    
		  end if
		  
		  ' Reset the anchor.
		  doc.setAnchor
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub handleShiftOptionRightArrowKey()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim selectStart as FTInsertionOffset
		  Dim selectEnd as FTInsertionOffset
		  Dim currentIo as FTInsertionOffset
		  Dim io as FTInsertionOffset
		  
		  ' Get the current insertion offset.
		  currentIo = doc.getInsertionOffset
		  
		  ' Is something selected?
		  if doc.isSelected then
		    
		    ' Get the current selection range.
		    doc.getSelectionRange(selectStart, selectEnd)
		    
		    ' Find the insertion offset for the next word boundary.
		    io = doc.findWordBoundaryAtInsertion(true, currentIo = selectStart)
		    
		    ' Did we flip the ends?
		    if io > selectEnd then
		      
		      ' Look for the boundary again.
		      io = doc.findWordBoundaryAtInsertion(true, false)
		      
		    end if
		    
		    ' Set the insertion point for the next time around.
		    doc.setInsertionPoint(io, false)
		    
		    ' Is the current insertion point at the beginning?
		    if currentIo = selectStart then
		      
		      ' Select the segment.
		      doc.selectSegment(io, selectEnd)
		      
		    else
		      
		      ' Select the segment.
		      doc.selectSegment(selectStart, io)
		      
		    end if
		    
		  else
		    
		    ' Find the insertion offset for the next word boundary.
		    io = doc.findWordBoundaryAtInsertion(true, false)
		    
		    ' Set the insertion point for the next time around.
		    doc.setInsertionPoint(io, false)
		    
		    ' Select the segment.
		    doc.selectSegment(currentIo, io)
		    
		  end if
		  
		  ' Reset the anchor.
		  doc.setAnchor
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub handleShiftOptionUpArrowKey()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim selectStart as FTInsertionOffset
		  Dim selectEnd as FTInsertionOffset
		  Dim currentIo as FTInsertionOffset
		  Dim io as FTInsertionOffset
		  
		  ' Get the current insertion offset.
		  currentIo = doc.getInsertionOffset
		  
		  ' Is something selected?
		  if doc.isSelected then
		    
		    ' Get the current selection range.
		    doc.getSelectionRange(selectStart, selectEnd)
		    
		    ' Create a copy.
		    io = currentIo.clone
		    
		    ' Are we at the beginning of a paragraph?
		    if io.offset = 0 then
		      
		      ' Move to the previous paragraph.
		      io.paragraph = max(io.paragraph - 1, 0)
		      
		    end if
		    
		    ' Set it to the beginning of the paragraph.
		    io.offset = 0
		    
		    ' Set the insertion point for the next time around.
		    doc.setInsertionPoint(io, false)
		    
		    ' Is the current insertion point at the beginning?
		    if currentIo = selectStart then
		      
		      ' Select the segment.
		      doc.selectSegment(io, selectEnd)
		      
		    else
		      
		      ' Select the segment.
		      doc.selectSegment(selectStart, io)
		      
		    end if
		    
		  else
		    
		    ' Create a copy.
		    io = currentIo.clone
		    
		    ' Are we at the beginning of a paragraph?
		    if io.offset = 0 then
		      
		      ' Move to the previous paragraph.
		      io.paragraph = max(io.paragraph - 1, 0)
		      
		    end if
		    
		    ' Set it to the beginning of the paragraph.
		    io.offset = 0
		    
		    ' Set the insertion point for the next time around.
		    doc.setInsertionPoint(io, false)
		    
		    ' Select the segment.
		    doc.selectSegment(currentIo, io)
		    
		  end if
		  
		  ' Reset the anchor.
		  doc.setAnchor
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function handleSingleClick(x as integer, y as integer) As boolean
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim p as FTParagraph
		  Dim pic as FTPicture
		  Dim bias as boolean
		  
		  ' Is this a normal click?
		  if not inMouseDrag then
		    
		    ' Is this point in a picture?
		    if doc.isPointInPicture(x, y, vScrollValue, picDisplay.height, p, pic) then
		      
		      ' Has the picture changed?
		      if not (pic is doc.getResizePicture) then
		        
		        ' Turn the resize mode off for any previous picture.
		        doc.deselectResizePictures
		        
		        ' Turn the resize mode on if needed.
		        doc.setResizePicture(pic, p, x, y)
		        
		        ' Set up an undo object for typing.
		        undo.startNewInsertion(doc.getInsertionPoint.getOffset)
		        
		      end if
		      
		    end if
		    
		  end if
		  
		  ' Get the paragraph with the caret in it.
		  p = doc.getInsertionPoint.getCurrentParagraph
		  
		  ' Make sure the caret is turned off.
		  doc.getInsertionPoint.setCaretState(false)
		  
		  ' Update the display.
		  update(true, true)
		  
		  ' Call the single click event.
		  SingleClick(x, y)
		  
		  ' Is there a resize picture?
		  if not (doc.getResizePicture is nil) then
		    
		    ' Deselect all of the text.
		    deselectAll
		    
		    ' We handled it.
		    return true
		    
		  end if
		  
		  ' Are we doing a normal click?
		  if not inMouseDrag then
		    
		    ' Find the new insertion point.
		    if doc.findInsertionPoint(x, y, bias) then
		      
		      ' Clear the style binding.
		      setStyleBinding
		      
		      ' Set up an undo object for typing.
		      undo.startNewInsertion(doc.getInsertionPoint.getOffset)
		      
		      ' Is the insertion point within a selection?
		      if doc.isPositionSelected(doc.getInsertionPoint.getOffset) then
		        
		        ' Deselect all of the text.
		        deselectAll
		        
		        ' Reset the anchor.
		        doc.setAnchor
		        
		        ' We handled it.
		        return true
		        
		      else
		        
		        ' Reset the anchor.
		        doc.setAnchor
		        
		      end if
		      
		    end if
		    
		  end if
		  
		  
		  if not doc.isSelected and Lastinsertion <> doc.getInsertionPoint.getOffset.offset then
		    callSelectionChangedEvent()
		    Lastinsertion = doc.getInsertionPoint.getOffset.offset
		  end
		  
		  ' We did not handle it.
		  return false
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub handleTripleClick(x as integer, y as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim startOffset as FTInsertionOffset
		  Dim endOffset as FTInsertionOffset
		  Dim p as FTParagraph
		  
		  ' Get the paragraph with the caret in it.
		  p = doc.getInsertionPoint.getCurrentParagraph
		  
		  ' Find the selection range of the paragraph.
		  startOffset = doc.getInsertionPoint.getOffset
		  startOffset.offset = 0
		  
		  ' Is this an empty paragraph?
		  if p.getLength = 0 then
		    
		    ' Find the selection range of the paragraph.
		    endOffset = startOffset.clone
		    
		  else
		    
		    ' Find the selection range of the paragraph.
		    endOffset = startOffset.clone
		    endOffset.offset = p.getLength + 1
		    
		  end if
		  
		  ' Do we have a valid selection range?
		  if endOffset >= startOffset then
		    
		    ' Deselect all the text.
		    doc.deselectAll
		    doc.deselectResizePictures
		    
		    ' Select the paragraph.
		    doc.selectSegment(startOffset, endOffset)
		    
		    ' Save the multi-click anchors.
		    anchorLeft = startOffset
		    anchorRight = endOffset
		    anchorType = 3
		    
		    ' Update the display.
		    update(true, true)
		    
		  end if
		  
		  ' Call the triple click event.
		  TripleClick(x, y)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub handleUpArrowKey()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim selectStart as FTInsertionOffset
		  Dim selectEnd as FTInsertionOffset
		  Dim io as FTInsertionOffset
		  
		  ' Is the shift key pressed?
		  if Keyboard.ShiftKey then
		    
		    ' Is the option key pressed?
		    if isOptionKeyPressed then
		      
		      ' Handle the key combination.
		      handleShiftOptionUpArrowKey
		      
		    else
		      
		      ' Extend the selection to the previous line.
		      doc.addToSelectionByLine(-1)
		      
		    end if
		    
		  elseif isCommandKeyPressed then ' Is the command key pressed?
		    
		    // Mantis Ticket 3802/1456: Command + (Shift Key) + Arrow Keys doesn't move insertion point correctly
		    
		    ' Move the insertion point to the beginning of the document.
		    doc.moveInsertionPointToBeginning(false)
		    
		  else
		    
		    ' Was something selected?
		    if doc.isSelected then
		      
		      ' Get the selection range.
		      doc.getSelectionRange(selectStart, selectEnd)
		      
		      ' Deselect any selection.
		      deselectAll
		      
		      ' Move the insertion point.
		      doc.setInsertionPoint(selectStart - 1, true)
		      
		    end if
		    
		    ' Is the option key pressed?
		    if isOptionKeyPressed then
		      
		      ' Get the current insertion offset.
		      io = doc.getInsertionPoint.getOffset
		      
		      ' Are we at the beginning of the paragraph?
		      if io.offset = 0 then
		        
		        ' Move to the previous paragraph.
		        io.paragraph = max(io.paragraph - 1, 0)
		        
		      end if
		      
		      ' Set the offset to the beginning.
		      io.offset = 0
		      
		      ' Set the insertion point.
		      setInsertionPoint(io, false)
		      
		    else
		      
		      ' Move the insertion point up one line.
		      doc.moveInsertionPointByLine(-1, doc.getInsertionPoint.getCaretOffset, getDisplayScale)
		      
		    end if
		    
		    ' Reset the anchor.
		    doc.setAnchor
		    
		    ' Set up an undo object for typing.
		    undo.startNewInsertion(doc.getInsertionPoint.getOffset)
		    
		  end if
		  
		  ' Make sure the insertion point is visible.
		  call scrollToCaret
		  
		  ' Clear the style binding.
		  setStyleBinding
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub hideAutoComplete()
		  if m_bAutoCompleteVisible and m_wAutoComplete<>nil then
		    m_wAutoComplete.Close
		    m_wAutoComplete = nil
		    m_bAutoCompleteVisible = false
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub hScroll(position as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Should we ignore this event?
		  if inhibitScroll then return
		  
		  ' Save the display position.
		  hScrollValue = -position
		  
		  ' Update the display.
		  update(false, true)
		  
		  ' Let the world know.
		  ScrollChanged(vScrollValue, hScrollValue)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub hScrollTo(position as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Does the scrollbar exist?
		  if not (hScrollbar is nil) then
		    
		    ' Check the range.
		    position = Max(position, 0)
		    position = Min(position, hScrollbar.Maximum)
		    
		    ' Did anything change?
		    if hScrollbar.Value <> position then
		      
		      ' Scroll the the desired position.
		      hScrollbar.Value = position
		      
		    end if
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub insertCustomObject(obj as FTCustom, undoName as string)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim selectStart as FTInsertionOffset
		  Dim selectEnd as FTInsertionOffset
		  Dim newOffset as FTInsertionOffset
		  Dim firstPa as ParagraphAttributes
		  Dim newContent as string
		  Dim selectedContent as string
		  
		  ' Get the selected content and range.
		  selectedContent = doc.getSelectedXML(selectStart, selectEnd)
		  
		  ' Save the first paragraphs attributes.
		  firstPa = doc.getParagraph(selectStart.paragraph).getParagraphAttributes
		  
		  ' Insert a custom object.
		  insertObject(obj)
		  
		  ' Get the current offset.
		  newOffset = doc.getInsertionOffset
		  
		  ' Get the inserted content.
		  newContent = doc.getXML(selectStart, newOffset)
		  
		  ' Set up the undo.
		  getUndoManager.saveCustomInsertion(undoName, selectStart, selectEnd, _
		  newOffset, selectedContent, newContent, firstPa)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub insertFTPicture(targetPicture as FTPicture)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Insert the picture into the document.
		  doc.insertObject(targetPicture)
		  
		  ' Send notification of the change.
		  TextChanged
		  
		  ' Update the display.
		  update(true, true)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub insertObject(obj as FTObject)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Insert the object into the document.
		  doc.insertObject(obj)
		  
		  ' Send notification of the change.
		  TextChanged
		  
		  ' Update the display.
		  update(true, true)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub insertPageBreak()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim ip as FTInsertionPoint
		  Dim selectedContent as string
		  Dim startPosition as FTInsertionOffset
		  Dim endPosition as FTInsertionOffset
		  
		  ' Get the insertion point.
		  ip = doc.getInsertionPoint
		  
		  ' Is something selected?
		  if doc.isSelected then
		    
		    ' Get the range of the selection.
		    doc.getSelectionRange(startPosition, endPosition)
		    
		    ' Get the selected content.
		    selectedContent = doc.getXML(startPosition, endPosition)
		    
		    ' Delete the selected text.
		    doc.deleteSelected
		    
		  else
		    
		    ' Get the insertion position.
		    startPosition = doc.getInsertionOffset
		    
		  end if
		  
		  ' Save the page break undo.
		  undo.savePageBreak(startPosition, endPosition, selectedContent)
		  
		  ' Insert the page break into the document.
		  doc.insertPageBreak(startPosition)
		  
		  ' Send notification of the change.
		  TextChanged
		  
		  ' Update the display.
		  updatePages(true, true)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub insertPicture(targetPicture as Picture, fi as FolderItem = nil)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim p as Picture
		  Dim ftp as FTPicture
		  
		  ' Is there anything to insert?
		  if targetPicture is nil then return
		  
		  ' Create the picture.
		  p = new Picture(targetPicture.Width, targetPicture.Height, BIT_DEPTH)
		  
		  ' Copy over the picture.
		  p.Graphics.DrawPicture(targetPicture, 0, 0)
		  
		  ' Create the container.
		  ftp = new FTPicture(self, p, true)
		  
		  ' Save the folder item reference.
		  ftp.associatedFolderItem = fi
		  
		  ' Insert the picture into the document.
		  doc.insertPicture(ftp)
		  
		  ' Send notification of the change.
		  TextChanged
		  
		  ' Update the display.
		  update(true, true)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub insertPictureWithUndo(targetPicture as Picture)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim newContent as string
		  Dim selectedContent as string
		  Dim selectStart as FTInsertionOffset
		  Dim selectEnd as FTInsertionOffset
		  Dim newOffset as FTInsertionOffset
		  Dim firstPa as ParagraphAttributes
		  Dim delta as integer
		  
		  ' Is there anything to do?
		  if ReadOnly then return
		  
		  ' Set the Mouse Cursor
		  'BK 08August12 Lengthy paste needs wait cursor
		  self.MouseCursor = system.Cursors.Wait
		  
		  ' Get the selected content and range.
		  selectedContent = doc.getSelectedXML(selectStart, selectEnd)
		  
		  ' Save the first paragraphs attributes.
		  firstPa = doc.getParagraph(selectStart.paragraph).getParagraphAttributes
		  
		  'insert our Picture
		  insertPicture(targetPicture)
		  
		  ' Get the new offset for the inserted text.
		  newOffset = doc.getInsertionOffset
		  
		  ' Compute the position compared to the end of the paragraph.
		  delta = newOffset.offset - newOffset.getParagraph.getLength
		  
		  ' Are we past the end?
		  if delta > 0 then
		    
		    ' Readjust the offsets.
		    newOffset.offset = newOffset.offset - delta
		    selectStart.offset = selectStart.offset - delta
		    
		  end if
		  
		  ' Get the inserted content.
		  newContent = doc.getXml(selectStart, newOffset)
		  
		  ' Save the undo paste action.
		  undo.savePaste(selectStart, selectEnd, newOffset, _
		  selectedContent, newContent, firstPa)
		  
		  ' Send notification of the change.
		  TextChanged
		  
		  ' Set the Mouse Cursor
		  'BK 08August12 Lengthy paste needs wait cursor
		  self.MouseCursor = nil
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub insertRTF(text as string)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim s as string
		  
		  ' Get the RTF data
		  s = DefineEncoding(text, Encodings.ASCII)
		  
		  ' Trim off the null terminator.
		  s = replaceAllB(s, Chr(0), "")
		  
		  ' Paste the RTF text.
		  call doc.insertRtfString(s)
		  
		  ' Send notification of the change.
		  TextChanged
		  
		  ' Update the display.
		  update(true, true)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub InsertRTFWithUndo(s as string)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim newContent as string
		  Dim selectedContent as string
		  Dim selectStart as FTInsertionOffset
		  Dim selectEnd as FTInsertionOffset
		  Dim newOffset as FTInsertionOffset
		  Dim firstPa as ParagraphAttributes
		  Dim delta as integer
		  
		  ' Is there anything to do?
		  if ReadOnly then return
		  
		  ' Set the Mouse Cursor
		  'BK 08August12 Lengthy paste needs wait cursor
		  self.MouseCursor = system.Cursors.Wait
		  
		  ' Get the selected content and range.
		  selectedContent = doc.getSelectedXML(selectStart, selectEnd)
		  
		  ' Save the first paragraphs attributes.
		  firstPa = doc.getParagraph(selectStart.paragraph).getParagraphAttributes
		  
		  
		  
		  insertRTF(s)
		  
		  '' Is there a picture available?
		  'if cb.PictureAvailable then
		  '
		  ''--------------------------------------------
		  '' Picture.
		  ''--------------------------------------------
		  '
		  'insertPicture(cb.Picture)
		  '
		  'end if
		  
		  
		  ' Get the new offset for the inserted text.
		  newOffset = doc.getInsertionOffset
		  
		  ' Compute the position compared to the end of the paragraph.
		  delta = newOffset.offset - newOffset.getParagraph.getLength
		  
		  ' Are we past the end?
		  if delta > 0 then
		    
		    ' Readjust the offsets.
		    newOffset.offset = newOffset.offset - delta
		    selectStart.offset = selectStart.offset - delta
		    
		  end if
		  
		  ' Get the inserted content.
		  newContent = doc.getXml(selectStart, newOffset)
		  
		  ' Save the undo paste action.
		  undo.savePaste(selectStart, selectEnd, newOffset, _
		  selectedContent, newContent, firstPa)
		  
		  ' Send notification of the change.
		  TextChanged
		  
		  ' Set the Mouse Cursor
		  'BK 08August12 Lengthy paste needs wait cursor
		  self.MouseCursor = nil
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub insertTab(numberOfTabs as integer = 1)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  
		  ' Is there anything to do?
		  if numberOfTabs < 1 then return
		  
		  ' Insert the tabs.
		  for i = 1 to numberOfTabs
		    
		    ' Insert the tab into the document.
		    doc.insertObject(new FTTab(self))
		    
		  next
		  
		  ' Send notification of the change.
		  TextChanged
		  
		  ' Update the display.
		  update(true, true)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub insertText(s as string)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Insert the text.
		  doc.insertString(s)
		  
		  ' Send notification of the change.
		  TextChanged
		  
		  ' Update the display.
		  update(true, true)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub InsertTextWithUndo(s as string)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim newContent as string
		  Dim selectedContent as string
		  Dim selectStart as FTInsertionOffset
		  Dim selectEnd as FTInsertionOffset
		  Dim newOffset as FTInsertionOffset
		  Dim firstPa as ParagraphAttributes
		  Dim delta as integer
		  
		  ' Is there anything to do?
		  if ReadOnly then return
		  
		  ' Set the Mouse Cursor
		  'BK 08August12 Lengthy paste needs wait cursor
		  self.MouseCursor = system.Cursors.Wait
		  
		  ' Get the selected content and range.
		  selectedContent = doc.getSelectedXML(selectStart, selectEnd)
		  
		  ' Save the first paragraphs attributes.
		  firstPa = doc.getParagraph(selectStart.paragraph).getParagraphAttributes
		  
		  
		  
		  insertText(s)
		  
		  '' Is there a picture available?
		  'if cb.PictureAvailable then
		  '
		  ''--------------------------------------------
		  '' Picture.
		  ''--------------------------------------------
		  '
		  'insertPicture(cb.Picture)
		  '
		  'end if
		  
		  
		  ' Get the new offset for the inserted text.
		  newOffset = doc.getInsertionOffset
		  
		  ' Compute the position compared to the end of the paragraph.
		  delta = newOffset.offset - newOffset.getParagraph.getLength
		  
		  ' Are we past the end?
		  if delta > 0 then
		    
		    ' Readjust the offsets.
		    newOffset.offset = newOffset.offset - delta
		    selectStart.offset = selectStart.offset - delta
		    
		  end if
		  
		  ' Get the inserted content.
		  newContent = doc.getXml(selectStart, newOffset)
		  
		  ' Save the undo paste action.
		  undo.savePaste(selectStart, selectEnd, newOffset, _
		  selectedContent, newContent, firstPa)
		  
		  ' Send notification of the change.
		  TextChanged
		  
		  ' Set the Mouse Cursor
		  'BK 08August12 Lengthy paste needs wait cursor
		  self.MouseCursor = nil
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub insertXML(text as string)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim s as string
		  
		  ' Get the XML data.
		  s = DefineEncoding(text, Encodings.UTF8)
		  
		  ' Trim off the null terminator.
		  s = replaceAllB(s, Chr(0), "")
		  
		  ' Paste the XML text.
		  doc.insertXml(s, false, false)
		  
		  ' Send notification of the change.
		  TextChanged
		  
		  ' Update the display.
		  update(true, true)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub invalidateBackground()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' The background needs to be redrawn.
		  hasMoved = true
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function isArrowKeyPressed() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Are any of the arrow keys pressed?
		  return Keyboard.AsyncKeyDown(&h07B) or Keyboard.AsyncKeyDown(&h07C) or _
		  Keyboard.AsyncKeyDown(&h07D) or Keyboard.AsyncKeyDown(&h07E)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isClearActionAvailable() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Are we read only?
		  if ReadOnly then return false
		  
		  ' Is something selected?
		  if doc.isSelected then return true
		  
		  ' The functionality is not enabled.
		  return false
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function isCommandKeyPressed() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  #if TargetMacOS
		    
		    ' Use the command key.
		    return Keyboard.CommandKey
		    
		  #else
		    
		    ' Use the control key.
		    return Keyboard.ControlKey
		    
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isCopyActionAvailable() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Is something selected?
		  if doc.isSelected then return true
		  
		  ' The functionality is not enabled.
		  return false
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isCutActionAvailable() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Are we read only?
		  if ReadOnly then return false
		  
		  ' Is something selected?
		  if doc.isSelected then return true
		  
		  ' The functionality is not enabled.
		  return false
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isEditViewMode() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Are we in edit view mode?
		  return (mode = Display_mode.Edit)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isInitialized() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the initialization flag.
		  return initialized
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isNormalViewMode() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Are we in normal view mode?
		  return (mode = Display_mode.Normal)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function isOptionKeyPressed() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  #if TargetMacOS
		    
		    ' Use the option key.
		    return Keyboard.OptionKey
		    
		  #else
		    
		    ' Use the control key.
		    return Keyboard.ControlKey
		    
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isPageViewMode() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Are we in page view mode?
		  return (mode = Display_mode.Page)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isPasteActionAvailable() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim cb as Clipboard
		  
		  ' Are we read only?
		  if ReadOnly then return false
		  
		  ' Get the clipboard.
		  cb = new Clipboard
		  
		  ' Is there something to paste?
		  if cb.RawDataAvailable(XML_DATA_TYPE) or _
		    cb.RawDataAvailable(RTF_DATA_TYPE) or _
		    cb.TextAvailable or _
		    cb.PictureAvailable then
		    
		    ' Close the clipboard.
		    cb.close
		    
		    ' We can paste.
		    return true
		    
		  end if
		  
		  ' Close the clipboard.
		  cb.close
		  
		  ' The functionality is not enabled.
		  return false
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isRedoActionAvailable() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Are we read only?
		  if ReadOnly then return false
		  
		  ' Can we redo?
		  if undo.isRedoable then return true
		  
		  ' The functionality is not enabled.
		  return false
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isSingleViewMode() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Are we in single view mode?
		  return (mode = Display_mode.Single)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isUndoActionAvailable() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Are we read only?
		  if ReadOnly then return false
		  
		  ' Can we undo?
		  if undo.isUndoable then return true
		  
		  ' The functionality is not enabled.
		  return false
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isValidParagraphMargins(leftMargin as double, rightMargin as double, firstIndent as double = 0) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim docLeftMargin as double
		  Dim docRightMargin as double
		  
		  ' Get the absolute margins.
		  docLeftMargin = doc.getLeftMargin
		  docRightMargin = doc.getPageWidth - doc.getRightMargin
		  
		  ' Is there any space between the margins?
		  if (docLeftMargin + leftMargin) >= (docRightMargin - rightMargin) then return false
		  
		  ' Is the first indent margin to big?
		  if (docLeftMargin + firstIndent + leftMargin) >= (docRightMargin - rightMargin) then return false
		  if (docLeftMargin + firstIndent + leftMargin) < 0 then return false
		  
		  ' The settings are valid.
		  return true
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub makeFontBigger()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim startPosition as FTInsertionOffset
		  Dim endPosition as FTInsertionOffset
		  Dim sr as FTStyleRun
		  Dim style as FTCharacterStyle
		  Dim originalContent as string
		  Dim newContent as string
		  
		  ' Are we in the read only mode?
		  if readOnly then return
		  
		  ' Is there anything selected?
		  if doc.isSelected then
		    
		    ' Get the selection range.
		    doc.getSelectionRange(startPosition, endPosition)
		    
		    ' Get the original content.
		    originalContent = doc.getXML(startPosition, endPosition)
		    
		    ' Change the font size.
		    doc.makeFontBigger(startPosition, endPosition)
		    
		    ' Get the updated content.
		    newContent = doc.getXML(startPosition, endPosition)
		    
		    ' Save the style change.
		    undo.saveContent(FTCStrings.SIZE, startPosition, endPosition, originalContent, newContent)
		    
		  else
		    
		    ' Are we in the middle of a word?
		    if doc.findWordBoundaryAtInsertion(startPosition, endPosition) then
		      
		      ' Get the original content.
		      originalContent = doc.getXML(startPosition, endPosition)
		      
		      ' Toggle the selected text state.
		      doc.makeFontBigger( startPosition, endPosition)
		      
		      ' Get the updated content.
		      newContent = doc.getXML(startPosition, endPosition)
		      
		      ' Save the style change.
		      undo.saveContent(FTCStrings.SIZE, startPosition, endPosition, originalContent, newContent)
		      
		    else
		      
		      ' Get the current insertion style and the current style run.
		      findInsertionReferences(style, sr)
		      
		      ' Set the attribute.
		      style.makeFontBigger()
		      
		    end if
		    
		  end if
		  
		  
		  ' Update the display.
		  update(true, true)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub makeFontSmaller()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim startPosition as FTInsertionOffset
		  Dim endPosition as FTInsertionOffset
		  Dim sr as FTStyleRun
		  Dim style as FTCharacterStyle
		  Dim originalContent as string
		  Dim newContent as string
		  
		  ' Are we in the read only mode?
		  if readOnly then return
		  
		  ' Is there anything selected?
		  if doc.isSelected then
		    
		    ' Get the selection range.
		    doc.getSelectionRange(startPosition, endPosition)
		    
		    ' Get the original content.
		    originalContent = doc.getXML(startPosition, endPosition)
		    
		    ' Change the font size.
		    doc.makeFontSmaller( startPosition, endPosition)
		    
		    ' Get the updated content.
		    newContent = doc.getXML(startPosition, endPosition)
		    
		    ' Save the style change.
		    undo.saveContent(FTCStrings.SIZE, startPosition, endPosition, originalContent, newContent)
		    
		  else
		    
		    ' Are we in the middle of a word?
		    if doc.findWordBoundaryAtInsertion(startPosition, endPosition) then
		      
		      ' Get the original content.
		      originalContent = doc.getXML(startPosition, endPosition)
		      
		      ' Toggle the selected text state.
		      doc.makeFontSmaller( startPosition, endPosition)
		      
		      ' Get the updated content.
		      newContent = doc.getXML(startPosition, endPosition)
		      
		      ' Save the style change.
		      undo.saveContent(FTCStrings.SIZE, startPosition, endPosition, originalContent, newContent)
		      
		    else
		      
		      ' Get the current insertion style and the current style run.
		      findInsertionReferences(style, sr)
		      
		      ' Set the attribute.
		      style.makeFontSmaller()
		      
		    end if
		    
		  end if
		  
		  
		  ' Update the display.
		  update(true, true)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub mouseDragSelection(x as integer, y as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim startPosition as FTInsertionOffset
		  Dim endPosition as FTInsertionOffset
		  Dim lastOffset as FTInsertionOffset
		  Dim lastId as integer
		  Dim bias as boolean
		  
		  ' Get the current insertion point.
		  lastId = doc.getInsertionPoint.getCurrentParagraph.getID
		  lastOffset = doc.getInsertionOffset
		  
		  ' Should we change the insertion point?
		  call doc.findInsertionPoint(x, y, bias)
		  
		  ' Find the current insertion position.
		  endPosition = doc.getInsertionOffset
		  
		  ' Has the insertion point changed?
		  if (endPosition <> lastEndPosition) or _
		    ((endPosition = lastEndPosition) and (endPosition.bias <> lastEndPosition.bias)) or _
		    endPosition.isBeginning or endPosition.isEnd then
		    
		    ' Save the end position.
		    lastEndPosition = endPosition.clone
		    
		    ' Get the start position.
		    startPosition = anchorOffset.clone
		    
		    ' Is there anything to select or is this multi-click situation?
		    if (startPosition <> endPosition) or _
		      ((startPosition = endPosition) and (startPosition.bias <> endPosition.bias)) or _
		      (anchorType > 0) then
		      
		      ' Are we doing a backwards selection?
		      if startPosition > endPosition then
		        
		        ' Put them in the correct order.
		        startPosition = endPosition.clone
		        endPosition = anchorOffset.clone
		        
		      end if
		      
		      ' Is this a double or triple click situation?
		      if anchorType > 0 then
		        
		        ' Are we shifted to the left?
		        if (startPosition < anchorLeft) and (endPosition <= anchorRight) then
		          
		          ' Adjust the start of the selection.
		          startPosition = findAnchorPosition(anchorType, startPosition, false)
		          
		          ' Use the right anchor.
		          endPosition = anchorRight.clone
		          
		          ' Are we shifted to the right?
		        elseif (startPosition >= anchorLeft) and (endPosition > anchorRight) then
		          
		          ' Use the left anchor.
		          startPosition = anchorLeft.clone
		          
		          ' Adjust the end of the selection.
		          endPosition = findAnchorPosition(anchorType, endPosition, true)
		          
		        else
		          
		          ' Use both anchors.
		          startPosition = anchorLeft.clone
		          endPosition = anchorRight.clone
		          
		        end if
		        
		      end if
		      
		      ' Select the text.
		      doc.selectSegment(startPosition, endPosition)
		      
		    else
		      
		      ' Select the text.
		      doc.deselectAll
		      
		    end if
		    
		    ' Set the flag.
		    inMouseDrag = true
		    
		    ' Update the display.
		    update(true, true)
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub mouseShiftDragSelection(x as integer, y as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim startPosition as FTInsertionOffset
		  Dim endPosition as FTInsertionOffset
		  Dim offset as FTInsertionOffset
		  Dim bias as boolean
		  
		  ' Scroll it into view.
		  scrollToMouse(x, y)
		  
		  ' Should we change the insertion point?
		  if doc.findInsertionPoint(x, y, bias) then
		    
		    ' Get the current insertion point offset.
		    offset = doc.getInsertionOffset
		    
		    ' Has the insertion point changed?
		    if offset <> lastEndPosition then
		      
		      ' Save the new position.
		      lastEndPosition = offset.clone
		      
		      ' Is anything selected?
		      if doc.isSelected then
		        
		        ' Get the current selection.
		        doc.getSelectionRange(startPosition, endPosition)
		        
		      else
		        
		        ' Is this a left handed selection?
		        if currentInsertionOffset <= offset then
		          
		          ' Set the positions.
		          startPosition = currentInsertionOffset + 1
		          endPosition = offset - 1
		          
		        else
		          
		          ' Set the positions.
		          startPosition = offset + 1
		          endPosition = currentInsertionOffset
		          
		        end if
		        
		      end if
		      
		      ' Are we before the selection?
		      if offset < startPosition then
		        
		        ' Set the start position.
		        startPosition = offset
		        
		        ' Select the text.
		        doc.selectSegment(startPosition, endPosition)
		        
		        ' Set the anchor point.
		        anchorOffset = endPosition.clone
		        
		      else
		        
		        ' Set the end position.
		        endPosition = offset.clone
		        
		        ' Select the text.
		        doc.selectSegment(startPosition, endPosition)
		        
		        ' Set the anchor point.
		        anchorOffset = startPosition.clone
		        
		      end if
		      
		      ' Set the flag.
		      inMouseDrag = true
		      
		      ' Update the display.
		      update(true, true)
		      
		    end if
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub mouseWheelScroll(hScrollbar as Scrollbar, vScrollbar as Scrollbar, deltaX as Integer, deltaY as integer, speed as integer = 4)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Is the horizontal scrollbar present?
		  if not (hScrollbar is nil) then
		    
		    ' Was there a change in the horizontal direction?
		    if deltaX <> 0 then
		      
		      ' Scroll horizontally.
		      hScrollbar.Value = hScrollbar.value + (speed * deltaX)
		      
		    end if
		    
		  end if
		  
		  ' Is the vertical scrollbar present?
		  if not (vScrollbar is nil) then
		    
		    ' Was there a change in the vertical direction?
		    if deltaY <> 0 then
		      
		      ' Scroll vertically.
		      vScrollbar.Value = vScrollbar.value + (speed * deltaY)
		      
		    end if
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub moveCaretToBeginning()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Move the caret to the beginning of the display.
		  setInsertionPoint(0, 0, true)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub openScrollbars()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Get the scrollbars.
		  hScrollbar = getHorizontalScrollbar
		  vScrollbar = getVerticalScrollbar
		  
		  ' Does the horizontal scrollbar exist?
		  if not (hScrollbar is nil) then
		    
		    ' Tell the scrollbar who to scroll.
		    hScrollbar.setTarget(self)
		    
		    ' Set the parent.
		    hScrollbar.Parent = me
		    
		    ' Lock the scrollbar in place.
		    hScrollbar.LockLeft = true
		    hScrollbar.LockTop = false
		    hScrollbar.LockRight = true
		    hScrollbar.LockBottom = true
		    
		  end if
		  
		  ' Does the vertical scrollbar exist?
		  if not (vScrollbar is nil) then
		    
		    ' Tell the scrollbar who to scroll.
		    vScrollbar.setTarget(self)
		    
		    ' Set the parent.
		    vScrollbar.Parent = me
		    
		    ' Lock the scrollbar in place.
		    vScrollbar.LockLeft = false
		    vScrollbar.LockTop = true
		    vScrollbar.LockRight = true
		    vScrollbar.LockBottom = true
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PositionAutoCompleteWindow(x as integer, y as integer)
		  if not AutoComplete then
		    return
		  end if
		  if not m_bAutoCompleteVisible then
		    return
		  end if
		  if m_wAutoComplete=nil then
		    return
		  end if
		  
		  x = x + self.Left
		  y = y + self.Top
		  
		  dim w as Window = self.Window
		  while true
		    x = x + w.Left
		    y = y + w.Top
		    if w isa ContainerControl then
		      w = ContainerControl(w).Window
		    else
		      exit while
		    end if
		  wend
		  
		  x = x + 10
		  if m_wAutoComplete.Left<>x then
		    m_wAutoComplete.Left = x
		  end if
		  if m_wAutoComplete.Top<>y then
		    m_wAutoComplete.Top = y
		  end if
		  if not m_wAutoComplete.Visible then
		    m_wAutoComplete.Visible = true
		    m_wAutoComplete.Show
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function PrefixBinarySearch(ars() as string, sPrefix as string) As integer
		  dim iMin as integer = 0
		  dim iMax as integer = ars.Ubound
		  
		  dim iPrefixLen as integer = sPrefix.Len
		  
		  while iMin<iMax
		    dim iMid as integer = Floor((iMin+iMax)/2.0)
		    
		    if ars(iMid).Left(iPrefixLen) < sPrefix then
		      iMin = iMid + 1
		    else
		      iMax = iMid
		    end if
		  wend
		  
		  if iMax=iMin and ars(iMin).Left(iPrefixLen) = sPrefix then
		    return iMin
		  end if
		  return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub print(g as graphics, printer as PrinterSetup, firstPage as integer = -1, lastPage as integer = -1)
		  
		  #If Not DebugBuild
		    
		    #Pragma BoundsChecking FTC_BOUNDSCHECKING
		    #Pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #Pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #EndIf
		  
		  ' Is there anything to do?
		  If printer Is Nil Then Return
		  
		  // Mantis Ticket 3755: Printing has the side-effect of scrolling the editing window to the top
		  Dim state As Boolean = setInhibitUpdates(True) ' inhibit updates
		  Dim holdMode As Display_Mode = mode ' preserve current mode
		  Dim holdMargins As DisplayMargins = doc.getDisplayMargins ' preserve the current margins
		  Dim pageWidth As Double
		  Dim pageHeight As Double
		  Dim oldPageWidth As Double
		  Dim oldPageHeight As Double
		  
		  ' If mode is edit or single then adjust margins
		  ' to take account of single mode and of customized margins
		  If isEditViewMode Or IsSingleViewMode Then
		    
		    ' Set the edit view print margins, assuming that if the margin has been changed
		    ' from the default then it is the space required for extra drawing on the screen.
		    ' This provides the expected behavior when the margins have not been changed.
		    ' If the programmer requires a different behavior it can be still be set up in the
		    ' subclass that calls print, either by a temporary adjustment to the margins or
		    ' by overriding the print method
		    
		    ' Line numbers now print correctly in FTRBScript but is compatible with past usage
		    Dim dLeftMargin As Double = holdMargins.leftMargin
		    
		    If dLeftMargin = EditViewMargin Then 
		      dLeftMargin = EditViewPrintMargin 
		    Else 
		      dLeftMargin = dLeftMargin + EditViewPrintMargin
		    End
		    
		    Dim dRightMargin As Double = holdMargins.rightMargin
		    
		    If dRightMargin = EditViewMargin Then 
		      dRightMargin = EditViewPrintMargin 
		    Else 
		      dRightMargin = dRightMargin + EditViewPrintMargin
		    End
		    
		    Dim dTopMargin As Double = holdMargins.topMargin
		    
		    If dTopMargin = EditViewMargin Then 
		      dTopMargin = EditViewPrintMargin 
		    Else 
		      dTopMargin = dTopMargin + EditViewPrintMargin
		    End
		    
		    Dim dBottomMargin As Double = holdMargins.bottomMargin
		    
		    If dBottomMargin = EditViewMargin Then 
		      dBottomMargin = EditViewPrintMargin 
		    Else 
		      dBottomMargin = dBottomMargin + EditViewPrintMargin
		    End
		    
		    doc.setMargins(dLeftMargin, dRightMargin, dTopMargin, dBottomMargin)
		    
		  End If
		  
		  ' Set up for the page view mode for printing 
		  ' don't use setPageViewMode as it has too many undesired side-effects such as scrolling to top
		  mode = Display_Mode.Page
		  
		  ' Compose the document so we can get the number of pages.
		  doc.markAllParagraphsDirty
		  doc.compose
		  
		  ' Save the old dimensions.
		  oldPageWidth = doc.getPageWidth
		  oldPageHeight = doc.getPageHeight
		  
		  ' Calculate the dimensions of the page.
		  pageWidth = printer.Width / printer.HorizontalResolution
		  pageHeight = printer.Height / printer.VerticalResolution
		  
		  ' Set the page size.
		  doc.setPageSize(pageWidth, pageHeight)
		  
		  ' Was the first page specified?
		  If firstPage > -1 Then
		    
		    ' Was the last page unspecified?
		    If lastPage < 0 Then
		      
		      ' Print to the end of the document.
		      lastPage = doc.getNumberOfPages - 1
		      
		    End If
		    
		  Else
		    
		    ' Use the page range specified in the graphics object.
		    firstPage = g.FirstPage
		    lastPage = g.LastPage
		    
		  End If
		  
		  #If TargetWin32
		    
		    ' Set the page boundaries to print.
		    firstPage = firstPage - 1
		    lastPage = Min(lastPage - 1, doc.getNumberOfPages - 1)
		    
		  #EndIf
		  
		  ' Check the page range.
		  If firstPage < 0 Then firstPage = 0
		  If lastPage < 0 Then lastPage = doc.getNumberOfPages - 1
		  
		  ' Print the document.
		  doc.print(g, printer, firstPage, lastPage)
		  
		  ' Reset the page size.
		  doc.setPageSize(oldPageWidth, oldPageHeight)
		  
		  ' Restore the original mode.
		  Me.Mode = holdMode
		  doc.setMargins(holdMargins)
		  
		  ' Restore updates.
		  Call setInhibitUpdates(state)
		  
		  ' Update the display (resets correcting Clipping Page).
		  resize
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Refresh(eraseBackground as boolean = true)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  #pragma Unused eraseBackground
		  
		  ' Perform an update.
		  update(true, true)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub removeHyperLink()
		  //we want to find the entire hyperlink style and remove it
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim startPosition as FTInsertionOffset
		  Dim endPosition as FTInsertionOffset
		  Dim originalContent as string
		  Dim newContent as string
		  Dim io As FTInsertionOffset
		  
		  ' Are we in the read only mode?
		  if readOnly then return
		  
		  ' Get the insertion offset.
		  io = getdoc.getInsertionPoint.getOffset
		  
		  ' Get our offset for our hyperlink
		  if doc.findHyperLinkBoundaryAtOffset(io,startPosition, endPosition) then
		    
		    ' Get the original content.
		    originalContent = doc.getXML(startPosition, endPosition)
		    
		    ' Toggle the selected text state.
		    doc.removeHyperLink(startPosition, endPosition)
		    
		    ' Get the updated content.
		    newContent = doc.getXML(startPosition, endPosition)
		    
		    ' Save the style change.
		    undo.saveContent(FTCStrings.HYPERLINK, startPosition, endPosition, originalContent, newContent)
		    
		    
		  end if
		  
		  
		  
		  ' Update the display.
		  update(true, true)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub replaceAll(target as string, replacement as string, searchStart as FTInsertionOffset, searchEnd as FTInsertionOffset)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim index as integer
		  Dim text as string
		  Dim startIndex as integer
		  Dim selectStart as FTInsertionOffset
		  Dim selectEnd as FTInsertionOffset
		  Dim delta as integer
		  Dim endOffset as integer
		  Dim targetLength as integer
		  Dim replacementLength as integer
		  
		  '----------------------------------------
		  
		  ' Was the start position specified?
		  if searchStart is nil then
		    
		    ' Use the beginning of the document.
		    searchStart = new FTInsertionOffset(doc, 0, 0)
		    
		  end if
		  
		  '----------------------------------------
		  
		  ' Was the end position specified?
		  if searchEnd is nil then
		    
		    ' Get the index to the last paragraph.
		    i = doc.getParagraphCount - 1
		    
		    ' Use the end of the document.
		    searchEnd = new FTInsertionOffset(doc, i, doc.getParagraph(i).getLength)
		    
		  end if
		  
		  '----------------------------------------
		  
		  ' Is there anything to search?
		  if searchStart >= searchEnd then return
		  
		  ' Get the lengths.
		  targetLength = target.len
		  replacementLength = replacement.len
		  
		  ' Compute the difference in the added text.
		  delta = replacementLength - targetLength
		  
		  ' Extract the end offset.
		  endOffset = searchEnd.offset
		  
		  ' Start searching at the insertion point offset.
		  startIndex = searchStart.offset + 1
		  
		  ' Search the paragraphs.
		  for i = searchStart.paragraph to searchEnd.paragraph
		    
		    ' Get the text from the paragraph.
		    text = doc.getParagraph(i).getText(true)
		    
		    ' Look for the string in the paragraph.
		    index = InStr(startIndex, text, target)
		    
		    ' Is the target string in the paragraph?
		    while ((index > 0) and (i < searchEnd.paragraph)) or _
		      ((index > 0) and (index + targetLength <= endOffset) and (i = searchEnd.paragraph))
		      
		      ' Make it zero based.
		      index = index - 1
		      
		      ' Set the selection range.
		      selectStart = new FTInsertionOffset(doc, i, index)
		      selectEnd = new FTInsertionOffset(doc, i, index + targetLength)
		      
		      ' Replace the target string.
		      doc.selectSegment(selectStart, selectEnd)
		      doc.insertString(replacement)
		      
		      ' Is this the last paragraph?
		      if i = searchEnd.paragraph then
		        
		        ' We need to adjust for the added text.
		        endOffset = endOffset + delta
		        
		      end if
		      
		      ' Get the text from the paragraph.
		      text = doc.getParagraph(i).getText(true)
		      
		      ' Look for the string in the paragraph.
		      index = InStr(index + replacementLength, text, target)
		      
		    wend
		    
		    ' Use the beginning of the paragraph.
		    startIndex = 0
		    
		  next
		  
		  '----------------------------------------
		  
		  ' Update the display.
		  update(true, true)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub resetImageSize()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim width as integer
		  Dim height as integer
		  Dim p as FTPicture
		  
		  ' Is a picture in the resize mode?
		  if doc.isInResizeMode then
		    
		    ' Get the picture.
		    p = doc.getResizePicture
		    
		    ' Get the current dimensions.
		    width = p.getWidth(1.0)
		    height = p.getHeight(1.0)
		    
		    ' Reset the picture.
		    p.resetSize
		    
		    ' Save the image change.
		    undo.saveImageChange(doc.getInsertionOffset, width, height, _
		    p.getWidth(1.0), p.getHeight(1.0))
		    
		    ' Update the display.
		    updateFull
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub resize()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Have we been initalized?
		  if not isInitialized then return
		  
		  ' Move the scrollbars into position.
		  adjustScrollbars
		  
		  ' Adjust the display picture.
		  adjustDisplayPicture
		  
		  ' Is this a mode that changes width with the size of the window?
		  if not (isPageViewMode or isNormalViewMode) then
		    
		    ' Set the default tab stops to a half inch.
		    getDoc.addDefaultTabStops(FTTabStop.TabStopType.Left, DefaultTabStop)
		    
		  end if
		  
		  ' Are we in edit view mode?
		  if isEditViewMode then
		    
		    ' Set the margins.
		    ' we don't need to divide by 2 here because doc.getresolution will return the correct number to divide by on retina macs
		    doc.setPageWidth(picDisplay.Width / doc.getMonitorPixelsPerInch)
		    
		    
		    ' Update the display.
		    update(true, true)
		    
		  else
		    
		    ' Set the scrollbar parameters.
		    adjustScrollbarParameters
		    
		    ' Mark the background as needing updating.
		    hasMoved = true
		    
		    ' Draw the contents of the display.
		    draw
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub saveUndoDelete(name as string)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim startPosition as FTInsertionOffset
		  Dim endPosition as FTInsertionOffset
		  
		  ' Is something selected?
		  if doc.isSelected then
		    
		    ' Get the range of the selection.
		    doc.getSelectionRange(startPosition, endPosition)
		    
		    ' Is just the pilcrow selected?
		    if startPosition.offset > startPosition.getParagraph.getLength then
		      
		      ' Move back to a valid insertion point.
		      startPosition.offset = Max(startPosition.offset - 1, 0)
		      
		    end if
		    
		    ' Save the text to be deleted.
		    undo.saveDelete(name, doc.getXML(startPosition, endPosition), startPosition, endPosition)
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub scrollToCaret()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim ip as FTInsertionPoint
		  Dim currentPosition as integer
		  Dim p as FTParagraphProxy
		  Dim offset as integer
		  Dim buffer as integer
		  
		  const BUFFER_SPACE = 30
		  
		  ' Adjust the buffer offset.
		  buffer = BUFFER_SPACE * displayScale
		  
		  ' Get the current insertion point.
		  ip = doc.getInsertionPoint
		  
		  ' Get the proxy paragraph.
		  p = ip.getCurrentProxyParagraph
		  
		  '---------------------------------------------
		  ' Vertical scrolling.
		  '---------------------------------------------
		  
		  ' Compute the paragraph offset.
		  offset = p.findLineHeightToOffset(ip.getOffset.offset, false, scale)
		  
		  ' Are we in page view mode?
		  if isPageViewMode then
		    
		    ' Compute where we should scroll to.
		    currentPosition = doc.getStartOfPageDistance(p.getAbsolutePage) + _
		    p.getYPosition + offset
		    
		    ' Are we at the beginning?
		    if currentPosition < 0 then return
		    
		    ' Are we above the display?
		    if currentPosition <= Abs(vScrollValue) + buffer then
		      
		      ' Compute where we should scroll to
		      currentPosition = currentPosition - offset + _
		      p.findLineHeightToOffset(ip.getOffset.offset, true, scale) - buffer
		      
		      ' Scroll to the position.
		      vScrollTo(currentPosition)
		      
		      ' Are we below the display?
		    elseif currentPosition > (Abs(vScrollValue) + getDisplayHeight - buffer) then
		      
		      ' Scroll to that position.
		      currentPosition = currentPosition - getDisplayHeight + buffer
		      
		      ' Scroll to the position.
		      vScrollTo(currentPosition)
		      
		    end if
		    
		  else
		    
		    ' Compute the paragraph offset.
		    offset = p.findLineHeightToOffset(ip.getOffset.offset, false, scale)
		    currentPosition = p.getYPosition + offset
		    
		    ' Are we at the beginning?
		    if currentPosition < 0 then return
		    
		    ' Are we above the display?
		    if currentPosition <= Abs(vScrollValue) + buffer then
		      
		      ' Compute where we should scroll to by moving to the previous line.
		      currentPosition = currentPosition - offset + _
		      p.findLineHeightToOffset(ip.getOffset.offset, true, scale) - buffer
		      
		      ' Scroll to the position.
		      vScrollTo(currentPosition)
		      
		      ' Are we below the display?
		    elseif currentPosition > (Abs(vScrollValue) + getDisplayHeight - buffer) then
		      
		      ' Compute where we should scroll to
		      currentPosition = currentPosition - getDisplayHeight + buffer
		      
		      ' Scroll to the position.
		      vScrollTo(currentPosition)
		      
		    end if
		    
		  end if
		  
		  '---------------------------------------------
		  ' Horizontal scrolling.
		  '---------------------------------------------
		  
		  ' Do we have the possibility to scroll horizontally?
		  if Mode <> Display_mode.Edit then
		    
		    ' Calculate the current horizontal position of the insertion caret.
		    currentPosition = doc.getLeftMarginWidth + p.getParent.getLeftMarginWidth + ip.getCaretOffset
		    
		    ' Are we to the left of the display?
		    if currentPosition <= (Abs(hScrollValue) + buffer) then
		      
		      ' Scroll horizontally to the position.
		      hScrollTo(Max(currentPosition - buffer - Abs(hScrollValue), 0))
		      
		      ' Are we to the right of the display?
		    elseif currentPosition >= (Abs(hScrollValue) + getDisplayWidth - buffer) then
		      
		      ' Scroll horizontally to the position.
		      hScrollTo(Max(currentPosition + buffer - getDisplayWidth, 0))
		      
		    end if
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub scrollToMouse(x as integer, y as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim currentPosition as integer
		  
		  '--------------------------------------------------
		  ' Vertical scrolling.
		  '--------------------------------------------------
		  
		  ' Do we need to scroll vertically?
		  if (y < 0) or (y > getDisplayHeight) then
		    
		    ' Compute where we should scroll to.
		    currentPosition = Abs(vScrollValue) + y
		    
		    ' Are we at the beginning?
		    if currentPosition < 0 then currentPosition = 0
		    
		    ' Are we above the display?
		    if currentPosition <= Abs(vScrollValue) then
		      
		      ' Scroll to that position.
		      vScrollTo(currentPosition)
		      
		      ' Are we below the display?
		    elseif currentPosition > (Abs(vScrollValue) + getDisplayHeight) then
		      
		      ' Scroll to that position.
		      vScrollTo(currentPosition - getDisplayHeight)
		      
		    end if
		    
		  end if
		  
		  '--------------------------------------------------
		  ' Horizontal scrolling.
		  '--------------------------------------------------
		  
		  ' Do we need to scroll horizontally?
		  if (x < 0) or (x > getDisplayWidth) then
		    
		    ' Compute where we should scroll to.
		    currentPosition = Abs(hScrollValue) + x
		    
		    ' Are we at the beginning?
		    if currentPosition < 0 then currentPosition = 0
		    
		    ' Are we above the display?
		    if currentPosition <= Abs(hScrollValue) then
		      
		      ' Scroll to that position.
		      hScrollTo(currentPosition)
		      
		      ' Are we below the display?
		    elseif currentPosition > (Abs(hScrollValue) + getDisplayWidth) then
		      
		      ' Scroll to that position.
		      hScrollTo(currentPosition - getDisplayWidth)
		      
		    end if
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub scrollToSelection()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim selectStart as FTInsertionOffset
		  Dim selectEnd as FTInsertionOffset
		  
		  ' Is anything selected?
		  if not doc.isSelected then return
		  
		  ' Get the current selection range.
		  doc.getSelectionRange(selectStart, selectEnd)
		  
		  ' Set the insertion point to the start of the selection.
		  doc.setInsertionPoint(selectStart, false)
		  
		  ' Make the beginning of the selection.
		  scrollToCaret
		  
		  ' Reselect the selection.
		  doc.selectSegment(selectStart, selectEnd)
		  
		  ' Update the display.
		  update(true, true)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function search(target as string, searchStart as FTInsertionOffset, searchEnd as FTInsertionOffset, ByRef selectStart as FTInsertionOffset, ByRef selectEnd as FTInsertionOffset) As boolean
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim index as integer
		  Dim text as string
		  Dim startIndex as integer
		  
		  '----------------------------------------
		  
		  ' Was the start position specified?
		  if searchStart is nil then
		    
		    ' Use the beginning of the document.
		    searchStart = new FTInsertionOffset(doc, 0, 0)
		    
		  end if
		  
		  '----------------------------------------
		  
		  ' Was the end position specified?
		  if searchEnd is nil then
		    
		    ' Get the index to the last paragraph.
		    i = doc.getParagraphCount - 1
		    
		    ' Use the end of the document.
		    searchEnd = new FTInsertionOffset(doc, i, doc.getParagraph(i).getLength)
		    
		  end if
		  
		  '----------------------------------------
		  
		  ' Is there anything to search?
		  if searchStart >= searchEnd then return false
		  
		  ' Start searching at the insertion point offset.
		  startIndex = searchStart.offset + 1
		  
		  ' Search the paragraphs.
		  for i = searchStart.paragraph to searchEnd.paragraph
		    
		    ' Get the text from the paragraph.
		    text = doc.getParagraph(i).getText(true)
		    
		    ' Look for the string in the paragraph.
		    index = InStr(startIndex, text, target)
		    
		    ' Is the target string in the paragraph?
		    if ((index > 0) and (i < searchEnd.paragraph)) or _
		      ((index > 0) and (index + target.len <= searchEnd.offset) and (i = searchEnd.paragraph)) then
		      
		      ' Make it zero based.
		      index = index - 1
		      
		      ' Set the selection range.
		      selectStart = new FTInsertionOffset(doc, i, index)
		      selectEnd = new FTInsertionOffset(doc, i, index + target.len)
		      
		      ' We found it.
		      return true
		      
		    else
		      
		      ' Reset to the beginning of the paragraph.
		      startIndex = 1
		      
		    end if
		    
		  next
		  
		  '----------------------------------------
		  
		  ' Clear the selection.
		  selectStart = nil
		  selectEnd = nil
		  
		  ' Target not found.
		  return false
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub selectAll()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Select all the text.
		  doc.selectAll
		  
		  ' Update the display.
		  update(true, true)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function selectionAlignment() As FTParagraph.Alignment_Type
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Call the document method.
		  Return doc.selectionAlignment
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function selectionBackgroundColor(ByRef sameColor as boolean) As color
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Call the document method.
		  return doc.selectionBackgroundColor(sameColor)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function selectionBold(any as boolean = false) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Call the document method.
		  return doc.selectionBold(any)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function selectionFontColor(ByRef sameColor as boolean) As color
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Call the document method.
		  return doc.selectionFontColor(sameColor)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function selectionFontName() As string
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Call the document method.
		  return doc.selectionFontName
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function selectionFontSize() As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Call the document method.
		  return doc.selectionFontSize
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function selectionHasBackgroundColor(byRef sameBackgroundSettings as Boolean) As Boolean
		  //Get whether or not a background color is defined new 3b1
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Call the document method.
		  return doc.selectionIsBackgroundColorDefined(sameBackgroundSettings)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function selectionHyperLink(byRef inNewWindow As Boolean) As String
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Call the document method.
		  return doc.selectionHyperLink(inNewWindow)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function selectionHyperLinkColor(byref hyperlinkColor As Color, byref hyperlinkColorRollover As Color, byref hyperlinkColorVisited As Color, byref hyperLinkColorDisabled As Color, byref ulNormal As Boolean, byref ulRollover As Boolean, byref ulVisited as Boolean, byref ulDisabled as Boolean) As Boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Call the document method.
		  return doc.selectionHyperLinkColor( hyperlinkColor, hyperlinkColorRollover, _
		  hyperlinkColorVisited, hyperLinkColorDisabled, _
		  ulNormal, ulRollover, _
		  ulVisited, ulDisabled )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function selectionItalic(any as boolean = false) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Call the document method.
		  return doc.selectionItalic(any)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function selectionLineSpacing() As double
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Call the document method.
		  return doc.selectionLineSpacing
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function selectionMarked(any as boolean = false) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Call the document method.
		  return doc.selectionMarked(any)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SelectionOpacity() As double
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Call the document method.
		  return doc.selectionOpacity
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SelectionShadow(byref shadowColor as Color, byref ShadowBlur as Double, byref ShadowOffset As Double, byref ShadowAngle as DOuble, byref ShadowOpacity as Double, any as boolean = false) As Boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Call the document method.
		  return doc.selectionShadow(shadowColor,  ShadowBlur , ShadowOffset, ShadowAngle , ShadowOpacity,any)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function selectionStrikethrough(any as boolean = false) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Call the document method.
		  return doc.selectionStrikethrough(any)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function selectionSubscript(any as boolean = false) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Call the document method.
		  return doc.selectionSubscript(any)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function selectionSuperscript(any as boolean = false) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Call the document method.
		  return doc.selectionSuperscript(any)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function selectionUnderline(any as boolean = false) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Call the document method.
		  return doc.selectionUnderline(any)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub selectSegment(startOffset as FTInsertionOffset, endOffset as FTInsertionOffset)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Select the segment.
		  doc.selectSegment(startOffset, endOffset)
		  
		  ' Update the display.
		  update(true, true)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub selectSegment(startParagraphIndex as integer, startParagraphOffset as integer, endParagraphIndex as integer, endParagraphOffset as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Select the segment.
		  doc.selectSegment(startParagraphIndex, startParagraphOffset, _
		  endParagraphIndex, endParagraphOffset)
		  
		  ' Update the display.
		  update(true, true)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub selectWordFromInsertionPoint()
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  '-----------------------------------------------
		  ' Get some info.
		  '-----------------------------------------------
		  
		  ' Get the paragraph with the caret in it.
		  dim p as FTParagraph = doc.getInsertionPoint.getCurrentParagraph
		  
		  ' Get the offset into the paragraph
		  dim io as FTInsertionOffset= doc.getInsertionPoint.getOffset
		  
		  ' Get the start of the paragraph.
		  dim startOffset as integer = io.offset
		  dim endOffset as integer = startOffset + 1
		  
		  ' Get the text from the paragraph.
		  dim text as string = p.getText(true)
		  
		  ' Get the length of the text.
		  dim length as integer = p.getLength + 1
		  
		  '-----------------------------------------------
		  ' Scan for the word.
		  '-----------------------------------------------
		  
		  ' Scan backwards for white space.
		  while startOffset > 0
		    
		    ' Is this a space?
		    if FTUtilities.isWordDivider(mid(text, startOffset, 1)) then
		      
		      ' Trim the offset.
		      startOffset = startOffset + 1
		      
		      ' We found the beginning of the selection
		      exit
		      
		    end if
		    
		    ' Move to the next character.
		    startOffset = startOffset - 1
		    
		  wend
		  
		  '-----------------------
		  
		  ' Scan forwards for white space.
		  while endOffset <= length
		    
		    ' Is this a space?
		    if FTUtilities.isWordDivider(mid(text, endOffset, 1)) then
		      
		      ' Trim the offset.
		      endOffset = endOffset - 1
		      
		      ' We found the end of the selection
		      exit
		      
		    end if
		    
		    ' Move to the next character.
		    endOffset = endOffset + 1
		    
		  wend
		  
		  ' Range check the values.
		  if startOffset < 1 then startOffset = 1
		  if endOffset > length then endOffset = length
		  
		  '-----------------------------------------------
		  ' Select the word.
		  '-----------------------------------------------
		  
		  ' Do we have a valid selection range?
		  if endOffset >= startOffset then
		    
		    ' Is this a picture?
		    if (startOffset = endOffset) and _
		      p.isOffsetPicture(startOffset) then
		      
		      ' Deselect all the text.
		      doc.deselectAll
		      
		      ' Should we put it in resize mode?
		      if isOptionKeyPressed then
		        
		        ' Turn on resizing for the picture.
		        FTPicture(p.getItem(p.findItem(startOffset))).setResizeMode(true)
		        
		      end if
		      
		      ' Adjust the start offset.
		      startOffset = startOffset - 1
		      
		      ' Select the paragraph.
		      doc.selectSegment(io.paragraph, startOffset, io.paragraph, endOffset)
		      
		      ' Save the multi-click anchors.
		      anchorLeft.set(io.paragraph, startOffset)
		      anchorRight.set(io.paragraph, endOffset)
		      anchorType = 2
		      
		      ' Update the display.
		      update(true, true)
		      
		    else
		      
		      ' Is this an empty word?
		      if Trim(mid(text, startOffset, endOffset - startOffset + 1)) <> "" then
		        
		        ' Deselect all the text.
		        doc.deselectAll
		        
		        ' Adjust the start offset.
		        startOffset = startOffset - 1
		        
		        ' Select the paragraph.
		        doc.selectSegment(io.paragraph, startOffset, io.paragraph, endOffset)
		        
		        ' Save the multi-click anchors.
		        anchorLeft = doc.newInsertionOffset(io.paragraph, startOffset)
		        anchorRight = doc.newInsertionOffset(io.paragraph, endOffset)
		        anchorType = 2
		        
		        ' Update the display.
		        update(true, true)
		        
		      end if
		      
		    end if
		    
		  end if
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setAutoCompleteOptions(arsOption() as string)
		  redim m_arsAutoCompleteOption(-1)
		  
		  arsOption.Sort
		  for i as integer = 0 to arsOption.Ubound
		    m_arsAutoCompleteOption.Append(arsOption(i))
		  next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setDisplayAlignment(alignment as Display_Alignment)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set the display alignment.
		  DisplayAlignment = alignment
		  
		  ' Mark the background as needing updating.
		  hasMoved = true
		  
		  ' Update the display.
		  update(true, true)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub setEditMenuAutoEnable(state as boolean)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  'NOTE:  GETTING A COMPILE ERROR ON EditRedo?
		  'You are getting this error because your Menubar does not have a Redo command in the Edit menu.
		  'Solutions:
		  '1 - Add a Redo menu command in the Edit Menu, making sure it's is named EditRedo
		  '2 - Comment out the following bit of code.  Comment out to <End>
		  
		  
		  ' Are we resetting the auto enable state?
		  if state then
		    
		    ' Restore the auto enable state.
		    EditUndo.AutoEnable = editMenuAutoEnableState.undo
		    EditRedo.AutoEnable = editMenuAutoEnableState.redo //Comment out if no Redo Menu
		    EditCut.AutoEnable = editMenuAutoEnableState.cut
		    EditCopy.AutoEnable = editMenuAutoEnableState.copy
		    EditPaste.AutoEnable = editMenuAutoEnableState.paste
		    EditClear.AutoEnable = editMenuAutoEnableState.clear
		    
		  else
		    
		    ' Save the current auto enable state.
		    editMenuAutoEnableState.undo = EditUndo.AutoEnable
		    editMenuAutoEnableState.redo = EditRedo.AutoEnable //Comment out if no Redo Menu
		    editMenuAutoEnableState.cut = EditCut.AutoEnable
		    editMenuAutoEnableState.copy = EditCopy.AutoEnable
		    editMenuAutoEnableState.paste = EditPaste.AutoEnable
		    editMenuAutoEnableState.clear = EditClear.AutoEnable
		    
		    ' Turn off the auto enable state.
		    EditUndo.AutoEnable = state
		    EditRedo.AutoEnable = state //Comment out if no Redo Menu
		    EditCut.AutoEnable = state
		    EditCopy.AutoEnable = state
		    EditPaste.AutoEnable = state
		    EditClear.AutoEnable = state
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setEditViewMode(margin as double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set the margins to all be the same.
		  setEditViewMode(margin, margin, margin, margin)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setEditViewMode(leftMargin as double, rightMargin as double, topMargin as double, bottomMargin as double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim state as boolean
		  
		  ' Inhibit updates.
		  state = setInhibitUpdates(true)
		  
		  ' Set the scale to 100%.
		  setScale(1.0)
		  
		  ' Save the mode data.
		  Mode = Display_mode.Edit
		  
		  ' Set the margins.
		  doc.setMargins(leftMargin, rightMargin, topMargin, bottomMargin)
		  
		  ' Set the scrollbars.
		  showHorizontalScrollbar(false)
		  showVerticalScrollbar(true)
		  
		  ' Restore the update state.
		  call setInhibitUpdates(state)
		  
		  ' Update the display.
		  resize
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub setHandleCursor(handle as FTPicture.Handle_Type)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set the cursor of the picture handle.
		  select case handle
		    
		  Case FTPicture.Handle_Type.Bottom_Middle
		    doc.getResizePicture.setCursor(System.Cursors.ArrowNorthSouth)
		    
		  Case FTPicture.Handle_Type.Bottom_Right
		    doc.getResizePicture.setCursor(System.Cursors.ArrowNorthwestSoutheast)
		    
		  case FTPicture.Handle_Type.Middle_Right
		    doc.getResizePicture.setCursor(System.Cursors.ArrowEastWest)
		    
		  end select
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function setInhibitUpdates(state as boolean) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim lastState as boolean
		  
		  ' Get the current state.
		  lastState = inhibitUpdates
		  
		  ' Turn off updates.
		  inhibitUpdates = state
		  
		  ' Return the restore state.
		  return lastState
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setInsertionPoint(io as FTInsertionOffset, calculateOffset as boolean)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set the insertion caret position.
		  doc.setInsertionPoint(io, calculateOffset)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setInsertionPoint(p as FTParagraph, offset as integer, calculateOffset as boolean)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set the insertion caret position.
		  doc.setInsertionPoint(p, offset, calculateOffset)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setInsertionPoint(paragraph as integer, offset as integer, calculateOffset as boolean)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set the insertion point.
		  doc.setInsertionPoint(paragraph, offset, calculateOffset)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setMargins(leftMargin as double, rightMargin as double, topMargin as double, bottomMargin as double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Is there anything to do?
		  if (doc.getLeftMargin = leftMargin) and _
		  (doc.getRightMargin = rightMargin) and _
		  (doc.getTopMargin = topMargin) and _
		  (doc.getBottomMargin = bottomMargin) _
		  then return
		  
		  ' Save the original margins.
		  undo.saveOriginalMargins(FTCStrings.MARGINS)
		  
		  ' Set the margins.
		  doc.setLeftMargin(leftMargin)
		  doc.setRightMargin(rightMargin)
		  doc.setTopMargin(topMargin)
		  doc.setBottomMargin(bottomMargin)
		  
		  ' Save the new margin settings.
		  undo.saveNewMargins
		  
		  ' Make sure everything gets updated.
		  doc.markAllParagraphsDirty
		  
		  ' Send notification of the change.
		  TextChanged
		  
		  ' Update the display.
		  update(true, true)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub setMouseCursor(cursor as MouseCursor)
		  
		  ' Set the cursor.
		  me.MouseCursor = cursor
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub setMousePointer(x as integer, y as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Are we in focus?
		  if not focusState then return
		  
		  '--------------------------------------------
		  ' Vertical scrollbar.
		  '--------------------------------------------
		  
		  ' Does the vertical scroll bar exist?
		  if not (vScrollbar is nil) then
		    
		    ' Are we within the vertical scroll bar?
		    if x/self.Window.ScalingFactor >= (me.width - vScrollbar.width) then
		      
		      ' Use the arrow cursor.
		      setMouseCursor(nil)
		      
		      ' We are done.
		      return
		      
		    end if
		    
		  end if
		  
		  '--------------------------------------------
		  ' Horizontal scrollbar.
		  '--------------------------------------------
		  
		  ' Does the horizontal scroll bar exist?
		  if not (hScrollbar is nil) then
		    
		    ' Are we within the vertical scroll bar?
		    if y/self.Window.ScalingFactor >= (me.height * 2 - hScrollbar.height) then
		      
		      ' Use the arrow cursor.
		      setMouseCursor(nil)
		      
		      ' We are done.
		      return
		      
		    end if
		    
		  end if
		  
		  '--------------------------------------------
		  ' Active custom object.
		  '--------------------------------------------
		  
		  ' Are we in picture resize mode?
		  if doc.isInResizeMode then
		    
		    ' Call the mouse movement event.
		    doc.getResizePicture.callMouseMovement(x, y)
		    
		    ' Is this a plain picture and is the mouse button is up?
		    if not (doc.getResizePicture isa FTCustom) and (not System.MouseDown) then
		      
		      ' Reset the mouse cursor.
		      doc.getResizePicture.setCursor(nil)
		      
		    else
		      
		      ' Use the cursor.
		      setMouseCursor(doc.getResizePicture.getCurrentCursor)
		      
		    end if
		    
		  else
		    
		    ' Get the Insertion point from the position.
		    
		    ' Check to see if it's a Hyperlink
		    dim oOffset as FTInsertionOffset = GetDoc.findXYOffset(x, y)
		    if oOffset <> nil then
		      dim fto as FTObject = GetDoc.getObjectAtOffset(oOffset)
		      if fto isa FTStyleRun then
		        if FTStyleRun(fto).HyperLink <> "" then
		          ' Set the cursor to the Finger Pointer.
		          setMouseCursor(system.Cursors.FingerPointer)
		          return
		        end
		      end
		    end
		    
		    ' Set the cursor to the IBeam.
		    setMouseCursor(system.Cursors.IBeam)
		    
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setNormalViewMode()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the mode data.
		  Mode = Display_mode.Normal
		  
		  ' Check the picture sizes.
		  doc.checkPictureSizes
		  
		  ' Update the display.
		  updateFull
		  
		  ' Resize the display.
		  resize
		  
		  ' Move to the top of the document.
		  vScrollTo(0)
		  
		  ' Set the scrollbars.
		  showHorizontalScrollbar(true)
		  showVerticalScrollbar(true)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setPageSize(pageWidth as double, pageHeight as double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Is there anything to do?
		  if (doc.getPageWidth = pageWidth) and _
		  (doc.getPageHeight = pageHeight) then return
		  
		  ' Save the original document page settings.
		  undo.saveOriginalPage(FTCStrings.PAGE_SIZE)
		  
		  ' Set the page size.
		  doc.setPageSize(pageWidth, pageHeight)
		  
		  ' Save the new document page settings.
		  undo.saveNewPage
		  
		  ' Send notification of the change.
		  TextChanged
		  
		  ' Update the display.
		  updateFull
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setPageViewMode()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the mode data.
		  Mode = Display_mode.Page
		  
		  ' Check the picture sizes.
		  doc.checkPictureSizes
		  
		  ' Update the display.
		  updateFull
		  
		  ' Resize the display.
		  resize
		  
		  ' Move to the top of the document.
		  vScrollTo(0)
		  
		  ' Show the scrollbars.
		  showHorizontalScrollbar(true)
		  showVerticalScrollbar(true)
		  
		  ' Send notification of the change.
		  TextChanged
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setParagraphStyle(id as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Are we in the read only mode?
		  if readOnly then return
		  
		  ' Save the original paragraph characteristics.
		  undo.saveOriginalParagraph(FTCStrings.PARAGRAPH_STYLE)
		  
		  ' Set the paragraph style for the selected items.
		  doc.setParagraphStyle(id)
		  
		  ' Save the style change.
		  undo.saveNewParagraph
		  
		  ' Send notification of the change.
		  TextChanged
		  
		  ' Update the display.
		  updateFull
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setPrintMarginOffsets(leftMargin as double, rightMargin as double, topMargin as double, bottomMargin as double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  #if TargetMacOS
		    
		    #pragma Unused leftMargin
		    #pragma Unused rightMargin
		    #pragma Unused topMargin
		    #pragma Unused bottomMargin
		    
		  #elseif TargetWindows
		    
		    ' Set the printing margin offsets (Windows only).
		    doc.setPrintMarginOffsets(leftMargin, rightMargin, topMargin, bottomMargin)
		    
		  #endif
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setReadOnly(state as boolean)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Is there anything to do?
		  if state = readOnly then return
		  
		  ' Are we going into read only mode?
		  if state then
		    
		    ' Make sure the cursor is visible.
		    setVisibleCursorState(true)
		    
		    ' Clear any pictures in resize mode.
		    doc.deselectResizePictures
		    
		    ' Clear the target reference.
		    targetResizePicture = nil
		    
		  end if
		  
		  ' Save the read only state.
		  readOnly = state
		  
		  ' Update the display.
		  updateFull
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setRTF(s as string)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim state as boolean
		  
		  ' Turn off updates.
		  state = setInhibitUpdates(true)
		  
		  ' Clear out any undo items.
		  getUndoManager.clear
		  
		  ' Clear all content.
		  doc.deleteAll
		  
		  ' Set the text in the document.
		  doc.setRTF(s)
		  
		  ' Make sure the content fits the display.
		  resize
		  
		  ' Send notification of the change.
		  TextChanged
		  
		  ' Restore the update state.
		  call setInhibitUpdates(state)
		  
		  ' Update the display.
		  updateFull
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setScale(scale as double, update as boolean = true)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Is there anything to do?
		  if scale <= 0.0 then return
		  
		  ' Are we in edit mode?
		  if isEditViewMode or isSingleViewMode then return
		  
		  ' Are scaling down?
		  if scale < 1.0 then
		    
		    ' Render at 100%.
		    displayScale = 1.0
		    
		  else
		    
		    ' Render at the scale.
		    displayScale = scale
		    
		  end if
		  
		  ' Save the new scale setting.
		  me.scale = scale
		  
		  ' Should we do an update?
		  if update then
		    
		    ' Adjust the clipping page.
		    doc.adjustClippingPage
		    
		    ' Scale the contents.
		    doc.scale
		    
		    ' Send notification of the change.
		    TextChanged
		    
		    ' Update the display.
		    updateFull
		    
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setSelectStyleBinding()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim startOffset as FTInsertionOffset
		  Dim endOffset as FTInsertionOffset
		  Dim fto as FTObject
		  
		  ' Is there anything selected?
		  if doc.isSelected then
		    
		    ' Get the selection range.
		    doc.getSelectionRange(startOffset, endOffset)
		    
		    ' Get the first item in the selection.
		    fto = doc.getObjectAtOffset(endOffset)
		    
		    ' Is this a style run?
		    if fto isa FTStyleRun then
		      
		      ' Set up the style binding.
		      setStyleBinding(fto)
		      
		    end if
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setSingleViewMode(margin as double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set the margins to all be the same.
		  setSingleViewMode(margin, margin, margin, margin)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setSingleViewMode(leftMargin as double, rightMargin as double, topMargin as double, bottomMargin as double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim state as boolean
		  
		  ' Inhibit updates.
		  state = setInhibitUpdates(true)
		  
		  ' Set the scale to 100%.
		  setScale(1.0)
		  
		  ' Save the mode data.
		  mode = Display_mode.Single
		  
		  ' Set the margins.
		  doc.setMargins(leftMargin, rightMargin, topMargin, bottomMargin)
		  
		  ' Set the scrollbars.
		  showHorizontalScrollbar(true)
		  showVerticalScrollbar(true)
		  
		  ' Restore the update state.
		  call setInhibitUpdates(state)
		  
		  
		  //Issue 3754: Clipping Page incorrect after printing in Single mode
		  ' Update the display.
		  ' updateFull
		  
		  ' Resize which will do a full update
		  resize
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub setStyleBinding(fto as FTBase = nil)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Are we clearing the binding?
		  if fto is nil then
		    
		    ' Clear the style binding.
		    styleBinding = nil
		    
		  else
		    
		    ' Is this a style run?
		    if fto isa FTStyleRun then
		      
		      ' Set the style binding.
		      styleBinding = new FTCharacterStyle(self, FTStyleRun(fto))
		      
		    end if
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setText(s as string)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim state as boolean
		  
		  ' Turn off updates.
		  state = setInhibitUpdates(true)
		  
		  ' Clear out any undo items.
		  getUndoManager.clear
		  
		  ' Set the text in the document.
		  doc.setText(s)
		  
		  ' Make sure the content fits the display.
		  resize
		  
		  ' Send notification of the change.
		  TextChanged
		  
		  ' Restore the update state.
		  call setInhibitUpdates(state)
		  
		  ' Update the display.
		  updateFull
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub setUpAcceptDrops()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  const FILE_TYPE_NAME = "FTCDropType"
		  
		  ' Can we accept drops on the control?
		  if not readOnly and DragAndDrop then
		    
		    ' Set up the drop types.
		    AcceptTextDrop
		    AcceptPictureDrop
		    AcceptRawDataDrop(RTF_DATA_TYPE)
		    AcceptRawDataDrop(XML_DATA_TYPE)
		    AcceptRawDataDrop(PRIVATE_DROP_TYPE)
		    
		    ' Has the drop file types been created?
		    if dropFileTypes is nil then
		      
		      ' Create the file drop type.
		      dropFileTypes = new FileType
		      dropFileTypes.name = FILE_TYPE_NAME
		      dropFileTypes.MacCreator = "????"
		      dropFileTypes.MacType = "????"
		      
		    end if
		    
		    ' Set the file drops.
		    AcceptFileDrop(dropFileTypes)
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub setVisibleCursorState(state as boolean)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim x as integer
		  Dim y as integer
		  
		  ' Get the current mouse coordinates.
		  x = me.MouseX - me.Left
		  y = me.MouseY - me.Top
		  
		  ' Are we outside the control?
		  if (x < 0) or (x > me.Width) or (y < 0) or (y > me.Height) then
		    
		    ' Make it visible.
		    state = true
		    
		  end if
		  
		  ' Do we want to show the cursor?
		  if state then
		    
		    ' Make sure it is visible.
		    System.Cursors.Show
		    System.Cursors.Show
		    
		  else
		    
		    ' Don't hide the cursor?
		    if cursorVisible and (not ReadOnly) then
		      
		      ' Hide the cursor.
		      System.Cursors.Hide
		      
		    end if
		    
		  end if
		  
		  ' Save the current cursor state.
		  cursorVisible = state
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setXML(s as string)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim state as boolean
		  
		  ' Turn off updates.
		  state = setInhibitUpdates(true)
		  
		  ' Clear out any undo items.
		  getUndoManager.clear
		  
		  ' Set the text in the document.
		  doc.setXML(s)
		  
		  ' Make sure the content fits the display.
		  resize
		  
		  ' Send notification of the change.
		  TextChanged
		  
		  ' Restore the update state.
		  call setInhibitUpdates(state)
		  
		  ' Update the display.
		  updateFull
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub showAutoComplete(sPrefix as string, arsOption() as string)
		  m_bAutoCompleteVisible = true
		  if m_wAutoComplete=nil then
		    m_wAutoComplete = new FTAutoCompleteWindow(self)
		    m_wAutoComplete.Visible = false
		  end if
		  m_wAutoComplete.Display(sPrefix, arsOption)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub showHorizontalScrollbar(state as boolean)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Does the scrollbar exist?
		  if not (hScrollbar is nil) then
		    
		    ' Will the state of the scrollbar change?
		    if hScrollbar.visible <> state then
		      
		      ' Change the visible state of the scrollbar.
		      hScrollbar.visible = state
		      
		      ' Reposition the scrollbars.
		      adjustScrollbars
		      
		      ' Readjust the display picture.
		      adjustDisplayPicture
		      
		      ' Resize the display.
		      resize
		      
		    end if
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub showVerticalScrollbar(state as boolean)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Does the scrollbar exist?
		  if not (vScrollbar is nil) then
		    
		    ' Will the state of the scrollbar change?
		    if vScrollbar.visible <> state then
		      
		      ' Change the visible state of the scrollbar.
		      vScrollbar.visible = state
		      
		      ' Reposition the scrollbars.
		      adjustScrollbars
		      
		      ' Readjust the display picture.
		      adjustDisplayPicture
		      
		      ' Resize the display.
		      resize
		      
		    end if
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub TIC_DeleteBackward()
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		  #endif
		  
		  Dim saveUpdate as boolean
		  Dim p as FTParagraph
		  
		  ' Are we currently handling a mouse event?
		  if inMouseDownEvent then
		    return
		  end if
		  
		  setVisibleCursorState(false)
		  saveUpdate = setInhibitUpdates(true)
		  
		  '----------------------------------------------
		  ' Adjust the insertion point.
		  '----------------------------------------------
		  'put the insertion point at the end of the current paragraph if it's gone past the end
		  p = doc.getInsertionPoint.getCurrentParagraph
		  if doc.getInsertionOffset.offset > p.getLength then
		    doc.setInsertionPoint(p, p.getLength, false)
		  end if
		  
		  handleBackwardDelete
		  
		  '----------------------------------------------
		  ' Exit code.
		  '----------------------------------------------
		  
		  ' Make sure the insertion caret is showing.
		  doc.blinkCaret(true)
		  
		  ' Turn on updates.
		  call setInhibitUpdates(saveUpdate)
		  
		  ' Update the display.
		  updateFlag = true
		  scrollToCaretFlag = true
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TIC_DeleteText(range as TextRange)
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  TIC_InsertText( "", range )
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function TIC_DoCommand(command as string) As boolean
		  #If Not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim saveUpdate as boolean
		  Dim p as FTParagraph
		  
		  ' Are we currently handling a mouse event?
		  if inMouseDownEvent then return true
		  
		  #if DebugBuild
		    
		    Dim time as double
		    
		    ' Save the total number of key strokes for optimization purposes.
		    keyStrokesTotal = keyStrokesTotal + 1
		    
		    ' Time the key stroke update.
		    time = Microseconds
		    
		  #endif
		  
		  ' Hide the cursor.
		  setVisibleCursorState(false)
		  
		  ' Turn off updates.
		  saveUpdate = setInhibitUpdates(true)
		  
		  '----------------------------------------------
		  ' Adjust the insertion point.
		  '----------------------------------------------
		  
		  ' Get the paragraph with the insertion point.
		  p = doc.getInsertionPoint.getCurrentParagraph
		  
		  ' Are we past the end of the paragraph?
		  if doc.getInsertionOffset.offset > p.getLength then
		    
		    ' Bring it back into the paragraph.
		    doc.setInsertionPoint(p, p.getLength, false)
		    
		  end if
		  '================
		  
		  select case command
		  case cmdMoveLeft, CmdMoveWordLeft, cmdMoveLeftAndModifySelection, _
		    CmdMoveWordLeftAndModifySelection, cmdMoveToLeftEndOfLine, cmdMoveToLeftEndOfLineAndModifySelection
		    // Implemented by subclasses to move the selection or insertion point one element or character
		    // to the left.
		    handleLeftArrowKey
		    callSelectionChangedEvent
		    
		    
		  case cmdMoveRight, CmdMoveWordRight, cmdMoveRightAndModifySelection, _
		    cmdMoveToRightEndOfLine, cmdMoveToRightEndOfLineAndModifySelection
		    // Implemented by subclasses to move the selection or insertion point one element or character to the right.
		    handleRightArrowKey
		    callSelectionChangedEvent
		    
		    
		  case cmdMoveDown, cmdMoveToEndOfLine, CmdMoveForward, _
		    cmdMoveDownAndModifySelection, cmdMoveToEndOfLineAndModifySelection
		    handleDownArrowKey
		    callSelectionChangedEvent
		    
		    
		  case cmdMoveUp, cmdMoveToBeginningOfLine, cmdMoveToBeginningOfDocument, _
		    CmdMoveBackward, cmdMoveUpAndModifySelection, _
		    cmdMoveToBeginningOfLineAndModifySelection
		    handleUpArrowKey
		    callSelectionChangedEvent
		    
		    
		  case cmdMoveToBeginningOfParagraph, cmdMoveToBeginningOfParagraphAndModifySelection
		    // Mantis Ticket 3832: Implement Control + Up/Down Arrow Key Handling
		    
		    ' Normally doc.getInsertionOffset.moveToBeginningOfParagraph
		    ' should do this, but it does not work in all cases.
		    doc.moveInsertionPointToParagraphStart(false)
		    
		  case cmdMoveToEndOfParagraph, cmdMoveToEndOfParagraphAndModifySelection
		    // Mantis Ticket 3832: Implement Control + Up/Down Arrow Key Handling
		    
		    ' Normally doc.getInsertionOffset.moveToEndOfParagraph
		    ' should do this, but it does not work in all cases.
		    doc.moveInsertionPointToParagraphEnd(false)
		    
		  case cmdMoveParagraphForwardAndModifySelection
		    // Mantis Ticket 3833: Implement paragraph moving via keyboard handling
		    
		    ' Shift + Option + Down Arrow
		    ' Word: Shift + Control + Down Arrow
		    doc.moveParagraphForward
		    
		  case cmdMoveParagraphBackwardAndModifySelection
		    // Mantis Ticket 3833: Implement paragraph moving via keyboard handling
		    
		    ' Shift + Option + Up Arrow
		    ' Word: Shift + Control + Up Arrow
		    doc.moveParagraphBackward
		    
		  case cmdDeleteBackward, CmdDeleteWordBackward
		    TIC_DeleteBackward
		    
		  case cmdDeleteForward, CmdDeleteWordForward
		    // Deletes the selection, if there is one, or a single character forward from the insertion point
		    handleForwardDelete
		    
		    
		  case cmdDeleteToEndOfLine, cmdDeleteToEndOfParagraph
		    // Implemented by subclasses to delete the selection, if there is one, or all text from the insertion point to
		    // the end of a line/paragraph (typically of text).
		    //
		    // Also places the deleted text into the kill buffer.
		    
		    
		  case cmdDeleteToBeginningOfLine, cmdDeleteToBeginningOfParagraph
		    // Implemented by subclasses to delete the selection, if there is one, or all text from the insertion point
		    // to the beginning of a line/paragraph (typically of text).
		    //
		    // Also places the deleted text into the kill buffer.
		    
		  case cmdYank
		    // Replaces the insertion point or selection with text from the kill buffer.
		    break //have yet to see this called.  Please let us know how this works and how to duplicate!
		    
		  case cmdToggleOverwriteMode
		    'mOverwriteMode = not mOverwriteMode
		    
		  case cmdInsertNewline, CmdInsertNewlineIgnoringFieldEditor
		    call callKeyDown(EndOfLine.Macintosh)
		    
		  case cmdInsertTab, CmdInsertTabIgnoringFieldEditor
		    if AutoComplete then //This will insert a tab if there isn't an AutoComplete
		      handleAutoCompleteKey
		    else
		      TIC_InsertText(Chr(9), nil)
		    end if
		    
		  case CmdScrollPageDown, CmdPageDown, CmdPageDownAndModifySelection
		    HandlePageDown saveUpdate
		    
		  case CmdScrollPageUp, cmdPageUp, CmdPageUpAndModifySelection
		    HandlePageUp saveUpdate
		    
		  case CmdScrollToBeginningOfDocument, CmdMoveToBeginningOfDocumentAndModifySelection
		    ' Turn on updates.
		    call setInhibitUpdates(saveUpdate)
		    
		    handleHomeKey
		    
		  case CmdScrollToEndOfDocument, cmdMoveToEndOfDocument, cmdMoveToEndOfDocumentAndModifySelection
		    ' Turn on updates.
		    call setInhibitUpdates(saveUpdate)
		    
		    handleEndKey
		  case CmdCancelOperation
		    //Not sure what todo if anything
		    
		  Case CmdMoveWordRightAndModifySelection
		    handleShiftOptionRightArrowKey
		    
		  Case CmdMoveWordLeftAndModifySelection
		    handleShiftOptionLeftArrowKey
		    
		  Else
		    #If DebugBuild
		      MsgBox command
		    #endif
		    return false
		  end select
		  
		  ' Make sure the insertion caret is showing.
		  doc.blinkCaret(true)
		  
		  ' Turn on updates.
		  call setInhibitUpdates(saveUpdate)
		  
		  '============
		  ' Update the display.
		  updateFlag = true
		  
		  select case command
		  case CmdScrollPageDown, CmdPageDown, CmdPageDownAndModifySelection,CmdScrollPageUp, cmdPageUp, CmdPageUpAndModifySelection, _
		    CmdScrollToEndOfDocument, CmdScrollToBeginningOfDocument, cmdMoveToEndOfDocumentAndModifySelection, cmdMoveToBeginningOfDocumentAndModifySelection
		    scrollToCaretFlag = false
		  case else
		    scrollToCaretFlag = true
		  end
		  
		  #if DebugBuild
		    
		    ' Save the total key stroke time.
		    keyTimeTotal = keyTimeTotal + (Microseconds - time)
		    
		  #endif
		  '=============
		  
		  return true
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function TIC_GetInsertionOffsetFromOffset(offset as integer) As FTInsertionOffset
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  if offset<0 then
		    return new FTInsertionOffset(doc, 0, 0, true)
		  end if
		  
		  dim iMax as integer = doc.getParagraphCount-1
		  
		  for i as integer = 0 to iMax
		    
		    dim par as FTParagraph = doc.getParagraph(i)
		    
		    if par.getLength>offset then
		      return new FTInsertionOffset(doc, i, offset)
		    end if
		    
		    '-1 is for the paragraph separator
		    offset = offset - par.getLength - 1
		    
		  next
		  
		  return new FTInsertionOffset(doc, iMax, doc.getParagraph(iMax).getLength)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TIC_GetLineAtCharacterIndex(doc as FTDocument, index as integer, byref oLineOut as FTLine, byref lineOffsetOut as integer) As boolean
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  if doc is nil then
		    return false
		  end if
		  
		  dim io as FTInsertionOffset
		  io = TIC_GetInsertionOffsetFromOffset(index)
		  if io is nil then
		    return false
		  end if
		  
		  dim p as FTParagraph = doc.getParagraph(io.paragraph)
		  if p is nil then
		    return false
		  end if
		  
		  dim lineIndex as integer
		  dim offsetIndex as integer
		  p.findLine(0, io.offset, false, lineIndex, offsetIndex)
		  dim oLine as FTLine = p.getLine(lineIndex)
		  if oLine is nil then
		    return false
		  end if
		  
		  
		  if offsetIndex>=oLine.getLength then
		    dim iLineLength as integer = oLine.getLength
		    offsetIndex = offsetIndex - iLineLength
		  end if
		  
		  oLineOut = oLine
		  lineOffsetOut = offsetIndex
		  
		  return true
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function TIC_GetOffsetFromInsertionOffset(ioIn as FTInsertionOffset) As integer
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  'get the character offset from the insertion offset
		  'the character is ahead of the insertion point
		  
		  dim op as FTParagraph = doc.getParagraph(ioIn.paragraph)
		  dim io as new FTInsertionOffset(doc, ioIn.paragraph, ioIn.offset, ioIn.bias)
		  if io.offset>op.getLength then
		    if io.paragraph+1<doc.getParagraphCount then
		      'io.offset = 0
		      'io.paragraph = io.paragraph+1
		    else
		      'io.offset = io.offset - 1
		    end if
		  end if
		  
		  dim offset as integer
		  if io.paragraph>0 then
		    dim iMax as integer = io.paragraph-1
		    for i as integer = 0 to iMax
		      dim par as FTParagraph = doc.getParagraph(i)
		      dim ct as integer = par.getLength
		      offset = offset + ct
		    next
		  end if
		  offset = offset + io.offset + io.paragraph
		  
		  return offset
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TIC_GetStyleRunAtOffset(offset as integer) As FTStyleRun
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  dim io as FTInsertionOffset = TIC_GetInsertionOffsetFromOffset(offset)
		  if io is nil then
		    return nil
		  end if
		  
		  dim p as FTParagraph
		  p = doc.getParagraph(io.paragraph)
		  
		  dim ix as integer = p.findItem(io.offset)
		  dim oItem as FTObject = p.getItem(ix)
		  if oItem is nil then
		    return nil
		  end if
		  
		  dim iStartPos as integer = oItem.getStartPosition-1 'start position within the paragraph
		  if io.offset>=iStartPos+oItem.getLength then
		    'end of style run item
		    ix = ix + 1
		    oItem = p.getItem(ix)
		    if oItem is nil then
		      return nil
		    end if
		  end if
		  
		  if not oItem isa FTStyleRun then
		    return nil
		  end if
		  return FTStyleRun(oItem)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TIC_InsertText(text as string, range as TextRange)
		  
		  ' Note, this part of the software is the most critical for
		  ' determining the speed of the system. Be careful how you handle
		  ' key strokes!
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim saveUpdate as boolean
		  Dim io as FTInsertionOffset
		  Dim startPosition as FTInsertionOffset
		  Dim endPosition as FTInsertionOffset
		  Dim p as FTParagraph
		  
		  ' Are we currently handling a mouse event?
		  if inMouseDownEvent then
		    return
		  end if
		  
		  #if DebugBuild
		    
		    Dim time as double
		    
		    ' Save the total number of key strokes for optimization purposes.
		    keyStrokesTotal = keyStrokesTotal + 1
		    
		    ' Time the key stroke update.
		    time = Microseconds
		    
		  #endif
		  
		  ' Hide the cursor.
		  setVisibleCursorState(false)
		  
		  ' Turn off updates.
		  saveUpdate = setInhibitUpdates(true)
		  
		  '----------------------------------------------
		  ' Adjust the insertion point.
		  '----------------------------------------------
		  
		  ' Get the paragraph with the insertion point.
		  p = doc.getInsertionPoint.getCurrentParagraph
		  
		  ' Are we past the end of the paragraph?
		  if doc.getInsertionOffset.offset > p.getLength then
		    
		    ' Bring it back into the paragraph.
		    doc.setInsertionPoint(p, p.getLength, false)
		    
		  end if
		  
		  
		  '----------------------------------------------
		  ' Normal key processing.
		  '----------------------------------------------
		  
		  ' Are we in the read only mode?
		  If readOnly = False Then
		    
		    ' We can edit the text.
		    
		    if range<>nil then
		      startPosition = TIC_GetInsertionOffsetFromOffset(range.Location - 1)
		      endPosition = startPosition + range.Length
		      doc.selectSegment(startPosition, endPosition)
		      
		      ' Get the selection range.
		      doc.getSelectionRange(startPosition, endPosition)
		      
		      ' Use the start position.
		      io = startPosition
		    elseif doc.isSelected then
		      
		      ' Check for selected text being deleted.
		      saveUndoDelete(FTCStrings.DELETE)
		      
		      ' Get the selection range.
		      doc.getSelectionRange(startPosition, endPosition)
		      
		      ' Use the start position.
		      io = startPosition
		    Else
		      
		      ' Use the insertion point.
		      io = doc.getInsertionPoint.getOffset
		      
		    end if
		    
		    ' Move the insertion point for the undo.
		    undo.saveTyping(text, io)
		    
		    ' Allow filtering of the key press.
		    'KeyPress(text)
		    
		    ' set that we are typing
		    me.doc.isTyping = true
		    
		    ' Insert the key press.
		    doc.insertString(text, styleBinding)
		    
		    ' Reset that we are typing
		    me.doc.isTyping = false
		    
		    ' Reset the style binding.
		    setStyleBinding
		    
		    ' Send notification of the change.
		    TextChanged
		    
		  End
		  
		  '----------------------------------------------
		  ' Exit code.
		  '----------------------------------------------
		  
		  ' Make sure the insertion caret is showing.
		  doc.blinkCaret(true)
		  
		  ' Turn on updates.
		  call setInhibitUpdates(saveUpdate)
		  
		  ' Update the display.
		  updateFlag = true
		  scrollToCaretFlag = true
		  
		  #if DebugBuild
		    
		    ' Save the total key stroke time.
		    keyTimeTotal = keyTimeTotal + (Microseconds - time)
		    
		  #endif
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub update()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Are we blocked?
		  if inhibitUpdates then return
		  
		  ' Request an update.
		  updateFlag = true
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub update(compose as boolean, force as boolean)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Are we blocked?
		  if inhibitUpdates or not isInitialized then return
		  
		  ' We don't need an update via the timer.
		  updateFlag = false
		  
		  ' Has the number of paragraphs changed since the last time we updated?
		  if lastParagraphCount <> (doc.getParagraphCount - 1) then
		    
		    ' Mark all the pages for an update.
		    doc.markAllPagesDirty
		    
		    ' Save the new count.
		    lastParagraphCount = doc.getParagraphCount - 1
		    
		  end if
		  
		  #if DebugBuild
		    
		    Dim time as double
		    
		    ' Save the total number of updates for optimization purposes.
		    updateCallsTotal = updateCallsTotal + 1
		    
		    ' Time the key stroke update.
		    time = Microseconds
		    
		  #endif
		  
		  ' Do we need to compose the text?
		  if compose then
		    
		    ' Compose the pages.
		    doc.compose
		    
		    ' Set the scroll bar lengths.
		    adjustScrollbarParameters
		    
		  end if
		  
		  ' Do we need to draw the contents?
		  if force then
		    
		    ' Draw the contents.
		    draw
		    
		  end if
		  
		  ' Draw the entire display.
		  Invalidate(false)
		  
		  #if DebugBuild
		    
		    ' Save the total update time.
		    updateTimeTotal = updateTimeTotal + (Microseconds - time)
		    
		  #endif
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub updateDraw()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Are we blocked?
		  if inhibitUpdates or (doc is nil) then return
		  
		  ' Was an update requested?
		  if updateFlag then
		    
		    ' Update the display.
		    update(doc.hasDirtyParagraphs, true)
		    
		  end if
		  
		  ' Do we need to make the insertion caret visible?
		  if scrollToCaretFlag then
		    
		    ' Make sure the insertion point is visible.
		    scrollToCaret
		    
		    ' Clear the flag.
		    scrollToCaretFlag = false
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub updateFull()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Are we blocked?
		  if inhibitUpdates then return
		  
		  ' Mark the background as needing updating.
		  hasMoved = true
		  
		  ' Mark all the paragraphs as needing an update.
		  doc.markAllParagraphsDirty
		  
		  ' Update the display.
		  update(true, true)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub updatePages(compose as boolean, force as boolean)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Make sure all the pages get reformatted.
		  doc.markAllPagesDirty
		  
		  ' Update the display.
		  update(compose, force)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub updatePartial(preslop as integer, postSlop as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Mark the background as needing updating.
		  hasMoved = true
		  
		  ' Mark all the visible paragraphs as needing an update.
		  doc.markAllVisibleParagraphsDirty(preslop, postslop)
		  
		  ' Update the display.
		  update(true, true)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub vScroll(position as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Should we ignore this event?
		  if inhibitScroll then return
		  
		  ' Are we in page view?
		  if (not isPageViewMode) and (scale < 1.0) then
		    
		    ' Save the display position.
		    vScrollValue = -(position / scale)
		    
		  else
		    
		    ' Save the display position.
		    vScrollValue = -position
		    
		  end if
		  
		  ' Update the display.
		  update(false, true)
		  
		  ' Let the world know.
		  ScrollChanged(vScrollValue, hScrollValue)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub vScrollTo(position as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Does the scrollbar exist?
		  if not (vScrollbar is nil) then
		    
		    ' Check the range.
		    position = Max(position, 0)
		    position = Min(position, vScrollbar.Maximum)
		    
		    ' Did anything change?
		    if vScrollbar.Value <> position then
		      
		      ' Scroll to the desired position.
		      vScrollbar.Value = position
		      
		    end if
		    
		  end if
		  
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event AutoCompleteOptions(ip as FTInsertionPoint, byref sPrefix as string, arsOption() as string) As boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Close()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ConstructContextualMenu(base as MenuItem, x as integer, y as integer) As boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ContextualMenuAction(hitItem as MenuItem) As boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event DefaultParagraphStyle() As FTParagraphStyle
	#tag EndHook

	#tag Hook, Flags = &h0
		Event DoCommand(command as string) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event DoubleClick(x as integer, y as integer)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event DragEnter(obj as DragItem, action as integer) As boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event DragExit(obj as DragItem, action as integer)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event DrawLine(proxy as FTParagraphProxy, line as FTLine, g as graphics, drawBeforeSpace as boolean, firstIndent as integer, page as integer, x as double, y as double, leftPoint as integer, rightPoint as integer, alignment as FTParagraph.Alignment_Type, printing as boolean, printScale as double)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event DropFolderItem(fi as FolderItem, offset as FTInsertionOffset)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event DropObject(obj as DragItem, action as integer) As boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event EnableMenuItems()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event GetHorizontalScrollbar() As FTScrollbar
	#tag EndHook

	#tag Hook, Flags = &h0
		Event GetVerticalScrollbar() As FTScrollbar
	#tag EndHook

	#tag Hook, Flags = &h0
		Event GotFocus()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event HyperlinkClick(sURL as String)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event InsertImage(pic as FTPicture) As boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event InsertionPointChanged(previousOffset as FTInsertionOffset, currentOffset as FTInsertionOffset)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event KeyPress(ByRef key as string)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event LostFocus()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event MouseDown(x as integer, y as integer) As boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event MouseDrag(x as integer, y as integer)
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
		Event MouseWheel(x as integer, y as integer, deltaX as integer, deltaY as integer) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event NewDocument() As FTDocument
	#tag EndHook

	#tag Hook, Flags = &h0
		Event NewPage() As FTPage
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ObjectDoubleClick(obj as FTObject)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Open()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Paint(g as Graphics)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event PasteAction() As boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event PostDisplayDraw(g as graphics)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event PostPageDraw(g as graphics, p as FTPage, printing as boolean, printScale as double)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event PreDisplayDraw(g as graphics)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event PrePageDraw(g as graphics, p as FTPage, printing as boolean, printScale as double)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ScrollChanged(verticalPosition as integer, horizontalPosition as integer)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event SelectionChanged()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event SingleClick(x as integer, y as integer)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event SpellCheckParagraph(text as string) As FTSpellCheckWord()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event SpellCheckWord(word as string) As boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event TextChanged()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event TripleClick(x as integer, y as integer)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event UnrecognizedXmlObject(obj as XmlElement)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event UnrecognizedXmlObjectFromAttributeList(attributeList as XmlAttributeList)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event XmlDecodeTag(data as string, obj as FTBase)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event XmlEncodeTag(obj as FTBase) As string
	#tag EndHook

	#tag Hook, Flags = &h0
		Event XmlObjectCreate(obj as XmlElement) As FTObject
	#tag EndHook

	#tag Hook, Flags = &h0
		Event XmlObjectCreateFromAttributeList(attributeList as XmlAttributeList) As FTObject
	#tag EndHook


	#tag Property, Flags = &h21
		Private absoluteMouseDownTime As integer
	#tag EndProperty

	#tag Property, Flags = &h0
		AllowBackgroundUpdates As boolean = true
	#tag EndProperty

	#tag Property, Flags = &h0
		AllowPictures As boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private anchorLeft As FTInsertionOffset
	#tag EndProperty

	#tag Property, Flags = &h21
		Private anchorOffset As FTInsertionOffset
	#tag EndProperty

	#tag Property, Flags = &h21
		Private anchorRight As FTInsertionOffset
	#tag EndProperty

	#tag Property, Flags = &h21
		Private anchorType As integer
	#tag EndProperty

	#tag Property, Flags = &h0
		AutoComplete As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		BackgroundColor As Color = &cA0ADCD
	#tag EndProperty

	#tag Property, Flags = &h0
		BorderColor As color = &ca0a0a0
	#tag EndProperty

	#tag Property, Flags = &h0
		BottomMargin As double
	#tag EndProperty

	#tag Property, Flags = &h0
		CaretColor As Color = &c000000
	#tag EndProperty

	#tag Property, Flags = &h21
		Private clickCount As integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private contextualInsertionOffset As FTInsertionOffset
	#tag EndProperty

	#tag Property, Flags = &h0
		CornerColor As Color = &cFFFFFF00
	#tag EndProperty

	#tag Property, Flags = &h21
		Private currentInsertionOffset As FTInsertionOffset
	#tag EndProperty

	#tag Property, Flags = &h21
		Private currentResizePicture As FTPicture
	#tag EndProperty

	#tag Property, Flags = &h21
		Private cursorVisible As boolean = true
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  
			  #if not DebugBuild
			    
			    #pragma BoundsChecking FTC_BOUNDSCHECKING
			    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
			    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
			    
			  #endif
			  
			  return mDefaultFont
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  
			  #if not DebugBuild
			    
			    #pragma BoundsChecking FTC_BOUNDSCHECKING
			    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
			    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
			    
			  #endif
			  
			  ' Save the font.
			  mDefaultFont = checkFontName(value)
			End Set
		#tag EndSetter
		DefaultFont As string
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  
			  #if not DebugBuild
			    
			    #pragma BoundsChecking FTC_BOUNDSCHECKING
			    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
			    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
			    
			  #endif
			  
			  ' Return the value.
			  return mDefaultFontSize
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  
			  #if not DebugBuild
			    
			    #pragma BoundsChecking FTC_BOUNDSCHECKING
			    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
			    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
			    
			  #endif
			  
			  ' Check the range.
			  if value <= 0 then value = 12
			  
			  ' Set the value.
			  mDefaultFontSize = value
			End Set
		#tag EndSetter
		DefaultFontSize As integer
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		defaultHyperLinkColor As Color = &c0000ff
	#tag EndProperty

	#tag Property, Flags = &h0
		defaultHyperLinkColorDisabled As Color = &ccccccc
	#tag EndProperty

	#tag Property, Flags = &h0
		defaultHyperLinkColorRollover As Color = &cFF0000
	#tag EndProperty

	#tag Property, Flags = &h0
		defaultHyperLinkColorVisited As Color = &c800080
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  
			  #if not DebugBuild
			    
			    #pragma BoundsChecking FTC_BOUNDSCHECKING
			    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
			    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
			    
			  #endif
			  
			  ' Return the value.
			  return mDefaultTabStop
			  
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  
			  #if not DebugBuild
			    
			    #pragma BoundsChecking FTC_BOUNDSCHECKING
			    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
			    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
			    
			  #endif
			  
			  ' Check the range.
			  if value <= 0 then value = 0.5
			  
			  ' Set the value.
			  mDefaultTabStop = value
			  
			  ' Has the document been created?
			  if not (doc is nil) then
			    
			    ' Update the tab stops.
			    doc.addDefaultTabStops(FTTabStop.TabStopType.Left, value)
			    
			  end if
			  
			End Set
		#tag EndSetter
		DefaultTabStop As double
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		DefaultTextColor As Color = &c000000
	#tag EndProperty

	#tag Property, Flags = &h0
		DisplayAlignment As Display_Alignment
	#tag EndProperty

	#tag Property, Flags = &h21
		Private displayScale As double = 1.0
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected doc As FTDocument
	#tag EndProperty

	#tag Property, Flags = &h0
		DragAndDrop As boolean = true
	#tag EndProperty

	#tag Property, Flags = &h0
		DrawControlBorder As boolean = true
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Shared dropFileTypes As FileType
	#tag EndProperty

	#tag Property, Flags = &h21
		Private editMenuAutoEnableState As AutoEnableData
	#tag EndProperty

	#tag Property, Flags = &h0
		EditViewMargin As double = 0.06
	#tag EndProperty

	#tag Property, Flags = &h0
		EditViewPrintMargin As double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private flipDraw As boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private focusState As boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private hasMoved As boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private heightUpdate As integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private hScrollbar As FTScrollbar
	#tag EndProperty

	#tag Property, Flags = &h0
		HScrollbarAutoHide As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private hScrollValue As integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private imageResizeHeightNew As integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private imageResizeHeightOld As integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private imageResizeOffset As FTInsertionOffset
	#tag EndProperty

	#tag Property, Flags = &h21
		Private imageResizeWidthNew As integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private imageResizeWidthOld As integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private inDragAndDrop As boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private inhibitScroll As boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		InhibitSelections As boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private inhibitUpdates As boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private initialized As boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private inMouseDownEvent As boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private inMouseDrag As boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private insertionPointTimer As FTInsertionPointTimer
	#tag EndProperty

	#tag Property, Flags = &h0
		InvisiblesColor As Color = &c526AFF
	#tag EndProperty

	#tag Property, Flags = &h0
		IsHiDPT As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private keyStrokesTotal As integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private keyTimeTotal As double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private lastClickOffset As FTInsertionOffset
	#tag EndProperty

	#tag Property, Flags = &h21
		Private lastEndPosition As FTInsertionOffset
	#tag EndProperty

	#tag Property, Flags = &h21
		Private LastHScrollValue As Integer = -100000
	#tag EndProperty

	#tag Property, Flags = &h1
		#tag Note
			added for doing selectionchange on mouseup
		#tag EndNote
		Protected Lastinsertion As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h21
		Private lastParagraphCount As integer = -1
	#tag EndProperty

	#tag Property, Flags = &h21
		Private LastVScrollValue As integer = -100000
	#tag EndProperty

	#tag Property, Flags = &h0
		LeftMargin As double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private leftUpdate As integer
	#tag EndProperty

	#tag Property, Flags = &h0
		MarginGuideColor As Color = &cCACACA
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDefaultFont As string
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDefaultFontSize As integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDefaultTabStop As double = 0.5
	#tag EndProperty

	#tag Property, Flags = &h0
		Mode As Display_Mode
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mouseDownStartTime As integer = -1
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mouseDownX As integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mouseDownY As integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mouseDragX As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mouseDragY As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private m_arsAutoCompleteOption() As string
	#tag EndProperty

	#tag Property, Flags = &h21
		Private m_bAutoCompleteVisible As boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private m_wAutoComplete As FTAutoCompleteWindow
	#tag EndProperty

	#tag Property, Flags = &h0
		objectCountId As integer
	#tag EndProperty

	#tag Property, Flags = &h0
		PageHeight As double = 11.0
	#tag EndProperty

	#tag Property, Flags = &h0
		PageWidth As double = 8.5
	#tag EndProperty

	#tag Property, Flags = &h21
		Private picDisplay As picture
	#tag EndProperty

	#tag Property, Flags = &h0
		ReadOnly As boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		RightMargin As double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private scale As double = 1.0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private scrollToCaretFlag As boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private selectionRect(4) As integer
	#tag EndProperty

	#tag Property, Flags = &h0
		ShowInvisibles As boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		ShowMarginGuides As boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		ShowPilcrows As boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		SpellCheckWhileTyping As boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private styleBinding As FTCharacterStyle
	#tag EndProperty

	#tag Property, Flags = &h21
		Private targetContextualMenuPicture As FTPicture
	#tag EndProperty

	#tag Property, Flags = &h21
		Private targetCustomObject As FTCustom
	#tag EndProperty

	#tag Property, Flags = &h21
		Private targetResizePicture As FTPicture
	#tag EndProperty

	#tag Property, Flags = &h0
		TIC_m_incompleteTextRange As TextRange
	#tag EndProperty

	#tag Property, Flags = &h0
		TIC_PageTop As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		TIC_xCaret As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		TIC_yCaret As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		TopMargin As double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private topUpdate As integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private tripleClickTime As integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private undo As FTCUndoManager
	#tag EndProperty

	#tag Property, Flags = &h0
		UndoLimit As Integer = 128
	#tag EndProperty

	#tag Property, Flags = &h21
		Private updateCallsTotal As integer
	#tag EndProperty

	#tag Property, Flags = &h0
		updateFlag As boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		updateTimer As FTUpdateTimer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private updateTimeTotal As double
	#tag EndProperty

	#tag Property, Flags = &h0
		UsePageShadow As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h21
		Private vScrollbar As FTScrollbar
	#tag EndProperty

	#tag Property, Flags = &h0
		VScrollbarAutoHide As boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private vScrollValue As integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private widthUpdate As integer
	#tag EndProperty

	#tag Property, Flags = &h0
		WordParagraphBackground As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h0
		xDisplayAlignmentOffset As integer
	#tag EndProperty


	#tag Constant, Name = BIT_DEPTH, Type = Double, Dynamic = False, Default = \"32", Scope = Public
	#tag EndConstant

	#tag Constant, Name = DRAG_THRESHOLD, Type = Double, Dynamic = False, Default = \"14", Scope = Private
	#tag EndConstant

	#tag Constant, Name = DRAG_TIMEOUT, Type = Double, Dynamic = False, Default = \"120", Scope = Private
	#tag EndConstant

	#tag Constant, Name = PRIVATE_DROP_TYPE, Type = String, Dynamic = False, Default = \"FTCp", Scope = Public
	#tag EndConstant

	#tag Constant, Name = RTF_DATA_TYPE, Type = String, Dynamic = False, Default = \"RTF ", Scope = Public
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"Rich Text Format"
	#tag EndConstant

	#tag Constant, Name = VERSION, Type = String, Dynamic = False, Default = \"3.2.0", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XML_DATA_TYPE, Type = String, Dynamic = False, Default = \"FTCx", Scope = Public
	#tag EndConstant


	#tag Enum, Name = Display_Alignment, Type = Integer, Flags = &h0
		Left
		  Center
		Right
	#tag EndEnum

	#tag Enum, Name = Display_Mode, Type = Integer, Flags = &h0
		Page
		  Normal
		  Edit
		Single
	#tag EndEnum


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
			EditorType="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
			EditorType="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Height"
			Visible=true
			Group="Position"
			InitialValue="100"
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="InitialParent"
			Group="Position"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockBottom"
			Visible=true
			Group="Position"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockLeft"
			Visible=true
			Group="Position"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockRight"
			Visible=true
			Group="Position"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockTop"
			Visible=true
			Group="Position"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabIndex"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabPanelIndex"
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabStop"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Width"
			Visible=true
			Group="Position"
			InitialValue="100"
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AutoDeactivate"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Enabled"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HelpTag"
			Visible=true
			Group="Appearance"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Visible"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AutoComplete"
			Visible=true
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="defaultHyperLinkColor"
			Group="Behavior"
			InitialValue="&c0000ff"
			Type="Color"
		#tag EndViewProperty
		#tag ViewProperty
			Name="defaultHyperLinkColorDisabled"
			Group="Behavior"
			InitialValue="&ccccccc"
			Type="Color"
		#tag EndViewProperty
		#tag ViewProperty
			Name="defaultHyperLinkColorRollover"
			Group="Behavior"
			InitialValue="&cFF0000"
			Type="Color"
		#tag EndViewProperty
		#tag ViewProperty
			Name="defaultHyperLinkColorVisited"
			Group="Behavior"
			InitialValue="&c800080"
			Type="Color"
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsHiDPT"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="objectCountId"
			Group="Behavior"
			InitialValue="0"
			Type="integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TIC_PageTop"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TIC_xCaret"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TIC_yCaret"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="updateFlag"
			Group="Behavior"
			InitialValue="0"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="xDisplayAlignmentOffset"
			Group="Behavior"
			Type="integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowBackgroundUpdates"
			Visible=true
			Group="FT Behavior"
			InitialValue="True"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowPictures"
			Visible=true
			Group="FT Behavior"
			InitialValue="True"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="BackgroundColor"
			Visible=true
			Group="FT Behavior"
			InitialValue="&cA0ADCD"
			Type="Color"
		#tag EndViewProperty
		#tag ViewProperty
			Name="BorderColor"
			Visible=true
			Group="FT Behavior"
			InitialValue="&ca0a0a0"
			Type="color"
		#tag EndViewProperty
		#tag ViewProperty
			Name="CaretColor"
			Visible=true
			Group="FT Behavior"
			InitialValue="&c000000"
			Type="Color"
		#tag EndViewProperty
		#tag ViewProperty
			Name="CornerColor"
			Visible=true
			Group="FT Behavior"
			InitialValue="&cFFFFFF00"
			Type="Color"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DragAndDrop"
			Visible=true
			Group="FT Behavior"
			InitialValue="True"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DrawControlBorder"
			Visible=true
			Group="FT Behavior"
			InitialValue="true"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HScrollbarAutoHide"
			Visible=true
			Group="FT Behavior"
			InitialValue="False"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="InhibitSelections"
			Visible=true
			Group="FT Behavior"
			InitialValue="False"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="InvisiblesColor"
			Visible=true
			Group="FT Behavior"
			InitialValue="&c526AFF"
			Type="Color"
		#tag EndViewProperty
		#tag ViewProperty
			Name="MarginGuideColor"
			Visible=true
			Group="FT Behavior"
			InitialValue="&cCACACA"
			Type="Color"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Mode"
			Visible=true
			Group="FT Behavior"
			Type="Display_Mode"
			EditorType="Enum"
			#tag EnumValues
				"0 - Page"
				"1 - Normal"
				"2 - Edit"
				"3 - Single"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="ReadOnly"
			Visible=true
			Group="FT Behavior"
			InitialValue="False"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ShowInvisibles"
			Visible=true
			Group="FT Behavior"
			InitialValue="False"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ShowMarginGuides"
			Visible=true
			Group="FT Behavior"
			InitialValue="False"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ShowPilcrows"
			Visible=true
			Group="FT Behavior"
			InitialValue="False"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="SpellCheckWhileTyping"
			Visible=true
			Group="FT Behavior"
			InitialValue="False"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="UndoLimit"
			Visible=true
			Group="FT Behavior"
			InitialValue="128"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="UsePageShadow"
			Visible=true
			Group="FT Behavior"
			InitialValue="True"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="VScrollbarAutoHide"
			Visible=true
			Group="FT Behavior"
			InitialValue="False"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="WordParagraphBackground"
			Visible=true
			Group="FT Behavior"
			InitialValue="True"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="BottomMargin"
			Visible=true
			Group="FT Page Mode"
			InitialValue="0"
			Type="double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LeftMargin"
			Visible=true
			Group="FT Page Mode"
			InitialValue="0"
			Type="double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="PageHeight"
			Visible=true
			Group="FT Page Mode"
			InitialValue="11.0"
			Type="double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="PageWidth"
			Visible=true
			Group="FT Page Mode"
			InitialValue="8.5"
			Type="double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="RightMargin"
			Visible=true
			Group="FT Page Mode"
			InitialValue="0"
			Type="double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TopMargin"
			Visible=true
			Group="FT Page Mode"
			InitialValue="0"
			Type="double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DefaultFont"
			Visible=true
			Group="FT Defaults"
			InitialValue="Arial"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DefaultFontSize"
			Visible=true
			Group="FT Defaults"
			InitialValue="12"
			Type="integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DefaultTabStop"
			Visible=true
			Group="FT Defaults"
			InitialValue="0.5"
			Type="double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DefaultTextColor"
			Visible=true
			Group="FT Defaults"
			InitialValue="&c000000"
			Type="Color"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DisplayAlignment"
			Visible=true
			Group="FT Mode"
			InitialValue="0"
			Type="Display_Alignment"
			EditorType="Enum"
			#tag EnumValues
				"0 - Left"
				"1 - Center"
				"2 - Right"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="EditViewMargin"
			Visible=true
			Group="FT Edit Mode"
			InitialValue="0.06"
			Type="double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="EditViewPrintMargin"
			Visible=true
			Group="FT Edit Mode"
			InitialValue="0.5"
			Type="double"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
