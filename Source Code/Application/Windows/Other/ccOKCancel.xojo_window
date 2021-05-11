#tag Window
Begin ContainerControl ccOKCancel
   AcceptFocus     =   False
   AcceptTabs      =   False
   AutoDeactivate  =   True
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   Compatibility   =   ""
   Enabled         =   True
   EraseBackground =   False
   HasBackColor    =   False
   Height          =   27
   HelpTag         =   ""
   InitialParent   =   ""
   Left            =   32
   LockBottom      =   False
   LockLeft        =   False
   LockRight       =   False
   LockTop         =   False
   TabIndex        =   0
   TabPanelIndex   =   0
   TabStop         =   True
   Top             =   32
   Transparent     =   True
   UseFocusRing    =   False
   Visible         =   True
   Width           =   172
   Begin pushbutton pbLeft
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   "0"
      Cancel          =   False
      Caption         =   "Untitled"
      Default         =   False
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   
      Italic          =   False
      Left            =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   False
      LockTop         =   False
      Scope           =   "0"
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   4
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin pushbutton pbRight
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   "0"
      Cancel          =   False
      Caption         =   "Untitled"
      Default         =   False
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   
      Italic          =   False
      Left            =   92
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   False
      LockTop         =   False
      Scope           =   "0"
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   4
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
End
#tag EndWindow

#tag WindowCode
	#tag Hook, Flags = &h0
		Event CancelClicked()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event OKClicked()
	#tag EndHook


#tag EndWindowCode

#tag Events pbLeft
	#tag Event
		Sub Open()
		  #If TargetMacOS Then
		    Me.Caption="Cancel"
		    Me.Cancel=True
		    Me.Default=False
		  #else
		    Me.Caption = "OK"
		    Me.Cancel = false
		    Me.Default = true
		  #EndIf
		End Sub
	#tag EndEvent
	#tag Event
		Sub Action()
		  #If TargetMacOS Then
		    CancelClicked
		  #Else
		    OKClicked
		  #EndIf
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events pbRight
	#tag Event
		Sub Open()
		  #If TargetMacOS Then
		    Me.Caption="OK"
		    Me.Cancel=False
		    Me.Default=True
		  #else
		    Me.Caption = "Cancel"
		    Me.Cancel = true
		    Me.Default = false
		  #EndIf
		End Sub
	#tag EndEvent
	#tag Event
		Sub Action()
		  #If TargetMacOS Then
		    OKClicked
		  #Else
		    CancelClicked
		  #EndIf
		End Sub
	#tag EndEvent
#tag EndEvents
