#tag Class
Protected Class FTCUndoContentItem
	#tag Method, Flags = &h0
		Sub Constructor(offset as FTinsertionOffset, isReturn as boolean = false)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the data.
		  startOffset = offset.clone
		  me.isReturn = isReturn
		  
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
		  endOffset = nil
		  startOffset = nil
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getContent() As string
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the content.
		  return content
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function hasContent() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Is there any content?
		  return hasTyping
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function hasEndPoint() As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Has the end point been set?
		  return (not (endOffset is nil))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setContent(content as string)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the content.
		  me.content = content
		  
		  ' Mark it as having content.
		  hasTyping = true
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setEndPosition(offset as FTInsertionOffset)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the end position.
		  endOffset = offset.clone
		  
		  ' Mark it as having content.
		  hasTyping = true
		  
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private content As string
	#tag EndProperty

	#tag Property, Flags = &h0
		endOffset As FTinsertionOffset
	#tag EndProperty

	#tag Property, Flags = &h21
		Private hasTyping As boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		isReturn As boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		startOffset As FTInsertionOffset
	#tag EndProperty


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
			Name="isReturn"
			Group="Behavior"
			InitialValue="0"
			Type="boolean"
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
End Class
#tag EndClass
