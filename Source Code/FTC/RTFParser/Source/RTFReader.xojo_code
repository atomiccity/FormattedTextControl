#tag Class
Protected Class RTFReader
	#tag Method, Flags = &h21
		Private Function booleanValue(value as integer) As boolean
		  if value = 0 then
		    return false
		  else
		    return true
		  end
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(applyStyles as boolean)
		  ' Save the flag.
		  me.bApplyStyles = applyStyles
		  
		  ' Create the attribute containers.
		  oParagraphAttributes = new RTFParagraphAttributes
		  oStyleAttributes = new RTFStyleAttributes
		  oDocumentAttributes = new RTFDocumentAttributes
		  
		  ' Create the Dictionaries
		  dictFonts = new Dictionary
		  dictParagraphStyles = new Dictionary
		  dictCharacterStyles = new Dictionary
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ConsumeGroup(oLexer as RTFLexer)
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  dim oToken as RTFLexer.Token
		  
		  if not oLexer.NextToken(oToken) then
		    return
		  end if
		  
		  if oToken.type <> RTFLexer.TokenTypes.GroupBegin then
		    break
		    return
		  end if
		  
		  dim iLevel as integer = 1
		  
		  while oLexer.NextToken(oToken)
		    
		    select case oToken.type
		    case RTFLexer.TokenTypes.GroupBegin
		      iLevel = iLevel + 1
		      
		    case RTFLexer.TokenTypes.GroupEnd
		      iLevel = iLevel - 1
		      
		      if iLevel=0 then
		        exit while
		      end if
		      
		    end select
		  wend
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function DecodeTextData(sData as string) As String
		  dim cs as integer = self.oStyleAttributes.font.characterSet
		  dim oEnc as TextEncoding
		  if cs>=0 then
		    oEnc = GetCharacterSetEncoding(cs)
		  else
		    oEnc = self.oEncoding
		  end if
		  
		  if oEnc is nil then
		    oEnc = self.oEncoding
		  end if
		  return DefineEncoding(sData, oEnc)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub EmitEscapedCharacter(ch as string)
		  if fldinstFlag then
		    fldinstText = fldinstText + ch
		  else
		    RaiseEvent EscapedCharacter(ch)
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub EmitTextSegment(s as string)
		  if fldinstFlag then
		    fldinstText = fldinstText + s
		  else
		    RaiseEvent TextSegment(s)
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function FieldIsHyperLink(oLexer as RTFLexer) As boolean
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  dim bIgnore as boolean
		  dim oToken as RTFLexer.Token
		  dim iStartGroupLevel as integer = iGroupLevel
		  
		  while oLexer.NextToken(oToken)
		    
		    select case oToken.type
		    case RTFLexer.TokenTypes.ControlSymbol
		      //Don't Care
		      
		    case RTFLexer.TokenTypes.ControlWord
		      dim sCommand as string = oLexer.GetText(oToken.name)
		      if sCommand = "\pict" or sCommand = "\shppict" or scommand = "\nonshppict" then
		        bIgnore = true
		      end
		      ' case RTFLexer.TokenTypes.EOF
		      ' ' break
		      '
		      ' case RTFLexer.TokenTypes.Error
		      ' ' break
		      
		    case RTFLexer.TokenTypes.GroupBegin
		      iGroupLevel = iGroupLevel + 1
		      
		    case RTFLexer.TokenTypes.GroupEnd
		      iGroupLevel = iGroupLevel - 1
		      
		      if iGroupLevel < iStartGroupLevel then
		        exit
		      end
		      
		    case RTFLexer.TokenTypes.HexValue
		      break
		      
		    case RTFLexer.TokenTypes.Text
		      if bIgnore = false then
		        dim sData as string = oLexer.GetText(oToken.value)
		        if sData.InStr("HYPERLINK") > 0 then
		          Return true
		        end
		      end
		    end select
		    
		  wend
		  
		  return false
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function FieldIsShpPict(oLexer as RTFLexer) As boolean
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  dim oToken as RTFLexer.Token
		  dim iStartGroupLevel as integer = iGroupLevel
		  
		  while oLexer.NextToken(oToken)
		    
		    select case oToken.type
		      ' case RTFLexer.TokenTypes.ControlSymbol
		      ' //Don't Care
		      
		    case RTFLexer.TokenTypes.ControlWord
		      
		      dim sCommand as String = oLexer.GetText(oToken.name)
		      if sCommand = "\shppict" then
		        return true
		      end
		      
		      
		      ' case RTFLexer.TokenTypes.EOF
		      ' //Consume
		      '
		      ' case RTFLexer.TokenTypes.Error
		      ' //Consume
		      
		    case RTFLexer.TokenTypes.GroupBegin
		      iGroupLevel = iGroupLevel + 1
		      
		    case RTFLexer.TokenTypes.GroupEnd
		      
		      iGroupLevel = iGroupLevel - 1
		      
		      
		      if iGroupLevel < iStartGroupLevel then
		        exit
		      end
		      
		      ' case RTFLexer.TokenTypes.HexValue
		      ' //Consume
		      '
		      ' case RTFLexer.TokenTypes.Text
		      ' //Consume
		    end select
		    
		  wend
		  
		  return false
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetCharacterSetEncoding(cs as integer) As TextEncoding
		  ' Specifies the character set of a font in the font table. Values for N are defined by Windows header files:
		  ' 0ANSI
		  ' 1Default
		  ' 2Symbol
		  ' 3Invalid
		  ' 77Mac
		  ' 128Shift Jis
		  ' 129Hangul
		  ' 130Johab
		  ' 134GB2312
		  ' 136Big5
		  ' 161Greek
		  ' 162Turkish
		  ' 163Vietnamese
		  ' 177Hebrew
		  ' 178Arabic
		  ' 179Arabic Traditional
		  ' 180Arabic user
		  ' 181Hebrew user
		  ' 186Baltic
		  ' 204Russian
		  ' 222Thai
		  ' 238Eastern European
		  ' 254PC 437
		  ' 255OEM
		  
		  dim oEnc as TextEncoding
		  
		  'these translations are incomplete - not sure yet how to map the full list
		  'from \fcharset (also, I'm not sure that the \fcharset list is complete).
		  select case cs
		  case 0 to 3
		    oEnc = Encodings.WindowsANSI
		  case 77 to 127
		    'oEnc = Encodings.MacRoman
		    oEnc = GetTextEncoding(cs-77)
		  case 128
		    oEnc = Encodings.ShiftJIS
		  case 129
		    oEnc = Encodings.MacKorean
		  case else
		    break
		  end select
		  return oEnc
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getCharacterStyles() As RTFCharacterStyle()
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  dim aro() as RTFCharacterStyle
		  for i as integer = 0 to dictCharacterStyles.count-1
		    dim key as variant = dictCharacterStyles.key(i)
		    
		    dim oStyle as RTFCharacterStyle = dictCharacterStyles.value(key)
		    
		    aro.Append oStyle
		  next
		  
		  return aro
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getCurrentParagraphAttributes() As RTFParagraphAttributes
		  ' Return the current paragraph attributes.
		  return oParagraphAttributes
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getCurrentStyle() As RTFStyleAttributes
		  ' Return the current style.
		  return oStyleAttributes
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getParagraphStyles() As RTFParagraphStyle()
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  dim aro() as RTFParagraphStyle
		  for i as integer = 0 to dictParagraphStyles.count-1
		    dim key as variant = dictParagraphStyles.key(i)
		    
		    dim oStyle as RTFParagraphStyle = dictParagraphStyles.value(key)
		    
		    aro.Append oStyle
		  next
		  
		  return aro
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub IsUnknownCommand(s as String, Location as String)
		  if kLogUnknownCommands = false then return
		  
		  dim iIndex as integer
		  
		  iIndex = arsKnownCommands.IndexOf(s)
		  
		  if iIndex = -1 then
		    //unknown command
		    LogMissingCommands Location + ": " + s
		  end
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub LogAllCommands(rtfString as String)
		  dim f as folderitem = SpecialFolder.Desktop.child("RTF Command Log.txt")
		  if f.exists then
		    f.delete
		  end
		  
		  dim tos as TextOutputStream = TextOutputStream.Create(f)
		  
		  dim oLexer as new RTFLexer(rtfString)
		  dim tk as RTFLexer.Token
		  dim tkLast as RTFLexer.Token
		  dim iGroupLevel as integer
		  
		  while oLexer.NextToken(tk)
		    dim s as String = oLexer.GetText(tk.name)
		    
		    select case tk.type
		    case RTFLexer.TokenTypes.ControlSymbol
		      tos.WriteLine "ControlSymbol: " + s
		      
		    case RTFLexer.TokenTypes.ControlWord
		      tos.WriteLine  "ControlWord: " + s + ": " + oLexer.GetText(tk.value)
		      
		    case RTFLexer.TokenTypes.EOF
		      tos.WriteLine  "EOF: " + s
		      
		    case RTFLexer.TokenTypes.Error
		      tos.WriteLine "Error: " + s
		      
		    case RTFLexer.TokenTypes.GroupBegin
		      iGroupLevel = iGroupLevel + 1
		      tos.WriteLine  "Group Begin: Level "  + str(iGroupLevel)
		      
		    case RTFLexer.TokenTypes.GroupEnd
		      tos.WriteLine  "Group End:  Level "  + str(iGroupLevel)
		      iGroupLevel = iGroupLevel - 1
		      
		    case RTFLexer.TokenTypes.HexValue
		      tos.WriteLine  "HexValue: "+ oLexer.GetText(tk.value)
		      
		    case RTFLexer.TokenTypes.Text
		      tos.WriteLine  "Text: "+ oLexer.GetText(tk.value) + " " + s
		      
		    end select
		    
		    tkLast = tk
		  wend
		  
		  tos.close
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub LogMissingCommands(s as String)
		  dim f as folderitem = SpecialFolder.Desktop.child("RTF Missing Commands.txt")
		  
		  dim tos as TextOutputStream = TextOutputStream.append(f)
		  
		  tos.WriteLine s
		  
		  tos.close
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LookUpColor(index as integer) As Color
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Are we out of range?
		  if index < 0 or index > arColors.ubound then
		    
		    ' Return a default color.
		    return &c000000
		    
		  end if
		  
		  ' Return the color.
		  return arColors(index)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LookUpFont(index as integer) As RTFFont
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Does the font exist?
		  if not dictFonts.HasKey(index) then
		    
		    ' Return an empty font.
		    return new RTFFont
		    
		  end if
		  
		  ' Return the font.
		  dim oFont as RTFFont = dictFonts.Value(index)
		  return oFont.clone
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LookUpStyle(name as string) As string
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Does the style exist?
		  if dictParagraphStyles.HasKey(name) = false then
		    
		    ' Return an empty style.
		    return ""
		    
		  end if
		  
		  ' Return the style.
		  return dictParagraphStyles.Value(name)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function openMacPicture(data as string, picw as integer, pich as integer, picwgoal as integer, pichgoal as integer) As Picture
		  Dim mb as MemoryBlock
		  
		  ' Create the pict header.
		  mb = new MemoryBlock(512)
		  
		  ' Open the pict file.
		  return openPicture (mb.StringValue(0, 512) + data, picw, pich, picwgoal, pichgoal)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function openPicture(data as string, picw as integer, pich as integer, picwgoal as integer, pichgoal as integer) As Picture
		  dim mb as MemoryBlock = data
		  dim p as picture = Picture.FromData(mb)
		  
		  
		  ' Were the dimensions specified?
		  dim iWidth, iHeight as integer
		  if picwgoal>0 and pichgoal>0 then
		    iWidth = picwgoal\20
		    iHeight = pichgoal\20
		  else
		    ' if pictureFormat<>"\wmetafile" then
		    iWidth = picw
		    iHeight = pich
		    ' end if
		  end if
		  
		  
		  if p<>nil and iWidth>0 and iHeight>0 then
		    dim dimensionedPicture as new Picture(iWidth, iHeight, 32)
		    dimensionedPicture.Graphics.DrawPicture(p, 0, 0, iWidth, iHeight, 0, 0, p.Width, p.Height)
		    p = dimensionedPicture
		  end if
		  
		  
		  return p
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub parse(rtfString as string)
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  if kLogUnknownCommands then
		    SetupKnownCommands
		  end
		  
		  ' Signal the start of parsing.
		  RaiseEvent StartOfParsing
		  
		  dim oLexer as new RTFLexer(rtfString)
		  dim oToken as RTFLexer.Token
		  
		  while oLexer.NextToken(oToken)
		    
		    ' dim s as String = oLexer.GetText(oToken.name)
		    
		    select case oToken.type
		    case RTFLexer.TokenTypes.ControlSymbol
		      ParseControlSymbol  oToken, oLexer
		      
		    case RTFLexer.TokenTypes.ControlWord
		      
		      if bInCommentGroup = false then
		        ParseControlWord oToken, oLexer
		        
		        ' else
		        ' 'app.LogMissingCommands "• skipped command: " + oLexer.GetText(oToken.name)
		      end
		      
		    case RTFLexer.TokenTypes.EOF
		      //Token EOF Error.  Skip
		      
		    case RTFLexer.TokenTypes.Error
		      //Token Error.  Skip it.
		      
		    case RTFLexer.TokenTypes.GroupBegin
		      iGroupLevel = iGroupLevel + 1
		      
		    case RTFLexer.TokenTypes.GroupEnd
		      iGroupLevel = iGroupLevel - 1
		      
		      // Mantis Ticket 3637: FTCParagraphStyle.backgroundColor won’t set correctly
		      oStyleAttributes.reset
		      
		      if bInCommentGroup then
		        ' if iGroupLevel <= iStartCommentGroupLevel then
		        if iGroupLevel < iStartCommentGroupLevel then
		          bInCommentGroup = False
		        end
		      end
		      
		    case RTFLexer.TokenTypes.HexValue
		      if bInCommentGroup  = false then
		        'if there's a run of hex data then grab all of it
		        oLexer.Rewind(oToken)
		        dim arsByte() as string
		        while oLexer.NextToken(oToken)
		          if oToken.type<>RTFLexer.TokenTypes.HexValue then
		            oLexer.Rewind(oToken)
		            exit while
		          end if
		          dim sHexByte as string = oLexer.GetData(oToken.value)
		          arsByte.Append(ChrB(Val("&h" + sHexByte)))
		        wend
		        
		        dim sData as string = Join(arsByte, "")
		        EmitTextSegment(DecodeTextData(sData))
		      end if
		      
		    Case RTFLexer.TokenTypes.Text
		      If bInCommentGroup = False Then
		        
		        ParseText oToken, oLexer
		      end
		      
		    end select
		    
		    
		    oLastToken = oToken
		  wend
		  
		  
		  ' Signal the end of parsing the document.
		  RaiseEvent EndOfParsing(oDocumentAttributes)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ParseCharacterStyles(oLexer as RTFLexer)
		  #If Not DebugBuild
		    
		    #Pragma BoundsChecking RTF_BOUNDSCHECKING
		    #Pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #Pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #EndIf
		  
		  Dim oToken As RTFLexer.Token
		  Dim iStartGroupLevel As Integer = iGroupLevel
		  
		  Dim oStyle As New RTFCharacterStyle("Unknown")
		  
		  While oLexer.NextToken(oToken)
		    
		    Select Case oToken.type
		    Case RTFLexer.TokenTypes.ControlSymbol
		      Dim sControlSymbol As String = oLexer.GetText(oToken.name)
		      Select Case sControlSymbol
		      Case "\*"
		        ' bIgnore = true
		      Case Else
		        Break//not handled
		      End
		      
		    Case RTFLexer.TokenTypes.ControlWord
		      Dim sCommand As String = oLexer.GetText(oToken.name)
		      Dim dValue As Double = oLexer.GetText(oToken.value).Val
		      
		      Select Case sCommand
		        
		      Case "\cb"
		        //Background Color
		        oStyle.setBackgroundColor LookUpColor(dValue-1)
		      Case "\f"
		        //Font Name
		        oStyle.setFontName LookUpFont(dValue).Font
		      Case "\fs"
		        //Font Size
		        oStyle.setFontSize Round(dValue / 2.0)
		      Case "\b"
		        //Bold
		        oStyle.setBold True
		      Case "\expndtw"
		        //Character Spacing
		        oStyle.setCharacterSpacing (dValue / 240) * 100
		      Case "\i"
		        //Italic
		        oStyle.setItalic True
		      Case "\strike"
		        //StrikeThrough
		        oStyle.setStrikeThrough True
		      Case "\ul"
		        //Underline
		        oStyle.setUnderline True
		        
		      Case "\super"
		        //SuperScript
		        oStyle.setScriptLevel scriptValue(1, oLexer.GetText(oToken.value))
		        
		      Case "\sub"
		        //SubScript
		        oStyle.setScriptLevel scriptValue(-1, oLexer.GetText(oToken.value))
		        
		      Case "\cf"
		        //Text Color
		        oStyle.setTextColor LookUpColor(dValue-1)
		        
		      Case "\s"
		        //Paragraph Style
		        oStyle.setStyleNumber dValue
		        
		      Case "\shad"
		        //Shadow
		        oStyle.setShadow True
		        
		      Case "\shadc"
		        //Shadow Color
		        oStyle.setShadowColor LookUpColor(dValue-1)
		        
		      Case "\shado"
		        //Shadow Opacity
		        oStyle.setShadowOpacity dValue
		        
		      Case "\shadr"
		        //Shadow Blur
		        oStyle.setShadowBlur dValue/20
		        
		      Case "\shadx"
		        //Shadow Offset
		        oStyle.setShadowOffset dValue/20
		        
		      Case Else
		        IsUnknownCommand sCommand, CurrentMethodName
		      End
		      
		      
		      
		    Case RTFLexer.TokenTypes.GroupBegin
		      iGroupLevel = iGroupLevel + 1
		      
		    Case RTFLexer.TokenTypes.GroupEnd
		      iGroupLevel = iGroupLevel - 1
		      
		      If iGroupLevel < iStartGroupLevel Then
		        Exit While
		      End
		      
		    Case RTFLexer.TokenTypes.HexValue
		      Break
		      
		    Case RTFLexer.TokenTypes.Text
		      oStyle.SetStyleName oLexer.GetText(oToken.value).Replace(";", "")
		      dictCharacterStyles.value(oStyle.GetStyleName) = oStyle
		    End Select
		    
		    
		    oLastToken = oToken
		  Wend
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ParseColorTable(oLexer as RTFLexer)
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  dim oToken as RTFLexer.Token
		  dim iStartGroupLevel as integer = iGroupLevel
		  dim iRed as integer = -1
		  dim iGreen  as integer  = -1
		  dim iBlue as integer = -1
		  
		  while oLexer.NextToken(oToken)
		    
		    select case oToken.type
		    case RTFLexer.TokenTypes.ControlSymbol
		      dim sControlSymbol as String = oLexer.GetText(oToken.name)
		      select case sControlSymbol
		      case "\*"
		        ' bIgnore = true
		      case else
		        break//not handled
		      end
		      
		      
		    case RTFLexer.TokenTypes.ControlWord
		      dim sCommand as String = oLexer.GetText(oToken.name)
		      dim dValue as double = oLexer.GetText(oToken.value).val
		      
		      select case sCommand
		      case "\red"
		        iRed = dValue
		      case "\green"
		        iGreen = dValue
		      case "\blue"
		        iBlue = dValue
		      case else
		        IsUnknownCommand sCommand, CurrentMethodName
		      end
		      
		      ' case RTFLexer.TokenTypes.EOF
		      ' break
		      '
		      ' case RTFLexer.TokenTypes.Error
		      ' break
		      
		    case RTFLexer.TokenTypes.GroupBegin
		      iGroupLevel = iGroupLevel + 1
		      
		    case RTFLexer.TokenTypes.GroupEnd
		      iGroupLevel = iGroupLevel - 1
		      
		      if iGroupLevel < iStartGroupLevel then
		        exit while
		      end
		      
		      ' case RTFLexer.TokenTypes.HexValue
		      ' break
		      
		    case RTFLexer.TokenTypes.Text
		      //End of group?
		      if iRed <> -1 AND iGreen <> -1 AND iBlue <> -1 then
		        arColors.Append RGB(iRed, iGreen, iBlue)
		        iRed = -1
		        iGreen = -1
		        iBlue = -1
		      end
		    end select
		    
		    
		    oLastToken = oToken
		  wend
		  
		  ' Install a default color of black if no colors
		  if arColors.Ubound = -1 then
		    arColors.Append RGB(0, 0, 0)
		  end
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ParseConsume(oLexer as RTFLexer)
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  dim iStartGroupLevel as integer = iGroupLevel
		  
		  dim oToken as RTFLexer.Token
		  while oLexer.NextToken(oToken)
		    
		    select case oToken.type
		      ' case RTFLexer.TokenTypes.ControlSymbol
		      ' //Do nothing - consume it
		      ' case RTFLexer.TokenTypes.ControlWord
		      ' //Do nothing - consume it
		      ' case RTFLexer.TokenTypes.EOF
		      ' //Do nothing - consume it
		      ' case RTFLexer.TokenTypes.Error
		      ' //Do nothing - consume it
		    case RTFLexer.TokenTypes.GroupBegin
		      iGroupLevel = iGroupLevel + 1
		      
		    case RTFLexer.TokenTypes.GroupEnd
		      
		      iGroupLevel = iGroupLevel - 1
		      if iGroupLevel < iStartGroupLevel then
		        exit
		      end
		      
		      ' case RTFLexer.TokenTypes.HexValue
		      ' //Do nothing - consume it
		      ' case RTFLexer.TokenTypes.Text
		      ' //Do nothing - consume it
		    end select
		    
		    
		    oLastToken = oToken
		  wend
		  
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ParseControlSymbol(oToken as RTFLexer.Token, oLexer as RTFLexer)
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  dim sControlSymbol as String = oLexer.GetText(oToken.name)
		  select case sControlSymbol
		  case "\*"
		    ' oLexer.Rewind oLastToken
		    ' ConsumeGroup oLexer
		    
		    if bInCommentGroup = false then
		      bInCommentGroup = true
		      iStartCommentGroupLevel = iGroupLevel
		    end
		    
		  case "\~"
		    RaiseEvent NonbreakingSpace
		    
		  case "\_"
		    RaiseEvent NonbreakingHyphen
		    
		  case "\-"
		    RaiseEvent HyphenationPoint
		    
		  case "\\"
		    EmitEscapedCharacter "\"
		    
		  case "\{"
		    EmitEscapedCharacter "{"
		    
		  case "\}"
		    EmitEscapedCharacter "}"
		    
		  case else
		    
		    if sControlSymbol = "\" + EndOfLine.OSX then
		      RaiseEvent NewParagraph
		      
		      ' Reset the page break attribute.
		      oParagraphAttributes.pageBreak = false
		      return
		    end
		    
		    IsUnknownCommand sControlSymbol, CurrentMethodName
		    'app.LogMissingCommands "ParseControlSymbol: " + sControlSymbol
		  end
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ParseControlWord(oToken as RTFLexer.Token, oLexer as RTFLexer)
		  #If Not DebugBuild
		    
		    #Pragma BoundsChecking RTF_BOUNDSCHECKING
		    #Pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #Pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #EndIf
		  
		  Dim sCommand As String = oLexer.GetText(oToken.name)
		  Dim sValue As String = oLexer.GetText(oToken.value)
		  Dim dValue As Double = sValue.Val
		  Select Case sCommand
		  Case "\ansi"
		    oEncoding = Encodings.WindowsANSI
		  Case "\mac"
		    oEncoding = Encodings.MacRoman
		  Case "\pc"
		    oEncoding = Encodings.DOSLatinUS
		  Case "\pca"
		    oEncoding = Encodings.DOSLatin1
		  Case "\ansicpg"
		    ' 437United States IBM
		    ' 708Arabic (ASMO 708)
		    ' 709Arabic (ASMO 449+, BCON V4)
		    ' 710Arabic (transparent Arabic)
		    ' 711Arabic (Nafitha Enhanced)
		    ' 720Arabic (transparent ASMO)
		    ' 819Windows 3.1 (United States and Western Europe)
		    ' 850IBM multilingual
		    ' 852Eastern European
		    ' 860Portuguese
		    ' 862Hebrew
		    ' 863French Canadian
		    ' 864Arabic
		    ' 865Norwegian
		    ' 874Thai
		    ' 932Japanese
		    ' 936Simplified Chinese
		    ' 949Korean
		    ' 950Traditional Chinese
		    ' 1250Windows 3.1 (Eastern European)
		    ' 1251Windows 3.1 (Cyrillic)
		    ' 1252Western European
		    ' 1253Greek
		    ' 1254Turkish
		    ' 1255Hebrew
		    ' 1256Arabic
		    ' 1257Baltic
		    ' 1258Vietnamese
		    ' 1361Johab
		    iUnicodeCodepage = dValue
		    
		  Case "\colortbl"
		    ParseColorTable oLexer
		    
		  Case "\uc"
		    
		    //This may not be the proper description.  From http://msdn.microsoft.com/en-us/library/office/aa140301(v=office.10).aspx#rtfspec_9
		    ' This keyword represents the number of bytes corresponding to a given \uN Unicode character. This keyword may be used at any time, and values are scoped like character properties. That is, a \ucN keyword applies only to text following the keyword, and within the same (or deeper) nested braces. On exiting the group, the previous \uc value is restored. The reader must keep a stack of counts seen and use the most recent one to skip the appropriate number of characters when it encounters a \uN keyword. When leaving an RTF group that specified a \uc value, the reader must revert to the previous value. A default of 1 should be assumed, if no \uc keyword has been seen in the current or outer scopes.
		    ' A common practice is to emit no ANSI representation for Unicode characters within a Unicode destination context (that is, inside a \ud destination.). Typically, the destination will contain a \uc0 control sequence. There is no need to reset the count on leaving the \ud destination as the scoping rules will ensure the previous value is restored.
		    
		    ' Set up the skip count.
		    oStyleAttributes.unicodeSkipCount = dValue
		    
		  Case "\u"
		    //This keyword represents a single Unicode character that has no equivalent ANSI representation based on the current ANSI code page.
		    //N represents the Unicode character value expressed as a decimal number.
		    Dim sUnicodeText As String = ParseUnicodeString(oToken, oLexer)
		    
		    // Issue 4135: Ich migrieren Texte aus einer TextArea in das FTC (21May2019)
		    If dValue = 8232 Then
		      ' Call the user event.
		      RaiseEvent NewParagraph
		    Else
		      EmitTextSegment ConvertEncoding(sUnicodeText, Encodings.UTF8)
		    End If
		    
		  Case "\fonttbl"
		    //Font Table
		    oLexer.Rewind(oLastToken)
		    ParseFontTable oLexer
		    
		  Case "\stylesheet"
		    ParseStyleSheet oLexer
		    
		  Case "\mmath", "\mbrk", "\msmall", "\mdisp", "\ml", "\mr", "\mdef", "\mwrap", "\mint", "\mnary"
		    //WORD HEADER STUFF?
		    //Consume it.  Don't emit any text.
		    ParseConsume oLexer
		    
		  Case "\info"
		    ParseDocumentInfo oLexer
		    
		  Case "\paperw"
		    oDocumentAttributes.pageWidth = dvalue
		  Case "\paperh"
		    oDocumentAttributes.pageHeight = dValue
		  Case "\margl"
		    oDocumentAttributes.leftMargin= dValue
		  Case "\margr"
		    oDocumentAttributes.rightMargin= dValue
		  Case "\margt"
		    oDocumentAttributes.topMargin= dValue
		  Case "\margb"
		    oDocumentAttributes.bottomMargin= dValue
		  Case "\~"
		    RaiseEvent NonbreakingSpace
		    
		  Case "\_"
		    RaiseEvent NonbreakingHyphen
		    
		  Case "\-"
		    RaiseEvent HyphenationPoint
		    
		  Case "\\"
		    EmitEscapedCharacter "\"
		    
		  Case "\{"
		    EmitEscapedCharacter "{"
		    
		  Case "\}"
		    EmitEscapedCharacter "}"
		    
		    ' Style attributes.
		  Case "\f"
		    oStyleAttributes.Font = LookUpFont(dValue)
		  Case "\fs"
		    oStyleAttributes.fontSize = Round(dValue / 2.0)
		  Case "\b"
		    oStyleAttributes.bold = (sValue <> "0")
		  Case "\expndtw"
		    oStyleAttributes.characterSpacing = (dValue / 240) * 100
		  Case "\i"
		    oStyleAttributes.italic = (sValue <> "0")
		  Case "\ul"
		    oStyleAttributes.underline = (sValue <> "0")
		  Case "\ulnone"
		    oStyleAttributes.underline = False
		  Case "\strike"
		    oStyleAttributes.strikethrough = (sValue <> "0")
		  Case "\super"
		    oStyleAttributes.scriptLevel = scriptValue(1, oLexer.GetText(oToken.value))
		  Case "\sub"
		    oStyleAttributes.scriptLevel = scriptValue(-1, oLexer.GetText(oToken.value))
		  Case "\nosupersub"
		    oStyleAttributes.scriptLevel = 0
		  Case "\cs"
		    oStyleAttributes.characterStyle = dValue
		  Case "\cf"
		    oStyleAttributes.TextColor = LookUpColor(dValue-1)
		    oStyleAttributes.useForegroundColor = True
		  Case "\cb", "\chcbpat" ' "\chcbpat" is for Microsoft Word
		    oStyleAttributes.backgroundColor = LookUpColor(dValue-1)
		    oStyleAttributes.useBackgroundColor = True
		  Case "\plain"
		    oStyleAttributes.reset
		  Case "\shad"
		    //Shadow
		    oStyleAttributes.shadow = (sValue <> "0")
		  Case "\shadc"
		    //Shadow Color
		    oStyleAttributes.shadowColor = LookUpColor(dValue-1)
		  Case "\shado"
		    //Shadow Opacity
		    oStyleAttributes.shadowOpacity = 255-dValue
		  Case "\shadr"
		    //Shadow Blur
		    oStyleAttributes.shadowBlur = Round(dValue / 20)
		  Case "\shadx"
		    //Shadow Offset
		    oStyleAttributes.shadowOffset = Round(dValue / 20)
		    
		    ' Special characters.
		  Case "\tab"
		    EmitTextSegment Encodings.UTF8.Chr(9)
		  Case "\lquote"
		    EmitTextSegment "'"
		  Case "\rquote"
		    EmitTextSegment "'"
		  Case "\ldblquote"
		    EmitTextSegment """"
		  Case "\rdblquote"
		    EmitTextSegment """"
		  Case "\bullet"
		    EmitTextSegment Encodings.UTF8.Chr(&h2022)
		  Case "\endash"
		    EmitTextSegment Encodings.UTF8.Chr(&h2013)
		  Case "\emdash"
		    EmitTextSegment Encodings.UTF8.Chr(&h2014)
		  Case "\emspace"
		    EmitTextSegment Encodings.UTF8.Chr(&h2003)
		  Case "\enspace"
		    EmitTextSegment Encodings.UTF8.Chr(&h2002)
		  Case "\qmspace"
		    EmitTextSegment Encodings.UTF8.Chr(&h2001)
		  Case "\line"
		    ' Call the user event.
		    RaiseEvent NewParagraph
		    
		    ' Reset the page break attribute.
		    oParagraphAttributes.pageBreak = False
		  Case "\tx"
		    ' RTF: <tabkind>? <tablead>? \tx
		    
		    ' Reset hasTabLeading
		    hasTabLeading = False
		    
		    Dim count As Integer = oParagraphAttributes.tabStops.Ubound
		    If count > -1 Then
		      oParagraphAttributes.tabStops(count) = oParagraphAttributes.tabStops(count) + Str(dValue)
		    Else
		      oParagraphAttributes.tabStops.Append("0;" + Str(dValue))
		    End If
		    
		  Case "\tqr"
		    //Flush-Right Tab (NOT SUPPORTED)
		    ' Reset hasTabLeading
		    hasTabLeading = False
		    
		    oParagraphAttributes.tabStops.Append(If(hasTabLeading, Str(Integer(oParagraphAttributes.Leader)), "0") + ";" + Str(dValue))
		    
		  Case "\tqc"
		    //Centered tab. (NOT SUPPORTED)
		    ' Reset hasTabLeading
		    hasTabLeading = False
		    
		    oParagraphAttributes.tabStops.Append(Str(Integer(oParagraphAttributes.Leader)) + ";" + Str(dValue))
		    
		  Case "\tldot", "\tlhyph", "\tlmdot", "\tlul"
		    ' Set hasTabLeading
		    hasTabLeading = True
		    
		    ' Tabstop Leading Sign
		    Select Case sCommand
		    Case "\tldot"
		      
		      oParagraphAttributes.Leader = RTFParagraphAttributes.Tab_Leader_Type.Dot
		      
		    Case "\tlhyph"
		      
		      oParagraphAttributes.Leader = RTFParagraphAttributes.Tab_Leader_Type.Hypen
		      
		    Case "\tlmdot"
		      
		      oParagraphAttributes.Leader = RTFParagraphAttributes.Tab_Leader_Type.MiddleDot
		      
		    Case "\tlul"
		      
		      oParagraphAttributes.Leader = RTFParagraphAttributes.Tab_Leader_Type.Underscore
		      
		    End Select
		    
		    oParagraphAttributes.tabStops.Append(Str(oParagraphAttributes.Leader) + ";")
		    
		  Case "\par"
		    RaiseEvent NewParagraph
		    
		    ' Reset the page break attribute.
		    oParagraphAttributes.pageBreak = False
		    
		  Case "\page", "\pagebb"
		    oParagraphAttributes.pageBreak = True
		    
		  Case "\pard"
		    ' Reset the attributes.
		    oStyleAttributes.reset
		    oParagraphAttributes.reset
		  Case "\s"
		    //BK TO DO.  Not sure what I should be doing here.
		    ' if bApplyStyles then
		    ' oStyleAttributes.setStyle LookUpStyle(oLexer.GetText(oToken.value))
		    ' end
		    
		  Case "\ql"
		    oParagraphAttributes.alignment = RTFUtilities.RTFAlignment.ALIGN_LEFT
		  Case "\qc"
		    oParagraphAttributes.alignment = RTFUtilities.RTFAlignment.ALIGN_CENTER
		  Case "\qr"
		    oParagraphAttributes.alignment = RTFUtilities.RTFAlignment.ALIGN_RIGHT
		    
		  Case "\sa"
		    //SpaceAfter
		    oParagraphAttributes.afterSpace = dValue
		    
		  Case "\sb"
		    //SpaceBefore
		    oParagraphAttributes.beforeSpace = dValue
		    
		  Case "\sl"
		    //Line Spacing
		    oParagraphAttributes.lineSpacing = Abs(dValue)
		  Case "\slmult"
		    ' oParagraphAttributes.lineSpacing = dValue * 240
		  Case "\cbpat"
		    oParagraphAttributes.backgroundColor = LookUpColor(dValue - 1)
		    
		  Case "\li"
		    //Left Margin
		    oParagraphAttributes.leftMargin = RTFUtilities.TWIPSToInches(dValue)
		  Case "\ri"
		    //Right Margin
		    oParagraphAttributes.rightMargin = RTFUtilities.TWIPSToInches(dValue)
		  Case "\fi"
		    //First Indent
		    oParagraphAttributes.firstIndent = RTFUtilities.TWIPSToInches(dValue)
		  Case"\pict"
		    If bInCommentGroup = False Then
		      ParsePicture oLexer
		    End
		  Case "\field"
		    ParseField oLexer, oToken
		    
		  Case Else
		    IsUnknownCommand sCommand, CurrentMethodName
		    'app.LogMissingCommands "ParseControlWord: " + sCommand
		  End
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ParseDocumentInfo(oLexer as RTFLexer)
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Note that we are currently not doing anything with the document info.
		  ' This is here merely for formality and possible inclusion at a later date
		  
		  dim oToken as RTFLexer.Token
		  dim iStartGroupLevel as integer = iGroupLevel
		  
		  while oLexer.NextToken(oToken)
		    
		    select case oToken.type
		      ' case RTFLexer.TokenTypes.ControlSymbol
		      ' break //shouldn't be happening in the color table?
		      
		    case RTFLexer.TokenTypes.ControlWord
		      dim sCommand as String = oLexer.GetText(oToken.name)
		      
		      IsUnknownCommand sCommand, CurrentMethodName
		      
		    case RTFLexer.TokenTypes.GroupBegin
		      iGroupLevel = iGroupLevel + 1
		      
		    case RTFLexer.TokenTypes.GroupEnd
		      iGroupLevel = iGroupLevel - 1
		      
		      if iGroupLevel < iStartGroupLevel then
		        exit while
		      end
		      
		      ' case RTFLexer.TokenTypes.HexValue
		      ' break
		      '
		      ' case RTFLexer.TokenTypes.Text
		      
		    end select
		    
		    
		    oLastToken = oToken
		  wend
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ParseField(oLexer as RTFLexer, oBeginToken as RTFLexer.Token)
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  dim iStartGroupLevel as integer = iGroupLevel
		  
		  if FieldIsHyperLink(oLexer) then
		    oLexer.Rewind oBeginToken
		    ParseHyperlink oLexer
		    
		  elseif FieldIsShpPict(oLexer) then
		    oLexer.Rewind oBeginToken
		    ParsePicture oLexer
		    
		  else
		    
		    dim oToken as RTFLexer.Token
		    while oLexer.NextToken(oToken)
		      
		      select case oToken.type
		        ' case RTFLexer.TokenTypes.ControlSymbol
		        ' //Do nothing - consume it
		        ' case RTFLexer.TokenTypes.ControlWord
		        ' //Do nothing - consume it
		        ' case RTFLexer.TokenTypes.EOF
		        ' //Do nothing - consume it
		        ' case RTFLexer.TokenTypes.Error
		        ' //Do nothing - consume it
		      case RTFLexer.TokenTypes.GroupBegin
		        iGroupLevel = iGroupLevel + 1
		        
		      case RTFLexer.TokenTypes.GroupEnd
		        
		        iGroupLevel = iGroupLevel - 1
		        if iGroupLevel < iStartGroupLevel then
		          exit
		        end
		        
		        ' case RTFLexer.TokenTypes.HexValue
		        ' //Do nothing - consume it
		        ' case RTFLexer.TokenTypes.Text
		        ' //Do nothing - consume it
		      end select
		      
		      
		      oLastToken = oToken
		    wend
		    
		    
		    
		  end
		  
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ParseFontTable(oLexer as RTFLexer)
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  dim oToken as RTFLexer.Token
		  dim iStartGroupLevel as integer = iGroupLevel
		  dim oFontHolder as new RTFFont
		  dim bIgnore as boolean
		  
		  'add symbol font
		  oFontHolder = new RTFFont
		  oFontHolder.font = "Symbol"
		  oFontHolder.characterSet = 77
		  dictFonts.Value(SYMBOL_FONT_INDEX) = oFontHolder
		  oFontHolder = nil
		  
		  while oLexer.NextToken(oToken)
		    
		    select case oToken.type
		    case RTFLexer.TokenTypes.ControlSymbol
		      dim sControlSymbol as String = oLexer.GetText(oToken.name)
		      select case sControlSymbol
		      case "\*"
		        bIgnore = true
		      case else
		        break//not handled
		      end select
		    case RTFLexer.TokenTypes.ControlWord
		      if bIgnore = false then
		        dim sCommand as String = oLexer.GetText(oToken.name)
		        dim dValue as double = oLexer.GetText(oToken.value).val
		        select case sCommand
		        case "\f"
		          dim iFontNumber as integer = Val(oLexer.GetText(oToken.value))
		          oFontHolder = new RTFFont
		          dictFonts.Value(iFontNumber) = oFontHolder
		        case "\fcharset"
		          if oFontHolder<>nil then
		            oFontHolder.characterSet = dValue
		          end if
		        case else
		          IsUnknownCommand sCommand, CurrentMethodName
		        end
		      end
		    case RTFLexer.TokenTypes.GroupBegin
		      iGroupLevel = iGroupLevel + 1
		      
		    case RTFLexer.TokenTypes.GroupEnd
		      if bIgnore then bIgnore = false
		      
		      iGroupLevel = iGroupLevel - 1
		      
		      if iStartGroupLevel = iGroupLevel then
		        exit while
		      end if
		    case RTFLexer.TokenTypes.Text
		      if bIgnore = false and oFontHolder<>nil then
		        oFontHolder.font = oLexer.GetText(oToken.value).replace(";", "")
		      end if
		    end select
		    
		    oLastToken = oToken
		  wend
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ParseHyperlink(oLexer as RTFLexer)
		  #If Not DebugBuild
		    
		    #Pragma BoundsChecking RTF_BOUNDSCHECKING
		    #Pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #Pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #EndIf
		  
		  Dim oToken As RTFLexer.Token
		  Dim iStartGroupLevel As Integer = iGroupLevel
		  Dim sURL As String
		  Dim sText As String
		  
		  Dim bIgnore As Boolean
		  
		  While oLexer.NextToken(oToken)
		    
		    Select Case oToken.type
		      
		      //Issue #4074: RTF clipboard ignores hyperlinks with umlauts and cuts them
		    Case RTFLexer.TokenTypes.HexValue
		      If bInCommentGroup  = False Then
		        'if there's a run of hex data then grab all of it
		        oLexer.Rewind(oToken)
		        Dim arsByte() As String
		        While oLexer.NextToken(oToken)
		          If oToken.type<>RTFLexer.TokenTypes.HexValue Then
		            oLexer.Rewind(oToken)
		            Exit While
		          End If
		          Dim sHexByte As String = oLexer.GetData(oToken.value)
		          arsByte.Append(ChrB(Val("&h" + sHexByte)))
		        Wend
		        
		        Dim sData As String = Join(arsByte, "")
		        EmitTextSegment(DecodeTextData(sData))
		      End If
		      
		    Case RTFLexer.TokenTypes.ControlSymbol
		      Dim sControlSymbol As String = oLexer.GetText(oToken.name)
		      Select Case sControlSymbol
		      Case "\*"
		        
		      Case Else
		        'app.LogMissingCommands "ParseHyperlink (ControlSymbol): " + sControlSymbol
		      End
		      
		    Case RTFLexer.TokenTypes.ControlWord
		      
		      Dim sCommand As String = oLexer.GetText(oToken.name)
		      Dim sValue As String = oLexer.GetText(oToken.value)
		      Dim dValue As Double = sValue.Val
		      
		      
		      Select Case sCommand
		      Case "\'"
		        Break
		      Case "\u"
		        sText =  sText + ParseUnicodeString(oToken, oLexer)
		      Case "\uc"
		        //This may not be the proper description.  From http://msdn.microsoft.com/en-us/library/office/aa140301(v=office.10).aspx#rtfspec_9
		        ' This keyword represents the number of bytes corresponding to a given \uN Unicode character. This keyword may be used at any time, and values are scoped like character properties. That is, a \ucN keyword applies only to text following the keyword, and within the same (or deeper) nested braces. On exiting the group, the previous \uc value is restored. The reader must keep a stack of counts seen and use the most recent one to skip the appropriate number of characters when it encounters a \uN keyword. When leaving an RTF group that specified a \uc value, the reader must revert to the previous value. A default of 1 should be assumed, if no \uc keyword has been seen in the current or outer scopes.
		        ' A common practice is to emit no ANSI representation for Unicode characters within a Unicode destination context (that is, inside a \ud destination.). Typically, the destination will contain a \uc0 control sequence. There is no need to reset the count on leaving the \ud destination as the scoping rules will ensure the previous value is restored.
		        
		        ' Set up the skip count.
		        oStyleAttributes.unicodeSkipCount = dValue
		      Case "\f"
		        oStyleAttributes.Font = LookUpFont(dValue)
		      Case "\fs"
		        oStyleAttributes.fontSize = Round(dValue / 2.0)
		      Case "\b"
		        oStyleAttributes.bold = (sValue <> "0")
		      Case "\expndtw"
		        //Character Spacing
		        oStyleAttributes.characterSpacing = (dValue / 240) * 100
		      Case "\i"
		        oStyleAttributes.italic = (sValue <> "0")
		      Case "\ul"
		        oStyleAttributes.underline = (sValue <> "0")
		      Case "\ulnone"
		        oStyleAttributes.underline = False
		      Case "\strike"
		        oStyleAttributes.strikethrough = (sValue <> "0")
		      Case "\super"
		        oStyleAttributes.scriptLevel = scriptValue(1, oLexer.GetText(oToken.value))
		      Case "\sub"
		        oStyleAttributes.scriptLevel = scriptValue(-1, oLexer.GetText(oToken.value))
		      Case "\nosupersub"
		        oStyleAttributes.scriptLevel = 0
		      Case "\cs"
		        oStyleAttributes.characterStyle = dValue
		      Case "\cf"
		        oStyleAttributes.TextColor = LookUpColor(dValue-1)
		        oStyleAttributes.useForegroundColor = True
		      Case "\cb"
		        oStyleAttributes.backgroundColor = LookUpColor(dValue-1)
		        oStyleAttributes.useBackgroundColor = True
		      Case "\datafield"
		        bIgnore = True
		      Case "\field", "\fldinst", "\fldrslt"
		        //Ignore
		      Case Else
		        IsUnknownCommand sCommand, CurrentMethodName
		        'app.LogMissingCommands "ParseHyperlink (Command): " + sCommand
		      End
		      
		      
		    Case RTFLexer.TokenTypes.GroupBegin
		      iGroupLevel = iGroupLevel + 1
		      
		    Case RTFLexer.TokenTypes.GroupEnd
		      
		      
		      iGroupLevel = iGroupLevel - 1
		      
		      
		      If iGroupLevel < iStartGroupLevel Then
		        
		        //BK: 01June2019 4074: RTF clipboard ignores hyperlinks with umlauts and cuts them
		        oStyleAttributes.reset
		        Exit
		        
		      End
		      
		    Case RTFLexer.TokenTypes.Text
		      
		      Dim sData As String = oLexer.GetText(oToken.value)
		      
		      If sData.InStr("HYPERLINK") > 0 Then
		        sURL = sData.Replace("HYPERLINK", "").ReplaceAll(Chr(34), "")
		        oStyleAttributes.hyperlink = sURL
		        
		      Else
		        
		        If bIgnore = False Then
		          
		          EmitTextSegment(DecodeTextData(sData))
		          
		        Else
		          bIgnore = False
		        End
		      End
		      
		    End Select
		    
		    
		    oLastToken = oToken
		  Wend
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ParsePicture(oLexer as RTFLexer)
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  dim oToken as RTFLexer.Token
		  dim iStartGroupLevel as integer = iGroupLevel
		  dim iStartPictureLevel as integer
		  dim iPictureType as integer = UNSUPPORTED_PICTURE
		  dim iWidth as integer
		  dim iHeight as integer
		  dim iWidthGoal as integer
		  dim iHeightGoal as integer
		  dim arsData() as string
		  dim bIgnore as boolean
		  dim bnonshppict as boolean
		  
		  dim iStartCommentLevel as integer
		  dim bIgnoreStyle as boolean
		  
		  while oLexer.NextToken(oToken)
		    
		    select case oToken.type
		    case RTFLexer.TokenTypes.ControlSymbol
		      dim sControlSymbol as String = oLexer.GetText(oToken.name)
		      select case sControlSymbol
		      case "\*"
		        bIgnore = true
		        iStartCommentLevel = iGroupLevel
		      case "\\"
		        //do nothing
		      case else
		        break//not handled
		      end
		      
		    case RTFLexer.TokenTypes.ControlWord
		      
		      dim sCommand as String = oLexer.GetText(oToken.name)
		      dim dValue as double = oLexer.GetText(oToken.value).val
		      
		      if bIgnore = false then
		        select case sCommand
		        case "\nonshppict"
		          bNonShpPict = true
		          iStartPictureLevel = iGroupLevel
		        case "\pngblip"
		          iPictureType = PNG_PICTURE
		        case "\jpegblip"
		          iPictureType = JPEG_PICTURE
		        case "\macpict"
		          iPictureType = MAC_PICTURE
		        case "\emfblip"
		          //EMF (enhanced metafile).
		          iPictureType = EMF_PICTURE
		        case "\pmmetafile"
		          //OS/2 metafile
		          iPictureType = OS2METAFILE_PICTURE  //Unsupported
		        case "\wmetafile"
		          //Source of the picture is a Windows metafile.
		          iPictureType = WINDOWSMETAFILE_PICTURE  //Unsupported
		        case "\picw"
		          iWidth = dValue
		        case "\pich"
		          iHeight = dValue
		          
		        case "\picwgoal"
		          //Desired width of the picture in twips
		          iWidthGoal = dValue/240
		        case "\pichgoal"
		          //Desired height of the picture in twips
		          iHeightGoal = dValue/240
		        case "\bliptag"
		          //A mostly unique identifier for a picture
		          ': -1883724787
		          
		        case "\sn", "\sp", "\sv"
		          bIgnoreStyle = true
		          
		        case else
		          IsUnknownCommand sCommand, CurrentMethodName
		          'app.LogMissingCommands "ParsePicture: " + sCommand
		        end
		        
		      end
		      
		      ' case RTFLexer.TokenTypes.EOF
		      ' //Consume
		      '
		      ' case RTFLexer.TokenTypes.Error
		      ' //Consume
		      
		    case RTFLexer.TokenTypes.GroupBegin
		      iGroupLevel = iGroupLevel + 1
		      
		    case RTFLexer.TokenTypes.GroupEnd
		      
		      
		      iGroupLevel = iGroupLevel - 1
		      bIgnore = false
		      
		      
		      if iGroupLevel <= iStartCommentLevel then
		        bIgnoreStyle = false
		      end
		      
		      if bnonshppict = false and iGroupLevel < iStartPictureLevel then
		        if arsData.Ubound > -1 then
		          dim sHex as string = join(arsData, "")
		          
		          if sHex.left(2) = "01" then
		            ' 'app.LogMissingCommands "SKIPPING PICTURE CONVERSION BAD DATA"
		            if iGroupLevel <= iStartGroupLevel then
		              exit
		            else
		              redim arsData(-1)
		              CONTINUE
		            end
		          end
		          
		          dim sBinary as string = RTFUtilities.hexToBinary(sHex)
		          dim p as picture
		          ' Reconstruct the picture.
		          select case iPictureType
		            
		          case PNG_PICTURE
		            
		            ' Create the picture.
		            p = RTFUtilities.PNGStringToPicture(sBinary)
		            
		          case JPEG_PICTURE
		            
		            ' Create the picture.
		            p = RTFUtilities.JPEGStringToPicture(sBinary)
		            
		          case MAC_PICTURE
		            
		            ' Create the picture.
		            p = openMacPicture(sBinary, iWidth, iHeight, iWidthGoal, iHeightGoal)
		            
		          case UNSUPPORTED_PICTURE, OS2METAFILE_PICTURE, WINDOWSMETAFILE_PICTURE, EMF_PICTURE
		            //Give it a shot
		            p = openPicture(sBinary, iWidth, iHeight, iWidthGoal, iHeightGoal)
		            
		          end select
		          
		          if p <> nil then
		            ' 'app.LogMissingCommands "ParsePicure: Added P"
		            redim arsData(-1)
		            RaiseEvent AddPicture p
		          else
		            redim arsData(-1)
		            ' 'app.LogMissingCommands "ParsePicure:  P IS NIL"
		          end
		          
		        end
		      end
		      
		      if iGroupLevel < iStartGroupLevel then exit
		      
		      ' case RTFLexer.TokenTypes.HexValue
		      ' //Consume
		      
		    case RTFLexer.TokenTypes.Text
		      dim sData as string = oLexer.GetText(oToken.value)
		      
		      if bIgnore = false and bIgnoreStyle = false and bNonShpPict = false then
		        if iStartPictureLevel = 0 then iStartPictureLevel = iGroupLevel
		        
		        arsData.Append sData
		      end
		      
		      //Word files like to put style information before the pictdata
		      if bIgnoreStyle then bIgnoreStyle = false
		    end select
		    
		    
		    oLastToken = oToken
		  wend
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ParseStyleSheet(oLexer as RTFLexer)
		  #If Not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  dim oToken as RTFLexer.Token
		  dim iStartGroupLevel as integer = iGroupLevel
		  
		  Dim oStyle as new RTFParagraphStyle("unknown")
		  
		  while oLexer.NextToken(oToken)
		    
		    select case oToken.type
		    case RTFLexer.TokenTypes.ControlSymbol
		      dim sControlSymbol as String = oLexer.GetText(oToken.name)
		      select case sControlSymbol
		      case "\*"
		        ' bIgnore = true
		      case else
		        break//not handled
		      end
		      
		    case RTFLexer.TokenTypes.ControlWord
		      dim sCommand as String = oLexer.GetText(oToken.name)
		      dim dValue as double = oLexer.GetText(oToken.value).val
		      
		      select case sCommand
		      case "\ql"
		        //Left Alignment
		        oStyle.setAlignment FTParagraph.Alignment_Type.Left
		      Case "\qc"
		        //Center Alignment
		        oStyle.setAlignment  FTParagraph.Alignment_Type.Center
		      case "\qr"'
		        //Right Alignment
		        oStyle.setAlignment  FTParagraph.Alignment_Type.Right
		      case "\li"
		        //Left Margin
		        oStyle.setLeftMargin RTFUtilities.TWIPSToInches(dValue)
		      case "\ri"
		        //Right Margin
		        oStyle.setRightMargin RTFUtilities.TWIPSToInches(dValue)
		      case "\fi"
		        //First Indent
		        oStyle.setFirstIndent RTFUtilities.TWIPSToInches(dValue)
		      case "\sb"
		        //Set Before Space
		        oStyle.setBeforeSpace RTFUtilities.TWIPSToInches(dValue)
		      case "\sa"
		        //Set After Space
		        oStyle.setAfterSpace RTFUtilities.TWIPSToInches(dValue)
		      case "\sl"
		        //Line Spacing
		        oStyle.setLineSpacing dValue
		      case "\slmult"
		        oStyle.setLineSpacing dValue * 240
		      case "\cb"
		        //Background Color
		        oStyle.setBackgroundColor LookUpColor(dValue-1)
		      case "\f"
		        //Font Name
		        oStyle.setFontName LookUpFont(dValue).font
		      case "\fs"
		        //Font Size
		        oStyle.setFontSize Round(dValue / 2.0)
		      case "\b"
		        //Bold
		        oStyle.setBold true
		      Case "\expndtw"
		        //Character Spacing
		        oStyle.setCharacterSpacing (dValue / 240) * 100
		      case "\i"
		        //Italic
		        oStyle.setItalic true
		      case "\strike"
		        //StrikeThrough
		        oStyle.setStrikeThrough true
		      case "\ul"
		        //Underline
		        oStyle.setUnderline true
		        
		      case "\super"
		        //SuperScript
		        oStyle.setScriptLevel scriptValue(1, oLexer.GetText(oToken.value))
		        
		      case "\sub"
		        //SubScript
		        oStyle.setScriptLevel scriptValue(-1, oLexer.GetText(oToken.value))
		        
		      case "\cf"
		        //Text Color
		        oStyle.setTextColor LookUpColor(dValue-1)
		        
		      case "\s"
		        //Paragraph Style
		        oStyle.setStyleNumber dValue
		      case "\cs"
		        //Designates character style. If a character style is specified, style properties must be specified with the character run. N refers to an entry in the style table.
		        ParseCharacterStyles oLexer
		        
		      Case "\shad"
		        //Shadow
		        oStyle.setShadow True
		        
		      Case "\shadc"
		        //Shadow Color
		        oStyle.setShadowColor LookUpColor(dValue-1)
		        
		      Case "\shado"
		        //Shadow Opacity
		        oStyle.setShadowOpacity(dValue)
		        
		      Case "\shadr"
		        //Shadow Blur
		        oStyle.setShadowBlur dValue/20
		        
		      Case "\shadx"
		        //Shadow Offset
		        oStyle.setShadowOffset dValue/20
		        
		      case else
		        IsUnknownCommand sCommand, CurrentMethodName
		        'app.LogMissingCommands "StyleSheet: " + sCommand //break
		      end
		      
		      
		      
		    case RTFLexer.TokenTypes.GroupBegin
		      iGroupLevel = iGroupLevel + 1
		      
		    case RTFLexer.TokenTypes.GroupEnd
		      iGroupLevel = iGroupLevel - 1
		      
		      if iGroupLevel < iStartGroupLevel then
		        exit while
		      end
		      
		      ' case RTFLexer.TokenTypes.HexValue
		      ' break
		      
		    case RTFLexer.TokenTypes.Text
		      oStyle.SetStyleName oLexer.GetText(oToken.value).replace(";", "")
		      dictParagraphStyles.value(oStyle.GetStyleName) = oStyle
		    end select
		    
		    
		    oLastToken = oToken
		  wend
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ParseText(oToken as RTFLexer.Token, oLexer as RTFLexer)
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  dim sData as string = oLexer.GetData(oToken.value)
		  EmitTextSegment(DecodeTextData(sData))
		  
		  'RAS: 6 Feb 15
		  'The call to oStyleAttributes.reset is commented out because in a RTF document
		  'that only uses on set of text style attributtes
		  'for the entire document (all paragraphs have the same Font, Font Size, etc).
		  'Resetting the StyleAttributes sets the attributes to the FTC Document defaults
		  'and the RTF document does not import correctly.
		  'oStyleAttributes.reset
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ParseUnicodeString(oToken as RTFLexer.Token, oLexer as RTFLexer) As String
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  //This keyword represents a single Unicode character that has no equivalent ANSI representation based on the current ANSI code page.
		  //N represents the Unicode character value expressed as a decimal number.
		  
		  'consume as many \u values as possible
		  dim arsUnicodeChar() as string
		  
		  oLexer.Rewind(oToken)
		  while oLexer.NextToken(oToken)
		    if oToken.type<>RTFLexer.TokenTypes.ControlWord or _
		      oLexer.GetText(oToken.name)<>"\u" then
		      oLexer.Rewind(oToken)
		      exit while
		    end if
		    
		    dim sCharValue as string = oLexer.GetText(oToken.value)
		    dim c as integer = Val(sCharValue)
		    if c<0 then
		      c = c + 65536
		    end if
		    
		    dim sChar as string
		    sChar = Encodings.UTF8.Chr(c)
		    arsUnicodeChar.Append(sChar)
		    
		    dim iSkipCount as integer = oStyleAttributes.unicodeSkipCount
		    if iSkipCount>0 then
		      Skip(oLexer, iSkipCount)
		    end if
		  wend
		  
		  dim sUnicodeText as string = Join(arsUnicodeChar, "")
		  return ConvertEncoding(sUnicodeText, Encodings.UTF8)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function scriptValue(defaultValue as integer, value as string) As integer
		  ' Is there something in the value?
		  if Trim(value) <> "" then
		    
		    ' Is it a zero to signal the scripting off?
		    if Val(Value) = 0 then
		      
		      ' Turn off the scripting.
		      return 0
		      
		    end if
		    
		  else
		    
		    ' Return the value passed in.
		    return defaultValue
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SetupKnownCommands()
		  Redim arsKnownCommands(-1)
		  
		  arsKnownCommands.append "\rtf"
		  
		  arsKnownCommands.append "\adeff"
		  arsKnownCommands.append"\adeflang"
		  arsKnownCommands.append "\aenddoc"//Endnotes at end of document.
		  arsKnownCommands.append "\ab"
		  arsKnownCommands.append "\ai"
		  arsKnownCommands.append "\aspalpha"//Auto spacing between DBC and English.
		  arsKnownCommands.append "\aspnum" //Auto spacing between DBC and numbers.
		  arsKnownCommands.append "\adjustright" //Automatically adjust right indent when document grid is defined.
		  arsKnownCommands.append "\af"//Associated font number (the default is 0).
		  arsKnownCommands.append "\afs"//Associated font size in half-points (the default is 24).
		  arsKnownCommands.append "\alang"//Language ID for the associated font. (This uses the same language ID codes described in the standard language table in the Character Text section of this RTF Specification.)
		  arsKnownCommands.append "\additive"//Used in a character style definition ('{\*'\cs...'}'). Indicates that character style attributes are to be added to the current paragraph style attributes, rather than setting the paragraph attributes to only those defined in the character style definition.
		  arsKnownCommands.append "\aspalpha"//Auto spacing between DBC and English.
		  arsKnownCommands.append "\aspnum"//Auto spacing between DBC and numbers.
		  arsKnownCommands.append "\adjustright"//Automatically adjust right indent when document grid is defined.
		  arsKnownCommands.append "\author"
		  
		  arsKnownCommands.append "\bliptag" //A mostly unique identifier for a picture
		  arsKnownCommands.append "\blipupi"//represents units per inch on a picture (only certain image types need or output this)
		  arsKnownCommands.append "\box" //Border around the paragraph (box paragraph).
		  arsKnownCommands.append "\brdrsh" //Shadowed border.
		  arsKnownCommands.append "\brdrart" //Page border art; the N argument is a value from 1-165 representing the number of the border.
		  arsKnownCommands.append "\brdrw" //N is the width in twips of the pen used to draw the paragraph border line. N cannot be greater than 75. To obtain a larger border width, the \brdth control word can be used to obtain a width double that of N.
		  arsKnownCommands.append "\brsp" //Space in twips between borders and the paragraph.
		  arsKnownCommands.append "\brdrcf" //N is the color of the paragraph border, specified as an index into the color table in the RTF header.
		  arsKnownCommands.append "\brdrframe" //Border resembles a "Frame."
		  arsKnownCommands.append "\brdrbtw"  //Consecutive paragraphs with identical border formatting are considered part of a single group with the border information applying to the entire group. To have borders around individual paragraphs within the group, the \brdrbtw control must be specified for that paragraph.
		  arsKnownCommands.append "\brdrnone"
		  arsKnownCommands.append "\brdrbar"  //Border outside (right side of odd-numbered pages, left side of even-numbered pages).
		  arsKnownCommands.append "\brdrt" '? border top
		  arsKnownCommands.append "\brdrs"'? border shadow
		  arsKnownCommands.append "\brdrl"'? border left
		  arsKnownCommands.append "\brdrb"'? border bottom
		  arsKnownCommands.append "\brdrr"'? border right
		  
		  
		  
		  arsKnownCommands.append"\charrsid"
		  arsKnownCommands.append "\cocoartf"
		  arsKnownCommands.append "\cocoasubrtf"
		  arsKnownCommands.append "\cgrid"//Character grid.
		  arsKnownCommands.append "\creatim"
		  arsKnownCommands.append "\charrsid"
		  arsKnownCommands.append "\cgrid"//Character grid.
		  arsKnownCommands.append "\cs"//Designates character style. If a character style is specified, style properties must be specified with the character run. N refers to an entry in the style table.
		  
		  
		  
		  
		  arsKnownCommands.append "\deff"  //Font table stuff
		  arsKnownCommands.append"\deflang"
		  arsKnownCommands.append "\deflangfe"
		  arsKnownCommands.append "\deftab"//Default tab width in twips (the default is 720).
		  arsKnownCommands.append "\donotembedsysfont"
		  arsKnownCommands.append"\donotembedlingdata"
		  arsKnownCommands.append "\dghspace"
		  arsKnownCommands.append"\dgvspace"
		  arsKnownCommands.append"\dghorigin"
		  arsKnownCommands.append"\dgvorigin"
		  arsKnownCommands.append"\dghshow"
		  arsKnownCommands.append"\dgvshow"
		  arsKnownCommands.append "\dy"
		  arsKnownCommands.append "\dbch"//The text consists of double-byte characters.
		  
		  
		  arsKnownCommands.append "\expnd"
		  arsKnownCommands.append "\edmins"
		  
		  arsKnownCommands.append "\fbidi"
		  arsKnownCommands.append "\froman"' \froman    Roman, proportionally spaced serif fonts    eg. Times New Roman, Palatino
		  arsKnownCommands.append "\fcharset" ' Specifies the character set of a font in the font table. Values for N are defined by Windows header files:
		  arsKnownCommands.append "\fprq" 'Specifies the pitch of a font in the font table.
		  arsKnownCommands.append "\ftnbj"//Footnotes at the bottom of the page (bottom justified).
		  arsKnownCommands.append "\fet" ' Footnote/endnote type. This indicates what type of notes are present in the document.
		  arsKnownCommands.append "\faauto"
		  arsKnownCommands.append "\fcs"//Unknown
		  arsKnownCommands.append "\faauto"
		  arsKnownCommands.append "\fcs"
		  arsKnownCommands.append "\fbidi"
		  arsKnownCommands.append  "\fonttbl"
		  arsKnownCommands.append "\froman"
		  arsKnownCommands.append  "\fswiss"
		  arsKnownCommands.append  "\fmodern" // Roman, proportionally spaced serif fonts    eg. Times New Roman, Palatino
		  arsKnownCommands.append "\fprq"  //Specifies the pitch of a font in the font table.
		  arsKnownCommands.append "\flomajor"
		  arsKnownCommands.append  "\fdbmajor"
		  arsKnownCommands.append  "\fhimajor"
		  arsKnownCommands.append  "\flominor"
		  arsKnownCommands.append  "\fdbminor"
		  arsKnownCommands.append  "\fhiminor"
		  arsKnownCommands.append  "\fbimajor"
		  arsKnownCommands.append  "\fbiminor"
		  arsKnownCommands.append "\fnil"
		  arsKnownCommands.append "\fldedit"
		  arsKnownCommands.append "\fldinst"
		  arsKnownCommands.append "\fldrslt"
		  arsKnownCommands.append "\field"
		  arsKnownCommands.append "\fldedit"
		  arsKnownCommands.append "\fldrslt"
		  arsKnownCommands.append "\fcs"
		  arsKnownCommands.append "\f"
		  arsKnownCommands.append "\faauto"
		  
		  
		  
		  arsKnownCommands.append"\grfdocevents"
		  arsKnownCommands.append "\gutter" //Gutter width in twips (the default is 0).
		  
		  
		  arsKnownCommands.append "\horzdoc" //Horizontal rendering.
		  arsKnownCommands.append "\hr"
		  arsKnownCommands.append "\hich" //The text consists of single-byte high-ANSI (0x80–0xFF) characters.
		  
		  arsKnownCommands.append "\ignoremixedcontent"
		  arsKnownCommands.append "\ilfomacatclnup"
		  arsKnownCommands.append "\insrsid"
		  arsKnownCommands.append "\itap"//Paragraph nesting level, where 0 is the main document, 1 is a table cell, 2 is a nested table cell, 3 is a doubly nested table cell, and so forth. The default is 1.
		  arsKnownCommands.append "\insrsid"
		  
		  
		  
		  arsKnownCommands.append "\jcompress" //Compressing justification (default).
		  
		  arsKnownCommands.append "\kerning"
		  arsKnownCommands.append "\keepn" //Keep paragraph with the next paragraph.
		  
		  arsKnownCommands.append "\lang"//Applies a language to a character
		  arsKnownCommands.append "\langfe"//Applies a language to a character. N is a number corresponding to a language.
		  arsKnownCommands.append "\langnp"//Applies a language to a character. N is a number corresponding to a language.
		  arsKnownCommands.append "\langfenp"//Applies a language to a character. N is a number corresponding to a language.
		  arsKnownCommands.append "\ltrsect"//This section will snake (newspaper style) columns from left to right (the default).
		  arsKnownCommands.append"\ltrpar"
		  arsKnownCommands.append"\linex"
		  arsKnownCommands.append "\lin"//Left indent for left-to-right paragraphs; right indent for right-to-left paragraphs (the default is 0). It defines space before the paragraph.
		  arsKnownCommands.append "\ltrch"//The character data following this control word will be treated as a left-to-right run (the default).
		  arsKnownCommands.append "\loch"//The text consists of single-byte low-ANSI (0x00–0x7F) characters.
		  
		  
		  arsKnownCommands.append "\min"
		  arsKnownCommands.append "\mo"
		  
		  
		  arsKnownCommands.append"/noqfpromote"
		  arsKnownCommands.append "\noqfpromote"
		  arsKnownCommands.append "\nowidctlpar"
		  arsKnownCommands.append "\nofpages"
		  arsKnownCommands.append "\nofwords"
		  arsKnownCommands.append  "\nofchars"
		  arsKnownCommands.append  "\nofcharsws"
		  arsKnownCommands.append "\nowidctlpar"
		  
		  arsKnownCommands.append "\outlinelevel"//Outline level of paragraph. The N argument is a value from 0-8 representing the outline level of the paragraph. In the default arsKnownCommands.append, no outline level is specified (same as body text).
		  arsKnownCommands.append "\outl"
		  arsKnownCommands.append "\operator"
		  
		  
		  
		  arsKnownCommands.append "\pararsid"
		  arsKnownCommands.append "\pardeftab"
		  arsKnownCommands.append "\pardirnatural"
		  arsKnownCommands.append "\picscalex" //Horizontal scaling value. The N argument is a value representing a percentage (the default is 100).
		  arsKnownCommands.append "\picscaley"//Vertical scaling value. The N argument is a value representing a percentage (the default is 100).
		  arsKnownCommands.append "\piccropl"//Left cropping value in twips. A positive value crops toward the center of the picture; a negative value crops away from the center, adding a space border around picture (the default is 0).
		  arsKnownCommands.append "\piccropr"//Right cropping value in twips. A positive value crops toward the center of the picture; a negative value crops away from the center, adding a space border around picture (the default is 0).
		  arsKnownCommands.append "\piccropt"//Top cropping value in twips. A positive value crops toward the center of the picture; a negative value crops away from the center, adding a space border around picture (the default is 0).
		  arsKnownCommands.append "\piccropb"//Bottom cropping value in twips. A positive value crops toward the center of the picture; a negative value crops away from the center, adding a space border around picture (the default is 0).
		  arsKnownCommands.Append "\pict"
		  
		  
		  
		  arsKnownCommands.append "\relyonvml"
		  arsKnownCommands.append"\rsidroot"
		  arsKnownCommands.append "\rtlch"' Token commands.
		  arsKnownCommands.append "\rin"//Right indent for left-to-right paragraphs; left indent for right-to-left paragraphs (the default is 0). It defines space after the paragraph.
		  arsKnownCommands.append "\rtlch"//The character data following this control word will be treated as a right-to-left run.
		  arsKnownCommands.append "\rin"//Right indent for left-to-right paragraphs; left indent for right-to-left paragraphs (the default is 0). It defines space after the paragraph.
		  arsKnownCommands.append "\revtim"
		  arsKnownCommands.append "\rtlch"//The character data following this control word will be treated as a right-to-left run.
		  arsKnownCommands.append "\rtlgutter"//Gutter is positioned on the right
		  
		  arsKnownCommands.append"\shad"
		  arsKnownCommands.append"\shadc"
		  arsKnownCommands.append"\shado"
		  arsKnownCommands.append"\shadr"
		  arsKnownCommands.append"\shadx"
		  
		  arsKnownCommands.append"\saveinvalidxml"
		  arsKnownCommands.append"\showplaceholdtext"
		  arsKnownCommands.append"\stshfdbch"
		  arsKnownCommands.append"\stshfloch"
		  arsKnownCommands.append"\stshfhich"
		  arsKnownCommands.append "\stshfbi"
		  arsKnownCommands.append"\showxmlerrors"
		  arsKnownCommands.append"\sectd"
		  arsKnownCommands.append"\sectdefaultcl"
		  arsKnownCommands.append"\sftnbj"
		  arsKnownCommands.append "\snext"//Defines the next style associated with the current style; if omitted, the next style is the current style
		  arsKnownCommands.append "\sqformat"//Unknown
		  arsKnownCommands.append "\spriority"//Unknown
		  arsKnownCommands.append "\sbasedon"//Defines the number of the style on which the current style is based (the default is 222—no style).
		  arsKnownCommands.append "\slink"
		  arsKnownCommands.append "\strokewidth"
		  arsKnownCommands.append "\strokec"
		  arsKnownCommands.append "\slocked"
		  arsKnownCommands.append "\ssemihidden"
		  arsKnownCommands.append "\sunhideused"
		  
		  
		  
		  arsKnownCommands.append"\themelang"
		  arsKnownCommands.append"\themelangfe"
		  arsKnownCommands.append "\themelangcs"
		  arsKnownCommands.append "\trackmoves"
		  arsKnownCommands.append"\trackformatting"
		  arsKnownCommands.append "\ts"
		  arsKnownCommands.append "\tsrowd"
		  arsKnownCommands.append "\trfts"
		  arsKnownCommands.append "\trpaddl"//Default left cell margin or padding for the row.
		  arsKnownCommands.append "\trpaddr"//Default right cell margin or padding for the row.
		  arsKnownCommands.append "\trpaddfl"//Units for \ trpaddlN:
		  arsKnownCommands.append "\trpaddft"//Units for \ trpaddlN:
		  arsKnownCommands.append "\trpaddfb"//Units for \ trpaddlN:
		  arsKnownCommands.append "\trpaddfr"//Units for \ trpaddlN:
		  arsKnownCommands.append "\trcbpat"
		  arsKnownCommands.append "\trcfpat"
		  arsKnownCommands.append "\tblind"
		  arsKnownCommands.append "\tblindtype"
		  arsKnownCommands.append "\tscellwidthfts"
		  arsKnownCommands.append "\tsvertalt"
		  arsKnownCommands.append "\tsbrdrt"
		  arsKnownCommands.append "\tsbrdrl"
		  arsKnownCommands.append "\tsbrdrb"
		  arsKnownCommands.append "\tsbrdrr"
		  arsKnownCommands.append "\tsbrdrdgl"
		  arsKnownCommands.append "\tsbrdrdgr"
		  arsKnownCommands.append "\tsbrdrh"
		  arsKnownCommands.append "\tsbrdrv"
		  arsKnownCommands.append "\ts"
		  arsKnownCommands.append "\tsrowd"
		  
		  
		  arsKnownCommands.append "\up"
		  arsKnownCommands.Append "\upr" //This keyword represents a destination with two embedded destinations, one represented using Unicode and the other using ANSI. This keyword operates in conjunction with the \ud keyword to provide backward compatibility. The general syntax is as follows:
		  //{\upr{keyword ansi_text}{\*\ud{keyword Unicode_text}}}
		  //Notice that this keyword-destination does not use the \* keyword; this forces the old RTF readers to pick up the ANSI representation and discard the Unicode one.
		  arsKnownCommands.append "\ulc"
		  
		  arsKnownCommands.append"\validatexml"
		  arsKnownCommands.append "\vertdoc" //Vertical rendering
		  arsKnownCommands.append "\viewkind" ' An integer (0-5) that represents the view mode of the document.
		  arsKnownCommands.append "\viewscale" //Zoom level of the document; the N argument is a value representing a percentage (the default is 100).
		  arsKnownCommands.append "\version"
		  arsKnownCommands.append  "\vern"
		  
		  
		  arsKnownCommands.append "\widowctr" //Enable widow and orphan control.
		  arsKnownCommands.append "\widctlpar" //Widow/orphan control is used for the current paragraph. This is a paragraph property used to override the absence of the document-level \widowctrl
		  arsKnownCommands.append "\widowctrl"
		  arsKnownCommands.append "\wrapdefault"
		  arsKnownCommands.append "\widctlpar"//Widow/orphan control is used for the current paragraph. This is a paragraph property used to override the absence of the document-level \widowctrl
		  arsKnownCommands.append "\wrapdefault"
		  
		  arsKnownCommands.append "\yr"
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Skip(oLexer as RTFLexer, ctSkip as integer)
		  'Skip ctSkip characters
		  dim oToken as RTFLexer.Token
		  while ctSkip>0 and oLexer.NextToken(oToken)
		    select case oToken.type
		    case RTFLexer.TokenTypes.ControlSymbol, RTFLexer.TokenTypes.ControlWord
		      ctSkip = ctSkip - 1
		    case RTFLexer.TokenTypes.EOF
		      exit while
		    case RTFLexer.TokenTypes.Error
		      ctSkip = ctSkip - 1
		    case RTFLexer.TokenTypes.GroupBegin, RTFLexer.TokenTypes.GroupEnd
		      'don't enter groups while skipping
		      oLexer.Rewind(oToken)
		      exit while
		    case RTFLexer.TokenTypes.HexValue
		      ctSkip = ctSkip - 1
		    case RTFLexer.TokenTypes.Text
		      dim sData as string = oLexer.GetText(oToken.value)
		      if sData.Len<=ctSkip then
		        'skip the whole text segment
		        ctSkip = ctSkip - sData.Len
		      else
		        'skip just the beginning of the segment and emit the rest
		        if not bInCommentGroup then
		          EmitTextSegment(sData.Mid(ctSkip+1))
		          oStyleAttributes.reset
		        end if
		        ctSkip = 0
		      end if
		    end select
		  wend
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event AddPicture(p as Picture)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event CommandSegment(command as string, value as string)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event EndOfParsing(docAttributes as RTFDocumentAttributes)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event EscapedCharacter(ch as string)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event GroupEnd()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event GroupStart()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event HyphenationPoint()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event InfoGroupSegment(info as string)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event NewParagraph()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event NonbreakingHyphen()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event NonbreakingSpace()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event SkippedGroup(group as string)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event StartOfParsing()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event TextSegment(s as string)
	#tag EndHook


	#tag Property, Flags = &h0
		arColors() As Color
	#tag EndProperty

	#tag Property, Flags = &h21
		Private arsKnownCommands() As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private arsPictureData() As string
	#tag EndProperty

	#tag Property, Flags = &h21
		Private bApplyStyles As boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private bInCommentGroup As boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private dictCharacterStyles As dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private dictFonts As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private dictParagraphStyles As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private fldinstFlag As boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private fldinstText As string
	#tag EndProperty

	#tag Property, Flags = &h21
		Private hasTabLeading As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21
		Private iGroupLevel As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private iStartCommentGroupLevel As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private iUnicodeCodepage As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private oDocumentAttributes As RTFDocumentAttributes
	#tag EndProperty

	#tag Property, Flags = &h21
		Private oEncoding As TextEncoding
	#tag EndProperty

	#tag Property, Flags = &h21
		Private oLastToken As RTFLexer.Token
	#tag EndProperty

	#tag Property, Flags = &h21
		Private oParagraphAttributes As RTFParagraphAttributes
	#tag EndProperty

	#tag Property, Flags = &h21
		Private oStyleAttributes As RTFStyleAttributes
	#tag EndProperty


	#tag Constant, Name = EMF_PICTURE, Type = Double, Dynamic = False, Default = \"4", Scope = Public
	#tag EndConstant

	#tag Constant, Name = JPEG_PICTURE, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kLogUnknownCommands, Type = Boolean, Dynamic = False, Default = \"false", Scope = Private
	#tag EndConstant

	#tag Constant, Name = MAC_PICTURE, Type = Double, Dynamic = False, Default = \"3", Scope = Public
	#tag EndConstant

	#tag Constant, Name = NO_PICTURE, Type = Double, Dynamic = False, Default = \"0", Scope = Public
	#tag EndConstant

	#tag Constant, Name = OS2METAFILE_PICTURE, Type = Double, Dynamic = False, Default = \"5", Scope = Public
	#tag EndConstant

	#tag Constant, Name = PNG_PICTURE, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = SYMBOL_FONT_INDEX, Type = Double, Dynamic = False, Default = \"2147483647", Scope = Private
	#tag EndConstant

	#tag Constant, Name = UNSUPPORTED_PICTURE, Type = Double, Dynamic = False, Default = \"-1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = WINDOWSMETAFILE_PICTURE, Type = Double, Dynamic = False, Default = \"6", Scope = Public
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
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
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
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
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
