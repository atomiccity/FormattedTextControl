#tag Module
Protected Module GUString
	#tag Method, Flags = &h0
		Function addFileExtension(fileName as string, extension as string) As string
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  Dim ext as string
		  Dim strLen as Integer
		  Dim newFileName as string
		  
		  ' Do we have a dot in front of the extension?
		  if Left(extension, 1) = "." then
		    
		    ' Build up the extension.
		    ext = lowercase (extension)
		    
		  else
		    
		    ' Build up the extension.
		    ext = "." + lowercase (extension)
		    
		  end if
		  
		  ' Get the length of the extension.
		  strLen = Len(ext)
		  
		  ' Does the file already end in the extension?
		  if lowercase (right (fileName, strLen)) <> ext then
		    
		    ' Add the extension.
		    newFileName = fileName + ext
		    
		  else
		    
		    ' Do nothing to the file name.
		    newFileName = fileName
		    
		  end if
		  
		  ' Send back the modified file name.
		  return newFileName
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function addFileExtensionB(fileName as string, extension as string) As string
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  Dim ext as string
		  Dim strLen as Integer
		  Dim newFileName as string
		  
		  ' Do we have a dot in front of the extension?
		  if LeftB(extension, 1) = "." then
		    
		    ' Build up the extension.
		    ext = lowercase (extension)
		    
		  else
		    
		    ' Build up the extension.
		    ext = "." + lowercase (extension)
		    
		  end if
		  
		  ' Get the length of the extension.
		  strLen = LenB(ext)
		  
		  ' Does the file already end in the extension?
		  if lowercase (rightB (fileName, strLen)) <> ext then
		    
		    ' Add the extension.
		    newFileName = fileName + ext
		    
		  else
		    
		    ' Do nothing to the file name.
		    newFileName = fileName
		    
		  end if
		  
		  ' Send back the modified file name.
		  return newFileName
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function findNonSpace(s as string, startIndex as integer) As integer
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  Dim i as integer
		  Dim length as integer
		  
		  ' Get the length of the string.
		  length = s.len
		  
		  ' Search for a non-space.
		  for i = startIndex to length
		    
		    ' Is this a non-space character?
		    if not isSpace(mid(s, i, 1)) then
		      
		      ' Return the index of the non-space character.
		      return i
		      
		    end if
		    
		  next
		  
		  ' Nothing was found.
		  return 0
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function findNonSpaceB(s as string, startIndex as integer) As integer
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  Dim i as integer
		  Dim length as integer
		  
		  ' Get the length of the string.
		  length = s.lenB
		  
		  ' Search for a non-space.
		  for i = startIndex to length
		    
		    ' Is this a non-space character?
		    if not isSpaceB(midB(s, i, 1)) then
		      
		      ' Return the index of the non-space character.
		      return i
		      
		    end if
		    
		  next
		  
		  ' Nothing was found.
		  return 0
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getEncodingFromStr(s as string) As TextEncoding
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  Dim base as integer
		  Dim variant as integer
		  Dim format as integer
		  
		  ' Extract the encoding data.
		  base = Val(NthField(s, " ", 1))
		  variant = Val(NthField(s, " ", 2))
		  format = Val(NthField(s, " ", 3))
		  
		  ' Return the encoding.
		  return GetTextEncoding(base, variant, format)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getNextWord(s as string, ByRef startIndex as integer) As string
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  Dim stringLength as integer
		  Dim i as integer
		  Dim j as integer
		  Dim ch as string
		  Dim token as string
		  
		  ' Get the length of the string.
		  stringLength = Len(s)
		  
		  ' Look for the start of a token.
		  for i = startIndex to stringLength
		    
		    ' Get a character.
		    ch = Mid(s, i, 1)
		    
		    ' Is this a token character?
		    if not isSpace(ch) then
		      
		      ' Append the character we found.
		      token = ch
		      
		      ' look for the end of the token.
		      for j = (i + 1) to stringLength
		        
		        ' Get a character.
		        ch = Mid(s, j, 1)
		        
		        ' Is this the end of the token?
		        if isSpace(ch) then
		          
		          ' Move the start indicator for the next iteration.
		          startIndex = j
		          
		          return token
		          
		        end if
		        
		        ' Append the character we found.
		        token = token + ch
		        
		      next
		      
		      ' We reached the end of the string.
		      startIndex = stringlength + 1
		      
		      return token
		      
		    end if
		    
		  next
		  
		  ' We reached the end of the string.
		  startIndex = stringlength + 1
		  
		  return ""
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getNextWordB(s as string, ByRef startIndex as integer) As string
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  Dim stringLength as integer
		  Dim i as integer
		  Dim j as integer
		  Dim ch as string
		  Dim token as string
		  
		  ' Get the length of the string.
		  stringLength = LenB(s)
		  
		  ' Look for the start of a token.
		  for i = startIndex to stringLength
		    
		    ' Get a character.
		    ch = MidB(s, i, 1)
		    
		    ' Is this a token character?
		    if not isSpaceB(ch) then
		      
		      ' Append the character we found.
		      token = ch
		      
		      ' look for the end of the token.
		      for j = (i + 1) to stringLength
		        
		        ' Get a character.
		        ch = MidB(s, j, 1)
		        
		        ' Is this the end of the token?
		        if isSpaceB(ch) then
		          
		          ' Move the start indicator for the next iteration.
		          startIndex = j
		          
		          return token
		          
		        end if
		        
		        ' Append the character we found.
		        token = token + ch
		        
		      next
		      
		      ' We reached the end of the string.
		      startIndex = stringlength + 1
		      
		      return token
		      
		    end if
		    
		  next
		  
		  ' We reached the end of the string.
		  startIndex = stringlength + 1
		  
		  return ""
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getPrefix(s as string) As string
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  Dim sl as integer
		  Dim i as integer
		  
		  ' Get the length of the string.
		  sl = Len(s)
		  
		  ' Walk backwards through the string.
		  for i = sl downto 1
		    
		    ' Is this the suffix separator?
		    if Mid(s, i, 1) = "." then
		      
		      ' Return the prefix.
		      return Left(s, i - 1)
		      
		    end if
		    
		  next
		  
		  ' No suffix was found.
		  return s
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getPrefixB(s as string) As string
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  Dim sl as integer
		  Dim i as integer
		  
		  ' Get the length of the string.
		  sl = LenB(s)
		  
		  ' Walk backwards through the string.
		  for i = sl downto 1
		    
		    ' Is this the suffix separator?
		    if MidB(s, i, 1) = "." then
		      
		      ' Return the prefix.
		      return LeftB(s, i - 1)
		      
		    end if
		    
		  next
		  
		  ' No suffix was found.
		  return s
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getSuffix(s as string) As string
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  Dim sl as integer
		  Dim i as integer
		  
		  ' Get the length of the string.
		  sl = Len(s)
		  
		  ' Walk backwards through the string.
		  for i = sl downto 1
		    
		    ' Is this the suffix separator?
		    if Mid(s, i, 1) = "." then
		      
		      ' Return the suffix.
		      return Right(s, sl - i)
		      
		    end if
		    
		  next
		  
		  ' No suffix was found.
		  return ""
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getSuffixB(s as string) As string
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  Dim sl as integer
		  Dim i as integer
		  
		  ' Get the length of the string.
		  sl = LenB(s)
		  
		  ' Walk backwards through the string.
		  for i = sl downto 1
		    
		    ' Is this the suffix separator?
		    if MidB(s, i, 1) = "." then
		      
		      ' Return the suffix.
		      return RightB(s, sl - i)
		      
		    end if
		    
		  next
		  
		  ' No suffix was found.
		  return ""
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getWord(s as string, index as integer = - 1) As string
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  Dim ch as string
		  Dim fullWord as string
		  
		  ' Get a character.
		  ch = mid(s, index, 1)
		  
		  ' Get the rest of the word.
		  while (ch <> "") and (not isSpace(ch))
		    
		    ' Add the character to the word.
		    fullWord = fullWord + ch
		    
		    ' Move to the next character.
		    index = index + 1
		    
		    ' Get a character.
		    ch = mid(s, index, 1)
		    
		  wend
		  
		  ' Return the word found.
		  return fullWord
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getWordB(s as string, index as integer = - 1) As string
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  Dim ch as string
		  Dim fullWord as string
		  
		  ' Get a character.
		  ch = midB(s, index, 1)
		  
		  ' Get the rest of the word.
		  while (ch <> "") and (not isSpaceB(ch))
		    
		    ' Add the character to the word.
		    fullWord = fullWord + ch
		    
		    ' Move to the next character.
		    index = index + 1
		    
		    ' Get a character.
		    ch = midB(s, index, 1)
		    
		  wend
		  
		  ' Return the word found.
		  return fullWord
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isAlnum(c as string) As boolean
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  Dim ch as integer
		  
		  ' Extract the first character.
		  ch = Asc(c)
		  
		  ' Is the character a small letter?
		  if (ch > 96) and (ch < 123) then
		    
		    return true
		    
		  end if
		  
		  ' Is the character a capital letter?
		  if (ch > 64) and (ch < 91) then
		    
		    return true
		    
		  end if
		  
		  ' Is the character a digit?
		  if (ch > 47) and (ch < 58) then
		    
		    return true
		    
		  end if
		  
		  return false
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isAlnumB(c as string) As boolean
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  Dim ch as integer
		  
		  ' Extract the first character.
		  ch = AscB(c)
		  
		  ' Is the character a small letter?
		  if (ch > 96) and (ch < 123) then
		    
		    return true
		    
		  end if
		  
		  ' Is the character a capital letter?
		  if (ch > 64) and (ch < 91) then
		    
		    return true
		    
		  end if
		  
		  ' Is the character a digit?
		  if (ch > 47) and (ch < 58) then
		    
		    return true
		    
		  end if
		  
		  return false
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isAlpha(c as string) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  Dim ch as integer
		  
		  ' Extract the first character.
		  ch = Asc(c)
		  
		  ' Is the character a small letter?
		  if (ch > 96) and (ch < 123) then
		    
		    return true
		    
		  end if
		  
		  ' Is the character a capital letter?
		  if (ch > 64) and (ch < 91) then
		    
		    return true
		    
		  end if
		  
		  return false
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isAlphaB(c as string) As boolean
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  Dim ch as integer
		  
		  ' Extract the first character.
		  ch = AscB(c)
		  
		  ' Is the character a small letter?
		  if (ch > 96) and (ch < 123) then
		    
		    return true
		    
		  end if
		  
		  ' Is the character a capital letter?
		  if (ch > 64) and (ch < 91) then
		    
		    return true
		    
		  end if
		  
		  return false
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isCaps(word as string) As boolean
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim ch as string
		  
		  ' Get the length of the word.
		  count = Len(word)
		  
		  ' Walk through the word checking for upper case.
		  for i = 1 to count
		    
		    ' Get the character.
		    ch = Mid(word, i, 1)
		    
		    ' Is this a letter?
		    if isAlpha(ch) then
		      
		      ' Is the character upper case?
		      if isLower(ch) then
		        
		        ' This is not an all upper case word.
		        return false
		        
		      end if
		      
		    end if
		    
		  next
		  
		  ' The word is all upper case.
		  return true
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isCapsB(word as string) As boolean
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim ch as string
		  
		  ' Get the length of the word.
		  count = LenB(word)
		  
		  ' Walk through the word checking for upper case.
		  for i = 1 to count
		    
		    ' Get the character.
		    ch = MidB(word, i, 1)
		    
		    ' Is this a letter?
		    if isAlphaB(ch) then
		      
		      ' Is the character upper case?
		      if isLowerB(ch) then
		        
		        ' This is not an all upper case word.
		        return false
		        
		      end if
		      
		    end if
		    
		  next
		  
		  ' The word is all upper case.
		  return true
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isDigit(c as string) As boolean
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  Dim ch as integer
		  
		  ' Extract the first character.
		  ch = Asc(c)
		  
		  ' Is the digit within range?
		  return ((ch > 47) and (ch < 58))
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isDigitB(c as string) As boolean
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  Dim ch as integer
		  
		  ' Extract the first character.
		  ch = AscB(c)
		  
		  ' Is the digit within range?
		  return ((ch > 47) and (ch < 58))
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isLower(c as string) As boolean
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  Dim ch as integer
		  
		  ' Extract the first character.
		  ch = Asc(c)
		  
		  ' Is the character a small letter?
		  return ((ch > 96) and (ch < 123))
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isLowerB(c as string) As boolean
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  Dim ch as integer
		  
		  ' Extract the first character.
		  ch = AscB(c)
		  
		  ' Is the character a small letter?
		  return ((ch > 96) and (ch < 123))
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isPunct(c as string) As boolean
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  Dim ch as integer
		  
		  ' Extract the first character.
		  ch = Asc(c)
		  
		  ' Check the first range of punctuation characters (! to /).
		  if (ch > 32) and (ch < 48) then
		    
		    return true
		    
		  end if
		  
		  ' Check the second range of punctuation characters (: to @).
		  if (ch > 57) and (ch < 65) then
		    
		    return true
		    
		  end if
		  
		  ' Check the third range of punctuation characters ([ to `).
		  if (ch > 90) and (ch < 97) then
		    
		    return true
		    
		  end if
		  
		  ' Check the fourth range of punctuation characters({ to ~).
		  if (ch > 122) and (ch < 127) then
		    
		    return true
		    
		  end if
		  
		  return false
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isSpace(c as string) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  Dim ch as integer
		  
		  ' Extract the first character.
		  ch = Asc(c)
		  
		  ' Is the character one of those space characters?
		  return ((ch = 32) or ((ch > 8) and (ch < 14)))
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isSpaceB(c as string) As boolean
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  Dim ch as integer
		  
		  ' Extract the first character.
		  ch = AscB(c)
		  
		  ' Is the character one of those space characters?
		  return ((ch = 32) or ((ch > 8) and (ch < 14)))
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isUpper(c as string) As boolean
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  Dim ch as integer
		  
		  ' Extract the first character.
		  ch = Asc(c)
		  
		  ' Is the character a capital letter?
		  return ((ch > 64) and (ch < 91))
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isUpperB(c as string) As boolean
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  Dim ch as integer
		  
		  ' Extract the first character.
		  ch = AscB(c)
		  
		  ' Is the character a capital letter?
		  return ((ch > 64) and (ch < 91))
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isValidWordChar(ch as string) As boolean
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  ' Is this a valid character for a word (a-z or ')?
		  if isAlpha(ch) or (ch = "'") then
		    
		    return true
		    
		  end if
		  
		  ' This is not a valid character for a word.
		  return false
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isValidWordCharB(ch as string) As boolean
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  ' Is this a valid character for a word (a-z or ')?
		  if isAlphaB(ch) or (ch = "'") then
		    
		    return true
		    
		  end if
		  
		  ' This is not a valid character for a word.
		  return false
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isVariableName(s as string) As boolean
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  Dim i as integer
		  Dim strLength as integer
		  Dim ch as integer
		  
		  ' Extract a character.
		  ch = Asc(s)
		  
		  ' Does the string begin with a letter?
		  if not (((ch > 96) and (ch < 123)) or ((ch > 64) and (ch < 91))) then
		    
		    return false
		    
		  end if
		  
		  ' Get the length of the string.
		  strLength = Len(s)
		  
		  ' Walk through the string.
		  for i = 2 to strLength
		    
		    ' Extract a character.
		    ch = Asc(mid(s, i, 1))
		    
		    ' Is this a letter?
		    if not (((ch > 96) and (ch < 123)) or ((ch > 64) and (ch < 91))) then
		      
		      ' Is this a digit or underscore?
		      if not (((ch > 47) and (ch < 58)) or (ch = 95)) then
		        
		        return false
		        
		      end if
		      
		    end if
		    
		  next
		  
		  ' We have a valid variable name.
		  return true
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isVariableNameB(s as string) As boolean
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  Dim i as integer
		  Dim strLength as integer
		  Dim ch as integer
		  
		  ' Extract a character.
		  ch = AscB(s)
		  
		  ' Does the string begin with a letter?
		  if not (((ch > 96) and (ch < 123)) or ((ch > 64) and (ch < 91))) then
		    
		    return false
		    
		  end if
		  
		  ' Get the length of the string.
		  strLength = LenB(s)
		  
		  ' Walk through the string.
		  for i = 2 to strLength
		    
		    ' Extract a character.
		    ch = AscB(midB(s, i, 1))
		    
		    ' Is this a letter?
		    if not (((ch > 96) and (ch < 123)) or ((ch > 64) and (ch < 91))) then
		      
		      ' Is this a digit or underscore?
		      if not (((ch > 47) and (ch < 58)) or (ch = 95)) then
		        
		        return false
		        
		      end if
		      
		    end if
		    
		  next
		  
		  ' We have a valid variable name.
		  return true
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isxDigit(c as string) As boolean
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  Dim ch as integer
		  
		  ' Extract the first character.
		  ch = Asc(c)
		  
		  ' Is the digit within digit range?
		  if (ch > 47) and (ch < 58) then
		    
		    return true
		    
		  end if
		  
		  ' Is the character in the set A-F letter?
		  if (ch > 64) and (ch < 71) then
		    
		    return true
		    
		  end if
		  
		  ' Is the character in the set a-f letter?
		  if (ch > 96) and (ch < 103) then
		    
		    return true
		    
		  end if
		  
		  return false
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isxDigitB(c as string) As boolean
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  Dim ch as integer
		  
		  ' Extract the first character.
		  ch = AscB(c)
		  
		  ' Is the digit within digit range?
		  if (ch > 47) and (ch < 58) then
		    
		    return true
		    
		  end if
		  
		  ' Is the character in the set A-F letter?
		  if (ch > 64) and (ch < 71) then
		    
		    return true
		    
		  end if
		  
		  ' Is the character in the set a-f letter?
		  if (ch > 96) and (ch < 103) then
		    
		    return true
		    
		  end if
		  
		  return false
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function replaceSegment(s as string, startIndex as integer, length as integer, replacement as string) As string
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  ' Return the string with the specified segment replaced.
		  return left(s, startIndex - 1) + replacement + mid(s, startIndex + length)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function replaceSegmentB(s as string, startIndex as integer, length as integer, replacement as string) As string
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  ' Return the string with the specified segment replaced.
		  return leftB(s, startIndex - 1) + replacement + midB(s, startIndex + length)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Str(te as TextEncoding) As string
		  
		  #if not DebugBuild
		    
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  ' Return the encoding.
		  return Str(te.base) + " " + Str(te.variant) + " " + Str(te.format)
		  
		End Function
	#tag EndMethod


	#tag Note, Name = Copyright Notice
		
		Copyright 2002-2015 BKeeney Software Inc. - All Rights Reserved.
		
		This software is freeware and may be used freely without
		royalties or fees.
	#tag EndNote

	#tag Note, Name = Usage
		
		Best viewed in font "Courier New" with font size of 12.
		
		This module contains general utility functions and subroutines.
		
		The functions whose names end with "B" in this module use the
		faster *B methods internally. This results in significantly
		faster operations. The restriction with these *B functions
		is that you can only use it on single byte characters.
		
		
		addFileExtension
		----------------
		
		  Description:
		
		    Adds a specified extension to a file name. The extension
		    parameter should be passed without a dot extension. For
		    example...
		
		      newFileName = addFileExtension(fileName, "txt")
		
		    The function will look to see if an extension exists at
		    the end of the file name. If the extension is not found,
		    then one will be appended dot in front of it.
		
		  Parameters:
		
		    fileName as string:
		      Original file name.
		
		    extension as string:
		      Extension to be added such as "txt".
		
		  Return:
		
		    string:
		      Filename with extension appended.
		
		
		getNextWord
		-----------
		
		  Description:
		
		    This function returns the next word from a string. The
		    delimiting characters for words are white space.
		
		  Parameters:
		
		    s as string:
		      The string from which to extract the next word from.
		
		    ByRef startIndex as integer:
		      The start index from which to start looking for words.
		      Upon return from this function, startIndex will be
		      moved to after the new word. If no word is found,
		      startIndex will equal the length of the string plus one
		      and the returned word will be "".
		
		  Return:
		
		    string:
		      The next word from the string. If no word is found, ""
		      will be returned.
		
		
		getPrefix
		---------
		
		  Description:
		
		    This function returns the prefix portion of a string.
		    The prefix portion is the part of the string before
		    the last "." in the string. If no "." exists in the
		    string, then the entire string will be returned.
		
		  Parameters:
		
		    s as string:
		      The string with a suffix. 
		
		  Return:
		
		    string:
		      The prefix portion of the string. Returns the entire
		      string if no "." character is present in the string.
		
		
		getSuffix
		---------
		
		  Description:
		
		    This function returns the suffix portion of a string.
		    The suffix portion is the part of the string after
		    the last "." in the string. If no "." exists in the
		    string, then an empty string will be returned.
		
		  Parameters:
		
		    s as string:
		      The string with a suffix. 
		
		  Return:
		
		    string:
		      The suffix portion of the string. Returns an empty
		      string if no "." character is present in the string.
		
		
		getWord
		-------
		
		  Description:
		    This function returns a word that is broken up by white
		    space.
		    
		  Parameters:
		
		    s as string:
		      The target string.
		      
		    index as integer = -1:
		      The starting index.
		
		  Return:
		
		    string:
		      The word.
		
		
		isAlnum
		-------
		
		  Description:
		
		    Determines if the first character in the string is an
		    alphanumeric (a-zA-Z0-9). This method assumes you are
		    working with the ASCII character set.
		
		  Parameters:
		
		    c as string:
		      The target string. Only the first character is
		      examined.
		
		  Return:
		
		      boolean:
		        True if the first character is in the set (a-zA-Z0-9).
		
		
		isAlpha
		-------
		
		  Description:
		
		    Determines if the first character in the string is a
		    letter (a-zA-Z). This method assumes you are working
		    with the ASCII character set.
		
		  Parameters:
		
		    c as string:
		      The target string. Only the first character is
		      examined.
		
		  Return:
		
		    boolean:
		      True if the first character is in the set (a-zA-Z).
		
		
		isCaps
		------
		
		  Description:
		  
		    Determines if all the letters in the word are upper case
		    letters.
		
		  Parameters:
		
		    word as string:
		      The target word to check.
		
		  Return:
		
		    boolean:
		      True if all letters in the word are upper case.
		
		
		isDigit
		-------
		
		  Description:
		
		    Determines if the first character in the string is a
		    digit (0-9). This method assumes you are working with
		    the ASCII character set.
		
		  Parameters:
		
		    c as string:
		      The target string. Only the first character is
		      examined.
		
		  Return:
		
		    boolean:
		      True if the first character is in the set (0-9).
		
		
		isLower
		-------
		
		  Description:
		
		    Determines if the first character in the string is a
		    lower case letter (a-z). This method assumes you are
		    working with the ASCII character set.
		
		  Parameters:
		
		    c as string:
		      The target string. Only the first character is
		      examined.
		
		  Return:
		
		    boolean:
		      True if the first character is in the set (a-z).
		
		
		isPunct
		-------
		
		  Description:
		
		    Determines if the first character in the string is a
		    punctuation character (!"#$%&'()*+,-./:;<=>?@[\]^_`{|}~).
		    This method assumes you are working with the ASCII
		    character set.
		
		  Parameters:
		
		    c as string:
		      The target string. Only the first character is
		      examined.
		
		  Return:
		
		    boolean:
		      True if the first character is in the set
		      (!"#$%&'()*+ ,-./:;<=>?@[\]^_`{|}~).
		
		
		isSpace
		-------
		
		  Description:
		
		    Determines if the first character in the string is a
		    space (" " ht nl vt np cr). This method assumes you are
		    working with the ASCII character set.
		
		  Parameters:
		
		    c as string:
		      The target string. Only the first character is
		      examined.
		
		  Return:
		
		    boolean:
		      True if the first character is in the set (" " ht nl
		      vt np cr).
		
		
		isUpper
		-------
		
		  Description:
		
		    Determines if the first character in the string is an
		    upper case letter (A-Z). This method assumes you are
		    working with the ASCII character set.
		
		  Parameters:
		
		    c as string:
		      The target string. Only the first character is
		      examined.
		
		  Return:
		
		    boolean:
		      True if the first character is in the set (A-Z).
		
		
		isValidWordChar
		---------------
		
		  Description:
		  
		    Determines if the character is letter or ' character.
		    Example: The characters in "won't" are all valid
		    characters.
		
		  Parameters:
		
		    ch as string:
		      The target string. Only the first character is
		      examined.
		
		  Return:
		
		    boolean:
		      True if the character is letter or a ' (a-zA-Z').
		
		
		isVariableName
		--------------
		
		  Description:
		
		    Determines if the the string follows the pattern for a
		    variable name (a-zA-Z)(a-zA-Z0-9_)*. The variable name
		    can only contain letters, digits, and underscore
		    characters and must begin with a letter. This method
		    assumes you are working with the ASCII character set.
		
		  Parameters:
		
		    s as string:
		      The target string. Spaces are not ignored, so you
		      either trim the string or make sure you don't pick any
		      leading or trailing spaces from your source text.
		
		  Return:
		
		    boolean:
		      True if the first character is a variable name with
		      the pattern of (a-zA-Z)(a-zA-Z0-9_)*.
		
		
		isxDigit
		--------
		
		  Description:
		
		    Determines if the first character in the string is a
		    hexadecimal digit (0-9a-fA-F). This method assumes you
		    are working with the ASCII character set.
		
		  Parameters:
		
		    c as string:
		      The target string. Only the first character is
		      examined.
		
		  Return:
		
		    boolean:
		      True if the first character is in the set (0-9a-fA-F).
		
		
		Str
		---
		
		  Description:
		
		    This subroutine converts a color to a string.
		
		  Parameters:
		
		    c as Color:
		      The color to be converted to a string.
		
		  Return:
		
		    string:
		      "true" or "false"
		      
		      
		Str
		---
		
		  Description:
		
		    This subroutine converts a boolean to a string.
		
		  Parameters:
		
		    value as boolean:
		      The value to be converted to a string.
		
		  Return:
		
		    string:
		      Formatted as "R G B" where R, G, and B range from 0 to
		      255.
	#tag EndNote


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
