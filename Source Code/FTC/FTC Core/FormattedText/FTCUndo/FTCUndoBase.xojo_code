#tag Class
Protected Class FTCUndoBase
Inherits FTBase
Implements UndoItemInterface
	#tag Method, Flags = &h0
		Sub constructor(parent as FTCUndoManager, undoName as string)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Inistialize the base.
		  super.Constructor(parent.getControl)
		  
		  ' Save the reference.
		  me.parent = parent
		  
		  ' Save the undo name.
		  me.undoName = undoName
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Destructor()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Release the references.
		  endPosition = nil
		  paragraphPosition = nil
		  parent = nil
		  startPosition = nil
		  Redim obj(-1)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub finish()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getUndoName() As string
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the menu item name.
		  return undoName
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isRedoable() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Assume redoable.
		  return true
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isUndoable() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Assume undoable.
		  return true
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub redo()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub undo()
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		content As string
	#tag EndProperty

	#tag Property, Flags = &h0
		endPosition As FTinsertionOffset
	#tag EndProperty

	#tag Property, Flags = &h0
		length As integer
	#tag EndProperty

	#tag Property, Flags = &h0
		obj() As FTBase
	#tag EndProperty

	#tag Property, Flags = &h0
		paragraphPosition As FTInsertionOffset
	#tag EndProperty

	#tag Property, Flags = &h0
		parent As FTCUndoManager
	#tag EndProperty

	#tag Property, Flags = &h0
		startPosition As FTInsertionOffset
	#tag EndProperty

	#tag Property, Flags = &h0
		undoName As string
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
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
