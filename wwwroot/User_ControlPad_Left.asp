<!--#include file="inc/Conn_User.asp"-->
<!--#include file="inc/md5.asp"-->
<!--#include file="inc/function.asp"-->
<%
if CheckUserLogined()=False then
	response.Redirect "index.asp"
end if
%>
<html>
<head>
<title></title>
<style>
<!--
a:link {
	text-decoration: none;
	color: #000000;
	font-family: ����
}
a:visited {
	text-decoration: none;
	color: #000000;
	font-family: ����
}
a:hover {
	text-decoration: underline;
	color: #cc0000
}
body {
	font-family: "����";
	font-size: 9pt;
	line-height: 12pt;
}
table {
	font-family: "����";
	font-size: 9pt;
	line-height: 12pt;
}
-->
</style>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<body bgcolor="#E7DEAD" text="#000000" leftmargin="0" topmargin="0" background="NewImages/bgLightGreen.gif">
<br>
<table width="100%" border="0" cellpadding="0" cellspacing="0" height="100%">
  <tr>
    <td width="10" height="200">&nbsp;</td>
    <td width="8">&nbsp;</td>
    <td valign="top" width="1004"><script language="JavaScript">
function MenuClick(name)
{
if (name.style.display=="none")
{
xiaoshuo.style.display = "none"
zawen.style.display = "none"

xiaoxi.style.display = "none"
shige.style.display = "none"
name.style.display="block";

}
else
name.style.display="none";
}
</script>
      <br>
      <%
		response.write "�� ӭ �㣺" & UserName
		response.write "<br>���ĵȼ���"
		if UserLevel=999 then
			response.write "ע���û�"
		elseif UserLevel=99 then
			response.write "�շ��û�"
		elseif UserLevel=9 then
			response.write "�߼��û�"
		end if
%>
      <br>
      <img name="Image5" border="0" src="NewImages/Textapps.png" width="28" height="28"><a href="javascript:MenuClick(shige);">Ͷ���������</a><br/>
      <div id="shige" style="display:none;"> &nbsp;&nbsp;&nbsp;<img src="NewImages/iecool_arrow_210.gif" width="20" height="16" border="0"><a href="User_ArticleAdd.asp" target="main"><font color="blue">�����µ�����</font></a><br>
        &nbsp;&nbsp;&nbsp;<img src="NewImages/iecool_arrow_210.gif" width="20" height="16" border="0"><a href="User_ArticleManage.asp" target="main"><font color="blue">�鿴����״̬</font></a><br>
        &nbsp;&nbsp;&nbsp;<img src="NewImages/iecool_arrow_210.gif" width="20" height="16" border="0"><a href="User_Articlere.asp" target="main"><font color="blue">���˻ص�����</font></a></div>
      <br>
      <img name="Image5" border="0" src="NewImages/Favorites.png" width="28" height="28"><a href="javascript:MenuClick(xiaoshuo);">�������Ϲ���</a><br>
      <div id="xiaoshuo" style="display:none;"> &nbsp;&nbsp;&nbsp;<img src="NewImages/iecool_arrow_210.gif" width="20" height="16" border="0"><a href=User_ModifyPwd.asp target=main><font color="blue">�޸ĵ�½����</font></a><br>
        &nbsp;&nbsp;&nbsp;<img src="NewImages/iecool_arrow_210.gif" width="20" height="16" border="0"><a href=User_ModifyInfo.asp target=main><font color="blue">�޸ĸ�������</font></a></div>
      <br>
      <img name="Image5" border="0" src="NewImages/Mail.png" width="28" height="28"><a href="javascript:MenuClick(xiaoxi);">������Ϣ����</a><br>
      <div id="xiaoxi" style="display:none;"> &nbsp;&nbsp;&nbsp;<img src="NewImages/iecool_arrow_210.gif" width="20" height="16" border="0"><a href="sms_main.asp?action=new" target="main"><font color="blue">���Ͷ���Ϣ</font></a><br>
        &nbsp;&nbsp;&nbsp;<img src="NewImages/iecool_arrow_210.gif" width="20" height="16" border="0"><a href="sms_user.asp?action=inbox" target="main"><font color="blue">�鿴����Ϣ</font></a></div>
      <br>
      <img name="Image5" border="0" src="NewImages/Adresses.png" width="28" height="28"><a href="javascript:MenuClick(zawen);">��������</a><br>
      <div id="zawen" style="display:none;"> &nbsp;&nbsp;&nbsp;<img src="NewImages/iecool_arrow_210.gif" width="20" height="16" border="0"><a href="guestbook.asp" target="_blank"><font color="#FF0000">����������</font></a><br>        
      </div>
      <br>
      <img name="Image5" border="0" src="NewImages/Classic.png" width="28" height="28"><a href="User_ControlPad_main.asp" target="main">������ҳ</a><br>
      <img name="Image5" border="0" src="NewImages/Xpired.png" width="28" height="28"><a href="User_Logout.asp" target="_top">�˳���¼</a><br>
      </div>
      </div>
      <div align="center"></div></td>
  </tr>
</table>
</body>
</html>
