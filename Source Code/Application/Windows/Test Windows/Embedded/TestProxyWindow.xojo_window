#tag Window
Begin Window TestProxyWindow
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   True
   Composite       =   False
   Frame           =   0
   FullScreen      =   False
   FullScreenButton=   False
   HasBackColor    =   False
   Height          =   181
   ImplicitInstance=   True
   LiveResize      =   "True"
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   False
   MaxWidth        =   32000
   MenuBar         =   0
   MenuBarVisible  =   False
   MinHeight       =   64
   MinimizeButton  =   False
   MinWidth        =   64
   Placement       =   0
   Resizeable      =   False
   Title           =   "Untitled"
   Visible         =   False
   Width           =   232
   Begin FormattedTextProxy Target
      AllowBackgroundUpdates=   True
      AllowPictures   =   True
      AutoComplete    =   False
      AutoDeactivate  =   True
      BackgroundColor =   &cA0ADCD00
      BorderColor     =   &cA0A0A000
      BottomMargin    =   0.0
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
      DisplayAlignment=   0
      DragAndDrop     =   True
      DrawControlBorder=   True
      EditViewMargin  =   0.0599999999999999977796
      EditViewPrintMargin=   0.5
      Enabled         =   True
      Height          =   147
      HelpTag         =   ""
      HScrollbarAutoHide=   False
      Index           =   -2147483648
      InhibitSelections=   False
      InitialParent   =   ""
      InvisiblesColor =   &c526AFF00
      IsHiDPT         =   False
      Left            =   20
      LeftMargin      =   0.0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MarginGuideColor=   &cCACACA00
      Mode            =   2
      myPic           =   0
      objectCountId   =   0
      PageHeight      =   0.0
      PageWidth       =   0.0
      ReadOnly        =   False
      RightMargin     =   0.0
      Scope           =   0
      ShowInvisibles  =   False
      ShowMarginGuides=   False
      ShowPilcrows    =   False
      SpellCheckWhileTyping=   False
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
      Visible         =   False
      VScrollbarAutoHide=   False
      Width           =   192
      WordParagraphBackground=   True
      xDisplayAlignmentOffset=   0
      xPos            =   100
      yPos            =   100
   End
   Begin FTScrollbar VScrollbar
      AcceptFocus     =   False
      AutoDeactivate  =   True
      Enabled         =   True
      Height          =   100
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   174
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
      Top             =   25
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
      Left            =   52
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
      Top             =   118
      Transparent     =   False
      Value           =   0
      Visible         =   True
      Width           =   100
   End
End
#tag EndWindow

#tag WindowCode
	#tag Method, Flags = &h0
		Sub adjustParagraph()
		  
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
		  p = Target.getDoc.getInsertionPoint.getCurrentParagraph
		  
		  ' Get the margins.
		  firstIndent = p.getFirstIndent
		  leftMargin = p.getLeftMargin
		  rightMargin = p.getRightMargin
		  beforeSpace = p.getBeforeParagraphSpace
		  afterSpace = p.getAfterParagraphSpace
		  
		  ' Create the window.
		  pw = new ParagraphWindow(Target.getDoc, firstIndent, leftMargin, rightMargin, beforeSpace, afterSpace)
		  
		  ' Show the window.
		  pw.ShowModal
		  
		  ' Did the user confirm the action?
		  if pw.getResult then
		    
		    ' Get the margins.
		    pw.getMargins(firstIndent, leftMargin, rightMargin, beforeSpace, afterSpace)
		    
		    ' Is there selected text?
		    if Target.getDoc.isSelected then
		      
		      ' Get the selection range.
		      Target.getDoc.getSelectionRange(selectStart, selectEnd)
		      
		      ' Extract the paragraph indexes.
		      startIndex = selectStart.paragraph
		      endIndex = selectEnd.paragraph
		      
		    else
		      
		      ' Just use the current paragraph.
		      startIndex = p.getAbsoluteIndex
		      endIndex = startIndex
		      
		    end if
		    
		    ' Update the display.
		    Target.changeParagraphMargins(startIndex, endIndex, _
		    firstIndent, leftMargin, rightMargin, beforeSpace, afterSpace)
		    
		  end if
		  
		End Sub
	#tag EndMethod


#tag EndWindowCode

#tag Events Target
	#tag Event
		Function GetVerticalScrollbar() As FTScrollbar
		  
		  return VScrollbar
		  
		End Function
	#tag EndEvent
	#tag Event
		Function GetHorizontalScrollbar() As FTScrollbar
		  
		  return HScrollbar
		  
		End Function
	#tag EndEvent
	#tag Event
		Function XmlObjectCreate(obj as XmlElement) As FTObject
		  
		  Dim fto as FTObject
		  
		  ' Create the display object.
		  select case obj.Name
		    
		  case else
		    break //Not handling any custom objects in this demo.
		    
		  end select
		  
		  ' Return the new display object.
		  return fto
		  
		End Function
	#tag EndEvent
	#tag Event
		Function ConstructContextualMenu(base as MenuItem, x as integer, y as integer) As boolean
		  
		  #pragma Unused x
		  #pragma Unused y
		  
		  Dim mi as MenuItem
		  
		  mi = new MenuItem
		  mi.text = "Check Spelling"
		  base.Append(mi)
		  
		  mi = new MenuItem
		  mi.text = "Adjust Paragraph..."
		  base.Append(mi)
		  
		  mi = new MenuItem
		  mi.text = MenuItem.TextSeparator
		  base.Append(mi)
		  
		  mi = new MenuItem
		  mi.text = "Refresh"
		  base.Append(mi)
		  
		  ' Show the menu.
		  return true
		  
		End Function
	#tag EndEvent
	#tag Event
		Function ContextualMenuAction(hitItem as MenuItem) As boolean
		  
		  select case hitItem.Text
		    
		  case "Check Spelling"
		    
		    ' Begin a spell check.
		    me.checkSpelling
		    
		  case "Adjust Paragraph..."
		    
		    ' Adjust the paragraph.
		    adjustParagraph
		    
		  case "Refresh"
		    
		    ' Do a complete update of the display.
		    me.updateFull
		    
		  end select
		  
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
