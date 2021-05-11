#tag Window
Begin Window winAsk
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   True
   Compatibility   =   ""
   Composite       =   False
   Frame           =   2
   FullScreen      =   False
   HasBackColor    =   False
   Height          =   135
   ImplicitInstance=   True
   LiveResize      =   True
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   False
   MaxWidth        =   32000
   MenuBar         =   0
   MenuBarVisible  =   True
   MinHeight       =   64
   MinimizeButton  =   True
   MinWidth        =   64
   Placement       =   0
   Resizeable      =   False
   Title           =   ""
   Visible         =   True
   Width           =   409
   Begin Label stInstructions
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   43
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   False
      LockTop         =   False
      Multiline       =   True
      Scope           =   "0"
      Selectable      =   False
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Instructions Go Here"
      TextAlign       =   0
      TextColor       =   
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   11
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   369
   End
   Begin TextField efText
      AcceptTabs      =   False
      Alignment       =   0
      AutoDeactivate  =   True
      AutomaticallyCheckSpelling=   False
      BackColor       =   
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
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LimitText       =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   False
      LockTop         =   False
      Mask            =   ""
      Password        =   False
      ReadOnly        =   False
      Scope           =   "0"
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextColor       =   
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   60
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   369
   End
   Begin ccOKCancel ccOKCancel1
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      BackColor       =   
      Backdrop        =   0
      Enabled         =   True
      EraseBackground =   False
      HasBackColor    =   False
      Height          =   27
      HelpTag         =   ""
      Index           =   "-2147483648"
      InitialParent   =   ""
      Left            =   217
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      Scope           =   "0"
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   94
      Transparent     =   True
      UseFocusRing    =   False
      Visible         =   True
      Width           =   172
   End
End
#tag EndWindow

#tag WindowCode
	#tag Method, Flags = &h0
		Function Ask(instructions as string, byref initialtext as String, bPassword as boolean = false, w as Window) As Boolean
		  stInstructions.text = instructions
		  efText.Password = bPassword
		  efText.text = initialtext
		  
		  efText.SelectAll
		  
		  if w = nil then
		    self.ShowModal
		  else
		    self.ShowModalWithin w
		  end
		  
		  if bSave then initialtext = efText.text
		  
		  return bSave
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		bSave As Boolean
	#tag EndProperty


#tag EndWindowCode

#tag Events ccOKCancel1
	#tag Event
		Sub CancelClicked()
		  bSave = false
		  self.Visible = false
		End Sub
	#tag EndEvent
	#tag Event
		Sub OKClicked()
		  bSave = true
		  self.Visible = false
		End Sub
	#tag EndEvent
#tag EndEvents
