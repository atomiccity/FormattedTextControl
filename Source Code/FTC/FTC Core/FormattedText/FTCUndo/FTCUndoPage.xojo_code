#tag Class
Protected Class FTCUndoPage
Inherits FTCUndoBase
	#tag Method, Flags = &h0
		Sub constructor(parent as FTCUndoManager, styleName as string, docMargins as DocumentMargins)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Initialize the base.
		  Super.Constructor(parent, styleName)
		  
		  ' Save the data.
		  me.oldDocMargins = docMargins
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub redo()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set the margins.
		  doc.setDocumentMargins(newDocMargins)
		  
		  ' Mark all paragraphs for an update.
		  parent.getControl.getDoc.markAllParagraphsDirty
		  parent.getControl.invalidateBackground
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setNewContent(docMargins as DocumentMargins)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the data.
		  me.newDocMargins = docMargins
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub undo()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set the margins.
		  doc.setDocumentMargins(oldDocMargins)
		  
		  ' Mark all paragraphs for an update.
		  parent.getControl.getDoc.markAllParagraphsDirty
		  parent.getControl.invalidateBackground
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		newDocMargins As DocumentMargins
	#tag EndProperty

	#tag Property, Flags = &h0
		oldDocMargins As DocumentMargins
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
