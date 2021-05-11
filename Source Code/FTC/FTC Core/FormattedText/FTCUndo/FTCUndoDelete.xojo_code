#tag Class
Protected Class FTCUndoDelete
Inherits FTCUndoBase
	#tag Method, Flags = &h0
		Sub constructor(parent as FTCUndoManager, name as string, startOffset as FTInsertionOffset, endOffset as FTInsertionOffset, content as string)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Initialize the base.
		  Super.Constructor(parent, name)
		  
		  ' Save the start position.
		  startPosition = startOffset.clone
		  
		  ' Save the end position.
		  endPosition = endOffset.clone
		  
		  ' Save the deleted content.
		  me.content = content
		  me.firstPa = doc.getParagraph(startOffset.paragraph).getParagraphAttributes
		  me.lastPa = doc.getParagraph(endOffset.paragraph).getParagraphAttributes
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub redo()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Select the text.
		  doc.selectSegment(startPosition, endPosition)
		  
		  ' Delete the text.
		  doc.deleteSelected
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub undo()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Deselect all the text.
		  doc.deselectAll
		  
		  ' Set the insertion point.
		  doc.setInsertionPoint(startPosition, false)
		  
		  ' Restore the content.
		  doc.insertXml(content, false, false)
		  
		  ' Reselect the text.
		  doc.selectSegment(startPosition, endPosition)
		  
		  ' Reset the paragraph attributes.
		  doc.getParagraph(startPosition.paragraph).setParagraphAttributes(firstPa)
		  doc.getParagraph(endPosition.paragraph).setParagraphAttributes(lastPa)
		  
		  ' Make sure everything gets updated properly.
		  doc.markAllParagraphsDirty
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private firstPa As ParagraphAttributes
	#tag EndProperty

	#tag Property, Flags = &h21
		Private lastPa As ParagraphAttributes
	#tag EndProperty


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
