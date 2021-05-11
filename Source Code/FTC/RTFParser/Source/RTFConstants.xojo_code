#tag Module
Protected Module RTFConstants
	#tag Constant, Name = RTF_BOUNDSCHECKING, Type = Boolean, Dynamic = False, Default = \"false", Scope = Public
	#tag EndConstant

	#tag Constant, Name = RTF_NILOBJECTCHECKING, Type = Boolean, Dynamic = False, Default = \"false", Scope = Public
	#tag EndConstant

	#tag Constant, Name = RTF_STACKOVERFLOWCHECKING, Type = Boolean, Dynamic = False, Default = \"false", Scope = Public
	#tag EndConstant

	#tag Constant, Name = VERSION, Type = String, Dynamic = False, Default = \"1.0.3", Scope = Public
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Module
#tag EndModule
