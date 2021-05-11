#tag Module
Protected Module GUPrint
	#tag Method, Flags = &h0
		Function getBottomMargin(extends ps as PrinterSetup, margin as double) As integer
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  Dim printableMargin as integer
		  
		  ' Calculate the pixel offset for the margin.
		  printableMargin = ps.PageHeight - (margin * ps.HorizontalResolution)
		  
		  ' Is the calculated margin less than the printable margin.
		  if printableMargin > ps.physicalPageBottom then
		    
		    ' Use the printable margin.
		    printableMargin = ps.Height
		    
		  else
		    
		    ' Translate to the printable area coordinates.
		    printableMargin = printableMargin - Abs(ps.PageTop)
		    
		  end if
		  
		  ' Return the printable margin.
		  return printableMargin
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getHorizontalScaleFactor(extends ps as PrinterSetup, resolution as integer = 72) As double
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  ' Return the horizontal scaling factor.
		  return ps.HorizontalResolution / resolution
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getLeftMargin(extends ps as PrinterSetup, margin as double) As integer
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  Dim printableMargin as integer
		  
		  ' Calculate the pixel offset for the margin.
		  printableMargin = margin * ps.HorizontalResolution
		  
		  ' Is the calculated margin less than the printable margin.
		  if printableMargin < ps.PhysicalPageLeft then
		    
		    ' Use the printable margin.
		    printableMargin = Abs(ps.PageLeft)
		    
		  else
		    
		    ' Translate to the printable area coordinates.
		    printableMargin = printableMargin - Abs(ps.PageLeft)
		    
		  end if
		  
		  ' Return the printable margin.
		  return printableMargin
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getRightMargin(extends ps as PrinterSetup, margin as double, resolution as integer = 72) As integer
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  #pragma Unused resolution
		  
		  Dim printableMargin as integer
		  
		  ' Calculate the pixel offset for the margin.
		  printableMargin = ps.PageWidth - (margin * ps.HorizontalResolution)
		  
		  ' Is the calculated margin less than the printable margin.
		  if printableMargin > ps.PhysicalPageRight then
		    
		    ' Use the printable margin.
		    printableMargin = ps.Width
		    
		  else
		    
		    ' Translate to the printable area coordinates.
		    printableMargin = printableMargin - Abs(ps.PageLeft)
		    
		  end if
		  
		  ' Return the printable margin.
		  return printableMargin
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getTopMargin(extends ps as PrinterSetup, margin as double, resolution as integer = 72) As integer
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  #pragma Unused resolution
		  
		  Dim printableMargin as integer
		  
		  ' Calculate the pixel offset for the margin.
		  printableMargin = margin * ps.HorizontalResolution
		  
		  ' Is the calculated margin less than the printable margin.
		  if printableMargin < ps.PhysicalPageTop then
		    
		    ' Use the printable margin.
		    printableMargin = Abs(ps.PageTop)
		    
		  else
		    
		    ' Translate to the printable area coordinates.
		    printableMargin = printableMargin - Abs(ps.PageTop)
		    
		  end if
		  
		  ' Return the printable margin.
		  return printableMargin
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getVerticalScaleFactor(extends ps as PrinterSetup, resolution as integer = 72) As double
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  ' Return the vertical scaling factor.
		  return ps.VerticalResolution / resolution
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function physicalPageBottom(extends ps as PrinterSetup) As integer
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  ' Calculate the bottom side of the printable area.
		  return abs(ps.PageTop) + ps.height
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function physicalPageLeft(extends ps as PrinterSetup) As integer
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  ' Calculate the left side of the printable area.
		  return abs(ps.PageLeft)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function physicalPageRight(extends ps as PrinterSetup) As integer
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  ' Calculate the right side of the printable area.
		  return abs(ps.PageLeft) + ps.width
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function physicalPageTop(extends ps as PrinterSetup) As integer
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  ' Calculate the top side of the printable area.
		  return abs(ps.PageTop)
		  
		End Function
	#tag EndMethod


	#tag Note, Name = Copyright Notice
		
		Copyright 2002-2015 BKeeney Software Inc. - All Rights Reserved.
		
		This software is freeware and may be used freely without
		royalties or fees.
	#tag EndNote

	#tag Note, Name = Usage
		
		Best viewed in font "Courier New" with font size of 12.
		
		This module contains general utility functions and subroutines.
		
		getBottomMargin
		getLeftMargin
		getRightMargin
		getTopMargin
		---------------
		
		  Description:
		
		    This function returns the number of pixels that
		    represents the margin specified in inches. If the
		    specified margin is less than the printable area, then
		    the printable margin is returned.
		
		  Parameters:
		
		    extends ps as PrinterSetup:
		      The printer setup object.
		      
		    margin as double:
		      The desired margin in inches.
		    
		  Return:
		
		    integer:
		      The number of pixels that represents the margin.
		
		
		getHorizontalScaleFactor
		getVerticalScaleFactor
		------------------------
		
		  Description:
		
		    These functions return the scale factor for converting
		    measurements from another graphics port to the printing
		    port.
		
		  Parameters:
		
		    extends ps as PrinterSetup:
		      The printer setup object.
		      
		    resolution as integer = 72:
		      The resolution of the graphics port you are converting from.
		      
		  Return:
		
		    double:
		      The scale factor.
		      
		
		physicalPageBottom
		physicalPageLeft
		physicalPageRight
		physicalPageTop
		------------------
		
		  Description:
		
		    This function returns the physical margin for the page.
		
		  Parameters:
		
		    extends ps as PrinterSetup:
		      The printer setup object.
		      
		  Return:
		
		    Integer:
		      The physical margin.
	#tag EndNote


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
