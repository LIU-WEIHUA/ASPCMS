<!--#include file="Inc/syscode_article.asp"-->
<%
const ChannelID=2
const ShowRunTime="Yes"
MaxPerPage=10
SkinID=0
PageTitle="�������"
strFileName="Article_Search.asp?Field=" & strField & "&Keyword=" & keyword & "&ClassID=" & ClassID
%>
<html>
<head>
<title><%=SiteName%>--�����������</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<!--#include file="inc/Skin_CSS.asp"-->
<% call MenuJS() %>
</head>
<body  <%=Body_Label%>  onmousemove='HideMenu()'  bgcolor="#FFFFFF"  style="BACKGROUND-COLOR: #ffffff" >
<table width="989"><tr><td>
<div align="center" ><table id="__01" width="989"  border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
	<tr>
		<td colspan="2">
			<img   src="images/��ҳ_slice2_03.jpg" width="989" height="140" alt=""></td>
	</tr>
	<tr>
       <td align="left" background="images/��ҳ_slice_05.jpg" width="84%" height="25">&nbsp;&nbsp;<a href="index.asp">��&nbsp;&nbsp;&nbsp;&nbsp;ҳ</a>&nbsp;&nbsp;<font color="#FFFFFF">��</font>&nbsp;&nbsp;<a href="Article_Class2.asp?ClassID=2">��������</a>&nbsp;&nbsp;<font color="#FFFFFF">��</font>&nbsp;&nbsp;<a href="Article_Class2.asp?ClassID=1">���۶�̬</a>&nbsp;&nbsp;<font color="#FFFFFF">��</font>&nbsp;&nbsp;<a href="Article_Class2.asp?ClassID=3">ʱ������</a>&nbsp;&nbsp;<font color="#FFFFFF">��</font>&nbsp;&nbsp;<a href="Article_Class2.asp?ClassID=58">ѧ����Ʒ</a>&nbsp;&nbsp;<font color="#FFFFFF">��</font>&nbsp;&nbsp;<a href="userlist.asp">��&nbsp;&nbsp;&nbsp;&nbsp;��</a>&nbsp;&nbsp;<font color="#FFFFFF">��</font>&nbsp;&nbsp;<a href="guestbook.asp">��&nbsp;&nbsp;&nbsp;&nbsp;��</a></td><td background="images/��ҳ_slice_05.jpg"  align="left"><% call ShowSearchForm("Article_Search.asp",1) %></td>
		<td colspan="2"><img src="images/�ָ���.gif" width="1" height="25" alt=""></td>
	</tr>
    </table><!--top--></div></td></tr>
<tr><!--the great talbe--><Td>


<table width="989" border="0" align="center" cellpadding="0" cellspacing="0" class="border2">
  <tr> 
    <td  valign="top"> <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="title_main">
        <tr> 
          <td width="40">&nbsp;</td>
          <td><table width="100%" border="0" cellpadding="0" cellspacing="0" >
              <tr> 
                <td class="title_maintxt"><%
		if keyword="" then
			response.write "��������"
		else
			select case strField
				case "Title"
					response.write "���±��⺬�� <font color=red>"&keyword&"</font> ������"
				case "Content"
					response.write "�������ݺ��� <font color=red>"&keyword&"</font> ������"
				case "Author"
					response.write "������������ <font color=red>"&keyword&"</font> ������"
				case "Editor"
					response.write "�༭�������� <font color=red>"&keyword&"</font> ������"
				case else
					response.write "���±��⺬�� <font color=red>"&keyword&"</font> ������"
			end select
		end if
%>
                </td>
              </tr>
            </table></td>
        </tr>
      </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td height="5"></td>
        </tr>
      </table>
      <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="border">
        <tr> 
          <td valign="top"> <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="5">
              <tr> 
                <td valign="top">
                  <%call ShowSearchResult()%>
                </td>
              </tr>
            </table></td>
        </tr>
        <tr class="tdbg"> 
          <td> <table width="100%" border="0" cellpadding="0" cellspacing="0">
              <tr class="tdbg_leftall"> 
                <td> 
                  <%
		  if totalput>0 then
		  	call showpage(strFileName,totalput,MaxPerPage,false,true,"ƪ����")
		  end if
		  %>
                </td>
              </tr>
            </table></td>
        </tr>
      </table>
      <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
          <td  height="15" align="center" valign="top"> <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr> 
                <td height="13" Class="tdbg_left2"></td>
              </tr>
            </table></td>
        </tr>
      </table>
      
      <table width='99%' border='0' align="center"cellpadding='2' cellspacing='0' class="tdbg_rightall">
        <tr class='tdbg_leftall'> 
          <td width="22%"> <div align="center"><img src="Images/checkarticle.gif" width="15" height="15" align="absmiddle">&nbsp;&nbsp;վ������������</div></td>
          <td width="78%"> <div align="center"> 
              <% call ShowSearchForm("Article_Search.asp",2) %>
            </div></td>
        </tr>
      </table>
      
    </td>
  </tr>
</table>
</Td><!--the great talbe--></tr><tr><!--the great talbe--><td>
<% call Bottom_all() %></td></tr></table>
</body>
</html>
<% call CloseConn() %>