<!--#include file="Inc/syscode_photo.asp"-->
<%
'����Ķ����������д���
const ChannelID=4
Const ShowRunTime="Yes"
MaxPerPage=20
SkinID=0
PageTitle="��ҳ"
Set rsPhoto= Server.CreateObject("ADODB.Recordset")
%>
<html>
<head>
<title><%=strPageTitle & " >> " & PageTitle%></title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<!--#include file="inc/Skin_CSS.asp"-->
<%call MenuJS()%>
</head>
<body <%=Body_Label%> onmousemove='HideMenu()'>

<div id=menuDiv style='Z-INDEX: 1000; VISIBILITY: hidden; WIDTH: 1px; POSITION: absolute; HEIGHT: 1px; BACKGROUND-COLOR: #9cc5f8'></div>

<table width="760" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr> 
    <td background="images/to_bj.gif" height="8"></td>
  </tr>
  <tr> 
    <td background="images/to_bj01.gif" height="8" bgcolor="#D98145"></td>
  </tr>
  <tr> 
    <td background="images/m_bg.gif" height="62">
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td height="11" width="234" align="right">&nbsp;</td>
          <td width="526" height="78"  align="center" valign="middle"><% call ShowBanner() %></td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td background="images/to_bj03.gif" height="8" bgcolor="#D98145"></td>
  </tr>
</table>
<table width="760" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr> 
    <td height="24" background="images/daohang1.gif"> 
      <table width="683" border="0" cellspacing="0" cellpadding="0" align="center">
        <tr> 
         
          <td height="24" background="images/daohang.gif" width="68" align="center"> 
            <a href="diary_index.asp" target="_blank"><font color="#FF0000">�ռǱ�</font></a></td>
          <td height="24" background="images/daohang.gif" width="68" align="center"><a href="Article_Class2.asp?ClassID=2">ɢ 
            ��</a></td>
          <td height="24" background="images/daohang.gif" width="68" align="center"><a href="Article_Class2.asp?ClassID=1">С 
            ˵</a></td>
          <td height="24" background="images/daohang.gif" width="68" align="center"><a href="Article_Class2.asp?ClassID=4">�� 
            ��</a></td>
          <td height="24" background="images/daohang.gif" width="68" align="center"><a href="Article_Class2.asp?ClassID=3">ʫ 
            ��</a></td>
          <td height="24" background="images/daohang.gif" width="68" align="center"><a href="Article_Class2.asp?ClassID=5">����ѧ</a></td>
       <td height="24" background="images/daohang.gif" width="68" align="center"><a href="Article_Class2.asp?ClassID=43">��ѧ����</a></td>
          <td height="24" background="images/daohang.gif" width="68" align="center"><a href="photo_index.asp">�� 
            ͼ</a></td>
          <td height="24" background="images/daohang.gif" width="68" align="center"><a href="soft_index.asp">�������</a></td>
          <td height="24" background="images/daohang.gif" width="68" align="center"><a href="http://bbs.fanchen.com" target="_blank"><font color="#FF0000">��������</font></a></td>
        </tr>
      </table>
    </td>
  </tr>
  <tr> 
    <td background="images/to_bj08.gif" height="10" bgcolor="#F4DBCA"></td>
  </tr>
  <tr> 
    <td background="images/to_bj06.gif" height="9"></td>
  </tr>
</table><script language="javascript">
function click() {
if (event.button==2) {  //�ĳ�button==2Ϊ��ֹ�Ҽ�
alert('��ӭ������������ѧ������վ���𲽣����֧�֡���')
}
}
document.onmousedown=click
</script>
<table width="760" border="0" align="center" cellpadding="0" cellspacing="0" class="border2">
  <tr>
    <td width="180" valign="top" class="tdbg_leftall"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td height="5"></td>
        </tr>
      </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td background="Images/left01.gif"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td align="center" class="title_lefttxt"><strong>�û���¼</strong></td>
              </tr>
            </table></td>
        </tr>
        <tr> 
          <td valign="top" class="tdbg_left"><table width="100%" height="100%" border="0" cellpadding="0" cellspacing="5">
              <tr> 
                <td height="100" valign="top"> <% call ShowUserLogin() %> </td>
              </tr>
            </table></td>
        </tr>
        <tr>
          <td class="title_left2"></td>
        </tr>
        <tr> 
          <td background="Images/left02.gif"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td align="center" class="title_lefttxt"><strong>ͼƬͳ��</strong></td>
              </tr>
            </table></td>
        </tr>
        <tr> 
          <td valign="top" class="tdbg_left"><table width="100%" height="100%" border="0" cellpadding="8">
              <tr> 
                <td height="100" valign="top"><%call ShowSiteCount()%></td>
              </tr>
            </table></td>
        </tr>
        <tr> 
          <td class="title_left2"></td>
        </tr>
        <tr> 
          <td background="Images/left18.gif"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td align="center" class="title_lefttxt"><strong>��������ͼƬ</strong></td>
              </tr>
            </table></td>
        </tr>
        <tr> 
          <td valign="top" class="tdbg_left"><table width="100%" height="100%" border="0" cellpadding="8">
              <tr> 
                <td valign="top"> 
                  <%call ShowHot(10,100)%>
                </td>
              </tr>
            </table></td>
        </tr>
        <tr> 
          <td class="title_left2"></td>
        </tr>
        <tr> 
          <td background="Images/left08.gif"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td align="center" class="title_lefttxt"><strong>�����Ƽ�ͼƬ</strong></td>
              </tr>
            </table></td>
        </tr>
        <tr> 
          <td valign="top" class="tdbg_left"><table width="100%" height="100%" border="0" cellpadding="8">
              <tr> 
                <td valign="top">
<%call ShowElite(10,100)%>
                </td>
              </tr>
            </table></td>
        </tr>
        <tr> 
          <td class="title_left2"></td>
        </tr>
	        <tr> 
          <td background="Images/left06.gif"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td class="title_lefttxt"><div align="center"><strong>�� �� �� ��</strong></div></td>
              </tr>
            </table></td>
        </tr>
        <tr> 
          <td valign="top" class="tdbg_left"> <table width="100%" border="0" cellpadding="8">
              <tr> 
                <td> <% call ShowVote() %> </td>
              </tr>
            </table></td>
        </tr>
        <tr> 
          <td class="title_left2"></td>
        </tr>
      </table></td>
    <td width="5">&nbsp;</td>
    <td width="575" valign="top"><table width="99%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
          <td><table width=100% height=15 border=0 align="center" cellPadding=0 cellSpacing=0>
              <tr> 
                <td width="20"><img src="Images/announce.gif" width="20" height="16"></td>
                <td width="66"><div align="center"><font color="#CC0000">ͼƬ���棺</font></div></td>
                <td width="483" height=15 align=center valign=middle> <div align="right"> 
                   <marquee behavior=scroll width=100%
            align="left" onmouseover="this.stop()" onmouseout="this.start()"><% call ShowAnnounce(2,5) %>
                    </MARQUEE>
                  </div></td>
              </tr>
            </table>
          </td>
        </tr>
        <tr>
          <td height="10" class="title_main"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="title_main">
              <tr> 
                <td width="40">&nbsp;</td>
                <td class="title_maintxt">������µ�ͼƬ</td>
              </tr>
            </table></td>
        </tr>
        <tr> 
          <td height="100" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="5" class="border">
              <tr> 
                <td height="120" valign="top"> <% call ShowNewPhoto(12,True,18)%> </td>
              </tr>
            </table></td>
        </tr>
        <tr> 
          <td  height="15" align="center" valign="top"> <table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr> 
                <td height="13" Class="tdbg_left2"></td>
              </tr>
            </table></td>
        </tr>
        <tr> 
          <td height="20" class="tdbg_right2">
<table width="100%" border="0" cellpadding="0" cellspacing="0">
              <tr> 
                <td width="40">&nbsp;</td>
                <td class="title_maintxt">��Ŀ����</td>
              </tr>
            </table></td>
        </tr>
        <tr> 
          <td height="28" valign="top"> 
            <table width="100%" border="0" cellpadding="0" cellspacing="5" class="border">
              <tr> 
                <td height="18" valign="top"> 
                  <% call ShowClassNavigation() %>
                </td>
              </tr>
            </table></td>
        </tr>
        <tr> 
          <td  height="15" align="center" valign="top"> <table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr> 
                <td height="13" Class="tdbg_left2"></td>
              </tr>
            </table></td>
        </tr>
        <tr> 
          <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="tdbg_rightall">
              <tr> 
                <td width="100" align="center"><img src="Images/checkphoto.gif" width="15" height="15" align="absmiddle">&nbsp;&nbsp;ͼƬ������</td>
                <td align="center">
<%call ShowSearchForm("Photo_Search.asp",2)%>
                </td>
              </tr>
            </table></td>
        </tr>
      </table></td>
  </tr>
</table>
<table width="760" border="0" align="center" cellpadding="0" cellspacing="0" class="tdbg">
  <tr> 
    <td  height="13" align="center" valign="top"><table width="756" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
          <td height="13" Class="tdbg_left2"></td>
        </tr>
      </table></td>
  </tr>
</table>
<% call Bottom() %>
<% call PopAnnouceWindow(400,300) %>
<% call ShowAD(0) %>                         
<% call ShowAD(4) %>                         
<% call ShowAD(5) %>                         
</body>
</html>
<%
set rsPhoto=nothing
call CloseConn()
%>