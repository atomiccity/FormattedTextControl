#tag Module
Protected Module modExtends
	#tag Method, Flags = &h0
		Sub AddItemAndTag(extends base as DesktopMenuItem, sText as string, Tag as Variant)
		  base.AddMenu(New DesktopMenuItem(sText))
		  base.MenuAt(base.Count - 1).Tag = tag
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DrawTriangle(extends lst as DesktopListBox, g as Graphics, bSelected as Boolean = false)
		  #Pragma Unused lst
		  
		  // Settings
		  const kPadding = 5
		  
		  // Get Original ForeColor
		  Dim c As Color = g.ForeColor
		  
		  // Draw an arrow to indicate that clicking this field will
		  g.ForeColor = &c8c8c8c
		  
		  If bSelected Then 
		    g.ForeColor = &c000000
		  End
		  
		  // Points for a triangle on the right side of the cell
		  Dim points(6) As Integer
		  points(1) = g.Width - 16
		  points(2) = kPadding + ((g.Height - 16) / 2)
		  
		  points(3) = g.Width - 6
		  points(4) = kPadding + ((g.Height - 16) / 2)
		  
		  points(5) = g.Width - 11
		  points(6) = 12 + ((g.Height - 16) / 2)
		  
		  g.FillPolygon(points)
		  
		  g.ForeColor = c
		End Sub
	#tag EndMethod


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Module
#tag EndModule
