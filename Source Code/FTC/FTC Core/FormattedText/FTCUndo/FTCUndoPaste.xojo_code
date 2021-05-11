#tag Class
Protected Class FTCUndoPaste
Inherits FTCUndoBase
	#tag Method, Flags = &h1000
		Sub constructor(name as string, byref parent as FTCUndoManager, byref selectStart as FTInsertionOffset, byref selectEnd as FTInsertionOffset, byref newOffset as FTInsertionOffset, byref selectedContent as string, byref newContent as string, byref firstPa as ParagraphAttributes)
		  //BK 08Nov.  This method is now getting most parameters byref because of Win64 issue with pasting (hard crash).
		  // Private <feedback://showreport?report_id=53967>
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Initialize the base.
		  Super.Constructor(parent, name)
		  
		  '---------------------------------------
		  
		  ' Was something selected?
		  If Not (selectStart Is Nil) Then
		    
		    ' Save the position.
		    me.startPosition = selectStart.clone
		    
		  end if
		  
		  ' Was something selected?
		  if not (selectEnd is nil) then
		    
		    ' Save the position.
		    me.endPosition = selectEnd.clone
		    
		  end if
		  
		  '---------------------------------------
		  
		  ' Save the new offset.
		  me.newOffset = newOffset.clone
		  
		  ' Save the content.
		  me.selectedContent = selectedContent
		  me.newContent = newContent
		  
		  ' Save the fist paragraph attributes.
		  me.firstPa = firstPa
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub redo()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  doc.deselectAll
		  
		  ' Was something selected?
		  if selectedContent <> "" then
		    
		    ' Select the text.
		    doc.selectSegment(startPosition, endPosition)
		    
		    ' Delete the text.
		    doc.deleteSelected
		    
		  end if
		  
		  ' Set the insertion point.
		  doc.setInsertionPoint(startPosition, false)
		  
		  ' Restore the content.
		  doc.insertXml(newContent, true, false)
		  
		  ' Select the text.
		  doc.selectSegment(startPosition, newOffset)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub undo()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim p as FTParagraph
		  
		  ' Was something selected?
		  if not (startPosition is nil) and not (endPosition is nil) then
		    
		    ' Select the text.
		    doc.selectSegment(startPosition, newOffset)
		    
		    ' Delete the text.
		    doc.deleteSelected
		    
		    ' Get the current paragraph.
		    p = doc.getInsertionPoint.getCurrentParagraph
		    
		    ' Restore the paragraph attributes.
		    p.setParagraphAttributes(firstPa)
		    
		    ' Remove any leftover hidden styles.
		    p.removeEmptyStyleRuns
		    
		  end if
		  
		  ' Clear any selections.
		  doc.deselectAll
		  
		  ' Was something selected?
		  if selectedContent <> "" then
		    
		    ' Restore the content.
		    doc.insertXml(selectedContent, true, true)
		    
		    ' Select the text.
		    doc.selectSegment(startPosition, endPosition)
		    
		  end if
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private firstPa As ParagraphAttributes
	#tag EndProperty

	#tag Property, Flags = &h21
		Private newContent As string
	#tag EndProperty

	#tag Property, Flags = &h21
		Private newOffset As FTInsertionOffset
	#tag EndProperty

	#tag Property, Flags = &h21
		Private selectedContent As string
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="content"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="length"
			Group="Behavior"
			InitialValue="0"
			Type="integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="undoName"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
