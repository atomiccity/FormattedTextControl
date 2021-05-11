#tag Class
Protected Class FTInsertionPoint
Inherits FTBase
	#tag Method, Flags = &h0
		Sub calculateCaretOffset()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim ignore as double
		  Dim p as FTParagraph
		  
		  ' Reset the offset.
		  caretOffset = 0
		  
		  ' Get the current paragraph.
		  p = getCurrentParagraph
		  
		  ' Is there anything to do?
		  if p is nil then return
		  
		  ' Calculate the X offset of the insertion caret.
		  p.getInsertionPoint(0, self, caretOffset, ignore, ignore, ignore)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(parentControl as FormattedText, doc as FTDocument, trackChanges as boolean = false)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Is this the main insertion point holder?
		  me.trackChanges = trackChanges
		  
		  ' Create the offset object.
		  io = new FTInsertionOffset(doc, 0, 0)
		  
		  ' Set the previous position to the default.
		  previousInsertionOffset = io.clone
		  
		  ' Save the parent control.
		  Super.Constructor(parentControl, doc)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub findProxy()
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim lineIndex as integer
		  Dim offsetIndex as integer
		  Dim p as FTParagraph
		  Dim pp as FTParagraphProxy
		  Dim startLine as integer
		  Dim endLine as integer
		  
		  ' Is the current proxy been set?
		  if currentProxyParagraph <> -1 then
		    
		    ' Has the proxy been set?
		    if not setProxy then
		      
		      ' Set up for the next time around.
		      setProxy = true
		      
		      ' We don't need to look for it.
		      return
		      
		    end if
		    
		  end if
		  
		  ' Get the paragraph.
		  p = doc.getParagraph(io.paragraph)
		  
		  ' Does it exist?
		  if p is nil then return
		  
		  ' Make it zero based.
		  count = p.getProxyItemCount - 1
		  
		  ' Is there only one proxy?
		  if count = 0 then
		    
		    ' Set the proxy.
		    currentProxyParagraph = p.getProxyItem(0).getProxyId
		    
		    ' We are done.
		    return
		    
		  end if
		  
		  ' Find the line for the offset.
		  p.findLine(0, io.offset, io.bias, lineIndex, offsetIndex)
		  
		  ' Find the correct proxy.
		  for i = 0 to count
		    
		    ' Get the proxy.
		    pp = p.getProxyItem(i)
		    
		    ' Get the line range of the proxy.
		    pp.getStartAndEndLines(startLine, endLine)
		    
		    ' Are we within this proxy?
		    if (lineIndex >= startLine) and (lineIndex <= endLine) then
		      
		      ' Save the paragraph proxy.
		      currentProxyParagraph = pp.getProxyId
		      
		      ' We are done.
		      return
		      
		    end if
		    
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getBias() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Get the bias.
		  return io.bias
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getCaretOffset(calculate as boolean = false) As double
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Should we calculate the offset?
		  if calculate then calculateCaretOffset
		  
		  ' Return the caret offset.
		  return caretOffset
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getCaretState() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the blink state of the insertion caret.
		  return caretState
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getCurrentParagraph() As FTParagraph
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Is there anything to look at?
		  if not io.isSet then return nil
		  
		  ' Return the current paragraph.
		  return doc.getParagraph(io.paragraph)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getCurrentProxyParagraph() As FTParagraphProxy
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim pp as FTParagraphProxy
		  
		  ' Is there anything in the control?
		  if currentProxyParagraph < 0 then return nil
		  
		  ' Get the proxy.
		  pp = getCurrentParagraph.getProxyById(currentProxyParagraph)
		  
		  ' Was the proxy set?
		  if pp is nil then
		    
		    ' Compose the proxies.
		    doc.compose
		    
		    ' Find the current proxy.
		    findProxy
		    
		    ' Get the proxy.
		    pp = getCurrentParagraph.getProxyById(currentProxyParagraph)
		    
		  end if
		  
		  ' Return the current paragraph.
		  return pp
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getHeightToOffset() As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Is there anything to do?
		  if currentProxyParagraph = -1 then return 0
		  
		  ' Find the line height to the offset.
		  return getCurrentProxyParagraph.findLineHeightToOffset(io.offset, _
		  false, parentControl.getDisplayScale)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getOffset() As FTinsertionOffset
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the offset.
		  return io.clone
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isAtEndOfParagraph() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim p as FTParagraph
		  
		  ' Get the current paragraph.
		  p = getCurrentParagraph
		  
		  ' Is there anything to do?
		  if p is nil then return false
		  
		  ' Are we at the end of the current paragraph?
		  return (io.offset = (p.getLength + 1))
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub reset()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Clear the data.
		  caretState = false
		  io.clear
		  caretOffset = 0
		  currentProxyParagraph = -1
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setBias(state as boolean)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set the bias.
		  io.bias = state
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setCaretState(state as boolean)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set the caret state.
		  caretState = state
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setInsertionPoint(io as FTInsertionOffset, calculateOffset as boolean)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Was the point specified?
		  if io is nil then
		    
		    ' Set the insertion point to the beginning.
		    setInsertionPoint(0, 0, calculateOffset, true)
		    
		  else
		    
		    ' Set the insertion point.
		    setInsertionPoint(io.paragraph, io.offset, calculateOffset, io.bias)
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setInsertionPoint(p as FTParagraph, offset as integer, calculateOffset as boolean, bias as boolean = false)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Is there anything to do?
		  if p is nil then return
		  
		  ' Set the insertion point.
		  setInsertionPoint(p.getAbsoluteIndex, offset, calculateOffset, bias)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setInsertionPoint(pp as FTParagraphProxy, offset as integer, calculateOffset as boolean, bias as boolean = false)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set the insertion point.
		  currentProxyParagraph = pp.getProxyId
		  offset = pp.getParent.getLineLength(0, pp.getLineStart - 1) + offset
		  
		  ' The proxy has been set.
		  setProxy = false
		  
		  ' Set the insertion point.
		  setInsertionPoint(pp.getParent.getAbsoluteIndex, offset, calculateOffset, bias)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setInsertionPoint(paragraph as integer, offset as integer, calculateOffset as boolean, bias as boolean = false)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Have we been intialized and the insertion point has not change?
		  if io.isSet and (paragraph = previousInsertionOffset.paragraph) and _
		    (offset = previousInsertionOffset.offset) and _
		    (bias = previousInsertionOffset.bias) then
		    
		    ' Should the X offset be reset?
		    if calculateOffset then
		      
		      ' Calculate the offset.
		      calculateCaretOffset
		      
		    end if
		    
		    ' We are done.
		    return
		    
		  end if
		  
		  ' Check the ranges.
		  if paragraph < 0 then
		    
		    ' Set it to the beginning of the document.
		    paragraph = 0
		    offset = 0
		    bias = true
		    
		  end if
		  
		  ' Are we past the end of the document?
		  if paragraph > (doc.getParagraphCount - 1) then
		    
		    ' Set it to the end of the document.
		    paragraph = Max(doc.getParagraphCount - 1, 0)
		    offset = getCurrentParagraph.getLength
		    bias = false
		    
		  end if
		  
		  ' Is the offset out of range?
		  if offset < 0 then
		    
		    ' Give it a sane value.
		    offset = 0
		    
		    ' We should not get here.
		    break
		    
		  end if
		  
		  ' Are we at the very beginning?
		  if (paragraph = 0) and (offset = 0) then bias = true
		  
		  ' Set the insertion point.
		  io.set(paragraph, offset)
		  io.bias = bias
		  
		  ' Find the proxy paragraph.
		  findProxy
		  
		  ' Should the X offset be reset?
		  if calculateOffset then
		    
		    ' Calculate the offset.
		    calculateCaretOffset
		    
		  end if
		  
		  ' Are we tracking changes to the insertion point?
		  if trackChanges and (previousInsertionOffset <> io) then
		    
		    ' Notify the control.
		    parentControl.callInsertionPointChangedEvent(previousInsertionOffset, io)
		    
		  end if
		  
		  ' Save the current offset.
		  previousInsertionOffset = io.clone
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private caretOffset As double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private caretState As boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private currentProxyParagraph As integer = -1
	#tag EndProperty

	#tag Property, Flags = &h21
		Private io As FTInsertionOffset
	#tag EndProperty

	#tag Property, Flags = &h21
		Private previousInsertionOffset As FTInsertionOffset
	#tag EndProperty

	#tag Property, Flags = &h21
		Private setProxy As boolean = true
	#tag EndProperty

	#tag Property, Flags = &h21
		Private trackChanges As boolean
	#tag EndProperty


	#tag ViewBehavior
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
	#tag EndViewBehavior
End Class
#tag EndClass
