#tag Window
Begin Window HTMLExportWindow
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   True
   Compatibility   =   ""
   Composite       =   False
   Frame           =   1
   FullScreen      =   False
   HasBackColor    =   False
   Height          =   261
   ImplicitInstance=   True
   LiveResize      =   False
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
   Title           =   "HTML Export"
   Visible         =   True
   Width           =   505
   Begin PushButton ProceedButton
      AutoDeactivate  =   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "Proceed"
      Default         =   True
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   
      Italic          =   False
      Left            =   405
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      Scope           =   "0"
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   221
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin Label ExplantionLabel
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   195
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   
      Italic          =   False
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Multiline       =   True
      Scope           =   "0"
      Selectable      =   False
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "This functionality demonstrates the FTIterator and FTIteratorBase classes within the FTC. These two classes allow you to easily walk through the FTC paragraphs and style runs. In this case it is used to generate some basic HTML output. The class FTinterator takes care of the mechanics of walking through the data structures and FTIteratorBase is the base class you use to create your own handlers. The FTinterator class will call the handlers in your subclass.\r\rNote, the HTML produced by this particular implementation only handles paragraphs, paragraph alignment, bold, italic and underline. Pictures are ignored. You can extend this code to format the text any way want."
      TextAlign       =   0
      TextColor       =   
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   14
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   465
   End
End
#tag EndWindow

#tag WindowCode
#tag EndWindowCode

#tag Events ProceedButton
	#tag Event
		Sub Action()
		  
		  Close
		  
		End Sub
	#tag EndEvent
#tag EndEvents
