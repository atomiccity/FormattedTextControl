#tag Class
Protected Class FTCMask
	#tag Method, Flags = &h0
		Sub appendLiterals(ByRef key as string, position as integer)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim mi as FTCMaskItem
		  Dim preText as string
		  
		  ' Build up the literal pretext.
		  for i = position to maxlength
		    
		    ' Get a mask item.
		    mi = maskItems(i)
		    
		    ' Is this a lieteral?
		    if mi.literal <> "" then
		      
		      ' Add in the literal.
		      preText = preText + mi.literal
		      
		    else
		      
		      ' We are done looking for literals.
		      exit
		      
		    end if
		    
		  next
		  
		  ' Add in the literal text.
		  key = preText + key
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function checkTextCase(text as string, ByRef output as string) As boolean
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim sa() as string
		  Dim ch as string
		  Dim result as boolean
		  
		  ' Get the number of items in the mask.
		  count = Ubound(maskItems)
		  
		  ' Scan the text.
		  for i = 0 to count
		    
		    ' Get a character.
		    ch = mid(text, i + 1, 1)
		    
		    ' What case should we make it?
		    select case maskItems(i).textCase
		      
		    case FTCMaskItem.CaseState.None
		      
		      ' Do nothing.
		      sa.Append(ch)
		      
		    case FTCMaskItem.CaseState.Upper
		      
		      ' Do we need to change to upper case?
		      if StrComp(ch, Uppercase(ch), 1) <> 0 then
		        
		        ' Make it upper case.
		        sa.Append(Uppercase(ch))
		        
		        ' We changed case.
		        result = true
		        
		      else
		        
		        ' Use the character as is.
		        sa.Append(ch)
		        
		      end if
		      
		    case FTCMaskItem.CaseState.Lower
		      
		      ' Do we need to change to lower case?
		      if StrComp(ch, Lowercase(ch), 1) <> 0 then
		        
		        ' Make it lower case.
		        sa.Append(Lowercase(ch))
		        
		        ' We changed case.
		        result = true
		        
		      else
		        
		        ' Use the character as is.
		        sa.Append(ch)
		        
		      end if
		      
		    end select
		    
		  next
		  
		  ' Is there anything to do?
		  if result then
		    
		    ' Reassemble the string.
		    output = join(sa, "")
		    
		  end if
		  
		  return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(mask as string)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Save the mask.
		  me.mask = mask
		  
		  ' Parse the mask into an executable parser.
		  parseMask(mask, true)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getLength() As integer
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Return the number of mask items.
		  return Ubound(maskItems)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function getNextCharacter(mask as string, ByRef index as integer) As string
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim ch as string
		  
		  ' Get a character.
		  ch = mid(mask, index, 1)
		  
		  ' Is this an escape character?
		  if ch = "\" then
		    
		    ' Move past the \.
		    index = index + 1
		    
		    ' Complete the escape sequence.
		    ch = ch + mid(mask, index, 1)
		    
		  end if
		  
		  ' Return the complete character.
		  return ch
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isValidMask(mask as string) As boolean
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Run it through the parser.
		  parseMask(mask, false)
		  
		  ' All is well.
		  return true
		  
		exception
		  
		  ' A problem was found.
		  return false
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub parseMask(mask as string, install as boolean)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim ch as string
		  Dim state as FTCMaskItem.CaseState
		  Dim characterSet as Dictionary
		  
		  ' Assume no change to the case.
		  state = FTCMaskItem.CaseState.None
		  
		  ' Get the number of characters.
		  count = mask.len
		  
		  ' Start with the first character.
		  i = 1
		  
		  ' Scan all the characters.
		  while i <= count
		    
		    ' Get a character from the mask.
		    ch = getNextCharacter(mask, i)
		    
		    ' Are we filling a character set?
		    if not (characterSet is nil) then
		      
		      ' Is this the end of the character set?
		      if ch = "]" then
		        
		        ' Create the character set item.
		        if install then maskItems.Append(new FTCMaskItem(characterSet, state))
		        
		        ' Signal we are done with this character set.
		        characterSet = nil
		        
		      else
		        
		        ' Save the character in the look up dictionary.
		        characterSet.value(removeEscape(ch)) = ""
		        
		      end if
		      
		    else
		      
		      select case ch
		        
		      case ">"
		        
		        ' Upper case.
		        state = FTCMaskItem.CaseState.Upper
		        
		      case "<"
		        
		        ' Lower case.
		        state = FTCMaskItem.CaseState.Lower
		        
		      case "["
		        
		        ' Start a new character set.
		        characterSet = new Dictionary
		        
		      else
		        
		        ' Is this an escape character?
		        if ch = "\" then
		          
		          ' Is there another character to examine?
		          if i < count then
		            
		            ' Move past the \.
		            i = i + 1
		            
		            ' Complete the escape sequence.
		            ch = ch + mid(mask, i, 1)
		            
		          else
		            
		            ' Bad mask.
		            raise new RuntimeException
		            
		          end if
		          
		        end if
		        
		        ' Create the item.
		        if install then maskItems.Append(new FTCMaskItem(ch, state))
		        
		      end select
		      
		    end if
		    
		    ' Move to the next character.
		    i = i + 1
		    
		  wend
		  
		  ' Get the maximum length of the string
		  maxLength = Ubound(maskItems)
		  
		  ' Do we have a dangling character set?
		  if not (characterSet is nil) then
		    
		    ' Bad mask.
		    raise new RuntimeException
		    
		  end if
		  
		End Sub
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

	#tag Method, Flags = &h0
		Function verify(text as string, ByRef position as integer) As boolean
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  Dim i as integer
		  Dim count as integer
		  Dim index as integer
		  Dim length as integer
		  
		  ' Start with the first character.
		  index = 1
		  
		  ' Get the number of items to verify against.
		  count = Ubound(maskItems)
		  
		  ' Get the length of the text.
		  length = text.len
		  
		  ' Scan the string.
		  for i = 0 to count
		    
		    ' Is this the end of the input text?
		    if index > length then exit
		    
		    ' Does this character fail the mask.
		    if not maskItems(i).isValid(mid(text, index, 1)) then
		      
		      ' Mark the error position.
		      position = i
		      
		      ' Error found.
		      return false
		      
		    end if
		    
		    ' Move to the next character.
		    index = index + 1
		    
		  next
		  
		  ' No error.
		  position = 0
		  
		  ' All is well.
		  return true
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		mask As string
	#tag EndProperty

	#tag Property, Flags = &h21
		Private maskItems() As FTCMaskItem
	#tag EndProperty

	#tag Property, Flags = &h0
		maxLength As integer
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
			Name="mask"
			Group="Behavior"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="maxLength"
			Group="Behavior"
			Type="integer"
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
