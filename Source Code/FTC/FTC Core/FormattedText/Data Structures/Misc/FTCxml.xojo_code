#tag Class
Protected Class FTCxml
	#tag Constant, Name = XML_AFTER_SPACE, Type = String, Dynamic = False, Default = \"as", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XML_ALIGNMENT, Type = String, Dynamic = False, Default = \"a", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XML_BACKGROUND_COLOR, Type = String, Dynamic = False, Default = \"bc", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XML_BACKGROUND_COLOR_DEFINED, Type = String, Dynamic = False, Default = \"bcd", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XML_BEFORE_SPACE, Type = String, Dynamic = False, Default = \"bs", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XML_BOLD, Type = String, Dynamic = False, Default = \"b", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XML_BOTTOM_MARGIN, Type = String, Dynamic = False, Default = \"bm", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XML_CHARACTER_SPACING, Type = String, Dynamic = False, Default = \"ts", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XML_CHARACTER_STYLE, Type = String, Dynamic = False, Default = \"cs", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XML_CHARACTER_STYLES, Type = String, Dynamic = False, Default = \"CharacterStyles", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XML_CREATOR, Type = String, Dynamic = False, Default = \"c", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XML_DATA, Type = String, Dynamic = False, Default = \"d", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XML_DOCUMENT_TAG, Type = String, Dynamic = False, Default = \"dt", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XML_FILE_TYPE, Type = String, Dynamic = False, Default = \"ft", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XML_FILE_VERSION, Type = String, Dynamic = False, Default = \"fv", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XML_FIRST_INDENT, Type = String, Dynamic = False, Default = \"fi", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XML_FIRST_INDENT_DEFINED, Type = String, Dynamic = False, Default = \"fid", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XML_FONT, Type = String, Dynamic = False, Default = \"f", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XML_FTDOCUMENT, Type = String, Dynamic = False, Default = \"FTDocument", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XML_FTPARAGRAPH, Type = String, Dynamic = False, Default = \"FTParagraph", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XML_FTPICTURE, Type = String, Dynamic = False, Default = \"FTPicture", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XML_FTSTYLERUN, Type = String, Dynamic = False, Default = \"FTStyleRun", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XML_FTTAB, Type = String, Dynamic = False, Default = \"FTTab", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XML_HEIGHT, Type = String, Dynamic = False, Default = \"h", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XML_HYPERLINK, Type = String, Dynamic = False, Default = \"cushl", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XML_HYPERLINKCOLOR, Type = String, Dynamic = False, Default = \"cushlc", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XML_HYPERLINKCOLORDISABLED, Type = String, Dynamic = False, Default = \"cushlcd", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XML_HYPERLINKCOLORROLLOVER, Type = String, Dynamic = False, Default = \"cushlcr", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XML_HYPERLINKCOLORVISITED, Type = String, Dynamic = False, Default = \"cushlcv", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XML_HYPERLINKOPENNEWWINDOW, Type = String, Dynamic = False, Default = \"cushloin", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XML_HYPERLINKULDISABLED, Type = String, Dynamic = False, Default = \"cushuld", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XML_HYPERLINKULNORMAL, Type = String, Dynamic = False, Default = \"cushuln", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XML_HYPERLINKULROLLOVER, Type = String, Dynamic = False, Default = \"cushulr", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XML_HYPERLINKULVISITED, Type = String, Dynamic = False, Default = \"cushulv", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XML_HYPERLINKUSECUSTOMCOLOR, Type = String, Dynamic = False, Default = \"cushlucc", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XML_ITALIC, Type = String, Dynamic = False, Default = \"i", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XML_LEFT_MARGIN, Type = String, Dynamic = False, Default = \"lm", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XML_LEFT_MARGIN_DEFINED, Type = String, Dynamic = False, Default = \"lmd", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XML_LINE_SPACING, Type = String, Dynamic = False, Default = \"ls", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XML_MARKED, Type = String, Dynamic = False, Default = \"m", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XML_MARK_COLOR, Type = String, Dynamic = False, Default = \"mc", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XML_MARK_DEFINED, Type = String, Dynamic = False, Default = \"md", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XML_MARK_ON, Type = String, Dynamic = False, Default = \"mo", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XML_NUDGE, Type = String, Dynamic = False, Default = \"nu", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XML_ORIGINAL_SIZE, Type = String, Dynamic = False, Default = \"os", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XML_PAGE_BACKGROUND_COLOR, Type = String, Dynamic = False, Default = \"pbc", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XML_PAGE_BREAK, Type = String, Dynamic = False, Default = \"pb", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XML_PAGE_HEIGHT, Type = String, Dynamic = False, Default = \"ph", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XML_PAGE_WIDTH, Type = String, Dynamic = False, Default = \"pw", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XML_PARAGRAPHS, Type = String, Dynamic = False, Default = \"Paragraphs", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XML_PARAGRAPH_STYLE, Type = String, Dynamic = False, Default = \"ps", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XML_PARAGRAPH_STYLES, Type = String, Dynamic = False, Default = \"ParagraphStyles", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XML_RIGHT_MARGIN, Type = String, Dynamic = False, Default = \"rm", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XML_RIGHT_MARGIN_DEFINED, Type = String, Dynamic = False, Default = \"rmd", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XML_ROOT, Type = String, Dynamic = False, Default = \"root", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XML_SCALED_HEIGHT, Type = String, Dynamic = False, Default = \"sh", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XML_SCALED_WIDTH, Type = String, Dynamic = False, Default = \"sw", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XML_SCRIPT_LEVEL, Type = String, Dynamic = False, Default = \"sl", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XML_SCRIPT_LEVEL_DEFINED, Type = String, Dynamic = False, Default = \"sld", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XML_SHADOW, Type = String, Dynamic = False, Default = \"cuhs", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XML_SHADOW_ANGLE, Type = String, Dynamic = False, Default = \"cusa", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XML_SHADOW_BLUR, Type = String, Dynamic = False, Default = \"cusb", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XML_SHADOW_COLOR, Type = String, Dynamic = False, Default = \"cusc", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XML_SHADOW_OFFSET, Type = String, Dynamic = False, Default = \"cuso", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XML_SHADOW_OPACITY, Type = String, Dynamic = False, Default = \"cusop", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XML_SIZE, Type = String, Dynamic = False, Default = \"s", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XML_STRIKE_THROUGH, Type = String, Dynamic = False, Default = \"st", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XML_STYLE_ID, Type = String, Dynamic = False, Default = \"sid", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XML_STYLE_NAME, Type = String, Dynamic = False, Default = \"n", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XML_SUBSCRIPT, Type = String, Dynamic = False, Default = \"sbs", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XML_SUPERSCRIPT, Type = String, Dynamic = False, Default = \"sps", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XML_TAB_STOP, Type = String, Dynamic = False, Default = \"ts", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XML_TAB_TYPE, Type = String, Dynamic = False, Default = \"tt", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XML_TAG, Type = String, Dynamic = False, Default = \"tg", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XML_TEXT, Type = String, Dynamic = False, Default = \"t", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XML_TEXT_COLOR, Type = String, Dynamic = False, Default = \"tc", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XML_TEXT_COLOR_DEFINED, Type = String, Dynamic = False, Default = \"tcd", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XML_TEXT_ENCODED, Type = String, Dynamic = False, Default = \"te", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XML_TEXT_OPACITY, Type = String, Dynamic = False, Default = \"cuto", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XML_TOP_MARGIN, Type = String, Dynamic = False, Default = \"tm", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XML_UNDERLINE, Type = String, Dynamic = False, Default = \"u", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XML_VERSION, Type = String, Dynamic = False, Default = \"version", Scope = Public
	#tag EndConstant

	#tag Constant, Name = XML_WIDTH, Type = String, Dynamic = False, Default = \"w", Scope = Public
	#tag EndConstant


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
