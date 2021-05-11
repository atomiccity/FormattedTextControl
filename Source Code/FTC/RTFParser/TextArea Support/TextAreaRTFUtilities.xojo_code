#tag Module
Protected Module TextAreaRTFUtilities
	#tag Method, Flags = &h21
		Private Sub addText(oRTFWrite as RTFWriter, oStyleRun as StyleRun, text as string, pa() as RTFAlignment, ByRef pi as integer)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  
		  
		  ' Normalize any line endings.
		  text = ReplaceLineEndings(text, EndOfLine.Macintosh)
		  
		  ' Break into paragraphs.
		  dim arsParagraphs() as string = parseText(text)
		  
		  
		  ' Add all the paragraphs.
		  for i as integer = 0 to arsParagraphs.Ubound
		    
		    ' Get a paragraph.
		    text = arsParagraphs(i)
		    
		    ' Does paragraph have something in it?
		    if text = EndOfLine.Macintosh then
		      
		      ' Set the paragraph alignment.
		      oRTFWrite.setAlignment(pa(pi))
		      pi = pi + 1
		      
		      ' Create a paragraph.
		      oRTFWrite.newParagraph
		      
		    else
		      
		      ' Add the style run.
		      composeStyleRun(oRTFWrite, oStyleRun, text)
		      
		    end if
		    
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function buildAlignmentArray(oTextArea as TextArea, ari() as integer) As RTFAlignment()
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim count as integer
		  Dim aroAlignments() as RTFAlignment
		  
		  
		  ' Extract the paragraph alignments from the text area.
		  Dim d as Dictionary = buildAlignmentLookup(oTextArea.styledText)
		  
		  ' Get the number of paragraphs.
		  count = Ubound(ari)
		  
		  ' Allocate space for the alignments.
		  Redim aroAlignments(count)
		  
		  ' Assign alignments to each paragraph.
		  for i as integer = 0 to count
		    
		    ' Does the start of the paragraph exist?
		    if d.HasKey(ari(i)) then
		      
		      ' Associate the alignment with it.
		      aroAlignments(i) = d.Value(ari(i))
		      
		    end if
		    
		  next
		  
		  ' Return the paragraph alignment list.
		  return aroAlignments
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function buildAlignmentLookup(oStyledText as StyledText) As dictionary
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim d as Dictionary
		  Dim p as Paragraph
		  Dim alignment as RTFAlignment
		  
		  ' Create the lookup dictionary.
		  d = new Dictionary
		  
		  
		  ' Go through the alignments.
		  for i as integer = 0 to oStyledText.ParagraphCount - 1
		    
		    ' Get a paragraph.
		    p = oStyledText.Paragraph(i)
		    
		    ' Translate the alignment.
		    select case p.Alignment
		      
		    case Paragraph.AlignLeft
		      
		      alignment = RTFAlignment.ALIGN_LEFT
		      
		    case Paragraph.AlignCenter
		      
		      alignment = RTFAlignment.ALIGN_CENTER
		      
		    case Paragraph.AlignRight
		      
		      alignment = RTFAlignment.ALIGN_RIGHT
		      
		    case Paragraph.AlignDefault
		      
		      alignment = RTFAlignment.ALIGN_LEFT
		      
		    end select
		    
		    ' Associate the alignment with the start of the paragraph.
		    d.value(p.StartPos) = alignment
		    
		  next
		  
		  ' Return the dictionary.
		  return d
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub composeStyleRun(oRTFWrite as RTFWriter, oStyleRun as StyleRun, text as string)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Start a new group.
		  oRTFWrite.startGroup
		  
		  ' Add the text.
		  oRTFWrite.setText(text)
		  
		  ' Set the font information.
		  oRTFWrite.setFont(oStyleRun.Font)
		  oRTFWrite.setFontSize(oStyleRun.Size)
		  
		  ' Add the style characteristics.
		  if oStyleRun.Bold then oRTFWrite.setBold
		  if oStyleRun.Italic then oRTFWrite.setItalic
		  if oStyleRun.TextColor <> &c000000 then oRTFWrite.setForegroundColor(oStyleRun.TextColor)
		  if oStyleRun.Underline then oRTFWrite.setUnderline
		  
		  ' End the group.
		  oRTFWrite.endGroup
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function findSelectionInfo(st as StyledText, iSelStart as integer, iSelEnd as integer, ariParStart() as integer) As SelectionInfo
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim si as SelectionInfo
		  Dim oRange as Range
		  
		  ' Get the number of style runs.
		  dim iStyleRunCount as integer = st.StyleRunCount - 1
		  
		  si.styleRunStart = iStyleRunCount
		  si.styleRunStartIndex = -1
		  
		  si.styleRunEnd = iStyleRunCount
		  si.styleRunEndIndex = -1
		  
		  '--------------------------------------------
		  ' Style run start.
		  '--------------------------------------------
		  
		  ' Scan the style runs.
		  for i as integer = 0 to iStyleRunCount
		    
		    ' Get the style run range.
		    oRange = st.StyleRunRange(i)
		    
		    ' Are we in the range of this run?
		    if (iSelStart >= oRange.StartPos) and (iSelStart <= oRange.EndPos) then
		      
		      ' We found it.
		      si.styleRunStart = i
		      si.styleRunStartIndex = iSelStart - oRange.StartPos
		      exit
		      
		    end if
		    
		  next
		  
		  '--------------------------------------------
		  ' Style run end.
		  '--------------------------------------------
		  
		  ' Scan the style runs.
		  dim bFoundEnd as boolean
		  for i  as integer = si.styleRunStart to iStyleRunCount
		    
		    ' Get the style run range.
		    oRange = st.StyleRunRange(i)
		    
		    ' Are we in the range of this run?
		    if (iSelEnd >= oRange.StartPos) and (iSelEnd <= oRange.EndPos) then
		      
		      ' We found it.
		      si.styleRunEnd = i
		      si.styleRunEndIndex = Max(iSelEnd - oRange.StartPos - 1, 0)
		      bFoundEnd = true
		      exit
		      
		    end if
		    
		  next
		  
		  if bFoundEnd = false then
		    si.styleRunEnd = iStyleRunCount
		    si.styleRunEndIndex = min(iSelEnd, st.StyleRunRange(iStyleRunCount).EndPos)
		  end
		  
		  '--------------------------------------------
		  ' Paragraph start.
		  '--------------------------------------------
		  
		  ' Get the number of paragraphs.
		  dim iParagraphCount as integer = ariParStart.Ubound
		  
		  ' Assume the last paragraph.
		  si.paragraphStart = iParagraphCount
		  si.paragraphEnd = iParagraphCount
		  
		  ' Scan for the paragraph that contains the selection start.
		  for i as integer = 0 to iParagraphCount
		    
		    ' Have we found the beginning of the selection?
		    if iSelStart <= ariParStart(i) then
		      
		      ' We found it.
		      si.paragraphStart = i - 1
		      exit
		      
		    end if
		    
		  next
		  
		  '--------------------------------------------
		  ' Paragraph end.
		  '--------------------------------------------
		  if iParagraphCount > -1 then
		    ' Scan for the paragraph that contains the selection end.
		    for i as integer = si.paragraphStart to iParagraphCount
		      
		      ' Have we passed the end of the selection?
		      if iSelEnd <= ariParStart(i) then
		        
		        ' We found it.
		        si.paragraphEnd = i - 1
		        exit
		        
		      end if
		      
		    next
		  end
		  
		  '--------------------------------------------
		  
		  ' Return the selection metrics.
		  return si
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getRTF(extends oTextArea as TextArea) As string
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  
		  ' Create the writer.
		  dim oRTFWrite as new RTFWriter
		  
		  ' Build a list with the paragraph alignments.
		  dim ariParagraphs() as integer = parseParagraphs(oTextArea.Text)
		  Dim pa() as RTFAlignment = buildAlignmentArray(oTextArea, ariParagraphs)
		  
		  ' Get a reference.
		  dim oStyledText as StyledText = oTextArea.StyledText
		  
		  ' Create the paragraph.
		  oRTFWrite.newParagraph
		  
		  ' Scan the style runs.
		  for i as integer = 0 to oStyledText.StyleRunCount - 1
		    Dim pi as integer  //Seems to be useless in this case.
		    
		    ' Add the style run.
		    addText(oRTFWrite, oStyledText.StyleRun(i), oStyledText.StyleRun(i).Text, pa, pi)
		    
		  next
		  
		  ' Return the rtf string.
		  return oRTFWrite.getRTF
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getSelectedRTF(extends oTextArea as TextArea) As string
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  
		  ' Is there anything to do?
		  if oTextArea.SelLength = 0 then return ""
		  
		  Dim iRunStart as integer
		  Dim iRunEnd as integer
		  
		  ' Create the RTF writer.
		  dim oRTWWriter as new RTFWriter
		  
		  ' Start with a new paragraph.
		  oRTWWriter.newParagraph
		  
		  ' Get a reference.
		  dim oStyledText as StyledText = oTextArea.StyledText
		  
		  
		  ' Get the start and end positions.
		  dim iSelectStart as integer = oTextArea.SelStart + 1
		  dim iSelectEnd as integer = iSelectStart + oTextArea.SelLength
		  
		  ' Get the start indexes of all the paragraphs.
		  dim ariPargraphIndexes() as integer  = parseParagraphs(oTextArea.Text)
		  
		  ' Get the metrics on the selection.
		  dim oSelectionInfo as SelectionInfo = findSelectionInfo(oStyledText, iSelectStart, iSelectEnd, ariPargraphIndexes)
		  
		  ' Build a list with the paragraph alignments.
		  dim aroRTFAlignment() as RTFAlignment = buildAlignmentArray(oTextArea, ariPargraphIndexes)
		  
		  dim iParagraphIndex as integer = 0
		  
		  ' Set the alignment.
		  if aroRTFAlignment.Ubound > -1 then
		    oRTWWriter.setAlignment(aroRTFAlignment(ariPargraphIndexes(iParagraphIndex)))
		  end
		  
		  '----------------------------------------------------
		  ' First run.
		  '----------------------------------------------------
		  
		  ' Get some data.
		  dim iParStart as integer = oSelectionInfo.paragraphStart
		  dim oStyleRun as StyleRun = oStyledText.StyleRun(oSelectionInfo.styleRunStart)
		  
		  ' Default to the length of the run.
		  dim iLength as integer = oStyleRun.Text.len
		  
		  ' Are we within this style run?
		  if (oSelectionInfo.styleRunStartIndex + oTextArea.SelLength) <= iLength then
		    
		    ' Use the current selection length.
		    iLength = oTextArea.SelLength
		    
		  end if
		  
		  ' Add the style run.
		  addText(oRTWWriter, oStyleRun, Mid(oStyleRun.Text, oSelectionInfo.styleRunStartIndex, iLength), aroRTFAlignment, iParStart)
		  
		  '----------------------------------------------------
		  ' Full runs.
		  '----------------------------------------------------
		  
		  ' Is there something selected?
		  if (oSelectionInfo.styleRunEnd - oSelectionInfo.styleRunStart) > 1 then
		    
		    iRunStart = oSelectionInfo.styleRunStart + 1
		    iRunEnd = oSelectionInfo.styleRunEnd - 1
		    
		    ' Add all the style runs.
		    for i as integer = iRunStart to iRunEnd
		      
		      ' Add the style run.
		      oStyleRun = oStyledText.StyleRun(i)
		      addText(oRTWWriter, oStyleRun, oStyleRun.Text, aroRTFAlignment, iParStart)
		      
		    next
		    
		  end if
		  
		  '----------------------------------------------------
		  ' End run.
		  '----------------------------------------------------
		  
		  ' Is there an end run to consider?
		  if oSelectionInfo.styleRunStart <> oSelectionInfo.styleRunEnd then
		    
		    oStyleRun = oStyledText.StyleRun(oSelectionInfo.styleRunEnd)
		    
		    ' Add the style run.
		    addText(oRTWWriter, oStyleRun, Left(oStyleRun.Text, oSelectionInfo.styleRunEndIndex), aroRTFAlignment, iParStart)
		    
		  end if
		  
		  '----------------------------------------------------
		  
		  ' Return the rtf string.
		  return oRTWWriter.getRTF
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function parseParagraphs(text as string) As integer()
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim ariParagraph() as integer
		  
		  ' Normalize any line endings.
		  text = ReplaceLineEndings(text, EndOfLine.Macintosh)
		  
		  ' Get the length of the text.
		  dim iLength as integer = text.len
		  
		  //Always 1 paragraph
		  ariParagraph.Append 0
		  
		  ' Scan the text for paragraphs.
		  for i as integer = 1 to iLength
		    
		    ' Is this a paragraph marker?
		    if text.mid(i, 1) = EndOfLine.Macintosh then
		      
		      ' Save the start position of the paragraph.
		      ariParagraph.Append i - 1
		      
		    end if
		    
		  next
		  
		  ' Return the start of the paragraphs.
		  return ariParagraph
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function parseText(text as string) As string()
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  
		  Dim list() as string
		  Dim sa() as string
		  Dim ch as string
		  
		  
		  
		  ' Parse the text into paragraphs.
		  for i as integer = 1 to text.len
		    
		    ' Get a character.
		    ch = text.mid(i, 1)
		    
		    ' Is this a paragraph marker?
		    if ch = EndOfLine.Macintosh then
		      
		      ' Have we accumilated some text?
		      if Ubound(sa) > -1 then
		        
		        ' Add the text.
		        list.Append(join(sa, ""))
		        
		        ' Clear the string array.
		        Redim sa(-1)
		        
		      end if
		      
		      ' Add the end of line.
		      list.Append(ch)
		      
		    else
		      
		      ' Put the character into the string buffer.
		      sa.Append(ch)
		      
		    end if
		    
		  next
		  
		  ' Add any leftovers.
		  if Ubound(sa) > -1 then list.Append(join(sa, ""))
		  
		  ' Return the list of paragraphs.
		  return list
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setRTF(extends ta as TextArea, rtf as string, applyStyles as boolean = true, moveToBeginning as boolean = false)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim tarr as TextAreaRTFReader
		  
		  ' Create the parser.
		  tarr = new TextAreaRTFReader(ta, applyStyles)
		  
		  ' Parse the RTF.
		  tarr.parse(rtf)
		  
		  ' Should we move to the beginning of the text?
		  if moveToBeginning then
		    
		    ' Move to the beginning of the text.
		    ta.SelStart = 0
		    ta.SelLength = 0
		    
		  end if
		  
		End Sub
	#tag EndMethod


	#tag Structure, Name = SelectionInfo, Flags = &h21
		paragraphStart as integer
		  paragraphEnd as integer
		  styleRunStart as integer
		  styleRunStartIndex as integer
		  styleRunEnd as integer
		styleRunEndIndex as integer
	#tag EndStructure


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
End Module
#tag EndModule
