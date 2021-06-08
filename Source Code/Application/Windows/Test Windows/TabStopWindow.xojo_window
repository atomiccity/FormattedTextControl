#tag Window
Begin Window TabStopWindow
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   False
   Composite       =   False
   Frame           =   1
   FullScreen      =   False
   FullScreenButton=   False
   HasBackColor    =   False
   Height          =   356
   ImplicitInstance=   False
   LiveResize      =   "True"
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   False
   MaxWidth        =   32000
   MenuBar         =   0
   MenuBarVisible  =   True
   MinHeight       =   64
   MinimizeButton  =   False
   MinWidth        =   64
   Placement       =   1
   Resizeable      =   False
   Title           =   "Tabs"
   Visible         =   True
   Width           =   310
   Begin Separator Separator1
      AutoDeactivate  =   True
      Enabled         =   True
      Height          =   4
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   False
      Scope           =   2
      TabIndex        =   8
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   300
      Transparent     =   False
      Visible         =   True
      Width           =   270
   End
   Begin PushButton btnCancel
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   0
      Cancel          =   False
      Caption         =   "Cancel"
      Default         =   False
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   121
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      Scope           =   2
      TabIndex        =   9
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   316
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin PushButton btnOK
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   0
      Cancel          =   False
      Caption         =   "OK"
      Default         =   True
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   210
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      Scope           =   2
      TabIndex        =   10
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   316
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin PushButton btnClearAll
      AutoDeactivate  =   True
      Bold            =   False
      ButtonStyle     =   0
      Cancel          =   False
      Caption         =   "Clear All"
      Default         =   False
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
      Scope           =   2
      TabIndex        =   18
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   316
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   80
   End
   Begin TextField txtDefault
      AcceptTabs      =   False
      Alignment       =   0
      AutoDeactivate  =   True
      AutomaticallyCheckSpelling=   False
      BackColor       =   &cFFFFFF00
      Bold            =   False
      Border          =   True
      CueText         =   "0.00"
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Format          =   ""
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   114
      LimitText       =   0
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Mask            =   ""
      Password        =   False
      ReadOnly        =   False
      Scope           =   2
      TabIndex        =   26
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   21
      Transparent     =   False
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   77
   End
   Begin Label DefaultLabel
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
      Scope           =   2
      Selectable      =   False
      TabIndex        =   27
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Default Stops:"
      TextAlign       =   0
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   20
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   92
   End
   BeginSegmented SegmentedControl EditSegmented
      Enabled         =   True
      Height          =   24
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      MacControlStyle =   6
      Scope           =   2
      Segments        =   "+\n\nFalse\r-\n\nFalse"
      SelectionType   =   2
      TabIndex        =   28
      TabPanelIndex   =   0
      TabStop         =   "True"
      Top             =   264
      Transparent     =   False
      Visible         =   True
      Width           =   48
   End
   Begin Listbox TabsList
      AutoDeactivate  =   True
      AutoHideScrollbars=   True
      Bold            =   False
      Border          =   True
      ColumnCount     =   3
      ColumnsResizable=   True
      ColumnWidths    =   ""
      DataField       =   ""
      DataSource      =   ""
      DefaultRowHeight=   -1
      Enabled         =   True
      EnableDrag      =   False
      EnableDragReorder=   True
      GridLinesHorizontal=   0
      GridLinesVertical=   0
      HasHeading      =   True
      HeadingIndex    =   -1
      Height          =   199
      HelpTag         =   ""
      Hierarchical    =   False
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   "Stops	Alignment	Leader"
      Italic          =   False
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      RequiresSelection=   False
      Scope           =   2
      ScrollbarHorizontal=   False
      ScrollBarVertical=   True
      SelectionType   =   0
      ShowDropIndicator=   False
      TabIndex        =   29
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   55
      Transparent     =   False
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   270
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
End
#tag EndWindow

#tag WindowCode
	#tag Method, Flags = &h0
		Sub Constructor(Paragraph as FTParagraph)
		  // Calling the overridden superclass constructor.
		  Super.Constructor
		  
		  ' Get current Paragraph
		  oParagraph = Paragraph
		  
		  ' Get tabs of current Paragraph
		  Tabs = oParagraph.getTabStops
		  
		  ' Get all Tabs in TabsList
		  FillTabsList
		  
		  ' Enable the Add button
		  AddButton.Enabled = True
		  
		  //Display Modally
		  Self.ShowModal
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub FillTabsList()
		  ' Clear TabsList
		  TabsList.DeleteAllRows
		  
		  ' Get count of tabs
		  Dim count As Integer = Tabs.Ubound
		  
		  ' Add custom tabs to TabsList
		  For i As Integer = 0 To count
		    
		    ' Add only custom Tabs
		    If Tabs(i).default = False Then
		      
		      ' Add current FTTabStop
		      Dim sName As String = FTTab.GetTabLeaderExample(tabs(i).GetTabLeader)
		      TabsList.AddRow Format(Tabs(i).getTabStop, "0.00\ \i\n"), "Left", sName
		      TabsList.RowTag(TabsList.LastIndex) = Tabs(i)
		      
		    End If
		    
		  Next
		  
		  If TabsList.ListCount > 0 Then
		    txtDefault.Text = ""
		    txtDefault.Enabled = False
		    DefaultLabel.Enabled = False
		  Else
		    txtDefault.Enabled = True
		    DefaultLabel.Enabled = True
		    txtDefault.Text = Format(Tabs(0).getTabStop, "0.00\ \i\n")
		  End
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Validate() As boolean
		  //Check to see if the tabs are in order.
		  Dim dLastValue As Integer = -1
		  For i As Integer = 0 To TabsList.ListCount-1
		    Dim dValue As Double = TabsList.cell(i, 0).Val
		    
		    If dValue < dLastValue Then
		      Msgbox "Validation Error" + endofline + "The tab stops are not in order."
		      Return False
		    End
		    
		    dLastValue = dValue
		  Next
		  
		  Return True
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private AddButton As SegmentedControlItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private DeleteButton As SegmentedControlItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private oParagraph As FTParagraph
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Tabs() As FTTabStop
	#tag EndProperty


#tag EndWindowCode

#tag Events btnCancel
	#tag Event
		Sub Action()
		  Close
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events btnOK
	#tag Event
		Sub Action()
		  If Validate = False Then Return
		  
		  
		  //Clear the Tabstops from the paragraph
		  oParagraph.clearTabStops
		  
		  If TabsList.ListCount = 0 Then
		    
		    ' Set the Default Tab Stops for the paragraph
		    oParagraph.SetDefaultTabStops(txtDefault.Text.Val)
		    
		  Else
		    
		    ' Create area of our new Tab Stops
		    Dim aroTabstops() As FTTabStop
		    For i As Integer = 0 To TabsList.ListCount-1
		      
		      Dim tabType As FTTabStop.TabStopType
		      Dim dValue As Double
		      Dim tabLead As FTTab.Tab_Leader_Type
		      
		      tabType = FTTabStop.TabStopType.Left
		      dValue = TabsList.cell(i, 0).Val
		      tabLead = FTTab.GetTabLeaderFromText(TabsList.cell(i, 2))
		      
		      
		      Dim ts As New FTTabStop(oParagraph.parentControl, tabType, dValue, False, tabLead)
		      
		      aroTabstops.Append ts
		    Next
		    
		    
		    oParagraph.SetTabStops(aroTabstops)
		    
		  End
		  
		  //close the dialog
		  Self.Close
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events btnClearAll
	#tag Event
		Sub Action()
		  TabsList.DeleteAllRows
		  
		  txtDefault.Enabled = True
		  DefaultLabel.Enabled = True
		  txtDefault.Text = Format(Tabs(0).getTabStop, "0.00\ \i\n")
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events txtDefault
	#tag Event
		Sub LostFocus()
		  me.text = Format(me.text.val, "0.00\ \i\n")
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events EditSegmented
	#tag Event
		Sub Open()
		  ' Initialize Add Button
		  AddButton = Me.Items(0)
		  AddButton.Enabled = False
		  
		  ' Initialize Delete Button
		  DeleteButton = Me.Items(1)
		  DeleteButton.Enabled = False
		End Sub
	#tag EndEvent
	#tag Event
		Sub Action(itemIndex as integer)
		  Select Case itemIndex
		  Case 0
		    
		    ' Add Button
		    
		    ' Get the last value in the listbox
		    Dim d As Double
		    If TabsList.ListCount > 0 Then
		      d = TabsList.cell(TabsList.ListCount-1, 0).Val
		    End
		    
		    d = d + txtDefault.Text.Val
		    
		    //GetWrapWidth is in pixels
		    Dim dTest As Double = oParagraph.getWrapWidth/72
		    If d > dTest Then
		      d = dTest
		    End
		    
		    TabsList.AddRow format(d, "0.00\ \i\n"), "Left", "None"
		    
		    
		  Case 1
		    
		    ' Delete Button
		    TabsList.RemoveRow(TabsList.ListIndex)
		    
		    
		  End Select
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events TabsList
	#tag Event
		Sub Change()
		  ' Enable delete button if there is a selection
		  DeleteButton.Enabled = Me.ListIndex <> - 1
		  
		  
		End Sub
	#tag EndEvent
	#tag Event
		Function CellBackgroundPaint(g As Graphics, row As Integer, column As Integer) As Boolean
		  If Me.selected(row) = False Then
		    If row Mod 2 = 0 Then
		      g.ForeColor = &cE6E6E600
		      g.FillRect 0, 0, g.Width, g.Height
		    End
		  End
		  
		  If column > 1 And row < Me.ListCount Then
		    //Draw the triangle on the right side of the cell
		    Me.DrawTriangle(g, Me.Selected(row))
		  End
		End Function
	#tag EndEvent
	#tag Event
		Sub MouseUp(x As Integer, y As Integer)
		  // Display menu if clicked in PopupMenu column
		  Dim row As Integer = Me.RowFromXY(x, y)
		  Dim col As Integer = Me.ColumnFromXY(x, y)
		  If row > Me.listcount Or col <> 2 Then  Return
		  
		  
		  Me.ListIndex = row
		  Me.Selected(row) = True
		  
		  dim oTypeMenu as new MenuItem
		  oTypeMenu.AddItemAndTag(FTTab.GetTabLeaderExample(FTTab.Tab_Leader_Type.None), FTTab.GetTabLeaderExample(FTTab.Tab_Leader_Type.None))
		  oTypeMenu.AddItemAndTag(FTTab.GetTabLeaderExample(FTTab.Tab_Leader_Type.Dot), FTTab.Tab_Leader_Type.Dot)
		  oTypeMenu.AddItemAndTag(FTTab.GetTabLeaderExample(FTTab.Tab_Leader_Type.Hypen), FTTab.Tab_Leader_Type.Hypen)
		  oTypeMenu.AddItemAndTag(FTTab.GetTabLeaderExample(FTTab.Tab_Leader_Type.MiddleDot), FTTab.Tab_Leader_Type.MiddleDot)
		  oTypeMenu.AddItemAndTag(FTTab.GetTabLeaderExample(FTTab.Tab_Leader_Type.Underscore), FTTab.Tab_Leader_Type.Underscore)
		  
		  
		  Dim mnuTypeSelection As MenuItem = oTypeMenu.PopUp
		  
		  // Selected nothing
		  if mnuTypeSelection = nil then return
		  
		  Me.cell(row, col) = mnuTypeSelection.Text
		  me.celltag(row, col) = mnuTypeSelection.tag
		  
		  Self.TrueWindow.ContentsChanged = True
		End Sub
	#tag EndEvent
	#tag Event
		Function MouseDown(x As Integer, y As Integer) As Boolean
		  If Me.ColumnFromXY(x, y) = 2 Then
		    Return True
		  End If
		End Function
	#tag EndEvent
	#tag Event
		Sub Open()
		  me.ColumnType(0) = listbox.TypeEditableTextField
		End Sub
	#tag EndEvent
	#tag Event
		Sub CellLostFocus(row as Integer, column as Integer)
		  Dim d As Double
		  
		  d = Me.cell(row, column).val
		  
		  //GetWrapWidth is in pixels
		  Dim dTest As Double = oParagraph.getWrapWidth/72
		  If d > dTest Then
		    d = dTest
		  End
		  
		  me.cell(row, column) = format(d, "0.00\ \i\n")
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
		Name="Name"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
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
		Name="Super"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="600"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="400"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Title"
		Visible=true
		Group="Frame"
		InitialValue="Untitled"
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Resizeable"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Composite"
		Visible=false
		Group="OS X (Carbon)"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MacProcID"
		Visible=false
		Group="OS X (Carbon)"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="ImplicitInstance"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="FullScreen"
		Visible=false
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Backdrop"
		Visible=true
		Group="Background"
		InitialValue=""
		Type="Picture"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBar"
		Visible=true
		Group="Menus"
		InitialValue=""
		Type="MenuBar"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBarVisible"
		Visible=true
		Group="Deprecated"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
