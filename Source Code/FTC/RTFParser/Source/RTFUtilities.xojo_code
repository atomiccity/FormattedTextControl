#tag Module
Protected Module RTFUtilities
	#tag Method, Flags = &h1
		Protected Function binaryToHex(binaryData as string) As string
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim sa() as string
		  Dim mb as MemoryBlock
		  Dim length as integer
		  
		  ' Initialize the lookup table.
		  initialize
		  
		  ' Get the number of bytes to process.
		  length = binaryData.lenb
		  
		  ' Preallocate the space.
		  Redim sa(length * 2)
		  
		  ' Create the memory block.
		  mb = new MemoryBlock(length)
		  
		  ' Dump in the binary data.
		  mb.StringValue(0, length) = binaryData
		  
		  ' Make it zero based.
		  count = length - 1
		  
		  ' Convert the bytes.
		  for i = 0 to count
		    
		    ' Add the hexadecimal character.
		    sa(i) = hexConvert(mb.byte(i))
		    
		  next
		  
		  ' Return the hexadecimal data.
		  return join(sa, "")
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function characterSetToEncoding(set as integer) As TextEncoding
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim te as TextEncoding
		  
		  ' Do we need to initlize the lookup dictionary?
		  if cs is nil then
		    
		    ' Create the lookup character set dictionary.
		    cs = new Dictionary
		    
		    ' Fill in the encodings.
		    #if TargetMacOS
		      
		      cs.Value(0) = GetInternetTextEncoding("windows-1252")
		      
		    #else
		      
		      cs.Value(0) = Encodings.WindowsLatin1
		      
		    #endif
		    
		    cs.Value(1) = Encodings.SystemDefault
		    
		    #if TargetMacOS
		      
		      cs.Value(2) = Encodings.MacSymbol
		      
		    #else
		      
		      cs.Value(2) = Encodings.WindowsLatin1
		      
		    #endif
		    
		    cs.Value(77) = Encodings.MacRoman
		    cs.Value(78) = GetInternetTextEncoding("Shift_JIS")
		    cs.Value(79) = Encodings.MacKorean ' Unknown
		    cs.Value(80) = Encodings.MacChineseSimp
		    cs.Value(81) = GetInternetTextEncoding("Big5") ' Unknown
		    cs.Value(82) = GetInternetTextEncoding("Johab") ' Unknown
		    cs.Value(83) = GetInternetTextEncoding("X-MAC-HEBREW")
		    cs.Value(84) = GetInternetTextEncoding("X-MAC-ARABIC")
		    cs.Value(85) = GetInternetTextEncoding("X-MAC-GREEK")
		    cs.Value(86) = GetInternetTextEncoding("X-MAC-TURKISH")
		    cs.Value(87) = Encodings.MacThai
		    cs.Value(88) = Encodings.MacRomanLatin1
		    cs.Value(89) = Encodings.MacCyrillic
		    cs.Value(128) = GetInternetTextEncoding("Shift_JIS")
		    cs.Value(129) = Encodings.MacKorean ' Unknown
		    cs.Value(130) = GetInternetTextEncoding("Johab")
		    cs.Value(134) = GetInternetTextEncoding("GB2312")
		    cs.Value(136) = GetInternetTextEncoding("Big5")
		    cs.Value(161) = GetInternetTextEncoding("windows-1253")
		    cs.Value(162) = GetInternetTextEncoding("windows-1254")
		    cs.Value(163) = GetInternetTextEncoding("windows-1258")
		    cs.Value(177) = GetInternetTextEncoding("windows-1255")
		    cs.Value(178) = GetInternetTextEncoding("windows-1256")
		    cs.Value(179) = GetInternetTextEncoding("windows-1256") ' Unknown
		    cs.Value(180) = GetInternetTextEncoding("windows-1256") ' Unknown
		    cs.Value(181) = GetInternetTextEncoding("windows-1255") ' Unknown
		    cs.Value(186) = GetInternetTextEncoding("windows-1257")
		    cs.Value(204) = GetInternetTextEncoding("windows-1251")
		    cs.Value(222) = Encodings.MacThai ' Unknown
		    cs.Value(238) = GetInternetTextEncoding("windows-1250")
		    cs.Value(254) = GetInternetTextEncoding("cp437")
		    cs.Value(255) = GetInternetTextEncoding("cp850")
		    
		  end if
		  
		  ' Do we have an encoding for this character set?
		  if cs.HasKey(set) then
		    
		    ' Get the encoding.
		    te = cs.Value(set)
		    
		  else
		    
		    ' Use UTF8 as a default.
		    te = Encodings.UTF8
		    
		  end if
		  
		  ' Return the target encoding.
		  return te
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function colorToString(c as Color) As string
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the color as an RGB string.
		  return Str(c.red) + " " + Str(c.green) + " " + Str(c.blue)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function convertEncoding(ch as integer, characterSet as integer) As string
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim te as TextEncoding
		  
		  ' Look up the character set.
		  te = characterSetToEncoding(characterSet)
		  
		  ' Do we have a converter?
		  if te is nil then
		    
		    ' Use a space.
		    return " "
		    
		  else
		    
		    ' Convert to UTF.
		    return ConvertEncoding(te.Chr(ch), Encodings.UTF8)
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function convertEscapedCharacters(s as string, characterSet as integer) As string
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim index as integer
		  Dim lastIndex as integer
		  Dim sa() as string
		  Dim ch as integer
		  
		  const MARKER = "\'"
		  
		  ' Start at the beginning.
		  lastIndex = 1
		  
		  ' Find the first marker.
		  index = InStr(s, MARKER)
		  
		  ' Were there any markers?
		  if index > 0 then
		    
		    ' Convert all the escaped characters.
		    while index > 0
		      
		      ' Add the previous text.
		      sa.Append(midB(s, lastIndex, index - lastIndex))
		      
		      ' Convert the
		      ch = Val("&h" + midB(s, index + 2, 2))
		      sa.Append(RTFUtilities.convertEncoding(ch, characterSet))
		      
		      ' Skip past the current marker.
		      lastIndex = index + 4
		      
		      ' Find the next marker.
		      index = InStr(lastIndex, s, MARKER)
		      
		    wend
		    
		    ' Add in the leftover.
		    sa.Append(midB(s, lastIndex))
		    
		    ' Put the string back together.
		    return join(sa, "")
		    
		  else
		    
		    ' Return the original string.
		    return s
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function convertPNG(p as picture) As string
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim sa() as string
		  Dim data as string
		  
		  ' Header.
		  sa.Append("\pict \pngblip \picw" + str(p.Width) + " \pich" + str(p.Height) + " ")
		  
		  ' Convert the picture.
		  data = RTFUtilities.pictureToPNGString(p)
		  
		  ' Convert the picture data.
		  data = RTFUtilities.binaryToHex(data)
		  
		  ' Add the picture data.
		  sa.Append(data)
		  
		  ' Return the encoded picture.
		  return join(sa, "")
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function hexToBinary(s as string) As string
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim index as integer
		  Dim count as integer
		  Dim mb as MemoryBlock
		  
		  ' Get the length of the string.
		  count = s.lenB
		  
		  ' Allocate the memory block.
		  mb = new MemoryBlock(count / 2)
		  
		  ' Convert the string to binary data.
		  for i = 1 to count step 2
		    
		    ' Convert the byte.
		    mb.byte(index) = Val("&h" + midB(s, i, 2))
		    
		    ' Move to the next byte.
		    index = index + 1
		    
		  next
		  
		  ' Return the binary data.
		  return mb.StringValue(0, count / 2)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function inchesToTWIPS(inches as double) As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the number of TWIPS.
		  return (inches * 1440.0)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub initialize()
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim value as string
		  
		  ' Have we been initialized?
		  if not hexInitFlag then
		    
		    ' Create lookup values.
		    for i = 0 to 255
		      
		      ' Get the string value.
		      value = hex(i)
		      
		      ' Is there only one character?
		      if value.lenb = 1 then
		        
		        ' Prepend a zero.
		        value = "0" + value
		        
		      end if
		      
		      ' Add the value.
		      hexConvert(i) = value
		      
		    next
		    
		    ' We have finished initializing.
		    hexInitFlag = true
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function JPEGStringToPicture(s as string) As picture
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the picture.
		  return stringToPicture(s)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function pictureToJPEGString(p as picture) As string
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim mb as MemoryBlock
		  
		  ' Was there anything to convert?
		  if p is nil then return ""
		  
		  ' Get the picture data.
		  mb = p.GetData(Picture.FormatJPEG, Picture.QualityMax)
		  
		  ' Return nothing.
		  return mb.StringValue(0, mb.Size)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function pictureToPNGString(p as picture) As string
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim mb as MemoryBlock
		  
		  ' Was there anything to convert?
		  if p is nil then return ""
		  
		  ' Get the picture data.
		  mb = p.GetData(Picture.FormatPNG)
		  
		  ' Return nothing.
		  return mb.StringValue(0, mb.Size)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function PNGStringToPicture(s as string) As picture
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the picture.
		  return RTFUtilities.stringToPicture(s)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function stringToPicture(s as string) As picture
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim mb as MemoryBlock
		  Dim length as integer
		  
		  ' Get the length of the picture data.
		  length = s.lenb
		  
		  ' Copy the data into a memory block.
		  mb = new MemoryBlock(length)
		  mb.StringValue(0, length) = s
		  
		  ' Return nothing.
		  return Picture.FromData(s)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function TWIPSToInches(twips as integer) As double
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking RTF_BOUNDSCHECKING
		    #pragma NilObjectChecking RTF_NILOBJECTCHECKING
		    #pragma StackOverflowChecking RTF_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the number of inches.
		  return (twips / 1440.0)
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private cs As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private hexConvert(255) As string
	#tag EndProperty

	#tag Property, Flags = &h21
		Private hexInitFlag As boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private symbolLookup() As integer
	#tag EndProperty


	#tag Enum, Name = RTFAlignment, Flags = &h0
		ALIGN_LEFT
		  ALIGN_CENTER
		  ALIGN_RIGHT
		  ALIGN_FULL
		ALIGN_NONE
	#tag EndEnum


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
End Module
#tag EndModule
