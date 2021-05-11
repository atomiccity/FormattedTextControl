#tag Module
Protected Module ConsoleUtilities
	#tag Method, Flags = &h0
		Sub AppendConsoleText(s as string)
		  ' Clear the internal text.
		  consoleText = consoleText + s + EndOfLine
		  
		  ' Does the console window exist?
		  If Not (console Is Nil) Then
		    
		    ' Clear the display text.
		    console.OutputField.Text = consoleText
		    
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub closeConsole()
		  
		  ' Close the console window.
		  console.close
		  console = nil
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getAutoLogFile() As FolderItem
		  
		  ' Return the folder item for the auto log file.
		  return autoLogConsoleFile
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getAutoLogging() As boolean
		  
		  ' Return the current state of logging.
		  return autoLog
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getConsoleText() As string
		  
		  ' Return the current console text.
		  return consoleText
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getConsoleTimestamp() As boolean
		  
		  ' Return the current state of using timestamps in the log.
		  return useTimestamp
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub prt(s as string = "")
		  
		  Dim message as string
		  
		  ' Should we add a time stamp?
		  if useTimestamp then
		    
		    ' Add a message to the time stamp.
		    message = getTimeStamp(getCurrentDate) + ": " + s + chr(13)
		    
		  else
		    
		    ' Create a plain old message
		    message = s + chr(13)
		    
		  end if
		  
		  ' Append the text.
		  consoleText = consoleText + message
		  
		  ' Does the console window exist?
		  if not (console is nil) then
		    
		    ' Append the text.
		    console.OutputField.AppendText(message)
		    
		    ' Scroll to the bottom.
		    console.OutputField.ScrollPosition = 2147483647
		    
		  end if
		  
		  ' Should we write it out to the auto log?
		  if autoLog then
		    
		    ' Do we have something to write to?
		    if not (autoFileStream is nil) then
		      
		      ' Append the message to the auto log file.
		      autoFileStream.Write(message)
		      
		    end if
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setAutoLogFile(fi as FolderItem)
		  
		  ' Turn off auto logging.
		  autoLog = false
		  
		  ' Is the console window present?
		  if not (console is nil) then
		    
		    console.LogCheckBox.Value = false
		    
		  end if
		  
		  ' Reset the console text.
		  setConsoleText("")
		  
		  ' Are we completely turning off logging?
		  if fi is nil then
		    
		    ' Do we have a log file open?
		    if not (autoFileStream is nil) then
		      
		      ' Close the existing log.
		      autoFileStream.close
		      
		    end if
		    
		    ' Release the memory.
		    autoFileStream = nil
		    autoLogConsoleFile = nil
		    
		    ' Is the console window present?
		    if not (console is nil) then
		      
		      ' Display the name of the file.
		      console.LogFileField.text = ""
		      
		      ' Disable the log output checkbox.
		      console.LogCheckbox.Enabled = false
		      
		      ' Turn off the close button.
		      console.CloseLogButton.Enabled = false
		      
		    end if
		    
		  else
		    
		    ' Create the new file.
		    autoFileStream = TextOutputStream.Create(fi)
		    
		    ' Save the folder item for the auto log file.
		    autoLogConsoleFile = fi
		    
		    ' Is the console window present?
		    if not (console is nil) then
		      
		      ' Display the name of the file.
		      console.LogFileField.text = "(" + fi.name + ") " + fi.NativePath
		      
		      ' Enable the log output checkbox.
		      console.LogCheckbox.Enabled = true
		      
		      ' Turn on the close button.
		      console.CloseLogButton.Enabled = true
		      
		    end if
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setAutoLogging(state as boolean)
		  
		  ' Save the state of auto logging.
		  autoLog = state
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setConsoleText(s as string)
		  
		  ' Clear the internal text.
		  consoleText = s
		  
		  ' Does the console window exist?
		  if not (console is nil) then
		    
		    ' Clear the display text.
		    console.OutputField.Text = s
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setConsoleTimestamp(state as boolean)
		  
		  ' Set the state of adding time stamps to the log.
		  useTimestamp = state
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub showConsole()
		  
		  ' Is this the first time we calling this subroutine?
		  if console is nil then
		    
		    ' Create the console window.
		    console = new ConsoleWindow
		    
		  end if
		  
		  ' Update the display with the current console text.
		  console.OutputField.Text = consoleText
		  
		  ' Restore the timestamp setting.
		  console.TimestampsCheckBox.Value = getConsoleTimestamp
		  
		  ' Make the console window visible.
		  console.Show
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = Copyright Notice
		
		Copyright 2002-2015 BKeeney Software Inc. - All Rights Reserved.
		
		This software is freeware and may be used freely without
		royalties or fees.
	#tag EndNote

	#tag Note, Name = Usage
		
		Best viewed in font "Courier New" with font size of 12.
		
		This module provides methods for using a console window.
		You should not directly access the console window but use
		the methods in ConsoleUtilities.
		
		In general, the only routines you need to be concerned with
		are "showConsole" and "prt". Call showConsole to make the
		console window visible. Call the prt (which stands for
		print) subroutine when you want to send a message to the
		console window. You can call the prt subroutine at any time
		even if the console window is not shown.
		
		The console window itself consists of the following items.
		
		Console Output Area
		-------------------
		
		All console messages will be displayed main edit field.
		
		Display
		-------
		
		- "Save as..." button.
		
		  Takes a snap shot of the entire console and writes it to a
		  file.
		
		- "Clear" button.
		
		  Clear the console output display area. This will not
		  affect auto logging.
		
		- "Timestamps" checkbox.
		
		  You can optionally specify if you want timestamps prepended
		  to each message sent to the console through the prt
		  subroutine.
		  
		- Console "Close" button.
		
		  Closes the window.
		  
		Auto Logging
		------------
		
		- "Select" button.
		
		  Allows you to choose the file for auto logging. Selecting
		  a file will close the previous file.
		
		- "Close" button.
		
		  This will close the current auto logging file.
		
		- "Log output" checkbox.
		
		  With this checkbox you can dynamically turn on/off logging
		  to the file on disk. Logging will continue to occur to the
		  console window itself (in memory).
		
		- Log file name area.
		
		  This shows the current name and path of the auto log file.
		
		
		closeConsole
		------------
		
		  Description:
		    Close the console window.
		
		  Parameters:
		
		    None.
		
		  Return:
		
		    None.
		      
		      
		getAutoLogFile
		--------------
		
		  Description:
		    Return the folder item representing the auto log file.
		
		  Parameters:
		
		    None.
		
		  Return:
		
		    FolderItem:
		      FolderItem representing the auto log file.
		      
		      
		getAutoLogging
		--------------
		
		  Description:
		    This function tells you the current state of writing
		    messages to the auto log file.
		
		  Parameters:
		
		    None.
		
		  Return:
		
		    boolean:
		      Are messages to the console being written to the auto
		      log file.
		      
		      
		getConsoleText
		--------------
		
		  Description:
		    The function return the complete text that is displayed
		    in the console window.
		
		  Parameters:
		
		    None.
		
		  Return:
		
		    string:
		      The complete text of the text stored in the display
		      console.
		      
		      
		getConsoleTimestamp
		-------------------
		
		  Description:
		    This function returns the current state of using
		    prepended time stamps on console messages.
		
		  Parameters:
		
		    None.
		
		  Return:
		
		    boolean:
		      Are timestamps being prepended to messages to the
		      console.
		      
		      
		prt
		---
		
		  Description:
		    This the subroutine you should use to add text messages
		    to the console window. Note, this subroutine will append
		    a return (13) to your message.
		
		  Parameters:
		
		    s as string (default = ""):
		      Message you want to send to the console window.
		
		  Return:
		
		    None.
		      
		      
		setAutoLogFile
		--------------
		
		  Description:
		    This subroutine will set up the auto logging file. If
		    you pass it "nil," it will turn off auto logging.
		    Generally you should never need to call this subroutine.
		
		  Parameters:
		
		    fi as FolderItem:
		      The Folder item representing the new auto logging
		      file.
		
		  Return:
		
		    None.
		      
		      
		setAutoLogging
		--------------
		
		  Description:
		    This subroutine allows you to programatically turn
		    on/off auto logging. This will NOT affect the users
		    setting in the console window. If you call this, you are
		    responsible for keeping the user's setting in sync.
		    Generally, you should not call this unless you want
		    something displayed in the window but not in the log
		    file.
		
		  Parameters:
		
		    state as boolean:
		      Should messages be written to the auto log file.
		
		  Return:
		
		    None.
		      
		      
		setConsoleText
		--------------
		
		  Description:
		    This method replaces the entire console window text. Do
		    NOT pass nil to this subroutine.
		
		  Parameters:
		
		    s as string:
		      The new console text.
		
		  Return:
		
		    None.
		      
		      
		setConsoleTimestamp
		-------------------
		
		  Description:
		    This subroutine allows you to programatically turn
		    on/off timestamps being prepend to console messages.
		    logging. This will NOT affect the users setting in the
		    console window. If you call this, you are responsible
		    for keeping the user's setting in sync. Generally, you
		    should not call subroutine.
		
		  Parameters:
		
		    state as boolean:
		      The current state of usage of timestamps in the
		      console window.
		
		  Return:
		
		    None.
		      
		      
		showConsole
		-----------
		
		  Description:
		    This subroutine show the console window.
		
		  Parameters:
		
		    None.
		
		  Return:
		
		    None.
	#tag EndNote

	#tag Note, Name = Version History
		
		Author: BKeeney Software Inc.
		
		Version 1.0.1
		  * Minor update to make the window more resizable.
		  
		  * Made the parameter to the prt subroutine default to ""
		    so that you can call prt without parameters.
		  
		Version 1.0
		  * Original.
	#tag EndNote


	#tag Property, Flags = &h1
		Protected autoFileStream As TextOutputStream
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected autoLog As boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected autoLogConsoleFile As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected console As ConsoleWindow
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected consoleText As string
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected useTimestamp As boolean
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
End Module
#tag EndModule
