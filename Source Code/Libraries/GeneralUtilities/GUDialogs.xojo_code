#tag Module
Protected Module GUDialogs
	#tag Method, Flags = &h0
		Function getOpenFolderItemSheet(parent as Window, filter as string) As FolderItem
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  Dim od as OpenDialog
		  Dim fi as FolderItem
		  
		  ' Allocate the open dialog.
		  od = new OpenDialog
		  
		  ' Set up the file filter for the open dialog.
		  od.Filter = filter
		  
		  ' Show it as a sheet window.
		  fi = od.ShowModalWithin(parent)
		  
		  return fi
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function saveAsDialogSheet(parent as Window, suggestedName as string) As FolderItem
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  Dim sd as SaveAsDialog
		  Dim fi as FolderItem
		  
		  ' Allocate the save dialog.
		  sd = new SaveAsDialog
		  
		  ' Set up the suggested file name.
		  sd.SuggestedFileName = suggestedName
		  
		  ' Show it as a sheet window.
		  fi = sd.ShowModalWithin(parent)
		  
		  return fi
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function showChoice(errorMessage as string, note as string, choiceButton as string) As boolean
		  #if not DebugBuild
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  Dim md as MessageDialog
		  
		  ' Create the dialog.
		  md = new MessageDialog
		  
		  ' Fill in the text in the dialog.
		  md.message = errorMessage
		  md.explanation = note
		  md.ActionButton.Caption = "Cancel"
		  md.CancelButton.Visible = true
		  md.CancelButton.Caption = choiceButton
		  md.Title = "Error"
		  md.icon = 1
		  
		  ' Get the user's attention.
		  Beep
		  
		  ' Show the dialog on the screen.
		  return md.ShowModal = md.CancelButton
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub showError(errorMessage as string, note as string)
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  Dim md as MessageDialog
		  
		  ' Create the dialog.
		  md = new MessageDialog
		  
		  ' Fill in the text in the dialog.
		  md.message = errorMessage
		  md.explanation = note
		  md.ActionButton.Caption = "OK"
		  md.Title = "Error"
		  md.icon = 1
		  
		  ' Get the user's attention.
		  Beep
		  
		  ' Show the dialog on the screen.
		  call md.ShowModal
		  
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
		
		getOpenFolderItemSheet
		----------------------
		
		  Description:
		
		    This function operates exactly the same as
		    getOpenFolderItem except that it opens the dialog as a
		    sheet window under OS X.
		
		  Parameters:
		
		    parent as Window:
		      The window you wish the sheet to open on.
		
		    filter as string:
		      The file filter. Same as for getOpenFolderItem.
		
		  Return:
		
		    FolderItem:
		      The folder item selected by the user.
		
		
		saveAsDialogSheet
		-----------------
		
		  Description:
		
		    This function operates exactly the same as saveAsDialog
		    except that it opens the dialog as a sheet window under
		    OS X.
		
		  Parameters:
		
		    parent as Window:
		      The window you wish the sheet to open on.
		
		    suggestedName as string:
		      The suggested file name.
		
		  Return:
		
		    FolderItem:
		      The folder item representing the user's choice.
		
		
		showChoice
		----------
		
		  Description:
		
		    This function will display dialog as a sheet window with
		    a choice button. If the user chooses the choice button,
		    this function will return true.
		
		  Parameters:
		
		    parent as Window:
		      The window to show the sheet on.
		
		    errorMessage as string:
		      Main error message in bold text.
		
		    note as string:
		      Supplementary information.
		
		    choiceButton as string:
		      Text for the choice button.
		
		  Return:
		
		    boolean:
		      True if the user selected the choice button.
		
		
		showChoice
		----------
		
		  Description:
		
		    This function will display dialog as a modal window with
		    a choice button. If the user chooses the choice button,
		    this function will return true.
		
		  Parameters:
		
		    errorMessage as string:
		      Main error message in bold text.
		
		    note as string:
		      Supplementary information.
		
		    choiceButton as string:
		      Text for the choice button.
		
		    Return:
		
		      boolean:
		        True if the user selected the choice button.
		
		
		showError
		---------
		
		  Description:
		
		    This subroutine displays an error dialog as a sheet
		    window.
		
		  Parameters:
		
		    parent as Window:
		      The window to show the sheet on.
		
		    errorMessage as string:
		      Main error message in bold text.
		
		    note as string:
		      Supplementary information.
		
		  Return:
		
		    None.
		
		
		showError
		---------
		
		  Description:
		
		    This subroutine displays an error dialog as a modal
		    window.
		
		  Parameters:
		
		    errorMessage as string:
		      Main error message in bold text.
		
		    note as string:
		      Supplementary information.
		
		  Return:
		
		    None.
		
		
		waitDialog
		----------
		
		  Description:
		
		    This will display sheet dialog asking the user to wait.
		
		  Parameters:
		
		    parent as Window:
		      The window you wish the sheet to open on.
		
		    waitMessage as string:
		      The main wait message you wish to display.
		
		    note as string:
		      A secondary note to display in the dialog.
		
		    windowThread as WaitWindowThread:
		      The worker thread to do the work while the user is
		      waiting. You must be a subclass of the
		      WaitWindowThread class and call "runComplete" when the
		      thread is done.
		
		  Return:
		
		    None.
		
		
		waitDialog
		----------
		
		  Description:
		
		    This will display modal dialog asking the user to wait.
		
		  Parameters:
		
		    parent as Window:
		      The window you wish the sheet to open on.
		
		    waitMessage as string:
		      The main wait message you wish to display.
		
		    note as string:
		      A secondary note to display in the dialog.
		
		    windowThread as WaitWindowThread:
		      The worker thread to do the work while the user is
		      waiting. You must be a subclass of the
		      WaitWindowThread class and call "runComplete" when the
		      thread is done.
		
		  Return:
		
		    None.
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
