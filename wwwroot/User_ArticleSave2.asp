<%@language=vbscript codepage=936 %>
<%
option explicit
response.buffer=true	
%>
<!--#include file="inc/conn.asp"-->
<!--#include file="inc/config.asp"-->
<!--#include file="inc/Conn_User.asp"-->
<!--#include file="inc/ubbcode.asp"-->
<!--#include file="inc/function.asp"-->
<!--#include file="inc/admin_code_article.asp"-->
<%
if CheckUserLogined()=False then
	response.Redirect "User_Login.asp"
end if

dim Action,rs,sql,ErrMsg,FoundErr,ObjInstalled
dim ArticleID,ClassID,SpecialID,Title,Content,key,Author,CopyFrom,UpdateTime,Editor
dim IncludePic,DefaultPicUrl,UploadFiles,Passed,OnTop,Hot,Elite,arrUploadFiles
dim TitleFontColor,TitleFontType,AuthorName,AuthorEmail,CopyFromName,CopyFromUrl,SkinID,LayoutID,PaginationType,MaxCharPerPage
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
Editor=trim(Request.Cookies("asp163")("UserName"))
PaginationType=trim(request.form("PaginationType"))
MaxCharPerPage=trim(request.form("MaxCharPerPage"))

dim trs
set trs=conn.execute("select SkinID from Skin where IsDefault=True")
SkinID=trs(0)
set trs=conn.execute("select LayoutID from Layout where IsDefault=True and LayoutType=3")
LayoutID=trs(0)

call SaveArticle()

if founderr=true then
	call WriteErrMsg()
else
	call SaveSuccess()
end if
call CloseConn()


sub SaveArticle()
	if ClassID="" then
		founderr=true
		errmsg=errmsg & "<br><li>δָ������������Ŀ����ָ������Ŀ����������Ŀ</li>"
	else
		ClassID=CLng(ClassID)
		if ClassID=0 then
			FoundErr=True
			ErrMsg=ErrMsg & "<br><li>����������Ŀ����ָ��Ϊ�ⲿ��Ŀ</li>"
		elseif ClassID=-1 then
			FoundErr=True
			ErrMsg=ErrMsg & "<br><li>��û������ָ������Ŀ�������µ�Ȩ��</li>"
		else
			set tClass=conn.execute("select ClassName,Depth,ParentPath,Child,LinkUrl,AddPurview From ArticleClass where ClassID=" & ClassID)
			if tClass.bof and tClass.eof then
				founderr=True
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
				if Clng(tClass(5))<Clng(request.Cookies("asp163")("UserLevel")) then
					FoundErr=True
					ErrMsg=ErrMsg & "<br><li>��û������ָ������Ŀ�������µ�Ȩ��</li>"
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
	
	set rs=server.createobject("adodb.recordset")
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
				call SaveData()
				rs.update
				Passed=rs("Passed")
				rs.close
			end if
		end if
	set rs=nothing
end sub

sub SaveData()
	rs("Title")=Title
	rs("TitleFontColor")=TitleFontColor
	rs("TitleFontType")=TitleFontType
	rs("Content")=Content
	rs("Key")=Key
	rs("Author")=Author
	rs("CopyFrom")=CopyFrom
	rs("PaginationType")=PaginationType
	rs("MaxCharPerPage")=MaxCharPerPage
	if IncludePic="yes" then
		rs("IncludePic")=True
	else
		rs("IncludePic")=False
	end if
	rs("UpdateTime")=UpdateTime
	if EnableArticleCheck="No" then
		rs("Passed")=True
	else
		rs("Passed")=False
	end if

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
	rs("nopass")=False
end sub
	
sub SaveSuccess()
%>
<html>
<head>
<title></title>
<link rel="stylesheet" type="text/css" href="Admin_Style.css">
</head>
<body leftmargin="2" topmargin="0" marginwidth="0" marginheight="0">
<br><br>
<table class="border" align=center width="400" border="0" cellpadding="0" cellspacing="0" bordercolor="#999999">
  <tr align=center> 
    <td  height="22" align="center" class="title"><b> 
      �����ύ���³ɹ�</b></td>
  </tr>
<%if Passed=False then%>
  <tr class="tdbg"> 
    <td height="60"><font color="#0000FF">ע�⣺</font><br>
      &nbsp;&nbsp;&nbsp; ��������Ѿ��ٴ��ύ������Ա��ˣ���</td>
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
    <td height="30" align="center">��<a href="User_ArticleModify.asp?ArticleID=<%=ArticleID%>">�޸ı���</a>��&nbsp;��<a href="User_ArticleAdd.asp">�����������</a>��&nbsp;��<a href="User_ArticleManage.asp">���¹���</a>��&nbsp;��<a href="User_ArticleShow.asp?ArticleID=<%=ArticleID%>">Ԥ����������</a>��</td>
  </tr>
</table>
</body>
</html>
<%
	session("ClassID")=ClassID
	session("SpecialID")=SpecialID
	session("Key")=trim(request("Key"))
	session("Author")=Author
	session("AuthorName")=AuthorName
	session("AuthorEmail")=AuthorEmail
	session("CopyFrom")=CopyFrom
	session("CopyFromName")=CopyFromName
	session("CopyFromUrl")=CopyFromUrl
end sub
%>