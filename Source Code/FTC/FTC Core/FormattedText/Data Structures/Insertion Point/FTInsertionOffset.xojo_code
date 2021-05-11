#tag Class
Protected Class FTInsertionOffset
	#tag Method, Flags = &h21
		Private Function addToInsertionOffset(amount as integer) As FTinsertionOffset
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim index as integer
		  Dim startIndex as integer
		  Dim computedOffset as integer
		  Dim p as FTParagraph
		  Dim paragraphCount as integer
		  Dim length as integer
		  Dim io As FTInsertionOffset
		  Dim bFound As Boolean
		  
		  ' Get the current paragraph.
		  p = doc.getParagraph(paragraph)
		  
		  ' Is there anything to do?
		  if p is nil then return nil
		  
		  ' Create the new offset.
		  io = new FTInsertionOffset(doc)
		  
		  ' Calculate how far we must go.
		  computedOffset = offset + amount
		  
		  ' Are we into a previous paragraph?
		  if amount < 0 then
		    
		    '-----------------------------------------
		    ' Search backwards.
		    '-----------------------------------------
		    
		    ' Are we in the same paragraph?
		    if computedOffset >= 0 then
		      
		      ' We are done.
		      io.set(paragraph, computedOffset)
		      
		    else
		      
		      ' Start with the previous paragraph.
		      startIndex = paragraph
		      
		      ' Scan for the paragraph.
		      for index = startIndex downto 0
		        
		        ' Get the paragraph.
		        p = doc.getParagraph(index)
		        
		        ' Get the length of the paragraph.
		        length = Max(p.getLength, 1)
		        
		        ' Is this the first paragraph?
		        if index = startIndex then
		          
		          ' Are we within this paragraph?
		          if (computedOffset >= 0) and (computedOffset <= offset) then
		            
		            ' We are done.
		            io.set(index, computedOffset)
		            
		            exit
		            
		          end if
		          
		          ' Subtract out the current offset.
		          computedOffset = computedOffset + Max(offset, 1)
		          
		        else
		          
		          ' Are we within this paragraph?
		          if (computedOffset >= 0) and (computedOffset <= length) then
		            
		            ' We are done.
		            io.set(index, length - computedOffset)
		            
		            exit
		            
		          end if
		          
		          ' Subtract out the length of the paragraph.
		          computedOffset = computedOffset + length
		          
		        end if
		        
		      next
		      
		    end if
		    
		    ' Are we into the next paragraph?
		  elseif computedOffset >= p.getLength + 1 then
		    
		    '-----------------------------------------
		    ' Search forwards.
		    '-----------------------------------------
		    
		    ' Get the number of paragraphs.
		    paragraphCount = doc.getParagraphCount - 1
		    
		    
		    ' Scan for the paragraph.
		    for index = paragraph to paragraphCount
		      
		      ' Get the next paragraph.
		      p = doc.getParagraph(index)
		      
		      ' Get the length of the paragraph.
		      length = p.getLength
		      
		      ' Are we within this paragraph?
		      if computedOffset <= length then
		        
		        ' We are done.
		        io.set(index, computedOffset - 1)
		        
		        ' We found it.
		        //Issue 4196: Remove GOTO Keywords from FTC
		        bFound = True
		        exit
		        
		      else
		        
		        ' Subtract out the length of the paragraph.
		        computedOffset = computedOffset - length - 1
		        
		      end if
		      
		    next
		    
		    //Issue 4196: Remove GOTO Keywords from FTC
		    If bFound = False Then
		      ' Set the insertion offset at the very end.
		      io.set(paragraphCount, doc.getParagraph(paragraphCount).getLength)
		    End
		    
		  else
		    
		    '-----------------------------------------
		    ' Use the current paragraph.
		    '-----------------------------------------
		    
		    ' Set the new offset within the current paragraph.
		    io.set(paragraph, computedOffset)
		    
		  end if
		  
		  ' Are we at the beginning of the paragraph?
		  if io.offset = 0 then io.bias = true
		  
		  ' Return the new offset.
		  return io
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub checkOffset()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim count as integer
		  
		  ' Get the paragraph count.
		  count = doc.getParagraphCount - 1
		  
		  ' Are there any paragraphs?
		  if count > -1 then
		    
		    ' Are we past the last paragraph?
		    if me.paragraph > count then
		      
		      ' Set it to the end of the document.
		      me.paragraph = doc.getParagraphCount
		      me.offset = doc.getParagraph(count).getLength
		      me.bias = false
		      
		      ' Are we in an empty paragraph?
		    elseif doc.getParagraph(me.paragraph).getLength = 0 then
		      
		      ' Set it to the beginning of the paragraph.
		      me.offset = 0
		      me.bias = true
		      
		      ' Are we past the end of the paragraph?
		    elseif me.offset > doc.getParagraph(me.paragraph).getLength + 1 then
		      
		      ' Use the end of the paragraph.
		      me.offset = doc.getParagraph(me.paragraph).getLength + 1
		      me.bias = false
		      
		    end if
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub clear()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Clear the data.
		  paragraph = -1
		  offset = -1
		  bias = false
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function clone() As FTInsertionOffset
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Create the clone.
		  return new FTInsertionOffset(doc, paragraph, offset, bias)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(doc as FTDocument)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the data.
		  me.doc = doc
		  me.paragraph = 0
		  me.offset = 0
		  me.bias = true
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(doc as FTDocument, paragraph as integer, offset as integer, bias as boolean = false)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the data.
		  me.doc = doc
		  me.paragraph = Max(paragraph, 0)
		  me.offset = Max(offset, 0)
		  me.bias = bias
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub copy(obj as FTInsertionOffset)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Copy over the settings.
		  paragraph = obj.paragraph
		  offset = obj.offset
		  bias = obj.bias
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Destructor()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Release the referernces.
		  doc = nil
		  parentControl = nil
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function dump() As string
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  return "(" + Str(paragraph) + ", " + Str(offset) + ", " + Str(bias) + ")"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function findDistance(obj as FTInsertionOffset) As integer
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim startParagraph as integer
		  Dim endParagragh as integer
		  Dim distance as integer
		  Dim firstParagraph as integer
		  Dim lastParagraph as integer
		  Dim firstOffset as integer
		  Dim lastOffset as integer
		  Dim negative as boolean
		  
		  '----------------------------------------------
		  ' Determine the ordering based on the paragraph.
		  '----------------------------------------------
		  
		  ' Are we in the same paragraph?
		  if paragraph = obj.paragraph then
		    
		    ' Use the original order.
		    firstParagraph = paragraph
		    firstOffset = offset
		    
		    lastParagraph = firstParagraph
		    lastOffset = obj.offset
		    
		    ' Do we need to reverse the order?
		  elseif paragraph < obj.paragraph then
		    
		    ' Reverse the order.
		    firstParagraph = paragraph
		    firstOffset = offset
		    
		    lastParagraph = obj.paragraph
		    lastOffset = obj.offset
		    
		    ' It will be a negative value.
		    negative = true
		    
		  else
		    
		    ' Use the original order.
		    firstParagraph = obj.paragraph
		    firstOffset = obj.offset
		    
		    lastParagraph = paragraph
		    lastOffset = offset
		    
		  end if
		  
		  '----------------------------------------------
		  ' Calculate the distance.
		  '----------------------------------------------
		  
		  ' Is this the same paragraph?
		  if firstParagraph = lastParagraph then
		    
		    ' Calculate the distance.
		    distance = firstOffset - lastOffset
		    
		  else
		    
		    ' Add in the first paragraph.
		    distance = abs(firstOffset - Max(doc.getParagraph(firstParagraph).getLength, 1))
		    
		    ' Set up the middle paragraphs.
		    startParagraph = firstParagraph + 1
		    endParagragh = lastParagraph - 1
		    
		    ' Add in the middle paragraphs.
		    for i = startParagraph to endParagragh
		      
		      ' Add in the paragraph length.
		      distance = distance + Max(doc.getParagraph(i).getLength, 1)
		      
		    next
		    
		    ' Add in the last paragraph.
		    distance = distance + min(doc.getParagraph(lastParagraph).getLength, lastOffset)
		    
		  end if
		  
		  ' Will this be a negative distance?
		  if negative then distance = -distance
		  
		  ' Return the distance.
		  return distance
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getParagraph() As FTParagraph
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the paragraph.
		  return doc.getParagraph(paragraph)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isBeginning() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Are we at the beginning?
		  return (paragraph = 0) and (offset = 0)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isBeginningOfParagraph() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Is there something in the paragraph?
		  if getParagraph.getLength > 0 then
		    
		    ' Are we at the beginning of the paragraph.
		    return (offset = 0)
		    
		  else
		    
		    ' Check the bias.
		    return bias
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isBetweenLines() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim ignore as boolean
		  
		  ' Only return the return the return value.
		  return isBetweenLines(ignore)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isBetweenLines(ByRef frontOfLine as boolean) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim line as integer
		  Dim lineOffset as integer
		  Dim p as FTParagraph
		  
		  ' Get the target paragraph.
		  p = getParagraph
		  
		  ' Find the offset into the target line.
		  p.findLine(0, offset, bias, line, lineOffset)
		  
		  ' Are we at the beginning of the line?
		  if lineOffset = 0 then
		    
		    ' We are at the beginning of the line.
		    frontOfLine = true
		    return true
		    
		  end if
		  
		  ' Are we at the end of the line?
		  if lineOffset = p.getLine(line).getLength then
		    
		    ' We are at the end of the line.
		    frontOfLine = false
		    return true
		    
		  end if
		  
		  ' We are in the middle of the line.
		  frontOfLine = false
		  return false
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isEnd() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Is this the last paragraph?
		  if paragraph = (doc.getParagraphCount - 1) then
		    
		    ' Are we at the end of the paragraph?
		    if offset >= doc.getParagraph(paragraph).getLength then
		      
		      ' We are at the end.
		      return true
		      
		    end if
		    
		  end if
		  
		  ' We are not at the end.
		  return false
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isEndOfParagraph() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim length as integer
		  
		  ' Get the length of the paragraph.
		  length = doc.getParagraph(paragraph).getLength
		  
		  ' Is there something in the paragraph?
		  if length > 0 then
		    
		    ' Are we at the end of the paragraph?
		    return (offset >= length)
		    
		  else
		    
		    ' Check the bias.
		    return (not bias)
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isSet() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Are we set?
		  return (paragraph > -1)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub moveToBeginning()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Move to the beginning.
		  paragraph = 0
		  offset = 0
		  bias = true
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub moveToBeginningOfParagraph()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Move to the beginning of the paragraph.
		  offset = 0
		  bias = true
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub moveToEnd()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim p as FTParagraph
		  
		  ' Get the last paragraph.
		  p = doc.getParagraph(doc.getParagraphCount - 1)
		  
		  ' Move to the end of the document.
		  paragraph = p.getAbsoluteIndex
		  offset = p.getLength
		  bias = false
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub moveToEndOfParagraph()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Move to the end of the paragraph.
		  offset = getParagraph.getLength
		  bias = false
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub moveToNextParagraph()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim target as integer
		  
		  ' Calculate the next paragraph.
		  target = paragraph + 1
		  
		  ' Are we in range?
		  if target <= (doc.getParagraphCount - 1) then
		    
		    ' Move to the beginning of the next paragraph.
		    paragraph = target
		    offset = 0
		    bias = true
		    
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub moveToPreviousParagraph()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim target as integer
		  
		  ' Calculate the previous paragraph.
		  target = paragraph - 1
		  
		  ' Are we in range?
		  if target > -1 then
		    
		    ' Move to the end of the previous paragraph.
		    paragraph = target
		    offset = getParagraph.getLength
		    bias = false
		    
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function operator_add(amount as integer) As FTInsertionOffset
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Add the amount to the offset.
		  return addToInsertionOffset(amount)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function operator_addRight(amount as integer) As FTinsertionOffset
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Add the amount to the offset.
		  return addToInsertionOffset(amount)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function operator_compare(obj as FTinsertionOffset) As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Is there anything to compare to?
		  if obj is nil then return -1
		  
		  '-------------------------------------------
		  ' Check the paragraph indexes.
		  '-------------------------------------------
		  
		  ' Are they in the cleared state?
		  if (paragraph < 0) or (obj.paragraph < 0) then return -1
		  
		  ' Greater than?
		  if paragraph > obj.paragraph then return 1
		  
		  ' Less than?
		  if paragraph < obj.paragraph then return -1
		  
		  '-------------------------------------------
		  ' Check the offset into the paragraph.
		  '-------------------------------------------
		  
		  ' Greater than?
		  if offset > obj.offset then return 1
		  
		  ' Less than?
		  if offset < obj.offset then return -1
		  
		  ' They are equal.
		  return 0
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function operator_subtract(obj as FTInsertionOffset) As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Find the distance between the points.
		  return findDistance(obj)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function operator_subtract(amount as integer) As FTInsertionOffset
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Add the amount to the offset.
		  return addToInsertionOffset(-amount)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function operator_subtractRight(obj as FTInsertionOffset) As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Find the distance between the points.
		  return findDistance(obj)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function operator_subtractRight(amount as integer) As FTInsertionOffset
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Add the amount to the offset.
		  return addToInsertionOffset(-amount)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub set(io as FTInsertionOffset = nil)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Was anything passed in?
		  if io is nil then
		    
		    ' Set the point.
		    me.paragraph = 0
		    me.offset = 0
		    me.bias = true
		    
		  else
		    
		    ' Set the point.
		    me.paragraph = io.paragraph
		    me.offset = io.offset
		    me.bias = io.bias
		    
		  end if
		  
		  ' Check the rage of the offset.
		  checkOffset
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub set(paragraph as integer, offset as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set the point.
		  me.paragraph = paragraph
		  me.offset = Max(offset, 0)
		  me.bias = (offset <= 0)
		  
		  ' Check the rage of the offset.
		  checkOffset
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Sub setRelativeEndBias(startOffset as FTInsertionOffset, endOffset as FTInsertionOffset)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  '--------------------------------------------
		  ' Start offset.
		  '--------------------------------------------
		  
		  ' Are we at the beginning?
		  if startOffset.offset = 0 then
		    
		    ' Set the bias to the beginning.
		    startOffset.bias = true
		    
		  else
		    
		    ' Are we at the end of the paragraph?
		    if startOffset.offset = endOffset.getParagraph.getLength then
		      
		      ' Set the bias to the end of the paragraph.
		      startOffset.bias = false
		      
		    end if
		    
		  end if
		  
		  '--------------------------------------------
		  ' End offset.
		  '--------------------------------------------
		  
		  ' Are we at the end of the paragraph?
		  if (endOffset.offset = endOffset.getParagraph.getLength) then
		    
		    ' Make it the end of the paragraph.
		    endOffset.bias = false
		    
		  else
		    
		    ' Are we at the beginning?
		    if endOffset.offset = 0 then
		      
		      ' Make it the beginning of the paragraph.
		      endOffset.bias = true
		      
		    end if
		    
		  end if
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		#tag Note
			True = the beginning of the line.
			False = the end of the line.
		#tag EndNote
		bias As boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private doc As FTDocument
	#tag EndProperty

	#tag Property, Flags = &h0
		offset As integer
	#tag EndProperty

	#tag Property, Flags = &h0
		paragraph As integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private parentControl As FormattedText
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="bias"
			Group="Behavior"
			InitialValue="0"
			Type="boolean"
		#tag EndViewProperty
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
			Name="offset"
			Group="Behavior"
			InitialValue="0"
			Type="integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="paragraph"
			Group="Behavior"
			InitialValue="0"
			Type="integer"
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
