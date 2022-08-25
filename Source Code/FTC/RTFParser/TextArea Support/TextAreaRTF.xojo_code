#tag Class
Protected Class TextAreaRTF
Inherits DesktopTextArea
	#tag Event
		Sub MenuBarSelected()
		  
		  #If Not DebugBuild
		    
		    #Pragma BoundsChecking RTF_BOUNDSCHECKING
		    #Pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #Pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #EndIf
		  
		  Dim cb As Clipboard
		  
		  ' Is anything selected?
		  If SelectionLength > 0 Then
		    
		    ' Turn them on.
		    EditCut.Enabled = True
		    EditCopy.Enabled = True
		    
		  Else
		    
		    ' Turn them off.
		    EditCut.Enabled = False
		    EditCopy.Enabled = False
		    
		  End If
		  
		  ' Get the clipboard.
		  cb = New Clipboard
		  
		  ' Is there something we can paste (plain text or RTF)?
		  If cb.TextAvailable Or cb.RawDataAvailable(RTF_DATA_TYPE) Then
		    
		    ' Turn it on.
		    EditPaste.Enabled = True
		    
		  Else
		    
		    ' Turn it off.
		    EditPaste.Enabled = False
		    
		  End If
		  
		  ' Release the clipboard.
		  cb.close
		  
		End Sub
	#tag EndEvent


	#tag MenuHandler
		Function EditCopy() As Boolean Handles EditCopy.Action
			
			#if not DebugBuild
			
			#pragma BoundsChecking RTF_BOUNDSCHECKING
			#pragma NilObjectChecking RTF_NILOBJECTCHECKING
			#pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
			
			#endif
			
			' Copy to the clipboard.
			editCopyAction
			
			' We handled it.
			return true
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function EditCut() As Boolean Handles EditCut.Action
			
			#if not DebugBuild
			
			#pragma BoundsChecking RTF_BOUNDSCHECKING
			#pragma NilObjectChecking RTF_NILOBJECTCHECKING
			#pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
			
			#endif
			
			' Cut to the clipboard.
			editCutAction
			
			' We handled it.
			return true
			
		End Function
	#tag EndMenuHandler

	#tag MenuHandler
		Function EditPaste() As Boolean Handles EditPaste.Action
			
			#if not DebugBuild
			
			#pragma BoundsChecking RTF_BOUNDSCHECKING
			#pragma NilObjectChecking RTF_NILOBJECTCHECKING
			#pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
			
			#endif
			
			' Paste the from the clipboard.
			editPasteAction
			
			' We handled it.
			return true
			
		End Function
	#tag EndMenuHandler


	#tag Method, Flags = &h21
		Private Sub copySelection()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim cb as Clipboard
		  
		  ' Is there anything to copy?
		  if SelectionLength = 0 then return
		  
		  ' Create a clipboard object.
		  cb = new Clipboard
		  
		  ' Copy the plain text.
		  cb.Text = SelectedText
		  
		  ' Copy the RTF.
		  cb.AddRawData(me.getSelectedRTF, RTF_DATA_TYPE)
		  
		  ' Close the clipboard.
		  cb.close
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub editCopyAction()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Copy the current selection.
		  copySelection
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub editCutAction()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Is there anything to do?
		  if SelectionLength = 0 then return
		  
		  ' Copy the current selection.
		  copySelection
		  
		  ' Delete the currently selected text.
		  SelectedText = ""
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub editPasteAction()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim cb as Clipboard
		  
		  ' Create a clipboard object.
		  cb = new Clipboard
		  
		  ' Is RTF data available?
		  if cb.RawDataAvailable(RTF_DATA_TYPE) then
		    
		    ' Insert the RTF.
		    me.setRTF(cb.RawData(RTF_DATA_TYPE))
		    
		    ' Close the clipboard.
		    cb.close
		    
		  else
		    
		    ' Close the clipboard.
		    cb.close
		    
		    ' Use the built in paste.
		    paste
		    
		  end if
		  
		  
		End Sub
	#tag EndMethod


	#tag Constant, Name = RTF_DATA_TYPE, Type = String, Dynamic = False, Default = \"public.rtf", Scope = Public
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"Rich Text Format"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"text/rtf"
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Text"
			Visible=true
			Group="Initial State"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowAutoDeactivate"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="BackgroundColor"
			Visible=true
			Group="Appearance"
			InitialValue="&hFFFFFF"
			Type="ColorGroup"
			EditorType="ColorGroup"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasBorder"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Tooltip"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasHorizontalScrollbar"
			Visible=true
			Group="Appearance"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasVerticalScrollbar"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowStyledText"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Transparent"
			Visible=true
			Group="Appearance"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowFocusRing"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="FontName"
			Visible=true
			Group="Font"
			InitialValue="System"
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="FontSize"
			Visible=true
			Group="Font"
			InitialValue="0"
			Type="Single"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="FontUnit"
			Visible=true
			Group="Font"
			InitialValue="0"
			Type="FontUnits"
			EditorType="Enum"
			#tag EnumValues
				"0 - Default"
				"1 - Pixel"
				"2 - Point"
				"3 - Inch"
				"4 - Millimeter"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowTabs"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TextAlignment"
			Visible=true
			Group="Behavior"
			InitialValue="0"
			Type="TextAlignments"
			EditorType="Enum"
			#tag EnumValues
				"0 - Default"
				"1 - Left"
				"2 - Center"
				"3 - Right"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowSpellChecking"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MaximumCharactersAllowed"
			Visible=true
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ValidationMask"
			Visible=true
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="UnicodeMode"
			Visible=true
			Group="Selection Behavior"
			InitialValue="0"
			Type="DesktopTextArea.UnicodeModes"
			EditorType="Enum"
			#tag EnumValues
				"0 - Native"
				"1 - Characters"
				"2 - Codepoints"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="Bold"
			Visible=true
			Group="Font"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Enabled"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Format"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Height"
			Visible=true
			Group="Position"
			InitialValue="100"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HideSelection"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Italic"
			Visible=true
			Group="Font"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LineHeight"
			Visible=true
			Group="Appearance"
			InitialValue="0"
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LineSpacing"
			Visible=true
			Group="Appearance"
			InitialValue="1"
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockBottom"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockLeft"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockRight"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockTop"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Multiline"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ReadOnly"
			Visible=true
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
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
			Name="TabIndex"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabPanelIndex"
			Visible=false
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabStop"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TextColor"
			Visible=true
			Group="Appearance"
			InitialValue="&h000000"
			Type="ColorGroup"
			EditorType="ColorGroup"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Underline"
			Visible=true
			Group="Font"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Visible"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Width"
			Visible=true
			Group="Position"
			InitialValue="100"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
