#tag Class
Protected Class FTCUndoForwardDelete
Inherits FTCUndoBase
	#tag Method, Flags = &h0
		Sub constructor(parent as FTCUndoManager, offset as FTInsertionOffset)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Initialize the base.
		  Super.Constructor(parent, FTCStrings.FORWARD_DELETE)
		  
		  ' Save the start position.
		  paragraphPosition = offset.clone
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub redo()
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim p as FTParagraph
		  
		  ' Deselect all the text.
		  doc.deselectAll
		  
		  ' Set the insertion point.
		  doc.setInsertionPoint(paragraphPosition, false)
		  
		  ' Get the number of deletions to perform.
		  count = Ubound(obj)
		  
		  ' Delete the characters.
		  for i = 0 to count
		    
		    ' Delete a character.
		    call doc.deleteCharacter(true, p)
		    
		    ' Mark the paragraphs for spell checking.
		    doc.markDirtyParagraphsForSpellCheck
		    
		    ' Compose the paragraphs.
		    doc.compose
		    
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub undo()
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim item as FTBase
		  Dim p as FTParagraph
		  
		  ' Deselect all the text.
		  doc.deselectAll
		  
		  ' Get the number items to insert.
		  count = Ubound(obj)
		  
		  ' Set the insertion point.
		  doc.setInsertionPoint(paragraphPosition, false)
		  
		  ' Insert the deleted object.
		  for i = 0 to count
		    
		    ' Get an item.
		    item = obj(i)
		    
		    ' Is this a paragraph?
		    if item isa FTParagraph then
		      
		      ' Insert the paragraph.
		      p = doc.insertNewParagraph(doc.getInsertionPoint.getOffset)
		      
		      ' Reset the paragraph attributes.
		      p.copyParagraphStyle(FTParagraph(item), false)
		      
		      ' Set the insertion point.
		      doc.getInsertionPoint.setInsertionPoint(p, 0, false)
		      
		    else
		      
		      ' Is the item a picture?
		      if item isa FTPicture then
		        
		        ' Reset the resize mode.
		        FTPicture(item).setResizeMode(false)
		        
		      end if
		      
		      ' Put the item back.
		      doc.insertObject(FTObject(item).clone)
		      
		    end if
		    
		  next
		  
		  ' Move the insertion point to the beginning of the undo.
		  doc.setInsertionPoint(paragraphPosition, false)
		  
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
