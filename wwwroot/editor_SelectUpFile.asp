<%@language=vbscript codepage=936 %>
<%
option explicit
response.buffer=true	
if trim(session("AdminName"))="" then
	response.write "�Բ��𣬴˹���ֻ�й���Ա����ʹ�á�"
	response.end
end if
%>
<!--#include file="inc/config.asp"-->
<!--#include file="inc/function.asp"-->
<%
Const MaxPerPage=20
const UpFileType_pic="jpg|gif|bmp|png"
const UpFileType_flash="swf"
const UpFileType_media="wmv|asf|avi|mpg"
const UpFileType_rm="ram|rm|ra"
dim strFileName
dim Action
dim totalPut,CurrentPage,TotalPages
dim UploadDir,TruePath,fso,theFolder,theFile,thisfile,FileCount,TotalSize,TotalSize_Page
dim DialogType,strUpFileType,strFileType,FileID
DialogType=replace(trim(request("DialogType")),"'","")
strFileName="editor_SelectUpFile.asp?DialogType=" & DialogType
Action=trim(Request("Action"))

if request("page")<>"" then
    currentPage=cint(request("page"))
else
	currentPage=1
end if
select case DialogType
	case "pic"
		strUpFileType=UpFileType_pic
	case "flash"
		strUpFileType=UpFileType_flash
	case "media"
		strUpFileType=UpFileType_media
	case "rm"
		strUpFileType=UpFileType_rm
	case else
		strUpFileType=""
end select


if right(SaveUpFilesPath,1)<>"/" then
	UploadDir="" & SaveUpFilesPath & "/"
else
	UploadDir="" & SaveUpFilesPath
end if
TruePath=Server.MapPath(UploadDir)
%>

<html>
<head>
<title>�����ϴ��ļ�ѡ��</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="Admin_Style.css" rel="stylesheet" type="text/css">
</head>
<body leftmargin="2" topmargin="0" marginwidth="0" marginheight="0">
<%
If not IsObjInstalled("Scripting.FileSystemObject") Then
	Response.Write "<b><font color=red>��ķ�������֧�� FSO(Scripting.FileSystemObject)! ����ʹ�ñ�����</font></b>"
Else
	set fso=CreateObject("Scripting.FileSystemObject")
	call main()
end if

sub main()
	if fso.FolderExists(TruePath)=False then
		response.write "�Ҳ����ļ��У���������������"
		exit sub
	end if

	FileCount=0
	TotalSize=0
	Set theFolder=fso.GetFolder(TruePath)
	For Each theFile In theFolder.Files
		strFileType=lcase(mid(theFile.Name,instrrev(theFile.Name,".")+1))
		if instr(strUpFileType,strFileType)>0 then
			FileCount=FileCount+1
			TotalSize=TotalSize+theFile.Size
		end if
	next
	if FileCount=0 then
		response.write "<p>&nbsp;</p><p>&nbsp;</p><p align='center'>û���ҵ��κ�" & DialogType & "�ļ���</p>"
		exit sub
	end if
	totalPut=FileCount
	if currentpage<1 then
		currentpage=1
	end if
	if (currentpage-1)*MaxPerPage>totalput then
		if (totalPut mod MaxPerPage)=0 then
			currentpage= totalPut \ MaxPerPage
		else
			currentpage= totalPut \ MaxPerPage + 1
		end if
	end if
	if currentPage=1 then
		showContent
		showpage2 strFileName,totalput,MaxPerPage
		response.write "<br><div align='center'>��ҳ����ʾ <b>" & FileCount & "</b> ���ļ���ռ�� <b>" & TotalSize_Page\1024 & "</b> K</div>"
	else
		if (currentPage-1)*MaxPerPage<totalPut then
			showContent
			showpage2 strFileName,totalput,MaxPerPage
			response.write "<br><div align='center'>��ҳ����ʾ <b>" & FileCount & "</b> ���ļ���ռ�� <b>" & TotalSize_Page\1024 & "</b> K</div>"
		else
			currentPage=1
			showContent
			showpage2 strFileName,totalput,MaxPerPage
			response.write "<br><div align='center'>��ҳ����ʾ <b>" & FileCount & "</b> ���ļ���ռ�� <b>" & TotalSize_Page\1024 & "</b> K</div>"
		end if
	end if
end sub

sub ShowContent()
   	dim c
	FileCount=0
	TotalSize_Page=0
%>
<table width='100%' border="0" cellpadding="0" cellspacing="0">
  <tr>
  <form name="myform" method="Post" action="editor_SelectUpFile.asp" onsubmit="return confirm('ȷ��Ҫɾ��ѡ�е��ļ���');">
     <td>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="3" class="border">
  <tr class="tdbg">
  <%

For Each theFile In theFolder.Files
	c=c+1
	if FileCount>=MaxPerPage then
		exit for
	elseif c>MaxPerPage*(CurrentPage-1) then
		strFileType=lcase(mid(theFile.Name,instrrev(theFile.Name,".")+1))
		if instr(strUpFileType,strFileType)>0 then
%>
   <td>
      <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="2">
        <tr>
          <td colspan="2" align="center">
            <%
		  response.write "<a href='#' onClick=""javascript:window.opener.document.form1.url.value='" & UploadDir & theFile.Name & "';window.opener.document.form1.UpFileName.value='" & UploadDir & theFile.Name & "';window.close();"">"
		  select case strFileType
		  case "jpg","gif","bmp","png"
		  	response.write "<img src='" & UploadDir & theFile.Name & "' width='140' height='100' border='0' title='���ͼƬ�����أ���������ļ������鿴ԭʼ�ļ���'></a>"
		  case "swf"
		  	response.write "<img src='images/filetype_flash.gif' width='140' height='100' border='0'></a>"
		  case "wmv","avi","asf","mpg"
		  	response.write "<img src='images/filetype_media.gif' width='140' height='100' border='0'></a>"
		  case "rm","ra","ram"
		  	response.write "<img src='images/filetype_rm.gif' width='140' height='100' border='0'></a>"
		  case "rar"
		    response.write "<img src='images/filetype_rar.gif' width='140' height='100' border='0'></a>"
		  case "zip"
		    response.write "<img src='images/filetype_zip.gif' width='140' height='100' border='0'></a>"
		  case "exe"
		    response.write "<img src='images/filetype_exe.gif' width='140' height='100' border='0'></a>"
		  case else
		  	response.write "<img src='images/filetype_other.gif' width='140' height='100' border='0'></a>"
		  end select
		  %>
          </td></tr>
        <tr>
          <td align="right">�� �� ����</td>
          <td><a href="<%=(UploadDir & theFile.Name)%>" target="_blank"><%=theFile.Name%></a></td>
        </tr>
        <tr>
          <td align="right">�ļ���С��</td>
          <td><%=round(theFile.size/1024) & " K"%></td>
        </tr>
        <tr>
          <td align="right">�ļ����ͣ�</td>
          <td><%=theFile.type%></td>
        </tr>
        <tr>
          <td align="right">�޸�ʱ�䣺</td>
          <td><%=theFile.DateLastModified%></td>
        </tr>
      </table></td>
  <%
			FileCount=FileCount+1
			if FileCount mod 4=0 then response.write "</td><tr class='tdbg'>"
			TotalSize_Page=TotalSize_Page+theFile.Size
		end if
	end if
Next
%>
    </tr>
</table> 
     </td>
  </form></tr></table>
<%
end sub
%>
</body> 
</html>
<%
sub showpage2(sfilename,totalnumber,maxperpage)
	dim n, i,strTemp
	if totalnumber mod maxperpage=0 then
    	n= totalnumber \ maxperpage
  	else
    	n= totalnumber \ maxperpage+1
  	end if
  	strTemp= "<table align='center'><form name='showpages' method='Post' action='" & sfilename & "'><tr><td>"
	strTemp=strTemp & "�� <b>" & totalnumber & "</b> ���ļ���ռ�� <b>" & TotalSize\1024 & "</b> K&nbsp;&nbsp;&nbsp;"
	sfilename=JoinChar(sfilename)
  	if CurrentPage<2 then
    		strTemp=strTemp & "��ҳ ��һҳ&nbsp;"
  	else
    		strTemp=strTemp & "<a href='" & sfilename & "page=1'>��ҳ</a>&nbsp;"
    		strTemp=strTemp & "<a href='" & sfilename & "page=" & (CurrentPage-1) & "'>��һҳ</a>&nbsp;"
  	end if

  	if n-currentpage<1 then
    		strTemp=strTemp & "��һҳ βҳ"
  	else
    		strTemp=strTemp & "<a href='" & sfilename & "page=" & (CurrentPage+1) & "'>��һҳ</a>&nbsp;"
    		strTemp=strTemp & "<a href='" & sfilename & "page=" & n & "'>βҳ</a>"
  	end if
   	strTemp=strTemp & "&nbsp;ҳ�Σ�<strong><font color=red>" & CurrentPage & "</font>/" & n & "</strong>ҳ "
    strTemp=strTemp & "&nbsp;<b>" & maxperpage & "</b>" & "���ļ�/ҳ"
	strTemp=strTemp & "&nbsp;ת����<select name='page' size='1' onchange='javascript:submit()'>"   
    for i = 1 to n   
   		strTemp=strTemp & "<option value='" & i & "'"
		if cint(CurrentPage)=cint(i) then strTemp=strTemp & " selected "
		strTemp=strTemp & ">��" & i & "ҳ</option>"   
	next
	strTemp=strTemp & "</select>"
	strTemp=strTemp & "</td></tr></form></table>"
	response.write strTemp
end sub
%>