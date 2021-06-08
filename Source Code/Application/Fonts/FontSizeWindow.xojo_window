#tag Window
Begin Window FontSizeWindow
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   True
   Composite       =   False
   Frame           =   1
   FullScreen      =   False
   HasBackColor    =   False
   HasFullScreenButton=   False
   Height          =   108
   ImplicitInstance=   True
   LiveResize      =   "False"
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
   Title           =   "Font Size"
   Visible         =   True
   Width           =   243
   Begin PushButton CancelButton
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   0
      Cancel          =   True
      Caption         =   "Cancel"
      ControlOrder    =   "0"
      Default         =   False
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   154
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   12.0
      TextUnit        =   0
      Top             =   68
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   69
   End
   Begin PushButton SelectButton
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   0
      Cancel          =   False
      Caption         =   "Select"
      ControlOrder    =   "1"
      Default         =   True
      Enabled         =   False
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   73
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   12.0
      TextUnit        =   0
      Top             =   68
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   69
   End
   Begin Label FontSizeLabel
      AutoDeactivate  =   True
      Bold            =   False
      ControlOrder    =   "2"
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
      Selectable      =   False
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Font size:"
      TextAlign       =   2
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   12.0
      TextUnit        =   0
      Top             =   22
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   61
   End
   Begin TextField FontSizeField
      AcceptTabs      =   False
      Alignment       =   0
      AutoDeactivate  =   True
      AutomaticallyCheckSpelling=   False
      BackColor       =   &cFFFFFF00
      Bold            =   False
      Border          =   True
      ControlOrder    =   "3"
      CueText         =   ""
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Format          =   ""
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   93
      LimitText       =   3
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Mask            =   "###"
      Multiline       =   "False"
      Password        =   False
      ReadOnly        =   False
      ScrollbarHorizontal=   "False"
      ScrollbarVertical=   "True"
      Styled          =   "False"
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   12.0
      TextUnit        =   0
      Top             =   21
      Transparent     =   False
      Underline       =   False
      UseFocusRing    =   False
      Visible         =   True
      Width           =   37
   End
End
#tag EndWindow

#tag WindowCode
	#tag Method, Flags = &h0
		Function getFontSize() As integer
		  
		  ' Return the font size.
		  return Val(FontSizeField.text)
		  
		End Function
	#tag EndMethod


	#tag Note, Name = Change log
		
		beta11
	#tag EndNote


	#tag Property, Flags = &h0
		result As boolean
	#tag EndProperty


#tag EndWindowCode

#tag Events CancelButton
	#tag Event
		Sub Action()
		  
		  ' Cancel the dialog.
		  result = false
		  
		  ' Hide the window.
		  hide
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SelectButton
	#tag Event
		Sub Action()
		  
		  ' The user accepted the font size.
		  result = true
		  
		  ' Hide the window.
		  hide
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events FontSizeField
	#tag Event
		Sub TextChange()
		  
		  ' Is there something to select?
		  SelectButton.Enabled = (Val(me.Text) > 0)
		  
		End Sub
	#tag EndEvent
#tag EndEvents
