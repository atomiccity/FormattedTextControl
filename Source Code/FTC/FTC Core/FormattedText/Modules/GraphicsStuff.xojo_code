#tag Module
Protected Module GraphicsStuff
	#tag Method, Flags = &h0
		Function GetPictureShadow(pic As Picture, shadowColor As Color, shadowBlur As Double, shadowOpacity As single) As Picture
		  // Returns Picture of just the shadow of pic
		  //   shadowColor is the shadow color
		  //   shadowBlur is the blurriness from 0 (solid) to 100 (almost transparent)
		  //   shadowOpacity is the opacity of the shadow from 0 (transparent) to 1 (opaque)
		  
		  #if TargetMacOS then
		    #if DebugBuild then
		      if shadowOpacity <1 and shadowOpacity>0 then
		        MsgBox "shadowOpacity needs to be 0-100!!!!"
		        Break
		        Return nil
		        
		      end if
		    #endif
		    
		    Declare Sub CGContextDrawImage Lib "CoreGraphics" (context As Integer, rect As CGRect_FTC, image As Ptr)
		    Declare Sub CGContextSetShadow Lib "CoreGraphics" (context As Integer, offset As CGSize_FTC, blur As CGFloat)
		    Declare Sub CGContextSetShadowWithColor Lib "CoreGraphics" (context As Integer, offset As CGSize_FTC, blur As CGFloat, colorref As Ptr)
		    Declare Function CGColorSpaceCreateWithName Lib "CoreGraphics" (name As CFStringRef) As Ptr
		    Declare Function CGColorCreate Lib "CoreGraphics" (space As Ptr, components As Ptr) As Ptr
		    
		    Declare Sub CFRelease Lib "CoreFoundation" (obj As ptr)
		    
		    Dim temp, result As Picture
		    Dim g As Graphics
		    Dim context As Integer
		    Dim p, cspace, colorref As Ptr
		    Dim r As CGRect_FTC
		    Dim offset As CGSize_FTC
		    Dim components As MemoryBlock
		    
		    temp = New Picture(pic.Width * 2 + shadowBlur * 2, pic.Height + shadowBlur * 2)
		    g = temp.Graphics
		    
		    context = g.Handle(g.HandleTypeCGContextRef)
		    p = pic.CopyOSHandle(Picture.HandleType.MacCGImage)
		    
		    r.origin.x = 0
		    r.origin.y = (temp.Height - pic.Height) / 2
		    r.rsize.width = pic.Width
		    r.rsize.height = pic.Height
		    offset.width = pic.Width + shadowBlur
		    offset.height = 0
		    
		    #If Target32Bit
		      
		      components = New MemoryBlock(4 * 4) ' 4 components per color * sizeof(Single)
		      components.SingleValue(0 * 4) = shadowColor.Red / 255
		      components.SingleValue(1 * 4) = shadowColor.Green / 255
		      components.SingleValue(2 * 4) = shadowColor.Blue / 255
		      components.SingleValue(3 * 4) = shadowOpacity /100 ' must be single /100 (0 = no Shadow, 100 = 100% Shadow)
		      
		    #ElseIf Target64Bit
		      
		      components = New MemoryBlock(4 * 8) ' 4 components per color * sizeof(Single)
		      components.DoubleValue(0 * 8) = shadowColor.Red / 255
		      components.DoubleValue(1 * 8) = shadowColor.Green / 255
		      components.DoubleValue(2 * 8) = shadowColor.Blue / 255
		      components.DoubleValue(3 * 8) = shadowOpacity /100 ' must be single /100 (0 = no Shadow, 100 = 100% Shadow)
		      
		    #EndIf
		    
		    
		    
		    cspace = CGColorSpaceCreateWithName("kCGColorSpaceGenericRGB")
		    colorref = CGColorCreate(cspace, components)
		    
		    
		    'Declare Function CGColorGetAlpha  Lib "ApplicationServices"  (ref as PTR) as Double
		    'Dim iCol as Double =CGColorGetAlpha(colorref)
		    
		    CGContextSetShadowWithColor context, offset, shadowBlur, colorref
		    CGContextDrawImage context, r, p
		    CFRelease p
		    
		    result = New Picture(temp.Width - pic.Width, temp.Height)
		    result.Graphics.DrawPicture temp, 0, 0, result.Width, result.Height, pic.Width, 0, result.Width, result.Height
		    
		    Return result
		  #elseif TargetWindows then
		    Break
		    
		  #endif
		End Function
	#tag EndMethod


	#tag Constant, Name = Rads2DegMultiplier, Type = Double, Dynamic = False, Default = \"0.01745329252", Scope = Public
	#tag EndConstant


	#tag Structure, Name = CGPoint_FTC, Flags = &h1
		x as CGFloat
		y as CGFloat
	#tag EndStructure

	#tag Structure, Name = CGRect_FTC, Flags = &h1
		origin as CGPoint_FTC
		rsize as CGSize_FTC
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
