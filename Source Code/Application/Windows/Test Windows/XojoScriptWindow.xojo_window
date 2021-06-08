#tag Window
Begin BaseWindow XojoScriptWindow
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   True
   Composite       =   False
   Frame           =   0
   FullScreen      =   False
   FullScreenButton=   False
   HasBackColor    =   False
   Height          =   662
   ImplicitInstance=   True
   LiveResize      =   "True"
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   True
   MaxWidth        =   32000
   MenuBar         =   1610178758
   MenuBarVisible  =   True
   MinHeight       =   300
   MinimizeButton  =   True
   MinWidth        =   400
   Placement       =   0
   Resizeable      =   True
   Title           =   "Xojo Code Editor"
   Visible         =   True
   Width           =   720
   Begin FTXojoScriptField XojoScriptEditor
      AllowBackgroundUpdates=   True
      AllowPictures   =   True
      AutoComplete    =   True
      AutoDeactivate  =   True
      BackgroundColor =   &cA0ADCD00
      BorderColor     =   &cA0A0A000
      BottomMargin    =   0.0
      CaretColor      =   &c00000000
      Comments        =   &c7F000000
      CornerColor     =   &cFFFFFF00
      DefaultFont     =   "monaco"
      DefaultFontSize =   12
      defaultHyperLinkColor=   &c0000FF00
      defaultHyperLinkColorDisabled=   &cCCCCCC00
      defaultHyperLinkColorRollover=   &cFF000000
      defaultHyperLinkColorVisited=   &c80008000
      DefaultTabStop  =   0.5
      DefaultTextColor=   &c00000000
      DisplayAlignment=   0
      DragAndDrop     =   True
      DrawControlBorder=   True
      EditViewMargin  =   0.0599999999999999977796
      EditViewPrintMargin=   0.5
      Enabled         =   True
      Error           =   &cFF86A400
      Floating        =   &c00653200
      Height          =   596
      HelpTag         =   ""
      HScrollbarAutoHide=   False
      Indent          =   0.25
      Index           =   -2147483648
      InhibitSelections=   False
      InitialParent   =   ""
      Integers        =   &c32659800
      InvisiblesColor =   &c526AFF00
      IsHiDPT         =   False
      Keywords        =   &c0000FF00
      Left            =   20
      LeftMargin      =   0.0
      LineNumberBackground=   &cF0F0F000
      LineNumberColor =   &c00000000
      LineSeparator   =   &cAAAAAA00
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      MarginGuideColor=   &cCACACA00
      Mode            =   0
      objectCountId   =   0
      PageHeight      =   11.0
      PageWidth       =   8.5
      ReadOnly        =   False
      RightMargin     =   0.0
      Scope           =   0
      ShowInvisibles  =   False
      ShowLineNumbers =   True
      ShowMarginGuides=   False
      ShowPilcrows    =   False
      Softwrap        =   False
      Source          =   &c00000000
      SpellCheckWhileTyping=   False
      Strings         =   &c6500FE00
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      TIC_PageTop     =   0
      TIC_xCaret      =   0
      TIC_yCaret      =   0
      Top             =   14
      TopMargin       =   0.0
      UndoLimit       =   128
      updateFlag      =   False
      UsePageShadow   =   True
      Visible         =   True
      VScrollbarAutoHide=   False
      Width           =   680
      WordParagraphBackground=   True
      xDisplayAlignmentOffset=   0
   End
   Begin FTScrollbar VScrollbar
      AcceptFocus     =   False
      AutoDeactivate  =   True
      Enabled         =   True
      Height          =   100
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   493
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
      Top             =   136
      Transparent     =   False
      Value           =   0
      Visible         =   True
      Width           =   16
   End
   Begin FTScrollbar HScrollbar
      AcceptFocus     =   False
      AutoDeactivate  =   True
      Enabled         =   True
      Height          =   16
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   218
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
      Top             =   317
      Transparent     =   False
      Value           =   0
      Visible         =   True
      Width           =   100
   End
   Begin PushButton ErrorButton
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   0
      Cancel          =   False
      Caption         =   "Generate Random Error Line"
      Default         =   False
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   474
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      Scope           =   0
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   622
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   226
   End
   Begin CheckBox LineNumberCheckbox
      AutoDeactivate  =   True
      Bold            =   False
      Caption         =   "Line Numbers"
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
      Scope           =   0
      State           =   1
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   615
      Transparent     =   False
      Underline       =   False
      Value           =   True
      Visible         =   True
      Width           =   113
   End
   Begin CheckBox SoftwrapCheckbox
      AutoDeactivate  =   True
      Bold            =   False
      Caption         =   "Softwrap"
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
      Scope           =   0
      State           =   0
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   635
      Transparent     =   False
      Underline       =   False
      Value           =   False
      Visible         =   True
      Width           =   84
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  
		  ' Set the checkbox value to match the display.
		  LineNumberCheckbox.Value = XojoScriptEditor.ShowLineNumbers
		  
		  XojoScriptEditor.setAutoCompleteOptions(Array("for", "each", "as", "string", "strip", "stop", "line.test", "line.height"))
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resized()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Resize the control.
		  XojoScriptEditor.resize
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resizing()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Resize the control.
		  XojoScriptEditor.resize
		  
		End Sub
	#tag EndEvent


	#tag MenuHandler
		Function EditRefresh() As Boolean Handles EditRefresh.Action
			
			#if not DebugBuild
			
			#pragma BoundsChecking FTC_BOUNDSCHECKING
			#pragma NilObjectChecking FTC_NILOBJECTCHECKING
			#pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
			
			#endif
			
			' Update the control.
			XojoScriptEditor.indentAllLines
			XojoScriptEditor.updateFull
			
			return true
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function FilePrint() As Boolean Handles FilePrint.Action
			
			#if not DebugBuild
			
			#pragma BoundsChecking FTC_BOUNDSCHECKING
			#pragma NilObjectChecking FTC_NILOBJECTCHECKING
			#pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
			
			#endif
			
			Dim g as Graphics
			
			' Has the printer set up dialog been run?
			if app.doPageSetup(false) then
			
			' Show the printer dialog.
			g = OpenPrinterDialog(app.getPrinter)
			
			' Did the user confirm the print action?
			if not (g is nil) then
			
			' Print the document.
			XojoScriptEditor.print(g, app.getPrinter)
			
			end if
			
			end if
			
			' We handled it.
			return true
			
		End Function
	#tag EndMenuHandler


#tag EndWindowCode

#tag Events XojoScriptEditor
	#tag Event
		Function GetHorizontalScrollbar() As FTScrollbar
		  
		  ' Return the scrollbar.
		  return HScrollbar
		  
		End Function
	#tag EndEvent
	#tag Event
		Function GetVerticalScrollbar() As FTScrollbar
		  
		  ' Return the scrollbar.
		  return VScrollbar
		  
		End Function
	#tag EndEvent
	#tag Event
		Sub Open()
		  ' Install the test data.
		  me.setText(testscript)
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ErrorButton
	#tag Event
		Sub Action()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim line as integer
		  
		  ' Get the number of lines.
		  line = (XojoScriptEditor.getDoc.getParagraphCount - 1) * rnd
		  
		  ' Color the line.
		  XojoScriptEditor.showErrorLine(line)
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events LineNumberCheckbox
	#tag Event
		Sub Action()
		  
		  ' Toggle the line numbers.
		  XojoScriptEditor.showLineNumbers(me.value)
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SoftwrapCheckbox
	#tag Event
		Sub Action()
		  
		  ' Change the wrapping.
		  XojoScriptEditor.setSoftwrap(me.value)
		  
		End Sub
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
