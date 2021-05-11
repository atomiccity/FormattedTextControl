#tag Class
Protected Class FTIterator
	#tag Method, Flags = &h0
		Sub Constructor(ftc as FormattedText, iterator as FTIteratorBase = nil)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the references.
		  me.ftc = ftc
		  me.iterator = iterator
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getIterator() As FTIteratorBase
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the iterator.
		  return iterator
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub run(startPos as FTInsertionOffset, endPos as FTInsertionOffset)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim j as integer
		  Dim paragraphCount as integer
		  Dim runCount as integer
		  Dim seg as FTSegment
		  Dim p as FTParagraph
		  
		  ' Is there anything to do?
		  if (ftc is nil) or (iterator is nil) then return
		  
		  ' Was the start point specified?
		  if startPos is nil then
		    
		    ' Use the beginning of the document.
		    startPos = new FTInsertionOffset(ftc.getDoc, 0, 0)
		    
		  end if
		  
		  ' Was the end point specified?
		  if endPos is nil then
		    
		    ' Use the end of the document.
		    endPos = new FTInsertionOffset(ftc.getDoc, 0, 0)
		    endPos.moveToEnd
		    
		  end if
		  
		  ' Get a copy of the text
		  seg = ftc.getDoc.getSegment(startPos, endPos)
		  
		  ' Set up the references.
		  iterator.ftc = ftc
		  iterator.doc = ftc.getDoc
		  
		  ' Start the parsing.
		  iterator.callPreParse
		  
		  ' Get the number of paragraphs.
		  paragraphCount = seg.getNumberOfParagraphs - 1
		  
		  ' Go through all the paragraphs.
		  for i = 0 to paragraphCount
		    
		    ' Allow the yielding to other threads.
		    iterator.callYield
		    
		    ' Get a paragraph.
		    p = seg.getParagraph(i)
		    
		    ' We are starting a new paragraph.
		    iterator.callParagraphStart(p, i)
		    
		    ' Get the number of style run items.
		    runCount = p.getItemCount - 1
		    
		    ' Run through the style run items.
		    for j = 0 to runCount
		      
		      dim oObject as FTObject = p.getItem(j)
		      
		      ' Process the style run.
		      iterator.callStyleRun(oObject)
		      
		    next
		    
		    ' We are ending the paragraph.
		    iterator.callParagraphEnd(p)
		    
		  next
		  
		  ' End the parsing.
		  iterator.callPostParse
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setIterator(iterator as FTIteratorBase)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the new iterator.
		  me.iterator = iterator
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private ftc As FormattedText
	#tag EndProperty

	#tag Property, Flags = &h21
		Private iterator As FTIteratorBase
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
