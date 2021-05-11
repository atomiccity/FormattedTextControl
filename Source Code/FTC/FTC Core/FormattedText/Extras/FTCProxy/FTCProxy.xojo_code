#tag Class
Protected Class FTCProxy
	#tag Method, Flags = &h0
		Function callConstructContexualMenu(base as MenuItem, x as integer, y as integer) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Call the event.
		  return ftc.callConstructContexualMenu(base, x, y)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function callContextualMenuAction(hitItem as MenuItem) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Call the event.
		  return ftc.callContextualMenuAction(hitItem)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub callDropObject(obj as DragItem, action as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Call the event.
		  ftc.callDropObject(obj, action)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub callEnableMenuItems()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Call the event.
		  ftc.callEnableMenuItems
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub callGotFocus()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Call the event.
		  ftc.callGotFocus
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function callKeyDown(key as string) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Call the event.
		  return ftc.callKeyDown(key)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub callLostFocus()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Call the event.
		  ftc.callLostFocus
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function callMouseDown(x as integer, y as integer) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Call the event.
		  return ftc.callMouseDown(x, y)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub callMouseDrag(x as integer, y as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Call the event.
		  ftc.callMouseDrag(x, y)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub callMouseEnter()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Call the event.
		  ftc.callMouseEnter
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub callMouseExit()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Call the event.
		  ftc.callMouseExit
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub callMouseMove(x as integer, y as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Call the event.
		  ftc.callMouseMove(x, y)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub callMouseUp(x as integer, y as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Call the event.
		  ftc.callMouseUp(x, y)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function callMouseWheel(x as integer, y as integer, deltaX as integer, deltaY as integer) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Call the event.
		  return ftc.callMouseWheel(x, y, deltaX, deltaY)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(target as TextInputCanvas, ftc as FormattedTextProxy)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Extract the control.
		  me.ftc = ftc
		  
		  ' Let the control know the target.
		  ftc.setReferences(target)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isPointInControl(x as integer, y as integer) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Is the point in the control?
		  return ftc.adjustCoordinates(x, y)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub resize()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Update the display.
		  ftc.resize
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setDimensions(width as integer, height as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set the dimensions of the control.
		  ftc.setDimensions(width, height)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub setPosition(x as integer, y as integer)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set the position of the control.
		  ftc.setPosition(x, y)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub update(compose as boolean)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Update the display.
		  ftc.update(compose, true)
		  
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event XmlObjectCreate(obj as XmlElement) As FTObject
	#tag EndHook


	#tag Property, Flags = &h0
		ftc As FormattedTextProxy
	#tag EndProperty


	#tag ViewBehavior
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
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
			InheritedFrom="Object"
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
	#tag EndViewBehavior
End Class
#tag EndClass
