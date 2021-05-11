#tag Class
Protected Class FTTestDragItem
Inherits DragItem
	#tag Method, Flags = &h0
		Sub AddItem(left as integer, top as integer, width as integer, height as integer)
		  
		  #pragma unused left
		  #pragma unused top
		  #pragma unused width
		  #pragma unused height
		  
		  ' Do nothing.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1000
		Sub Constructor()
		  
		  ' Set up the internal data structures.
		  rawDataDictionary = new Dictionary
		  privateRawDataDictionary = new Dictionary
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Drag()
		  
		  ' Do nothing.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FolderItemAvailable() As boolean
		  
		  ' Is there a folder item?
		  return not (FolderItem is nil)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NextItem() As boolean
		  
		  ' We only do one item for testing.
		  return false
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PictureAvailable() As boolean
		  
		  ' Is the picture available?
		  return not (Picture is nil)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PrivateRawData(type as string) As string
		  
		  ' Does it exist?
		  if privateRawDataDictionary.HasKey(type) then
		    
		    ' Return the data.
		    return privateRawDataDictionary.value(type)
		    
		  else
		    
		    ' Nothing found.
		    return ""
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PrivateRawData(type as string, Assigns value as string)
		  
		  ' Save the private data.
		  privateRawDataDictionary.value(type) = value
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RawData(type as string) As string
		  
		  ' Does it exist?
		  if rawDataDictionary.HasKey(type) then
		    
		    ' Return the data.
		    return rawDataDictionary.value(type)
		    
		  else
		    
		    ' Nothing found.
		    return ""
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RawData(type as string, Assigns value as string)
		  
		  ' Save the raw data.
		  rawDataDictionary.value(type) = value
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RawDataAvailable(type as string) As boolean
		  
		  ' Is the raw data available?
		  return rawDataDictionary.HasKey(type)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TextAvailable() As boolean
		  
		  ' Is there any text?
		  return (text.lenb > 0)
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private privateRawDataDictionary As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private rawDataDictionary As Dictionary
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="DragPicture"
			Group="Behavior"
			Type="Picture"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DropHeight"
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DropLeft"
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DropTop"
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DropWidth"
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Handle"
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
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
			Name="Picture"
			Group="Behavior"
			InitialValue="0"
			Type="Picture"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Text"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
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
