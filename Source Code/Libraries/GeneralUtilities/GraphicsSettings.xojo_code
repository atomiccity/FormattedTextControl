#tag Class
Protected Class GraphicsSettings
	#tag Method, Flags = &h0
		Sub Constructor(g as graphics)
		  
		  #if not DebugBuild
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  ' Save the settings.
		  saveSettings(g)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub restoreSettings(g as graphics)
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  ' Restore the state of the graphics object.
		  g.Bold = bold
		  g.ForeColor = foreColor
		  g.Italic = italic
		  g.PenHeight = penHeight
		  g.PenWidth = penWidth
		  g.TextFont = textFont
		  g.TextSize = textSize
		  g.Underline = underline
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub saveSettings(g as graphics)
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  ' Save the state of the graphics object.
		  bold = g.Bold
		  foreColor = g.ForeColor
		  italic = g.Italic
		  penHeight = g.PenHeight
		  penWidth = g.PenWidth
		  textFont = g.TextFont
		  textSize = g.TextSize
		  underline = g.Underline
		  
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
		
		This class will save the current settings of the graphics
		port passed into the constructor. This class is useful for
		preserving settings across calls that change the graphics
		port settings.
		
		Constructor
		-----------
		
		  Description:
		
		    This constructor saves the current settings of the
		    graphics port.
		
		  Parameters:
		
		    g as graphics:
		      The graphics port.
		    
		  Return:
		
		    None.
		
		
		restoreSettings
		---------------
		
		  Description:
		
		    This method restores the settings previously stored in
		    this object.
		
		  Parameters:
		
		    g as graphics:
		      The graphics port.  
		        
		  Return:
		
		    None.
		
		
		saveSettings
		------------
		
		  Description:
		
		    This method saves the settings of the specified graphics
		    port in this object.
		
		  Parameters:
		
		    g as graphics:
		      The graphics port.  
		    
		  Return:
		
		    None.
	#tag EndNote


	#tag Property, Flags = &h1
		Protected bold As boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected foreColor As Color
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected italic As boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected penHeight As integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected penWidth As integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected textFont As string
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected textSize As integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected underline As boolean
	#tag EndProperty


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
End Class
#tag EndClass
