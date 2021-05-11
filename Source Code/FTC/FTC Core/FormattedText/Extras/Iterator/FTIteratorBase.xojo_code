#tag Class
Protected Class FTIteratorBase
	#tag Method, Flags = &h0
		Sub callParagraphEnd(p as FTParagraph)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Call the event.
		  ParagraphEnd(p)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub callParagraphStart(p as FTParagraph, pIndex As Integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Call the event.
		  ParagraphStart(p,pIndex)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub callPostParse()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Call the event.
		  PostParse
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub callPreParse()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Call the event.
		  PreParse
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub callStyleRun(fto as FTObject)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Call the event.
		  StyleRun(fto)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub callYield()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Call the event.
		  Yield
		  
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event ParagraphEnd(p as FTParagraph)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ParagraphStart(p as FTParagraph, pIndex As Integer)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event PostParse()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event PreParse()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event StyleRun(fto as FTObject)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Yield()
	#tag EndHook


	#tag Property, Flags = &h0
		doc As FTDocument
	#tag EndProperty

	#tag Property, Flags = &h0
		ftc As FormattedText
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
