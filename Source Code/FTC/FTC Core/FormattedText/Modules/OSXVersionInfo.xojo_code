#tag Module
Protected Module OSXVersionInfo
	#tag Method, Flags = &h0
		Function appKitVersionNumber() As double
		  // Const appKitVersionNumber10_8 = 1187
		  // Const appKitVersionNumber10_9 = 1265
		  // Const appKitVersionNumber10_10 = 1328
		  
		  Declare Function dlopen Lib "System" ( path As CString, mode As Integer ) As ptr
		  Declare Function dlsym Lib "System" ( handle As PTr, name As CString ) As ptr
		  
		  Const RTLD_LAZY = 1
		  Const RTLD_GLOBAL = 8
		  
		  Dim libPtr As ptr = dlopen( "/System/Library/Frameworks/AppKit.framework/AppKit", RTLD_LAZY Or RTLD_GLOBAL )
		  If libPtr = Nil Then return 0
		  
		  Dim rvalue as Ptr = dlsym( libPtr, "NSAppKitVersionNumber" )
		  
		  if rvalue <> nil then return rvalue.double
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function OSVersion() As OSVersionInfo
		  Dim rvalue as OSVersionInfo
		  if appKitVersionNumber >= appKitVersionNumber10_10 then
		    // --- We're using 10.10
		    #if TargetMacOS
		      declare function NSClassFromString lib "AppKit" ( className as CFStringRef ) as Ptr
		      declare function processInfo lib "AppKit" selector "processInfo" ( ClassRef as Ptr ) as Ptr
		      Dim myInfo as Ptr = processInfo( NSClassFromString( "NSProcessInfo" ) )
		      declare function operatingSystemVersion lib "AppKit" selector "operatingSystemVersion" ( NSProcessInfo as Ptr ) as OSVersionInfo
		      rvalue = operatingSystemVersion( myInfo )
		    #Endif
		  else
		    dim minor, bug as Integer
		    call System.Gestalt( "sys2", minor )
		    call System.Gestalt( "sys3", bug )
		    
		    rvalue.major = 10
		    rvalue.minor = minor
		    rvalue.bug = bug
		    
		  end if
		  
		  return rvalue
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function osVersionHumanReadable() As string
		  #if TargetMacOS then
		    declare function NSClassFromString lib "AppKit" ( className as CFStringRef ) as Ptr
		    declare function processInfo lib "AppKit" selector "processInfo" ( classRef as Ptr ) as Ptr
		    dim myProcess as Ptr = processInfo( NSClassFromString( "NSProcessInfo" ) )
		    
		    declare function operatingSystemVersionString lib "AppKit" selector "operatingSystemVersionString" ( NSProcessInfo as Ptr ) as CFStringRef
		    return operatingSystemVersionString( myProcess )
		  #endif
		End Function
	#tag EndMethod


	#tag Note, Name = Notes
		Originally from Ohanaware.  http://ohanaware.com
		
	#tag EndNote


	#tag Constant, Name = appKitVersionNumber10_10, Type = Double, Dynamic = False, Default = \"1328", Scope = Public
	#tag EndConstant

	#tag Constant, Name = appKitVersionNumber10_8, Type = Double, Dynamic = False, Default = \"1187", Scope = Public
	#tag EndConstant

	#tag Constant, Name = appKitVersionNumber10_9, Type = Double, Dynamic = False, Default = \"1265", Scope = Public
	#tag EndConstant


	#tag Structure, Name = OSVersionInfo, Flags = &h0
		major as integer
		  minor as integer
		bug as integer
	#tag EndStructure


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
