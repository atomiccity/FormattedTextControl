#tag Module
Protected Module ReleaseNotes
	#tag Note, Name = 3.1.7
		25 Nov 2016
		
		* Fixed issues with Unicode Hyperlinks
		* Fixed Windows Compiler Issue
		* Fixed HIDPT coordinates issue issue with ConstructContextualMenu event handler
		* Added ability to detect Windows HiDPI (requires Xojo 2016 R2 or better.
		* TextInputCanvas rebuilt to be 64 bit compatible.
	#tag EndNote

	#tag Note, Name = 3.1.8
		22 Mar 2017
		
		* Fixed issue with getText returning the character before the selection start on occasion
		* Added FTDocument.AppendXML helper method
		* Added FTDocument.Speak helper method.
		* Selections style queries now default to false when selecting the space between paragraphs
		* Styling reset for \pard (specific to Microsoft generated RTF)
		* Creating and saving a document as xml the reloading it and continuing to edit may drop style runs that initially are correctly set
		* Fixed issue in Page Layout mode where white area of page displayed at twice required width
		* Removed Regression testing suite since they never worked in Xojo and tries to update UI from within a thread
		
	#tag EndNote

	#tag Note, Name = 3.1.9
		30 October 2017
		
		- Fixed issue with view scale < 1.0 setting up the clipping page incorrectly (#3500)
		- Fixed spelling replace on TestWindow (#3581)
		- Fixed Mac text AutoComplete positioning (#3574)
		- Fixed Tabstop Widths (#3500, #3576)
		- Updated Linux declare for doubleClickTime to include GTK3 in newer Xojo versions (#3575)
		- Fixed the Draw Control border on the right side (#3473)
		- Added SpellCheck configuration testing to contextual menu on TestWindow
		- Added SpellCheck configuration testing to App.Close event
		- Fixed resources directory location for the the Spell Checker initialization
		- Added more comments in code if plugins are missing
		
	#tag EndNote

	#tag Note, Name = 3.2.0
		Released Feb 12, 2019
		
		New Items:
		* Contains code from the ImagePlay Effects Library - http://imageplay.sourceforge.net
		* Tab Leaders implemented
		* Issue #3832: Implement Control + Up/Down Arrow Key Handling
		* Issue #3833: Implement paragraph moving via keyboard handling
		* Issue #3700: Drop Shadow available on Windows and Linux
		* Issue #3795: The FTDocument properties characterStyles and paragraphStyles need to be accessible to subclasses.  
		               Added CharacterStyles and ParagraphStyles getter/setters so developers can create their own style editor.
		* Character Spacing implemented (requires Xojo >= 2015.4)
		
		Bug Fixes:
		* Issue #3650:  CustomObjects Demo:  Added FTFile.Clone method so it works with FTIterator propertly.
		* Issue #3653:  macOS: "getDoubleClickTime" - Cocoa replacement for old CarbonLib call
		* Issue #3699:  Add Win64 Declares
		* Issue #3654:  Hi-DPI Mode: FTPicture - Handles drawn incorrect and matches wrong.
		* Issue #3702:  DragRect is half height in HiDPI
		* Fixed an issue with FTParagraph clones that have a different ID after going through the FTIterator
		* Issue #2007/3605: Candidate Window Shows up in Wrong Location
		* Issue #3646: FTParagraph.getXML saves wrong TabStop Properties
		* Issue #3709: FTPicture ignores Nudge property
		* Issue #3748: FTDocument.selectionBold,Italic, shadow, strikethrough, subscript, superscript, underline now works properly
		* Issue #3752: FTRBScript: Fix for printing line numbers
		* Issue #3763: RTFReader/FtcRtfReader ignored the left/right margin and first indent of paragraphs.
		* Issue #3764: RTFReader ignored "\sb" SpaceBefore of paragraphs.
		* Win64 Issue:  Modified FTCUndoPaste.constructor and FTCUndoManager.savePaste to allow pasting (Xojo Compiler Issue.  Feedback 53967)
		* Issue #3750: Suggestion & comparison of the Office applications for the display optimization of the paragraph background color
		* Issue #3775: Implement Corner Color Property in Formatted Text (Switch between Light/DarkMode - Xojo Version >= 2018.3)
		* Issue #3777: Implement Page Shadow Property in Formatted Text (Switch between Light/DarkMode - Xojo Version >= 2018.3)
		* Issue #3755: Printing has the side-effect of scrolling the editing window to the top
		* Issue #3794: FTDocument.getSelectedParagraphs returns first paragraph of multi-paragraph doc regardless of insertion point
		* Issue #3796: FTStyleRun.copyStyleData does not copy background color
		* Issue #3820: RTFWriter missed "\par" after the last Paragraph
		* Issue #3774: FormattedText — changeParagraphMargins method name changeParagraphMarigns
		* Issue #3762: FTDocument.selectionFontColor returns sameColor false when it should be true
		* Issue #3842: FTStyleRun.updateWith Style sets textColor black when undefined
		* Issue #3806: FTDocument.addParagraphStyle and addCharacterStyle bypassed by insertXML and cannot be overridden in subclass
		* Issue #3818: Print RB Code Editor: Unwanted positive y-offset of the content compared to its line number
		* Issue #3637: FTCParagraphStyle.backgroundColor won’t set correctly
		* Issue #3910: RTF-Reader ignores local value for first line indent in paragraphs
		* Issue #3914: First Paragraph on Page with Background Color ignores Before Space
		* Issue #3917: Paragraphs Background Color ignores Hanging Indent
		
		Changes:
		* Renamed FormattedText.xDisplayPosition to FormattedText.hScrollValue to better reflect what it is.
		* Renamed FormattedText.lastXDisplayPosition to FormattedText.lastHScrollValue
		* Renamed FormattedText.yDisplayPosition to FormattedText.vScrollValue to better reflect what it is.
		* Renamed FormattedText.lastYDisplayPosition to FormattedText.lastVScrollValue
		* Renamed FormattedText.GetResolution to FormattedText.GetMonitorPixelsPerInch to better reflect what it does.
		* Renamed FTDocument.SetResolution to FTDocument.setMonitorPixelsPerInch
		* Renamed FTDocument.GetResolution to FTDocument.getMonitorPixelsPerInch
		* Renamed FTDocument.Resolution to FTDocument.MonitorPixelsPerInch
		* FormattedText.DISPLAY_ALIGN_CENTER/LEFT/RIGHT replaced with Display_Alignment enum
		* FormattedText.MODE_PAGE/NORMAL/EDIT/Single replaced with Display_Mode enum
		* FTLine.FIRST_LINE/MIDDLE/LAST/BOTH replaced with Line_Type enum
		* FTPicture.Handle constants converted to FTPicture.Handle_Type enum
		* FTParagraph.Alignment constants converted to FTParagraph.Alignment_Type enum
		* Removed Alignment constants from RTFConstants module
		* Changed how hyperlinks are drawn in FTObject.drawHyperLink
		* Changed how the gradient shadow is drawn in FTPage.drawPageViewMode
		* Changed how strikethroughs are drawn in FTObject.drawStrikethrough
		* Changed how underline is drawing in FTObject.drawUnderline
		* Can now read/write shadow properties from/to RTF Documents
		* Added AcceptFileDrop to test window for testing custom objects.  Added FTFile into project.
		* Changed how Styles are saved and read in XML format.
		* Issue #3802/1456: Command + (Shift Key) + Arrow Keys doesn't move insertion point correctly
		* Changed RB Script classes to Xojo Script.
		* Now have TabLeaders (WORK IN PROGRESS)
		* Embedded FTC demo now does text formatting with keyboard shortcuts.
		* Removed unused FTDocument.DocOffset method.
		* Fixed TargetCocoa and TargetWin32 constants with more appropriate ones for 2018 R4.
		* Removed duplicated code line in RTFReader.SetupKnownCommands
		* Updated ParagraphWindow to easy format First Line and Hanging Indents
		
		
		PARTIAL IMPLEMENATION:
		* Issue #3753: PageBreaks won't load from RTF
		
		
		
	#tag EndNote

	#tag Note, Name = 3.2.1
		
		Bug Fixes:
		* Fixed issue where all StyleRuns after a hyperlink will also be marked as hyperlink
		* Issue #4074: RTF clipboard ignores hyperlinks with umlauts and cuts them
		* Issue #4087: missing RTF space after "\kerning0" keyword
		* Issue #4130: FTXojoScriptField: Left part of the text is hidden by the section of the line number.
		* Issue #4135: Migrating texts from a TextArea to the FTC (Ich migrieren Texte aus einer TextArea in das FTC)
		* Issue #4196: Remove GOTO calls from FTC
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
