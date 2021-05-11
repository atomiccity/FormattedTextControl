#tag Module
Protected Module BKSSC
	#tag Method, Flags = &h0
		Sub addIgnoreWord(s as String)
		  ' PLEASE READ!!!!!:
		  ' If you are getting an "This item doesn't exist" error
		  ' it means you are missing the BKSSpellChecker plugin.  This is located in the download package.
		  
		  oSpellCheck.IgnoreWord s
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub addUserWord(s as String)
		  oSpellCheck.LearnWord s
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CheckSpellingBlock(sText as String) As BKSSpellCheckerRange()
		  ' PLEASE READ!!!!!:
		  ' If you are getting an "This item doesn't exist" error
		  ' it means you are missing the BKSSpellChecker plugin.  This is located in the download package.
		  
		  Dim aroRange() As BKSSpellCheckerRange
		  
		  
		  dim iStart as Integer = 1
		  dim iTextLen as integer = sText.Len
		  
		  while iStart < iTextLen
		    dim oRange as BKSSpellCheckerRange = oSpellCheck.CheckSpelling(sText,iStart)
		    if oRange = nil then exit while
		    aroRange.Append oRange
		    iStart = oRange.Start + oRange.Length
		  wend
		  
		  return aroRange
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub InitSpellChecker()
		  dim fBase as folderitem
		  #if TargetMacOS then
		    fBase = app.ExecutableFile.Parent.Parent.Child("Resources").Child("en_US")
		  #Else
		    #If XojoVersion >= 2016.01 Then
		      Dim s As String = App.ExecutableFile.name.replaceAll(".exe", "") + " Resources"
		      s = s.replaceall(".exe", "")
		      fBase = GetFolderItem(s).child("en_US")
		    #else
		      fBase = GetFolderItem("Resources").child("en_US")
		    #EndIf
		  #endif
		  
		  if fBase = nil or fbase.Exists = false then
		    break
		    Return
		  end if
		  
		  
		  
		  dim f as FolderItem = app.GetApplicationSupportFolder.Child("en_US")
		  if f.Exists = false or f.Directory = false then
		    f.CreateAsFolder
		  end if
		  
		  if f.Child("en_US.dic").Exists = false and fBase.Child("en_US.dic").Exists = true then
		    fBase.Child("en_US.dic").CopyFileTo f.Child("en_US.dic")
		  end if
		  
		  if f.Child("en_US.aff").Exists = false and fBase.Child("en_US.aff").Exists then
		    fBase.Child("en_US.aff").CopyFileTo f.Child("en_US.aff")
		  end if
		  
		  fUserDictionary = fUserDictionary
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SaveUserDictionary()
		  #Pragma BreakOnExceptions
		  
		  if bSystemSpellCheck then Return
		  if moSpellCheck = nil then Return
		  
		  try
		    oSpellCheck.SaveUserDictionary fUserDictionary
		  catch ex as RuntimeException
		    //Do Nothing
		    break
		  end try
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SuggestionsForWord(word as String) As String()
		  Return oSpellCheck.SuggestionsForWord(word)
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private bSystemSpellCheck As Boolean
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  if mfUserDictionary = nil  or mfUserDictionary.Exists = false then
			    dim f as FolderItem = app.GetApplicationSupportFolder.Child("user.dic")
			    if f <> nil and  f.Exists = false then
			      Dim t AS TextOutputStream
			      t = TextOutputStream.Create(f)
			      t.close
			    end if
			    mfUserDictionary = f
			  end if
			  
			  return mfUserDictionary
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mfUserDictionary = value
			End Set
		#tag EndSetter
		fUserDictionary As FolderItem
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mfUserDictionary As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h21
		#tag Note
			' PLEASE READ!!!!!:
			' If you are getting an "This item doesn't exist" error
			' it means you are missing the BKSSpellChecker plugin.  This is located in the download package.
		#tag EndNote
		Private moSpellCheck As BKSSpellChecker
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' PLEASE READ!!!!!:
			  ' If you are getting an "This item doesn't exist" error
			  ' it means you are missing the BKSSpellChecker plugin.  This is located in the download package.
			  #Pragma BreakOnExceptions False
			  if moSpellCheck = nil then
			    InitSpellChecker
			    //Try System
			    Try
			      moSpellCheck  = BKSSpellChecker.CreateSystemChecker
			      bSystemSpellCheck = true
			    catch ex as PlatformNotSupportedException
			      //Do Nothing
			    End Try
			    
			    if moSpellCheck = nil then//system spell check not available
			      //Try Hunspell
			      dim fDict as FolderItem = app.GetApplicationSupportFolder.Child("en_US").Child("en_US.dic")
			      dim fAff as FolderItem = app.GetApplicationSupportFolder.Child("en_US").Child("en_US.aff")
			      Try
			        moSpellCheck  = BKSSpellChecker.CreateHunspellChecker(fDict,fAff)
			        moSpellCheck.LoadUserDictionary fUserDictionary
			      catch ex as RuntimeException
			        MsgBox "Could not create Spell Checker"
			        break
			      End Try
			    end if
			    
			    
			    
			  end if
			  
			  return moSpellCheck
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  ' PLEASE READ!!!!!:
			  ' If you are getting an "This item doesn't exist" error
			  ' it means you are missing the BKSSpellChecker plugin.  This is located in the download package.
			  
			  moSpellCheck = value
			End Set
		#tag EndSetter
		oSpellCheck As BKSSpellChecker
	#tag EndComputedProperty


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
