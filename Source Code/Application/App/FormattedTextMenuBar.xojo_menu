#tag Menu
Begin Menu FormattedTextMenuBar
   Begin MenuItem FileMenu
      SpecialMenu = 0
      Text = "&File"
      Index = -2147483648
      AutoEnable = True
      Visible = True
      Begin MenuItem FileNew
         SpecialMenu = 0
         Text = "&New"
         Index = -2147483648
         ShortcutKey = "N"
         Shortcut = "Cmd+N"
         MenuModifier = True
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem FileOpen
         SpecialMenu = 0
         Text = "&Open"
         Index = -2147483648
         ShortcutKey = "O"
         Shortcut = "Cmd+O"
         MenuModifier = True
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem FileClose
         SpecialMenu = 0
         Text = "&Close"
         Index = -2147483648
         ShortcutKey = "W"
         Shortcut = "Cmd+W"
         MenuModifier = True
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem UntitledSeparator6
         SpecialMenu = 0
         Text = "-"
         Index = -2147483648
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem FileSave
         SpecialMenu = 0
         Text = "&Save"
         Index = -2147483648
         ShortcutKey = "S"
         Shortcut = "Cmd+S"
         MenuModifier = True
         AutoEnable = False
         Visible = True
      End
      Begin MenuItem FileSaveAs
         SpecialMenu = 0
         Text = "Sa&ve As..."
         Index = -2147483648
         AutoEnable = True
         SubMenu = True
         Visible = True
         Begin MenuItem SaveAsRTF
            SpecialMenu = 0
            Text = "&RTF"
            Index = -2147483648
            AutoEnable = True
            Visible = True
         End
         Begin MenuItem SaveText
            SpecialMenu = 0
            Text = "&Text"
            Index = -2147483648
            AutoEnable = True
            Visible = True
         End
         Begin MenuItem SaveAsXML
            SpecialMenu = 0
            Text = "&XML"
            Index = -2147483648
            AutoEnable = True
            Visible = True
         End
      End
      Begin MenuItem FileExport
         SpecialMenu = 0
         Text = "Export"
         Index = -2147483648
         AutoEnable = True
         SubMenu = True
         Visible = True
         Begin MenuItem ExportHTML
            SpecialMenu = 0
            Text = "HTML"
            Index = -2147483648
            AutoEnable = True
            Visible = True
         End
      End
      Begin MenuItem UntitledSeparator15
         SpecialMenu = 0
         Text = "-"
         Index = -2147483648
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem FilePageSetup
         SpecialMenu = 0
         Text = "P&age Setup..."
         Index = -2147483648
         ShortcutKey = "P"
         Shortcut = "Cmd+Shift+P"
         MenuModifier = True
         AltMenuModifier = True
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem FilePrint
         SpecialMenu = 0
         Text = "&Print..."
         Index = -2147483648
         ShortcutKey = "P"
         Shortcut = "Cmd+P"
         MenuModifier = True
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem UntitledItem
         SpecialMenu = 0
         Text = "-"
         Index = -2147483648
         AutoEnable = True
         Visible = True
      End
      Begin QuitMenuItem FileQuit
         SpecialMenu = 0
         Text = "#App.kFileQuit"
         Index = -2147483648
         ShortcutKey = "#App.kFileQuitShortcut"
         Shortcut = "#App.kFileQuitShortcut"
         AutoEnable = True
         Visible = True
      End
   End
   Begin MenuItem EditMenu
      SpecialMenu = 0
      Text = "&Edit"
      Index = -2147483648
      AutoEnable = True
      Visible = True
      Begin MenuItem EditUndo
         SpecialMenu = 0
         Text = "&Undo"
         Index = -2147483648
         ShortcutKey = "Z"
         Shortcut = "Cmd+Z"
         MenuModifier = True
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem EditRedo
         SpecialMenu = 0
         Text = "R&edo"
         Index = -2147483648
         ShortcutKey = "Z"
         Shortcut = "Cmd+Shift+Z"
         MenuModifier = True
         AltMenuModifier = True
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem UntitledMenu1
         SpecialMenu = 0
         Text = "-"
         Index = -2147483648
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem EditCut
         SpecialMenu = 0
         Text = "Cu&t"
         Index = -2147483648
         ShortcutKey = "X"
         Shortcut = "Cmd+X"
         MenuModifier = True
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem EditCopy
         SpecialMenu = 0
         Text = "&Copy"
         Index = -2147483648
         ShortcutKey = "C"
         Shortcut = "Cmd+C"
         MenuModifier = True
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem EditPaste
         SpecialMenu = 0
         Text = "&Paste"
         Index = -2147483648
         ShortcutKey = "V"
         Shortcut = "Cmd+V"
         MenuModifier = True
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem EditClear
         SpecialMenu = 0
         Text = "#App.kEditClear"
         Index = -2147483648
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem UntitledMenu0
         SpecialMenu = 0
         Text = "-"
         Index = -2147483648
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem EditSelectAll
         SpecialMenu = 0
         Text = "Select &All"
         Index = -2147483648
         ShortcutKey = "A"
         Shortcut = "Cmd+A"
         MenuModifier = True
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem EditDeselectAll
         SpecialMenu = 0
         Text = "D&eselect All"
         Index = -2147483648
         ShortcutKey = "A"
         Shortcut = "Cmd+Shift+A"
         MenuModifier = True
         AltMenuModifier = True
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem UntitledSeparator7
         SpecialMenu = 0
         Text = "-"
         Index = -2147483648
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem EditCheckSpelling
         SpecialMenu = 0
         Text = "&Check Spelling"
         Index = -2147483648
         ShortcutKey = ";"
         Shortcut = "Cmd+;"
         MenuModifier = True
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem EditHideSpellingErrors
         SpecialMenu = 0
         Text = "&Hide Spelling Errors"
         Index = -2147483648
         ShortcutKey = ";"
         Shortcut = "Cmd+Shift+;"
         MenuModifier = True
         AltMenuModifier = True
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem EditCheckSpellingasYouType
         SpecialMenu = 0
         Text = "Check &Spelling as You Type"
         Index = -2147483648
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem UntitledSeparator9
         SpecialMenu = 0
         Text = "-"
         Index = -2147483648
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem EditRefresh
         SpecialMenu = 0
         Text = "&Refresh"
         Index = -2147483648
         ShortcutKey = "R"
         Shortcut = "Cmd+R"
         MenuModifier = True
         AutoEnable = True
         Visible = True
      End
   End
   Begin MenuItem ExamplesMenu
      SpecialMenu = 0
      Text = "E&xamples"
      Index = -2147483648
      AutoEnable = True
      Visible = True
      Begin MenuItem ExamplesFTCEditField
         SpecialMenu = 0
         Text = "&FTC EditField"
         Index = -2147483648
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem ExamplesFTCTextField
         SpecialMenu = 0
         Text = "FTC TextField"
         Index = -2147483648
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem ExamplesRBCodeEditor
         SpecialMenu = 0
         Text = "&Xojo Code Editor"
         Index = -2147483648
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem ExamplesEmbeddedFTC
         SpecialMenu = 0
         Text = "&Embedded FTC"
         Index = -2147483648
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem ExamplesTextAreaRTF
         SpecialMenu = 0
         Text = "TextAreaRTF"
         Index = -2147483648
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem UntitledSeparator16
         SpecialMenu = 0
         Text = "-"
         Index = -2147483648
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem ExamplesTestWindow
         SpecialMenu = 0
         Text = "&Test Window"
         Index = -2147483648
         AutoEnable = True
         Visible = True
      End
   End
   Begin MenuItem PopulateMenu
      SpecialMenu = 0
      Text = "&Populate"
      Index = -2147483648
      AutoEnable = True
      Visible = True
      Begin MenuItem PopulateClearText
         SpecialMenu = 0
         Text = "&Clear Text"
         Index = -2147483648
         ShortcutKey = "0"
         Shortcut = "Cmd+0"
         MenuModifier = True
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem UntitledSeparator
         SpecialMenu = 0
         Text = "-"
         Index = -2147483648
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem PopulateSmallPlain
         SpecialMenu = 0
         Text = "&Small Plain"
         Index = -2147483648
         ShortcutKey = "1"
         Shortcut = "Cmd+1"
         MenuModifier = True
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem PopulateSmallMixed
         SpecialMenu = 0
         Text = "S&mall Mixed"
         Index = -2147483648
         ShortcutKey = "2"
         Shortcut = "Cmd+2"
         MenuModifier = True
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem UntitledItem
         SpecialMenu = 0
         Text = "-"
         Index = -2147483648
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem PopulateMediumPlain
         SpecialMenu = 0
         Text = "Me&dium Plain"
         Index = -2147483648
         ShortcutKey = "3"
         Shortcut = "Cmd+3"
         MenuModifier = True
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem PopulateMediumMixed
         SpecialMenu = 0
         Text = "Medi&um Mixed"
         Index = -2147483648
         ShortcutKey = "4"
         Shortcut = "Cmd+4"
         MenuModifier = True
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem UntitledItem
         SpecialMenu = 0
         Text = "-"
         Index = -2147483648
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem PopulateLargePlain
         SpecialMenu = 0
         Text = "&Large Plain"
         Index = -2147483648
         ShortcutKey = "5"
         Shortcut = "Cmd+5"
         MenuModifier = True
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem PopulateLargeMixed
         SpecialMenu = 0
         Text = "Large Mi&xed"
         Index = -2147483648
         ShortcutKey = "6"
         Shortcut = "Cmd+6"
         MenuModifier = True
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem UntitledSeparator0
         SpecialMenu = 0
         Text = "-"
         Index = -2147483648
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem PopulateVeryLargePlain
         SpecialMenu = 0
         Text = "&Very Large Plain"
         Index = -2147483648
         ShortcutKey = "7"
         Shortcut = "Cmd+7"
         MenuModifier = True
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem PopulateVeryLargeMixed
         SpecialMenu = 0
         Text = "Very Large &Mixed"
         Index = -2147483648
         ShortcutKey = "8"
         Shortcut = "Cmd+8"
         MenuModifier = True
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem UntitledSeparator10
         SpecialMenu = 0
         Text = "-"
         Index = -2147483648
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem PopulateVeryLargeParagraph
         SpecialMenu = 0
         Text = "Very Large &Paragraph"
         Index = -2147483648
         ShortcutKey = "9"
         Shortcut = "Cmd+9"
         MenuModifier = True
         AutoEnable = True
         Visible = True
      End
   End
   Begin MenuItem FormatMenu
      SpecialMenu = 0
      Text = "&Format"
      Index = -2147483648
      AutoEnable = True
      Visible = True
      Begin MenuItem FormatDisplayMode
         SpecialMenu = 0
         Text = "&Display Mode"
         Index = -2147483648
         AutoEnable = True
         SubMenu = True
         Visible = True
         Begin MenuItem DisplayModePageView
            SpecialMenu = 0
            Text = "&Page View"
            Index = -2147483648
            AutoEnable = True
            Visible = True
         End
         Begin MenuItem DisplayModeNormalView
            SpecialMenu = 0
            Text = "&Normal View"
            Index = -2147483648
            AutoEnable = True
            Visible = True
         End
         Begin MenuItem DisplayModeEditView
            SpecialMenu = 0
            Text = "&Edit View"
            Index = -2147483648
            AutoEnable = True
            Visible = True
         End
         Begin MenuItem DisplayModeSingleView
            SpecialMenu = 0
            Text = "Single View"
            Index = -2147483648
            AutoEnable = True
            Visible = True
         End
      End
      Begin MenuItem FormatDisplayAlignment
         SpecialMenu = 0
         Text = "Display Alignment"
         Index = -2147483648
         AutoEnable = True
         SubMenu = True
         Visible = True
         Begin MenuItem DisplayAlignmentLeft
            SpecialMenu = 0
            Text = "Left"
            Index = -2147483648
            AutoEnable = True
            Visible = True
         End
         Begin MenuItem DisplayAlignmentCenter
            SpecialMenu = 0
            Text = "Center"
            Index = -2147483648
            AutoEnable = True
            Visible = True
         End
         Begin MenuItem DisplayAlignmentRight
            SpecialMenu = 0
            Text = "Right"
            Index = -2147483648
            AutoEnable = True
            Visible = True
         End
      End
      Begin MenuItem FormatScale
         SpecialMenu = 0
         Text = "S&cale"
         Index = -2147483648
         AutoEnable = True
         SubMenu = True
         Visible = True
         Begin MenuItem Scale50
            SpecialMenu = 0
            Text = "&50%"
            Index = -2147483648
            AutoEnable = True
            Visible = True
         End
         Begin MenuItem Scale75
            SpecialMenu = 0
            Text = "&75%"
            Index = -2147483648
            AutoEnable = True
            Visible = True
         End
         Begin MenuItem Scale100
            SpecialMenu = 0
            Text = "&100%"
            Index = -2147483648
            AutoEnable = True
            Visible = True
         End
         Begin MenuItem Scale125
            SpecialMenu = 0
            Text = "1&25%"
            Index = -2147483648
            AutoEnable = True
            Visible = True
         End
         Begin MenuItem Scale150
            SpecialMenu = 0
            Text = "15&0%"
            Index = -2147483648
            AutoEnable = True
            Visible = True
         End
         Begin MenuItem Scale200
            SpecialMenu = 0
            Text = "&200%"
            Index = -2147483648
            AutoEnable = True
            Visible = True
         End
      End
      Begin MenuItem UntitledSeparator12
         SpecialMenu = 0
         Text = "-"
         Index = -2147483648
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem FormatSearchandReplace
         SpecialMenu = 0
         Text = "Search and Replace"
         Index = -2147483648
         ShortcutKey = "F"
         Shortcut = "Cmd+F"
         MenuModifier = True
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem FormatInsert
         SpecialMenu = 0
         Text = "I&nsert"
         Index = -2147483648
         AutoEnable = True
         SubMenu = True
         Visible = True
         Begin MenuItem InsertCustomHyperlink
            SpecialMenu = 0
            Text = "&Custom Hyperlink"
            Index = -2147483648
            AutoEnable = False
            Visible = True
         End
         Begin MenuItem InsertPageBreak
            SpecialMenu = 0
            Text = "&Page Break"
            Index = -2147483648
            AutoEnable = False
            Visible = True
         End
      End
      Begin MenuItem UntitledSeparator11
         SpecialMenu = 0
         Text = "-"
         Index = -2147483648
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem FormatFont
         SpecialMenu = 0
         Text = "&Font"
         Index = -2147483648
         AutoEnable = True
         SubMenu = True
         Visible = True
      End
      Begin MenuItem FormatSize
         SpecialMenu = 0
         Text = "&Size"
         Index = -2147483648
         AutoEnable = True
         SubMenu = True
         Visible = True
         Begin MenuItem Size9
            SpecialMenu = 0
            Text = "&9"
            Index = -2147483648
            AutoEnable = False
            Visible = True
         End
         Begin MenuItem Size10
            SpecialMenu = 0
            Text = "&10"
            Index = -2147483648
            AutoEnable = False
            Visible = True
         End
         Begin MenuItem Size12
            SpecialMenu = 0
            Text = "1&2"
            Index = -2147483648
            AutoEnable = False
            Visible = True
         End
         Begin MenuItem Size14
            SpecialMenu = 0
            Text = "1&4"
            Index = -2147483648
            AutoEnable = False
            Visible = True
         End
         Begin MenuItem Size18
            SpecialMenu = 0
            Text = "1&8"
            Index = -2147483648
            AutoEnable = False
            Visible = True
         End
         Begin MenuItem Size24
            SpecialMenu = 0
            Text = "&24"
            Index = -2147483648
            AutoEnable = False
            Visible = True
         End
         Begin MenuItem Size32
            SpecialMenu = 0
            Text = "&32"
            Index = -2147483648
            AutoEnable = False
            Visible = True
         End
         Begin MenuItem Size48
            SpecialMenu = 0
            Text = "&48"
            Index = -2147483648
            AutoEnable = False
            Visible = True
         End
         Begin MenuItem Size72
            SpecialMenu = 0
            Text = "&72"
            Index = -2147483648
            AutoEnable = False
            Visible = True
         End
      End
      Begin MenuItem FormatCharacterSpacing
         SpecialMenu = 0
         Text = "Character Spacing"
         Index = -2147483648
         AutoEnable = True
         SubMenu = True
         Visible = True
         Begin MenuItem CharacterSpacing100Minus
            SpecialMenu = 0
            Text = "-100%"
            Index = -2147483648
            AutoEnable = True
            Visible = True
         End
         Begin MenuItem CharacterSpacing50Minus
            SpecialMenu = 0
            Text = "-50%"
            Index = -2147483648
            AutoEnable = True
            Visible = True
         End
         Begin MenuItem CharacterSpacing25Minus
            SpecialMenu = 0
            Text = "-25%"
            Index = -2147483648
            AutoEnable = True
            Visible = True
         End
         Begin MenuItem CharacterSpacing0
            SpecialMenu = 0
            Text = "0%"
            Index = -2147483648
            AutoEnable = True
            Visible = True
         End
         Begin MenuItem CharacterSpacing25
            SpecialMenu = 0
            Text = "25%"
            Index = -2147483648
            AutoEnable = True
            Visible = True
         End
         Begin MenuItem CharacterSpacing50
            SpecialMenu = 0
            Text = "50%"
            Index = -2147483648
            AutoEnable = True
            Visible = True
         End
         Begin MenuItem CharacterSpacing100
            SpecialMenu = 0
            Text = "100%"
            Index = -2147483648
            AutoEnable = True
            Visible = True
         End
      End
      Begin MenuItem FormatStyle
         SpecialMenu = 0
         Text = "S&tyle"
         Index = -2147483648
         AutoEnable = True
         SubMenu = True
         Visible = True
         Begin MenuItem StylePlain
            SpecialMenu = 0
            Text = "&Plain"
            Index = -2147483648
            ShortcutKey = "L"
            Shortcut = "Cmd+L"
            MenuModifier = True
            AutoEnable = False
            Visible = True
         End
         Begin MenuItem StyleBold
            SpecialMenu = 0
            Text = "&Bold"
            Index = -2147483648
            ShortcutKey = "B"
            Shortcut = "Cmd+B"
            MenuModifier = True
            AutoEnable = False
            Visible = True
         End
         Begin MenuItem StyleItalic
            SpecialMenu = 0
            Text = "&Italic"
            Index = -2147483648
            ShortcutKey = "I"
            Shortcut = "Cmd+I"
            MenuModifier = True
            AutoEnable = False
            Visible = True
         End
         Begin MenuItem StyleUnderline
            SpecialMenu = 0
            Text = "&Underline"
            Index = -2147483648
            ShortcutKey = "U"
            Shortcut = "Cmd+U"
            MenuModifier = True
            AutoEnable = False
            Visible = True
         End
         Begin MenuItem StyleStrikeThrough
            SpecialMenu = 0
            Text = "&Strike Through"
            Index = -2147483648
            ShortcutKey = "J"
            Shortcut = "Cmd+J"
            MenuModifier = True
            AutoEnable = False
            Visible = True
         End
         Begin MenuItem StyleSuperscript
            SpecialMenu = 0
            Text = "Sup&erscript"
            Index = -2147483648
            AutoEnable = False
            Visible = True
         End
         Begin MenuItem StyleSubscript
            SpecialMenu = 0
            Text = "Subs&cript"
            Index = -2147483648
            AutoEnable = False
            Visible = True
         End
      End
      Begin MenuItem FormatAlignment
         SpecialMenu = 0
         Text = "&Alignment"
         Index = -2147483648
         AutoEnable = True
         SubMenu = True
         Visible = True
         Begin MenuItem AlignmentLeft
            SpecialMenu = 0
            Text = "&Left"
            Index = -2147483648
            AutoEnable = False
            Visible = True
         End
         Begin MenuItem AlignmentCenter
            SpecialMenu = 0
            Text = "&Center"
            Index = -2147483648
            AutoEnable = False
            Visible = True
         End
         Begin MenuItem AlignmentRight
            SpecialMenu = 0
            Text = "&Right"
            Index = -2147483648
            AutoEnable = False
            Visible = True
         End
      End
      Begin MenuItem FormatLineSpacing
         SpecialMenu = 0
         Text = "&Line Spacing"
         Index = -2147483648
         AutoEnable = True
         SubMenu = True
         Visible = True
         Begin MenuItem LineSpacing_1
            SpecialMenu = 0
            Text = "&1"
            Index = -2147483648
            AutoEnable = False
            Visible = True
         End
         Begin MenuItem LineSpacing_15
            SpecialMenu = 0
            Text = "1.&5"
            Index = -2147483648
            AutoEnable = False
            Visible = True
         End
         Begin MenuItem LineSpacing_2
            SpecialMenu = 0
            Text = "&2"
            Index = -2147483648
            AutoEnable = False
            Visible = True
         End
         Begin MenuItem LineSpacing_25
            SpecialMenu = 0
            Text = "2.&5"
            Index = -2147483648
            AutoEnable = False
            Visible = True
         End
         Begin MenuItem LineSpacing_3
            SpecialMenu = 0
            Text = "&3"
            Index = -2147483648
            AutoEnable = False
            Visible = True
         End
      End
      Begin MenuItem FormatTextColor
         SpecialMenu = 0
         Text = "&Text Color"
         Index = -2147483648
         AutoEnable = True
         SubMenu = True
         Visible = True
         Begin MenuItem ColorBlack
            SpecialMenu = 0
            Text = "&Black"
            Index = -2147483648
            AutoEnable = False
            Visible = True
         End
         Begin MenuItem ColorRed
            SpecialMenu = 0
            Text = "&Red"
            Index = -2147483648
            AutoEnable = False
            Visible = True
         End
         Begin MenuItem ColorGreen
            SpecialMenu = 0
            Text = "&Green"
            Index = -2147483648
            AutoEnable = False
            Visible = True
         End
         Begin MenuItem ColorBlue
            SpecialMenu = 0
            Text = "Bl&ue"
            Index = -2147483648
            AutoEnable = False
            Visible = True
         End
      End
      Begin MenuItem FormatTextBackgroundColor
         SpecialMenu = 0
         Text = "Text &Background Color"
         Index = -2147483648
         AutoEnable = True
         SubMenu = True
         Visible = True
         Begin MenuItem BackgroundColorNone
            SpecialMenu = 0
            Text = "&None"
            Index = -2147483648
            AutoEnable = False
            Visible = True
         End
         Begin MenuItem BackgroundColorRed
            SpecialMenu = 0
            Text = "&Red"
            Index = -2147483648
            AutoEnable = False
            Visible = True
         End
         Begin MenuItem BackgroundColorGreen
            SpecialMenu = 0
            Text = "&Green"
            Index = -2147483648
            AutoEnable = False
            Visible = True
         End
         Begin MenuItem BackgroundColorBlue
            SpecialMenu = 0
            Text = "&Blue"
            Index = -2147483648
            AutoEnable = False
            Visible = True
         End
      End
      Begin MenuItem FormatOpacity
         SpecialMenu = 0
         Text = "Text Opacity"
         Index = -2147483648
         AutoEnable = True
         SubMenu = True
         Visible = True
         Begin MenuItem OpacityZero
            SpecialMenu = 0
            Text = "Zero"
            Index = -2147483648
            AutoEnable = True
            Visible = True
         End
         Begin MenuItem Opacity25
            SpecialMenu = 0
            Text = "25%"
            Index = -2147483648
            AutoEnable = True
            Visible = True
         End
         Begin MenuItem Opacity50
            SpecialMenu = 0
            Text = "50%"
            Index = -2147483648
            AutoEnable = True
            Visible = True
         End
         Begin MenuItem Opacity75
            SpecialMenu = 0
            Text = "75%"
            Index = -2147483648
            AutoEnable = True
            Visible = True
         End
      End
      Begin MenuItem FormatTextShadow
         SpecialMenu = 0
         Text = "Text Shadow"
         Index = -2147483648
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem FormatParagraphBackgroundColor
         SpecialMenu = 0
         Text = "P&aragraph Background Color"
         Index = -2147483648
         AutoEnable = True
         SubMenu = True
         Visible = True
         Begin MenuItem ParagraphBackgroundColorNone
            SpecialMenu = 0
            Text = "&None"
            Index = -2147483648
            AutoEnable = False
            Visible = True
         End
         Begin MenuItem ParagraphBackgroundColorRed
            SpecialMenu = 0
            Text = "&Red"
            Index = -2147483648
            AutoEnable = False
            Visible = True
         End
         Begin MenuItem ParagraphBackgroundColorGreen
            SpecialMenu = 0
            Text = "&Green"
            Index = -2147483648
            AutoEnable = False
            Visible = True
         End
         Begin MenuItem ParagraphBackgroundColorblue
            SpecialMenu = 0
            Text = "&Blue"
            Index = -2147483648
            AutoEnable = False
            Visible = True
         End
      End
      Begin MenuItem FormatMark
         SpecialMenu = 0
         Text = "&Mark"
         Index = -2147483648
         AutoEnable = True
         SubMenu = True
         Visible = True
         Begin MenuItem MarkNone
            SpecialMenu = 0
            Text = "&None"
            Index = -2147483648
            AutoEnable = False
            Visible = True
         End
         Begin MenuItem MarkRed
            SpecialMenu = 0
            Text = "&Red"
            Index = -2147483648
            AutoEnable = False
            Visible = True
         End
         Begin MenuItem MarkGreen
            SpecialMenu = 0
            Text = "&Green"
            Index = -2147483648
            AutoEnable = False
            Visible = True
         End
         Begin MenuItem MarkBlue
            SpecialMenu = 0
            Text = "&Blue"
            Index = -2147483648
            AutoEnable = False
            Visible = True
         End
      End
      Begin MenuItem FormatChangeCase
         SpecialMenu = 0
         Text = "Change Case"
         Index = -2147483648
         AutoEnable = True
         SubMenu = True
         Visible = True
         Begin MenuItem ChangeCaseUpper
            SpecialMenu = 0
            Text = "Upper"
            Index = -2147483648
            AutoEnable = True
            Visible = True
         End
         Begin MenuItem ChangeCaseLower
            SpecialMenu = 0
            Text = "Lower"
            Index = -2147483648
            AutoEnable = True
            Visible = True
         End
         Begin MenuItem ChangeCaseTitle
            SpecialMenu = 0
            Text = "Title"
            Index = -2147483648
            AutoEnable = True
            Visible = True
         End
      End
      Begin MenuItem FormatResetImageSize
         SpecialMenu = 0
         Text = "R&eset Image Size"
         Index = -2147483648
         AutoEnable = False
         Visible = True
      End
      Begin MenuItem UntitledSeparator13
         SpecialMenu = 0
         Text = "-"
         Index = -2147483648
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem FormatSetHyperlink
         SpecialMenu = 0
         Text = "Set Hyperlink"
         Index = -2147483648
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem FormatClearHyperlink
         SpecialMenu = 0
         Text = "Clear Hyperlink"
         Index = -2147483648
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem FormatHyperlinkColors
         SpecialMenu = 0
         Text = "Hyperlink Colors"
         Index = -2147483648
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem UntitledSeparator4
         SpecialMenu = 0
         Text = "-"
         Index = -2147483648
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem FormatParagraphsStyle
         SpecialMenu = 0
         Text = "&Paragraph Styles"
         Index = -2147483648
         AutoEnable = True
         SubMenu = True
         Visible = True
         Begin MenuItem ParagraphStyleNone
            SpecialMenu = 0
            Text = "&None"
            Index = -2147483648
            AutoEnable = False
            Visible = True
         End
         Begin MenuItem UntitledSeparator3
            SpecialMenu = 0
            Text = "-"
            Index = -2147483648
            AutoEnable = True
            Visible = True
         End
         Begin MenuItem ParagraphStyleIndented
            SpecialMenu = 0
            Text = "&Indented"
            Index = -2147483648
            AutoEnable = False
            Visible = True
         End
         Begin MenuItem ParagraphStyleTitle
            SpecialMenu = 0
            Text = "&Title"
            Index = -2147483648
            AutoEnable = False
            Visible = True
         End
         Begin MenuItem ParagraphStyleWildandCrazy
            SpecialMenu = 0
            Text = "&Wild and Crazy"
            Index = -2147483648
            AutoEnable = False
            Visible = True
         End
      End
      Begin MenuItem FormatCharactersStyle
         SpecialMenu = 0
         Text = "C&haracter Styles"
         Index = -2147483648
         AutoEnable = True
         SubMenu = True
         Visible = True
         Begin MenuItem CharacterStylesNone
            SpecialMenu = 0
            Text = "&None"
            Index = -2147483648
            AutoEnable = False
            Visible = True
         End
         Begin MenuItem UntitledSeparator5
            SpecialMenu = 0
            Text = "-"
            Index = -2147483648
            AutoEnable = True
            Visible = True
         End
         Begin MenuItem CharacterStylesTitle
            SpecialMenu = 0
            Text = "&Title"
            Index = -2147483648
            AutoEnable = False
            Visible = True
         End
         Begin MenuItem CharacterStylesEmphasis
            SpecialMenu = 0
            Text = "&Emphasis"
            Index = -2147483648
            AutoEnable = False
            Visible = True
         End
         Begin MenuItem CharacterStylesFigure
            SpecialMenu = 0
            Text = "&Figure"
            Index = -2147483648
            AutoEnable = False
            Visible = True
         End
      End
      Begin MenuItem FormatAdjustParagraph
         SpecialMenu = 0
         Text = "Adjust &Paragraph..."
         Index = -2147483648
         ShortcutKey = "K"
         Shortcut = "Cmd+K"
         MenuModifier = True
         AutoEnable = False
         Visible = True
      End
      Begin MenuItem FormatTabs
         SpecialMenu = 0
         Text = "Tabs..."
         Index = -2147483648
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem UntitledSeparator1
         SpecialMenu = 0
         Text = "-"
         Index = -2147483648
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem FormatAdjustMargins
         SpecialMenu = 0
         Text = "A&djust Margins..."
         Index = -2147483648
         ShortcutKey = "M"
         Shortcut = "Cmd+M"
         MenuModifier = True
         AutoEnable = False
         Visible = True
      End
      Begin MenuItem FormatShowMarginGuides
         SpecialMenu = 0
         Text = "S&how Margin Guides"
         Index = -2147483648
         ShortcutKey = "G"
         Shortcut = "Cmd+G"
         MenuModifier = True
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem UntitledSeparator8
         SpecialMenu = 0
         Text = "-"
         Index = -2147483648
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem FormatShowInvisibles
         SpecialMenu = 0
         Text = "Show Invisibles"
         Index = -2147483648
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem FormatMakeReadOnly
         SpecialMenu = 0
         Text = "Make &Read Only"
         Index = -2147483648
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem FormatToggleScrollbars
         SpecialMenu = 0
         Text = "T&oggle Scrollbars"
         Index = -2147483648
         AutoEnable = True
         SubMenu = True
         Visible = True
         Begin MenuItem ToggleScrollbarsAutoHideScrollbars
            SpecialMenu = 0
            Text = "Auto Hide Scrollbars"
            Index = -2147483648
            AutoEnable = True
            Visible = True
         End
         Begin MenuItem UntitledSeparator2
            SpecialMenu = 0
            Text = "-"
            Index = -2147483648
            AutoEnable = True
            Visible = True
         End
         Begin MenuItem ToggleScrollbarsVerticalScrollbar
            SpecialMenu = 0
            Text = "&Vertical Scrollbar"
            Index = -2147483648
            AutoEnable = False
            Visible = True
         End
         Begin MenuItem ToggleScrollbarsHorizontalScrollbar
            SpecialMenu = 0
            Text = "&Horizontal Scrollbar"
            Index = -2147483648
            AutoEnable = False
            Visible = True
         End
      End
   End
   Begin MenuItem HelpMenu
      SpecialMenu = 0
      Text = "&Help"
      Index = -2147483648
      AutoEnable = True
      Visible = True
      Begin MenuItem HelpShowConsole
         SpecialMenu = 0
         Text = "&Show Console"
         Index = -2147483648
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem HelpSeparator1
         SpecialMenu = 0
         Text = "-"
         Index = -2147483648
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem HelpKeyStrokeTiming
         SpecialMenu = 0
         Text = "&Key Stroke Timing"
         Index = -2147483648
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem HelpClearKeyStrokeTiming
         SpecialMenu = 0
         Text = "&Clear Key Stroke Timing"
         Index = -2147483648
         AutoEnable = True
         Visible = True
      End
      Begin MenuItem HelpSeparator2
         SpecialMenu = 0
         Text = "-"
         Index = -2147483648
         AutoEnable = True
         Visible = True
      End
      Begin AppleMenuItem HelpAboutFormattedText
         SpecialMenu = 0
         Text = "&About Formatted Text"
         Index = -2147483648
         AutoEnable = True
         Visible = True
      End
   End
End
#tag EndMenu
