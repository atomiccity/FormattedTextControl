#tag Class
Protected Class App
Inherits Application
	#tag Event
		Function CancelClose() As Boolean
		  Dim message as string
		  Dim note as string
		  
		  ' Are there documents that need to be saved?
		  if hasDirtyDocuments then
		    
		    ' Set up the dialog message.
		    message = "There are unsaved documents open."
		    note = "Are you sure you want to quit?"
		    
		    ' Ask the user if they want to quit.
		    if not showChoice(message, note, "Quit") then
		      
		      ' Cancel the quit action.
		      return true
		      
		    end if
		    
		  end if
		End Function
	#tag EndEvent

	#tag Event
		Sub Close()
		  #if FTCConfiguration.BKS_SPELLCHECK_ENABLED = true then
		    BKSSC.SaveUserDictionary
		    
		  #endif
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  //Check our FTC version
		  #if DebugBuild then
		    if FormattedText.VERSION <> "3.2.0" then
		      break //Wrong version
		    end
		  #endif
		  
		  #if not DebugBuild
		    
		    ' Turn off the key stroke timing menu items.
		    HelpKeyStrokeTiming.Visible = false
		    HelpClearKeyStrokeTiming.Visible = false
		    
		    ' Hide the separators.
		    HelpSeparator1.Visible = false
		    HelpSeparator2.Visible = false
		    
		  #endif
		  
		  ' Build the font menu.
		  buildFontMenu
		  
		  ' Only the about box for final builds.
		  if not DebugBuild then
		    
		    ' Show the about window.
		    aboutAction(2)
		    
		  end if
		  
		  #if not DebugBuild
		    
		    ' Create the new editor.
		    newFTCEditFieldAction
		    
		    ' Create a new RBScript editor.
		    newRBScriptEditorAction
		    
		    ' Create a new text field.
		    newFTCTextFieldAction
		    
		  #endif
		  
		  ' Create the test editor.
		  newTestWindowAction(true)
		  
		  'newRBScriptEditorAction
		  
		  ' newFTCEditFieldAction
		  
		  #if DebugBuild
		    
		    ' Run the test code.
		    test
		    
		  #endif
		End Sub
	#tag EndEvent

	#tag Event
		Function UnhandledException(error As RuntimeException) As Boolean
		  
		  Dim s as string
		  Dim fi as FolderItem
		  Dim tos as TextOutputStream
		  
		  ' Alert the user.
		  if showChoice("An unhandled exception occurred.", _
		    "Please save the error to a file and then send it to support@bkeeney.com.", _
		    "Save") then
		    
		    ' Ask the user for a file.
		    fi = GetSaveFolderItem("Text", "FTC demo error.txt")
		    
		    ' Did the user give use one?
		    if not (fi is nil) then
		      
		      ' Create the file.
		      tos = TextOutputStream.Create(fi)
		      
		      ' Were we able to open it?
		      if not (tos is nil) then
		        
		        ' Create the error message.
		        s = "OS = " + getProcessorType + EndOfLine
		        s = s + "Xojo Version = " + XojoVersionString + EndOfLine
		        s = s + "Exception Type = " + Introspection.GetType(error).FullName + EndOfLine + EndOfLine
		        s = s + "Stack Trace:" + EndOfLine
		        s = s + Join(error.Stack, EndOfLine)
		        
		        ' Write out the contents.
		        tos.write(s)
		        
		        ' Close the file.
		        tos.close
		        
		      end if
		      
		    end if
		    
		  end if
		  
		  ' We handled it.
		  return true
		  
		End Function
	#tag EndEvent


	#tag MenuHandler
		Function ExamplesEmbeddedFTC() As Boolean Handles ExamplesEmbeddedFTC.Action
			
			' Create a new embedded editor.
			newEmbeddedFTCAction
			
			' We handled it.
			return true
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function ExamplesFTCEditField() As Boolean Handles ExamplesFTCEditField.Action
			
			' Create the new editor.
			newFTCEditFieldAction
			
			' We handled it.
			return true
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function ExamplesFTCTextField() As Boolean Handles ExamplesFTCTextField.Action
			
			' Create the new editor.
			newFTCTextFieldAction
			
			' We handled it.
			return true
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function ExamplesRBCodeEditor() As Boolean Handles ExamplesRBCodeEditor.Action
			
			' Create a new RBScript editor.
			newRBScriptEditorAction
			
			' We handled it.
			return true
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function ExamplesTestWindow() As Boolean Handles ExamplesTestWindow.Action
			
			' Create a new window.
			newTestWindowAction(true)
			
			' We handled it.
			return true
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function ExamplesTextAreaRTF() As Boolean Handles ExamplesTextAreaRTF.Action
			winTextAreaRTF.show
			
			Return True
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function FileNew() As Boolean Handles FileNew.Action
			
			' Create a new window.
			newTestWindowAction(false)
			
			' We handled it.
			return true
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function FileOpen() As Boolean Handles FileOpen.Action
			
			Dim fi as FolderItem
			Dim tis as TextInputStream
			Dim s as string
			Dim suffix as string
			Dim tw as TestWindow
			
			#if TargetWindows
			
			' Ask the the user for a file.
			fi = GetOpenFolderItem(DemoFiletypes.FTC_ANY + DemoFiletypes.FTC_RTF + DemoFiletypes.FTC_TEXT + DemoFiletypes.FTC_XML)
			
			#else
			
			' Ask the the user for a file.
			fi = GetOpenFolderItem(DemoFiletypes.FTC_RTF + DemoFiletypes.FTC_TEXT + DemoFiletypes.FTC_XML)
			
			#endif
			
			' Did the user give us one?
			if not (fi is nil) then
			
			' Open the file.
			tis = TextInputStream.Open(fi)
			
			' Were we able to open the file?
			if not (tis is nil) then
			
			' Set the cursor to a watch.
			app.MouseCursor = System.Cursors.Wait
			
			' Read in all of the text.
			s = tis.ReadAll
			
			' Close the file.
			tis.Close
			
			' Get the file name.
			suffix = getSuffix(fi.name)
			
			try
			
			' Create the window.
			tw = new TestWindow(s, fi)
			
			' Show the window.
			tw.show
			
			' Reset the cursor.
			app.MouseCursor = nil
			
			catch excep as RuntimeException
			
			' Reset the cursor.
			app.MouseCursor = nil
			
			' Alert the user.
			showError("Unable to open the file """ + fi.Name + """.", "")
			
			end try
			
			end if
			
			end if
			
			' We handled it.
			return true
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function FilePageSetup() As Boolean Handles FilePageSetup.Action
			
			' Allow the user to set up the printer.
			call doPageSetup(true)
			
			' We handled it.
			return true
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function HelpAboutFormattedText() As Boolean Handles HelpAboutFormattedText.Action
			
			' Show the about window.
			aboutAction
			
			' We handled it.
			return true
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function HelpShowConsole() As Boolean Handles HelpShowConsole.Action
			
			' Show the console.
			showConsole
			
			' We handled it.
			return true
			
		End Function
	#tag EndMenuHandler


	#tag Method, Flags = &h0
		Sub aboutAction(delay as integer = - 1)
		  
		  Dim aw as AboutWindow
		  
		  ' Create the window.
		  aw = new AboutWindow(delay)
		  
		  ' Show the window.
		  aw.showModal
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub buildFontMenu()
		  
		  #pragma DisableBackgroundTasks
		  
		  Dim i as integer
		  Dim count as integer
		  Dim sa() as string
		  
		  ' Make it zero based.
		  count = FormatFont.count - 1
		  
		  ' Remove all the menu items.
		  for i = count downto 0
		    
		    ' Get rid of the font name.
		    FormatFont.Remove(i)
		    
		  next
		  
		  ' Make it zero based.
		  count = FontCount - 1
		  
		  ' Did we get any fonts?
		  if count > -1 then
		    
		    ' Add all of the font names.
		    for i = 0 to count
		      
		      ' Add the font.
		      sa.Append(Font(i))
		      
		    Next
		    
		    ' Sort the font names.
		    sa.sort
		    
		    ' Add all of the font names.
		    for i = 0 to count
		      
		      ' Set the menu text.
		      FormatFont.Append(new FontMenuItem(sa(i)))
		      
		    Next
		    
		  else
		    
		    ' Make it the default "None" item.
		    FormatFont.Append(new FontMenuItem("None"))
		    
		  end if
		  
		  ' Turn off the menu items.
		  setTargetStyleField(nil)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function doPageSetup(force as boolean) As boolean
		  
		  Dim result as boolean
		  
		  ' Assume we don't have a valid set up.
		  result = false
		  
		  ' Should we show the printer set up dialog?
		  if force then
		    
		    ' Does the printer setup exist?
		    if app.printer is nil then
		      
		      ' Allocate the printer object.
		      app.printer = new PrinterSetup
		      
		      ' Use the user defined resolution.
		      app.printer.MaxHorizontalResolution = -1
		      app.printer.MaxVerticalResolution = -1
		      
		    end if
		    
		    ' Show the printer setup dialog.
		    if app.printer.PageSetupDialog then
		      
		      ' The user OKed the printer set up.
		      result = true
		      
		    end if
		    
		  else
		    
		    ' Does the printer setup exist?
		    if app.printer is nil then
		      
		      ' Allocate the printer object.
		      app.printer = new PrinterSetup
		      
		      ' Use the user defined resolution.
		      app.printer.MaxHorizontalResolution = -1
		      app.printer.MaxVerticalResolution = -1
		      
		      ' Show the printer setup dialog.
		      if app.printer.PageSetupDialog then
		        
		        ' The user OKed the printer set up.
		        result = true
		        
		      else
		        
		        ' Release the printer object.
		        app.printer = nil
		        
		      end if
		      
		    else
		      
		      ' Use the current user settings.
		      result = true
		      
		    end if
		    
		  end if
		  
		  ' Return the page setup state.
		  return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetApplicationSupportFolder() As FolderItem
		  dim f as FolderItem = SpecialFolder.ApplicationData.child("com.bkeeney.formattedtextdemo")
		  
		  if f.exists = false or f.Directory = false then
		    f.CreateAsFolder
		  end
		  
		  return f
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getPrinter() As PrinterSetup
		  
		  ' Return the printer.
		  return printer
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getProcessorType() As string
		  
		  Dim s as string
		  
		  '------------------------------------
		  ' OS.
		  '------------------------------------
		  
		  if TargetMacOS then
		    
		    s = "Mac "
		    
		  Elseif TargetWindows Then
		    
		    s = "Windows "
		    
		  elseif TargetLinux then
		    
		    s = "Linux "
		    
		  else
		    
		    s = "Unknown "
		    
		  end if
		  
		  '------------------------------------
		  ' Processor.
		  '------------------------------------
		  
		  If Target32Bit Then
		    
		    s = s + "32-bit"
		    
		  Elseif Target64Bit Then
		    
		    s = s + "64-bit"
		    
		  else
		    
		    s = s + "Unknown"
		    
		  end if
		  
		  '------------------------------------
		  
		  ' Return the processor type.
		  return s
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function hasDirtyDocuments() As boolean
		  
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
		    
		    ' Is this a visible test window?
		    if (w.Frame = 0) and w.visible and (w isa TestWindow) then
		      
		      ' Is the window dirty?
		      if TestWindow(w).isDirty then return true
		      
		    end if
		    
		  next
		  
		  ' No dirty windows found.
		  return false
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub newEmbeddedFTCAction()
		  
		  Dim efw as EmbeddedFTCWindow
		  
		  ' Create the window.
		  efw = new EmbeddedFTCWindow
		  
		  ' Show the window.
		  efw.show
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub newFTCEditFieldAction()
		  
		  Dim few as FTCEditFieldWindow
		  
		  ' Create the window.
		  few = new FTCEditFieldWindow
		  
		  ' Show the window.
		  few.show
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub newFTCTextFieldAction()
		  
		  Dim ftfw as FTCTextFieldWindow
		  
		  ' Create the window.
		  ftfw = new FTCTextFieldWindow
		  
		  ' Show the window.
		  ftfw.show
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub newRBScriptEditorAction()
		  
		  Dim rbw as XojoScriptWindow
		  
		  ' Create the window.
		  rbw = new XojoScriptWindow
		  
		  ' Show the window.
		  rbw.show
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub newTestWindowAction(populate as boolean)
		  
		  Dim tw as TestWindow
		  
		  ' Create the window.
		  tw = new TestWindow(populate)
		  
		  
		  
		  ' Show the window.
		  tw.show
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setTargetStyleField(target as FontStyleInterface)
		  
		  ' Save the current style target.
		  targetStyleField = target
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setTargetStyleFieldFont(fontName as string)
		  
		  Dim tw as TestWindow
		  
		  ' Get the active window.
		  tw = TestWindow(getTopDocumentWindow)
		  
		  ' Set the font.
		  tw.TestDisplay.changeFont(fontName)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub test()
		  
		  ' This method is here for testing experimental code.
		  ' This method is called from the app's open event.
		  
		  ' Your code goes here...
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub timeTest()
		  
		  #pragma DisableBackgroundTasks
		  #pragma DisableBoundsChecking
		  #pragma NilObjectChecking false
		  #pragma StackOverflowChecking false
		  
		  Dim t as double
		  
		  ' Start the timing.
		  t = Microseconds
		  
		  ' End the timing.
		  t = (Microseconds - t) / 1000000.0
		  prt(Str(t))
		  
		  ' Show the results.
		  showConsole
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private printer As PrinterSetup
	#tag EndProperty

	#tag Property, Flags = &h0
		stopit As boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private targetStyleField As FontStyleInterface
	#tag EndProperty


	#tag Constant, Name = kEditClear, Type = String, Dynamic = False, Default = \"&Delete", Scope = Public
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"&Delete"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"&Delete"
	#tag EndConstant

	#tag Constant, Name = kFileQuit, Type = String, Dynamic = False, Default = \"Quit", Scope = Public
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"E&xit"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"E&xit"
	#tag EndConstant

	#tag Constant, Name = kFileQuitShortcut, Type = String, Dynamic = False, Default = \"", Scope = Public
		#Tag Instance, Platform = Mac OS, Language = Default, Definition  = \"Cmd+Q"
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="stopit"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
