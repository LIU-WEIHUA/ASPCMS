<!--#include file="Inc/syscode_article.asp"-->
<%
'����Ķ����������д���
const ChannelID=0
Const ShowRunTime="Yes"
MaxPerPage=20
SkinID=0
PageTitle="������ѧԭ����ѧ��"
Set rsArticle= Server.CreateObject("ADODB.Recordset")
Set rsPic= Server.CreateObject("ADODB.Recordset")
%>
<html>
<head>
<title><%=strPageTitle & " >> " & PageTitle%></title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<!--#include file="inc/Skin_CSS.asp"-->
<%call MenuJS()%>
</head>
<body <%=Body_Label%> onmousemove='HideMenu()'>
<!--#include file="top.asp"-->
<table width="760" border="0" align="center" cellpadding="0" cellspacing="0" class="border2">
  <tr> 
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><div align="center"> 
        <p class="tdbg_rightall"><font color="#CC0000" size="3">��&nbsp;���ڱ�����ѧԭ����ѧ��԰&nbsp;��</font> 
        </p>
      </div></td>
  </tr>
  <tr> 
    <td height="347"> 
      <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
          <td height="347"> 
            <div align="center"> </div>
            <p>1��<font color="#CC0000" size="3">������ѧԭ����ѧ��԰</font>��һ����ԭ��������ѧΪ������������Ϊ�����ۺ���ѧվ�㡣</p>
            <p>2��<font color="#CC0000" size="3">������ѧԭ����ѧ��԰</font>Ŀǰ���еķ�������Ѳ������Ƶġ�</p>
            <p>3��<font color="#CC0000" size="3">������ѧԭ����ѧ��԰</font>��Ŀ���ǳ�Ϊ����֪������ѧ��վ֮һ��</p>
            <p>4��<font color="#CC0000" size="3">������ѧԭ����ѧ��԰</font>������2006��1��1�ա���Ȼʱ�䲻������������һֱ�����������������ݲ���ѹ��ͬ����վ��</p>
            <p>5��<font color="#CC0000" size="3">������ѧԭ����ѧ��԰</font>�ṩ������ԭ����ᡢ���صȷ����Ժ󻹽��Ƴ�������ꡣ 
            </p>
            <p>6�������<font color="#CC0000" size="3">������ѧԭ����ѧ��԰</font>���κ�����ͽ������������µ�ַ�����������顣лл��</p>
            <p>7��δ��������<font color="#CC0000" size="3">������ѧԭ����ѧ��԰</font>���¹���͹�����ط���Ϊ׼��<br>
            </p>
            <p>**********************************************************************<br>
              * ��������: <a href="mailto:10000@26265.cn">antishy</a><br>
              * ��ҳ��ַ: <a href="http://www.26265.cn/">http://www.26265.cn/</a><br>
              * ��̳��ַ: <a href="http://www.26265.cn/bbs">http://www.26265.cn/bbs</a><br>
              **********************************************************************<br>
              <br>
              <br>
            </p>
          </td>
        </tr>
      </table></td>
  </tr>
</table>
<table width="760" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" class="tdbg">
  <tr> 
    <td  height="13" align="center" valign="top"><table width="755" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
          <td height="13" Class="tdbg_left2"></td>
        </tr>
      </table></td>
  </tr>
</table>
<% call Bottom() %>
<% call PopAnnouceWindow(400,300) %>
</body>
</html>
<%
set rsArticle=nothing
set rsPic=nothing
call CloseConn()
%>