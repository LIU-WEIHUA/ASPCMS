<!--#include file="Inc/syscode_article.asp"-->
<%
'����Ķ����������д���
const ChannelID=2
Const ShowRunTime="Yes"
dim OrderType
MaxPerPage=20
SkinID=0
OrderType=trim(request("OrderType"))
if OrderType="" then
	OrderType=1
else
	OrderType=Clng(OrderType)
end if
PageTitle="�û��б�"
strFileName="UserList.asp?OrderType=" & OrderType
%>
<html>
<head>
<title><%=strPageTitle & " >> " & PageTitle%></title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<!--#include file="inc/Skin_CSS.asp"-->
<% call MenuJS() %>
</head>
<body <%=Body_Label%> onmousemove='HideMenu()'     bgcolor=#ffffff style="BACKGROUND-COLOR: #ffffff"  >
<table width="989"> <tr><td><%	call Top_noIndex() %></td></tr>
<tr><td><div align="center"><!--main body-->
		<table bgcolor="#ffffff" >
		<tr><td><!-- start left column-->
		<table width="231">
				<tr>
				<td>
            	<fieldset><legend>�û���¼</legend><% call ShowUserLogin() %></fieldset>
                </td>
				</tr>
		<tr><td   background="Images/�γ��б���_06.jpg"  width="231" >&nbsp;&nbsp;&nbsp;&nbsp;<strong>վ�ڵ���</strong>
		
		
		</td></tr>
		
		<tr><td>
		  <ul>
			<li><a href="index.asp">����&nbsp;&nbsp;&nbsp;&nbsp;ҳ��</a>&nbsp;&nbsp;<a href="article_specialList.asp">���γ��б�</a></li>
		    <li><a href="Article_Class2.asp?ClassID=1">�����۶�̬��</a>&nbsp;&nbsp;<a href="Article_Class2.asp?ClassID=2">���������ġ�</a> </li>
		    <li><a href="Article_Class2.asp?ClassID=3">��ʱ�����š�</a>&nbsp;&nbsp;<a href="Article_Class2.asp?ClassID=58">��ѧ����Ʒ��</a> </li>
			</ul>
		</td>
		</tr>
		<tr><td background="Images/�γ��б���_06.jpg"  width="231" > &nbsp;&nbsp;&nbsp;&nbsp;<strong>��������</strong>
		
		</td></tr>
		<tr><td><% call Showhot(8,16) %></td></tr>
        <tr><td background="Images/�γ��б���_06.jpg"  width="231" > &nbsp;&nbsp;&nbsp;&nbsp;<strong>�Ƽ�����</strong>
        	</td></tr>
      	<tr><td>  <% call ShowElite(10,16) %>
        
        </td></tr>
		
		</table>
		
		
		
		<!-- end left column--></td>
		
		<td><!--right column-->
        	<td  valign="top" width="758"><table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#949693" class="border">
        <tr> 
          <td valign="top"> <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="5">
              <tr> 
                <td valign="top"> <% call ShowAllUser() %> </td>
              </tr>
            </table></td>
        </tr>
        <tr class="tdbg"> 
          <td> <table width="100%" border="0" cellspacing="5" cellpadding="0">
              <tr class="tdbg_leftall"> 
                <td> <%
		  if TotalPut>0 then
		  	call showpage(strFileName,totalPut,MaxPerPage,true,true,"���û�")
		  end if
		  %> </td>
              </tr>
            </table></td>
        </tr>
      </table></td>
        
        
        <!--end right column--></td>
		</tr><!--end main bocy-->
		
		
		</table><!--end main bocy-->
	
	</div></td></tr>
    <tr><td>    <!--Bottom--><%  call Bottom_All()  %></td></tr>
    </table><!--the great talbe-->
<!--����ҳ��ײ�-->


</table><% call PopAnnouceWindow(400,300) %>
</body>
</html>
<%
set rsArticle=nothing
set rsPic=nothing
call CloseConn()
%>