<%@language=vbscript codepage=936 %>
<%
option explicit
response.buffer=true	
Const PurviewLevel=2
Const CheckChannelID=2
Const PurviewLevel_Article=3
%>
<!--#include file="inc/conn.asp"-->
<!--#include file="inc/config.asp"-->
<!--#include file="Admin_ChkPurview.asp"-->
<!--#include file="inc/Conn_User.asp"-->
<!--#include file="inc/ubbcode.asp"-->
<!--#include file="inc/function.asp"-->
<!--#include file="inc/admin_code_article.asp"-->
<%
dim Action,rs,sql,ErrMsg,FoundErr,ObjInstalled
dim ArticleID,ClassID,SpecialID,Title,Content,key,Author,CopyFrom,UpdateTime,Hits,Editor
dim IncludePic,DefaultPicUrl,UploadFiles,Passed,OnTop,Hot,Elite,arrUploadFiles
dim TitleFontColor,TitleFontType,AuthorName,AuthorEmail,CopyFromName,CopyFromUrl,PaginationType,ReadLevel,ReadPoint,Stars,SkinID,LayoutID,MaxCharPerPage
dim tClass,ClassName,Depth,ParentPath,Child,i
ObjInstalled=IsObjInstalled("Scripting.FileSystemObject")
FoundErr=false
Action=trim(request("Action"))
ArticleID=Trim(Request.Form("ArticleID"))
ClassID=trim(request.form("ClassID"))
SpecialID=trim(request.Form("SpecialID"))
Title=trim(request.form("Title"))
TitleFontColor=trim(request.form("TitleFontColor"))
TitleFontType=trim(request.form("TitleFontType"))
Key=trim(request.form("Key"))
Content=trim(request.form("Content"))
Author=trim(request.form("Author"))
AuthorName=trim(request.form("AuthorName"))
AuthorEmail=trim(request.form("AuthorEmail"))
CopyFrom=trim(request.form("CopyFrom"))
CopyFromName=trim(request.form("CopyFromName"))
CopyFromUrl=trim(request.form("CopyFromUrl"))
UpdateTime=trim(request.form("UpdateTime"))
IncludePic=trim(request.form("IncludePic"))
DefaultPicUrl=trim(request.form("DefaultPicUrl"))
UploadFiles=trim(request.form("UploadFiles"))
Passed=trim(request.form("Passed"))
OnTop=trim(request.form("OnTop"))
Hot=trim(request.form("Hot"))
Elite=trim(request.form("Elite"))
Hits=trim(request.form("Hits"))
Editor=AdminName
PaginationType=trim(request.form("PaginationType"))
MaxCharPerPage=trim(request.form("MaxCharPerPage"))
ReadLevel=trim(request.form("ReadLevel"))
ReadPoint=trim(request.form("ReadPoint"))
Stars=trim(request.form("Stars"))
SkinID=trim(request.form("SkinID"))
LayoutID=trim(request.form("LayoutID"))

if Action="" then
	FoundErr=True
	ErrMsg=ErrMsg & "<br><li>��������</li>"
else
	call SaveArticle()
end if
if founderr=true then
	call WriteErrMsg()
else
	call SaveSuccess()
end if
call CloseConn()


sub SaveArticle()
	dim PurviewChecked
	if ClassID="" then
		founderr=true
		errmsg=errmsg & "<br><li>δָ������������Ŀ����ָ������Ŀ����������Ŀ</li>"
	else
		ClassID=CLng(ClassID)
		if ClassID<=0 then
			FoundErr=True
			ErrMsg=ErrMsg & "<br><li>ָ���˷Ƿ�����Ŀ���ⲿ��Ŀ�򲻴��ڵ���Ŀ��</li>"
		else
			set tClass=conn.execute("select ClassName,Depth,ParentPath,Child,LinkUrl,ParentID,ClassInputer From ArticleClass where ClassID=" & ClassID)
			if tClass.bof and tClass.eof then
				FoundErr=True
				ErrMsg=ErrMsg & "<br><li>�Ҳ���ָ������Ŀ</li>"
			else
				ClassName=tClass(0)
				Depth=tClass(1)
				ParentPath=tClass(2)
				Child=tClass(3)
				if Child>0 then
					FoundErr=True
					ErrMsg=ErrMsg & "<br><li>ָ������Ŀ����������Ŀ</li>"
				end if
				if tClass(4)<>"" then
					FoundErr=True
					ErrMsg=ErrMsg & "<br><li>����ָ���ⲿ��Ŀ</li>"
				end if
				if AdminPurview=2 and AdminPurview_Article=3 then
					PurviewChecked=CheckClassMaster(tClass(6),AdminName)
					if PurviewChecked=False and tClass(5)>0 then
						set tClass=conn.execute("select ClassInputer from ArticleClass where ClassID in (" & ParentPath & ")")
						do while not tClass.eof
							PurviewChecked=CheckClassMaster(tClass(0),AdminName)
							if PurviewChecked=True then exit do
							tClass.movenext
						loop
					end if
					if PurviewChecked=False then
						FoundErr=True
						ErrMsg=ErrMsg & "<br><li>�Բ�����û���ڴ���Ŀ�������µ�Ȩ�ޣ�</li>"
					end if
				end if
			end if
		end if
	end if
	if Title="" then
		founderr=true
		errmsg=ErrMsg & "<br><li>���±��ⲻ��Ϊ��</li>"
	end if
	if Key="" then
		founderr=true
		errmsg=errmsg & "<br><li>���������¹ؼ���</li>"
	end if
	if Content="" then
		founderr=true
		errmsg=errmsg & "<br><li>�������ݲ���Ϊ��</li>"
	end if
	if SkinID="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>��ָ��Ĭ����ɫģ��</li>"
	else
		SkinID=Clng(SkinID)
	end if
	if LayoutID="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>��ָ��Ĭ�ϰ������ģ��</li>"
	else
		LayoutID=Clng(LayoutID)
	end if
	if PaginationType="" then
		PaginationType=0
	else
		PaginationType=Cint(PaginationType)
	end if
	if MaxCharPerPage="" then
		MaxCharPerPage=0
	else
		MaxCharPerPage=CLng(MaxCharPerPage)
	end if
	if PaginationType=1 and MaxCharPerPage=0 then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>��ָ���Զ���ҳʱ��ÿҳ��Լ�ַ������������0</li>"
	end if
	
	if FoundErr=True then
		exit sub
	end if

	if SpecialID="" then
		SpecialID=0
	else
		SpecialID=CLng(SpecialID)
	end if
	Title=dvhtmlencode(Title)
	if TitleFontType="" then
		TitleFontType=0
	end if
	Key="|" & ReplaceBadChar(Key) & "|"
	dim strSiteUrl
	strSiteUrl=request.ServerVariables("HTTP_REFERER")
	strSiteUrl=lcase(left(strSiteUrl,instrrev(strSiteUrl,"/")))
	Content=ubbcode(replace(Content,strSiteUrl,""))
	Content=ReplaceRemoteUrl(Content)
	if Author<>"" then
		Author=dvhtmlencode(Author)
	else
		if AuthorName="" and AuthorEmail="" then
			Author="����"
		else
			if AuthorName<>"" then
				Author=AuthorName
				if AuthorEmail<>"" then
			 		Author=Author & "|" & AuthorEmail
				end if
			end if
		end if
	end if
	if CopyFrom<>"" then
		CopyFrom=dvhtmlencode(CopyFrom)
	else
		if CopyFromName="" and CopyFromUrl="" then
			CopyFrom="��վԭ��"
		else
			if CopyFromName<>"" then
				CopyFrom=CopyFromName
				if CopyFromUrl<>"" then
					CopyFrom=CopyFrom & "|" & CopyFromUrl
				end if
			end if
		end if			
	end if
	if UpdateTime<>"" and IsDate(UpdateTime)=true then
		UpdateTime=CDate(UpdateTime)
	else
		UpdateTime=now()
	end if
	if Hits<>"" then
		Hits=CLng(Hits)
	else
		Hits=0
	end if
	if ReadLevel="" then
		ReadLevel=9999
	else
		ReadLevel=CInt(ReadLevel)
	end if
	if ReadPoint="" then
		ReadPoint=0
	else
		ReadPoint=Cint(ReadPoint)
	end if
	if Stars="" then
		Stars=0
	else
		Stars=CInt(Stars)
	end if
	
	set rs=server.createobject("adodb.recordset")
	if Action="Add1" or Action="Add2" then
		sql="select top 1 * from article" 
		rs.open sql,conn,1,3
		rs.addnew
		call SaveData()
		rs("Editor")=Editor
		rs.update
		ArticleID=rs("ArticleID")
		rs.close
	elseif Action="Modify" then
  		if ArticleID="" then
			founderr=true
			errmsg=errmsg & "<br><li>����ȷ��ArticleID��ֵ</li>"
		else
			ArticleID=Clng(ArticleID)
			sql="select * from article where articleid=" & ArticleID
			rs.open sql,conn,1,3
			if rs.bof and rs.eof then
				founderr=true
				errmsg=errmsg & "<br><li>�Ҳ��������£������Ѿ���������ɾ����</li>"
 			else
				if rs("Passed")=False and Passed="yes" then
					Conn_User.execute("update " & db_User_Table & " set " & db_User_ArticleChecked & "=" & db_User_ArticleChecked & "+1 where " & db_User_Name & "='" & rs("Editor") & "'")
				end if
				if rs("Passed")=True and Passed<>"yes" then
					Conn_User.execute("update " & db_User_Table & " set " & db_User_ArticleChecked & "=" & db_User_ArticleChecked & "-1 where " & db_User_Name & "='" & rs("Editor") & "'")
				end if
				call SaveData()
				rs.update
				rs.close
			end if
		end if
	else
		FoundErr=True
		ErrMsg="<br><li>��������!</li>"
	end if
	set rs=nothing
end sub

sub SaveData()
	rs("ClassID")=ClassID
	rs("SpecialID")=SpecialID
	rs("Title")=Title
	rs("TitleFontColor")=TitleFontColor
	rs("TitleFontType")=TitleFontType
	rs("Content")=Content
	rs("Key")=Key
	rs("Hits")=Hits
	rs("Author")=Author
	rs("CopyFrom")=CopyFrom
	if IncludePic="yes" then
		rs("IncludePic")=True
	else
		rs("IncludePic")=False
	end if
	if Passed="yes" then
		rs("Passed")=True
	else
		if EnableArticleCheck="No" then
			rs("Passed")=True
		else
			rs("Passed")=False
		end if
	end if
	if OnTop="yes" then
		rs("OnTop")=True
	else
		rs("OnTop")=False
	end if
	if Hot="yes" then
		rs("Hot")=True
	else
		rs("Hot")=False
	end if
	if Elite="yes" then
		rs("Elite")=True
	else
		rs("Elite")=False
	end if
	rs("Stars")=Stars
	rs("UpdateTime")=UpdateTime
	rs("PaginationType")=PaginationType
	rs("MaxCharPerPage")=MaxCharPerPage
	rs("ReadLevel")=ReadLevel
	rs("ReadPoint")=ReadPoint
	rs("SkinID")=SkinID
	rs("LayoutID")=LayoutID

	'***************************************
	'ɾ�����õ��ϴ��ļ�
	if ObjInstalled=True and UploadFiles<>"" then
		dim fso,strRubbishFile
		Set fso = Server.CreateObject("Scripting.FileSystemObject")
		if instr(UploadFiles,"|")>1 then
			dim arrUploadFiles,intTemp
			arrUploadFiles=split(UploadFiles,"|")
			UploadFiles=""
			for intTemp=0 to ubound(arrUploadFiles)
				if instr(Content,arrUploadFiles(intTemp))<=0 and arrUploadFiles(intTemp)<>DefaultPicUrl then
					strRubbishFile=server.MapPath("" & arrUploadFiles(intTemp))
					if fso.FileExists(strRubbishFile) then
						fso.DeleteFile(strRubbishFile)
						response.write "<br><li>" & arrUploadFiles(intTemp) & "��������û���õ���Ҳû�б���Ϊ��ҳͼƬ�������Ѿ���ɾ����</li>"
					end if
				else
					if intTemp=0 then
						UploadFiles=arrUploadFiles(intTemp)
					else
						UploadFiles=UploadFiles & "|" & arrUploadFiles(intTemp)
					end if
				end if
			next
		else
			if instr(Content,UploadFiles)<=0 and UploadFiles<>DefaultPicUrl then
				strRubbishFile=server.MapPath("" & UploadFiles)
				if fso.FileExists(strRubbishFile) then
					fso.DeleteFile(strRubbishFile)
					response.write "<br><li>" & UploadFiles & "��������û���õ���Ҳû�б���Ϊ��ҳͼƬ�������Ѿ���ɾ����</li>"
				end if
				UploadFiles=""
			end if
		end if
		set fso=nothing
	end If
	'����
	'***************************************
	rs("DefaultPicUrl")=DefaultPicUrl
	rs("UploadFiles")=UploadFiles
end sub
	
sub SaveSuccess()
%>
<html>
<head>
<title></title>
<link rel="stylesheet" type="text/css" href="Admin_Style.css">
</head>
<body leftmargin="2" topmargin="0" marginwidth="0" marginheight="0">
<br/><br/>
<table class="border" align=center width="400" border="0" cellpadding="0" cellspacing="0" bordercolor="#999999">
  <tr align=center> 
    <td  height="22" align="center" class="title"><b> 
      <%if action="Add1" or Action="Add2" then%>
      ��� 
      <%else%>
      �޸� 
      <%end if%>
      ���³ɹ�</b></td>
  </tr>
<%if Passed<>"yes" then%>
  <tr class="tdbg"> 
    <td height="60"><font color="#0000FF">ע�⣺</font><br>
      &nbsp;&nbsp;&nbsp; ���������δ��������ֻ�еȹ���Ա��˲�ͨ����������º�������ӵ����²Żᷢ��</td>
  </tr>
<%end if%>
  <tr> 
    <td><table width="100%" border="0" cellpadding="2" cellspacing="1">
        <tr class="tdbg"> 
          <td width="100" align="right"><strong>������Ŀ��</strong></td>
          <td><%call Admin_ShowPath2(ParentPath,ClassName,Depth)%></td>
        </tr>
        <tr class="tdbg"> 
          <td width="100" align="right"><strong>���±��⣺</strong></td>
          <td><%= Title %></td>
        </tr>
        <tr class="tdbg"> 
          <td width="100" align="right"><strong>��&nbsp;&nbsp;&nbsp;&nbsp;�ߣ�</strong></td>
          <td><%= Author %></td>
        </tr>
        <tr class="tdbg"> 
          <td width="100" align="right"><strong>ת �� �ԣ�</strong></td>
          <td><%= CopyFrom %></td>
        </tr>
        <tr class="tdbg"> 
          <td width="100" align="right"><strong>�� �� �֣�</strong></td>
          <td><%= mid(Key,2,len(Key)-2) %></td>
        </tr>
      </table></td>
  </tr>
  <tr class="tdbg"> 
    <td height="30" align="center">��<a href="Admin_ArticleModify.asp?ArticleID=<%=ArticleID%>">�޸ı���</a>��&nbsp;��<a href="<%if Action="Add1" then%>Admin_ArticleAdd1.asp<%else%>Admin_ArticleAdd2.asp<%end if%>">�����������</a>��&nbsp;��<a href="Admin_ArticleManage.asp">���¹���</a>��&nbsp;��<a href="Admin_ArticleShow.asp?ArticleID=<%=ArticleID%>">Ԥ����������</a>��</td>
  </tr>
</table>
</body>
</html>
<%
	session("ClassID_Article")=ClassID
	session("SpecialID_Article")=SpecialID
	session("Key")=trim(request("Key"))
	session("Author")=Author
	session("AuthorName")=AuthorName
	session("AuthorEmail")=AuthorEmail
	session("CopyFrom")=CopyFrom
	session("CopyFromName")=CopyFromName
	session("CopyFromUrl")=CopyFromUrl
	session("PaginationType")=PaginationType
	session("ReadLevel")=ReadLevel
	session("ReadPoint")=ReadPoint
	session("SkinID")=SkinID
	session("LayoutID")=LayoutID
end sub


'==================================================
'��������ReplaceRemoteUrl
'��  �ã��滻�ַ����е�Զ���ļ�Ϊ�����ļ�������Զ���ļ�
'��  ����strContent ------ Ҫ�滻���ַ���
'==================================================
function ReplaceRemoteUrl(strContent)
	if IsObjInstalled("Microsoft.XMLHTTP")=False or EnableSaveRemote="No" then
		ReplaceRemoteUrl=strContent
		exit function
	end if
			
	dim re,RemoteFile,RemoteFileurl,SaveFilePath,SaveFileName,SaveFileType,arrSaveFileName,ranNum
	SaveFilePath = "UploadFiles"			'�ļ�����ı���·��
	if right(SaveFilePath,1)<>"/" then SaveFilePath=SaveFilePath&"/"
	Set re=new RegExp
	re.IgnoreCase =true
	re.Global=True
	re.Pattern = "((http|https|ftp|rtsp|mms):(\/\/|\\\\){1}((\w)+[.]){1,}(net|com|cn|org|cc|tv|[0-9]{1,3})(\S*\/)((\S)+[.]{1}(gif|jpg|png|bmp)))"
	Set RemoteFile = re.Execute(strContent)
	For Each RemoteFileurl in RemoteFile
		arrSaveFileName = split(RemoteFileurl,".")
		SaveFileType=arrSaveFileName(ubound(arrSaveFileName))
		ranNum=int(900*rnd)+100
		SaveFileName = SaveFilePath&year(now)&month(now)&day(now)&hour(now)&minute(now)&second(now)&ranNum&"."&SaveFileType	
		call SaveRemoteFile(SaveFileName,RemoteFileurl)
		strContent=Replace(strContent,RemoteFileurl,SaveFileName)
		if UploadFiles="" then
			UploadFiles=SaveFileName
		else
			UploadFiles=UploadFiles & "|" & SaveFileName
		end if
	Next
	ReplaceRemoteUrl=strContent
end function



'==================================================
'��������SaveRemoteFile
'��  �ã�����Զ�̵��ļ�������
'��  ����LocalFileName ------ �����ļ���
'		 RemoteFileUrl ------ Զ���ļ�URL
'==================================================
sub SaveRemoteFile(LocalFileName,RemoteFileUrl)
	dim Ads,Retrieval,GetRemoteData
	Set Retrieval = Server.CreateObject("Microsoft.XMLHTTP")
	With Retrieval
		.Open "Get", RemoteFileUrl, False, "", ""
		.Send
		GetRemoteData = .ResponseBody
	End With
	Set Retrieval = Nothing
	Set Ads = Server.CreateObject("Adodb.Stream")
	With Ads
		.Type = 1
		.Open
		.Write GetRemoteData
		.SaveToFile server.MapPath(LocalFileName),2
		.Cancel()
		.Close()
	End With
	Set Ads=nothing
end sub

%>