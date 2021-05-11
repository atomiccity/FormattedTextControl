#tag Interface
Protected Interface UndoItemInterface
	#tag Method, Flags = &h0
		Sub finish()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getUndoName() As string
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isRedoable() As boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isUndoable() As boolean
		  
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


	#tag ViewBehavior
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
	#tag EndViewBehavior
End Interface
#tag EndInterface
