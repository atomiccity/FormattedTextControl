#tag Class
Protected Class FTCUndoImage
Inherits FTCUndoBase
	#tag Method, Flags = &h0
		Sub changePictureSize(width as integer, height as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim p as FTPicture
		  
		  ' Get the picture.
		  p = doc.getPictureAtOffset(startPosition)
		  
		  ' Did we get a picture?
		  if p is nil then
		    
		    ' We should not get here!
		    break
		    
		    ' Exit.
		    return
		    
		  end if
		  
		  ' Set the width and height of the picture.
		  p.setPictureSize(width, height)
		  
		  ' Mark the paragraph as dirty.
		  doc.getParagraph(startPosition.paragraph).makeDirty
		  
		  ' Deselect everything.
		  doc.deselectAll
		  doc.deselectResizePictures
		  
		  ' Select the picture.
		  doc.selectSegment(startPosition - 1, startPosition)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub constructor(parent as FTCUndoManager, styleName as string, offset as FTInsertionOffset, oldWidth as integer, oldHeight as integer, newWidth as integer, newHeight as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Initialize the base.
		  Super.Constructor(parent, styleName)
		  
		  ' Save the offset.
		  me.startPosition = offset.clone
		  
		  ' Save the sizes.
		  me.oldWidth = oldWidth
		  me.oldHeight = oldHeight
		  me.newWidth = newWidth
		  me.newHeight = newHeight
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub redo()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Change the size of the picture.
		  changePictureSize(newWidth, newHeight)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub undo()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Change the size of the picture.
		  changePictureSize(oldWidth, oldHeight)
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		newHeight As integer
	#tag EndProperty

	#tag Property, Flags = &h0
		newWidth As integer
	#tag EndProperty

	#tag Property, Flags = &h0
		oldHeight As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		oldWidth As Integer
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="content"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
			InheritedFrom="FTCUndoBase"
		#tag EndViewProperty
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
			Name="length"
			Group="Behavior"
			InitialValue="0"
			Type="integer"
			InheritedFrom="FTCUndoBase"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="newHeight"
			Group="Behavior"
			InitialValue="0"
			Type="integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="newWidth"
			Group="Behavior"
			InitialValue="0"
			Type="integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="oldHeight"
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="oldWidth"
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
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
		#tag ViewProperty
			Name="undoName"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
			InheritedFrom="FTCUndoBase"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
