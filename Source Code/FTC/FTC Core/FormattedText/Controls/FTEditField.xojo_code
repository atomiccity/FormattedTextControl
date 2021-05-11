#tag Class
Protected Class FTEditField
Inherits FormattedText
	#tag Event
		Function GetHorizontalScrollbar() As FTScrollbar
		  
		  ' Do not delete this comment!!!
		  '
		  ' This comment prevents the horizontal scroll bar from being added.
		  
		End Function
	#tag EndEvent

	#tag Event
		Sub Open()
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Set up for edit view mode.
		  setEditViewMode(0.06)
		  
		  ' Turn off pilcrows.
		  ShowPilcrows = false
		  
		  ' Call the event.
		  Open
		  
		End Sub
	#tag EndEvent


	#tag Hook, Flags = &h0
		Event Open()
	#tag EndHook


	#tag Property, Flags = &h21
		Private ignoreMe As Integer
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="AllowBackgroundUpdates"
			Visible=true
			Group="FT Behavior"
			InitialValue="True"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowPictures"
			Visible=true
			Group="FT Behavior"
			InitialValue="True"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AutoComplete"
			Visible=true
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AutoDeactivate"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="BackgroundColor"
			Visible=true
			Group="FT Behavior"
			InitialValue="&cA0ADCD"
			Type="Color"
		#tag EndViewProperty
		#tag ViewProperty
			Name="BorderColor"
			Visible=true
			Group="FT Behavior"
			InitialValue="&ca0a0a0"
			Type="color"
		#tag EndViewProperty
		#tag ViewProperty
			Name="BottomMargin"
			Visible=true
			Group="FT Page Mode"
			InitialValue="0"
			Type="double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="CaretColor"
			Visible=true
			Group="FT Behavior"
			InitialValue="&c000000"
			Type="Color"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DefaultFont"
			Visible=true
			Group="FT Defaults"
			InitialValue="Arial"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DefaultFontSize"
			Visible=true
			Group="FT Defaults"
			InitialValue="12"
			Type="integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="defaultHyperLinkColor"
			Group="Behavior"
			InitialValue="&c0000ff"
			Type="Color"
		#tag EndViewProperty
		#tag ViewProperty
			Name="defaultHyperLinkColorDisabled"
			Group="Behavior"
			InitialValue="&ccccccc"
			Type="Color"
		#tag EndViewProperty
		#tag ViewProperty
			Name="defaultHyperLinkColorRollover"
			Group="Behavior"
			InitialValue="&cFF0000"
			Type="Color"
		#tag EndViewProperty
		#tag ViewProperty
			Name="defaultHyperLinkColorVisited"
			Group="Behavior"
			InitialValue="&c800080"
			Type="Color"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DefaultTabStop"
			Visible=true
			Group="FT Defaults"
			InitialValue="0.5"
			Type="double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DefaultTextColor"
			Visible=true
			Group="FT Defaults"
			InitialValue="&c000000"
			Type="Color"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DisplayAlignment"
			Visible=true
			Group="FT Mode"
			InitialValue="0"
			Type="Display_Alignment"
			EditorType="Enum"
			#tag EnumValues
				"0 - Left"
				"1 - Center"
				"2 - Right"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="DragAndDrop"
			Visible=true
			Group="FT Behavior"
			InitialValue="True"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DrawControlBorder"
			Visible=true
			Group="FT Behavior"
			InitialValue="true"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="EditViewMargin"
			Visible=true
			Group="FT Edit Mode"
			InitialValue="0.06"
			Type="double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="EditViewPrintMargin"
			Visible=true
			Group="FT Edit Mode"
			InitialValue="0.5"
			Type="double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Enabled"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Height"
			Visible=true
			Group="Position"
			InitialValue="100"
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HelpTag"
			Visible=true
			Group="Appearance"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HScrollbarAutoHide"
			Visible=true
			Group="FT Behavior"
			InitialValue="False"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="InhibitSelections"
			Visible=true
			Group="FT Behavior"
			InitialValue="False"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="InitialParent"
			Group="Position"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="InvisiblesColor"
			Visible=true
			Group="FT Behavior"
			InitialValue="&c526AFF"
			Type="Color"
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsHiDPT"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LeftMargin"
			Visible=true
			Group="FT Page Mode"
			InitialValue="0"
			Type="double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockBottom"
			Visible=true
			Group="Position"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockLeft"
			Visible=true
			Group="Position"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockRight"
			Visible=true
			Group="Position"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockTop"
			Visible=true
			Group="Position"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="MarginGuideColor"
			Visible=true
			Group="FT Behavior"
			InitialValue="&cCACACA"
			Type="Color"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Mode"
			Visible=true
			Group="FT Behavior"
			Type="Display_Mode"
			EditorType="Enum"
			#tag EnumValues
				"0 - Page"
				"1 - Normal"
				"2 - Edit"
				"3 - Single"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
			EditorType="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="objectCountId"
			Group="Behavior"
			InitialValue="0"
			Type="integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="PageHeight"
			Visible=true
			Group="FT Page Mode"
			InitialValue="11.0"
			Type="double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="PageWidth"
			Visible=true
			Group="FT Page Mode"
			InitialValue="8.5"
			Type="double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ReadOnly"
			Visible=true
			Group="FT Behavior"
			InitialValue="False"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="RightMargin"
			Visible=true
			Group="FT Page Mode"
			InitialValue="0"
			Type="double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ShowInvisibles"
			Visible=true
			Group="FT Behavior"
			InitialValue="False"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ShowMarginGuides"
			Visible=true
			Group="FT Behavior"
			InitialValue="False"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ShowPilcrows"
			Visible=true
			Group="FT Behavior"
			InitialValue="False"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="SpellCheckWhileTyping"
			Visible=true
			Group="FT Behavior"
			InitialValue="False"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
			EditorType="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabIndex"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabPanelIndex"
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabStop"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TIC_PageTop"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TIC_xCaret"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TIC_yCaret"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TopMargin"
			Visible=true
			Group="FT Page Mode"
			InitialValue="0"
			Type="double"
		#tag EndViewProperty
		#tag ViewProperty
			Name="UndoLimit"
			Visible=true
			Group="FT Behavior"
			InitialValue="128"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="updateFlag"
			Group="Behavior"
			InitialValue="0"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Visible"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="VScrollbarAutoHide"
			Visible=true
			Group="FT Behavior"
			InitialValue="False"
			Type="boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Width"
			Visible=true
			Group="Position"
			InitialValue="100"
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="xDisplayAlignmentOffset"
			Group="Behavior"
			Type="integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
