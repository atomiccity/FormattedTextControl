#tag Module
Protected Module GUGraphics
	#tag Method, Flags = &h0
		Function centerStringOffset(extends g as graphics, s as string, width as integer) As integer
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  Dim offset as integer
		  Dim delta as integer
		  Dim sw as integer
		  
		  ' Get the width of the string.
		  sw = g.StringWidth(s)
		  
		  ' Calculate how much space we have to work with.
		  delta = width - sw
		  
		  ' Is the string wider then the specified width?
		  if delta > 0 then
		    
		    ' Calculate the centered offset.
		    offset = delta / 2
		    
		  else
		    
		    ' Default to left justified.
		    offset = 0
		    
		  end if
		  
		  ' Return the center offset.
		  return offset
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub erase(extends g as graphics)
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  Dim c as Color
		  
		  ' Save the forecolor.
		  c = g.ForeColor
		  
		  ' Set the color to white.
		  g.ForeColor = &cFFFFFF
		  
		  ' Clear the entire picture.
		  g.FillRect(0, 0, g.Width, g.Height)
		  
		  ' Restore the forecolor.
		  g.ForeColor = c
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function findBestFitString(extends g as Graphics, s as string, width as integer, ByRef leftOver as string) As string
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  Dim i as integer
		  Dim current as string
		  Dim length as integer
		  
		  ' Get the length of the string.
		  length = Len(s)
		  
		  ' Find a length that will fit in the width.
		  for i = length downto 1
		    
		    ' Pull out a chunk of the text.
		    current = Left(s, i)
		    
		    ' Will this string fit the wrap width?
		    if g.StringWidth(current) <= width then
		      
		      ' Copy the left over string.
		      leftOver = Mid(s, i + 1)
		      
		      ' We found a string that will fit.
		      return current
		      
		    end if
		    
		  next
		  
		  ' The entire string is left over.
		  leftOver = s
		  
		  ' Nothing will fit.
		  return ""
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setPen(extends g as graphics, pixels as integer)
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  ' Set the pen width and height.
		  g.PenWidth = pixels
		  g.PenHeight = pixels
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setStyleRunCharacteristics(extends g as graphics, sr as StyleRun, scaleFactor as double = 1.0)
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  ' Set the drawing characteristics for the style.
		  g.Bold = sr.Bold
		  g.TextFont = sr.Font
		  g.Italic = sr.Italic
		  g.TextSize = sr.Size * scaleFactor
		  g.ForeColor = sr.TextColor
		  g.Underline = sr.Underline
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = Copyright Notice
		
		Copyright 2002-2015 BKeeney Software Inc. - All Rights Reserved.
		
		This software is freeware and may be used freely without
		royalties or fees.
	#tag EndNote

	#tag Note, Name = Usage
		
		Best viewed in font "Courier New" with font size of 12.
		
		This module contains general utility functions and subroutines.
		
		centerStringOffset
		------------------
		
		  Description:
		    
		    This function returns an offset that will center the
		    string in the specified width. If the string is wider
		    than the specified width then zero is returned.
		
		  Parameters:
		
		    extends g as Graphics:
		      The graphics object.
		            
		    s as string:
		      The source string.
		      
		    width as integer:
		      The target width for string.
		
		  Return:
		
		    integer:
		      Center offset for the specified width.
		
		
		erase
		-----
		
		  Description:
		    
		    This subroutine erases the entire picture (Sets every pixel
		    to white).
		
		  Parameters:
		
		    extends g as Graphics:
		      The graphics object.
		
		  Return:
		
		    None.
		
		
		findBestFitString
		-----------------
		
		  Description:
		    
		    This function returns a string that will fit in the
		    specified width. This is useful when printing.
		
		  Parameters:
		
		    extends g as Graphics:
		      The graphics object.
		      
		    s as string:
		      The source string.
		      
		    width as integer:
		      The target width for string.
		    
		    ByRef leftOver as string:
		      The right half of the string that was cut off.
		
		  Return:
		
		    string:
		      The string that will fit in the specified width.
		
		
		setPen
		------
		
		  Description:
		
		    This subroutine extends the graphics class to provide a
		    convenience method for setting the pen drawing thickness.
		
		  Parameters:
		
		    extends g as graphics:
		      The graphics object.
		
		    pixels as integer:
		      The thickness of the pen.
		
		  Return:
		
		    None.
		
		
		setStyleRunCharacteristics
		--------------------------
		
		  Description:
		
		    This subroutine extends the graphics class to set the
		    drawing characteristics based on a the settings of a
		    StyleRun.
		
		  Parameters:
		
		    extends g as graphics:
		      The graphics object.
		
		    sr as StyleRun:
		      The style run.
		      
		    scaleFactor as double = 1.0:
		      The print scaling factor.
		
		  Return:
		
		    None.
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
