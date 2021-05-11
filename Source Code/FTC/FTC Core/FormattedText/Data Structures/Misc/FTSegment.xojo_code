#tag Class
Protected Class FTSegment
	#tag Method, Flags = &h0
		Sub addParagraph(p as FTParagraph)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim target as FTParagraph
		  
		  ' Create a copy.
		  target = p.clone
		  
		  ' Add the paragraph.
		  items.Append(target)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub addParagraph(p as FTParagraph, startPosition as integer, endPosition as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Add the sub-paragraph.
		  addParagraph(p.clone(startPosition, endPosition))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getNumberOfParagraphs() As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the number of paragraphs.
		  return Ubound(items) + 1
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getParagraph(index as integer) As FTParagraph
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the specified paragraph.
		  return items(index)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setParent(parentControl as FormattedText)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim p as FTParagraph
		  
		  ' Change their parent.
		  for each p in items
		    
		    ' Set the parent on the paragraph.
		    p.setParent(parentControl)
		    
		  next
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private items() As FTParagraph
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
