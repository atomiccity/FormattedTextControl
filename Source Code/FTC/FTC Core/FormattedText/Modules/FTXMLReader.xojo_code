#tag Class
Protected Class FTXMLReader
Inherits XMLReader
	#tag Event
		Sub EndElement(name as String)
		  select case Name
		  case "FTParagraph", "Paragraph"
		    bParagraph = false
		    m_oParagraph = nil
		  end select
		End Sub
	#tag EndEvent

	#tag Event
		Sub StartElement(name as String, attributeList as XmlAttributeList)
		  select case Name
		    
		  case FTCxml.XML_VERSION
		    
		    xmlHandleVersion(attributeList)
		    
		  case FTCxml.XML_FTDOCUMENT
		    
		    xmlHandleDocument(attributeList)
		    
		  case FTCxml.XML_PARAGRAPH_STYLES
		    m_odoc.clearParagraphStyles
		    
		  case FTCxml.XML_PARAGRAPH_STYLE
		    
		    xmlHandleParagraphStyle(attributeList)
		    
		  case FTCxml.XML_CHARACTER_STYLES
		    m_odoc.clearCharacterStyles
		    
		  case FTCxml.XML_CHARACTER_STYLE
		    
		    xmlHandleCharacterStyle(attributeList)
		    
		  case FTCxml.XML_PARAGRAPHS
		    
		  case "FTParagraph", "Paragraph"
		    bParagraph = true
		    xmlHandleAddParagraphs(attributeList)
		  case else
		    
		    if bParagraph = true then
		      HandleParseParagraph Name, attributeList
		    else
		      m_oDoc.callXMLItemFromAttributeList(attributeList)
		    end if
		    
		    
		  end select
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h1000
		Sub Constructor(oDoc as FTDocument)
		  // Calling the overridden superclass constructor.
		  // Note that this may need modifications if there are multiple constructor choices.
		  // Possible constructor calls:
		  // Constructor() -- From XmlReader
		  // Constructor(xmlEncoding As String) -- From XmlReader
		  // Constructor(xmlEncoding As String, namespaceSeparator As String) -- From XmlReader
		  Super.Constructor("utf-8")
		  m_oDoc = oDoc
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub HandleParseParagraph(Name as String,attributeList as XmlAttributeList)
		  
		  Dim fto as FTObject
		  
		  ' Create the object.
		  select case name
		    
		  case FTCxml.XML_FTSTYLERUN
		    
		    ' Create a style run.
		    fto = new FTStyleRun(m_oDoc.parentControl, attributeList)
		    
		  case FTCxml.XML_FTTAB
		    
		    ' Create the tab.
		    fto = new FTTab(m_oDoc.parentControl, attributeList)
		    
		  case FTCxml.XML_FTPICTURE
		    
		    ' Create the picture.
		    fto = new FTPicture(m_oDoc.parentControl, attributeList)
		    
		  case else
		    
		    ' Call the custom object creation.
		    fto = m_oDoc.parentControl.callXmlObjectCreate(attributeList)
		    
		  end select
		  
		  ' Was this object recognized
		  if not (fto is nil) then
		    
		    ' Add the run to the paragraph.
		    m_oParagraph.addObject(fto)
		    
		  else
		    
		    ' This is an unrecognized object.
		    m_oDoc.parentControl.callUnrecognizedXmlObject(attributeList)
		    
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub xmlHandleAddParagraphs(attributeList as XmlAttributeList)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  m_oParagraph = m_oDoc.addNewParagraph
		  
		  ' Load the paragraph attributes.
		  m_oParagraph.addXMLAttributesParagraphAttributes(attributeList)
		  
		  ' Decode the developer tag.
		  m_oDoc.parentControl.callXmlDecodeTag(attributeList.value(FTCxml.XML_TAG), m_oDoc)
		  
		  m_oParagraph.addXMLTabstops Trim(attributeList.value(FTCxml.XML_TAB_STOP))
		  
		  'Dim paragraph as XmlElement
		  'Dim p as FTParagraph
		  '
		  '' Get the first paragraph.
		  'paragraph = XmlElement(item.FirstChild)
		  '
		  '' Add all the paragraphs.
		  'while not (paragraph is nil)
		  '
		  '' Create the paragraph.
		  'p = addNewParagraph
		  '
		  '' Populate the paragraph.
		  'p.addXmlNode(paragraph)
		  '
		  '' Get the next paragraph.
		  'paragraph = XmlElement(paragraph.NextSibling)
		  '
		  'wend
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub xmlHandleCharacterStyle(attributeList as XmlAttributeList)
		  
		  #pragma DisableBackgroundTasks
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  
		  Dim oStyle as new FTCharacterStyle(m_oDoc.parentControl,attributeList)
		  
		  
		  ' Install the style.
		  m_oDoc.addcharacterStyle   oStyle
		  
		  ' Set the tag.
		  m_oDoc.parentControl.callXmlDecodeTag(attributeList.value(FTCxml.XML_TAG), oStyle)
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub xmlHandleDocument(attributeList as XmlAttributeList)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  dim dLeft as Double = Val(attributeList.value(FTCxml.XML_LEFT_MARGIN))
		  dim dRight as Double = Val(attributeList.value(FTCxml.XML_RIGHT_MARGIN))
		  dim dTop as Double = Val(attributeList.value(FTCxml.XML_TOP_MARGIN))
		  dim dBottom as double = Val(attributeList.value(FTCxml.XML_BOTTOM_MARGIN))
		  
		  ' Load up the attributes.
		  m_oDoc.setMargins dLeft, dRight, dTop, dBottom
		  m_oDoc.setPageBackgroundColor  FTUtilities.stringToColor(attributeList.value(FTCxml.XML_PAGE_BACKGROUND_COLOR))
		  m_oDoc.setPageHeight Val(attributeList.value(FTCxml.XML_PAGE_HEIGHT))
		  m_oDoc.setPageWidth Val(attributeList.value(FTCxml.XML_PAGE_WIDTH))
		  m_oDoc.parentControl.callXmlDecodeTag(attributeList.value(FTCxml.XML_TAG), m_oDoc)
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub xmlHandleParagraphStyle(attributeList as XmlAttributeList)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  dim oStyle as new FTParagraphStyle(m_oDoc.parentControl,attributeList)
		  
		  
		  
		  if iParagraphStyleCount = 0 then
		    m_oDoc.setDefaultParagraphStyle oStyle
		  else
		    m_oDoc.addParagraphStyle oStyle
		    m_oDoc.parentControl.callXmlDecodeTag(attributeList.value(FTCxml.XML_TAG), oStyle)
		  end if
		  
		  iParagraphStyleCount = iParagraphStyleCount + 1
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub xmlHandleVersion(attributeList as XmlAttributeList)
		  
		  #if not DebugBuild
		    
		    #pragma BoundsChecking FTC_BOUNDSCHECKING
		    #pragma NilObjectChecking FTC_NILOBJECTCHECKING
		    #pragma StackOverflowChecking FTC_STACKOVERFLOWCHECKING
		    
		  #endif
		  
		  ' Load up the attributes.
		  m_oDoc.setXMLCreator(attributeList.value(FTCxml.XML_CREATOR))
		  m_oDoc.setXMLFileType(attributeList.value(FTCxml.XML_FILE_TYPE))
		  m_oDoc.setXMLFileVersion(attributeList.value(FTCxml.XML_FILE_VERSION))
		  m_oDoc.setXMLDocumentTag(attributeList.value(FTCxml.XML_DOCUMENT_TAG))
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected bParagraph As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		iParagraphStyleCount As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected m_oDoc As FTDocument
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected m_oParagraph As FTParagraph
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="iParagraphStyleCount"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
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
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
