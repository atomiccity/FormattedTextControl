#tag Module
Protected Module FTCPragma
	#tag Constant, Name = FTC_BOUNDSCHECKING, Type = Boolean, Dynamic = False, Default = \"false", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FTC_NILOBJECTCHECKING, Type = Boolean, Dynamic = False, Default = \"false", Scope = Public
	#tag EndConstant

	#tag Constant, Name = FTC_STACKOVERFLOWCHECKING, Type = Boolean, Dynamic = False, Default = \"false", Scope = Public
	#tag EndConstant


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
End Module
#tag EndModule
