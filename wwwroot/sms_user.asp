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
dim tablebody,strErr
dim boxName,smscount,smstype,readaction,turl
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
	call smsmain()
end if
call bottom()
%>

</body>
</html>

<%
sub smsmain()
smscount=1
select case request("action")
case "inbox"
	boxName="�ռ���"
	smstype="inbox"
	readaction="read"
	turl="readsms"
	sql="select * from message where incept='"&trim(membername)&"' and issend=1 and delR=0 order by flag,sendtime desc"
	call smsbox()
case "outbox"
	boxName="�ݸ���"
	smstype="outbox"
	readaction="edit"
	turl="sms"
	sql="select * from message where sender='"&trim(membername)&"' and issend=0 and delS=0 order by sendtime desc"
	call smsbox()
case "issend"
	boxName="�ѷ��͵���Ϣ"
	smstype="issend"
	readaction="outread"
	turl="readsms"
	sql="select * from message where sender='"&trim(membername)&"' and issend=1 and delS=0 order by sendtime desc"
	call smsbox()
case "recycle"
	boxName="������"
	smstype="recycle"
	readaction="read"
	turl="readsms"
	sql="select * from message where ((sender='"&trim(membername)&"' and delS=1) or (incept='"&trim(membername)&"' and delR=1)) and not delS=2 order by sendtime desc"
	call smsbox()
case else
	boxName="�ռ���"
	smstype="inbox"
	readaction="read"
	turl="readsms"
	sql="select * from message where incept='"&trim(membername)&"' and issend=1 and delR=0 order by flag,sendtime desc"
	call smsbox()
end select
end sub

sub smsbox()
dim newstyle
call mainnav()
%>
<br><table width="770" border="0" align="center" cellpadding="0" cellspacing="0" class="border2">
  <tr> 
    <td valign="top">
<table width="100%" border="0" align="center" cellpadding="3" cellspacing="1" class="sms_border">
<form action="sms_main.asp" method=post name=inbox>
<tr height='22'>
<td class=txt_css valign=middle width=30>�Ѷ�</td>
<td class=txt_css valign=middle width=100>
<%if smstype="inbox" or smstype="recycle" then response.write "������" else response.write "�ռ���"%>
</td>
<td class=txt_css valign=middle width=300>����</td>
<td class=txt_css valign=middle width=150>����</td>
<td class=txt_css valign=middle width=50>��С</td>
<td class=txt_css valign=middle width=30>����</td>
</tr>
<%
	set rs=server.createobject("adodb.recordset")
	rs.open sql,Conn_User,1,1
	if rs.eof and rs.bof then
%>
<tr>
<td class=tdbg align=center valign=middle colspan=6>����<%=boxname%>��û���κ����ݡ�</td>
</tr>
<%else%>
<%do while not rs.eof%>
<%
if rs("flag")=0 then
tablebody="tablebody2"
newstyle="font-weight:bold"
else
tablebody="tablebody1"
newstyle="font-weight:normal"
end if
%>
<tr>
<td class=tdbg align=center valign=middle>
<%
select case smstype
case "inbox"
	if rs("flag")=0 then
	response.write "<img src=""images/m_news.gif"">"
	else
	response.write "<img src=""images/m_olds.gif"">"
	end if
case "outbox"
	response.write "<img src=""images/m_issend_2.gif"">"
case "issend"
	response.write "<img src=""images/m_issend_1.gif"">"
case "recycle"
	if rs("flag")=0 then
	response.write "<img src=""images/m_news.gif"">"
	else
	response.write "<img src=""images/m_olds.gif"">"
	end if
end select
%>
</td>
<td class=tdbg align=center valign=middle style="<%=newstyle%>">
<%if smstype="inbox" or smstype="recycle" then%>
<%=htmlencode(rs("sender"))%>
<%else%>
<%=htmlencode(rs("incept"))%>
<%end if%>
</td>
<td class=tdbg align=left style="<%=newstyle%>"><a href="JavaScript:openScript2('sms_main.asp?action=<%=readaction%>&id=<%=rs("id")%>&sender=<%=rs("sender")%>',500,400)"><%=htmlencode(rs("title"))%></a>	</td>
<td class=tdbg style="<%=newstyle%>"><%=rs("sendtime")%></td>
<td class=tdbg style="<%=newstyle%>"><%=len(rs("content"))%>Byte</td>
<td align=center valign=middle width=30 class=tdbg><input type=checkbox name=id value=<%=rs("id")%>></td>
</tr>
<%
	rs.movenext
	loop
	end if
	rs.close
	set rs=nothing
%>
<tr> 
<td align=right valign=middle colspan=6 class=tdbg>��ʡÿһ�ֿռ䣬�뼰ʱɾ��������Ϣ&nbsp;<input type=checkbox name=chkall value=on onClick="CheckAll(this.form)">ѡ��������ʾ��¼&nbsp;<input type=submit name=action onClick="{if(confirm('ȷ��ɾ��ѡ���ļ�¼��?')){this.document.inbox.submit();return true;}return false;}" value="ɾ��<%=replace(boxname,"��","")%>">&nbsp;<input type=submit name=action onClick="{if(confirm('ȷ�����<%=boxname%>���еļ�¼��?')){this.document.inbox.submit();return true;}return false;}" value="���<%=boxname%>"></td>
</tr>
</form>
</table>
<table width="760" border="0" align="center" cellpadding="0" cellspacing="0">
<tr> 
  <td  height="13" align="center" valign="top"><table width="755" border="0" align="center" cellpadding="0" cellspacing="0">
	  <tr> 
		<td height="13" Class="tdbg_left2"></td>
	  </tr>
	</table></td>
</tr>
</table>
</td>
</tr>
</table>
<%
end sub
%>