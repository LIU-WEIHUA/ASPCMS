<%@language=vbscript codepage=936 %>
<%
option explicit
response.buffer=true	
Const PurviewLevel=2    '����Ȩ��
Const CheckChannelID=0    '����Ƶ����0Ϊ���������Ƶ��
Const PurviewLevel_Others="UpFile"
%>
<!--#include file="inc/conn.asp"-->
<!--#include file="inc/config.asp"-->
<!--#include file="Admin_ChkPurview.asp"-->
<!--#include file="inc/function.asp"-->
<%
Const MaxPerPage=20
dim strFileName
dim Action
dim totalPut,CurrentPage,TotalPages
dim UploadDir,TruePath,fso,theFolder,theFile,thisfile,FileCount,TotalSize,TotalSize_Page
dim strFileType
dim sql,rs,strFiles,i
dim strDirName
Action=trim(Request("Action"))

if request("page")<>"" then
    currentPage=cint(request("page"))
else
	currentPage=1
end if

set rs=server.CreateObject("adodb.recordset")
select case trim(request("UploadDir"))
case "UploadFiles"
	UploadDir="UploadFiles"
	strDirName="����Ƶ�����ϴ��ļ�"
	sql="select UploadFiles from Article"
	rs.open sql,conn,1,1
	do while not rs.eof
		if rs(0)<>"" then
			strFiles=strFiles & "|" & rs(0)
		end if
		rs.movenext
	loop
case "UploadThumbs"
	UploadDir="UploadThumbs"
	strDirName="ͼƬƵ��������ͼ"
	sql="select PhotoUrl_Thumb,PhotoUrl,PhotoUrl2,PhotoUrl3,PhotoUrl4 from Photo"
	rs.open sql,conn,1,1
	do while not rs.eof
		if rs(0)<>"" then
			strFiles=strFiles & "|" & rs(0)
		end if
		if rs(1)<>"" then
			strFiles=strFiles & "|" & rs(0)
		end if
		if rs(2)<>"" then
			strFiles=strFiles & "|" & rs(0)
		end if
		if rs(3)<>"" then
			strFiles=strFiles & "|" & rs(0)
		end if
		if rs(4)<>"" then
			strFiles=strFiles & "|" & rs(0)
		end if
		rs.movenext
	loop
case "UploadPhotos"
	UploadDir="UploadPhotos"
	strDirName="ͼƬƵ�����ϴ�ͼƬ"
	sql="select PhotoUrl_Thumb,PhotoUrl,PhotoUrl2,PhotoUrl3,PhotoUrl4 from Photo"
	rs.open sql,conn,1,1
	do while not rs.eof
		if rs(0)<>"" then
			strFiles=strFiles & "|" & rs(0)
		end if
		if rs(1)<>"" then
			strFiles=strFiles & "|" & rs(0)
		end if
		if rs(2)<>"" then
			strFiles=strFiles & "|" & rs(0)
		end if
		if rs(3)<>"" then
			strFiles=strFiles & "|" & rs(0)
		end if
		if rs(4)<>"" then
			strFiles=strFiles & "|" & rs(0)
		end if
		rs.movenext
	loop
case "UploadSoftPic"
	UploadDir="UploadSoftPic"
	strDirName="����Ƶ�������ͼƬ"
	sql="select SoftPicUrl from Soft"
	rs.open sql,conn,1,1
	do while not rs.eof
		if rs(0)<>"" then
			strFiles=strFiles & "|" & rs(0)
		end if
		rs.movenext
	loop
case "UploadSoft"
	UploadDir="UploadSoft"
	strDirName="����Ƶ�����ϴ����"
	sql="select DownloadUrl1,DownloadUrl2,DownloadUrl3,DownloadUrl4 from Soft"
	rs.open sql,conn,1,1
	do while not rs.eof
		if rs(0)<>"" then
			strFiles=strFiles & "|" & rs(0)
		end if
		if rs(1)<>"" then
			strFiles=strFiles & "|" & rs(0)
		end if
		if rs(2)<>"" then
			strFiles=strFiles & "|" & rs(0)
		end if
		if rs(3)<>"" then
			strFiles=strFiles & "|" & rs(0)
		end if
		rs.movenext
	loop
case "UploadAdPic"
	UploadDir="UploadAdPic"
	strDirName="��վ�����ϴ�ͼƬ"
	sql="select ImgUrl from Advertisement"
	rs.open sql,conn,1,1
	do while not rs.eof
		if rs(0)<>"" then
			strFiles=strFiles & "|" & rs(0)
		end if
	rs.movenext
	loop
case else
	UploadDir="UploadFiles"
	strDirName="����Ƶ�����ϴ��ļ�"
	sql="select UploadFiles from Article"
	rs.open sql,conn,1,1
	do while not rs.eof
		if rs(0)<>"" then
			strFiles=strFiles & "|" & rs(0)
		end if
		rs.movenext
	loop
end select
rs.close
set rs=nothing

strFileName="Admin_UploadFile.asp?UploadDir=" & UploadDir
if right(UploadDir,1)<>"/" then
	UploadDir=UploadDir & "/"
end if
TruePath=Server.MapPath(UploadDir)
%>

<html>
<head>
<title>�ϴ��ļ�����</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="Admin_Style.css" rel="stylesheet" type="text/css">
</head>
<SCRIPT language=javascript>
function unselectall()
{
    if(document.myform.chkAll.checked){
	document.myform.chkAll.checked = document.myform.chkAll.checked&0;
    } 	
}

function CheckAll(form)
{
  for (var i=0;i<form.elements.length;i++)
    {
    var e = form.elements[i];
    if (e.Name != "chkAll")
       e.checked = form.chkAll.checked;
    }
}

</script>
<body leftmargin="2" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" Class="border">
  <tr class="topbg"> 
    <td height="22" colspan=2 align=center><b>�� �� �� �� �� ��</b></td>
  </tr>
  <tr class="tdbg"> 
    <td width="70" height="30"><strong>��������</strong></td>
    <td height="30"><a href="Admin_UploadFile.asp?UploadDir=UploadFiles">����Ƶ�����ϴ��ļ�</a> 
      |<a href="Admin_UploadFile.asp?UploadDir=UploadAdPic"> ��վ�����ϴ�ͼƬ</a> | <a href="Admin_UploadFile.asp?Action=Clear">��������ļ�</a> 
      | </td>
  </tr>
</table>
<%
If not IsObjInstalled("Scripting.FileSystemObject") Then
	Response.Write "<b><font color=red>��ķ�������֧�� FSO(Scripting.FileSystemObject)! ����ʹ�ñ�����</font></b>"
Else
	set fso=CreateObject("Scripting.FileSystemObject")
	if Action="Del" then
		call DelFiles()
	elseif Action="DelAll" then
		call DelAll()
	elseif Action="Clear" or Action="DoClear" then
		call ClearFile()
	else
		call main()
	end if
end if

sub main()
	if fso.FolderExists(TruePath)=False then
		response.write "�Ҳ����ļ��У���������������"
		exit sub
	end if
	
	response.write "<br>�����ڵ�λ�ã�<a href='Admin_UploadFile.asp'>�ϴ��ļ�����</a>&nbsp;&gt;&gt;&nbsp;<a href='Admin_UploadFile.asp?UploadDir=" & UploadDir & "'><font color=red>" & strDirName & "</font></a>" 
	FileCount=0
	TotalSize=0
	Set theFolder=fso.GetFolder(TruePath)
	For Each theFile In theFolder.Files
		FileCount=FileCount+1
		TotalSize=TotalSize+theFile.Size
	next
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

sub showContent()
   	dim c
	FileCount=0
	TotalSize_Page=0
%>
<br>
<table width='100%' border="0" cellpadding="0" cellspacing="0">
  <tr>
  <form name="myform" method="Post" action="Admin_UploadFile.asp" onsubmit="return confirm('ȷ��Ҫɾ��ѡ�е��ļ���');">
     <td>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="3" class="border">
  <tr class="tdbg">
    <%

For Each theFile In theFolder.Files
	c=c+1
	if FileCount>=MaxPerPage then
		exit for
	elseif c>MaxPerPage*(CurrentPage-1) then
%>
    <td>
      <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="2">
        <tr>
          <td colspan="2" align="center">
            <%
		  strFileType=lcase(mid(theFile.Name,instrrev(theFile.Name,".")+1))
		  response.write "<a href='" & UploadDir & theFile.Name & "'>"
		  select case strFileType
		  case "jpg","gif","bmp","png"
			  if instr(strFiles,theFile.Name)>0 then
			  	response.write "<img src='" & UploadDir & theFile.Name & "' width='140' height='100' border='0'></a>"
			  else
			  	response.write "<img src='" & UploadDir & theFile.Name & "' width='140' height='100' border='2' Title='���õ��ϴ��ļ�'></a>"
			  end if
		  case "swf"
			  if instr(strFiles,theFile.Name)>0 then
			  	response.write "<img src='images/filetype_flash.gif' width='140' height='100' border='0'></a>"
			  else
				response.write "<img src='images/filetype_flash.gif' width='140' height='100' border='2' Title='���õ��ϴ��ļ�'></a>"
			  end if
		  case "wmv","avi","asf","mpg"
			  if instr(strFiles,theFile.Name)>0 then
			  	response.write "<img src='images/filetype_media.gif' width='140' height='100' border='0'></a>"
			  else	
				response.write "<img src='images/filetype_media.gif' width='140' height='100' border='2' Title='���õ��ϴ��ļ�'></a>"
			  end if
		  case "rm","ra","ram"
			  if instr(strFiles,theFile.Name)>0 then
		  		response.write "<img src='images/filetype_rm.gif' width='140' height='100' border='0'></a>"
		  	  else		
				response.write "<img src='images/filetype_rm.gif' width='140' height='100' border='2' Title='���õ��ϴ��ļ�'></a>"
			  end if
		  case "rar"
		    response.write "<img src='images/filetype_rar.gif' width='140' height='100' border='0'></a>"
		  case "zip"
		    response.write "<img src='images/filetype_zip.gif' width='140' height='100' border='0'></a>"
		  case "exe"
		    response.write "<img src='images/filetype_exe.gif' width='140' height='100' border='0'></a>"
		  case else
			  if instr(strFiles,theFile.Name)>0 then
		  		response.write "<img src='images/filetype_other.gif' width='140' height='100' border='0'></a>"
		  	  else		
				response.write "<img src='images/filetype_other.gif' width='140' height='100' border='2' Title='���õ��ϴ��ļ�'></a>"
			  end if
		  end select
		  %>
          </td>
        </tr>
        <tr>
          <td align="right">�� �� ����</td>
          <td><%
		  if instr(strFiles,theFile.Name)>0 then
		  	response.write "<a href='" & UploadDir & theFile.Name & "' target='_blank'>" & theFile.Name & "</a>"
		  else
		  	response.write "<a href='" & UploadDir & theFile.Name & "' target='_blank' title='���õ��ϴ��ļ�'><font color=red>" & theFile.Name & "</font></a>"
		  end if%>
		  </td>
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
        <tr>
          <td align="right">����ѡ�</td>
          <td><input name="FileName" type="checkbox" id="FileName" value="<%=theFile.Name%>" onclick="unselectall()" <%if instr(strFiles,theFile.Name)<=0 then response.write "checked"%>>
            ѡ��&nbsp;&nbsp;&nbsp;&nbsp;<a href="Admin_UploadFile.asp?Action=Del&FileName=<%=theFile.Name%>&UploadDir=<%=left(UploadDir,len(UploadDir)-1)%>" onclick="return confirm('�����Ҫɾ�����ļ���!')">ɾ��</a></td>
        </tr>
      </table>
    </td>
    <%
		FileCount=FileCount+1
		if FileCount mod 4=0 then response.write "</td><tr class='tdbg'>"
		TotalSize_Page=TotalSize_Page+theFile.Size
	end if
Next
%>
  </tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td width="200" height="30"><input name="chkAll" type="checkbox" id="chkAll" onclick=CheckAll(this.form) value="checkbox">
      ѡ�б�ҳ��ʾ�������ļ�</td>
    <td><input name="Action" type="hidden" id="Action" value="Del">
      <input name="UploadDir" type="hidden" id="UploadDir" value="<%=left(UploadDir,len(UploadDir)-1)%>">
              <input type="submit" name="Submit" value="ɾ��ѡ�е��ļ�">
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              <input type="submit" name="Submit2" value="ɾ�������ļ�" onClick="document.myform.Action.value='DelAll';">
              </td>
  </tr>
</table>
</td></form></tr></table>
<%
end sub

sub ClearFile()
%>
<br>
<table width="100%" border="0" cellspacing="1" cellpadding="2" class="border">
  <tr class="title">
    <td height="22" align="center"><strong>�������õ��ϴ��ļ�</strong></td>
  </tr>
  <tr class="tdbg">
    <td height="150">
<%
if Action="Clear" then
%>
<form name="form1" method="post" action="Admin_UploadFile.asp" onSubmit="javascript:if(document.form1.UploadFiles.checked==false&&document.form1.UploadThumbs.checked==false&&document.form1.UploadPhotos.checked==false&&document.form1.UploadSoftPic.checked==false&&document.form1.UploadSoft.checked==false&&document.form1.UploadAdPic.checked==false){alert('��������ѡ��һ��Ҫ��յ�Ŀ¼��');return false;}">
&nbsp;&nbsp;&nbsp;&nbsp;���������ʱ������������ϴ���ͼƬ��ȴ����û�з�����ƪ���µ������ʱ��һ�ã��ͻ�����������������ļ���������Ҫ����ʹ�ñ����ܽ�������      
<p>&nbsp;&nbsp;&nbsp;&nbsp;����ϴ��ļ��ܶ࣬�������������϶ִ࣬�б�������Ҫ�ķ��൱����ʱ�䣬���ڷ�������ʱִ�б�������</p>
<p>&nbsp;&nbsp;&nbsp;&nbsp;��ѡ����Ҫ������ϴ�Ŀ¼��</p>
        <table width="150" border="0" align="center" cellpadding="0" cellspacing="2">
          <tr> 
            <td><input name="UploadFiles" type="checkbox" id="UploadFiles" value="Yes">
              ����Ƶ�����ϴ��ļ�</td>
          </tr>
  
          <tr> 
            <td><input name="UploadAdPic" type="checkbox" id="UploadAdPic" value="Yes">
              ��վ�����ϴ�ͼƬ</td>
          </tr>
        </table>
<p align="center"><input name="Action" type="hidden" id="Action" value="DoClear">
      <input type="submit" name="Submit3" value=" ��ʼ���� ">
</p>
</form>
<%
else
	call DoClear()
end if
%>
    </td>
  </tr>
</table>
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

sub DelFiles()
	dim whichfile,arrFileName,i
	whichfile=trim(Request("FileName"))
	if whichfile="" then exit sub
	if instr(whichfile,",")>0 then
		arrFileName=split(whichfile,",")
		for i=0 to ubound(arrFileName)
			if left(trim(arrFileName(i)),3)<>"../" and left(trim(arrFileName(i)),1)<>"/" then
				whichfile=server.MapPath(UploadDir & trim(arrFileName(i)))
				set thisfile=fso.GetFile(whichfile)
				thisfile.Delete True
			end if
		next
	else
		if left(whichfile,3)<>"../" and left(whichfile,1)<>"/" then
			Set thisfile = fso.GetFile(server.MapPath(UploadDir & whichfile))
			thisfile.Delete True
		end if
	end if
	call main()
end sub

sub DelAll()
	Set theFolder=fso.GetFolder(TruePath)
	For Each theFile In theFolder.Files
		theFile.Delete True
	next
	call main()
end sub

sub DoClear()
	set rs=server.CreateObject("adodb.recordset")
	if trim(request("UploadFiles"))="Yes" then
		strFiles=""
		sql="select UploadFiles from Article"
		rs.open sql,conn,1,1
		do while not rs.eof
			if rs(0)<>"" then
				strFiles=strFiles & "|" & rs(0)
			end if
			rs.movenext
		loop
		rs.close
		call DelFile_Useless("UploadFiles","����Ƶ�����ϴ��ļ�")
	end if
	
	if trim(request("UploadThumbs"))="Yes" then
		strFiles=""
		sql="select PhotoUrl_Thumb,PhotoUrl,PhotoUrl2,PhotoUrl3,PhotoUrl4 from Photo"
		rs.open sql,conn,1,1
		do while not rs.eof
			if rs(0)<>"" then
				strFiles=strFiles & "|" & rs(0)
			end if
			if rs(1)<>"" then
				strFiles=strFiles & "|" & rs(0)
			end if
			if rs(2)<>"" then
				strFiles=strFiles & "|" & rs(0)
			end if
			if rs(3)<>"" then
				strFiles=strFiles & "|" & rs(0)
			end if
			if rs(4)<>"" then
				strFiles=strFiles & "|" & rs(0)
			end if
			rs.movenext
		loop
		rs.close
		call DelFile_Useless("UploadThumbs","ͼƬƵ��������ͼ")
	end if
	
	if trim(request("UploadPhotos"))="Yes" then
		strFiles=""
		sql="select PhotoUrl_Thumb,PhotoUrl,PhotoUrl2,PhotoUrl3,PhotoUrl4 from Photo"
		rs.open sql,conn,1,1
		do while not rs.eof
			if rs(0)<>"" then
				strFiles=strFiles & "|" & rs(0)
			end if
			if rs(1)<>"" then
				strFiles=strFiles & "|" & rs(0)
			end if
			if rs(2)<>"" then
				strFiles=strFiles & "|" & rs(0)
			end if
			if rs(3)<>"" then
				strFiles=strFiles & "|" & rs(0)
			end if
			if rs(4)<>"" then
				strFiles=strFiles & "|" & rs(0)
			end if
			rs.movenext
		loop
		rs.close
		call DelFile_Useless("UploadPhotos","ͼƬƵ�����ϴ�ͼƬ")
	end if

	if trim(request("UploadSoftPic"))="Yes" then
		strFiles=""
		sql="select SoftPicUrl from Soft"
		rs.open sql,conn,1,1
		do while not rs.eof
			if rs(0)<>"" then
				strFiles=strFiles & "|" & rs(0)
			end if
			rs.movenext
		loop
		rs.close
		call DelFile_Useless("UploadSoftPic","����Ƶ�������ͼƬ")
	end if
	
	if trim(request("UploadSoft"))="Yes" then
		strFiles=""
		sql="select DownloadUrl1,DownloadUrl2,DownloadUrl3,DownloadUrl4 from Soft"
		rs.open sql,conn,1,1
		do while not rs.eof
			if rs(0)<>"" then
				strFiles=strFiles & "|" & rs(0)
			end if
			if rs(1)<>"" then
				strFiles=strFiles & "|" & rs(0)
			end if
			if rs(2)<>"" then
				strFiles=strFiles & "|" & rs(0)
			end if
			if rs(3)<>"" then
				strFiles=strFiles & "|" & rs(0)
			end if
			rs.movenext
		loop
		rs.close
		call DelFile_Useless("UploadSoft","����Ƶ�����ϴ����")
	end if

	if trim(request("UploadAdPic"))="Yes" then
		strFiles=""
		sql="select ImgUrl from Advertisement"
		rs.open sql,conn,1,1
		do while not rs.eof
			if rs(0)<>"" then
				strFiles=strFiles & "|" & rs(0)
			end if
			rs.movenext
		loop
		rs.close
		call DelFile_Useless("UploadAdPic","��վ�����ϴ�ͼƬ")
	end if

	set rs=nothing
end sub

sub DelFile_Useless(strDir,strDirName)
	dim i
	i=0
	Set theFolder=fso.GetFolder(server.MapPath(strDir))
	For Each theFile In theFolder.Files
		if instr(strFiles,theFile.Name)<=0 then
			theFile.Delete True
			i=i+1
		end if
	next
	response.write "����ִ�гɹ����� <font color=blue>" & strDirName & "</font> Ŀ¼�й�ɾ���� <font color=red><b>" & i & "</b></font> �����õ��ļ���<br><br>"
end sub
%>