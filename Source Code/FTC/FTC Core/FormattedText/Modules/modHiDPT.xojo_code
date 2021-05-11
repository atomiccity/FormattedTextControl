#tag Module
Protected Module modHiDPT
	#tag Method, Flags = &h0
		Function MacOS10_7_Or_Better() As Boolean
		  //Retina displays are currently only available on Mac OS and 10.7 or greater.
		  #if TargetMacOS then
		    dim oVersion as OSVersionInfo = OSXVersionInfo.OSVersion
		    
		    return oVersion.major >=10 and oVersion.minor > 6
		    
		    ' dim Major, Minor as integer
		    
		    ' If System.Gestalt("sys1", major) Then
		    ' If System.Gestalt("sys2", minor) Then
		    ' if major >= 10 and minor > 6 then
		    ' return true
		    ' else
		    ' return false
		    ' end
		    ' End If
		    ' End If
		    
		  #else
		    Return false
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ScalingFactor(Extends G As Graphics) As Double
		  #If XojoVersion >= 2016.02 then
		    return g.ScaleX
		  #else
		    #If TargetMacOS Then
		      //This must be checked because Mac OS 10.6 doesn't handle Retina display Mac's.
		      if MacOS10_7_Or_Better = false then
		        return 1
		      end
		      
		      Declare Function CGContextConvertSizeToDeviceSpace Lib "ApplicationServices" (Context As Integer, UserSize As CGSize_FTC) As CGSize_FTC
		      If System.IsFunctionAvailable("CGContextConvertSizeToDeviceSpace","ApplicationServices") Then
		        Dim UserSize As CGSize_FTC
		        UserSize.Width = 100
		        UserSize.Height = 100
		        
		        Dim Handle As Integer = G.Handle(Graphics.HandleTypeCGContextRef)
		        Dim DeviceSize As CGSize_FTC = CGContextConvertSizeToDeviceSpace(Handle,UserSize)
		        Return DeviceSize.Width / UserSize.Width
		      Else
		        Return 1
		      End If
		    #else
		      Return 1
		    #endif
		  #Endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ScalingFactor(Extends W As Window) As Double
		  #If XojoVersion >= 2016.02 then
		    return w.ScaleFactor
		  #else
		    #if TargetMacOS then
		      //This must be checked because Mac OS 10.6 doesn't handle Retina display Mac's.
		      if MacOS10_7_Or_Better = false then
		        return 1
		      end
		      
		      Declare Function BackingScaleFactor Lib "AppKit" Selector "backingScaleFactor" (Target As WindowPtr) As Double
		      Return BackingScaleFactor(W)
		    #else
		      Return 1
		    #endif
		  #Endif
		End Function
	#tag EndMethod


	#tag Note, Name = Telling system to enable High Resolution
		You can add the NSHighResolutionCapable key to your Info.plist at build and debug time using this code in a build automation script:
		
		Dim App As String = CurrentBuildLocation + "/""" + CurrentBuildAppName + ".app"""
		Call DoShellCommand("/usr/bin/defaults write " + App + "/Contents/Info ""NSHighResolutionCapable"" YES")
	#tag EndNote


	#tag Structure, Name = CGSize_FTC, Flags = &h0
		Width as CGFloat
		Height as CGFloat
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
