#tag Class
Protected Class FTParagraph
Inherits FTBase
	#tag Method, Flags = &h0
		Sub addFullProxy(page as integer, compositionPosition as double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' We need to throw away the proxies.
		  clearProxies
		  
		  ' Add the proxy to the list.
		  proxies.append(new FTParagraphProxy(parentControl, self, page, 0, Ubound(lines), compositionPosition))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub addObject(obj as FTObject)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim lastItem as FTObject
		  Dim iItemsMax As Integer = items.Ubound
		  
		  ' Is this an empty object (except for a marker)?
		  if (iItemsMax > 0) and (obj.getLength <= 0) and (not (obj isa FTMarker)) then
		    
		    ' We are done.
		    return
		  end if
		  
		  ' Are we allowing pictures?
		  if (obj isa FTPicture) and (not parentControl.AllowPictures) then return
		  
		  ' The length has changed.
		  length = -1
		  
		  ' Is this a style run?
		  if obj isa FTStyleRun then
		    
		    ' Remove any line endings.
		    FTStyleRun(obj).removeLineEndings
		    
		  end if
		  
		  '-----------------------------------------------
		  ' Compare the last item to the one we are adding.
		  '-----------------------------------------------
		  
		  ' Is there anything to compare?
		  if iItemsMax > -1 then
		    
		    ' Get the last item in the list.
		    lastItem = items(iItemsMax)
		    
		    ' Is the last item and the item we are adding style runs?
		    if (obj isa FTStyleRun) and (lastItem isa FTStyleRun) then
		      
		      ' Do they have the same style settings?
		      if FTStyleRun(obj).isSameStyle(FTStyleRun(lastItem)) then
		        
		        ' Add the text to the existing style.
		        FTStyleRun(lastItem).appendText(FTStyleRun(obj).getText)
		        
		        ' We are done.
		        return
		        
		      end if
		      
		      ' if we only have one item in our pagraph and it has no text, we should remove it
		      ' because it will just be the blank first style
		      if iItemsMax = 0 then
		        
		        if FTStyleRun(lastItem).getLength = 0 then
		          ' it has not text and is probably the default style run with no settings
		          me.items.Remove(0)
		        end if
		      end if
		    end if
		  end if
		  
		  '-----------------------------------------------
		  
		  ' Add the item to the paragraph.
		  addObjectFast(obj)
		  
		  ' Mark the paragraph as dirty.
		  makeDirty
		  
		  ' Mark the paragraph for spell checking.
		  makeSpellingDirty
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub addObjectFast(obj as FTObject)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set the reference to the parent paragraph.
		  obj.setParagraph(self)
		  
		  ' Add the item to the paragraph.
		  items.Append(obj)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub addObjects(obj() as FTObject)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  
		  ' The length has changed.
		  length = -1
		  
		  ' Get the number of items to add.
		  count = Ubound(obj)
		  
		  ' Add the FTObjects to the list.
		  for i = 0 to count
		    
		    ' Add the item to the paragraph.
		    addObject(obj(i))
		    
		  next
		  
		  ' Mark the paragraph as dirty.
		  makeDirty
		  
		  ' Update the object positions.
		  updatePositions
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub addParagraph(p as FTParagraph)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  
		  ' Get the number of items.
		  count = p.getItemCount - 1
		  
		  ' Add in all of the items.
		  for i = 0 to count
		    
		    ' Add the item to the list.
		    addObject(p.getItem(i))
		    
		  next
		  
		  ' Update the positions.
		  updatePositions
		  
		  ' Mark the paragraph for updating.
		  makeDirty
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub addPartialProxy(page as integer, startLine as integer, endLine as integer, compositionPosition as double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Add the proxy to the list.
		  proxies.append(new FTParagraphProxy(parentControl, self, page, startLine, endLine, compositionPosition))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub addTabStop(tabType as FTTabStop.TabStopType, tabStop as double, tableader as FTTab.Tab_Leader_Type)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #EndIf
		  
		  Dim i as integer
		  Dim count as integer
		  Dim ts as FTTabStop
		  
		  ' Get the number of existing tab stops.
		  count = Ubound(tabStops)
		  
		  ' Clear out the default tab stops.
		  for i = count downto 0
		    
		    ' Is this a default tab stop?
		    if tabStops(i).default then
		      
		      ' Remove the tab stop.
		      tabStops.Remove(i)
		      
		    end if
		    
		  next
		  
		  ' Flag that we need to add the default tab stops.
		  addDefaultTabStops = true
		  
		  ' Create the tab stop.
		  ts = New FTTabStop(parentControl, tabType, tabStop, False, tableader)
		  
		  ' Get the number of tab stops.
		  count = Ubound(tabStops) - 1
		  
		  ' Scan for the place to insert the tab stop.
		  for i = 0 to count
		    
		    ' Did we find the spot to insert the tab stop?
		    if (tabStop >= tabStops(i).getTabStop) and _
		      (tabStop <= tabStops(i + 1).getTabStop) then
		      
		      ' Insert the tab stop into the list.
		      tabStops.Insert(i + 1, ts)
		      
		      ' We are done.
		      return
		      
		    end if
		    
		  next
		  
		  ' Add the tab stop to the end of the list.
		  tabStops.Append(ts)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub addTestItems(plainType as boolean, preText as string, items as integer)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim sa() as string
		  Dim sr as FTStyleRun
		  Dim length as integer
		  Dim testLength1 as integer
		  Dim testLength2 as integer
		  
		  const FONT_SIZE = 12
		  const FONT_NAME = "arial"
		  const TEST_TEXT1 = "Now is the time for all good men to come to the aid of their country. "
		  const TEST_TEXT2 = "These are the times that try men's souls.  "
		  
		  '-------------------------------------
		  ' Add plain paragraphs.
		  '-------------------------------------
		  
		  ' Get the lengths of the text.
		  testLength1 = TEST_TEXT1.len
		  testLength2 = TEST_TEXT2.len
		  
		  ' Should we do just plain text?
		  if plainType then
		    
		    ' Was the number of items specified?
		    if items < 1 then
		      
		      ' Use the default value.
		      items = 6
		      
		    end if
		    
		    ' Was a pretext specified?
		    if preText <> "" then
		      
		      ' Add the specified pretext.
		      sa.append(preText)
		      
		      ' Add in the length of the string.
		      length = length + preText.len
		      
		    end if
		    
		    ' Create a paragraph.
		    for i = 0 to items
		      
		      ' Is this the last line?
		      if i = items then
		        
		        ' Add some text.
		        sa.append(TEST_TEXT2)
		        
		        ' Add in the length of the string.
		        length = length + testLength2
		        
		      else
		        
		        ' Add some text.
		        sa.append(TEST_TEXT1)
		        
		        ' Add in the length of the string.
		        length = length + testLength1
		        
		      end if
		      
		    next
		    
		    ' Add the item.
		    addText(join(sa, ""), length)
		    
		    ' We are done.
		    return
		    
		  end if
		  
		  '-------------------------------------
		  ' Add mixed paragraphs.
		  '-------------------------------------
		  
		  // Plain
		  
		  sr = new FTStyleRun(parentControl)
		  sr.font = FONT_NAME
		  sr.fontSize = FONT_SIZE
		  
		  ' Was the pretext specified?
		  if preText <> "" then
		    
		    sr.setText(preText + TEST_TEXT1)
		    
		  else
		    
		    sr.setText(TEST_TEXT1, testLength1)
		    
		  end if
		  
		  addObject(sr)
		  
		  '-------------------------------------
		  
		  // Bold
		  
		  sr = new FTStyleRun(parentControl)
		  sr.font = FONT_NAME
		  sr.fontSize = FONT_SIZE + 8
		  sr.bold = true
		  
		  sr.setText(TEST_TEXT1, testLength1)
		  
		  addObject(sr)
		  
		  '-------------------------------------
		  
		  // Italic
		  
		  sr = new FTStyleRun(parentControl)
		  sr.font = FONT_NAME
		  sr.fontSize = FONT_SIZE
		  sr.italic = true
		  
		  sr.setText(TEST_TEXT1, testLength1)
		  
		  addObject(sr)
		  
		  '-------------------------------------
		  
		  // Underline
		  
		  sr = new FTStyleRun(parentControl)
		  sr.font = FONT_NAME
		  sr.fontSize = FONT_SIZE
		  sr.underline = true
		  
		  sr.setText(TEST_TEXT2, testLength2)
		  
		  addObject(sr)
		  
		  '-------------------------------------
		  
		  // Plain space
		  
		  sr = new FTStyleRun(parentControl)
		  sr.font = FONT_NAME
		  sr.fontSize = FONT_SIZE
		  
		  sr.setText(" ", 1)
		  
		  addObject(sr)
		  
		  '-------------------------------------
		  
		  // Bold italic
		  
		  sr = new FTStyleRun(parentControl)
		  sr.font = FONT_NAME
		  sr.fontSize = FONT_SIZE
		  sr.bold = true
		  sr.italic = true
		  
		  sr.setText(TEST_TEXT2, testLength2)
		  
		  addObject(sr)
		  
		  '-------------------------------------
		  
		  // Plain space
		  
		  sr = new FTStyleRun(parentControl)
		  sr.font = FONT_NAME
		  sr.fontSize = FONT_SIZE
		  
		  sr.setText(sr.getText + " ", 1)
		  
		  addObject(sr)
		  
		  '-------------------------------------
		  
		  // Italic underline
		  
		  sr = new FTStyleRun(parentControl)
		  sr.font = FONT_NAME
		  sr.fontSize = FONT_SIZE
		  sr.italic = true
		  sr.underline = true
		  
		  sr.setText(TEST_TEXT2, testLength2)
		  
		  addObject(sr)
		  
		  '-------------------------------------
		  
		  // Plain
		  
		  sr = new FTStyleRun(parentControl)
		  sr.font = FONT_NAME
		  sr.fontSize = FONT_SIZE
		  
		  sr.setText(TEST_TEXT1, testLength1)
		  
		  addObject(sr)
		  
		  '-------------------------------------
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub addText(s as string, stringLength as integer = - 1)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim ftsr as FTStyleRun
		  Dim fto() as FTObject
		  
		  ' Remove line endings.
		  s = ReplaceLineEndings(s, "")
		  
		  ' Create the style run.
		  ftsr = new FTStyleRun(parentControl, s, true, stringLength)
		  
		  ' Update the style.
		  ftsr.updateWithStyle(parentControl.getDoc.getParagraphStyle(pa.paragraphStyle))
		  
		  ' Break the text up by tabs.
		  fto = ftsr.splitOnTabs
		  
		  ' Get the number of segments.
		  count = Ubound(fto)
		  
		  ' Add the segments to the paragraph.
		  for i = 0 to count
		    
		    ' Add the style run to the paragraph.
		    addObject(fto(i))
		    
		  next
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub addXMLAttributesParagraphAttributes(attributeList as XmlAttributeList)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Load the paragraph attributes.
		  pa.afterParagraphSpace = Val(attributeList.value(FTCxml.XML_AFTER_SPACE))
		  pa.beforeParagraphSpace = Val(attributeList.value(FTCxml.XML_BEFORE_SPACE))
		  pa.lineSpacing = Val(attributeList.value(FTCxml.XML_LINE_SPACING))
		  Dim oTempAlignment As FTParagraph.Alignment_Type = FTParagraph.GetAlignmentFromValue(Val(attributeList.value(FTCxml.XML_ALIGNMENT)))
		  setAlignment(oTempAlignment)
		  pa.leftMargin = Val(attributeList.value(FTCxml.XML_LEFT_MARGIN))
		  pa.rightMargin = Val(attributeList.value(FTCxml.XML_RIGHT_MARGIN))
		  pa.firstIndent = Val(attributeList.value(FTCxml.XML_FIRST_INDENT))
		  pa.paragraphStyle = parentControl.getDoc.getParagraphStyle(attributeList.value(FTCxml.XML_PARAGRAPH_STYLE)).getId
		  pa.backgroundColor = FTUtilities.stringToColor(attributeList.value(FTCxml.XML_BACKGROUND_COLOR), &cFFFFFF)
		  pa.pageBreak = (attributeList.value(FTCxml.XML_PAGE_BREAK) = "true")
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub addXmlNode(paragraph as XmlElement)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim obj as XmlElement
		  Dim fto as FTObject
		  
		  ' Load the paragraph attributes.
		  addXMLParagraphAttributes(paragraph)
		  
		  ' Decode the developer tag.
		  parentControl.callXmlDecodeTag(paragraph.GetAttribute(FTCxml.XML_TAG), self)
		  
		  ' Add the tab stops.
		  addXMLTabstops(paragraph)
		  
		  ' Get the first object.
		  obj = XmlElement(paragraph.FirstChild)
		  
		  ' Add all the runs to the paragraph.
		  while not (obj is nil)
		    
		    ' Create the object.
		    select case obj.name
		      
		    case FTCxml.XML_FTSTYLERUN
		      
		      ' Create a style run.
		      fto = new FTStyleRun(parentControl, obj)
		      
		    case FTCxml.XML_FTTAB
		      
		      ' Create the tab.
		      fto = new FTTab(parentControl, obj)
		      
		    case FTCxml.XML_FTPICTURE
		      
		      ' Create the picture.
		      fto = new FTPicture(parentControl, obj)
		      
		    else
		      
		      ' Call the custom object creation.
		      fto = parentControl.callXmlObjectCreate(obj)
		      
		    end select
		    
		    ' Was this object recognized
		    if not (fto is nil) then
		      
		      ' Add the run to the paragraph.
		      addObject(fto)
		      
		    else
		      
		      ' This is an unrecognized object.
		      parentControl.callUnrecognizedXmlObject(obj)
		      
		    end if
		    
		    ' Get the next object.
		    obj = XmlElement(obj.NextSibling)
		    
		  wend
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub addXMLParagraphAttributes(paragraph as XmlElement)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Load the paragraph attributes.
		  pa.afterParagraphSpace = Val(paragraph.GetAttribute(FTCxml.XML_AFTER_SPACE))
		  pa.beforeParagraphSpace = Val(paragraph.GetAttribute(FTCxml.XML_BEFORE_SPACE))
		  pa.lineSpacing = Val(paragraph.GetAttribute(FTCxml.XML_LINE_SPACING))
		  Dim iValue As Integer = Val(paragraph.GetAttribute(FTCxml.XML_ALIGNMENT))
		  Dim oTempAlignment As FTParagraph.Alignment_Type = FTParagraph.GetAlignmentFromValue(iValue)
		  setAlignment(oTempAlignment)
		  pa.leftMargin = Val(paragraph.GetAttribute(FTCxml.XML_LEFT_MARGIN))
		  pa.rightMargin = Val(paragraph.GetAttribute(FTCxml.XML_RIGHT_MARGIN))
		  pa.firstIndent = Val(paragraph.GetAttribute(FTCxml.XML_FIRST_INDENT))
		  pa.paragraphStyle = parentControl.getDoc.getParagraphStyle(paragraph.GetAttribute(FTCxml.XML_PARAGRAPH_STYLE)).getId
		  pa.backgroundColor = FTUtilities.stringToColor(paragraph.GetAttribute(FTCxml.XML_BACKGROUND_COLOR), &cFFFFFF)
		  pa.pageBreak = (paragraph.GetAttribute(FTCxml.XML_PAGE_BREAK) = "true")
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub addXMLTabstops(text as String)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim sa() as string
		  
		  ' Clear out the tab stops.
		  Redim tabStops(-1)
		  
		  ' Are there any tab stops to install?
		  if text <> "" then
		    
		    ' Break into individual tab stops.
		    sa = split(text, " ")
		    
		    ' Get the number of stops to add.
		    count = Ubound(sa)
		    
		    ' Add all the tab stops.
		    for i = 0 to count
		      
		      Dim iVal As Integer = sa(i).NthFieldB(TABSTOP_SEPARATOR, 3).val
		      Dim tabLeader As FTTab.Tab_Leader_Type
		      
		      Select Case iVal
		      Case 1
		        tabLeader = FTTab.Tab_Leader_Type.Dot
		      Case 2
		        tabLeader = FTTab.Tab_Leader_Type.Underscore
		      Case 3
		        tabLeader = FTTab.Tab_Leader_Type.Hypen
		      Case 4
		        tabLeader = FTTab.Tab_Leader_Type.MiddleDot
		      Case Else
		        tabLeader = FTTab.Tab_Leader_Type.None
		      End
		      
		      Dim tabStop As FTTabStop.TabStopType = FTTabStop.TabStopType.Left
		      iVal = Val(sa(i).NthFieldB(TABSTOP_SEPARATOR, 1))
		      Select Case iVal
		      Case 1
		        tabStop = FTTabStop.TabStopType.Left
		      Case 2
		        tabStop = FTTabStop.TabStopType.Center
		      Case 3
		        tabStop = FTTabStop.TabStopType.Right
		      Case Else
		        tabStop = FTTabStop.TabStopType.Left
		      End
		      
		      
		      ' Parse the tab stop.
		      addTabStop(tabStop, Val(sa(i).NthFieldB(TABSTOP_SEPARATOR, 2)), tabLeader)
		      
		    Next
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub addXMLTabstops(paragraph as XmlElement)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  
		  ' Get the tab stops.
		  dim text as string = Trim(paragraph.GetAttribute(FTCxml.XML_TAB_STOP))
		  addXMLTabstops text
		  
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
		  Dim page as integer
		  Dim lineCount as integer
		  Dim fto as FTObject
		  
		  '--------------------------------------------
		  ' Proxies.
		  '--------------------------------------------
		  
		  ' Get the number of lines.
		  lineCount = Ubound(lines)
		  
		  ' Do we have any lines?
		  if lineCount = -1 then break
		  
		  ' Get the number of proxies.
		  count = Ubound(proxies)
		  
		  ' Do we have any proxies?
		  if count = -1 then break
		  
		  ' Prep the page number.
		  page = proxies(0).getPage - 1
		  
		  ' Audit the proxies.
		  for i = 0 to count
		    
		    ' Check the paragraph.
		    proxies(i).audit
		    
		    ' Did we skip a page?
		    if (proxies(i).getPage - 1) <> page then break
		    
		    ' Move to the next page.
		    page = page + 1
		    
		  next
		  
		  ' Does the last proxy use the last line?
		  if proxies(count).getLineEnd <> lineCount then break
		  
		  '--------------------------------------------
		  ' Style run positions.
		  '--------------------------------------------
		  
		  ' Get the number of items.
		  count = Ubound(items) - 1
		  
		  ' Scan all the items.
		  for i = 0 to count
		    
		    ' Have the positions been updated?
		    if (items(i).getEndPosition + 1) <> items(i + 1).getStartPosition then break
		    
		  next
		  
		  '--------------------------------------------
		  ' Empty style runs.
		  '--------------------------------------------
		  
		  ' Get the number of items.
		  count = Ubound(items)
		  
		  ' Scan for empty styles.
		  for i = 0 to count
		    
		    ' Is this an empty run?
		    if (items(i) isa FTStyleRun) and (items(i).getLength = 0) and _
		      (not FTStyleRun(items(i)).isSaved) then
		      
		      ' Can we peek at the next item?
		      if i < Ubound(items) then
		        
		        ' Get the next item.
		        fto = items(i + 1)
		        
		      else
		        
		        ' Nothing to look at.
		        fto = nil
		        
		      end if
		      
		      ' Are we surrounded by style runs?
		      if fto isa FTStyleRun then
		        
		        ' Unnessary style run.
		        break
		        
		        ' Is there something to look at?
		      elseif i > 0 then
		        
		        ' Is it a style run?
		        if items(i - 1) isa FTStyleRun then
		          
		          ' Unnessary style run.
		          break
		          
		        end if
		        
		      end if
		      
		    end if
		    
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeBackgroundColor()
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim item as FTObject
		  
		  ' Scan the items.
		  for each item in items
		    
		    ' Change the color.
		    item.changeBackgroundColor
		    
		  next
		  
		  ' Mark the paragraph as dirty.
		  makeDirty
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeBackgroundColor(c as Color)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim item as FTObject
		  
		  ' Scan the items.
		  for each item in items
		    
		    ' Change the color.
		    item.changeBackgroundColor(c)
		    
		  next
		  
		  ' Mark the paragraph as dirty.
		  makeDirty
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeBackgroundColor(startPosition as integer, endPosition as integer)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim startIndex as integer
		  Dim endIndex as integer
		  
		  ' Get the items to change.
		  if setupChange(startPosition, endPosition, startIndex, endIndex) then
		    
		    ' Change the full styles.
		    for i = startIndex to endIndex
		      
		      ' Change the color.
		      items(i).changeBackgroundColor
		      
		    next
		    
		  end if
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeBackgroundColor(startPosition as integer, endPosition as integer, c as Color)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim startIndex as integer
		  Dim endIndex as integer
		  
		  ' Get the items to change.
		  if setupChange(startPosition, endPosition, startIndex, endIndex) then
		    
		    ' Change the full styles.
		    for i = startIndex to endIndex
		      
		      ' Change the color.
		      items(i).changeBackgroundColor(c)
		      
		    next
		    
		  end if
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeCharacterSpacing(spacing As Integer)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim item as FTObject
		  
		  ' Scan the items.
		  for each item in items
		    
		    ' Is this a text run?
		    if item isa FTStyleRun then
		      
		      ' Change the character spacing.
		      FTStyleRun(item).changeCharacterSpacing(spacing)
		      
		    end if
		    
		  next
		  
		  ' Mark the paragraph as dirty.
		  makeDirty
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeCharacterSpacing(startPosition as integer, endPosition as integer, spacing as integer)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim startIndex as integer
		  Dim endIndex as integer
		  
		  ' Get the items to change.
		  if setupChange(startPosition, endPosition, startIndex, endIndex) then
		    
		    ' Change the full styles.
		    for i = startIndex to endIndex
		      
		      ' Is this a style run?
		      if items(i) isa FTStyleRun then
		        
		        ' Change the character spacing.
		        FTStyleRun(items(i)).changeCharacterSpacing(spacing)
		        
		      end if
		      
		    next
		    
		  end if
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeCharacterStyle(styleId as integer)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim item as FTObject
		  
		  ' Scan the items.
		  for each item in items
		    
		    ' Is this a text run?
		    if item isa FTStyleRun then
		      
		      ' Change the style.
		      FTStyleRun(item).changeCharacterStyle(styleId)
		      
		    end if
		    
		  next
		  
		  ' Mark the paragraph as dirty.
		  makeDirty
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeCharacterStyle(startPosition as integer, endPosition as integer, styleId as integer)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim startIndex as integer
		  Dim endIndex as integer
		  
		  ' Get the items to change.
		  if setupChange(startPosition, endPosition, startIndex, endIndex) then
		    
		    ' Change the full styles.
		    for i = startIndex to endIndex
		      
		      ' Is this a style run?
		      if items(i) isa FTStyleRun then
		        
		        ' Change the style.
		        FTStyleRun(items(i)).changeCharacterStyle(styleId)
		        
		      end if
		      
		    next
		    
		  end if
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeColor(c as Color)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim item as FTObject
		  
		  ' Scan the items.
		  for each item in items
		    
		    ' Is this a text run?
		    if item isa FTStyleRun then
		      
		      ' Change the color.
		      FTStyleRun(item).changeColor(c)
		      
		    end if
		    
		  next
		  
		  ' Mark the paragraph as dirty.
		  makeDirty
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeColor(startPosition as integer, endPosition as integer, c as Color)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim startIndex as integer
		  Dim endIndex as integer
		  
		  ' Get the items to change.
		  if setupChange(startPosition, endPosition, startIndex, endIndex) then
		    
		    ' Change the full styles.
		    for i = startIndex to endIndex
		      
		      ' Is this a style run?
		      if items(i) isa FTStyleRun then
		        
		        ' Change the color.
		        FTStyleRun(items(i)).changeColor(c)
		        
		      end if
		      
		    next
		    
		  end if
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeFont(startPosition as integer, endPosition as integer, fontName as string)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim startIndex as integer
		  Dim endIndex as integer
		  
		  ' Get the items to change.
		  if setupChange(startPosition, endPosition, startIndex, endIndex) then
		    
		    ' Change the full styles.
		    for i = startIndex to endIndex
		      
		      ' Is this a style run?
		      if items(i) isa FTStyleRun then
		        
		        ' Change the font.
		        FTStyleRun(items(i)).changeFont(fontName)
		        
		      end if
		      
		    next
		    
		  end if
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeFont(fontName as string)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim item as FTObject
		  
		  ' Scan the items.
		  for each item in items
		    
		    ' Is this a text run?
		    if item isa FTStyleRun then
		      
		      ' Change the font.
		      FTStyleRun(item).changeFont(fontName)
		      
		    end if
		    
		  next
		  
		  ' Mark the paragraph as dirty.
		  makeDirty
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ChangeHyperLink(startPosition as integer, endPosition as integer, hyperLink As String, newWindow as Boolean)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim startIndex as integer
		  Dim endIndex as integer
		  
		  ' Get the items to change.
		  if setupChange(startPosition, endPosition, startIndex, endIndex) then
		    
		    ' Change the styles.
		    for i = startIndex to endIndex
		      
		      ' Change the color.
		      items(i).ChangeHyperLink(hyperLink,newWindow)
		    next
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ChangeHyperLink(hyperLink As String, newWindow as Boolean)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim item as FTObject
		  
		  ' Scan the items.
		  for each item in items
		    
		    ' Change the color.
		    item.ChangeHyperLink(hyperlink,newWindow)
		    
		  next
		  
		  ' Mark the paragraph as dirty.
		  makeDirty
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ChangeHyperLinkColor(linkColor As Color, linkColorRollover As Color, linkColorVisited As Color, linkColorDisabled As Color, ulNormal As Boolean, ulRollover As Boolean, ulVisited as Boolean, ulDisabled as Boolean)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim item as FTObject
		  
		  ' Scan the items.
		  for each item in items
		    
		    ' Change the color.
		    item.ChangeHyperLinkColor(linkColor,linkColorRollover, linkColorVisited, linkColorDisabled,ulNormal , ulRollover , ulVisited , ulDisabled)
		    
		  next
		  
		  ' Mark the paragraph as dirty.
		  makeDirty
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ChangeHyperLinkColor(startPosition as integer, endPosition as integer, linkColor As Color, linkColorRollover As Color, linkColorVisited As Color, linkColorDisabled As Color, ulNormal As Boolean, ulRollover As Boolean, ulVisited as Boolean, ulDisabled as Boolean)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  
		  Dim startIndex as integer
		  Dim endIndex as integer
		  
		  
		  ' Get the items to change.
		  if setupChange(startPosition, endPosition, startIndex, endIndex) then
		    ' Change the styles.
		    for i = startIndex to endIndex
		      
		      ' Change the color.
		      items(i).ChangeHyperLinkColor(linkColor,linkColorRollover, linkColorVisited, linkColorDisabled,ulNormal , ulRollover , ulVisited , ulDisabled)
		      
		    next
		    
		  end if
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeMark()
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim item as FTObject
		  
		  ' Scan the items.
		  for each item in items
		    
		    ' Change the color.
		    item.changeMark
		    
		  next
		  
		  ' Mark the paragraph as dirty.
		  makeDirty
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeMark(c as Color)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim item as FTObject
		  
		  ' Scan the items.
		  for each item in items
		    
		    ' Change the color.
		    item.changeMark(c)
		    
		  next
		  
		  ' Mark the paragraph as dirty.
		  makeDirty
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeMark(startPosition as integer, endPosition as integer)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim startIndex as integer
		  Dim endIndex as integer
		  
		  ' Get the items to change.
		  if setupChange(startPosition, endPosition, startIndex, endIndex) then
		    
		    ' Change the full styles.
		    for i = startIndex to endIndex
		      
		      ' Change the color.
		      items(i).changeMark
		      
		    next
		    
		  end if
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeMark(startPosition as integer, endPosition as integer, c as Color)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim startIndex as integer
		  Dim endIndex as integer
		  
		  ' Get the items to change.
		  if setupChange(startPosition, endPosition, startIndex, endIndex) then
		    
		    ' Change the styles.
		    for i = startIndex to endIndex
		      
		      ' Change the color.
		      items(i).changeMark(c)
		      
		    next
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeMisspelledWord(startPosition as integer, endPosition as integer, state as boolean)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim startIndex as integer
		  Dim endIndex as integer
		  Dim si as integer
		  Dim so as integer
		  
		  ' Find the starting and ending positions.
		  findRunItem(startPosition, si, so)
		  
		  ' Is there anything to look at?
		  if (si < 0) or (so < 0) then return
		  
		  ' Get the number of FTObjects.
		  count = Ubound(items)
		  
		  ' Look for the first style run.
		  for i = si to count
		    
		    ' Is this the first style run?
		    if items(i) isa FTStyleRun then
		      
		      ' Is the style run marked differently?
		      if FTStyleRun(items(i)).misspelled <> state then
		        
		        ' Get the items to change.
		        if setupChange(startPosition, endPosition, startIndex, endIndex) then
		          
		          ' Change the full styles.
		          for i = startIndex to endIndex
		            
		            ' Is this a style run?
		            if items(i) isa FTStyleRun then
		              
		              ' Set the misspelled indicator.
		              FTStyleRun(items(i)).changeMisspelledWord(state)
		              
		            end if
		            
		          next
		          
		        end if
		        
		        ' We are done.
		        exit
		        
		      end if
		      
		    end if
		    
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ChangeOpacity(value as double)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim item as FTObject
		  
		  ' Scan the items.
		  for each item in items
		    
		    ' Change the color.
		    item.ChangeOpacity(value )
		    
		  next
		  
		  ' Mark the paragraph as dirty.
		  makeDirty
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ChangeOpacity(startPosition as integer, endPosition as integer, value as double)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim startIndex as integer
		  Dim endIndex as integer
		  
		  ' Get the items to change.
		  if setupChange(startPosition, endPosition, startIndex, endIndex) then
		    
		    ' Change the styles.
		    for i = startIndex to endIndex
		      
		      ' Change the color.
		      items(i).ChangeOpacity( value )
		      
		    next
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeParent(target as FormattedText)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim item as FTObject
		  
		  ' Change the parent.
		  parentControl = target
		  doc = target.getDoc
		  
		  ' Get the number of items.
		  count = getItemCount - 1
		  
		  ' Change all the items.
		  for i = 0 to count
		    
		    ' Get an item.
		    item = getItem(i)
		    
		    ' Change the parent.
		    item.parentControl = parentControl
		    item.doc = doc
		    
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ChangeShadow(mHasShadow As Boolean, col as color, offset as double, blur as Double, opacity as double, angle as double)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim item as FTObject
		  
		  ' Scan the items.
		  for each item in items
		    
		    ' Change the color.
		    item.ChangeShadow(mHasShadow , col , offset , blur,opacity, angle )
		    
		  next
		  
		  ' Mark the paragraph as dirty.
		  makeDirty
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ChangeShadow(startPosition as integer, endPosition as integer, mHasShadow As Boolean, col as color, offset as double, blur as Double, opacity as double, angle as double)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim startIndex as integer
		  Dim endIndex as integer
		  
		  ' Get the items to change.
		  if setupChange(startPosition, endPosition, startIndex, endIndex) then
		    
		    ' Change the styles.
		    for i = startIndex to endIndex
		      
		      ' Change the color.
		      items(i).ChangeShadow(mHasShadow , col , offset , blur, opacity,angle )
		      
		    next
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeSize(size as integer)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim item as FTObject
		  
		  ' Scan the items.
		  for each item in items
		    
		    ' Is this a text run?
		    if item isa FTStyleRun then
		      
		      ' Change the font size.
		      FTStyleRun(item).changeSize(size)
		      
		    end if
		    
		  next
		  
		  ' Mark the paragraph as dirty.
		  makeDirty
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeSize(startPosition as integer, endPosition as integer, size as integer)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim startIndex as integer
		  Dim endIndex as integer
		  
		  ' Get the items to change.
		  if setupChange(startPosition, endPosition, startIndex, endIndex) then
		    
		    ' Change the full styles.
		    for i = startIndex to endIndex
		      
		      ' Is this a style run?
		      if items(i) isa FTStyleRun then
		        
		        ' Change the size.
		        FTStyleRun(items(i)).changeSize(size)
		        
		      end if
		      
		    next
		    
		  end if
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeStyle(style as integer, value as boolean)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim item as FTObject
		  
		  ' Scan the items.
		  for each item in items
		    
		    ' Flip the attribute.
		    item.changeStyle(style, value)
		    
		  next
		  
		  ' Mark the paragraph as dirty.
		  makeDirty
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeStyle(startPosition as integer, endPosition as integer, style as integer, value as boolean)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim startIndex as integer
		  Dim endIndex as integer
		  
		  ' Get the items to change.
		  if setupChange(startPosition, endPosition, startIndex, endIndex) then
		    
		    ' Change the full styles.
		    for i = startIndex to endIndex
		      
		      ' Flip the attribute.
		      items(i).changeStyle(style, value)
		      
		    next
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeToLowerCase()
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim item as FTObject
		  
		  ' Scan the items.
		  for each item in items
		    
		    ' Is this a text run?
		    if item isa FTStyleRun then
		      
		      ' Change to lower case.
		      FTStyleRun(item).changeToLowerCase
		      
		    end if
		    
		  next
		  
		  ' Mark the paragraph as dirty.
		  makeDirty
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeToLowerCase(startPosition as integer, endPosition as integer)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim startIndex as integer
		  Dim endIndex as integer
		  
		  ' Get the items to change.
		  if setupChange(startPosition, endPosition, startIndex, endIndex) then
		    
		    ' Change the full styles.
		    for i = startIndex to endIndex
		      
		      ' Is this a style run?
		      if items(i) isa FTStyleRun then
		        
		        ' Change to lower case.
		        FTStyleRun(items(i)).changeToLowerCase
		        
		      end if
		      
		    next
		    
		  end if
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeToTitleCase()
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim item as FTObject
		  
		  ' Scan the items.
		  for each item in items
		    
		    ' Is this a text run?
		    if item isa FTStyleRun then
		      
		      ' Change to title case.
		      FTStyleRun(item).changeToTitleCase
		      
		    end if
		    
		  next
		  
		  ' Mark the paragraph as dirty.
		  makeDirty
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeToTitleCase(startPosition as integer, endPosition as integer)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim startIndex as integer
		  Dim endIndex as integer
		  Dim fto as FTObject
		  Dim ch as string
		  
		  ' Get the items to change.
		  if setupChange(startPosition, endPosition, startIndex, endIndex) then
		    
		    ' Are at the beginning of the paragraph?
		    if startIndex > 0 then
		      
		      ' Get the previous item.
		      fto = items(startIndex - 1)
		      
		      ' Is the previous itme a style run?
		      if fto isa FTStyleRun then
		        
		        ' Get the last characet of the run.
		        ch = Right(FTStyleRun(fto).getText, 1)
		        
		        ' Change to title case.
		        FTStyleRun(items(startIndex)).changeToTitleCase(ch)
		        
		      else
		        
		        ' Change to title case.
		        FTStyleRun(items(startIndex)).changeToTitleCase
		        
		      end if
		      
		    else
		      
		      ' Change to title case.
		      FTStyleRun(items(startIndex)).changeToTitleCase
		      
		    end if
		    
		    ' Change the full styles.
		    for i = (startIndex + 1) to endIndex
		      
		      ' Is this a style run?
		      if items(i) isa FTStyleRun then
		        
		        ' Change to title case.
		        FTStyleRun(items(i)).changeToTitleCase
		        
		      end if
		      
		    next
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeToUpperCase()
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim item as FTObject
		  
		  ' Scan the items.
		  for each item in items
		    
		    ' Is this a text run?
		    if item isa FTStyleRun then
		      
		      ' Change to upper case.
		      FTStyleRun(item).changeToUpperCase
		      
		    end if
		    
		  next
		  
		  ' Mark the paragraph as dirty.
		  makeDirty
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub changeToUpperCase(startPosition as integer, endPosition as integer)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim startIndex as integer
		  Dim endIndex as integer
		  
		  ' Get the items to change.
		  if setupChange(startPosition, endPosition, startIndex, endIndex) then
		    
		    ' Change the full styles.
		    for i = startIndex to endIndex
		      
		      ' Is this a style run?
		      if items(i) isa FTStyleRun then
		        
		        ' Change to upper case.
		        FTStyleRun(items(i)).changeToUpperCase
		        
		      end if
		      
		    next
		    
		  end if
		  
		  
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
		  
		  Dim item as FTObject
		  Dim newWidth as integer
		  Dim newHeight as integer
		  Dim maxWidth as integer
		  Dim maxHeight as integer
		  
		  ' Get the maximum dimensions.
		  maxWidth = FTUtilities.getScaledLength(doc.getMarginWidth)
		  maxHeight = FTUtilities.getScaledLength(doc.getMarginHeight)
		  
		  ' Scan for oversized pictures.
		  for each item in items
		    
		    ' Is this a picture?
		    if item isa FTPicture then
		      
		      ' Get the current size of the picture.
		      FTPicture(item).getCurrentSize(newWidth, newHeight)
		      
		      ' Does anything need to be done?
		      if (newWidth > maxWidth) or (newHeight > maxHeight) then
		        
		        ' Check the dimensions of the picture.
		        FTPicture(item).checkDimensions(newWidth, newHeight, maxWidth, maxHeight, true)
		        
		        ' Resize the picture.
		        FTPicture(item).setPictureSize(newWidth, newHeight)
		        
		      end if
		      
		    end if
		    
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub clear()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Clear all dependencies and release the memory.
		  clearItems
		  clearProxies
		  clearLines(-1)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub clearItems(startIndex as integer = - 1)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Clear the text holder.
		  currentText = ""
		  currentTextWithPictures = ""
		  
		  ' Is there something to delete?
		  if startIndex < Ubound(items) then
		    
		    ' Release the memory.
		    Redim items(startIndex)
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub clearLines(startingLine as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Check the range.
		  if startingLine < -1 then startingLine = -1
		  
		  ' Clear all dependencies.
		  Redim lines(startingLine)
		  
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
		  
		  Dim item as FTObject
		  
		  ' Clear all the items.
		  for each item in items
		    
		    ' Is this a style run?
		    if item isa FTStyleRun then
		      
		      ' Clear the misspelled indicator.
		      FTStyleRun(item).misspelled = false
		      
		    end if
		    
		  next
		  
		  ' Mark the paragraph as dirty.
		  makeDirty
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub clearProxies(pageIndex as integer = - 1)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim count as integer
		  Dim pp as FTParagraphProxy
		  
		  ' Clear the proxies.
		  for each pp in proxies
		    
		    ' Should we clear this proxy?
		    if pp.getAbsolutePage >= pageIndex then
		      
		      ' Clear the parent link.
		      pp.clear
		      
		      ' Bump up the count.
		      count = count + 1
		      
		    end if
		    
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub clearTabStops()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Will this affect the paragraph.
		  if Ubound(tabStops) > -1 then
		    
		    ' Clear the tab stops.
		    Redim tabStops(-1)
		    
		    ' We will need to add in the default tabstops.
		    addDefaultTabStops = true
		    
		    ' Mark the paragraph as needing updating.
		    makeDirty
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function clone(CreateNewID as boolean = false) As FTParagraph
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim p as FTParagraph
		  
		  ' Create a new paragraph.
		  p = new FTParagraph(parentControl, -1, self)
		  
		  ' Clear out any existing items.
		  p.clearItems
		  
		  ' Copy the base object.
		  Super.copy(p)
		  
		  If CreateNewID = False Then
		    //BK 23Aug2018 - I think this fixes FTDocument.findParagraphPage from not working in an FTIterator class.
		    p.id = Me.id
		  End
		  
		  ' Get the number of items.
		  count = Ubound(items)
		  
		  ' Clone all the items.
		  for i = 0 to count
		    
		    ' Make a clone of the paragraph.
		    p.items.append(items(i).clone)
		    
		  next
		  
		  ' Return the clone.
		  return p
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function clone(startPosition as integer, endPosition as integer) As FTParagraph
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim p as FTParagraph
		  Dim length as integer
		  
		  ' Make a clone.
		  p = clone
		  
		  ' Get the length of the paragraph.
		  length = getLength
		  
		  ' Trim the end position.
		  if endPosition < length then p.deleteSegment(endPosition + 1, length)
		  
		  ' Trim the beginning.
		  if startPosition > 1 then p.deleteSegment(0, startPosition - 1)
		  
		  ' Return the clone.
		  return p
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function cloneItem(item as FTObject) As FTObject
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Is this a picture?
		  if item isa FTPicture then
		    
		    ' Return the original picture.
		    return item
		    
		  end if
		  
		  ' Return the clone.
		  return item.clone
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub composeLines()
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim startOfLine as integer
		  Dim line as FTLine
		  Dim wrapWidth as double
		  Dim lineIndex as integer
		  Dim ignore as integer
		  Dim startIndex as integer
		  
		  ' Is there any work to do?
		  if not dirty then return
		  
		  ' Optimize the paragraph.
		  optimizeParagraph
		  
		  ' Mark it as clean.
		  dirty = false
		  
		  ' Does this paragraph need to be spell checked?
		  if spellingDirty then
		    
		    ' Spell check the paragraph.
		    spellCheckParagraph(false)
		    
		  end if
		  
		  '-------------------------------------------------
		  ' Do some computations.
		  '-------------------------------------------------
		  
		  ' Clear the proxies.
		  clearProxies
		  
		  ' Was a hint given?
		  if characterInsertionPoint = -1 then
		    
		    ' Start with the first line and first character.
		    lineIndex = 0
		    startOfLine = 1
		    
		  else
		    
		    ' Find the starting line to compose.
		    findLine(0, characterInsertionPoint, true, lineIndex, ignore)
		    
		    ' Go back one line.
		    lineIndex = max(lineIndex - 1, 0)
		    
		    ' Start with the first character of the line that needs to be composed.
		    startOfLine = getLineLength(0, lineIndex - 1) + 1
		    
		  end if
		  
		  ' Clear the list of lines.
		  clearLines(lineIndex - 1)
		  
		  ' Update the positions.
		  updatePositions
		  
		  ' Compute the wrap width of the first line.
		  wrapWidth = getFirstLineWidth(1.0)
		  
		  '-------------------------------------------------
		  ' Parse the lines.
		  '-------------------------------------------------
		  
		  ' Are we in single line mode?
		  if parentControl.isSingleViewMode then
		    
		    ' Clear the lines.
		    Redim lines(-1)
		    
		    ' Add the line to the list.
		    lines.Append(parseLine(startOfLine, 0, true))
		    
		  else
		    
		    ' Get the sub-style for the line.
		    line = parseLine(startOfLine, wrapWidth, true)
		    
		    ' Was there anything to parse?
		    if line is nil then
		      
		      ' Add a new line to the list.
		      lines.Append(new FTLine(parentControl, self, 0, getLineSpacing))
		      
		      ' Is there anything to add?
		      if Ubound(items) > -1 then
		        
		        ' Add in the first object from the paragraph.
		        lines(Ubound(lines)).addObject(items(0).clone)
		        
		      end if
		      
		      ' Make sure all the items have the correct decent.
		      lines(Ubound(lines)).computeDecent
		      
		    else
		      
		      ' Compute the wrap width.
		      wrapWidth = getWrapWidth
		      
		      ' Is there something to look at?
		      if wrapWidth <= 0 then return
		      
		      ' Mark the start of the lines to be parsed.
		      startIndex = lineIndex
		      
		      ' Add the lines.
		      while not (line is nil)
		        
		        ' Are we past the end of the lines?
		        if lineIndex > Ubound(lines) then
		          
		          ' Add the line to the list.
		          lines.Append(line)
		          
		        else
		          
		          ' Replace the line in the list.
		          lines(lineIndex) = line
		          
		        end if
		        
		        ' Move to the next line.
		        lineIndex = lineIndex + 1
		        
		        ' Get the sub-style for the line.
		        line = parseLine(startOfLine, wrapWidth, false)
		        
		      wend
		      
		    end if
		    
		  end if
		  
		  '-------------------------------------------------
		  ' Set the line types.
		  '-------------------------------------------------
		  
		  ' Is there only one line?
		  if Ubound(lines) = 0 then
		    
		    ' Mark it as both.
		    lines(0).setLineType(FTLine.Line_Type.Both_First_And_Last, _
		    getBeforeParagraphSpace, getAfterParagraphSpace)
		    
		  else
		    
		    ' Mark the first line.
		    lines(0).setLineType(FTLine.Line_Type.First, getBeforeParagraphSpace, 0)
		    
		    ' Mark the last line.
		    lines(Ubound(lines)).setLineType(FTLine.Line_Type.Last, 0, getAfterParagraphSpace)
		    
		  end if
		  
		  ' Trim the lines.
		  trimLines
		  
		  '-------------------------------------------------
		  ' Clean up.
		  '-------------------------------------------------
		  
		  ' Compute the paragraph height.
		  computeHeight
		  
		  ' Clear the hint.
		  characterInsertionPoint = -1
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub computeHeight()
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim line as FTLine
		  Dim lineHeight as double
		  
		  ' Add in all the line heights.
		  for each line in lines
		    
		    ' Add in the line height.
		    lineHeight = lineHeight + line.getHeight(1.0)
		    
		  next
		  
		  ' Calculate the height.
		  height = getBeforeParagraphSpaceLength + getAfterParagraphSpaceLength + lineHeight
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Constructor()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(parentControl as FormattedText, absoluteIndex as integer, parent as FTParagraph)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set the defaults.
		  pa.alignment = FTParagraph.Alignment_Type.Left
		  pa.lineSpacing = 1.0
		  pa.backgroundColor = &cFFFFFF
		  
		  ' Save the parent control.
		  super.Constructor(parentControl)
		  
		  ' Save the index.
		  setAbsoluteIndex(absoluteIndex)
		  
		  ' Save the ID of the paragraph.
		  me.id = FTUtilities.getNewID
		  
		  ' Add the initial place holder for text.
		  items.Append(new FTStyleRun(parentControl))
		  
		  ' Set the paragraph style.
		  setParagraphStyle(parent.getParagraphStyle)
		  
		  ' Copy over the parent data.
		  copyParagraphStyle(parent)
		  
		  ' Mark the paragraph as dirty.
		  makeDirty
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(parentControl as FormattedText, absoluteIndex as integer, style as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set the defaults.
		  pa.alignment = FTParagraph.Alignment_Type.Left
		  pa.lineSpacing = 1.0
		  pa.backgroundColor = &cFFFFFF
		  
		  ' Save the parent control.
		  super.Constructor(parentControl)
		  
		  ' Save the index.
		  setAbsoluteIndex(absoluteIndex)
		  
		  ' Save the ID of the paragraph.
		  me.id = FTUtilities.getNewID
		  
		  ' Add the initial place holder for text.
		  items.Append(new FTStyleRun(parentControl))
		  
		  ' Set the paragraph style.
		  setParagraphStyle(style)
		  
		  ' Mark the paragraph as dirty.
		  makeDirty
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function containsPicture(pic as FTPicture) As boolean
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim id as integer
		  Dim item as FTObject
		  
		  ' Get the target ID.
		  id = pic.getId
		  
		  ' Scan the paragraph for the picture.
		  for each item in items
		    
		    ' Is this the one we are looking for?
		    if item.getId = id then
		      
		      ' We found it.
		      return true
		      
		    end if
		    
		  next
		  
		  ' Not found.
		  return false
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub copyParagraphStyle(parent as FTParagraph, deepCopy as boolean = true)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  
		  ' Should we update the styles?
		  if deepCopy then
		    
		    ' Copy the style information.
		    setParagraphStyle(parent.getParagraphStyle, false)
		    
		  end if
		  
		  ' Copy over the paragraph attributes.
		  pa = parent.pa
		  
		  ' Get the number of tab stops.
		  count = Ubound(parent.tabStops)
		  
		  ' Resize the tab stops.
		  Redim tabStops(count)
		  
		  ' Clone the tab stops.
		  for i = 0 to count
		    
		    ' Clone the tab stop.
		    tabStops(i) = parent.tabStops(i).clone
		    
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub copyStyleAtOffset(offset as integer, obj as FTStyleRun)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim index as integer
		  Dim ignore as integer
		  
		  ' Get the run item index.
		  findRunItem(offset, index, ignore)
		  
		  ' Is there anything to do?
		  if index = -1 then
		    
		    return
		    
		  end if
		  
		  ' Is the item a text run?
		  if items(index) isa FTStyleRun then
		    
		    ' Copy the style run data.
		    FTStyleRun(items(index)).copyStyleData(obj)
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub deleteCharacter(offset as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim item as FTObject
		  Dim itemIndex as integer
		  
		  ' Range check the offset to be within the paragraph.
		  if offset > getLength then offset = getLength
		  
		  ' The length has changed.
		  length = -1
		  
		  ' Find the item index.
		  itemIndex = findItem(offset)
		  
		  ' Are we passed the end?
		  if itemIndex > Ubound(items) then
		    
		    ' Move to the last one.
		    itemIndex = itemIndex - 1
		    
		  end if
		  
		  ' Get the item.
		  item = items(itemIndex)
		  
		  ' Is this a typed character?
		  if item isa FTStyleRun then
		    
		    ' Delete the text from the paragraph.
		    item.deleteText(offset)
		    
		  else
		    
		    ' Delete the picture.
		    items.Remove(itemIndex)
		    
		  end if
		  
		  ' Mark it for an update.
		  makeDirty
		  
		  ' Mark the paragraph for spell checking.
		  makeSpellingDirty
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub deleteSegment(startOffset as integer, endOffset as integer)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim startIndex as integer
		  Dim endIndex as integer
		  Dim si as integer
		  Dim so as integer
		  Dim ei as integer
		  Dim eo as integer
		  
		  ' Make sure the positions are up to date.
		  updatePositions
		  
		  ' Check the range.
		  if startOffset < 0 then startOffset = 0
		  if endOffset > getLength then endOffset = getLength
		  
		  ' Find the starting and ending positions.
		  findRunItem(startOffset, si, so)
		  findRunItem(endOffset, ei, eo)
		  
		  ' Is there anything to do?
		  if (si = -1) or (ei = -1) then return
		  
		  ' Are we in the same run item?
		  if si = ei then
		    
		    ' Is this a picture or tab?
		    if (items(si) isa FTPicture) or (items(si) isa FTTab) then
		      
		      ' Remove the picture.
		      items.Remove(si)
		      
		    else
		      
		      ' Delete the mid part of the string.
		      items(si).deleteMid(so, eo)
		      
		    end if
		    
		  else
		    
		    ' Is the starting item a style run?
		    if items(si) isa FTStyleRun then
		      
		      ' Delete the text from the first style.
		      items(si).deleteRight(so - 1)
		      
		    else
		      
		      ' Replace it with an empty string.
		      items(si) = new FTStyleRun(parentControl)
		      
		    end if
		    
		    ' Is the ending item a style run?
		    if items(ei) isa FTStyleRun then
		      
		      ' Delete the text from the last style.
		      items(ei).deleteLeft(eo + 1)
		      
		    else
		      
		      ' Replace it with an empty string.
		      items(ei) = new FTStyleRun(parentControl)
		      
		    end if
		    
		    ' Set up the deletes of the full styles.
		    startIndex = si + 1
		    endIndex = ei - 1
		    
		    ' Delete the full styles.
		    for i = endIndex downto startIndex
		      
		      ' Delete the style.
		      items.Remove(i)
		      
		    next
		    
		  end if
		  
		  ' Reset the paragraph.
		  reset
		  
		  ' Is there anything to spellcheck?
		  if getLength = 0 then
		    
		    ' Make sure it is turned off.
		    spellingDirty = false
		    
		  else
		    
		    ' Mark the paragraph for spell checking.
		    makeSpellingDirty
		    
		  end if
		  
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
		  
		  ' Get the number of items.
		  count = Ubound(items)
		  
		  ' Deselect all the pictures.
		  for i = 0 to count
		    
		    ' Is this a picture?
		    if items(i) isa FTPicture then
		      
		      ' Is the picture in the resize mode?
		      if FTPicture(items(i)).isResizeMode then
		        
		        ' Clear the resize handles.
		        FTPicture(items(i)).setResizeMode(false)
		        
		      end if
		      
		    end if
		    
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
		  
		  const LINE_SEPARATOR = "---------------------------------------"
		  
		  ' Get the paragraph information.
		  sa.Append(LINE_SEPARATOR)
		  sa.Append("Paragraph index: " + str(absoluteIndex))
		  sa.Append(LINE_SEPARATOR)
		  sa.Append("")
		  
		  ' Get the number of runs.
		  count = Ubound(items)
		  
		  ' Get all the information on each style run.
		  for i = 0 to count
		    
		    ' Get the style run information.
		    items(i).dump(sa)
		    
		  next
		  
		  ' Blank line.
		  sa.Append("")
		  
		  ' Return the paragraph information.
		  return join(sa, EndOfLine)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function dumpLines() As string
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim sa() as string
		  
		  const LINE_SEPARATOR = "---------------------------------------"
		  
		  ' Get the paragraph information.
		  sa.Append(LINE_SEPARATOR)
		  sa.Append("Paragraph index: " + str(absoluteIndex))
		  sa.Append(LINE_SEPARATOR)
		  sa.Append("")
		  
		  ' Get the number of runs.
		  count = Ubound(lines)
		  
		  ' Get all the information on each style run.
		  for i = 0 to count
		    
		    sa.Append("----------------")
		    sa.Append("Line index: " + str(i))
		    sa.Append("----------------")
		    sa.Append("")
		    
		    ' Get the style run information.
		    lines(i).dumpRuns(sa)
		    
		  next
		  
		  ' Blank line.
		  sa.Append("")
		  
		  ' Return the paragraph information.
		  return join(sa, EndOfLine)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function findAndSplitSegment(offset as integer) As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim startIndex as integer
		  Dim startOffset as integer
		  
		  ' Find the spot in the paragraph.
		  findRunItem(offset, startIndex, startOffset)
		  
		  ' Are we past the end?
		  if startIndex = -1 then return Ubound(items) + 1
		  
		  ' Split the segment.
		  splitItem(startIndex, startOffset)
		  
		  ' Return the insertion position.
		  return startIndex + 1
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub findEndPosition(startIndex as integer, startOffset as integer, ByRef endIndex as integer, ByRef endOffset as integer, width as double)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim lastWidth as double
		  Dim currentWidth as double
		  Dim fto as FTObject
		  
		  '-------------------------------------------
		  ' Check the first one.
		  '-------------------------------------------
		  
		  ' Get the starting object.
		  fto = items(startIndex)
		  
		  ' Get the width of the first object.
		  currentWidth = fto.getWidth(startOffSet, fto.getLength, 1.0, 0)
		  
		  ' Do we have enough for a line?
		  if currentWidth >= width then
		    
		    ' Is this a picture that is really big?
		    if fto isa FTPicture then
		      
		      ' Just use the picture.
		      endIndex = startIndex
		      endOffset = startIndex + 1
		      
		    else
		      
		      ' Set the ending offset.
		      endIndex = startIndex
		      endOffset = fto.seekEndPosition(startOffset, width)
		      
		    end if
		    
		    ' We are done.
		    return
		    
		  end if
		  
		  '-------------------------------------------
		  ' Look for the end of the line.
		  '-------------------------------------------
		  
		  ' Make it zero based.
		  count = getItemCount - 1
		  
		  ' Move to the next index.
		  startIndex = startIndex + 1
		  
		  ' Search for the end position of the line.
		  for i = startIndex to count
		    
		    ' Get the starting object.
		    fto = items(i)
		    
		    ' Save the last current width.
		    lastWidth = currentWidth
		    
		    ' Get the width of this object.
		    currentWidth = currentWidth + fto.getWidth(1.0, currentWidth)
		    
		    ' Is the segment long enough?
		    if currentWidth >= width then
		      
		      ' Save the FTObject index.
		      endIndex = i
		      
		      ' Did we find an exact match?
		      if currentWidth = width then
		        
		        ' Use the length.
		        endOffset = fto.getLength
		        
		      else
		        
		        ' Find the last character position.
		        endOffset = fto.seekEndPosition(1, width - lastWidth)
		        
		        ' Should we move back one item?
		        if endOffset = 0 then
		          
		          ' Move to the previous item.
		          endIndex = endIndex - 1
		          endOffset = items(endIndex).getLength
		          
		        end if
		        
		      end if
		      
		      ' We are done.
		      return
		      
		    end if
		    
		  next
		  
		  '-------------------------------------------
		  ' Use the end of the paragraph.
		  '-------------------------------------------
		  
		  ' Use the end of the paragraph.
		  endIndex = count
		  endOffset = items(count).getLength
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function findItem(offset as integer, useEmpties as boolean = false) As integer
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  
		  ' Get the number of items.
		  count = Ubound(items)
		  
		  ' Is there anything to look at?
		  if count = -1 then return -1
		  
		  ' Are we at the end?
		  if offset > items(count).getEndPosition then
		    
		    ' Move beyond the end.
		    return count + 1
		    
		  end if
		  
		  ' Do we need to consider the empty style runs?
		  if useEmpties then
		    
		    ' Scan the items.
		    for i = count downto 0
		      
		      ' Are we within this object?
		      if (items(i).getLength = 0) and (offset = items(i).getEndPosition) then
		        
		        ' Return the object index.
		        return i
		        
		      end if
		      
		      ' Are we within this object?
		      if (offset >= items(i).getStartPosition) and _
		        (offset <= items(i).getEndPosition) then
		        
		        ' Return the object index.
		        return i
		        
		      end if
		      
		    next
		    
		  else
		    
		    ' Scan the items.
		    for i = count downto 0
		      
		      ' Are we within this object?
		      if (offset >= items(i).getStartPosition) and _
		        (offset <= items(i).getEndPosition) then
		        
		        ' Return the object index.
		        return i
		        
		      end if
		      
		    next
		    
		  end if
		  
		  ' Put it at the beginning.
		  return 0
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function findItemReverse(offset as integer, useEmpties as boolean = false) As integer
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  
		  ' Get the number of items.
		  count = Ubound(items)
		  
		  ' Is there anything to look at?
		  if count = -1 then return -1
		  
		  ' Are we at the beginning?
		  if offset < items(0).getStartPosition then
		    
		    ' Move beyond the beginning.
		    return 0
		    
		  end if
		  
		  ' Do we need to consider the empty style runs?
		  if useEmpties then
		    break//not implement yet!!!
		    ' Scan the items.
		    for i = count downto 0
		      
		      ' Are we within this object?
		      if (items(i).getLength = 0) and (offset = items(i).getEndPosition) then
		        
		        ' Return the object index.
		        return i
		        
		      end if
		      
		      ' Are we within this object?
		      if (offset >= items(i).getStartPosition) and _
		        (offset <= items(i).getEndPosition) then
		        
		        ' Return the object index.
		        return i
		        
		      end if
		      
		    next
		    
		  else
		    
		    ' Scan the items.
		    for i = count DownTo 0
		      
		      ' Are we within this object?
		      if (offset >= items(i).getStartPosition) and _
		        (offset <= items(i).getEndPosition) then
		        
		        ' Return the object index.
		        return i
		        
		      end if
		      
		    next
		    
		  end if
		  
		  ' Put it at the beginning.
		  return 0//not changed!!!
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub findLine(lineStart as integer, offset as integer, bias as boolean, ByRef lineIndex as integer, ByRef offsetIndex as integer)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim startOffset as integer
		  Dim endOffset as integer
		  
		  ' Get the number of lines.
		  count = Ubound(lines)
		  
		  ' Scan the lines.
		  for i = lineStart to count
		    
		    ' Extract the line paragraph offsets.
		    startOffset = lines(i).getParagraphOffset - 1
		    endOffset = startOffset + lines(i).getLength
		    
		    ' Is the offset within this line?
		    if (offset >= startOffset) and (offset <= endOffset) then
		      
		      ' Are we at the beginning of the next line?
		      if (offset = endOffset) and bias then
		        
		        ' Move to the next line.
		        i = Min(i + 1, count)
		        
		      end if
		      
		      ' Return the current line.
		      lineIndex = i
		      offsetIndex = offset - startOffset
		      
		      ' We are done.
		      return
		      
		    end if
		    
		  next
		  
		  ' Is there anything to look at?
		  if count < 0 then
		    
		    ' Use the beginning of the line.
		    lineIndex = 0
		    offsetIndex = 0
		    
		  else
		    
		    ' Return the last line and offset to the end of the line.
		    lineIndex = count
		    offsetIndex = lines(lineIndex).getLength
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function findOffsetInLine(line as integer, pixelOffset as integer, scale as double) As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the offset into the line.
		  return lines(line).findOffset(pixelOffset, scale)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function findOffsetOfPicture(p as FTPicture) As integer
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  
		  ' Get the number of items.
		  count = Ubound(items)
		  
		  ' Scan the items.
		  for i = 0 to count
		    
		    ' Is this the picture?
		    if items(i) = p then
		      
		      ' Return the picture offset.
		      return items(i).getStartPosition
		      
		    end if
		    
		  next
		  
		  ' Not found.
		  return -1
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function findPictureItem(offset as integer) As integer
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim endOffset as integer
		  
		  ' Get the number of items.
		  count = Ubound(items)
		  
		  ' Scan the items.
		  for i = 0 to count
		    
		    ' Get the end offset of the item.
		    endOffset = items(i).getEndPosition
		    
		    ' Are we within this object?
		    if offset <= endOffset then
		      
		      ' Return the object index.
		      return i
		      
		    end if
		    
		  next
		  
		  ' Put it at the end.
		  return count + 1
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function findPictureItem(x as integer, y as integer) As FTPicture
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim pic as FTPicture
		  Dim pageX as integer
		  Dim pageY as integer
		  Dim ignore as integer
		  
		  ' Get the number of items.
		  count = Ubound(items)
		  
		  ' Scan the items.
		  for i = 0 to count
		    
		    ' Is this a picture?
		    if items(i) isa FTPicture then
		      
		      ' Type cast the object.
		      pic = FTPicture(items(i))
		      
		      ' Get the last drawn coordinates.
		      pic.getLastDrawnCoordinates(ignore, pageX, pageY)
		      
		      ' Are we in a non-page mode?
		      if not (parentControl.isPageViewMode) then
		        
		        ' Adjust the page coorninates for the scroll position.
		        pageX = pageX - parentControl.getXDisplayPosition
		        pageY = pageY - parentControl.getYDisplayPosition
		        
		      end if
		      
		      ' Adjust the coordinates for the picture offset.
		      x = x - pageX
		      y = y - (pageY - pic.getHeight(parentControl.getDisplayScale))
		      
		      ' Is the point within the picture?
		      if pic.isPointWithin(x, y) then return pic
		      
		    end if
		    
		  next
		  
		  ' Not found.
		  return nil
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub findRunItem(startPosition as integer, ByRef startIndex as integer, ByRef startOffset as integer)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim fto as FTObject
		  
		  ' Are we at the beginning?
		  if startPosition <= 0 then
		    
		    ' Use the starting position.
		    startIndex = 0
		    startOffset = 0
		    
		    ' We are done.
		    return
		    
		  end if
		  
		  ' Make it zero based.
		  count = getItemCount - 1
		  
		  ' Was there only one item?
		  if count = 0 then
		    
		    ' Does it have anything in it?
		    if getItem(0).getLength = 0 then
		      
		      ' It is past the end.
		      startIndex = -1
		      startOffset = -1
		      
		      ' We are done.
		      return
		      
		    end if
		    
		  end if
		  
		  ' Search for the starting and ending runs.
		  for i = 0 to count
		    
		    ' Get an object.
		    fto = getItem(i)
		    
		    ' Is the character position in the range of this run?
		    if (startPosition >= fto.getStartPosition) and _
		      (startPosition <= fto.getEndPosition) then
		      
		      ' Save the starting object index.
		      startIndex = i
		      
		      ' Compute the offset into the object.
		      startOffset = startPosition - fto.getStartPosition + 1
		      
		      ' We are done.
		      return
		      
		    end if
		    
		  next
		  
		  ' It is past the end.
		  startIndex = -1
		  startOffset = -1
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function findTabStop(offset as double) As double
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim tabLength as double
		  Dim ts() as FTTabStop
		  
		  ' Get the tab stops for the paragraph.
		  ts = getTabStops
		  
		  ' Get the number of tab stops.
		  count = Ubound(ts)
		  
		  ' Find the tab stop that fits.
		  for i = 0 to count
		    
		    ' Get the length of the tab.
		    tabLength = FTUtilities.getScaledLength(ts(i).getTabStop, 1.0)
		    
		    ' Is the tab stop greater than the width?
		    if tabLength > offset then
		      
		      ' Return the tab offset.
		      return ts(i).getTabStop
		      
		    end if
		    
		  next
		  
		  ' Unknown position.
		  return doc.getMarginWidth
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function findTabStopLeader(offset as double) As FTTab.Tab_Leader_Type
		  #Pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim tabLength as double
		  Dim ts() as FTTabStop
		  
		  ' Get the tab stops for the paragraph.
		  ts = getTabStops
		  
		  ' Get the number of tab stops.
		  count = Ubound(ts)
		  
		  ' Find the tab stop that fits.
		  for i = 0 to count
		    
		    ' Get the length of the tab.
		    tabLength = FTUtilities.getScaledLength(ts(i).getTabStop, 1.0)
		    
		    ' Is the tab stop greater than the width?
		    if tabLength > offset then
		      
		      ' Return the tab offset.
		      Return ts(i).getTabLeader
		      
		    end if
		    
		  next
		  
		  ' Unknown position.
		  Return FTTab.Tab_Leader_Type.None
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getAbsoluteIndex() As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the paragraph index.
		  return absoluteIndex
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getAfterParagraphSpace() As double
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Get the after paragraph space.
		  return pa.afterParagraphSpace
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getAfterParagraphSpaceLength() As double
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Has the value been calculated?
		  if afterParagraphSpaceCache = -1 then
		    
		    ' Calculate the value.
		    afterParagraphSpaceCache = FTUtilities.getScaledLength(pa.afterParagraphSpace, 1.0)
		    
		  end if
		  
		  ' Return the after paragraph space.
		  return afterParagraphSpaceCache
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getAlignment() As Alignment_Type
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the alignment.
		  return pa.alignment
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function GetAlignmentFromValue(value as Integer) As Alignment_Type
		  Select Case value
		  Case 1
		    Return Alignment_Type.Left
		  Case 2
		    Return Alignment_Type.Center
		  Case 3
		    Return Alignment_Type.Right
		  Case Else
		    Return Alignment_Type.None
		  end
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getBackgroundColor() As Color
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the background color.
		  // Mantis 3637: FTCParagraphStyle.backgroundColor won’t set correctly
		  Dim style As FTParagraphStyle = doc.getParagraphStyle(getParagraphStyle)
		  
		  ' Check for global Style Definition
		  If style.isBackgroundColorDefined Then
		    
		    ' Check for local Background Color (global Background Color was overriden)
		    If pa.backgroundColor <> &cFFFFFF00 And pa.backgroundColor <> style.getBackgroundColor Then
		      
		      ' Return local Background Color
		      Return pa.backgroundColor
		      
		    Else
		      
		      ' Return global Background Color
		      Return style.getBackgroundColor
		      
		    End If
		    
		  Else
		    
		    ' If there was no global Background Color defined, return local Background Color
		    Return pa.backgroundColor
		    
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getBaseLineOffset(lineStart as integer, lineEnd as integer) As double
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim height as double
		  Dim scale as double
		  
		  ' Get the scale.
		  scale = parentControl.getDisplayScale
		  
		  ' Compute the distance to the baseline.
		  for i = lineStart to lineEnd
		    
		    ' Add in the previous line's decent and the current ascent.
		    height = height + lines(i - 1).getDescent + lines(i).getAscent
		    
		  next
		  
		  ' Return the base line height.
		  return height * scale
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getBeforeParagraphSpace() As double
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Get the before paragraph space.
		  return pa.beforeParagraphSpace
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getBeforeParagraphSpaceLength() As double
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Has the value been calculated?
		  if beforeParagraphSpaceCache = -1 then
		    
		    ' Calculate the value.
		    beforeParagraphSpaceCache = FTUtilities.getScaledLength(pa.beforeParagraphSpace, 1.0)
		    
		  end if
		  
		  ' Return the before paragraph space.
		  return beforeParagraphSpaceCache
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getCaretOffset(offset as integer, bias as boolean) As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim line as integer
		  Dim lineOffset as integer
		  
		  ' Find the line and offset into the line.
		  findLine(0, offset, bias, line, lineOffset)
		  
		  ' Return the caret offset into the line.
		  return lines(line).getOffsetWidth(lineOffset, parentControl.getDisplayScale)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getFirstIndent() As double
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the first indent.
		  return pa.firstIndent
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getFirstIndentWidth(scale as double) As double
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Compute the first indent in pixels.
		  return FTUtilities.getScaledLength(pa.firstIndent, scale)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getFirstLineWidth(scale as double) As double
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Compute the first line wrap width.
		  return FTUtilities.getScaledLength _
		  (parentControl.getDoc.getMarginWidth - pa.leftMargin - _
		  pa.rightMargin - pa.firstIndent, scale)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getFirstProxyPage() As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the first page.
		  return proxies(0).getPage
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getHeight(includeBeforeSpace as boolean) As double
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Should we include the before space?
		  if includeBeforeSpace then
		    
		    ' Return the height of the paragraph.
		    return height
		    
		  else
		    
		    ' Return the height without the before space.
		    return height - getBeforeParagraphSpaceLength
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getHeight(includeBeforeSpace as boolean, lineStart as integer, lineEnd as integer, scale as double) As double
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim sumHeight as double
		  Dim lastLine as integer
		  
		  ' Are we at the starting line?
		  if lineEnd < lineStart then
		    
		    return 0
		    
		  end if
		  
		  ' Should we include the space before the paragraph?
		  if includeBeforeSpace then
		    
		    ' Add in the space before the paragraph.
		    sumHeight = FTUtilities.getScaledLength(pa.beforeParagraphSpace, 1.0)
		    
		  end if
		  
		  ' Get the upper bound.
		  lastLine = Ubound(lines)
		  
		  ' Get the total height of the lines.
		  for i = lineStart to lineEnd
		    
		    ' Is there anything to do?
		    if i > lastLine then exit
		    
		    ' Add in the line height.
		    sumHeight = sumHeight + lines(i).getHeight
		    
		  next
		  
		  ' Are we at the end of the paragraph?
		  if lineEnd = Ubound(lines) then
		    
		    ' Add in the after paragraph space.
		    sumHeight = sumHeight + FTUtilities.getScaledLength(pa.afterParagraphSpace, 1.0)
		    
		  end if
		  
		  ' Return the height of the lines.
		  return (sumHeight * scale)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getId() As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the ID for the paragraph.
		  return id
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub getIndexOffsetFromPosition(position as integer, ByRef index as integer, ByRef offset as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Get the item's index.
		  index = findItem(position)
		  
		  ' Did we find a valid index?
		  if index > Ubound(items) then
		    
		    ' Nothing found.
		    index = -1
		    offset = -1
		    
		  else
		    
		    ' Compute the offset into the item.
		    offset = position - items(index).getStartPosition + 1
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getInsertionLine(offset as integer, bias as boolean, ByRef lineOffset as integer) As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim lineIndex as integer
		  
		  ' Look for the line.
		  findLine(0, offset, bias, lineIndex, lineOffset)
		  
		  ' Return the line.
		  return lineIndex
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub getInsertionPoint(lineStart as integer, insertionPoint as FTInsertionPoint, ByRef x as double, ByRef y as double, ByRef ascent as double, ByRef descent as double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim lineIndex as integer
		  Dim offsetIndex as integer
		  Dim line as FTLine
		  Dim scale as double
		  
		  ' Is there anything to look at?
		  if Ubound(lines) = -1 then return
		  
		  ' Get the scale.
		  scale = parentControl.getDisplayScale
		  
		  ' Locate the line and offset.
		  findLine(lineStart, insertionPoint.getOffset.offset, insertionPoint.getOffset.bias, lineIndex, offsetIndex)
		  
		  ' Get the line.
		  line = lines(lineIndex)
		  
		  ' Should we favor the beginning of the line?
		  if not insertionPoint.getBias then
		    
		    ' Compute the horizontal position of the caret.
		    x = line.getOffsetWidth(offsetIndex, scale)
		    
		  end if
		  
		  ' Calculate the vertical position of the caret.
		  y = lines(lineIndex).getYPos - lines(lineStart).getYPos
		  
		  ' only adjust the y offset for the insertion if we aren't in the first paragraph
		  Dim IsFirstParagraphOnPage As Boolean = insertionPoint.getCurrentProxyParagraph.isFirstParagraphOnPage
		  
		  If IsFirstParagraphOnPage = False Then
		    
		    //Issue 3760: Wrong Caret Position in FTParagraph with Before/After Space if Zoom > 1.0
		    y = y + (getBeforeParagraphSpaceLength * scale)
		    
		  end if
		  
		  ' Do we need to make an adjustment for the line alignment?
		  select case pa.alignment
		    
		  Case FTParagraph.Alignment_Type.Left
		    
		    ' Is this the first line?
		    if lineIndex = 0 then
		      
		      ' Add in the offset with the indent.
		      x = x + getFirstIndentWidth(scale)
		      
		    end if
		    
		  case FTParagraph.Alignment_Type.Center
		    
		    ' Is this the first line?
		    if lineIndex = 0 then
		      
		      ' Add in the offset with the indent.
		      x = x + getFirstIndentWidth(scale) + _
		      Round((getFirstLineWidth(scale) - line.getWidth(scale)) / 2)
		      
		    else
		      
		      ' Add in the offset for center alignment.
		      x = x + Round(((getWrapWidth * scale) - line.getWidth(scale)) / 2)
		      
		    end if
		    
		  case FTParagraph.Alignment_Type.Right
		    
		    ' Add in the offset for right alignment.
		    x = x + (Round(getWrapWidth * scale) - line.getWidth(scale))
		    
		  end select
		  
		  ' Get the line height.
		  ascent = line.getOffsetAscent(offsetIndex, scale)
		  descent = line.getOffsetDecent(offsetIndex, scale)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getItem(index as integer) As FTObject
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Are we in range.
		  if (index >= 0) and (index <= Ubound(items)) then
		    
		    ' Return the specified FTObject.
		    return items(index)
		    
		  end if
		  
		  ' We are out of range.
		  return nil
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getItemCount() As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the number of FTObjects.
		  return Ubound(items) + 1
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getLastProxyPage() As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the last page.
		  return proxies(Ubound(proxies)).getPage
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getLeftMargin() As double
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the left margin.
		  return pa.leftMargin
		  
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
		  return FTUtilities.getScaledLength(pa.leftMargin, 1.0)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getLeftOvers(startIndex as integer) As FTObject()
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim startRun as integer
		  Dim startOffset as integer
		  Dim obj as FTObject
		  Dim objs() as FTObject
		  
		  ' Find the starting item and offset.
		  findRunItem(startIndex, startRun, startOffset)
		  
		  ' Are there any left overs?
		  if startRun = -1 then
		    
		    ' Is it a style run?
		    if items(Ubound(items)) isa FTStyleRun then
		      
		      ' Make a clone of the last item.
		      obj = items(Ubound(items)).clone
		      
		      ' Clear the text.
		      FTStyleRun(obj).setText("", 0)
		      
		    else
		      
		      ' Create a new style.
		      obj = new FTStyleRun(parentControl)
		      
		    end if
		    
		    ' Add the item to the list.
		    objs.append(obj)
		    
		    ' Return the object.
		    return objs
		    
		  end if
		  
		  ' Is this a piece of text?
		  if Items(startRun) isa FTStyleRun then
		    
		    ' Do we need to include the style of the previous run?
		    if (startRun > 0) and (startOffset = 1) then
		      
		      ' Is the previous item a style run?
		      if Items(startRun - 1) isa FTStyleRun then
		        
		        ' Clone the previous item.
		        obj = Items(startRun - 1).clone
		        
		        ' Clear the text.
		        FTStyleRun(obj).setText("", 0)
		        
		        ' Add the item to the list.
		        objs.append(obj)
		        
		      end if
		      
		    end if
		    
		    ' Clone the item.
		    obj = Items(startRun).clone
		    
		    ' Delete the left overs from the original.
		    Items(startRun).deleteRight(startOffset - 1)
		    
		    ' Delete the original from the left over.
		    obj.deleteLeft(startOffset)
		    
		  else
		    
		    ' Get the object.
		    obj = Items(startRun)
		    
		    ' Remove it from the original paragraph.
		    Items.Remove(startRun)
		    
		  end if
		  
		  ' Add the item to the list.
		  objs.append(obj)
		  
		  ' Move to the first full item to be copied over.
		  startRun = StartRun + 1
		  
		  ' Get the total number of items.
		  count = Ubound(items)
		  
		  ' Copy over the full items.
		  for i = startRun to count
		    
		    ' Add the full items to the list.
		    objs.append(items(i))
		    
		  next
		  
		  ' Chop off the excess items.
		  clearItems(startRun - 1)
		  
		  ' Mark this paragraph for updating.
		  makeDirty
		  
		  ' Return the objects.
		  return objs
		  
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
		  
		  Dim i as integer
		  Dim count as integer
		  
		  ' Has the paragraph changed?
		  if length = -1 then
		    
		    ' Reset the length.
		    length = 0
		    
		    ' Get the number of paragraphs.
		    count = Ubound(items)
		    
		    ' Add up all the lengths.
		    for i = 0 to count
		      
		      ' Add in the paragraph length.
		      length = length + items(i).getLength
		      
		    next
		    
		  end if
		  
		  ' Return the total length.
		  return length
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getLine(index as integer) As FTLine
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Are we in range?
		  if (index >= 0) and (index <= Ubound(lines)) then
		    
		    ' Return the specified line.
		    return lines(index)
		    
		  end if
		  
		  ' Line not found.
		  return nil
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getLineCount() As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the number of lines.
		  return Ubound(lines) + 1
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getLineLength(startLine as integer, endLine as integer) As integer
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim sum as integer
		  
		  ' Get the number of paragraphs.
		  count = Ubound(lines)
		  
		  ' Add up all the lengths.
		  for i = startLine to endLine
		    
		    ' Add in the paragraph length.
		    sum = sum + lines(i).getLength
		    
		  next
		  
		  ' Return the total length.
		  return sum
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getLineSpacing() As double
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the line spacing.
		  return pa.lineSpacing
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getPageBreak() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the page break state.
		  return pa.pageBreak
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getParagraphAttributes() As ParagraphAttributes
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the attributes.
		  return pa
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getParagraphStyle() As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the paragraph style.
		  return pa.paragraphStyle
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getPosition(index as integer, offset as integer) As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the position in the paragraph.
		  return getItem(index).getStartPosition + offset - 1
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getProxy(startLine as integer, height as integer, includeBeforeSpace as boolean, compositionPosition as double) As FTParagraphProxy
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim endLine as integer
		  Dim currentHeight as integer
		  Dim scale as double
		  
		  ' Is there anything to get?
		  if Ubound(proxies) = -1 then return nil
		  
		  ' Get the scale.
		  scale = parentControl.getDisplayScale
		  
		  ' Is this an impossible situation?
		  if height <= 0 then
		    
		    ' There is nothing to do.
		    return nil
		    
		  end if
		  
		  ' Is this the start of the paragraph and should we include the before space?
		  if (startLine = 0) and includeBeforeSpace then
		    
		    ' Add in the before space.
		    currentHeight = (lines(startLine).getHeight * scale) + getBeforeParagraphSpaceLength
		    
		  else
		    
		    ' Just use the line height.
		    currentHeight = lines(startLine).getHeight * scale
		    
		  end if
		  
		  ' Will the starting line fit?
		  if currentHeight > height then
		    
		    ' It will not fit.
		    return nil
		    
		  end if
		  
		  ' Get the number lines.
		  count = Ubound(lines)
		  
		  ' Assume only one line found.
		  endLine = -1
		  
		  ' Search for the end line.
		  for i = (startLine + 1) to count
		    
		    ' Get the height of the first line.
		    currentHeight = currentHeight + lines(i).getHeight * scale
		    
		    ' Have we exceeded the height?
		    if currentHeight >= height then
		      
		      ' Set the end line.
		      endLine = i - 1
		      
		      ' We are done.
		      exit
		      
		    end if
		    
		  next
		  
		  ' Return the proxy.
		  return new FTParagraphProxy(parentControl, self, -1, startLine, endLine, compositionPosition)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getProxyById(id as integer) As FTParagraphProxy
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim pp as FTParagraphProxy
		  
		  ' Scan the proxies.
		  for each pp in proxies
		    
		    ' Did we find it?
		    if pp.getProxyId = id then return pp
		    
		  next
		  
		  ' Not found.
		  return nil
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getProxyItem(index as integer) As FTParagraphProxy
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the proxy.
		  return proxies(index)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getProxyItemCount() As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the number of proxies.
		  return Ubound(proxies) + 1
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getProxyLines(height as integer, ByRef startLine as integer, ByRef endLine as integer, clear as boolean) As boolean
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim currentHeight as double
		  
		  ' Do we need to clear the proxies?
		  if clear then clearProxies
		  
		  ' Get the number of lines.
		  count = Ubound(lines)
		  
		  ' Are there any proxies?
		  if Ubound(proxies) > -1 then
		    
		    ' Get the next starting line.
		    startLine = proxies(Ubound(proxies)).getLineEnd + 1
		    
		  else
		    
		    ' Start with the first line.
		    startLine = 0
		    
		  end if
		  
		  ' Do we have a valid proxy?
		  if startLine > count then return false
		  
		  ' Use the rest of the paragraph.
		  endLine = count
		  
		  ' Get the end line.
		  for i = startLine to count
		    
		    ' Add in the next line height.
		    currentHeight = currentHeight + lines(i).getLineHeight(true, 1.0)
		    
		    ' Have we reached the specified height?
		    if currentHeight >= height then
		      
		      ' Will the first line fit?
		      if i = startLine then return false
		      
		      ' Save the end line.
		      endLine = i - 1
		      
		      ' We are done.
		      return true
		      
		    end if
		    
		  next
		  
		  ' Do we have a valid proxy?
		  if endLine < startLine then return false
		  
		  ' Make sure we are in range.
		  endLine = Min(endLine, count)
		  
		  ' It fits.
		  return true
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getRightMargin() As double
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the right margin.
		  return pa.rightMargin
		  
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
		  return FTUtilities.getScaledLength(pa.rightMargin, 1.0)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub getRTF(rtf as RTFWriter)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim style as FTParagraphStyle
		  Dim sr as FTStyleRun
		  
		  ' Create a new paragraph.
		  rtf.newParagraph
		  
		  ' Should we set a page break?
		  if pa.pageBreak then rtf.setPageBreak
		  
		  ' Was a non default style used?
		  if pa.paragraphStyle > 0 then
		    
		    ' Get the paragraph style.
		    style = parentControl.getDoc.getParagraphStyle(pa.paragraphStyle)
		    
		    ' Add the paragraph style.
		    if not (style is nil) then rtf.setParagraphStyle(style.getStyleName)
		    
		  end if
		  
		  ' Set the paragraph alignment.
		  select case pa.alignment
		    
		  Case FTParagraph.Alignment_Type.Left
		    
		    rtf.setAlignment(RTFAlignment.ALIGN_LEFT)
		    
		  Case FTParagraph.Alignment_Type.Center
		    
		    rtf.setAlignment(RTFAlignment.ALIGN_CENTER)
		    
		  case FTParagraph.Alignment_Type.Right
		    
		    rtf.setAlignment(RTFAlignment.ALIGN_RIGHT)
		    
		  end select
		  
		  ' Set the paragraph spacing.
		  rtf.setBeforeSpace(pa.beforeParagraphSpace)
		  rtf.setAfterSpace(pa.afterParagraphSpace)
		  rtf.setLineSpacing(pa.LineSpacing)
		  
		  ' Set the margins.
		  rtf.setLeftMargin(pa.leftMargin)
		  rtf.setRightMargin(pa.rightMargin)
		  rtf.setFirstIndent(pa.firstIndent)
		  
		  ' Set the paragraph background color.
		  rtf.setParagraphBackgroundColor(pa.backgroundColor)
		  
		  ' Get the number of items.
		  count = Ubound(tabStops)
		  
		  ' Encode all the tab stops.
		  For i = 0 To count
		    
		    ' Encode the tab stop
		    If tabStops(i).default = False Then 
		      ' Encode the tab stop 
		      rtf.addTabStop(Integer(tabStops(i).GetTabLeader), tabStops(i).getTabStop)
		    End If
		    
		  Next
		  
		  ' Is this an emmpty paragraph?
		  if getLength = 0 then
		    
		    ' Get the first style run.
		    sr = FTStyleRun(items(0))
		    
		    ' Set the basic style attributes.
		    rtf.setFont(sr.font)
		    rtf.setFontSize(sr.fontSize)
		    if sr.bold then rtf.setBold
		    if sr.italic then rtf.setItalic
		    if sr.strikeThrough then rtf.setStrikeThrough
		    if sr.underline then rtf.setUnderline
		    
		    If sr.hasShadow Then
		      
		      rtf.setShadow
		      rtf.setShadowBlur(sr.shadowBlur)
		      rtf.setShadowColor(sr.shadowColor)
		      rtf.setShadowOffset(sr.shadowOffset)
		      rtf.setShadowOpacity(sr.shadowOpacity)
		      
		    End If
		    
		    
		    ' Is the sub or super script been applied?
		    if sr.scriptLevel <> 0 then
		      
		      ' Is this a subscript?
		      if sr.scriptLevel < 0 then
		        
		        ' Subscript.
		        rtf.setSubscript(sr.fontSize)
		        
		      else
		        
		        ' Superscript.
		        rtf.setSuperscript(sr.fontSize)
		        
		      end if
		      
		    end if
		    
		  end if
		  
		  ' Get the number of items.
		  count = Ubound(items)
		  
		  ' Encode all the subruns.
		  for i = 0 to count
		    
		    ' Encode the sub run.
		    items(i).getRTF(rtf)
		    
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getSelectionEndOffset() As integer
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim endIndex as integer
		  Dim delta as integer
		  Dim ignore as integer
		  
		  ' Get the number of items.
		  count = Ubound(items)
		  
		  ' Scan the items for a selection.
		  for i = count downto 0
		    
		    ' Is something selected?
		    if items(i).isSelected then
		      
		      ' Get the selected range of the item.
		      items(i).getSelection(ignore, endIndex)
		      
		      ' Add in the delta.
		      delta = delta + (items(i).getLength - endIndex)
		      
		      ' We are done looking.
		      exit
		      
		    else
		      
		      ' Add in the length of the item.
		      delta = delta + items(i).getLength
		      
		    end if
		    
		  next
		  
		  ' Return the offset.
		  return getLength - delta
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getSelectionStartOffset() As integer
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim offset as integer
		  Dim startIndex as integer
		  Dim ignore as integer
		  
		  ' Get the number of items.
		  count = Ubound(items)
		  
		  ' Scan the items for a selection.
		  for i = 0 to count
		    
		    ' Is something selected?
		    if items(i).isSelected then
		      
		      ' Get the selected range of the item.
		      items(i).getSelection(startIndex, ignore)
		      
		      ' Add in the offset.
		      offset = offset + startIndex - 1
		      
		      ' We are done looking.
		      exit
		      
		    else
		      
		      ' Add in the length of the item.
		      offset = offset + items(i).getLength
		      
		    end if
		    
		  next
		  
		  ' Return the offset.
		  return offset
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getSingleLineWidth() As double
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim item as FTObject
		  
		  ' Has it been calculated?
		  if singleLineWidth < 0 then
		    
		    ' Clear the length.
		    singleLineWidth = 0
		    
		    ' Add up all the widths of the items.
		    for each item in items
		      
		      ' Add in in the width of the item.
		      singleLineWidth = singleLineWidth + item.getWidth(1.0)
		      
		    next
		    
		  end if
		  
		  ' Return the width.
		  return singleLineWidth
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function getSubRun(lineStartOffset as integer, startIndex as integer, startOffset as integer, endIndex as integer, endOffset as integer) As FTLine
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim fullRunStart as integer
		  Dim fullRunEnd as integer
		  Dim fto as FTObject
		  Dim ftl as FTLine
		  
		  ' Create the line.
		  ftl = new FTLine(parentControl, self, lineStartOffset, getLineSpacing)
		  
		  ' Are we contained in the same run?
		  if startIndex = endIndex then
		    
		    ' Copy the partial first run.
		    fto = cloneItem(items(startIndex))
		    
		    ' Chop off the end of the string.
		    fto.deleteRight(endOffset)
		    
		    ' Chop off the beginning of the string.
		    fto.deleteLeft(startOffset)
		    
		    ' Add the line.
		    ftl.addObject(fto)
		    
		  else
		    
		    '-------------------------------
		    ' Get the first part.
		    '-------------------------------
		    
		    ' Do we need a partial run?
		    if startOffset >= 1 then
		      
		      ' Copy the partial first run.
		      fto = cloneItem(items(startIndex))
		      fto.deleteLeft(startOffset)
		      ftl.addObject(fto)
		      
		    else
		      
		      ' Add the run.
		      ftl.addObject(items(startIndex).clone)
		      
		    end if
		    
		    '-------------------------------
		    ' Get the full runs.
		    '-------------------------------
		    
		    ' Get the full runs range.
		    fullRunStart = startIndex + 1
		    fullRunEnd = endIndex - 1
		    
		    ' Copy over the full runs.
		    for i = fullRunStart to fullRunEnd
		      
		      ' Add the run.
		      ftl.addObject(cloneItem(items(i)))
		      
		    next
		    
		    '-------------------------------
		    ' Get the last part.
		    '-------------------------------
		    
		    ' Is there anything to append?
		    if endOffset >= 1 then
		      
		      ' Copy the partial end run.
		      fto = cloneItem(items(endIndex))
		      fto.deleteRight(endOffset)
		      ftl.addObject(fto)
		      
		    end if
		    
		  end if
		  
		  '-------------------------------
		  
		  ' Return the sub run.
		  return ftl
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getTabStops() As FTTabStop()
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim lastStop as double
		  Dim dts() as FTTabStop
		  
		  ' Do we need to add in the default tab stops?
		  if addDefaultTabStops then
		    
		    ' Get the number of existing tab stops.
		    count = Ubound(tabStops)
		    
		    ' Clear out the default tab stops.
		    for i = count downto 0
		      
		      ' Is this a default tab stop?
		      if tabStops(i).default then
		        
		        ' Remove the tab stop.
		        tabStops.Remove(i)
		        
		      end if
		      
		    next
		    
		    ' Get the default tab stops.
		    dts = parentControl.getDoc.getDefaultTabStops
		    
		    ' Are there any existing tab stops?
		    if Ubound(tabStops) > 0 then
		      
		      ' Get the position of the last tab stop.
		      lastStop = tabStops(Ubound(tabStops)).getTabStop
		      
		    end if
		    
		    ' Get the number of default tab stops.
		    count = Ubound(dts)
		    
		    ' Fill the remaing tab stops with default tab stops.
		    for i = 0 to count
		      
		      ' Are we past the end of the user defined tab stops?
		      if dts(i).getTabStop > lastStop then
		        
		        ' Add in the default tab spot.
		        tabStops.Append(dts(i))
		        
		      end if
		      
		    next
		    
		    ' The job is done.
		    addDefaultTabStops = false
		    
		  end if
		  
		  ' Return the set of tab stops.
		  return tabStops
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getText(showPictures as boolean = false) As string
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim sa() as string
		  
		  ' Should we include pictures?
		  if showPictures then
		    
		    ' Has the text been set up?
		    if currentTextWithPictures = "" then
		      
		      ' Make it zero based.
		      count = getItemCount - 1
		      
		      ' Walk through each item.
		      for i = 0 to count
		        
		        ' Append the text.
		        sa.append(items(i).getText(showPictures))
		        
		      next
		      
		      ' Join the segments.
		      currentTextWithPictures = join(sa, "")
		      
		    end if
		    
		    ' Return the current text.
		    return currentTextWithPictures
		    
		  else
		    
		    ' Has the text been set up?
		    if currentText = "" then
		      
		      ' Make it zero based.
		      count = getItemCount - 1
		      
		      ' Walk through each item.
		      for i = 0 to count
		        
		        ' Append the text.
		        sa.append(items(i).getText(showPictures))
		        
		      next
		      
		      ' Join the segments.
		      currentText = join(sa, "")
		      
		    end if
		    
		    ' Return the current text.
		    return currentText
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getText(startPosition as integer, endPosition as integer) As string
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim startIndex as integer
		  Dim startOffset as integer
		  Dim endIndex as integer
		  Dim endOffset as integer
		  Dim sa() as string
		  
		  ' Get the style run information.
		  findRunItem(startPosition, startIndex, startOffset)
		  findRunItem(endPosition, endIndex, endOffset)
		  
		  ' Are we past the end of the paragraph?
		  if endIndex = -1 then
		    
		    ' Set it to the end of the paragraph.
		    endIndex = Ubound(items)
		    endOffset = items(Ubound(items)).getEndPosition
		    
		  end if
		  
		  ' Is there anything to return?
		  if startIndex = -1 then
		    
		    return ""
		    
		  end if
		  
		  ' Are we within the same style run?
		  if startIndex = endIndex then
		    
		    ' Get the text from the run.
		    sa.append(items(startIndex).getText(startOffset, endOffset))
		    
		  else
		    
		    ' Get the text from the first run item.
		    sa.append(items(startIndex).getText(startOffset, items(startIndex).getLength))
		    
		    ' Get the number of items.
		    count = Ubound(items)
		    
		    ' Set the boundaries.
		    startIndex = startIndex + 1
		    endIndex = endIndex - 1
		    
		    ' Walk through each item.
		    for i = startIndex to endIndex
		      
		      ' Append the text.
		      sa.append(items(i).getText)
		      
		    next
		    
		    ' Get the text from the last run item.
		    sa.append(items(endIndex + 1).getText(1, endOffset))
		    
		  end if
		  
		  ' Return the text.
		  return join(sa, "")
		  
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
		  
		  Dim i as integer
		  Dim wordCount as integer
		  Dim length as integer
		  Dim text as string
		  Dim inWord as boolean
		  Dim ch as string
		  
		  ' Has the word count been computed?
		  if wordCountCache = -1 then
		    
		    ' Get the text.
		    text = getText
		    
		    ' Get the length of the text.
		    length = text.Len
		    
		    ' Count the words in the text.
		    for i = 1 to length
		      
		      ' Get a character.
		      ch = mid(text, i, 1)
		      
		      ' Are we currently inside a word?
		      if inWord then
		        
		        ' Is this a space or punctuation character?
		        if FTUtilities.isWordDivider(ch) then
		          
		          ' Reset the flag.
		          inWord = false
		          
		        end if
		        
		      else
		        
		        ' Is this a regular character?
		        if not FTUtilities.isWordDivider(ch) then
		          
		          ' Bump up the word count.
		          wordCount = wordCount + 1
		          
		          ' We entered a word.
		          inWord = true
		          
		        end if
		        
		      end if
		      
		    next
		    
		    ' Save the word count.
		    wordCountCache = wordCount
		    
		  end if
		  
		  ' Return the number of words.
		  return wordCountCache
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getWrapWidth() As double
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Has the wrap width been computed?
		  if wrapWidthCache = -1 then
		    
		    ' Compute the wrap width.
		    wrapWidthCache = FTUtilities.getScaledLength( _
		    parentControl.getDoc.getMarginWidth - pa.leftMargin - pa.rightMargin, _
		    1.0)
		    
		  end if
		  
		  ' Return the wrap width.
		  return wrapWidthCache
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub getXML(xmlDoc as XmlDocument, paragraph as XmlElement)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim style as FTParagraphStyle
		  Dim sa() as string
		  
		  ' Optimize the paragraph.
		  optimizeParagraph
		  
		  ' Load up the attributes.
		  if pa.afterParagraphSpace <> 0 then paragraph.SetAttribute(FTCxml.XML_AFTER_SPACE, str(pa.afterParagraphSpace))
		  if pa.beforeParagraphSpace <> 0 then paragraph.SetAttribute(FTCxml.XML_BEFORE_SPACE, str(pa.beforeParagraphSpace))
		  paragraph.SetAttribute(FTCxml.XML_LINE_SPACING, str(pa.lineSpacing))
		  paragraph.SetAttribute(FTCxml.XML_ALIGNMENT, str(pa.alignment))
		  if pa.leftMargin <> 0 then paragraph.SetAttribute(FTCxml.XML_LEFT_MARGIN, str(pa.leftMargin))
		  if pa.rightMargin <> 0 then paragraph.SetAttribute(FTCxml.XML_RIGHT_MARGIN, str(pa.rightMargin))
		  if pa.backgroundColor <> &cFFFFFF then paragraph.SetAttribute(FTCxml.XML_BACKGROUND_COLOR, FTUtilities.colorToString(pa.backgroundColor))
		  if pa.firstIndent <> 0 then paragraph.SetAttribute(FTCxml.XML_FIRST_INDENT, str(pa.firstIndent))
		  if pa.pageBreak then paragraph.SetAttribute(FTCxml.XML_PAGE_BREAK, str(pa.pageBreak))
		  
		  ' Load the paragraph style.
		  style = parentControl.getDoc.getParagraphStyle(pa.paragraphStyle)
		  if not (style is nil) then paragraph.SetAttribute(FTCxml.XML_PARAGRAPH_STYLE, style.getStyleName)
		  
		  ' Get the number of tab stops.
		  count = Ubound(tabStops)
		  
		  ' Do we have specific tabs?
		  if count > -1 then
		    
		    ' Encode all the tab stops.
		    for i = 0 to count
		      
		      ' Encode the tab stop
		      If tabStops(i).default = False Then 
		        ' Encode the tab stop 
		        sa.Append(Str(tabStops(i).getTabType) + TABSTOP_SEPARATOR + Str(tabStops(i).getTabStop) + TABSTOP_SEPARATOR + Str(tabStops(i).getTabLeader))
		        
		      End If
		      
		    next
		    
		    ' Load the tab stops.
		    paragraph.SetAttribute(FTCxml.XML_TAB_STOP, join(sa, " "))
		    
		  end if
		  
		  ' Make it zero based.
		  count = Ubound(items)
		  
		  ' Walk through each item.
		  for i = 0 to count
		    
		    ' Append the XML.
		    items(i).getXML(xmlDoc, paragraph)
		    
		  next
		  
		  ' Get the tag data.
		  super.getXMLTagData(paragraph)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasContent() As Boolean
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim count as integer
		  
		  ' Get the number of paragraphs.
		  count = Ubound(items)
		  
		  if count = -1 then return false
		  
		  if count = 0 then
		    if items(0) isa FTStyleRun then
		      Return FTStyleRun(items(0)).getText.lenb>0
		      
		    elseif items(0) isa FTTab then
		      Return true
		      
		    elseif items(0) isa FTPicture then
		      Return true
		      
		    else
		      break //What else could we have here?
		      Return false
		    end if
		    
		  else
		    'We have more than 1 item.  Definitely have content
		    Return true
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function hasLineId(id as integer) As boolean
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim pp as FTParagraphProxy
		  
		  ' Search the proxies
		  for each pp in proxies
		    
		    ' Does this proxy start on this page?
		    if getLine(pp.getLineStart).getId = id then return true
		    
		  next
		  
		  ' Not found.
		  return false
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function hasPageProxy(page as integer) As boolean
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim pp as FTParagraphProxy
		  
		  ' Search the proxies.
		  for each pp in proxies
		    
		    ' Is this proxy on the target page?
		    if pp.getPage = page then return true
		    
		  next
		  
		  ' Not found.
		  return false
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function hasResizeModePicture() As FTPicture
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim obj as FTObject
		  
		  ' Get the number of items.
		  count = Ubound(items)
		  
		  ' Scan for a selected picture.
		  for i = 0 to count
		    
		    ' Get an item.
		    obj = items(i)
		    
		    ' Is this a picture?
		    if obj isa FTPicture then
		      
		      ' Is this picture in resize mode?
		      if FTPicture(obj).isResizeMode then
		        
		        ' Return the picture.
		        return FTPicture(obj)
		        
		      end if
		      
		    end if
		    
		  next
		  
		  ' Nothing found.
		  return nil
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function hasSelection() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim so as FTInsertionOffset
		  Dim eo as FTInsertionOffset
		  
		  ' Get the current selection range.
		  parentControl.getDoc.getSelectionRange(so, eo)
		  
		  ' Is the paragraph in the selection range?
		  return (absoluteIndex >= so.paragraph) and (absoluteIndex <= eo.paragraph)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function hasTabs() As boolean
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim fto as FTObject
		  
		  ' Scan for tabs.
		  for each fto in items
		    
		    ' Is this a tab?
		    if fto isa FTTab then
		      
		      ' We found a tab.
		      return true
		      
		    end if
		    
		  next
		  
		  ' No tabs found.
		  return false
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub insertObject(index as integer, obj as FTObject, optimize as boolean = true)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Are we allowing pictures?
		  if (obj isa FTPicture) and _
		  (not parentControl.AllowPictures) then return
		  
		  ' Add the item to the paragraph.
		  items.Insert(index, obj)
		  
		  ' Should we optimize the paragraph?
		  if optimize then
		    
		    ' Update the positions.
		    updatePositions
		    
		  end if
		  
		  ' Mark the paragraph as dirty.
		  makeDirty
		  
		  ' Mark the paragraph for spell checking.
		  makeSpellingDirty
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub insertObjects(offset as integer, objects() as FTObject)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim item as FTObject
		  Dim sr as FTStyleRun
		  Dim index as integer
		  
		  ' The length has changed.
		  length = -1
		  
		  '-------------------------------------------------
		  ' Decide where to insert.
		  '-------------------------------------------------
		  
		  ' Get the index of the item.
		  index = findItem(offset, true)
		  
		  ' Is there something in this paragraph?
		  if index > -1 then
		    
		    ' Are we passed the end?
		    if index > Ubound(items) then
		      
		      ' Get the item at the end.
		      item = items(Ubound(items))
		      
		      ' Set the insertion point past the end.
		      index = Ubound(items) + 1
		      
		    else
		      
		      ' Is this a tab or picture?
		      if items(index).isMonolithic then
		        
		        ' Move to the next item for insertion.
		        index = index + 1
		        
		      end if
		      
		      ' Are we past the end?
		      if index > Ubound(items) then
		        
		        ' Get the item at the end.
		        item = items(Ubound(items))
		        
		        ' Set the insertion point past the end.
		        index = Ubound(items) + 1
		        
		      else
		        
		        ' Get the item.
		        item = items(index)
		        
		      end if
		      
		    end if
		    
		    '-------------------------------------------------
		    ' Insert a picture.
		    '-------------------------------------------------
		    
		    ' Is this a picture?
		    if (item isa FTPicture) or (item isa FTTab) then
		      
		      ' Create a filler style run.
		      sr = new FTStyleRun(parentControl)
		      sr.updateWithStyle(parentControl.getDoc.getParagraphStyle(pa.paragraphStyle))
		      
		      ' Are we past the end?
		      if index > Ubound(items) then
		        
		        ' Add a filler style run.
		        items.Append(sr)
		        
		      else
		        
		        ' Insert a filler style run.
		        items.insert(index, sr)
		        
		      end if
		      
		    else
		      
		      ' Do we need to split a style run?
		      if index <= Ubound(items) then
		        
		        ' Split the style run.
		        splitItem(index, (offset + 1) - item.getStartPosition + 1)
		        
		        ' Move to the insertion position.
		        index = index + 1
		        
		      end if
		      
		    end if
		    
		  else
		    
		    ' Assume the beginning of the paragraph.
		    index = 0
		    
		  end if
		  
		  '-------------------------------------------------
		  ' Insert the items.
		  '-------------------------------------------------
		  
		  ' Get the number of items to insert.
		  count = Ubound(objects)
		  
		  ' Insert all the items.
		  for i = count downto 0
		    
		    ' Are we allowing pictures?
		    if (objects(i) isa FTPicture) and _
		    (not parentControl.AllowPictures) then continue
		    
		    ' Are we past the end?
		    if index > Ubound(items) then
		      
		      ' Append the run item.
		      items.append(objects(i))
		      
		    else
		      
		      ' Insert the run item.
		      items.insert(index, objects(i))
		      
		    end if
		    
		  next
		  
		  ' Is there anything in the paragraph?
		  if Ubound(items) = -1 then
		    
		    ' Insert an empty run item.
		    items.insert(index, new FTStyleRun(parentControl))
		    
		  end if
		  
		  '-------------------------------------------------
		  ' Clean up.
		  '-------------------------------------------------
		  
		  ' Mark it for an update.
		  makeDirty
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub insertPicture(offset as integer, ftp as FTPicture)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim item as FTObject
		  Dim sr as FTStyleRun
		  Dim index as integer
		  
		  ' Are we allowing pictures?
		  if not parentControl.AllowPictures then return
		  
		  ' The length has changed.
		  length = -1
		  
		  ' Are we after the first item?
		  if offset > 0 then
		    
		    ' Are we past the end?
		    if offset > getLength then
		      
		      ' Get the end item.
		      index = Ubound(items)
		      
		      ' Get the item.
		      item = items(index)
		      
		      ' Move past the last item.
		      index = index + 1
		      
		    else
		      
		      ' Get the index of the item.
		      index = findItem(offset)
		      
		      ' Are we passed the end?
		      if index > Ubound(items) then
		        
		        ' Get the item at the end.
		        item = items(Ubound(items))
		        
		      else
		        
		        ' Is this a picture or tab?
		        if items(index).isMonolithic then
		          
		          ' Move to the next item for insertion.
		          index = index + 1
		          
		        end if
		        
		        ' Get the item.
		        item = items(index)
		        
		      end if
		      
		    end if
		    
		  else
		    
		    ' Use the first item.
		    item = items(0)
		    
		  end if
		  
		  ' Is this a picture?
		  if item isa FTPicture then
		    
		    ' Create a filler style run.
		    sr = new FTStyleRun(parentControl)
		    sr.updateWithStyle(parentControl.getDoc.getParagraphStyle(pa.paragraphStyle))
		    
		    ' Insert a filler style run.
		    items.insert(index, sr)
		    
		  else
		    
		    ' Split the style run.
		    splitItem(index, (offset + 1) - item.getStartPosition + 1)
		    
		    ' Move to the insertion position.
		    index = index + 1
		    
		  end if
		  
		  ' Are we in range?
		  if index > Ubound(items) then
		    
		    ' Put the picture into the paragraph.
		    items.Append(ftp)
		    
		  else
		    
		    ' Put the picture into the paragraph.
		    items.insert(index, ftp)
		    
		  end if
		  
		  ' Update the positions.
		  updatePositions
		  
		  ' Mark it for an update.
		  makeDirty
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub insertPicture(offset as integer, pic as Picture)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Add the picture to the paragraph.
		  insertPicture(offset, new FTPicture(parentControl, pic))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub insertString(offset as integer, s as string)
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim item as FTObject
		  Dim itemNext as FTObject
		  Dim index as integer
		  
		  ' The length has changed.
		  length = -1
		  
		  ' Get the index of the item.
		  index = findItem(offset, true)
		  
		  ' Are we passed the end?
		  if index > Ubound(items) then
		    
		    ' Get the item at the end.
		    item = items(Ubound(items))
		    
		  else
		    
		    ' Is this a picture?
		    if items(index).isMonolithic then
		      
		      ' Move to the next item for insertion.
		      index = index + 1
		      
		      ' Are we past the end?
		      if index > Ubound(items) then
		        
		        ' Create a text run.
		        items.append(new FTStyleRun(parentControl, ""))
		        
		        ' Get the index.
		        index = Ubound(items)
		        
		      end if
		      
		    end if
		    
		    ' Get the item.
		    item = items(index)
		    
		    ' Can we get a next item?
		    if index < items.Ubound then
		      itemNext = items(index + 1)
		    end
		    
		  end if
		  
		  ' Is this a picture or a tab?
		  if (item isa FTPicture) or (item isa FTTab) then
		    
		    ' Create a text run.
		    item = new FTStyleRun(parentControl, s)
		    
		    ' Put the text into the paragraph.
		    items.insert(index, item)
		    
		  else
		    
		    ' Check to see if we have a hyperlink style.  If we are at the end of the word.  If so and we
		    ' we have a next style that's isn't a hyperlink, use that style.
		    dim bInsertText as boolean = true
		    if (item isa FTStyleRun) and FTStyleRun(item).isHyperlink then
		      'we are in a style run that is a hyperlink
		      
		      if offset > FTStyleRun(item).getStartPosition  AND offset < FTStyleRun(item).getEndPosition then
		        'we're in the middle of the link, so continue with the hyperlink style and do nothing
		        
		      else
		        
		        ' we're outside the link so don't continue the hyperlink
		        dim oStyle as FTStyleRun = FTStyleRun(item)
		        dim oNextStyle as FTStyleRun
		        
		        if  (itemNext <> nil) and (itemNext isa FTStyleRun) then
		          oNextStyle= FTStyleRun(itemNext)
		          
		        else
		          ' we need to create a new style run here. We are probably at the end of the document
		          ' Clone the current StyleRun and reset the hyperlink value.
		          oNextStyle = FTStyleRun(oStyle.clone)
		          oNextStyle.HyperLink = ""
		          
		        end
		        
		        if oStyle.IsHyperlink and oNextStyle.isHyperlink = false then
		          
		          ' Create a text run.
		          item = oNextStyle.clone
		          
		          ' Set the text in the Style Run
		          FTStyleRun(item).settext s
		          
		          ' Insert the item into our array
		          items.insert(index + 1, item)
		          
		          ' Tell the next bit to not insert the text.  We've already taken care of it.
		          bInsertText = false
		        end
		        
		        
		      end if
		    end
		    
		    if bInsertText then
		      ' Insert the text into the paragraph.
		      item.insertText(offset, s)
		    end
		    
		  end if
		  
		  ' Mark it for an update.
		  makeDirty
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub insertTabCharacter(offset as integer)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim item as FTObject
		  Dim sr as FTStyleRun
		  Dim index as integer
		  
		  ' The length has changed.
		  length = -1
		  
		  ' Get the index of the item.
		  index = findItem(offset)
		  
		  ' Are we passed the end?
		  if index > Ubound(items) then
		    
		    index = Ubound(items)
		    
		    ' Get the item at the end.
		    item = items(index)
		    
		  else
		    
		    ' Is this a picture or a tab?
		    if items(index).isMonolithic then
		      
		      ' Move to the next item for insertion.
		      index = index + 1
		      
		    end if
		    
		    ' Get the item.
		    item = items(index)
		    
		  end if
		  
		  ' Is this a picture?
		  if item isa FTPicture then
		    
		    ' Create a filler style run.
		    sr = new FTStyleRun(parentControl)
		    sr.updateWithStyle(parentControl.getDoc.getParagraphStyle(pa.paragraphStyle))
		    
		    ' Insert a filler style run.
		    items.insert(index, sr)
		    
		  elseif item isa FTStyleRun then
		    
		    ' Split the style run.
		    splitItem(index, (offset + 1) - item.getStartPosition + 1)
		    
		    ' Move to the insertion position.
		    index = index + 1
		    
		  end if
		  
		  ' Are we past the end?
		  if index > Ubound(items) then
		    
		    ' Put the tab into the paragraph.
		    items.append(new FTTab(parentControl))
		    
		  else
		    
		    ' Put the tab into the paragraph.
		    items.insert(index, new FTTab(parentControl))
		    
		  end
		  
		  ' Create a filler style run.
		  sr = new FTStyleRun(parentControl)
		  sr.updateWithStyle(parentControl.getDoc.getParagraphStyle(pa.paragraphStyle))
		  
		  ' Scan for the previous style run.
		  for i = index downto 0
		    
		    ' Is this a style run?
		    if items(i) isa FTStyleRun then
		      
		      ' Copy the style data.
		      FTStyleRun(items(i)).copyStyleData(sr)
		      
		      ' We are done.
		      exit
		      
		    end if
		    
		  next
		  
		  ' Are we past the end?
		  if index + 1 > Ubound(items) then
		    
		    ' Insert a filler style run.
		    items.append(sr)
		    
		  else
		    
		    ' Insert a filler style run.
		    items.insert(index + 1, sr)
		    
		  end if
		  
		  ' Mark it for an update.
		  makeDirty
		  
		  ' Mark the paragraph for spell checking.
		  makeSpellingDirty
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function insertXmlNode(paragraph as XmlElement, offset as integer, useAttributes as boolean) As integer
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim obj as XmlElement
		  Dim fto as FTObject
		  Dim items() as FTObject
		  Dim length as integer
		  
		  ' Should we add the paragraph attributes?
		  if useAttributes then
		    
		    ' Load the paragraph attributes.
		    addXMLParagraphAttributes(paragraph)
		    
		  end if
		  
		  ' Is this an empty paragraph?
		  if getLength = 0 then
		    
		    ' Clear out any default values.
		    clearItems
		    
		  end if
		  
		  ' Decode the developer tag.
		  parentControl.callXmlDecodeTag(paragraph.GetAttribute(FTCxml.XML_TAG), self)
		  
		  ' Add the tab stops.
		  addXMLTabstops(paragraph)
		  
		  ' Get the first object.
		  obj = XmlElement(paragraph.FirstChild)
		  
		  ' Add all the runs to the paragraph.
		  while not (obj is nil)
		    
		    ' Create the object.
		    select case obj.name
		      
		    case FTCxml.XML_FTSTYLERUN
		      
		      ' Create a style run.
		      fto = new FTStyleRun(parentControl, obj)
		      
		    case FTCxml.XML_FTPICTURE
		      
		      ' Create the picture.
		      fto = new FTPicture(parentControl, obj)
		      
		    case FTCxml.XML_FTTAB
		      
		      ' Create the tab.
		      fto = new FTTab(parentControl, obj)
		      
		    else
		      
		      ' Call the custom object creation.
		      fto = parentControl.callXmlObjectCreate(obj)
		      
		    end select
		    
		    ' Was this object recognized
		    if not (fto is nil) then
		      
		      ' Add the run to the paragraph.
		      items.Append(fto)
		      
		    else
		      
		      ' This is an unrecognized object.
		      parentControl.callUnrecognizedXmlObject(obj)
		      
		    end if
		    
		    ' Get the next object.
		    obj = XmlElement(obj.NextSibling)
		    
		  wend
		  
		  ' Add up the insertion lengths.
		  for each fto in items
		    
		    ' Add in the length of the item.
		    length = length + fto.getLength
		    
		  next
		  
		  ' Insert the objects.
		  insertObjects(offset, items)
		  
		  ' Return the length of the insertion.
		  return length
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isAllSelected() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim count as integer
		  
		  ' Get the number of items.
		  count = Ubound(items)
		  
		  ' Is there anything to look at?
		  if count = -1 then return false
		  
		  ' Is every thing selected?
		  return items(0).isFirstPositionSelected and _
		  items(count).isLastPositionSelected
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isDirty() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the dirty flag.
		  return dirty
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isFirstPositionSelected() As boolean
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  
		  ' Get the number of items.
		  count = Ubound(items)
		  
		  ' Scan for a non empty item.
		  for i = 0 to count
		    
		    ' Does this item have something in it?
		    if items(i).getLength > 0 then
		      
		      ' Is the very first thing selected?
		      return items(i).isFirstPositionSelected
		      
		    end if
		    
		  next
		  
		  ' Nothing selected.
		  return false
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isLastPositionSelected() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Is the very last thing selected?
		  return items(Ubound(items)).isLastPositionSelected
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isOffsetPicture(offset as integer) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim index as integer
		  
		  ' Find the item.
		  index = findItem(offset)
		  
		  ' Are we in range?
		  if index > Ubound(items) then return false
		  
		  ' Is this item a picture?
		  return (items(index) isa FTPicture)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function isPreviousItemTab(index as integer) As integer
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim fto as FTObject
		  
		  ' Are we at the beginning?
		  if index = 0 then return 0
		  
		  ' Search for a tab.
		  for i = (index - 1) downto 0
		    
		    ' Get the object.
		    fto = items(i)
		    
		    ' Is this item a style run?
		    if fto isa FTStyleRun then
		      
		      ' Is there any text in it?
		      if fto.getLength > 0 then
		        
		        ' Not a tab item.
		        return 0
		        
		      else
		        
		        ' Keep looking.
		        continue
		        
		      end if
		      
		      ' Is this a tab?
		    elseif fto isa FTTab then
		      
		      ' Return the length of the tab.
		      return fto.getWidth(parentControl.getDisplayScale)
		      
		    end if
		    
		  next
		  
		  ' Nothing found.
		  return 0
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function isSpace(c as string) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Is the character one of those space characters?
		  return (Asc(c) <= 32) or (c = "")
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isSpellingDirty() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the dirty flag.
		  return spellingDirty
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub makeDirty()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Tell the document that we went dirty.
		  parentControl.getDoc.setDirtyParagraph(absoluteIndex)
		  
		  ' Reset the internals.
		  reset
		  
		  ' Mark it as dirty.
		  dirty = true
		  
		  ' Recalculate the positions.
		  positionsChanged = true
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub makeFontBigger()
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim item as FTObject
		  
		  ' Scan the items.
		  for each item in items
		    
		    ' Is this a text run?
		    if item isa FTStyleRun then
		      
		      ' Change the font size.
		      FTStyleRun(item).makeFontBigger
		      
		    end if
		    
		  next
		  
		  ' Mark the paragraph as dirty.
		  makeDirty
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub makeFontBigger(startPosition as integer, endPosition as integer)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim startIndex as integer
		  Dim endIndex as integer
		  
		  ' Get the items to change.
		  if setupChange(startPosition, endPosition, startIndex, endIndex) then
		    
		    ' Change the full styles.
		    for i = startIndex to endIndex
		      
		      ' Is this a style run?
		      if items(i) isa FTStyleRun then
		        
		        ' Change the size.
		        FTStyleRun(items(i)).makeFontBigger
		        
		      end if
		      
		    next
		    
		  end if
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub makeFontSmaller()
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim item as FTObject
		  
		  ' Scan the items.
		  for each item in items
		    
		    ' Is this a text run?
		    if item isa FTStyleRun then
		      
		      ' Change the font size.
		      FTStyleRun(item).makeFontSmaller
		      
		    end if
		    
		  next
		  
		  ' Mark the paragraph as dirty.
		  makeDirty
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub makeFontSmaller(startPosition as integer, endPosition as integer)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim startIndex as integer
		  Dim endIndex as integer
		  
		  ' Get the items to change.
		  if setupChange(startPosition, endPosition, startIndex, endIndex) then
		    
		    ' Change the full styles.
		    for i = startIndex to endIndex
		      
		      ' Is this a style run?
		      if items(i) isa FTStyleRun then
		        
		        ' Change the size.
		        FTStyleRun(items(i)).makeFontSmaller
		        
		      end if
		      
		    next
		    
		  end if
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub makeSpellingDirty()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Are we checking spelling as we are typing?
		  if parentControl.SpellCheckWhileTyping then
		    
		    ' Is there anything to check?
		    if getLength > 0 then
		      
		      ' Mark it as dirty.
		      spellingDirty = true
		      
		    else
		      
		      ' Mark it as clean.
		      spellingDirty = false
		      
		    end if
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub notifyChangeScale()
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim item as FTObject
		  
		  ' Notify each item.
		  for each item in items
		    
		    ' Notify the item.
		    item.callScaleChanged
		    
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function operator_compare(rhs as FTParagraph) As integer
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  
		  ' Optimize the paragraph.
		  optimizeParagraph
		  rhs.optimizeParagraph
		  
		  ' Check the length of the text.
		  if getLength <> rhs.getLength then
		    
		    break
		    return -1
		    
		  end if
		  
		  ' Compare the content.
		  if getText(true) <> rhs.getText(true) then
		    
		    break
		    return -1
		    
		  end if
		  
		  ' Check the number of style runs.
		  if getItemCount <> rhs.getItemCount then
		    
		    break
		    return -1
		    
		  end if
		  
		  ' Get the number of style runs.
		  count = getItemCount - 1
		  
		  ' Scan all the runs.
		  for i = 0 to count
		    
		    ' Are the objects the same?
		    if not getItem(i).isSame(rhs.getItem(i)) then
		      
		      break
		      call getItem(i).isSame(rhs.getItem(i))
		      
		      return -1
		      
		    end if
		    
		  next
		  
		  ' They are equal.
		  return 0
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub optimizeParagraph()
		  
		  ' Do NOT remove this pragma or you may have unpredictable results!
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim sr as FTStyleRun
		  Dim sr1 as FTStyleRun
		  Dim sr2 as FTStyleRun
		  Dim preFto as FTObject
		  Dim postFto as FTObject
		  Dim fto as FTObject
		  
		  '-----------------------------------------------
		  ' Save the current style information.
		  '-----------------------------------------------
		  
		  ' Get the number of items.
		  count = Ubound(items)
		  
		  ' Scan for the first style run.
		  for i = 0 to count
		    
		    ' Is this a style run?
		    if items(i) isa FTStyleRun then
		      
		      ' Get the first style run so we don't lose the formatting.
		      sr = FTStyleRun(items(i))
		      
		      ' We are done.
		      exit
		      
		    end if
		    
		  next
		  
		  ' Did we find a style?
		  if sr is nil then
		    
		    ' Create a new style.
		    sr = new FTStyleRun(parentControl)
		    
		    ' Update the style information.
		    sr.updateWithStyle(doc.getParagraphStyle(pa.paragraphStyle))
		    
		  end if
		  
		  '-----------------------------------------------
		  ' Remove empty style runs.
		  '-----------------------------------------------
		  
		  ' Get the number of items.
		  count = Ubound(items)
		  
		  ' Scan for empty styles.
		  for i = count downto 0
		    
		    ' Get the current target style run.
		    fto = items(i)
		    
		    ' Is this an empty run?
		    if (fto isa FTStyleRun) and (fto.getLength = 0) and _
		      (not FTStyleRun(fto).isSaved) then
		      
		      ' Can we peek at the previous item?
		      if i > 0 then
		        
		        ' Get the next item.
		        preFto = items(i - 1)
		        
		      else
		        
		        ' Nothing to look at.
		        preFto = nil
		        
		      end if
		      
		      ' Can we peek at the next item?
		      if i < Ubound(items) then
		        
		        ' Get the next item.
		        postFto = items(i + 1)
		        
		      else
		        
		        ' Nothing to look at.
		        postFto = nil
		        
		      end if
		      
		      '--------------------
		      
		      ' Are we surrounded by style runs?
		      if (preFto isa FTStyleRun) and (postFto isa FTStyleRun) then
		        
		        ' Chuck the sucker.
		        items.Remove(i)
		        continue
		        
		      end if
		      
		      '--------------------
		      
		      ' Is the previous run a style run?
		      if preFto isa FTStyleRun then
		        
		        ' Are they the same?
		        if FTStyleRun(preFto).isSameStyle(FTStyleRun(fto)) then
		          
		          ' Chuck the sucker.
		          items.Remove(i)
		          continue
		          
		        end if
		        
		      end if
		      
		      '--------------------
		      
		      ' Is the next run a style run?
		      if postFto isa FTStyleRun then
		        
		        ' Are they the same?
		        if FTStyleRun(postFto).isSameStyle(FTStyleRun(fto)) then
		          
		          ' Chuck the sucker.
		          items.Remove(i)
		          continue
		          
		        end if
		        
		      end if
		      
		      '--------------------
		      
		      ' Is this a filler after a picture?
		      if (preFto isa FTPicture) and (postFto isa FTStyleRun) then
		        
		        ' Chuck the sucker.
		        items.Remove(i)
		        continue
		        
		      end if
		      
		      '--------------------
		      
		      ' Is this a filler before a picture?
		      if (preFto isa FTStyleRun) and (postFto isa FTPicture) then
		        
		        ' Chuck the sucker.
		        items.Remove(i)
		        continue
		        
		      end if
		      
		      '--------------------
		      
		      ' Check the end case.
		      if ((i = 0) and (postFto isa FTStyleRun)) or _
		        ((i = count) and (preFto isa FTStyleRun)) then
		        
		        ' Chuck the sucker.
		        items.Remove(i)
		        continue
		        
		      end if
		      
		      '--------------------
		      
		    end if
		    
		  next
		  
		  '-----------------------------------------------
		  ' Scan for duplicate style runs.
		  '-----------------------------------------------
		  
		  ' Get the number of items.
		  count = Ubound(items)
		  
		  ' Scan for duplicate styles.
		  for i = count downto 1
		    
		    ' Are we dealing with two style runs in a row?
		    if (items(i) isa FTStyleRun) and (items(i - 1) isa FTStyleRun) then
		      
		      ' Type cast the objects.
		      sr1 = FTStyleRun(items(i))
		      sr2 = FTStyleRun(items(i - 1))
		      
		      ' Are the two adjacent styles the same?
		      if sr1.isSameStyle(sr2) then
		        
		        ' Move the text over.
		        sr2.appendText(sr1.getText)
		        
		        ' Remove the duplicate style.
		        items.Remove(i)
		        
		      end if
		      
		    end if
		    
		  next
		  
		  '-----------------------------------------------
		  ' Adjust ordering.
		  '-----------------------------------------------
		  
		  ' Are there any items left in the paragraph?
		  if Ubound(items) = -1 then
		    
		    ' Clear the text.
		    sr.setText("", 0)
		    
		    ' Add in the default run.
		    items.Append(sr)
		    
		  else
		    
		    ' Is the first item a picture?
		    if items(0) isa FTPicture then
		      
		      ' Create a new style.
		      sr = new FTStyleRun(parentControl)
		      
		      ' Update the style information.
		      sr.updateWithStyle(doc.getParagraphStyle(pa.paragraphStyle))
		      
		      ' Insert in the new style.
		      items.Insert(0, sr)
		      
		    end if
		    
		    ' Is the last item a picture?
		    if items(Ubound(items)) isa FTPicture then
		      
		      ' Create a new style.
		      sr = new FTStyleRun(parentControl)
		      
		      ' Update the style information.
		      sr.updateWithStyle(doc.getParagraphStyle(pa.paragraphStyle))
		      
		      ' Add the new style.
		      items.Append(sr)
		      
		    end if
		    
		  end if
		  
		  '-----------------------------------------------
		  ' Remove empty style runs.
		  '-----------------------------------------------
		  
		  ' Get the number of items.
		  count = Ubound(items)
		  
		  ' Do we need to check the last one?
		  if count >= 1 then
		    
		    ' Is this an empty run?
		    if (items(count) isa FTStyleRun) and (items(count).getLength = 0) and _
		      (not FTStyleRun(items(count)).isSaved) then
		      
		      ' Is the previous object a style run?
		      if items(count - 1) isa FTStyleRun then
		        
		        ' Remove the empty style.
		        items.Remove(count)
		        
		      end if
		      
		    end if
		    
		  end if
		  
		  '-------------------------------
		  
		  ' Do we need to check the first one?
		  if Ubound(items) >= 1 then
		    
		    ' Is this an empty run?
		    if (items(0) isa FTStyleRun) and (items(0).getLength = 0) and _
		      (not FTStyleRun(items(0)).isSaved) then
		      
		      ' Is the next object a style run?
		      if items(1) isa FTStyleRun then
		        
		        ' Remove the empty style.
		        items.Remove(0)
		        
		      end if
		      
		    end if
		    
		  end if
		  
		  '-----------------------------------------------
		  ' Update calculated values.
		  '-----------------------------------------------
		  
		  ' Update the positions in the paragraph.
		  updatePositions(true)
		  
		  ' Update the length.
		  call getLength
		  
		  '-----------------------------------------------
		  
		  exception
		    
		    ' Do nothing. We want to bury the exception because we
		    ' don't want to crash the system.
		    
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function parseLine(ByRef startPosition as integer, width as double, firstLine as boolean) As FTLine
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim startIndex as integer
		  Dim startOffset as integer
		  Dim endIndex as integer
		  Dim endOffset as integer
		  Dim ftl as FTline
		  
		  ' Are we just making a single line?
		  if parentControl.isSingleViewMode then
		    
		    ' Return the entire line.
		    return getSubRun(1, 0, 1, Ubound(items), items(Ubound(items)).getLength)
		    
		  end if
		  
		  ' Is there anything to parse?
		  if width <= 0 then return nil
		  
		  ' Get the starting position.
		  findRunItem(startPosition, startIndex, startOffset)
		  
		  ' Was the run item found?
		  if startIndex <> -1 then
		    
		    ' Populate the tab widths.
		    populateTabs(startIndex, startOffset)
		    
		    ' Find the end position of the line.
		    findEndPosition(startIndex, startOffset, endIndex, endOffset, width)
		    
		    ' Is a non-first line?
		    if not firstLine then
		      
		      ' Trim the beginning of the line.
		      trimStartPosition(startIndex, startOffset)
		      
		      ' Is there anything to look at?
		      if startIndex = -1 then return nil
		      
		    end if
		    
		    ' Chop off partial words.
		    trimEndPosition(startIndex, startOffset, endIndex, endOffset)
		    
		    ' Create the line.
		    ftl = getSubRun(startPosition, startIndex, startOffset, endIndex, endOffset)
		    
		    ' Save the next starting position.
		    startPosition = startPosition + ftl.getLength
		    
		  end if
		  
		  ' Return the line.
		  return ftl
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub populateTabs(startIndex as integer, startOffset as integer)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim offset as double
		  Dim tabPosition as double
		  Dim tabLeader As FTTab.Tab_Leader_Type
		  
		  ' Is this a tab?
		  if items(startIndex) isa FTTab then
		    
		    tabPosition = findTabStop(0)
		    
		    ' Set the tab width.
		    FTTab(items(startIndex)).setTabPosition(tabPosition)
		    
		    ' Sum up the item widths.
		    offset = FTUtilities.getScaledLength(tabPosition, 1.0)
		    
		  else
		    
		    ' Get the width of the first item.
		    offset = items(startIndex).getWidth(startOffset, items(startIndex).getLength)
		    
		  end if
		  
		  ' Get the number of items in the paragraph.
		  count = Ubound(items)
		  
		  ' Fill in the tab widths.
		  for i = (startIndex + 1) to count
		    
		    ' Is this a tab?
		    if items(i) isa FTTab then
		      
		      tabPosition = findTabStop(offset)
		      
		      ' Set the tab width.
		      FTTab(items(i)).setTabPosition(tabPosition)
		      
		      tabLeader = findTabStopLeader(offset)
		      FTTab(items(i)).Leader = tabLeader
		      
		      ' Sum up the item widths.
		      offset = FTUtilities.getScaledLength(tabPosition, 1.0)
		      
		    else
		      
		      ' Get the width of the item.
		      offset = offset + items(i).getWidth(1.0)
		      
		    end if
		    
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub removeEmptyStyleRuns()
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim fto as FTObject
		  
		  ' Get the number of items.
		  count = Ubound(items)
		  
		  ' Scan for empty styles.
		  for i = count downto 0
		    
		    ' Get the current target style run.
		    fto = items(i)
		    
		    ' Is this an empty run?
		    if (fto isa FTStyleRun) and (fto.getLength = 0) and _
		      (not FTStyleRun(fto).isSaved) then
		      
		      ' Chuck the sucker.
		      items.Remove(i)
		      
		    end if
		    
		  next
		  
		  ' Optimize the paragraph.
		  optimizeParagraph
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub removeHyperlinks()
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim item as FTObject
		  
		  ' Scan the items.
		  for each item in items
		    
		    ' Change the color.
		    item.removeHyperlinks()
		    
		  next
		  
		  ' Mark the paragraph as dirty.
		  makeDirty
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub removeHyperlinks(startPosition as integer, endPosition as integer)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim startIndex as integer
		  Dim endIndex as integer
		  
		  ' Get the items to change.
		  if setupChange(startPosition, endPosition, startIndex, endIndex) then
		    
		    ' Change the styles.
		    for i = startIndex to endIndex
		      
		      ' Change the color.
		      items(i).removeHyperlinks()
		    next
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub removeMarkers()
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim fto as FTObject
		  
		  ' Get the number of items.
		  count = Ubound(items)
		  
		  ' Scan for empty styles.
		  for i = count downto 0
		    
		    ' Get the current target style run.
		    fto = items(i)
		    
		    ' Is this an empty run?
		    if fto isa FTMarker then
		      
		      ' Chuck the sucker.
		      items.Remove(i)
		      
		    end if
		    
		  next
		  
		  ' Optimize the paragraph.
		  optimizeParagraph
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub removeProxy(id as integer)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  
		  ' Get the number of proxies.
		  count = Ubound(proxies)
		  
		  ' Scan the list.
		  for i = 0 to count
		    
		    ' Is this the one we are looking for?
		    if proxies(i).getProxyId = id then
		      
		      ' Remove the proxy.
		      proxies.Remove(i)
		      
		      ' We are done.
		      return
		      
		    end if
		    
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub reset()
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim item as FTObject
		  
		  ' Reset all the objects.
		  for each item in items
		    
		    ' Reset the object.
		    item.reset
		    
		  next
		  
		  ' Reset the caches.
		  wrapWidthCache = -1
		  beforeParagraphSpaceCache = -1
		  afterParagraphSpaceCache = -1
		  wordCountCache = -1
		  length = -1
		  currentText = ""
		  currentTextWithPictures = ""
		  singleLineWidth = -1
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setAbsoluteIndex(index as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set the absolute index.
		  absoluteIndex = index
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setAfterSpace(space as double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Invalidate the cache.
		  afterParagraphSpaceCache = -1
		  
		  ' Set the margin.
		  pa.afterParagraphSpace = space
		  
		  ' Mark the paragraph as dirty.
		  makeDirty
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setAlignment(alignment as FTParagraph.Alignment_Type)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the alignment.
		  pa.alignment = alignment
		  
		  ' Mark the paragraph as dirty.
		  makeDirty
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setBackgroundColor()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set the background color to white.
		  pa.backgroundColor = &cFFFFFF
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setBackgroundColor(c as Color)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set the background color.
		  pa.backgroundColor = c
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setBeforeSpace(space as double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set the margin.
		  pa.beforeParagraphSpace = space
		  
		  ' Mark the paragraph as dirty.
		  makeDirty
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setComposeLinesHint(characterInsertionPoint as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the starting point to start composing.
		  me.characterInsertionPoint = characterInsertionPoint
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetDefaultTabStops(NewTabStopDefault as double)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim ts As FTTabStop
		  
		  ' Get the number of existing tab stops.
		  count = Ubound(tabStops)
		  
		  ' Clear out the old tab stops.
		  for i = count downto 0
		    
		    ' Remove the tab stop.
		    tabStops.Remove(i)
		    
		  next
		  
		  Dim dStop As Double = NewTabStopDefault
		  
		  While dStop < Me.doc.getPageWidth
		    
		    ' Create the tab stop.
		    ts = New FTTabStop(Me.parentControl, FTTabstop.TabStopType.Left, dStop, True)
		    
		    ' Add the tab stop to the end of the list.
		    tabStops.Append(ts)
		    
		    dStop = dStop + NewTabStopDefault
		  Wend
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setFirstIndent(indent as double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Invalidate the cache.
		  wrapWidthCache = -1
		  
		  ' Set the first indent.
		  pa.firstIndent = indent
		  
		  ' Mark the paragraph as dirty.
		  makeDirty
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setLeftMargin(margin as double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Invalidate the cache.
		  wrapWidthCache = -1
		  
		  ' Set the left margin.
		  pa.leftMargin = Max(margin, 0)
		  
		  ' In single view mode this does not change the composition.
		  if not parentControl.isSingleViewMode then
		    
		    ' Mark the paragraph as dirty.
		    makeDirty
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setLineSpacing(lineSpacing as double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Was a line spacing specified?
		  if lineSpacing <= 0 then
		    
		    ' Use the default line spacing.
		    pa.lineSpacing = 1.0
		    
		  else
		    
		    ' Set the line spacing.
		    pa.lineSpacing = lineSpacing
		    
		  end if
		  
		  ' Mark the paragraph as dirty.
		  makeDirty
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setPageBreak(state as boolean)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set the page break state.
		  pa.pageBreak = state
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setParagraphAttributes(pa as ParagraphAttributes)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set the attributes.
		  me.pa = pa
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setParagraphStyle(paragraphStyle as integer, updateStyleRuns as boolean = true)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim item as FTObject
		  Dim style as FTParagraphStyle
		  
		  '----------------------------------------------------
		  ' Update the style runs.
		  '----------------------------------------------------
		  
		  ' Get the style.
		  style = parentControl.getDoc.getParagraphStyle(paragraphStyle)
		  
		  ' Save the style.
		  pa.paragraphStyle = paragraphStyle
		  
		  ' Is there anything to update?
		  if style is nil then return
		  
		  ' Should we update the style runs?
		  if updateStyleRuns then
		    
		    ' Update all the style runs.
		    for each item in items
		      
		      ' Update the style.
		      item.updateWithStyle(style)
		      
		    next
		    
		  end if
		  
		  '----------------------------------------------------
		  ' Update the first indent.
		  '----------------------------------------------------
		  
		  ' Is the first indent defined?
		  if style.isFirstIndentDefined then
		    
		    ' Set the first indent.
		    setFirstIndent(style.getFirstIndent)
		    
		  else
		    
		    ' Use the default value.
		    setFirstIndent(0)
		    
		  end if
		  
		  '----------------------------------------------------
		  ' Update the left margin.
		  '----------------------------------------------------
		  
		  ' Is the left margin defined?
		  if style.isLeftMarginDefined then
		    
		    ' Set the left margin.
		    setLeftMargin(style.getLeftMargin)
		    
		  else
		    
		    ' Use the default value.
		    setLeftMargin(0)
		    
		  end if
		  
		  '----------------------------------------------------
		  ' Update the right margin.
		  '----------------------------------------------------
		  
		  ' Is the right margin defined?
		  if style.isRightMarginDefined then
		    
		    ' Set the right margin.
		    setRightMargin(style.getRightMargin)
		    
		  else
		    
		    ' Use the default value.
		    setRightMargin(0)
		    
		  end if
		  
		  '----------------------------------------------------
		  ' Update the alignment.
		  '----------------------------------------------------
		  
		  ' Is the alignment defined?
		  if style.isAlignmentDefined then
		    
		    ' Set the alignment.
		    pa.alignment = style.getAlignment
		    
		  else
		    
		    ' Use the default value.
		    pa.alignment = FTParagraph.Alignment_Type.Left
		    
		  end if
		  
		  '----------------------------------------------------
		  ' Update the spacing.
		  '----------------------------------------------------
		  
		  ' Save the spacing.
		  setBeforeSpace(style.getBeforeSpace)
		  setAfterSpace(style.getAfterSpace)
		  setLineSpacing(style.getLineSpacing)
		  
		  ' Mark the paragraph as dirty.
		  makeDirty
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setParent(parentControl as FormattedText)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim obj as FTObject
		  
		  ' Handle this object.
		  super.setParent(parentControl)
		  
		  ' Set the parent for each FTObject.
		  for each obj in items
		    
		    ' Set the parent.
		    obj.setParent(parentControl)
		    
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setRightMargin(margin as double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Invalidate the cache.
		  wrapWidthCache = -1
		  
		  ' Set the right margin.
		  pa.rightMargin = Max(margin, 0)
		  
		  ' In single view mode this does not change the composition.
		  if not parentControl.isSingleViewMode then
		    
		    ' Mark the paragraph as dirty.
		    makeDirty
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetTabStops(aroTabStops() as FTTabStop)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  
		  ' Get the number of existing tab stops.
		  count = Ubound(tabStops)
		  
		  ' Clear out the old tab stops.
		  for i = count downto 0
		    
		    ' Remove the tab stop.
		    tabStops.Remove(i)
		    
		  next
		  
		  ' Set the array in the Paragraph to the passed in array.
		  tabStops = aroTabStops
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function setupChange(startPosition as integer, endPosition as integer, ByRef startIndex as integer, ByRef endIndex as integer) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim si as integer
		  Dim so as integer
		  Dim ei as integer
		  Dim eo as integer
		  Dim styleLength as integer
		  
		  ' Make sure the positions are up to date.
		  updatePositions
		  
		  ' Is there anything in this paragraph?
		  if getLength > 0 then
		    
		    ' Check the ranges.
		    startPosition = Max(startPosition, 0)
		    endPosition = Min(endPosition, getLength)
		    
		    ' Is there anything to change?
		    if (startPosition = 0) and (endPosition = 0) then return false
		    
		    ' Find the starting and ending positions.
		    findRunItem(startPosition, si, so)
		    findRunItem(endPosition, ei, eo)
		    
		    ' Is there anything to do?
		    if (si = -1) or (ei = -1) then return false
		    
		    ' Are we in the same run item?
		    if si = ei then
		      
		      ' Get the length of the text in the style.
		      styleLength = items(si).getLength
		      
		      ' Is there anything to do?
		      if (items(si) isa FTStyleRun) and (styleLength > 0) and _
		        (styleLength <> (eo - so + 1)) then
		        
		        ' Split the run.
		        splitItem(ei, eo + 1)
		        splitItem(si, so)
		        
		        ' Set the indexes.
		        startIndex = si + 1
		        endIndex = startIndex
		        
		      else
		        
		        ' Set the indexes.
		        startIndex = si
		        endIndex = ei
		        
		      end if
		      
		    else
		      
		      ' Is there anything to do with the end run?
		      if (items(ei) isa FTStyleRun) and (ei < items(ei).getLength) then
		        
		        ' Split the run.
		        splitItem(ei, eo + 1)
		        
		      end if
		      
		      ' Set the end index.
		      endIndex = ei
		      
		      ' Is there anything to do with the starting run?
		      if (items(si) isa FTStyleRun) and _
		        (not ((si = 0) and (so = 1))) then
		        
		        ' Split the run.
		        splitItem(si, so)
		        
		        ' Set the start index.
		        startIndex = si + 1
		        
		        ' Adjust the end index.
		        endIndex = ei + 1
		        
		      else
		        
		        ' Set the start index.
		        startIndex = si
		        
		      end if
		      
		    end if
		    
		  else
		    
		    ' Use the first style run.
		    startIndex = 0
		    endIndex = 0
		    
		  end if
		  
		  ' Mark it for an update.
		  makeDirty
		  
		  ' It is ready.
		  return true
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub spellCheckParagraph(forceUpdate as boolean = true)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim text as string
		  Dim words() as FTSpellCheckWord
		  Dim word as FTSpellCheckWord
		  Dim item as FTObject
		  
		  ' Is there anything to check?
		  if getLength = 0 then return
		  
		  ' We spell checked the paragraph.
		  spellingDirty = false
		  
		  ' Get the paragraph text.
		  text = getText
		  
		  ' Is there anything to look at?
		  if Trim(text) = "" then return
		  
		  ' Clear out any misspelled word indicators.
		  for each item in items
		    
		    ' Is this a style run?
		    if item isa FTStyleRun then
		      
		      ' Turn off the misspelled indicator.
		      FTStyleRun(item).changeMisspelledWord(false)
		      
		    end if
		    
		  next
		  
		  ' Spell check the paragraph.
		  words = parentControl.callSpellCheckParagraphEvent(text)
		  
		  ' Are there any misspelled words?
		  if Ubound(words) > -1 then
		    
		    ' Mark all the words with the misspelled indicator.
		    for each word in words
		      
		      ' Mark the word as misspelled.
		      changeMisspelledWord(word.wordStart, word.wordEnd, true)
		      
		    next
		    
		    ' Clean up any internal left overs.
		    optimizeParagraph
		    
		    ' Mark the paragraph as dirty.
		    makeDirty
		    
		    ' Should perform an update?
		    if forceUpdate then
		      
		      ' Update the display.
		      parentControl.update(true, true)
		      
		    end if
		    
		  end if
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub splitItem(index as integer, offset as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim fto as FTObject
		  Dim fto1 as FTObject
		  
		  ' Are we in range?
		  if (index < 0) or (index > Ubound(items)) then return
		  
		  ' Get the target item.
		  fto = items(index)
		  
		  ' Create the second half of the string.
		  fto1 = fto.clone
		  fto1.deleteLeft(offset)
		  
		  ' Is there anything to add?
		  if fto1.getLength <> 0 then
		    
		    ' Create the first half of the string.
		    fto.deleteRight(offset - 1)
		    
		    ' Insert the second half of the string.
		    items.Insert(index + 1, fto1)
		    
		  end if
		  
		  ' Update the positions in the paragraph.
		  updatePositions
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub trimEndPosition(startIndex as integer, startOffset as integer, ByRef endIndex as integer, ByRef endOffset as integer)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim j as integer
		  Dim text as string
		  Dim endPos as integer
		  Dim startPos as integer
		  Dim ch as string
		  
		  ' Get the end position.
		  endPos = getPosition(endIndex, endOffset)
		  
		  ' Retrieve the target text.
		  text = getText(true)
		  
		  ' Are we at the end of the text?
		  if endPos = length then return
		  
		  ' Is the next character a picture?
		  if Asc(mid(text, endPos + 1, 1)) = 0 then return
		  
		  ' Is the end character a space?
		  if isSpace(mid(text, endPos, 1)) and (pa.alignment = FTParagraph.Alignment_Type.Left) then
		    
		    '--------------------------------------------------
		    ' Look forwards for a non-space.
		    '--------------------------------------------------
		    
		    ' Is the last character a non-tab?
		    if mid(text, endPos, 1) <> Chr(9) then
		      
		      ' Scan for the end of the line.
		      for i = (endPos + 1) to length
		        
		        ' Get a character.
		        ch = mid(text, i, 1)
		        
		        ' Is this a non-space character?
		        if not isSpace(ch) then
		          
		          ' Retrieve the index and offset.
		          getIndexOffsetFromPosition(i - 1, endIndex, endOffset)
		          
		          ' We are done.
		          return
		          
		        end if
		        
		      next
		      
		    end if
		    
		  else
		    
		    '--------------------------------------------------
		    ' Look backwards for a space.
		    '--------------------------------------------------
		    
		    ' Get the starting position.
		    startPos = getPosition(startIndex, startOffset)
		    
		    ' Search through the text.
		    for i = endPos downto startPos
		      
		      ' Have we found a space?
		      if isSpace(mid(text, i, 1)) then
		        
		        ' Is the text right justified?
		        if pa.alignment = FTParagraph.Alignment_Type.Right then
		          
		          ' Look for a non-space.
		          for j = i downto startPos
		            
		            ' Is this a non-space?
		            if not isSpace(mid(text, j, 1)) then
		              
		              ' Retrieve the index and offset.
		              getIndexOffsetFromPosition(j, endIndex, endOffset)
		              
		              ' We are done.
		              return
		              
		            end if
		            
		          next
		          
		        end if
		        
		        ' Retrieve the index and offset.
		        getIndexOffsetFromPosition(i, endIndex, endOffset)
		        
		        ' We are done.
		        return
		        
		      end if
		      
		    next
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub trimLines()
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  
		  ' Get the number of lines.
		  count = Ubound(lines)
		  
		  ' Trim the lines.
		  for i = 0 to count
		    
		    ' Trim the line.
		    lines(i).trim(pa.alignment)
		    
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub trimStartPosition(ByRef startIndex as integer, ByRef startOffset as integer)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim text as string
		  Dim startPos as integer
		  Dim ch as integer
		  
		  ' Is there anything to do?
		  if (startIndex = 0) and (startOffset = 0) then return
		  
		  ' Get the start position.
		  startPos = getPosition(startIndex, startOffset)
		  
		  ' Retrieve the target text.
		  text = getText(true)
		  
		  ' Is this paragraph right aligned?
		  if pa.alignment = FTParagraph.Alignment_Type.Right then
		    
		    ' Scan for a non-space character.
		    for i = startPos downto 1
		      
		      ' Is this a non-space character?
		      if Asc(mid(text, i, 1)) > 32 then
		        
		        ' Move to the next space.
		        i = i + 1
		        
		        ' Retrieve the index and offset.
		        getIndexOffsetFromPosition(i, startIndex, startOffset)
		        
		        ' We are done.
		        return
		        
		      end if
		      
		    next
		    
		  else
		    
		    ' Scan for a non-space character.
		    for i = startPos to length
		      
		      ' Get the character.
		      ch = Asc(mid(text, i, 1))
		      
		      ' Is this a non-space character?
		      if (ch > 32) or (ch = 9) or (ch = 0) then
		        
		        ' Retrieve the index and offset.
		        getIndexOffsetFromPosition(i, startIndex, startOffset)
		        
		        ' We are done.
		        return
		        
		      end if
		      
		    next
		    
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub updateData()
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  
		  ' Are background updates allowed
		  if not parentControl.AllowBackgroundUpdates then return
		  
		  ' Get the number of items.
		  count = Ubound(items)
		  
		  ' Update the items in the paragraph.
		  for i = 0 to count
		    
		    ' Is this a picture?
		    if items(i) isa FTPicture then
		      
		      ' Update the RTF data.
		      FTPicture(items(i)).updateData(false)
		      
		    end if
		    
		  next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub updatePositions(force as boolean = false)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim currentPosition as integer
		  
		  ' Do we need to recalculate?
		  if force or positionsChanged then
		    
		    ' Start at the beginning.
		    currentPosition = 1
		    
		    ' Get the number of FTObjects
		    count = Ubound(items)
		    
		    ' Set the position
		    for i = 0 to count
		      
		      ' Fill in the starting position.
		      items(i).setPosition(currentPosition)
		      
		      ' Move to the next starting position.
		      currentPosition = items(i).getEndPosition + 1
		      
		    next
		    
		    ' Clear the flag.
		    positionsChanged = false
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub updateSettings(style as FTParagraphStyle)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Update the paragraph settings.
		  setAfterSpace(style.getAfterSpace)
		  setFirstIndent(style.getFirstIndent)
		  setAlignment(style.getAlignment)
		  setBeforeSpace(style.getBeforeSpace)
		  setLeftMargin(style.getLeftMargin)
		  setLineSpacing(style.getLineSpacing)
		  setRightMargin(style.getRightMargin)
		  
		  ' Was the background color defined?
		  if style.isBackgroundColorDefined then
		    
		    ' Set the background color.
		    setBackgroundColor(style.getBackgroundColor)
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub updateWithStyle(style as FTCharacterStyle)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim item as FTObject
		  
		  ' Scan the items.
		  for each item in items
		    
		    ' Is this a text run?
		    if item isa FTStyleRun then
		      
		      ' Change the style.
		      FTStyleRun(item).updateWithStyle(style)
		      
		    end if
		    
		  next
		  
		  ' Mark the paragraph as dirty.
		  makeDirty
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub updateWithStyle(startPosition as integer, endPosition as integer, style as FTCharacterStyle)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim startIndex as integer
		  Dim endIndex as integer
		  
		  ' Get the items to change.
		  if setupChange(startPosition, endPosition, startIndex, endIndex) then
		    
		    ' Change the full styles.
		    for i = startIndex to endIndex
		      
		      ' Is this a style run?
		      if items(i) isa FTStyleRun then
		        
		        ' Change the style.
		        FTStyleRun(items(i)).updateWithStyle(style)
		        
		      end if
		      
		    next
		    
		  end if
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub verifyAttibutes()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Is this configuration possible?
		  if (pa.leftMargin + pa.rightMargin) >= doc.getMarginWidth then
		    
		    ' Check it against the alignment of the paragraph.
		    select case pa.alignment
		      
		    Case FTParagraph.Alignment_Type.Left
		      
		      pa.rightMargin = 0
		      
		    Case FTParagraph.Alignment_Type.Center
		      
		      pa.leftMargin = 0
		      pa.rightMargin = 0
		      
		    case FTParagraph.Alignment_Type.Right
		      
		      pa.leftMargin = 0
		      
		    end select
		    
		    ' Is there still something wrong?
		    if (pa.leftMargin + pa.rightMargin) >= doc.getMarginWidth then
		      
		      ' Remove the margin values.
		      pa.leftMargin = 0
		      pa.rightMargin = 0
		      
		    end if
		    
		    ' Reset the internals.
		    reset
		    
		  end if
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private absoluteIndex As integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private addDefaultTabStops As boolean = true
	#tag EndProperty

	#tag Property, Flags = &h21
		Private afterParagraphSpaceCache As double = -1
	#tag EndProperty

	#tag Property, Flags = &h21
		Private beforeParagraphSpaceCache As double = -1
	#tag EndProperty

	#tag Property, Flags = &h21
		Private characterInsertionPoint As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private currentText As string
	#tag EndProperty

	#tag Property, Flags = &h21
		Private currentTextWithPictures As string
	#tag EndProperty

	#tag Property, Flags = &h21
		Private dirty As boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private height As double = -1
	#tag EndProperty

	#tag Property, Flags = &h21
		Private id As integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private items() As FTObject
	#tag EndProperty

	#tag Property, Flags = &h21
		Private length As integer = -1
	#tag EndProperty

	#tag Property, Flags = &h21
		Private lines() As FTLine
	#tag EndProperty

	#tag Property, Flags = &h21
		Private pa As ParagraphAttributes
	#tag EndProperty

	#tag Property, Flags = &h21
		Private positionsChanged As boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private proxies() As FTParagraphProxy
	#tag EndProperty

	#tag Property, Flags = &h21
		Private selected As boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		selectPilcrow As boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private singleLineWidth As double = -1
	#tag EndProperty

	#tag Property, Flags = &h21
		Private spellingDirty As boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private tabStops() As FTTabStop
	#tag EndProperty

	#tag Property, Flags = &h21
		Private wordCountCache As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h21
		Private wrapWidthCache As double = -1
	#tag EndProperty


	#tag Constant, Name = TABSTOP_SEPARATOR, Type = String, Dynamic = False, Default = \":", Scope = Public
	#tag EndConstant

	#tag Constant, Name = zCENTER_ALIGNMENT, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = zLEFT_ALIGNMENT, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = zNO_ALIGNMENT, Type = Double, Dynamic = False, Default = \"0", Scope = Public
	#tag EndConstant

	#tag Constant, Name = zRIGHT_ALIGNMENT, Type = Double, Dynamic = False, Default = \"3", Scope = Public
	#tag EndConstant


	#tag Enum, Name = Alignment_Type, Type = Integer, Flags = &h0
		None
		  Left
		  Center
		Right
	#tag EndEnum


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
			Name="selectPilcrow"
			Group="Behavior"
			Type="boolean"
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
