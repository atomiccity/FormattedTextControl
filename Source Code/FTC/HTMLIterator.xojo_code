#tag Class
Protected Class HTMLIterator
Inherits FTIteratorBase
	#tag Event
		Sub ParagraphEnd(p as FTParagraph)
		  
		  #pragma unused p
		  
		  ' End of paragraph.
		  lines.append("</p>")
		End Sub
	#tag EndEvent

	#tag Event
		Sub ParagraphStart(p as FTParagraph, pIndex As Integer)
		  #pragma unused pIndex
		  
		  dim lineHeight As double = p.getLineSpacing
		  
		  ' Build the paragraph start tag.
		  select case p.getAlignment
		    
		  Case FTParagraph.Alignment_Type.Center
		    
		    lines.append("<p align=""center"">")
		    
		  case FTParagraph.Alignment_Type.Right
		    
		    lines.append("<p align=""right"">")
		    
		  else
		    
		    lines.append("<p style='line-height:"+Str(lineHeight*100)+"%'>")
		    
		  end select
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub PostParse()
		  
		  ' Close the html tag.
		  lines.append("</html>")
		  
		  dim sCSS as string = GetHTMLStyles
		  
		  lines.Insert iCSSInsertIndex, sCSS
		End Sub
	#tag EndEvent

	#tag Event
		Sub PreParse()
		  
		  ' Set up the header.
		  lines.append("<!DOCTYPE HTML PUBLIC ""-//W3C//DTD HTML 4.01 Transitional//EN"">")
		  lines.append("<html>")
		  
		  
		  lines.append "<head>"
		  lines.append "<meta http-equiv=" + chr(34) + "Content-Type" + chr(34) + " content=" + chr(34) + "text/html; charset=utf-8" + chr(34) + ">"
		  lines.append "<style type=" + chr(34) + "text/css" + chr(34) + ">"
		  
		  'lines.append "a[href]:link {"
		  'lines.append "color: #0000FF;"
		  'lines.append "text-weight: normal;"
		  'lines.append "text-decoration: underline;"
		  'lines.append "}"
		  'lines.append "body {"
		  'lines.append "font-family: '" + me.ftc.DefaultFont + "';" //'Helvetica','Lucida Grande','Arial','Sans-Serif';"
		  'lines.append "font-size: " + cstr(me.ftc.DefaultFontSize) + "px;" //12px;"
		  'lines.append "color: #000000;"
		  'lines.append "background-color: #FFFFFF;"
		  'lines.append "}"
		  
		  
		  
		  iCSSInsertIndex = lines.Ubound+1
		  
		  lines.append "</style>"
		  lines.append "</head>"
		End Sub
	#tag EndEvent

	#tag Event
		Sub StyleRun(fto as FTObject)
		  
		  Dim startTagLine as string
		  Dim endTagLine as string
		  Dim text as string
		  Dim sr as FTStyleRun
		  
		  if dictStyles = nil then
		    dictStyles = new Dictionary
		  end
		  
		  
		  ' Is this a style run?
		  if fto isa FTStyleRun then
		    dim sCSSStyleName as string
		    
		    ' Cast it to a style run.
		    sr = FTStyleRun(fto)
		    
		    'Get our base style
		    if dictStyles.haskey("body") = false then
		      dictStyles.Value("body") = StyleDefToText(sr, true)
		    else
		      sCSSStyleName = StyleDefToStylesDict(sr, false)
		    end
		    
		    ' Get the text.
		    text = ReplaceSpacesWithTabs(sr.getText)
		    
		    if sCSSStyleName <> "" and sCSSStyleName <> "body" then
		      startTagLine = "<span class=" + chr(34) + sCSSStyleName + chr(34) + ">"
		      endTagLine = "</span>"
		    end
		    
		    'Hyperlink
		    if sr.HyperLink <> "" then
		      
		      lines.append "<a href=" + chr(34) + sr.HyperLink + chr(34) + ">" + text + "</a>"
		    else
		      
		      ' Add the the HTML text.
		      if text="" then //added by MaximilianTyrtania
		        lines.append("<br>")
		      else
		        lines.append(startTagLine + text + endTagLine)
		      end
		    end
		    
		  elseif fto isa FTCustom then
		    dim p as picture = FTCustom(fto).getPicture
		    if p <> nil then
		      arImages.Append p
		      
		      dim sNumber as string = format(arImages.Ubound + 1, "00000")
		      lines.append "<img src=" + chr(34) + "images/" + sNumber + ".png" + chr(34) + " height=" + chr(34) + cstr(p.height) + chr(34) + " width=" + chr(34) + cstr(p.Width) + chr(34) + ">"
		      
		    else
		      Text = FTCustom(fto).getText
		    end
		    
		  elseif fto isa FTPicture then
		    dim p as Picture = FTPicture(fto).getPicture
		    if p <> nil then
		      
		      //<img src="../Documents/BKeeney%20Logo%20Horizontal.png" height="100" width="500">
		      arImages.Append p
		      
		      dim sNumber as string = format(arImages.Ubound + 1, "00000")
		      lines.append "<img src=" + chr(34) + "images/" + sNumber + ".png" + chr(34) + " height=" + chr(34) + cstr(p.height) + chr(34) + " width=" + chr(34) + cstr(p.Width) + chr(34) + ">"
		    end
		    
		  elseif fto isa FTTab then
		    
		    lines.append kHTMLTab
		    
		  end if
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function AppendStyleToDict(s As String, inName As String = "") As String
		  if dictStyles is nil Then dictStyles = new Dictionary
		  
		  dim sStyleName As String
		  
		  if len(s) > 5 Then
		    // isn't "{}"
		    sStyleName = HasStyle(s)
		    
		    if sStyleName = "" Then
		      
		      if inName = "" Then
		        dim i As Integer = iLastStyleNum + 1
		        
		        iLastStyleNum = i
		        
		        sStyleName = "Style" + str(iLastStyleNum)
		      Else
		        
		        sStyleName = inName
		        
		      End If
		      
		      dictStyles.Value(sStyleName) = s
		      
		    End If
		    
		  end if
		  
		  Return sStyleName
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ColorToHexString(c As Color) As String
		  dim s as string = "#" + Right("0" + Hex(c.red), 2) + Right("0" + Hex(c.green), 2) + Right("0" + Hex(c.blue), 2)
		  
		  return s
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ColorToRGBA(c As Color, alpha As Integer) As String
		  
		  Dim s As String
		  s= "rgba("
		  s=s + format(c.Red,"#")+","
		  s=s + format(c.green,"#")+","
		  s=s + format(c.blue,"#")+","
		  s=s + format(alpha/100,"#.0")
		  s=s+ ")"
		  
		  Return s
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1000
		Sub Constructor(fOutput as FolderItem)
		  mF = fOutput
		  
		  mfImages = mf.child("Images")
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getHTML() As string
		  
		  #if not DebugBuild
		    
		    #pragma DisableBoundsChecking
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		    
		  #endif
		  
		  ' Assemble the output.
		  return join(lines, "")
		  'return join(lines, endofline.UNIX)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetHTMLStyles() As String
		  dim s As String
		  
		  if dictStyles = nil then
		    return s
		  end
		  
		  for i As Integer = 0 to dictStyles.Count - 1
		    dim key As String = dictStyles.Key(i)
		    dim sd As String = dictStyles.Value(key)
		    
		    if key <> "body" Then
		      s = s + "."
		    end if
		    
		    s = s + key + " {" + sd + "}" + EndOfLine
		  next
		  
		  Return s
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function HasStyle(s As String) As String
		  if dictStyles is nil Then Return ""
		  
		  for i as integer = 0 to dictStyles.Count - 1
		    dim key as string = dictStyles.Key(i)
		    if s = dictStyles.Value(key) Then Return key
		  next
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ReplaceSpacesWithTabs(s as String) As String
		  Return s.ReplaceAll(kDefinedSpacsToTab, kHTMLTab)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function StyleDefToStylesDict(sr as FTStyleRun, bBody as Boolean) As String
		  
		  if dictStyles is nil Then dictStyles = new Dictionary
		  
		  dim sName As String
		  dim s As String = StyleDefToText( sr, bBody )
		  
		  if len(s) > 5 Then
		    // isn't "{}"
		    
		    sName = ReplaceAll(sName, " ", "_")
		    sName = AppendStyleToDict(s)
		    dictStyles.Value(sName) = s
		    
		    Return sName
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function StyleDefToText(sr as FTStyleRun, bBody as Boolean) As String
		  dim s As String
		  
		  dim font As String = sr.font
		  if (font <> "" and font <> me.FTC.DefaultFont) or bBody Then
		    s = s + "  font-family: '" + font + "';" + EndOfLine
		  end if
		  
		  dim size As Integer = sr.fontSize
		  if (size <> 0 and size <> me.ftc.DefaultFontSize) or bBody Then
		    s = s + "  font-size: " + str(size) + "px; " + EndOfLine
		  end if
		  
		  if sr.Bold Then
		    s = s + "  font-weight: bold; " + EndOfLine
		  end if
		  
		  if sr.Italic Then
		    s = s + "  font-style: italic; " + EndOfLine
		  end if
		  
		  if sr.Underline Then
		    s = s + "  text-decoration: underline; " + EndOfLine
		  end if
		  
		  if sr.strikeThrough then
		    s = s + " text-decoration:line-through; " + EndOfLine
		  end
		  
		  dim sTextColor as string = ColorToHexString(sr.textColor)
		  if sTextColor <> ColorToHexString(me.ftc.DefaultTextColor) then
		    s = s + "  color: "  + sTextColor + ";" + EndOfLine
		  end
		  
		  dim sBackgroundColor as string = ColorToHexString(sr.getBackgroundColor)
		  if sBackgroundColor <> ColorToHexString(&cFFFFFF) then
		    s = s + "  background-color: " + sBackgroundColor + "; " + EndOfLine
		  end
		  
		  if sr.colorOpacity>0 then
		    s = s + " opacity: " +  Format((1-sr.colorOpacity/100),"#.#")+ "; " + EndOfLine
		    s= s + " filter:alpha(opacity="+Format((100-sr.colorOpacity),"#")+")" + EndOfLine
		  end
		  
		  if sr.hasShadow then
		    
		    Dim mAngle,offsetX,offsety as double
		    mAngle = sr.shadowAngle * Rads2DegMultiplier
		    offsetX= sr.shadowOffset*cos(mAngle) //be careful of type conversions
		    offsetY= sr.shadowOffset*sin(mAngle) * -1
		    
		    s = s + " text-shadow: "+format(offsetX/2,"-#.0000")+"px "+format(offsety/2,"-#.0000")+"px "+format( sr.shadowBlur/2,"#.0")+"px "_
		    + ColorToRGBA( sr.shadowColor,sr.shadowOpacity)+";"+EndOfLine
		  end
		  
		  Return s
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Write()
		  //Create our index file
		  dim f as folderitem = mf.child("index.html")
		  
		  dim tos as TextOutputStream = TextOutputStream.Create(f)
		  
		  if tos = nil or tos.LastErrorCode <> 0 then
		    break
		  end
		  
		  tos.Write GetHTML
		  
		  tos.close
		  
		  //Do we need to create an images directory?
		  if arImages.Ubound > -1 then
		    if mfImages.exists = false or mfImages.Directory = false then
		      mfImages.CreateAsFolder
		    end
		    
		    for i as integer = 0 to arImages.Ubound
		      dim sName as string = format(i + 1, "00000")
		      dim fPicture as folderitem = mfImages.child(sName + ".png")
		      if fPicture.exists then
		        fPicture.Delete
		      end
		      
		      dim p as picture = arImages(i)
		      p.save(fPicture, picture.SaveAsPNG)
		    next
		    
		  end
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		arImages() As Picture
	#tag EndProperty

	#tag Property, Flags = &h21
		Private dictStyles As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h0
		iCSSInsertIndex As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		iImageCount As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private iLastStyleNum As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		lines() As string
	#tag EndProperty

	#tag Property, Flags = &h0
		mf As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h0
		mfImages As FolderItem
	#tag EndProperty


	#tag Constant, Name = kDefinedSpacsToTab, Type = String, Dynamic = False, Default = \"    ", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kHTMLTab, Type = String, Dynamic = False, Default = \"&nbsp;&nbsp;&nbsp;&nbsp;", Scope = Public
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="iCSSInsertIndex"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="iImageCount"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
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
