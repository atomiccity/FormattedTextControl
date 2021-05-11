#tag Window
Begin BaseWindow TestWindow
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   True
   Compatibility   =   ""
   Composite       =   False
   Frame           =   0
   FullScreen      =   False
   FullScreenButton=   False
   HasBackColor    =   False
   Height          =   679
   ImplicitInstance=   True
   LiveResize      =   True
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   True
   MaxWidth        =   32000
   MenuBar         =   1610178758
   MenuBarVisible  =   True
   MinHeight       =   300
   MinimizeButton  =   True
   MinWidth        =   300
   Placement       =   0
   Resizeable      =   True
   Title           =   " "
   Visible         =   False
   Width           =   720
   Begin FormattedText TestDisplay
      AllowBackgroundUpdates=   True
      AllowPictures   =   True
      AutoComplete    =   False
      AutoDeactivate  =   True
      BackgroundColor =   &cA0ADCD00
      BorderColor     =   &cA0A0A000
      BottomMargin    =   1.0
      CaretColor      =   &c00000000
      CornerColor     =   &cFFFFFF00
      DefaultFont     =   "Arial"
      DefaultFontSize =   12
      defaultHyperLinkColor=   &c0000FF00
      defaultHyperLinkColorDisabled=   &cCCCCCC00
      defaultHyperLinkColorRollover=   &cFF000000
      defaultHyperLinkColorVisited=   &c80008000
      DefaultTabStop  =   0.5
      DefaultTextColor=   &c00000000
      DisplayAlignment=   "1"
      DragAndDrop     =   True
      DrawControlBorder=   True
      EditViewMargin  =   0.0599999999999999977796
      EditViewPrintMargin=   0.5
      Enabled         =   True
      Height          =   635
      HelpTag         =   ""
      HScrollbarAutoHide=   True
      Index           =   -2147483648
      InhibitSelections=   False
      InitialParent   =   ""
      InvisiblesColor =   &c526AFF00
      IsHiDPT         =   False
      Left            =   20
      LeftMargin      =   1.0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      MarginGuideColor=   &cCACACA00
      Mode            =   "0"
      objectCountId   =   0
      PageHeight      =   11.0
      PageWidth       =   8.5
      ReadOnly        =   False
      RightMargin     =   1.0
      Scope           =   0
      ShowInvisibles  =   True
      ShowMarginGuides=   True
      ShowPilcrows    =   True
      SpellCheckWhileTyping=   True
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      TIC_PageTop     =   0
      TIC_xCaret      =   0
      TIC_yCaret      =   0
      Top             =   14
      TopMargin       =   1.0
      UndoLimit       =   128
      updateFlag      =   False
      UsePageShadow   =   True
      Visible         =   True
      VScrollbarAutoHide=   True
      Width           =   680
      WordParagraphBackground=   True
      xDisplayAlignmentOffset=   0
   End
   Begin FTScrollBar VScrollbar
      AcceptFocus     =   True
      AutoDeactivate  =   True
      Enabled         =   True
      Height          =   100
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   436
      LineStep        =   8
      LiveScroll      =   True
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Maximum         =   100
      Minimum         =   0
      PageStep        =   20
      Scope           =   0
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   144
      Transparent     =   False
      Value           =   0
      Visible         =   True
      Width           =   16
   End
   Begin FTScrollBar HScrollbar
      AcceptFocus     =   True
      AutoDeactivate  =   True
      Enabled         =   True
      Height          =   16
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   263
      LineStep        =   8
      LiveScroll      =   True
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Maximum         =   100
      Minimum         =   0
      PageStep        =   20
      Scope           =   0
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   311
      Transparent     =   False
      Value           =   0
      Visible         =   True
      Width           =   161
   End
   Begin Label Coordinates
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   False
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Coordinates = (---, ---) (---: ---, ---)"
      TextAlign       =   0
      TextColor       =   &c00000000
      TextFont        =   "geneva"
      TextSize        =   10.0
      TextUnit        =   0
      Top             =   658
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   680
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Function CancelClose(appQuitting as Boolean) As Boolean
		  #if not DebugBuild
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  Dim message as string
		  Dim note as string
		  
		  ' Is the document dirty?
		  if (not appQuitting) and dirty then
		    
		    ' Set up the dialog.
		    message = "This document has unsave edits."
		    note = "Are you sure you want to close this document?"
		    
		    ' Ask the user what they want to do.
		    if not showChoice(message, note, "Close") then
		      
		      ' Cancel the close.
		      return true
		      
		    end if
		    
		  end if
		  
		  ' Continue the close.
		  return false
		End Function
	#tag EndEvent

	#tag Event
		Sub Close()
		  
		  ' Does the search and replace window exist?
		  if not (sarWindow is nil) then sarWindow.close
		  
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub EnableMenuItems()
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as  integer
		  
		  ' Set the display mode checkmark.
		  setDisplayModeCheckmark
		  
		  ' Set the display alignment checkmark.
		  setDisplayAlignmentCheckmark
		  
		  ' Set the scale checkmark.
		  setScaleCheckmark
		  
		  ' Are we in read only mode?
		  if TestDisplay.readOnly then return
		  
		  '---------------------------------------------
		  ' File save.
		  '---------------------------------------------
		  
		  ' Has the file been saved or opened?
		  if not (currentFolderItem is nil) then
		    
		    FileSave.Enable
		    
		  end if
		  
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
		  if TestDisplay.getDoc.isSelected then
		    
		    CharacterStylesNone.Enable
		    CharacterStylesTitle.Enable
		    CharacterStylesEmphasis.Enable
		    CharacterStylesFigure.Enable
		    
		  end if
		  
		  '---------------------------------------------
		  ' Adjust margins.
		  '---------------------------------------------
		  
		  ' Are we in non-edit view mode?
		  if not TestDisplay.isEditViewMode then
		    
		    ' Turn on the adjust margins menu item.
		    FormatAdjustMargins.Enable
		    
		  end if
		  
		  '---------------------------------------------
		  ' Reset image size.
		  '---------------------------------------------
		  
		  ' Is an image in resize mode?
		  if TestDisplay.getDoc.isInResizeMode then
		    
		    ' Turn on the image reset.
		    FormatResetImageSize.Enable
		    
		  end if
		  
		  '---------------------------------------------
		  ' Fonts.
		  '---------------------------------------------
		  
		  ' Get the number of font menu items.
		  count = FormatFont.count - 1
		  
		  ' Enable the font menu.
		  for i = 0 to count
		    
		    ' Turn on the menu item.
		    FormatFont.item(i).Enable
		    
		  next
		  
		  '---------------------------------------------
		  ' Adjust paragraphs.
		  '---------------------------------------------
		  
		  ' Are we in non-edit view mode?
		  if not TestDisplay.isEditViewMode then
		    
		    ' Turn on the menu item.
		    FormatAdjustParagraph.Enable
		    
		  end if
		  
		  '---------------------------------------------
		  ' Other.
		  '---------------------------------------------
		  
		  ' Set the check marks.
		  FormatShowMarginGuides.Checked = TestDisplay.ShowMarginGuides
		  FormatShowInvisibles.Checked = TestDisplay.ShowInvisibles
		  FormatMakeReadOnly.Checked = TestDisplay.ReadOnly
		  EditCheckSpellingasYouType.Checked = TestDisplay.SpellCheckWhileTyping
		  
		  '---------------------------------------------
		  ' Scrollbars.
		  '---------------------------------------------
		  
		  ' Are we auto hiding the scrollbars?
		  if TestDisplay.VScrollbarAutoHide then
		    
		    ' Check the auto hide.
		    ToggleScrollbarsAutoHideScrollbars.Checked = true
		    
		  else
		    
		    ' Uncheck the auto hide.
		    ToggleScrollbarsAutoHideScrollbars.Checked = false
		    
		    ' Turn on the scrollbar menu items.
		    ToggleScrollbarsHorizontalScrollbar.Enable
		    ToggleScrollbarsVerticalScrollbar.Enable
		    
		  end if
		  
		  ' Set the check marks.
		  ToggleScrollbarsHorizontalScrollbar.Checked = TestDisplay.getHScrollbar.Visible
		  ToggleScrollbarsVerticalScrollbar.Checked = TestDisplay.getVScrollbar.Visible
		  
		  ' Turn it off if we are in edit mode.
		  ToggleScrollbarsHorizontalScrollbar.visible = _
		  not TestDisplay.isEditViewMode
		  
		  '---------------------------------------------
		  ' Scrollbars.
		  '---------------------------------------------
		  dim iValue as integer = TestDisplay.getDoc.selectionOpacity
		  select case iValue
		  case 0
		    OpacityZero.checked = true
		    Opacity25.checked = false
		    Opacity50.checked = false
		    Opacity75.checked = false
		  case 25
		    OpacityZero.checked = false
		    Opacity25.checked = true
		    Opacity50.checked = false
		    Opacity75.checked = false
		  case 50
		    OpacityZero.checked = false
		    Opacity25.checked = false
		    Opacity50.checked = true
		    Opacity75.checked = false
		  case 75
		    OpacityZero.checked = false
		    Opacity25.checked = false
		    Opacity50.checked = false
		    Opacity75.checked = true
		  end
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  
		  #if not DebugBuild
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  ' Set the check marks that the scrollbars are visible.
		  ToggleScrollbarsVerticalScrollbar.Checked = true
		  ToggleScrollbarsHorizontalScrollbar.Checked = true
		  
		  ' Set the focus.
		  TestDisplay.SetFocus
		  
		  #if TargetLinux
		    
		    ' Make sure it fits.
		    Coordinates.TextSize = Coordinates.TextSize - 1
		    
		  #endif
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resized()
		  
		  #if not DebugBuild
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  ' Resize the control.
		  TestDisplay.resize
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resizing()
		  
		  #if not DebugBuild
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  ' Resize the control.
		  TestDisplay.resize
		  
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
			TestDisplay.changeCenterAlignment
			
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
			TestDisplay.changeLeftAlignment
			
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
			TestDisplay.changeRightAlignment
			
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
			TestDisplay.changeBackgroundColor(&c0000FF)
			
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
			TestDisplay.changeBackgroundColor(&c00FF00)
			
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
			TestDisplay.changeBackgroundColor
			
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
			TestDisplay.changeBackgroundColor(&cFF0000)
			
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
			TestDisplay.changeToLowerCase
			
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
			TestDisplay.changeToTitleCase
			
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
			TestDisplay.changeToUpperCase
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function CharacterSpacing0() As Boolean Handles CharacterSpacing0.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Change the character spacing.
			TestDisplay.changeCharacterSpacing(0)
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function CharacterSpacing100() As Boolean Handles CharacterSpacing100.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Change the character spacing.
			TestDisplay.changeCharacterSpacing(100)
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function CharacterSpacing100Minus() As Boolean Handles CharacterSpacing100Minus.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Change the character spacing.
			TestDisplay.changeCharacterSpacing(-100)
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function CharacterSpacing25() As Boolean Handles CharacterSpacing25.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Change the character spacing.
			TestDisplay.changeCharacterSpacing(25)
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function CharacterSpacing25Minus() As Boolean Handles CharacterSpacing25Minus.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Change the character spacing.
			TestDisplay.changeCharacterSpacing(-25)
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function CharacterSpacing50() As Boolean Handles CharacterSpacing50.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Change the character spacing.
			TestDisplay.changeCharacterSpacing(50)
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function CharacterSpacing50Minus() As Boolean Handles CharacterSpacing50Minus.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Change the character spacing.
			TestDisplay.changeCharacterSpacing(-50)
			
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
			style = TestDisplay.getDoc.getCharacterStyle("Emphasis")
			
			' Did we get a style?
			if not (style is nil) then
			
			' Set the character style for the selected text.
			TestDisplay.changeCharacterStyle(style.getId)
			
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
			style = TestDisplay.getDoc.getCharacterStyle("Figure")
			
			' Did we get a style?
			if not (style is nil) then
			
			' Set the character style for the selected text.
			TestDisplay.changeCharacterStyle(style.getId)
			
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
			TestDisplay.changeCharacterStyle
			
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
			style = TestDisplay.getDoc.getCharacterStyle("Title")
			
			' Did we get a style?
			if not (style is nil) then
			
			' Set the character style for the selected text.
			TestDisplay.changeCharacterStyle(style.getId)
			
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
			TestDisplay.changeTextColor(&c000000)
			
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
			TestDisplay.changeTextColor(&c0000FF)
			
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
			TestDisplay.changeTextColor(&c00FF00)
			
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
			TestDisplay.changeTextColor(&cFF0000)
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function DisplayAlignmentCenter() As Boolean Handles DisplayAlignmentCenter.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Set to center aligned.
			TestDisplay.setDisplayAlignment(FormattedText.Display_Alignment.Center)
			
			' We handled it.
			return true
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function DisplayAlignmentLeft() As Boolean Handles DisplayAlignmentLeft.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Set to left aligned.
			TestDisplay.setDisplayAlignment(FormattedText.Display_Alignment.Left)
			
			' We handled it.
			return true
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function DisplayAlignmentRight() As Boolean Handles DisplayAlignmentRight.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Set to right aligned.
			TestDisplay.setDisplayAlignment(FormattedText.Display_Alignment.Right)
			
			' We handled it.
			return true
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function DisplayModeEditView() As Boolean Handles DisplayModeEditView.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Set the watch cursor.
			app.MouseCursor = System.Cursors.Wait
			
			' Save the current margins.
			leftMargin = TestDisplay.getdoc.getLeftMargin
			rightMargin = TestDisplay.getdoc.getRightMargin
			topMargin = TestDisplay.getdoc.getTopMargin
			bottomMargin = TestDisplay.getdoc.getBottomMargin
			pageWidth = TestDisplay.getdoc.getPageWidth
			pageHeight = TestDisplay.getdoc.getPageHeight
			
			' Set the display more to edit mode.
			TestDisplay.setEditViewMode(0.06)
			
			' Reset the cursor.
			app.MouseCursor = nil
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function DisplayModeNormalView() As Boolean Handles DisplayModeNormalView.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Set the watch cursor.
			app.MouseCursor = System.Cursors.Wait
			
			' Reset the margins.
			resetMargins
			
			' Set the display more to normal mode.
			TestDisplay.setNormalViewMode
			
			' Reset the cursor.
			app.MouseCursor = nil
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function DisplayModePageView() As Boolean Handles DisplayModePageView.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Set the watch cursor.
			app.MouseCursor = System.Cursors.Wait
			
			' Reset the margins.
			resetMargins
			
			' Set the display more to page mode.
			TestDisplay.setPageViewMode
			
			' Reset the cursor.
			app.MouseCursor = nil
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function DisplayModeSingleView() As Boolean Handles DisplayModeSingleView.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Set the watch cursor.
			app.MouseCursor = System.Cursors.Wait
			
			' Save the current margins.
			leftMargin = TestDisplay.getdoc.getLeftMargin
			rightMargin = TestDisplay.getdoc.getRightMargin
			topMargin = TestDisplay.getdoc.getTopMargin
			bottomMargin = TestDisplay.getdoc.getBottomMargin
			pageWidth = TestDisplay.getdoc.getPageWidth
			pageHeight = TestDisplay.getdoc.getPageHeight
			
			' Set the display more to edit mode.
			TestDisplay.setSingleViewMode(0.06)
			
			' Reset the cursor.
			app.MouseCursor = nil
			
			' We handled it.
			return true
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function EditCheckSpelling() As Boolean Handles EditCheckSpelling.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Begin a spell check.
			TestDisplay.checkSpelling
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function EditCheckSpellingasYouType() As Boolean Handles EditCheckSpellingasYouType.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Flip the status.
			TestDisplay.SpellCheckWhileTyping = not TestDisplay.SpellCheckWhileTyping
			
			' We handled it.
			return true
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function EditDeselectAll() As Boolean Handles EditDeselectAll.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Deselect all the text.
			TestDisplay.deselectAll
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function EditHideSpellingErrors() As Boolean Handles EditHideSpellingErrors.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Clear the indicators.
			TestDisplay.clearMisspelledIndicators
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function EditRefresh() As Boolean Handles EditRefresh.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Do a complete update of the display.
			TestDisplay.updateFull
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function EditSelectAll() As Boolean Handles EditSelectAll.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Select all the text.
			TestDisplay.selectAll
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function ExportHTML() As Boolean Handles ExportHTML.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			Dim fi as FolderItem
			Dim ftit as FTIterator
			Dim it as HTMLIterator
			
			fi = SelectFolder
			
			
			' Did the user confirm the action?
			if not (fi is nil) then
			
			' Set the cursor to a watch.
			app.MouseCursor = System.Cursors.Wait
			
			
			' Create the HTML output.
			it = new HTMLIterator(fi)
			ftit = new FTIterator(TestDisplay, it)
			ftit.run(nil, nil)
			
			it.Write
			
			' Reset the cursor.
			app.MouseCursor = nil
			
			end if
			
			' We handled it.
			return true
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function FileClose() As Boolean Handles FileClose.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Close the window.
			close
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function FilePrint() As Boolean Handles FilePrint.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			Dim g as Graphics
			
			' Indicate we are printing.
			inhibitDirty = true
			
			' Has the printer set up dialog been run?
			if app.doPageSetup(false) then
			
			' Show the printer dialog.
			g = OpenPrinterDialog(app.getPrinter)
			
			' Did the user confirm the print action?
			if not (g is nil) then
			
			' Print the document.
			TestDisplay.print(g, app.getPrinter)
			
			end if
			
			end if
			
			' We are done printing.
			inhibitDirty = false
			
			' We handled it.
			return true
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function FileSave() As Boolean Handles FileSave.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			Dim tos as TextOutputStream
			
			' Is there anything to do?
			if currentFolderItem is nil then
			
			' We should not get here.
			break
			
			return true
			
			end if
			
			' Set the cursor to a watch.
			app.MouseCursor = System.Cursors.Wait
			
			' Create the file.
			tos = TextOutputStream.Create(currentFolderItem)
			
			' Save the content.
			select case getSuffix(currentFolderItem.name)
			
			case "xml"
			
			' Write out the text.
			tos.Write(TestDisplay.getDoc.getXML)
			
			case "rtf"
			
			' Write out the text.
			tos.Write(TestDisplay.getDoc.getRTF)
			
			else
			
			' Write out the text.
			tos.Write(TestDisplay.getDoc.getText)
			
			end select
			
			' Close the file.
			tos.close
			
			' Update the title.
			markDirty(false)
			
			' Reset the cursor.
			app.MouseCursor = nil
			
			' We handled the item.
			return true
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function FormatAdjustMargins() As Boolean Handles FormatAdjustMargins.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			Dim dmw as DocumentMarginsWindow
			Dim doc as FTDocument
			Dim lm as double
			Dim rm as double
			Dim tm as double
			Dim bm as double
			Dim currentPageSize as integer
			
			' Get the document.
			doc = TestDisplay.getDoc
			
			' Save the page size.
			currentPageSize = pageSize
			
			' Create the window.
			dmw = new DocumentMarginsWindow(doc.getLeftMargin, doc.getRightMargin, _
			doc.getTopMargin, doc.getBottomMargin, pageSize)
			
			' Show the window.
			dmw.ShowModal
			
			' Did the user confirm the action?
			if dmw.getResult then
			
			' Get the margins.
			dmw.getMargins(lm, rm, tm, bm, pageSize)
			
			' Did the page size change?
			if currentPageSize <> pageSize then
			
			' Set the page size.
			select case pageSize
			
			case 0
			TestDisplay.setPageSize(8.27, 11.69)
			
			case 1
			TestDisplay.setPageSize(8.5, 11.00)
			
			case 2
			TestDisplay.setPageSize(8.5, 14.00)
			
			end select
			
			end if
			
			' Set the margins.
			TestDisplay.setMargins(lm, rm, tm, bm)
			
			end if
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function FormatAdjustParagraph() As Boolean Handles FormatAdjustParagraph.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Adjust the paragraph.
			adjustParagraph
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function FormatClearHyperlink() As Boolean Handles FormatClearHyperlink.Action
			TestDisplay.removeHyperLink
			
			Return True
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function FormatHyperlinkColors() As Boolean Handles FormatHyperlinkColors.Action
			dim w as HyperlinkWindow
			w = new HyperlinkWindow(TestDisplay)
			Return True
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function FormatMakeReadOnly() As Boolean Handles FormatMakeReadOnly.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Flip the check mark.
			FormatMakeReadOnly.Checked = not FormatMakeReadOnly.Checked
			
			' Set the read only state.
			TestDisplay.setReadOnly(FormatMakeReadOnly.Checked)
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function FormatResetImageSize() As Boolean Handles FormatResetImageSize.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Reset the image size back to the original size.
			TestDisplay.resetImageSize
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function FormatSearchandReplace() As Boolean Handles FormatSearchandReplace.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Does the window exist?
			if sarWindow is nil then
			
			' Create the window.
			sarWindow = new SearchWindow(TestDisplay)
			
			end if
			
			' Show the window.
			sarWindow.show
			
			' We handled it.
			return true
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function FormatSetHyperlink() As Boolean Handles FormatSetHyperlink.Action
			dim bNewWin as boolean
			dim sURL as string = TestDisplay.selectionHyperLink(bNewWin)
			
			if sURL = "" then
			sURL =  "http://www.bkeeney.com"
			end
			
			dim wAsk as new winAsk
			if wAsk.ask("Enter Hyperlink Data", sURL, false, self) = false then return true
			
			TestDisplay.SetFocus
			
			TestDisplay.ChangeHyperLink(sURL, bNewWin)
			
			Return True
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function FormatShowInvisibles() As Boolean Handles FormatShowInvisibles.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Flip the invisibles flag.
			TestDisplay.ShowInvisibles = not TestDisplay.ShowInvisibles
			
			' Update the display.
			TestDisplay.updateFull
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function FormatShowMarginGuides() As Boolean Handles FormatShowMarginGuides.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Flip the check mark.
			FormatShowMarginGuides.Checked = not FormatShowMarginGuides.Checked
			
			' Set the margin guides.
			TestDisplay.changeMarginGuides(FormatShowMarginGuides.Checked)
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function FormatTabs() As Boolean Handles FormatTabs.Action
			
			#If Not DebugBuild
			
			#Pragma DisableBoundsChecking
			#Pragma NilObjectChecking False
			#Pragma StackOverflowChecking False
			
			#EndIf
			
			' Get the target paragraph.
			Dim p As FTParagraph = TestDisplay.getDoc.getInsertionPoint.getCurrentParagraph
			
			Dim w As TabStopWindow
			w = New TabStopWindow(p)
			
			
			Return True
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function FormatTextShadow() As Boolean Handles FormatTextShadow.Action
			dim w as ShadowWindow
			w = new ShadowWindow(TestDisplay)
			Return True
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function HelpClearKeyStrokeTiming() As Boolean Handles HelpClearKeyStrokeTiming.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Clear the key stroke timer values.
			TestDisplay.clearKeyStrokeTiming
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function HelpKeyStrokeTiming() As Boolean Handles HelpKeyStrokeTiming.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Show the console.
			showConsole
			
			' Dump the timing values.
			prt(TestDisplay.getOptimizationData)
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function HelpTest() As Boolean Handles HelpTest.Action
			
			#pragma DisableBackgroundTasks
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			Dim doc as FTDocument
			
			' Get the document.
			doc = TestDisplay.getDoc
			
			' Put test code here.
			
			' We handled it.
			return true
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function InsertPageBreak() As Boolean Handles InsertPageBreak.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Add a page break.
			TestDisplay.insertPageBreak
			
			' We handled it.
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
			TestDisplay.changeLineSpacing(1.0)
			
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
			TestDisplay.changeLineSpacing(1.5)
			
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
			TestDisplay.changeLineSpacing(2.0)
			
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
			TestDisplay.changeLineSpacing(2.5)
			
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
			TestDisplay.changeLineSpacing(3.0)
			
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
			TestDisplay.changeMark(&c0000FF)
			
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
			TestDisplay.changeMark(&c00FF00)
			
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
			TestDisplay.changeMark
			
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
			TestDisplay.changeMark(&cFF0000)
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function Opacity25() As Boolean Handles Opacity25.Action
			TestDisplay.changeOpacity(25)
			Return True
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function Opacity50() As Boolean Handles Opacity50.Action
			TestDisplay.changeOpacity(50)
			Return True
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function Opacity75() As Boolean Handles Opacity75.Action
			TestDisplay.changeOpacity(75)
			Return True
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function OpacityZero() As Boolean Handles OpacityZero.Action
			TestDisplay.changeOpacity(0)
			Return True
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function ParagraphBackgroundColorblue() As Boolean Handles ParagraphBackgroundColorblue.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Change the color.
			TestDisplay.changeParagraphBackgroundColor(&c0000FF)
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function ParagraphBackgroundColorGreen() As Boolean Handles ParagraphBackgroundColorGreen.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Change the color.
			TestDisplay.changeParagraphBackgroundColor(&c00FF00)
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function ParagraphBackgroundColorNone() As Boolean Handles ParagraphBackgroundColorNone.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Change the color.
			TestDisplay.changeParagraphBackgroundColor
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function ParagraphBackgroundColorRed() As Boolean Handles ParagraphBackgroundColorRed.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Change the color.
			TestDisplay.changeParagraphBackgroundColor(&cFF0000)
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function ParagraphStyleIndented() As Boolean Handles ParagraphStyleIndented.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Set the paragraph style for the selected paragraphs.
			TestDisplay.setParagraphStyle _
			(TestDisplay.getDoc.getParagraphStyle("Indented").getId)
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function ParagraphStyleNone() As Boolean Handles ParagraphStyleNone.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Set the paragraph style for the selected paragraphs.
			TestDisplay.setParagraphStyle _
			(TestDisplay.getDoc.getParagraphStyle.getId)
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function ParagraphStyleTitle() As Boolean Handles ParagraphStyleTitle.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Set the paragraph style for the selected paragraphs.
			TestDisplay.setParagraphStyle _
			(TestDisplay.getDoc.getParagraphStyle("Title").getId)
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function ParagraphStyleWildandCrazy() As Boolean Handles ParagraphStyleWildandCrazy.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Set the paragraph style for the selected paragraphs.
			TestDisplay.setParagraphStyle _
			(TestDisplay.getDoc.getParagraphStyle("Wild and Crazy").getId)
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function PopulateClearText() As Boolean Handles PopulateClearText.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Create an empty page.
			TestDisplay.deleteAll
			
			' Clear the undo stack.
			TestDisplay.getUndoManager.clear
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function PopulateLargeMixed() As Boolean Handles PopulateLargeMixed.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Set the watch cursor.
			app.MouseCursor = System.Cursors.Wait
			
			' Add only a large number of items.
			populate(600, false)
			
			' Reset the cursor.
			app.MouseCursor = nil
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function PopulateLargePlain() As Boolean Handles PopulateLargePlain.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Set the watch cursor.
			app.MouseCursor = System.Cursors.Wait
			
			' Add only a large number of items.
			populate(2400, true)
			
			' Reset the cursor.
			app.MouseCursor = nil
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function PopulateMediumMixed() As Boolean Handles PopulateMediumMixed.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Add only a few items.
			populate(55, false)
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function PopulateMediumPlain() As Boolean Handles PopulateMediumPlain.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Add only a few items.
			populate(240, true)
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function PopulateSmallMixed() As Boolean Handles PopulateSmallMixed.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Add only a few items.
			populate(2, false)
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function PopulateSmallPlain() As Boolean Handles PopulateSmallPlain.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Add only a few items.
			populate(4, true)
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function PopulateVeryLargeMixed() As Boolean Handles PopulateVeryLargeMixed.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Set the watch cursor.
			app.MouseCursor = System.Cursors.Wait
			
			' Add only a large number of items.
			populate(2000, false)
			
			' Reset the cursor.
			app.MouseCursor = nil
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function PopulateVeryLargeParagraph() As Boolean Handles PopulateVeryLargeParagraph.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Set the watch cursor.
			app.MouseCursor = System.Cursors.Wait
			
			' Add a large paragraph.
			populateParagraph(150)
			
			' Reset the cursor.
			app.MouseCursor = nil
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function PopulateVeryLargePlain() As Boolean Handles PopulateVeryLargePlain.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Set the watch cursor.
			app.MouseCursor = System.Cursors.Wait
			
			' Add only a large number of items.
			populate(9600, true)
			
			' Reset the cursor.
			app.MouseCursor = nil
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function SaveAsRTF() As Boolean Handles SaveAsRTF.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			Dim fi as FolderItem
			Dim tos as TextOutputStream
			
			' Ask the user for a text file.
			fi = GetSaveFolderItem("RTF", getName + ".rtf")
			
			' Did the user confirm the action?
			if not (fi is nil) then
			
			' Set the cursor to a watch.
			app.MouseCursor = System.Cursors.Wait
			
			' Create the file.
			tos = TextOutputStream.Create(fi)
			
			' Write out the text.
			tos.Write(TestDisplay.getDoc.getRTF)
			
			' Close the file.
			tos.close
			
			' Save the folder item.
			currentFolderItem = fi
			
			' Set the title.
			me.Title = currentFolderItem.name
			
			' Update the title.
			markDirty(false)
			
			' Reset the cursor.
			app.MouseCursor = nil
			
			end if
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function SaveAsXML() As Boolean Handles SaveAsXML.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			Dim fi as FolderItem
			Dim tos as TextOutputStream
			
			' Ask the user for a text file.
			fi = GetSaveFolderItem("XML", getName + ".xml")
			
			' Did the user confirm the action?
			if not (fi is nil) then
			
			' Set the cursor to a watch.
			app.MouseCursor = System.Cursors.Wait
			
			' Create the file.
			tos = TextOutputStream.Create(fi)
			
			' Write out the text.
			tos.Write(TestDisplay.getDoc.getXML)
			
			' Close the file.
			tos.close
			
			' Save the folder item.
			currentFolderItem = fi
			
			' Set the title.
			me.Title = currentFolderItem.name
			
			' Update the title.
			markDirty(false)
			
			' Reset the cursor.
			app.MouseCursor = nil
			
			end if
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function SaveText() As Boolean Handles SaveText.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			Dim fi as FolderItem
			Dim tos as TextOutputStream
			
			' Ask the user for a text file.
			fi = GetSaveFolderItem("Text", getName + ".txt")
			
			' Did the user confirm the action?
			if not (fi is nil) then
			
			' Set the cursor to a watch.
			app.MouseCursor = System.Cursors.Wait
			
			' Create the file.
			tos = TextOutputStream.Create(fi)
			
			' Write out the text.
			tos.Write(TestDisplay.getDoc.getText)
			
			' Close the file.
			tos.close
			
			' Save the folder item.
			currentFolderItem = fi
			
			' Set the title.
			me.Title = currentFolderItem.name
			
			' Update the title.
			markDirty(false)
			
			' Reset the cursor.
			app.MouseCursor = nil
			
			end if
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function Scale100() As Boolean Handles Scale100.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Set the scale of the display to 100%.
			TestDisplay.setScale(1.0)
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function Scale125() As Boolean Handles Scale125.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Set the scale of the display to 125%.
			TestDisplay.setScale(1.25)
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function Scale150() As Boolean Handles Scale150.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Set the scale of the display to 150%.
			TestDisplay.setScale(1.5)
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function Scale200() As Boolean Handles Scale200.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Set the scale of the display to 200%.
			TestDisplay.setScale(2.0)
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function Scale50() As Boolean Handles Scale50.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Set the scale of the display to 50%.
			TestDisplay.setScale(0.50)
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function Scale75() As Boolean Handles Scale75.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Set the scale of the display to 75%.
			TestDisplay.setScale(0.75)
			
			' We handled it.
			return true
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
			TestDisplay.changeSize(10)
			
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
			TestDisplay.changeSize(12)
			
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
			TestDisplay.changeSize(14)
			
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
			TestDisplay.changeSize(18)
			
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
			TestDisplay.changeSize(24)
			
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
			TestDisplay.changeSize(32)
			
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
			TestDisplay.changeSize(48)
			
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
			TestDisplay.changeSize(72)
			
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
			TestDisplay.changeSize(9)
			
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
			TestDisplay.changeBoldStyle
			
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
			TestDisplay.changeItalicStyle
			
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
			TestDisplay.changePlainStyle
			
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
			TestDisplay.changeStrikeThrough
			
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
			TestDisplay.changeSubscript
			
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
			TestDisplay.changeSuperscript
			
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
			TestDisplay.changeUnderlineStyle
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function ToggleScrollbarsAutoHideScrollbars() As Boolean Handles ToggleScrollbarsAutoHideScrollbars.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			Dim state as boolean
			
			' Get the new toggle state.
			state = not TestDisplay.VScrollbarAutoHide
			
			' Toggle the scrollbar auto hide feature.
			TestDisplay.VScrollbarAutoHide = state
			TestDisplay.HScrollbarAutoHide = state
			
			' Do we need to show the scrollbars again?
			if not state then
			
			' Turn them on.
			TestDisplay.showVerticalScrollbar(true)
			TestDisplay.showHorizontalScrollbar(true)
			
			end if
			
			' Update the display.
			TestDisplay.resize
			
			' We handled it.
			return true
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function ToggleScrollbarsHorizontalScrollbar() As Boolean Handles ToggleScrollbarsHorizontalScrollbar.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Invert the checkmark.
			ToggleScrollbarsHorizontalScrollbar.Checked = not ToggleScrollbarsHorizontalScrollbar.Checked
			
			' Toggle the scrollbar.
			TestDisplay.showHorizontalScrollbar(ToggleScrollbarsHorizontalScrollbar.checked)
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function ToggleScrollbarsVerticalScrollbar() As Boolean Handles ToggleScrollbarsVerticalScrollbar.Action
			
			#if not DebugBuild
			
			#pragma DisableBoundsChecking
			#pragma NilObjectChecking false
			#pragma StackOverflowChecking false
			
			#endif
			
			' Invert the checkmark.
			ToggleScrollbarsVerticalScrollbar.Checked = not ToggleScrollbarsVerticalScrollbar.Checked
			
			' Toggle the scrollbar.
			TestDisplay.showVerticalScrollbar(ToggleScrollbarsVerticalScrollbar.checked)
			
			' We handled it.
			return true
		End Function
	#tag EndMenuHandler


	#tag Method, Flags = &h0
		Sub addTestData(doc as FTDocument, paragraphCount as integer, plainType as boolean, items as integer = - 1)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  Dim i as integer
		  Dim p as FTParagraph
		  Dim preText as string
		  Dim sr as FTStyleRun
		  Dim parentControl as FormattedText
		  
		  ' Get the parent.
		  parentControl = TestDisplay
		  
		  ' Clear out the paragraphs.
		  doc.clearParagraphs
		  
		  ' Add in the test paragraphs.
		  for i = 1 to paragraphCount
		    
		    ' Should we add debugging paragraph numbers?
		    if ADD_PRETEXT then
		      
		      ' Uncomment this to add paragraph numbers.
		      preText = Str(i) + ": "
		      
		    end if
		    
		    ' Create the paragraph.
		    p = doc.addNewParagraph
		    p.addTestItems(plainType, preText, items)
		    p.setAlignment(FTParagraph.Alignment_Type.Left)
		    
		    ' Is this just mixed text?
		    if not plainType then
		      
		      ' Use a custom graph for every other picture.
		      if (i mod 2) = 0 then
		        
		        ' Create the picture paragraph.
		        p = doc.addNewParagraph
		        p.setAlignment(FTParagraph.Alignment_Type.Center)
		        p.addObject(new FTPicture(parentControl, MountainSmall))
		        
		        ' Create the figure caption.
		        p = doc.addNewParagraph
		        p.setAlignment(FTParagraph.Alignment_Type.Center)
		        sr = new FTStyleRun(parentControl, "Figure " + Str(i))
		        sr.updateWithStyle(doc.getParagraphStyle(p.getParagraphStyle))
		        p.addObject(sr)
		        
		      else
		        
		        ' ' Create the graph.
		        ' p = doc.addNewParagraph
		        ' p.setAlignment(FTParagraph.CENTER_ALIGNMENT)
		        ' p.addObject(createBarChart(parentControl))
		        '
		        ' ' Create the figure caption.
		        ' p = doc.addNewParagraph
		        ' p.setAlignment(FTParagraph.CENTER_ALIGNMENT)
		        ' sr = new FTStyleRun(parentControl, "Custom Chart " + Str(i))
		        ' sr.updateWithStyle(doc.getParagraphStyle(p.getParagraphStyle))
		        ' p.addObject(sr)
		        
		      end if
		      
		    end if
		    
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub adjustParagraph()
		  
		  #if not DebugBuild
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  Dim pw as ParagraphWindow
		  Dim firstIndent as double
		  Dim leftMargin as double
		  Dim rightMargin as double
		  Dim beforeSpace as double
		  Dim afterSpace as double
		  Dim p as FTParagraph
		  Dim startIndex as integer
		  Dim endIndex as integer
		  Dim selectStart as FTInsertionOffset
		  Dim selectEnd as FTInsertionOffset
		  
		  ' Get the target paragraph.
		  p = TestDisplay.getDoc.getInsertionPoint.getCurrentParagraph
		  
		  ' Get the margins.
		  firstIndent = p.getFirstIndent
		  leftMargin = p.getLeftMargin
		  rightMargin = p.getRightMargin
		  beforeSpace = p.getBeforeParagraphSpace
		  afterSpace = p.getAfterParagraphSpace
		  
		  ' Create the window.
		  pw = new ParagraphWindow(TestDisplay.getDoc, firstIndent, leftMargin, rightMargin, beforeSpace, afterSpace)
		  
		  ' Show the window.
		  pw.ShowModal
		  
		  ' Did the user confirm the action?
		  if pw.getResult then
		    
		    ' Get the margins.
		    pw.getMargins(firstIndent, leftMargin, rightMargin, beforeSpace, afterSpace)
		    
		    ' Is there selected text?
		    if TestDisplay.getDoc.isSelected then
		      
		      ' Get the selection range.
		      TestDisplay.getDoc.getSelectionRange(selectStart, selectEnd)
		      
		      ' Extract the paragraph indexes.
		      startIndex = selectStart.paragraph
		      endIndex = selectEnd.paragraph
		      
		    else
		      
		      ' Just use the current paragraph.
		      startIndex = p.getAbsoluteIndex
		      endIndex = startIndex
		      
		    end if
		    
		    ' Update the display.
		    TestDisplay.changeParagraphMargins(startIndex, endIndex, _
		    firstIndent, leftMargin, rightMargin, beforeSpace, afterSpace)
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(populate as boolean)
		  
		  #if not DebugBuild
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  ' Fire the open events.
		  Super.Window
		  
		  ' Create some styles.
		  loadCharacterStyles
		  loadParagraphStyles
		  
		  ' Should we populate the window
		  If populate Then
		    
		    ' Add some text.
		    populate(4, false)
		    
		    
		    Dim p As FTParagraph
		    
		    p = TestDisplay.getDoc.getParagraph(0)
		    
		    TestDisplay.update(True, True)
		    
		  end if
		  
		  ' Mark the document as dirty.
		  dirty = false
		  
		  ' Clear the title.
		  markDirty(false)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(s as string, fi as FolderItem)
		  
		  #if not DebugBuild
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  Dim ft as string
		  
		  ' Fire the open events.
		  Super.Window
		  
		  ' Turn off updates.
		  call TestDisplay.setInhibitUpdates(true)
		  
		  ' Save the folder item.
		  currentFolderItem = fi
		  
		  ' Get the file type.
		  ft = getSuffix(fi.name)
		  
		  ' Set the window title.
		  markDirty(false)
		  
		  ' Add the data.
		  select case ft
		    
		  case "xml"
		    
		    ' Add the text.
		    TestDisplay.setXML(s)
		    
		  case "rtf"
		    
		    ' Add the text.
		    TestDisplay.setRTF(s)
		    
		  else
		    
		    ' Add the text.
		    TestDisplay.setText(s)
		    
		  end select
		  
		  ' Create some styles.
		  loadCharacterStyles
		  loadParagraphStyles
		  
		  ' Turn on updates.
		  call TestDisplay.setInhibitUpdates(false)
		  
		  ' Update the display.
		  TestDisplay.updateFull
		  
		  ' Move the caret to the beginning of the file.
		  TestDisplay.moveCaretToBeginning
		  
		  ' Mark the document as clean.
		  dirty = false
		  
		  ' Clear the title.
		  markDirty(false)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function findWord(doc as FTDocument, startParagraph as integer, startOffset as integer, word as string) As boolean
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim position as integer
		  Dim text as string
		  Dim p as FTParagraph
		  
		  ' Get the number of paragraphs.
		  count = doc.getParagraphCount - 1
		  
		  ' Scan the paragraphs.
		  for i = startParagraph to count
		    
		    ' Get a paragraph.
		    p = doc.getParagraph(i)
		    
		    ' Get the text from the paragraph.
		    text = p.getText(true)
		    
		    ' Search for the word.
		    position = inStr(startOffset, text, word)
		    
		    ' Use the start of the paragraph.
		    startOffset = 0
		    
		    ' Did we find it?
		    if position > 0 then
		      
		      ' Make it zero based.
		      position = position - 1
		      
		      ' Select the word.
		      doc.selectSegment(i, position, i, position + word.len)
		      
		      ' Update the display.
		      doc.parentControl.update(true, true)
		      
		      ' We are done.
		      return true
		      
		    end if
		    
		  next
		  
		  ' We did not find it.
		  return false
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getName() As string
		  
		  #if not DebugBuild
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  ' Has the file been save yet?
		  if currentFolderItem is nil then
		    
		    ' An unnamed file.
		    return "Untitled"
		    
		  else
		    
		    ' Use the current file name.
		    return getPrefix(currentFolderItem.name)
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isDirty() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  ' Return the dirty flag.
		  return dirty
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub loadCharacterStyles()
		  
		  #if not DebugBuild
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  Dim cs as FTCharacterStyle
		  Dim doc as FTDocument
		  
		  ' Get a document reference.
		  doc = TestDisplay.getDoc
		  
		  '-------------------------------------------
		  
		  ' Does it exist?
		  if not doc.hasCharacterStyle("Title") then
		    
		    ' Create the character style.
		    cs = new FTCharacterStyle(TestDisplay, "Title")
		    
		    ' Fill in the style.
		    cs.setFontName("Helvetica")
		    cs.setFontSize(18)
		    cs.setBold
		    
		    ' Add the style to the document.
		    doc.addCharacterStyle(cs)
		    
		  end if
		  
		  '-------------------------------------------
		  
		  ' Does it exist?
		  if not doc.hasCharacterStyle("Emphasis") then
		    
		    ' Create the character style.
		    cs = new FTCharacterStyle(TestDisplay, "Emphasis")
		    
		    ' Fill in the style.
		    cs.setBold
		    cs.setItalic
		    
		    ' Add the style to the document.
		    doc.addCharacterStyle(cs)
		    
		  end if
		  
		  '-------------------------------------------
		  
		  ' Does it exist?
		  if not doc.hasCharacterStyle("Figure") then
		    
		    ' Create the character style.
		    cs = new FTCharacterStyle(TestDisplay, "Figure")
		    
		    ' Fill in the style.
		    cs.setFontName("Helvetica")
		    cs.setFontSize(10)
		    cs.setItalic
		    cs.setTextColor(&cFF0000)
		    
		    ' Add the style to the document.
		    doc.addCharacterStyle(cs)
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub loadParagraphStyles()
		  
		  #if not DebugBuild
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  Dim ps as FTParagraphStyle
		  Dim doc as FTDocument
		  
		  ' Get a document reference.
		  doc = TestDisplay.getDoc
		  
		  '-------------------------------------------
		  
		  ' Does it exist?
		  if not doc.hasParagraphStyle("Indented") then
		    
		    ' Create the paragraph style.
		    ps = new FTParagraphStyle(TestDisplay, "Indented")
		    
		    ' Fill in the style.
		    ps.setLeftMargin(1.0)
		    ps.setRightMargin(1.0)
		    ps.setLineSpacing(2.0)
		    
		    ' Add the style to the document.
		    doc.addParagraphStyle(ps)
		    
		  end if
		  
		  '-------------------------------------------
		  
		  ' Does it exist?
		  if not doc.hasParagraphStyle("Title") then
		    
		    ' Create the paragraph style.
		    ps = new FTParagraphStyle(TestDisplay, "Title")
		    
		    ' Fill in the style.
		    ps.setBold
		    ps.setAlignment(FTParagraph.Alignment_Type.Center)
		    
		    ' Add the style to the document.
		    doc.addParagraphStyle(ps)
		    
		  end if
		  
		  '-------------------------------------------
		  
		  ' Does it exist?
		  if not doc.hasParagraphStyle("Wild and Crazy") then
		    
		    ' Create the paragraph style.
		    ps = new FTParagraphStyle(TestDisplay, "Wild and Crazy")
		    
		    ' Fill in the style.
		    ps.setFontName("Helvetica")
		    ps.setFontSize(14)
		    
		    ps.setBold
		    ps.setItalic
		    ps.setUnderline
		    ps.setTextColor(&cFF0000)
		    ps.setAlignment(FTParagraph.Alignment_Type.Right)
		    
		    ps.setLeftMargin(1.0)
		    
		    ' Add the style to the document.
		    doc.addParagraphStyle(ps)
		    
		  end if
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub markDirty(state as boolean)
		  
		  #if not DebugBuild
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  Dim name as string
		  
		  ' Are we printing?
		  if inhibitDirty then return
		  
		  ' Was the file specified?
		  if currentFolderItem is nil then
		    
		    ' Use the default name.
		    name = "Untitled"
		    
		  else
		    
		    ' Use the name of the file.
		    name = currentFolderItem.Name
		    
		  end if
		  
		  #if TargetMacOS then
		    
		    ' Set the dirty window indicator.
		    self.ContentsChanged = state
		    
		    ' Has the title changed?
		    if me.Title <> name then
		      
		      ' Update the title.
		      me.Title = name
		      
		    end if
		    
		  #else
		    
		    ' Is the document dirty?
		    if state then
		      
		      ' Add the dirty markers.
		      name = "• " + name + " •"
		      
		    end if
		    
		    ' Has the title changed?
		    if me.Title <> name then
		      
		      ' Update the title.
		      me.Title = name
		      
		    end if
		    
		  #endif
		  
		  ' Save the dirty state.
		  dirty = state
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub populate(paragraphCount as integer, plainType as boolean)
		  
		  #if not DebugBuild
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  Dim state as boolean
		  
		  ' Inhibit updates.
		  state = TestDisplay.setInhibitUpdates(true)
		  
		  ' Clear the display.
		  TestDisplay.deleteAll
		  
		  ' Clear the undo stack.
		  TestDisplay.getUndoManager.clear
		  
		  ' Add the paragraphs.
		  addTestData(TestDisplay.getDoc, paragraphCount, plainType)
		  
		  ' Restore updates.
		  call TestDisplay.setInhibitUpdates(state)
		  
		  ' Update the display.
		  TestDisplay.updateFull
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub populateParagraph(items as integer)
		  
		  #if not DebugBuild
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  ' Clear the display.
		  TestDisplay.deleteAll
		  
		  ' Add the paragraphs.
		  addTestData(TestDisplay.getDoc, items, true, items)
		  
		  ' Update the display.
		  TestDisplay.updateFull
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub resetMargins()
		  
		  #if not DebugBuild
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  ' Were we in edit view mode?
		  if (not TestDisplay.isPageViewMode) and _
		    TestDisplay.isEditViewMode then
		    
		    ' Restore the margins.
		    TestDisplay.getdoc.setLeftMargin(leftMargin)
		    TestDisplay.getdoc.setRightMargin(rightMargin)
		    TestDisplay.getdoc.setTopMargin(topMargin)
		    TestDisplay.getdoc.setBottomMargin(bottomMargin)
		    TestDisplay.getdoc.setPageWidth(pageWidth)
		    TestDisplay.getdoc.setPageHeight(pageHeight)
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setDisplayAlignmentCheckmark()
		  
		  #if not DebugBuild
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  ' Clear the check marks.
		  DisplayAlignmentLeft.Checked = false
		  DisplayAlignmentCenter.Checked = false
		  DisplayAlignmentRight.Checked = false
		  
		  ' Are we in page or normal view mode?
		  if TestDisplay.isPageViewMode or TestDisplay.isNormalViewMode then
		    
		    ' Left align.
		    If TestDisplay.getDisplayAlignment = FormattedText.Display_Alignment.Left Then
		      
		      DisplayAlignmentLeft.Checked = true
		      
		      ' Center align.
		    Elseif TestDisplay.getDisplayAlignment = FormattedText.Display_Alignment.Center Then
		      
		      DisplayAlignmentCenter.Checked = true
		      
		      ' Right align.
		    Elseif TestDisplay.getDisplayAlignment = FormattedText.Display_Alignment.Right Then
		      
		      DisplayAlignmentRight.Checked = true
		      
		    end if
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setDisplayModeCheckmark()
		  
		  #if not DebugBuild
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  ' Clear the check marks.
		  DisplayModePageView.Checked = false
		  DisplayModeNormalView.Checked = false
		  DisplayModeEditView.Checked = false
		  
		  ' Are we in page view mode?
		  if TestDisplay.isPageViewMode then
		    
		    DisplayModePageView.Checked = true
		    
		    ' Are we in edit view mode?
		  elseif TestDisplay.isEditViewMode then
		    
		    DisplayModeEditView.Checked = true
		    
		    ' Are we in single view mode?
		  elseif TestDisplay.isSingleViewMode then
		    
		    DisplayModeSingleView.Checked = true
		    
		  else
		    
		    DisplayModeNormalView.Checked = true
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setScaleCheckmark()
		  
		  #if not DebugBuild
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  ' Clear the check marks.
		  Scale50.Checked = false
		  Scale75.Checked = false
		  Scale100.Checked = false
		  Scale125.Checked = false
		  Scale150.Checked = false
		  Scale200.Checked = false
		  
		  ' Are we in edit mode?
		  if TestDisplay.isEditViewMode then
		    
		    ' Turn off the menu.
		    Scale50.Enabled = false
		    Scale75.Enabled = false
		    Scale100.Enabled = false
		    Scale125.Enabled = false
		    Scale150.Enabled = false
		    Scale200.Enabled = false
		    
		    ' We are done.
		    return
		    
		  end if
		  
		  ' Turn on the menu.
		  Scale50.Enabled = true
		  Scale75.Enabled = true
		  Scale100.Enabled = true
		  Scale125.Enabled = true
		  Scale150.Enabled = true
		  Scale200.Enabled = true
		  
		  ' Select the scale in the menu.
		  select case TestDisplay.getScale
		    
		  case 0.50
		    
		    Scale50.Checked = true
		    
		  case 0.75
		    
		    Scale75.Checked = true
		    
		  case 1.00
		    
		    Scale100.Checked = true
		    
		  case 1.25
		    
		    Scale125.Checked = true
		    
		  case 1.50
		    
		    Scale150.Checked = true
		    
		  case 2.00
		    
		    Scale200.Checked = true
		    
		  end select
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub updateCoordinates(x as integer, y as integer)
		  
		  #if not DebugBuild
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  static lastX as integer
		  static lastY as integer
		  Dim page as integer
		  Dim pageX as integer
		  Dim pageY as integer
		  Dim paragraph as string
		  Dim offset as string
		  Dim io as FTInsertionOffset
		  Dim coordinateText as string
		  Dim maxX as integer
		  
		  const EMPTY = "Coordinates (---, ---) (---: ---, ---) (-, -)"
		  const SEMI_EMPTY = " (---: ---, ---) (-, -)"
		  
		  ' Are we currently inside the control?
		  if inControl then
		    
		    ' Set up the
		    coordinateText = "Coordinates (" + str(x) + ", " + str(y) + ") "
		    
		    ' Has something changed?
		    if (x <> lastX) or (y <> lastY) then
		      
		      ' Convert to page coordinates.
		      TestDisplay.convertDisplayToPageCoordinates(x, y, page, pageX, pageY)
		      
		      ' Calculate the maximum page edge.
		      maxX = TestDisplay.getDoc.getPageWidthLength * TestDisplay.getDisplayScale
		      
		      ' Are we in range on the page?
		      if (pageX > 0) and (pageX < maxX) then
		        
		        ' Get the insertion offset for the coordinates.
		        io = TestDisplay.getDoc.findXYOffset(x, y)
		        
		        ' Are we on the page?
		        if io is nil then
		          
		          ' Use an empty offset.
		          paragraph = "-"
		          offset = "-"
		          
		        else
		          
		          ' Use the offset.
		          paragraph = str(io.paragraph)
		          offset = str(io.offset)
		          
		        end if
		        
		        ' Update the display.
		        Coordinates.Text = coordinateText + _
		        "(" + str(page) + " : "+ str(pageX) + ", " + str(pageY) + ") " + "(" + paragraph + ", " + offset + ")"
		        
		      else
		        
		        ' Update the display.
		        Coordinates.Text = coordinateText + SEMI_EMPTY
		        
		      end if
		      
		      ' Save the coordinates.
		      lastX = x
		      lastY = y
		      
		    end if
		    
		  else
		    
		    ' Update the display.
		    Coordinates.Text = EMPTY
		    
		    ' Reset the coordinates.
		    lastX = -1
		    lastY = -1
		    
		  end if
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private bottomMargin As double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private currentFolderItem As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private dirty As boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private inControl As boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private inhibitDirty As boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private leftMargin As double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private pageHeight As double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private pageSize As integer = 1
	#tag EndProperty

	#tag Property, Flags = &h21
		Private pageWidth As double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private rightMargin As double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private sarWindow As SearchWindow
	#tag EndProperty

	#tag Property, Flags = &h21
		Private topMargin As double
	#tag EndProperty


	#tag Constant, Name = ADD_PRETEXT, Type = Boolean, Dynamic = False, Default = \"false", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events TestDisplay
	#tag Event
		Function GetHorizontalScrollbar() As FTScrollbar
		  
		  #if not DebugBuild
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  ' Tell the control what scrollbar to use.
		  return HScrollbar
		  
		End Function
	#tag EndEvent
	#tag Event
		Function GetVerticalScrollbar() As FTScrollbar
		  
		  #if not DebugBuild
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  ' Tell the control what scrollbar to use.
		  return VScrollbar
		  
		End Function
	#tag EndEvent
	#tag Event
		Function XmlObjectCreate(obj as XmlElement) As FTObject
		  
		  #if not DebugBuild
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  Dim fto as FTObject
		  
		  ' Create the display object.
		  select case obj.Name
		    
		  Case "FTFile"
		    
		    fto = New FTFile(Me, obj)
		    
		  Case Else
		    Break //Need to add the ohter custom object this is.
		    
		  end select
		  
		  ' Return the new display object.
		  return fto
		  
		End Function
	#tag EndEvent
	#tag Event
		Function ConstructContextualMenu(base as MenuItem, x as integer, y as integer) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  #pragma Unused x
		  #pragma Unused y
		  
		  Dim mi as MenuItem
		  
		  Dim startPosition as FTInsertionOffset
		  Dim endPosition as FTInsertionOffset
		  dim doc as FTDocument = me.getDoc
		  
		  ' Get the range of selected text.
		  me.selectWordFromInsertionPoint//(x, y)
		  
		  doc.getSelectionRange(startPosition, endPosition)
		  
		  dim sSelectedWord as string = ReplaceLineEndings(doc.getText(startPosition, endPosition), EndOfLine)
		  
		  Dim arsSuggestions() As String
		  
		  #If FTCConfiguration.BKS_SPELLCHECK_ENABLED = True Then
		    ' PLEASE READ!!!!!:
		    ' If you are getting an "This item doesn't exist" error
		    ' it means you are missing the BKSSpellChecker plugin.  This is located in the download package.
		    Dim oSpell As BKSSpellChecker = BKSSC.oSpellCheck
		    if oSpell <> nil then
		      if oSpell.IsWordSpelledCorrectly(sSelectedWord) = false then
		        arsSuggestions = BKSSC.SuggestionsForWord(sSelectedWord)
		      end if
		    end if
		    
		    if arsSuggestions.Ubound = -1 then
		      mi = new MenuItem
		      mi.text = "Spelled Correctly"
		      mi.tag = -2
		      base.Append mi
		      return true
		    else
		      
		      for i as integer = 0 to arsSuggestions.Ubound
		        base.Append new MenuItem(arsSuggestions(i))
		      next
		      
		    end
		    
		  #else
		    // BKS_SpellCheck not enabled
		    mi = new MenuItem("BKS_SpellCheck not enabled.")
		    mi.Tag = -2
		    base.Append(mi)
		    return true
		    
		  #endif
		  
		  mi = new MenuItem
		  mi.text = MenuItem.TextSeparator
		  mi.tag = -2
		  base.Append(mi)
		  
		  mi = new MenuItem
		  mi.text = "Adjust Paragraph..."
		  mi.tag = -1
		  base.Append(mi)
		  
		  mi = new MenuItem
		  mi.text = MenuItem.TextSeparator
		  mi.tag = -2
		  base.Append(mi)
		  
		  mi = new MenuItem
		  mi.text = "Refresh"
		  base.Append(mi)
		  
		  // Show the menu
		  return true
		  
		End Function
	#tag EndEvent
	#tag Event
		Function ContextualMenuAction(hitItem as MenuItem) As boolean
		  #if not DebugBuild then
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  select case hitItem.tag
		  case -2
		    // Ignored item
		    
		  case -1
		    // Function item
		    select case hitItem.Text
		    case "Adjust Paragraph..."
		      // Adjust paragrahp
		      adjustParagraph
		      
		    case "Refresh"
		      // Do a complete update of the display.
		      TestDisplay.updateFull
		      
		    end select
		    
		  case else
		    // Replacement word
		    dim sSelectedWord as string
		    dim sNewWord as String
		    Dim selectStart as FTInsertionOffset
		    Dim selectEnd as FTInsertionOffset
		    Dim newOffset as FTInsertionOffset
		    Dim firstPa as ParagraphAttributes
		    
		    dim doc as FTDocument = me.getDoc
		    
		    ' Is anything selected?
		    if doc.isSelected then
		      
		      ' Get the selection range.
		      doc.getSelectionRange(selectStart, selectEnd)
		      
		      ' Get the selected content.
		      sSelectedWord = doc.getXml(selectStart, selectEnd)
		      
		    else
		      
		      ' Get the starting offset.
		      selectStart = doc.getInsertionOffset.clone
		      selectEnd = doc.getInsertionOffset.clone
		      
		    end if
		    
		    dim oParagraph as FTParagraph = doc.getParagraph(selectStart.paragraph)
		    
		    ' Save the first paragraphs attributes.
		    firstPa = doc.getParagraph(selectStart.paragraph).getParagraphAttributes
		    
		    me.insertText(hitItem.Text)
		    
		    ' Get the new offset for the inserted text.
		    newOffset = doc.getInsertionOffset.clone
		    
		    ' Get the inserted content.
		    sNewWord = doc.getXml(selectStart, newOffset)
		    
		    ' Save the undo paste action.
		    me.getUndoManager.savePaste selectStart, selectEnd, newOffset, sSelectedWord, sNewWord, firstPa
		    
		    ' Send notification of the change.
		    me.callTextChanged
		    
		    ' Tell the paragraph to recheck the spelling
		    oParagraph.spellcheckparagraph true
		    
		  end select
		  
		  
		  
		End Function
	#tag EndEvent
	#tag Event
		Sub PostPageDraw(g as graphics, p as FTPage, printing as boolean, printScale as double)
		  
		  #if not DebugBuild
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  Dim left as double
		  Dim top as double
		  Dim doc as FTDocument
		  Dim scale as double
		  
		  ' Are we in a non-page view mode?
		  if not me.isPageViewMode then return
		  
		  ' Are we printing?
		  if printing then
		    
		    ' Get the scale.
		    scale = printScale
		    
		  else
		    
		    ' Get the scale.
		    scale = me.getDisplayScale
		    
		  end if
		  
		  ' Set up the graphic port
		  g.TextFont = "arial"
		  g.TextSize = 12 * scale
		  g.bold = false
		  g.underline = false
		  g.italic = false
		  g.ForeColor = &c000000
		  
		  ' Get the document.
		  doc = me.getDoc
		  
		  ' Compute the bottom left corner coordinates.
		  left = doc.getLeftMargin + doc.getMarginWidth
		  top = doc.getTopMargin + doc.getMarginHeight
		  
		  ' Draw the page number.
		  g.DrawString("Page " + Str(p.getAbsolutePage + 1), _
		  FTUtilities.getScaledLength(left - 0.75, scale), _
		  FTUtilities.getScaledLength(top + 0.15, scale))
		  
		  if self.ScalingFactor <> 1 then
		    Coordinates.Bold = true
		    Coordinates.TextColor = &cFF0000
		  else
		    Coordinates.Bold = false
		    Coordinates.TextColor = &c000000
		  end
		End Sub
	#tag EndEvent
	#tag Event
		Sub Open()
		  
		  Dim doc as FTDocument
		  
		  ' Update the coordinates.
		  updateCoordinates(0, 0)
		  
		  ' Get the document.
		  doc = me.getDoc
		  
		  ' Set the XML version attributes.
		  doc.setXMLCreator("FTC Demo")
		  doc.setXMLFileType("Demo FTC Document")
		  doc.setXMLFileVersion("1.0")
		  doc.setXMLDocumentTag("Nothing")
		  
		  ' Initialize the margins.
		  leftMargin = me.LeftMargin
		  rightMargin = me.RightMargin
		  topMargin = me.TopMargin
		  bottomMargin = me.BottomMargin
		  pageWidth = me.PageWidth
		  pageHeight = Me.PageHeight
		  
		  ' Allow file drops
		  Me.AcceptFileDrop ""
		  
		  
		End Sub
	#tag EndEvent
	#tag Event
		Sub MouseMove(x as integer, y as integer)
		  
		  #if not DebugBuild
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  ' Update the coordinates.
		  updateCoordinates(x, y)
		  
		End Sub
	#tag EndEvent
	#tag Event
		Sub MouseEnter()
		  
		  #if not DebugBuild
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  ' The mouse is in the control.
		  inControl = true
		  
		  ' Update the coordinates.
		  updateCoordinates(0, 0)
		  
		End Sub
	#tag EndEvent
	#tag Event
		Sub MouseExit()
		  
		  #if not DebugBuild
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  ' The mouse is out of control.
		  inControl = false
		  
		  ' Update the coordinates.
		  updateCoordinates(0, 0)
		  
		End Sub
	#tag EndEvent
	#tag Event
		Sub TextChanged()
		  
		  #if not DebugBuild
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  ' Is there anything to do?
		  if dirty then return
		  
		  ' Update the title.
		  markDirty(true)
		  
		End Sub
	#tag EndEvent
	#tag Event
		Function XmlEncodeTag(obj as FTBase) As string
		  
		  #if not DebugBuild
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  ' In the demo we don't care about the example code below.
		  return ""
		  
		  '----------------------
		  
		  ' Note, you need to return a string value that represents
		  ' your tag. The FTC will base64 encode and decode your data
		  ' before inserting it into the XML stream, so you don't have
		  ' to do that.
		  
		  Dim t as Introspection.TypeInfo
		  
		  ' Get the type information.
		  t = Introspection.GetType(obj)
		  
		  ' Act on the object class type to create a string representation.
		  ' Fill in the ones you care about.
		  select case t.name
		    
		  case "FTDocument"
		    
		  case "FTParagraphStyle"
		    
		  case "FTCharacterStyle"
		    
		  case "FTParagraph"
		    
		  case "FTStyleRun"
		    
		    ' As an example we use the string value. You need to encode
		    ' the tag value in a form that you can parse out in the XmlDecodeTag
		    ' event.
		    return obj.tag.StringValue
		    
		  case "FTPicture"
		    
		  case "FTTab"
		    
		  case "FTCustom"
		    
		  end select
		  
		  ' Return an empty string to indicate no tag value.
		  return ""
		  
		End Function
	#tag EndEvent
	#tag Event
		Sub XmlDecodeTag(data as string, obj as FTBase)
		  
		  #if not DebugBuild
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  ' In the demo we don't care about the example code below.
		  return
		  
		  '----------------------
		  
		  ' Note, when this event is called, data will not have it's encoding
		  ' defined. It is up to you to define it.
		  
		  Dim t as Introspection.TypeInfo
		  
		  ' Get the type information.
		  t = Introspection.GetType(obj)
		  
		  ' Act on the object class type to restore the object's tag.
		  ' Decode the ones you care about.
		  select case t.name
		    
		  case "FTDocument"
		    
		  case "FTParagraphStyle"
		    
		  case "FTCharacterStyle"
		    
		  case "FTParagraph"
		    
		  case "FTStyleRun"
		    
		    ' Convert the data into the actual variant.
		    obj.tag = data
		    
		  case "FTPicture"
		    
		  case "FTTab"
		    
		  case "FTCustom"
		    
		  end select
		  
		End Sub
	#tag EndEvent
	#tag Event
		Sub HyperlinkClick(sURL as String)
		  MsgBox "Hyperlink Clicked: " + sURL
		End Sub
	#tag EndEvent
	#tag Event
		Function SpellCheckParagraph(text as string) As FTSpellCheckWord()
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  ' Dim index as integer
		  ' Dim word as string
		  Dim scw() as FTSpellCheckWord
		  
		  '--------------------------------------------------
		  ' BKS Spell Checker plugin.
		  '
		  ' This means that BKSSpellChecker.xojo_plugin must be installed in the plugins folder
		  ' A demo version of the plugin comes with the package
		  '--------------------------------------------------
		  #If FTCConfiguration.BKS_SPELLCHECK_ENABLED Then
		    ' PLEASE READ!!!!!:
		    ' If you are getting an "This item doesn't exist" error
		    ' it means you are missing the BKSSpellChecker plugin.  This is located in the download package.
		    dim oSpell as BKSSpellChecker = BKSSC.oSpellCheck
		    if oSpell <> nil then
		      for each oRange as BKSSpellCheckerRange in BKSSC.CheckSpellingBlock(text)
		        scw.Append(new FTSpellCheckWord(oRange.start , (oRange.Start-1) + oRange.Length))
		      next
		    end if
		  #Endif
		  
		  '--------------------------------------------------
		  ' Einhugur spell checker.
		  '--------------------------------------------------
		  
		  ' Uncomment this code if you want to use the Einhugur spell checker.
		  ' Note - you would do something similar if you are using the MBS spell checker.
		  
		  ' #if TargetMacOS
		  '
		  ' Dim spell as SpellingChecker
		  '
		  ' ' Get the spell checker.
		  ' spell = new SpellingChecker(nil)
		  '
		  ' Dim i as integer
		  ' Dim count as integer
		  ' Dim words() as string
		  '
		  ' ' Break up the words in the text.
		  ' words = Split(text, " ")
		  '
		  ' ' Get the number of words.
		  ' count = Ubound(words)
		  '
		  ' ' Check the words on the line.
		  ' for i = 0 to count
		  '
		  ' ' Get a word.
		  ' word = words(i)
		  '
		  ' ' Was the word spelled correctly?
		  ' if not spell.Check(Word) then
		  '
		  ' ' Mark the word as misspelled.
		  ' scw.Append(new FTSpellCheckWord(index + 1, index + word.len))
		  '
		  ' end
		  '
		  ' ' Move past the word.
		  ' index = index + Word.Len + 1
		  '
		  ' next
		  '
		  ' #endif
		  
		  ' Return the list of misspelled words.
		  return scw
		  
		End Function
	#tag EndEvent
	#tag Event
		Function SpellCheckWord(word as string) As boolean
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  '--------------------------------------------------
		  ' BKS Spell Checker plugin.
		  '
		  ' This means that BKSSpellChecker.xojo_plugin must be installed in the plugins folder
		  ' A demo version of the plugin comes with the package
		  '--------------------------------------------------
		  #if FTCConfiguration.BKS_SPELLCHECK_ENABLED then
		    ' PLEASE READ!!!!!:
		    ' If you are getting an "This item doesn't exist" error
		    ' it means you are missing the BKSSpellChecker plugin.  This is located in the download package.
		    Dim oSpell As BKSSpellChecker = BKSSC.oSpellCheck
		    if oSpell <> nil then
		      Return NOT oSpell.IsWordSpelledCorrectly(word)
		    end if
		  #Endif
		  
		  '--------------------------------------------------
		  ' Einhugur spell checker.
		  '--------------------------------------------------
		  
		  ' Uncomment this code if you want to use the Einhugur spell checker.
		  ' Note - you would do something similar if you are using the MBS spell checker.
		  
		  ' #if TargetMacOS
		  '
		  ' Dim spell as SpellingChecker
		  '
		  ' ' Get the spell checker.
		  ' spell = new SpellingChecker(nil)
		  '
		  '
		  ' ' Was the word spelled correctly?
		  ' return spell.Check(Word)
		  '
		  ' #endif
		  
		End Function
	#tag EndEvent
	#tag Event
		Sub SelectionChanged()
		  
		End Sub
	#tag EndEvent
	#tag Event
		Function DropObject(obj as DragItem, action as integer) As boolean
		  #Pragma Unused action
		  
		  dim doc as FTDocument
		  dim p as FTParagraph
		  
		  doc = me.getdoc
		  
		  if obj.FolderItemAvailable then
		    
		    p = doc.addNewParagraph
		    p.setAlignment(FTParagraph.Alignment_Type.Left)
		    
		    Dim f As folderitem = obj.FolderItem
		    
		    p.addObject(new FTFile(me, f))
		    
		    me.UpdateFull
		    
		    return true
		  end
		End Function
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="BackColor"
		Visible=true
		Group="Appearance"
		InitialValue="&hFFFFFF"
		Type="Color"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Backdrop"
		Visible=true
		Group="Appearance"
		Type="Picture"
		EditorType="Picture"
	#tag EndViewProperty
	#tag ViewProperty
		Name="CloseButton"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Composite"
		Visible=true
		Group="Appearance"
		InitialValue="False"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Frame"
		Visible=true
		Group="Appearance"
		InitialValue="0"
		Type="Integer"
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
		Name="FullScreen"
		Visible=true
		Group="Appearance"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="FullScreenButton"
		Visible=true
		Group="Appearance"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasBackColor"
		Visible=true
		Group="Appearance"
		InitialValue="False"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Position"
		InitialValue="400"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="ImplicitInstance"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Interfaces"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LiveResize"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MacProcID"
		Visible=true
		Group="Appearance"
		InitialValue="0"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaxHeight"
		Visible=true
		Group="Position"
		InitialValue="32000"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximizeButton"
		Visible=true
		Group="Appearance"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaxWidth"
		Visible=true
		Group="Position"
		InitialValue="32000"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBar"
		Visible=true
		Group="Appearance"
		Type="MenuBar"
		EditorType="MenuBar"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBarVisible"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinHeight"
		Visible=true
		Group="Position"
		InitialValue="64"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimizeButton"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinWidth"
		Visible=true
		Group="Position"
		InitialValue="64"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Name"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Placement"
		Visible=true
		Group="Position"
		InitialValue="0"
		Type="Integer"
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
		Name="Resizeable"
		Visible=true
		Group="Appearance"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Super"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Title"
		Visible=true
		Group="Appearance"
		InitialValue="Untitled"
		Type="String"
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
		Name="Width"
		Visible=true
		Group="Position"
		InitialValue="600"
		Type="Integer"
	#tag EndViewProperty
#tag EndViewBehavior
