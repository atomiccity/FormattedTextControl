#tag Class
Protected Class FTTextFieldBase
Inherits FormattedText
	#tag Event
		Sub KeyPress(ByRef key as string)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Adjust the typed input for the mask.
		  extendTyping(key)
		  
		  ' Call the event.
		  KeyPress(key)
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Create the mask if one was specified.
		  setMask(Mask)
		  
		  ' Call the event.
		  Open
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub PostDisplayDraw(g as graphics)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Draw the shadow lines.
		  
		  ' Left
		  drawVerticalLine(g, 0, &cF5F5F5)
		  
		  ' Right
		  drawVerticalLine(g, g.width, &cF5F5F5)
		  
		  ' Top
		  drawHorizontalLine(g, 0, &cCBCBCB)
		  drawHorizontalLine(g, 1, &cF6F6F6)
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub TextChanged()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Are we in the midst of changing the text?
		  if not inhibitTextChange then
		    
		    ' Turn off text changes.
		    inhibitTextChange = true
		    
		    ' Call the event.
		    TextChanged
		    
		    ' Check the maximum length of the text.
		    checkMaximumLength
		    
		    ' Check for lower and upper case shifts.
		    checkTextCase
		    
		    ' Validate the line.
		    validate
		    
		    ' Allow text changes.
		    inhibitTextChange = false
		    
		  end if
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub checkMaximumLength()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Is a mask present?
		  if not (maskObject is nil) then
		    
		    ' Trim the text to the specified length.
		    trimText(maskObject.getLength + 1)
		    
		    ' Has the text been limited to a certain size
		  elseif LimitText > 0 then
		    
		    ' Trim the text to the specified length.
		    trimText(LimitText)
		    
		  end  if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub checkTextCase()
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim io as FTInsertionOffset
		  Dim text as string
		  
		  ' Is a mask present?
		  if not (maskObject is nil) then
		    
		    ' Will the case of any characters change?
		    if maskObject.checkTextCase(doc.getText, text) then
		      
		      ' Get the current insertion offset.
		      io = doc.getInsertionOffset
		      
		      ' Reset the text.
		      setText(text)
		      
		      ' Restore the insertion offset.
		      doc.setInsertionPoint(io, true)
		      
		    end if
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub drawBorder(g as graphics)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Should we draw the border?
		  if DrawControlBorder then
		    
		    ' Bottom
		    drawHorizontalLine(g, g.height - 1, &cD9D9D9)
		    
		    ' Left
		    drawVerticalLine(g, 0, &cB4B4B4)
		    
		    ' Right
		    drawVerticalLine(g, g.width - 1, &cB4B4B4)
		    
		    ' Top
		    drawHorizontalLine(g, 0, &c727272)
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub drawHorizontalLine(g as Graphics, y as integer, c as Color)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set up the drawing characteristics.
		  g.PenWidth = 1
		  g.PenHeight = 1
		  g.ForeColor = c
		  
		  g.DrawLine(0, y, g.width, y)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub drawVerticalLine(g as Graphics, x as integer, c as Color)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set up the drawing characteristics.
		  g.PenWidth = 1
		  g.PenHeight = 1
		  g.ForeColor = c
		  
		  g.DrawLine(x, 0, x, g.height)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub extendTyping(ByRef key as string)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim text as string
		  Dim io as FTInsertionOffset
		  
		  ' Is there anything to do?
		  if maskObject is nil then return
		  
		  ' Get the current offset.
		  io = doc.getInsertionOffset
		  
		  ' Get the current text.
		  text = me.getDoc.getText
		  
		  ' Are we at the end of the text?
		  if text.len = io.offset then
		    
		    ' Add in any literals that are specied in the mask.
		    maskObject.appendLiterals(key, io.offset)
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getLineWidth() As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim p as FTParagraph
		  
		  ' Get the paragraph.
		  p = doc.getParagraph(0)
		  
		  ' Get the width of the paragraph.
		  return p.getLeftMarginWidth + p.getSingleLineWidth
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getMaskObject() As FTCMask
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the mask object.
		  return maskObject
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getText() As string
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the current text content.
		  return doc.getText
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isMaskValid(mask as string) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim mo as FTCMask
		  
		  ' Create a new mask object.
		  mo = new FTCMask
		  
		  ' Check the validity of the mask.
		  return mo.isValidMask(mask)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub scrollToCaret()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim ip as FTInsertionPoint
		  Dim currentPosition as integer
		  Dim p as FTParagraphProxy
		  
		  ' Is there anything to look at?
		  if me.getDoc.getParagraphCount >= 1 then
		    
		    ' Get the current insertion point.
		    ip = doc.getInsertionPoint
		    
		    ' Get the proxy paragraph.
		    p = ip.getCurrentProxyParagraph
		    
		    ' Calculate the current horizontal position of the insertion caret.
		    currentPosition = Round(doc.getLeftMarginWidth + p.getParent.getLeftMarginWidth + ip.getCaretOffset)
		    
		    ' Are we to the left of the display?
		    if currentPosition <= (Abs(getXDisplayPosition) + BUFFER_SPACE) then
		      
		      ' Scroll horizontally to the position.
		      hScroll(Max(currentPosition - BUFFER_SPACE, 0))
		      
		      ' Are we to the right of the display?
		    elseif currentPosition > (Abs(getXDisplayPosition) + getDisplayWidth - BUFFER_SPACE) then
		      
		      ' Scroll horizontally to the position.
		      hScroll(Max(currentPosition + BUFFER_SPACE - getDisplayWidth, 0))
		      
		    end if
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub scrollToMouse(x as integer, y as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  #pragma Unused y
		  
		  Dim currentPosition as integer
		  
		  ' Is there anything to look at?
		  if me.getDoc.getParagraphCount >= 1 then
		    
		    ' Do we need to scroll to the left?
		    if x < 0 then
		      
		      ' Compute where we should scroll to.
		      currentPosition = Max(Abs(getXDisplayPosition) + x, 0)
		      
		      ' Scroll to that position.
		      hScroll(currentPosition)
		      
		      ' Do we need to scroll to the right?
		    elseif x > getDisplayWidth then
		      
		      ' Compute where we should scroll to.
		      currentPosition = Min(Abs(getXDisplayPosition) + x, getLineWidth - getDisplayWidth + BUFFER_SPACE)
		      
		      ' Scroll to that position.
		      hScroll(currentPosition)
		      
		    end if
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setMask(mask as string)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the mask.
		  me.Mask = mask
		  
		  ' Is it being reset?
		  if mask = "" then
		    
		    ' Clear the mask.
		    maskObject = nil
		    
		  else
		    
		    try
		      
		      ' Create and intialize the mask.
		      maskObject = new FTCMask(mask)
		      
		    catch
		      
		      ' Clear the mask.
		      mask = ""
		      maskObject = nil
		      
		    end try
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub trimText(maxLength as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim io as FTInsertionOffset
		  Dim length as integer
		  Dim text as string
		  
		  ' Get the current text.
		  text = doc.getText
		  
		  ' Get the length of the text.
		  length = text.len
		  
		  ' Have we exceeded the maximum length of the mask?
		  if length > maxLength then
		    
		    ' Get the current insertion offset.
		    io = doc.getInsertionOffset
		    
		    ' Reset the text.
		    setText(left(text, maxLength))
		    
		    ' Restore the insertion offset.
		    doc.setInsertionPoint(io, true)
		    
		    ' Alert the user.
		    beep
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub validate()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim text as string
		  Dim position as integer
		  Dim io as FTInsertionOffset
		  
		  ' Is there anything to check?
		  if maskObject is nil then return
		  
		  ' Get the current text.
		  text = me.getDoc.getText
		  
		  ' Validate the text against the mask.
		  if not maskObject.verify(text, position) then
		    
		    ' Was this handled by the sub class?
		    if not ValidationError(text, position) then
		      
		      ' Get the current insertion offset.
		      io = doc.getInsertionOffset
		      
		      ' Reset the text.
		      setText(left(text, position))
		      
		      ' Restore the insertion offset.
		      doc.setInsertionPoint(io, true)
		      
		      ' Alert the user.
		      beep
		      
		    end if
		    
		  end if
		  
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event KeyPress(ByRef key as string)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Open()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event TextChanged()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ValidationError(invalidText as String, startPosition as Integer) As boolean
	#tag EndHook


	#tag Property, Flags = &h1
		Protected inhibitTextChange As boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		LimitText As integer
	#tag EndProperty

	#tag Property, Flags = &h0
		Mask As string
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected maskObject As FTCMask
	#tag EndProperty


	#tag Constant, Name = BUFFER_SPACE, Type = Double, Dynamic = False, Default = \"30", Scope = Protected
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="AllowBackgroundUpdates"
			Visible=true
			Group="FT Behavior"
			InitialValue="True"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowPictures"
			Visible=true
			Group="FT Behavior"
			InitialValue="True"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AutoComplete"
			Visible=true
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AutoDeactivate"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="BackgroundColor"
			Visible=true
			Group="FT Behavior"
			InitialValue="&cA0ADCD"
			Type="Color"
		#tag EndViewProperty
		#tag ViewProperty
			Name="BorderColor"
			Visible=true
			Group="FT Behavior"
			InitialValue="&ca0a0a0"
			Type="color"
		#tag EndViewProperty
		#tag ViewProperty
			Name="BottomMargin"
			Visible=true
			Group="FT Page Mode"
			InitialValue="0"
			Type="double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="CaretColor"
			Visible=true
			Group="FT Behavior"
			InitialValue="&c000000"
			Type="Color"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DefaultFont"
			Visible=true
			Group="FT Defaults"
			InitialValue="Arial"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DefaultFontSize"
			Visible=true
			Group="FT Defaults"
			InitialValue="12"
			Type="integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="defaultHyperLinkColor"
			Group="Behavior"
			InitialValue="&c0000ff"
			Type="Color"
		#tag EndViewProperty
		#tag ViewProperty
			Name="defaultHyperLinkColorDisabled"
			Group="Behavior"
			InitialValue="&ccccccc"
			Type="Color"
		#tag EndViewProperty
		#tag ViewProperty
			Name="defaultHyperLinkColorRollover"
			Group="Behavior"
			InitialValue="&cFF0000"
			Type="Color"
		#tag EndViewProperty
		#tag ViewProperty
			Name="defaultHyperLinkColorVisited"
			Group="Behavior"
			InitialValue="&c800080"
			Type="Color"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DefaultTabStop"
			Visible=true
			Group="FT Defaults"
			InitialValue="0.5"
			Type="double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DefaultTextColor"
			Visible=true
			Group="FT Defaults"
			InitialValue="&c000000"
			Type="Color"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DisplayAlignment"
			Visible=true
			Group="FT Mode"
			InitialValue="0"
			Type="Display_Alignment"
			EditorType="Enum"
			#tag EnumValues
				"0 - Left"
				"1 - Center"
				"2 - Right"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="DragAndDrop"
			Visible=true
			Group="FT Behavior"
			InitialValue="True"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DrawControlBorder"
			Visible=true
			Group="FT Behavior"
			InitialValue="true"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="EditViewMargin"
			Visible=true
			Group="FT Edit Mode"
			InitialValue="0.06"
			Type="double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="EditViewPrintMargin"
			Visible=true
			Group="FT Edit Mode"
			InitialValue="0.5"
			Type="double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Enabled"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Height"
			Visible=true
			Group="Position"
			InitialValue="100"
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HelpTag"
			Visible=true
			Group="Appearance"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HScrollbarAutoHide"
			Visible=true
			Group="FT Behavior"
			InitialValue="False"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="InhibitSelections"
			Visible=true
			Group="FT Behavior"
			InitialValue="False"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="InitialParent"
			Group="Position"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="InvisiblesColor"
			Visible=true
			Group="FT Behavior"
			InitialValue="&c526AFF"
			Type="Color"
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsHiDPT"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LeftMargin"
			Visible=true
			Group="FT Page Mode"
			InitialValue="0"
			Type="double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LimitText"
			Visible=true
			Group="FT Behavior"
			Type="integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockBottom"
			Visible=true
			Group="Position"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockLeft"
			Visible=true
			Group="Position"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockRight"
			Visible=true
			Group="Position"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockTop"
			Visible=true
			Group="Position"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="MarginGuideColor"
			Visible=true
			Group="FT Behavior"
			InitialValue="&cCACACA"
			Type="Color"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Mask"
			Visible=true
			Group="FT Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Mode"
			Visible=true
			Group="FT Behavior"
			Type="Display_Mode"
			EditorType="Enum"
			#tag EnumValues
				"0 - Page"
				"1 - Normal"
				"2 - Edit"
				"3 - Single"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
			EditorType="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="objectCountId"
			Group="Behavior"
			InitialValue="0"
			Type="integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="PageHeight"
			Visible=true
			Group="FT Page Mode"
			InitialValue="11.0"
			Type="double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="PageWidth"
			Visible=true
			Group="FT Page Mode"
			InitialValue="8.5"
			Type="double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ReadOnly"
			Visible=true
			Group="FT Behavior"
			InitialValue="False"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="RightMargin"
			Visible=true
			Group="FT Page Mode"
			InitialValue="0"
			Type="double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ShowInvisibles"
			Visible=true
			Group="FT Behavior"
			InitialValue="False"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ShowMarginGuides"
			Visible=true
			Group="FT Behavior"
			InitialValue="False"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ShowPilcrows"
			Visible=true
			Group="FT Behavior"
			InitialValue="False"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="SpellCheckWhileTyping"
			Visible=true
			Group="FT Behavior"
			InitialValue="False"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
			EditorType="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabIndex"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabPanelIndex"
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabStop"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TIC_PageTop"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TIC_xCaret"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TIC_yCaret"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TopMargin"
			Visible=true
			Group="FT Page Mode"
			InitialValue="0"
			Type="double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="UndoLimit"
			Visible=true
			Group="FT Behavior"
			InitialValue="128"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="updateFlag"
			Group="Behavior"
			InitialValue="0"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Visible"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="VScrollbarAutoHide"
			Visible=true
			Group="FT Behavior"
			InitialValue="False"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Width"
			Visible=true
			Group="Position"
			InitialValue="100"
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="xDisplayAlignmentOffset"
			Group="Behavior"
			Type="integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
