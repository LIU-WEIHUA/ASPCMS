<!--#include file="Inc/syscode_article.asp"-->
<%
'����Ķ����������д���
const ChannelID=2
Const ShowRunTime="Yes"
MaxPerPage=20
strFileName="Article_Class.asp?ClassID=" & ClassID & "&SpecialID=" & SpecialID
Set rsArticle= Server.CreateObject("ADODB.Recordset")
Set rsPic= Server.CreateObject("ADODB.Recordset")
%>
<html>
<head>
<title><%=strPageTitle%></title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<!--#include file="inc/Skin_CSS.asp"-->
<%call MenuJS()%>
</head>
<body <%=Body_Label%> onmousemove='HideMenu()'  bgcolor=#ffffff style="BACKGROUND-COLOR: #ffffff">
<%
dim sqlRoot,rsRoot,trs,arrClassID,TitleStr
sqlRoot="select C.ClassID,C.ClassName,C.RootID,L.LayoutFileName,L.LayoutID,C.Child,C.ParentPath From ArticleClass C inner join Layout L on C.LayoutID=L.LayoutID where C.ParentID=" & ClassID & " and C.IsElite=True and C.LinkUrl='' and C.BrowsePurview>=" & UserLevel & " order by C.OrderID"
Set rsRoot= Server.CreateObject("ADODB.Recordset")
rsRoot.open sqlRoot,conn,1,1
%>
<table><!--the great talbe--><tr><td>
<%	call Top_noIndex() %></td></tr>
	
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
        	<td  valign="top"> <%
	if rsRoot.bof and rsRoot.eof then
	%> <table width="748" border="0" valign="top" align="center" cellpadding="0" cellspacing="5" bgcolor="#F7EFDE">
              <tr> 
                <td valign="top" align="left">&nbsp;&nbsp;&nbsp;&nbsp;<font face="����" color="#FF3300"><strong>��<%=ClassName%>�������б�</strong></font></td>
              </tr>
            </table>
            <table width="100%" border="0" valign="top" align="center" cellpadding="0" cellspacing="5" bgcolor="#FFFFFF">
              <tr> 
                <td height="198" valign="top" align="left" background="images/fcbg2.gif"><%call ShowArticle(30)%> </td>
              </tr>
            </table>
            <%
		  if totalput>0 then
		  	call showpage(strFileName,totalput,MaxPerPage,false,true,"ƪ����")
		  end if
		  %> <%
	else
		do while not rsRoot.eof
%> <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td><table width="98%" border="0" align="center" cellpadding="0" cellspacing="5" bgcolor="#F7EFDE">
                    <tr> 
                      <td>&nbsp;&nbsp;&nbsp;&nbsp; <%
				arrClassID=rsRoot(0)
				response.write "<a href='" & rsRoot(3) & "?ClassID=" & rsRoot(0) & "'>" & rsRoot(1) & "</a>"
				if rsRoot(5)>0 then
					response.write "��"
					set trs=conn.execute("select top 4 C.ClassID,C.ClassName,C.RootID,L.LayoutFileName,L.LayoutID From ArticleClass C inner join Layout L on C.LayoutID=L.LayoutID where C.ParentID=" & rsRoot(0) & " and C.IsElite=True and C.LinkUrl=''  and C.BrowsePurview>=" & UserLevel & " order by C.OrderID")
					do while not trs.eof
						response.write "&nbsp;&nbsp;<a href='" & trs(3) & "?ClassID=" & trs(0) & "'>" & trs(1) & "</a>"
						trs.movenext
					loop
					set trs=conn.execute("select ClassID from ArticleClass where ParentID=" & rsRoot(0) & " or ParentPath like '%" & rsRoot(6) & "," & rsRoot(0) & ",%' and Child=0 and LinkUrl='' and BrowsePurview>=" & UserLevel)
					do while not trs.eof
						arrClassID=arrClassID & "," & trs(0)
						trs.movenext
					loop
				end if
				%> </td>
                    </tr>
                  </table></td>
              </tr>
              <tr> 
                <td height="57" align="center"><table bgcolor="#FFFFFF" width="98%" border="0" align="center" cellpadding="0" cellspacing="5">
                    <tr> 
                      <td height="24" colspan="2" valign="top"><table width="99%" border="0" align="center" cellpadding="0" cellspacing="0">
                          <tr> 
                            <td background="images/fcbg2.gif"> <%
sql="select top 5 A.ArticleID,A.ClassID,L.LayoutID,L.LayoutFileName,A.Title,A.Key,A.Author,A.CopyFrom,A.UpdateTime,A.Editor,A.TitleFontColor,A.TitleFontType,"
sql=sql & "A.Hits,A.OnTop,A.Hot,A.Elite,A.Passed,A.IncludePic,A.Stars,A.PaginationType,A.ReadLevel,A.ReadPoint,A.DefaultPicUrl from Article A"
sql=sql & " inner join Layout L on A.LayoutID=L.LayoutID where A.Deleted=False and A.Passed=True and A.ClassID in (" & arrClassID & ")  order by A.ArticleID desc"
rsArticle.open sql,conn,1,1
if rsArticle.bof and  rsArticle.eof then
	response.write "<li>û���κ�����</li>"
else
	call ArticleContent(30,True,True,True,1,True,True)
end if
rsArticle.close
				%> </td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr> 
                      <td width="510" height="18" valign="top" background="images/fcbg2.gif"><div align="right"> 
                        </div></td>
                      <td width="53" valign="top" background="images/fcbg2.gif"> 
                        <%response.write "<a href='" & rsRoot(3) & "?ClassID=" & rsRoot(0) & "'>more...</a>"%> </td>
                    </tr>
                  </table></td>
              </tr>
            </table>
            <%
			rsRoot.movenext
		loop
	end if
	rsRoot.close
	set rsRoot=nothing
%> <table width='98%' border='0' align="center" cellpadding='0' cellspacing='5' bgcolor="#FFFFFF">
              <tr> 
                <td width="19%" height="18" align="right"> <div align="right">վ����������&nbsp;&nbsp;</div></td>
                <td width="81%" align="left"> <% call ShowSearchForm("Article_Search.asp",2) %> </td>
              </tr>
            </table></td>
        
        
        <!--end right column--></td>
		</tr><!--end main bocy-->
		
		
		</table><!--end main bocy-->
	
	</div></td></tr>
	<tr><td>    <!--Bottom--><%  call Bottom_All()  %></td></tr>
    </table><!--the great talbe-->
</body>
</html>
<%
set rsArticle=nothing
set rsPic=nothing
call CloseConn()
%>