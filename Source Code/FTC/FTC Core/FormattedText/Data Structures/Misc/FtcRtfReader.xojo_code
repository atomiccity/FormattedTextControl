#tag Class
Protected Class FtcRtfReader
Inherits RTFReader
	#tag Event
		Sub AddPicture(p as Picture)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim ftp as FTPicture
		  
		  ' Create the picture object.
		  ftp = new FTPicture(doc.parentControl, p)
		  
		  ' Copy over the style attributes.
		  ftp.copyStyleData(getCurrentStyle)
		  
		  ' Save the picture.
		  items.Append(ftp)
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub EndOfParsing(docAttributes as RTFDocumentAttributes)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim characterStyles() as RTFCharacterStyle
		  Dim paragraphStyles() as RTFparagraphStyle
		  
		  ' Are there any left overs?
		  if Ubound(items) > -1 then
		    
		    ' Add the leftovers.
		    createNewParagraph(true)
		    
		    ' Clear the data.
		    Redim items(-1)
		    
		  end if
		  
		  ' Should we use the document attributes?
		  if useDocumentAttributes then
		    
		    ' Set the document margins.
		    doc.setLeftMargin(RTFUtilities.TWIPSToInches(docAttributes.leftMargin))
		    doc.setRightMargin(RTFUtilities.TWIPSToInches(docAttributes.rightMargin))
		    doc.setTopMargin(RTFUtilities.TWIPSToInches(docAttributes.topMargin))
		    doc.setBottomMargin(RTFUtilities.TWIPSToInches(docAttributes.bottomMargin))
		    
		    ' Set the page diemensions.
		    doc.setPageSize(RTFUtilities.TWIPSToInches(docAttributes.pageWidth), _
		    RTFUtilities.TWIPSToInches(docAttributes.pageHeight))
		    
		  end if
		  
		  '-------------------------------------------
		  
		  ' Get the styles.
		  paragraphStyles = getParagraphStyles
		  
		  ' Get the number of styles.
		  count = Ubound(paragraphStyles)
		  
		  ' Add all the styles.
		  for i = 0 to count
		    
		    ' Add the style.
		    doc.addParagraphStyle(new FTParagraphStyle(doc.parentControl, paragraphStyles(i)))
		    
		  next
		  
		  '-------------------------------------------
		  
		  ' Get the styles.
		  characterStyles = getCharacterStyles
		  
		  ' Get the number of styles.
		  count = Ubound(characterStyles)
		  
		  ' Add all the styles.
		  for i = 0 to count
		    
		    ' Add the style.
		    doc.addCharacterStyle(new FTCharacterStyle(doc.parentControl, characterStyles(i)))
		    
		  next
		  
		  '-------------------------------------------
		  
		  ' Update the control.
		  doc.parentControl.update(true, true)
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub EscapedCharacter(ch as string)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Add the escaped character.
		  addString(ConvertEncoding(ch, Encodings.UTF8))
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub NewParagraph()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Start a new paragraph.
		  createNewParagraph(false)
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub NonbreakingHyphen()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Add a hyphen.
		  addString("-")
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub NonbreakingSpace()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Add the space.
		  addString(" ")
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub TextSegment(s as string)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Convert the string to UTF8
		  s = ConvertEncoding(s, Encodings.UTF8)
		  
		  
		  ' Add the string to the document.
		  addString(s)
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub addString(s as string)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim sr as FTStyleRun
		  Dim fto() as FTObject
		  
		  ' Create a new item.
		  sr = new FTStyleRun(doc.parentControl, s)
		  
		  ' Copy over the style attributes.
		  sr.copyStyleData getCurrentStyle
		  
		  ' Are there tabs in this situation?
		  fto = sr.splitOnTabs
		  
		  ' Get the number of segments.
		  count = Ubound(fto)
		  
		  ' Add the items.
		  for i = 0 to count
		    
		    ' Add the item.
		    items.Append(fto(i))
		    
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(doc as FTDocument, useDocumentAttributes as boolean, applyStyles as boolean)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the reference.
		  me.doc = doc
		  
		  ' Save the setting.
		  me.useDocumentAttributes = useDocumentAttributes
		  
		  ' Initialize the first paragraph.
		  firstParagraph = true
		  
		  ' Initialize the object.
		  Super.Constructor(applyStyles)
		  
		  ' Initialize the current paragraph to the insertion point.
		  currentParagraph = doc.getInsertionPoint.getCurrentParagraph
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub createNewParagraph(lastParagraph as boolean)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim length as integer
		  Dim io as FTInsertionOffset
		  Dim currentLength as integer
		  Dim offset as integer
		  
		  ' Get the offset into the current paragraph.
		  io = doc.getInsertionPoint.getOffset
		  
		  ' Save some information.
		  currentLength = currentParagraph.getLength
		  offset = io.offset
		  
		  ' Insert the objects into the paragraph.
		  currentParagraph.insertObjects(io.offset, items)
		  
		  ' Get the length of the insertion.
		  length = getInsertionLength
		  
		  ' Update the insertion point.
		  doc.getInsertionPoint.setInsertionPoint(io + length, false)
		  
		  ' Clear the data for the paragraph.
		  Redim items(-1)
		  
		  ' Is this the first paragraph
		  if firstParagraph then
		    
		    ' Are we inserting into a blank paragraph?
		    if (currentLength = 0) or (offset = 0) then
		      
		      ' Update the attributes.
		      updateParagraphAttributes
		      
		    end if
		    
		    ' We have seen the first paragraph.
		    firstParagraph = false
		    
		  else
		    
		    ' Update the attributes.
		    updateParagraphAttributes
		    
		  end if
		  
		  ' Should we add a new paragraph?
		  if lastParagraph then return
		  
		  ' Create a new paragraph.
		  currentParagraph = doc.insertNewParagraph(currentParagraph, doc.getInsertionPoint.getOffset.offset)
		  
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
		  currentParagraph = nil
		  doc = nil
		  Redim items(-1)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function getInsertionLength() As integer
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim length as integer
		  
		  ' Get the number of items inserted.
		  count = Ubound(items)
		  
		  ' Get the total length.
		  for i = 0 to count
		    
		    ' Add in the length of the inserted item.
		    length = length + items(i).getLength
		    
		  next
		  
		  ' Return the length.
		  return length
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub updateParagraphAttributes()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim att as RTFParagraphAttributes
		  
		  ' Get the paragraph attributes.
		  att = getCurrentParagraphAttributes
		  
		  ' Set the surrounding space attributes.
		  currentParagraph.setBeforeSpace(RTFUtilities.TWIPSToInches(att.beforeSpace))
		  currentParagraph.setAfterSpace(RTFUtilities.TWIPSToInches(att.afterspace))
		  currentParagraph.setLineSpacing(att.lineSpacing / 240)
		  
		  ' Set the margins.
		  currentParagraph.setFirstIndent(att.firstIndent)
		  currentParagraph.setLeftMargin(att.leftMargin)
		  currentParagraph.setRightMargin(att.rightMargin)
		  
		  ' Set the background color.
		  currentParagraph.setBackgroundColor(att.backgroundColor)
		  
		  ' Set the alignment of the paragraph.
		  select case att.alignment
		    
		  case RTFAlignment.ALIGN_LEFT
		    
		    ' Left justified.
		    currentParagraph.setAlignment(FTParagraph.Alignment_Type.Left)
		    
		  case RTFAlignment.ALIGN_CENTER
		    
		    ' Center justified.
		    currentParagraph.setAlignment(FTParagraph.Alignment_Type.Center)
		    
		  case RTFAlignment.ALIGN_RIGHT
		    
		    ' Right justified.
		    currentParagraph.setAlignment(FTParagraph.Alignment_Type.Right)
		    
		  case RTFAlignment.ALIGN_FULL
		    
		    ' Default to left justified.
		    currentParagraph.setAlignment(FTParagraph.Alignment_Type.Left)
		    
		  case RTFAlignment.ALIGN_NONE
		    
		    ' Default to left justified.
		    currentParagraph.setAlignment(FTParagraph.Alignment_Type.Left)
		    
		  else
		    
		    ' Default to left justified.
		    currentParagraph.setAlignment(FTParagraph.Alignment_Type.Left)
		    
		  end select
		  
		  ' Set the page break.
		  currentParagraph.setPageBreak(att.pageBreak)
		  
		  ' Clear the tab stops.
		  currentParagraph.clearTabStops
		  
		  ' Get the number of tab stops.
		  count = Ubound(att.tabStops)
		  
		  ' Add all the tab stops.
		  For i = 0 To count
		    
		    ' Add the tab stop.
		    Dim currentTab() As String = att.tabStops(i).Split(";")
		    Dim tabLeaderSign As Integer = Val(currentTab(0))
		    
		    Dim tabLeader As FTTab.Tab_Leader_Type
		    tabLeader = FTTab.Tab_Leader_Type(tabLeaderSign)
		    
		    Dim tabSpace As Double = RTFUtilities.TWIPSToInches(Val(currentTab(1)))
		    currentParagraph.addTabStop(FTTabStop.TabStopType.Left, tabSpace, tabLeader)
		    
		  Next
		  
		  ' Make sure the attributes make sence.
		  currentParagraph.verifyAttibutes
		  
		  ' Reset the caches.
		  currentParagraph.reset
		  
		  ' Update the style attributes.
		  updateStyleAttributes
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub updateStyleAttributes()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim cs as FTCharacterStyle
		  Dim rtfCs as RTFCharacterStyle
		  
		  ' Is this an empty paragraph?
		  if currentParagraph.getLength = 0 then
		    
		    ' Create the RTF character style.
		    rtfCs = new RTFCharacterStyle(getCurrentStyle)
		    
		    ' Populate a character style.
		    cs = new FTCharacterStyle(doc.parentControl, rtfCs)
		    
		    ' Update the paragraph with the style attributes.
		    currentParagraph.updateWithStyle(cs)
		    
		  end if
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private currentParagraph As FTParagraph
	#tag EndProperty

	#tag Property, Flags = &h21
		Private doc As FTDocument
	#tag EndProperty

	#tag Property, Flags = &h21
		Private firstParagraph As boolean = true
	#tag EndProperty

	#tag Property, Flags = &h21
		Private items() As FTObject
	#tag EndProperty

	#tag Property, Flags = &h21
		Private useDocumentAttributes As boolean
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
