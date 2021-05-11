#tag Class
Protected Class FTCUndoMove
Inherits FTCUndoBase
	#tag Method, Flags = &h0
		Sub constructor(parent as FTCUndoManager, insertionStart as FTInsertionOffset, selectStart as FTInsertionOffset, selectEnd as FTInsertionOffset, content as string, firstParagraphAttributes as ParagraphAttributes, lastParagraphAttributes as ParagraphAttributes)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Initialize the base.
		  Super.Constructor(parent, FTCStrings.MOVE)
		  
		  ' Save the original position.
		  me.startPosition = insertionStart.clone
		  
		  ' Save the selection position.
		  me.selectStart = selectStart.clone
		  me.selectEnd = selectEnd.clone
		  
		  ' Save the selected paragraph attributes.
		  selectStartPa = doc.getParagraph(selectStart.paragraph).getParagraphAttributes
		  selectEndPa = doc.getParagraph(selectEnd.paragraph).getParagraphAttributes
		  
		  ' Save the content.
		  me.content = content
		  me.firstPa = firstParagraphAttributes
		  me.lastPa = lastParagraphAttributes
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub redo()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Deselect all text.
		  doc.deselectAll
		  
		  ' Delete the text.
		  doc.selectSegment(startPosition, endPosition)
		  doc.deleteSelected
		  
		  ' Mark the paragraphs for spell checking.
		  doc.markDirtyParagraphsForSpellCheck
		  
		  ' Compose the paragraphs.
		  parent.getControl.getDoc.compose
		  
		  ' Set the insertion point.
		  doc.setInsertionPoint(selectStart, false)
		  
		  ' Restore the content.
		  doc.insertXml(content, false, false)
		  
		  ' Select the text.
		  doc.selectSegment(selectStart, doc.getInsertionOffset)
		  
		  ' Reset the paragraph attributes.
		  doc.getParagraph(selectStart.paragraph).setParagraphAttributes(selectStartPa)
		  doc.getParagraph(selectEnd.paragraph).setParagraphAttributes(selectEndPa)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub undo()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Deselect all text.
		  doc.deselectAll
		  
		  ' Reset the paragraph attributes.
		  doc.getParagraph(selectStart.paragraph).setParagraphAttributes(selectStartPa)
		  doc.getParagraph(selectEnd.paragraph).setParagraphAttributes(selectEndPa)
		  
		  ' Delete the text.
		  doc.selectSegment(selectStart, selectEnd)
		  doc.deleteSelected
		  
		  ' Mark the paragraphs for spell checking.
		  doc.markDirtyParagraphsForSpellCheck
		  
		  ' Compose the paragraphs.
		  parent.getControl.getDoc.compose
		  
		  ' Set the insertion point.
		  doc.setInsertionPoint(startPosition, false)
		  
		  ' Restore the content.
		  doc.insertXml(content, true, false)
		  
		  ' Save the end position.
		  endPosition = doc.getInsertionOffset
		  
		  ' Select the previously selected text.
		  doc.selectSegment(startPosition, endPosition)
		  
		  ' Reset the paragraph attributes.
		  doc.getParagraph(startPosition.paragraph).setParagraphAttributes(firstPa)
		  doc.getParagraph(endPosition.paragraph).setParagraphAttributes(lastPa)
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private firstPa As ParagraphAttributes
	#tag EndProperty

	#tag Property, Flags = &h21
		Private lastPa As ParagraphAttributes
	#tag EndProperty

	#tag Property, Flags = &h21
		Private selectEnd As FTInsertionOffset
	#tag EndProperty

	#tag Property, Flags = &h0
		selectEndPa As ParagraphAttributes
	#tag EndProperty

	#tag Property, Flags = &h21
		Private selectStart As FTInsertionOffset
	#tag EndProperty

	#tag Property, Flags = &h0
		selectStartPa As ParagraphAttributes
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
