#tag Class
Protected Class FTCMaskItem
	#tag Method, Flags = &h0
		Sub Constructor(characterSet as Dictionary, state as CaseState)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the lower/upper case state.
		  textCase = state
		  
		  ' Set the set of valid characters.
		  me.characterSet = characterSet
		  
		  ' Set the parser.
		  parser = AddressOf isValidCharacterSet
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(ch as string, state as CaseState)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the lower/upper case state.
		  textCase = state
		  
		  select case ch
		    
		  case "#"
		    
		    ' Digit (0-9).
		    
		    parser = AddressOf isValidDigit
		    
		  case "A"
		    
		    ' Alphabetic (a-z, A-Z).
		    
		    parser = AddressOf isValidAlphabetic
		    
		  case "B"
		    
		    ' Alphanumeric (a-z, A-Z, 0-9)
		    
		    parser = AddressOf isValidAlphaNumeric
		    
		  case "C"
		    
		    ' Any printable character.
		    
		    parser = AddressOf isValidCharacter
		    
		  case "."
		    
		    ' The decimal placeholder that is actually used is specified in the
		    ' user's International settings. The character is treated as a
		    ' literal (formatting) character for masking purposes.
		    
		    ' Save the literal character.
		    literal = FTUtilities.decimalPoint
		    
		    parser = AddressOf isValidLiteral
		    
		  case ","
		    
		    ' The thousands separator that is actually used is specified in the
		    ' user's International settings. The character is treated as a
		    ' literal (formatting) character for masking purposes.
		    
		    ' Save the literal character.
		    literal = FTUtilities.thousandsSeparator
		    
		    parser = AddressOf isValidLiteral
		    
		  case "/"
		    
		    ' The date separator that is actually used is specified in the
		    ' user's International settings. The character is treated as a
		    ' literal (formatting) character for masking purposes.
		    
		    ' Save the literal character.
		    literal = FTUtilities.dateSeparator
		    
		    parser = AddressOf isValidLiteral
		    
		  else
		    
		    ' Save the literal character.
		    literal = removeEscape(ch)
		    
		    parser = AddressOf isValidLiteral
		    
		  end select
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function IsLetterASCII(ch as string) As boolean
		  Dim index as integer
		  
		  ' Convert to an integer.
		  index = Asc(ch)
		  
		  ' Is the character a small letter?
		  if (index > 96) and (index < 123) then
		    
		    return true
		    
		  end if
		  
		  ' Is the character a capital letter?
		  if (index > 64) and (index < 91) then
		    
		    return true
		    
		  end if
		  
		  return false
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function IsLetterCocoa(ch as string) As boolean
		  'Use NSCharacterSet to decide what's a letter.
		  #if TargetMacOS
		    Declare Function objc_getClass Lib "Cocoa" (aClassName as CString) as Integer
		    Declare Function sel_registerName Lib "Cocoa" (theName as CString) as Integer
		    Declare Function objc_msgSend Lib "Cocoa" (theReceiver as Integer, theSelector as Integer) as Integer
		    
		    dim classRef as integer = objc_getClass("NSCharacterSet")
		    dim selectorRef as integer = sel_registerName("letterCharacterSet")
		    dim letterCharacterSetRef as integer = objc_msgSend(classRef, selectorRef)
		    
		    selectorRef = sel_registerName("longCharacterIsMember:")
		    declare function objc_msgSend1 lib "Cocoa" alias "objc_msgSend" (theReceiver as Integer, theSelector as Integer, ch as integer) as boolean
		    
		    dim chU32 as string = ConvertEncoding(ch, Encodings.UTF32LE)
		    dim mb as MemoryBlock = chU32
		    
		    return objc_msgSend1(letterCharacterSetRef, selectorRef, mb.Int32Value(0))
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isValid(ch as string) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Invoke the validation method.
		  return parser.Invoke(ch)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function isValidAlphabetic(ch as string) As boolean
		  if ch.Len=0 then
		    return false
		  elseif Encoding(ch)=nil then
		    'if the encoding is unknown then treat it as ASCII
		    return IsLetterASCII(ch)
		  else
		    #if TargetMacOS
		      return IsLetterCocoa(ch)
		    #else
		      return IsLetterASCII(ch)
		    #endif
		  end if
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function isValidAlphaNumeric(ch as string) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim index as integer
		  
		  ' Convert to an integer.
		  index = Asc(ch)
		  
		  ' Is the character a digit?
		  if (index > 47) and (index < 58) then
		    
		    return true
		    
		  end if
		  
		  return isValidAlphabetic(ch)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function isValidCharacter(ch as string) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim index as integer
		  
		  ' Convert to an integer.
		  index = Asc(ch)
		  
		  ' Is this a printable character.
		  return ((index >= 32) and (index <> 127))
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function isValidCharacterSet(ch as string) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Does the character exist in this set?
		  return characterSet.HasKey(ch)
		  
		End Function
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h0
		Delegate Function isValidDelagate(ch as string) As boolean
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h21
		Private Function isValidDigit(ch as string) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim index as integer
		  
		  ' Convert to an integer.
		  index = Asc(ch)
		  
		  ' Is this a digit?
		  return ((index > 47) and (index < 58))
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function isValidLiteral(ch as string) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Does this match the literal?
		  return (Asc(literal) = Asc(ch))
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function removeEscape(ch as string) As string
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Is this a single character?
		  if ch.len = 1 then
		    
		    ' Use the original.
		    return ch
		    
		  else
		    
		    ' Is this an escaped character?
		    if left(ch, 1) = "\" then
		      
		      ' Cut off the escape character.
		      return mid(ch, 2)
		      
		    else
		      
		      ' Use the original.
		      return ch
		      
		    end if
		    
		  end if
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private characterSet As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h0
		literal As string
	#tag EndProperty

	#tag Property, Flags = &h21
		Private parser As isValidDelagate
	#tag EndProperty

	#tag Property, Flags = &h0
		textCase As CaseState
	#tag EndProperty


	#tag Enum, Name = CaseState, Type = Integer, Flags = &h0
		None
		  Lower
		Upper
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
			Name="literal"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
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
			Name="textCase"
			Group="Behavior"
			Type="CaseState"
			EditorType="Enum"
			#tag EnumValues
				"0 - None"
				"1 - Lower"
				"2 - Upper"
			#tag EndEnumValues
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
