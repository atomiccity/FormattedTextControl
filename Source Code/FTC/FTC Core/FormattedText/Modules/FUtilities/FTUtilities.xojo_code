#tag Module
Protected Module FTUtilities
	#tag Method, Flags = &h1
		Protected Function booleanToString(value as boolean) As string
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Is this value true or false?
		  if value then
		    
		    return "true"
		    
		  else
		    
		    return "false"
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub clipToMarginGuide(doc as FTDocument, ByRef x as integer, ByRef y as integer, ByRef width as integer, ByRef height as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim dm as DisplayMargins
		  Dim scale as double
		  Dim delta as integer
		  Dim limit as integer
		  
		  ' Get the scale.
		  scale = doc.parentControl.getScale
		  
		  ' Get the marings.
		  dm = doc.getDisplayMargins
		  
		  '---------------------------------------------------
		  ' X.
		  '---------------------------------------------------
		  
		  ' Get the left margin.
		  limit = FTUtilities.getScaledLength(dm.leftMargin, scale)
		  
		  ' Are we before the left margin?
		  if x < limit then
		    
		    ' Compute the difference.
		    delta = limit - x
		    
		    ' Adjust the parameters.
		    x = x + delta
		    width = width - delta
		    
		  end if
		  
		  '---------------------------------------------------
		  ' Y.
		  '---------------------------------------------------
		  
		  ' Get the top margin.
		  limit = FTUtilities.getScaledLength(dm.topMargin, scale)
		  
		  ' Are we before the top margin?
		  if y < limit then
		    
		    ' Compute the difference.
		    delta = limit - y
		    
		    ' Adjust the parameters.
		    y = y + delta
		    height = height - delta
		    
		  end if
		  
		  '---------------------------------------------------
		  ' Width.
		  '---------------------------------------------------
		  
		  ' Get the right margin.
		  limit = FTUtilities.getScaledLength(doc.getPageWidth - dm.rightMargin, scale)
		  
		  ' Are we before the left margin?
		  if (x + width) > limit then
		    
		    ' Compute the difference.
		    delta = (x + width) - limit
		    
		    ' Adjust the width.
		    width = width - delta
		    
		  end if
		  
		  '---------------------------------------------------
		  ' Height.
		  '---------------------------------------------------
		  
		  ' Get the bottom margin.
		  limit = FTUtilities.getScaledLength(doc.getPageHeight - dm.bottomMargin, scale)
		  
		  if (y + height) > limit then
		    
		    ' Compute the difference.
		    delta = (y + height) - limit
		    
		    ' Adjust the height.
		    height = height - delta
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function colorToString(c as Color) As string
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the color as an RGB string.
		  return Str(c.red) + " " + Str(c.green) + " " + Str(c.blue)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function convertRTFToText(rtf as string) As string
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim cw as FTCConverterWindow
		  
		  ' Create the window.
		  cw = new FTCConverterWindow
		  
		  ' Insert the RTF.
		  cw.target.setRTF(rtf)
		  
		  ' Get the text version.
		  return cw.target.getDoc.getText
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function convertRTFToXML(rtf as string) As string
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim cw as FTCConverterWindow
		  
		  ' Create the window.
		  cw = new FTCConverterWindow
		  
		  ' Insert the RTF.
		  cw.target.setRTF(rtf)
		  
		  ' Get the XML version.
		  return cw.target.getDoc.getXML
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function convertTextToRTF(text as string) As string
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim cw as FTCConverterWindow
		  
		  ' Create the window.
		  cw = new FTCConverterWindow
		  
		  ' Insert the text.
		  cw.target.setText(text)
		  
		  ' Get the RTF version.
		  return cw.target.getDoc.getRTF
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function convertTextToXML(text as string) As string
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim cw as FTCConverterWindow
		  
		  ' Create the window.
		  cw = new FTCConverterWindow
		  
		  ' Insert the text.
		  cw.target.setText(text)
		  
		  ' Get the XML version.
		  return cw.target.getDoc.getXML
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function convertXMLToRTF(xml as string) As string
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim cw as FTCConverterWindow
		  
		  ' Create the window.
		  cw = new FTCConverterWindow
		  
		  ' Insert the XML.
		  cw.target.setXML(xml)
		  
		  ' Get the RTF version.
		  return cw.target.getDoc.getRTF
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function convertXMLToText(xml as string) As string
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim cw as FTCConverterWindow
		  
		  ' Create the window.
		  cw = new FTCConverterWindow
		  
		  ' Insert the XML.
		  cw.target.setXML(xml)
		  
		  ' Get the text version.
		  return cw.target.getDoc.getText
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub drawBorder(g as graphics, x as integer, y as integer, width as integer, height as integer, penWidth as integer, c as color, scale as double = 1.0)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set up the drawing characteristics.
		  penWidth = penWidth * scale
		  g.PenWidth = penWidth
		  g.PenHeight = penWidth
		  g.ForeColor = c
		  
		  #if TargetWindows
		    
		    ' Draw the border.
		    g.DrawRect(x + 1, y + 1, width, height)
		    
		  #else
		    
		    ' Draw the border.
		    g.DrawRect(x, y, width + 1, height + 1)
		    
		  #endif
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ExtractExtension(f As FolderItem) As String
		  dim n as integer
		  Dim FileName As String
		  
		  Dim FileExt As String
		  
		  
		  if f = nil or Not f.exists Then
		    Return ""
		  End
		  
		  
		  FileName=f.name
		  n = countFields(FileName, ".")
		  if n > 1 then
		    FileExt=nthField(FileName, ".", n)
		    
		    Return FileExt
		    
		  else
		    return ""
		  end
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ExtractExtension(FileName As String) As String
		  Dim n As Integer
		  
		  
		  n = countFieldsb(FileName, ".")
		  if n > 1 then
		    
		    Return nthField(FileName, ".", n)
		  else
		    return ""
		  end
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function findEndOfWord(text as string, offset as integer, forward as boolean) As integer
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim startIndex as integer
		  Dim endIndex as integer
		  Dim interval as integer
		  
		  ' Are we searching forwards or backwards?
		  if forward then
		    
		    ' Set up for searching forwards
		    startIndex = offset
		    endIndex = text.len
		    interval = 1
		    
		  else
		    
		    ' Set up for searching backwards.
		    startIndex = offset
		    endIndex = 1
		    interval = -1
		    
		  end if
		  
		  ' Search for a word boundary.
		  for i = startIndex to endIndex step interval
		    
		    ' Is the word divider?
		    if isWordDivider(Mid(text, i, 1)) then
		      
		      ' Return the word boundary.
		      return i - interval
		      
		    end if
		    
		  next
		  
		  ' Return the last index.
		  return endIndex
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function flipScriptLevel(level as integer, subscript as boolean) As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Is this a subscript?
		  if subscript then
		    
		    ' Are we already a subscript?
		    if level < 0 then
		      
		      ' Turn it off.
		      level = 0
		      
		    else
		      
		      ' Make it a subscript.
		      level = -1
		      
		    end if
		    
		  else
		    
		    ' Are we already a superscript?
		    if level > 0 then
		      
		      ' Turn it off.
		      level = 0
		      
		    else
		      
		      ' Make it a superscript.
		      level = 1
		      
		    end if
		    
		  end if
		  
		  ' Return the script level.
		  return level
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function getDoubleClickTime() As integer
		  #If Not DebugBuild Then
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  dim time as Integer
		  
		  // Mac
		  #If TargetMacOS Then
		    Declare Function NSClassFromString Lib "Cocoa" (name As CFStringRef) As Ptr
		    Declare Function getTime Lib "AppKit" selector "doubleClickInterval" (id As Ptr) As Double
		    
		    ' Get the double click time.
		    time = getTime(NSClassFromString("NSEvent")) * 60
		    
		  #EndIf
		  
		  // Windows
		  #If TargetWindows
		    Declare Function GetDoubleClickTime Lib "User32.DLL" () As Integer
		    
		    ' Get the double click time.
		    time = GetDoubleClickTime * 0.06
		    
		  #EndIf
		  
		  // Linux
		  
		  ' Linux is not officially supported, but here is a code snippet
		  ' from the Language Reference.
		  
		  #If TargetLinux
		    // Use GTKLib constant to declare into the right lib
		    #If XojoVersion < 2017.02 Then
		      Const GTK_Lib = "libgtk-x11-2.0.so"
		      
		    #Else
		      Const GTK_Lib = "libgtk-3.so"
		      
		    #EndIf
		    
		    Declare Function gtk_settings_get_default Lib GTK_Lib As Ptr
		    
		    Declare Sub g_object_get Lib GTK_Lib (Obj As Ptr, first_property_name As CString, ByRef doubleClicktime As Integer, Null As Integer)
		    
		    Dim gtkSettings As MemoryBlock
		    Dim doubleclicktime As Integer
		    
		    gtkSettings = gtk_settings_get_default
		    
		    g_object_get(gtkSettings,"gtk-double-click-time", doubleClickTime, 0)
		    
		    // DoubleClickTime now holds the number of milliseconds
		    time = DoubleClickTime / 1000.0 * 60
		    
		  #EndIf
		  
		  ' Return the double click time.
		  Return time
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub getMacSystemVersion(ByRef sys1 as integer, ByRef sys2 as integer, ByRef sys3 as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Initialize the variables.
		  sys1 = 0
		  sys2 = 0
		  sys3 = 0
		  
		  #if TargetMacOS
		    
		    ' ' Get the system version for the mac.
		    ' if System.Gestalt("sys1", sys1) and _
		    ' System.Gestalt("sys2", sys2) and _
		    ' System.Gestalt("sys3", sys3) then
		    ' end if
		    
		    dim oVersion as OSVersionInfo = OSXVersionInfo.OSVersion
		    
		    sys1 = oVersion.major
		    sys2 = oVersion.minor
		    sys3 = oVersion.bug
		    
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function getNewID() As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Have we reached the end?
		  if nextID >= 2147483647 then nextID = 0
		  
		  ' Move to the next ID.
		  nextID = nextID + 1
		  
		  ' Return the new ID.
		  return nextID
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function getScaledLength(length as double, scale as double = 1.0, resolution as double = 72.0) As double
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Get the absolute length.
		  return length * resolution * scale
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getStringAscent(extends obj as FTStyleRun, scale as double) As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set up for the correct font.
		  scratchGraphic.TextFont = obj.font
		  scratchGraphic.TextSize = obj.getFontSize
		  scratchGraphic.Bold = obj.bold
		  scratchGraphic.Italic = obj.italic
		  
		  ' Compute the ascent of the string.
		  return scratchGraphic.TextAscent * scale
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function getStringAscent(font as string, fontSize as integer, scale as double) As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set up for the correct font.
		  scratchGraphic.TextFont = font
		  scratchGraphic.TextSize = Round(fontSize * scale)
		  scratchGraphic.Bold = false
		  scratchGraphic.Italic = false
		  
		  ' Compute the ascent of the string.
		  return scratchGraphic.TextAscent
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getStringHeight(extends obj as FTStyleRun, scale as double) As double
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set up for the correct font.
		  scratchGraphic.TextFont = obj.font
		  scratchGraphic.TextSize = obj.getFontSize
		  scratchGraphic.Bold = obj.bold
		  scratchGraphic.Italic = obj.italic
		  
		  ' Compute the height of the string.
		  return scratchGraphic.TextHeight * scale
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function getStringHeight(font as string, fontSize as integer, scale as double) As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set up for the correct font.
		  scratchGraphic.TextFont = font
		  scratchGraphic.TextSize = fontSize
		  
		  ' Compute the height of the string.
		  return scratchGraphic.TextHeight * scale
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getStringWidth(extends obj as FTCharacterStyle, text as string) As double
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set up for the correct font.
		  scratchGraphic.TextFont = obj.getFontName
		  scratchGraphic.TextSize = obj.getFontSize
		  scratchGraphic.Bold = obj.getBold
		  scratchGraphic.Italic = obj.getItalic
		  #If XojoVersion > 2015.03 Then
		    scratchGraphic.CharacterSpacing = obj.getCharacterSpacing
		  #Endif
		  
		  ' Compute the length of the sub-string.
		  return Floor(scratchGraphic.StringWidth(text))
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getStringWidth(extends obj as FTStyleRun, scale as double) As double
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set up for the correct font.
		  scratchGraphic.TextFont = obj.font
		  scratchGraphic.TextSize = Round(obj.getFontSize * scale)
		  scratchGraphic.Bold = obj.bold
		  scratchGraphic.Italic = obj.italic
		  #If XojoVersion > 2015.03 Then
		    scratchGraphic.CharacterSpacing = obj.characterSpacing
		  #Endif
		  
		  ' Compute the length of the string.
		  return Floor(scratchGraphic.StringWidth(obj.getText))
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getStringWidth(extends obj as FTStyleRun, startPosition as integer, endPosition as integer, scale as double = 1.0) As double
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set up for the correct font.
		  scratchGraphic.TextFont = obj.font
		  scratchGraphic.TextSize = Round(obj.getFontSize * scale)
		  scratchGraphic.Bold = obj.bold
		  scratchGraphic.Italic = obj.italic
		  #If XojoVersion > 2015.03 Then
		    scratchGraphic.CharacterSpacing = obj.characterSpacing
		  #Endif
		  
		  ' Compute the length of the sub-string.
		  return Floor(scratchGraphic.StringWidth(obj.getText(startPosition, endPosition)))
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getStringWidth(extends obj as FTStyleRun, text as string, scale as double = 1.0) As double
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set up for the correct font.
		  scratchGraphic.TextFont = obj.font
		  scratchGraphic.TextSize = Round(obj.getFontSize * scale)
		  scratchGraphic.Bold = obj.bold
		  scratchGraphic.Italic = obj.italic
		  #If XojoVersion > 2015.03 Then
		    scratchGraphic.CharacterSpacing = obj.characterSpacing
		  #Endif
		  
		  ' Compute the length of the string.
		  return Floor(scratchGraphic.StringWidth(text))
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getStringWidth(s as string, font as string, size as integer, bold as boolean = false, italic as boolean = false, characterSpacing as integer = 0) As double
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set up for the correct font.
		  scratchGraphic.TextFont = font
		  scratchGraphic.TextSize = size
		  scratchGraphic.Bold = bold
		  scratchGraphic.Italic = italic
		  #If XojoVersion > 2015.03 Then
		    scratchGraphic.CharacterSpacing = characterSpacing
		  #Endif
		  
		  ' Compute the length of the string.
		  return Floor(scratchGraphic.StringWidth(s))
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getStringWidthSize(extends obj as FTStyleRun, size as integer, text as string) As double
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set up for the correct font.
		  scratchGraphic.TextFont = obj.font
		  scratchGraphic.TextSize = size
		  scratchGraphic.Bold = obj.bold
		  scratchGraphic.Italic = obj.italic
		  
		  ' Compute the length of the string.
		  return Floor(scratchGraphic.StringWidth(text))
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function getSuffix(s as string) As string
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim sl as integer
		  Dim i as integer
		  
		  ' Get the length of the string.
		  sl = Len(s)
		  
		  ' Walk backwards through the string.
		  for i = sl downto 1
		    
		    ' Is this the suffix separator?
		    if Mid(s, i, 1) = "." then
		      
		      ' Return the suffix.
		      return Right(s, sl - i)
		      
		    end if
		    
		  next
		  
		  ' No suffix was found.
		  return ""
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub getSystemFontAndSize(ByRef font as string, ByRef size as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Static systemfont as string
		  Static systemSize as integer
		  Dim cw as FTCConverterWindow
		  Dim sr as StyleRun
		  Dim st as StyledText
		  
		  ' Has the font and size been calculated?
		  if systemFont = "" then
		    
		    ' Create the window.
		    cw = new FTCConverterWindow
		    
		    ' Get the reference to the styled text.
		    st = cw.TargetTextArea.StyledText
		    
		    ' Create the style run.
		    sr = new StyleRun
		    sr.Font = "system"
		    sr.Size = 0
		    sr.Text = "x"
		    
		    ' Add the style run to the text area.
		    st.AppendStyleRun(sr)
		    
		    ' Extract the font data.
		    systemfont = st.StyleRun(0).Font
		    systemSize = st.StyleRun(0).Size
		    
		  end if
		  
		  ' Return the font information.
		  font = systemFont
		  size = systemSize
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub initialize()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Does the scratch area exist?
		  if scratchGraphic is nil then
		    
		    ' Create a picture for calculating string widths.
		    scratchPicture = new picture(1, 1, 32)
		    scratchGraphic = scratchPicture.Graphics
		    
		    ' Create the regular expression.
		    re = new RegEx
		    
		    ' Filter out control characters except tabs.
		    re.SearchPattern = "[\x00-\x08\x0A-\x0C\x0E-\x1F]+"
		    
		    ' We will strip these characters.
		    re.ReplacementPattern = ""
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function isPictureFile(f As Folderitem) As Boolean
		  If f<> nil and f.Exists then
		    
		    #if FTCConfiguration.MBS_INSTALLED then
		      if f.IsPictureFileMBS then
		        Return True
		      end
		    #endif
		    
		    dim extensions as string =".png,.jpeg,.jpg,.gif,.tiff"
		    dim ext as string = ExtractExtension(f)
		    if Extensions.InStr(ext)>0 then
		      Return true
		    end if
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function isTextfile(f As Folderitem) As Boolean
		  If f<> nil and f.Exists then
		    
		    
		    dim extensions as string =".txt,.text,.rtf,.html,.htm"
		    dim ext as string = ExtractExtension(f)
		    if Extensions.InStr(ext)>0 then
		      Return true
		    end if
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function isWordDivider(c as string) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim ch as integer
		  
		  ' Is this a blank?
		  if c = "" then return false
		  
		  ' Extract the first character.
		  ch = Asc(c)
		  
		  ' Is this a space or punctuation character?
		  return ((ch <= 47) or _
		  ((ch >= 58) and (ch <= 64)) or _
		  ((ch >= 91) and (ch <= 96)) or _
		  ((ch >= 123) and (ch <= 127))) and _
		  (not (ch = 39))
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function prepareText(s as string) As string
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Is the encoding in one we can use?
		  if s.Encoding <> Encodings.UTF8 then
		    
		    ' Convert the encoding.
		    s = ConvertEncoding(s, Encodings.UTF8)
		    
		  end if
		  
		  ' Normalize the line endings.
		  s = ReplaceLineEndings(s, EndOfLine.Macintosh)
		  
		  ' Remove invalid characters control characters.
		  s = re.Replace(s)
		  
		  ' Return the string.
		  return s
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function readTextFile(fi as FolderItem, ByRef text as string) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim tis as TextInputStream
		  
		  ' Did we get valid input?
		  if not (fi is nil) then return false
		  
		  ' Open the file.
		  tis = TextInputStream.Open(fi)
		  
		  ' Were we able to open the file?
		  if not (fi is nil) then
		    
		    ' Read in the text.
		    text = tis.ReadAll
		    
		    ' Close the file.
		    tis.close
		    
		    ' We were able to open the file.
		    return true
		    
		  end if
		  
		  ' We were not able to open the file.
		  return false
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function stringToBoolean(s as string) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Is this value true or false?
		  if s = "true" then
		    
		    return true
		    
		  else
		    
		    return false
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function stringToColor(s as string, defaultColor as Color = &cFFFFFF) As Color
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim r as string
		  Dim g as string
		  Dim b as string
		  
		  ' Extract the first color component.
		  r = NthField(s, " ", 1)
		  
		  ' Was anything defined?
		  if r = "" then
		    
		    ' Return the default color.
		    return defaultColor
		    
		  end if
		  
		  ' Extract the rest of the color components.
		  g = NthField(s, " ", 2)
		  b = NthField(s, " ", 3)
		  
		  ' Create the color object.
		  return RGB(Val(r), Val(g), Val(b))
		  
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  
			  #pragma DisableBackgroundTasks
			  
			  #if not DebugBuild
			    
			    #pragma BoundsChecking FTC_BOUNDSCHECKING
			    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
			    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
			    
			  #endif
			  
			  Dim i as integer
			  Dim count as integer
			  Dim d as Date
			  Dim s as string
			  Dim ch as integer
			  
			  ' Has it been initialized?
			  if mDateSeparator = "" then
			    
			    ' Get a short date.
			    d = new Date
			    s = d.ShortDate
			    
			    ' Get the length of the string.
			    count = s.len
			    
			    ' Scan for a separator.
			    for i = 1 to count
			      
			      ' Pull out a character.
			      ch = Asc(Mid(s, i, 1))
			      
			      ' Is this a non-digit?
			      if (ch < 48) or (ch > 57) then
			        
			        ' Save the date separator.
			        mDateSeparator = Chr(ch)
			        
			        ' We are done.
			        exit
			        
			      end if
			      
			    next
			    
			    ' Use the default if something bad happened.
			    if mDateSeparator = "" then mDateSeparator = "/"
			    
			  end if
			  
			  ' Return the separator.
			  return mDateSeparator
			  
			End Get
		#tag EndGetter
		Protected dateSeparator As string
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  
			  #if not DebugBuild
			    
			    #pragma BoundsChecking FTC_BOUNDSCHECKING
			    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
			    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
			    
			  #endif
			  
			  ' Has it been initialized?
			  if mDecimalPoint = "" then
			    
			    ' Get the decimal point symbol.
			    mDecimalPoint = left(format(1000, ".0"), 1)
			    
			  end if
			  
			  ' Return the decimal point symbol.
			  return mDecimalPoint
			  
			End Get
		#tag EndGetter
		Protected decimalPoint As string
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mDateSeparator As string
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mDecimalPoint As string
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mThousandsSeparator As string
	#tag EndProperty

	#tag Property, Flags = &h21
		Private nextID As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private re As RegEx
	#tag EndProperty

	#tag Property, Flags = &h21
		Private scratchGraphic As Graphics
	#tag EndProperty

	#tag Property, Flags = &h21
		Private scratchPicture As picture
	#tag EndProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  
			  #if not DebugBuild
			    
			    #pragma BoundsChecking FTC_BOUNDSCHECKING
			    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
			    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
			    
			  #endif
			  
			  ' Has it been initialized?
			  if mThousandsSeparator = "" then
			    
			    ' Get the thousands separator symbol.
			    mThousandsSeparator = mid(format(1000, ",0"), 2, 1)
			    
			  end if
			  
			  ' Return the thousands separator symbol.
			  return mThousandsSeparator
			  
			End Get
		#tag EndGetter
		Protected thousandsSeparator As string
	#tag EndComputedProperty


	#tag Constant, Name = OUT_OF_FOCUS_COLOR, Type = Color, Dynamic = False, Default = \"&cDADADA", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PILCROW, Type = String, Dynamic = False, Default = \"\xC2\xB6", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = RESOLUTION_ADJUSTMENT, Type = Double, Dynamic = False, Default = \"1.0", Scope = Protected
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"1.0"
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"0.75"
		#Tag Instance, Platform = Mac OS, Language = Default, Definition  = \"1.0"
	#tag EndConstant


	#tag Structure, Name = AutoEnableData, Flags = &h0
		undo as boolean
		  redo as boolean
		  cut as boolean
		  copy as boolean
		  paste as boolean
		  clear as boolean
		fill(1) as boolean
	#tag EndStructure

	#tag Structure, Name = DisplayMargins, Flags = &h0
		topMargin as double
		  bottomMargin as double
		  leftMargin as double
		rightMargin as double
	#tag EndStructure

	#tag Structure, Name = DocumentMargins, Flags = &h0
		pageWidth as double
		pageHeight as double
	#tag EndStructure

	#tag Structure, Name = DoubleCache, Flags = &h0
		scale as single
		value as double
	#tag EndStructure

	#tag Structure, Name = IntegerCache, Flags = &h0
		scale as double
		value as integer
	#tag EndStructure

	#tag Structure, Name = ParagraphAttributes, Flags = &h0
		alignment as FTParagraph.Alignment_Type
		  lineSpacing as double
		  paragraphStyle as integer
		  afterParagraphSpace as double
		  beforeParagraphSpace as double
		  firstIndent as double
		  leftMargin as double
		  rightMargin as double
		  backgroundColor as color
		  pageBreak as boolean
		fill(2) as boolean
	#tag EndStructure

	#tag Structure, Name = PrintMarginOffset, Flags = &h0
		left as double
		  right as double
		  top as double
		bottom as double
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
