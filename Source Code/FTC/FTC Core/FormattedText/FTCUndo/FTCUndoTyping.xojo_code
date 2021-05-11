#tag Class
Protected Class FTCUndoTyping
Inherits FTCUndoBase
	#tag Method, Flags = &h0
		Sub addKey(offset as FTInsertionOffset, key as string)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim undoItem as FTCUndoContentItem
		  
		  ' Is this a return?
		  if key = EndOfLine.Macintosh then
		    
		    ' Complete the previous item.
		    completeLastItem(offset)
		    
		    ' Create the return item.
		    undoItem = new FTCUndoContentItem(offset, true)
		    
		    ' Add the return.
		    contents.Append(undoItem)
		    
		  else
		    
		    ' Get the item on top of the stack.
		    undoItem = contents(Ubound(contents))
		    
		    ' Is it a return?
		    if undoItem.isReturn then
		      
		      ' Create the next typing item.
		      undoItem = new FTCUndoContentItem(offset)
		      
		      ' Add the typing item.
		      contents.Append(undoItem)
		      
		    end if
		    
		  end if
		  
		  ' Set the end point.
		  contents(Ubound(contents)).setEndPosition(offset)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub completeLastItem(offset as FTInsertionOffset)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  #pragma Unused offset
		  
		  Dim undoItem as FTCUndoContentItem
		  
		  ' Get the top level undo item.
		  undoItem = contents(Ubound(contents))
		  
		  ' Is there anything to do?
		  if undoItem.isReturn then return
		  
		  ' Is there anything to look at?
		  if undoItem.hasEndPoint then
		    
		    ' Save the content.
		    undoItem.setContent(doc.getXML(undoItem.startOffset, undoItem.endOffset + 1))
		    
		  else
		    
		    ' Remove the empty item.
		    contents.Remove(Ubound(contents))
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub constructor(parent as FTCUndoManager, offset as FTInsertionOffset)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim undoItem as FTCUndoContentItem
		  
		  ' Initialize the base.
		  Super.Constructor(parent, FTCStrings.TYPING)
		  
		  ' Create the next typing item.
		  undoItem = new FTCUndoContentItem(offset)
		  
		  ' Add the typing item.
		  contents.Append(undoItem)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Destructor()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Release the references.
		  Redim contents(-1)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub finish()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim undoItem as FTCUndoContentItem
		  
		  ' Get the top level undo item.
		  undoItem = contents(Ubound(contents))
		  
		  ' Update the last item.
		  completeLastItem(undoItem.endOffset)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isUndoable() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim undoItem as FTCUndoContentItem
		  
		  ' Is there anything to undo?
		  if Ubound(contents) = -1 then return false
		  
		  ' Is there more than  one item in the list?
		  if Ubound(contents) > 0 then
		    
		    ' It is undoable.
		    return true
		    
		  end if
		  
		  ' Get the top item.
		  undoItem = FTCUndoContentItem(contents(Ubound(contents)))
		  
		  ' Is it a return item?
		  if undoItem.isReturn then return true
		  
		  ' Has some typing occurred?
		  return undoItem.hasContent
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub redo()
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim item as FTCUndoContentItem
		  Dim doc as FTDocument
		  
		  ' Get the number of items.
		  count = Ubound(contents)
		  
		  ' Is there anything to do?
		  if count = -1 then return
		  
		  ' Get the first undo item.
		  item = contents(0)
		  
		  ' Get the document.
		  doc = parent.getControl.getDoc
		  
		  ' Set the insertion point.
		  doc.deselectAll
		  doc.setInsertionPoint(item.startOffset, false)
		  
		  ' Redo the items.
		  for i = 0 to count
		    
		    ' Redo the item.
		    redoItem(i)
		    
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub redoItem(index as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim doc as FTDocument
		  Dim item as FTCUndoContentItem
		  
		  ' Get the document.
		  doc = parent.getControl.getDoc
		  
		  ' Get the undo item.
		  item = contents(index)
		  
		  ' Is this a return?
		  if item.isReturn then
		    
		    ' Insert the return.
		    doc.insertString(EndOfLine.Macintosh)
		    
		  else
		    
		    ' Restore the content.
		    doc.insertXml(item.getContent, true, false)
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub undo()
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim p as FTParagraph
		  Dim startSkipCount as integer
		  Dim endSkipCount as integer
		  
		  ' Get the number of items.
		  count = Ubound(contents)
		  
		  '----------------------------------------------------
		  ' Count the beginning returns.
		  '----------------------------------------------------
		  
		  ' Scan for returns.
		  for i = 0 to count
		    
		    ' Is the last item a return?
		    if contents(i).isReturn then
		      
		      ' Found a return.
		      startSkipCount = startSkipCount + 1
		      
		    else
		      
		      ' We are done looking.
		      exit
		      
		    end if
		    
		  next
		  
		  '----------------------------------------------------
		  ' Count the ending returns.
		  '----------------------------------------------------
		  
		  ' Were there only returns?
		  if startSkipCount < (count + 1) then
		    
		    ' Scan for returns.
		    for i = count downto 0
		      
		      ' Is the last item a return?
		      if contents(i).isReturn then
		        
		        ' Found a return.
		        endSkipCount = endSkipCount + 1
		        
		      else
		        
		        ' We are done looking.
		        exit
		        
		      end if
		      
		    next
		    
		  end if
		  
		  '----------------------------------------------------
		  ' Delete the text in the middle.
		  '----------------------------------------------------
		  
		  ' Deselect all content.
		  doc.deselectAll
		  
		  ' Is there anything to delete?
		  if (startSkipCount + endSkipCount) < (count + 1) then
		    
		    ' Delete the text.
		    doc.deleteSegment(contents(startSkipCount).startOffset, _
		    contents(count - endSkipCount).endOffset + 1)
		    
		  end if
		  
		  '----------------------------------------------------
		  ' Delete the returns.
		  '----------------------------------------------------
		  
		  ' Calculate the paragraphs to combine.
		  count = startSkipCount + endSkipCount
		  
		  ' Combine the paragraphs.
		  for i = 1 to count
		    
		    ' Delete the return.
		    doc.combineParagraphs(contents(0).startOffset.paragraph)
		    
		  next
		  
		  '----------------------------------------------------
		  ' Finish up.
		  '----------------------------------------------------
		  
		  ' Get the combined paragraph.
		  p = doc.getParagraph(contents(0).startOffset.paragraph)
		  
		  ' Did we get a paragraph?
		  if not (p is nil) then
		    
		    ' Set the insertion point.
		    doc.setInsertionPoint(p, contents(0).startOffset.offset, false)
		    
		  end if
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private contents() As FTCUndoContentItem
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="content"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
			InheritedFrom="FTCUndoBase"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="length"
			Group="Behavior"
			InitialValue="0"
			Type="integer"
			InheritedFrom="FTCUndoBase"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="undoName"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
			InheritedFrom="FTCUndoBase"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
