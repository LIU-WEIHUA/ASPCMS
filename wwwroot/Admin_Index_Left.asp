<%@language=vbscript codepage=936 %>
<%
option explicit
response.buffer=true	
Const PurviewLevel=0
%>
<!--#include file="inc/conn.asp"-->
<!--#include file="inc/config.asp"-->
<!--#include file="Admin_ChkPurview.asp"-->
<html>
<head>
<title>������</title>
<style type=text/css>
body {
	background:#39867B;
	margin:0px;
	font:9pt ����;
	FONT-SIZE: 9pt;
	text-decoration: none;
	SCROLLBAR-FACE-COLOR: #C6EBDE;
	SCROLLBAR-HIGHLIGHT-COLOR: #ffffff;
	SCROLLBAR-SHADOW-COLOR: #39867B;
	SCROLLBAR-3DLIGHT-COLOR: #39867B;
	SCROLLBAR-ARROW-COLOR: #330000;
	SCROLLBAR-TRACK-COLOR: #E2F3F1;
	SCROLLBAR-DARKSHADOW-COLOR: #ffffff;
}
table {
	border:0px;
}
td {
	font:normal 12px ����;
}
img {
	vertical-align:bottom;
	border:0px;
}
a {
	font:normal 12px ����;
	color:#000000;
	text-decoration:none;
}
a:hover {
	color:#cc0000;
	text-decoration:underline;
}
.sec_menu {
	border-left:1px solid white;
	border-right:1px solid white;
	border-bottom:1px solid white;
	overflow:hidden;
	background:#C6EBDE;
}
.menu_title {
}
.menu_title span {
	position:relative;
	top:2px;
	left:8px;
	color:#39867B;
	font-weight:bold;
}
.menu_title2 {
}
.menu_title2 span {
	position:relative;
	top:2px;
	left:8px;
	color:#cc0000;
	font-weight:bold;
}
</style>
<SCRIPT language=javascript1.2>
function showsubmenu(sid)
{
whichEl = eval("submenu" + sid);
if (whichEl.style.display == "none")
{
eval("submenu" + sid + ".style.display=\"\";");
}
else
{
eval("submenu" + sid + ".style.display=\"none\";");
}
}
</SCRIPT>
</head>
<BODY leftmargin="0" topmargin="0" marginheight="0" marginwidth="0">
<table width=100% cellpadding=0 cellspacing=0 border=0 align=left>
<tr>
  <td valign=top><table cellpadding=0 cellspacing=0 width=158 align=center>
      <tr>
        <td height=25 class=menu_title onmouseover=this.className='menu_title2'; onmouseout=this.className='menu_title'; background=images/title_bg_quit.gif id=menuTitle0><span><a href="Admin_Index_Main.asp" target=main><b>������ҳ</b></a> | <a href=Admin_logout.asp target=_top><b>�˳�</b></a></span></td>
      </tr>
      <tr>
        <td style="display:" id='submenu0'><div class=sec_menu style="width:158">
            <table cellpadding=0 cellspacing=0 align=center width=130>
              <tr>
                <td height=20>�û�����<%=AdminName%></td>
              </tr>
              <tr>
                <td height=20>Ȩ&nbsp;&nbsp;�ޣ�
                  <%
		  select case AdminPurview
		  	case 1
				response.write "��������Ա"
			case 2
				response.write "��ʦ����Ա"
		 	 case 3
				response.write "ѧ������Ա"
		  
		  end select
		  %></td>
              </tr>
            </table>
          </div>
          <div  style="width:158">
            <table cellpadding=0 cellspacing=0 align=center width=130>
              <tr>
                <td height=20></td>
              </tr>
            </table>
          </div></td>
      </tr>
    </table>
    <%if AdminPurview=1 or AdminPurview_Article<=3 or AdminPurview=2 or AdminPurview=3 then%>
    <table cellpadding=0 cellspacing=0 width=158 align=center>
      <tr>
        <td height=25 class=menu_title onmouseover=this.className='menu_title2'; onmouseout=this.className='menu_title'; background="images/Admin_left_1.gif" id=menuTitle1 onClick="showsubmenu(1)" style="cursor:hand;"><span>���¹���</span></td>
      </tr>
      <tr>
        <td style="display:" id='submenu1'><div class=sec_menu style="width:158">
            <table cellpadding=0 cellspacing=0 align=center width=130>
              <% if AdminPurview < 3 then %>
              <tr>
                <td height=20><a href=Admin_ArticleAdd1.asp target=main>������£����ģʽ��</a></td>
              </tr>
              <tr>
                <td height=20><a href=Admin_ArticleAdd2.asp target=main>������£��߼�ģʽ��</a></td>
              </tr>
              <tr>
                <td height=20><a href=Admin_ArticleManage.asp?ManageType=MyArticle target=main>�ҷ��������</a></td>
              </tr>
              <%end if%>
              <tr>
                <td height=20><a href=Admin_ArticleManage.asp target=main>������Ŀ����</a> | <a href=Admin_ArticleCheck.asp target=main>���</a></td>
              </tr>
              <%if AdminPurview=1 or AdminPurview_Article<=2 then%>
              <tr>
                <td height=20><a href=Admin_ArticleManageSpecial.asp target=main>�γ����¹���</a></td>
              </tr>
              <%end if%>
              <%if AdminPurview=1 or AdminPurview_Article=1 then%>
              <tr>
                <td height=20><a href=Admin_ArticleRecyclebin.asp target=main>���»���վ����</a></td>
              </tr>
              <tr>
                <td height=20><a href=Admin_ArticleComment.asp target=main>�������۹���</a></td>
              </tr>
              <%end if%>
            </table>
          </div>
          <div  style="width:158">
            <table cellpadding=0 cellspacing=0 align=center width=130>
              <tr>
                <td height=20></td>
              </tr>
            </table>
          </div></td>
      </tr>
    </table>
    <%
end if

PurviewPassed=False
arrPurview(0)=CheckPurview(AdminPurview_Others,"Channel")
arrPurview(1)=CheckPurview(AdminPurview_Others,"AD")
arrPurview(2)=CheckPurview(AdminPurview_Others,"FriendSite")
arrPurview(3)=CheckPurview(AdminPurview_Others,"Announce")
arrPurview(4)=CheckPurview(AdminPurview_Others,"Vote")
arrPurview(5)=CheckPurview(AdminPurview_Others,"Count")
for PurviewIndex=0 to 5
	if arrPurview(PurviewIndex)=True then
		PurviewPassed=True
		exit for
	end if
next
if AdminPurview=1 or PurviewPassed=True then
%>
    <table cellpadding=0 cellspacing=0 width=158 align=center>
      <tr>
        <td height=25 class=menu_title onmouseover=this.className='menu_title2'; onmouseout=this.className='menu_title'; background="images/Admin_left_2.gif" id=menuTitle2 onClick="showsubmenu(2)" style="cursor:hand;"><span>��������</span></td>
      </tr>
      <tr>
        <td style="display:none" id='submenu2'><div class=sec_menu style="width:158">
            <table cellpadding=0 cellspacing=0 align=center width=130>
              <%
			if AdminPurview=1 or AdminPurview=2 then
			%>
              <tr>
                <td height=20><a href=Admin_Course.asp target=main>����ʱ��༶ | ����</a></td>
              </tr>
              <%
			end if
			%>
              <%if AdminPurview=1 then%>
              <tr>
                <td height=20><a href=Admin_Class_Article.asp?Action=Add target=main>������Ŀ���</a> | <a href=Admin_Class_Article.asp target=main>����</a></td>
              </tr>
              <tr>
                <td height=20><a href=Admin_Special.asp?Action=Add target=main>��&nbsp;��&nbsp;&nbsp;��&nbsp;��</a> | <a href=Admin_Special.asp target=main>����</a></td>
              </tr>
              <tr>
                <td height=20><a href=Admin_SiteConfig.asp target=main>��վ��Ϣ���� | ѡ��</a></td>
              </tr>
              <%
end if
if AdminPurview=1 or arrPurview(0)=True then
%>
              <tr>
                <td height=20><a href=Admin_Channel.asp?Action=Add target=main>��վƵ�����</a> | <a href=Admin_Channel.asp target=main>����</a></td>
              </tr>
              <%
end if
if AdminPurview=1 or arrPurview(1)=True then
%>
              <!--����Ҫ��վ������   <tr> 
                <td height=20><a href=Admin_Advertisement.asp?Action=Add target=main>��վ������</a> 
                  | <a href=Admin_Advertisement.asp target=main>����</a></td>
              </tr>   -->
              <%
end if
if AdminPurview=1 or arrPurview(2)=True then
%>
              <tr>
                <td height=20><a href=Admin_FriendSite.asp?Action=Add target=main>��վ�������</a> | <a href=Admin_FriendSite.asp target=main>����</a></td>
              </tr>
              <%
end if
if AdminPurview=1 or arrPurview(3)=True then
%>
              <tr>
                <td height=20><a href=Admin_Announce.asp?Action=Add target=main>������վ����</a> | <a href=Admin_Announce.asp target=main>����</a></td>
              </tr>
              <%
end if
if AdminPurview=1 or arrPurview(4)=True then
%>
              <tr>
                <td height=20><a href=Admin_Vote.asp?Action=Add target=main>������վ����</a> | <a href=Admin_Vote.asp target=main>����</a></td>
              </tr>
              <%
end if
%>
            </table>
          </div>
          <div  style="width:158">
            <table cellpadding=0 cellspacing=0 align=center width=130>
              <tr>
                <td height=20></td>
              </tr>
            </table>
          </div></td>
      </tr>
    </table>
    <%
end if
PurviewPassed=False
arrPurview(0)=CheckPurview(AdminPurview_Guest,"Reply")
arrPurview(1)=CheckPurview(AdminPurview_Guest,"Modify")
arrPurview(2)=CheckPurview(AdminPurview_Guest,"Del")
arrPurview(3)=CheckPurview(AdminPurview_Guest,"Check")
for PurviewIndex=0 to 3
	if arrPurview(PurviewIndex)=True then
		PurviewPassed=True
		exit for
	end if
next
if AdminPurview=1 or PurviewPassed=True then
%>
    <table cellpadding=0 cellspacing=0 width=158 align=center>
      <tr>
        <td height=25 class=menu_title onmouseover=this.className='menu_title2'; onmouseout=this.className='menu_title'; background="images/Admin_left_3.gif" id=menuTitle3 onClick="showsubmenu(3)" style="cursor:hand;"><span>���԰����</span></td>
      </tr>
      <tr>
        <td style="display:none" id='submenu3'><div class=sec_menu style="width:158">
            <table cellpadding=0 cellspacing=0 align=center width=130>
              <%if AdminPurview=1 or arrPurview(3)=True then%>
              <tr>
                <td height=20><a href=Admin_Guest.asp target=main>��վ���Թ���</a></td>
              </tr>
              <%end if%>
              <!--<tr> 
                <td height=20><a href=Admin_Guest.asp target=main>��վ�������</a></td>
              </tr>-->
              <%if AdminPurview =1 or AdminPurview=2 then %>
              <tr>
                <td height=20><a href=admin_message.asp target=main>����Ϣ����</a></td>
              </tr>
              <%end if%>
            </table>
          </div>
          <div  style="width:158">
            <table cellpadding=0 cellspacing=0 align=center width=130>
              <tr>
                <td height=20></td>
              </tr>
            </table>
          </div></td>
      </tr>
    </table>
    <%
end if

PurviewPassed=False
arrPurview(0)=CheckPurview(AdminPurview_Others,"User")
arrPurview(1)=CheckPurview(AdminPurview_Others,"MailList")
for PurviewIndex=0 to 1
	if arrPurview(PurviewIndex)=True then
		PurviewPassed=True
		exit for
	end if
next
if AdminPurview=1 or PurviewPassed=True then
%>
    <table cellpadding=0 cellspacing=0 width=158 align=center>
      <tr>
        <td height=25 class=menu_title onmouseover=this.className='menu_title2'; onmouseout=this.className='menu_title'; background="images/Admin_left_4.gif" id=menuTitle4 onClick="showsubmenu(4)" style="cursor:hand;"><span>�û�����</span></td>
      </tr>
      <tr>
        <td style="display:none" id='submenu4'><div class=sec_menu style="width:158">
            <table cellpadding=0 cellspacing=0 align=center width=130>
              <%if AdminPurview=1 or arrPurview(0)=True then%>
              <tr>
                <td height=20><a href=Admin_UserList.asp target=main>�û�ͳ��</a></td>
              </tr>
              <tr>
                <td height=20><a href=Admin_User.asp target=main>ע���û�����</a></td>
              </tr>
              <tr>
                <td height=20><a href="Admin_User.asp?Action=Update" target="main">�����û�����</a></td>
              </tr>
              <%
end if
if AdminPurview=1 or arrPurview(2)=True then
%>
              <tr>
                <td height=20><a href="Admin_Maillist.asp" target="main">�ʼ��б�</a> | <a href="Admin_Maillist.asp?Action=Export" target="main">�б���</a></td>
              </tr>
              <%
end if
if AdminPurview=1 or AdminPurview=2 then
%>
              <tr>
                <td height=20><a href=Admin_Admin.asp?Action=Add target=main>����Ա���</a> | <a href=Admin_Admin.asp target=main>����</a></td>
              </tr>
              <%end if%>
            </table>
          </div>
          <div  style="width:158">
            <table cellpadding=0 cellspacing=0 align=center width=130>
              <tr>
                <td height=20></td>
              </tr>
            </table>
          </div></td>
      </tr>
    </table>
    <%
end if
PurviewPassed=False
arrPurview(0)=CheckPurview(AdminPurview_Others,"Skin")
arrPurview(1)=CheckPurview(AdminPurview_Others,"Layout")
for PurviewIndex=0 to 1
	if arrPurview(PurviewIndex)=True then
		PurviewPassed=True
		exit for
	end if
next
if AdminPurview=1 or PurviewPassed=True then
%>
    <table cellpadding=0 cellspacing=0 width=158 align=center>
      <tr>
        <td height=25 class=menu_title onmouseover=this.className='menu_title2'; onmouseout=this.className='menu_title'; background="images/Admin_left_5.gif" id=menuTitle5 onClick="showsubmenu(5)" style="cursor:hand;"><span>ģ�����</span></td>
      </tr>
      <tr>
        <td style="display:none" id='submenu5'><div class=sec_menu style="width:158">
            <table cellpadding=0 cellspacing=0 align=center width=130>
              <%if AdminPurview=1 or arrPurview(0)=True then%>
              <tr>
                <td height=20><a href=Admin_Skin.asp?Action=Add target=main>��ɫģ�����</a> | <a href=Admin_Skin.asp target=main>����</a></td>
              </tr>
              <tr>
                <td height=20><a href="Admin_Skin.asp?Action=Export" target="main">��ɫģ�嵼��</a> | <a href="Admin_Skin.asp?Action=Import" target="main">����</a></td>
              </tr>
              <%
end if
if AdminPurview=1 or arrPurview(1)=True then
%>
              <tr>
                <td height=20><a href=Admin_Layout.asp?Action=Add target=main>����������</a> | <a href=Admin_Layout.asp target=main>����</a></td>
              </tr>
              <tr>
                <td height=20><a href="Admin_Temp.asp" target="main">������Ƶ���</a> | <a href="Admin_Temp.asp" target="main">����</a></td>
              </tr>
              <%end if%>
            </table>
          </div>
          <div  style="width:158">
            <table cellpadding=0 cellspacing=0 align=center width=130>
              <tr>
                <td height=20></td>
              </tr>
            </table>
          </div></td>
      </tr>
    </table>
    <%
end if
if AdminPurview=1 or CheckPurview(AdminPurview_Others,"JS")=True then
%>
    <table cellpadding=0 cellspacing=0 width=158 align=center>
      <tr>
        <td height=25 class=menu_title onmouseover=this.className='menu_title2'; onmouseout=this.className='menu_title'; background="images/Admin_left_6.gif" id=menuTitle6 onClick="showsubmenu(6)" style="cursor:hand;"><span>JS�������</span></td>
      </tr>
      <tr>
        <td style="display:none" id='submenu6'><div class=sec_menu style="width:158">
            <table cellpadding=0 cellspacing=0 align=center width=130>
              <tr>
                <td height=20><a href="Admin_MakeJS.asp?Action=JS_Common" target="main">��ͨ���µ�JS����</a></td>
              </tr>
              <tr>
                <td height=20><a href="Admin_MakeJS.asp?Action=JS_Pic" target="main">��ҳͼ�ĵ�JS����</a></td>
              </tr>
            </table>
          </div>
          <div  style="width:158">
            <table cellpadding=0 cellspacing=0 align=center width=130>
              <tr>
                <td height=20></td>
              </tr>
            </table>
          </div></td>
      </tr>
    </table>
    <%
end if
if AdminPurview=1 or CheckPurview(AdminPurview_Others,"Database")=True then
%>
    <table cellpadding=0 cellspacing=0 width=158 align=center>
      <tr>
        <td height=25 class=menu_title onmouseover=this.className='menu_title2'; onmouseout=this.className='menu_title'; background="images/Admin_left_7.gif" id=menuTitle7 onClick="showsubmenu(7)" style="cursor:hand;"><span>���ݿ����</span></td>
      </tr>
      <tr>
        <td style="display:none" id='submenu7'><div class=sec_menu style="width:158">
            <table cellpadding=0 cellspacing=0 align=center width=130>
              <tr>
                <td height=20><a href=Admin_Database.asp?Action=Compact target=main>ѹ�����ݿ�</a></td>
              </tr>
              <tr>
                <td height=20><a href=Admin_Database.asp?Action=Backup target=main>�������ݿ�</a></td>
              </tr>
              <tr>
                <td height=20><a href=Admin_Database.asp?Action=Restore target=main>�ָ����ݿ�</a></td>
              </tr>
              <tr>
                <td height=20><a href=Admin_Database.asp?Action=Init target=main>ϵͳ��ʼ��</a></td>
              </tr>
              <tr>
                <td height=20><a href=Admin_Database.asp?Action=SpaceSize target=main>ϵͳ�ռ�ռ��</a></td>
              </tr>
            </table>
          </div>
          <div  style="width:158">
            <table cellpadding=0 cellspacing=0 align=center width=130>
              <tr>
                <td height=20></td>
              </tr>
            </table>
          </div></td>
      </tr>
    </table>
    <%end if
if AdminPurview=1 or CheckPurview(AdminPurview_Others,"UpFile")=True then
%>
    <table cellpadding=0 cellspacing=0 width=158 align=center>
      <tr>
        <td height=25 class=menu_title onmouseover=this.className='menu_title2'; onmouseout=this.className='menu_title'; background="images/Admin_left_8.gif" id=menuTitle8 onClick="showsubmenu(8)" style="cursor:hand;"><span>�ϴ��ļ�����</span></td>
      </tr>
      <tr>
        <td style="display:none" id='submenu8'><div class=sec_menu style="width:158">
            <table cellpadding=0 cellspacing=0 align=center width=130>
              <tr>
                <td height=20><a href=Admin_UploadFile.asp?UploadDir=UploadFiles target=main>����Ƶ�����ϴ��ļ�</a></td>
              </tr>
              <tr>
                <td height=20><a href=Admin_UploadFile.asp?Action=Clear target=main>��������ļ�</a></td>
              </tr>
            </table>
          </div>
          <div  style="width:158">
            <table cellpadding=0 cellspacing=0 align=center width=130>
              <tr>
                <td height=20></td>
              </tr>
            </table>
          </div></td>
      </tr>
    </table>
    <%end if%>
    <!--<table cellpadding=0 cellspacing=0 width=158 align=center>
      <tr>
        <td><div class=sec_menu style="width:158">
            <table cellpadding=0 cellspacing=0 width=158 align=center>
              <tr>
                <td height=25 class=menu_title onmouseover=this.className='menu_title2'; onmouseout=this.className='menu_title'; background="images/Admin_left_9.gif" id=menuTitle9><span>�༭��������</span></td>
              </tr>
              <tr>
                <td height="100"><div class=sec_menu style="width:158"> </div></td>
              </tr>
            </table>
          </div></td>
      </tr>
    </table>-->
</body>
</html>
<%
call CloseConn()
%>