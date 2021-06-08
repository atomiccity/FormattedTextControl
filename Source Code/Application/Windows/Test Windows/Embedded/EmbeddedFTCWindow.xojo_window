#tag Window
Begin Window EmbeddedFTCWindow
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   True
   Composite       =   False
   Frame           =   0
   FullScreen      =   False
   FullScreenButton=   False
   HasBackColor    =   False
   Height          =   400
   ImplicitInstance=   False
   LiveResize      =   "True"
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   True
   MaxWidth        =   32000
   MenuBar         =   0
   MenuBarVisible  =   True
   MinHeight       =   64
   MinimizeButton  =   True
   MinWidth        =   64
   Placement       =   0
   Resizeable      =   True
   Title           =   "Embedded FTC"
   Visible         =   True
   Width           =   600
   Begin TextInputCanvas cvs
      AutoDeactivate  =   True
      Enabled         =   True
      Height          =   360
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   0
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   20
      Visible         =   True
      Width           =   560
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub EnableMenuItems()
		  
		  #Pragma DisableBackgroundTasks
		  
		  #If Not DebugBuild
		    
		    #Pragma DisableBoundsChecking
		    #Pragma NilObjectChecking False
		    #Pragma StackOverflowChecking False
		    
		  #EndIf
		  
		  Dim i As Integer
		  Dim count As  Integer
		  
		  
		  ' Are we in read only mode?
		  If targetProxy.ftc.readOnly Then Return
		  
		  
		  '---------------------------------------------
		  ' Alignment.
		  '---------------------------------------------
		  
		  ' Turn on the alignment menu items.
		  AlignmentLeft.Enable
		  AlignmentCenter.Enable
		  AlignmentRight.Enable
		  
		  '---------------------------------------------
		  ' Font size.
		  '---------------------------------------------
		  
		  Size9.Enable
		  Size10.Enable
		  Size12.Enable
		  Size14.Enable
		  Size18.Enable
		  Size24.Enable
		  Size32.Enable
		  Size48.Enable
		  Size72.Enable
		  
		  '---------------------------------------------
		  ' Styles.
		  '---------------------------------------------
		  
		  StylePlain.Enable
		  StyleBold.Enable
		  StyleItalic.Enable
		  StyleUnderline.Enable
		  StyleStrikeThrough.Enable
		  StyleSubscript.Enable
		  StyleSuperscript.Enable
		  
		  '---------------------------------------------
		  ' Line spacing.
		  '---------------------------------------------
		  
		  LineSpacing_1.Enable
		  LineSpacing_15.Enable
		  LineSpacing_2.Enable
		  LineSpacing_25.Enable
		  LineSpacing_3.Enable
		  
		  '---------------------------------------------
		  ' Text color.
		  '---------------------------------------------
		  
		  ColorBlack.Enable
		  ColorRed.Enable
		  ColorGreen.Enable
		  ColorBlue.Enable
		  
		  '---------------------------------------------
		  ' Text background color.
		  '---------------------------------------------
		  
		  BackgroundColorNone.Enable
		  BackgroundColorRed.Enable
		  BackgroundColorGreen.Enable
		  BackgroundColorBlue.Enable
		  
		  '---------------------------------------------
		  ' Paragraph background color.
		  '---------------------------------------------
		  
		  ParagraphBackgroundColorNone.Enable
		  ParagraphBackgroundColorRed.Enable
		  ParagraphBackgroundColorGreen.Enable
		  ParagraphBackgroundColorblue.Enable
		  
		  '---------------------------------------------
		  ' Mark.
		  '---------------------------------------------
		  
		  MarkNone.Enable
		  MarkRed.Enable
		  MarkGreen.Enable
		  MarkBlue.Enable
		  
		  '---------------------------------------------
		  ' Insert.
		  '---------------------------------------------
		  
		  InsertPageBreak.Enable
		  InsertCustomHyperlink.Enable
		  
		  '---------------------------------------------
		  ' Paragraph styles.
		  '---------------------------------------------
		  
		  ' Turn on the paragraph style menu items.
		  ParagraphStyleNone.Enable
		  ParagraphStyleIndented.Enable
		  ParagraphStyleTitle.Enable
		  ParagraphStyleWildandCrazy.Enable
		  
		  '---------------------------------------------
		  ' Character styles.
		  '---------------------------------------------
		  
		  ' Is anything selected?
		  If targetProxy.ftc.getDoc.isSelected Then
		    
		    CharacterStylesNone.Enable
		    CharacterStylesTitle.Enable
		    CharacterStylesEmphasis.Enable
		    CharacterStylesFigure.Enable
		    
		  End If
		  
		  
		  
		  '---------------------------------------------
		  ' Fonts.
		  '---------------------------------------------
		  
		  ' Get the number of font menu items.
		  count = FormatFont.count - 1
		  
		  ' Enable the font menu.
		  For i = 0 To count
		    
		    ' Turn on the menu item.
		    FormatFont.item(i).Enable
		    
		  Next
		  
		  
		End Sub
	#tag EndEvent

	#tag Event
		Function MouseDown(X As Integer, Y As Integer) As Boolean
		  ' Bug in TextInputCanvas where returning false from the MouseDown event the event doesn't get
		  ' fired in the parent control/window like it should (as if it was a normal canvas).
		  ' See HandleMouseDown
		  
		  ' Are we in the first control?
		  if proxy1.isPointInControl(x, y) then
		    
		    ' Change the focus.
		    proxy2.callLostFocus
		    proxy1.callGotFocus
		    
		    ' Set the target proxy.
		    targetProxy = proxy1
		    
		    ' Are we in the second control?
		  elseif proxy2.isPointInControl(x, y) then
		    
		    ' Change the focus.
		    proxy1.callLostFocus
		    proxy2.callGotFocus
		    
		    ' Set the target proxy.
		    targetProxy = proxy2
		    
		  end if
		  
		End Function
	#tag EndEvent

	#tag Event
		Sub Resized()
		  
		  ' Resize the proxies to fit the display.
		  resizeProxies
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resizing()
		  
		  ' Resize the proxies to fit the display.
		  resizeProxies
		End Sub
	#tag EndEvent


	#tag MenuHandler
		Function AlignmentCenter() As Boolean Handles AlignmentCenter.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Set the alignment.
			targetProxy.ftc.changeCenterAlignment
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function AlignmentLeft() As Boolean Handles AlignmentLeft.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Set the alignment.
			targetProxy.ftc.changeLeftAlignment
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function AlignmentRight() As Boolean Handles AlignmentRight.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Set the alignment.
			targetProxy.ftc.changeRightAlignment
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function BackgroundColorBlue() As Boolean Handles BackgroundColorBlue.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Change the color.
			targetProxy.ftc.changeBackgroundColor(&c0000FF)
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function BackgroundColorGreen() As Boolean Handles BackgroundColorGreen.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Change the color.
			targetProxy.ftc.changeBackgroundColor(&c00FF00)
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function BackgroundColorNone() As Boolean Handles BackgroundColorNone.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Remove the color.
			targetProxy.ftc.changeBackgroundColor
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function BackgroundColorRed() As Boolean Handles BackgroundColorRed.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Change the color.
			targetProxy.ftc.changeBackgroundColor(&cFF0000)
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function ChangeCaseLower() As Boolean Handles ChangeCaseLower.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Change to lower case.
			targetProxy.ftc.changeToLowerCase
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function ChangeCaseTitle() As Boolean Handles ChangeCaseTitle.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Change to title case.
			targetProxy.ftc.changeToTitleCase
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function ChangeCaseUpper() As Boolean Handles ChangeCaseUpper.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Change to upper case.
			targetProxy.ftc.changeToUpperCase
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function CharacterStylesEmphasis() As Boolean Handles CharacterStylesEmphasis.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			Dim style as FTCharacterStyle
			
			' Get the character style.
			style = targetProxy.ftc.getDoc.getCharacterStyle("Emphasis")
			
			' Did we get a style?
			if not (style is nil) then
			
			' Set the character style for the selected text.
			targetProxy.ftc.changeCharacterStyle(style.getId)
			
			end if
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function CharacterStylesFigure() As Boolean Handles CharacterStylesFigure.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			Dim style as FTCharacterStyle
			
			' Get the character style.
			style = targetProxy.ftc.getDoc.getCharacterStyle("Figure")
			
			' Did we get a style?
			if not (style is nil) then
			
			' Set the character style for the selected text.
			targetProxy.ftc.changeCharacterStyle(style.getId)
			
			end if
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function CharacterStylesNone() As Boolean Handles CharacterStylesNone.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Set the character style for the selected text.
			targetProxy.ftc.changeCharacterStyle
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function CharacterStylesTitle() As Boolean Handles CharacterStylesTitle.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			Dim style as FTCharacterStyle
			
			' Get the character style.
			style = targetProxy.ftc.getDoc.getCharacterStyle("Title")
			
			' Did we get a style?
			if not (style is nil) then
			
			' Set the character style for the selected text.
			targetProxy.ftc.changeCharacterStyle(style.getId)
			
			end if
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function ColorBlack() As Boolean Handles ColorBlack.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Change the color.
			targetProxy.ftc.changeTextColor(&c000000)
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function ColorBlue() As Boolean Handles ColorBlue.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Change the color.
			targetProxy.ftc.changeTextColor(&c0000FF)
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function ColorGreen() As Boolean Handles ColorGreen.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Change the color.
			targetProxy.ftc.changeTextColor(&c00FF00)
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function ColorRed() As Boolean Handles ColorRed.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Change the color.
			targetProxy.ftc.changeTextColor(&cFF0000)
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function EditClear() As Boolean Handles EditClear.Action
			
			#if not DebugBuild
			
			#pragma BoundsChecking FTC_BOUNDSCHECKING
			#pragma NilObjectChecking FTC_NILOBJECTCHECKING
			#pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
			
			#endif
			
			' Perform the clear action.
			targetProxy.ftc.editClearAction
			
			' We handled the event.
			return true
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function EditCopy() As Boolean Handles EditCopy.Action
			
			#if not DebugBuild
			
			#pragma BoundsChecking FTC_BOUNDSCHECKING
			#pragma NilObjectChecking FTC_NILOBJECTCHECKING
			#pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
			
			#endif
			
			' Perform the copy action.
			targetProxy.ftc.editCopyAction
			
			' We handled the event.
			return true
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function EditCut() As Boolean Handles EditCut.Action
			
			#if not DebugBuild
			
			#pragma BoundsChecking FTC_BOUNDSCHECKING
			#pragma NilObjectChecking FTC_NILOBJECTCHECKING
			#pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
			
			#endif
			
			' Perform the cut action.
			targetProxy.ftc.editCutAction
			
			' We handled the event.
			return true
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function EditPaste() As Boolean Handles EditPaste.Action
			
			#if not DebugBuild
			
			#pragma BoundsChecking FTC_BOUNDSCHECKING
			#pragma NilObjectChecking FTC_NILOBJECTCHECKING
			#pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
			
			#endif
			
			' Perform the paste action.
			targetProxy.ftc.editPasteAction
			
			' We handled the event.
			return true
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function EditRedo() As Boolean Handles EditRedo.Action
			
			#if not DebugBuild
			
			#pragma BoundsChecking FTC_BOUNDSCHECKING
			#pragma NilObjectChecking FTC_NILOBJECTCHECKING
			#pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
			
			#endif
			
			' Perform the redo action.
			targetProxy.ftc.editRedoAction
			
			' We handled the event.
			return true
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function EditUndo() As Boolean Handles EditUndo.Action
			
			#if not DebugBuild
			
			#pragma BoundsChecking FTC_BOUNDSCHECKING
			#pragma NilObjectChecking FTC_NILOBJECTCHECKING
			#pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
			
			#endif
			
			' Perform the undo action.
			targetProxy.ftc.editUndoAction
			
			' We handled the event.
			return true
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function LineSpacing_1() As Boolean Handles LineSpacing_1.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Set the line spacing.
			targetProxy.ftc.changeLineSpacing(1.0)
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function LineSpacing_15() As Boolean Handles LineSpacing_15.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Set the line spacing.
			targetProxy.ftc.changeLineSpacing(1.5)
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function LineSpacing_2() As Boolean Handles LineSpacing_2.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Set the line spacing.
			targetProxy.ftc.changeLineSpacing(2.0)
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function LineSpacing_25() As Boolean Handles LineSpacing_25.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Set the line spacing.
			targetProxy.ftc.changeLineSpacing(2.5)
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function LineSpacing_3() As Boolean Handles LineSpacing_3.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Set the line spacing.
			targetProxy.ftc.changeLineSpacing(3.0)
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function MarkBlue() As Boolean Handles MarkBlue.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Change the mark color.
			targetProxy.ftc.changeMark(&c0000FF)
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function MarkGreen() As Boolean Handles MarkGreen.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Change the mark color.
			targetProxy.ftc.changeMark(&c00FF00)
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function MarkNone() As Boolean Handles MarkNone.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Remove the mark color.
			targetProxy.ftc.changeMark
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function MarkRed() As Boolean Handles MarkRed.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Change the mark color.
			targetProxy.ftc.changeMark(&cFF0000)
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function Opacity25() As Boolean Handles Opacity25.Action
			targetProxy.ftc.changeOpacity(25)
			Return True
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function Opacity50() As Boolean Handles Opacity50.Action
			targetProxy.ftc.changeOpacity(50)
			Return True
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function Opacity75() As Boolean Handles Opacity75.Action
			targetProxy.ftc.changeOpacity(75)
			Return True
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function OpacityZero() As Boolean Handles OpacityZero.Action
			targetProxy.ftc.changeOpacity(0)
			Return True
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function Size10() As Boolean Handles Size10.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Change the font size.
			targetProxy.ftc.changeSize(10)
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function Size12() As Boolean Handles Size12.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Change the font size.
			targetProxy.ftc.changeSize(12)
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function Size14() As Boolean Handles Size14.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Change the font size.
			targetProxy.ftc.changeSize(14)
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function Size18() As Boolean Handles Size18.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Change the font size.
			targetProxy.ftc.changeSize(18)
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function Size24() As Boolean Handles Size24.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Change the font size.
			targetProxy.ftc.changeSize(24)
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function Size32() As Boolean Handles Size32.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Change the font size.
			targetProxy.ftc.changeSize(32)
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function Size48() As Boolean Handles Size48.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Change the font size.
			targetProxy.ftc.changeSize(48)
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function Size72() As Boolean Handles Size72.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Change the font size.
			targetProxy.ftc.changeSize(72)
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function Size9() As Boolean Handles Size9.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Change the font size.
			targetProxy.ftc.changeSize(9)
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function StyleBold() As Boolean Handles StyleBold.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Change the style.
			targetProxy.ftc.changeBoldStyle
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function StyleItalic() As Boolean Handles StyleItalic.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Change the style.
			targetProxy.ftc.changeItalicStyle
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function StylePlain() As Boolean Handles StylePlain.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Change the style.
			targetProxy.ftc.changePlainStyle
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function StyleStrikeThrough() As Boolean Handles StyleStrikeThrough.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Change the style.
			targetProxy.ftc.changeStrikeThrough
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function StyleSubscript() As Boolean Handles StyleSubscript.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Change the style.
			targetProxy.ftc.changeSubscript
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function StyleSuperscript() As Boolean Handles StyleSuperscript.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Change the style.
			targetProxy.ftc.changeSuperscript
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function StyleUnderline() As Boolean Handles StyleUnderline.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Change the style.
			targetProxy.ftc.changeUnderlineStyle
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler


	#tag Method, Flags = &h21
		Private Function HandleMouseDown(x as integer, y as Integer) As boolean
		  ' Bug in TextInputCanvas where returning false from the MouseDown event the event doesn't get
		  ' fired in the parent control/window like it should (as if it was a normal canvas).
		  ' This replaces Window.MouseDown event.
		  
		  ' Are we in the first control?
		  if proxy1.isPointInControl(x, y) then
		    
		    ' Change the focus.
		    proxy2.callLostFocus
		    proxy1.callGotFocus
		    
		    ' Set the target proxy.
		    targetProxy = proxy1
		    
		    ' Are we in the second control?
		  elseif proxy2.isPointInControl(x, y) then
		    
		    ' Change the focus.
		    proxy1.callLostFocus
		    proxy2.callGotFocus
		    
		    ' Set the target proxy.
		    targetProxy = proxy2
		    
		  end if
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub resizeProxies()
		  
		  Dim width as integer
		  Dim height as integer
		  
		  ' Calculate the dimensions.
		  width = (cvs.Width / 2) - 30
		  height = cvs.Height - 40
		  
		  ' Set the first proxy.
		  proxy1.setPosition(20, 20)
		  proxy1.setDimensions(width, height)
		  
		  ' Set the second proxy.
		  proxy2.setPosition((cvs.Width / 2) + 10, 20)
		  proxy2.setDimensions(width, height)
		  
		  ' Draw the FTC content.
		  proxy1.resize
		  proxy2.resize
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected proxy1 As FTCProxy
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected proxy2 As FTCProxy
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected targetProxy As FTCProxy
	#tag EndProperty


#tag EndWindowCode

#tag Events cvs
	#tag Event
		Sub Open()
		  //If you get a compile error like this:
		  ' cvs on EmbeddedFTCWindow implements the event "Open", but its superclass TextInputCanvas does not declare such an event.
		  //It means you do NOT have the MBS Xojo _TextInputCanvas Plugin.xojo_plugin installed in your Xojo plugins folder.
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim tw as TestProxyWindow
		  
		  ' Set up the drop types.
		  me.AcceptTextDrop
		  me.AcceptPictureDrop
		  me.AcceptRawDataDrop(FormattedText.RTF_DATA_TYPE)
		  me.AcceptRawDataDrop(FormattedText.XML_DATA_TYPE)
		  me.AcceptRawDataDrop(FormattedText.PRIVATE_DROP_TYPE)
		  
		  ' Create the first proxy.
		  tw = new TestProxyWindow
		  proxy1 = new FTCProxy(me, tw.target)
		  
		  ' Create the second proxy.
		  tw = new TestProxyWindow
		  proxy2 = new FTCProxy(me, tw.target)
		  
		  ' Set the target proxy.
		  targetProxy = proxy1
		  
		  ' Resize the proxies to fit the display.
		  resizeProxies
		  
		End Sub
	#tag EndEvent
	#tag Event
		Sub Paint(g as Graphics, areas() as object)
		  //If you get a compile error like this:
		  ' cvs on EmbeddedFTCWindow implements the event "Paint", but its superclass TextInputCanvas does not declare such an event.
		  //It means you do NOT have the MBS Xojo _TextInputCanvas Plugin.xojo_plugin installed in your Xojo plugins folder.
		  
		  #pragma unused areas
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  dim dScaleFactor as double = self.ScalingFactor
		  dim p as new picture(me.Width*dScaleFactor, me.Height*dScaleFactor, 32)
		  dim pg as graphics = p.Graphics
		  
		  ' Erase the background.
		  pg.ForeColor = &c8DADD5
		  pg.FillRect(0, 0, pg.width, pg.height)
		  
		  ' Draw the FTC content.
		  proxy1.update(true)
		  proxy2.update(true)
		  
		  pg.DrawPicture proxy1.ftc.myPic, proxy1.ftc.xPos*dScaleFactor, proxy1.ftc.yPos*dScaleFactor
		  pg.DrawPicture proxy2.ftc.myPic, proxy2.ftc.xPos*dScaleFactor, proxy2.ftc.yPos*dScaleFactor
		  
		  ' Draw the enclosing rectangle.
		  pg.ForeColor = &cAEAEAE
		  pg.DrawRect(0, 0, pg.width, pg.height)
		  
		  g.DrawPicture p, _
		  0, 0, p.Width/dScaleFactor, p.Height/dScaleFactor, _
		  0, 0, p.Width, p.Height
		End Sub
	#tag EndEvent
	#tag Event
		Sub GotFocus()
		  //If you get a compile error like this:
		  ' cvs on EmbeddedFTCWindow implements the event "GotFocus", but its superclass TextInputCanvas does not declare such an event.
		  //It means you do NOT have the MBS Xojo _TextInputCanvas Plugin.xojo_plugin installed in your Xojo plugins folder.
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Invoke the event.
		  targetProxy.callGotFocus
		  
		End Sub
	#tag EndEvent
	#tag Event
		Function MouseDown(x as Integer, y as Integer) As Boolean
		  //If you get a compile error like this:
		  ' cvs on EmbeddedFTCWindow implements the event "MouseDown", but its superclass TextInputCanvas does not declare such an event.
		  //It means you do NOT have the MBS Xojo _TextInputCanvas Plugin.xojo_plugin installed in your Xojo plugins folder.
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  //NOTE:  If we return FALSE from this event the event then falls through
		  //to the Window.MouseDown event handler
		  
		  ' Invoke the event.
		  dim b as boolean = targetProxy.callMouseDown(x, y)
		  
		  ' Bug in TextInputCanvas where returning false from the MouseDown event the event doesn't get
		  ' fired in the parent control/window like it should (as if it was a normal canvas).
		  ' See HandleMouseDown
		  If b = false then
		    b = HandleMouseDown(x, y)
		  end
		  return b
		  
		End Function
	#tag EndEvent
	#tag Event
		Sub MouseDrag(x as Integer, y as Integer)
		  //If you get a compile error like this:
		  ' cvs on EmbeddedFTCWindow implements the event "MouseDrag", but its superclass TextInputCanvas does not declare such an event.
		  //It means you do NOT have the MBS Xojo _TextInputCanvas Plugin.xojo_plugin installed in your Xojo plugins folder.
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Invoke the event.
		  targetProxy.callMouseDrag(x, y)
		  
		End Sub
	#tag EndEvent
	#tag Event
		Sub MouseUp(x as Integer, y as Integer)
		  //If you get a compile error like this:
		  ' cvs on EmbeddedFTCWindow implements the event "MouseUp", but its superclass TextInputCanvas does not declare such an event.
		  //It means you do NOT have the MBS Xojo _TextInputCanvas Plugin.xojo_plugin installed in your Xojo plugins folder.
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Invoke the event.
		  targetProxy.callMouseUp(x, y)
		  
		End Sub
	#tag EndEvent
	#tag Event
		Function KeyDown(Key As String) As Boolean
		  //If you get a compile error like this:
		  ' cvs on EmbeddedFTCWindow implements the event "KeyDown", but its superclass TextInputCanvas does not declare such an event.
		  //It means you do NOT have the MBS Xojo _TextInputCanvas Plugin.xojo_plugin installed in your Xojo plugins folder.
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  //This is a Mac Only event.  If you leave this off, double characters show up in Windows
		  #if TargetMacOS then
		    ' Invoke the event.
		    return targetProxy.callKeyDown(key)
		  #endif
		End Function
	#tag EndEvent
	#tag Event
		Sub LostFocus()
		  //If you get a compile error like this:
		  ' cvs on EmbeddedFTCWindow implements the event "LostFocus", but its superclass TextInputCanvas does not declare such an event.
		  //It means you do NOT have the MBS Xojo _TextInputCanvas Plugin.xojo_plugin installed in your Xojo plugins folder.
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Invoke the event.
		  targetProxy.callLostFocus
		  
		End Sub
	#tag EndEvent
	#tag Event
		Sub EnableMenuItems()
		  //If you get a compile error like this:
		  ' cvs on EmbeddedFTCWindow implements the event "EnableMenuItems", but its superclass TextInputCanvas does not declare such an event.
		  //It means you do NOT have the MBS Xojo _TextInputCanvas Plugin.xojo_plugin installed in your Xojo plugins folder.
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Invoke the event.
		  targetProxy.callEnableMenuItems
		  
		End Sub
	#tag EndEvent
	#tag Event
		Sub MouseEnter()
		  //If you get a compile error like this:
		  ' cvs on EmbeddedFTCWindow implements the event "MouseEnter", but its superclass TextInputCanvas does not declare such an event.
		  //It means you do NOT have the MBS Xojo _TextInputCanvas Plugin.xojo_plugin installed in your Xojo plugins folder.
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Invoke the event.
		  targetProxy.callMouseEnter
		  
		End Sub
	#tag EndEvent
	#tag Event
		Sub MouseExit()
		  //If you get a compile error like this:
		  ' cvs on EmbeddedFTCWindow implements the event "MouseExit", but its superclass TextInputCanvas does not declare such an event.
		  //It means you do NOT have the MBS Xojo _TextInputCanvas Plugin.xojo_plugin installed in your Xojo plugins folder.
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Invoke the event.
		  targetProxy.callMouseExit
		  
		End Sub
	#tag EndEvent
	#tag Event
		Sub MouseMove(X As Integer, Y As Integer)
		  //If you get a compile error like this:
		  ' cvs on EmbeddedFTCWindow implements the event "MouseMove", but its superclass TextInputCanvas does not declare such an event.
		  //It means you do NOT have the MBS Xojo _TextInputCanvas Plugin.xojo_plugin installed in your Xojo plugins folder.
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Invoke the event.
		  targetProxy.callMouseMove(x, y)
		  
		End Sub
	#tag EndEvent
	#tag Event
		Function MouseWheel(X As Integer, Y As Integer, deltaX as Integer, deltaY as Integer) As Boolean
		  //If you get a compile error like this:
		  ' cvs on EmbeddedFTCWindow implements the event "MouseWheel", but its superclass TextInputCanvas does not declare such an event.
		  //It means you do NOT have the MBS Xojo _TextInputCanvas Plugin.xojo_plugin installed in your Xojo plugins folder.
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Invoke the event.
		  return targetProxy.callMouseWheel(x, y, deltaX, deltaY)
		  
		End Function
	#tag EndEvent
	#tag Event
		Sub DropObject(obj As DragItem, action As Integer)
		  //If you get a compile error like this:
		  ' cvs on EmbeddedFTCWindow implements the event "DropObject", but its superclass TextInputCanvas does not declare such an event.
		  //It means you do NOT have the MBS Xojo _TextInputCanvas Plugin.xojo_plugin installed in your Xojo plugins folder.
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Invoke the event.
		  targetProxy.callDropObject(obj, action)
		  
		End Sub
	#tag EndEvent
	#tag Event
		Function ConstructContextualMenu(base as MenuItem, x as Integer, y as Integer) As Boolean
		  //If you get a compile error like this:
		  ' cvs on EmbeddedFTCWindow implements the event "ConstructContextualMenu", but its superclass TextInputCanvas does not declare such an event.
		  //It means you do NOT have the MBS Xojo _TextInputCanvas Plugin.xojo_plugin installed in your Xojo plugins folder.
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Invoke the event.
		  return targetProxy.callConstructContexualMenu(base, x, y)
		  
		End Function
	#tag EndEvent
	#tag Event
		Function ContextualMenuAction(hitItem as MenuItem) As Boolean
		  //If you get a compile error like this:
		  ' cvs on EmbeddedFTCWindow implements the event "ContextualMenuAction", but its superclass TextInputCanvas does not declare such an event.
		  //It means you do NOT have the MBS Xojo _TextInputCanvas Plugin.xojo_plugin installed in your Xojo plugins folder.
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Invoke the event.
		  return targetProxy.callContextualMenuAction(hitItem)
		  
		End Function
	#tag EndEvent
	#tag Event
		Sub InsertText(text as string, range as TextRange)
		  //If you get a compile error like this:
		  ' cvs on EmbeddedFTCWindow implements the event "InsertText", but its superclass TextInputCanvas does not declare such an event.
		  //It means you do NOT have the MBS Xojo _TextInputCanvas Plugin.xojo_plugin installed in your Xojo plugins folder.
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  targetProxy.ftc.callInsertTextEvent(text, range)
		End Sub
	#tag EndEvent
	#tag Event
		Function IncompleteTextRange() As TextRange
		  //If you get a compile error like this:
		  ' cvs on EmbeddedFTCWindow implements the event "IncompleteTextRange", but its superclass TextInputCanvas does not declare such an event.
		  //It means you do NOT have the MBS Xojo _TextInputCanvas Plugin.xojo_plugin installed in your Xojo plugins folder.
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Return targetProxy.ftc.TIC_m_incompleteTextRange
		End Function
	#tag EndEvent
	#tag Event
		Function FontSizeAtLocation(location as integer) As integer
		  //If you get a compile error like this:
		  ' cvs on EmbeddedFTCWindow implements the event "FontSizeAtLocation", but its superclass TextInputCanvas does not declare such an event.
		  //It means you do NOT have the MBS Xojo _TextInputCanvas Plugin.xojo_plugin installed in your Xojo plugins folder.
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Return targetProxy.ftc.CallFontSizeAtLocation(location)
		End Function
	#tag EndEvent
	#tag Event
		Function DoCommand(command as string) As boolean
		  //If you get a compile error like this:
		  ' cvs on EmbeddedFTCWindow implements the event "DoCommand", but its superclass TextInputCanvas does not declare such an event.
		  //It means you do NOT have the MBS Xojo _TextInputCanvas Plugin.xojo_plugin installed in your Xojo plugins folder.
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  return targetProxy.ftc.callDoCommand(command)
		End Function
	#tag EndEvent
	#tag Event
		Sub DiscardIncompleteText()
		  //If you get a compile error like this:
		  ' cvs on EmbeddedFTCWindow implements the event "DiscardIncompleteText", but its superclass TextInputCanvas does not declare such an event.
		  //It means you do NOT have the MBS Xojo _TextInputCanvas Plugin.xojo_plugin installed in your Xojo plugins folder.
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  targetProxy.ftc.callDiscardIncompleteText()
		End Sub
	#tag EndEvent
	#tag Event
		Function CharacterAtPoint(x as integer, y as integer) As integer
		  //If you get a compile error like this:
		  ' cvs on EmbeddedFTCWindow implements the event "CharacterAtPoint", but its superclass TextInputCanvas does not declare such an event.
		  //It means you do NOT have the MBS Xojo _TextInputCanvas Plugin.xojo_plugin installed in your Xojo plugins folder.
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  return targetProxy.ftc.CallCharacterAtPoint(x,y)
		End Function
	#tag EndEvent
	#tag Event
		Function BaselineAtIndex(index as integer) As integer
		  //If you get a compile error like this:
		  ' cvs on EmbeddedFTCWindow implements the event "BaselineAtIndex", but its superclass TextInputCanvas does not declare such an event.
		  //It means you do NOT have the MBS Xojo _TextInputCanvas Plugin.xojo_plugin installed in your Xojo plugins folder.
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  return targetProxy.ftc.callBaseLineAtIndex(index)
		End Function
	#tag EndEvent
	#tag Event
		Function TextLength() As integer
		  //If you get a compile error like this:
		  ' cvs on EmbeddedFTCWindow implements the event "TextLength", but its superclass TextInputCanvas does not declare such an event.
		  //It means you do NOT have the MBS Xojo _TextInputCanvas Plugin.xojo_plugin installed in your Xojo plugins folder.
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Return targetProxy.ftc.callTextLength
		End Function
	#tag EndEvent
	#tag Event
		Function TextForRange(range as TextRange) As string
		  //If you get a compile error like this:
		  ' cvs on EmbeddedFTCWindow implements the event "TextForRange", but its superclass TextInputCanvas does not declare such an event.
		  //It means you do NOT have the MBS Xojo _TextInputCanvas Plugin.xojo_plugin installed in your Xojo plugins folder.
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Return targetProxy.ftc.callTextForRange(range)
		End Function
	#tag EndEvent
	#tag Event
		Sub SetIncompleteText(text as string, replacementRange as TextRange, relativeSelection as TextRange)
		  //If you get a compile error like this:
		  ' cvs on EmbeddedFTCWindow implements the event "SetIncompleteText", but its superclass TextInputCanvas does not declare such an event.
		  //It means you do NOT have the MBS Xojo _TextInputCanvas Plugin.xojo_plugin installed in your Xojo plugins folder.
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  targetProxy.ftc.CallSetIncompleteText(text, replacementRange, relativeSelection)
		End Sub
	#tag EndEvent
	#tag Event
		Function FontNameAtLocation(location as integer) As string
		  //If you get a compile error like this:
		  ' cvs on EmbeddedFTCWindow implements the event "FontNameAtLocation", but its superclass TextInputCanvas does not declare such an event.
		  //It means you do NOT have the MBS Xojo _TextInputCanvas Plugin.xojo_plugin installed in your Xojo plugins folder.
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Return targetProxy.ftc.CallFontNameAtLocation(location)
		End Function
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="MinimumWidth"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumHeight"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximumWidth"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximumHeight"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Type"
		Visible=true
		Group="Frame"
		InitialValue="0"
		Type="Types"
		EditorType="Enum"
		#tag EnumValues
			"0 - Document"
			"1 - Movable Modal"
			"2 - Modal Dialog"
			"3 - Floating Window"
			"4 - Plain Box"
			"5 - Shadowed Box"
			"6 - Rounded Window"
			"7 - Global Floating Window"
			"8 - Sheet Window"
			"9 - Metal Window"
			"11 - Modeless Dialog"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasCloseButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMaximizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMinimizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasFullScreenButton"
		Visible=true
		Group="Frame"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="DefaultLocation"
		Visible=true
		Group="Behavior"
		InitialValue="0"
		Type="Locations"
		EditorType="Enum"
		#tag EnumValues
			"0 - Default"
			"1 - Parent Window"
			"2 - Main Screen"
			"3 - Parent Window Screen"
			"4 - Stagger"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasBackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="BackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="&hFFFFFF"
		Type="Color"
		EditorType="Color"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Backdrop"
		Visible=true
		Group="Appearance"
		InitialValue=""
		Type="Picture"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Composite"
		Visible=true
		Group="Appearance"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="FullScreen"
		Visible=true
		Group="Appearance"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Position"
		InitialValue="400"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="ImplicitInstance"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Interfaces"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MacProcID"
		Visible=true
		Group="Appearance"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBar"
		Visible=true
		Group="Appearance"
		InitialValue=""
		Type="MenuBar"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBarVisible"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
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
		Name="Resizeable"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
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
		Name="Title"
		Visible=true
		Group="Appearance"
		InitialValue="Untitled"
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Width"
		Visible=true
		Group="Position"
		InitialValue="600"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
