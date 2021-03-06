#tag Class
Protected Class FTSpellCheckTimer
Inherits FTBaseTimer
	#tag Event
		Sub Action()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim p as FTParagraph
		  
		  ' Are we at the beginning?
		  if index = 0 then needsRestart = false
		  
		  ' Get a paragraph.
		  p = doc.getParagraph(index)
		  
		  ' Does the paragraph exist?
		  if not (p is nil) then
		    
		    ' Spell check the paragraph.
		    p.spellCheckParagraph
		    
		    ' Set up for the next paragraph.
		    index = index + 1
		    
		  else
		    
		    ' Go back to the beginning.
		    index = 0
		    
		    ' Do we need start over?
		    if needsRestart then
		      
		      ' Keep going.
		      mode = Timer.ModeMultiple
		      
		    else
		      
		      ' We can go to sleep.
		      mode = Timer.ModeOff
		      
		    end if
		    
		    ' We got the request.
		    needsRestart = false
		    
		  end if
		  
		exception
		  
		  ' Do nothing.
		  
		End Sub
	#tag EndEvent


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			Type="Integer"
			InheritedFrom="Timer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			Type="Integer"
			InheritedFrom="Timer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Mode"
			Visible=true
			Group="Behavior"
			InitialValue="2"
			Type="Integer"
			EditorType="Enum"
			InheritedFrom="Timer"
			#tag EnumValues
				"0 - Off"
				"1 - Single"
				"2 - Multiple"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
			InheritedFrom="Timer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Period"
			Visible=true
			Group="Behavior"
			InitialValue="1000"
			Type="Integer"
			InheritedFrom="Timer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
			InheritedFrom="Timer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			Type="Integer"
			InheritedFrom="Timer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
