#tag Class
Protected Class FTDocument
Inherits FTBase
	#tag Method, Flags = &h0
		Sub addCharacterStyle(cs as FTCharacterStyle)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the style.
		  characterStyles.value(cs.getId) = cs
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub addDefaultTabStop(tabType as FTTabStop.TabStopType, tabStop as double)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim ts as FTTabStop
		  
		  ' Create the tab stop.
		  ts = New FTTabStop(parentControl, tabType, tabStop, True)
		  
		  ' Get the number of tab stops.
		  count = Ubound(defaultTabStops) - 1
		  
		  ' Scan for the place to insert the tab stop.
		  for i = 0 to count
		    
		    ' Did we find the spot to insert the tab stop?
		    if (tabStop >= defaultTabStops(i).getTabStop) and _
		      (tabStop <= defaultTabStops(i + 1).getTabStop) then
		      
		      ' Insert the tab stop into the list.
		      defaultTabStops.Insert(i + 1, ts)
		      
		      ' We are done.
		      return
		      
		    end if
		    
		  next
		  
		  ' Add the tab stop to the end of the list.
		  defaultTabStops.Append(ts)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub addDefaultTabStops(tabType as FTTabStop.TabStopType, tabStop as double)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #Pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim ts as FTTabStop
		  Dim currentTabStop as double
		  
		  const MAX_TAB_STOPS = 200
		  
		  ' Is the tab stop length the same?
		  if (Ubound(defaultTabStops) >= 0) and (tabStop = defaultTabStops(0).getTabStop) then
		    
		    ' Have they already been created?
		    if Ubound(defaultTabStops) >= MAX_TAB_STOPS then return
		    
		  end if
		  
		  ' Clear any existing tab stops.
		  Redim defaultTabStops(-1)
		  
		  ' Update all the paragraphs.
		  markAllParagraphsDirty
		  
		  ' Is there anything to do?
		  if tabStop <= 0 then return
		  
		  ' Get the number of tab stops.
		  count = Max(MAX_TAB_STOPS, (getPageWidth / tabStop) + 5)
		  
		  ' Scan for the place to insert the tab stop.
		  for i = 1 to count
		    
		    ' Set the tab stop position.
		    currentTabStop = currentTabStop + tabStop
		    
		    ' Create the tab stop.
		    ts = new FTTabStop(parentControl, tabType, currentTabStop, true)
		    
		    ' Append the tab stop into the list.
		    defaultTabStops.append(ts)
		    
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function addNewPage(pageIndex as integer, force as boolean = false) As FTPage
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim page as FTPage
		  Dim currentPage as FTPage
		  Dim pp as FTParagraphProxy
		  Dim line as FTLine
		  Dim index as integer
		  
		  ' Are we within range?
		  if not force and (pageIndex >= 1) and (pageIndex <= Ubound(pages)) then
		    
		    ' Get the page.
		    currentPage = pages(pageIndex)
		    
		    ' Get the last paparagraph proxy on the previous page.
		    pp = currentPage.getParagraph(pages(pageIndex - 1).getParagraphCount - 1)
		    
		    ' Did we get a proxy?
		    if (not (pp is nil)) and (not (pp.getParent is nil)) then
		      
		      ' Get the next line in the paragraph.
		      line = pp.getParent.getLine(pp.getLineEnd + 1)
		      
		      ' Are we into the next paragraph?
		      if line is nil then
		        
		        ' Get the paragraph index.
		        index = pp.getParent.getAbsoluteIndex + 1
		        
		        ' Is the paragraph index in range?
		        if (index > -1) and (index <= Ubound(paragraphs)) then
		          
		          ' Get the first line of that paragraph.
		          line = paragraphs(index).getLine(0)
		          
		        end if
		        
		      end if
		      
		      ' Will anything change on the page?
		      if (not (line is nil)) and ((pageIndex + 1) <= Ubound(pages)) then
		        
		        ' Have we reached a page that doesn't need updating?
		        if pages(pageIndex + 1).getFirstLineId = line.getId then
		          
		          ' Signal that a new page is not needed.
		          return nil
		          
		        end if
		        
		      end if
		      
		    end if
		    
		    ' Use the current page.
		    page = currentPage
		    
		    ' Clear the content off the page.
		    page.clear
		    
		  else
		    
		    ' Are we within the page range?
		    if pageIndex <= Ubound(pages) then
		      
		      ' Get the page.
		      page = pages(pageIndex)
		      
		      ' Clear the content off the page.
		      page.clear
		      
		    else
		      
		      ' Call the user event.
		      page = parentControl.callNewPage
		      
		      ' Did we get a new page?
		      if page is nil then
		        
		        ' Create an FTPage.
		        page = new FTPage(parentControl)
		        
		      end if
		      
		      ' Add the page to the list.
		      pages.Append(page)
		      
		      ' Set the page number.
		      page.setAbsolutePage(Ubound(pages))
		      
		    end if
		    
		  end if
		  
		  ' Return the page to the caller.
		  return page
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function addNewParagraph(parent as FTParagraph = nil) As FTParagraph
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim p as FTParagraph
		  Dim index as integer
		  
		  ' Was the parent specified?
		  if parent is nil then
		    
		    ' Create the paragraph.
		    p = new FTParagraph(parentControl, getNextAbsoluteIndex, _
		    defaultParagraphStyle.getId)
		    
		    ' Add it to the end of the list.
		    paragraphs.Append(p)
		    
		  else
		    
		    ' Find the insertion point.
		    index = parent.getAbsoluteIndex + 1
		    
		    ' Create the duplicate paragraph.
		    p = new FTParagraph(parentControl, index, parent)
		    
		    ' Add the paragraph.
		    paragraphs.insert(index, p)
		    
		    ' Update the indexes.
		    updateParagraphIndexes(index)
		    
		  end if
		  
		  ' Make the paragraph dirty.
		  p.makeDirty
		  
		  ' Return the new paragraph.
		  return p
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub addParagraphStyle(ps as FTParagraphStyle)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the style.
		  paragraphStyles.value(ps.getStyleName) = ps
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub addToSelection(amount as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim startPosition as FTInsertionOffset
		  Dim endPosition as FTInsertionOffset
		  Dim selectionFlag as boolean
		  Dim length as integer
		  
		  const RESET_CARET = true
		  
		  ' Is there anything to do?
		  if amount = 0 then return
		  
		  ' Is something selected?
		  if isSelected then
		    
		    ' Get the range of the current selection.
		    getSelectionRange(startPosition, endPosition)
		    
		    ' Get the length of the selection.
		    length = getSelectionLength
		    
		  else
		    
		    ' Use the current insertion point.
		    startPosition = getInsertionOffset
		    endPosition = startPosition.clone
		    
		  end if
		  
		  ' Handle the current achor type.
		  select case anchor
		    
		  case AnchorTag.NONE
		    
		    selectionFlag = addToSelectionAnchorNone(amount, length, startPosition, endPosition)
		    
		  case AnchorTag.LEFT_SIDE
		    
		    selectionFlag = addToSelectionAnchorLeft(amount, length, startPosition, endPosition)
		    
		  case AnchorTag.RIGHT_SIDE
		    
		    selectionFlag = addToSelectionAnchorRight(amount, length, startPosition, endPosition)
		    
		  end select
		  
		  ' Update the display.
		  updateSelectionAndAnchor(selectionFlag, startPosition, endPosition)
		  
		  ' Make sure the X offset has been calculated.
		  getInsertionPoint.calculateCaretOffset
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function addToSelectionAnchorLeft(amount as integer, length as integer, ByRef sp as FTInsertionOffset, ByRef ep as FTInsertionOffset) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim targetOffset as FTInsertionOffset
		  
		  const RESET_CARET = true
		  
		  ' Are we moving to the left?
		  if amount < 0 then
		    
		    ' Move the start of the selection.
		    sp = sp + amount
		    
		    ' Are we at the end of the paragraph that has something in it?
		    if sp.isEndOfParagraph and (sp.getParagraph.getLength > 0) then
		      
		      ' Back it up so the selection shows up.
		      sp = sp - 1
		      
		    end if
		    
		    ' Are we at the front part of the line?
		    if sp.isBetweenLines then
		      
		      ' Use the beginning of the line.
		      sp.bias = true
		      
		    end if
		    
		  else
		    
		    ' Are we moving right where the selection is nullified?
		    if (length > 0) and (length = amount) then
		      
		      ' Nothing is selected.
		      anchor = AnchorTag.NONE
		      
		      ' Is this an empty paragraph?
		      if ep.getParagraph.getLength = 0 then
		        
		        ' Move to the next paragraph.
		        ep = ep + 1
		        
		      end if
		      
		      ' Move the insertion point.
		      setInsertionPoint(ep, RESET_CARET)
		      
		      ' No selection.
		      return false
		      
		    end if
		    
		    ' Calculate the new start position of the selection.
		    targetOffset = sp + amount
		    
		    ' Are we before the end of the selection?
		    if targetOffset <= ep then
		      
		      ' Move the start of the selection.
		      sp = targetOffset
		      
		    else
		      
		      ' Flip the selection.
		      sp = ep
		      ep = targetOffset
		      
		      ' Set the anchor.
		      anchor = AnchorTag.RIGHT_SIDE
		      
		    end if
		    
		  end if
		  
		  ' There is a selection.
		  return true
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function addToSelectionAnchorNone(amount as integer, length as integer, ByRef sp as FTInsertionOffset, ByRef ep as FTInsertionOffset) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim io as FTInsertionOffset
		  
		  const RESET_CARET = true
		  
		  ' Get the insertion offset.
		  io = getInsertionOffset
		  
		  ' Is anything selected?
		  if length = 0 then
		    
		    ' Are we moving to the left?
		    if amount < 0 then
		      
		      ' Is there anything to do?
		      if io.isBeginning then return false
		      
		      ' Set the start and end positions of the selection.
		      sp = io + amount
		      ep = io.clone
		      
		      ' Do we need to back up the end offset?
		      if (ep.offset = 0) and (ep.getParagraph.getLength = 0) then
		        
		        ' Move it to the previous paragraph.
		        ep.paragraph = Max(ep.paragraph - 1, 0)
		        ep.offset = ep.getParagraph.getLength
		        ep.bias = false
		        
		      end if
		      
		      ' Calculate the position and set the anchor.
		      anchor = AnchorTag.LEFT_SIDE
		      
		      ' Move the insertion point.
		      setInsertionPoint(sp, RESET_CARET)
		      
		      return true
		      
		    end if
		    
		    '-----------------------------------------------
		    
		    ' Are we moving to the right?
		    if amount > 0 then
		      
		      ' Is there anything to do?
		      if io.isEnd then return false
		      
		      ' Set the start and end positions of the selection.
		      sp = io.clone
		      ep = io + amount
		      
		      ' Do we need to move to the next paragraph?
		      if (sp.offset = 0) and (sp.getParagraph.getLength = 0) then
		        
		        ' Favor the beginning of the paragraph.
		        sp.bias = true
		        
		        ' Are we just selecting the empty paragraph?
		        if amount = 1 then
		          
		          ' Set the end position to the end of the paragraph.
		          ep.paragraph = sp.paragraph
		          ep.offset = 0
		          ep.bias = false
		          
		        end if
		        
		      end if
		      
		      ' Calculate the position and set the anchor.
		      anchor = AnchorTag.RIGHT_SIDE
		      
		      ' Move the insertion point.
		      setInsertionPoint(ep, RESET_CARET)
		      
		    end if
		    
		  end if
		  
		  ' There is a selection.
		  return true
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function addToSelectionAnchorRight(amount as integer, length as integer, ByRef sp as FTInsertionOffset, ByRef ep as FTInsertionOffset) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim targetOffset as FTInsertionOffset
		  
		  const RESET_CARET = true
		  
		  ' Are we moving right?
		  if amount > 0 then
		    
		    ' Move the end of the selection.
		    ep = ep + amount
		    
		    ' Do we need to make the selection show up?
		    if ep.isBeginningOfParagraph and (ep.getParagraph.getLength > 0) then
		      
		      ' Bump it up.
		      ep = ep + 1
		      
		    else
		      
		      ' Make sure the bias represents the end or middle of the paragraph.
		      ep.bias = false
		      
		    end if
		    
		  else
		    
		    ' Are we moving left where the selection is nullified?
		    if (length > 0) and (length = abs(amount)) then
		      
		      ' Nothing is selected.
		      anchor = AnchorTag.NONE
		      
		      ' Move the insertion point.
		      setInsertionPoint(sp, RESET_CARET)
		      
		      ' No selection.
		      return false
		      
		    end if
		    
		    ' Calculate the destination.
		    targetOffset = ep + amount
		    
		    ' Do we need to flip the selection?
		    if targetOffset < sp then
		      
		      ' Flip the selection.
		      ep = sp
		      sp = targetOffset
		      
		      ' Set the anchor.
		      anchor = AnchorTag.LEFT_SIDE
		      
		    else
		      
		      ' Set the end of the selection.
		      ep = targetOffset
		      
		      ' Do we need to adjust it?
		      if ep.isBeginningOfParagraph and (ep.getParagraph.getLength > 0) then
		        
		        ' Back up the selection.
		        ep = ep - 1
		        
		      end if
		      
		    end if
		    
		  end if
		  
		  ' We will be selecting
		  return true
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub addToSelectionByLine(amount as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim selectStart as FTInsertionOffset
		  Dim selectEnd as FTInsertionOffset
		  Dim selectionFlag as boolean
		  
		  ' Is there anything to do?
		  if amount = 0 then return
		  
		  ' Is there a selection?
		  if isSelected then
		    
		    ' Get the selection range.
		    getSelectionRange(selectStart, selectEnd)
		    
		    select case anchor
		      
		    case AnchorTag.LEFT_SIDE
		      
		      ' Move the selection backwards.
		      selectionFlag = addToSelectionByLineAnchorLeft _
		      (amount, selectStart, selectEnd)
		      
		    case AnchorTag.RIGHT_SIDE
		      
		      ' Move the selection forwards.
		      selectionFlag = addToSelectionByLineAnchorRight _
		      (amount, selectStart, selectEnd)
		      
		    else
		      
		      ' We should not get here.
		      break
		      
		    end select
		    
		  else
		    
		    ' Handle the non-selected situation.
		    selectionFlag = addToSelectionByLineAnchorNone(amount, selectStart, selectEnd)
		    
		  end if
		  
		  ' Update the display.
		  updateSelectionAndAnchor(selectionFlag, selectStart, selectEnd)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function addToSelectionByLineAnchorLeft(amount as integer, ByRef selectStart as FTInsertionOffset, ByRef selectEnd as FTInsertionOffset) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim caretOffset as integer
		  Dim startParagraph as integer
		  Dim startLine as integer
		  Dim endParagraph as integer
		  Dim endLine as integer
		  Dim startOffset as integer
		  Dim endOffset as integer
		  Dim temp as integer
		  Dim beginningSelected as boolean
		  Dim endSelected as boolean
		  Dim changed as boolean
		  Dim scale as double
		  
		  ' Get the current scale.
		  scale = parentControl.getDisplayScale
		  
		  ' Get the caret offset.
		  caretOffset = insertionPoint.getCaretOffset
		  
		  ' Assume the left side.
		  anchor = AnchorTag.LEFT_SIDE
		  
		  ' Get the selected range.
		  getSelectionRange(selectStart, selectEnd)
		  
		  ' Initialize the offsets.
		  startOffset = selectStart.offset
		  endOffset = selectEnd.offset
		  
		  ' Get the selection boundaries in terms of lines.
		  findSelectionLines(startParagraph, startLine, endParagraph, endLine)
		  
		  ' Are the ends of the lines selected?
		  beginningSelected = getParagraph(startParagraph).getLine(startLine).isFirstPositionSelected
		  endSelected = getParagraph(endParagraph).getLine(endLine).isLastPositionSelected
		  
		  ' Move to the next logical line.
		  startLine = startLine + amount
		  
		  ' Adjust the paragraph and line.
		  changed = addToSelectionByLineRangeCheck(startParagraph, startLine)
		  
		  ' Are we going to the left?
		  if amount < 0 then
		    
		    '--------------------------------------------
		    ' Moving to the Left.
		    '--------------------------------------------
		    
		    ' Are we selecting whole lines?
		    if (caretOffset > 0) and beginningSelected then
		      
		      ' Use the beginning of the line.
		      caretOffset = 0
		      
		    end if
		    
		    ' Should we select to the beginning?
		    if startLine = -1 then
		      
		      ' Go to the beginning.
		      startOffset = 0
		      
		    else
		      
		      ' Are we at the end of a paragraph?
		      if (startOffset >= getParagraph(startParagraph).getLength) and _
		        (caretOffset >= getParagraph(startParagraph).getLine(startLine).getWidth(scale)) and _
		        (getParagraph(startParagraph).getLineCount > 1) then
		        
		        ' Back up a line.
		        startLine = startLine - 1
		        
		        ' Adjust the paragraph and line.
		        call addToSelectionByLineRangeCheck(startParagraph, startLine)
		        
		      end if
		      
		      ' Calculate where to set the start offset in the paragraph.
		      startOffset = findLineOffset(getParagraph(startParagraph), caretOffset, startLine, scale)
		      
		      ' Did we cross the paragraph boundary?
		      if endParagraph < selectEnd.paragraph then
		        
		        ' Use the end of the paragraph as the offset.
		        endOffset = getParagraph(endParagraph).getLength + 1
		        
		      end if
		      
		    end if
		    
		  else
		    
		    '--------------------------------------------
		    ' Moving to the right.
		    '--------------------------------------------
		    
		    ' Was the selection at the very beginning?
		    if selectStart.isBeginning and (caretOffset > 0) then
		      
		      ' Calculate where to set the start offset in the paragraph.
		      startOffset = findLineOffset(getParagraph(startParagraph), caretOffset, 0, scale)
		      
		    else
		      
		      ' Are we doing whole lines?
		      if beginningSelected then
		        
		        ' Use the beginning of the line.
		        caretOffset = 0
		        
		      end if
		      
		      ' Calculate where to set the end offset in the paragraph.
		      startOffset = findLineOffset(getParagraph(startParagraph), caretOffset, startLine, scale)
		      
		      
		      ' Are we making a transition to a non-selection?
		      if changed and (startParagraph > endParagraph) then
		        
		        ' Clear the selection.
		        endParagraph = startParagraph
		        endOffset = startOffset
		        
		      end if
		      
		      ' Are we in the same paragraph?
		      if startParagraph = endParagraph then
		        
		        ' Are we at the very end of the paragraph?
		        if startOffset >= getParagraph(startParagraph).getLength then
		          
		          ' Clear the selection.
		          endParagraph = startParagraph
		          endOffset = startOffset
		          
		        else
		          
		          ' Have we flipped the relationship?
		          if (endLine < startLine) or ((startLine = endLine) and (endOffset < startOffset)) then
		            
		            ' Swap the endpoints.
		            temp = startOffset
		            startOffset = endOffset
		            endOffset = temp
		            
		            ' Flip to the left side.
		            anchor = AnchorTag.RIGHT_SIDE
		            
		          else
		            
		            ' Are we back on the original line but not back
		            ' to the original insertion point?
		            if beginningSelected and endSelected and _
		              (startLine = endLine) then
		              
		              ' Calculate where to set the end offset in the paragraph.
		              startOffset = findLineOffset(getParagraph(startParagraph), 0, startLine, scale)
		              
		            end if
		            
		          end if
		          
		        end if
		        
		      end if
		      
		    end if
		    
		  end if
		  
		  '--------------------------------------------
		  ' Clean up.
		  '--------------------------------------------
		  
		  ' Set the selection range.
		  selectStart.set(startParagraph, startOffset)
		  selectEnd.set(endParagraph, endOffset)
		  
		  ' Return the selection flag.
		  return addToSelectionCheck(startParagraph, startOffset, _
		  endParagraph, endOffset, insertionPoint.getCaretOffset)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function addToSelectionByLineAnchorNone(amount as integer, ByRef selectStart as FTInsertionOffset, ByRef selectEnd as FTInsertionOffset) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim caretOffset as integer
		  Dim selectionFlag as boolean
		  Dim startParagraph as integer
		  Dim startLine as integer
		  Dim endParagraph as integer
		  Dim endLine as integer
		  Dim startOffset as integer
		  Dim endOffset as integer
		  Dim scale as double
		  Dim fto as FTObject
		  Dim p as FTParagraph
		  Dim isBetweenLines as boolean
		  Dim frontOfLine as boolean
		  
		  ' Get the current scale.
		  scale = parentControl.getDisplayScale
		  
		  ' Get the caret offset.
		  caretOffset = insertionPoint.getCaretOffset
		  
		  ' Get the selected range.
		  getSelectionRange(selectStart, selectEnd)
		  
		  ' Initialize the offsets.
		  startOffset = getInsertionOffset.offset
		  endOffset = startOffset
		  
		  ' Get the selection boundaries in terms of lines.
		  findSelectionLines(startParagraph, startLine, endParagraph, endLine)
		  
		  ' Are we going to the right?
		  if amount > 0 then
		    
		    '--------------------------------------------
		    ' Moving to the right.
		    '--------------------------------------------
		    
		    ' Move to the next logical line.
		    endLine = endLine + amount
		    
		    ' Adjust the paragraph and line.
		    call addToSelectionByLineRangeCheck(endParagraph, endLine)
		    
		    ' Get the reference to the paragraph.
		    p = getParagraph(endParagraph)
		    
		    ' Are we within range?
		    if endLine = p.getLineCount then
		      
		      ' Calculate where to set the end offset in the paragraph.
		      endOffset = findLineOffset(p, caretOffset, endLine, scale)
		      
		      ' Set the anchor.
		      anchor = AnchorTag.RIGHT_SIDE
		      
		    elseif endLine < p.getLineCount then
		      
		      ' Calculate where to set the end offset in the paragraph.
		      endOffset = findLineOffset(p, caretOffset, endLine, scale)
		      
		      ' Get the item this refers to.
		      fto = p.getLine(endLine).getItemFromOffset(p.getLine(endLine).getParagraphOffset - endOffset)
		      
		      ' Did we get something?
		      if not (fto is nil) then
		        
		        ' Is it a picture or custom object, then select it.
		        if fto.isMonolithic then endOffset = endOffset + 1
		        
		      end if
		      
		      ' Set the anchor.
		      anchor = AnchorTag.RIGHT_SIDE
		      
		    end if
		    
		  else
		    
		    '--------------------------------------------
		    ' Moving to the left.
		    '--------------------------------------------
		    
		    ' Calculate where to set the start offset in the current line.
		    startOffset = findLineOffset(getParagraph(startParagraph), caretOffset, startLine, scale)
		    
		    ' Is there something to select on this line?
		    if startOffset < getInsertionOffset.offset then
		      
		      ' Set up so that it makes the selection on the current line.
		      startLine = startLine - amount
		      
		      ' Are we on the first line?
		    elseif startLine = 0 then
		      
		      ' Check to see if the insertion point is between lines.
		      isBetweenLines = getInsertionOffset.isBetweenLines(frontOfLine)
		      
		      ' Are we at the end of the line?
		      if isBetweenLines and (not frontOfLine) then
		        
		        ' Use the beginning of the line offset.
		        caretOffset = 0
		        
		        ' Make it so that we end up on line zero.
		        startLine = startLine - amount
		        
		      end if
		      
		    end if
		    
		    ' Move to the next logical line.
		    startLine = startLine + amount
		    
		    ' Adjust the paragraph and line.
		    call addToSelectionByLineRangeCheck(startParagraph, startLine)
		    
		    ' Calculate where to set the start offset in the paragraph.
		    startOffset = findLineOffset(getParagraph(startParagraph), caretOffset, startLine, scale)
		    
		    ' Set the anchor.
		    anchor = AnchorTag.LEFT_SIDE
		    
		  end if
		  
		  '--------------------------------------------
		  ' Clean up.
		  '--------------------------------------------
		  
		  ' Have we deselected everything?
		  if (startParagraph = endParagraph) and (startOffset = endOffset) then
		    
		    ' Turn off the selection.
		    selectionFlag = false
		    
		    ' Clear the anchor.
		    anchor = AnchorTag.NONE
		    
		  else
		    
		    ' We will be selecting something.
		    selectionFlag = true
		    
		    ' Set the selection range.
		    selectStart.set(startParagraph, Max(startOffset, 0))
		    selectEnd.set(endParagraph, endOffset)
		    
		  end if
		  
		  ' Return the selection flag.
		  return selectionFlag
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function addToSelectionByLineAnchorRight(amount as integer, ByRef selectStart as FTInsertionOffset, ByRef selectEnd as FTInsertionOffset) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim caretOffset as integer
		  Dim startParagraph as integer
		  Dim startLine as integer
		  Dim endParagraph as integer
		  Dim endLine as integer
		  Dim startOffset as integer
		  Dim endOffset as integer
		  Dim temp as integer
		  Dim beginningSelected as boolean
		  Dim endSelected as boolean
		  Dim originalEndLine as integer
		  Dim scale as double
		  Dim line as FTLine
		  Dim fto as FTObject
		  Dim ep as FTParagraph
		  Dim useParagraphEnd as boolean
		  
		  ' Get the current scale.
		  scale = parentControl.getDisplayScale
		  
		  ' Get the caret offset.
		  caretOffset = insertionPoint.getCaretOffset
		  
		  ' Assume the right side.
		  anchor = AnchorTag.RIGHT_SIDE
		  
		  ' Get the selected range.
		  getSelectionRange(selectStart, selectEnd)
		  
		  ' Initialize the offsets.
		  startOffset = selectStart.offset
		  endOffset = selectEnd.offset
		  
		  ' Get the selection boundaries in terms of lines.
		  findSelectionLines(startParagraph, startLine, endParagraph, endLine)
		  
		  ' Save the original ending line.
		  originalEndLine = endLine
		  
		  ' Are the ends of the lines selected?
		  beginningSelected = getParagraph(startParagraph).getLine(startLine).isFirstPositionSelected
		  endSelected = getParagraph(endParagraph).getLine(endLine).isLastPositionSelected
		  
		  ' Move to the next logical line.
		  endLine = endLine + amount
		  
		  ' Adjust the paragraph and line.
		  call addToSelectionByLineRangeCheck(endParagraph, endLine)
		  
		  ' Get a reference to an end paragraph.
		  ep = getParagraph(endParagraph)
		  
		  ' Are we going to the right?
		  if amount > 0 then
		    
		    '--------------------------------------------
		    ' Moving to the right.
		    '--------------------------------------------
		    
		    ' Are we selecting from the beginning of the line?
		    if caretOffset = 0 then
		      
		      ' Are we past the end of the paragraph?
		      if endLine >= ep.getLineCount - 1 then
		        
		        ' Reset to the end of the paragraph.
		        useParagraphEnd = true
		        
		      else
		        
		        ' Move to the next line.
		        endLine = endLine + 1
		        
		        ' Adjust the paragraph and line.
		        call addToSelectionByLineRangeCheck(endParagraph, endLine)
		        
		      end if
		      
		    end if
		    
		    ' Get a reference to an end paragraph.
		    ep = getParagraph(endParagraph)
		    
		    ' Are we past the end of the paragraph?
		    if endLine > (ep.getLineCount - 1) then
		      
		      ' Reset to the end of the paragraph.
		      endOffset = ep.getLength
		      
		    else
		      
		      ' Are we selecting to the end of the paragraph?
		      if useParagraphEnd then
		        
		        ' Use the end of the paragraph.
		        endOffset = ep.getLength + 1
		        
		      else
		        
		        ' Calculate where to set the end offset in the paragraph.
		        endOffset = findLineOffset(ep, caretOffset, endLine, scale)
		        
		      end if
		      
		      ' Get the item this offset refers to.
		      fto = ep.getLine(endLine).getItemFromOffset(ep.getLine(endLine).getParagraphOffset - endOffset)
		      
		      ' Did we get something?
		      if not (fto is nil) then
		        
		        ' Is it a picture or custom object, then select it.
		        if fto.isMonolithic then endOffset = endOffset + 1
		        
		      end if
		      
		      ' Are we on the border between paragraphs?
		      if getParagraph(startParagraph).getLength = startOffset then
		        
		        ' Move to the beginning of the following paragraph.
		        startParagraph = startParagraph + 1
		        startOffset = 0
		        
		      end if
		      
		    end if
		    
		  else
		    
		    '--------------------------------------------
		    ' Moving to the left.
		    '--------------------------------------------
		    
		    ' Was the selection at the very end?
		    if (caretOffset > 0) and selectEnd.isEnd then
		      
		      ' Get the last line.
		      line = ep.getLine(ep.getLineCount - 1)
		      
		      ' Do we have a stop point on the last line?
		      if (caretOffset > 0) and (caretOffset < line.getWidth(scale)) then
		        
		        ' Use the very last line.
		        endLine = ep.getLineCount - 1
		        
		      end if
		      
		      ' Calculate where to set the end offset in the paragraph.
		      endOffset = findLineOffset(ep, caretOffset, endLine, scale)
		      
		    else
		      
		      ' Are we selecting whole lines?
		      if (caretOffset = 0) and endSelected then
		        
		        ' Set it to a pratically infinite value.
		        caretOffset = CARET_OFFSET_INFINITY
		        
		      end if
		      
		      ' Calculate where to set the end offset in the paragraph.
		      endOffset = findLineOffset(ep, caretOffset, endLine, scale)
		      
		      ' Are the start and end selection points in different paragraphs?
		      if endParagraph < startParagraph then
		        
		        ' Are we at the very end of the paragraph?
		        if (endOffset >= getParagraph(endParagraph).getLength) and (startOffset = 0) then
		          
		          ' Clear the selection.
		          startParagraph = endParagraph
		          startOffset = endOffset
		          
		        else
		          
		          ' Get the item this offset refers to.
		          fto = ep.getLine(endLine).getItemFromOffset(ep.getLine(endLine).getParagraphOffset - endOffset)
		          
		          ' Did we get something?
		          if not (fto is nil) then
		            
		            ' Is it a picture or custom object, then select it.
		            if fto.isMonolithic then endOffset = endOffset + 1
		            
		          end if
		          
		        end if
		        
		        ' Are we in the same paragraph?
		      elseif startParagraph = endParagraph then
		        
		        ' Do we need to flip on the same line?
		        if (startLine = endLine) and (endOffset < startOffset) then
		          
		          ' Swap the endpoints.
		          temp = startOffset
		          startOffset = endOffset
		          endOffset = temp
		          
		          ' Flip to the left side.
		          anchor = AnchorTag.LEFT_SIDE
		          
		          ' Do we need to flip?
		        elseif endLine < startLine then
		          
		          ' Swap the endpoints.
		          temp = startOffset
		          startOffset = endOffset
		          endOffset = temp
		          
		          ' Flip to the left side.
		          anchor = AnchorTag.LEFT_SIDE
		          
		        end if
		        
		      end if
		      
		    end if
		    
		  end if
		  
		  '--------------------------------------------
		  ' Clean up.
		  '--------------------------------------------
		  
		  ' Set the selection range.
		  selectStart.set(startParagraph, Max(startOffset, 0))
		  selectEnd.set(endParagraph, endOffset)
		  
		  ' Return the selection flag.
		  return addToSelectionCheck(startParagraph, startOffset, _
		  endParagraph, endOffset, insertionPoint.getCaretOffset)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function addToSelectionByLineRangeCheck(ByRef paragraph as integer, ByRef line as integer) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim changed as boolean
		  
		  ' Are we past the end of the paragraph?
		  if line > (getParagraph(paragraph).getLineCount - 1) then
		    
		    ' Are we before the last paragraph in the document?
		    if paragraph < (getParagraphCount - 1) then
		      
		      ' Move the beginning of the next paragraph.
		      paragraph = paragraph + 1
		      line = 0
		      
		      ' The paragraph will change.
		      changed = true
		      
		    else
		      
		      ' Move to the end of the document.
		      paragraph = getParagraphCount - 1
		      line = getParagraph(paragraph).getLineCount
		      
		    end if
		    
		    ' Are we moving to the previous paragraph?
		  elseif line < 0 then
		    
		    ' Can we back up a paragraph?
		    if paragraph > 0 then
		      
		      ' Go to the previous paragraph.
		      paragraph = paragraph - 1
		      line = getParagraph(paragraph).getLineCount - 1
		      
		      ' The paragraph will change.
		      changed = true
		      
		    else
		      
		      ' Move to the beginning of the document.
		      paragraph = 0
		      line = -1
		      
		    end if
		    
		  end if
		  
		  ' Has the paragraph changed?
		  return changed
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function addToSelectionCheck(startParagraph as integer, startOffset as integer, endParagraph as integer, endOffset as integer, caretOffset as double) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim selectionFlag as boolean
		  
		  ' Have we deselected everything?
		  if (startParagraph = endParagraph) and (startOffset = endOffset) then
		    
		    ' Clear the selection.
		    deselectAll
		    
		    ' Set the insertion point.
		    setInsertionPoint(startParagraph, startOffset, false)
		    
		    ' Set the bias.
		    getInsertionPoint.setBias(caretOffset = 0)
		    
		    ' Clear the anchor.
		    anchor = AnchorTag.NONE
		    
		  else
		    
		    ' We will be selecting something.
		    selectionFlag = true
		    
		  end if
		  
		  ' Return the selection flag.
		  return selectionFlag
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub adjustClippingPage()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim scale as double
		  Dim pWidth as integer
		  Dim pHeight as integer
		  
		  ' Are we in page view mode?
		  if parentControl.isPageViewMode then
		    
		    ' Get the scale
		    scale = parentControl.getScale
		    
		    // Correct for scale-down
		    if scale < 1 then scale = 1
		    
		    ' Get the current dimensions
		    pWidth = Floor(getPageWidthLength * scale)
		    pHeight = Floor(getPageHeightLength * scale)
		    
		    ' Has the page been allocated at all?
		    if clippingPage is nil then
		      
		      ' Create the clipping page.
		      clippingPage = new picture(Max(pWidth, 1), Max(pHeight, 1), parentControl.BIT_DEPTH)
		      
		    else
		      
		      ' Has the dimensions changed?
		      if (clippingPage.Width <> pWidth) or (clippingPage.Height <> pHeight) then
		        
		        ' Create the clipping page.
		        clippingPage = new picture(Max(pWidth, 1), Max(pHeight, 1), parentControl.BIT_DEPTH)
		        
		      end if
		      
		    end if
		    
		  else
		    
		    ' Are we down scaling?
		    if parentControl.getScale < 1.0 then
		      
		      ' Get the scale.
		      scale = parentControl.getScale
		      
		    else
		      
		      ' Use the normal scale.
		      scale = 1.0
		      
		    end if
		    
		    ' Has the page been allocated at all?
		    if clippingPage is nil then
		      
		      ' Create the clipping page.
		      clippingPage = new picture(Max(parentControl.getDisplayWidth / scale, 1), _
		      Max(parentControl.getDisplayHeight / scale, 1), parentControl.BIT_DEPTH)
		      
		    else
		      
		      ' Has the dimensions changed?
		      if (clippingPage.Width <> (parentControl.getDisplayWidth * scale)) or _
		        (clippingPage.Height <> (parentControl.getDisplayHeight * scale)) then
		        
		        ' Create the clipping page.
		        clippingPage = new picture(Max(parentControl.getDisplayWidth / scale, 1), _
		        Max(parentControl.getDisplayHeight / scale, 1), parentControl.BIT_DEPTH)
		        
		      end if
		      
		    end if
		    
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
		  
		  Dim p as FTParagraph
		  
		  ' Get the last paragraph.
		  p = paragraphs(Ubound(paragraphs))
		  
		  ' Set the insertion point to the end.
		  setInsertionPoint(Ubound(paragraphs), p.getLength, false)
		  
		  ' Copy over the content.
		  insertXml(target.getDoc.getXML, true, true)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub appendXML(sXML as String)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim p as FTParagraph
		  
		  ' Get the last paragraph.
		  p = paragraphs(Ubound(paragraphs))
		  
		  ' Set the insertion point to the end.
		  setInsertionPoint(Ubound(paragraphs), p.getLength, false)
		  
		  ' Copy over the content.
		  insertXml(sXML, true, true)
		  
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
		  Dim lastPageNumber as integer
		  Dim delta as integer
		  Dim p as FTParagraph
		  
		  '-----------------------------------------
		  ' Paragraphs.
		  '-----------------------------------------
		  
		  ' Get the number of paragraphs.
		  count = Ubound(paragraphs)
		  
		  ' Audit the paragraphs.
		  for i = 0 to count
		    
		    ' Get the paragraph.
		    p = paragraphs(i)
		    
		    ' Check the paragraph.
		    p.audit
		    
		    ' Is the absolute index correct?
		    if p.getAbsoluteIndex <> i then break
		    
		    ' Calculate the change in the page number.
		    delta = p.getProxyItem(0).getPage - lastPageNumber
		    
		    ' Did we skip a page?
		    if (delta < 0) or (delta > 1) then break
		    
		    ' Save the current page.
		    lastPageNumber = p.getProxyItem(p.getProxyItemCount - 1).getPage
		    
		  next
		  
		  '-----------------------------------------
		  ' Pages.
		  '-----------------------------------------
		  
		  ' Get the number of pages.
		  count = Ubound(pages)
		  
		  ' Audit the paragraphs.
		  for i = 0 to count
		    
		    ' Check the paragraph.
		    pages(i).audit
		    
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub blinkCaret(state as boolean)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the current on/off state.
		  insertionPoint.setCaretState(state)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub callXMLItemFromAttributeList(attributeList as XmlAttributeList)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  LoadXMLItemFromAttributeList attributeList
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeBackgroundColor(startPosition as FTInsertionOffset, endPosition as FTInsertionOffset)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim index as integer
		  Dim startId as integer
		  Dim sp as FTParagraph
		  Dim ep as FTParagraph
		  
		  ' Get the paragraph information.
		  sp = getParagraph(startPosition.paragraph)
		  ep = getParagraph(endPosition.paragraph)
		  
		  ' Are we within range?
		  if (sp is nil) or (ep is nil) then return
		  
		  ' Is this the same paragraph?
		  if sp.getId = ep.getId then
		    
		    ' Change the color of the paragraph.
		    sp.changeBackgroundColor(startPosition.offset + 1, endPosition.offset)
		    
		  else
		    
		    ' Get the starting paragraph ID.
		    startId = sp.getId
		    
		    ' Get the first full paragraph index.
		    index = ep.getAbsoluteIndex - 1
		    
		    ' Delete the full paragraphs.
		    for i = index downto 0
		      
		      ' Are we at the end?
		      if paragraphs(i).getId = startId then
		        
		        ' We are done.
		        exit
		        
		      end if
		      
		      ' Change the color of the paragraph.
		      paragraphs(i).changeBackgroundColor
		      
		    next
		    
		    ' Change the color from the first paragraph.
		    sp.changeBackgroundColor(startPosition.offset + 1, sp.getLength)
		    
		    ' Change the color from the last paragraph.
		    ep.changeBackgroundColor(1, endPosition.offset)
		    
		  end if
		  
		  ' Make sure the selection is correct.
		  reselect
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeBackgroundColor(startPosition as FTInsertionOffset, endPosition as FTInsertionOffset, c as Color)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim index as integer
		  Dim startId as integer
		  Dim sp as FTParagraph
		  Dim ep as FTParagraph
		  
		  ' Get the paragraph information.
		  sp = getParagraph(startPosition.paragraph)
		  ep = getParagraph(endPosition.paragraph)
		  
		  ' Are we within range?
		  if (sp is nil) or (ep is nil) then return
		  
		  ' Is this the same paragraph?
		  if sp.getId = ep.getId then
		    
		    ' Change the color of the paragraph.
		    sp.changeBackgroundColor(startPosition.offset + 1, endPosition.offset, c)
		    
		  else
		    
		    ' Get the starting paragraph ID.
		    startId = sp.getId
		    
		    ' Get the first full paragraph index.
		    index = ep.getAbsoluteIndex - 1
		    
		    ' Delete the full paragraphs.
		    for i = index downto 0
		      
		      ' Are we at the end?
		      if paragraphs(i).getId = startId then
		        
		        ' We are done.
		        exit
		        
		      end if
		      
		      ' Change the color of the paragraph.
		      paragraphs(i).changeBackgroundColor(c)
		      
		    next
		    
		    '----------------
		    
		    ' Is whole first paragraph selected?
		    if startPosition.offset = 0 then
		      
		      ' Change the size of the entire first paragraph.
		      sp.changeBackgroundColor(c)
		      
		    else
		      
		      ' Change the size of the first paragraph.
		      sp.changeBackgroundColor(startPosition.offset + 1, sp.getLength, c)
		      
		    end if
		    
		    '----------------
		    
		    ' Is whole last paragraph selected?
		    if endPosition.offset >= ep.getLength then
		      
		      ' Change the size of the entire last paragraph.
		      ep.changeBackgroundColor(c)
		      
		    else
		      
		      ' Change the size of the last paragraph.
		      ep.changeBackgroundColor(0, endPosition.offset, c)
		      
		    end if
		    
		  end if
		  
		  ' Make sure the selection is correct.
		  reselect
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeBoldStyle(startPosition as FTInsertionOffset, endPosition as FTInsertionOffset, value as boolean)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Change the bold style of the text.
		  changeStyle(startPosition, endPosition, FTStyle.STYLE_BOLD, value)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeCharacterSpacing(spacing as integer, startPosition as FTInsertionOffset, endPosition as FTInsertionOffset)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim index as integer
		  Dim startId as integer
		  Dim sp as FTParagraph
		  Dim ep as FTParagraph
		  
		  ' Get the paragraph information.
		  sp = getParagraph(startPosition.paragraph)
		  ep = getParagraph(endPosition.paragraph)
		  
		  ' Are we within range?
		  if (sp is nil) or (ep is nil) then return
		  
		  ' Is this the same paragraph?
		  if sp.getId = ep.getId then
		    
		    ' Change the style of the paragraph.
		    sp.changeCharacterSpacing(startPosition.offset + 1, endPosition.offset, spacing)
		    
		  else
		    
		    ' Get the starting paragraph ID.
		    startId = sp.getId
		    
		    ' Get the first full paragraph index.
		    index = ep.getAbsoluteIndex - 1
		    
		    ' Delete the full paragraphs.
		    for i = index downto 0
		      
		      ' Are we at the end?
		      if paragraphs(i).getId = startId then
		        
		        ' We are done.
		        exit
		        
		      end if
		      
		      ' Change the character spacing of the paragraph.
		      paragraphs(i).changeCharacterSpacing(spacing)
		      
		    next
		    
		    '----------------
		    
		    ' Is whole first paragraph selected?
		    if startPosition.offset = 0 then
		      
		      ' Change the character spacing of the entire first paragraph.
		      sp.changeCharacterSpacing(spacing)
		      
		    else
		      
		      ' Change the character spacing of the first paragraph.
		      sp.changeCharacterSpacing(startPosition.offset + 1, sp.getLength, spacing)
		      
		    end if
		    
		    '----------------
		    
		    ' Is whole last paragraph selected?
		    if endPosition.offset >= ep.getLength then
		      
		      ' Change the character spacing of the entire last paragraph.
		      ep.changeCharacterSpacing(spacing)
		      
		    else
		      
		      ' Change the character spacing of the last paragraph.
		      ep.changeCharacterSpacing(0, endPosition.offset, spacing)
		      
		    end if
		    
		  end if
		  
		  ' Make sure the selection is correct.
		  reselect
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeCharacterStyle(startPosition as FTInsertionOffset, endPosition as FTInsertionOffset, styleId as integer)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim index as integer
		  Dim startId as integer
		  Dim sp as FTParagraph
		  Dim ep as FTParagraph
		  
		  ' Get the paragraph information.
		  sp = getParagraph(startPosition.paragraph)
		  ep = getParagraph(endPosition.paragraph)
		  
		  ' Are we within range?
		  if (sp is nil) or (ep is nil) then return
		  
		  ' Is this the same paragraph?
		  if sp.getId = ep.getId then
		    
		    ' Change the character style of the paragraph.
		    sp.changeCharacterStyle(startPosition.offset + 1, endPosition.offset, styleId)
		    
		  else
		    
		    ' Get the starting paragraph ID.
		    startId = sp.getId
		    
		    ' Get the first full paragraph index.
		    index = ep.getAbsoluteIndex - 1
		    
		    ' Delete the full paragraphs.
		    for i = index downto 0
		      
		      ' Are we at the end?
		      if paragraphs(i).getId = startId then
		        
		        ' We are done.
		        exit
		        
		      end if
		      
		      ' Change the character style of the paragraph.
		      paragraphs(i).changeCharacterStyle(styleId)
		      
		    next
		    
		    '----------------
		    
		    ' Is whole first paragraph selected?
		    if startPosition.offset = 0 then
		      
		      ' Change the character style of the entire first paragraph.
		      sp.changeCharacterStyle(styleId)
		      
		    else
		      
		      ' Change the character style of the first paragraph.
		      sp.changeCharacterStyle(startPosition.offset + 1, sp.getLength, styleId)
		      
		    end if
		    
		    '----------------
		    
		    ' Is whole last paragraph selected?
		    if endPosition.offset >= ep.getLength then
		      
		      ' Change the character style of the entire last paragraph.
		      ep.changeCharacterStyle(styleId)
		      
		    else
		      
		      ' Change the character style of the last paragraph.
		      ep.changeCharacterStyle(0, endPosition.offset, styleId)
		      
		    end if
		    
		  end if
		  
		  ' Make sure the selection is correct.
		  reselect
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeFont(fontName as string, startPosition as FTInsertionOffset, endPosition as FTInsertionOffset)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim index as integer
		  Dim startId as integer
		  Dim sp as FTParagraph
		  Dim ep as FTParagraph
		  
		  ' Get the paragraph information.
		  sp = getParagraph(startPosition.paragraph)
		  ep = getParagraph(endPosition.paragraph)
		  
		  ' Are we within range?
		  if (sp is nil) or (ep is nil) then return
		  
		  ' Is this the same paragraph?
		  if sp.getId = ep.getId then
		    
		    ' Change the font of the paragraph.
		    sp.changeFont(startPosition.offset + 1, endPosition.offset, fontName)
		    
		  else
		    
		    ' Get the starting paragraph ID.
		    startId = sp.getId
		    
		    ' Get the first full paragraph index.
		    index = ep.getAbsoluteIndex - 1
		    
		    ' Delete the full paragraphs.
		    for i = index downto 0
		      
		      ' Are we at the end?
		      if paragraphs(i).getId = startId then
		        
		        ' We are done.
		        exit
		        
		      end if
		      
		      ' Change the font of the paragraph.
		      paragraphs(i).changeFont(fontName)
		      
		    next
		    
		    '----------------
		    
		    ' Is whole first paragraph selected?
		    if startPosition.offset = 0 then
		      
		      ' Change the font of the entire first paragraph.
		      sp.changeFont(fontName)
		      
		    else
		      
		      ' Change the font of the first paragraph.
		      sp.changeFont(startPosition.offset + 1, sp.getLength, fontName)
		      
		    end if
		    
		    '----------------
		    
		    ' Is whole last paragraph selected?
		    if endPosition.offset >= ep.getLength then
		      
		      ' Change the font of the entire last paragraph.
		      ep.changeFont(fontName)
		      
		    else
		      
		      ' Change the font of the last paragraph.
		      ep.changeFont(0, endPosition.offset, fontName)
		      
		    end if
		    
		  end if
		  
		  ' Make sure the selection is correct.
		  reselect
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ChangeHyperLink(startPosition as FTInsertionOffset, endPosition as FTInsertionOffset, hyperlink As String, newWindow as Boolean)
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim index as integer
		  Dim startId as integer
		  Dim sp as FTParagraph
		  Dim ep as FTParagraph
		  
		  ' Get the paragraph information.
		  sp = getParagraph(startPosition.paragraph)
		  ep = getParagraph(endPosition.paragraph)
		  
		  ' Are we within range?
		  if (sp is nil) or (ep is nil) then return
		  
		  ' Is this the same paragraph?
		  if sp.getId = ep.getId then
		    
		    ' Change the hyperlink of the paragraph.
		    sp.ChangeHyperLink(startPosition.offset + 1, endPosition.offset, hyperlink,newWindow)
		    
		  else
		    
		    ' Get the starting paragraph ID.
		    startId = sp.getId
		    
		    ' Get the first full paragraph index.
		    index = ep.getAbsoluteIndex - 1
		    
		    ' Delete the full paragraphs.
		    for i = index downto 0
		      
		      ' Are we at the end?
		      if paragraphs(i).getId = startId then
		        
		        ' We are done.
		        exit
		        
		      end if
		      
		      ' Change the hyperlink of the paragraph.
		      paragraphs(i).ChangeHyperLink(hyperlink,newWindow)
		      
		    next
		    
		    '----------------
		    
		    ' Is whole first paragraph selected?
		    if startPosition.offset = 0 then
		      
		      ' Change the hyperlink of the entire first paragraph.
		      sp.ChangeHyperLink(hyperlink,newWindow)
		      
		    else
		      
		      ' Change the hyperlink of the first paragraph.
		      sp.ChangeHyperLink(startPosition.offset + 1, sp.getLength, hyperlink,newWindow)
		      
		    end if
		    
		    '----------------
		    
		    ' Is whole last paragraph selected?
		    if endPosition.offset >= ep.getLength then
		      
		      ' Change the hyperlink of the entire last paragraph.
		      ep.ChangeHyperLink(hyperlink,newWindow)
		      
		    else
		      
		      ' Change the hyperlink of the last paragraph.
		      ep.ChangeHyperLink(0, endPosition.offset, hyperlink,newWindow)
		      
		    end if
		    
		  end if
		  
		  ' Make sure the selection is correct.
		  reselect
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ChangeHyperLinkColor(startPosition as FTInsertionOffset, endPosition as FTInsertionOffset, hyperlinkColor As Color, hyperlinkColorRollover As Color, hyperlinkColorVisited As Color, hyperlinkColorDisabled As Color, ulNormal As Boolean, ulRollover As Boolean, ulVisited as Boolean, ulDisabled as Boolean)
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim index as integer
		  Dim startId as integer
		  Dim sp as FTParagraph
		  Dim ep as FTParagraph
		  
		  ' Get the paragraph information.
		  sp = getParagraph(startPosition.paragraph)
		  ep = getParagraph(endPosition.paragraph)
		  
		  ' Are we within range?
		  if (sp is nil) or (ep is nil) then return
		  
		  ' Is this the same paragraph?
		  if sp.getId = ep.getId then
		    
		    ' Change the hyperlink of the paragraph.
		    sp.ChangeHyperLinkColor(startPosition.offset + 1, endPosition.offset,hyperlinkColor, hyperlinkColorRollover, hyperlinkColorVisited, hyperlinkColorDisabled,ulNormal , ulRollover , ulVisited , ulDisabled)
		    
		    
		  else
		    
		    ' Get the starting paragraph ID.
		    startId = sp.getId
		    
		    ' Get the first full paragraph index.
		    index = ep.getAbsoluteIndex - 1
		    
		    ' Delete the full paragraphs.
		    for i = index downto 0
		      
		      ' Are we at the end?
		      if paragraphs(i).getId = startId then
		        
		        ' We are done.
		        exit
		        
		      end if
		      
		      ' Change the hyperlink of the paragraph.
		      paragraphs(i).ChangeHyperLinkColor(hyperlinkColor, hyperlinkColorRollover, hyperlinkColorVisited, hyperlinkColorDisabled,ulNormal , ulRollover , ulVisited , ulDisabled)
		      
		    next
		    
		    '----------------
		    
		    ' Is whole first paragraph selected?
		    if startPosition.offset = 0 then
		      
		      ' Change the hyperlink of the entire first paragraph.
		      sp.ChangeHyperLinkColor(hyperlinkColor, hyperlinkColorRollover, hyperlinkColorVisited, hyperlinkColorDisabled,ulNormal , ulRollover , ulVisited , ulDisabled)
		      
		    else
		      
		      ' Change the hyperlink of the first paragraph.
		      sp.ChangeHyperLinkColor(startPosition.offset + 1, endPosition.offset,hyperlinkColor, hyperlinkColorRollover, hyperlinkColorVisited, hyperlinkColorDisabled,ulNormal , ulRollover , ulVisited , ulDisabled)
		      
		      
		    end if
		    
		    '----------------
		    
		    ' Is whole last paragraph selected?
		    if endPosition.offset >= ep.getLength then
		      
		      ' Change the hyperlink of the entire last paragraph.
		      ep.ChangeHyperLinkColor(hyperlinkColor, hyperlinkColorRollover, hyperlinkColorVisited, hyperlinkColorDisabled,ulNormal , ulRollover , ulVisited , ulDisabled)
		      
		    else
		      
		      ' Change the hyperlink of the last paragraph.
		      ep.ChangeHyperLinkColor(hyperlinkColor, hyperlinkColorRollover, hyperlinkColorVisited, hyperlinkColorDisabled,ulNormal , ulRollover , ulVisited , ulDisabled)
		      
		    end if
		    
		  end if
		  
		  ' Make sure the selection is correct.
		  reselect
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeItalicStyle(startPosition as FTInsertionOffset, endPosition as FTInsertionOffset, value as boolean)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Change the italic style of the text.
		  changeStyle(startPosition, endPosition, FTStyle.STYLE_ITALIC, value)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeMark(startPosition as FTInsertionOffset, endPosition as FTInsertionOffset)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim index as integer
		  Dim startId as integer
		  Dim sp as FTParagraph
		  Dim ep as FTParagraph
		  
		  ' Get the paragraph information.
		  sp = getParagraph(startPosition.paragraph)
		  ep = getParagraph(endPosition.paragraph)
		  
		  ' Are we within range?
		  if (sp is nil) or (ep is nil) then return
		  
		  ' Is this the same paragraph?
		  if sp.getId = ep.getId then
		    
		    ' Change the mark of the paragraph.
		    sp.changeMark(startPosition.offset + 1, endPosition.offset)
		    
		  else
		    
		    ' Get the starting paragraph ID.
		    startId = sp.getId
		    
		    ' Get the first full paragraph index.
		    index = ep.getAbsoluteIndex - 1
		    
		    ' Delete the full paragraphs.
		    for i = index downto 0
		      
		      ' Are we at the end?
		      if paragraphs(i).getId = startId then
		        
		        ' We are done.
		        exit
		        
		      end if
		      
		      ' Change the mark of the paragraph.
		      paragraphs(i).changeMark
		      
		    next
		    
		    '----------------
		    
		    ' Is whole first paragraph selected?
		    if startPosition.offset = 0 then
		      
		      ' Change the mark of the entire first paragraph.
		      sp.changeMark
		      
		    else
		      
		      ' Change the mark of the first paragraph.
		      sp.changeMark(startPosition.offset + 1, sp.getLength)
		      
		    end if
		    
		    '----------------
		    
		    ' Is whole last paragraph selected?
		    if endPosition.offset >= ep.getLength then
		      
		      ' Change the mark of the entire last paragraph.
		      ep.changeMark
		      
		    else
		      
		      ' Change the mark of the last paragraph.
		      ep.changeMark(0, endPosition.offset)
		      
		    end if
		    
		  end if
		  
		  ' Make sure the selection is correct.
		  reselect
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeMark(startPosition as FTInsertionOffset, endPosition as FTInsertionOffset, c as Color)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim index as integer
		  Dim startId as integer
		  Dim sp as FTParagraph
		  Dim ep as FTParagraph
		  
		  ' Get the paragraph information.
		  sp = getParagraph(startPosition.paragraph)
		  ep = getParagraph(endPosition.paragraph)
		  
		  ' Are we within range?
		  if (sp is nil) or (ep is nil) then return
		  
		  ' Is this the same paragraph?
		  if sp.getId = ep.getId then
		    
		    ' Change the mark of the paragraph.
		    sp.changeMark(startPosition.offset + 1, endPosition.offset, c)
		    
		  else
		    
		    ' Get the starting paragraph ID.
		    startId = sp.getId
		    
		    ' Get the first full paragraph index.
		    index = ep.getAbsoluteIndex - 1
		    
		    ' Delete the full paragraphs.
		    for i = index downto 0
		      
		      ' Are we at the end?
		      if paragraphs(i).getId = startId then
		        
		        ' We are done.
		        exit
		        
		      end if
		      
		      ' Change the mark of the paragraph.
		      paragraphs(i).changeMark(c)
		      
		    next
		    
		    '----------------
		    
		    ' Is whole first paragraph selected?
		    if startPosition.offset = 0 then
		      
		      ' Change the mark of the entire first paragraph.
		      sp.changeMark(c)
		      
		    else
		      
		      ' Change the mark of the first paragraph.
		      sp.changeMark(startPosition.offset + 1, sp.getLength, c)
		      
		    end if
		    
		    '----------------
		    
		    ' Is whole last paragraph selected?
		    if endPosition.offset >= ep.getLength then
		      
		      ' Change the mark of the entire last paragraph.
		      ep.changeMark(c)
		      
		    else
		      
		      ' Change the mark of the last paragraph.
		      ep.changeMark(0, endPosition.offset, c)
		      
		    end if
		    
		  end if
		  
		  ' Make sure the selection is correct.
		  reselect
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeOpacity(opacity as double, startPosition as FTInsertionOffset, endPosition as FTInsertionOffset)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim index as integer
		  Dim startId as integer
		  Dim sp as FTParagraph
		  Dim ep as FTParagraph
		  
		  ' Get the paragraph information.
		  sp = getParagraph(startPosition.paragraph)
		  ep = getParagraph(endPosition.paragraph)
		  
		  ' Are we within range?
		  if (sp is nil) or (ep is nil) then return
		  
		  ' Is this the same paragraph?
		  if sp.getId = ep.getId then
		    
		    ' Change the style of the paragraph.
		    sp.ChangeOpacity(startPosition.offset + 1, endPosition.offset, opacity)
		    
		  else
		    
		    ' Get the starting paragraph ID.
		    startId = sp.getId
		    
		    ' Get the first full paragraph index.
		    index = ep.getAbsoluteIndex - 1
		    
		    ' Delete the full paragraphs.
		    for i = index downto 0
		      
		      ' Are we at the end?
		      if paragraphs(i).getId = startId then
		        
		        ' We are done.
		        exit
		        
		      end if
		      
		      ' Change the font size of the paragraph.
		      paragraphs(i).ChangeOpacity(opacity)
		      
		    next
		    
		    '----------------
		    
		    ' Is whole first paragraph selected?
		    if startPosition.offset = 0 then
		      
		      ' Change the size of the entire first paragraph.
		      sp.ChangeOpacity(opacity)
		      
		    else
		      
		      ' Change the size of the first paragraph.
		      sp.ChangeOpacity(startPosition.offset + 1, sp.getLength, opacity)
		      
		    end if
		    
		    '----------------
		    
		    ' Is whole last paragraph selected?
		    if endPosition.offset >= ep.getLength then
		      
		      ' Change the size of the entire last paragraph.
		      ep.ChangeOpacity(opacity)
		      
		    else
		      
		      ' Change the size of the last paragraph.
		      ep.ChangeOpacity(0, endPosition.offset, opacity)
		      
		    end if
		    
		  end if
		  
		  ' Make sure the selection is correct.
		  reselect
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeParagraphBackgroundColor(startPosition as FTInsertionOffset, endPosition as FTInsertionOffset)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  
		  ' Change the selected paragraphs.
		  for i = startPosition.paragraph to endPosition.paragraph
		    
		    ' Set the background color for the paragraph.
		    getParagraph(i).setBackgroundColor
		    
		  next
		  
		  ' Make sure the selection is correct.
		  reselect
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeParagraphBackgroundColor(startPosition as FTInsertionOffset, endPosition as FTInsertionOffset, c as Color)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  
		  ' Change the selected paragraphs.
		  for i = startPosition.paragraph to endPosition.paragraph
		    
		    ' Set the background color for the paragraph.
		    getParagraph(i).setBackgroundColor(c)
		    
		  next
		  
		  ' Make sure the selection is correct.
		  reselect
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changePlainStyle(startPosition as FTInsertionOffset, endPosition as FTInsertionOffset, value as boolean)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Remove any styling.
		  changeStyle(startPosition, endPosition, FTStyle.STYLE_PLAIN, value)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ChangeShadow(hasShadow as Boolean, shadowColor as Color, ShadowOffset as Double, ShadowBlur as Double, ShadowOpacity as Double, shadowAngle as Double, startPosition as FTInsertionOffset, endPosition as FTInsertionOffset)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim index as integer
		  Dim startId as integer
		  Dim sp as FTParagraph
		  Dim ep as FTParagraph
		  
		  ' Get the paragraph information.
		  sp = getParagraph(startPosition.paragraph)
		  ep = getParagraph(endPosition.paragraph)
		  
		  ' Are we within range?
		  if (sp is nil) or (ep is nil) then return
		  
		  ' Is this the same paragraph?
		  if sp.getId = ep.getId then
		    
		    ' Change the style of the paragraph.
		    sp.ChangeShadow(startPosition.offset + 1, endPosition.offset, hasShadow,shadowColor,ShadowOffset,ShadowBlur,ShadowOpacity,shadowAngle)
		    
		  else
		    
		    ' Get the starting paragraph ID.
		    startId = sp.getId
		    
		    ' Get the first full paragraph index.
		    index = ep.getAbsoluteIndex - 1
		    
		    ' Delete the full paragraphs.
		    for i = index downto 0
		      
		      ' Are we at the end?
		      if paragraphs(i).getId = startId then
		        
		        ' We are done.
		        exit
		        
		      end if
		      
		      ' Change the font size of the paragraph.
		      paragraphs(i).ChangeShadow(hasShadow,shadowColor,ShadowOffset,ShadowBlur,ShadowOpacity,shadowAngle)
		      
		    next
		    
		    '----------------
		    
		    ' Is whole first paragraph selected?
		    if startPosition.offset = 0 then
		      
		      ' Change the size of the entire first paragraph.
		      sp.ChangeShadow(hasShadow,shadowColor,ShadowOffset,ShadowBlur,ShadowOpacity,shadowAngle)
		      
		    else
		      
		      ' Change the size of the first paragraph.
		      sp.ChangeShadow(startPosition.offset + 1, sp.getLength, hasShadow,shadowColor,ShadowOffset,ShadowBlur,ShadowOpacity,shadowAngle)
		      
		    end if
		    
		    '----------------
		    
		    ' Is whole last paragraph selected?
		    if endPosition.offset >= ep.getLength then
		      
		      ' Change the size of the entire last paragraph.
		      ep.ChangeShadow(hasShadow,shadowColor,ShadowOffset,ShadowBlur,ShadowOpacity,shadowAngle)
		      
		    else
		      
		      ' Change the size of the last paragraph.
		      ep.ChangeShadow(0, endPosition.offset, hasShadow,shadowColor,ShadowOffset,ShadowBlur,ShadowOpacity,shadowAngle)
		      
		    end if
		    
		  end if
		  
		  ' Make sure the selection is correct.
		  reselect
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeSize(size as integer, startPosition as FTInsertionOffset, endPosition as FTInsertionOffset)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim index as integer
		  Dim startId as integer
		  Dim sp as FTParagraph
		  Dim ep as FTParagraph
		  
		  ' Get the paragraph information.
		  sp = getParagraph(startPosition.paragraph)
		  ep = getParagraph(endPosition.paragraph)
		  
		  ' Are we within range?
		  if (sp is nil) or (ep is nil) then return
		  
		  ' Is this the same paragraph?
		  if sp.getId = ep.getId then
		    
		    ' Change the style of the paragraph.
		    sp.changeSize(startPosition.offset + 1, endPosition.offset, size)
		    
		  else
		    
		    ' Get the starting paragraph ID.
		    startId = sp.getId
		    
		    ' Get the first full paragraph index.
		    index = ep.getAbsoluteIndex - 1
		    
		    ' Delete the full paragraphs.
		    for i = index downto 0
		      
		      ' Are we at the end?
		      if paragraphs(i).getId = startId then
		        
		        ' We are done.
		        exit
		        
		      end if
		      
		      ' Change the font size of the paragraph.
		      paragraphs(i).changeSize(size)
		      
		    next
		    
		    '----------------
		    
		    ' Is whole first paragraph selected?
		    if startPosition.offset = 0 then
		      
		      ' Change the size of the entire first paragraph.
		      sp.changeSize(size)
		      
		    else
		      
		      ' Change the size of the first paragraph.
		      sp.changeSize(startPosition.offset + 1, sp.getLength, size)
		      
		    end if
		    
		    '----------------
		    
		    ' Is whole last paragraph selected?
		    if endPosition.offset >= ep.getLength then
		      
		      ' Change the size of the entire last paragraph.
		      ep.changeSize(size)
		      
		    else
		      
		      ' Change the size of the last paragraph.
		      ep.changeSize(0, endPosition.offset, size)
		      
		    end if
		    
		  end if
		  
		  ' Make sure the selection is correct.
		  reselect
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeStrikeThrough(startPosition as FTInsertionOffset, endPosition as FTInsertionOffset, value as boolean)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Change the strike through style of the text.
		  changeStyle(startPosition, endPosition, FTStyle.STYLE_STRIKE_THROUGH, value)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub changeStyle(startPosition as FTInsertionOffset, endPosition as FTInsertionOffset, style as integer, value as boolean)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim index as integer
		  Dim startId as integer
		  Dim sp as FTParagraph
		  Dim ep as FTParagraph
		  
		  ' Get the paragraph information.
		  sp = getParagraph(startPosition.paragraph)
		  ep = getParagraph(endPosition.paragraph)
		  
		  ' Are we within range?
		  if (sp is nil) or (ep is nil) then return
		  
		  ' Is this the same paragraph?
		  if sp.getId = ep.getId then
		    
		    ' Change the style of the paragraph.
		    sp.changeStyle(startPosition.offset + 1, endPosition.offset, style, value)
		    
		  else
		    
		    ' Get the starting paragraph ID.
		    startId = sp.getId
		    
		    ' Get the first full paragraph index.
		    index = ep.getAbsoluteIndex - 1
		    
		    ' Delete the full paragraphs.
		    for i = index downto 0
		      
		      ' Are we at the end?
		      if paragraphs(i).getId = startId then
		        
		        ' We are done.
		        exit
		        
		      end if
		      
		      ' Change the style of the paragraph.
		      paragraphs(i).changeStyle(style, value)
		      
		    next
		    
		    '----------------
		    
		    ' Is whole first paragraph selected?
		    if startPosition.offset = 0 then
		      
		      ' Change the style of the entire first paragraph.
		      sp.changeStyle(style, value)
		      
		    else
		      
		      ' Change the style of the first paragraph.
		      sp.changeStyle(startPosition.offset + 1, sp.getLength, style, value)
		      
		    end if
		    
		    '----------------
		    
		    ' Is whole last paragraph selected?
		    if endPosition.offset >= ep.getLength then
		      
		      ' Change the style of the entire last paragraph.
		      ep.changeStyle(style, value)
		      
		    else
		      
		      ' Change the style of the last paragraph.
		      ep.changeStyle(0, endPosition.offset, style, value)
		      
		    end if
		    
		  end if
		  
		  ' Make sure the selection is correct.
		  reselect
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeSubscript(startPosition as FTInsertionOffset, endPosition as FTInsertionOffset, value as boolean)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Change the sub script style of the text.
		  changeStyle(startPosition, endPosition, FTStyle.SUB_SCRIPT, value)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeSuperscript(startPosition as FTInsertionOffset, endPosition as FTInsertionOffset, value as boolean)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Change the super script style of the text.
		  changeStyle(startPosition, endPosition, FTStyle.SUPER_SCRIPT, value)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeTextColor(startPosition as FTInsertionOffset, endPosition as FTInsertionOffset, c as Color)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim index as integer
		  Dim startId as integer
		  Dim sp as FTParagraph
		  Dim ep as FTParagraph
		  
		  ' Get the paragraph information.
		  sp = getParagraph(startPosition.paragraph)
		  ep = getParagraph(endPosition.paragraph)
		  
		  ' Are we within range?
		  if (sp is nil) or (ep is nil) then return
		  
		  ' Is this the same paragraph?
		  if sp.getId = ep.getId then
		    
		    ' Change the text color of the paragraph.
		    sp.changeColor(startPosition.offset + 1, endPosition.offset, c)
		    
		  else
		    
		    ' Get the starting paragraph ID.
		    startId = sp.getId
		    
		    ' Get the first full paragraph index.
		    index = ep.getAbsoluteIndex - 1
		    
		    ' Delete the full paragraphs.
		    for i = index downto 0
		      
		      ' Are we at the end?
		      if paragraphs(i).getId = startId then
		        
		        ' We are done.
		        exit
		        
		      end if
		      
		      ' Change the text color of the paragraph.
		      paragraphs(i).changeColor(c)
		      
		    next
		    
		    '----------------
		    
		    ' Is whole first paragraph selected?
		    if startPosition.offset = 0 then
		      
		      ' Change the text color of the entire first paragraph.
		      sp.changeColor(c)
		      
		    else
		      
		      ' Change the text color of the first paragraph.
		      sp.changeColor(startPosition.offset + 1, sp.getLength, c)
		      
		    end if
		    
		    '----------------
		    
		    ' Is whole last paragraph selected?
		    if endPosition.offset >= ep.getLength then
		      
		      ' Change the text color of the entire last paragraph.
		      ep.changeColor(c)
		      
		    else
		      
		      ' Change the text color of the last paragraph.
		      ep.changeColor(0, endPosition.offset, c)
		      
		    end if
		    
		  end if
		  
		  ' Make sure the selection is correct.
		  reselect
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeToLowerCase(startPosition as FTInsertionOffset, endPosition as FTInsertionOffset)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim index as integer
		  Dim startId as integer
		  Dim sp as FTParagraph
		  Dim ep as FTParagraph
		  
		  ' Get the paragraph information.
		  sp = getParagraph(startPosition.paragraph)
		  ep = getParagraph(endPosition.paragraph)
		  
		  ' Are we within range?
		  if (sp is nil) or (ep is nil) then return
		  
		  ' Is this the same paragraph?
		  if sp.getId = ep.getId then
		    
		    ' Change to lower case.
		    sp.changeToLowerCase(startPosition.offset + 1, endPosition.offset)
		    
		  else
		    
		    ' Get the starting paragraph ID.
		    startId = sp.getId
		    
		    ' Get the first full paragraph index.
		    index = ep.getAbsoluteIndex - 1
		    
		    ' Delete the full paragraphs.
		    for i = index downto 0
		      
		      ' Are we at the end?
		      if paragraphs(i).getId = startId then
		        
		        ' We are done.
		        exit
		        
		      end if
		      
		      ' Change to lower case the paragraph.
		      paragraphs(i).changeToLowerCase
		      
		    next
		    
		    '----------------
		    
		    ' Is whole first paragraph selected?
		    if startPosition.offset = 0 then
		      
		      ' Change to lower case the entire first paragraph.
		      sp.changeToLowerCase
		      
		    else
		      
		      ' Change to lower case the first paragraph.
		      sp.changeToLowerCase(startPosition.offset + 1, sp.getLength)
		      
		    end if
		    
		    '----------------
		    
		    ' Is whole last paragraph selected?
		    if endPosition.offset >= ep.getLength then
		      
		      ' Change to lower case of the entire last paragraph.
		      ep.changeToLowerCase
		      
		    else
		      
		      ' Change to lower case the last paragraph.
		      ep.changeToLowerCase(0, endPosition.offset)
		      
		    end if
		    
		  end if
		  
		  ' Make sure the selection is correct.
		  reselect
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeToTitleCase(startPosition as FTInsertionOffset, endPosition as FTInsertionOffset)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim index as integer
		  Dim startId as integer
		  Dim sp as FTParagraph
		  Dim ep as FTParagraph
		  
		  ' Get the paragraph information.
		  sp = getParagraph(startPosition.paragraph)
		  ep = getParagraph(endPosition.paragraph)
		  
		  ' Are we within range?
		  if (sp is nil) or (ep is nil) then return
		  
		  ' Is this the same paragraph?
		  if sp.getId = ep.getId then
		    
		    ' Change to title case.
		    sp.changeToTitleCase(startPosition.offset + 1, endPosition.offset)
		    
		  else
		    
		    ' Get the starting paragraph ID.
		    startId = sp.getId
		    
		    ' Get the first full paragraph index.
		    index = ep.getAbsoluteIndex - 1
		    
		    ' Delete the full paragraphs.
		    for i = index downto 0
		      
		      ' Are we at the end?
		      if paragraphs(i).getId = startId then
		        
		        ' We are done.
		        exit
		        
		      end if
		      
		      ' Change to title case the paragraph.
		      paragraphs(i).changeToTitleCase
		      
		    next
		    
		    '----------------
		    
		    ' Is whole first paragraph selected?
		    if startPosition.offset = 0 then
		      
		      ' Change to title case the entire first paragraph.
		      sp.changeToTitleCase
		      
		    else
		      
		      ' Change to title case the first paragraph.
		      sp.changeToTitleCase(startPosition.offset + 1, sp.getLength)
		      
		    end if
		    
		    '----------------
		    
		    ' Is whole last paragraph selected?
		    if endPosition.offset >= ep.getLength then
		      
		      ' Change to title case of the entire last paragraph.
		      ep.changeToTitleCase
		      
		    else
		      
		      ' Change to title case the last paragraph.
		      ep.changeToTitleCase(0, endPosition.offset)
		      
		    end if
		    
		  end if
		  
		  ' Make sure the selection is correct.
		  reselect
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeToUpperCase(startPosition as FTInsertionOffset, endPosition as FTInsertionOffset)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim index as integer
		  Dim startId as integer
		  Dim sp as FTParagraph
		  Dim ep as FTParagraph
		  
		  ' Get the paragraph information.
		  sp = getParagraph(startPosition.paragraph)
		  ep = getParagraph(endPosition.paragraph)
		  
		  ' Are we within range?
		  if (sp is nil) or (ep is nil) then return
		  
		  ' Is this the same paragraph?
		  if sp.getId = ep.getId then
		    
		    ' Change to upper case.
		    sp.changeToUpperCase(startPosition.offset + 1, endPosition.offset)
		    
		  else
		    
		    ' Get the starting paragraph ID.
		    startId = sp.getId
		    
		    ' Get the first full paragraph index.
		    index = ep.getAbsoluteIndex - 1
		    
		    ' Delete the full paragraphs.
		    for i = index downto 0
		      
		      ' Are we at the end?
		      if paragraphs(i).getId = startId then
		        
		        ' We are done.
		        exit
		        
		      end if
		      
		      ' Change to upper case the paragraph.
		      paragraphs(i).changeToUpperCase
		      
		    next
		    
		    '----------------
		    
		    ' Is whole first paragraph selected?
		    if startPosition.offset = 0 then
		      
		      ' Change to upper case the entire first paragraph.
		      sp.changeToUpperCase
		      
		    else
		      
		      ' Change to upper case the first paragraph.
		      sp.changeToUpperCase(startPosition.offset + 1, sp.getLength)
		      
		    end if
		    
		    '----------------
		    
		    ' Is whole last paragraph selected?
		    if endPosition.offset >= ep.getLength then
		      
		      ' Change to upper case of the entire last paragraph.
		      ep.changeToUpperCase
		      
		    else
		      
		      ' Change to upper case the last paragraph.
		      ep.changeToUpperCase(0, endPosition.offset)
		      
		    end if
		    
		  end if
		  
		  ' Make sure the selection is correct.
		  reselect
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeUnderlineStyle(startPosition as FTInsertionOffset, endPosition as FTInsertionOffset, value as boolean)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Change the underline style of the text.
		  changeStyle(startPosition, endPosition, FTStyle.STYLE_UNDERLINE, value)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub checkFirstParagraph()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Is there anything to look at?
		  if Ubound(paragraphs) > -1 then
		    
		    ' Are we starting with a page break?
		    if paragraphs(0).getPageBreak then
		      
		      ' Insert a blank paragraph at the beginning.
		      call insertNewParagraph
		      
		      ' Reset the dirty indexes.
		      markAllParagraphsDirty
		      
		    end if
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub checkPicture(pic as FTPicture)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim maxWidth as integer
		  Dim maxHeight as integer
		  Dim picWidth as integer
		  Dim picHeight as integer
		  
		  ' Did the subclass handle the image?
		  if parentControl.checkPicture(pic) then return
		  
		  ' Compute the maximum dimensions.
		  maxWidth = FTUtilities.getScaledLength(docMargins.pageWidth - margins.rightMargin - margins.leftMargin, 1.0)
		  maxHeight = FTUtilities.getScaledLength(docMargins.pageHeight - margins.bottomMargin - margins.topMargin, 1.0)
		  
		  ' Get the picture dimensions.
		  picWidth = pic.getWidth(1.0)
		  picHeight = pic.getHeight(1.0)
		  
		  ' Is there any thing to do?
		  if (picWidth <= maxWidth) and (picHeight <= maxHeight) then return
		  
		  ' Scale the picture to fit.
		  pic.scalePicture(min(maxWidth / picWidth, maxHeight / picHeight))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub checkPictureSizes()
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim p as FTParagraph
		  
		  ' Scan each paragraph for oversize pictures.
		  for each p in paragraphs
		    
		    ' Check the pictures in the paragraph.
		    p.checkPictureSizes
		    
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub checkSpelling(background as boolean = true)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim p as FTParagraph
		  
		  ' Should we perform the spell check in the background?
		  if background then
		    
		    ' Start a spell check run.
		    spellCheckTimer.restart
		    
		  else
		    
		    ' Check all the paragraphs.
		    for each p in paragraphs
		      
		      ' Spell check the paragraph.
		      p.spellCheckParagraph
		      
		    next
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub clearCharacterStyles()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Clear out the old character styles.
		  characterStyles.Clear
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub clearDirtyParagraphs()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Clear the dirty indexes.
		  dirtyIndexes.Clear
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub clearMisspelledIndicators()
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim p as FTParagraph
		  
		  ' Clear all the proxies.
		  for each p in paragraphs
		    
		    ' Clear the proxies.
		    p.clearMisspelledIndicators
		    
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub clearPages()
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim page as FTPage
		  
		  ' Clear all the pages.
		  for each page in pages
		    
		    ' Clear the page.
		    page.clear
		    
		  next
		  
		  ' Clear all the pages.
		  Redim pages(-1)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub clearParagraphProxies()
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim para as FTParagraph
		  
		  ' Clear all the proxies.
		  for each para in paragraphs
		    
		    ' Clear the proxies.
		    para.clearProxies
		    
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub clearParagraphs()
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim para as FTParagraph
		  
		  ' Clear all the proxies.
		  for each para in paragraphs
		    
		    ' Clear the proxies.
		    para.clear
		    
		  next
		  
		  ' Clear out all of the paragraphs.
		  Redim paragraphs(-1)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub clearParagraphStyles()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Clear out the old paragraph styles.
		  paragraphStyles.Clear
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub clearResizePicture()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Clear the resize data.
		  resizePicture = nil
		  resizeParagraph = nil
		  resizeHandle = FTPicture.Handle_Type.None
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function clone(parentControl as FormattedText) As FTDocument
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim ftd as FTDocument
		  
		  ' Create the document.
		  ftd = new FTDocument(parentControl, parentControl.backgroundColor)
		  
		  ' Clear out all of the paragraphs.
		  ftd.clearParagraphs
		  
		  ' Get the number of paragraphs.
		  count = Ubound(paragraphs)
		  
		  ' Clone all the paragraphs.
		  for i = 0 to count
		    
		    ' Make a clone of the paragraph.
		    ftd.paragraphs.append(paragraphs(i).clone)
		    
		  next
		  
		  ' Return the clone.
		  return ftd
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub combineParagraphs(index as integer)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  
		  ' Get the number of paragraphs.
		  count = Ubound(paragraphs)
		  
		  ' Is there anything to do?
		  if index > (count - 1) then return
		  
		  ' Combine the paragraphs.
		  paragraphs(index).addParagraph(paragraphs(index + 1))
		  
		  ' Remove the next paragraph from the list.
		  removeParagraph(index + 1)
		  
		  ' Adjust the indexes
		  index = index + 1
		  count = count - 1
		  
		  ' Update the indexes.
		  for i = index to count
		    
		    ' Change the index of the paragraph.
		    paragraphs(i).setAbsoluteIndex(i)
		    
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub compose()
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim pageCount as integer
		  Dim currentScale as double
		  Dim height as double
		  
		  '-------------------------------------------------
		  ' Compose the pages.
		  '-------------------------------------------------
		  
		  ' Get the current count of pages.
		  pageCount = Ubound(pages)
		  
		  ' Save the current scale.
		  currentScale = parentControl.getScale
		  
		  ' Set the scale to 100%.
		  parentControl.setScale(1.0, false)
		  
		  ' Are we in the normal view mode?
		  if not parentControl.isPageViewMode then
		    
		    ' Compose the single page.
		    composeNormalViewPages
		    
		    ' Reset the scale.
		    parentControl.setScale(currentScale, false)
		    
		    ' Compute the positions.
		    height = pages(0).computePositions
		    
		    ' Set the page length.
		    setNormalViewLength(height / MonitorPixelsPerInch)
		    
		  else
		    
		    ' Compose the pages.
		    composePageViewPages
		    
		    ' Reset the scale.
		    parentControl.setScale(currentScale, false)
		    
		  end if
		  
		  '--------------------------------------------
		  ' Refresh the background.
		  '--------------------------------------------
		  
		  ' Has the page count changed?
		  if pageCount <> Ubound(pages) then
		    
		    ' We need to redraw the background.
		    parentControl.invalidateBackground
		    
		  end if
		  
		  '--------------------------------------------
		  ' Set the insertion point.
		  '--------------------------------------------
		  
		  ' Has the insertion point been set?
		  if insertionPoint.getCurrentParagraph is nil then
		    
		    ' Use the first paragraph.
		    insertionPoint.setInsertionPoint(paragraphs(0), 0, true)
		    
		  end if
		  
		  ' Make sure the insertion point is set up properly.
		  insertionPoint.findProxy
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub composeNormalPages()
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim paragraphCount as integer
		  Dim page as FTPage
		  
		  '---------------------------------------------
		  ' Set up the first page.
		  '---------------------------------------------
		  
		  ' Clear the existing pages.
		  Redim pages(-1)
		  
		  ' Create the page.
		  page = new FTPage(parentControl)
		  
		  ' Add the page to the list.
		  pages.Append(page)
		  
		  ' Set the page number.
		  page.setAbsolutePage(0)
		  
		  '---------------------------------------------
		  ' Add in all the proxies.
		  '---------------------------------------------
		  
		  ' Get the number of paragraphs.
		  paragraphCount = Ubound(paragraphs)
		  
		  ' Create the pages.
		  for i = 0 to paragraphCount
		    
		    ' Add the proxy.
		    page.addParagraph(paragraphs(i).getProxyItem(0))
		    
		  next
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub composeNormalProxies(startParagraph as integer, endParagraph as integer)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  
		  ' Go through all the paragraphs.
		  for i = startParagraph to endParagraph
		    
		    ' Add a full proxy to the paragraph.
		    paragraphs(i).addFullProxy(0, -1)
		    
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub composeNormalViewPages()
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim startParagraph as integer
		  Dim endParagraph as integer
		  Dim fullCompose as boolean
		  
		  ' Is there any thing to do?
		  if dirtyIndexes.Count = 0 then return
		  
		  ' Compose the paragraphs.
		  composeParagraphs(startParagraph, endParagraph, fullCompose)
		  
		  ' Compose the proxies.
		  composeNormalProxies(startParagraph, endParagraph)
		  
		  ' Compose the pages.
		  composeNormalPages
		  
		  #if DebugBuild
		    
		    ' Audit the data structures.
		    parentControl.audit
		    
		  #endif
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub composePagePages(startPage as integer, endPage as integer, fullCompose as boolean)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim j as integer
		  Dim count as integer
		  Dim paragraphCount as integer
		  Dim startParagraph as integer
		  Dim index as integer
		  Dim proxyCount as integer
		  Dim page as FTPage
		  Dim p as FTParagraph
		  Dim pp as FTParagraphProxy
		  Dim pageIndex as integer
		  
		  '---------------------------------------------
		  ' Set up the first page.
		  '---------------------------------------------
		  
		  ' Get the number of paragraphs.
		  paragraphCount = Ubound(paragraphs)
		  
		  ' Find the starting paragraph.
		  startParagraph = findStartParagraph(startPage)
		  
		  ' Do we need to create a new page?
		  if startPage > Ubound(pages) then
		    
		    ' Create the page.
		    page = new FTPage(parentControl)
		    
		    ' Add the page to the list.
		    pages.Append(page)
		    
		    ' Get the page index.
		    pageIndex = Ubound(pages)
		    
		    ' Set the page number.
		    page.setAbsolutePage(pageIndex)
		    
		  else
		    
		    ' Get the page.
		    page = pages(startPage)
		    
		    ' Clear the page.
		    page.clear
		    
		    ' Set the page index.
		    pageIndex = startPage
		    
		  end if
		  
		  '---------------------------------------------
		  ' Add in all the proxies.
		  '---------------------------------------------
		  
		  ' Create the pages.
		  for i = startParagraph to paragraphCount
		    
		    ' Get the paragraph.
		    p = paragraphs(i)
		    
		    ' Get the number of proxies.
		    proxyCount = p.getProxyItemCount - 1
		    
		    ' Go through the proxies.
		    for j = 0 to proxyCount
		      
		      ' Get the proxy.
		      pp = p.getProxyItem(j)
		      
		      ' Get the page index for the proxy.
		      index = pp.getAbsolutePage
		      
		      ' Does it go on this page?
		      if index = pageIndex then
		        
		        ' Add the proxy.
		        page.addParagraph(pp)
		        
		      else
		        
		        ' Is this the next page?
		        if index > pageIndex then
		          
		          ' Do we need to create a new page?
		          if index > Ubound(pages) then
		            
		            ' Create the page.
		            page = new FTPage(parentControl)
		            
		            ' Add the page to the list.
		            pages.Append(page)
		            
		            ' Move the page index.
		            pageIndex = Ubound(pages)
		            
		            ' Set the page number.
		            page.setAbsolutePage(pageIndex)
		            
		          else
		            
		            ' Are we done?
		            if (index > endPage) and (not fullCompose) then exit
		            
		            ' Move the page index.
		            pageIndex = index
		            
		            ' Get the page.
		            page = pages(pageIndex)
		            
		            ' Clear the page.
		            page.clear
		            
		          end if
		          
		          ' Add the proxy.
		          page.addParagraph(pp)
		          
		        end if
		        
		      end if
		      
		    next
		    
		  next
		  
		  '---------------------------------------------
		  ' Clean up empty pages.
		  '---------------------------------------------
		  
		  ' Get the last paragraph.
		  p = paragraphs(paragraphCount)
		  
		  ' Get the number of proxy items.
		  count = p.getProxyItemCount - 1
		  
		  ' Is there anything to do?
		  if count > -1 then
		    
		    ' Determine the last page to remove.
		    pageIndex = p.getProxyItem(count).getPage + 1
		    
		    ' Get the number of pages.
		    count = Ubound(pages)
		    
		    ' Delete empty pages.
		    for i = count downto pageIndex
		      
		      ' Clear the page.
		      pages(i).clear
		      
		      ' Delete the page.
		      pages.remove(i)
		      
		    next
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub composePageProxies(startParagraph as integer, endParagraph as integer, fullCompose as boolean)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim startLine as integer
		  Dim endLine as integer
		  Dim pageIndex as integer
		  Dim pageHeight as double
		  Dim paragraphHeight as double
		  Dim currentHeight as double
		  Dim p as FTParagraph
		  Dim pp as FTParagraphProxy
		  Dim beforeSpace as boolean
		  Dim position as double
		  
		  ' Get the display height.
		  pageHeight = FTUtilities.getScaledLength(getMarginHeight)
		  
		  ' Get the number of paragraphs.
		  count = Ubound(paragraphs)
		  
		  ' Do we need to do a full compse to the end?
		  if fullCompose then
		    
		    ' Compose to the end.
		    endParagraph = count
		    
		  end if
		  
		  ' Are we at the beginning?
		  if startParagraph = 0 then
		    
		    ' Set it to match the beginning.
		    pageIndex = 0
		    beforeSpace = false
		    currentHeight = 0
		    
		  else
		    
		    ' Get the previous paragraph.
		    p = paragraphs(startParagraph - 1)
		    
		    ' Get the last proxy from that paragraph.
		    pp = p.getProxyItem(p.getProxyItemCount - 1)
		    
		    ' Set the page number.
		    pageIndex = pp.getPage
		    
		    ' Get the compose position.
		    position = pp.getComposePosition
		    
		    ' Should we use the before space?
		    beforeSpace = (position > 0)
		    
		    ' Calculate the current height.
		    currentHeight = position + pp.getHeight(beforeSpace, 1.0)
		    
		  end if
		  
		  ' Go through all the paragraphs and rebuild the proxies.
		  for i = startParagraph to endParagraph
		    
		    ' Get the paragraph.
		    p = paragraphs(i)
		    
		    ' Clear the proxies.
		    p.clearProxies
		    
		    ' Add the page break.
		    if p.getPageBreak then
		      
		      ' Move to the next page.
		      pageIndex = pageIndex + 1
		      
		      ' Turn off before space.
		      beforeSpace = false
		      
		      ' Reset the height.
		      currentHeight = 0
		      
		    else
		      
		      ' Turn on before space.
		      beforeSpace = true
		      
		    end if
		    
		    ' Get the height of the paragraph.
		    paragraphHeight = p.getHeight(beforeSpace)
		    
		    ' Does it fit on the page?
		    if (currentHeight + paragraphHeight) > pageHeight then
		      
		      ' Get the lines that will fit.
		      if p.getProxyLines(pageHeight - currentHeight, startLine, endLine, true) then
		        
		        ' Add the partial proxy.
		        p.addPartialProxy(pageIndex, startLine, endLine, currentHeight)
		        
		        ' Are there more pages to add?
		        while p.getProxyLines(pageHeight, startLine, endLine, false)
		          
		          ' Move to the next page.
		          pageIndex = pageIndex + 1
		          
		          ' Add the partial proxy.
		          p.addPartialProxy(pageIndex, startLine, endLine, 0)
		          
		        wend
		        
		        ' Reset the height.
		        currentHeight = p.getProxyItem(p.getProxyItemCount - 1).getHeight(false, 1.0)
		        
		        ' Turn on before space.
		        beforeSpace = true
		        
		      else
		        
		        ' Reset the height.
		        currentHeight = 0
		        
		        ' Move to the next page.
		        pageIndex = pageIndex + 1
		        
		        ' Turn off before space.
		        beforeSpace = false
		        
		        ' Is this line to tall to fit on a page?
		        if not p.getProxyLines(pageHeight, startLine, endLine, true) then
		          
		          ' Add the line anyways.
		          p.addPartialProxy(pageIndex, startLine, startLine, currentHeight)
		          
		          ' Move to the next page.
		          pageIndex = pageIndex + 1
		          
		        else
		          
		          ' Stay on the same paragraph.
		          i = i - 1
		          
		        end if
		        
		      end if
		      
		    else
		      
		      ' Add a full proxy to the page.
		      p.addFullProxy(pageIndex, currentHeight)
		      
		      ' Update the height.
		      currentHeight = currentHeight + paragraphHeight
		      
		      ' Use the before space.
		      beforeSpace = true
		      
		    end if
		    
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub composePageViewPages()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim startParagraph as integer
		  Dim endParagraph as integer
		  Dim fullCompose as boolean
		  
		  ' Are we processing deleted text situation?
		  if allPagesDirty then
		    
		    ' Clear the flag.
		    allPagesDirty = false
		    
		    ' Is there any thing to do?
		    if dirtyIndexes.Count > 0 then
		      
		      ' Compose the paragraphs.
		      composeParagraphs(startParagraph, endParagraph, fullCompose)
		      
		    end if
		    
		    ' Set indexes.
		    endParagraph = Ubound(paragraphs)
		    fullCompose = true
		    
		    ' Compose the proxies.
		    composePageProxies(startParagraph, endParagraph, fullCompose)
		    
		    ' Compose the pages.
		    composePagePages(Max(paragraphs(startParagraph).getFirstProxyPage - 2, 0), _
		    paragraphs(endParagraph).getLastProxyPage + 2, fullCompose)
		    
		  else
		    
		    ' Is there any thing to do?
		    if dirtyIndexes.Count = 0 then return
		    
		    ' Compose the paragraphs.
		    composeParagraphs(startParagraph, endParagraph, fullCompose)
		    
		    ' Compose the proxies.
		    composePageProxies(startParagraph, endParagraph, fullCompose)
		    
		    ' Compose the pages.
		    composePagePages(Max(paragraphs(startParagraph).getFirstProxyPage - 2, 0), _
		    paragraphs(endParagraph).getLastProxyPage + 2, fullCompose)
		    
		  end if
		  
		  #if DebugBuild
		    
		    ' Audit the data structures.
		    parentControl.audit
		    
		  #endif
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub composeParagraphs(ByRef startParagraph as integer, ByRef endParagraph as integer, ByRef fullCompose as boolean)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim indexMax as integer
		  Dim keys() as Variant
		  Dim p as FTParagraph
		  Dim index as integer
		  Dim lineCount as integer
		  Dim paragraphHeight as double
		  
		  const MAX_PARAGRAPH = 2147483647
		  
		  ' Assume we don't need to do a full compose.
		  fullCompose = false
		  
		  ' Check the first paragraph for a page break.
		  checkFirstParagraph
		  
		  ' Get the number of paragraphs to compose.
		  count = dirtyIndexes.count - 1
		  
		  ' Get the maximum number of paragraphs.
		  indexMax = Ubound(paragraphs)
		  
		  ' Get the keys.
		  keys = dirtyIndexes.Keys
		  
		  ' Set the bounds.
		  startParagraph = MAX_PARAGRAPH
		  endParagraph = -1
		  
		  ' Reformat all the paragraphs.
		  for i = 0 to count
		    
		    ' Are we in range?
		    if keys(i) <= indexMax then
		      
		      ' Get the paragraph.
		      p = paragraphs(keys(i))
		      
		      ' Get the number of lines.
		      lineCount = p.getLineCount
		      
		      ' Get the current paragraph height.
		      paragraphHeight = p.getHeight(true)
		      
		      ' Reformat the paragraph.
		      p.composeLines
		      
		      ' Did the height of the paragraph change?
		      if (lineCount <> p.getLineCount) or _
		      (paragraphHeight <> p.getHeight(true)) then fullCompose = true
		      
		      ' Get the index of the paragraph.
		      index = p.getAbsoluteIndex
		      
		      ' Is this the first paragraph?
		      if index < startParagraph then
		        
		        ' Save the index.
		        startParagraph = index
		        
		      end if
		      
		      ' Is this the first paragraph?
		      if index > endParagraph then
		        
		        ' Save the index.
		        endParagraph = index
		        
		      end if
		      
		    end if
		    
		  next
		  
		  ' Clear the stack.
		  dirtyIndexes.Clear
		  
		  ' Check the range.
		  if startParagraph = MAX_PARAGRAPH then startParagraph = 0
		  if endParagraph = -1 then endParagraph = startParagraph
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub composePartial()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim ignore as integer
		  Dim fullCompose as boolean
		  
		  ' Compose the dirty paragrphs.
		  composeParagraphs(ignore, ignore, fullCompose)
		  
		  ' Compose the proxies.
		  composePageProxies(0, Ubound(paragraphs), fullCompose)
		  
		  ' Compose the pages.
		  composePagePages(0, paragraphs(Ubound(paragraphs)).getLastProxyPage, fullCompose)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub computeBorderColors(backgroundColor as Color)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim colorStep as double
		  
		  const COLOR_STEP = 0.125
		  
		  //added Opacity for smoother gradient"
		  Dim myColor As Color
		  myColor = RGB(backgroundColor.Red + 39, backgroundColor.Green + 39, backgroundColor.Blue + 39)
		  
		  ' Create the gradient colors.
		  For i = 0 To 6
		    
		    ' Compute the color step.
		    colorStep = (i + 1) * COLOR_STEP
		    
		    ' Save the color.
		    borderColors(i) = RGB(myColor.Red * colorStep, _
		    myColor.Green * colorStep, _
		    myColor.Blue * colorStep, 172)
		    
		  Next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(parentControl as FormattedText, backgroundColor as Color)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Create the dirty index holder.
		  dirtyIndexes = new Dictionary
		  
		  ' Save the parent control reference.
		  super.Constructor(parentControl)
		  
		  ' Create the selection indicators.
		  selectStart = newInsertionOffset(0, 0)
		  selectEnd = newInsertionOffset(0, 0)
		  selectStart.clear
		  selectEnd.clear
		  
		  ' Create the containers for the styles.
		  paragraphStyles = new Dictionary
		  characterStyles = new Dictionary
		  
		  ' Create the default style.
		  defaultParagraphStyle = createDefaultParagraphStyle
		  
		  ' Allocate the insertion point data.
		  insertionPoint = new FTInsertionPoint(parentControl, self, true)
		  
		  ' Create the border colors.
		  computeBorderColors(backgroundColor)
		  
		  ' Set the default for the screen resolution.
		  setMonitorPixelsPerInch(parentControl.GetMonitorPixelsPerInch)
		  
		  ' Set the default page dimensions in inches.
		  setPageSize(8.5, 11.0)
		  
		  ' Set the default values.
		  margins.leftMargin = 1.0
		  margins.topMargin = 1.0
		  margins.rightMargin = 1.0
		  margins.bottomMargin = 1.0
		  
		  ' Set the default space between pages.
		  setPageSpace(10)
		  
		  ' Set the default background color.
		  setPageBackgroundColor
		  
		  ' Create the threads.
		  startThreads
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub copyStyleAtInsertion(obj as FTStyleRun)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Does it exist?
		  if not (insertionPoint.getCurrentParagraph is nil) then
		    
		    ' Copy the style at the insertion point.
		    insertionPoint.getCurrentParagraph.copyStyleAtOffset(insertionPoint.getOffset.offset, obj)
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function createDefaultParagraphStyle() As FTParagraphStyle
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim ps as FTParagraphStyle
		  
		  ' Get the user defined style.
		  ps = parentControl.callDefaultParagraphStyle
		  
		  ' Did the user give us one?
		  if ps is nil then
		    
		    ' Create the style.
		    ps = new FTParagraphStyle(parentControl, "")
		    
		    ' Set the default font characteristics.
		    ps.setFontName(parentControl.DefaultFont)
		    ps.setFontSize(parentControl.DefaultFontSize)
		    ps.setTextColor(parentControl.DefaultTextColor)
		    
		    ' Set the default after space.
		    ps.setAfterSpace(0.15)
		    
		  end if
		  
		  ' Set the default ID.
		  ps.setId(0)
		  
		  ' Return the style.
		  return ps
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub createXmlDocument(ByRef xmlDoc as XmlDocument, ByRef root as XmlElement)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim item as XmlElement
		  
		  '--------------------------------------------------
		  ' Create the document.
		  '--------------------------------------------------
		  
		  ' Create the XML document.
		  xmlDoc = new XmlDocument
		  
		  ' Create the root node.
		  root = XmlElement(xmlDoc.AppendChild(xmlDoc.CreateElement(FTCxml.XML_ROOT)))
		  
		  '--------------------------------------------------
		  ' Version.
		  '--------------------------------------------------
		  
		  ' Create the version element.
		  item = XmlElement(root.AppendChild(xmlDoc.CreateElement(FTCxml.XML_VERSION)))
		  getXMLVersionAttributes(item)
		  
		  '--------------------------------------------------
		  ' Document.
		  '--------------------------------------------------
		  
		  ' Create the document element.
		  item = XmlElement(root.AppendChild(xmlDoc.CreateElement(FTCxml.XML_FTDOCUMENT)))
		  getXMLDocumentAttributes(item)
		  
		  '--------------------------------------------------
		  ' Styles.
		  '--------------------------------------------------
		  
		  ' Create the paragraph styles element.
		  item = XmlElement(root.AppendChild(xmlDoc.CreateElement(FTCxml.XML_PARAGRAPH_STYLES)))
		  getXMLParagraphStyleAttributes(xmlDoc, item)
		  
		  ' Create the character styles element.
		  item = XmlElement(root.AppendChild(xmlDoc.CreateElement(FTCxml.XML_CHARACTER_STYLES)))
		  getXMLCharacterStyleAttributes(xmlDoc, item)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub deleteAll()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Clear any selection.
		  deselectAll
		  
		  ' Clear the dirty indicators.
		  dirtyIndexes.Clear
		  
		  ' Clear the resize data.
		  clearResizePicture
		  
		  ' Release the paragraphs.
		  clearParagraphs
		  
		  ' Clear the items.
		  clearPages
		  
		  ' Add a new page.
		  call addNewPage(0)
		  
		  ' Add a starter paragraph.
		  call addNewParagraph
		  
		  ' Compose the paragraphs.
		  compose
		  
		  ' Reset the caret position.
		  resetInsertionCaret
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function deleteCharacter(forwards as boolean, ByRef target as FTParagraph) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim cp as FTParagraph
		  Dim targetParagraph as FTParagraph
		  Dim caretPosition as integer
		  Dim paragraphDelete as boolean
		  Dim offset as integer
		  Dim length as integer
		  
		  ' Make sure it is cleared.
		  target = nil
		  
		  ' Get the current paragraph.
		  cp = insertionPoint.getCurrentParagraph
		  
		  ' Is there something to insert into?
		  if not (cp is nil) then
		    
		    ' Get the current measurements.
		    offset = insertionPoint.getOffset.offset
		    length = cp.getLength
		    
		    ' Should we do a forwards delete?
		    if forwards then
		      
		      '----------------------------------------------
		      ' Forward delete
		      '----------------------------------------------
		      
		      ' Are we at the end of the paragraph?
		      if (offset >= length) and (not isInResizeMode) then
		        
		        ' Find the next paragraph.
		        targetParagraph = getNextParagraph(cp.getAbsoluteIndex)
		        
		        ' Is there anything to combine?
		        if targetParagraph is nil then return false
		        
		        ' Make an empty copy.
		        target = new FTParagraph(parentControl, -1, targetParagraph)
		        
		        ' Combine the paragraphs.
		        cp.addParagraph(targetParagraph)
		        
		        ' Delete the target paragraph.
		        deleteParagraph(targetParagraph.getId)
		        
		        ' We deleted a paragraph.
		        paragraphDelete = true
		        
		      else
		        
		        ' Are we deleting a picture that is in resize mode?
		        if isInResizeMode then
		          
		          ' Delete the picture.
		          cp.deleteCharacter(getResizePicture.getStartPosition)
		          
		          ' Move the insertion point.
		          insertionPoint.setInsertionPoint(insertionPoint.getOffset - 1, true)
		          
		        else
		          
		          ' Delete the text.
		          cp.deleteCharacter(offset + 1)
		          
		        end if
		        
		      end if
		      
		    else
		      
		      '----------------------------------------------
		      ' Backspace
		      '----------------------------------------------
		      
		      ' Should we combine paragraphs?
		      if (offset = 0) and (not isInResizeMode) then
		        
		        ' Get the previous paragraph.
		        targetParagraph = getPreviousParagraph(cp.getAbsoluteIndex)
		        
		        ' Is there anything to combine?
		        if targetParagraph is nil then return false
		        
		        ' Get the new insertion position.
		        caretPosition = targetParagraph.getLength
		        
		        ' Make an empty copy.
		        target = new FTParagraph(parentControl, -1, cp)
		        
		        ' Combine the paragraphs.
		        targetParagraph.addParagraph(cp)
		        
		        ' Delete the original paragraph.
		        deleteParagraph(cp.getId)
		        
		        ' We deleted a paragraph.
		        paragraphDelete = true
		        
		        ' Move the insertion point.
		        insertionPoint.setInsertionPoint(targetParagraph, caretPosition, true)
		        
		      else
		        
		        ' Are we deleting a picture that is in resize mode?
		        if isInResizeMode then
		          
		          ' Delete the picture.
		          cp.deleteCharacter(getResizePicture.getStartPosition)
		          
		        else
		          
		          ' Delete the text.
		          cp.deleteCharacter(offset)
		          
		        end if
		        
		        ' Move the insertion point.
		        insertionPoint.setInsertionPoint(cp, offset - 1, true)
		        
		      end if
		      
		    end if
		    
		  end if
		  
		  ' Return the paragraph delete state.
		  return paragraphDelete
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DeleteCharacterStyle(pName As String)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' delete the style.
		  Var cs As FTCharacterStyle = getCharacterStyle(pName)
		  
		  If characterStyles.HasKey(cs.getId) Then
		    characterStyles.Remove(cs.getId) 
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub deleteParagraph(id as integer)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim j as integer
		  Dim count as integer
		  Dim p as FTParagraph
		  
		  ' Get the number of paragraphs.
		  count = Ubound(paragraphs)
		  
		  ' Scan the paragraphs.
		  for i = 0 to count
		    
		    ' Get the paragraph.
		    p = paragraphs(i)
		    
		    ' Is this the one we are looking for?
		    if p.getId = id then
		      
		      ' Delete the paragraph.
		      removeParagraph(i)
		      
		      ' Get the number of paragraphs.
		      count = Ubound(paragraphs)
		      
		      ' Update the indexes.
		      for j = i to count
		        
		        ' Change the index of the paragraph.
		        paragraphs(j).setAbsoluteIndex(j)
		        
		      next
		      
		      ' We are done.
		      return
		      
		    end if
		    
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub deleteSegment(startPosition as FTInsertionOffset, endPosition as FTInsertionOffset)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim index as integer
		  Dim startId as integer
		  Dim sp as FTParagraph
		  Dim ep as FTParagraph
		  
		  ' Is there anything to do?
		  if (startPosition is nil) or (endPosition is nil) then return
		  
		  ' Get the paragraph information.
		  sp = getParagraph(startPosition.paragraph)
		  ep = getParagraph(endPosition.paragraph)
		  
		  ' Are we within range?
		  if (sp is nil) or (ep is nil) then return
		  
		  ' Is this the same paragraph?
		  if sp.getId = ep.getId then
		    
		    ' Delete the text from the paragraph.
		    sp.deleteSegment(startPosition.offset + 1, endPosition.offset)
		    
		  else
		    
		    ' Get the starting paragraph ID.
		    startId = sp.getId
		    
		    ' Get the first full paragraph index.
		    index = ep.getAbsoluteIndex - 1
		    
		    ' Delete the full paragraphs.
		    for i = index downto 0
		      
		      ' Are we at the end?
		      if paragraphs(i).getId = startId then
		        
		        ' We are done.
		        exit
		        
		      end if
		      
		      ' Delete the paragraph.
		      removeParagraph(i)
		      
		    next
		    
		    ' Delete the text from the first paragraph.
		    sp.deleteSegment(startPosition.offset + 1, sp.getLength)
		    
		    ' Delete the text from the last paragraph.
		    ep.deleteSegment(1, endPosition.offset)
		    
		    ' Is there something to add?
		    if ep.getLength > 0 then
		      
		      ' Add the paragraph.
		      sp.addParagraph(ep)
		      
		    end if
		    
		    ' Delete the last paragraph.
		    deleteParagraph(ep.getId)
		    
		  end if
		  
		  ' Mark it for an update.
		  sp.makeDirty
		  
		  ' Clean up the paragraph.
		  sp.optimizeParagraph
		  
		  ' Reset the dirty indexes.
		  scanForDirtyParagraphs
		  
		  ' Make sure the pages get reformatted.
		  markAllPagesDirty
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub deleteSelected()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim startOffset as FTInsertionOffset
		  Dim endOffset as FTInsertionOffset
		  Dim caretOffset as FTInsertionOffset
		  
		  ' Is anything selected?
		  if not isSelected then return
		  
		  ' Get the selection range.
		  getSelectionRange(startOffset, endOffset)
		  
		  ' Make a copy of the insertion point.
		  caretOffset = startOffset.clone
		  
		  ' Is just the pilcrow selected?
		  if startOffset.offset > startOffset.getParagraph.getLength then
		    
		    ' Move back to a valid insertion point.
		    caretOffset.offset = Max(caretOffset.offset - 1, 0)
		    
		  end if
		  
		  ' Delete the text.
		  deleteSegment(startOffset, endOffset)
		  
		  ' Clear the selection.
		  deselectAll
		  
		  ' Clear the resize picture.
		  setResizePicture
		  
		  ' Set the insertion point.
		  setInsertionPoint(caretOffset, false)
		  
		  ' Recompose the paragraphs.
		  compose
		  
		  ' Make sure the pages get reformatted.
		  markAllPagesDirty
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub deselectAll()
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim io as FTInsertionOffset
		  
		  ' Is there something to deselect?
		  if not isSelected then return
		  
		  ' Get the current insertion point.
		  io = getInsertionOffset
		  
		  ' Reset the internal variables.
		  setSelectionRange
		  
		  ' Restore the insertion point.
		  setInsertionPoint(io, false)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub deselectResizePictures()
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  
		  ' Is there anything to do?
		  if not (resizePicture is nil) then
		    
		    ' Get the number of paragraphs.
		    count = Ubound(paragraphs)
		    
		    ' Remove all selection objects.
		    for i = 0 to count
		      
		      ' Clear the selection.
		      paragraphs(i).deselectResizePictures
		      
		    next
		    
		  end if
		  
		  ' Save the state.
		  setResizePicture
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub dispose()
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim page as FTPage
		  Dim para as FTParagraph
		  
		  ' Clear all the pages.
		  for each page in pages
		    
		    ' Clear the page.
		    page.clear
		    
		  next
		  
		  ' Clear all the proxies.
		  for each para in paragraphs
		    
		    ' Clear the proxies.
		    para.clear
		    
		  next
		  
		  ' Release the references.
		  characterStyles = nil
		  clippingPage = nil
		  defaultParagraphStyle = nil
		  dirtyIndexes = nil
		  insertionPoint = nil
		  paragraphStyles = nil
		  printer = nil
		  resizeParagraph = nil
		  resizePicture = nil
		  selectEnd = nil
		  selectStart = nil
		  spellCheckTimer = nil
		  updateDataTimer = nil
		  parentControl = nil
		  
		  ' Release the arrays.
		  Redim defaultTabStops(-1)
		  Redim pages(-1)
		  Redim paragraphs(-1)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub draw(hScrollValue as integer, vScrollValue as integer, displayHeight as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Are we in the page view mode?
		  if parentControl.isPageViewMode then
		    
		    ' Draw the display in the page view.
		    drawPageViewMode(hScrollValue, vScrollValue, displayHeight)
		    
		  else
		    
		    ' Draw the display in the normal view.
		    drawNormalViewMode(hScrollValue, vScrollValue)
		    
		  end if
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub drawNormalViewMode(hScrollValue as integer, vScrollValue as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim g as Graphics
		  
		  ' Get the display.
		  g = parentControl.getDisplay
		  
		  ' Draw the page.
		  pages(0).drawNormalViewMode(g, self, hScrollValue, vScrollValue, insertionPoint)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub drawPageViewMode(hScrollValue as integer, vScrollValue as integer, displayHeight as integer)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim firstPage as integer
		  Dim lastPage as integer
		  Dim pageTop as integer
		  Dim pageLength as integer
		  Dim g as Graphics
		  
		  ' Find the first visible page.
		  firstPage = findVisiblePage(abs(vScrollValue))
		  
		  ' Find the last visible page.
		  lastPage = findVisiblePage(abs(vScrollValue) + displayHeight)
		  
		  ' Check the range of the last page.
		  if lastPage > Ubound(pages) then lastPage = Ubound(pages)
		  
		  ' Get the length of a page.
		  pageLength = (parentControl.getScale * getPageHeightLength) + pageSpace
		  
		  ' Set the starting position.
		  pageTop = vScrollValue mod pageLength
		  parentControl.TIC_PageTop = PageTop
		  
		  ' Get the display.
		  g = parentControl.getDisplay
		  
		  ' Draw all the visible pages.
		  for i = firstPage to lastPage
		    
		    ' Draw the page.
		    pages(i).drawPageViewMode(g, self, hScrollValue, pageTop, insertionPoint, false, 1.0)
		    
		    ' Move to the next page position.
		    pageTop = pageTop + pageLength
		    
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub drawToPDF(g As PDFGraphics, pTop As Integer)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i As Integer
		  
		  ' Reset the scale to 100%.
		  parentControl.setScale(1.0, False)
		  
		  ' Dim firstPage as integer
		  ' Dim lastPage as integer
		  ' Dim pageTop as integer
		  ' Dim pageLength as integer
		  ' Dim g as Graphics
		  
		  ' ' Find the first visible page.
		  ' firstPage = findVisiblePage(abs(vScrollValue))
		  ' 
		  ' ' Find the last visible page.
		  ' lastPage = findVisiblePage(abs(vScrollValue) + displayHeight)
		  ' 
		  ' ' Check the range of the last page.
		  ' if lastPage > Ubound(pages) then lastPage = Ubound(pages)
		  ' 
		  ' ' Get the length of a page.
		  ' pageLength = (parentControl.getScale * getPageHeightLength) + pageSpace
		  ' 
		  ' ' Set the starting position.
		  ' pageTop = vScrollValue mod pageLength
		  ' parentControl.TIC_PageTop = PageTop
		  
		  ' ' Get the display.
		  ' g = parentControl.getDisplay
		  
		  ' Draw all the visible pages.
		  For i = 0 To pages.LastIndex
		    
		    ' Draw the page.
		    pTop = pages(i).drawPageToPDF(g, Self, 1.0, pTop)
		    
		    ' ' Move to the next page position.
		    ' pageTop = pageTop + pageLength
		    
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
		  Dim sa() as string
		  
		  ' Get the number of paragraphs.
		  count = getParagraphCount - 1
		  
		  ' Scan all the paragraphs.
		  for i = 0 to count
		    
		    ' Add the paragraph.
		    sa.Append(getParagraph(i).dump)
		    sa.Append("")
		    
		  next
		  
		  ' Put them all together.
		  return join(sa, EndOfLine)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function findCharacterOffset(x as integer, y as integer) As FTInsertionOffset
		  Dim targetPage as integer
		  Dim page as FTPage
		  Dim pp as FTParagraphProxy
		  Dim offset as integer
		  Dim pageX as integer
		  Dim pageY as integer
		  Dim startLine as integer
		  Dim endLine as integer
		  Dim displayScale as double
		  Dim bias as boolean
		  
		  ' Get the display scale.
		  displayScale = parentControl.getDisplayScale
		  
		  ' Convert the coordinates.
		  parentControl.convertDisplayToPageCoordinates(x, y, targetPage, pageX, pageY)
		  if targetPage > Ubound(pages) then
		    'click wasn't in any page
		    return nil
		  end if
		  
		  ' Get the target page.
		  page = pages(targetPage)
		  
		  ' Find the target paragraph.
		  pp = page.findParagraph(pageX, pageY, displayScale, true)
		  if pp is nil then
		    'click wasn't in any paragraph
		    return nil
		  end if
		  
		  
		  ' Get the lines involved.
		  pp.getStartAndEndLines(startLine, endLine)
		  
		  ' Find the offset into the paragraph.
		  offset = pp.findOffset(pageX, pageY, startLine, endLine, bias)
		  
		  if startLine>0 then
		    'if the paragraph has been split then we need to take that
		    'into account - the offset needs to be relative to the start of the proxy paragraph
		    dim ftl as FTLine = pp.getParent.getLine(startLine)
		    if ftl<>nil then
		      offset = offset - ftl.getParagraphOffset - 1
		    end if
		  end if
		  
		  offset = pp.getParent.getLineLength(0, pp.getLineStart - 1) + offset
		  
		  dim paragraph as integer = pp.getParent.getAbsoluteIndex
		  return new FTInsertionOffset(self, paragraph, offset, bias)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function findHyperLinkBoundaryAtOffset(io as FTInsertionOffset, ByRef startPosition as FTInsertionOffset, ByRef endPosition as FTInsertionOffset) As boolean
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim j as integer
		  Dim paragraphCount as integer
		  Dim itemCount as integer
		  Dim p as FTParagraph
		  Dim fto as FTObject
		  Dim curLink As String
		  Dim startParagraphIndex As Integer ' we need to start from a specific Paragraph
		  dim startStyleIndex As Integer
		  Dim doExit As Boolean
		  Dim nextObect As FTObject
		  
		  
		  'get out current style
		  Dim curStyle As FTStyleRun = getCurrentStyleRun
		  
		  
		  'did we get a current style?
		  if curStyle is Nil or not curStyle.isHyperlink then
		    'let's just make sure and check our next insert point to see if its a hyperlink
		    'we can be to the left or the right of a hyperlink and it may get missed
		    nextObect = me.getObjectAtOffset(io + 1)
		    
		    if not nextObect isA FTStyleRun or not FTStyleRun(nextObect).isHyperlink then
		      'definitely not a hyperlink
		      
		      'now let's check our pevious insertionPoint
		      nextObect = me.getObjectAtOffset(io - 2)
		      if not nextObect isA FTStyleRun or not FTStyleRun(nextObect).isHyperlink then
		        'no hyperlinks anywhere, return false
		        Return false
		        
		      end if
		      
		    end
		    
		    'either before or after was a hyperlink so let's keep going
		    curStyle = FTStyleRun(nextObect)
		    //Return False
		  end if
		  
		  'store our current link
		  curLink = curStyle.HyperLink
		  
		  'just incase we set our begining and ending boundaries
		  endPosition = io.clone
		  startPosition  = io.clone
		  
		  startPosition.offset = curStyle.getStartPosition - 1
		  endPosition.offset= curStyle.getEndPosition
		  
		  //get the start Paragraph index so we know where to start looking
		  startParagraphIndex = findParagraphIndex(io.getParagraph.getid)
		  
		  ' Get the number of paragraphs so we know what to search
		  paragraphCount = getParagraphCount - 1
		  
		  ' Scan the paragraphs going forward
		  for i = startParagraphIndex to paragraphCount
		    
		    ' Get a paragraph.
		    p = getParagraph(i)
		    
		    'if we are in our first Paragraph we want to start searching at the currentStyle
		    if i = startParagraphIndex then
		      
		      'get our current style index so we know where to start searching from
		      startStyleIndex =p.findItem(curStyle.getStartPosition, false)
		      
		      'if startStyleIndex = 0 then
		      ''why can't we find this style? shouldn't happen
		      'Break
		      'Return false
		      'end if
		      
		    else
		      
		      'we can start searching the styles at 0
		      startStyleIndex = 0
		      
		    end if
		    
		    ' Get the number of items in the paragraph.
		    itemCount = p.getItemCount - 1
		    
		    ' Scan the items in the paragraph.
		    for j = startStyleIndex to itemCount
		      
		      ' Get an item from the paragraph.
		      fto = p.getItem(j)
		      
		      ' Is this a style run?
		      if fto isa FTStyleRun then
		        
		        ' Is there anything to check in this style run? (shouldn't we exit?)
		        if FTStyleRun(fto).getLength = 0 then continue
		        
		        'do we have the same link in this hyperlink?
		        if curLink = FTStyleRun(fto).HyperLink then
		          
		          'something was found so lets store the endPosition. Endposition will be updated each time until something is not found
		          endPosition.offset = FTStyleRun(fto).getEndPosition
		          endPosition.paragraph = i
		        else
		          'link not found so we can exit
		          doExit = true
		          
		          exit
		          
		        end
		        
		      end if
		      
		    next
		    
		    ' Can we can stop searching our paragraphs?
		    if doExit then
		      exit
		      
		    end if
		    
		  next
		  
		  'reset our variables
		  doExit = false
		  
		  ' no we must search backwards
		  for i =startParagraphIndex  Downto 0
		    
		    ' Get a paragraph.
		    p = getParagraph(i)
		    
		    'if we are in our first Paragraph we want to start searching at the currentStyle
		    if i = startParagraphIndex then
		      
		      'get our current style index so we know where to start searching from
		      startStyleIndex =p.findItem(curStyle.getStartPosition, false)
		      
		      'if startStyleIndex = 0 then
		      ''why can't we find this style? shouldn't happen
		      'Break
		      'Return false
		      'end if
		      
		    else
		      
		      'we can start searching the styles at 0
		      startStyleIndex = p.getItemCount -1
		      
		    end if
		    
		    ' Get the number of items in the paragraph.
		    itemCount = p.getItemCount - 1
		    
		    ' Scan the items in the paragraph but in reverse
		    for j = startStyleIndex downto 0
		      
		      ' Get an item from the paragraph.
		      fto = p.getItem(j)
		      
		      ' Is this a style run?
		      if fto isa FTStyleRun then
		        
		        ' Is there anything to check in this style run? (shouldn't we exit?)
		        if FTStyleRun(fto).getLength = 0 then continue
		        
		        'do we have the same link in this hyperlink?
		        if curLink = FTStyleRun(fto).HyperLink then
		          
		          'something was found so lets store the startPosition. startPosition will be updated each time until something is not found
		          startPosition.offset = FTStyleRun(fto).getStartPosition -1
		          startPosition.paragraph = i
		        else
		          
		          'link not found so we can exit
		          doExit = true
		          
		          exit
		          
		        end
		        
		      end if
		      
		    next
		    
		    ' Can we can stop searching our paragraphs?
		    if doExit then
		      exit
		      
		    end if
		    
		  next
		  
		  'if we got this far, something was found
		  Return true
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function findInsertionOffset(x as integer, y as integer) As FTInsertionOffset
		  Dim targetPage As Integer
		  Dim page as FTPage
		  Dim pp as FTParagraphProxy
		  Dim offset as integer
		  Dim pageX as integer
		  Dim pageY as integer
		  Dim startLine as integer
		  Dim endLine as integer
		  Dim displayScale as double
		  Dim bias as boolean
		  
		  ' Get the display scale.
		  displayScale = parentControl.getDisplayScale
		  
		  ' Convert the coordinates.
		  parentControl.convertDisplayToPageCoordinates(x, y, targetPage, pageX, pageY)
		  
		  ' Are we past the last page?
		  if targetPage > Ubound(pages) then
		    if UBound(pages)<0 then
		      return nil
		    else
		      return pages(UBound(pages)).getEndOffset
		    end if
		  end if
		  
		  ' Get the target page.
		  page = pages(targetPage)
		  
		  ' Find the target paragraph.
		  pp = page.findParagraph(pageX, pageY, displayScale, true)
		  
		  ' Was the click in a paragraph?
		  if pp is nil then
		    
		    ' Were we before the paragraph?
		    if page.isPointBeforeParagraphs(pageY) then
		      
		      return page.getBeginOffset
		      
		      ' Were we after the paragraph?
		    elseif page.isPointAfterParagraphs(pageY) then
		      
		      return page.getEndOffset
		      
		    end if
		    
		    ' We are done.
		    return nil
		    
		  end if
		  
		  ' Get the lines involved.
		  pp.getStartAndEndLines(startLine, endLine)
		  
		  ' Find the offset into the paragraph.
		  offset = pp.findOffset(pageX, pageY, startLine, endLine, bias)
		  
		  if startLine>0 then
		    'if the paragraph has been split then we need to take that
		    'into account - the offset needs to be relative to the start of the proxy paragraph
		    dim ftl as FTLine = pp.getParent.getLine(startLine)
		    If ftl<>Nil Then
		      //ISSUE 3798: Wrong Caret x-Position in FTParagraph if Paragraph (continued Paragraph) breaks into two pages
		      offset = offset - ftl.getParagraphOffset + 1
		    end if
		  end if
		  
		  offset = pp.getParent.getLineLength(0, pp.getLineStart - 1) + offset
		  
		  dim paragraph as integer = pp.getParent.getAbsoluteIndex
		  return new FTInsertionOffset(self, paragraph, offset, bias)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function findInsertionPoint(x as integer, y as integer, ByRef bias as boolean) As boolean
		  'set the insertion point based on the x,y position
		  dim io as FTInsertionOffset = findInsertionOffset(x, y)
		  if io=nil then
		    return false
		  end if
		  bias = io.bias
		  insertionPoint.setInsertionPoint(io, true)
		  return true
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function findLineOffset(p as FTParagraph, xOffset as integer, targetLine as integer, scale as double) As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Are we past the beginning of the paragraph?
		  if targetLine < 0 then
		    
		    ' Use the start of the paragraph.
		    return 0
		    
		  end if
		  
		  ' Are we past the end of the paragraph?
		  if targetLine >= p.getLineCount then
		    
		    ' Use the end of the paragraph.
		    return p.getLength + 1
		    
		    ' Is this the last line?
		  elseif targetLine = (p.getLineCount - 1) then
		    
		    ' Are we past the end of the line?
		    if xOffset >= p.getLine(targetLine).getWidth(scale) then
		      
		      ' Use the end of the line.
		      return p.getLineLength(0, targetLine) + 1
		      
		    end if
		    
		  end if
		  
		  ' Return the offset that is closest.
		  return p.getLine(targetLine).getParagraphOffset + p.findOffsetInLine(targetLine, xOffset, scale) - 1
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function findPageContainingPicture(pic as FTPicture) As FTPage
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as  integer
		  
		  ' Is there anything to search for?
		  if pic is nil then return nil
		  
		  ' Get the number of pages.
		  count = Ubound(pages)
		  
		  ' Search for the paragraph.
		  for i = 0 to count
		    
		    ' Does this page contain the picture?
		    if pages(i).containsPicture(pic) then
		      
		      ' Return the enclosing page.
		      return pages(i)
		      
		    end if
		    
		  next
		  
		  ' The picture was not found.
		  return nil
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function findParagraphContainingPicture(pic as FTPicture) As FTParagraph
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim p as FTParagraph
		  
		  ' Search the paragraphs.
		  for each p in paragraphs
		    
		    ' Does this paragraph contain the picture?
		    if p.containsPicture(pic) then
		      
		      ' We found it.
		      return p
		      
		    end if
		    
		  next
		  
		  ' Not found.
		  return nil
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function findParagraphHeightOffset(id as integer) As integer
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim offset as integer
		  
		  ' Is it the first paragraph?
		  if paragraphs(0).getId = id then return 0
		  
		  ' Get the number of paragraphs.
		  count = Ubound(paragraphs)
		  
		  ' Get the height of the first paragraph.
		  offset = paragraphs(0).getHeight(false)
		  
		  ' Scan the paragraphs.
		  for i = 1 to count
		    
		    ' Is this the one we are looking for?
		    if paragraphs(i).getId = id then return offset
		    
		    ' Add in the offset.
		    offset = offset + paragraphs(i).getHeight(true)
		    
		  next
		  
		  ' We did not find it.
		  return -1
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function findParagraphIndex(id as integer) As integer
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  
		  ' Get the number of paragraphs.
		  count = Ubound(paragraphs)
		  
		  ' Scan the paragraphs.
		  for i = 0 to count
		    
		    ' Is this the paragraph we are looking for?
		    if paragraphs(i).getId = id then
		      
		      ' Return the paragraph index.
		      return i
		      
		    end if
		    
		  next
		  
		  ' We did not find it.
		  return -1
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function findParagraphOffset(id as integer) As integer
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim offset as integer
		  
		  ' Get the number of paragraphs.
		  count = Ubound(paragraphs)
		  
		  ' Scan the paragraphs.
		  for i = 0 to count
		    
		    ' Is this the one we are looking for?
		    if paragraphs(i).getId = id then
		      
		      ' We found the offset.
		      return offset
		      
		    end if
		    
		    ' Add in the offset.
		    offset = offset + paragraphs(i).getLength
		    
		  next
		  
		  ' We did not find it.
		  return -1
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function findParagraphPage(p as FTParagraph, offset as integer, bias as boolean, hintPage as integer = - 1) As integer
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim j as integer
		  Dim startPage as integer
		  Dim endPage as integer
		  Dim line as integer
		  Dim startLine as integer
		  Dim endLine as integer
		  Dim count as integer
		  Dim id as integer
		  Dim ignore as integer
		  Dim pp as FTParagraphProxy
		  
		  '---------------------------------------------------
		  ' Set up the search parameters.
		  '---------------------------------------------------
		  
		  ' Get the ID of the paragraph.
		  id = p.getId
		  
		  ' Get the line number.
		  p.findLine(0, offset, bias, line, ignore)
		  
		  ' Was a hint supplied?
		  if hintPage <> -1 then
		    
		    ' Set the page range.
		    startPage = hintPage - 1
		    endPage = hintPage + 1
		    
		    ' Check the ranges.
		    if startPage < 0 then startPage = 0
		    if endPage > Ubound(pages) then endPage = Ubound(pages)
		    
		  else
		    
		    ' Search all the pages.
		    startPage = 0
		    endPage = Ubound(pages)
		    
		  end if
		  
		  '---------------------------------------------------
		  ' Search the pages.
		  '---------------------------------------------------
		  
		  ' Scan the pages.
		  for i = startPage to endPage
		    
		    ' Get the number of paragraphs on the page.
		    count = pages(i).getParagraphCount - 1
		    
		    ' Scan the paragraph proxies.
		    for j = 0 to count
		      
		      ' Get the proxy.
		      pp = pages(i).getParagraph(j)
		      
		      ' Does this proxy belong to the target paragraph?
		      if pp.getParent.getId = p.getId then
		        
		        ' Get the lines covered by the proxy.
		        pp.getStartAndEndLines(startLine, endLine)
		        
		        ' Are we in range?
		        if (line >= startLine) and (line <= endLine) then
		          
		          ' Return the page.
		          return i
		          
		        end if
		        
		      end if
		      
		    next
		    
		  next
		  
		  '---------------------------------------------------
		  ' Reset the search parameters for all pages.
		  '---------------------------------------------------
		  
		  ' Set the page range.
		  startPage = 0
		  endPage = Ubound(pages)
		  
		  '---------------------------------------------------
		  ' Search all the pages.
		  '---------------------------------------------------
		  
		  ' Scan the pages.
		  for i = startPage to endPage
		    
		    ' Get the number of paragraphs on the page.
		    count = pages(i).getParagraphCount - 1
		    
		    ' Scan the paragraph proxies.
		    for j = 0 to count
		      
		      ' Get the proxy.
		      pp = pages(i).getParagraph(j)
		      
		      ' Does this proxy belong to the target paragraph?
		      if pp.getParent.getId = p.getId then
		        
		        ' Get the lines covered by the proxy.
		        pp.getStartAndEndLines(startLine, endLine)
		        
		        ' Are we in range?
		        if (line >= startLine) and (line <= endLine) then
		          
		          ' Return the page.
		          return i
		          
		        end if
		        
		      end if
		      
		    next
		    
		  next
		  
		  ' Page not found.
		  return 0
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub findResizeModePicture(x as integer, y as integer)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim pic as FTPicture
		  
		  ' Get the number of paragraphs.
		  count = Ubound(paragraphs)
		  
		  ' Look for a selected picture.
		  for i = 0 to count
		    
		    ' Find the picture.
		    pic = paragraphs(i).hasResizeModePicture
		    
		    ' Did we find a picture?
		    if not (pic is nil) then
		      
		      ' Set the picture in resize mode.
		      setResizePicture(pic, paragraphs(i), x, y)
		      
		      ' We are done.
		      return
		      
		    end if
		    
		  next
		  
		  ' Clear the references.
		  clearResizePicture
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub findSelectionLines(ByRef startParagraph as integer, ByRef startLine as integer, ByRef endParagraph as integer, ByRef endLine as integer)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim line as integer
		  Dim ignore as integer
		  Dim selectStart as FTInsertionOffset
		  Dim selectEnd as FTInsertionOffset
		  Dim p as FTParagraph
		  
		  ' Is anything selected?
		  if isSelected then
		    
		    ' Get the selected range.
		    getSelectionRange(selectStart, selectEnd)
		    
		    ' Retrieve the paragraph indexes.
		    startParagraph = selectStart.paragraph
		    endParagraph = selectEnd.paragraph
		    
		    '-----------------------------------
		    ' Look for the start line.
		    '-----------------------------------
		    
		    ' Get the starting selected paragraph.
		    p = selectStart.getParagraph
		    
		    ' Get the number of lines in the paragraph.
		    count = p.getLineCount - 1
		    
		    ' Assume the end of the paragraph.
		    startLine = count
		    
		    ' Scan for the first selected line.
		    for i = 0 to count
		      
		      ' Is the line selected?
		      if p.getLine(i).isLineSelected then
		        
		        ' Save the starting selected line index.
		        startLine = i
		        
		        ' We are done.
		        exit
		        
		      end if
		      
		    next
		    
		    '-----------------------------------
		    ' Look for the end line.
		    '-----------------------------------
		    
		    ' Are we at the beginning of the paragraph?
		    if selectEnd.isBeginningOfParagraph then
		      
		      ' Is this the beginning paragraph?
		      if endParagraph = 0 then
		        
		        ' Set it to the first line.
		        endLine = 0
		        
		      else
		        
		        ' Get the last line of the previous paragraph.
		        endParagraph = endParagraph - 1
		        endLine = getParagraph(endParagraph).getLineCount - 1
		        
		      end if
		      
		    else
		      
		      ' Get the ending selected paragraph.
		      p = selectEnd.getParagraph
		      
		      ' Get the number of lines in the paragraph.
		      count = p.getLineCount - 1
		      
		      ' Scan for the last selected line.
		      for i = count downto 0
		        
		        ' Is the line selected?
		        if p.getLine(i).isLineSelected then
		          
		          ' Save the ending selected line index.
		          endLine = i
		          
		          ' We are done.
		          exit
		          
		        end if
		        
		      next
		      
		    end if
		    
		  else
		    
		    '-----------------------------------
		    ' Look for insertion point line.
		    '-----------------------------------
		    
		    ' Get the insertion point paragraph.
		    p = getInsertionOffset.getParagraph
		    
		    ' Find the line that contains the insertion point.
		    p.findLine(0, getInsertionOffset.offset, getInsertionOffset.bias, line, ignore)
		    
		    ' Set the indexes.
		    startParagraph = p.getAbsoluteIndex
		    endParagraph = startParagraph
		    startLine = line
		    endLine = line
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function findStartParagraph(pageIndex as integer) As integer
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim high as integer
		  Dim low as integer
		  Dim center as integer
		  
		  ' Set the range of the search.
		  high = Ubound(paragraphs)
		  
		  ' Calculate the center.
		  center = (high - low) / 2
		  
		  ' Search for the character position.
		  while low <= high
		    
		    ' Did we find the paragraph?
		    if paragraphs(center).hasPageProxy(pageIndex) then exit
		    
		    ' Is the position above or below the center paragraph.
		    if paragraphs(center).getFirstProxyPage > pageIndex then
		      
		      ' Move to the bottom half.
		      high = center - 1
		      
		    else
		      
		      ' Move to the upper half.
		      low = center + 1
		      
		    end if
		    
		    ' Compute the new center paragraph.
		    center = ((high - low) / 2) + low
		    
		  wend
		  
		  ' Make sure we found the correct paragraph.
		  while center >= 0
		    
		    ' Is the paragraph on the page?
		    if not paragraphs(center).hasPageProxy(pageIndex) then exit
		    
		    ' Move back a page.
		    center = center - 1
		    
		  wend
		  
		  ' Return the starting paragraph.
		  return Max(center, 0)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function findVisiblePage(y as integer) As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Are we in page view?
		  if parentControl.isPageViewMode then
		    
		    ' Return the page.
		    return (y \ ((parentControl.getScale * getPageHeightLength) + getPageSpace))
		    
		  else
		    
		    ' Return the first page.
		    return 0
		    
		  end if
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function findWordBoundaryAtInsertion(forward as boolean, trim as boolean) As FTInsertionOffset
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim io as FTInsertionOffset
		  Dim direction as integer
		  Dim ch as string
		  Dim keepLooking as boolean
		  
		  '-----------------------------------------------
		  ' Do some set up.
		  '-----------------------------------------------
		  
		  ' Get the insertion offset.
		  io = getInsertionPoint.getOffset
		  
		  ' Which direction should we scan?
		  if forward then
		    
		    ' Are we at the end of the document?
		    if io.isEnd then return io
		    
		    ' Set the direction.
		    direction = 1
		    
		  else
		    
		    ' Are we at the beginning of the document?
		    if io.isBeginning then return io
		    
		    ' Adjust for the direction.
		    io = io - 1
		    
		    ' Set the direction.
		    direction = -1
		    
		  end if
		  
		  '-----------------------------------------------
		  ' Skip over white space.
		  '-----------------------------------------------
		  
		  ' Get the character.
		  ch = getCharacter(io)
		  
		  ' Are we at the end of a paragraph?
		  if ch = "" then
		    
		    ' Move to the next character.
		    io = io + direction
		    
		    ' Are we going to the left?
		    if (direction < 0) then
		      
		      ' Do we need to stop?
		      if io.isBeginning then return io
		      
		    else
		      
		      ' Do we need to stop?
		      if io.isEnd then return io
		      
		    end if
		    
		    ' Get the character.
		    ch = getCharacter(io)
		    
		  end if
		  
		  ' Skip over the space and pictures.
		  while FTUtilities.isWordDivider(ch) and (Asc(ch) > 0)
		    
		    ' Move to the next character.
		    io = io + direction
		    
		    ' Get the character.
		    ch = getCharacter(io)
		    
		    ' Are we at the boundary of a paragraph?
		    if ch = "" then
		      
		      ' Move to the next character.
		      io = io + direction
		      
		      ' Are we going to the left?
		      if (direction < 0) then
		        
		        ' Do we need to stop?
		        if io.isBeginning then return io
		        
		      else
		        
		        ' Do we need to stop?
		        if io.isEnd then return io
		        
		      end if
		      
		      ' Get the character.
		      ch = getCharacter(io)
		      
		    end if
		    
		  wend
		  
		  '-----------------------------------------------
		  ' Find the word boundary.
		  '-----------------------------------------------
		  
		  ' Get the character.
		  ch = getCharacter(io)
		  
		  ' Do we have a character?
		  if ch <> "" then
		    
		    ' Is this a character in a word?
		    keepLooking = (Asc(ch) = 0) or (not FTUtilities.isWordDivider(ch))
		    
		  else
		    
		    ' We are at the boundary of a paragraph.
		    keepLooking = false
		    
		  end if
		  
		  ' Scan for the end of the word.
		  while keepLooking
		    
		    ' Move to the next character.
		    io = io + direction
		    
		    ' Are we going to the left?
		    if (direction < 0) then
		      
		      ' Do we need to stop?
		      if io.isBeginning then return io
		      
		    else
		      
		      ' Do we need to stop?
		      if io.isEnd then return io
		      
		    end if
		    
		    ' Get the character.
		    ch = getCharacter(io)
		    
		    ' Do we have a character?
		    if ch <> "" then
		      
		      ' Is this a character in a word?
		      keepLooking = (Asc(ch) = 0) or (not FTUtilities.isWordDivider(ch))
		      
		    else
		      
		      ' We are at the boundary of a paragraph.
		      keepLooking = false
		      
		    end if
		    
		  wend
		  
		  '-----------------------------------------------
		  ' Trim white space if needed.
		  '-----------------------------------------------
		  
		  ' Should we trim the remaining white space?
		  if trim then
		    
		    ' Get the character.
		    ch = getCharacter(io)
		    
		    ' Are we at the end of a paragraph?
		    if ch = "" then
		      
		      ' Move to the next character.
		      io = io + direction
		      
		      ' Are we going to the left?
		      if (direction < 0) then
		        
		        ' Do we need to stop?
		        if io.isBeginning then return io
		        
		      else
		        
		        ' Do we need to stop?
		        if io.isEnd then return io
		        
		      end if
		      
		      ' Get the character.
		      ch = getCharacter(io)
		      
		    end if
		    
		    ' Skip over the space.
		    while FTUtilities.isWordDivider(ch)
		      
		      ' Move to the next character.
		      io = io + direction
		      
		      ' Get the character.
		      ch = getCharacter(io)
		      
		      ' Are we at the boundary of a paragraph?
		      if ch = "" then
		        
		        ' Move to the next character.
		        io = io + direction
		        
		        ' Are we going to the left?
		        if (direction < 0) then
		          
		          ' Do we need to stop?
		          if io.isBeginning then return io
		          
		        else
		          
		          ' Do we need to stop?
		          if io.isEnd then return io
		          
		        end if
		        
		        ' Get the character.
		        ch = getCharacter(io)
		        
		      end if
		      
		    wend
		    
		  end if
		  
		  '-----------------------------------------------
		  ' Finish up.
		  '-----------------------------------------------
		  
		  if not forward then
		    
		    ' Adjust for the direction.
		    io = io + 1
		    
		  end if
		  
		  ' Return the offset.
		  return io
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function findWordBoundaryAtInsertion(ByRef startPosition as FTInsertionOffset, ByRef endPosition as FTInsertionOffset) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Find the word at the current insrtion offset.
		  return findWordBoundaryAtOffset(getInsertionOffset, startPosition, endPosition)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function findWordBoundaryAtOffset(io as FTInsertionOffset, ByRef startPosition as FTInsertionOffset, ByRef endPosition as FTInsertionOffset) As boolean
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim p as FTParagraph
		  Dim text as string
		  Dim length as integer
		  
		  '--------------------------------------------------------
		  ' Set up some data.
		  '--------------------------------------------------------
		  
		  ' Is there anything to do?
		  if io is nil then return false
		  
		  ' Do we need to allocate the start point?
		  if startPosition is nil then
		    
		    ' Use the current insertion point.
		    startPosition = io.clone
		    
		  end if
		  
		  ' Do we need to allocate the end point?
		  if endPosition is nil then
		    
		    ' Use the current insertion point.
		    endPosition = io.clone
		    
		  end if
		  
		  ' Get the parent paragraph.
		  p = getParagraph(io.paragraph)
		  
		  ' Get the text of the paragraph.
		  text = p.getText
		  
		  ' Get the length of the text.
		  length = text.len
		  
		  ' Are we at the beginning or the end?
		  if (io.offset <= 0) or (io.offset >= length) then
		    
		    ' We are not inside a word.
		    return false
		    
		  end if
		  
		  ' Are these characters word dividers?
		  if FTUtilities.isWordDivider(mid(text, io.offset, 1)) or _
		    FTUtilities.isWordDivider(mid(text, io.offset + 1, 1)) then
		    
		    ' We are not inside a word.
		    return false
		    
		  end if
		  
		  ' Initialize the positions.
		  startPosition.offset = io.offset
		  endPosition.offset = io.offset
		  
		  '--------------------------------------------------------
		  ' Look for the end of the word.
		  '--------------------------------------------------------
		  
		  ' Scan for the end of the word.
		  for i = io.offset to length
		    
		    ' Is this a word divider?
		    if FTUtilities.isWordDivider(mid(text, i, 1)) then
		      
		      ' We are done.
		      exit
		      
		    end if
		    
		    ' Expand the boundary.
		    endPosition.offset = i
		    
		  next
		  
		  '--------------------------------------------------------
		  ' Look for the beginning of the word.
		  '--------------------------------------------------------
		  
		  ' Scan for the beginning of the word.
		  for i = io.offset downto 0
		    
		    ' Is this a word divider?
		    if FTUtilities.isWordDivider(mid(text, i, 1)) then
		      
		      ' Expand the boundary.
		      startPosition.offset = i
		      
		      ' We are done.
		      exit
		      
		    end if
		    
		    ' Expand the boundary.
		    startPosition.offset = i
		    
		  next
		  
		  ' We are inside a word.
		  return true
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function findXYOffset(x as integer, y as integer) As FTInsertionOffset
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim targetPage as integer
		  Dim page as FTPage
		  Dim pp as FTParagraphProxy
		  Dim offset as integer
		  Dim pageX as integer
		  Dim pageY as integer
		  Dim startLine as integer
		  Dim endLine as integer
		  Dim displayScale as double
		  Dim ip as FTInsertionPoint
		  Dim bias as boolean
		  
		  ' Get the display scale.
		  displayScale = parentControl.getDisplayScale
		  
		  ' Convert the coordinates.
		  parentControl.convertDisplayToPageCoordinates(x, y, targetPage, pageX, pageY)
		  
		  ' Is it horizontally within the pages?
		  if pageX > (getPageWidthLength * displayScale) then
		    
		    ' We are done.
		    return nil
		    
		  end if
		  
		  ' Are we past the last page?
		  if targetPage > Ubound(pages) then
		    
		    ' We are done.
		    return nil
		    
		  end if
		  
		  ' Get the target page.
		  page = pages(targetPage)
		  
		  ' Find the target paragraph.
		  pp = page.findParagraph(pageX, pageY, displayScale, true)
		  
		  ' Was the click in a paragraph?
		  if pp is nil then
		    
		    ' Were we before the paragraph?
		    if page.isPointBeforeParagraphs(pageY) then
		      
		      ' We are done.
		      return nil
		      
		      ' Were we after the paragraph?
		    elseif page.isPointAfterParagraphs(pageY) then
		      
		      ' We are done.
		      return nil
		      
		    end if
		    
		    ' We are done.
		    return nil
		    
		  end if
		  
		  ' Get the lines involved.
		  pp.getStartAndEndLines(startLine, endLine)
		  
		  ' Find the offset into the paragraph.
		  offset = pp.findOffset(pageX, pageY, startLine, endLine, bias)
		  
		  ' Create an insertion point.
		  ip = new FTInsertionPoint(parentControl, self)
		  ip.setInsertionPoint(pp, offset, true, bias)
		  
		  ' Extract the offset.
		  return new FTInsertionOffset(self, ip.getOffset.paragraph, ip.getOffset.offset, bias)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getBottomMargin() As double
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the bottom margin.
		  return margins.bottomMargin
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getBottomMarginWidth() As double
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Compute the bottom margin in pixels.
		  return FTUtilities.getScaledLength(margins.bottomMargin, 1.0)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getCharacter(io as FTInsertionOffset) As string
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the character.
		  return mid(paragraphs(io.paragraph).getText(true), io.offset + 1, 1)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getCharacterStyle(id as integer) As FTCharacterStyle
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Does the style exist?
		  if characterStyles.HasKey(id) then
		    
		    ' Return the style.
		    return characterStyles.value(id)
		    
		  end if
		  
		  ' Style not found.
		  return nil
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getCharacterStyle(name as string) As FTCharacterStyle
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim values() as Variant
		  
		  ' Get the list of styles.
		  values = characterStyles.values
		  
		  ' Get the number of styles.
		  count = Ubound(values)
		  
		  ' Scan the styles.
		  for i = 0 to count
		    
		    ' Is this the one we are looking for?
		    if FTCharacterStyle(values(i).ObjectValue).getStyleName = name then
		      
		      ' Return the style.
		      return FTCharacterStyle(values(i).ObjectValue)
		      
		    end if
		    
		  next
		  
		  ' Style not found.
		  return nil
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getCharacterStyles() As Dictionary
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Return characterStyles
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getClippingPage() As Picture
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the clipping page.
		  return clippingPage
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getCurrentStyleRun() As FTStyleRun
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim ip as FTInsertionPoint
		  Dim p as FTParagraph
		  Dim fto as FTObject
		  Dim itemIndex as integer
		  Dim itemCount as integer
		  
		  '-----------------------------------------
		  ' Do some checking.
		  '-----------------------------------------
		  
		  ' Are we in resize mode?
		  if isInResizeMode then return nil
		  
		  ' Get the insertion point.
		  ip = getInsertionPoint
		  
		  ' Get the parent paragraph.
		  p = ip.getCurrentParagraph
		  
		  ' Is there anything to look at?
		  if p is nil then return nil
		  
		  '-----------------------------------------
		  ' Get the indicated style run.
		  '-----------------------------------------
		  
		  ' Get the index of the last item.
		  itemCount = p.getItemCount - 1
		  
		  ' Get the item at the specified index.
		  itemIndex = p.findItem(getInsertionPoint.getOffset.offset)
		  
		  ' Are we past the last item?
		  if itemIndex > itemCount then
		    
		    ' Use the last item in the paragraph.
		    fto = p.getItem(itemCount)
		    
		  else
		    
		    ' Get the target item.
		    fto = p.getItem(itemIndex)
		    
		  end if
		  
		  '-----------------------------------------
		  ' Do some further checking.
		  '-----------------------------------------
		  
		  ' Is this a non style run?
		  if not (fto isa FTStyleRun) then
		    
		    ' Move back one character.
		    itemIndex = p.findItem(getInsertionPoint.getOffset.offset - 1)
		    
		    ' Are we past the last item?
		    if itemIndex > itemCount then
		      
		      ' Use the last item in the paragraph.
		      fto = p.getItem(itemCount)
		      
		    else
		      
		      ' Get the target item.
		      fto = p.getItem(itemIndex)
		      
		    end if
		    
		  end if
		  
		  '-----------------------------------------
		  ' Check the run.
		  '-----------------------------------------
		  
		  ' Is this a style run?
		  if fto isa FTStyleRun then
		    
		    ' Return the style run.
		    return FTStyleRun(fto)
		    
		  else
		    
		    ' Not a style run.
		    return nil
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getDefaultTabStops() As FTTabStop()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the set of default tab stops.
		  return defaultTabStops
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getDirtyIndexes() As Variant()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the list of dirty paragraphs.
		  return dirtyIndexes.Keys
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getDisplayMargins() As DisplayMargins
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the display margins.
		  return margins
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getDocumentMargins() As DocumentMargins
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the document margins.
		  return docMargins
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getDocumentWidth() As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the horizontal printable height.
		  return (docMargins.pageWidth - margins.rightMargin - margins.leftMargin)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetGraphics() As Graphics
		  Return mGraphics
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getInsertionOffset() As FTInsertionOffset
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the offset.
		  return insertionPoint.getOffset
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getInsertionPoint() As FTInsertionPoint
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the insertion point.
		  return insertionPoint
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getLeftMargin() As double
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the position of the margin.
		  return margins.leftMargin
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getLeftMarginWidth() As double
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Compute the left margin in pixels.
		  return FTUtilities.getScaledLength(margins.leftMargin, 1.0)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getLength() As integer
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim p as FTParagraph
		  Dim docLength as integer
		  
		  ' Add up all the lengths.
		  for each p in paragraphs
		    
		    ' Add in the paragraph length.
		    docLength = docLength + p.getLength
		    
		  next
		  
		  ' Return the total length.
		  return docLength
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getLineCount() As integer
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim p as FTParagraph
		  Dim sum as integer
		  
		  ' Scan the paragraphs.
		  for each p in paragraphs
		    
		    ' Add in the number of lines from the paragraph.
		    sum = sum + p.getLineCount
		    
		  next
		  
		  ' Return the number of lines.
		  return sum
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getMarginGuideColor() As Color
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the color of the margin guides.
		  return parentControl.marginGuideColor
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getMarginHeight() As double
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the vertical printable height.
		  return (docMargins.pageHeight - margins.bottomMargin - margins.topMargin)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getMarginWidth() As double
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the horizontal printable height.
		  return (docMargins.pageWidth - margins.rightMargin - margins.leftMargin)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getMonitorPixelsPerInch() As double
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the current resolution.
		  return MonitorPixelsPerInch
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getNextAbsoluteIndex() As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the next index.
		  return Ubound(paragraphs) + 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getNextParagraph(index as integer) As FTParagraph
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Get the next paragraph.
		  return getParagraph(index + 1)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getNumberOfPages() As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the number of pages.
		  return Ubound(pages) + 1
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getObjectAtOffset(io as FTInsertionOffset) As FTObject
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim p as FTParagraph
		  Dim fto as FTObject
		  Dim startOffset as integer
		  
		  ' Get the parent paragraph.
		  p = getParagraph(io.paragraph)
		  
		  ' Was anything found?
		  if p is nil then return nil
		  
		  ' Get the target run item.
		  fto = p.getItem(p.findItem(io.offset))
		  
		  ' Did we get something?
		  if not (fto is nil) then
		    
		    ' Create a clone.
		    fto = fto.clone
		    
		    ' Is this a style run?
		    if fto isa FTStyleRun then
		      
		      ' Convert to the style run offset.
		      startOffset = io.offset - fto.getStartPosition + 1
		      
		      ' Delete the unused text.
		      fto.deleteRight(startOffset)
		      fto.deleteLeft(startOffset)
		      
		    end if
		    
		  end if
		  
		  ' Return the item.
		  return fto
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getPage(index as integer) As FTPage
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Are we in range?
		  if (index < 0) or (index > Ubound(pages)) then return nil
		  
		  ' Return the specified page.
		  return pages(index)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getPageBackgroundColor() As Color
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the background color.
		  return pageBackgroundColor
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getPageBorderColor(index as integer) As Color
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the specified border color.
		  return borderColors(index)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getPageHeight() As double
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the height of the page.
		  return docMargins.pageHeight
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getPageHeightLength() As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Are we page view mode?
		  if parentControl.isPageViewMode then
		    
		    ' Return the scaled length of the page.
		    Return FTUtilities.getScaledLength(docMargins.pageHeight, 1.0, parentControl.GetMonitorPixelsPerInch)
		    
		  else
		    
		    ' Return the scaled length of the normal view page.
		    return FTUtilities.getScaledLength(normalViewPageHeight, 1.0, parentControl.GetMonitorPixelsPerInch)
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getPageSpace() As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the current page space.
		  return pageSpace
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getPageTop(index as integer, scale as double) As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the offset to the top of the page.
		  return index * ((getPageHeightLength * scale) + getPageSpace)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getPageWidth() As double
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the page width.
		  return docMargins.pageWidth
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getPageWidthLength() As double
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the width of the page.
		  return FTUtilities.getScaledLength(docMargins.pageWidth, 1.0, parentControl.GetMonitorPixelsPerInch)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getParagraph(index as integer) As FTParagraph
		  
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
		Function getParagraphStart(p as FTParagraph) As integer
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim length as integer
		  Dim pid as integer
		  
		  ' Get the paragraph ID.
		  pid = p.getId
		  
		  ' Get the number of paragraphs.
		  count = Ubound(paragraphs)
		  
		  ' Add up the lengths of the proceeding paragraphs.
		  for i = 0 to count
		    
		    ' Is this the target paragraph?
		    if pid = paragraphs(i).getId then
		      
		      ' We are done.
		      exit
		      
		    end if
		    
		    ' Add in the length of the paragraph.
		    length = length + paragraphs(i).getLength
		    
		  next
		  
		  ' Return the length up to that paragraph.
		  return length
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getParagraphStart(index as integer) As integer
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim length as integer
		  
		  ' Only go to the previous paragraph.
		  count = index - 1
		  
		  ' Add up the lengths of the proceeding paragraphs.
		  for i = 0 to count
		    
		    ' Add in the length of the paragraph.
		    length = length + paragraphs(i).getLength
		    
		  next
		  
		  ' Return the length up to that paragraph.
		  return length
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getParagraphStyle(id as integer) As FTParagraphStyle
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim values() as Variant
		  
		  ' Get the list of styles.
		  values = paragraphStyles.values
		  
		  ' Get the number of styles.
		  count = Ubound(values)
		  
		  ' Scan the styles.
		  for i = 0 to count
		    
		    ' Is this the one we are looking for?
		    if FTParagraphStyle(values(i).ObjectValue).getId = id then
		      
		      ' Return the style.
		      return FTParagraphStyle(values(i).ObjectValue)
		      
		    end if
		    
		  next
		  
		  ' Style not found.
		  return defaultParagraphStyle
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getParagraphStyle(name as string = "") As FTParagraphStyle
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Does the style exist?
		  if paragraphStyles.HasKey(name) then
		    
		    ' Return the style.
		    return paragraphStyles.value(name)
		    
		  end if
		  
		  ' Style not found.
		  return defaultParagraphStyle
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getParagraphStyles() As Dictionary
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #EndIf
		  
		  
		  Return paragraphStyles
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getPictureAtOffset(offset as FTInsertionOffset) As FTPicture
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim fto as FTObject
		  Dim p as FTParagraph
		  
		  ' Get the target picture.
		  p = getParagraph(offset.paragraph)
		  
		  ' Make sure the positions are updated.
		  p.updatePositions
		  
		  ' Getthe item.
		  fto = p.getItem(p.findPictureItem(offset.offset))
		  
		  ' Is this a picture?
		  if fto isa FTPicture then
		    
		    ' Get the target picture.
		    return FTPicture(fto)
		    
		  else
		    
		    ' Nothing to return.
		    return nil
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getPreviousParagraph(index as integer) As FTParagraph
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Get the previous paragraph.
		  return getParagraph(index - 1)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getPrinterSetup() As Printersetup
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the printer setup object.
		  return printer
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getResizeHandle() As FTPicture.Handle_Type
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the handle that has been grabbed.
		  Return resizeHandle
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getResizeParagraph() As FTParagraph
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the paragraph containing the picture being resized.
		  return resizeParagraph
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getResizePicture() As FTPicture
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the picture being resized.
		  return resizePicture
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getRightMargin() As double
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the position of the margin.
		  return margins.rightMargin
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getRightMarginWidth() As double
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Compute the right margin in pixels.
		  return FTUtilities.getScaledLength(margins.rightMargin, 1.0)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getRTF() As string
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim rtf as RTFWriter
		  Dim keys() as variant
		  
		  ' Create the writer.
		  rtf = new RTFWriter
		  
		  '----------------------------------------
		  ' Character styles.
		  '----------------------------------------
		  
		  ' Get the keys.
		  keys = characterStyles.keys
		  
		  ' Get the number of keys.
		  count = Ubound(keys)
		  
		  ' Load up the character styles.
		  for i = 0 to count
		    
		    ' Get the RTF data from the style.
		    FTCharacterStyle(characterStyles.value(keys(i))).getRTF(rtf)
		    
		  next
		  
		  '----------------------------------------
		  ' Paragraph styles.
		  '----------------------------------------
		  
		  ' Get the keys.
		  keys = paragraphStyles.keys
		  
		  ' Get the number of keys.
		  count = Ubound(keys)
		  
		  ' Load up the character styles.
		  for i = 0 to count
		    
		    ' Get the RTF data from the style.
		    FTParagraphStyle(paragraphStyles.value(keys(i))).getRTF(rtf)
		    
		  next
		  
		  '----------------------------------------
		  'Info Group.
		  '----------------------------------------
		  
		  rtf.setInfoGroup(getXMLCreator, getXMLFileVersion)
		  
		  '----------------------------------------
		  ' Document attributes.
		  '----------------------------------------
		  
		  ' Set the document attributes.
		  rtf.setPageSize(getPageWidth, getPageHeight)
		  rtf.setDocumentMargins(getLeftMargin, getRightMargin, getTopMargin, getBottomMargin)
		  
		  '----------------------------------------
		  ' Paragraphs.
		  '----------------------------------------
		  
		  ' Get the number of paragraphs.
		  count = Ubound(paragraphs)
		  
		  ' Get the full paragraphs.
		  for i = 0 to count
		    
		    ' Get the RTF data from the paragraph.
		    paragraphs(i).getRTF(rtf)
		    
		  next
		  
		  '----------------------------------------
		  
		  ' Return the RTF data.
		  return rtf.getRTF
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getRTF(startPosition as FTInsertionOffset, endPosition as FTInsertionOffset) As string
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim rtf as RTFWriter
		  Dim keys() as variant
		  Dim segment as FTSegment
		  
		  ' Create the writer.
		  rtf = new RTFWriter
		  
		  '----------------------------------------
		  ' Character styles.
		  '----------------------------------------
		  
		  ' Get the keys.
		  keys = characterStyles.keys
		  
		  ' Get the number of keys.
		  count = Ubound(keys)
		  
		  ' Load up the character styles.
		  for i = 0 to count
		    
		    ' Get the RTF data from the style.
		    FTCharacterStyle(characterStyles.value(keys(i))).getRTF(rtf)
		    
		  next
		  
		  '----------------------------------------
		  ' Paragraph styles.
		  '----------------------------------------
		  
		  ' Get the keys.
		  keys = paragraphStyles.keys
		  
		  ' Get the number of keys.
		  count = Ubound(keys)
		  
		  ' Load up the character styles.
		  for i = 0 to count
		    
		    ' Get the RTF data from the style.
		    FTParagraphStyle(paragraphStyles.value(keys(i))).getRTF(rtf)
		    
		  next
		  
		  '----------------------------------------
		  'Info Group.
		  '----------------------------------------
		  
		  rtf.setInfoGroup(getXMLCreator, getXMLFileVersion)
		  
		  '----------------------------------------
		  ' Document attributes.
		  '----------------------------------------
		  
		  ' Set the document attributes.
		  rtf.setPageSize(getPageWidth, getPageHeight)
		  rtf.setDocumentMargins(getLeftMargin, getRightMargin, getTopMargin, getBottomMargin)
		  
		  '----------------------------------------
		  ' Paragraphs.
		  '----------------------------------------
		  
		  ' Get the specified segment.
		  segment = getSegment(startPosition, endPosition)
		  
		  ' Is there something to look at?
		  if not (segment is nil) then
		    
		    ' Get the number of paragraphs in the segment.
		    count = segment.getNumberOfParagraphs - 1
		    
		    ' Get the full paragraphs.
		    for i = 0 to count
		      
		      ' Get the RTF data from the paragraph.
		      segment.getParagraph(i).getRTF(rtf)
		      
		    next
		    
		  end if
		  
		  '----------------------------------------
		  
		  ' Return the RTF data.
		  return rtf.getRTF
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getSegment(startPosition as FTInsertionOffset, endPosition as FTInsertionOffset) As FTSegment
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim startIndex as integer
		  Dim endIndex as integer
		  Dim sp as FTParagraph
		  Dim ep as FTParagraph
		  Dim segment as FTSegment
		  
		  ' Create a new segment.
		  segment = new FTSegment
		  
		  ' Is there anything to look at?
		  if (startPosition is nil) or (endPosition is nil) then return segment
		  
		  ' Is there anything to look at?
		  if startPosition >= endPosition then return segment
		  
		  ' Get the paragraph information.
		  sp = getParagraph(startPosition.paragraph)
		  ep = getParagraph(endPosition.paragraph)
		  
		  ' Are we within range?
		  if (sp is nil) or (ep is nil) then return segment
		  
		  ' Is this the same paragraph?
		  if sp.getId = ep.getId then
		    
		    ' Get the partial paragraph.
		    segment.addParagraph(sp.clone(startPosition.offset + 1, endPosition.offset))
		    
		  else
		    
		    ' Get the segment from the first paragraph.
		    segment.addParagraph(sp.clone(startPosition.offset + 1, sp.getLength))
		    
		    ' Get the first full paragraph index.
		    startIndex = sp.getAbsoluteIndex + 1
		    endIndex = Ubound(paragraphs)
		    
		    ' Get the full paragraphs.
		    for i = startIndex to endIndex
		      
		      ' Are we done?
		      if paragraphs(i).getId = ep.getId then exit
		      
		      ' Get the paragraph.
		      segment.addParagraph(paragraphs(i))
		      
		    next
		    
		    ' Get the segment from the last paragraph.
		    segment.addParagraph(ep.clone(1, endPosition.offset))
		    
		  end if
		  
		  ' Return the segment.
		  return segment
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub getSelectedParagraphIndexes(ByRef startParagraph as integer, ByRef endParagraph as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim startIndex as FTInsertionOffset
		  Dim endIndex as FTInsertionOffset
		  
		  ' Is the text selected?
		  if isSelected then
		    
		    ' Get the range.
		    getSelectionRange(startIndex, endIndex)
		    
		    ' Convert to paragraph indexes.
		    startParagraph = startIndex.paragraph
		    endParagraph = endIndex.paragraph
		    
		  else
		    
		    ' Use the insertion point.
		    startIndex = getInsertionOffset
		    
		    ' Convert to paragraph indexes.
		    startParagraph = startIndex.paragraph
		    endParagraph = startParagraph
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getSelectedParagraphs() As FTParagraph()
		  //Issue 3794: FTDocument.getSelectedParagraphs returns first paragraph of multi-paragraph doc regardless of insertion point
		  #Pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim p as FTParagraph
		  Dim selectedParagraphs() as FTParagraph
		  Dim done as boolean
		  
		  ' Is anything selected? 
		  If isSelected Then
		    
		    ' Get the number of paragraphs. 
		    count = Ubound(paragraphs)
		    
		    ' Scan the paragraphs. 
		    For i = 0 To count
		      
		      ' Get a paragraph. 
		      p = paragraphs(i)
		      
		      ' Does this paragraph have something selected?
		      If p.hasSelection Then 
		        ' This return true if nothing is selected because the FTInsertionOffset
		        ' constructor used by FTInsertionOffset.clone will not allow paragraph number to be -1
		        
		        ' Save the reference. 
		        selectedParagraphs.append(p)
		        
		        ' We found one. 
		        done = True
		        
		      Else
		        
		        ' We are done looking.
		        If done Then Exit
		        
		      End
		    Next
		    
		  Else
		    
		    ' Use the paragraph with the insertion point.
		    selectedParagraphs.append(getInsertionPoint.getCurrentParagraph) 
		  End If
		  
		  ' Return the selected paragraphs.
		  return selectedParagraphs
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getSelectedXML(ByRef selectStart as FTinsertionOffset, ByRef selectEnd as FTInsertionOffset) As string
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim content as string
		  
		  ' Is something selected?
		  if isSelected then
		    
		    ' Get the range of the selection.
		    getSelectionRange(selectStart, selectEnd)
		    
		    ' Get the XML.
		    content = getXML(selectStart, selectEnd)
		    
		  else
		    
		    ' Use the current insertion point.
		    selectStart = getInsertionOffset
		    selectEnd = getInsertionOffset
		    
		  end if
		  
		  ' Return the selection.
		  return content
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getSelectionLength() As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim selectStart as FTInsertionOffset
		  Dim selectEnd as FTInsertionOffset
		  Dim length as integer
		  
		  ' Is anything selected?
		  if isSelected then
		    
		    ' Get the range of the selection.
		    getSelectionRange(selectStart, selectEnd)
		    
		    ' Is this an empty paragraph selection?
		    if selectStart = selectEnd then
		      
		      ' Is this empty paragraph selected?
		      if (selectStart.bias = true) and (selectEnd.bias = false) then
		        
		        ' This is an empty paragraph.
		        length = 1
		        
		      end if
		      
		    else
		      
		      ' Get the selection length.
		      length = selectEnd - selectStart
		      
		      ' Is the last paragraph an empty paragraph?
		      if selectEnd.isEndOfParagraph and (selectEnd.getParagraph.getLength = 0) then
		        
		        ' Adjust the length.
		        length = length + 1
		        
		      end if
		      
		    end if
		    
		  end if
		  
		  ' Return the length.
		  return length
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub getSelectionRange(ByRef selectStart as FTInsertionOffset, ByRef selectEnd as FTInsertionOffset)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Are we in resize mode?
		  if isInResizeMode then
		    
		    ' Get the range of the picture.
		    selectStart = new FTInsertionOffset(self, resizeParagraph.getAbsoluteIndex, _
		    resizePicture.getStartPosition - 1)
		    selectEnd = selectStart + 1
		    
		  else
		    
		    ' Return the selection range.
		    selectStart = me.selectStart.clone
		    selectEnd = me.selectEnd.clone
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getStartOfPageDistance(pageIndex as integer) As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Get the distance to the start of the page.
		  return pageIndex * ((parentControl.getScale * getPageHeightLength) + getPageSpace)
		  
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
		  Dim lastFullParagraph as integer
		  Dim sa() as string
		  
		  ' Get the number of paragraphs.
		  count = Ubound(paragraphs)
		  
		  ' Go to the next to last paragraph
		  lastFullParagraph = count - 1
		  
		  ' Get the full paragraphs.
		  for i = 0 to lastFullParagraph
		    
		    ' Get the text from the paragraph.
		    sa.append(paragraphs(i).getText + endOfLine.Macintosh)
		    
		  next
		  
		  ' Is there any leftover text?
		  if count > -1 then
		    
		    ' Add the last paragraph.
		    sa.append(paragraphs(count).getText)
		    
		  end if
		  
		  ' Return the text string.
		  return join(sa, "")
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getText(startPosition as FTInsertionOffset, endPosition as FTInsertionOffset) As string
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim startIndex as integer
		  Dim endIndex as integer
		  Dim sp as FTParagraph
		  Dim ep as FTParagraph
		  Dim text as string
		  Dim sa() as string
		  
		  ' Get the paragraph information.
		  sp = getParagraph(startPosition.paragraph)
		  ep = getParagraph(endPosition.paragraph)
		  
		  ' Are we within range?
		  if (sp is nil) or (ep is nil) then return ""
		  
		  ' Is this the same paragraph?
		  if sp.getId = ep.getId then
		    
		    ' Delete the text from the paragraph.
		    text = sp.getText(startPosition.offset + 1, endPosition.offset)
		    
		  else
		    
		    ' Get the text from the first paragraph.
		    sa.append(sp.getText(startPosition.offset + 1, sp.getLength) + endOfLine.Macintosh)
		    
		    ' Get the first full paragraph index.
		    startIndex = sp.getAbsoluteIndex + 1
		    endIndex = Ubound(paragraphs)
		    
		    ' Get the full paragraphs.
		    for i = startIndex to endIndex
		      
		      ' Are we done?
		      if paragraphs(i).getId = ep.getId then exit
		      
		      ' Get the text from the paragraph.
		      sa.append(paragraphs(i).getText + endOfLine.Macintosh)
		      
		    next
		    
		    ' Get the text from the first paragraph.
		    sa.append(ep.getText(1, endPosition.offset))
		    
		    ' Put all the segments together.
		    text = join(sa, "")
		    
		  end if
		  
		  ' Return the text string.
		  return text
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getTopMargin() As double
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the top margin.
		  return margins.topMargin
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getTopMarginWidth() As double
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Compute the top margin in pixels.
		  return FTUtilities.getScaledLength(margins.topMargin, 1.0)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getTotalPageLength() As double
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Are we in a page view?
		  if parentControl.isPageViewMode then
		    
		    ' Get the total length of the pages.
		    return getNumberOfPages * ((parentControl.getScale * getPageHeightLength) + getPageSpace)
		    
		  else
		    
		    ' Get the total length of the display area.
		    return (getPageHeightLength * min(parentControl.getScale, 1.0)) + _
		    FTUtilities.getScaledLength(getTopMargin + getBottomMargin, parentControl.getScale)
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getWordCount() As integer
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim p as FTParagraph
		  Dim wordCount as integer
		  
		  ' Sum up the word count.
		  for each p in paragraphs
		    
		    ' Add in the word count of the paragraph.
		    wordCount = wordCount + p.getWordCount
		    
		  next
		  
		  ' Return the number of words.
		  return wordCount
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getXML() As string
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim xmlDoc as XmlDocument
		  Dim root as XmlElement
		  Dim para as XmlElement
		  Dim p as XmlElement
		  
		  ' Create the document and populate the header.
		  createXmlDocument(xmlDoc, root)
		  
		  ' Create the paragraphs node.
		  para = XmlElement(root.AppendChild(xmlDoc.CreateElement(FTCxml.XML_PARAGRAPHS)))
		  
		  ' Get the number of paragraphs.
		  count = Ubound(paragraphs)
		  
		  ' Get the full paragraphs.
		  for i = 0 to count
		    
		    ' Create the paragraph node.
		    p = XmlElement(para.AppendChild(xmlDoc.CreateElement(FTCxml.XML_FTPARAGRAPH)))
		    
		    ' Get the xml from the paragraph.
		    paragraphs(i).getXML(xmlDoc, p)
		    
		  next
		  
		  ' Get the tag data.
		  super.getXMLTagData(root)
		  
		  ' Save any additional custom nodes.
		  SaveXML(xmlDoc, root)
		  
		  ' Return the xml string.
		  return xmlDoc.ToString
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getXML(startPosition as FTInsertionOffset, endPosition as FTInsertionOffset) As string
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim xmlDoc as XmlDocument
		  Dim root as XmlElement
		  Dim para as XmlElement
		  Dim p as XmlElement
		  Dim segment as FTSegment
		  
		  ' Create the document and populate the header.
		  createXmlDocument(xmlDoc, root)
		  
		  ' Create the paragraphs node.
		  para = XmlElement(root.AppendChild(xmlDoc.CreateElement(FTCxml.XML_PARAGRAPHS)))
		  
		  ' Get the specified segment.
		  segment = getSegment(startPosition, endPosition)
		  
		  ' Is there something to look at?
		  if not (segment is nil) then
		    
		    ' Get the number of paragraphs in the segment.
		    count = segment.getNumberOfParagraphs - 1
		    
		    ' Get the full paragraphs.
		    for i = 0 to count
		      
		      ' Create the paragraph node.
		      p = XmlElement(para.AppendChild(xmlDoc.CreateElement(FTCxml.XML_FTPARAGRAPH)))
		      
		      ' Get the xml from the paragraph.
		      segment.getParagraph(i).getXML(xmlDoc, p)
		      
		    next
		    
		  end if
		  
		  ' Get the tag data.
		  super.getXMLTagData(root)
		  
		  ' Return the xml string.
		  return xmlDoc.ToString
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub getXMLCharacterStyleAttributes(xmlDoc as XmlDocument, parent as XmlElement)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim item as FTCharacterStyle
		  Dim cs as XmlElement
		  Dim values() as variant
		  
		  ' Get the character styles.
		  values = characterStyles.values
		  
		  ' Encode all the character styles.
		  for each item in values
		    
		    ' Create the character style node.
		    cs = XmlElement(parent.AppendChild(xmlDoc.CreateElement("FTCharacterStyle")))
		    
		    ' Get the xml from the character style.
		    item.getXML(cs)
		    
		    ' Get the tag data.
		    item.getXMLTagData(cs)
		    
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getXMLCreator() As string
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the xml creator application.
		  return xmlCreator
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub getXMLDocumentAttributes(document as XmlElement)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Load up the attributes.
		  document.SetAttribute(FTCxml.XML_BOTTOM_MARGIN, str(margins.bottomMargin))
		  document.SetAttribute(FTCxml.XML_LEFT_MARGIN, str(margins.leftMargin))
		  document.SetAttribute(FTCxml.XML_PAGE_BACKGROUND_COLOR, FTUtilities.colorToString(pageBackgroundColor))
		  document.SetAttribute(FTCxml.XML_PAGE_HEIGHT, str(docMargins.pageHeight))
		  document.SetAttribute(FTCxml.XML_PAGE_WIDTH, str(docMargins.pageWidth))
		  document.SetAttribute(FTCxml.XML_RIGHT_MARGIN, str(margins.rightMargin))
		  document.SetAttribute(FTCxml.XML_TOP_MARGIN, str(margins.topMargin))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getXMLDocumentTag() As string
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the tag.
		  return xmlDocumentTag
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getXMLFileType() As string
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the XML file type.
		  return xmlFileType
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getXMLFileVersion() As string
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the XML file version.
		  return xmlFileVersion
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub getXMLParagraphStyleAttributes(xmlDoc as XmlDocument, parent as XmlElement)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim item as FTParagraphStyle
		  Dim ps as XmlElement
		  Dim values() as variant
		  
		  ' Get the paragraph styles.
		  values = paragraphStyles.values
		  
		  ' Create the default paragraph style node.
		  ps = XmlElement(parent.AppendChild(xmlDoc.CreateElement("FTParagraphStyle")))
		  
		  ' Get the xml from the paragraph style.
		  defaultParagraphStyle.getXML(ps)
		  
		  ' Get the tag data.
		  defaultParagraphStyle.getXMLTagData(ps)
		  
		  ' Encode all the paragraph styles.
		  for each item in values
		    
		    ' Create the paragraph style node.
		    ps = XmlElement(parent.AppendChild(xmlDoc.CreateElement("FTParagraphStyle")))
		    
		    ' Get the xml from the paragraph style.
		    item.getXML(ps)
		    
		    ' Get the tag data.
		    item.getXMLTagData(ps)
		    
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub getXMLVersionAttributes(version as XmlElement)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Load up the attributes.
		  version.SetAttribute(FTCxml.XML_CREATOR, getXMLCreator)
		  version.SetAttribute(FTCxml.XML_FILE_TYPE, getXMLFileType)
		  version.SetAttribute(FTCxml.XML_FILE_VERSION, getXMLFileVersion)
		  version.SetAttribute(FTCxml.XML_DOCUMENT_TAG, getXMLDocumentTag)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function hasCharacterStyle(name as string) As boolean
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim values() as Variant
		  
		  ' Extract the list of styles.
		  values = characterStyles.Values
		  
		  ' Get the number of entries.
		  count = Ubound(values)
		  
		  ' Scan the styles.
		  for i = 0 to count
		    
		    ' Does the style exist?
		    if FTCharacterStyle(values(i)).getStyleName = name then
		      
		      ' We found it.
		      return true
		      
		    end if
		    
		  next
		  
		  ' Not found.
		  return false
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasContent() As Boolean
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  if  Paragraphs.Ubound>-1 then
		    if Paragraphs(0).HasContent then
		      Return true
		      
		    end if
		  end if
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function hasDirtyParagraphs() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the state of the paragraphs.
		  return (dirtyIndexes.count > 0)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function hasParagraphStyle(name as string) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Does the style exist?
		  return paragraphStyles.HasKey(name)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function inSameWord(offset1 as FTInsertionOffset, offset2 as FTInsertionOffset) As boolean
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim startOffset as integer
		  Dim endOffset as integer
		  Dim text as string
		  
		  ' Is one of the offsets not set?
		  if not (offset1.isSet and offset2.isSet) then return false
		  
		  ' Are we in the same paragraph?
		  if offset1.paragraph <> offset2.paragraph then return false
		  
		  ' Are they the same offsets
		  if offset1.offset = offset2.offset then return true
		  
		  ' Do we need to swap?
		  if offset1.offset > offset2.offset then
		    
		    ' Swap them.
		    startOffset = offset2.offset
		    endOffset = offset1.offset
		    
		  else
		    
		    ' Use as is.
		    startOffset = offset1.offset
		    endOffset = offset2.offset
		    
		  end if
		  
		  ' Make it one based.
		  startOffset = startOffset + 1
		  
		  ' Get the text from the paragraph.
		  text = paragraphs(offset1.paragraph).getText(true)
		  
		  ' Scan for a word divider.
		  for i = startOffset to endOffset
		    
		    ' Is this character a word divider?
		    if FTUtilities.isWordDivider(mid(text, i, 1)) then
		      
		      ' We are not in the same word.
		      return false
		      
		    end if
		    
		  next
		  
		  ' We are in the same word.
		  return true
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function insertionPointToOffset(paragraphIndex as integer, paragraphOffset as integer = 0) As integer
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim length as integer
		  
		  ' Is there anything to do?
		  if paragraphIndex < 0 then return 0
		  
		  ' Check the offset range.
		  if paragraphOffset < 0 then paragraphOffset = 0
		  
		  ' Get the number of paragraphs to scan.
		  count = paragraphIndex - 1
		  
		  ' Are we past the end?
		  if count > Ubound(paragraphs) then
		    
		    ' Use the last paragraph index.
		    count = Ubound(paragraphs)
		    paragraphIndex = count
		    
		  end if
		  
		  ' Scan the paragraphs.
		  for i = 0 to count
		    
		    ' Add in the length of the paragraph.
		    length = length + paragraphs(i).getLength
		    
		  next
		  
		  ' Is there something to look at?
		  if paragraphIndex <= Ubound(paragraphs) then
		    
		    ' Are we past the end of the paragraph?
		    if paragraphOffset > paragraphs(paragraphIndex).getLength then
		      
		      ' Use the length of the paragraph.
		      paragraphOffset = paragraphs(paragraphIndex).getLength
		      
		    end if
		    
		  else
		    
		    ' We are at the end.
		    paragraphOffset = 0
		    
		  end if
		  
		  ' Return the offset.
		  return length + paragraphOffset
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function insertNewParagraph() As FTParagraph
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim p as FTParagraph
		  
		  ' Create the duplicate paragraph.
		  p = new FTParagraph(parentControl, 0, defaultParagraphStyle.getId)
		  
		  ' Add the paragraph.
		  paragraphs.insert(0, p)
		  
		  ' Update the indexes.
		  updateParagraphIndexes(0)
		  
		  ' Make the paragraph dirty.
		  p.makeDirty
		  
		  ' Return the new paragraph.
		  return p
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function insertNewParagraph(io as FTInsertionOffset) As FTParagraph
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim p as FTParagraph
		  
		  ' Get the current paragraph.
		  p = getParagraph(io.paragraph)
		  
		  ' Is there anything to insert into?
		  if p is nil then return nil
		  
		  ' Insert the paragraph.
		  return insertNewParagraph(p, io.offset)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function insertNewParagraph(cp as FTParagraph, offset as integer) As FTParagraph
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim p as FTParagraph
		  Dim leftOvers() as FTObject
		  
		  ' Make sure the positions are correct.
		  cp.updatePositions(true)
		  
		  ' Add the paragraph.
		  p = addNewParagraph(cp)
		  
		  ' Get the left overs from the paragraph.
		  leftOvers = cp.getLeftOvers(offset + 1)
		  
		  ' Do we have leftovers to add?
		  if Ubound(leftOvers) > -1 then
		    
		    ' Clear the paragraph.
		    p.clearItems
		    
		  end if
		  
		  ' Add the left overs from the previous paragraph.
		  p.addObjects(leftOvers)
		  
		  ' Move the insertion point.
		  insertionPoint.setInsertionPoint(p, 0, true)
		  
		  ' Return the new paragraph.
		  return p
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub insertObject(fto as FTObject)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim p as FTParagraph
		  Dim objectList(0) as FTObject
		  
		  ' Is there anything to insert?
		  if fto is nil then return
		  
		  ' Is there something to insert into?
		  if not (insertionPoint.getCurrentParagraph is nil) then
		    
		    ' Is anything selected?
		    if isSelected then
		      
		      ' Delete the selected text.
		      deleteSelected
		      
		    end if
		    
		    ' Get the current paragraph.
		    p = insertionPoint.getCurrentParagraph
		    
		    ' Put the object into the container.
		    objectList(0) = fto
		    
		    ' Add the picture.
		    p.insertObjects(insertionPoint.getOffset.offset, objectList)
		    
		    ' Update the positions in the paragraph.
		    p.updatePositions
		    
		    ' Set the hint for composing lines.
		    p.setComposeLinesHint(insertionPoint.getOffset.offset)
		    
		    ' Move the insertion point.
		    insertionPoint.setInsertionPoint(insertionPoint.getOffset + 1, false)
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub insertPageBreak(io as FTInsertionOffset)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim p as FTParagraph
		  
		  ' Create a new paragraph.
		  p = insertNewParagraph(io)
		  
		  ' Mark the paragraph as a page break.
		  p.setPageBreak(true)
		  
		  ' Mark the paragraphs for spell checking.
		  markDirtyParagraphsForSpellCheck
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function insertParagraph(p as FTParagraph, index as integer) As FTParagraph
		  #Pragma Unused index
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim pClone as FTParagraph
		  
		  ' Create a clone.
		  pClone = p.clone
		  pclone.parentControl = Self.parentControl
		  
		  ' Add the clone to the paragraph list.
		  ' paragraphs.Insert(index, pClone)
		  
		  Paragraphs.Append(pClone)
		  
		  ' Return the newly added paragraph.
		  return pClone
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub insertPicture(ftp as FTPicture)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim p as FTParagraph
		  Dim lineCount as integer
		  
		  ' Is there anything to insert?
		  if ftp is nil then return
		  
		  ' Allow the developer to resize the picture.
		  checkPicture(ftp)
		  
		  ' Is there something to insert into?
		  if not (insertionPoint.getCurrentParagraph is nil) then
		    
		    ' Get the current paragraph.
		    p = insertionPoint.getCurrentParagraph
		    
		    ' Get the current line count.
		    lineCount = p.getLineCount
		    
		    ' Is anything selected?
		    if isSelected then
		      
		      ' Delete the selected text.
		      deleteSelected
		      
		    end if
		    
		    ' Add the picture.
		    p.insertPicture(insertionPoint.getOffset.offset, ftp)
		    
		    ' Set the hint for composing lines.
		    p.setComposeLinesHint(insertionPoint.getOffset.offset)
		    
		    ' Move the insertion point.
		    insertionPoint.setInsertionPoint(insertionPoint.getOffset + 1, true)
		    
		    ' Mark the paragraphs for spell checking.
		    markDirtyParagraphsForSpellCheck
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub insertPicture(pic as Picture)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Is there anything to insert?
		  if pic is nil then return
		  
		  ' Insert the new picture.
		  insertPicture(new FTPicture(parentControl, pic))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function insertRtfString(s as string) As boolean
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim reader as FtcRtfReader
		  
		  ' Is there anything to do?
		  if s.lenb = 0 then return false
		  
		  ' Is there something to insert into?
		  if not (insertionPoint.getCurrentParagraph is nil) then
		    
		    ' Is anything selected?
		    if isSelected then
		      
		      ' Delete the selected text.
		      deleteSelected
		      
		    end if
		    
		    ' Create the reader.
		    reader = new FtcRtfReader(self, false, false)
		    
		    ' Parse the data.
		    reader.parse(s)
		    
		  end if
		  
		  ' Mark the paragraphs for spell checking.
		  markDirtyParagraphsForSpellCheck
		  
		  ' Return the compose pages flag.
		  return true
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub insertSegment(segment as FTSegment)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim cw as FTCConverterWindow
		  Dim doc as FTDocument
		  
		  ' Create a converter window.
		  cw = new FTCConverterWindow
		  
		  ' Adopt all the paragraphs.
		  segment.setParent(cw.Target)
		  
		  ' Get the target document.
		  doc = cw.Target.getDoc
		  
		  ' Clear out the paragraphs.
		  doc.clearParagraphs
		  
		  ' Get the number of paragraphs we are going to add.
		  count = segment.getNumberOfParagraphs - 1
		  
		  ' Is there anything in the segment?
		  if count > -1 then
		    
		    ' Add all the segment paragraphs.
		    for i = 0 to count
		      
		      ' Add the paragraph.
		      doc.paragraphs.Append(segment.getParagraph(i).clone)
		      
		    next
		    
		  else
		    
		    ' Add a blank paragraph.
		    call doc.addNewParagraph
		    
		  end if
		  
		  ' Mark the paragraphs for spell checking.
		  markDirtyParagraphsForSpellCheck
		  
		  ' Compose all the paragraphs
		  doc.compose
		  
		  ' Insert the segment data.
		  insertXml(doc.getXML, false, false)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub insertString(s as string, style as FTCharacterStyle = nil)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim p as FTParagraph
		  Dim segments() as string
		  Dim lineCount as integer
		  
		  ' Is there anything to do?
		  if s.lenb = 0 then return
		  
		  ' Prepare the text.
		  s = FTUtilities.prepareText(s)
		  
		  ' Is there something to insert into?
		  if insertionPoint.getCurrentParagraph is nil then return
		  
		  ' Is this a new line?
		  if s = EndOfLine.Macintosh then
		    
		    ' Is anything selected?
		    if isSelected then
		      
		      ' Delete the selected text.
		      deleteSelected
		      
		    end if
		    
		    ' Insert a new paragraph.
		    p = insertNewParagraph(insertionPoint.getOffset)
		    
		    ' The new paragraph should not use a page break.
		    p.setPageBreak(false)
		    
		    ' Is this a tab character?
		  elseif s = Chr(9) then
		    
		    ' Is anything selected?
		    if isSelected then
		      
		      ' Delete the selected text.
		      deleteSelected
		      
		    end if
		    
		    ' Insert a tab character.
		    insertTabCharacter(insertionPoint.getOffset)
		    
		  else
		    
		    ' Get the current paragraph.
		    p = insertionPoint.getCurrentParagraph
		    
		    ' Break the string into segments.
		    segments = segmentString(s)
		    
		    ' Get the number of segments.
		    count = Ubound(segments)
		    
		    ' Insert the segments.
		    for i = 0 to count
		      
		      ' Extract the segment.
		      s = segments(i)
		      
		      ' Is this an end of line?
		      if s = EndOfLine.Macintosh then
		        
		        ' Is anything selected?
		        if isSelected then
		          
		          ' Delete the selected text.
		          deleteSelected
		          
		        end if
		        
		        ' Create a new paragraph.
		        p = insertNewParagraph(insertionPoint.getOffset)
		        
		        ' The new paragraph should not use a page break.
		        p.setPageBreak(false)
		        
		        ' Insert the style if needed.
		        insertStyleAtInsertion(p, 0, style)
		        
		        ' Is this a tab character?
		      elseif s = Chr(9) then
		        
		        ' Is anything selected?
		        if isSelected then
		          
		          ' Delete the selected text.
		          deleteSelected
		          
		        end if
		        
		        ' Insert a tab character.
		        insertTabCharacter(insertionPoint.getOffset)
		        
		      else
		        
		        ' Get the current line count.
		        lineCount = p.getLineCount
		        
		        ' Is anything selected?
		        if isSelected then
		          
		          ' Delete the selected text.
		          deleteSelected
		          
		        end if
		        
		        ' Get the current paragraph.
		        p = insertionPoint.getCurrentParagraph
		        
		        ' Insert the style if needed.
		        insertStyleAtInsertion(p, insertionPoint.getOffset.offset, style)
		        
		        ' Add the text.
		        p.insertString(insertionPoint.getOffset.offset, segments(i))
		        
		        ' Set the hint for composing lines.
		        p.setComposeLinesHint(insertionPoint.getOffset.offset)
		        
		        ' Move the insertion point.
		        insertionPoint.setInsertionPoint(insertionPoint.getOffset + segments(i).len, true)
		        
		        ' Update the positions in the paragraph.
		        p.updatePositions
		        
		      end if
		      
		    next
		    
		  end if
		  
		  ' Mark the paragraphs for spell checking.
		  markDirtyParagraphsForSpellCheck
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub insertStyleAtInsertion(p as FTParagraph, offset as integer, style as FTCharacterStyle)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim sr as FTStyleRun
		  Dim container(0) as FTStyleRun
		  Dim obj as FTObject
		  
		  ' Is there anything to do?
		  if style is nil then return
		  
		  ' Get the item.
		  obj = p.getItem(p.findItem(offset, true)).clone
		  
		  ' Can we put in a style?
		  if not (obj isa FTStyleRun) then return
		  
		  ' Create the style run.
		  sr = FTStyleRun(obj)
		  
		  ' Should we insert a place holder style?
		  if not sr.isSameCharacterStyle(style) then
		    
		    ' Clear any residual text.
		    sr.setText("", 0)
		    
		    ' Let the optimizer pass over it.
		    FTStyleRun(sr).setSaveState(true)
		    
		    ' Populate the style run with the style.
		    sr.updateWithStyle(style)
		    
		    ' Insert the style run.
		    container(0) = sr
		    p.insertObjects(offset, container)
		    
		    ' Update the style run positions.
		    p.updatePositions
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub insertTabCharacter(io as FTInsertionOffset)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Insert the tab character.
		  getParagraph(io.paragraph).insertTabCharacter(io.offset)
		  
		  ' Move the insertion point.
		  insertionPoint.setInsertionPoint(io + 1, true)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub insertXml(s as string, useAttributes as boolean, forceAttributes as boolean)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim xmlDoc as XmlDocument
		  Dim root as XmlElement
		  Dim item as XmlElement
		  
		  ' Is there anything to do?
		  if s.lenb = 0 then return
		  
		  ' Is there something to insert into?
		  if not (insertionPoint.getCurrentParagraph is nil) then
		    
		    ' Is anything selected?
		    if isSelected then
		      
		      ' Delete the selected text.
		      deleteSelected
		      
		    end if
		    
		    ' Parse the xml data.
		    xmlDoc = new XmlDocument(s)
		    
		    ' Get the root node.
		    root = xmlDoc.DocumentElement
		    
		    ' Set the tag.
		    parentControl.callXmlDecodeTag(root.GetAttribute(FTCxml.XML_TAG), self)
		    
		    ' Get the first item.
		    item = XmlElement(root.FirstChild)
		    
		    ' Load the document.
		    while not (item is nil)
		      
		      ' Parse on the element name.
		      select case item.Name
		        
		      case FTCxml.XML_PARAGRAPHS
		        
		        xmlHandleInsertParagraphs(item, useAttributes, forceAttributes)
		        
		      end select
		      
		      ' Get the next item.
		      item = XmlElement(item.NextSibling)
		      
		    wend
		    
		  end if
		  
		  ' Mark the paragraphs for spell checking.
		  markDirtyParagraphsForSpellCheck
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isInResizeMode() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Are we resizing a picture?
		  return not (resizePicture is nil)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isOffsetBetweenLines(offset as FTInsertionOffset) As boolean
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim p as FTParagraph
		  Dim line as FTLine
		  Dim currentLength as integer
		  
		  ' Are we at the beginning?
		  if offset.offset = 0 then return true
		  
		  ' Get the paragraph.
		  p = getParagraph(offset.paragraph)
		  
		  ' Get the number of lines.
		  count = p.getLineCount - 1
		  
		  ' Scan for the end of the line.
		  for i = 0 to count
		    
		    ' Get a line.
		    line = p.getLine(i)
		    
		    ' Are we at the decision point?
		    if currentLength >= offset.offset then
		      
		      ' We are possibly in between lines.
		      return offset.offset = currentLength
		      
		    end if
		    
		    ' Add in the length of the line.
		    currentLength = currentLength + line.getLength
		    
		  next
		  
		  ' We are in the middle of a line.
		  return false
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isPageVisible(page as integer, vScrollValue as integer, displayHeight as integer) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim firstPage as integer
		  Dim lastPage as integer
		  
		  ' Find the first visible page.
		  firstPage = findVisiblePage(abs(vScrollValue))
		  
		  ' Are we before the first visible page?
		  if page < firstPage then
		    
		    return false
		    
		  end if
		  
		  ' Find the last visible page.
		  lastPage = findVisiblePage(abs(vScrollValue) + displayHeight)
		  
		  ' Return the visible status.
		  return ((page >= firstPage) and (page <= lastPage))
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isPointInPicture(x as integer, y as integer, vScrollValue as integer, displayHeight as integer, ByRef p as FTParagraph, ByRef pic as FTPicture) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim firstPage as integer
		  Dim lastPage as integer
		  Dim targetPage as integer
		  Dim pageLength as integer
		  Dim pageWidth as integer
		  Dim pp as FTParagraphProxy
		  Dim page as FTPage
		  Dim pageX as integer
		  Dim pageY as integer
		  Dim scale as double
		  Dim ignore as integer
		  Dim adjustedY as integer
		  
		  ' Find the first visible page.
		  firstPage = findVisiblePage(abs(vScrollValue))
		  
		  ' Find the last visible page.
		  lastPage = findVisiblePage(abs(vScrollValue) + displayHeight)
		  
		  ' Check the range of the last page.
		  if lastPage > Ubound(pages) then lastPage = Ubound(pages)
		  
		  ' Get the scale.
		  scale = parentControl.getDisplayScale
		  
		  ' Get the length of a page.
		  pageLength = (scale * getPageHeightLength) + pageSpace
		  pageWidth = scale * getPageWidthLength
		  
		  ' Calculate the page.
		  targetPage = findVisiblePage(abs(vScrollValue) + y)
		  
		  ' Are we within the pages vertically?
		  if targetPage > lastPage then
		    
		    ' We are done.
		    return false
		    
		  end if
		  
		  ' Get the target page.
		  page = pages(targetPage)
		  
		  ' Convert to page coordinates.
		  parentControl.convertDisplayToPageCoordinates(x, y, ignore, pageX, pageY)
		  
		  ' Save the Y coordinate.
		  adjustedY = pageY
		  
		  ' Are we scaling down?
		  if scale < 1.0 then
		    
		    ' Scale up to 100%.
		    pageX = pageX / scale
		    pageY = pageY / scale
		    adjustedY = pageY
		    
		  end if
		  
		  ' Find the target paragraph.
		  pp = page.findParagraph(pageX, adjustedY, parentControl.getDisplayScale, true)
		  
		  ' Was the click in a paragraph?
		  if not (pp is nil) then
		    
		    ' Are we in edit view mode?
		    if not parentControl.isPageViewMode then
		      
		      ' Convert to display mode coordinates.
		      pageY = pageY - abs(vScrollValue)
		      
		    end if
		    
		    ' Get the picture.
		    pic = pp.isPointInPicture(pageX, pageY, parentControl.getDisplayScale)
		    
		    ' Is the point in a picture?
		    if not (pic is nil) then
		      
		      ' Get the parent paragraph.
		      p = pp.getParent
		      
		      ' We found a picture.
		      return true
		      
		    end if
		    
		  end if
		  
		  ' Clear the variables.
		  p = nil
		  pic = nil
		  
		  ' The point is not in the picture.
		  return false
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isPositionSelected(position as FTInsertionOffset) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim selectStart as FTInsertionOffset
		  Dim selectEnd as FTInsertionOffset
		  
		  ' Is anything selected?
		  if isSelected then
		    
		    ' Get the selected range.
		    getSelectionRange(selectStart, selectEnd)
		    
		    ' Are we within the selected text?
		    return (position >= selectStart) and (position <= selectEnd)
		    
		  end if
		  
		  ' Not in a selection.
		  return false
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isSelected() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Pictures in resize mode are considered selected.
		  if isInResizeMode then return true
		  
		  ' Is anything selected?
		  return selectEnd.isSet
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub makeFontBigger(startPosition as FTInsertionOffset, endPosition as FTInsertionOffset)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim index as integer
		  Dim startId as integer
		  Dim sp as FTParagraph
		  Dim ep as FTParagraph
		  
		  ' Get the paragraph information.
		  sp = getParagraph(startPosition.paragraph)
		  ep = getParagraph(endPosition.paragraph)
		  
		  ' Are we within range?
		  if (sp is nil) or (ep is nil) then return
		  
		  ' Is this the same paragraph?
		  if sp.getId = ep.getId then
		    
		    ' Change the style of the paragraph.
		    sp.makeFontBigger(startPosition.offset + 1, endPosition.offset)
		    
		  else
		    
		    ' Get the starting paragraph ID.
		    startId = sp.getId
		    
		    ' Get the first full paragraph index.
		    index = ep.getAbsoluteIndex - 1
		    
		    ' Delete the full paragraphs.
		    for i = index downto 0
		      
		      ' Are we at the end?
		      if paragraphs(i).getId = startId then
		        
		        ' We are done.
		        exit
		        
		      end if
		      
		      ' Change the font size of the paragraph.
		      paragraphs(i).makeFontBigger()
		      
		    next
		    
		    '----------------
		    
		    ' Is whole first paragraph selected?
		    if startPosition.offset = 0 then
		      
		      ' Change the size of the entire first paragraph.
		      sp.makeFontBigger()
		      
		    else
		      
		      ' Change the size of the first paragraph.
		      sp.makeFontBigger(startPosition.offset + 1, sp.getLength)
		      
		    end if
		    
		    '----------------
		    
		    ' Is whole last paragraph selected?
		    if endPosition.offset >= ep.getLength then
		      
		      ' Change the size of the entire last paragraph.
		      ep.makeFontBigger()
		      
		    else
		      
		      ' Change the size of the last paragraph.
		      ep.makeFontBigger(0, endPosition.offset)
		      
		    end if
		    
		  end if
		  
		  ' Make sure the selection is correct.
		  reselect
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub makeFontSmaller(startPosition as FTInsertionOffset, endPosition as FTInsertionOffset)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim index as integer
		  Dim startId as integer
		  Dim sp as FTParagraph
		  Dim ep as FTParagraph
		  
		  ' Get the paragraph information.
		  sp = getParagraph(startPosition.paragraph)
		  ep = getParagraph(endPosition.paragraph)
		  
		  ' Are we within range?
		  if (sp is nil) or (ep is nil) then return
		  
		  ' Is this the same paragraph?
		  if sp.getId = ep.getId then
		    
		    ' Change the style of the paragraph.
		    sp.makeFontSmaller(startPosition.offset + 1, endPosition.offset)
		    
		  else
		    
		    ' Get the starting paragraph ID.
		    startId = sp.getId
		    
		    ' Get the first full paragraph index.
		    index = ep.getAbsoluteIndex - 1
		    
		    ' Delete the full paragraphs.
		    for i = index downto 0
		      
		      ' Are we at the end?
		      if paragraphs(i).getId = startId then
		        
		        ' We are done.
		        exit
		        
		      end if
		      
		      ' Change the font size of the paragraph.
		      paragraphs(i).makeFontSmaller()
		      
		    next
		    
		    '----------------
		    
		    ' Is whole first paragraph selected?
		    if startPosition.offset = 0 then
		      
		      ' Change the size of the entire first paragraph.
		      sp.makeFontSmaller()
		      
		    else
		      
		      ' Change the size of the first paragraph.
		      sp.makeFontSmaller(startPosition.offset + 1, sp.getLength)
		      
		    end if
		    
		    '----------------
		    
		    ' Is whole last paragraph selected?
		    if endPosition.offset >= ep.getLength then
		      
		      ' Change the size of the entire last paragraph.
		      ep.makeFontSmaller()
		      
		    else
		      
		      ' Change the size of the last paragraph.
		      ep.makeFontSmaller(0, endPosition.offset)
		      
		    end if
		    
		  end if
		  
		  ' Make sure the selection is correct.
		  reselect
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub markAllPagesDirty()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' We are doing a deletion of paragraphs.
		  allPagesDirty = true
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub markAllParagraphsDirty()
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim p as FTParagraph
		  
		  ' Clear all the dirty paragraphs.
		  clearDirtyParagraphs
		  
		  ' Mark all the paragraphs as dirty.
		  for each p in paragraphs
		    
		    ' Make it dirty.
		    p.makeDirty
		    
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub markAllVisibleParagraphsDirty(preslop as integer, postSlop as integer)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim firstPage as integer
		  Dim lastPage as integer
		  Dim vScrollValue as integer
		  
		  ' Get the top of the display.
		  vScrollValue = parentControl.getYDisplayPosition
		  
		  ' Are we in page view mode?
		  if parentControl.isPageViewMode then
		    
		    ' Find the first visible page.
		    firstPage = findVisiblePage(abs(vScrollValue)) - preslop
		    
		    ' Find the last visible page.
		    lastPage = findVisiblePage(abs(vScrollValue) + parentControl.getDisplayHeight) + postslop
		    
		    ' Are we out of range?
		    if firstPage < 0 then firstPage = 0
		    if lastPage > Ubound(pages) then lastPage = Ubound(pages)
		    
		    ' Mark all the visible pages as dirty.
		    for i = firstPage to lastPage
		      
		      ' Mark the page as dirty.
		      pages(i).markAllParagraphsDirty
		      
		    next
		    
		  else
		    
		    ' Mark all the visible paragraphs as dirty.
		    pages(0).markVisibleNormalModeParagraphsDirty
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub markDirtyParagraphsForSpellCheck()
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim indexMax as integer
		  Dim keys() as Variant
		  
		  ' Is there anything to do?
		  if not parentControl.SpellCheckWhileTyping then return
		  
		  ' Get the number of paragraphs to compose.
		  count = dirtyIndexes.count - 1
		  
		  ' Get the maximum number of paragraphs.
		  indexMax = Ubound(paragraphs)
		  
		  ' Get the keys.
		  keys = dirtyIndexes.Keys
		  
		  ' Mark all the paragraphs for spell checking.
		  for i = 0 to count
		    
		    ' Are we in range?
		    if keys(i) <= indexMax then
		      
		      ' Get the paragraph.
		      paragraphs(keys(i)).makeSpellingDirty
		      
		    end if
		    
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub markDirtySelectedParagraphs()
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim startParagraph as integer
		  Dim endParagraph as integer
		  
		  ' Get the selected paragraph range.
		  getSelectedParagraphIndexes(startParagraph, endParagraph)
		  
		  ' Mark all the paragaphs dirty.
		  for i = startParagraph to endParagraph
		    
		    paragraphs(i).makeDirty
		    
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub moveInsertionPoint(amount as integer, calculateOffset as boolean)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim io as FTInsertionOffset
		  
		  ' Is there anything to do?
		  if amount = 0 then return
		  
		  ' Add in the change in position.
		  io = insertionPoint.getOffset + amount
		  
		  ' Are we between the lines where we need to set the bias?
		  if isOffsetBetweenLines(io) then
		    
		    ' Set the bias so the caret shows up in the correct space.
		    if amount < 0 then
		      io.bias = (amount < 0)
		    else
		      io.bias = (Amount > 0)
		    end
		    
		  end if
		  
		  ' Move the offset of the insertion point.
		  insertionPoint.setInsertionPoint(io, calculateOffset)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub moveInsertionPointByLine(amount as integer, xOffset as integer, scale as double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim p as FTParagraph
		  Dim line as integer
		  Dim lineStart as integer
		  Dim io as FTInsertionOffset
		  
		  ' Is there anything to do?
		  if amount = 0 then return
		  
		  ' Get the insertion offset.
		  io = insertionPoint.getOffset
		  
		  ' Is there any place to move to?
		  if (amount < 0) and io.isBeginning then return
		  if (amount > 0) and io.isEnd then return
		  
		  ' Get the current paragraph.
		  p = insertionPoint.getCurrentParagraph
		  
		  ' Get the current insertion line.
		  line = p.getInsertionLine(io.offset, io.bias, lineStart)
		  
		  ' Set up the target line.
		  line = line + amount
		  
		  ' Are we in the previous paragraph?
		  if line < 0 then
		    
		    ' Get the previous paragraph.
		    p = getParagraph(p.getAbsoluteIndex - 1)
		    
		    ' Did we find one?
		    if not (p is nil) then
		      
		      ' Move to the previous paragraph.
		      moveToLine(p, p.getLineCount - 1, xOffset, scale)
		      
		    else
		      
		      ' Move to the beginning of the document.
		      insertionPoint.setInsertionPoint(nil, false)
		      
		    end if
		    
		    ' Are we in the next paragraph?
		  elseif line > (p.getLineCount - 1)  then
		    
		    ' Get the next paragraph.
		    p = getNextParagraph(p.getAbsoluteIndex)
		    
		    ' Did we find one?
		    if not (p is nil) then
		      
		      ' Move to the next paragraph.
		      moveToLine(p, 0, xOffset, scale)
		      
		    else
		      
		      ' Move to the end of the document.
		      moveInsertionPointToEnd(false)
		      
		    end if
		    
		  else
		    
		    ' We are in the same paragraph.
		    moveToLine(p, line, xOffset, scale)
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub moveInsertionPointInCurrentLine(xOffset as integer, scale as double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim p as FTParagraph
		  Dim line as integer
		  Dim ignore as integer
		  
		  ' Get the paragraph.
		  p = getInsertionOffset.getParagraph
		  
		  ' Get the current insertion line.
		  line = p.getInsertionLine(getInsertionOffset.offset, getInsertionOffset.bias, ignore)
		  
		  ' Move to the point in the line.
		  moveToLine(p, line, xOffset, scale)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub moveInsertionPointToBeginning(calculateOffset as boolean)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Move to the end of the document.
		  getInsertionPoint.setInsertionPoint(0, 0, calculateOffset)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub moveInsertionPointToEnd(calculateOffset as boolean)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim p as FTParagraph
		  
		  ' Get the last paragraph.
		  p = paragraphs(Ubound(paragraphs))
		  
		  ' Move to the end of the document.
		  getInsertionPoint.setInsertionPoint(p, p.getLength, calculateOffset)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub moveInsertionPointToLineEnd(calculateOffset as boolean)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim p as FTParagraph
		  Dim offset as integer
		  Dim currentLine as integer
		  Dim offsetIndex as integer
		  Dim bias as boolean
		  
		  ' Get the current paragraph.
		  p = insertionPoint.getCurrentParagraph
		  
		  ' Get information on the insertion point.
		  offset = insertionPoint.getOffset.offset
		  bias = insertionPoint.getOffset.bias
		  
		  ' Find the line that contains the caret offset.
		  p.findLine(0, offset, bias, currentLine, offsetIndex)
		  
		  ' Are we past the first line
		  if bias and (offsetIndex > 0) then
		    
		    ' Move to the next line.
		    currentLine = Min(currentLine + 1, p.getLineCount - 1)
		    
		    ' Turn off the bias.
		    insertionPoint.setBias(false)
		    
		  end if
		  
		  ' Are we on the last line?
		  if currentLine = (p.getLineCount - 1) then
		    
		    ' Put it at the end of the paragraph.
		    offset = p.getLength
		    
		  else
		    
		    ' Find the offset.
		    offset = Max(p.getLineLength(0, currentLine), 0)
		    
		  end if
		  
		  ' Move the caret.
		  insertionPoint.setInsertionPoint(p.getAbsoluteIndex, offset, calculateOffset, false)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub moveInsertionPointToLineStart(calculateOffset as boolean)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim p as FTParagraph
		  Dim offset as integer
		  Dim currentLine as integer
		  Dim offsetIndex as integer
		  
		  ' Get the current paragraph.
		  p = insertionPoint.getCurrentParagraph
		  
		  ' Find the line that contains the caret offset.
		  p.findLine(0, insertionPoint.getOffset.offset, _
		  insertionPoint.getOffset.bias, currentLine, offsetIndex)
		  
		  ' Are we already at the beginning of the line?
		  if insertionPoint.getOffset.bias then return
		  
		  ' Are we past the first line?
		  if currentLine > 0 then
		    
		    ' Find the offset.
		    offset = p.getLineLength(0, currentLine - 1)
		    
		  end if
		  
		  ' Move the caret.
		  insertionPoint.setInsertionPoint(p, offset, calculateOffset)
		  
		  ' Set the bias to show up at the beginning of this line.
		  insertionPoint.setBias(true)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub moveInsertionPointToParagraphEnd(calculateOffset as boolean)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Normally doc.getInsertionOffset.moveToEndOfParagraph
		  ' should do this, but it does not work in all cases.
		  
		  Dim p As FTParagraph
		  
		  ' Get the current paragraph.
		  p = insertionPoint.getCurrentParagraph
		  
		  ' Move to the end of the paragraph.
		  getInsertionPoint.setInsertionPoint(p, p.getLength, calculateOffset)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub moveInsertionPointToParagraphStart(calculateOffset as boolean)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Normally doc.getInsertionOffset.moveToBeginningOfParagraph
		  ' should do this, but it does not work in all cases.
		  
		  Dim p as FTParagraph
		  
		  ' Get the current paragraph.
		  p = insertionPoint.getCurrentParagraph
		  
		  ' Move the caret to the beginning of the paragraph.
		  insertionPoint.setInsertionPoint(p, 0, calculateOffset)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub moveParagraphBackward()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim p, NextParagraph as FTParagraph
		  Dim i, nexti As Integer
		  
		  ' Get the current paragraph.
		  p = insertionPoint.getCurrentParagraph
		  
		  ' Get the paragraph index.
		  i = findParagraphIndex(p.getId)
		  
		  ' Exit if caret is within the last paragraph.
		  If i = 0 Then Return
		  
		  ' Only Move the Paragraph Backward if it's not the first paragraph.
		  If i > 0 Then
		    nexti = i - 1
		    NextParagraph = Paragraphs(nexti)
		    Paragraphs.Remove(nexti)
		    NextParagraph.setAbsoluteIndex(i)
		    Paragraphs.Insert(i, NextParagraph)
		    p.SetAbsoluteIndex(Nexti)
		  End If
		  
		  ' Make sure the pages get reformatted.
		  markAllPagesDirty
		  
		  ' Recompose the paragraphs.
		  compose
		  
		  ' Move the caret to the beginning of the paragraph.
		  insertionPoint.setInsertionPoint(p, 0, True)
		  
		  ' Now Select the newly moved down paragraph
		  setSelectionRange(p.getAbsoluteIndex, 0, p.getAbsoluteIndex, p.getLength)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub moveParagraphForward()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim p, NextParagraph as FTParagraph
		  Dim i, nexti As Integer
		  
		  ' Get the current paragraph.
		  p = insertionPoint.getCurrentParagraph
		  
		  ' Get the paragraph index.
		  i = findParagraphIndex(p.getId)
		  
		  ' Exit if caret is within the last paragraph.
		  If i = paragraphs.Ubound Then Return
		  
		  ' Only Move the Paragraph Forward if it's not the last paragraph.
		  If i < paragraphs.Ubound Then
		    nexti = i + 1
		    NextParagraph = Paragraphs(nexti)
		    Paragraphs.Remove(nexti)
		    NextParagraph.setAbsoluteIndex(i)
		    Paragraphs.Insert(i, NextParagraph)
		    p.SetAbsoluteIndex(Nexti)
		  End If
		  
		  ' Make sure the pages get reformatted.
		  markAllPagesDirty
		  
		  ' Recompose the paragraphs.
		  compose
		  
		  ' Move the caret to the beginning of the paragraph.
		  insertionPoint.setInsertionPoint(p, 0, True)
		  
		  ' Now Select the newly moved down paragraph
		  setSelectionRange(p.getAbsoluteIndex, 0, p.getAbsoluteIndex, p.getLength)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub moveToLine(p as FTParagraph, line as integer, xOffset as integer, scale as double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim offset as integer
		  
		  ' Are we past the end of the line?
		  if xOffset >= p.getLine(line).getWidth(1.0) then
		    
		    ' Get the length of the entire paragraph.
		    offset = p.getLineLength(0, line)
		    
		  else
		    
		    ' Look for the insertion point within the line.
		    offset = findLineOffset(p, xOffset, line, scale)
		    
		  end if
		  
		  ' Set the insertion point.
		  insertionPoint.setInsertionPoint(p, offset, false)
		  
		  ' Reset the bias.
		  insertionPoint.setBias(xOffset = 0)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub moveToPage(page as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim position as integer
		  
		  ' Calculate the position of the page.
		  position = (getPageHeightLength + getPageSpace) * page
		  
		  ' Check the range.
		  if position > parentControl.getVScrollbar.MaximumValue then position = parentControl.getVScrollbar.MaximumValue
		  
		  ' Scroll to the page.
		  parentControl.getVScrollbar.Value = position
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function newInsertionOffset(io as FTInsertionOffset) As FTinsertionOffset
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Create a new insertion offset.
		  return new FTInsertionOffset(self, io.paragraph, io.offset)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function newInsertionOffset(paragraph as integer, offset as integer) As FTinsertionOffset
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Create a new insertion offset.
		  return new FTInsertionOffset(self, paragraph, offset)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub notifyChangeScale()
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim p as FTParagraph
		  
		  ' Go through all the paragraphs.
		  for each p in paragraphs
		    
		    ' Tell the paragraphs.
		    p.notifyChangeScale
		    
		  next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function operator_compare(rhs as FTDocument) As integer
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  //Mantis issue http://www.bkeeney.com/mantis/view.php?id=1295
		  // rhs coming in as nil
		  if rhs is nil then
		    
		    #if DebugBuild then break
		    
		    return -1
		    
		  end
		  
		  Dim i as integer
		  Dim count as integer
		  
		  ' Are the number of paragraphs different?
		  if getParagraphCount <> rhs.getParagraphCount then return -1
		  
		  ' Get the number of paragraphs.
		  count = Ubound(paragraphs)
		  
		  ' Scan all the paragraphs.
		  for i = 0 to count
		    
		    ' Are these paragraphs the same?
		    if getParagraph(i) <> rhs.getParagraph(i) then
		      
		      ' Failure.
		      return -1
		      
		    end if
		    
		  next
		  
		  ' They are equal.
		  return 0
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub optimizeAllParagraphs()
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  
		  ' Get the number of paragraphs.
		  count = Ubound(paragraphs)
		  
		  ' Optimize all of the objects.
		  for i = 0 to count
		    
		    ' Optimize the paragraph.
		    paragraphs(i).optimizeParagraph
		    
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub print(g as graphics, printer as PrinterSetup, firstPage as integer, lastPage as integer)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim saveState as boolean
		  Dim printScale as double
		  Dim scale as double
		  Dim pageWidth as double
		  Dim pageHeight as double
		  Dim lm as double
		  Dim rm as double
		  Dim tm as double
		  Dim bm as double
		  Dim origLm as double
		  Dim origRm as double
		  Dim origTm as double
		  Dim origBm as double
		  Dim resolution as integer
		  
		  '-------------------------------------------------
		  ' Save the settings.
		  '-------------------------------------------------
		  
		  ' Save the printer setup.
		  me.printer = printer
		  
		  ' Turn off updates.
		  saveState = parentControl.setInhibitUpdates(true)
		  
		  ' Get the printer resolution.
		  resolution = printer.HorizontalResolution
		  
		  ' Save the current parameters.
		  pageWidth = getPageWidth
		  pageHeight = getPageHeight
		  scale = parentControl.getScale
		  
		  ' Save the margins.
		  origLm = getLeftMargin
		  origRm = getRightMargin
		  origTm = getTopMargin
		  origBm = getBottomMargin
		  
		  '-------------------------------------------------
		  ' Set up for printing.
		  '-------------------------------------------------
		  
		  ' Reset the scale to 100%.
		  parentControl.setScale(1.0, false)
		  
		  ' Set the page size.
		  setPageSize(printer.Width / resolution, printer.Height / resolution)
		  
		  ' Calculate the margins.
		  lm = origLm - (abs(printer.PageLeft) / resolution) + printOffset.left
		  rm = origRm - ((printer.PageWidth - printer.Width - abs(printer.PageLeft)) / resolution) + printOffset.right
		  tm = origTm - (abs(printer.PageTop) / resolution) + printOffset.top
		  bm = origBm - ((printer.PageHeight - printer.Height - abs(printer.PageTop)) / resolution) + printOffset.bottom
		  
		  ' Adjust margins for the printable area.
		  setMargins(lm, rm, tm, bm)
		  
		  ' Set the print scale.
		  printScale = printer.HorizontalResolution / 72
		  
		  '-------------------------------------------------
		  ' Print the pages.
		  '-------------------------------------------------
		  
		  ' Compose the document.
		  markAllParagraphsDirty
		  compose
		  
		  ' This is the proper way to do printing
		  firstPage = g.FirstPage-1
		  lastPage = g.LastPage-1
		  
		  ' Check the ranges.
		  if firstPage < 0 then firstPage = 0
		  if lastPage > Ubound(pages) then lastPage = Ubound(pages)
		  
		  ' Get the number of copies
		  dim iCopyMax as integer = g.Copies
		  dim iCopyCount as integer = 0
		  
		  ' On Mac OS X the OS handles the number of copies.
		  #if TargetMacOS then iCopyCount = iCopyMax - 1
		  
		  while iCopyCount < iCopyMax
		    ' Print all the visible pages.
		    for i = firstPage to lastPage
		      
		      ' Is this not the first page?
		      if i <> firstPage then
		        
		        ' Create a new page.
		        g.NextPage
		        
		      end if
		      
		      ' Draw the page.
		      pages(i).drawPageViewMode(g, self, printer.PageLeft, printer.PageTop, nil, true, printScale)
		      
		    next
		    iCopyCount = iCopyCount + 1
		    
		    #if TargetWindows then
		      if iCopyCount < iCopyMax then
		        g.NextPage
		      end
		    #Endif
		    
		  wend
		  
		  //BK Note:  Leaving this commented out.  The above is the proper way to do printing.
		  ' ' Check the ranges.
		  ' if firstPage < 0 then firstPage = 0
		  ' if lastPage > Ubound(pages) then lastPage = Ubound(pages)
		  '
		  '
		  ' ' Print all the visible pages.
		  ' for i = firstPage to lastPage
		  '
		  ' ' Is this not the first page?
		  ' if i <> firstPage then
		  '
		  ' ' Create a new page.
		  ' g.NextPage
		  '
		  ' end if
		  '
		  ' ' Draw the page.
		  ' pages(i).drawPageViewMode(g, self, printer.PageLeft, printer.PageTop, nil, true, printScale)
		  '
		  ' next
		  
		  '-------------------------------------------------
		  ' Restore the settings.
		  '-------------------------------------------------
		  
		  ' Restore the page size.
		  setPageSize(pageWidth, pageHeight)
		  
		  ' Restore the margins.
		  setMargins(origLm, origRm, origTm, origBm)
		  
		  ' Reset the original state.
		  call parentControl.setInhibitUpdates(saveState)
		  
		  ' Reset the original scale.
		  parentControl.setScale(scale)
		  
		  ' Release the printer setup.
		  me.printer = nil
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub releaseThreads()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Stop the update thread.
		  updateDataTimer.kill
		  updateDataTimer = nil
		  
		  ' Stop the spell check thread.
		  spellCheckTimer.kill
		  spellCheckTimer = nil
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub removeHyperLink(startPosition as FTInsertionOffset, endPosition As FTInsertionOffset)
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim index as integer
		  Dim startId as integer
		  Dim sp as FTParagraph
		  Dim ep as FTParagraph
		  
		  ' Get the paragraph information.
		  sp = getParagraph(startPosition.paragraph)
		  ep = getParagraph(endPosition.paragraph)
		  
		  ' Are we within range?
		  if (sp is nil) or (ep is nil) then return
		  
		  ' Is this the same paragraph?
		  if sp.getId = ep.getId then
		    
		    ' Change the style of the paragraph.
		    sp.removeHyperlinks(startPosition.offset + 1, endPosition.offset)
		    
		  else
		    
		    ' Get the starting paragraph ID.
		    startId = sp.getId
		    
		    ' Get the first full paragraph index.
		    index = ep.getAbsoluteIndex - 1
		    
		    ' Delete the full paragraphs.
		    for i = index downto 0
		      
		      ' Are we at the end?
		      if paragraphs(i).getId = startId then
		        
		        ' We are done.
		        exit
		        
		      end if
		      
		      ' Change the style of the paragraph.
		      paragraphs(i).removeHyperlinks//(style, value)
		      
		    next
		    
		    '----------------
		    
		    ' Is whole first paragraph selected?
		    if startPosition.offset = 0 then
		      
		      ' Change the style of the entire first paragraph.
		      sp.removeHyperlinks//(style, value)
		      
		    else
		      
		      ' Change the style of the first paragraph.
		      sp.removeHyperlinks(startPosition.offset + 1, sp.getLength)//, style, value)
		      
		    end if
		    
		    '----------------
		    
		    ' Is whole last paragraph selected?
		    if endPosition.offset >= ep.getLength then
		      
		      ' Change the style of the entire last paragraph.
		      ep.removeHyperlinks//(style, value)
		      
		    else
		      
		      ' Change the style of the last paragraph.
		      ep.removeHyperlinks(0, endPosition.offset)//, style, value)
		      
		    end if
		    
		  end if
		  
		  ' Make sure the selection is correct.
		  reselect
		  
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
		Sub reselect()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim selectStart as FTInsertionOffset
		  Dim selectEnd as FTInsertionOffset
		  
		  ' Is something selected?
		  if isSelected then
		    
		    ' Reselect the selection to prevent possible selection overshoot.
		    getSelectionRange(selectStart, selectEnd)
		    selectSegment(selectStart, selectEnd)
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub resetInsertionCaret()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Reset the data.
		  insertionPoint.reset
		  
		  ' Are there any paragraphs?
		  if Ubound(paragraphs) > -1 then
		    
		    ' Set it to the first paragraph on page 0.
		    insertionPoint.setInsertionPoint(0, 0, true, true)
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub restartUpdateData()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Does the thread exist?
		  if not (updateDataTimer is nil) then
		    
		    ' Start update thread.
		    updateDataTimer.restart
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub scale()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Clear the caches.
		  markAllParagraphsDirty
		  
		  ' Let the objects know that the scale has changed.
		  notifyChangeScale
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub scanForDirtyParagraphs()
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  
		  ' Clear out the indexes.
		  dirtyIndexes.Clear
		  
		  ' Get the number of paragraphs.
		  count = Ubound(paragraphs)
		  
		  ' Scan the paragraphs.
		  for i = 0 to count
		    
		    ' Is the paragraph dirty?
		    if paragraphs(i).isDirty then
		      
		      ' Add the paragraph to the dirty index.
		      dirtyIndexes.Value(i) = 0
		      
		    end if
		    
		  next
		  
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
		    searchStart = New FTInsertionOffset(Self, 0, 0)
		    
		  end if
		  
		  '----------------------------------------
		  
		  ' Was the end position specified?
		  if searchEnd is nil then
		    
		    ' Get the index to the last paragraph.
		    i = Self.getParagraphCount - 1
		    
		    ' Use the end of the document.
		    searchEnd = New FTInsertionOffset(Self, i, Self.getParagraph(i).getLength)
		    
		  end if
		  
		  '----------------------------------------
		  
		  ' Is there anything to search?
		  if searchStart >= searchEnd then return false
		  
		  ' Start searching at the insertion point offset.
		  startIndex = searchStart.offset + 1
		  
		  ' Search the paragraphs.
		  for i = searchStart.paragraph to searchEnd.paragraph
		    
		    ' Get the text from the paragraph.
		    Text = Self.getParagraph(i).getText(True)
		    
		    ' Look for the string in the paragraph.
		    index = InStr(startIndex, text, target)
		    
		    ' Is the target string in the paragraph?
		    if ((index > 0) and (i < searchEnd.paragraph)) or _
		      ((index > 0) and (index + target.len <= searchEnd.offset) and (i = searchEnd.paragraph)) then
		      
		      ' Make it zero based.
		      index = index - 1
		      
		      ' Set the selection range.
		      selectStart = New FTInsertionOffset(Self, i, index)
		      selectEnd = New FTInsertionOffset(Self, i, index + target.Len)
		      
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

	#tag Method, Flags = &h1
		Protected Function segmentString(s as string) As string()
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim j as integer
		  Dim count as integer
		  Dim insertCount as integer
		  Dim arsSegment() as string
		  Dim ars() as string
		  
		  ' Split into paragraphs.
		  arsSegment = splitString(s, EndOfLine.Macintosh)
		  
		  ' Get the number of paragraphs.
		  count = Ubound(arsSegment)
		  
		  ' Scan for tabs.
		  for i = count downto 0
		    
		    ' Do we have a tab in this segment?
		    if InStr(arsSegment(i), chr(9)) > 0 then
		      
		      ' Break up the tabs.
		      ars = splitString(arsSegment(i), chr(9))
		      
		      ' Remove the original segment.
		      arsSegment.Remove(i)
		      
		      ' Get the number of segments to insert.
		      insertCount = Ubound(ars)
		      
		      ' Insert the new segments and tabs.
		      for j = insertCount downto 0
		        
		        ' Insert the segment.
		        arsSegment.insert(i, ars(j))
		        
		      next
		      
		    end if
		    
		  next
		  
		  ' Return the segments.
		  return arsSegment
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub selectAll()
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim count as integer
		  
		  ' Should we allow selections?
		  if parentControl.InhibitSelections then return
		  
		  ' Clear the resize picture.
		  setResizePicture
		  
		  ' Get the number of paragraphs.
		  count = Ubound(paragraphs)
		  
		  ' Save the selection range.
		  setSelectionRange(0, 0, count, paragraphs(count).getLength)
		  
		  ' Turn off the blinker.
		  getInsertionPoint.setCaretState(false)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function selectionAlignment(targetAlignment as FTParagraph.Alignment_Type = FTParagraph.Alignment_Type.None) As FTParagraph.Alignment_Type
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim paragraphCount as integer
		  Dim startPosition as FTInsertionOffset
		  Dim endPosition as FTInsertionOffset
		  Dim segment as FTSegment
		  Dim p as FTParagraph
		  Dim alignment As FTParagraph.Alignment_Type
		  
		  ' Is there anything selected?
		  if isSelected then
		    
		    ' Get the selection range.
		    getSelectionRange(startPosition, endPosition)
		    
		    ' Get the selected text.
		    segment = getSegment(startPosition, endPosition)
		    
		    ' Get the number of paragraphs.
		    paragraphCount = segment.getNumberOfParagraphs - 1
		    
		    ' Scan the paragraphs.
		    for i = 0 to paragraphCount
		      
		      ' Get a paragraph.
		      p = segment.getParagraph(i)
		      
		      ' Was the specified alignment found?
		      If targetAlignment = p.getAlignment Then
		        
		        ' We are done.
		        return p.getAlignment
		        
		      end if
		      
		      ' Has the alignment been specified yet?
		      If alignment = FTParagraph.Alignment_Type.None Then
		        
		        ' Set the alignment.
		        alignment = p.getAlignment
		        
		      else
		        
		        ' Does the alignment differ?
		        if alignment <> p.getAlignment then
		          
		          ' No common alignment.
		          return FTParagraph.Alignment_Type.None
		          
		        end if
		        
		      end if
		      
		    next
		    
		    ' Return the alignment.
		    return alignment
		    
		  else
		    
		    ' Get the paragraph with the insertion caret.
		    p = getInsertionPoint.getCurrentParagraph
		    
		    ' Is there something to return?
		    if not (p is nil) then
		      
		      ' Return the alignment at the insertion point.
		      return p.getAlignment
		      
		    end if
		    
		  end if
		  
		  ' Return the default.
		  return FTParagraph.Alignment_Type.None
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function selectionBackgroundColor(ByRef sameColor as boolean) As color
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim j as integer
		  Dim paragraphCount as integer
		  Dim itemCount as integer
		  Dim startPosition as FTInsertionOffset
		  Dim endPosition as FTInsertionOffset
		  Dim segment as FTSegment
		  Dim p as FTParagraph
		  Dim fto as FTObject
		  Dim colorValue as color
		  Dim inited as boolean
		  
		  ' Is there anything selected?
		  if isSelected then
		    
		    ' Get the selection range.
		    getSelectionRange(startPosition, endPosition)
		    
		    ' Get the selected text.
		    segment = getSegment(startPosition, endPosition)
		    
		    ' Get the number of paragraphs.
		    paragraphCount = segment.getNumberOfParagraphs - 1
		    
		    ' Scan the paragraphs.
		    for i = 0 to paragraphCount
		      
		      ' Get a paragraph.
		      p = segment.getParagraph(i)
		      
		      ' Get the number of items in the paragraph.
		      itemCount = p.getItemCount - 1
		      
		      ' Scan the items in the paragraph.
		      for j = 0 to itemCount
		        
		        ' Get an item from the paragraph.
		        fto = p.getItem(j)
		        
		        ' Is this a style run?
		        if fto isa FTStyleRun then
		          
		          ' Is there anything to check in this style run?
		          if FTStyleRun(fto).getLength = 0 then continue
		          
		          ' Have we seen the first one?
		          if not inited then
		            
		            ' Get the first color.
		            colorValue = FTStyleRun(fto).getBackgroundColor
		            
		            ' We got the first color.
		            inited = true
		            
		          else
		            
		            ' Do the colors differ?
		            if colorValue <> FTStyleRun(fto).getBackgroundColor then
		              
		              ' The colors are not the same.
		              sameColor = false
		              
		              ' It does not matter what we return here.
		              return colorValue
		              
		            end if
		            
		          end if
		          
		        end if
		        
		      next
		      
		    next
		    
		    ' The colors are the same.
		    sameColor = true
		    
		    ' Return the color value.
		    return colorValue
		    
		  else
		    
		    ' Get the current style run.
		    fto = getCurrentStyleRun
		    
		    ' Did we get a style run?
		    if not (fto is nil) then
		      
		      ' The colors are the same.
		      sameColor = true
		      
		      ' Get the state of the characteristic.
		      return FTStyleRun(fto).getBackgroundColor
		      
		    end if
		    
		  end if
		  
		  ' Return the default.
		  sameColor = false
		  return &cFFFFFF
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function selectionBold(any as boolean = false) As boolean
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim j as integer
		  Dim paragraphCount as integer
		  Dim itemCount as integer
		  Dim startPosition as FTInsertionOffset
		  Dim endPosition as FTInsertionOffset
		  Dim segment as FTSegment
		  Dim p as FTParagraph
		  Dim fto as FTObject
		  Dim testCondition as boolean
		  Dim sb as FTCharacterStyle
		  
		  ' Is there anything selected?
		  if isSelected then
		    
		    ' Get the selection range.
		    getSelectionRange(startPosition, endPosition)
		    
		    ' Get the selected text.
		    segment = getSegment(startPosition, endPosition)
		    
		    ' Did we get a segment?
		    if segment is nil then return false
		    
		    ' Get the number of paragraphs.
		    paragraphCount = segment.getNumberOfParagraphs - 1
		    
		    ' Scan the paragraphs.
		    for i = 0 to paragraphCount
		      
		      ' Get a paragraph.
		      p = segment.getParagraph(i)
		      
		      ' Get the number of items in the paragraph.
		      itemCount = p.getItemCount - 1
		      
		      ' Scan the items in the paragraph.
		      for j = 0 to itemCount
		        
		        ' Get an item from the paragraph.
		        fto = p.getItem(j)
		        
		        ' Is this a style run?
		        if fto isa FTStyleRun then
		          
		          ' Is there anything to check in this style run?
		          if FTStyleRun(fto).getLength = 0 then continue
		          
		          ' Get the state of the characteristic.
		          testCondition = FTStyleRun(fto).bold
		          
		          ' Are we looking for any item being set with the characteristic?
		          if any then
		            
		            ' Is the item set?
		            if testCondition then return true
		            
		          else
		            
		            ' Is this item characteristic off for this item?
		            if not testCondition then
		              
		              ' Not all the items have this characteristic.
		              return false
		              
		            end if
		            
		          end if
		          
		        end if
		        
		      next
		      
		    next
		    
		    ' Return the default value.
		    Return Not Any
		    
		  else
		    
		    ' Get the current style run.
		    fto = getCurrentStyleRun
		    
		    ' Get the style binding.
		    sb = parentControl.getCurrentStyleBinding
		    
		    ' Was the style binding present?
		    if not (sb is nil) then
		      
		      ' Use the style binding value.
		      return (sb.isBoldDefined and sb.getBold)
		      
		      ' Did we get a style run?
		    elseif not (fto is nil) then
		      
		      ' Get the state of the characteristic.
		      return FTStyleRun(fto).bold
		      
		    end if
		    
		  end if
		  
		  ' Return the default.
		  return false
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function selectionFontColor(ByRef sameColor as boolean) As color
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim j as integer
		  Dim paragraphCount as integer
		  Dim itemCount as integer
		  Dim startPosition as FTInsertionOffset
		  Dim endPosition as FTInsertionOffset
		  Dim segment as FTSegment
		  Dim p as FTParagraph
		  Dim fto as FTObject
		  Dim colorValue as color
		  Dim inited as boolean
		  
		  ' Is there anything selected?
		  if isSelected then
		    
		    ' Get the selection range.
		    getSelectionRange(startPosition, endPosition)
		    
		    ' Get the selected text.
		    segment = getSegment(startPosition, endPosition)
		    
		    ' Did we get a segment?
		    If segment Is Nil Then 
		      ' Return the default.
		      //BKS Issue 4196: Remove GOTO Keywords from FTC 
		      sameColor = False
		      Return &c000000
		    End
		    
		    ' Get the number of paragraphs.
		    paragraphCount = segment.getNumberOfParagraphs - 1
		    
		    ' Scan the paragraphs.
		    for i = 0 to paragraphCount
		      
		      ' Get a paragraph.
		      p = segment.getParagraph(i)
		      
		      ' Get the number of items in the paragraph.
		      itemCount = p.getItemCount - 1
		      
		      ' Scan the items in the paragraph.
		      for j = 0 to itemCount
		        
		        ' Get an item from the paragraph.
		        fto = p.getItem(j)
		        
		        ' Is this a style run?
		        if fto isa FTStyleRun then
		          
		          ' Is there anything to check in this style run?
		          if FTStyleRun(fto).getLength = 0 then continue
		          
		          ' Have we seen the first one?
		          if not inited then
		            
		            ' Get the first color.
		            colorValue = FTStyleRun(fto).textColor
		            
		            ' We got the first color.
		            inited = true
		            
		          else
		            
		            ' Do the colors differ?
		            if colorValue <> FTStyleRun(fto).textColor then
		              
		              ' The colors are not the same.
		              sameColor = false
		              
		              ' It does not matter what we return here.
		              return colorValue
		              
		            end if
		            
		          end if
		          
		        end if
		        
		      next
		      
		    next
		    
		    ' The colors are the same.
		    sameColor = true
		    
		    ' Return the color value.
		    return colorValue
		    
		  else
		    
		    ' Get the current style run.
		    fto = getCurrentStyleRun
		    
		    ' Did we get a style run?
		    if not (fto is nil) then
		      
		      ' Mantis Ticket 3762: FTDocument.selectionFontColor returns sameColor false when it should be true
		      sameColor = True
		      
		      ' Get the state of the characteristic.
		      return FTStyleRun(fto).textColor
		      
		    end if
		    
		  end if
		  
		  
		  ' Return the default.
		  sameColor = false
		  return &c000000
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function selectionFontName(fontName as string = "") As string
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim j as integer
		  Dim paragraphCount as integer
		  Dim itemCount as integer
		  Dim startPosition as FTInsertionOffset
		  Dim endPosition as FTInsertionOffset
		  Dim segment as FTSegment
		  Dim p as FTParagraph
		  Dim fto as FTObject
		  Dim stateValue as string
		  
		  ' Is there anything selected?
		  if isSelected then
		    
		    ' Get the selection range.
		    getSelectionRange(startPosition, endPosition)
		    
		    ' Get the selected text.
		    segment = getSegment(startPosition, endPosition)
		    
		    ' Did we get a segment?
		    if segment is nil then return ""
		    
		    ' Get the number of paragraphs.
		    paragraphCount = segment.getNumberOfParagraphs - 1
		    
		    ' Scan the paragraphs.
		    for i = 0 to paragraphCount
		      
		      ' Get a paragraph.
		      p = segment.getParagraph(i)
		      
		      ' Get the number of items in the paragraph.
		      itemCount = p.getItemCount - 1
		      
		      ' Scan the items in the paragraph.
		      for j = 0 to itemCount
		        
		        ' Get an item from the paragraph.
		        fto = p.getItem(j)
		        
		        ' Is this a style run?
		        if fto isa FTStyleRun then
		          
		          ' Is there anything to check in this style run?
		          if FTStyleRun(fto).getLength = 0 then continue
		          
		          ' Does this equal the target font name?
		          if fontName = FTStyleRun(fto).font then
		            
		            ' Return the font name.
		            return fontName
		            
		          end if
		          
		          ' Get the state of the characteristic.
		          if stateValue = "" then
		            
		            ' Set the common font name.
		            stateValue = FTStyleRun(fto).font
		            
		          else
		            
		            ' Do the font names differ?
		            if stateValue <> FTStyleRun(fto).font then
		              
		              ' No common font.
		              return ""
		              
		            end if
		            
		          end if
		          
		        end if
		        
		      next
		      
		    next
		    
		    ' Return the common font name.
		    return stateValue
		    
		  else
		    
		    ' Get the current style run.
		    fto = getCurrentStyleRun
		    
		    ' Did we get a style run?
		    if not (fto is nil) then
		      
		      ' Get the state of the characteristic.
		      return FTStyleRun(fto).font
		      
		    end if
		    
		  end if
		  
		  ' Return the default.
		  return ""
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function selectionFontSize(targetFontSize as integer = - 1) As integer
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim j as integer
		  Dim paragraphCount as integer
		  Dim itemCount as integer
		  Dim startPosition as FTInsertionOffset
		  Dim endPosition as FTInsertionOffset
		  Dim segment as FTSegment
		  Dim p as FTParagraph
		  Dim fto as FTObject
		  Dim fontSize as double
		  
		  const DEFAULT = 0
		  
		  ' Is there anything selected?
		  if isSelected then
		    
		    ' Get the selection range.
		    getSelectionRange(startPosition, endPosition)
		    
		    ' Get the selected text.
		    segment = getSegment(startPosition, endPosition)
		    
		    ' Did we get a segment?
		    if segment is nil then return DEFAULT
		    
		    ' Get the number of paragraphs.
		    paragraphCount = segment.getNumberOfParagraphs - 1
		    
		    ' Scan the paragraphs.
		    for i = 0 to paragraphCount
		      
		      ' Get a paragraph.
		      p = segment.getParagraph(i)
		      
		      ' Get the number of items in the paragraph.
		      itemCount = p.getItemCount - 1
		      
		      ' Scan the items in the paragraph.
		      for j = 0 to itemCount
		        
		        ' Get an item from the paragraph.
		        fto = p.getItem(j)
		        
		        ' Is this a style run?
		        if fto isa FTStyleRun then
		          
		          ' Is there anything to check in this style run?
		          if FTStyleRun(fto).getLength = 0 then continue
		          
		          ' Does this equal the target font size?
		          if targetFontSize = FTStyleRun(fto).getFontSize then
		            
		            ' Return the font size.
		            return targetFontSize
		            
		          end if
		          
		          ' Has the font size been set?
		          if fontSize = 0 then
		            
		            ' Save the current font size.
		            fontSize = FTStyleRun(fto).getFontSize
		            
		          else
		            
		            ' Do the font sizes differ?
		            if fontSize <> FTStyleRun(fto).getFontSize then
		              
		              ' No common font size.
		              return 0
		              
		            end if
		            
		          end if
		          
		        end if
		        
		      next
		      
		    next
		    
		    ' Return the common font size.
		    return fontSize
		    
		  else
		    
		    ' Get the current style run.
		    fto = getCurrentStyleRun
		    
		    ' Did we get a style run?
		    if not (fto is nil) then
		      
		      ' Get the state of the characteristic.
		      return FTStyleRun(fto).getFontSize
		      
		    end if
		    
		  end if
		  
		  ' Return the default.
		  return DEFAULT
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function selectionHyperLink(byref inNewWindow As Boolean) As String
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim j as integer
		  Dim paragraphCount as integer
		  Dim itemCount as integer
		  Dim startPosition as FTInsertionOffset
		  Dim endPosition as FTInsertionOffset
		  Dim segment as FTSegment
		  Dim p as FTParagraph
		  Dim fto as FTObject
		  
		  ' Is there anything selected?
		  if isSelected then
		    
		    ' Get the selection range.
		    getSelectionRange(startPosition, endPosition)
		    
		    ' Get the selected text.
		    segment = getSegment(startPosition, endPosition)
		    
		    ' Did we get a segment?
		    if segment is nil then return ""
		    
		    ' Get the number of paragraphs.
		    paragraphCount = segment.getNumberOfParagraphs - 1
		    
		    ' Scan the paragraphs.
		    for i = 0 to paragraphCount
		      
		      ' Get a paragraph.
		      p = segment.getParagraph(i)
		      
		      ' Get the number of items in the paragraph.
		      itemCount = p.getItemCount - 1
		      
		      ' Scan the items in the paragraph.
		      for j = 0 to itemCount
		        
		        ' Get an item from the paragraph.
		        fto = p.getItem(j)
		        
		        ' Is this a style run?
		        if fto isa FTStyleRun then
		          
		          ' Is there anything to check in this style run?
		          if FTStyleRun(fto).getLength = 0 then continue
		          
		          ' Get the state of the characteristic.
		          inNewWindow = FTStyleRun(fto).inNewWindow
		          return FTStyleRun(fto).HyperLink
		          
		          
		        end if
		        
		      next
		      
		    next
		    
		    ' Return the default value.
		    return ""
		    
		  else
		    
		    ' Get the current style run.
		    fto = getCurrentStyleRun
		    
		    ' Did we get a style run?
		    if not (fto is nil) then
		      
		      ' Get the state of the characteristic.
		      inNewWindow = FTStyleRun(fto).inNewWindow
		      
		      return FTStyleRun(fto).HyperLink
		      
		    end if
		    
		  end if
		  
		  ' Return no link
		  return ""
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function selectionHyperLinkColor(byref hyperlinkColor As Color, byref hyperlinkColorRollover As Color, byref hyperlinkColorVisited As Color, byref hyperLinkColorDisabled As Color, byref ulNormal As Boolean, byref ulRollover As Boolean, byref ulVisited as Boolean, byref ulDisabled as Boolean) As Boolean
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim j as integer
		  Dim paragraphCount as integer
		  Dim itemCount as integer
		  Dim startPosition as FTInsertionOffset
		  Dim endPosition as FTInsertionOffset
		  Dim segment as FTSegment
		  Dim p as FTParagraph
		  Dim fto as FTObject
		  
		  ' Is there anything selected?
		  if isSelected then
		    
		    ' Get the selection range.
		    getSelectionRange(startPosition, endPosition)
		    
		    ' Get the selected text.
		    segment = getSegment(startPosition, endPosition)
		    
		    ' Did we get a segment?
		    if segment is nil then return false
		    
		    ' Get the number of paragraphs.
		    paragraphCount = segment.getNumberOfParagraphs - 1
		    
		    ' Scan the paragraphs.
		    for i = 0 to paragraphCount
		      
		      ' Get a paragraph.
		      p = segment.getParagraph(i)
		      
		      ' Get the number of items in the paragraph.
		      itemCount = p.getItemCount - 1
		      
		      ' Scan the items in the paragraph.
		      for j = 0 to itemCount
		        
		        ' Get an item from the paragraph.
		        fto = p.getItem(j)
		        
		        ' Is this a style run?
		        if fto isa FTStyleRun then
		          
		          ' Is there anything to check in this style run?
		          if FTStyleRun(fto).getLength = 0 then continue
		          
		          if FTStyleRun(fto).HyperLink.lenb>0 then
		            ' Get the state of the characteristic.
		            FTStyleRun(fto).getHyperLinkColorAndUnderline(hyperlinkColor , hyperlinkColorRollover , hyperlinkColorVisited , hyperLinkColorDisabled , ulNormal , ulRollover , ulVisited , ulDisabled )
		            Return true
		            
		          end if
		          
		        end if
		        
		      next
		      
		    next
		    
		    ' Return the default value.
		    return false
		    
		  else
		    
		    ' Get the current style run.
		    fto = getCurrentStyleRun
		    
		    ' Did we get a style run?
		    if not (fto is nil) then
		      
		      ' Get the state of the characteristic.
		      if FTStyleRun(fto).HyperLink.lenb>0 then
		        
		        FTStyleRun(fto).getHyperLinkColorAndUnderline(hyperlinkColor , hyperlinkColorRollover , hyperlinkColorVisited , hyperLinkColorDisabled , ulNormal , ulRollover , ulVisited , ulDisabled )
		        Return true
		      end if
		    end if
		    
		  end if
		  
		  ' Return no link
		  return false
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function selectionIsBackgroundColorDefined(ByRef sameBackgroundSetting as boolean) As Boolean
		  //if a background color is defined
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim j as integer
		  Dim paragraphCount as integer
		  Dim itemCount as integer
		  Dim startPosition as FTInsertionOffset
		  Dim endPosition as FTInsertionOffset
		  Dim segment as FTSegment
		  Dim p as FTParagraph
		  Dim fto as FTObject
		  Dim isDefined as Boolean
		  Dim inited as boolean
		  
		  ' Is there anything selected?
		  if isSelected then
		    
		    ' Get the selection range.
		    getSelectionRange(startPosition, endPosition)
		    
		    ' Get the selected text.
		    segment = getSegment(startPosition, endPosition)
		    
		    ' Get the number of paragraphs.
		    paragraphCount = segment.getNumberOfParagraphs - 1
		    
		    ' Scan the paragraphs.
		    for i = 0 to paragraphCount
		      
		      ' Get a paragraph.
		      p = segment.getParagraph(i)
		      
		      ' Get the number of items in the paragraph.
		      itemCount = p.getItemCount - 1
		      
		      ' Scan the items in the paragraph.
		      for j = 0 to itemCount
		        
		        ' Get an item from the paragraph.
		        fto = p.getItem(j)
		        
		        ' Is this a style run?
		        if fto isa FTStyleRun then
		          
		          ' Is there anything to check in this style run?
		          if FTStyleRun(fto).getLength = 0 then continue
		          
		          ' Have we seen the first one?
		          if not inited then
		            
		            ' Get the first color.
		            isDefined = FTStyleRun(fto).useBackgroundColor
		            
		            ' We got the first color.
		            inited = true
		            
		          else
		            
		            ' Do the colors differ?
		            if isDefined <> FTStyleRun(fto).useBackgroundColor then
		              
		              ' The colors are not the same.
		              sameBackgroundSetting = false
		              
		              ' It does not matter what we return here.
		              return isDefined
		              
		            end if
		            
		          end if
		          
		        end if
		        
		      next
		      
		    next
		    
		    ' The colors are the same.
		    sameBackgroundSetting = true
		    
		    ' Return the color value.
		    return isDefined
		    
		  else
		    
		    ' Get the current style run.
		    fto = getCurrentStyleRun
		    
		    ' Did we get a style run?
		    if not (fto is nil) then
		      
		      ' The colors are the same.
		      sameBackgroundSetting = true
		      
		      ' Get the state of the characteristic.
		      return FTStyleRun(fto).useBackgroundColor
		      
		    end if
		    
		  end if
		  
		  ' Return the default.
		  sameBackgroundSetting = false
		  return FALSE
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function selectionItalic(any as boolean = false) As boolean
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim j as integer
		  Dim paragraphCount as integer
		  Dim itemCount as integer
		  Dim startPosition as FTInsertionOffset
		  Dim endPosition as FTInsertionOffset
		  Dim segment as FTSegment
		  Dim p as FTParagraph
		  Dim fto as FTObject
		  Dim testCondition as boolean
		  Dim sb as FTCharacterStyle
		  
		  ' Is there anything selected?
		  if isSelected then
		    
		    ' Get the selection range.
		    getSelectionRange(startPosition, endPosition)
		    
		    ' Get the selected text.
		    segment = getSegment(startPosition, endPosition)
		    
		    ' Did we get a segment?
		    if segment is nil then return false
		    
		    ' Get the number of paragraphs.
		    paragraphCount = segment.getNumberOfParagraphs - 1
		    
		    ' Scan the paragraphs.
		    for i = 0 to paragraphCount
		      
		      ' Get a paragraph.
		      p = segment.getParagraph(i)
		      
		      ' Get the number of items in the paragraph.
		      itemCount = p.getItemCount - 1
		      
		      ' Scan the items in the paragraph.
		      for j = 0 to itemCount
		        
		        ' Get an item from the paragraph.
		        fto = p.getItem(j)
		        
		        ' Is this a style run?
		        if fto isa FTStyleRun then
		          
		          ' Is there anything to check in this style run?
		          if FTStyleRun(fto).getLength = 0 then continue
		          
		          ' Get the state of the characteristic.
		          testCondition = FTStyleRun(fto).italic
		          
		          ' Are we looking for any item being set with the characteristic?
		          if any then
		            
		            ' Is the item set?
		            if testCondition then return true
		            
		          else
		            
		            ' Is this item characteristic off for this item?
		            if not testCondition then
		              
		              ' Not all the items have this characteristic.
		              return false
		              
		            end if
		            
		          end if
		          
		        end if
		        
		      next
		      
		    next
		    
		    ' Return the default value.
		    Return Not Any
		    
		  else
		    
		    ' Get the current style run.
		    fto = getCurrentStyleRun
		    
		    ' Get the style binding.
		    sb = parentControl.getCurrentStyleBinding
		    
		    ' Was the style binding present?
		    if not (sb is nil) then
		      
		      ' Use the style binding value.
		      return (sb.isItalicDefined and sb.getItalic)
		      
		      ' Did we get a style run?
		    elseif not (fto is nil) then
		      
		      ' Get the state of the characteristic.
		      return FTStyleRun(fto).italic
		      
		    end if
		    
		  end if
		  
		  ' Return the default.
		  return false
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function selectionLineSpacing(targetLineSpacing as double = - 1) As double
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim paragraphCount as integer
		  Dim startPosition as FTInsertionOffset
		  Dim endPosition as FTInsertionOffset
		  Dim segment as FTSegment
		  Dim p as FTParagraph
		  Dim lineSpacing as double
		  
		  const DEFAULT = 1.0
		  
		  ' Is there anything selected?
		  if isSelected then
		    
		    ' Get the selection range.
		    getSelectionRange(startPosition, endPosition)
		    
		    ' Get the selected text.
		    segment = getSegment(startPosition, endPosition)
		    
		    ' Did we get a segment?
		    if segment is nil then return DEFAULT
		    
		    ' Get the number of paragraphs.
		    paragraphCount = segment.getNumberOfParagraphs - 1
		    
		    ' Scan the paragraphs.
		    for i = 0 to paragraphCount
		      
		      ' Get a paragraph.
		      p = segment.getParagraph(i)
		      
		      ' Does this equal the target line spacing?
		      if targetLineSpacing = p.getLineSpacing then
		        
		        ' Return the line spacing.
		        return targetLineSpacing
		        
		      end if
		      
		      ' Has the line spacing been set?
		      if lineSpacing = 0 then
		        
		        ' Set the line spacing.
		        lineSpacing = p.getLineSpacing
		        
		      else
		        
		        ' Do the line spacings differ?
		        if lineSpacing <> p.getLineSpacing then
		          
		          ' No common line spacing.
		          return 0
		          
		        end if
		        
		      end if
		      
		    next
		    
		    ' Return the value.
		    return lineSpacing
		    
		  else
		    
		    ' Get the paragraph with the insertion caret.
		    p = getInsertionPoint.getCurrentParagraph
		    
		    ' Is there something to return?
		    if not (p is nil) then
		      
		      ' Return the line spacing at the insertion point.
		      return p.getLineSpacing
		      
		    end if
		    
		  end if
		  
		  ' Return the default.
		  return DEFAULT
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function selectionMarked(any as boolean = false) As boolean
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim j as integer
		  Dim paragraphCount as integer
		  Dim itemCount as integer
		  Dim startPosition as FTInsertionOffset
		  Dim endPosition as FTInsertionOffset
		  Dim segment as FTSegment
		  Dim p as FTParagraph
		  Dim fto as FTObject
		  Dim testCondition as boolean
		  
		  ' Is there anything selected?
		  if isSelected then
		    
		    ' Get the selection range.
		    getSelectionRange(startPosition, endPosition)
		    
		    ' Get the selected text.
		    segment = getSegment(startPosition, endPosition)
		    
		    ' Did we get a segment?
		    if segment is nil then return false
		    
		    ' Get the number of paragraphs.
		    paragraphCount = segment.getNumberOfParagraphs - 1
		    
		    ' Scan the paragraphs.
		    for i = 0 to paragraphCount
		      
		      ' Get a paragraph.
		      p = segment.getParagraph(i)
		      
		      ' Get the number of items in the paragraph.
		      itemCount = p.getItemCount - 1
		      
		      ' Scan the items in the paragraph.
		      for j = 0 to itemCount
		        
		        ' Get an item from the paragraph.
		        fto = p.getItem(j)
		        
		        ' Is there anything to check in this style run?
		        if fto.getLength = 0 then continue
		        
		        ' Get the state of the characteristic.
		        testCondition = fto.marked
		        
		        ' Are we looking for any item being set with the characteristic?
		        if any then
		          
		          ' Is the item set?
		          if testCondition then return true
		          
		        else
		          
		          ' Is this item characteristic off for this item?
		          if not testCondition then
		            
		            ' Not all the items have this characteristic.
		            return false
		            
		          end if
		          
		        end if
		        
		      next
		      
		    next
		    
		    ' Return the default value.
		    return not any
		    
		  else
		    
		    ' Get the current style run.
		    fto = getCurrentStyleRun
		    
		    ' Did we get a style run?
		    if not (fto is nil) then
		      
		      ' Get the state of the characteristic.
		      return FTStyleRun(fto).marked
		      
		    end if
		    
		  end if
		  
		  ' Return the default.
		  return false
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function selectionOpacity(targetOpacity as integer = - 1) As integer
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim j as integer
		  Dim paragraphCount as integer
		  Dim itemCount as integer
		  Dim startPosition as FTInsertionOffset
		  Dim endPosition as FTInsertionOffset
		  Dim segment as FTSegment
		  Dim p as FTParagraph
		  Dim fto as FTObject
		  Dim opacity as double
		  
		  const DEFAULT = 0
		  
		  ' Is there anything selected?
		  if isSelected then
		    
		    ' Get the selection range.
		    getSelectionRange(startPosition, endPosition)
		    
		    ' Get the selected text.
		    segment = getSegment(startPosition, endPosition)
		    
		    ' Did we get a segment?
		    if segment is nil then return DEFAULT
		    
		    ' Get the number of paragraphs.
		    paragraphCount = segment.getNumberOfParagraphs - 1
		    
		    ' Scan the paragraphs.
		    for i = 0 to paragraphCount
		      
		      ' Get a paragraph.
		      p = segment.getParagraph(i)
		      
		      ' Get the number of items in the paragraph.
		      itemCount = p.getItemCount - 1
		      
		      ' Scan the items in the paragraph.
		      for j = 0 to itemCount
		        
		        ' Get an item from the paragraph.
		        fto = p.getItem(j)
		        
		        ' Is this a style run?
		        if fto isa FTStyleRun then
		          
		          ' Is there anything to check in this style run?
		          if FTStyleRun(fto).getLength = 0 then continue
		          
		          ' Does this equal the target font size?
		          if targetOpacity = FTStyleRun(fto).colorOpacity then
		            
		            ' Return the font size.
		            return targetOpacity
		            
		          end if
		          
		          ' Has the font size been set?
		          if opacity = 0 then
		            
		            ' Save the current font size.
		            opacity = FTStyleRun(fto).colorOpacity
		            
		          else
		            
		            ' Do the font sizes differ?
		            if opacity <> FTStyleRun(fto).colorOpacity then
		              
		              ' No common font size.
		              return 0
		              
		            end if
		            
		          end if
		          
		        end if
		        
		      next
		      
		    next
		    
		    ' Return the common font size.
		    return opacity
		    
		  else
		    
		    ' Get the current style run.
		    fto = getCurrentStyleRun
		    
		    ' Did we get a style run?
		    if not (fto is nil) then
		      
		      ' Get the state of the characteristic.
		      return FTStyleRun(fto).colorOpacity
		      
		    end if
		    
		  end if
		  
		  ' Return the default.
		  return DEFAULT
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function selectionShadow(byref shadowColor as Color, byref ShadowBlur as Double, byref ShadowOffset As Double, byref ShadowAngle as DOuble, byref ShadowOpacity as Double, any as boolean = false) As Boolean
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim j as integer
		  Dim paragraphCount as integer
		  Dim itemCount as integer
		  Dim startPosition as FTInsertionOffset
		  Dim endPosition as FTInsertionOffset
		  Dim segment as FTSegment
		  Dim p as FTParagraph
		  Dim fto as FTObject
		  Dim testCondition as boolean
		  
		  ' Is there anything selected?
		  if isSelected then
		    
		    ' Get the selection range.
		    getSelectionRange(startPosition, endPosition)
		    
		    ' Get the selected text.
		    segment = getSegment(startPosition, endPosition)
		    
		    ' Did we get a segment?
		    if segment is nil then return false
		    
		    ' Get the number of paragraphs.
		    paragraphCount = segment.getNumberOfParagraphs - 1
		    
		    ' Scan the paragraphs.
		    for i = 0 to paragraphCount
		      
		      ' Get a paragraph.
		      p = segment.getParagraph(i)
		      
		      ' Get the number of items in the paragraph.
		      itemCount = p.getItemCount - 1
		      
		      ' Scan the items in the paragraph.
		      for j = 0 to itemCount
		        
		        ' Get an item from the paragraph.
		        fto = p.getItem(j)
		        
		        ' Is there anything to check in this style run?
		        if fto.getLength = 0 then continue
		        
		        ' Get the state of the characteristic.
		        testCondition = fto.hasShadow
		        
		        shadowColor = fto.shadowColor
		        ShadowOffset =fto.shadowOffset
		        ShadowAngle = fto.shadowAngle
		        ShadowOpacity = fto.shadowOpacity
		        ShadowBlur = fto.shadowBlur
		        
		        ' Are we looking for any item being set with the characteristic?
		        if any then
		          
		          ' Is the item set?
		          if testCondition then return true
		          
		        else
		          
		          ' Is this item characteristic off for this item?
		          if not testCondition then
		            
		            ' Not all the items have this characteristic.
		            return false
		            
		          end if
		          
		        end if
		        
		      next
		      
		    next
		    
		    ' Return the default value.
		    Return Not Any
		    
		  else
		    
		    ' Get the current style run.
		    fto = getCurrentStyleRun
		    
		    ' Did we get a style run?
		    if not (fto is nil) then
		      
		      ' get our shadow properties
		      shadowColor = fto.shadowColor
		      ShadowOffset =fto.shadowOffset
		      ShadowAngle = fto.shadowAngle
		      ShadowOpacity = fto.shadowOpacity
		      ShadowBlur = fto.shadowBlur
		      
		      ' Get the state of the characteristic.
		      return FTStyleRun(fto).hasShadow
		      
		    end if
		    
		  end if
		  
		  ' Return the default.
		  return false
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function selectionStrikethrough(any as boolean = false) As boolean
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim j as integer
		  Dim paragraphCount as integer
		  Dim itemCount as integer
		  Dim startPosition as FTInsertionOffset
		  Dim endPosition as FTInsertionOffset
		  Dim segment as FTSegment
		  Dim p as FTParagraph
		  Dim fto as FTObject
		  Dim testCondition as boolean
		  Dim sb as FTCharacterStyle
		  
		  ' Is there anything selected?
		  if isSelected then
		    
		    ' Get the selection range.
		    getSelectionRange(startPosition, endPosition)
		    
		    ' Get the selected text.
		    segment = getSegment(startPosition, endPosition)
		    
		    ' Did we get a segment?
		    if segment is nil then return false
		    
		    ' Get the number of paragraphs.
		    paragraphCount = segment.getNumberOfParagraphs - 1
		    
		    ' Scan the paragraphs.
		    for i = 0 to paragraphCount
		      
		      ' Get a paragraph.
		      p = segment.getParagraph(i)
		      
		      ' Get the number of items in the paragraph.
		      itemCount = p.getItemCount - 1
		      
		      ' Scan the items in the paragraph.
		      for j = 0 to itemCount
		        
		        ' Get an item from the paragraph.
		        fto = p.getItem(j)
		        
		        ' Is there anything to check in this style run?
		        if fto.getLength = 0 then continue
		        
		        ' Get the state of the characteristic.
		        testCondition = fto.strikeThrough
		        
		        ' Are we looking for any item being set with the characteristic?
		        if any then
		          
		          ' Is the item set?
		          if testCondition then return true
		          
		        else
		          
		          ' Is this item characteristic off for this item?
		          if not testCondition then
		            
		            ' Not all the items have this characteristic.
		            return false
		            
		          end if
		          
		        end if
		        
		      next
		      
		    next
		    
		    ' Return the default value.
		    Return Not Any
		    
		  else
		    
		    ' Get the current style run.
		    fto = getCurrentStyleRun
		    
		    ' Get the style binding.
		    sb = parentControl.getCurrentStyleBinding
		    
		    ' Was the style binding present?
		    if not (sb is nil) then
		      
		      ' Use the style binding value.
		      return (sb.isStrikeThroughDefined and sb.getStrikeThrough)
		      
		      ' Did we get a style run?
		    elseif not (fto is nil) then
		      
		      ' Get the state of the characteristic.
		      return FTStyleRun(fto).strikeThrough
		      
		    end if
		    
		  end if
		  
		  ' Return the default.
		  return false
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function selectionSubscript(any as boolean = false) As boolean
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim j as integer
		  Dim paragraphCount as integer
		  Dim itemCount as integer
		  Dim startPosition as FTInsertionOffset
		  Dim endPosition as FTInsertionOffset
		  Dim segment as FTSegment
		  Dim p as FTParagraph
		  Dim fto as FTObject
		  Dim testCondition as boolean
		  Dim sb as FTCharacterStyle
		  
		  ' Is there anything selected?
		  if isSelected then
		    
		    ' Get the selection range.
		    getSelectionRange(startPosition, endPosition)
		    
		    ' Get the selected text.
		    segment = getSegment(startPosition, endPosition)
		    
		    ' Did we get a segment?
		    if segment is nil then return false
		    
		    ' Get the number of paragraphs.
		    paragraphCount = segment.getNumberOfParagraphs - 1
		    
		    ' Scan the paragraphs.
		    for i = 0 to paragraphCount
		      
		      ' Get a paragraph.
		      p = segment.getParagraph(i)
		      
		      ' Get the number of items in the paragraph.
		      itemCount = p.getItemCount - 1
		      
		      ' Scan the items in the paragraph.
		      for j = 0 to itemCount
		        
		        ' Get an item from the paragraph.
		        fto = p.getItem(j)
		        
		        ' Is this a style run?
		        if fto isa FTStyleRun then
		          
		          ' Is there anything to check in this style run?
		          if FTStyleRun(fto).getLength = 0 then continue
		          
		          ' Get the state of the characteristic.
		          testCondition = (FTStyleRun(fto).scriptLevel < 0)
		          
		          ' Are we looking for any item being set with the characteristic?
		          if any then
		            
		            ' Is the item set?
		            if testCondition then return true
		            
		          else
		            
		            ' Is this item characteristic off for this item?
		            if not testCondition then
		              
		              ' Not all the items have this characteristic.
		              return false
		              
		            end if
		            
		          end if
		          
		        end if
		        
		      next
		      
		    next
		    
		    ' Return the default value.
		    Return Not Any
		    
		  else
		    
		    ' Get the current style run.
		    fto = getCurrentStyleRun
		    
		    ' Get the style binding.
		    sb = parentControl.getCurrentStyleBinding
		    
		    ' Was the style binding present?
		    if not (sb is nil) then
		      
		      ' Use the style binding value.
		      return (sb.isScriptLevelDefined and (sb.getScriptLevel < 0))
		      
		      ' Did we get a style run?
		    elseif not (fto is nil) then
		      
		      ' Get the state of the characteristic.
		      return (FTStyleRun(fto).scriptLevel < 0)
		      
		    end if
		    
		  end if
		  
		  ' Return the default.
		  return false
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function selectionSuperscript(any as boolean = false) As boolean
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim j as integer
		  Dim paragraphCount as integer
		  Dim itemCount as integer
		  Dim startPosition as FTInsertionOffset
		  Dim endPosition as FTInsertionOffset
		  Dim segment as FTSegment
		  Dim p as FTParagraph
		  Dim fto as FTObject
		  Dim testCondition as boolean
		  Dim sb as FTCharacterStyle
		  
		  ' Is there anything selected?
		  if isSelected then
		    
		    ' Get the selection range.
		    getSelectionRange(startPosition, endPosition)
		    
		    ' Get the selected text.
		    segment = getSegment(startPosition, endPosition)
		    
		    ' Did we get a segment?
		    if segment is nil then return false
		    
		    ' Get the number of paragraphs.
		    paragraphCount = segment.getNumberOfParagraphs - 1
		    
		    ' Scan the paragraphs.
		    for i = 0 to paragraphCount
		      
		      ' Get a paragraph.
		      p = segment.getParagraph(i)
		      
		      ' Get the number of items in the paragraph.
		      itemCount = p.getItemCount - 1
		      
		      ' Scan the items in the paragraph.
		      for j = 0 to itemCount
		        
		        ' Get an item from the paragraph.
		        fto = p.getItem(j)
		        
		        ' Is this a style run?
		        if fto isa FTStyleRun then
		          
		          ' Is there anything to check in this style run?
		          if FTStyleRun(fto).getLength = 0 then continue
		          
		          ' Get the state of the characteristic.
		          testCondition = (FTStyleRun(fto).scriptLevel > 0)
		          
		          ' Are we looking for any item being set with the characteristic?
		          if any then
		            
		            ' Is the item set?
		            if testCondition then return true
		            
		          else
		            
		            ' Is this item characteristic off for this item?
		            if not testCondition then
		              
		              ' Not all the items have this characteristic.
		              return false
		              
		            end if
		            
		          end if
		          
		        end if
		        
		      next
		      
		    next
		    
		    ' Return the default value.
		    Return Not Any
		    
		  else
		    
		    ' Get the current style run.
		    fto = getCurrentStyleRun
		    
		    ' Get the style binding.
		    sb = parentControl.getCurrentStyleBinding
		    
		    ' Was the style binding present?
		    if not (sb is nil) then
		      
		      ' Use the style binding value.
		      return (sb.isScriptLevelDefined and (sb.getScriptLevel > 0))
		      
		      ' Did we get a style run?
		    elseif not (fto is nil) then
		      
		      ' Get the state of the characteristic.
		      return (FTStyleRun(fto).scriptLevel > 0)
		      
		    end if
		    
		  end if
		  
		  ' Return the default.
		  return false
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function selectionUnderline(any as boolean = false) As boolean
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim j as integer
		  Dim paragraphCount as integer
		  Dim itemCount as integer
		  Dim startPosition as FTInsertionOffset
		  Dim endPosition as FTInsertionOffset
		  Dim segment as FTSegment
		  Dim p as FTParagraph
		  Dim fto as FTObject
		  Dim testCondition as boolean
		  Dim sb as FTCharacterStyle
		  
		  ' Is there anything selected?
		  if isSelected then
		    
		    ' Get the selection range.
		    getSelectionRange(startPosition, endPosition)
		    
		    ' Get the selected text.
		    segment = getSegment(startPosition, endPosition)
		    
		    ' Did we get a segment?
		    if segment is nil then return false
		    
		    ' Get the number of paragraphs.
		    paragraphCount = segment.getNumberOfParagraphs - 1
		    
		    ' Scan the paragraphs.
		    for i = 0 to paragraphCount
		      
		      ' Get a paragraph.
		      p = segment.getParagraph(i)
		      
		      ' Get the number of items in the paragraph.
		      itemCount = p.getItemCount - 1
		      
		      ' Scan the items in the paragraph.
		      for j = 0 to itemCount
		        
		        ' Get an item from the paragraph.
		        fto = p.getItem(j)
		        
		        ' Is there anything to check in this style run?
		        if fto.getLength = 0 then continue
		        
		        ' Get the state of the characteristic.
		        testCondition = fto.underline
		        
		        ' Are we looking for any item being set with the characteristic?
		        if any then
		          
		          ' Is the item set?
		          if testCondition then return true
		          
		        else
		          
		          ' Is this item characteristic off for this item?
		          if not testCondition then
		            
		            ' Not all the items have this characteristic.
		            return false
		            
		          end if
		          
		        end if
		        
		      next
		      
		    next
		    
		    ' Return the default value.
		    Return Not Any
		    
		  else
		    
		    ' Get the current style run.
		    fto = getCurrentStyleRun
		    
		    ' Get the style binding.
		    sb = parentControl.getCurrentStyleBinding
		    
		    ' Was the style binding present?
		    if not (sb is nil) then
		      
		      ' Use the style binding value.
		      return (sb.isUnderlineDefined and sb.getUnderline)
		      
		      ' Did we get a style run?
		    elseif not (fto is nil) then
		      
		      ' Get the state of the characteristic.
		      return FTStyleRun(fto).underline
		      
		    end if
		    
		  end if
		  
		  ' Return the default.
		  return false
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub selectSegment(startOffset as FTInsertionOffset, endOffset as FTInsertionOffset)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim temp as FTInsertionOffset
		  
		  ' Should we allow selections?
		  if parentControl.InhibitSelections then return
		  
		  ' Is there anything to select?
		  if (startOffset is nil) or (endOffset is nil) then return
		  
		  ' Is there anything selected?
		  if (not startOffset.isSet) or (not endOffset.isSet) then return
		  
		  ' Do we need to swap the positions?
		  if startOffset > endOffset then
		    
		    ' Swap the positions.
		    temp = startOffset
		    startOffset = endOffset
		    endOffset = temp
		    
		  end if
		  
		  ' Make sure the bias is set correctly for the end conditions.
		  FTInsertionOffset.setRelativeEndBias(startOffset, endOffset)
		  
		  ' Is there something selected?
		  if isSelected then
		    
		    ' Deselect the segment.
		    deselectAll
		    
		  end if
		  
		  ' Save the selection range.
		  setSelectionRange(startOffset, endOffset)
		  
		  ' Turn off the blinker.
		  getInsertionPoint.setCaretState(false)
		  
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
		  selectSegment(newInsertionOffset(startParagraphIndex, startParagraphOffset), _
		  newInsertionOffset(endParagraphIndex, endParagraphOffset))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setAnchor()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim selectStart as FTInsertionOffset
		  Dim selectEnd as FTInsertionOffset
		  
		  ' Is anything selected?
		  if isSelected then
		    
		    ' Get the selection information.
		    getSelectionRange(selectStart, selectEnd)
		    
		    ' Are we before the beginning of the selection?
		    if getInsertionOffset <= selectStart then
		      
		      ' Set the anchor to the left.
		      anchor = AnchorTag.LEFT_SIDE
		      
		    else
		      
		      ' Set the anchor to the right.
		      anchor = AnchorTag.RIGHT_SIDE
		      
		    end if
		    
		  else
		    
		    ' Nothing is selected.
		    anchor = AnchorTag.NONE
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setBottomMargin(margin as double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set the margin.
		  margins.bottomMargin = margin
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setCharacterStyles(d as Dictionary)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Reset the Dictionary
		  characterStyles = d
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setCleanParagraph(index as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Does the index exist?
		  if dirtyIndexes.HasKey(index) then
		    
		    ' Remove the index.
		    dirtyIndexes.Remove(index)
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setDefaultParagraphStyle(ps as FTParagraphStyle)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the default paragraph style.
		  defaultParagraphStyle = ps
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setDirtyParagraph(index as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Are we in range?
		  if (index >= 0) and (index <= Ubound(paragraphs)) then
		    
		    ' Save the dirty index.
		    dirtyIndexes.Value(index) = 0
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setDisplayMargins(margins as DisplayMargins)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set the margins.
		  me.margins = margins
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setDocumentMargins(margins as DocumentMargins)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set the margins.
		  me.docMargins = margins
		  
		  ' Create the clipping page.
		  adjustClippingPage
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetGraphics(g As Graphics)
		  mGraphics = g
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setInsertionPoint(io as FTInsertionOffset, calculateOffset as boolean)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Is there anything to do?
		  if io is nil then return
		  
		  ' Set the insertion caret position.
		  insertionPoint.setInsertionPoint(io, calculateOffset)
		  
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
		  insertionPoint.setInsertionPoint(p, offset, calculateOffset)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setInsertionPoint(paragraph as integer, offset as integer, calculateOffset as boolean)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set the insertion caret position.
		  insertionPoint.setInsertionPoint(paragraph, offset, calculateOffset)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setLeftMargin(margin as double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set the margin.
		  margins.leftMargin = margin
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setLineSpacing(lineSpacing as double)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim startOffset as FTInsertionOffset
		  Dim endOffset as FTInsertionOffset
		  
		  ' Is there anything selected?
		  if isSelected then
		    
		    ' Get the range of the selection.
		    getSelectionRange(startOffset, endOffset)
		    
		    ' Change the selected paragraph alignments.
		    for i = startOffset.paragraph to endOffset.paragraph
		      
		      ' Set the lineSpacing on the paragraph.
		      getParagraph(i).setLineSpacing(lineSpacing)
		      
		    next
		    
		  else
		    
		    ' Set the line spacing for the paragraph containing the caret.
		    getInsertionPoint.getCurrentParagraph.setLineSpacing(lineSpacing)
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setMargins(margins as DisplayMargins)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set the margins.
		  setLeftMargin(margins.leftMargin)
		  setRightMargin(margins.rightMargin)
		  setTopMargin(margins.topMargin)
		  setBottomMargin(margins.bottomMargin)
		  
		  ' Make sure everything gets updated.
		  markAllParagraphsDirty
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setMargins(leftMargin as double, rightMargin as double, topMargin as double, bottomMargin as double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set the margins.
		  setLeftMargin(leftMargin)
		  setRightMargin(rightMargin)
		  setTopMargin(topMargin)
		  setBottomMargin(bottomMargin)
		  
		  ' Make sure everything gets updated.
		  markAllParagraphsDirty
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setMonitorPixelsPerInch(resolution as integer = 72)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set the new resolution.
		  Me.MonitorPixelsPerInch = resolution
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setNormalViewLength(height as double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the page height.
		  normalViewPageHeight = height
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setPageBackgroundColor(backgroundColor as Color = &cFFFFFF)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the background color for the page.
		  pageBackgroundColor = backgroundColor
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setPageHeight(height as double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the page height.
		  docMargins.pageHeight = height
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setPageSize(width as double, height as double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the page width.
		  docMargins.pageWidth = width
		  docMargins.pageHeight = height
		  
		  ' Create the clipping page.
		  adjustClippingPage
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setPageSpace(space as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the page space.
		  pageSpace = space
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setPageWidth(width as double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the page width.
		  docMargins.pageWidth = width
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setParagraphAlignment(alignment as FTParagraph.Alignment_Type)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim startOffset as FTInsertionOffset
		  Dim endOffset as FTInsertionOffset
		  
		  ' Is there anything selected?
		  if isSelected then
		    
		    ' Get the range of the selection.
		    getSelectionRange(startOffset, endOffset)
		    
		    ' Change the selected paragraph alignments.
		    for i = startOffset.paragraph to endOffset.paragraph
		      
		      ' Set the alignment on the paragraph.
		      getParagraph(i).setAlignment(alignment)
		      
		    next
		    
		  else
		    
		    ' Set the paragraph alignment for the paragraph containing the caret.
		    getInsertionPoint.getCurrentParagraph.setAlignment(alignment)
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setParagraphStyle(id as integer)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim selectedParagraphs() as FTParagraph
		  Dim p as FTParagraph
		  Dim selectStart as FTInsertionOffset
		  Dim selectEnd as FTInsertionOffset
		  Dim reselect as boolean
		  
		  ' Is anything selected?
		  if isSelected then
		    
		    ' Get the current selection range.
		    getSelectionRange(selectStart, selectEnd)
		    
		    ' Flag the selection.
		    reselect = true
		    
		  end if
		  
		  ' Get the current selected paragraph.
		  selectedParagraphs = getSelectedParagraphs
		  
		  ' Add the style to all of the paragraphs.
		  for each p in selectedParagraphs
		    
		    ' Set the style.
		    p.setParagraphStyle(id)
		    
		  next
		  
		  ' Do we need to reselect the content?
		  if reselect then
		    
		    ' Restore the selection range.
		    selectSegment(selectStart, selectEnd)
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setParagraphStyles(d as dictionary)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  'Reset the dictionary
		  paragraphStyles = d
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setParentControl(parentControl as FormattedText)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the parent control.
		  me.parentControl = parentControl
		  
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
		    
		    ' This is only needed for Windows.
		  #elseif TargetWindows
		    
		    ' Set the margin offsets.
		    printOffset.left = leftMargin
		    printOffset.right = rightMargin
		    printOffset.top = topMargin
		    printOffset.bottom = bottomMargin
		    
		  #endif
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setResizePicture()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Was a picture selected?
		  if not (resizeParagraph is nil) then
		    
		    ' Deselectthe picture within the paragraph.
		    resizeParagraph.deselectResizePictures
		    
		  end if
		  
		  ' No picture specified.
		  resizePicture = nil
		  resizeParagraph = nil
		  resizeHandle = FTPicture.Handle_Type.None
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setResizePicture(p as FTParagraph, offset as integer, x as integer, y as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim pic as FTObject
		  
		  ' Is there anything to do?
		  if parentControl.ReadOnly then return
		  
		  ' Is there anything to look at?
		  if p is nil then return
		  
		  ' Get the target picture.
		  pic = p.getItem(p.findPictureItem(offset))
		  
		  ' Was anything found?
		  if pic is nil then return
		  
		  ' Is this a picture?
		  if pic isa FTPicture then
		    
		    ' Is there anything to do?
		    if not (resizePicture is pic) then
		      
		      ' Set the picture in resize mode.
		      setResizePicture(FTPicture(pic), p, x, y)
		      
		      ' Turn on the resize handles.
		      resizePicture.setResizeMode(true)
		      
		      ' Select the picture.
		      selectSegment(p.getAbsoluteIndex, resizePicture.getStartPosition, _
		      p.getAbsoluteIndex, resizePicture.getStartPosition)
		      
		    end if
		    
		  else
		    
		    ' No picture specified.
		    setResizePicture
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setResizePicture(pic as FTPicture, p as FTParagraph)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Is there anything to do?
		  if parentControl.ReadOnly then return
		  
		  ' Set the picture.
		  resizePicture = pic
		  resizeParagraph = p
		  resizeHandle = FTPicture.Handle_Type.None
		  
		  ' Set the resize mode of the picture.
		  pic.setResizeMode(true)
		  
		  ' Select the picture.
		  selectSegment(p.getAbsoluteIndex, resizePicture.getStartPosition, _
		  p.getAbsoluteIndex, resizePicture.getStartPosition)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setResizePicture(pic as FTPicture, p as FTParagraph, x as integer, y as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim picX as integer
		  Dim picY as integer
		  Dim scale as double
		  Dim ignore as integer
		  Dim page as FTPage
		  
		  ' Is there anything to do?
		  if parentControl.ReadOnly then return
		  
		  ' Find the relative picture coordinates.
		  Call parentControl.findPictureCoordinates(pic, page, picX, picY)
		  
		  ' Get the scale.
		  scale = parentControl.getScale
		  
		  ' Set the picture.
		  resizePicture = pic
		  resizeParagraph = p
		  
		  ' Are we scaling down?
		  if scale < 1.0 then
		    
		    ' Are we in page view mode?
		    if parentControl.isPageViewMode then
		      
		      ' Convert to page coordinates.
		      parentControl.convertDisplayToPageCoordinates(x, y, ignore, x, y)
		      
		      ' Find the resize handle.
		      resizeHandle = pic.isPointInHandle(x - picX, y - picY)
		      
		    else
		      
		      ' Find the resize handle.
		      resizeHandle = pic.isPointInHandle((x / scale) - picX, (y / scale) - picY)
		      
		    end if
		    
		  else
		    
		    
		    ' Convert to page coordinates.
		    parentControl.convertDisplayToPageCoordinates(x, y, ignore, x, y)
		    
		    Dim iAdjX As Integer = x - picX
		    Dim iAdjY As Integer = y - picY
		    
		    ' Find the resize handle.
		    resizeHandle = pic.isPointInHandle(iAdjX, iAdjY)
		    
		  end if
		  
		  ' Set the resize mode of the picture.
		  pic.setResizeMode(true)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setResizePictureAtOffset(offset as FTInsertionOffset)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim pic as FTObject
		  Dim p as FTParagraph
		  
		  ' Get the target picture.
		  p = getParagraph(offset.paragraph)
		  
		  ' Make sure the positions are correct.
		  p.updatePositions
		  
		  ' Get the target picture.
		  pic = p.getItem(p.findPictureItem(offset.offset + 1))
		  
		  ' Is this a picture?
		  if pic isa FTPicture then
		    
		    ' Is there anything to do?
		    if not (resizePicture is pic) then
		      
		      ' Set the picture in resize mode.
		      setResizePicture(FTPicture(pic), p)
		      
		      ' Turn on the resize handles.
		      resizePicture.setResizeMode(true)
		      
		    end if
		    
		  else
		    
		    ' No picture specified.
		    resizePicture = nil
		    resizeParagraph = nil
		    resizeHandle = FTPicture.Handle_Type.None
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setRightMargin(margin as double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set the margin.
		  margins.rightMargin = margin
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setRTF(s as string)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim reader as FtcRtfReader
		  
		  ' Create the reader.
		  reader = new FtcRtfReader(self, true, true)
		  
		  ' Parse the data.
		  reader.parse(s)
		  
		  ' Move the insertion point to the beginning.
		  setInsertionPoint(0, 0, false)
		  
		  ' Did an error occur?
		  exception excep as RuntimeException
		    
		    ' Clear the document.
		    clearParagraphs
		    
		    ' Reraise the exception.
		    raise excep
		    
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub setSelectionRange()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Turn off the selection.
		  selectStart.clear
		  selectEnd.clear
		  
		  ' Inform the parent control.
		  parentControl.callSelectionChangedEvent
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub setSelectionRange(startOffset as FTInsertionOffset, endOffset as FTInsertionOffset)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Is there something to select?
		  if (startOffset is nil) or (endOffset is nil) then
		    
		    ' Clear the selection.
		    setSelectionRange
		    
		  else
		    
		    ' Is anything selected?
		    if startOffset > endOffset then
		      
		      ' Turn off the selection.
		      setSelectionRange
		      
		    else
		      
		      ' Save the selection.
		      selectStart = startOffset.clone
		      selectEnd = endOffset.clone
		      
		      ' Check the relative bias.
		      FTInsertionOffset.setRelativeEndBias(selectStart, selectEnd)
		      
		      ' Inform the parent control.
		      parentControl.callSelectionChangedEvent
		      
		    end if
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub setSelectionRange(startParagraph as integer, startOffset as integer, endParagraph as integer, endOffset as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the selection.
		  selectStart.set(startParagraph, startOffset)
		  selectEnd.set(endParagraph, endOffset)
		  
		  ' Check the relative bias.
		  FTInsertionOffset.setRelativeEndBias(selectStart, selectEnd)
		  
		  ' Inform the parent control.
		  parentControl.callSelectionChangedEvent
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setText(s as string)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim sa() as string
		  Dim p as FTParagraph
		  
		  ' Prepare the text.
		  s = FTUtilities.prepareText(s)
		  
		  ' Is this an empty string?
		  if s = "" then
		    
		    ' Clear the document.
		    clearParagraphs
		    
		    ' Create the paragraph.
		    p = addNewParagraph
		    
		  else
		    
		    ' Break it into paragraphs.
		    sa = split(s, EndOfLine.Macintosh)
		    
		    ' Get the number of paragraphs.
		    count = Ubound(sa)
		    
		    ' Is there anything to add?
		    if count > -1 then
		      
		      ' Clear the document.
		      clearParagraphs
		      
		      ' Add all the paragraphs.
		      for i = 0 to count
		        
		        ' Create the paragraph.
		        p = addNewParagraph
		        
		        ' Add the text to the paragraph.
		        p.addText(sa(i))
		        
		      next
		      
		    end if
		    
		  end if
		  
		  ' Move the insertion point to the beginning.
		  setInsertionPoint(0, 0, false)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setTopMargin(margin as double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set the margin.
		  margins.topMargin = margin
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setXML(s as string)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  'There is a new class to use XMLReader instead of XMLDocument, though it is not fully hooked up.
		  'To use XMLReader please see note: XMLReaderNote
		  
		  Dim xmlDoc as XmlDocument
		  Dim root as XmlElement
		  Dim item as XmlElement
		  
		  ' Clear the document.
		  clearParagraphs
		  
		  ' Is there any content to add?
		  if Trim(s) = "" then
		    
		    ' Add a blank paragraph.
		    call addNewParagraph
		    
		    ' We are done.
		    return
		    
		  end if
		  
		  ' Parse the xml data.
		  xmlDoc = new XmlDocument(s)
		  
		  ' Get the root node.
		  root = xmlDoc.DocumentElement
		  
		  ' Get the first item.
		  item = XmlElement(root.FirstChild)
		  
		  ' Load the document.
		  while not (item is nil)
		    
		    ' Parse on the element name.
		    select case item.Name
		      
		    case FTCxml.XML_VERSION
		      
		      xmlHandleVersion(item)
		      
		    case FTCxml.XML_FTDOCUMENT
		      
		      xmlHandleDocument(item)
		      
		    case FTCxml.XML_PARAGRAPH_STYLES
		      
		      xmlHandleParagraphStyle(item)
		      
		    case FTCxml.XML_CHARACTER_STYLES
		      
		      xmlHandleCharacterStyle(item)
		      
		    case FTCxml.XML_PARAGRAPHS
		      
		      xmlHandleAddParagraphs(item)
		      
		    else
		      
		      ' Process the unknown XML item.
		      LoadXMLItem(item)
		      
		    end select
		    
		    ' Get the next item.
		    item = XmlElement(item.NextSibling)
		    
		  wend
		  
		  ' Signal the end of loading the data.
		  EndXMLLoad
		  
		  ' Move the insertion point to the beginning.
		  setInsertionPoint(0, 0, false)
		  
		  ' Did an error occur?
		  exception excep as RuntimeException
		    
		    ' Clear the document.
		    clearParagraphs
		    
		    ' Add a blank paragraph.
		    call addNewParagraph
		    
		    ' Reraise the exception.
		    raise excep
		    
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setXMLCreator(creator as string)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the data.
		  xmlCreator = creator
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setXMLDocumentTag(documentTag as string)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the data.
		  xmlDocumentTag = documentTag
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setXMLFileType(fileType as string)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the data.
		  xmlFileType = fileType
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setXMLFileVersion(fileVersion as string)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the data.
		  xmlFileVersion = fileVersion
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function showMarginGuides() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the state of showing the margin guides.
		  return parentControl.showMarginGuides
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Speak()
		  //get the selected text
		  dim oStart, oEnd as FTInsertionOffset
		  getSelectionRange(oStart, oEnd)
		  
		  if me.isSelected then
		    //get the selected text
		    
		    dim s as string = getText(oStart, oEnd)
		    
		    REALbasic.Speak(s, true)
		    
		  end
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function splitString(s as string, ch as string) As string()
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim arsSegment() as string
		  Dim ars() as string
		  
		  ' Split by returns.
		  ars = Split(s, ch)
		  
		  ' Did we get something to look at?
		  if ars.Ubound <= 0 then
		    
		    ' Return the array.
		    return ars
		    
		  end if
		  
		  ' Get the number of segments.
		  count = ars.Ubound - 1
		  
		  ' Scan for non-empty segments.
		  for i = 0 to count
		    
		    ' Is this non-empty segment?
		    if ars(i).lenB > 0 then
		      
		      ' Save the segment.
		      arsSegment.Append(ars(i))
		      
		    end if
		    
		    ' Add a return.
		    arsSegment.Append(ch)
		    
		  next
		  
		  ' Do we have a left over?
		  if ars(i).lenB > 0 then
		    
		    ' Add the leftover.
		    arsSegment.Append(ars(i))
		    
		  end if
		  
		  ' Return the segments.
		  return arsSegment
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub startThreads()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Create the background threads.
		  updateDataTimer = new FTUpdateDataTimer(self, 25)
		  spellCheckTimer = new FTSpellCheckTimer(self, 1)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ToPDF(g As PDFgraphics, printer As PrinterSetup, pTop As Integer)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim saveState as boolean
		  Dim printScale As Double
		  Dim scale as double
		  Dim pageWidth as double
		  Dim pageHeight as double
		  Dim lm as double
		  Dim rm as double
		  Dim tm as double
		  Dim bm as double
		  Dim origLm as double
		  Dim origRm as double
		  Dim origTm as double
		  Dim origBm as double
		  Dim resolution As Integer
		  Var firstPage As Integer
		  Var lastPage As Integer
		  
		  '-------------------------------------------------
		  ' Save the settings.
		  '-------------------------------------------------
		  
		  ' Save the printer setup.
		  me.printer = printer
		  
		  ' Turn off updates.
		  saveState = parentControl.setInhibitUpdates(true)
		  
		  ' Get the printer resolution.
		  resolution = printer.HorizontalResolution
		  
		  ' Save the current parameters.
		  pageWidth = getPageWidth
		  pageHeight = getPageHeight
		  scale = parentControl.getScale
		  
		  ' Save the margins.
		  origLm = getLeftMargin
		  origRm = getRightMargin
		  origTm = getTopMargin
		  origBm = getBottomMargin
		  
		  '-------------------------------------------------
		  ' Set up for printing.
		  '-------------------------------------------------
		  
		  ' Reset the scale to 100%.
		  parentControl.setScale(1.0, false)
		  
		  ' Set the page size.
		  setPageSize(g.Width / resolution, g.Height / resolution)
		  
		  ' Calculate the margins.
		  lm = origLm - (abs(printer.PageLeft) / resolution) + printOffset.left
		  rm = origRm - ((printer.PageWidth - printer.Width - abs(printer.PageLeft)) / resolution) + printOffset.right
		  tm = origTm - (abs(printer.PageTop) / resolution) + printOffset.top
		  bm = origBm - ((printer.PageHeight - printer.Height - abs(printer.PageTop)) / resolution) + printOffset.bottom
		  
		  ' Adjust margins for the printable area.
		  setMargins(lm, rm, tm, bm)
		  
		  ' Set the print scale.
		  printScale = printer.HorizontalResolution / 72
		  
		  '-------------------------------------------------
		  ' Print the pages.
		  '-------------------------------------------------
		  
		  ' Compose the document.
		  markAllParagraphsDirty
		  compose
		  
		  ' This is the proper way to do printing
		  firstPage = g.FirstPage-1
		  lastPage = g.LastPage-1
		  
		  ' Check the ranges.
		  If firstPage < 0 Then firstPage = 0
		  if lastPage > Ubound(pages) then lastPage = Ubound(pages)
		  
		  ' ' Get the number of copies
		  ' Dim iCopyMax As Integer = g.Copies
		  ' dim iCopyCount as integer = 0
		  
		  ' ' On Mac OS X the OS handles the number of copies.
		  ' #If TargetMacOS Then iCopyCount = iCopyMax - 1
		  ' 
		  ' While iCopyCount < iCopyMax
		  ' Print all the visible pages.
		  For i = 0 To pages.LastIndex
		    
		    ' ' Is this not the first page?
		    ' if i <> firstPage then
		    ' 
		    ' ' Create a new page.
		    ' g.NextPage
		    ' 
		    ' end if
		    
		    ' Draw the page.
		    pTop = pages(i).drawPageToPDF(g, Self, printScale, pTop)
		    
		  next
		  ' ' iCopyCount = iCopyCount + 1
		  ' 
		  ' ' #If TargetWindows Then
		  ' ' ' If iCopyCount < iCopyMax Then
		  ' ' ' ' g.NextPage
		  ' ' ' End
		  ' ' #EndIf
		  ' 
		  ' Wend
		  
		  //BK Note:  Leaving this commented out.  The above is the proper way to do printing.
		  ' ' Check the ranges.
		  ' if firstPage < 0 then firstPage = 0
		  ' if lastPage > Ubound(pages) then lastPage = Ubound(pages)
		  '
		  '
		  ' ' Print all the visible pages.
		  ' for i = firstPage to lastPage
		  '
		  ' ' Is this not the first page?
		  ' if i <> firstPage then
		  '
		  ' ' Create a new page.
		  ' g.NextPage
		  '
		  ' end if
		  '
		  ' ' Draw the page.
		  ' pages(i).drawPageViewMode(g, self, printer.PageLeft, printer.PageTop, nil, true, printScale)
		  '
		  ' next
		  
		  '-------------------------------------------------
		  ' Restore the settings.
		  '-------------------------------------------------
		  
		  ' Restore the page size.
		  setPageSize(pageWidth, pageHeight)
		  
		  ' Restore the margins.
		  setMargins(origLm, origRm, origTm, origBm)
		  
		  ' Reset the original state.
		  call parentControl.setInhibitUpdates(saveState)
		  
		  ' Reset the original scale.
		  parentControl.setScale(scale)
		  
		  ' Release the printer setup.
		  me.printer = nil
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub updateParagraphIndexes(index as integer = 0)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  
		  ' Get the number of paragraphs.
		  count = Ubound(paragraphs)
		  
		  ' Update the indexes.
		  for i = index to count
		    
		    ' Change the index of the paragraph.
		    paragraphs(i).setAbsoluteIndex(i)
		    
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub updateSelectionAndAnchor(selectionFlag as boolean, selectStart as FTInsertionOffset, selectEnd as FTInsertionOffset)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Turn off the selection.
		  deselectAll
		  
		  ' Is there something to select?
		  if selectionFlag then
		    
		    ' Extend the selection.
		    selectSegment(selectStart, selectEnd)
		    
		    ' Are we currently on the right side of the selection?
		    if anchor = AnchorTag.RIGHT_SIDE then
		      
		      ' Set the insertion point.
		      setInsertionPoint(selectEnd, CALCULATE_CARET)
		      
		    else
		      
		      ' Set the insertion point.
		      setInsertionPoint(selectStart, CALCULATE_CARET)
		      
		    end if
		    
		  else
		    
		    ' Clear the anchor.
		    anchor = AnchorTag.NONE
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub updateWithStyle(startPosition as FTInsertionOffset, endPosition as FTInsertionOffset, style as FTCharacterStyle)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim index as integer
		  Dim startId as integer
		  Dim sp as FTParagraph
		  Dim ep as FTParagraph
		  
		  ' Get the paragraph information.
		  sp = getParagraph(startPosition.paragraph)
		  ep = getParagraph(endPosition.paragraph)
		  
		  ' Are we within range?
		  if (sp is nil) or (ep is nil) then return
		  
		  ' Is this the same paragraph?
		  if sp.getId = ep.getId then
		    
		    ' Change the style of the paragraph.
		    sp.updateWithStyle(startPosition.offset + 1, endPosition.offset, style)
		    
		  else
		    
		    ' Get the starting paragraph ID.
		    startId = sp.getId
		    
		    ' Get the first full paragraph index.
		    index = ep.getAbsoluteIndex - 1
		    
		    ' Delete the full paragraphs.
		    for i = index downto 0
		      
		      ' Are we at the end?
		      if paragraphs(i).getId = startId then
		        
		        ' We are done.
		        exit
		        
		      end if
		      
		      ' Change the style of the paragraph.
		      paragraphs(i).updateWithStyle(style)
		      
		    next
		    
		    '----------------
		    
		    ' Is whole first paragraph selected?
		    if startPosition.offset = 0 then
		      
		      ' Change the style of the entire first paragraph.
		      sp.updateWithStyle(style)
		      
		    else
		      
		      ' Change the style of the first paragraph.
		      sp.updateWithStyle(startPosition.offset + 1, sp.getLength, style)
		      
		    end if
		    
		    '----------------
		    
		    ' Is whole last paragraph selected?
		    if endPosition.offset >= ep.getLength then
		      
		      ' Change the style of the entire last paragraph.
		      ep.updateWithStyle(style)
		      
		    else
		      
		      ' Change the style of the last paragraph.
		      ep.updateWithStyle(0, endPosition.offset, style)
		      
		    end if
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub xmlHandleAddParagraphs(item as XmlElement)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim paragraph as XmlElement
		  Dim p as FTParagraph
		  
		  ' Get the first paragraph.
		  paragraph = XmlElement(item.FirstChild)
		  
		  ' Add all the paragraphs.
		  while not (paragraph is nil)
		    
		    ' Create the paragraph.
		    p = addNewParagraph
		    
		    ' Populate the paragraph.
		    p.addXmlNode(paragraph)
		    
		    ' Get the next paragraph.
		    paragraph = XmlElement(paragraph.NextSibling)
		    
		  wend
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub xmlHandleCharacterStyle(item as XmlElement)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim cs as XmlElement
		  Dim style as FTCharacterStyle
		  
		  ' Clear out the old character styles.
		  characterStyles.Clear
		  
		  ' Get the first character style.
		  cs = XmlElement(item.FirstChild)
		  
		  ' Add all the character styles.
		  while not (cs is nil)
		    
		    ' Create the style.
		    style = new FTCharacterStyle(parentControl, cs)
		    
		    ' Install the style.
		    // Mantis Ticket 3806: FTDocument.addParagraphStyle and addCharacterStyle bypassed by insertXML and cannot be overridden in subclass
		    addCharacterStyle(style)
		    
		    ' Set the tag.
		    parentControl.callXmlDecodeTag(cs.GetAttribute(FTCxml.XML_TAG), style)
		    
		    ' Get the next character style.
		    cs = XmlElement(cs.NextSibling)
		    
		  wend
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub xmlHandleDocument(item as XmlElement)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Load up the attributes.
		  margins.bottomMargin = Val(item.GetAttribute(FTCxml.XML_BOTTOM_MARGIN))
		  margins.leftMargin = Val(item.GetAttribute(FTCxml.XML_LEFT_MARGIN))
		  pageBackgroundColor = FTUtilities.stringToColor(item.GetAttribute(FTCxml.XML_PAGE_BACKGROUND_COLOR))
		  docMargins.pageHeight = Val(item.GetAttribute(FTCxml.XML_PAGE_HEIGHT))
		  docMargins.pageWidth = Val(item.GetAttribute(FTCxml.XML_PAGE_WIDTH))
		  margins.rightMargin = Val(item.GetAttribute(FTCxml.XML_RIGHT_MARGIN))
		  margins.topMargin = Val(item.GetAttribute(FTCxml.XML_TOP_MARGIN))
		  parentControl.callXmlDecodeTag(item.GetAttribute(FTCxml.XML_TAG), self)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub xmlHandleInsertParagraphs(item as XmlElement, useAttributes as boolean, forceAttributes as boolean)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim paragraph as XmlElement
		  Dim p as FTParagraph
		  Dim offset as integer
		  Dim useAttributesState as boolean
		  
		  ' Get the first paragraph.
		  paragraph = XmlElement(item.FirstChild)
		  
		  ' Is there anything to do?
		  if paragraph is nil then return
		  
		  ' Get the current paragraph.
		  p = insertionPoint.getCurrentParagraph
		  offset = insertionPoint.getOffset.offset
		  
		  ' Should force the use of attributes?
		  if forceAttributes then
		    
		    ' Force the attributes to be used.
		    useAttributesState = true
		    
		  else
		    
		    ' Are we inserting more than one paragraph?
		    if (item.ChildCount > 1) then
		      
		      ' Use the attributes if we are inserting at the beginning
		      ' of the paragraph.
		      useAttributesState = (offset = 0)
		      
		    else
		      
		      ' Use the specified state.
		      useAttributesState = useAttributes
		      
		    end if
		    
		  end if
		  
		  ' Insert the objects into the paragraph.
		  offset = offset + p.insertXmlNode(paragraph, offset, useAttributesState)
		  
		  ' Set the insertion point.
		  insertionPoint.setInsertionPoint(p, offset, false)
		  
		  ' Get the next paragraph.
		  paragraph = XmlElement(paragraph.NextSibling)
		  
		  ' Add all the paragraphs.
		  while not (paragraph is nil)
		    
		    ' Create the paragraph.
		    p = insertNewParagraph(p, offset)
		    
		    ' Populate the paragraph.
		    offset = p.insertXmlNode(paragraph, 0, true)
		    
		    ' Set the insertion point.
		    insertionPoint.setInsertionPoint(p, offset, false)
		    
		    ' Get the next paragraph.
		    paragraph = XmlElement(paragraph.NextSibling)
		    
		  wend
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub xmlHandleParagraphStyle(item as XmlElement)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim ps as XmlElement
		  Dim style as FTParagraphStyle
		  
		  ' Clear out the old paragraph styles.
		  paragraphStyles.Clear
		  
		  ' Get the first paragraph style.
		  ps = XmlElement(item.FirstChild)
		  
		  ' Create the style.
		  style = new FTParagraphStyle(parentControl, ps)
		  
		  ' Install the default style.
		  defaultParagraphStyle = style
		  
		  ' Get the next paragraph style.
		  ps = XmlElement(ps.NextSibling)
		  
		  ' Add all the paragraph styles.
		  while not (ps is nil)
		    
		    ' Create the style.
		    style = new FTParagraphStyle(parentControl, ps)
		    
		    ' Install the style.
		    // Mantis Ticket 3806: FTDocument.addParagraphStyle and addCharacterStyle bypassed by insertXML and cannot be overridden in subclass
		    addParagraphStyle(style)
		    
		    ' Set the tag.
		    parentControl.callXmlDecodeTag(ps.GetAttribute(FTCxml.XML_TAG), style)
		    
		    ' Get the next paragraph style.
		    ps = XmlElement(ps.NextSibling)
		    
		  wend
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub xmlHandleVersion(item as XmlElement)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Load up the attributes.
		  setXMLCreator(item.GetAttribute(FTCxml.XML_CREATOR))
		  setXMLFileType(item.GetAttribute(FTCxml.XML_FILE_TYPE))
		  setXMLFileVersion(item.GetAttribute(FTCxml.XML_FILE_VERSION))
		  setXMLDocumentTag(item.GetAttribute(FTCxml.XML_DOCUMENT_TAG))
		  
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event EndXMLLoad()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event LoadXMLItem(item as XMLElement)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event LoadXMLItemFromAttributeList(attributeList as XmlAttributeList)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event SaveXML(doc as XmlDocument, root as XMLElement)
	#tag EndHook


	#tag Note, Name = XMLReaderNote
		This is an example of the a method you would use to call FTXMLReader.Parse
		
		#pragma DisableBackgroundTasks
		
		#if not DebugBuild
		
		#pragma BoundsChecking FTC_BOUNDSCHECKING
		#pragma NilObjectChecking FTC_NILOBJECTCHECKING
		#pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		
		#endif
		
		
		
		' Clear the document.
		clearParagraphs
		
		' Is there any content to add?
		if Trim(s) = "" then
		
		' Add a blank paragraph.
		call addNewParagraph
		
		' We are done.
		return
		
		end if
		
		dim oReader as new FTXMLReader(self)
		oReader.Parse s
		
		' Signal the end of loading the data.
		EndXMLLoad
		
		' Move the insertion point to the beginning.
		setInsertionPoint(0, 0, false)
		
		' Did an error occur?
		exception excep as RuntimeException
		
		' Clear the document.
		clearParagraphs
		
		' Add a blank paragraph.
		call addNewParagraph
		
		' Reraise the exception.
		raise excep
		
		
	#tag EndNote


	#tag Property, Flags = &h21
		Private allPagesDirty As boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private anchor As AnchorTag = AnchorTag.NONE
	#tag EndProperty

	#tag Property, Flags = &h21
		Private borderColors(6) As Color
	#tag EndProperty

	#tag Property, Flags = &h21
		Private characterStyles As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private clippingPage As Picture
	#tag EndProperty

	#tag Property, Flags = &h21
		Private defaultParagraphStyle As FTParagraphStyle
	#tag EndProperty

	#tag Property, Flags = &h21
		Private defaultTabStops() As FTTabStop
	#tag EndProperty

	#tag Property, Flags = &h21
		Private dirtyIndexes As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private docMargins As DocumentMargins
	#tag EndProperty

	#tag Property, Flags = &h21
		Private insertionPoint As FTInsertionPoint
	#tag EndProperty

	#tag Property, Flags = &h0
		isTyping As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private margins As DisplayMargins
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mGraphics As Graphics
	#tag EndProperty

	#tag Property, Flags = &h21
		Private MonitorPixelsPerInch As double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private normalViewPageHeight As double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private pageBackgroundColor As Color
	#tag EndProperty

	#tag Property, Flags = &h21
		Private pages() As FTPage
	#tag EndProperty

	#tag Property, Flags = &h21
		Private pageSpace As integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private paragraphs() As FTParagraph
	#tag EndProperty

	#tag Property, Flags = &h21
		Private paragraphStyles As dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private printer As PrinterSetup
	#tag EndProperty

	#tag Property, Flags = &h21
		Private printOffset As PrintMarginOffset
	#tag EndProperty

	#tag Property, Flags = &h21
		Private resizeHandle As FTPicture.Handle_Type
	#tag EndProperty

	#tag Property, Flags = &h21
		Private resizeParagraph As FTParagraph
	#tag EndProperty

	#tag Property, Flags = &h21
		Private resizePicture As FTPicture
	#tag EndProperty

	#tag Property, Flags = &h21
		Private selectEnd As FTInsertionOffset
	#tag EndProperty

	#tag Property, Flags = &h21
		Private selectStart As FTInsertionOffset
	#tag EndProperty

	#tag Property, Flags = &h21
		Private spellCheckTimer As FTSpellCheckTimer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private updateDataTimer As FTUpdateDataTimer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private xmlCreator As string
	#tag EndProperty

	#tag Property, Flags = &h21
		Private xmlDocumentTag As string
	#tag EndProperty

	#tag Property, Flags = &h21
		Private xmlFileType As string
	#tag EndProperty

	#tag Property, Flags = &h21
		Private xmlFileVersion As string
	#tag EndProperty


	#tag Constant, Name = CALCULATE_CARET, Type = Boolean, Dynamic = False, Default = \"false", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CARET_OFFSET_INFINITY, Type = Double, Dynamic = False, Default = \"2147483647", Scope = Protected
	#tag EndConstant


	#tag Enum, Name = AnchorTag, Type = Integer, Flags = &h0
		LEFT_SIDE
		  RIGHT_SIDE
		NONE
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
			Name="isTyping"
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
