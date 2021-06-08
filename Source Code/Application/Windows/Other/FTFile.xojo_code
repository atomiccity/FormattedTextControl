#tag Class
Protected Class FTFile
Inherits FTCustom
	#tag Event
		Function ConstructContextualMenu(base as MenuItem, x as integer, y as integer) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma DisableAutoWaitCursor
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  #Pragma Unused x
		  #Pragma Unused y
		  
		  base.append(new MenuItem("Show File")) 'Adds an item to the menu.
		  base.append(new MenuItem("Launch File")) 'Adds an item to the menu.
		  
		  return true
		  
		End Function
	#tag EndEvent

	#tag Event
		Function ContextualMenuAction(hitItem as MenuItem) As boolean
		  select case hitItem.Text
		  case "Show File"
		    ShowFile
		    return true
		  case "Launch File"
		    
		    LaunchFile
		    return true
		  case else
		    //Do Nothing
		  end
		  
		  
		End Function
	#tag EndEvent

	#tag Event
		Function GotFocus() As integer
		  
		  #if not DebugBuild
		    
		    #pragma DisableAutoWaitCursor
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  ' Set the finger pointer.
		  setCursor(System.Cursors.FingerPointer)
		  
		  ' We are in the control.
		  inControl = true
		  
		  ' No idle events.
		  return 0
		  
		End Function
	#tag EndEvent

	#tag Event
		Sub MouseDown(x as integer, y as integer)
		  
		  #if not DebugBuild
		    
		    #pragma DisableAutoWaitCursor
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  dim currentClickTicks as integer
		  currentClickTicks = ticks
		  
		  //if the two clicks happened close enough together in time
		  if (currentClickTicks - iLastClickTime) <= FTUtilities.getDoubleClickTime then
		    //if the two clicks occured close enough together in space
		    If Abs(X - iLastClickX) <= 5 And Abs(Y - iLastClickY) <= 5 then
		      LaunchFile
		    end if
		  end if
		  iLastClickTime = currentClickTicks
		  iLastClickX = x
		  iLastClickY = Y
		End Sub
	#tag EndEvent

	#tag Event
		Function MouseDrag(x as integer, y as integer) As boolean
		  if keyboard.AsyncOptionKey = false then return true
		  
		  dim f as FolderItem
		  
		  f = GetFolderItem(sPath)
		  
		  if f = nil or f.exists = false then return True
		  
		  'dim d as dragItem
		  dim iX, iY, OffsetX, OffsetY, iPage as integer
		  
		  me.getLastDrawnCoordinates iPage, iX, iY
		  OffSetX = me.parentControl.Left + iX + x + me.parentControl.Window.left
		  OffsetY = me.parentControl.Top + iY + y + me.parentControl.Window.top
		  
		  dim iWidth, iHeight as double
		  iWidth = me.getWidth(me.parentControl.getScale)
		  iHeight = me.getHeight(me.parentControl.getScale)
		  
		  dim p as new picture(iwidth, iHeight, 32)
		  dim g as graphics = p.graphics
		  g.ForeColor = &cFFFFFF
		  g.FillRect 0, 0, g.width, g.Height
		  g.ForeColor = &c000000
		  g.DrawRect 0, 0, g.Width, g.Height
		  
		  dim d as new DragItem(me.parentControl.Window, ix , iy, iWidth, iHeight, p)
		  
		  
		  d.FolderItem = f
		  d.drag
		  
		  Return true
		  
		End Function
	#tag EndEvent

	#tag Event
		Sub MouseEnter()
		  
		  #if not DebugBuild
		    
		    #pragma DisableAutoWaitCursor
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  ' We are in the control.
		  inControl = true
		  
		  setCursor(system.Cursors.FingerPointer)
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseExit()
		  
		  #if not DebugBuild
		    
		    #pragma DisableAutoWaitCursor
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  ' We are not in the control.
		  inControl = false
		  
		  setCursor(system.Cursors.StandardPointer)
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub MouseUp(x as integer, y as integer)
		  
		  #if not DebugBuild
		    
		    #pragma DisableAutoWaitCursor
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  #Pragma Unused x
		  #Pragma Unused y
		  
		  ' Update the contents.
		  updateContents
		  
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub OpenXML(node as XmlElement)
		  
		  #if not DebugBuild
		    
		    #pragma DisableAutoWaitCursor
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  ' Restore the data.
		  decodeData(node.GetAttribute("BKFile"))
		  
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub Paint(g as Graphics, print as boolean, printScale as double)
		  
		  #if not DebugBuild
		    
		    #pragma DisableAutoWaitCursor
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  #Pragma Unused print
		  #Pragma Unused printScale
		  
		  ' Recreate the graph.
		  DrawObject(g)
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resize(g as Graphics)
		  
		  #if not DebugBuild
		    
		    #pragma DisableAutoWaitCursor
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  ' Recreate the graph.
		  drawObject(g)
		  
		  ' Update the graph.
		  'return true
		  
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub Resized(g as Graphics)
		  
		  #if not DebugBuild
		    
		    #pragma DisableAutoWaitCursor
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  ' Recreate the graph.
		  drawObject(g)
		  
		  
		End Sub
	#tag EndEvent

	#tag Event
		Function SaveXML(xmlDoc as XmlDocument) As XmlElement
		  
		  #if not DebugBuild
		    
		    #pragma DisableAutoWaitCursor
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  Dim node as XmlElement
		  
		  ' Create the graph node.
		  node = xmlDoc.CreateElement("FTFile")
		  
		  ' Get the data.
		  node.SetAttribute("BKFile", encodeData)
		  
		  ' Return the node.
		  return node
		  
		  
		End Function
	#tag EndEvent


	#tag Method, Flags = &h0
		Function callMouseDrag(x as integer, y as integer) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  #pragma Unused x
		  #pragma Unused y
		  
		  Return false
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Clone() As FTFile
		  //Note:  Having the clone is very important.  Otherwise FTIterator or antying else
		  //that Clones paragraph objects will intrinsicly convert this to FTPicture
		  
		  #If Not DebugBuild
		    
		    #Pragma BoundsChecking FTC_BOUNDSCHECKING
		    #Pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #Pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #EndIf
		  
		  Dim oClone As FTFile
		  
		  dim f as folderitem = GetFolderItem(sPath, folderitem.PathTypeNative)
		  
		  ' Create the clone.
		  oClone = New FTFile(parentControl, f)
		  
		  oClone.sName = sName
		  oClone.sPath = sPath
		  
		  ' Return the clone.
		  Return oClone
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(parentControl as FormattedText, f as folderitem)
		  
		  #if not DebugBuild
		    
		    #pragma DisableAutoWaitCursor
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #EndIf
		  
		  
		  ' Modify the baseline Of the special object 10 pixels down.
		  setNudge(10)
		  
		  ' Generate the test data.
		  generateData f
		  
		  Dim g As graphics
		  Dim iWidth As Integer
		  
		  If p = Nil Then
		    iwidth = 200
		  Else
		    g = p.Graphics
		    
		    If g = Nil Then
		      iWidth = 200
		    Else
		      
		      g.ForeColor = &c0000FF
		      g.TextFont = "Courier"
		      If parentControl.IsHiDPT Then
		        g.TextSize = 28
		      Else
		        g.TextSize = 14 
		      End
		      g.Bold = False
		      g.Italic = False
		      g.Underline = True
		      iWidth = g.stringwidth(sName) + 32
		    End
		  End
		  
		  If p = Nil Then
		    ' Save the parent Control.
		    Super.Constructor(parentControl, iWidth, 32, True)
		  Else
		    Super.Constructor(parentControl, 128, 128, True)
		  End
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub decodeData(s as string)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma DisableAutoWaitCursor
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  dim sArray() as string
		  Dim sDecode As String
		  
		  sDecode = DecodeBase64(s)
		  
		  sArray = Split(sDecode, kSplit)
		  
		  If uBound(sArray) < 2 Then 
		    break
		    Return //error
		  End
		  
		  sName = sArray(0)
		  sPath = sArray(1)
		  
		  If sArray.Ubound = 2 Then
		    Dim sData As String = sarray(2)
		    Dim mb As MemoryBlock = sData
		    If mb.size = 0 Then
		      p = Nil
		    Else
		      Try
		        p = picture.FromData(mb)
		      Catch 
		        p = Nil //Bad data perhaps.
		      End
		    End
		  End
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub DrawObject(g as graphics)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma DisableAutoWaitCursor
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  If p = Nil Then
		    g.ForeColor = RGB(176, 255, 255)
		    g.FillRect 0, 0, g.Width, g.Height
		    
		    If sName <> "" Then
		      g.ForeColor = &c0000FF
		      g.TextFont = "Courier"
		      If Me.parentControl.IsHiDPT Then
		        g.TextSize = 28
		      Else
		        g.TextSize = 14 
		      End
		      
		      g.Bold = False
		      g.Italic = False
		      g.Underline = True
		      
		      g.DrawString sName, 32, g.Height/2, g.Width - 32, True
		    End
		    
		    g.ForeColor = &ccecece
		    g.DrawRect 0, 0, g.Width, g.Height
		    
		  Else
		    g.DrawPicture p, 0, 0, g.width, g.Height, 0, 0, p.Width, p.Height
		  End
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function encodeData() As string
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma DisableAutoWaitCursor
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  dim s as string
		  s = sName + kSplit
		  s = s + sPath + kSplit
		  If p <> Nil Then
		    Dim mb As MemoryBlock = p.GetData(picture.FormatPNG)
		    Dim sData As String = mb.StringValue(0, mb.Size)
		    s = s + sData
		  End
		  s =  EncodeBase64(s,0)
		  
		  return s
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub generateData(f as folderitem)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma DisableAutoWaitCursor
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  if f = nil or f.exists = false then return
		  
		  sPath = f.NativePath
		  sName = f.DisplayName
		  
		  p = picture.open(f)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub LaunchFile()
		  dim f as FolderItem
		  
		  
		  f = GetFolderItem(sPath, folderitem.PathTypeNative)
		  if f = nil OR f.exists = false then
		    MsgBox "File Error" + endofLine + "We could not find the referenced file.  It may be in a different location now."
		    return
		  end
		  
		  f.launch
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ShowFile()
		  dim f as FolderItem
		  
		  
		  f = GetFolderItem(sPath, folderitem.PathTypeNative)
		  if f = nil OR f.exists = false then
		    MsgBox "File Error" + endofLine + "We could not find the referenced file.  It may be in a different location now."
		    return
		  end
		  
		  f.Parent.launch
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private iLastClickTime As integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private iLastClickX As integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private iLastClickY As integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private inControl As boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private p As picture
	#tag EndProperty

	#tag Property, Flags = &h21
		Private sName As string
	#tag EndProperty

	#tag Property, Flags = &h21
		Private sPath As string
	#tag EndProperty


	#tag Constant, Name = kSplit, Type = String, Dynamic = False, Default = \"%$@!#", Scope = Public
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="colorOpacity"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="hasShadow"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HyperLink"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="hyperLinkColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c0000ff"
			Type="color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="hyperLinkColorDisabled"
			Visible=false
			Group="Behavior"
			InitialValue="&cC0C0C0"
			Type="color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="hyperLinkColorRollover"
			Visible=false
			Group="Behavior"
			InitialValue="&cFF0000"
			Type="color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="hyperLinkColorVisited"
			Visible=false
			Group="Behavior"
			InitialValue="&c800080"
			Type="color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="inNewWindow"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="shadowAngle"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="shadowBlur"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="shadowColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="shadowOffset"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="shadowOpacity"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="useCustomHyperLinkColor"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="borderColor"
			Visible=false
			Group="Behavior"
			InitialValue="&h000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="markColor"
			Visible=false
			Group="Behavior"
			InitialValue="&h000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="marked"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="boolean"
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
			Name="strikeThrough"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="boolean"
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
			Name="textColor"
			Visible=false
			Group="Behavior"
			InitialValue="&h000000"
			Type="color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="underline"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
