<%@language=vbscript codepage=936 %>
<%
option explicit
response.buffer=true	
Const PurviewLevel=2
%>
<!--#include file="inc/conn.asp"-->
<!--#include file="inc/conn_user.asp"-->
<!--#include file="Admin_ChkPurview.asp"-->
<!--#include file="inc/config.asp"-->

<html>
<head>
<title>����Ϣ����</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="Admin_Style.css" rel="stylesheet" type="text/css">
</head>
<%

dim Action,FoundErr,ErrMsg,rs,sql,smsinfo
Action=Trim(Request("Action"))

if Request("action")="add" then
	call savemsg()
elseif request("action")="delall" then
	call delall()
elseif request("action")="delchk" then
	call delchk()
else
	call sendmsg()
end if

if smsinfo<>"" then call info()
Conn_User.close
set Conn_User=nothing
%>
</table>
</body>
</html>

<%
sub savemsg()
	dim sendtime,sender
	sendtime=Now()
	sender=SiteName
	set rs = server.CreateObject ("adodb.recordset")

    sql = "select username from [user] order by userid desc"
    rs.Open sql,Conn_User,1,1
    do while not rs.EOF 
		sql="insert into message(incept,sender,title,content,sendtime,flag,issend) values('"&rs(0)&"','"&sender&"','"&TRim(Request("title"))&"','"&Trim(Request("message"))&"',Now(),0,1)"
		Conn_User.Execute(sql)
		rs.MoveNext 
	Loop
	rs.Close
	set rs=nothing
	smsinfo=smsinfo+"<br>"+"�����ɹ����������Ĳ�����"
end sub

sub sendmsg()
%>
<table width="95%" border="0" cellspacing="1" cellpadding="3"  align=center class="border">
  <tr align="center"> 
    <td colspan="2" class="title" height="22"><b> �� �� Ϣ �� �� </b></td>
  </tr>
  <form action="admin_message.asp?action=add" method=post>
    <tr> 
      <td width="22%" class=tdbg>��Ϣ����</td>
      <td width="78%" class=tdbg> 
        <input type="text" name="title" size="70">
      </td>
    </tr>
    <tr> 
      <td width="22%" class=tdbg>���շ�ѡ��</td>
      <td width="78%" class=tdbg> 
        <select name=stype size=1>
          <option value="1">�����û�</option>
        </select>
      </td>
    </tr>
    <tr> 
      <td width="22%" height="20" valign="top" class=tdbg> 
        <p>��Ϣ����</p>
      </td>
      <td width="78%" height="20" class=tdbg> 
        <textarea name="message" cols="80" rows="10"></textarea>
      </td>
    </tr>
    <tr> 
      <td width="22%" height="23" valign="top" align="center" class=tdbg> 
        <div align="left"> </div>
      </td>
      <td width="78%" height="23" class=tdbg> 
        <div align="center"> 
          <input type="submit" name="Submit" value="������Ϣ">
          <input type="reset" name="Submit2" value="������д">
        </div>
      </td>
    </tr>
  </form>
  <tr align="center"> 
    <td colspan="2" class="title" height="22"><b>�� �� ɾ �� </b></td>
  </tr>
  <form action="admin_message.asp?action=del" method=post>
  </form>
  <form action="admin_message.asp?action=delall" method=post>
    <tr> 
      <td colspan="2" class=tdbg> ����ɾ���û�ָ�������ڶ���Ϣ��Ĭ��Ϊɾ���Ѷ���Ϣ����<br>
        <select name="delDate" size=1>
          <option value=7>һ������ǰ</option>
          <option value=30>һ����ǰ</option>
          <option value=60>������ǰ</option>
          <option value=180>����ǰ</option>
          <option value="all">������Ϣ</option>
        </select>
        &nbsp; 
        <input type="checkbox" name="isread" value="yes">
        ����δ����Ϣ 
        <input type="submit" name="Submit" value="�� ��">
      </td>
    </tr>
  </form>
  <form action="admin_message.asp?action=delchk" method=post>
    <tr> 
      <td colspan="2" class=tdbg> ����ɾ������ĳ�ؼ��ֶ��ţ�ע�⣺��������ɾ�������Ѷ���δ����Ϣ����<br>
        �ؼ��֣� 
        <input type="text" name="keyword" size=30>
        &nbsp;�� 
        <select name="selaction" size=1>
          <option value=1>������</option>
          <option value=2>������</option>
        </select>
        &nbsp; 
        <input type="submit" name="Submit" value="�� ��">
      </td>
    </tr>
  </form>
<%
end sub

sub del()
	if request("username")="" then
		smsinfo=smsinfo+"<br>"+"������Ҫ����ɾ�����û�����"
		exit sub
	end if
	sql="delete from message where sender='"&request("username")&"'"
	Conn_User.Execute(sql)
	smsinfo=smsinfo+"<br>"+"�����ɹ����������Ĳ�����"
end sub

sub delall()
	dim selflag
	if request("isread")="yes" then
	selflag=""
	else
	selflag=" and flag=1"
	end if
	select case request("delDate")
	case "all"
	sql="delete from message where id>0 "&selflag
	case 7
	sql="delete from message where datediff('d',sendtime,Now())>7 "&selflag
	case 30
	sql="delete from message where datediff('d',sendtime,Now())>30 "&selflag
	case 60
	sql="delete from message where datediff('d',sendtime,Now())>60 "&selflag
	case 180
	sql="delete from message where datediff('d',sendtime,Now())>180 "&selflag
	end select
	Conn_User.Execute(sql)
	smsinfo=smsinfo+"<br>"+"�����ɹ����������Ĳ�����"
end sub

sub delchk()
	if request.form("keyword")="" then
	smsinfo="������ؼ��֣�"
	exit sub
	end if
	if request.form("selaction")=1 then
	Conn_User.execute("delete from message where title like '%"&replace(request.form("keyword"),"'","")&"%'")
	smsinfo="�����ɹ����������Ĳ�����"
	elseif request.form("selaction")=2 then
	Conn_User.execute("delete from message where content like '%"&replace(request.form("keyword"),"'","")&"%'")
	smsinfo="�����ɹ����������Ĳ�����"
	else
	smsinfo="δָ����ز�����"
	exit sub
	end if
end sub

sub info()
	dim strErr
	strErr=strErr & "<br><table cellpadding=2 cellspacing=1 border=0 width=460 class='border' align=center>" & vbcrlf
	strErr=strErr & "  <tr align='center' class='title'><td height='22'><strong>�û����Ų����ɹ���Ϣ</strong></td></tr>" & vbcrlf
	strErr=strErr & "  <tr class='tdbg'><td height='100' valign='top'><b>�����ɹ���</b><br>" & smsinfo &"</td></tr>" & vbcrlf
	strErr=strErr & "  <tr align='center' class='tdbg'><td><a href='javascript:history.go(-1)'>&lt;&lt; ������һҳ</a></td></tr>" & vbcrlf
	strErr=strErr & "</table><br>" & vbcrlf
	response.write strErr
end sub

%>