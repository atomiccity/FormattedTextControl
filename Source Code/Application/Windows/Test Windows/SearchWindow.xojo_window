#tag Window
Begin Window SearchWindow
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   True
   Compatibility   =   ""
   Composite       =   False
   Frame           =   3
   FullScreen      =   False
   HasBackColor    =   False
   Height          =   122
   ImplicitInstance=   True
   LiveResize      =   False
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   False
   MaxWidth        =   32000
   MenuBar         =   0
   MenuBarVisible  =   True
   MinHeight       =   64
   MinimizeButton  =   False
   MinWidth        =   64
   Placement       =   0
   Resizeable      =   False
   Title           =   "Search and Replace"
   Visible         =   True
   Width           =   317
   Begin Label Findlabel
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   
      Italic          =   False
      Left            =   68
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   "0"
      Selectable      =   False
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Find:"
      TextAlign       =   2
      TextColor       =   
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   15
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   45
   End
   Begin TextField FindField
      AcceptTabs      =   False
      Alignment       =   0
      AutoDeactivate  =   True
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
      Italic          =   False
      Left            =   125
      LimitText       =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
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
      Top             =   14
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   172
   End
   Begin Label ReplaceLabel
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   "0"
      Selectable      =   False
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Replace with:"
      TextAlign       =   2
      TextColor       =   
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   48
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   93
   End
   Begin TextField ReplaceField
      AcceptTabs      =   False
      Alignment       =   0
      AutoDeactivate  =   True
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
      Italic          =   False
      Left            =   125
      LimitText       =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Mask            =   ""
      Password        =   False
      ReadOnly        =   False
      Scope           =   "0"
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextColor       =   
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   48
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   172
   End
   Begin PushButton ReplaceButton
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   "0"
      Cancel          =   False
      Caption         =   "Replace"
      Default         =   False
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   
      Italic          =   False
      Left            =   125
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   "0"
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   82
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin PushButton FindButton
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   "0"
      Cancel          =   False
      Caption         =   "Find"
      Default         =   False
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   
      Italic          =   False
      Left            =   217
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   "0"
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   82
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Function CancelClose(appQuitting as Boolean) As Boolean
		  
		  ' Is this a user close?
		  if not appQuitting then
		    
		    ' Just hide the window.
		    hide
		    
		    ' Cancel the close.
		    return true
		    
		  end if
		  
		  ' Allow the close.
		  return false
		  
		End Function
	#tag EndEvent


	#tag Method, Flags = &h1000
		Sub Constructor(parent as FormattedText)
		  
		  ' Save the reference.
		  me.parent = parent
		  
		  ' Fire the open events.
		  Super.Constructor
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private parent As FormattedText
	#tag EndProperty

	#tag Property, Flags = &h0
		windowOpen As boolean
	#tag EndProperty


#tag EndWindowCode

#tag Events ReplaceButton
	#tag Event
		Sub Action()
		  
		  Dim doc as FTDocument
		  Dim selectStart as FTInsertionOffset
		  Dim selectEnd as FTInsertionOffset
		  
		  ' Get a reference to the document.
		  doc = parent.getDoc
		  
		  ' Is anything selected?
		  if not doc.isSelected then return
		  
		  ' Get the current selection range.
		  doc.getSelectionRange(selectStart, selectEnd)
		  
		  ' Replace the text.
		  parent.insertText(ReplaceField.Text)
		  
		  ' Reselect the inserted text.
		  doc.selectSegment(selectStart, selectStart + ReplaceField.Text.len)
		  
		  ' Update the display.
		  parent.update(true, true)
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events FindButton
	#tag Event
		Sub Action()
		  
		  Dim target as string
		  Dim ignore as FTInsertionOffset
		  Dim searchStart as FTInsertionOffset
		  Dim selectStart as FTInsertionOffset
		  Dim selectEnd as FTInsertionOffset
		  Dim doc as FTDocument
		  
		  ' Get a reference to the document.
		  doc = parent.getDoc
		  
		  ' Get the text to search for.
		  target = FindField.Text
		  
		  ' Was a target specified?
		  if target <> "" then
		    
		    ' Is there something currently selected?
		    if doc.isSelected then
		      
		      ' Use the end of the selection.
		      doc.getSelectionRange(ignore, searchStart)
		      
		    else
		      
		      ' Use the current insertion point.
		      searchStart = doc.getInsertionOffset
		      
		    end if
		    
		    ' Search for the target.
		    if parent.search(target, searchStart, nil, selectStart, selectEnd) then
		      
		      ' Select the found item.
		      parent.selectSegment(selectStart, selectEnd)
		      
		      ' Make sure it is visible.
		      parent.scrollToSelection
		      
		    else
		      
		      ' Alert the user.
		      beep
		      
		    end if
		    
		  else
		    
		    ' Alert the user.
		    beep
		    
		  end if
		  
		End Sub
	#tag EndEvent
#tag EndEvents
