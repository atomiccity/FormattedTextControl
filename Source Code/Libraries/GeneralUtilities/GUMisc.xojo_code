#tag Module
Protected Module GUMisc
	#tag Method, Flags = &h0
		Sub adjustScrollbars(extends parent as RectControl, vScrollbar as ScrollBar, hScrollbar as ScrollBar)
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  ' Does the vertical scrollbar exist?
		  if not (vScrollbar is nil) then
		    
		    ' Move it into position.
		    vScrollbar.Top = parent.Top
		    vScrollbar.Left = parent.Left + parent.Width
		    vScrollbar.Height = parent.Height
		    
		  end if
		  
		  ' Does the horizontal scrollbar exist?
		  if not (hScrollbar is nil) then
		    
		    ' Move it into position.
		    hScrollbar.Top = parent.Top + parent.Height
		    hScrollbar.Left = parent.left
		    hScrollbar.Width = parent.Width
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub adjustSpacing(Extends obj as RectControl, control as RectControl, space as integer, adjustControl as boolean)
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  Dim oldControlWidth as integer
		  Dim newControlWidth as integer
		  Dim st as Label
		  
		  ' Is this a static text control?
		  if obj isa Label then
		    
		    ' Cast it to the correct type.
		    st = Label(obj)
		    
		    ' Get the width of the text.
		    newControlWidth = getStringWidth(st.TextFont, st.TextSize, st.Text)
		    
		    ' Are we dealing with right aligned text?
		    if st.TextAlign = Label.AlignRight then
		      
		      ' Adjust the label's left position.
		      st.left = st.left + (st.width - newControlWidth)
		      
		    end if
		    
		    ' Adjust the label's width.
		    st.Width = newControlWidth
		    
		  end if
		  
		  ' Save the old position of the control.
		  oldControlWidth = control.left
		  
		  ' Move the control into the proper position.
		  control.Left = obj.left + obj.Width + space
		  
		  ' Is this a label or edit field?
		  if adjustControl then
		    
		    ' Adjust the width of the control.
		    control.Width = (oldControlWidth - control.left) + control.Width
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub checkScratchGraphic()
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  ' Does the scratch area exist
		  if scratchGraphic is nil then
		    
		    ' Create a picture for calculating string widths.
		    scratchPicture = new Picture(1, 1, 32)
		    scratchGraphic = scratchPicture.Graphics
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function createVersionString() As string
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  Dim s as string
		  
		  ' Create the version string.
		  s = Str(app.MajorVersion) + "."
		  s = s + Str(app.MinorVersion) + "."
		  s = s + Str(app.BugVersion)
		  
		  ' Add the development tag.
		  select case app.StageCode
		    
		  case 0
		    s = s + " Development " + Str(app.NonReleaseVersion)
		    
		  case 1
		    s = s + " Alpha " + Str(app.NonReleaseVersion)
		    
		  case 2
		    s = s + " Beta " + Str(app.NonReleaseVersion)
		    
		  case 3
		    
		    ' Is this a final candidate?
		    if app.NonReleaseVersion > 0 then
		      
		      s = s + " Final Candidate " + Str(app.NonReleaseVersion)
		      
		    end if
		    
		  end select
		  
		  ' Return the version string.
		  return s
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function degToRad(angle as double) As double
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  ' Covert the angle from degrees to radians.
		  return (angle * PI) / 180
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub deselectAllRows(extends lb as ListBox)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  
		  ' Make it zero based.
		  count = lb.ListCount - 1
		  
		  ' Deselect all of the rows.
		  for i = lb.ListIndex to count
		    
		    ' Is the row selected?
		    if lb.selected(i) then
		      
		      ' Turn off the selection.
		      lb.selected(i) = false
		      
		    end if
		    
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub enableSubmenu(mi as MenuItem)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  
		  ' Make it zero based.
		  count = mi.Count - 1
		  
		  ' Turn on the sub menu items.
		  for i = 0 to count
		    
		    ' Turn on the menu item.
		    mi.item(i).Enable
		    
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getCurrentDate() As Date
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  Dim currentDate as Date
		  
		  ' Allocate the date object.
		  currentDate = new Date
		  
		  ' Initialize the date and time.
		  call currentDate.TotalSeconds
		  
		  return currentDate
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getDateFromTimeStamp(dateString as string) As double
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  Dim d as Date
		  Dim dateParts() as string
		  Dim dateElements() as string
		  Dim timeElements() as string
		  Dim hours as integer
		  
		  ' Create a date to do the conversion.
		  d = new Date
		  
		  ' Get rid of extra white space.
		  dateString = trim(dateString)
		  
		  ' Break the date into date and time.
		  dateParts = split(dateString)
		  
		  ' Get the date parts.
		  dateElements = split(dateParts(0), "/")
		  
		  ' Get the time parts.
		  timeElements = split(dateParts(1), ":")
		  
		  ' Assign the date parts.
		  d.month = Val(dateElements(0))
		  d.day = Val(dateElements(1))
		  d.year = Val(dateElements(2))
		  
		  ' Assign the time parts.
		  d.minute = Val(timeElements(1))
		  d.second = Val(timeElements(2))
		  
		  ' Get the hours.
		  hours = Val(timeElements(0))
		  
		  ' Are we dealing with AM or PM?
		  if dateParts(2) = "PM" then
		    
		    ' Is this the normal case?
		    if hours < 12 then
		      
		      ' Add twelve hours to the time.
		      d.hour = hours + 12
		      
		    else
		      
		      ' Use the hours as is.
		      d.hour = hours
		      
		    end if
		    
		  else
		    
		    ' Is this midnight?
		    if hours = 12 then
		      
		      ' Default to the wee hours of the morning.
		      d.hour = 0
		      
		    else
		      
		      ' Use the hours as is.
		      d.hour = hours
		      
		    end if
		    
		  end if
		  
		  ' Return the date as seconds.
		  return d.TotalSeconds
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getStringHeight(font as string, size as integer) As integer
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  ' Is this the first run?
		  checkScratchGraphic
		  
		  ' Set up for the correct font.
		  scratchGraphic.TextFont = font
		  scratchGraphic.TextSize = size
		  
		  ' Compute the height of the string.
		  return scratchGraphic.TextAscent
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getStringWidth(font as string, size as integer, bold as boolean, italic as boolean, s as string) As integer
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  ' Is this the first run?
		  checkScratchGraphic
		  
		  ' Set up for the correct font.
		  scratchGraphic.TextFont = font
		  scratchGraphic.TextSize = size
		  scratchGraphic.Bold = bold
		  scratchGraphic.Italic = italic
		  scratchGraphic.Underline = false
		  
		  ' Compute the length of the string.
		  return scratchGraphic.StringWidth(s)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getStringWidth(font as string, size as integer, s as string) As integer
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  ' Is this the first run?
		  checkScratchGraphic
		  
		  ' Set up for the correct font.
		  scratchGraphic.TextFont = font
		  scratchGraphic.TextSize = size
		  scratchGraphic.Bold = false
		  scratchGraphic.Italic = false
		  scratchGraphic.Underline = false
		  
		  ' Compute the length of the string.
		  return scratchGraphic.StringWidth(s)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getStyleRunHeight(sr as StyleRun) As integer
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  ' Is this the first run?
		  checkScratchGraphic
		  
		  ' Set up for the correct environment.
		  scratchGraphic.TextFont = sr.Font
		  scratchGraphic.TextSize = sr.Size
		  scratchGraphic.Bold = sr.Bold
		  scratchGraphic.Italic = sr.Italic
		  scratchGraphic.Underline = sr.Underline
		  
		  ' Compute the height of the string.
		  return scratchGraphic.TextHeight
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getStyleRunWidth(sr as StyleRun, startPosition as integer = - 1, endPosition as integer = - 1) As integer
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  Dim s as string
		  Dim endPos as integer
		  
		  ' Is this the first run?
		  checkScratchGraphic
		  
		  ' Set up for the correct environment.
		  scratchGraphic.TextFont = sr.Font
		  scratchGraphic.TextSize = sr.Size
		  scratchGraphic.Bold = sr.Bold
		  scratchGraphic.Italic = sr.Italic
		  scratchGraphic.Underline = sr.Underline
		  
		  ' Look for an end of line character.
		  endPos = InStr(startPosition, sr.text, endofline.Macintosh)
		  
		  ' Do we have a starting position?
		  if startPosition > -1 then
		    
		    ' Do we have an ending position?
		    if endPosition > -1 then
		      
		      ' Did we find an end of line?
		      if (endPos > 0) and (endPos <= endPosition) then
		        
		        ' Retrieve a partial segment.
		        s = mid(sr.Text, startPosition + 1, endPos)
		        
		      else
		        
		        ' Retrieve a partial segment.
		        s = mid(sr.Text, startPosition + 1, endPosition - startPosition + 1)
		        
		      end if
		      
		    else
		      
		      ' Did we find an end of line?
		      if endPos > 0 then
		        
		        ' Retrieve a partial segment.
		        s = mid(sr.Text, startPosition + 1, endPos)
		        
		      else
		        
		        ' Retrieve from the start position to the end of the run.
		        s = mid(sr.Text, startPosition + 1)
		        
		      end if
		      
		    end if
		    
		  else
		    
		    ' Did we find an end of line?
		    if endPos > 0 then
		      
		      ' Retrieve a partial segment.
		      s = mid(sr.Text, 1, endPos)
		      
		    else
		      
		      ' Retrieve the entire text.
		      s = sr.Text
		      
		    end if
		    
		  end if
		  
		  ' Compute the length of the string.
		  return scratchGraphic.StringWidth(s)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getStyleRunWidth(sr as StyleRun, s as string) As integer
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  ' Is this the first run?
		  checkScratchGraphic
		  
		  ' Set up for the correct environment.
		  scratchGraphic.TextFont = sr.Font
		  scratchGraphic.TextSize = sr.Size
		  scratchGraphic.Bold = sr.Bold
		  scratchGraphic.Italic = sr.Italic
		  scratchGraphic.Underline = sr.Underline
		  
		  ' Compute the length of the string.
		  return scratchGraphic.StringWidth(s)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getTimeStamp(theDate as Date, includeTime as boolean = true) As String
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  Dim dateString as string
		  Dim timeString as string
		  
		  ' Convert the date to a string.
		  dateString = Str(theDate.month) + "/" + Str(theDate.day) +  "/" + Str(theDate.year)
		  
		  ' Should we include the time?
		  if not includeTime then return dateString
		  
		  ' Are we in the AM or PM?
		  if theDate.hour < 12 then
		    
		    ' Is this 12 AM?
		    if theDate.hour = 0 then
		      
		      timeString = "12:" + Str(theDate.minute) +  ":" + Str(theDate.second) + " AM"
		      
		    else
		      
		      timeString = Str(theDate.hour) + ":" + Str(theDate.minute) +  ":" + Str(theDate.second) + " AM"
		      
		    end if
		    
		  else
		    
		    ' Is this 12 PM?
		    if theDate.hour = 12 then
		      
		      timeString = "12:" + Str(theDate.minute) +  ":" + Str(theDate.second) + " PM"
		      
		    else
		      
		      timeString = Str(theDate.hour - 12) + ":" + Str(theDate.minute) +  ":" + Str(theDate.second) + " PM"
		      
		    end if
		    
		  end if
		  
		  ' Return the composite date string.
		  return dateString + " " + timeString
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getTopDocumentWindow() As Window
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  ' Get the top document style window.
		  return getTopWindow(0)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getTopWindow(windowType as integer) As Window
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  Dim i as integer
		  Dim wc as integer
		  Dim w as window
		  
		  ' Compute the total number of windows for iteration.
		  wc = WindowCount - 1
		  
		  ' Go through the window list.
		  for i = 0 to wc
		    
		    ' Get the window from the window list.
		    w = Window(i)
		    
		    ' Is this a visible target window?
		    if (w.Frame = windowType) and w.visible then
		      
		      ' This is the first visible document window.
		      return w
		      
		    end if
		    
		  next
		  
		  ' No visible window found of that type.
		  return nil
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function makeBackupFile(fi as FolderItem, force as boolean, prefix as string) As boolean
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  Dim backupFile as FolderItem
		  Dim copyFileName as string
		  
		  ' Does the original file exist?
		  if not fi.Exists then
		    
		    ' Do nothing.
		    return false
		    
		  end if
		  
		  ' Is the prefix empty?
		  if Trim(prefix) = "" then
		    
		    ' Cannot use an empty prefix.
		    return false
		    
		  end if
		  
		  ' Create the name of the backup file.
		  copyFileName = prefix + fi.name
		  
		  ' Get the new folder item for the target copy file.
		  backupFile = fi.Parent.Child(copyFileName)
		  
		  ' Does the backup already exist?
		  if backupFile.Exists then
		    
		    ' Should delete the file?
		    if force then
		      
		      ' Delete the file.
		      backupFile.Delete
		      
		      ' Does the backup already exist?
		      if backupFile.Exists then
		        
		        ' Unable to delete the existing backup file.
		        return false
		        
		      end if
		      
		    else
		      
		      ' Don't overwrite the file.
		      return false
		      
		    end if
		    
		  end if
		  
		  ' Make a copy of the file.
		  fi.CopyFileTo(backupFile)
		  
		  ' Was the file copied?
		  return backupFile.Exists
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function radToDeg(radians as double) As double
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  ' Covert the angle from radians to degrees.
		  return (radians * 180) / PI
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function readTextFile(fi as FolderItem, ByRef text as string) As boolean
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  Dim tis as TextInputStream
		  
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

	#tag Method, Flags = &h0
		Function stringToColor(s as string) As Color
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  Dim r as integer
		  Dim g as integer
		  Dim b as integer
		  
		  ' Break the string down into its components.
		  r = Val(NthField(s, " ", 1))
		  g = Val(NthField(s, " ", 2))
		  b = Val(NthField(s, " ", 3))
		  
		  ' Create the color object.
		  return RGB(r, g, b)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function visibleWindowCount() As integer
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim wc as integer
		  
		  ' Compute the total number of windows for iteration.
		  wc = WindowCount - 1
		  
		  ' Assume no window are visible.
		  count = 0
		  
		  ' Go through the window list.
		  for i = 0 to wc
		    
		    ' Is the window visible?
		    if Window(i).visible then
		      
		      ' Hey, this window is visible, so count it.
		      count = count + 1
		      
		    end if
		    
		  next
		  
		  ' Return the total count of windows that are open.
		  return count
		  
		End Function
	#tag EndMethod


	#tag Note, Name = Copyright Notice
		
		Copyright 2002-2015 BKeeney Software Inc. - All Rights Reserved.
		
		This software is freeware and may be used freely without
		royalties or fees.
	#tag EndNote

	#tag Note, Name = Usage
		
		Best viewed in font "Courier New" with font size of 12.
		
		This module contains general utility functions and subroutines.
		
		adjustSpacing
		-------------
		
		  Description:
		    
		    This subroutine is used to adjust the spacing between a
		    label and a control such as an EditField. This is useful
		    when dealing with cross platform implementations that
		    use different fonts and therefore messes up the spacing.
		    This subroutine will give a consistent look feel to the
		    label and control.
		    
		  Parameters:
		
		    Extends obj as StaticText:
		      This subroutine extends the StaticText control.
		    
		    control as RectControl:
		      The associated control with this label.
		    
		    space as integer:
		      The desired space between the label and control.
		    
		    adjustControl as boolean
		      Should the width of the control be changed so the
		      right side of the control remains stationary.
		      
		  Return:
		
		    None.
		
		
		createVersionString
		-------------------
		
		  Description:
		
		    This subroutine builds a version string based off your
		    build settings.
		    
		  Parameters:
		
		    None.
		
		  Return:
		
		    string:
		      Version string (i.e., "1.0.0 Alpha 1")
		
		
		degToRad
		--------
		
		  Description:
		
		    This subroutine converts degrees to radians.
		    
		  Parameters:
		
		    angle as double:
		      The angle to convert from degrees to radians.
		
		  Return:
		
		    double:
		      The angle in radians.
		      
		
		deselectAllRows
		---------------
		
		  Description:
		
		    This subroutine deselects all items in a listbox.
		    
		  Parameters:
		
		    extends lb as ListBox:
		      The listbox.
		
		  Return:
		
		    None.
		
		
		equals
		------
		
		  Description:
		
		    This function extends the folder item class to see if
		    the two items point to the same file.
		
		  Parameters:
		
		    extends f as FolderItem:
		      The folder item.
		      
		    target as FolderItem:
		      The folder item to compare with.
		      
		  Return:
		
		    boolean:
		      Are the two folder items point towards the same item.
		
		getCurrentDate
		--------------
		
		  Description:
		
		    Return a date initialized to the time that this function
		    was called.
		
		  Parameters:
		
		    None.
		
		  Return:
		
		    Date:
		      Initialized date object with the current time.
		    
		    
		getDateFromTimeStamp
		--------------------
		
		  Description:
		
		    This function will return the number of seconds a time
		    stamp represents. This function will only work with time
		    stamps produced from the getTimeStamp function in this
		    module.
		
		  Parameters:
		
		    dateString as string:
		      The date string produced from getTimeStamp.
		
		  Return:
		
		    double:
		      The time in seconds.
		
		    
		getStringHeight
		---------------
		
		  Description:
		
		    This function returns the height of a string in a
		    specified font and size.
		
		  Parameters:
		
		    font as string:
		      The font name. 
		      
		    size as integer:
		      The font size.
		    
		    s as string:
		      The string to measure.
		      
		  Return:
		
		    integer:
		      The height of the string in pixels.
		
		
		getStringWidth
		--------------
		
		  Description:
		
		    This function measures the width of a string in a
		    specified font and size.
		
		  Parameters:
		
		    font as string:
		      The font name. 
		      
		    size as integer:
		      The font size.
		    
		    s as string:
		      The string to measure.
		      
		  Return:
		
		    integer:
		      The width of the string in pixels.
		
		
		getStyleRunHeight
		-----------------
		 
		   Description:
		
		    This function measures the single line height of a style
		    run.
		
		  Parameters:
		
		    sr as StyleRun:
		      The style run to measure.
		      
		  Return:
		
		    integer:
		      The height of the style run in pixels.
		   
		
		getStyleRunStringWidth
		----------------------
		
		  Description:
		  
		    This function returns the width of a style run in
		    pixels. If startPosition is unspecified, then the entire
		    string is measured. If just startPosition is specified,
		    then the measurement is taken from the start position to
		    the end of the run. If both startPosition and
		    endPosition are specified, then the substring is
		    measured.
		
		  Parameters:
		
		    sr as StyleRun:
		      The target style run.
		      
		    startPosition as integer = -1:
		      The character position in the style run to start the
		      measurement.
		    
		    endPosition as integer = -1:
		      The character position in the style run to stop the
		      measurement.
		
		  Return:
		
		    integer:
		      The length of the style run in pixels.
		      
		
		getStyleRunStringWidth
		----------------------
		
		  Description:
		  
		    This function returns the width of a style run in
		    pixels. If startPosition is unspecified, then the entire
		    string is measured. If just startPosition is specified,
		    then the measurement is taken from the start position to
		    the end of the run. If both startPosition and
		    endPosition are specified, then the substring is
		    measured.
		
		  Parameters:
		
		    sr as StyleRun:
		      The target style run.
		      
		    s as string
		      The string to measure the width with.
		
		  Return:
		
		    integer:
		      The length of the string run in pixels.
		            
		
		getTimeStamp
		------------
		
		  Description:
		
		    This function converts a date object a string form of
		    "mm/dd/yyyy hh:mm:ss xx". This is useful for creating
		    time stamps for log files or for using with the built in
		    REALbasic database. This function assumes a valid date
		    object using military time (0 to 23 hours).
		
		  Parameters:
		
		    theDate as Date:
		      The target Date object to convert to a string.
		    
		  Return:
		
		    Window:
		      The string form of the date as "mm/dd/yyyy hh:mm:ss xx"
		      where xx is "AM" or "PM".
		  
		  
		getTopDocumentWindow
		--------------------
		
		  Description:
		
		    Searches the window list for the first visible document
		    window.
		
		  Parameters:
		
		    None.
		
		  Return:
		
		    Window:
		      The top visible document window. Nil will be returned
		      if no visible window with the document frame type is
		      found.
		  
		  
		getTopWindow
		------------
		
		  Description:
		
		    Searches the window list for the first visible window
		    where the window frame type matches the parameter
		    windowType.
		    
		  Parameters:
		
		    windowType as integer:
		      Target window type.
		
		  Return:
		
		    Window:
		      The top visible document window. Nil will be returned
		      if no visible window with the document frame type is
		      found.
		      
		
		kill
		----
		
		  Description:
		
		    This subroutine is a wrapper for the "Quit" subroutine.
		    It catches any exception that may be generated by the
		    quit command and buries them.
		
		  Parameters:
		
		    None.
		
		  Return:
		
		    None.
		
		
		makeBackupFile
		--------------
		
		  Description:
		
		    This subroutine will make a backup file in the same
		    directory as the original file.
		
		  Parameters:
		
		    fi as FolderItem:
		      The file to back up.
		      
		    force as boolean:
		      If a backup file already exists, delete it.
		      
		    prefix as string:
		      The string to be prefixed to the file name such as
		      "backup-".
		
		  Return:
		
		    boolean:
		      True if the backup file was created.
		   
		
		radToDeg
		--------
		
		  Description:
		
		    This subroutine converts radians to degrees.
		    
		  Parameters:
		
		    angle as double:
		      The angle to convert from radians to degrees.
		
		  Return:
		
		    double:
		      The angle in degrees.
		
		
		stringToColor
		-------------
		
		  Description:
		
		    This function converts a string representation of a color
		    to a color object. Use the "Str" function from the
		    GUString module to convert a color to a string for input
		    into this routine.
		    
		  Parameters:
		
		    s as string:
		      The string representation of a color.
		
		  Return:
		
		    Color:
		      The converted color.
		
		
		visibleWindowCount
		------------------
		
		  Description:
		  
		    This function returns the number of all "visible"
		    windows in the window list.
		
		  Parameters:
		
		    None.
		
		  Return:
		
		    integer:
		      The number of visible windows in the window list.
	#tag EndNote


	#tag Property, Flags = &h21
		Private scratchGraphic As Graphics
	#tag EndProperty

	#tag Property, Flags = &h21
		Private scratchPicture As picture
	#tag EndProperty


	#tag Constant, Name = PI, Type = Double, Dynamic = False, Default = \"3.14159265358979323846264338327950", Scope = Public
	#tag EndConstant


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
