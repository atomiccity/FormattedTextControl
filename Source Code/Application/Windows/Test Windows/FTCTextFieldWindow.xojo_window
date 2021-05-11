#tag Window
Begin BaseWindow FTCTextFieldWindow
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   True
   Compatibility   =   ""
   Composite       =   False
   Frame           =   0
   FullScreen      =   False
   FullScreenButton=   False
   HasBackColor    =   False
   Height          =   428
   ImplicitInstance=   True
   LiveResize      =   False
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   False
   MaxWidth        =   32000
   MenuBar         =   1610178758
   MenuBarVisible  =   True
   MinHeight       =   64
   MinimizeButton  =   True
   MinWidth        =   64
   Placement       =   0
   Resizeable      =   False
   Title           =   "FTTextField"
   Visible         =   True
   Width           =   459
   Begin Label ExplanationLabel
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   58
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Multiline       =   True
      Scope           =   0
      Selectable      =   False
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "The FTTextField is the equivalent of the built in TextField, except that it has all the advantages of the FTC behind it. For example it has cross platform spell checking and undo capabilities."
      TextAlign       =   0
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   14
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   419
   End
   Begin FTTextField TestTextField
      AcceptFocus     =   "True"
      AcceptTabs      =   ""
      AllowBackgroundUpdates=   True
      AllowPictures   =   True
      AutoComplete    =   False
      AutoDeactivate  =   True
      Backdrop        =   ""
      BackgroundColor =   &cA0ADCD00
      BorderColor     =   &cA0A0A000
      BottomMargin    =   0.0
      CaretColor      =   &c00000000
      DefaultFont     =   "Arial"
      DefaultFontSize =   12
      defaultHyperLinkColor=   &c0000FF00
      defaultHyperLinkColorDisabled=   &cCCCCCC00
      defaultHyperLinkColorRollover=   &cFF000000
      defaultHyperLinkColorVisited=   &c80008000
      DefaultTabStop  =   0.5
      DefaultTextColor=   &c00000000
      DisplayAlignment=   0
      DoubleBuffer    =   "False"
      DragAndDrop     =   True
      DrawControlBorder=   true
      EditViewMargin  =   0.0599999999999999977796
      EditViewPrintMargin=   0.5
      Enabled         =   True
      EraseBackground =   "True"
      Height          =   22
      HelpTag         =   ""
      HScrollbarAutoHide=   False
      Index           =   -2147483648
      InhibitSelections=   False
      InitialParent   =   ""
      InvisiblesColor =   &c526AFF00
      IsHiDPT         =   False
      Left            =   117
      LeftMargin      =   0.0
      LimitText       =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   False
      MarginGuideColor=   &cCACACA00
      Mask            =   ""
      Mode            =   0
      objectCountId   =   0
      PageHeight      =   11.0
      PageWidth       =   8.5
      ReadOnly        =   False
      RightMargin     =   0.0
      Scope           =   0
      ShowInvisibles  =   False
      ShowMarginGuides=   False
      ShowPilcrows    =   False
      SpellCheckWhileTyping=   True
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      TIC_PageTop     =   0
      TIC_xCaret      =   0
      TIC_yCaret      =   0
      Top             =   385
      TopMargin       =   0.0
      UndoLimit       =   128
      updateFlag      =   False
      UseFocusRing    =   "True"
      Visible         =   True
      VScrollbarAutoHide=   False
      Width           =   322
      xDisplayAlignmentOffset=   0
   End
   Begin Label FTTextFieldLabel
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
      LockRight       =   False
      LockTop         =   False
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "FTTextField:"
      TextAlign       =   2
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   385
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   85
   End
   Begin Label MaskLabel
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
      LockRight       =   False
      LockTop         =   False
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Mask:"
      TextAlign       =   2
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   329
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   85
   End
   Begin TextField MaskField
      AcceptTabs      =   False
      Alignment       =   0
      AutoDeactivate  =   True
      AutomaticallyCheckSpelling=   False
      BackColor       =   &cFFFFFF00
      Bold            =   False
      Border          =   True
      CueText         =   ""
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Format          =   ""
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      Italic          =   False
      Left            =   117
      LimitText       =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   False
      Mask            =   ""
      Password        =   False
      ReadOnly        =   False
      Scope           =   0
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   329
      Transparent     =   False
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   322
   End
   Begin FTEditField MaskDefinitionField
      AcceptFocus     =   ""
      AcceptTabs      =   ""
      AllowBackgroundUpdates=   False
      AllowPictures   =   False
      AutoComplete    =   False
      AutoDeactivate  =   True
      Backdrop        =   ""
      BackgroundColor =   &cA0ADCD00
      BorderColor     =   &cA0A0A000
      BottomMargin    =   0.0
      CaretColor      =   &c00000000
      DefaultFont     =   "Arial"
      DefaultFontSize =   12
      defaultHyperLinkColor=   &c0000FF00
      defaultHyperLinkColorDisabled=   &cCCCCCC00
      defaultHyperLinkColorRollover=   &cFF000000
      defaultHyperLinkColorVisited=   &c80008000
      DefaultTabStop  =   0.5
      DefaultTextColor=   &c00000000
      DisplayAlignment=   0
      DoubleBuffer    =   "False"
      DragAndDrop     =   False
      DrawControlBorder=   true
      EditViewMargin  =   0.0
      EditViewPrintMargin=   0.5
      Enabled         =   True
      EraseBackground =   "False"
      Height          =   214
      HelpTag         =   ""
      HScrollbarAutoHide=   False
      Index           =   -2147483648
      InhibitSelections=   false
      InitialParent   =   ""
      InvisiblesColor =   &c526AFF00
      IsHiDPT         =   False
      Left            =   20
      LeftMargin      =   0.0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      MarginGuideColor=   &cCACACA00
      Mode            =   0
      objectCountId   =   0
      PageHeight      =   0.0
      PageWidth       =   0.0
      ReadOnly        =   True
      RightMargin     =   0.0
      Scope           =   0
      ShowInvisibles  =   False
      ShowMarginGuides=   False
      ShowPilcrows    =   False
      SpellCheckWhileTyping=   False
      TabIndex        =   7
      TabPanelIndex   =   0
      TabStop         =   True
      TIC_PageTop     =   0
      TIC_xCaret      =   0
      TIC_yCaret      =   0
      Top             =   97
      TopMargin       =   0.0
      UndoLimit       =   128
      updateFlag      =   False
      UseFocusRing    =   "False"
      Visible         =   True
      VScrollbarAutoHide=   False
      Width           =   419
      xDisplayAlignmentOffset=   0
   End
   Begin FTScrollbar VScrollbar
      AcceptFocus     =   true
      AutoDeactivate  =   True
      Enabled         =   True
      Height          =   134
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   393
      LineStep        =   1
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
      Top             =   157
      Transparent     =   False
      Value           =   0
      Visible         =   True
      Width           =   16
   End
   Begin Label MaskDefinitionLabel
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
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   8
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Mask Definition:"
      TextAlign       =   0
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   74
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   237
   End
   Begin Label ValidMaskLabel
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   True
      Left            =   117
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   False
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   9
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "---"
      TextAlign       =   0
      TextColor       =   &c00000000
      TextFont        =   "Arial"
      TextSize        =   11.0
      TextUnit        =   0
      Top             =   353
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   322
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  
		  ' Set the window minimums.
		  MinWidth = Width
		  MinHeight = Height
		  
		  ' Set the initial mask.
		  MaskField.Text = "(###) ###-####"
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resized()
		  
		  ' Resize the text fields.
		  TestTextField.resize
		  MaskDefinitionField.resize
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resizing()
		  
		  ' Resize the text fields.
		  TestTextField.resize
		  MaskDefinitionField.resize
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub installMask(mask as string)
		  
		  ' Is the mask a valid one.
		  if TestTextField.isMaskValid(mask) then
		    
		    ' Install the mask.
		    TestTextField.setMask(mask)
		    
		    ' Clear the field.
		    TestTextField.setText("")
		    
		    ' Let the user know.
		    ValidMaskLabel.Text = "Valid mask"
		    
		  else
		    
		    ' Alert the user.
		    ValidMaskLabel.Text = "Invalid mask"
		    
		  end if
		  
		End Sub
	#tag EndMethod


	#tag Constant, Name = MASK_TEXT, Type = String, Dynamic = False, Default = \"{\\rtf1\\ansi\\ansicpg1252\\cocoartf949\\cocoasubrtf540\r{\\fonttbl\\f0\\fswiss\\fcharset0 Helvetica;}\r{\\colortbl;\\red255\\green255\\blue255;\\red74\\green0\\blue230;\\red59\\green0\\blue164;}\r\\margl1440\\margr1440\\margb1800\\margt1800\r\\deftab720\r\\pard\\tx560\\tx1120\\tx1680\\tx2240\\tx2800\\tx3360\\tx3920\\tx4480\\tx5040\\tx5600\\tx6160\\tx6720\\pardeftab720\\pardirnatural\r\r\\f0\\b\\fs24 \\cf2 \\expnd0\\expndtw0\\kerning0\r\\up0 \\nosupersub \\ulnone \\outl0\\strokewidth0 \\strokec2 #\r\\b0 \\cf0 \\expnd0\\expndtw0\\kerning0\r\\strokec0  - The single digit placeholder (0-9).\\\r\\\r\r\\b \\cf2 \\expnd0\\expndtw0\\kerning0\r\\strokec2 A\r\\b0 \\cf0 \\expnd0\\expndtw0\\kerning0\r\\strokec0  - Alphabetic (a-z A-Z).\\\r\\\r\r\\b \\cf2 \\expnd0\\expndtw0\\kerning0\r\\strokec2 B\r\\b0 \\cf0 \\expnd0\\expndtw0\\kerning0\r\\strokec0  - Alphanumeric (a-z A-Z 0-9).\\\r\\\r\r\\b \\cf2 \\expnd0\\expndtw0\\kerning0\r\\strokec2 C\r\\b0 \\cf0 \\expnd0\\expndtw0\\kerning0\r\\strokec0  - Any printable character.\\\r\\\r\\pard\\tx560\\tx1120\\tx1680\\tx2240\\tx2800\\tx3360\\tx3920\\tx4480\\tx5040\\tx5600\\tx6160\\tx6720\\pardeftab720\\pardirnatural\r\r\\b \\cf3 \\expnd0\\expndtw0\\kerning0\r\\strokec3 [ ]\r\\b0 \\cf0 \\expnd0\\expndtw0\\kerning0\r\\strokec0  - Character set. Allows you to define a set of characters for that position. For example \"[-+]\" allows you to have a plus or minus sign for that particular character position.\\\r\\\r\\pard\\tx560\\tx1120\\tx1680\\tx2240\\tx2800\\tx3360\\tx3920\\tx4480\\tx5040\\tx5600\\tx6160\\tx6720\\pardeftab720\\pardirnatural\r\r\\b \\cf2 \\expnd0\\expndtw0\\kerning0\r\\strokec2 .\r\\b0 \\cf0 \\expnd0\\expndtw0\\kerning0\r\\strokec0  - Decimal placeholder. Derived from the international settings.\\\r\\\r\r\\b \\cf2 \\expnd0\\expndtw0\\kerning0\r\\strokec2 \x2C\r\\b0 \\cf0 \\expnd0\\expndtw0\\kerning0\r\\strokec0  - Thousands separator. Derived from the international settings.\\\r\\\r\r\\b \\cf2 \\expnd0\\expndtw0\\kerning0\r\\strokec2 /\r\\b0 \\cf0 \\expnd0\\expndtw0\\kerning0\r\\strokec0  - Date separator. Derived from the international settings.\\\r\\\r\r\\b \\cf2 \\expnd0\\expndtw0\\kerning0\r\\strokec2 \\\\\r\\b0 \\cf0 \\expnd0\\expndtw0\\kerning0\r\\strokec0  - Mask escape character. Used to specify literal characters that conflict with reserved mask characters.\\\r\\\r\r\\b \\cf2 \\expnd0\\expndtw0\\kerning0\r\\strokec2 >\r\\b0 \\cf0 \\expnd0\\expndtw0\\kerning0\r\\strokec0  - Convert all the characters that follow to uppercase.\\\r\\\r\r\\b \\cf2 \\expnd0\\expndtw0\\kerning0\r\\strokec2 <\r\\b0 \\cf0 \\expnd0\\expndtw0\\kerning0\r\\strokec0  - Convert all the characters that follow to lowercase.\\\r\\\rAll other symbols are displayed as literals for formatting purposes.}", Scope = Public
	#tag EndConstant


#tag EndWindowCode

#tag Events MaskField
	#tag Event
		Sub TextChange()
		  
		  ' Install the mask.
		  installMask(me.text)
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events MaskDefinitionField
	#tag Event
		Function GetVerticalScrollbar() As FTScrollbar
		  
		  ' Return the vertical scrollbar.
		  return VScrollbar
		  
		End Function
	#tag EndEvent
	#tag Event
		Sub Open()
		  
		  ' Set up the mask defintion text.
		  MaskDefinitionField.setRTF(MASK_TEXT)
		  
		  ' Reset the margins.
		  me.setMargins(0.06, 0.06, 0.06, 0.06)
		  
		End Sub
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
