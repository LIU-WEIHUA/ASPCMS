<!--#include file="Inc/syscode_Article.asp"-->
<%
const ChannelID=2
Const ShowRunTime="Yes"
SkinID=0
PageTitle="�û����ŷ���"
dim membername
membername=Trim(Request.Cookies("asp163")("UserName"))
%>
<html>
<head>
<title><%=strPageTitle & " >> " & PageTitle %></title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<!--#include file="inc/Skin_CSS.asp"-->
<style type="text/css">
.sms_border
{
background:#6687BA;
}
</style>
<%call MenuJS()%>

</head>
<body <%=Body_Label%> onmousemove='HideMenu()'>
<%

if CheckUserLogined()=False then
  	errmsg=errmsg+"<br><br>"+"<li>����û�е�¼��<li>��û��ʹ�ô��������Ȩ�ޡ�"
	founderr=true
end if

if founderr then
	strErr=strErr & "<table cellpadding=2 cellspacing=1 border=0 width=400 class='border' align=center>" & vbcrlf
	strErr=strErr & "  <tr align='center' class='title'><td height='22'><strong>������Ϣ</strong></td></tr>" & vbcrlf
	strErr=strErr & "  <tr class='tdbg'><td height='100' valign='top'><b>��������Ŀ���ԭ��</b>" & errmsg &"</td></tr>" & vbcrlf
	strErr=strErr & "  <tr align='center' class='tdbg'><td><a href='javascript:history.go(-1)'>&lt;&lt; ������һҳ</a></td></tr>" & vbcrlf
	strErr=strErr & "</table><br>" & vbcrlf
	response.write strErr
else
	call mainnav()
	select case request("action")
	case "info"
		call info()
	case "addF"
		call addF()
	case "saveF"
		call saveF()
	case "ɾ��"
		call DelFriend()
	case "��պ���"
		call AllDelFriend()
	case else
		call info()
	end select
	if founderr then call WriteErrMsg()
end if
if not founderr then 
call bottom()
end if
sub info()
%>
<br><table width="770" cellpadding=3 cellspacing=1 align=center class=sms_border>
<form action="sms_friend.asp" method=post name=inbox>
            <tr>
                <td class=txt_css valign=middle width="25%">����</td>
                <td class=txt_css valign=middle width="25%">�ʼ�</td>
                <td class=txt_css valign=middle width="25%">��ҳ</td>
                <td class=txt_css valign=middle width="10%">QQ</td>
                <td class=txt_css valign=middle width="10%">������</td>
                <td class=txt_css valign=middle width="5%">����</td>
            </tr>
<%
	set rs=server.createobject("adodb.recordset")
	sql="select F.*,U."&db_User_Email&",U."&db_User_Homepage&",U."&db_User_QQ&" from Friend F inner join "&db_User_Table&" U on F.F_Friend=U."&db_User_Name&" where F.F_username='"&trim(membername)&"' order by F.f_addtime desc"
	rs.open sql,Conn_User,1,1
	if rs.eof and rs.bof then
%>
                <tr>
                <td class=tdbg align=center valign=middle colspan=6>���ĺ����б���û���κ����ݡ�</td>
                </tr>
		
<%else%>
<%do while not rs.eof%>
                <tr>
                    <td align=center valign=middle class=tdbg><a href="dispuser.asp?name=<%=htmlencode(rs("F_friend"))%>" target=_blank><%=htmlencode(rs("F_friend"))%></a></td>
                    <td align=center valign=middle class=tdbg><a href="mailto:<%=htmlencode(rs("UserEmail"))%>"><%=htmlencode(rs("UserEmail"))%></a></td>
                    <td align=center class=tdbg><a href="<%=htmlencode(rs("homepage"))%>" target=_blank><%=htmlencode(rs("homepage"))%></a></td>
                    <td align=center class=tdbg><%=htmlencode(rs("Oicq"))%></td>
                    <td align=center class=tdbg><a href="JavaScript:openScript2('sms_main.asp?action=new&touser=<%=htmlencode(rs("f_friend"))%>',500,400)">����</a></td>
                <td align=center class=tdbg><input type=checkbox name=id value=<%=rs("f_id")%>></td>
                </tr>
<%
	rs.movenext
	loop
	end if
	rs.close
	set rs=nothing
%>
                
        <tr> 
          <td align=right valign=middle colspan=6 class=tdbg><input type=checkbox name=chkall value=on onClick="CheckAll(this.form)">ѡ��������ʾ��¼&nbsp;<input type=button name=action onClick="location.href='sms_friend.asp?action=addF'" value="��Ӻ���">&nbsp;<input type=submit name=action onClick="{if(confirm('ȷ��ɾ��ѡ���ļ�¼��?')){this.document.inbox.submit();return true;}return false;}" value="ɾ��">&nbsp;<input type=submit name=action onClick="{if(confirm('ȷ��������еļ�¼��?')){this.document.inbox.submit();return true;}return false;}" value="��պ���"></td>
		</tr>
		</form>
		</table><BR>
<%
end sub

sub delFriend()
dim delid
delid=replace(request.form("id"),"'","")
if delid="" or isnull(delid) then
Errmsg=Errmsg+"<li>"+"��ѡ����ز�����"
founderr=true
exit sub
else
	Conn_User.execute("delete from Friend where F_username='"&trim(membername)&"' and F_id in ("&delid&")")
	sucmsg=sucmsg+"<br>"+"<li><b>���Ѿ�ɾ��ѡ���ĺ��Ѽ�¼��"
	call sms_suc()
end if
end sub
sub AllDelFriend()
	Conn_User.execute("delete from Friend where F_username='"&trim(membername)&"'")
	sucmsg=sucmsg+"<br>"+"<li><b>���Ѿ�ɾ�������к����б�"
	call sms_suc()
end sub

sub addF()
%>
<br>
<%call userlist()%>
<table width="760" cellpadding=3 cellspacing=1 align=center class=sms_border>
<form action="sms_friend.asp" method=post name=messager>
          <tr> 
            <td class=txt_css colspan=2 align=center> 
              <input type=hidden name="action" value="saveF">
              �������--����������������Ϣ</td>
          </tr>
          <tr height=50> 
            <td class=tdbg valign=middle width=70><b>���ѣ�</b></td>
            <td class=tdbg valign=middle>
              <input type=text name="touser" size=50 value="<%=request("myFriend")%>">
			  &nbsp;ʹ�ö��ţ�,���ֿ������5λ�û�
            </td>
          </tr>
          <tr> 
            <td valign=middle colspan=2 align=center class=tdbg> 
              <input type=Submit value="����" name=Submit>
              &nbsp; 
              <input type="reset" name="Clear" value="���">
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</form>
<%
end sub

sub saveF()
dim incept,i
if request("touser")="" then
	errmsg=errmsg+"<br>"+"<li>��������д���Ͷ����˰ɡ�"
	founderr=true
	exit sub
else
	incept=checkStr(request("touser"))
	incept=split(incept,",")
end if

for i=0 to ubound(incept)
set rs=server.createobject("adodb.recordset")
sql="select "&db_User_Name&" from "&db_User_Table&" where "&db_User_Name&"='"&incept(i)&"'"
set rs=Conn_User.execute(sql)
if rs.eof and rs.bof then
	set rs=nothing
	sql="select username from admin where username='"&replace(incept(i),"'","")&"'"
        set rs=Conn.execute(sql)
        if rs.eof and rs.bof then
	errmsg=errmsg+"<br>"+"<li>ϵͳû������û�������δ�ɹ���"
	founderr=true
	exit sub
	end if
end if
set rs=nothing

if membername=trim(incept(i)) then
	errmsg=errmsg+"<br>"+"<li>���ܰ��������Ϊ���ѡ�"
	founderr=true
	exit sub
end if

sql="select F_friend from friend where F_username='"&membername&"' and  F_friend='"&incept(i)&"'"
set rs=Conn_User.execute(sql)
if rs.eof and rs.bof then
	sql="insert into friend (F_username,F_friend,F_addtime) values ('"&membername&"','"&trim(incept(i))&"',Now())"
	Conn_User.execute(sql)
end if
if i>4 then
	errmsg=errmsg+"<br>"+"<li>ÿ�����ֻ�����5λ�û�����������5λ�Ժ����������д��"
	founderr=true
	exit sub
	exit for
end if
next

sucmsg=sucmsg+"<br>"+"<li><b>��ϲ����������ӳɹ���"
call sms_suc()
end sub

sub userlist()
response.write "<table class=border align=center cellpadding=2 cellspacing=1 border=0 width=""760"" style=""word-break:break-all;""><tr>��վ����Ա��<br>"
dim admin_face
sql="select username from admin order by ID"
set rs=Conn.execute(sql)
i=0
do while not rs.eof
admin_face="<img src=""images/admin_face.gif"" width=24 height=30>"
if membername=rs(0) then
	response.write "<td width=""14%"">" & admin_face&"&nbsp;<a href=sms_friend.asp?action=saveF&touser="&rs(0)&" title=""��վ����Ա""><font color=""#0000ff"">"&rs(0)&"</font></a></td>"
else
	response.write "<td width=""14%"">" & admin_face&"&nbsp;<a href=sms_friend.asp?action=saveF&touser="&rs(0)&" title=""��վ����Ա"">"&rs(0)&"</a></td>"
end if

if i=6 then response.write "</tr><tr>"
if i>6 then 
	i=1
else
	i=i+1
end if
rs.movenext
loop
response.write "</tr></TABLE><br>"
set rs=nothing

response.write "<table class=border align=center cellpadding=2 cellspacing=1 border=0 width=""760"" style=""word-break:break-all;""><tr>��ͨ�û���<br>"
dim user_face,user_info,sex,i
sql="select "&db_User_Name&","&db_User_Sex&","&db_User_QQ&","&db_User_Email&" from "&db_User_Table&" order by "&db_User_ID&""
set rs=Conn_User.execute(sql)
i=0
do while not rs.eof
if rs(1)=1 then
	sex="��"
else
	sex="Ů"
end if
user_info="�Ա�"& sex & vbcrlf & "QQ��"& rs(2) & vbcrlf &"Email��"& rs(3)
user_face="<img src=""images/user_face.gif"" width=12 height=11>"
if membername=rs(0) then
	response.write "<td width=""14%"">" & user_face&"&nbsp;<a href=sms_friend.asp?action=saveF&touser="&rs(0)&" title="""& user_info &"""><font color=""#0000ff"">"&rs(0)&"</font></a></td>"
else
	response.write "<td width=""14%"">" & user_face&"&nbsp;<a href=sms_friend.asp?action=saveF&touser="&rs(0)&" title="""& user_info &""">"&rs(0)&"</a></td>"
end if

if i=6 then response.write "</tr><tr>"
if i>6 then 
	i=1
else
	i=i+1
end if
rs.movenext
loop
response.write "</tr></TABLE><br>"
set rs=nothing
end sub
%>