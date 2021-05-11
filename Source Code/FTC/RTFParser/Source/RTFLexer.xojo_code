#tag Class
Protected Class RTFLexer
	#tag Method, Flags = &h0
		Sub Constructor(input As String)
		  mBufferObject = input
		  mBuffer = mBufferObject
		  mSize = mBufferObject.Size
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetData(ref as StringRef) As String
		  Return mBufferObject.StringValue( ref.start, ref.length, Nil )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetText(ref as StringRef) As String
		  Return mBufferObject.StringValue( ref.start, ref.length, Encodings.ASCII )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NextToken(ByRef tk As Token) As Boolean
		  // reset the token
		  tk.type = TokenTypes.EOF
		  tk.name.length = 0
		  tk.name.start = 0
		  tk.value.length = 0
		  tk.value.start = 0
		  tk.token.length = 0
		  tk.token.start = 0
		  
		  If mOffset >= mSize Then _
		  Return False
		  
		  tk.token.start = mOffset
		  
		  // A carriage return (character value 13) or linefeed (character value 10) will
		  // be treated as a \par control if the character is preceded by a backslash.
		  // You must include the backslash; otherwise, RTF ignores the control word.
		  While mOffset < mSize And _
		    (mBuffer.Int8( mOffset ) = 13 Or mBuffer.Int8( mOffset ) = 10)
		    mOffset = mOffset + 1
		  Wend
		  
		  Select Case mBuffer.Int8( mOffset )
		  Case 92 // backslash
		    // Something must follow the backslash or we have some sort of error.
		    If mOffset + 1 >= mSize Then
		      tk.type = TokenTypes.Error
		      tk.value.start = mOffset
		      tk.value.length = 1
		      mOffset = mSize
		      Return False
		    End If
		    
		    Dim ch As Int8 = mBuffer.Int8( mOffset + 1 )
		    If ch = 39 Then // single quote
		      ProcessCharsetValue( tk )
		    Elseif Not (ch >= 97 And ch <= 122) Then // a-z
		      // A control symbol consists of a backslash followed by a single, nonalphabetic
		      // character. For example, \~ represents a nonbreaking space. Control symbols
		      // take no delimiters.
		      tk.type = TokenTypes.ControlSymbol
		      tk.name.start = mOffset
		      tk.name.length = 2
		      mOffset = mOffset + 2
		    Else
		      ProcessControlWord( tk )
		    End If
		    
		  Case 123 // left curly bracket
		    tk.type = TokenTypes.GroupBegin
		    mOffset = mOffset + 1
		    
		  Case 125 // right curly bracket
		    tk.type = TokenTypes.GroupEnd
		    mOffset = mOffset + 1
		    
		  Else
		    ProcessText( tk )
		  End Select
		  
		  tk.token.length = mOffset - tk.token.start
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ProcessBinaryData(ByRef tk As Token)
		  // \binN
		  // The picture is in binary format. The numeric parameter N is the number of
		  // bytes that follow. Unlike all other controls, this control word takes a 32-bit parameter.
		  
		  // The lexer is currently pointing at the binary data and the token is the \bin control
		  // word.
		  Dim length As Integer = Val( GetText( tk.value ) )
		  If mOffset + length <= mSize Then
		    tk.value.start = mOffset
		    tk.value.length = length
		    mOffset = mOffset + length
		  Else
		    // We're reading out of bounds, so flag up an error. The token's ranges are
		    // already pointing to the correct location and mOffset has passed the error.
		    tk.type = TokenTypes.Error
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ProcessCharsetValue(ByRef tk As Token)
		  // \'hh
		  // A hexadecimal value, based on the specified character set (may be used to
		  // identify 8-bit values).
		  
		  // The lexer is at the beginning of the control symbol.
		  tk.name.start = mOffset
		  tk.name.length = 2
		  mOffset = mOffset + 2
		  
		  // We need two more bytes for the hex value.
		  If mOffset + 2 > mSize Then
		    tk.type = TokenTypes.Error
		    tk.value.start = mOffset
		    tk.value.length = mSize - mOffset
		    mOffset = mSize
		    Exit Sub
		  End If
		  
		  // Also verify that we've got two hex bytes and not something invalid.
		  Dim ch as Integer = mBuffer.Int8( mOffset )
		  //Looking for values 0-9 and a-f or (new) A-F
		  If Not (ch >= 48 And ch <= 57) And Not (ch >= 97 And ch <= 102) And Not (ch >= 65 And ch <= 70) Then
		    tk.type = TokenTypes.Error
		    tk.value.start = mOffset
		    tk.value.length = 1
		    mOffset = mOffset + 1
		    Exit Sub
		  End If
		  
		  ch = mBuffer.Int8( mOffset + 1 )
		  //Looking for values 0-9 and a-f or (new) A-F
		  If Not (ch >= 48 And ch <= 57) And Not (ch >= 97 And ch <= 102) And Not (ch >= 65 And ch <= 70) Then
		    tk.type = TokenTypes.Error
		    tk.value.start = mOffset + 1
		    tk.value.length = 1
		    mOffset = mOffset + 2
		    Exit Sub
		  End If
		  
		  tk.type = TokenTypes.HexValue
		  tk.value.start = mOffset
		  tk.value.length = 2
		  mOffset = mOffset + 2
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ProcessControlWord(byref tk as Token)
		  // A control word is a specially formatted command that RTF uses to mark
		  // printer control codes and information that applications use to manage
		  // documents. A control word cannot be longer than 32 characters. A control
		  // word takes the following form:
		  //    \LetterSequence<Delimiter>
		  //
		  // Note that a backslash begins each control word.
		  //
		  // The LetterSequence is made up of lowercase alphabetic characters between
		  // "a" and "z" inclusive. RTF is case sensitive, and all RTF control words
		  // must be lowercase.
		  //
		  // The delimiter marks the end of an RTF control word, and can be one of the
		  // following:
		  // * A space. In this case, the space is part of the control word.
		  // * A digit or a hyphen (-), which indicates that a numeric parameter follows.
		  //   The subsequent digital sequence is then delimited by a space or any
		  //   character other than a letter or a digit. The parameter can be a positive
		  //   or a negative number. The range of the values for the number is generally
		  //   -32767 through 32767. However, Word tends to restrict the range to -31680
		  //   through 31680. Word allows values in the range -2,147,483,648 to
		  //   2,147,483,648 for a small number of keywords (specifically \bin,
		  //   \revdttm, and some picture properties). An RTF parser must handle an
		  //   arbitrary string of digits as a legal value for a keyword. If a numeric
		  //   parameter immediately follows the control word, this parameter becomes
		  //   part of the control word. The control word is then delimited by a space
		  //   or a nonalphabetic or nonnumeric character in the same manner as any other
		  //   control word.
		  // * Any character other than a letter or a digit. In this case, the delimiting
		  //   character terminates the control word but is not actually part of the
		  //   control word.
		  //
		  // If a space delimits the control word, the space does not appear in the
		  // document. Any characters following the delimiter, including spaces, will
		  // appear in the document. For this reason, you should use spaces only where
		  // necessary; do not use spaces merely to break up RTF code.
		  
		  #pragma DisableBackgroundTasks
		  
		  // The lexer is currently pointing at the start of the control word.
		  tk.type = TokenTypes.ControlWord
		  tk.name.start = mOffset
		  mOffset = mOffset + 1
		  
		  // Iterate input until we hit a non-lowercase character, EOF, or 32 bytes.
		  // NOTE: We're not using REALbasic.Min() here because it's ParamArray, which
		  // means we would be creating and destroying an array when calling it.
		  Dim maxOffset As Integer = mOffset + 32
		  If maxOffset > mSize Then maxOffset = mSize
		  
		  While mOffset < maxOffset And _
		    (mBuffer.Int8( mOffset ) >= 97 And mBuffer.Int8( mOffset ) <= 122) // a-z
		    mOffset = mOffset + 1
		  Wend
		  tk.name.length = mOffset - tk.name.start
		  
		  // The lexer is now pointing at the value, a space, any other character, or EOF.
		  If mOffset = mSize Then Exit Sub
		  tk.value.start = mOffset
		  
		  // Check for a hyphen and the iterate until we hit a non-numeric character
		  If mBuffer.Int8( mOffset ) = 45 Then _ // hyphen
		  mOffset = mOffset + 1
		  
		  While mOffset < mSize And _
		    (mBuffer.Int8( mOffset ) >= 48 And mBuffer.Int8( mOffset ) <= 57) // 0-9
		    mOffset = mOffset + 1
		  Wend
		  tk.value.length = mOffset - tk.value.start
		  
		  // Now check to see if we are delimited by a space. If so, eat it.
		  If mBuffer.Int8( mOffset ) = 32 Then _ // space
		  mOffset = mOffset + 1
		  
		  // Here's a special case: binary data has to be handled in the lexer because the
		  // data could contain valid RTF.
		  If tk.name.length = 4 And _
		    mBuffer.Int8( tk.name.start + 1 ) = 98 And _  // b
		    mBuffer.Int8( tk.name.start + 2 ) = 105 And _ // i
		    mBuffer.Int8( tk.name.start + 3 ) = 110 Then  // n
		    ProcessBinaryData( tk )
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ProcessText(byref tk as Token)
		  #pragma DisableBackgroundTasks
		  
		  // The lexer is currently pointing at the start of the text.
		  tk.type = TokenTypes.Text
		  tk.value.start = mOffset
		  
		  // Iterate input until we hit another type of token or the EOF.
		  dim ch as integer = mBuffer.Int8( mOffset )
		  While mOffset < mSize And _
		    ch <> 10 And _ // linefeed
		    ch <> 13 And _ // carriage return
		    ch <> 92 And _ // backslash
		    ch <> 123 And _ // left curly bracket
		    ch <> 125 // right curly bracket
		    mOffset = mOffset + 1
		    ch = mBuffer.Int8( mOffset )
		  Wend
		  tk.value.length = mOffset - tk.value.start
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Rewind(tk as Token)
		  'Reset the lexer to the start of the given token
		  dim iOffset as integer = tk.token.start
		  if iOffset<0 or iOffset>=mSize then
		    'invalid offset
		    raise new RuntimeException
		  end if
		  mOffset = iOffset
		End Sub
	#tag EndMethod


	#tag Note, Name = Tokens
		TokenTypes.ControlWord
		- Name: the name of the control word (including the backslash)
		- Value: integer value of the control word
		
		TokenTypes.ControlSymbol
		- Name: the control symbol (including the backslash)
		- Value: n/a
		
		TokenTypes.GroupBegin
		- Name: n/a
		- Value: n/a
		
		TokenTypes.GroupEnd
		- Name: n/a
		- Value: n/a
		
		TokenTypes.Text
		- Name: n/a
		- Value: the range of text
		
		TokenTypes.HexValue
		- Name: \'
		- Value: the two hex digits for the charset value
		
		TokenTypes.EOF
		- Name: n/a
		- Value: n/a
		
		TokenTypes.Error
		- Name: the name of the control word/symbol (if applicable)
		- Value: the range that the error occurred at
	#tag EndNote

	#tag Note, Name = Usage
		To use, create a new Lexer object with your given input and invoke NextToken
		until it returns True. Error conditions will be signaled by setting the token
		type to TokenTypes.Error and advancing the input stream past the error, making
		limited forms of recovery possible.
		
		For example:
		Dim lex As New RTFLexer(input)
		Dim tk As RTFLexer.Token
		
		While lex.NextToken( tk )
		  Select case tk.type
		  Case RTFLexer.TokenTypes.ControlSymbol
		    // ...
		  Case RTFLexer.TokenTypes.ControlWord
		    // ...
		  Case ...
		  End Select
		Wend
	#tag EndNote


	#tag Property, Flags = &h21
		Private mBuffer As Ptr
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mBufferObject As MemoryBlock
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mOffset As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mSize As Integer
	#tag EndProperty


	#tag Structure, Name = StringRef, Flags = &h0
		start as integer
		length as Integer
	#tag EndStructure

	#tag Structure, Name = Token, Flags = &h0
		type As TokenTypes
		  name as StringRef
		  value as StringRef
		token as StringRef
	#tag EndStructure


	#tag Enum, Name = TokenTypes, Type = Integer, Flags = &h0
		ControlWord
		  ControlSymbol
		  GroupBegin
		  GroupEnd
		  Text
		  HexValue
		  EOF
		Error
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
End Class
#tag EndClass
