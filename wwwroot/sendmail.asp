<!--#include file="inc/conn.asp"-->
<!--#include file="inc/Conn_User.asp"-->
<!--#include file="inc/config.asp"-->
<!--#include file="inc/function.asp"-->
<%
dim rs,sql
dim Action,FoundErr,ErrMsg
dim Subject,mailbody
dim ArticleID
dim MailToName,MailToAddress,FromName,MailFrom
dim ObjInstalled
ObjInstalled=IsObjInstalled("JMail.SMTPMail")
ArticleID=request("ArticleID")
Action=trim(request("Action"))
if ArticleID="" then
	foundErr = true
	ErrMsg=ErrMsg & "<br><li>��ָ���������</li>"
else
	ArticleID=Clng(ArticleID)
end if
if CheckUserLogined()=False then 
	FoundErr=True
	ErrMsg=ErrMsg & "<br>&nbsp;&nbsp;&nbsp;&nbsp;�㻹ûע�᣿����û�е�¼��ֻ�б�վ��ע���û�����ʹ�á����ߺ��ѡ����ܣ�<br><br>"
	ErrMsg=ErrMsg & "&nbsp;&nbsp;&nbsp;&nbsp;����㻹ûע�ᣬ��Ͻ�<a href='User_Reg.asp'><font color=red>���ע��</font></a>�ɣ�<br><br>"
	ErrMsg=ErrMsg & "&nbsp;&nbsp;&nbsp;&nbsp;������Ѿ�ע�ᵫ��û��¼����Ͻ�<a href='User_Login.asp'><font color=red>��˵�¼</font></a>�ɣ�<br><br>"
end if

if foundErr<>True then
	sql="Select Title,Content,UpdateTime,Author from article where articleid="&ArticleId&""
	set rs=server.createobject("adodb.recordset")
	rs.open sql,conn,1,1
	if rs.bof and rs.eof then
		FoundErr=True
		ErrMsg=ErrMsg & "�Ҳ�������"
	else
		if Action="MailToFriend" then
			call MailToFriend()
		else
			call main()
		end if
	end if
	rs.close
	set rs=nothing
end if
if FoundErr=true then
	call WriteErrMsg()
end if
call CloseConn()

sub main()
%>
<HTML>
<HEAD>
<TITLE>���ߺ���</TITLE>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>
<link href="STYLE.CSS" rel="stylesheet" type="text/css">
</head>
<body>
<form action="sendmail.asp" method="post">
  <table cellpadding=2 cellspacing=1 border=0 width=400 class="border" align=center>
    <tr> 
      <td height="22" colspan=2 align=center valign=middle class="title"> <b>�����ĸ��ߺ���</b></td>
    </tr>
    <tr class="tdbg"> 
      <td width="120" align="right"><strong>������������</strong></td>
      <td><input name="MailtoName" type="text" id="MailtoName" size="40" maxlength="20"> 
        <font color="#FF0000">*</font></td>
    </tr>
    <tr class="tdbg"> 
      <td width="120" align="right"><strong>������Email��ַ��</strong></td>
      <td><input name="MailToAddress" type=text id="MailToAddress" size="40" maxlength="100"> 
        <font color="#FF0000">*</font></td>
    </tr>
    <tr class="tdbg"> 
      <td width="120" height="60" align="right"><strong>������Ϣ��</strong></td>
      <td height="60">���±��⣺<%= rs("Title") %><br>
        �������ߣ�<%= rs("Author") %> <br>
        ����ʱ�䣺<%= rs("UpdateTime") %> </td>
    </tr>
    <tr class="tdbg"> 
      <td colspan=2 align=center><input name="Action" type="hidden" id="Action" value="MailToFriend"> 
        <input name="ArticleID" type="hidden" id="ArticleID" value="<%=request("ArticleID")%>"> 
        <input type=submit value=" �� �� " name="Submit" <% If ObjInstalled=false Then response.write "disabled" end if%>> 
      </td>
    </tr>
    <%
If ObjInstalled=false Then
	Response.Write "<tr class='tdbg'><td height='40' colspan='2'><b><font color=red>�Բ�����Ϊ��������֧�� JMail���! ���Բ���ʹ�ñ����ܡ�</font></b></td></tr>"
End If
%>
  </table>
</form>
</BODY>
</HTML>
<%
end sub

sub MailToFriend()
	MailToName=trim(request.form("MailToName"))
	MailToAddress=trim(request.form("MailToAddress"))
	if MailToName="" then
		errmsg=errmsg & "<br><li>����������Ϊ�գ�</li>"
		founderr=true
	end if
	if IsValidEmail(MailToAddress)=false then
   		errmsg=errmsg & "<br><li>�����˵�Email��ַ�д���</li>"
   		founderr=true
	end if
				
	if founderr then
		exit sub
	end if
	
	call GetMailInfo()
	
	FromName=Request.Cookies("asp163")("UserName")
	dim trs
	set trs=conn_user.execute("select " & db_User_Name & "," & db_User_Email & " from " & db_User_Table & " where " & db_User_Name & "='" & FromName & "'")
	MailFrom=trs(1)
	set trs=nothing
	
	ErrMsg=SendMail(MailtoAddress,MailtoName,Subject,MailBody,FromName,MailFrom,3)
	if ErrMsg="" then
		call WriteSuccessMsg("�Ѿ��ɹ��������·��͸���ĺ��ѣ�")
	else
		FoundErr=True
	end if
end sub

sub GetMailInfo()
	Subject="��������" & Addressee & "��" & SiteName & "������������������"

	mailbody=mailbody &"<style>A:visited {	TEXT-DECORATION: none	}"
	mailbody=mailbody &"A:active  {	TEXT-DECORATION: none	}"
	mailbody=mailbody &"A:hover   {	TEXT-DECORATION: underline overline	}"
	mailbody=mailbody &"A:link 	  {	text-decoration: none;}"
	mailbody=mailbody &"A:visited {	text-decoration: none;}"
	mailbody=mailbody &"A:active  {	TEXT-DECORATION: none;}"
	mailbody=mailbody &"A:hover   {	TEXT-DECORATION: underline overline}"
	mailbody=mailbody &"BODY   {	FONT-FAMILY: ����; FONT-SIZE: 9pt;}"
	mailbody=mailbody &"TD	   {	FONT-FAMILY: ����; FONT-SIZE: 9pt	}</style>"

	mailbody=mailbody &"<TABLE border=0 width='95%' align=center><TBODY><TR>"
	mailbody=mailbody &"<TD valign=middle align=top>"
	mailbody=mailbody &"--&nbsp;&nbsp;���ߣ�"&rs("Author")&"<br>"
	mailbody=mailbody &"--&nbsp;&nbsp;����ʱ�䣺"&rs("UpdateTime")&"<br><br>"
	mailbody=mailbody &"--&nbsp;&nbsp;"&rs("title")&"<br>"
	mailbody=mailbody &""&rs("content")&""
	mailbody=mailbody &"</TD></TR></TBODY></TABLE>"

	mailbody=mailbody &"<center><a href='" & SiteUrl & "'>" & SiteName & "</a>"
	
end sub

%>