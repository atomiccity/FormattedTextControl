#tag Module
Protected Module GUStyledText
	#tag Method, Flags = &h0
		Function clone(extends st as StyledText) As StyledText
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  ' Return the clone of the style.
		  return st.getSubStyle(0, st.text.len)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function clone(extends sr as StyleRun, startPosition as integer = - 1, length as integer = - 1) As StyleRun
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  Dim clone as StyleRun
		  
		  ' Create a style run clone.
		  clone = new StyleRun
		  
		  ' Copy the attributes.
		  clone.Bold = sr.Bold
		  clone.Font = sr.Font
		  clone.Italic = sr.Italic
		  clone.Size = sr.Size
		  clone.TextColor = sr.TextColor
		  clone.Underline = sr.Underline
		  
		  ' Was a start position specified?
		  if startPosition > -1 then
		    
		    ' Was the length specified?
		    if length > -1 then
		      
		      ' Get the specified sub text.
		      clone.Text = Mid(sr.Text, startPosition + 1, length)
		      
		    else
		      
		      ' Get the text starting with start position to the end of the text.
		      clone.Text = Mid(sr.Text, startPosition + 1)
		      
		    end if
		    
		  else
		    
		    ' Copy the entire text.
		    clone.Text = sr.Text
		    
		  end if
		  
		  ' Return the clone of the style run.
		  return clone
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function debugString(extends r as Range) As string
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  Dim s as string
		  
		  ' Print out the range attributes.
		  s = "  StartPos = " + Str(r.StartPos) + EndOfLine
		  s = s + "  EndPos = " + Str(r.EndPos) + EndOfLine
		  s = s + "  Length = " + Str(r.Length) + EndOfLine
		  
		  ' Return the debug string.
		  return s
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function debugString(extends st as StyledText) As string
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim s as string
		  Dim p as Paragraph
		  Dim sr as StyleRun
		  
		  '------------------------------------
		  ' Paragraphs.
		  '------------------------------------
		  
		  ' Print the header.
		  s = "----------------------------------" + EndOfLine
		  s = s + "Paragraphs" + EndOfLine
		  s = s + "----------------------------------" + EndOfLine
		  
		  ' Add a blank line.
		  s = s + EndOfLine
		  
		  ' Paragraph count.
		  s = s + "Paragraph count = " + Str(st.ParagraphCount) + EndOfLine
		  s = s + EndOfLine
		  
		  ' Make it zero based.
		  count = st.ParagraphCount - 1
		  
		  ' Print out all of the paragraphs.
		  for i = 0 to count
		    
		    ' Get a paragraph.
		    p = st.Paragraph(i)
		    
		    ' Print out the paragraph title.
		    s = s + "Paragraph: " + Str(i) + EndOfLine
		    
		    ' Print the alignment.
		    select case p.Alignment
		      
		    case Paragraph.AlignLeft
		      s = s + "  Alignment = Left" + EndOfLine
		      
		    case Paragraph.AlignCenter
		      s = s + "  Alignment = Center" + EndOfLine
		      
		    case Paragraph.AlignRight
		      s = s + "  Alignment = Right" + EndOfLine
		      
		    else
		      s = s + "  Alignment = unknown " + Str(p.Alignment) + EndOfLine
		      
		    end select
		    
		    ' Print the rest of the data.
		    s = s + "  StartPos = " + Str(p.StartPos) + EndOfLine
		    s = s + "  EndPos = " + Str(p.EndPos) + EndOfLine
		    s = s + "  Length = " + Str(p.Length) + EndOfLine
		    
		    ' Add a blank line.
		    s = s + EndOfLine
		    
		  next
		  
		  '------------------------------------
		  ' Style runs.
		  '------------------------------------
		  
		  ' Print the header.
		  s = s + "----------------------------------" + EndOfLine
		  s = s + "Styles" + EndOfLine
		  s = s + "----------------------------------" + EndOfLine
		  
		  ' Add a blank line.
		  s = s + EndOfLine
		  
		  ' Style run count.
		  s = s + "Style run count = " + Str(st.StyleRunCount) + EndOfLine
		  s = s + EndOfLine
		  
		  ' Make it zero based.
		  count = st.StyleRunCount - 1
		  
		  ' Print out all of the style runs.
		  for i = 0 to count
		    
		    ' Get a style run.
		    sr = st.StyleRun(i)
		    
		    ' Print out the style run title.
		    s = s + "Style run: " + Str(i) + EndOfLine
		    
		    ' Add the attributes.
		    s = s + sr.debugString
		    s = s + st.StyleRunRange(i).debugString
		    
		    ' Add a blank line.
		    s = s + EndOfLine
		    
		  next
		  
		  ' Return the debug string.
		  return s
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function debugString(extends sr as StyleRun) As string
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  Dim s as string
		  Dim srText as string
		  
		  ' Print out the style run attributes.
		  s = "  Font = " + sr.Font + EndOfLine
		  s = s + "  Size = " + Str(sr.Size) + EndOfLine
		  s = s + "  Bold = " + Str(sr.Bold) + EndOfLine
		  s = s + "  Italic = " + Str(sr.Italic) + EndOfLine
		  s = s + "  UnderLine = " + Str(sr.Underline) + EndOfLine
		  s = s + "  Color = (" + _
		  "r = " + Str(sr.TextColor.red) + _
		  ", g = " + Str(sr.TextColor.green) + _
		  ", b = " + Str(sr.TextColor.blue) + ")" + EndOfLine
		  
		  ' Make the line endings visible.
		  srText = ReplaceLineEndings(sr.Text, "<eol>")
		  
		  ' Print out the style run text.
		  s = s + "  Text: """ + srText + """" + EndOfLine
		  
		  ' Return the debug string.
		  return s
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub decode(extends sr as StyleRun, s as string)
		  
		  #if not DebugBuild
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  Dim i as integer
		  Dim colorString as string
		  Dim r as integer
		  Dim g as integer
		  Dim b as integer
		  
		  ' Format: font/size/bold/italic/underline/color*text...
		  
		  ' Set the attributes.
		  sr.Font = NthField(s, "/", 1)
		  sr.Size = Val(NthField(s, "/", 2))
		  sr.Bold = (NthField(s, "/", 3) = "true")
		  sr.Italic = (NthField(s, "/", 4) = "true")
		  sr.Underline = (NthField(s, "/", 5) = "true")
		  
		  ' Get the color string.
		  colorString = NthField(s, "/", 6)
		  
		  ' Assign the color.
		  r = Val(NthField(colorString, " ", 1))
		  g = Val(NthField(colorString, " ", 2))
		  b = Val(NthField(colorString, " ", 3))
		  
		  ' Set the color.
		  sr.TextColor = RGB(r, g, b)
		  
		  ' Look for the text separator.
		  i = InStr(s, "*")
		  
		  ' Does it exist?
		  if i > 0 then
		    
		    ' Copy the rest of the string.
		    sr.text = mid(s, i + 1)
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub delete(extends st as StyledText, startPos as integer, endPos as integer = - 1)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  Dim i as integer
		  Dim startRun as integer
		  Dim endRun as integer
		  Dim startOffset as integer
		  Dim endOffset as integer
		  Dim sr as StyleRun
		  
		  Dim s as string
		  
		  '----------------------------------------------
		  ' Adjust the parameters.
		  '----------------------------------------------
		  
		  ' Are we deleting to the end.
		  if endPos = -1 then
		    
		    ' Make it the end of the text.
		    endPos = st.text.Len
		    
		  end if
		  
		  ' Is there anything to delete?
		  if startPos > endPos then return
		  
		  '----------------------------------------------
		  ' Look for starting and ending runs.
		  '----------------------------------------------
		  
		  ' Find the run information.
		  startRun = st.findStyleRun(startPos, startOffset)
		  endRun = st.findStyleRun(endPos, endOffset)
		  
		  ' Did we find anything?
		  if startRun = -1 then return
		  
		  if endRun = -1 then
		    
		    s = st.debugString
		    
		    endRun = st.findStyleRun(st.text.len, endOffset)
		    
		  end if
		  
		  '----------------------------------------------
		  ' Trim up the start and end runs.
		  '----------------------------------------------
		  
		  ' Are we only dealing with one text run?
		  if startRun = endRun then
		    
		    ' Get the run.
		    sr = st.StyleRun(startRun)
		    
		    ' Delete the text.
		    st.updateStyleRun(startRun, _
		    left(sr.text, startOffset - 1) + right(sr.text, sr.text.len - endOffset))
		    
		  else
		    
		    ' Get the start run.
		    sr = st.StyleRun(startRun)
		    
		    ' Delete the text.
		    st.updateStyleRun(startRun, left(sr.text, startOffset - 1))
		    
		    ' Get the end run.
		    sr = st.StyleRun(endRun)
		    
		    ' Delete the text.
		    st.updateStyleRun(endRun, right(sr.text, sr.text.len - endOffset))
		    
		    '----------------------------------------------
		    ' Delete runs in the middle.
		    '----------------------------------------------
		    
		    ' Adjust the end points.
		    startRun = startRun + 1
		    endRun = endRun - 1
		    
		    ' Delete the middle runs.
		    for i = endRun downTo startRun
		      
		      ' Delete the intervening runs.
		      st.RemoveStyleRun(i)
		      
		    next
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function encode(extends sr as StyleRun) As string
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  Dim s as string
		  
		  ' Format: length/font/size/bold/italic/underline/color*text...
		  
		  ' Add the attributes.
		  s = sr.Font + "/"
		  s = s + Str(sr.Size) + "/"
		  s = s + Str(sr.Bold) + "/"
		  s = s + Str(sr.Italic) + "/"
		  s = s + Str(sr.Underline) + "/"
		  s = s + Str(sr.TextColor) + "*"
		  
		  ' Add the text.
		  s = s + sr.Text
		  
		  ' Prepend the length of the string.
		  s = Str(s.len) + "/" + s
		  
		  ' Return the encoded string.
		  return s
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function findStyleRun(extends st as StyledText, charPosition as integer, ByRef offset as integer) As integer
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim sr as StyleRun
		  Dim startSr as integer
		  Dim endSr as integer
		  
		  ' Make it zero based.
		  count = st.StyleRunCount - 1
		  
		  ' Search for the starting and ending runs.
		  for i = 0 to count
		    
		    ' Get a style run.
		    sr = st.StyleRun(i)
		    'r = st.StyleRunRange(i)
		    
		    endSr = startSr + sr.text.len
		    
		    ' Is the character position in the range of this run?
		    if (charPosition >= startSr) and (charPosition <= endSr) then
		      
		      ' Compute the offset into the run.
		      offset = charPosition - startSr
		      
		      ' We found the run.
		      return i
		      
		    end if
		    
		    startSr = startSr + sr.text.len
		    
		  next
		  
		  ' No offset.
		  offset = 0
		  
		  ' We didn't find it.
		  return -1
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getAlignment(extends st as StyledText, position as integer) As integer
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim p as Paragraph
		  
		  ' Make it zero based.
		  count = st.ParagraphCount - 1
		  
		  ' Walk through the paragraphs.
		  for i = 0 to count
		    
		    ' Get a paragraph.
		    p = st.Paragraph(i)
		    
		    ' Does this position fall withing the paragraph?
		    if (position >= p.StartPos) and (position <= p.EndPos) then
		      
		      ' We found the alignment.
		      return p.Alignment
		      
		    end if
		    
		  next
		  
		  ' Assume a left alignment.
		  return EditField.AlignLeft
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getLine(extends st as StyledText, startPosition as integer, width as integer, scaleFactor as double = 1.0) As StyledText
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  #pragma Unused scaleFactor
		  
		  Dim endPosition as integer
		  Dim srIndex as integer
		  Dim srCount as integer
		  Dim sr as StyleRun
		  Dim r as Range
		  Dim currentWidth as integer
		  Dim lastWidth as integer
		  Dim subSt as StyledText
		  Dim endPos as integer
		  
		  ' Make the end the same as the start.
		  endPosition = startPosition
		  
		  ' Make it zero based.
		  srCount = st.StyleRunCount - 1
		  
		  ' Get the starting style run index.
		  srIndex = st.getStyleRunIndex(startPosition)
		  
		  ' Get the first style run and range.
		  sr = st.StyleRun(srIndex)
		  r = st.StyleRunRange(srIndex)
		  
		  ' Get the string width of this style run.
		  currentWidth = getStyleRunWidth(sr, startPosition - r.StartPos)
		  
		  ' Is the segment too short?
		  if (currentWidth < width) and (srIndex <= srCount) then
		    
		    ' Go through each style run.
		    while srIndex <= srCount
		      
		      ' Is it long enough?
		      if currentWidth >= width then
		        
		        ' Find the last character position.
		        endPosition = r.StartPos + seekEndPosition(sr, 0, width - lastWidth)
		        
		        ' We are done.
		        exit
		        
		      else
		        
		        ' Look for an end of line character.
		        endPos = InStr(startPosition - r.StartPos + 1, sr.text, endOfLine.Macintosh)
		        
		        ' Did we find it?
		        if endPos > 0  then
		          
		          ' Use the position.
		          endPosition = r.StartPos + endPos - 1
		          
		          ' Did we encounter a lone EOL?
		          if endPosition < startPosition then
		            
		            ' Reset the end position.
		            endPosition = startPosition
		            
		          end if
		          
		          ' We are done.
		          exit
		          
		        end if
		        
		        ' Is this the last style run?
		        if srIndex = srCount then
		          
		          ' Use the last character position.
		          endPosition = r.endPos
		          
		          ' We are done.
		          exit
		          
		        end if
		        
		      end if
		      
		      ' Move to the next style run.
		      srIndex = srIndex + 1
		      
		      ' Get the style run and range.
		      sr = st.StyleRun(srIndex)
		      r = st.StyleRunRange(srIndex)
		      
		      ' Save the last current width.
		      lastWidth = currentWidth
		      
		      ' Append the length of the segment.
		      currentWidth = currentWidth + getStyleRunWidth(sr)
		      
		    wend
		    
		  else
		    
		    ' Find the last character position.
		    endPosition = seekEndPosition(sr, startPosition, width)
		    
		  end if
		  
		  ' Chop off partial words.
		  endPosition = seekPartialWord(endPosition, st.text)
		  
		  ' Get the sub-style that represents the line.
		  subSt = st.getSubStyle(startPosition, endPosition - startPosition + 1)
		  
		  ' Return the line.
		  return subSt
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getStyleLineHeight(extends st as StyledText) As integer
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim runHeight as integer
		  Dim maxHeight as integer
		  
		  ' Make it zero based.
		  count = st.StyleRunCount - 1
		  
		  ' Search through the style runs.
		  for i = 0 to count
		    
		    ' Get the height of the run.
		    runHeight = getStyleRunHeight(st.StyleRun(i))
		    
		    ' Is this the tallest run?
		    if runHeight > maxHeight then
		      
		      ' Save the new max height.
		      maxHeight = runHeight
		      
		    end if
		    
		  next
		  
		  ' Return the maximum height.
		  return maxHeight
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getStyleRunIndex(extends st as StyledText, charPosition as integer) As integer
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim r as Range
		  
		  ' Make it zero based.
		  count = st.StyleRunCount - 1
		  
		  ' Search through the style runs.
		  for i = 0 to count
		    
		    ' Get a style range.
		    r = st.StyleRunRange(i)
		    
		    ' Is the index within the style run?
		    if (charPosition >= r.StartPos) and (charPosition <= r.EndPos) then
		      
		      ' We found the style run.
		      return i
		      
		    end if
		    
		  next
		  
		  ' We didn't find the run.
		  return -1
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getSubStyle(extends st as StyledText, startPosition as integer, length as integer) As StyledText
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  Dim srIndex as integer
		  Dim srCount as integer
		  Dim subStyle as StyledText
		  Dim sr as StyleRun
		  Dim r as Range
		  Dim subSr as StyleRun
		  Dim endPosition as integer
		  
		  ' Allocate the sub style.
		  subStyle = new StyledText
		  
		  ' Look for the starting style.
		  srIndex = st.getStyleRunIndex(startPosition)
		  
		  ' Compute the end position.
		  endPosition = startPosition + length - 1
		  
		  ' Extract the number of styles.
		  srCount = st.StyleRunCount
		  
		  ' Do we need to get more style runs?
		  while srIndex < srCount
		    
		    ' Get the style run and range.
		    sr = st.StyleRun(srIndex)
		    r = st.StyleRunRange(srIndex)
		    
		    ' Are we still chewing up full styles?
		    if endPosition >= r.EndPos then
		      
		      ' Clone the style entire run.
		      subSr = sr.clone(startPosition - r.StartPos)
		      
		      ' Add the style run to the sub style text.
		      subStyle.AppendStyleRun(subSr)
		      
		    else
		      
		      ' Is this a style run past the first style run?
		      if r.StartPos <= startPosition then
		        
		        ' Clone the partial style run.
		        subSr = sr.clone(startPosition - r.StartPos, endPosition - startPosition + 1)
		        
		      else
		        
		        ' Clone the partial style run from the beginning of the run.
		        subSr = sr.clone(0, endPosition - r.StartPos + 1)
		        
		      end if
		      
		      ' Add the style run to the sub style text.
		      subStyle.AppendStyleRun(subSr)
		      
		      ' We are done.
		      exit
		      
		    end if
		    
		    ' Move on to the next style run.
		    srIndex = srIndex + 1
		    
		  wend
		  
		  ' Return the sub style.
		  return subStyle
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub replaceRun(extends st as StyledText, index as integer, sr as StyleRun)
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  ' Delete the existing style run.
		  st.RemoveStyleRun(index)
		  
		  ' Insert the new style run.
		  st.InsertStyleRun(sr, index)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function seekEndPosition(sr as StyleRun, startPosition as integer, width as integer) As integer
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  Dim high as integer
		  Dim low as integer
		  Dim center as integer
		  Dim segmentWidth as integer
		  Dim endPos as integer
		  
		  '-----------------------------------------------
		  ' Look for an end of line.
		  '-----------------------------------------------
		  
		  ' Look for an end of line character.
		  endPos = InStr(startPosition, sr.text, endofline.Macintosh)
		  
		  ' Did we find one?
		  if endPos > 0 then
		    
		    ' Is this segment smaller than the width we are looking for?
		    if getStyleRunWidth(sr, startPosition, endPos) <= width then
		      
		      ' We found it.
		      return endPos
		      
		    end if
		    
		  end if
		  
		  '-----------------------------------------------
		  ' Look for the last character.
		  '-----------------------------------------------
		  
		  ' Set the range of the search.
		  low = startPosition
		  high = sr.Text.len - 1
		  
		  ' Calculate the center.
		  center = ((high - low) / 2) + low
		  
		  ' Search for the character position.
		  while low < high
		    
		    ' Get the length of the segment.
		    segmentWidth = getStyleRunWidth(sr, startPosition, center)
		    
		    ' Is the position above or below the center line.
		    if segmentWidth > width then
		      
		      ' Move to the bottom half.
		      high = center - 1
		      
		    else
		      
		      ' Did we find an exact match?
		      if segmentWidth = width then exit
		      
		      ' Move to the upper half.
		      low = center + 1
		      
		    end if
		    
		    ' Compute the new center line.
		    center = ((high - low) / 2) + low
		    
		  wend
		  
		  ' Return the character position.
		  return center
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function seekPartialWord(endPosition as integer, s as string) As integer
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  Dim i as integer
		  Dim start as integer
		  Dim ch as string
		  
		  ' Make it one based.
		  start = endPosition + 1
		  
		  ' Get the character after the last character.
		  ch = mid(s, start, 1)
		  
		  ' Is the character white space?
		  if not((ch = "") or isSpace(ch)) then
		    
		    ' Look for a space character.
		    for i = start downto 1
		      
		      ' Is the character a space?
		      if isSpace(mid(s, i, 1)) then
		        
		        ' Return the position.
		        return i - 1
		        
		      end if
		      
		    next
		    
		  end if
		  
		  ' Return the original position.
		  return endPosition
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub updateStyleRun(extends st as StyledText, index as integer, s as string)
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  Dim sr as StyleRun
		  
		  ' Will the run be empty?
		  if s = "" then
		    
		    ' Just remove it.
		    st.RemoveStyleRun(index)
		    
		  else
		    
		    ' Get the style run.
		    sr = st.StyleRun(index)
		    
		    ' Set the text.
		    sr.Text = s
		    
		  end if
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = Copyright Notice
		
		Copyright 2002-2015 BKeeney Software Inc. - All Rights Reserved.
		
		This software is freeware and may be used freely without
		royalties or fees.
	#tag EndNote

	#tag Note, Name = Usage
		
		Best viewed in font "Courier New" with font size of 12.
		
		This module contains general utility functions and subroutines.
		
		clone
		-----
		
		  Description:
		  
		    This function makes a clone of the specified style run.
		
		  Parameters:
		
		    extends sr as StyleRun:
		      The style run object.
		    
		    startPosition as integer = -1:
		      The position to start making the copy.
		    
		    length as integer = -1:
		      The length of the copy.
		
		  Return:
		  
		    StyleRun:
		      The clone of the style run.
		
		
		clone
		-----
		
		  Description:
		  
		    This function returns a clone of a styled text object.
		
		  Parameters:
		
		    extends st as StyledText:
		      The styled text object.
		
		  Return:
		  
		    StyledText:
		      The clone of the styled text.
		
		
		debugString
		-----------
		
		  Description:
		  
		    This function returns a string containing the contents
		    of the styled text in human readable form.
		
		  Parameters:
		
		    extends st as StyledText:
		      The styled text object.
		
		  Return:
		  
		    string:
		      The debug string.
		
		
		debugString
		-----------
		
		  Description:
		  
		    This function returns a string containing the contents
		    of the style run in human readable form.
		
		  Parameters:
		
		    extends sr as StyleRun:
		      The style run object.
		
		  Return:
		  
		    string:
		      The debug string.
		
		
		debugString
		-----------
		
		  Description:
		  
		    This function returns a string containing the contents
		    of the range in human readable form.
		
		  Parameters:
		
		    extends r as Range:
		      The range object.
		
		  Return:
		  
		    string:
		      The debug string.
		
		
		decode
		------
		
		  Description:
		  
		    This subroutine decodes the string and fills the style
		    run with the contents.
		    
		  Parameters:
		
		    extends sr as StyleRun:
		      The style run object.
		
		    s as string:
		      The encoded string. Use the encode method within this
		      module to encode the style run.
		      
		  Return:
		  
		    None.
		    
		
		encode
		------
		
		  Description:
		  
		    This function encodes the style run into a string.
		    
		  Parameters:
		
		    extends sr as StyleRun:
		      The style run object.
		      
		  Return:
		  
		    String:
		      The style run encoded into a string.
		      Format: font/size/bold/italic/underline/color*text...
		
		
		getAlignment
		------------
		
		  Description:
		  
		    This function returns the alignment of the paragraph at
		    the specified character position.
		
		  Parameters:
		
		    extends st as StyledText:
		      The styled text object.
		      
		    position as integer:
		      The character position in the style. One based.
		      
		  Return:
		  
		    integer:
		      The alignment of the paragraph.
		
		
		getLine
		-------
		
		  Description:
		  
		    This function returns a sub-style that represents a line
		    of text that will fit in the specified width.
		
		  Parameters:
		
		    extends st as StyledText
		      The styled text object.
		
		    startPosition as integer:
		      The starting character position.
		      
		    width as integer:
		      The width of the line in pixels.
		    
		    scaleFactor as double = 1.0:
		      The printing scale factor.
		
		  Return:
		  
		    StyledText:
		      The styled that represents a line that will fit in the
		      width.
		
		
		getStyleLineHeight
		------------------
		
		  Description:
		  
		    This function returns the maximum line height of a
		    style.
		
		  Parameters:
		
		    extends st as StyledText
		      The styled text object.
		
		  Return:
		  
		    integer:
		      The height of the line in pixels.
		
		
		getStyleRunIndex
		----------------
		
		  Description:
		  
		    This function returns style run index that contains the
		    character position.
		
		  Parameters:
		
		    extends st as StyledText
		      The styled text object.
		
		    charPosition as integer:
		      The character position within the style. Zero based.
		    
		  Return:
		  
		    integer:
		      The style run index that contains the specified
		      character position. Returns -1 if not within range.
		
		
		getSubStyle
		-----------
		
		  Description:
		  
		    This function returns a sub style within this style
		    starting at the specified position for the specified
		    length.
		
		  Parameters:
		
		    extends st as StyledText
		      The styled text object.
		
		    startPosition as integer:
		      The starting position within the style to begin
		      extracting the sub style.
		    
		    length as integer:
		      The number of characters to extract.
		
		  Return:
		  
		    StyledRext:
		      A sub style.
	#tag EndNote


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
