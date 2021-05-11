#tag Class
Protected Class FTTab
Inherits FTObject
	#tag Event
		Function Ascent(scale as double) As double
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the tab ascent.
		  return FTUtilities.getStringAscent(parentControl.DefaultFont, _
		  parentControl.DefaultFontSize, scale)
		  
		End Function
	#tag EndEvent

	#tag Event
		Function Height(scale as double) As double
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the tab height.
		  return FTUtilities.getStringHeight(parentControl.DefaultFont, _
		  parentControl.DefaultFontSize, scale)
		  
		End Function
	#tag EndEvent

	#tag Event
		Sub PaintBackground(g as graphics, x as integer, y as integer, leftPoint as integer, rightPoint as integer, lineTop as double, lineHeight as double, printing as boolean, printScale as double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  #pragma Unused y
		  
		  Dim lineWidth as integer
		  Dim currentWidth as double
		  
		  ' Compute the current width.
		  currentWidth = x - leftPoint - 1
		  
		  ' Is the item selected?
		  if isSelected then
		    
		    ' Scale the width for printing.
		    lineWidth = getWidth(getObjectScale(printing, printScale), currentWidth)
		    
		    ' Get the color.
		    g.ForeColor = getObjectColor
		    
		    ' Save the dimensions.
		    saveSelectDimensions(x, lineTop, lineWidth, lineHeight)
		    
		    ' Should we paint a background color?
		  elseif useBackgroundColor then
		    
		    ' Scale the width for printing.
		    lineWidth = getWidth(getObjectScale(printing, printScale), currentWidth)
		    
		    ' Use the background color.
		    g.ForeColor = getBackgroundColor
		    
		  else
		    
		    ' Nothing to do.
		    return
		    
		  end if
		  
		  ' Are we past the wrap point?
		  if (x + lineWidth) > rightPoint then
		    
		    ' Cut it back.
		    lineWidth = rightPoint - x
		    
		  end if
		  
		  ' Draw the background color.
		  g.FillRect(x, lineTop, lineWidth, lineHeight)
		  
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub PaintForeground(g as graphics, x as integer, y as integer, leftPoint as integer, rightPoint as integer, beforeSpace as double, afterSpace as double, printing as boolean, printScale as double)
		  
		  #If Not DebugBuild
		    
		    #Pragma BoundsChecking FTC_BOUNDSCHECKING
		    #Pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #Pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #EndIf
		  
		  #Pragma Unused leftPoint
		  #Pragma Unused rightPoint
		  #Pragma Unused beforeSpace
		  #Pragma Unused afterSpace
		  
		  Dim drawWidth As Integer
		  
		  ' Are we printing?
		  If printing Then
		    
		    ' Scale for printing.
		    drawWidth = tabPosition * printScale
		    
		  Else
		    
		    ' Use the current width.
		    drawWidth = tabPosition
		    
		  End If
		  
		  ' Draw the underline.
		  drawUnderline(0, g, drawWidth, x, y, printing, printScale)
		  
		  ' Marked indicator.
		  drawMark(g, drawWidth, x, y, printing, printScale)
		  
		  ' Draw the strike through.
		  drawStrikethrough(0, g, tabPosition, x, y, printing, printScale)
		  
		  ' Should we show the tab marker?
		  If parentControl.ShowInvisibles Then
		    
		    ' Are we printing?
		    If Not printing Then
		      
		      ' Show the tab indicator.
		      g.ForeColor = parentControl.InvisiblesColor
		      g.TextFont = "Arial"
		      g.TextSize = 10 * printScale
		      ' g.TextSize = 24 * printScale
		      g.Underline = False
		      g.Bold = False
		      g.Italic = False
		      
		      g.DrawString("➔", x , y)
		      
		    End If
		    
		  End If
		  
		  
		  If Leader = Tab_Leader_Type.None Then Return
		  
		  ' Compute the current width.
		  Dim currentWidth As Double = x - leftPoint - 1
		  
		  ' Scale the width for printing.
		  Dim lineWidth As Double = getWidth(getObjectScale(printing, printScale), currentWidth)
		  
		  g.ForeColor = Me.TextColor
		  
		  Dim myScale As Double = 1.5 * Me.parentControl.getDisplayScale ' printScale
		  Dim myPrintScale As Double = 1.5 * printScale
		  Dim myHeight As Double = 0.6 * If(printing, myPrintScale, myScale)
		  
		  Select Case Leader
		  Case Tab_Leader_Type.Dot, Tab_Leader_Type.Hypen, Tab_Leader_Type.MiddleDot
		    
		    Const stepWidth As Integer = 4
		    
		    Dim width As Integer = (lineWidth / stepWidth) - 2
		    
		    #Pragma Warning "Tab Leadings currently drawn only if paragraph align = left, need calculation for offset (center, right)"
		    
		    Select Case Leader
		    Case Tab_Leader_Type.Dot
		      
		      ' Draws Line with Fill Sign "."
		      Dim newHeight As Double = myHeight + (.25 * If(printing, myPrintScale, myScale))
		      
		      For i As Integer = 2 To width Step newHeight
		        g.FillOval(x + (stepWidth * i), y - (Me.getDescent(If(printing, myPrintScale, myScale)) / 5), newHeight, newHeight)
		      Next
		      
		    Case Tab_Leader_Type.Hypen
		      
		      ' Draws Line with Fill Sign "-"
		      Dim myWidth As Double = 2 * myScale
		      Dim myStep As Double = myWidth / 2
		      Dim newStep As Double = myStep / 1.5
		      
		      For i As Integer = 2 To width - .1 Step newStep
		        g.FillRect(x + (stepWidth * i), y - (Me.getDescent(If(printing, myPrintScale, myScale))) + myscale, myWidth , myHeight)
		      Next
		      
		    Case Tab_Leader_Type.MiddleDot
		      
		      ' Draws Line with Fill Sign "·"
		      Dim myWidth As Double = 2 * myScale
		      Dim myStep As Double = myWidth / If(printing, 1, 1.5)
		      Dim newStep As Double = myStep / 1.5
		      
		      Dim newHeight As Double = myHeight + (0.5 * If(printing, myPrintScale, myScale))
		      
		      For i As Integer = 2 To width - .1 Step newStep
		        g.FillOval(x + (stepWidth * i), y - (Me.getDescent(If(printing, myPrintScale, myScale))) + (myscale * .25), newHeight , newHeight)
		      Next
		      
		    End Select
		    
		  Case Tab_Leader_Type.Underscore
		    
		    ' Draws Line with Fill Sign "_"
		    g.FillRect(x + 5, y + (Me.getDescent(If(printing, myPrintScale, myScale)) / 3), lineWidth - 10,  myHeight-(.2* If(printing, myPrintScale, myScale)))
		    
		  End Select
		  
		End Sub
	#tag EndEvent

	#tag Event
		Function PartialWidth(startIndex as integer, endIndex as integer, scale as double, startPosition as double) As double
		  #pragma Unused Scale
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  #pragma Unused startIndex
		  #Pragma Unused endIndex
		  
		  //BK 20Oct2017 Note:
		  //This lovely bit of code brought to you by HiDPI
		  Dim dTempResolution As Double = doc.getMonitorPixelsPerInch
		  
		  If parentControl.IsHiDPT Then
		    dTempResolution = dTempResolution/2
		  End
		  
		  Return Ceil(((tabPosition * dTempResolution * scale) - startPosition))
		  
		End Function
	#tag EndEvent

	#tag Event
		Function Width(scale as double, startPosition as double) As double
		  #pragma Unused Scale
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the width to the next tab stop.
		  
		  //BK 20Oct2017 Note:
		  //This lovely bit of code brought to you by HiDPI
		  
		  Dim dTempResolution As Double = doc.getMonitorPixelsPerInch
		  If parentControl.IsHiDPT Then
		    dTempResolution = dTempResolution/2
		  end
		  
		  Return Ceil(((tabPosition * dTempResolution * scale) - startPosition))
		  
		End Function
	#tag EndEvent


	#tag Method, Flags = &h0
		Function clone() As FTObject
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Reuse the tab.
		  return self
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(parentControl as FormattedText, generateNewID as boolean = true)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the parent control.
		  super.Constructor(parentControl, generateNewId)
		  
		  ' Reset the flags.
		  reset
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1000
		Sub Constructor(parentControl as FormattedText, attributeList as XmlAttributeList, generateNewID as boolean = true)
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save  the parent control.
		  super.Constructor(parentControl, attributeList, generateNewID)
		  
		  ' Reset the flags.
		  reset
		  
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(parentControl as FormattedText, obj as XmlElement, generateNewID as boolean = true)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save  the parent control.
		  super.Constructor(parentControl, obj, generateNewID)
		  
		  ' Reset the flags.
		  reset
		  
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getLength() As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Default to one unit.
		  return 1
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub getRTF(rtf as RTFWriter)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Create a new subcontext.
		  rtf.startGroup
		  
		  ' Get the rest of the attributes.
		  super.getRTF(rtf)
		  
		  ' Save the text.
		  rtf.setText(Chr(9))
		  
		  ' Finish the context.
		  rtf.endGroup
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function GetTabLeaderExample(TabLeader as FTTab.Tab_Leader_Type) As String
		  ' This function if you want to display an example string in the UI.
		  
		  Select Case TabLeader
		  Case FTTab.Tab_Leader_Type.None
		    Return kNone
		    
		  Case FTTab.Tab_Leader_Type.Hypen
		    Return kHyphen
		    
		  Case FTTab.Tab_Leader_Type.MiddleDot
		    Return kMiddleDot
		    
		  Case FTTab.Tab_Leader_Type.Underscore
		    Return kUnderscore
		    
		  Case FTTab.Tab_Leader_Type.Dot
		    Return kDot
		    
		  Case Else
		    Break //error shouldn't happen
		    Return ""
		  End
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function GetTabLeaderFromText(Value as String) As FTTab.Tab_Leader_Type
		  ' This function if you want to get the leader type from the UI text used.
		  
		  Select Case Value
		  Case kNone
		    Return FTTab.Tab_Leader_Type.None
		    
		  Case kHyphen
		    Return FTTab.Tab_Leader_Type.Hypen
		    
		  Case kMiddleDot
		    Return FTTab.Tab_Leader_Type.MiddleDot
		    
		  Case kUnderscore
		    Return FTTab.Tab_Leader_Type.Underscore
		    
		  Case kDot
		    Return FTTab.Tab_Leader_Type.Dot
		    
		  Case Else
		    Return FTTab.Tab_Leader_Type.None
		    
		  End
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getText(showPictures as boolean = false) As string
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  #pragma Unused showPictures
		  
		  ' Return the text.
		  return Chr(9)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub getXML(xmlDoc as XmlDocument, paragraph as XmlElement)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim tabNode as XmlElement
		  
		  ' Create the tab node.
		  tabNode = xmlDoc.CreateElement(FTCxml.XML_FTTAB)
		  
		  ' Load up the base attributes.
		  getBaseXML(xmlDoc, tabNode)
		  
		  ' Add the node to the paragraph.
		  paragraph.AppendChild(tabNode)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function seekEndPosition(startPosition as integer, width as integer) As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  #pragma Unused startPosition
		  #pragma Unused width
		  
		  ' Return the default value.
		  return 1
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setTabPosition(position as double)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the tab position.
		  tabPosition = position
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		Leader As Tab_Leader_Type = Tab_Leader_Type.None
	#tag EndProperty

	#tag Property, Flags = &h21
		Private tabPosition As double
	#tag EndProperty


	#tag Constant, Name = kDot, Type = String, Dynamic = False, Default = \"..........", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kHyphen, Type = String, Dynamic = False, Default = \"------", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kMiddleDot, Type = String, Dynamic = False, Default = \"\xC2\xB7\xC2\xB7\xC2\xB7\xC2\xB7\xC2\xB7\xC2\xB7\xC2\xB7\xC2\xB7\xC2\xB7\xC2\xB7", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kNone, Type = String, Dynamic = False, Default = \"None", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kUnderscore, Type = String, Dynamic = False, Default = \"_______", Scope = Public
	#tag EndConstant


	#tag Enum, Name = Tab_Leader_Type, Type = Integer, Flags = &h0
		None
		  Dot
		  Underscore
		  Hypen
		MiddleDot
	#tag EndEnum


	#tag ViewBehavior
		#tag ViewProperty
			Name="colorOpacity"
			Group="Behavior"
			Type="Double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="hasShadow"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HyperLink"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="hyperLinkColor"
			Group="Behavior"
			InitialValue="&c0000ff"
			Type="color"
		#tag EndViewProperty
		#tag ViewProperty
			Name="hyperLinkColorDisabled"
			Group="Behavior"
			InitialValue="&cC0C0C0"
			Type="color"
		#tag EndViewProperty
		#tag ViewProperty
			Name="hyperLinkColorRollover"
			Group="Behavior"
			InitialValue="&cFF0000"
			Type="color"
		#tag EndViewProperty
		#tag ViewProperty
			Name="hyperLinkColorVisited"
			Group="Behavior"
			InitialValue="&c800080"
			Type="color"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="inNewWindow"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="markColor"
			Group="Behavior"
			InitialValue="&h000000"
			Type="Color"
		#tag EndViewProperty
		#tag ViewProperty
			Name="marked"
			Group="Behavior"
			InitialValue="0"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="shadowAngle"
			Group="Behavior"
			Type="double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="shadowBlur"
			Group="Behavior"
			Type="Double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="shadowColor"
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
		#tag EndViewProperty
		#tag ViewProperty
			Name="shadowOffset"
			Group="Behavior"
			Type="Double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="shadowOpacity"
			Group="Behavior"
			Type="Double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="strikeThrough"
			Group="Behavior"
			InitialValue="0"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="textColor"
			Group="Behavior"
			InitialValue="&h000000"
			Type="color"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="underline"
			Group="Behavior"
			InitialValue="0"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="useCustomHyperLinkColor"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Leader"
			Group="Behavior"
			InitialValue="Tab_Leader_Type.None"
			Type="Tab_Leader_Type"
			EditorType="Enum"
			#tag EnumValues
				"0 - None"
				"1 - Dot"
				"2 - Underscore"
				"3 - Hypen"
				"4 - MiddleDot"
			#tag EndEnumValues
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
