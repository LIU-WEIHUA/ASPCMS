<%@language=vbscript codepage=936 %>
<!--#include file="inc/Conn_User.asp"-->
<!--#include file="inc/Conn.asp"-->
<!--#include file="inc/config.asp"-->
<!--#include file="inc/md5.asp"-->
<%
dim sql,rs
dim username,password,CookieDate,CheckCode
username=replace(trim(request("username")),"'","")
password=replace(trim(Request("password")),"'","")
CheckCode=replace(trim(Request("CheckCode")),"'","")
CookieDate=trim(request("CookieDate"))
dim ComeUrl
ComeUrl=trim(request("ComeUrl"))
if ComeUrl="" then
	ComeUrl=Request.ServerVariables("HTTP_REFERER")
	if ComeUrl="" then ComeUrl="index.asp" end if
end if
if UserName="" then
	FoundErr=True
	ErrMsg=ErrMsg & "<br><li>�û�������Ϊ�գ�</li>"
end if
if Password="" then
	FoundErr=True
	ErrMsg=ErrMsg & "<br><li>���벻��Ϊ�գ�</li>"
end if
'��֤�벻����XP SP3���Ժ����ϵͳ
'if CheckCode="" then
'	FoundErr=True
'	ErrMsg=ErrMsg & "<br><li>��֤�벻��Ϊ�գ�</li>"
'end if
'if session("CheckCode")="" then
'	FoundErr=True
'	ErrMsg=ErrMsg & "<br><li>���¼ʱ������������·��ص�¼ҳ����е�¼��</li>"
'end if
'if CheckCode<>CStr(session("CheckCode")) then
'	FoundErr=True
'	ErrMsg=ErrMsg & "<br><li>�������ȷ�����ϵͳ�����Ĳ�һ�£����������롣</li>"
'end if

'��֤�Ƿ����Ա'
password=md5(password)
set rs=server.createobject("adodb.recordset")
sql="select * from admin where password='"&password&"' and username='"&username&"'"
rs.open sql,conn,1,3
if rs.bof and rs.eof then '������ǹ���Ա�������ͨ�û���¼����
 rs.close
 set rs=nothing
 call CloseConn()

    if CookieDate="" then 
	CookieDate=0
    else
	CookieDate=Clng(CookieDate)
    end if
    if FoundErr<>True then
	set rs=server.createobject("adodb.recordset")
	sql="select * from " & db_User_Table & " where " & db_User_Name & "='" & username & "' and " & db_User_Password & "='" & password &"'"
	rs.open sql,Conn_User,1,3
	if rs.bof and rs.eof then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>�û�����������󣡣���</li>"
	else
		if password<>rs(db_User_Password) then
			FoundErr=True
			ErrMsg=ErrMsg & "<br><li>�û�����������󣡣���</li>"
		else
			if rs(db_User_UserLevel)>999 then
				FoundErr=True
				ErrMsg=ErrMsg & "<br><li>�Բ�������δͨ����֤�����ܵ�¼��</li>"
			else
				rs(db_User_LastLoginIP)=Request.ServerVariables("REMOTE_ADDR")
				rs(db_User_LastLoginTime)=now()
				rs(db_User_LoginTimes)=rs(db_User_LoginTimes)+1
				rs.update
				call SaveCookie_asp163()
				rs.close
				set rs=nothing
				call CloseConn_User()
				response.redirect ComeUrl
			end if
		end if
      end if
	rs.close
	set rs=nothing
  end if

else '����ǹ���Ա��������Ա��¼����.
		if FoundErr<>True then
                if password<>rs("password") then
			FoundErr=True
			ErrMsg=ErrMsg & "<br><li>�㲻�ǹ���Ա���û���������󣡣���</li>"
		else
			rs("LastLoginIP")=Request.ServerVariables("REMOTE_ADDR")
			rs("LastLoginTime")=now()
			rs("LoginTimes")=rs("LoginTimes")+1
			rs.update
			session.Timeout=SessionTimeout
			session("AdminName")=rs("username")
			Response.Cookies("asp163")("UserLevel")=5
			Response.Cookies("asp163")("UserName")=rs("username")
			rs.close
			set rs=nothing
			call CloseConn()
			response.redirect "index.asp"
		end if
			rs.close
	        	set rs=nothing
		end if
			call CloseConn()
		
end if

if FoundErr=True then
	call WriteErrMsg()
end if
call CloseConn_User()

sub SaveCookie_asp163()
	Response.Cookies("asp163")("UserName")=username
	Response.Cookies("asp163")("Password") = PassWord
	Response.Cookies("asp163")("UserLevel")=rs("UserLevel")
	if UserTableType="Dvbbs6.0" then
		Response.Cookies("aspsky")("username") = username
		Response.Cookies("aspsky")("password") = PassWord
		Response.Cookies("aspsky")("userclass") = rs("userclass")
		Response.Cookies("aspsky")("userid") = rs("userid")
		Response.Cookies("aspsky")("userhidden") = 2
		Response.Cookies("aspsky")("usercookies") = CookieDate
	elseif UserTableType="Dvbbs6.1" then
		Response.Cookies("aspsky")("username") = username
		Response.Cookies("aspsky")("password") = PassWord
		Response.Cookies("aspsky")("userclass") = rs("userclass")
		Response.Cookies("aspsky")("userid") = rs("userid")
		Response.Cookies("aspsky")("userhidden") = 2
		Response.Cookies("aspsky")("usercookies") = CookieDate
	end if
	Response.Cookies("asp163")("CookieDate") = CookieDate
	select case CookieDate
		case 0
			'not save
		case 1
		   	Response.Cookies("asp163").Expires=Date+1
		case 2
			Response.Cookies("asp163").Expires=Date+31
		case 3
			Response.Cookies("asp163").Expires=Date+365
	end select
end sub

'****************************************************
'��������WriteErrMsg
'��  �ã���ʾ������ʾ��Ϣ
'��  ������
'****************************************************
sub WriteErrMsg()
	dim strErr
	strErr=strErr & "<html><head><title>������Ϣ</title><meta http-equiv='Content-Type' content='text/html; charset=gb2312'>" & vbcrlf
	strErr=strErr & "<link href='style.css' rel='stylesheet' type='text/css'></head><body>" & vbcrlf
	strErr=strErr & "<table cellpadding=2 cellspacing=1 border=0 width=400 class='border' align=center>" & vbcrlf
	strErr=strErr & "  <tr align='center'><td height='22' class='title'><strong>������Ϣ</strong></td></tr>" & vbcrlf
	strErr=strErr & "  <tr><td height='100' class='tdbg' valign='top'><b>��������Ŀ���ԭ��</b><br>" & errmsg &"</td></tr>" & vbcrlf
	strErr=strErr & "  <tr align='center'><td class='tdbg'><a href=""User_Login.asp?ComeUrl=" & ComeUrl & """>&lt;&lt; ���ص�¼ҳ��</a></td></tr>" & vbcrlf
	strErr=strErr & "</table>" & vbcrlf
	strErr=strErr & "</body></html>" & vbcrlf
	response.write strErr
end sub
%>