#tag Class
Protected Class FTXojoScriptField
Inherits FormattedText
	#tag Event
		Sub Close()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Kill the timer.
		  indentTimer.Mode = Timer.ModeOff
		  indentTimer = nil
		  
		  ' Release anything in the style run cache.
		  Redim cache(-1)
		  
		  ' Call the event.
		  Close
		  
		End Sub
	#tag EndEvent

	#tag Event
		Function DefaultParagraphStyle() As FTParagraphStyle
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim ps as FTParagraphStyle
		  
		  ' Create the style.
		  ps = new FTParagraphStyle(self)
		  
		  ' Set the default characteristics.
		  ps.setFontName(DefaultFont)
		  ps.setFontSize(DefaultFontSize)
		  
		  ' Return the style.
		  return ps
		  
		End Function
	#tag EndEvent

	#tag Event
		Sub DrawLine(proxy as FTParagraphProxy, line as FTLine, g as graphics, drawBeforeSpace as boolean, firstIndent as integer, page as integer, x as double, y as double, leftPoint as integer, rightPoint as integer, alignment as FTParagraph.Alignment_Type, printing as boolean, printScale as double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim lineType As FTLine.Line_Type
		  Dim ln as LineNumber
		  
		  ' Are we showing the line numbers?
		  If ShowLineNumbers Then
		    
		    ' Save the line number.
		    ln.number = proxy.getParent.getAbsoluteIndex + 1
		    
		    ' Get the type of the line.
		    lineType = line.getLineType
		    
		    ' Is this the starting line?
		    if (lineType = FTLine.Line_Type.First) or _
		      (lineType = FTLine.Line_Type.Both_First_And_Last) then
		      
		      ' Mark it as such.
		      ln.firstLine = true
		      
		    end if
		    
		    ' Get the position to draw the line number.
		    If Printing Then
		      ln.y = y + line.getAscent*printScale
		    Else
		      If IsHiDPT Then
		        ln.y = y + line.getAscent*2
		      Else
		        ln.y = y + line.getAscent
		      End
		    End
		    
		    ' Save the line number for drawing.
		    lineNumberCache.Append(ln)
		    
		  end if
		  
		  ' Call the event.
		  DrawLine(proxy, line, g, drawBeforeSpace, firstIndent, page, _
		  x, y, leftPoint, rightPoint, alignment, printing, printScale)
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim s as string
		  
		  ' Set it up to auto hide the horizontal scrollbar.
		  HScrollbarAutoHide = true
		  
		  ' Populate the look up dictionary.
		  createErrorCodes
		  
		  ' Don't accept tabs.
		  if not AutoComplete then
		    #if false
		      AcceptTabs = false
		    #endif
		  end if
		  
		  '--------------------------------------------
		  ' Create the syntax color search pattern.
		  '--------------------------------------------
		  
		  ' Comments.
		  s = "rem(\s.*|$)|('|//)(.*$)" + "|"
		  
		  ' Quoted strings.
		  s = s + """.*?(""|$)" + "|"
		  
		  ' Numerics.
		  s = s + "((\.\d+)|(\d+(\.\d*)?))" + "|"
		  
		  ' Keywords.
		  s = s + "[#|\w]+" + "|"
		  
		  ' Leftovers.
		  s = s + ".+?"
		  
		  ' Create the regular expression for color coding lines.
		  regColor = new RegEx
		  regColor.SearchPattern = s
		  
		  '--------------------------------------------
		  ' Create the indent search pattern.
		  '--------------------------------------------
		  
		  ' Keywords.
		  s = "^\s*([#|\w]+)"
		  
		  ' Create the regular expression for getting the first keyword.
		  regIndent = new RegEx
		  regIndent.SearchPattern = s
		  
		  ' Single line if-then construct.
		  s = "^\s*if[\(\s].*[\)\s]then\s+\S+"
		  
		  ' Create the regular expression for getting the if-then construct.
		  regIndentIfThen = new RegEx
		  regIndentIfThen.SearchPattern = s
		  
		  '--------------------------------------------
		  
		  ' Turn off updates.
		  call setInhibitUpdates(true)
		  
		  ' Create the background indenter.
		  indentTimer = new FTXojoScriptIndentTimer(self)
		  
		  ' Turn off the unused features.
		  AllowBackgroundUpdates = false
		  AllowPictures = false
		  ShowMarginGuides = false
		  ShowPilcrows = false
		  
		  ' Create a scratch picture.
		  scratchPicture = new Picture(1, 1, BIT_DEPTH)
		  scratchGraphic = scratchPicture.Graphics
		  
		  ' Set the font characteristics.
		  scratchGraphic.TextFont = DefaultFont
		  scratchGraphic.TextSize = DefaultFontSize
		  
		  ' Set the wrapping mode.
		  setSoftwrap(Softwrap, true)
		  
		  ' Create the keyword lookup.
		  buildKeywordDictionary
		  
		  ' Call the user event.
		  Open
		  
		  ' Set up line numbers.
		  showLineNumbers(ShowLineNumbers, true)
		  
		  ' Allow updates.
		  call setInhibitUpdates(false)
		  
		  ' Find the longest line and adjust the page size.
		  findWidth
		  
		  ' Update the display.
		  updateFull
		  
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub PostPageDraw(g as graphics, p as FTPage, printing as boolean, printScale as double)
		  
		  #Pragma DisableBackgroundTasks
		  
		  #If Not DebugBuild
		    
		    #Pragma BoundsChecking FTC_BOUNDSCHECKING
		    #Pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #Pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #EndIf
		  
		  Dim i As Integer
		  Dim count As Integer
		  Dim offset As Integer
		  Dim x As Integer
		  Dim lineNumber As String
		  Dim ln As LineNumber
		  
		  Const BORDER_OFFSET = 5
		  
		  ' Are we showing the line numbers?
		  If ShowLineNumbers Then
		    
		    ' calculate placement of line numbers from the FTPage
		    ' allows for margins - takes into account the printable page size when printing
		    ' can be extended in the PostPageDraw event of a subclass to add title, date,
		    ' page number (p.getAbsolutePage + 1 when mode = PAGE_MODE) etc in top or bottom margin
		    
		    Dim d As FTDocument = p.doc
		    
		    Dim dLeft As Double = d.getLeftMarginWidth - lineNumberWidth - BORDER_OFFSET
		    Dim dLeftX As Double
		    
		    If IsHiDPT Then
		      
		      dLeftX = dLeft + (lineNumberWidth * 2) - (BORDER_OFFSET * 2)
		      
		    Else
		      
		      dLeftX = dLeft + lineNumberWidth - BORDER_OFFSET
		      
		    End If
		    
		    Dim dTop As Double = d.getTopMarginWidth - BORDER_OFFSET
		    
		    ' compute exact height of line numbers region
		    Dim dHeight As Double = lineNumberCache(lineNumberCache.UBound).y - lineNumberCache(0).y + scratchGraphic.TextHeight + 2 *  BORDER_OFFSET
		    
		    ' Draw the background color.
		    g.ForeColor = LineNumberBackground
		    g.FillRect(dLeft, dTop, dLeftX, dHeight)
		    
		    ' Draw the separator.
		    g.ForeColor = LineSeparator
		    
		    
		    g.DrawLine(dLeftX, dTop, dLeftX, dTop + dHeight - 1)
		    
		    ' Set the font drawing environment.
		    g.ForeColor = LineNumberColor
		    g.TextFont = DefaultFont
		    
		    Dim iTextSize As Integer
		    If IsHiDPT Then
		      iTextSize = DefaultFontSize * 2
		    Else
		      g.TextSize =  DefaultFontSize
		    End
		    g.bold = False
		    g.italic = False
		    
		    ' Compute the far right side of the line numbers.
		    If IsHiDPT Then
		      
		      offset = (lineNumberWidth * 2) - (BORDER_OFFSET * 4)
		      
		    Else
		      
		      offset = lineNumberWidth - BORDER_OFFSET * 2
		      
		    End If
		    
		    ' Get the number of line numbers.
		    count = Ubound(lineNumberCache)
		    
		    ' Draw all the line numbers.
		    For i = 0 To count
		      
		      ' Get a line number.
		      ln = lineNumberCache(i)
		      
		      ' Do we draw a line number or continuation symbol?
		      If ln.firstLine Then
		        
		        ' Use the actual line number.
		        lineNumber = Str(ln.number)
		        
		      Else
		        
		        ' Just a wrapped line.
		        lineNumber = LINE_NUMBER_CONTINUATION
		        
		      End If
		      
		      ' Get the position to draw the line number.
		      x = offset - g.StringWidth(lineNumber)
		      
		      ' Draw the line number.
		      g.DrawString(lineNumber, dLeft + x, ln.y)
		      
		    Next
		    
		  End If
		  
		  ' Clear the line number cache.
		  Redim lineNumberCache(-1)
		  
		  ' Call the event.
		  PostPageDraw(g, p, printing, printScale)
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub TextChanged()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Find the longest line and adjust the page size.
		  findWidth
		  
		  ' Call the event.
		  TextChanged
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub buildKeywordDictionary()
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim sa() as string
		  Dim indentValue as integer
		  Dim word as string
		  Dim s as string
		  
		  ' Create the dictionary.
		  keywordLookup = new Dictionary
		  
		  ' Normalize the line endings.
		  s = ReplaceLineEndings(KEYWORD_LIST, EndOfLine.Macintosh)
		  
		  ' Break into words.
		  sa = Split(s, EndOfLine.Macintosh)
		  
		  ' Get the number of words.
		  count = Ubound(sa)
		  
		  ' Add all the words.
		  for i = 0 to count
		    
		    ' Parse the entry.
		    word = Trim(NthField(sa(i), " ", 1))
		    indentValue = Val(NthField(sa(i), " ", 2))
		    
		    ' Save the maximum length of the keyword.
		    if word.len > maxKeywordLength then maxKeywordLength = word.len
		    
		    ' Add the keyword.
		    keywordLookup.Value(word) = indentValue
		    
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function callKeyDown(key as string) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim result as boolean
		  Dim line as integer
		  Dim tag as FTXojoScriptTag
		  Dim previousTag as FTXojoScriptTag
		  Dim level as integer
		  Dim prevousLevel as integer
		  Dim p as FTParagraph
		  
		  ' Get the current line.
		  line = doc.getInsertionOffset.paragraph
		  
		  '-------------------------------------------
		  ' Keydown event.
		  '-------------------------------------------
		  
		  ' Call the keydown event.
		  result = super.callKeyDown(key)
		  
		  '-------------------------------------------
		  ' Pre-indent.
		  '-------------------------------------------
		  
		  ' Is this a non-return key?
		  if key <> EndOfLine.Macintosh then
		    
		    ' Is this a valid line?
		    if line < doc.getParagraphCount then
		      
		      ' Get the paragraph.
		      p = doc.getParagraph(line)
		      
		      ' Get the tag.
		      tag = getTag(line)
		      
		      ' Find the current type of the line.
		      tag.type = findIndentType(p.getText)
		      
		      ' Calculate the new level.
		      level = Max(currentLineLevel(tag), 0)
		      
		      ' Is there a previous line to look at?
		      if line > 0 then
		        
		        ' Get the previous line level.
		        prevousLevel = getTag(line - 1).level
		        
		      end if
		      
		      ' Are we within range of the previous line?
		      if abs(prevousLevel - level) <= 1 then
		        
		        ' Save the indent level.
		        tag.level = level
		        
		        ' Did the left margin change?
		        if p.getLeftMargin <> (level * Indent) then
		          
		          ' Set the left margin.
		          p.setLeftMargin(level * Indent)
		          
		          ' Update the indentation.
		          indentAllLines
		          
		        end if
		        
		      end if
		      
		    end if
		    
		  end if
		  
		  '-------------------------------------------
		  ' Post-indent.
		  '-------------------------------------------
		  
		  ' Is this a new line?
		  if key = EndOfLine.Macintosh then
		    
		    ' Get the line.
		    line = doc.getInsertionOffset.paragraph
		    
		    ' Get the paragraph.
		    p = doc.getParagraph(line)
		    
		    ' Clear any background color.
		    p.setBackgroundColor
		    
		    ' Get the tag.
		    tag = getTag(line)
		    
		    ' Get the tag of the previous line.
		    previousTag = getTag(line - 1)
		    
		    ' Recalculate the line type for the previous tag.
		    previousTag.type = findIndentType(doc.getParagraph(line - 1).getText)
		    
		    ' Save the indent level.
		    tag.level = nextLineLevel(previousTag)
		    
		    ' Did the left margin change?
		    if p.getLeftMargin <> (tag.level * Indent) then
		      
		      ' Set the left margin.
		      p.setLeftMargin(tag.level * Indent)
		      
		      ' Update the indentation.
		      indentAllLines
		      
		    end if
		    
		  end if
		  
		  ' Forward the result.
		  return result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeFontAll(font as string)
		  
		  #if not DebugBuild
		    
		    #pragma NilObjectChecking COMPASS_NILCHECKING
		    #pragma StackOverflowChecking COMPASS_STACKCHECKING
		    #pragma BoundsChecking COMPASS_BOUNDSCHECKING
		    
		  #endif
		  
		  Dim doc as FTDocument
		  Dim text as string
		  Dim io as FTInsertionOffset
		  Dim selectStart as FTInsertionOffset
		  Dim selectEnd as FTInsertionOffset
		  
		  ' Get the document.
		  doc = getDoc
		  
		  ' Is something selected?
		  if doc.isSelected then
		    
		    ' Get the selection range.
		    doc.getSelectionRange(selectStart, selectEnd)
		    
		  else
		    
		    ' Get the current insertion point.
		    io = doc.getInsertionOffset
		    
		  end if
		  
		  ' Reset the font size.
		  DefaultFont = Trim(font)
		  doc.setDefaultParagraphStyle(callDefaultParagraphStyle)
		  
		  setupScratchGraphic
		  
		  ' Save the text.
		  text = doc.getText
		  
		  ' Delete everything.
		  doc.deleteAll
		  
		  ' Reinsert the text
		  doc.setText(text)
		  
		  ' Compose the paragraphs.
		  composeDirtyParagraphs
		  
		  ' Is this selection case?
		  if io is nil then
		    
		    ' Reselect the text.
		    doc.selectSegment(selectStart, selectEnd)
		    
		  else
		    
		    ' Reset the offset.
		    setInsertionPoint(io, true)
		    
		  end if
		  
		  ' Update the display.
		  update(true, true)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeFontSizeAll(size as integer)
		  
		  #if not DebugBuild
		    
		    #pragma NilObjectChecking COMPASS_NILCHECKING
		    #pragma StackOverflowChecking COMPASS_STACKCHECKING
		    #pragma BoundsChecking COMPASS_BOUNDSCHECKING
		    
		  #endif
		  
		  Dim doc as FTDocument
		  Dim text as string
		  Dim io as FTInsertionOffset
		  Dim selectStart as FTInsertionOffset
		  Dim selectEnd as FTInsertionOffset
		  
		  ' Get the document.
		  doc = getDoc
		  
		  ' Is something selected?
		  if doc.isSelected then
		    
		    ' Get the selection range.
		    doc.getSelectionRange(selectStart, selectEnd)
		    
		  else
		    
		    ' Get the current insertion point.
		    io = doc.getInsertionOffset
		    
		  end if
		  
		  ' Reset the font size.
		  DefaultFontSize = size
		  doc.setDefaultParagraphStyle(callDefaultParagraphStyle)
		  
		  setupScratchGraphic
		  
		  ' Save the text.
		  text = doc.getText
		  
		  ' Delete everything.
		  doc.deleteAll
		  
		  ' Reinsert the text
		  doc.setText(text)
		  
		  ' Compose the paragraphs.
		  composeDirtyParagraphs
		  
		  ' Is this selection case?
		  if io is nil then
		    
		    ' Reselect the text.
		    doc.selectSegment(selectStart, selectEnd)
		    
		  else
		    
		    ' Reset the offset.
		    setInsertionPoint(io, true)
		    
		  end if
		  
		  ' Update the display.
		  update(true, true)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub colorCodeLine(index as integer)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim p as FTParagraph
		  Dim text as string
		  Dim match as RegExMatch
		  Dim stack() as string
		  Dim isFloat as boolean
		  
		  ' Get the paragraph.
		  p = doc.getParagraph(index)
		  
		  ' Is there anything to do?
		  if p is nil then return
		  
		  ' Set the text to be searched.
		  match = regColor.Search(p.getText)
		  
		  ' Get the number of style runs.
		  count = p.getItemCount - 1
		  
		  ' Cache all the style runs.
		  for i = 0 to count
		    
		    ' Cache the style run.
		    'cache.append(FTStyleRun(p.getItem(i)))
		    //Code contributed by Aaron Andrew Hunt
		    dim FTO as FTObject = p.getItem(i)
		    if FTO IsA FTStyleRun then
		      cache.append(FTStyleRun(p.getItem(i)))
		    end
		    //End change
		    
		  next
		  
		  ' Clear the style runs.
		  p.clear
		  p.addObjectFast(createStyleRun("", Source))
		  
		  ' Color the line.
		  while not (match is nil)
		    
		    ' Get the parsed expression.
		    text = match.SubExpressionString(0)
		    
		    ' Is this a keyword?
		    if keywordLookup.HasKey(text) then
		      
		      ' Post any plain text.
		      emptyStack(stack, p)
		      
		      ' Change to the keyword color.
		      p.addObjectFast(createStyleRun(text, Keywords))
		      
		      ' Is this a quoted string?
		    elseif Left(text, 1) = """" then
		      
		      ' Post any plain text.
		      emptyStack(stack, p)
		      
		      ' Use the strings color.
		      p.addObjectFast(createStyleRun(text, Strings))
		      
		      ' Is this a comment?
		    elseif isComment(text) then
		      
		      ' Post any plain text.
		      emptyStack(stack, p)
		      
		      ' Use the comment color.
		      p.addObjectFast(createStyleRun(text, Comments))
		      
		      ' Is this a quoted string?
		    elseif isNumeric(text, isFloat) then
		      
		      ' Post any plain text.
		      emptyStack(stack, p)
		      
		      ' Is this a floating point number?
		      if isFloat then
		        
		        ' Use the floating point color.
		        p.addObjectFast(createStyleRun(text, Floating))
		        
		      else
		        
		        ' Use the integer color.
		        p.addObjectFast(createStyleRun(text, Integers))
		        
		      end if
		      
		    else
		      
		      ' Add the text to the stack.
		      stack.append(text)
		      
		    end if
		    
		    ' Look for the next one.
		    match = regColor.Search
		    
		  wend
		  
		  ' Post any plain text.
		  emptyStack(stack, p)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub composeDirtyParagraphs()
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim keys() as Variant
		  Dim tag as FTXojoScriptTag
		  Dim p as FTParagraph
		  Dim startIndent as integer
		  Dim index as integer
		  
		  ' Get the keys.
		  keys = doc.getDirtyIndexes
		  
		  ' Get the number of paragraphs to color.
		  count = Ubound(keys)
		  
		  ' Is there anything to do?
		  if count = -1 then return
		  
		  ' Start at the top.
		  startIndent = 2147483647
		  
		  ' Color all the dirty lines.
		  for i = 0 to count
		    
		    ' Get a paragraph index.
		    index = keys(i)
		    
		    ' Save the high water mark.
		    startIndent = Min(index, startIndent)
		    
		    ' Color the line.
		    colorCodeLine(index)
		    
		    ' Get the paragraph.
		    p = doc.getParagraph(index)
		    
		    ' Is this a new paragraph?
		    if p.tag is nil then
		      
		      ' Create a new tag.
		      tag = new FTXojoScriptTag
		      
		      ' Save the tag.
		      p.tag = tag
		      
		    else
		      
		      ' Extract the tag.
		      tag = p.tag
		      
		    end if
		    
		    ' Get the identifier for the first token on the line.
		    tag.type = findIndentType(p.getText)
		    
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub createErrorCodes()
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim lines() as string
		  Dim index as integer
		  
		  ' Create the look up dictionary.
		  errorCodeLookup = new Dictionary
		  
		  ' Break into lines.
		  lines = split(ReplaceLineEndings(ERROR_CODES, EndOfLine.Macintosh), EndOfLine.Macintosh)
		  
		  ' Add all the error codes.
		  while i < Ubound(lines)
		    
		    ' Convert to integer.
		    index = Val(lines(i))
		    
		    ' Add the error code and message.
		    errorCodeLookup.Value(index) = lines(i + 1)
		    
		    ' Move to the next entry.
		    i = i + 2
		    
		  wend
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function createStyleRun(text as string, c as Color) As FTStyleRun
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim sr as FTStyleRun
		  
		  ' Is there anything in the cache?
		  if Ubound(cache) > -1 then
		    
		    ' Get the item from the cache.
		    sr = cache.pop
		    
		    ' Set the text in the style run.
		    sr.setText(text)
		    
		  else
		    
		    ' Create the style run.
		    sr = new FTStyleRun(self, text)
		    
		    ' Set the characteristics.
		    sr.font = DefaultFont
		    sr.fontSize = DefaultFontSize
		    
		  end if
		  
		  ' Set the color.
		  sr.textColor = c
		  
		  ' Return it.
		  return sr
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function currentLineLevel(tag as FTXojoScriptTag) As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set the left margin based on the type.
		  select case tag.type
		    
		  case 3
		    
		    ' End of block.
		    return tag.level - 1
		    
		  case 2
		    
		    ' else/elseif block.
		    return tag.level - 1
		    
		  end select
		  
		  ' Return the current level.
		  return tag.level
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub emptyStack(stack() as string, p as FTParagraph)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Is there anything in the plain text stack?
		  if Ubound(stack) > -1 then
		    
		    ' Use the default color.
		    p.addObjectFast(createStyleRun(join(stack, ""), Source))
		    
		    ' Clear the stack.
		    Redim stack(-1)
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function findIndentStart(startIndent as integer) As integer
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  
		  ' Scan for a zero level line.
		  for i = (startIndent - 1) downto 0
		    
		    ' Did we find a level all the way to the left?
		    if getTag(i).level = 0 then return i
		    
		  next
		  
		  ' Use the beginning.
		  return 0
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function findIndentType(s as string) As integer
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim match as RegExMatch
		  Dim word as string
		  
		  ' Search for the first keyword.
		  match = regIndent.Search(s)
		  
		  ' Did we find a keyword?
		  if not (match is nil) then
		    
		    ' Get the keyword.
		    word = match.SubExpressionString(1)
		    
		    ' Is this a keyword?
		    if keywordLookup.HasKey(word) then
		      
		      ' Is this an if statement?
		      if word = "if" then
		        
		        ' Look for a single line if statement construct.
		        match = regIndentIfThen.Search(s)
		        if not (match is nil) then return 0
		        
		      end if
		      
		      ' Return the indention type.
		      return keywordLookup.Value(word)
		      
		    end if
		    
		  end if
		  
		  ' Nothing to do.
		  return 0
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub findWidth()
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim currentWidth as double
		  Dim paragraphWidth as double
		  Dim p as FTParagraph
		  
		  ' If we are soft wrapping, then there is nothing to do.
		  if Softwrap then return
		  
		  ' Get the number of paragraphs.
		  count = doc.getParagraphCount - 1
		  
		  ' Scan the paragraphs.
		  for i = 0 to count
		    
		    ' Get the paragraph.
		    p = doc.getParagraph(i)
		    
		    ' Get the width of the paragraph.
		    paragraphWidth = p.getLeftMarginWidth + p.getSingleLineWidth
		    
		    ' Is this a new high water mark?
		    if paragraphWidth > currentWidth then
		      
		      ' Save the new max width.
		      currentWidth = paragraphWidth
		      
		    end if
		    
		  next
		  
		  ' Set the current width to at least the display width.
		  currentWidth = Max(currentWidth, me.width / 72)
		  
		  ' Save the length.
		  longestWidth = currentWidth
		  
		  ' Set the page width.
		  doc.setPageWidth((currentWidth / 72.0) + doc.getLeftMargin + doc.getRightMargin)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getTag(index as integer) As FTXojoScriptTag
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Are we in range?
		  if index < 0 then
		    
		    ' No tag found.
		    return nil
		    
		  end if
		  
		  ' Does the tag exist?
		  if doc.getParagraph(index).tag is nil then
		    
		    ' Create the tag.
		    doc.getParagraph(index).tag = new FTXojoScriptTag
		    
		  end if
		  
		  ' Retrieve the tag.
		  return FTXojoScriptTag(doc.getParagraph(index).tag.ObjectValue)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub indentAllLines()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Indent all the lines.
		  indentLines(0, doc.getParagraphCount - 1, 0)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub indentLines(startLine as integer, endLine as integer, indentLevel as integer)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim p as FTParagraph
		  Dim tag as FTXojoScriptTag
		  
		  ' Calculate the indents for the lines.
		  for i = startLine to endLine
		    
		    ' Get the paragraph.
		    p = doc.getParagraph(i)
		    
		    ' Are we done?
		    if p is nil then return
		    
		    ' Is this a new paragraph?
		    if p.tag is nil then
		      
		      ' Create a new tag.
		      tag = new FTXojoScriptTag
		      
		      ' Save the tag.
		      p.tag = tag
		      
		    else
		      
		      ' Extract the tag.
		      tag = p.tag
		      
		    end if
		    
		    ' Has the rage been populated yet?
		    if tag.type = -1 then
		      
		      ' Set the indation type of the line.
		      tag.type = findIndentType(p.getText)
		      tag.level = indentLevel
		      
		    end if
		    
		    ' Set the indentation of the line.
		    setLineLevel(tag, p, indentLevel)
		    
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub insertRTF(text as string)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Convert to plain text.
		  insertText(FTUtilities.convertRTFToText(text))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub insertText(s as string, trimLines as boolean = true)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim state as boolean
		  
		  ' Turn off updates.
		  state = setInhibitUpdates(true)
		  
		  ' Should we chop off leading white space?
		  if trimLines then
		    
		    ' Get rid of leading white spaces.
		    s = trimAllLines(s)
		    
		  end if
		  
		  ' Convert to plain text.
		  super.insertText(s)
		  
		  ' Indent the lines.
		  indentAllLines
		  
		  ' Restore the update state.
		  call setInhibitUpdates(state)
		  
		  ' Update the display.
		  update(true, true)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub insertXML(text as string)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Convert to plain text.
		  insertText(FTUtilities.convertXMLToText(text))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isComment(s as string) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim ch as string
		  
		  ' ' comment.
		  if LeftB(s, 1) = "'" then return true
		  
		  ' // comment.
		  if LeftB(s, 2) = "//" then return true
		  
		  ' REM comment.
		  if (LeftB(s, 3) = "rem") then
		    
		    ' Get the character after the rem statement.
		    ch = midB(s, 4, 1)
		    
		    ' Is it a space?
		    if (ch = " ") or (ch.lenB = 0) then
		      
		      ' This is a comment.
		      return true
		      
		    end if
		    
		  end if
		  
		  ' Not a comment.
		  return false
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isNumeric(s as string, ByRef isFloat as boolean) As boolean
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim ch as byte
		  Dim i as integer
		  Dim count as integer
		  Dim dotCount as integer
		  
		  ' Assume an integer.
		  isFloat = false
		  
		  ' Get the length of the string.
		  count = s.lenB
		  
		  ' Scan the string.
		  for i = 1 to count
		    
		    ' Extract the character.
		    ch = AscB(MidB(s, i, 1))
		    
		    ' Is this a non-integer?
		    if ch > 57 then
		      
		      ' This is not a numeric.
		      return false
		      
		      ' Is this a non-integer and not a dot chacracter.
		    elseif ch < 48 then
		      
		      ' Is this a non-dot character?
		      if ch <> 46 then
		        
		        ' This is not a numeric.
		        return false
		        
		      else
		        
		        ' Are there to many dots?
		        if dotCount > 0 then return false
		        
		        ' Save the number of dots.
		        dotCount = dotCount + 1
		        
		        ' Mark it as a floating point numeric.
		        isFloat = true
		        
		      end if
		      
		    end if
		    
		  next
		  
		  ' Is this just a dot?
		  if (count = 1) and (dotCount = 1) then return false
		  
		  ' This is a numeric.
		  return true
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function lookupErrorCode(errorCode as integer) As string
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Does this error exist?
		  if errorCodeLookup.HasKey(errorCode) then
		    
		    ' Return the error message.
		    return errorCodeLookup.Value(errorCode)
		    
		  else
		    
		    ' We don't know what this is.
		    return "Unknown error code."
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function nextLineLevel(tag as FTXojoScriptTag) As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set the left margin based on the type.
		  select case tag.type
		    
		  case 1
		    
		    ' Start of new block.
		    return tag.level + 1
		    
		  case 2
		    
		    ' else/elseif block.
		    return tag.level + 1
		    
		  end select
		  
		  ' Return the current level.
		  return tag.level
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setLineLevel(tag as FTXojoScriptTag, p as FTParagraph, ByRef indentLevel as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set the left margin based on the type.
		  select case tag.type
		    
		  case 0
		    
		    '-------------------------
		    ' Plain line.
		    '-------------------------
		    
		    ' Save the indent level.
		    tag.level = indentLevel
		    
		    ' Did the left margin change?
		    if p.getLeftMargin <> (indentLevel * Indent) then
		      
		      ' Set the indention.
		      p.setLeftMargin(indentLevel * Indent)
		      
		    end if
		    
		  case 1
		    
		    '-------------------------
		    ' Start of new block.
		    '-------------------------
		    
		    ' Save the indent level.
		    tag.level = indentLevel
		    
		    ' Did the left margin change?
		    if p.getLeftMargin <> (indentLevel * Indent) then
		      
		      ' Set the indention.
		      p.setLeftMargin(indentLevel * Indent)
		      
		    end if
		    
		    ' Indent the lines that follow.
		    indentLevel = indentLevel + 1
		    
		  case 3
		    
		    '-------------------------
		    ' End of block.
		    '-------------------------
		    
		    ' Calculate the indent level.
		    indentLevel = Max(indentLevel - 1, 0)
		    
		    ' Save the indent level.
		    tag.level = indentLevel
		    
		    ' Did the left margin change?
		    if p.getLeftMargin <> (indentLevel * Indent) then
		      
		      ' Set the indention.
		      p.setLeftMargin(indentLevel * Indent)
		      
		    end if
		    
		  case 2
		    
		    '-------------------------
		    ' else/elseif block.
		    '-------------------------
		    
		    ' Save the indent level.
		    tag.level =  Max(indentLevel - 1, 0)
		    
		    ' Did the left margin change?
		    if p.getLeftMargin <> (tag.level * Indent) then
		      
		      ' Set the indention.
		      p.setLeftMargin(tag.level * Indent)
		      
		    end if
		    
		  else
		    
		    '-------------------------
		    ' Plain line.
		    '-------------------------
		    
		    ' Save the indent level.
		    tag.level = indentLevel
		    
		    ' Did the left margin change?
		    if p.getLeftMargin <> (indentLevel * Indent) then
		      
		      ' Set the indention.
		      p.setLeftMargin(indentLevel * Indent)
		      
		    end if
		    
		  end select
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setRTF(s as string)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Convert to plain text.
		  setText(FTUtilities.convertRTFToText(s))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setSoftwrap(value as boolean, force as boolean = false)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Is there anything to do?
		  if (not force) and (value = Softwrap) then return
		  
		  ' Save the current value.
		  Softwrap = value
		  
		  ' Turn off updates.
		  call setInhibitUpdates(true)
		  
		  ' Are we soft wrapping?
		  if value then
		    
		    ' Soft wrap.
		    setEditViewMode(EditViewMargin)
		    
		  else
		    
		    ' No wrapping.
		    setSingleViewMode(EditViewMargin)
		    
		  end if
		  
		  ' Reset the line numbers.
		  showLineNumbers(showLineNumbers, true)
		  
		  ' Set the scrollbar auto hide feature
		  HScrollbarAutoHide = not Value
		  
		  ' Allow updates.
		  call setInhibitUpdates(false)
		  
		  ' Update the display.
		  updateFull
		  
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
		  
		  ' Get rid of leading white spaces.
		  s = trimAllLines(s)
		  
		  ' Remove all tabs.
		  s = ReplaceAllB(s, chr(9), "")
		  
		  ' Insert the text.
		  super.setText(s)
		  
		  ' Restore the update state.
		  call setInhibitUpdates(state)
		  
		  ' Indent the lines.
		  indentAllLines
		  
		  ' Update the display.
		  updateFull
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setupScratchGraphic()
		  ' ScratchGraphic needs updating when font or size is changed
		  
		  scratchGraphic.TextFont = DefaultFont
		  scratchGraphic.TextSize = DefaultFontSize
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setXML(s as string)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set the text.
		  setText(FTUtilities.convertXMLToText(s))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub showErrorLine(line as integer = - 1)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  
		  ' Get the number of lines.
		  count = doc.getParagraphCount - 1
		  
		  ' Turn off all the error lines.
		  for i = 0 to count
		    
		    ' Is this an error line?
		    if doc.getParagraph(i).getBackgroundColor = Error then
		      
		      ' Turn off the line.
		      doc.getParagraph(i).setBackgroundColor
		      
		      ' Mark it as dirty.
		      doc.getParagraph(i).makeDirty
		      
		      ' We are done.
		      exit
		      
		    end if
		    
		  next
		  
		  ' Is the line in range?
		  if (line >= 0) and (line <= count) then
		    
		    ' Color the line.
		    doc.getParagraph(line).setBackgroundColor(Error)
		    
		    ' Mark it as dirty.
		    doc.getParagraph(line).makeDirty
		    
		  end if
		  
		  ' Update the display.
		  update(true, true)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub showLineNumbers(state as boolean, force as boolean = false)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Is there anything to do?
		  if (not force) and (state = showLineNumbers) then return
		  
		  ' Save the change in state.
		  showLineNumbers = state
		  
		  ' What should we do?
		  if state then
		    
		    ' Allocate space for the line numbers.
		    lineNumberWidth = scratchGraphic.StringWidth("888888") + (2 * LINE_NUMBER_BORDER)
		    
		  Else
		    
		    ' Turn it off.
		    lineNumberWidth = 0
		    
		  end if
		  
		  ' Adjust the left margin according to the mode
		  
		  Dim margin As Double
		  
		  Select Case Mode
		  Case Display_Mode.Page, Display_Mode.Normal
		    
		    margin = LeftMargin
		    
		  Case Display_Mode.EDIT, Display_Mode.Single
		    
		    margin = EditViewMargin
		    
		  End Select
		  
		  //Line Number Width comes back in pixels
		  //Margins are in Inches.
		  
		  getDoc.setLeftMargin(lineNumberWidth/72  + margin)
		  
		  ' Update the display.
		  update(False, True)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function trimAllLines(s as string) As string
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim sa() as string
		  
		  ' Normalize the line endings.
		  s = ReplaceLineEndings(s, EndOfLine.Macintosh)
		  
		  ' Split into lines.
		  sa = split(s, EndOfLine.Macintosh)
		  
		  ' Get the number of lines.
		  count = Ubound(sa)
		  
		  ' Trim all the lines.
		  for i = 0 to count
		    
		    ' Chop off the leading spaces.
		    sa(i) = LTrim(sa(i))
		    
		  next
		  
		  ' Put the text back together.
		  return join(sa, EndOfLine.Macintosh)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub update(compose as boolean, force as boolean)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Are we composing the paragraphs?
		  if compose and (not doc.isSelected) then
		    
		    ' Update the keyword coloring and maximum width.
		    composeDirtyParagraphs
		    
		  end if
		  
		  ' Update the display.
		  super.update(compose, force)
		  
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event Close()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event DrawLine(proxy as FTParagraphProxy, line as FTLine, g as graphics, drawBeforeSpace as boolean, firstIndent as integer, page as integer, x as double, y as double, leftPoint as integer, rightPoint as integer, alignment as FTParagraph.Alignment_Type, printing as boolean, printScale as double)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Open()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event PostPageDraw(g as graphics, p as FTPage, printing as boolean, printScale as double)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event TextChanged()
	#tag EndHook


	#tag Property, Flags = &h21
		Private cache() As FTStyleRun
	#tag EndProperty

	#tag Property, Flags = &h0
		Comments As color = &c7F0000
	#tag EndProperty

	#tag Property, Flags = &h0
		Error As Color = &cFF86A4
	#tag EndProperty

	#tag Property, Flags = &h21
		Private errorCodeLookup As dictionary
	#tag EndProperty

	#tag Property, Flags = &h0
		Floating As color = &c006532
	#tag EndProperty

	#tag Property, Flags = &h0
		Indent As double = 0.25
	#tag EndProperty

	#tag Property, Flags = &h21
		Private indentTimer As FTXojoScriptIndentTimer
	#tag EndProperty

	#tag Property, Flags = &h0
		Integers As color = &c326598
	#tag EndProperty

	#tag Property, Flags = &h21
		Private keywordLookup As dictionary
	#tag EndProperty

	#tag Property, Flags = &h0
		Keywords As color = &c0000FF
	#tag EndProperty

	#tag Property, Flags = &h0
		LineNumberBackground As color = &cF0F0F0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private lineNumberCache() As LineNumber
	#tag EndProperty

	#tag Property, Flags = &h0
		LineNumberColor As Color = &c000000
	#tag EndProperty

	#tag Property, Flags = &h21
		Private lineNumberWidth As integer
	#tag EndProperty

	#tag Property, Flags = &h0
		LineSeparator As Color = &cAAAAAA
	#tag EndProperty

	#tag Property, Flags = &h21
		Private longestWidth As integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private maxKeywordLength As integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private regColor As RegEx
	#tag EndProperty

	#tag Property, Flags = &h21
		Private regIndent As RegEx
	#tag EndProperty

	#tag Property, Flags = &h21
		Private regIndentIfThen As RegEx
	#tag EndProperty

	#tag Property, Flags = &h21
		Private scratchGraphic As Graphics
	#tag EndProperty

	#tag Property, Flags = &h21
		Private scratchPicture As Picture
	#tag EndProperty

	#tag Property, Flags = &h0
		ShowLineNumbers As boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		Softwrap As boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		Source As color = &c000000
	#tag EndProperty

	#tag Property, Flags = &h0
		Strings As color = &c6500FE
	#tag EndProperty


	#tag Constant, Name = ERROR_CODES, Type = String, Dynamic = False, Default = \"1\rSyntax does not make sense.\r2\rType mismatch.\r3\rSelect Case does not support that type of expression.\r4\rThe compiler is not implemented (obsolete).\r5\rThe parser\'s internal stack has overflowed.\r6\rToo many parameters for this function.\r7\rNot enough parameters for this function call.\r8\rWrong number of parameters for this function call.\r9\rParameters are incompatible with this function.\r10\rAssignment of an incompatible data type.\r11\rUndefined identifier.\r12\rUndefined operator.\r13\rLogic operations require Boolean operands.\r14\rArray bounds must be integers.\r15\rCan\'t call a non-function.\r16\rCan\'t get an element from something that isn\'t an array.\r17\rNot enough subscripts for this array\'s dimensions.\r18\rToo many subscripts for this array\'s dimensions.\r19\rCan\'t assign an entire array.\r20\rCan\'t use an entire array in an expression.\r21\rCan\'t pass an expression as a ByRef parameter.\r22\rDuplicate identifier.\r23\rThe backend code generator failed.\r24\rAmbiguous call to overloaded method.\r25\rMultiple inheritance is not allowed.\r26\rCannot create an instance of an interface.\r27\rCannot implement a class as though it were an interface.\r28\rCannot inherit from something that is not a class.\r29\rThis class does not fully implement the specified interface.\r30\rEvent handlers cannot live outside of a class.\r31\rIt is not legal to ignore the result of a function call.\r32\rCan\'t use \"Self\" keyword outside of a class.\r33\rCan\'t use \"Me\" keyword outside of a class.\r34\rCan\'t return a value from a Sub.\r35\rAn exception object required here.\r40\rDestructors can\'t have parameters.\r41\rCan\'t use \"Super\" keyword outside of a class.\r42\rCan\'t use \"Super\" keyword in a class that has no parent.\r43\rThis #else does not have a matching #if preceding it.\r44\rThis #endif does not have a matching #if preceding it.\r45\rOnly Boolean constants can be used with #if.\r46\rOnly Boolean constants can be used with #if.\r47\rThe Next variable (%1) does not match the loop\'s counter variable (%2).\r48\rThe size of an array must be a constant or number.\r49\rYou can\'t pass an array to an external function.\r50\rExternal functions cannot use objects as parameters.\r51\rExternal functions cannot use ordinary strings as parameters. Use CString\x2C PString\x2C WString\x2C or CFStringRef instead.\r52\rThis kind of array can not be sorted.\r53\rThis property is protected. It can only be used from within its class.\r54\rThis method is protected. It can only be called from within its class.\r55\rThis local variable or constant has the same name as a Declare in this method. You must resolve this conflict.\r56\rThis global variable has the same name as a global function. You must resolve this conflict.\r57\rThis property has the same name as a method. You must resolve this conflict.\r58\rThis property has the same name as an event. You must resolve this conflict.\r59\rThis global variable has the same name as a class. You must resolve this conflict.\r60\rThis global variable has the same name as a module. You must change one of them.\r61\rThis local variable or parameter has the same name as a constant. You must resolve this conflict.\r62\r(%1) is reserved and can\'t be used as a variable or property name.\r63\rThere is no class with this name.\r64\rThe library name must be a string constant.\r65\rThis Declare Function statement is missing its return type.\r66\rYou can\'t use the New operator with this class.\r67\rThis method doesn\'t return a value.\r68\rEnd quote missing.\r69\rA class cannot be its own superclass.\r70\rCannot assign a value to this property.\r71\rCannot get this property\'s value.\r72\rThe If statement is missing its condition.\r73\rThe current function must return a value\x2C but this Return statement does not specify any value.\r74\rParameter options (%1) and (%2) are incompatible.\r75\rParameter option (%1) was already specified.\r76\rA parameter passed by reference cannot have a default value.\r77\rA ParamArray cannot have a default value.\r78\rAn Assigns parameter cannot have a default value.\r79\rAn Extends parameter cannot have a default value.\r80\rOnly the first parameter may use the Extends option.\r81\rOnly the last parameter may use the Assigns option.\r82\rAn ordinary parameter cannot follow a ParamArray.\r83\rOnly one parameter may use the Assigns option.\r84\rOnly one parameter may use the ParamArray option.\r85\rA ParamArray cannot have more than one dimension.\r86\rThe keyword \"Then\" is expected after this If statement\'s condition.\r87\r(obsolete)\r88\rConstants must be defined with constant values.\r89\rIllegal use of the Call keyword.\r90\rNo cases may follow the Else block.\r91\r(%1) is not a legal property accessor type.\r92\rThis (%1) accessor must end with \"End (%1)\"\x2C not \"End (%2)\".\r93\rDuplicate method definition.\r94\rThe library name for this declaration is blank.\r95\rThis If statement is missing an End If statement.\r96\rThis Select Case statement is missing an End Select statement.\r97\rThis For loop is missing its Next statement.\r98\rThis While loop is missing its Wend statement.\r99\rThis Try statement is missing an End Try statement.\r100\rThis Do loop is missing its Loop statement.\r101\rToo few parentheses.\r102\rToo many parentheses.\r103\rThe Continue statement only works inside a loop.\r104\rThere is no (%1) block to (%2) here.\r105\rShared methods cannot access instance properties.\r106\rShared methods cannot access instance methods.\r107\rShared computed property accessors cannot access instance properties.\r108\rShared computed property accessors cannot access instance methods.\r109\rThe Constructor of this class is protected\x2C and can only be called from within this class.\r110\rThis String field needs to specify its length.\r111\rStructures cannot contain (%1) fields.\r112\rStructures cannot contain multidimensional arrays.\r113\rEnumerated types can only contain integers.\r114\rAn Enumeration cannot be defined in terms of another enumeration.\r115\rThis is a constant; its value can\'t be changed.\r116\rA String field must be at least 1 byte long.\r117\rThe storage size specifier only applies to String fields.\r118\rA Structure cannot contain itself.\r119\r(%1) is a structure\x2C not a class\x2C and cannot be instantiated with New.\r120\r(%1) is an enumeration\x2C not a class\x2C and cannot be instantiated with New.\r121\rThis type is private\x2C and can only be used within its module.\r122\rClass members cannot be global.\r123\rModule members must be public or private; they cannot be protected.\r124\rMembers of inner modules cannot be global.\r125\rA Dim statement creates only one new object at a time.\r126\rA constant was expected here\x2C but this is some other kind of expression.\r127\rThis module is private\x2C and can only be used within its containing module.\r128\rDuplicate property definition.\r129\rThis datatype cannot be used as an array element.\r130\rDelegate parameters cannot be optional.\r131\rDelegates cannot use Extends\x2C Assigns\x2C or ParamArray.\r132\rThe Declare statement is illegal in RBScript.\r133\rIt is not legal to dereference a Ptr value in an RBScript.\r134\rDelegate creation from Ptr values is not allowed in RBScript.\r135\rDelegate constant definition.\r136\rAmbiguous interface method implementation.\r137\rIllegal explicit interface method implementation. The class does not claim to implement this interface.\r138\rThe interface does not declare this method.\r139\rThis method contains a #If without a closing #endif statement.\r140\rThis interface contains a cyclical interface aggregation.\r141\rThe Extends modifier cannot be used on a class method.\r142\rYou cannot assign a non-value type to a value.\r143\rDuplicate attribute name.\r144\rDelegates cannot return structures.\r145\rYou cannot create a delegate from this identifier.\r146\rYou cannot use an Operator_Convert method to perform a convert-to operation on an interface.\r147\rThe ElseIf statement is missing its condition.\r148\rThis type cannot be used as an explicit constant type.\r149\rRecursive constant declaration error.\r150\rCustom error created using #error.\r151\rThis is not a local variable or parameter.\r152\rThe maximum units in last position parameter must be a constant.\r153\rThe maximum units in last position parameter is out of range.\r154\rThe StructureAlignment attribute\'s value must be of the following: 1\x2C 2\x2C 4\x2C 8\x2C 16\x2C 32\x2C 64\x2C or 128.\r155\rPair creation via the: operator is not allowed in RBScript.\r156\rIntrospection via the GetTypeInfo operator is not allowed in RBScript.\r157\rThe For statement is missing its condition.\r158\rThe While statement is missing its condition.\r159\rUnsigned integer used in negative step loops can cause an infinite loop.", Scope = Public
	#tag EndConstant

	#tag Constant, Name = KEYWORD_LIST, Type = String, Dynamic = False, Default = \"#bad\r#else 2\r#elseif 2\r#endif 3\r#if 1\r#pragma\r#tag\raddressof\raggregates\rand\rarray\ras\rassigns\rattributes\rboolean\rbreak\rbyref\rbyte\rbyval\rcall\rcase 2\rcatch 2\rcfstringref\rclass 1\rcolor\rconst\rcontinue\rcstring\rcurrency\rdeclare\rdelegate\rdim\rdo 1\rdouble\rdownto\reach\relse 2\relseif 2\rend 3\renum\revent\rexception 1\rexit\rextends\rfalse\rfinally 2\rfor 1\rfunction 1\rglobal\rgoto\rhandles\rif 1\rimplements\rin\rinherits\rinline68k\rint8\rint16\rint32\rint64\rinteger\rinterface 1\ris\risa\rlib\rloop 3\rme\rmod\rmodule 1\rnamespace\rnew\rnext 3\rnil\rnot\robject\rof\roptional\ror\rostype\rparamarray\rprivate\rproperty\rprotected\rpstring\rptr\rpublic\rraise\rraiseevent\rredim\rreturn\rselect 1\rself\rshared\rshort\rsingle\rsoft\rstatic\rstep\rstring\rstructure\rsub 1\rsuper\rthen\rto\rtrue\rtry 1\rubyte\ruint8\ruint16\ruint32\ruint64\runtil\rushort\rvariant\rwend 3\rwhile 1\rwindowptr\rwith\rwstring", Scope = Public
	#tag EndConstant

	#tag Constant, Name = LINE_NUMBER_BORDER, Type = Double, Dynamic = False, Default = \"5", Scope = Public
	#tag EndConstant

	#tag Constant, Name = LINE_NUMBER_CONTINUATION, Type = String, Dynamic = False, Default = \".", Scope = Public
	#tag EndConstant


	#tag Structure, Name = LineNumber, Flags = &h0
		y as integer
		  number as integer
		firstLine as boolean
	#tag EndStructure


	#tag ViewBehavior
		#tag ViewProperty
			Name="Tooltip"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="CornerColor"
			Visible=true
			Group="FT Behavior"
			InitialValue="&cFFFFFF00"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="UsePageShadow"
			Visible=true
			Group="FT Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="WordParagraphBackground"
			Visible=true
			Group="FT Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowBackgroundUpdates"
			Visible=true
			Group="FT Behavior"
			InitialValue="True"
			Type="boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowPictures"
			Visible=true
			Group="FT Behavior"
			InitialValue="True"
			Type="boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AutoComplete"
			Visible=true
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
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
			Name="BackgroundColor"
			Visible=true
			Group="FT Behavior"
			InitialValue="&cA0ADCD"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="BorderColor"
			Visible=true
			Group="FT Behavior"
			InitialValue="&ca0a0a0"
			Type="color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="BottomMargin"
			Visible=true
			Group="FT Page Mode"
			InitialValue="0"
			Type="double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="CaretColor"
			Visible=true
			Group="FT Behavior"
			InitialValue="&c000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Comments"
			Visible=true
			Group="Keyword Colors"
			InitialValue="&c7F0000"
			Type="color"
			EditorType=""
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
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="defaultHyperLinkColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c0000ff"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="defaultHyperLinkColorDisabled"
			Visible=false
			Group="Behavior"
			InitialValue="&ccccccc"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="defaultHyperLinkColorRollover"
			Visible=false
			Group="Behavior"
			InitialValue="&cFF0000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="defaultHyperLinkColorVisited"
			Visible=false
			Group="Behavior"
			InitialValue="&c800080"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DefaultTabStop"
			Visible=true
			Group="FT Defaults"
			InitialValue="0.5"
			Type="double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DefaultTextColor"
			Visible=true
			Group="FT Defaults"
			InitialValue="&c000000"
			Type="Color"
			EditorType=""
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
			Name="DragAndDrop"
			Visible=true
			Group="FT Behavior"
			InitialValue="True"
			Type="boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DrawControlBorder"
			Visible=true
			Group="FT Behavior"
			InitialValue="true"
			Type="boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="EditViewMargin"
			Visible=true
			Group="FT Edit Mode"
			InitialValue="0.06"
			Type="double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="EditViewPrintMargin"
			Visible=true
			Group="FT Edit Mode"
			InitialValue="0.5"
			Type="double"
			EditorType=""
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
			Name="Error"
			Visible=true
			Group="Keyword Colors"
			InitialValue="&cFF86A4"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Floating"
			Visible=true
			Group="Keyword Colors"
			InitialValue="&c006532"
			Type="color"
			EditorType=""
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
			Name="HScrollbarAutoHide"
			Visible=true
			Group="FT Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Indent"
			Visible=true
			Group="RBScript"
			InitialValue="0.25"
			Type="double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="InhibitSelections"
			Visible=true
			Group="FT Behavior"
			InitialValue="False"
			Type="boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="InitialParent"
			Visible=false
			Group="Position"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Integers"
			Visible=true
			Group="Keyword Colors"
			InitialValue="&c326598"
			Type="color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="InvisiblesColor"
			Visible=true
			Group="FT Behavior"
			InitialValue="&c526AFF"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsHiDPT"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Keywords"
			Visible=true
			Group="Keyword Colors"
			InitialValue="&c0000FF"
			Type="color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LeftMargin"
			Visible=true
			Group="FT Page Mode"
			InitialValue="0"
			Type="double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LineNumberBackground"
			Visible=true
			Group="Line Numbers"
			InitialValue="&cF0F0F0"
			Type="color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LineNumberColor"
			Visible=true
			Group="Line Numbers"
			InitialValue="&c000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LineSeparator"
			Visible=true
			Group="Line Numbers"
			InitialValue="&cAAAAAA"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockBottom"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockLeft"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockRight"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockTop"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="MarginGuideColor"
			Visible=true
			Group="FT Behavior"
			InitialValue="&cCACACA"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Mode"
			Visible=true
			Group="FT Behavior"
			InitialValue=""
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
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="objectCountId"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="PageHeight"
			Visible=true
			Group="FT Page Mode"
			InitialValue="11.0"
			Type="double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="PageWidth"
			Visible=true
			Group="FT Page Mode"
			InitialValue="8.5"
			Type="double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ReadOnly"
			Visible=true
			Group="FT Behavior"
			InitialValue="False"
			Type="boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="RightMargin"
			Visible=true
			Group="FT Page Mode"
			InitialValue="0"
			Type="double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ShowInvisibles"
			Visible=true
			Group="FT Behavior"
			InitialValue="False"
			Type="boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ShowLineNumbers"
			Visible=true
			Group="Line Numbers"
			InitialValue="False"
			Type="boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ShowMarginGuides"
			Visible=true
			Group="FT Behavior"
			InitialValue="False"
			Type="boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ShowPilcrows"
			Visible=true
			Group="FT Behavior"
			InitialValue="False"
			Type="boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Softwrap"
			Visible=true
			Group="FT Behavior"
			InitialValue=""
			Type="boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Source"
			Visible=true
			Group="Keyword Colors"
			InitialValue="&c000000"
			Type="color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="SpellCheckWhileTyping"
			Visible=true
			Group="FT Behavior"
			InitialValue="False"
			Type="boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Strings"
			Visible=true
			Group="Keyword Colors"
			InitialValue="&c6500FE"
			Type="color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType="String"
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
			Visible=false
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
			Name="TIC_PageTop"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TIC_xCaret"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TIC_yCaret"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TopMargin"
			Visible=true
			Group="FT Page Mode"
			InitialValue="0"
			Type="double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="UndoLimit"
			Visible=true
			Group="FT Behavior"
			InitialValue="128"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="updateFlag"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="boolean"
			EditorType=""
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
			Name="VScrollbarAutoHide"
			Visible=true
			Group="FT Behavior"
			InitialValue="False"
			Type="boolean"
			EditorType=""
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
			Name="xDisplayAlignmentOffset"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
