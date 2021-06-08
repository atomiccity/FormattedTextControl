#tag Window
Begin Window FTAutoCompleteWindow
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   False
   Composite       =   False
   Frame           =   3
   FullScreen      =   False
   FullScreenButton=   False
   HasBackColor    =   False
   Height          =   250
   ImplicitInstance=   False
   LiveResize      =   "False"
   MacProcID       =   1040
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
   Title           =   ""
   Visible         =   True
   Width           =   150
   Begin Listbox lbOption
      AutoDeactivate  =   True
      AutoHideScrollbars=   True
      Bold            =   False
      Border          =   True
      ColumnCount     =   1
      ColumnsResizable=   False
      ColumnWidths    =   ""
      DataField       =   ""
      DataSource      =   ""
      DefaultRowHeight=   -1
      Enabled         =   True
      EnableDrag      =   False
      EnableDragReorder=   False
      GridLinesHorizontal=   0
      GridLinesVertical=   0
      HasHeading      =   False
      HeadingIndex    =   -1
      Height          =   250
      HelpTag         =   ""
      Hierarchical    =   False
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   ""
      Italic          =   False
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      RequiresSelection=   True
      Scope           =   0
      ScrollbarHorizontal=   False
      ScrollBarVertical=   True
      SelectionType   =   0
      ShowDropIndicator=   False
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   0
      Transparent     =   False
      Underline       =   False
      UseFocusRing    =   False
      Visible         =   True
      Width           =   150
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Function KeyDown(Key As String) As Boolean
		  select case Asc(Key)
		  case 30 'up arrow
		    lbOption.ListIndex = Max(0, lbOption.ListIndex-1)
		  case 31 'down arrow
		    lbOption.ListIndex = Min(lbOption.ListCount-1, lbOption.ListIndex+1)
		  case 13, 9 'completion keys
		    dim s as string
		    s = lbOption.Cell(lbOption.ListIndex, 0)
		    m_ftc.hideAutoComplete
		    if m_sPrefix.Len<s.Len then
		      s = s.Mid(m_sPrefix.Len+1)
		      m_ftc.insertText(s)
		    end if
		  case 27 'esc
		    m_ftc.hideAutoComplete
		  case else
		    if m_ftc.callKeyDown(Key) then
		      updateAutoComplete
		      return true
		    end if
		    return false
		  end select
		End Function
	#tag EndEvent

	#tag Event
		Sub Open()
		  #If TargetWindows
		    Const WS_BORDER = &H800000
		    Const WS_CAPTION = &h00C00000
		    
		    ChangeWindowStyle(self, WS_BORDER, false)
		    ChangeWindowStyle(self, WS_CAPTION, false)
		    
		    Const WS_EX_TOOLWINDOW = &h00000080
		    ChangeWindowStyleEx(self, WS_EX_TOOLWINDOW, true)
		    
		    MakeTopmost
		  #endif
		  lbOption.SetFocus
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub ChangeWindowStyle(win as Window, flag as Integer, set as Boolean)
		  #If TargetWindows
		    #If TargetWin32
		      Dim oldFlags As Integer
		      Dim newFlags As Integer
		      Dim styleFlags As Integer
		      
		      Const SWP_NOSIZE = &H1
		      Const SWP_NOMOVE = &H2
		      Const SWP_NOZORDER = &H4
		      Const SWP_FRAMECHANGED = &H20
		      
		      Const GWL_STYLE = -16
		      
		      Declare Function GetWindowLong Lib "user32" Alias "GetWindowLongA" (hwnd As Integer, nIndex As Integer) As Integer
		      Declare Function SetWindowLong Lib "user32" Alias "SetWindowLongA" (hwnd As Integer, nIndex As Integer, dwNewLong As Integer) As Integer
		      Declare Function SetWindowPos Lib "user32" (hwnd As Integer, hWndInstertAfter As Integer, x As Integer, y As Integer, cx As Integer, cy As Integer, flags As Integer) As Integer
		      
		      oldFlags = GetWindowLong( win.Handle, GWL_STYLE )
		      
		      If Not set Then
		        newFlags = BitwiseAnd( oldFlags, Bitwise.OnesComplement( flag ) )
		      Else
		        newFlags = BitwiseOr( oldFlags, flag )
		      End
		      
		      
		      styleFlags = SetWindowLong( win.Handle, GWL_STYLE, newFlags )
		      styleFlags = SetWindowPos( win.Handle, 0, 0, 0, 0, 0, SWP_NOMOVE + SWP_NOSIZE + SWP_NOZORDER + SWP_FRAMECHANGED )
		      
		    #Else
		      //64 Bit
		      Dim oldFlags As Integer
		      Dim newFlags As Integer
		      Dim styleFlags As Integer
		      
		      Const SWP_NOSIZE = &H1
		      Const SWP_NOMOVE = &H2
		      Const SWP_NOZORDER = &H4
		      Const SWP_FRAMECHANGED = &H20
		      
		      Const GWL_STYLE = -16
		      
		      Declare Function GetWindowLongPtr Lib "User32.dll" Alias "GetWindowLongPtrW" (hwnd As Integer, nIndex As Integer ) As Integer
		      Declare Function SetWindowLongPtr Lib "User32.dll" Alias "SetWindowLongPtrW" (hWnd As Integer, nIndex As Integer, dwNewLong As Integer) As Integer
		      Declare Function SetWindowPos Lib "user32" (hwnd As Integer, hWndInstertAfter As Integer, x As Integer, y As Integer, cx As Integer, cy As Integer, flags As Integer) As Integer
		      
		      oldFlags = GetWindowLongPtr( win.Handle, GWL_STYLE )
		      
		      If Not set Then
		        newFlags = BitwiseAnd( oldFlags, Bitwise.OnesComplement( flag ) )
		      Else
		        newFlags = BitwiseOr( oldFlags, flag )
		      End
		      
		      styleFlags = SetWindowLongPtr( win.Handle, GWL_STYLE, newFlags )
		      styleFlags = SetWindowPos( win.Handle, 0, 0, 0, 0, 0, SWP_NOMOVE + SWP_NOSIZE + SWP_NOZORDER + SWP_FRAMECHANGED )
		    #EndIf
		  #Else
		    #Pragma Unused win
		    #Pragma Unused flag
		    #Pragma Unused set
		  #EndIf
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ChangeWindowStyleEx(w as Window, flag as Integer, set as Boolean)
		  #If targetWindows 
		    #If TargetWin32
		      Dim oldFlags As Integer
		      Dim newFlags As Integer
		      Dim styleFlags As Integer
		      
		      Const SWP_NOSIZE = &H1
		      Const SWP_NOMOVE = &H2
		      Const SWP_NOZORDER = &H4
		      Const SWP_FRAMECHANGED = &H20
		      
		      Const GWL_EXSTYLE = -20
		      
		      Declare Function GetWindowLong Lib "user32" Alias "GetWindowLongA" (hwnd As Integer, nIndex As Integer) As Integer
		      Declare Function SetWindowLong Lib "user32" Alias "SetWindowLongA" (hwnd As Integer, nIndex As Integer, dwNewLong As Integer) As Integer
		      Declare Function SetWindowPos Lib "user32" (hwnd As Integer, hWndInstertAfter As Integer, x As Integer, y As Integer, cx As Integer, cy As Integer, flags As Integer) As Integer
		      
		      oldFlags = GetWindowLong(w.WinHWND, GWL_EXSTYLE)
		      
		      If Not set Then
		        newFlags = BitwiseAnd( oldFlags, Bitwise.OnesComplement( flag ) )
		      Else
		        newFlags = BitwiseOr( oldFlags, flag )
		      End
		      
		      
		      styleFlags = SetWindowLong( w.WinHWND, GWL_EXSTYLE, newFlags )
		      styleFlags = SetWindowPos( w.WinHWND, 0, 0, 0, 0, 0, SWP_NOMOVE + SWP_NOSIZE + SWP_NOZORDER + SWP_FRAMECHANGED )
		      
		    #Else 
		      Dim oldFlags As Integer
		      Dim newFlags As Integer
		      Dim styleFlags As Integer
		      
		      Const SWP_NOSIZE = &H1
		      Const SWP_NOMOVE = &H2
		      Const SWP_NOZORDER = &H4
		      Const SWP_FRAMECHANGED = &H20
		      
		      Const GWL_EXSTYLE = -20
		      
		      Declare Function GetWindowLongPtr Lib "User32.dll" Alias "GetWindowLongPtrW" (hwnd As Integer, nIndex As Integer ) As Integer
		      Declare Function SetWindowLongPtr Lib "User32.dll" Alias "SetWindowLongPtrW" (hWnd As Integer, nIndex As Integer, dwNewLong As Integer) As Integer
		      Declare Function SetWindowPos Lib "user32" (hwnd As Integer, hWndInstertAfter As Integer, x As Integer, y As Integer, cx As Integer, cy As Integer, flags As Integer) As Integer
		      
		      oldFlags = GetWindowLongPtr( w.Handle, GWL_EXSTYLE )
		      
		      If Not set Then
		        newFlags = BitwiseAnd( oldFlags, Bitwise.OnesComplement( flag ) )
		      Else
		        newFlags = BitwiseOr( oldFlags, flag )
		      End
		      
		      styleFlags = SetWindowLongPtr( w.WinHWND, GWL_EXSTYLE, newFlags )
		      styleFlags = SetWindowPos( w.WinHWND, 0, 0, 0, 0, 0, SWP_NOMOVE + SWP_NOSIZE + SWP_NOZORDER + SWP_FRAMECHANGED )
		      
		    #EndIf
		  #Else
		    #Pragma Unused w
		    #Pragma Unused flag
		    #Pragma Unused set
		  #EndIf
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1000
		Sub Constructor(ftc as FormattedText)
		  m_ftc = ftc
		  Super.Constructor
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Display(sPrefix as string, arsOption() as string)
		  #If TargetWindows
		    #Pragma DisableBackgroundTasks
		    FreezeUpdate(lbOption)
		    lbOption.ScrollPosition = 0
		    lbOption.ScrollBarVertical = False
		  #Else
		    lbOption.Visible = False
		  #EndIf
		  
		  lbOption.DeleteAllRows
		  For Each s As String In arsOption
		    lbOption.AddRow(s)
		  Next
		  
		  #If TargetWindows
		    lbOption.ScrollBarVertical = True
		    UnfreezeUpdate(lbOption)
		    lbOption.Invalidate(False)
		  #Else
		    lbOption.Visible = True
		    lbOption.SetFocus
		  #EndIf
		  
		  lbOption.ListIndex = 0
		  m_sPrefix = sPrefix
		  
		  Height = Min(lbOption.RowHeight*lbOption.ListCount+4, m_ftc.Height)
		  
		  Dim iMaxWidth As Integer
		  Dim pict As New Picture(1,1,32)
		  Dim g As Graphics = pict.Graphics
		  g.TextSize = 0
		  g.TextFont = "System"
		  
		  Dim iMax As Integer = Min(arsOption.Ubound, 99)
		  For i As Integer = 0 To iMax
		    Dim iWidth As Integer = Ceil(g.StringWidth(arsOption(i)))
		    iMaxWidth = Max(iWidth, iMaxWidth)
		  Next
		  If iMaxWidth<150 Then
		    iMaxWidth = 150
		  Elseif iMaxWidth>300 Then
		    iMaxWidth = 300
		  End If
		  self.Width = iMaxWidth
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub FreezeUpdate(w as RectControl)
		  #If TargetWindows
		    // We use the WM_SETREDRAW message to lock the redraw
		    // state of the window (note that this can be used for controls as well)
		    Const WM_SETREDRAW = &hB
		    Call SendMessage( w.Handle, WM_SETREDRAW, 0, 0 )
		  #Else
		    #Pragma Unused w
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub MakeTopmost()
		  #If TargetWindows
		    // Make sure it shows up as topmost
		    Declare Sub SetWindowPos Lib "User32" ( hwnd As Integer, after As Integer, x As Integer, y As Integer, width As Integer, height As Integer, flags As Integer )
		    
		    Const HWND_TOPMOST = -1
		    Const SWP_NOSIZE = &h1
		    Const SWP_NOMOVE = &h2
		    Const SWP_NOACTIVATE = &h10
		    
		    SetWindowPos( Self.Handle, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOSIZE + SWP_NOMOVE + SWP_NOACTIVATE )
		    
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function SendMessage(hwnd as Integer, msg as Integer, wParam as Integer, lParam as Integer) As Integer
		  #If TargetWindows
		    Soft Declare Function SendMessageA Lib "User32" ( hwnd As Integer, msg As Integer, wParam As Integer, lParam As Integer ) As Integer
		    Soft Declare Function SendMessageW Lib "User32" ( hwnd As Integer, msg As Integer, wParam As Integer, lParam As Integer ) As Integer
		    
		    If System.IsFunctionAvailable( "SendMessageW", "User32" ) Then
		      Return SendMessageW( hwnd, msg, wParam, lParam )
		    Else
		      Return SendMessageA( hwnd, msg, wParam, lParam )
		    End If
		  #Else
		    #Pragma Unused hwnd
		    #Pragma Unused msg
		    #Pragma Unused wParam
		    #Pragma Unused lParam
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub UnfreezeUpdate(w as RectControl)
		  #If TargetWindows
		    // We use the WM_SETREDRAW message to unlock the redraw
		    // state of the window (note that this can be used for controls as well)
		    Const WM_SETREDRAW = &hB
		    Call SendMessage( w.Handle, WM_SETREDRAW, 1, 0 )
		  #Else
		    #Pragma Unused w
		  #Endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub updateAutoComplete()
		  Dim sPrefix As String
		  dim arsOption() as string
		  m_ftc.getAutoCompleteOptions(sPrefix, arsOption)
		  if arsOption.Ubound<0 then
		    m_ftc.hideAutoComplete
		  else
		    Display(sPrefix, arsOption)
		  end if
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private m_ftc As FormattedText
	#tag EndProperty

	#tag Property, Flags = &h21
		Private m_sPrefix As string
	#tag EndProperty


#tag EndWindowCode

#tag Events lbOption
	#tag Event
		Sub LostFocus()
		  if me.Visible then
		    m_ftc.hideAutoComplete
		  end if
		End Sub
	#tag EndEvent
	#tag Event
		Function MouseDown(x As Integer, y As Integer) As Boolean
		  #pragma unused x
		  #pragma unused y
		  
		  return true
		End Function
	#tag EndEvent
	#tag Event
		Sub MouseUp(x As Integer, y As Integer)
		  dim row as integer = me.RowFromXY(x,y)
		  if row<0 or row>=me.ListCount then
		    return
		  end if
		  
		  dim s as string
		  s = lbOption.Cell(row, 0)
		  
		  m_ftc.hideAutoComplete
		  if m_sPrefix.Len<s.Len then
		    s = s.Mid(m_sPrefix.Len+1)
		    m_ftc.insertText(s)
		  end if
		End Sub
	#tag EndEvent
	#tag Event
		Function KeyDown(Key As String) As Boolean
		  if Key=Chr(9) then
		    dim s as string
		    s = lbOption.Cell(lbOption.ListIndex, 0)
		    m_ftc.hideAutoComplete
		    if m_sPrefix.Len<s.Len then
		      s = s.Mid(m_sPrefix.Len+1)
		      m_ftc.insertText(s)
		    end if
		    return true
		  end if
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
		Visible=false
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
		Visible=false
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
