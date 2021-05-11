#tag Class
Protected Class FTCUndoDrop
Inherits FTCUndoBase
	#tag Method, Flags = &h0
		Sub constructor(parent as FTCUndoManager, insertionStart as FTInsertionOffset, insertionEnd as FTInsertionOffset, content as string, selectStart as FTInsertionOffset, selectEnd as FTInsertionOffset)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Initialize the base.
		  Super.Constructor(parent, FTCStrings.DROP)
		  
		  ' Save the original position.
		  me.startPosition = insertionStart.clone
		  me.endPosition = insertionEnd.clone
		  
		  ' Save the selection position.
		  me.selectStart = selectStart.clone
		  me.selectEnd = selectEnd.clone
		  
		  ' Save the content.
		  me.content = content
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub redo()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set the insertion point.
		  doc.setInsertionPoint(startPosition, false)
		  
		  ' Restore the content.
		  doc.insertXml(content, false, false)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub undo()
		  
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


	#tag Property, Flags = &h21
		Private selectEnd As FTInsertionOffset
	#tag EndProperty

	#tag Property, Flags = &h21
		Private selectStart As FTInsertionOffset
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
