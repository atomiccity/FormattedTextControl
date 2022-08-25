#tag Class
Protected Class RTFWriter
	#tag Method, Flags = &h0
		Sub addCharacterStyle(style as RTFCharacterStyle)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Add the style to the list.
		  characterStyles.append(style)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub addParagraphStyle(style as RTFParagraphStyle)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Add the style to the list.
		  paragraphStyles.append(style)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub addTabStop(tableader as Integer, tabStop as double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Add the tab stop.
		  getContext.addTabStop(tableader, tabStop)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Create the default context.
		  defaultContext = new RTFContext
		  
		  ' Start with the default context.
		  currentContext = defaultContext
		  
		  ' Create the document attributes.
		  docAttributes = new RTFDocumentAttributes
		  
		  ' Create the storage for font names.
		  fontList = new Dictionary
		  
		  ' Create the storage for the colors.
		  colorList = new Dictionary
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub endGroup()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Clear the subcontext.
		  subcontext = nil
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub findColors()
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  
		  ' Clear the color list.
		  colorList.Clear
		  
		  ' Save a default of black.
		  colorList.value(RTFUtilities.colorToString(&c000000)) = ""
		  
		  ' Scan the default context.
		  defaultContext.findColors(colorList)
		  
		  ' Get the number of contexts.
		  count = Ubound(contextList)
		  
		  ' Scan the contexts for colors.
		  for i = 0 to count
		    
		    ' Scan the context.
		    contextList(i).findColors(colorList)
		    
		  next
		  
		  ' Get the number of character styles.
		  count = Ubound(characterStyles)
		  
		  ' Scan the character styles for colors.
		  for i = 0 to count
		    
		    ' Scan the style.
		    characterStyles(i).findColors(colorList)
		    
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub findFontNames()
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  
		  ' Clear the font list.
		  fontList.Clear
		  
		  ' Scan the default context.
		  defaultContext.findFontNames(fontList)
		  
		  ' Get the number of contexts.
		  count = Ubound(contextList)
		  
		  ' Scan the contexts for fonts.
		  for i = 0 to count
		    
		    ' Scan the context.
		    contextList(i).findFontNames(fontList)
		    
		  next
		  
		  ' Does the default font exist?
		  if defaultContext.font <> "" then
		    
		    ' Remove the default font.
		    fontList.Remove(defaultContext.font)
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getCharacterStyle(styleName as string) As string
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  
		  ' Get the number of styles.
		  count = Ubound(characterStyles)
		  
		  ' Scan for the style.
		  for i = 0 to count
		    
		    ' Is this the style we are looking for?
		    if styleName = characterStyles(i).getStyleName then
		      
		      ' We found it.
		      return "\cs" + Str(characterStyles(i).getStyleNumber) + " " _
		      + characterStyles(i).getAttributes(self)
		      
		    end if
		    
		  next
		  
		  ' Not found.
		  return ""
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getColorNumber(c as Color) As string
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Get the color number.
		  'In another project colorList dictionary could not find the key, so it threw a KeyNotFoundException
		  'I'm not going to implement the same fix here but if you run into this issue
		  'check to make sure the key exists if not Return "0" which should be the default color number.
		  return colorList.value(RTFUtilities.colorToString(c))
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getContext() As RTFContext
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Are we working on a subcontext?
		  if subcontext is nil then
		    
		    ' Return the current context.
		    return currentContext
		    
		  else
		    
		    ' Return the subcontext.
		    return subcontext
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getFontNumber(fontName as string) As string
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Get the font number.
		  return fontList.value(fontName)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetHyperLinkColorNumber() As string
		  return cstr(iHyperlinkColor)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getParagraphStyle(styleName as string) As string
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  
		  ' Get the number of styles.
		  count = Ubound(paragraphStyles)
		  
		  ' Scan for the style.
		  for i = 0 to count
		    
		    ' Is this the style we are looking for?
		    if styleName = paragraphStyles(i).getStyleName then
		      
		      ' We found it.
		      return "\s" + Str(paragraphStyles(i).getStyleNumber) + " " _
		      + paragraphStyles(i).getAttributes(self)
		      
		    end if
		    
		  next
		  
		  ' Not found.
		  return ""
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getRTF() As string
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Scan for the font names.
		  findFontNames
		  findColors
		  
		  ' Create the contents.
		  writeProlog
		  writeFontTable
		  writeColorTable
		  writeStylesheet
		  writeInfogroup
		  writePreliminaries
		  writeContent
		  
		  ' Add the closing brace.
		  rtfData.Append("}")
		  
		  ' Return the RTF data.
		  return join(rtfData, "")
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub newParagraph()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim context as RTFContext
		  
		  ' Create a context.
		  context = new RTFContext
		  
		  ' Save the context.
		  contextList.Append(context)
		  
		  ' Make it the current context.
		  currentContext = context
		  
		  ' Clear the subcontext.
		  subcontext = nil
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setAfterSpace(space as double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set the alignment.
		  getContext.afterSpace = space
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setAlignment(alignment as RTFAlignment)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set the alignment.
		  getContext.alignment = alignment
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setBackgroundColor(c as color)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim context as RTFContext
		  
		  ' Get the context.
		  context = getContext
		  
		  ' Set the color.
		  context.backgroundColor = c
		  context.useBackgroundColor = true
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setBeforeSpace(space as double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set the alignment.
		  getContext.beforeSpace = space
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setBold()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Turn on bold.
		  getContext.bold = true
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setCharacterSpacing(spacing As Integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set the font size.
		  getContext.characterSpacing = spacing
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setCharacterStyle(styleName as string)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the character style name.
		  getContext.characterStyleName = styleName
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setDocumentMargins(leftMargin as double, rightMargin as double, topMargin as double, bottomMargin as double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set the document margins.
		  docAttributes.leftMargin = RTFUtilities.inchesToTWIPS(leftMargin)
		  docAttributes.rightMargin = RTFUtilities.inchesToTWIPS(rightMargin)
		  docAttributes.topMargin = RTFUtilities.inchesToTWIPS(topMargin)
		  docAttributes.bottomMargin = RTFUtilities.inchesToTWIPS(bottomMargin)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setFirstIndent(indent as double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set the first indent.
		  getContext.firstIndent = indent
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setFont(font as string)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set the font.
		  getContext.font = font
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setFontSize(fontSize as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set the font size.
		  getContext.fontSize = fontSize
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setForegroundColor(c as color)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim context as RTFContext
		  
		  ' Get the context.
		  context = getContext
		  
		  ' Set the color.
		  context.foregroundColor = c
		  context.useForegroundColor = true
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setHyperLink(HyperLink as string)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Get the context.
		  Dim context as RTFContext = getContext
		  
		  ' Set the Hyperlink.
		  context.HyperLink = HyperLink
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setInfoGroup(creator As String, version As String)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set the Creator.
		  Me.Creator = creator
		  
		  ' Set the Version.
		  Me.Version = version
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setItalic()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Turn on italic.
		  getContext.italic = true
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setLeftMargin(margin as double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set the left margin.
		  getContext.leftMargin = margin
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setLineSpacing(lineSpacing as double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set the line spacing.
		  getContext.lineSpacing = lineSpacing
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setPageBreak()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set the page break.
		  getContext.pageBreak = true
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setPageSize(width as double, height as double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set the page size.
		  docAttributes.pageWidth = RTFUtilities.inchesToTWIPS(width)
		  docAttributes.pageHeight = RTFUtilities.inchesToTWIPS(height)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setParagraphBackgroundColor(c as color)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim context as RTFContext
		  
		  ' Get the context.
		  context = getContext
		  
		  ' Set the color.
		  context.paragraphBackgroundColor = c
		  context.useParagraphBackgroundColor = true
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setParagraphStyle(styleName as string)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the character style name.
		  getContext.paragraphStyleName = styleName
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setPicture(pictData as string)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the picture data.
		  getContext.pictData = pictData
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setPlain()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Turn on plain.
		  getContext.plain = true
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setRightMargin(margin as double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set the right margin.
		  getContext.rightMargin = margin
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setShadow()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Turn on shadow.
		  getContext.shadow = true
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setShadowBlur(value As Double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set the shadow blur size.
		  getContext.shadowBlur = value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setShadowColor(c as color)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim context as RTFContext
		  
		  ' Get the context.
		  context = getContext
		  
		  ' Set the color.
		  context.shadowColor = c
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setShadowOffset(value as Double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim context as RTFContext
		  
		  ' Get the context.
		  context = getContext
		  
		  ' Set the offset.
		  context.shadowOffset = value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setShadowOpacity(value as Integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim context as RTFContext
		  
		  ' Get the context.
		  context = getContext
		  
		  ' Set the opacity.
		  context.shadowOpacity = value
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setStrikeThrough()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Turn on strike through.
		  getContext.strikeThrough = true
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setSubscript(fontSize as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Turn on sub script.
		  getContext.setSubscript(fontSize)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setSuperscript(fontSize as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Turn on super script.
		  getContext.setSuperscript(fontSize)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setText(text as string)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim ch as integer
		  Dim sa() as string
		  
		  ' Get the length of the text.
		  count = text.len
		  
		  ' Convert any character to escaped notation that needs it.
		  for i = 1 to count
		    
		    ' Get the character.
		    ch = asc(mid(text, i, 1))
		    
		    ' Is this a \, {, or }?
		    if (ch = 92) or (ch = 123) or (ch = 125) then
		      
		      ' Add the escaped character.
		      sa.Append("\" + Chr(ch))
		      
		      ' Is this a normal ASCII character?
		    elseif ch <= 127 then
		      
		      ' Add the character.
		      sa.Append(Chr(ch))
		      
		      ' Is this an upper ASCII character?
		    elseif (ch >= 128) and (ch <= 255) then
		      
		      ' Add the escaped character.
		      sa.Append("\'" + Hex(ch))
		      
		      ' Is this a lower unicode character?
		    elseif (ch >= 256) and (ch <= 32768) then
		      
		      ' Add the escaped character.
		      sa.Append("\uc0\u" + Str(ch) + " ")
		      
		      ' Is this a upper unicode character?
		    elseif (ch >= 32769) and (ch <= 65535) then
		      
		      ' Add the escaped character.
		      sa.Append("\uc0\u" + Str(ch - 65536) + " ")
		      
		    else
		      
		      ' Out of range.
		      sa.Append(" " + Hex(ch))
		      
		    end if
		    
		  next
		  
		  ' Set the text.
		  getContext.text = join(sa, "")
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setUnderline()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Turn on underline.
		  getContext.underline = true
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub startGroup()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Create a subcontext.
		  subcontext = currentContext.newSubcontext
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub writeCharacterStyle(style as RTFCharacterStyle)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Add the character style indicator.
		  rtfData.Append(EndOfLine + "{\*\cs" + Str(style.getStyleNumber) + " ")
		  
		  ' Make the character style additive.
		  rtfData.Append("\additive ")
		  
		  ' Add the character specific attributes.
		  rtfData.Append(style.getAttributes(self))
		  
		  ' Add the style name.
		  rtfData.Append(style.getStyleName)
		  
		  ' Terminate the style.
		  rtfData.Append(";}")
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub writeColorTable()
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim colorNumber as integer
		  Dim keys() as variant
		  Dim red as string
		  Dim green as string
		  Dim blue as string
		  
		  ' Add the header with the default color.
		  rtfData.Append(EndOfLine + "{\colortbl ;")
		  
		  ' Get the number of colors to add.
		  count = colorList.Count - 1
		  
		  ' Get the list of fonts.
		  keys = colorList.keys
		  
		  ' Start with the second color.
		  colorNumber = 1
		  
		  ' Add the colors to the color table.
		  for i = 0 to count
		    
		    ' Get the color components.
		    red = NthField(keys(i).StringValue, " ", 1)
		    green = NthField(keys(i).StringValue, " ", 2)
		    blue = NthField(keys(i).StringValue, " ", 3)
		    
		    ' Add the color to the color table.
		    rtfData.Append("\red" + red + "\green" + green + "\blue" + blue + ";")
		    
		    ' Save the color number.
		    colorList.value(keys(i).StringValue) = Str(colorNumber)
		    
		    ' Check to see if our hyperlink color is this one.  If it is, save it for later use.
		    if red = "0" and green = "0" and blue = "255" then
		      iHyperlinkColor = colorNumber
		    end
		    
		    
		    ' Bump up the color number.
		    colorNumber = colorNumber + 1
		    
		  next
		  
		  ' Did we have a Hyperlink Color?  If not, then add it
		  if iHyperlinkColor = -1 then
		    rtfData.Append("\red0\green0\blue255;")
		    iHyperlinkColor = colorNumber
		  end
		  
		  ' Add the terminating brace.
		  rtfData.append("}")
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub writeContent()
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  
		  ' Get the number of paragraphs.
		  count = Ubound(contextList)
		  
		  ' Add all the paragraphs.
		  for i = 0 to count
		    
		    ' Start the paragraph.
		    rtfData.Append(EndOfLine + "{\pard ")
		    
		    ' Get the paragraph.
		    rtfData.Append(contextList(i).getRTF(self))
		    
		    ' Terminate the paragraph.
		    // Mantis Ticket 3820: FIXED: RTFWriter missed "\par" after the last Paragraph
		    rtfData.Append(EndOfLine + "\par}")
		    
		  next
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub writeFontTable()
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim fontNumber as integer
		  Dim keys() as variant
		  
		  ' Add the header.
		  rtfData.Append(EndOfLine + "{\fonttbl ")
		  
		  ' Does the default font exist?
		  if defaultContext.font <> "" then
		    
		    ' Add the default font.
		    rtfData.Append("{\f0\fnil " + defaultContext.font + ";}")
		    
		    ' Bump up the font number.
		    fontNumber = fontNumber + 1
		    
		  end if
		  
		  ' Get the number of fonts to add.
		  count = fontList.Count - 1
		  
		  ' Get the list of fonts.
		  keys = fontList.keys
		  
		  ' Add the fonts to the font table.
		  for i = 0 to count
		    
		    ' Add the font to the font table.
		    rtfData.Append("{\f" + Str(fontNumber) + "\fnil " + keys(i).StringValue + ";}")
		    
		    ' Save the font number.
		    fontList.value(keys(i).StringValue) = "\f" + Str(fontNumber)
		    
		    ' Bump up the font number.
		    fontNumber = fontNumber + 1
		    
		  next
		  
		  ' Add the terminating brace.
		  rtfData.append("}")
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub writeInfoGroup()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Check for existing Creator and/or Author
		  If Creator <> "" Or Version <> "" Then
		    
		    ' Add the Info Group.
		    rtfData.Append(EndOfLine + "{\info ")
		    
		    ' Add the Creator to the info Group.
		    rtfData.Append("\company " + Creator + " ")
		    
		    ' Add the Version to the info Group.
		    rtfData.Append("\version " + Version)
		    
		    ' Terminate the Info Group.
		    rtfData.Append("}")
		    
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub writeParagraphStyle(style as RTFParagraphStyle)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Add the paragraph style indicator.
		  rtfData.Append(EndOfLine + "{\s" + Str(style.getStyleNumber) + " ")
		  
		  ' Add the paragraph specific attributes.
		  rtfData.Append(style.getAttributes(self))
		  
		  ' Add the style name.
		  rtfData.Append(style.getStyleName)
		  
		  ' Terminate the style.
		  rtfData.Append(";}")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub writePreliminaries()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Add the document attributes.
		  rtfData.Append(EndOfLine)
		  rtfData.Append("\margl" + Str(docAttributes.leftMargin) + " " )
		  rtfData.Append("\margr" + Str(docAttributes.rightMargin) + " " )
		  rtfData.Append("\margt" + Str(docAttributes.topMargin) + " " )
		  rtfData.Append("\margb" + Str(docAttributes.bottomMargin) + " " )
		  rtfData.Append("\paperw" + Str(docAttributes.pageWidth) + " " )
		  rtfData.Append("\paperh" + Str(docAttributes.pageHeight) + " " )
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub writeProlog()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Add the prolog.
		  rtfData.Append("{\rtf1 \ansi \deff0 ")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub writeStylesheet()
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim styleNumber as integer
		  
		  ' Is there anything to do?
		  if (Ubound(characterStyles) > -1) or (Ubound(paragraphStyles) > -1) then
		    
		    ' Add the header.
		    rtfData.Append(EndOfLine + "{\stylesheet ")
		    
		    '------------------------------------------
		    ' Paragraph styles.
		    '------------------------------------------
		    
		    ' Get the number of paragraph styles to add.
		    count = Ubound(paragraphStyles)
		    
		    ' Add the paragraph styles.
		    for i = 0 to count
		      
		      ' Assign the style number.
		      paragraphStyles(i).setStyleNumber(styleNumber)
		      
		      ' Write out the paragraph style.
		      writeParagraphStyle(paragraphStyles(i))
		      
		      ' Bump up the style number.
		      styleNumber = styleNumber + 1
		      
		    next
		    
		    '------------------------------------------
		    ' Character styles.
		    '------------------------------------------
		    
		    ' Get the number of character styles to add.
		    count = Ubound(characterStyles)
		    
		    ' Add the character styles.
		    for i = 0 to count
		      
		      ' Assign the style number.
		      characterStyles(i).setStyleNumber(styleNumber)
		      
		      ' Write out the character style.
		      writeCharacterStyle(characterStyles(i))
		      
		      ' Bump up the style number.
		      styleNumber = styleNumber + 1
		      
		    next
		    
		    ' Add the terminating brace.
		    rtfData.append("}")
		    
		  end if
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private characterStyles() As RTFCharacterStyle
	#tag EndProperty

	#tag Property, Flags = &h21
		Private colorList As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private contextList() As RTFContext
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Creator As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private currentContext As RTFContext
	#tag EndProperty

	#tag Property, Flags = &h21
		Private defaultContext As RTFContext
	#tag EndProperty

	#tag Property, Flags = &h21
		Private docAttributes As RTFDocumentAttributes
	#tag EndProperty

	#tag Property, Flags = &h21
		Private fontList As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private iHyperlinkColor As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h21
		Private paragraphStyles() As RTFParagraphStyle
	#tag EndProperty

	#tag Property, Flags = &h21
		Private rtfData() As string
	#tag EndProperty

	#tag Property, Flags = &h21
		Private subcontext As RTFContext
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Version As String
	#tag EndProperty


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
