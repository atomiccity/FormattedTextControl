#tag Module
Protected Module Limits
	#tag Note, Name = Copyright Notice
		
		Copyright 2002-2015 BKeeney Software Inc. - All Rights Reserved.
		
		This software is freeware and may be used freely without
		royalties or fees.
	#tag EndNote


	#tag Constant, Name = DOUBLE_EPSILON, Type = Double, Dynamic = False, Default = \"2.2250738585072013e-308", Scope = Public
	#tag EndConstant

	#tag Constant, Name = DOUBLE_MAX, Type = Double, Dynamic = False, Default = \"1.7976931348623157e+308", Scope = Public
	#tag EndConstant

	#tag Constant, Name = INTEGER_MAX, Type = Double, Dynamic = False, Default = \"2147483647", Scope = Public
	#tag EndConstant

	#tag Constant, Name = INTEGER_MIN, Type = Integer, Dynamic = False, Default = \"-2147483648", Scope = Public
	#tag EndConstant

	#tag Constant, Name = SHORT_MAX, Type = Integer, Dynamic = False, Default = \"32767", Scope = Public
	#tag EndConstant

	#tag Constant, Name = SHORT_MIN, Type = Integer, Dynamic = False, Default = \"-32768", Scope = Public
	#tag EndConstant

	#tag Constant, Name = SINGLE_EPSILON, Type = Double, Dynamic = False, Default = \"1.175494e-38", Scope = Public
	#tag EndConstant

	#tag Constant, Name = SINGLE_MAX, Type = Double, Dynamic = False, Default = \"3.402823e+38", Scope = Public
	#tag EndConstant

	#tag Constant, Name = UINTEGER_MAX, Type = Double, Dynamic = False, Default = \"4294967295", Scope = Public
	#tag EndConstant

	#tag Constant, Name = USHORT_MAX, Type = Integer, Dynamic = False, Default = \"65535", Scope = Public
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
