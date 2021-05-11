#tag Class
Protected Class FTCUndoPageBreak
Inherits FTCUndoBase
	#tag Method, Flags = &h0
		Sub constructor(parent as FTCUndoManager, startOffset as FTinsertionOffset, endOffset as FTinsertionOffset, selectedContent as string)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Initialize the base.
		  Super.Constructor(parent, FTCStrings.PAGE_BREAK)
		  
		  ' Save the start position.
		  startPosition = startOffset.clone
		  
		  ' Was a selection specified?
		  if not (endOffset is nil) then
		    
		    ' Save the end position.
		    endPosition = endOffset.clone
		    
		  end if
		  
		  ' Save the content.
		  content = selectedContent
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub redo()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Is there anything to do?
		  if not startPosition.isSet then return
		  
		  ' Clear any selection.
		  doc.deselectAll
		  
		  ' Was something selected?
		  if content <> "" then
		    
		    ' Select the text.
		    doc.selectSegment(startPosition, endPosition)
		    
		    ' Delete the selected text.
		    doc.deleteSelected
		    
		  end if
		  
		  ' Move the insertion point.
		  doc.setInsertionPoint(startPosition, false)
		  
		  ' Insert the page break.
		  doc.insertPageBreak(startPosition)
		  
		  ' Make sure everthing updates.
		  doc.markAllPagesDirty
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub undo()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Is there anything to do?
		  if not startPosition.isSet then return
		  
		  ' Clear any selection.
		  doc.deselectAll
		  
		  ' Reverse the page break.
		  doc.combineParagraphs(startPosition.paragraph)
		  
		  ' Move the insertion point.
		  doc.setInsertionPoint(startPosition, false)
		  
		  ' Was something selected?
		  if content <> "" then
		    
		    ' Restore the content.
		    doc.insertXml(content, true, false)
		    
		    ' Select the text.
		    doc.selectSegment(startPosition, endPosition)
		    
		  end if
		  
		  ' Make sure everthing updates.
		  doc.markAllPagesDirty
		  
		End Sub
	#tag EndMethod


	#tag ViewBehavior
		#tag ViewProperty
			Name="content"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
			InheritedFrom="FTCUndoBase"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="length"
			Group="Behavior"
			InitialValue="0"
			Type="integer"
			InheritedFrom="FTCUndoBase"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="undoName"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
			InheritedFrom="FTCUndoBase"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
