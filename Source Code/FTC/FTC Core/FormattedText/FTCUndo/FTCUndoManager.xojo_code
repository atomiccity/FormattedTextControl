#tag Class
Protected Class FTCUndoManager
	#tag Method, Flags = &h0
		Sub appendItem(item as UndoItemInterface)
		  Dim topItem as UndoItemInterface
		  Dim ip as FTInsertionPoint
		  
		  ' Is there anything to do?
		  if item is nil then return
		  
		  ' Get the top item off the stack.
		  topItem = peek
		  
		  ' Is this item empty?
		  if (not (topItem is nil)) and (not topItem.isUndoable) then
		    
		    ' Clear the empty item from the stack.
		    pop
		    
		  end if
		  
		  ' Add the item to the undo stack.
		  push(item)
		  
		  'if not (item isa FTCUndoTyping) then
		  'redim redoStack(-1)
		  'end if
		  
		  if item.isUndoable then
		    redim redoStack(-1)
		  end if
		  
		  ' Is something currently selected?4
		  if not doc.isSelected then
		    
		    ' Is the top item on the stack a typing item?
		    if not (item isa FTCUndoTyping) then
		      
		      ' Get the insertion offset.
		      ip = doc.getInsertionPoint
		      
		      ' Add the item to the undo stack.
		      push(new FTCUndoTyping(self, ip.getOffset))
		      
		    end if
		    
		  end if
		  
		  ' Clear the insertion flag.
		  newInsertionFlag = false
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub clear()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Clear the stack and references.
		  Redim undoStack(-1)
		  Redim redoStack(-1)
		  
		  ' Set up an undo object for typing.
		  startNewInsertion
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(parentControl as FormattedText, limit as integer = - 1)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the reference.
		  me.parentControl = parentControl
		  
		  ' Get the document.
		  me.doc = parentControl.getDoc
		  
		  ' Make sure we have enough room to operate.
		  if limit = 0 then limit = 1
		  
		  ' Set the stack limit.
		  setStackLimit(limit)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub dispose()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Clear the stack and references.
		  Redim undoStack(-1)
		  Redim redoStack(-1)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getControl() As FormattedText
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the main control.
		  return parentControl
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getRedoName() As string
		  if redoStack.Ubound<0 then
		    return ""
		  end if
		  return redoStack(redoStack.Ubound).getUndoName
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getUndoName() As string
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim item as UndoItemInterface
		  
		  ' Get the top item off the undo stack.
		  item = peek
		  
		  ' Is there anything to undo?
		  if not (item is nil) then
		    
		    ' Do we need to look past the first item?
		    if (item isa FTCUndoTyping) and (not item.isUndoable) then
		      
		      ' Get the next item off the stack.
		      item = peek(1)
		      
		      ' Is there anything to look at?
		      if not (item is nil) then
		        
		        ' Return the name of the undo item.
		        return item.getUndoName
		        
		      end if
		      
		    else
		      
		      ' Return the name of the undo item.
		      return item.getUndoName
		      
		    end if
		    
		  end if
		  
		  ' Nothing to return.
		  return ""
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isRedoable() As boolean
		  return (redoStack.Ubound>=0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isUndoable() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim item as UndoItemInterface
		  
		  ' Get the top item off the undo stack.
		  item = peek
		  
		  ' Is there anything to undo?
		  if not (item is nil) then
		    
		    ' Do we need to look past the first item?
		    if (item isa FTCUndoTyping) and (not item.isUndoable) then
		      
		      ' Get the next item off the stack.
		      item = peek(1)
		      
		      ' Is there anything to look at?
		      if not (item is nil) then
		        
		        ' Return the status of the undo item.
		        return item.isUndoable
		        
		      end if
		      
		    else
		      
		      ' Return the status of the undo item.
		      return item.isUndoable
		      
		    end if
		    
		  end if
		  
		  ' Not undoable.
		  return false
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function peek(index as integer = 0) As UndoItemInterface
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Is there something in the stack?
		  if (Ubound(undoStack) - index) > -1 then
		    
		    ' Return the item off the stack.
		    return undoStack(Ubound(undoStack) - index)
		    
		  else
		    
		    ' Nothing in the stack.
		    return nil
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub pop()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Is there something in the stack?
		  if Ubound(undoStack) > -1 then
		    
		    ' Remove the top item off the stack.
		    call undoStack.pop
		    
		    ' Is there anything left in the stack?
		    if Ubound(undoStack) > -1 then
		      
		      ' Clear the redo item.
		      'redoItem = nil 'TODO: why?
		      
		    end if
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub push(item as UndoItemInterface)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim topItem as UndoItemInterface
		  
		  ' Is there anything to do?
		  if item is nil then return
		  
		  ' Get the top item off the stack.
		  topItem = peek
		  
		  ' Was there something on top of the stack?
		  if not (topItem is nil) then
		    
		    ' Give the undo object a chance to finish up.
		    topItem.finish
		    
		    ' Is this item undoable?
		    if not topItem.isUndoable then
		      
		      ' Remove the top item.
		      pop
		      
		    end if
		    
		  end if
		  
		  ' Is this a limited stack?
		  if stackLimit > -1 then
		    
		    ' Are we at the upper bound?
		    if Ubound(undoStack) = stackLimit then
		      
		      ' Remove the last item at the bottom of the stack.
		      undoStack.Remove(0)
		      
		    end if
		    
		  end if
		  
		  ' Add the item to the stack.
		  undoStack.Append(item)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub redo()
		  if redoStack.Ubound<0 then
		    return
		  end if
		  
		  Dim state as boolean
		  
		  ' Block updates.
		  state = parentControl.setInhibitUpdates(true)
		  
		  ' Perform the redo action.
		  dim redoItem as UndoItemInterface
		  redoItem = redoStack.Pop
		  redoItem.redo
		  
		  ' Put the item back on the stack.
		  undoStack.Append(redoItem)
		  
		  ' Allow updates to happen.
		  call parentControl.setInhibitUpdates(state)
		  
		  ' Mark the paragraphs for spell checking.
		  parentControl.getDoc.markDirtyParagraphsForSpellCheck
		  
		  ' Update the control.
		  parentControl.update(true, true)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub saveBackspace(obj as FTBase, ip as FTInsertionPoint)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim item as UndoItemInterface
		  
		  ' Get the top of the stack.
		  item = peek(1)
		  
		  ' Is this non-delete item?
		  if (item is nil) or (not (item isa FTCUndoBackspace)) or newInsertionFlag then
		    
		    ' Create a backspace item.
		    item = new FTCUndoBackspace(self, ip.getOffset)
		    
		    ' Put it on the undo stack.
		    appendItem(item)
		    
		  else
		    
		    ' Set the insertion point.
		    FTCUndoBackspace(item).paragraphPosition = ip.getOffset
		    
		  end if
		  
		  ' Add the deleted object.
		  FTCUndoBackspace(item).obj.append(obj)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub saveContent(name as string, startPosition as FTInsertionOffset, endPosition as FTInsertionOffset, originalContent as string, newContent as string)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim item as FTCUndoContent
		  
		  ' Create the undo item.
		  item = new FTCUndoContent(self, name, startPosition, endPosition, originalContent, newContent)
		  
		  ' Put it on the stack.
		  appendItem(item)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub saveCustomInsertion(name as string, startPosition as FTInsertionOffset, endPosition as FTInsertionOffset, newOffset as FTInsertionOffset, selectedContent as string, newContent as string, firstPa as ParagraphAttributes)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim item as FTCUndoPaste
		  
		  ' Create the undo item.
		  item = new FTCUndoPaste(name, self, startPosition, endPosition, _
		  newOffset, selectedContent, newContent, firstPa)
		  
		  ' Put it on the stack.
		  appendItem(item)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub saveDelete(name as string, content as string, startOffset as FTInsertionOffset, endOffset as FTInsertionOffset)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim item as FTCUndoDelete
		  
		  ' Create the undo item.
		  item = new FTCUndoDelete(self, name, startOffset, endOffset, content)
		  
		  ' Put it on the stack.
		  appendItem(item)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub saveDrop(insertionStart as FTInsertionOffset, insertionEnd as FTInsertionOffset, content as string, selectStart as FTInsertionOffset, selectEnd as FTInsertionOffset)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim item as FTCUndoDrop
		  
		  ' Create the undo item.
		  item = new FTCUndoDrop(self, insertionStart, insertionEnd, content, selectStart, selectEnd)
		  
		  ' Put it on the stack.
		  appendItem(item)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub saveForwardDelete(obj as FTBase, ip as FTInsertionPoint)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim item as UndoItemInterface
		  
		  ' Get the top of the stack.
		  item = peek(1)
		  
		  ' Is this non-delete item?
		  if (item is nil) or (not (item isa FTCUndoForwardDelete)) or _
		    newInsertionFlag then
		    
		    ' Create a delete item.
		    item = new FTCUndoForwardDelete(self, ip.getOffset)
		    
		    ' Put it on the undo stack.
		    appendItem(item)
		    
		  else
		    
		    ' Set the insertion point.
		    FTCUndoForwardDelete(item).paragraphPosition = ip.getOffset
		    
		  end if
		  
		  ' Add the deleted object.
		  FTCUndoForwardDelete(item).obj.append(obj)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub saveImageChange(offset as FTInsertionOffset, oldWidth as integer, oldHeight as integer, newWidth as integer, newHeight as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim item as FTCUndoImage
		  
		  ' Were spurious values passed in?
		  if (oldWidth <= 0) or (oldHeight <= 0) or _
		  (newWidth <= 0) or (newHeight <= 0) then return
		  
		  ' Did anything change?
		  if (oldWidth = newWidth) and (oldHeight = newHeight) then return
		  
		  ' Create the undo item.
		  item = new FTCUndoImage(self, FTCStrings.IMAGE_RESIZE, offset, oldWidth, oldHeight, newWidth, newHeight)
		  
		  ' Put it on the stack.
		  appendItem(item)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub saveMove(insertionStart as FTInsertionOffset, selectStart as FTInsertionOffset, selectEnd as FTInsertionOffset, content as string, firstParagraphAttributes as ParagraphAttributes, lastParagraphAttributes as ParagraphAttributes)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim item as FTCUndoMove
		  
		  ' Create the undo item.
		  item = new FTCUndoMove(self, insertionStart, selectStart, selectEnd, _
		  content, firstParagraphAttributes, lastParagraphAttributes)
		  
		  ' Put it on the stack.
		  appendItem(item)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub saveNewMargins()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim item as UndoItemInterface
		  
		  ' Get the top of the stack.
		  item = peek(0)
		  
		  ' Is this non-delete item?
		  if (item is nil) or (not (item isa FTCUndoMargins)) then
		    
		    ' Get the next item off the stack.
		    item = peek(1)
		    
		    ' Is this non-delete item?
		    if (item is nil) or (not (item isa FTCUndoMargins)) then
		      
		      ' Nothing to do.
		      return
		      
		    end if
		    
		  end if
		  
		  ' Save the content.
		  FTCUndoMargins(item).setNewContent(doc.getDisplayMargins)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub saveNewPage()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim item as UndoItemInterface
		  
		  ' Get the top of the stack.
		  item = peek(0)
		  
		  ' Is this non-delete item?
		  if (item is nil) or (not (item isa FTCUndoPage)) then
		    
		    ' Get the next item off the stack.
		    item = peek(1)
		    
		    ' Is this non-delete item?
		    if (item is nil) or (not (item isa FTCUndoPage)) then
		      
		      ' Nothing to do.
		      return
		      
		    end if
		    
		  end if
		  
		  ' Save the content.
		  FTCUndoPage(item).setNewContent(doc.getDocumentMargins)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub saveNewParagraph()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim item as UndoItemInterface
		  
		  ' Get the top of the stack.
		  item = peek(0)
		  
		  ' Is this non-delete item?
		  if (item is nil) or (not (item isa FTCUndoParagraph)) then
		    
		    ' Get the next item off the stack.
		    item = peek(1)
		    
		    ' Is this non-delete item?
		    if (item is nil) or (not (item isa FTCUndoParagraph)) then
		      
		      ' Nothing to do.
		      return
		      
		    end if
		    
		  end if
		  
		  ' Save the content.
		  FTCUndoParagraph(item).setNewContent
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub saveOriginalMargins(name as string)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim item as FTCUndoMargins
		  
		  ' Create the undo item.
		  item = new FTCUndoMargins(self, name, doc.getDisplayMargins)
		  
		  ' Put it on the stack.
		  appendItem(item)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub saveOriginalPage(name as string)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim item as FTCUndoPage
		  
		  ' Create the undo item.
		  item = new FTCUndoPage(self, name, doc.getDocumentMargins)
		  
		  ' Put it on the stack.
		  appendItem(item)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub saveOriginalParagraph(name as string)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim item as FTCUndoParagraph
		  Dim startOffset as FTInsertionOffset
		  Dim endOffset as FTInsertionOffset
		  
		  ' Is the text selected?
		  if doc.isSelected then
		    
		    ' Get the range.
		    doc.getSelectionRange(startOffset, endOffset)
		    
		  else
		    
		    ' Use the insertion point.
		    startOffset = doc.getInsertionOffset
		    endOffset = startOffset
		    
		  end if
		  
		  ' Create the undo item.
		  item = new FTCUndoParagraph(self, name, startOffset, endOffset)
		  
		  ' Put it on the stack.
		  appendItem(item)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub savePageBreak(startOffset as FTInsertionOffset, endOffset as FTInsertionOffset, selectedContent as string)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim item as FTCUndoPageBreak
		  
		  ' Create the undo item.
		  item = new FTCUndoPageBreak(self, startOffset, endOffset, selectedContent)
		  
		  ' Put it on the stack.
		  appendItem(item)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub savePaste(byref startPosition as FTInsertionOffset, byref endPosition as FTInsertionOffset, byref newOffset as FTInsertionOffset, byref selectedContent as string, newContent as string, byref firstPa as ParagraphAttributes)
		  //BK 08Nov.  This method is now getting most parameters byref because of Win64 issue with pasting (hard crash).
		  // Private <feedback://showreport?report_id=53967>
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim item as FTCUndoPaste
		  
		  ' Create the undo item.
		  item = new FTCUndoPaste(FTCStrings.PASTE, self, startPosition, endPosition, _
		  newOffset, selectedContent, newContent, firstPa)
		  
		  ' Put it on the stack.
		  appendItem(item)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub saveTyping(key as string, io as FTInsertionOffset)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim item as UndoItemInterface
		  
		  ' Get the top of the stack.
		  item = peek
		  
		  ' Is this non-delete item?
		  if (item is nil) or (not (item isa FTCUndoTyping)) or (not item.isUndoable) then
		    
		    ' Start a typing undo.
		    startNewInsertion(io)
		    
		    ' Get the top of the stack.
		    item = peek
		    
		  end if
		  
		  ' Add the key.
		  FTCUndoTyping(item).addKey(io, key)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setStackLimit(limit as integer)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Check the range.
		  if limit < -1 then limit = -1
		  
		  ' Save the stack limit.
		  stackLimit = limit
		  
		  ' Is this a limited stack?
		  if stackLimit > -1 then
		    
		    ' Do we need to trim the stack?
		    while Ubound(undoStack) > stackLimit
		      
		      ' Remove the item from the bottom of the stack.
		      undoStack.Remove(0)
		      
		    wend
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub startNewInsertion()
		  startNewInsertion(doc.newInsertionOffset(0, 0))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub startNewInsertion(io as FTinsertionOffset)
		  Dim item as UndoItemInterface
		  
		  ' Get the item on top of the stack.
		  item = peek
		  
		  ' Was there something on the stack?
		  if not (item is nil) then
		    
		    ' Do we need to clear out a typing item?
		    if not item.isUndoable then
		      
		      ' Clear the item.
		      call me.pop
		      
		    else
		      
		      ' Finish that item off.
		      item.finish
		      
		    end if
		    
		  end if
		  
		  ' Start an undo object to capture the typing.
		  appendItem(new FTCUndoTyping(self, io))
		  
		  ' Signal the new insertion.
		  newInsertionFlag = true
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub undo()
		  Dim item as UndoItemInterface
		  Dim state as boolean
		  
		  item = peek
		  if item is nil then
		    return
		  end if
		  
		  ' Do we need to look past the first item?
		  if (item isa FTCUndoTyping) and (not item.isUndoable) then
		    pop
		  end if
		  
		  ' Block updates.
		  state = parentControl.setInhibitUpdates(true)
		  
		  ' Get the undo item.
		  item = undoStack.pop
		  item.finish
		  item.undo
		  
		  'Put the redo item at the top of the Redo Stack
		  if item.isRedoable then
		    redoStack.Append(item)
		  else
		    break
		  end if
		  
		  ' Allow updates to happen.
		  call parentControl.setInhibitUpdates(state)
		  
		  ' Mark the paragraphs for spell checking.
		  parentControl.getDoc.markDirtyParagraphsForSpellCheck
		  
		  ' Update the control.
		  parentControl.update(true, true)
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private doc As FTDocument
	#tag EndProperty

	#tag Property, Flags = &h21
		Private newInsertionFlag As boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private parentControl As FormattedText
	#tag EndProperty

	#tag Property, Flags = &h21
		Private redoStack() As UndoItemInterface
	#tag EndProperty

	#tag Property, Flags = &h21
		Private stackLimit As integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private undoStack() As UndoItemInterface
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
