<%@language=vbscript codepage=936 %>
<%
option explicit
response.buffer=true	
Const PurviewLevel=2
Const CheckChannelID=2
Const PurviewLevel_Article=2
%>
<!--#include file="inc/conn.asp"-->
<!--#include file="inc/config.asp"-->
<!--#include file="Admin_ChkPurview.asp"-->
<!--#include file="inc/ubbcode.asp"-->
<!--#include file="inc/function.asp"-->
<!--#include file="inc/admin_code_article.asp"-->
<%

'�γ��б�����ݿ�����

dim strFileName,FileName
const MaxPerPage=20
dim totalPut,CurrentPage,TotalPages
dim i,j
dim keyword,strField
dim sql,rsArticleList
dim ClassID,SpecialID,SpecialName
FileName="Admin_ArticleManageSpecial.asp"
ClassID=Trim(request("ClassID"))
SpecialID=trim(request("SpecialID"))
keyword=trim(request("keyword"))
if keyword<>"" then 
	keyword=ReplaceBadChar(keyword)
end if
strField=trim(request("Field"))

if ClassID="" then
	ClassID=0
else
	ClassID=CLng(ClassID)
end if
if SpecialID="" then
	SpecialID=0
else
	SpecialID=Clng(SpecialID)
end if
strFileName=FileName & "?SpecialID=" & SpecialID & "&ClassID=" & ClassID & "&strField=" & strField & "&keyword=" & keyword
if request("page")<>"" then
    currentPage=cint(request("page"))
else
	currentPage=1
end if


dim rsSpecial,sqlSpecial
sqlSpecial="select * from Special"
set rsSpecial=server.CreateObject("adodb.recordset")
rsSpecial.open sqlSpecial,conn,1,1

sql="select Article.ArticleID,Article.SpecialID,Special.SpecialName,Article.Title,Article.Key,Article.Author,Article.CopyFrom,Article.UpdateTime,Article.Editor,"
sql=sql & "Article.Hits,Article.OnTop,Article.Hot,Article.Elite,Article.Passed,Article.IncludePic,Article.Stars,Article.PaginationType,Article.ReadLevel,Article.ReadPoint from Article  "
sql=sql & " left join Special on Article.SpecialID=Special.SpecialID where Article.Deleted=False "
'sql=sql & " inner join Special on Article.SpecialID=Special.SpecialID where Article.Deleted=False "

'�ж�Ȩ��

	
 if AdminPurview=2 then
	sql=sql  & " and (Article.TeacherName='" & session("AdminTeacherName") & "' or Article.TeacherName='admin') "
	else if AdminPurview=3 then
				sql=sql & "   and Article.TeacherName='" & session("AdminTeacherName") & "'"

		'sql=sql & "   and Article.TeacherName='" & session("AdminTeacherName") & "' and  Article.SpecialID like '%" & session("AdminPurview_SpecialID") & "%' "
	end if
end if



'�����ж�Ȩ��

if SpecialID>0 then
	sql=sql & " and Article.SpecialID=" & SpecialID
end if
if ClassID>0 then
	sql=sql & " and Article.ClassID=" & ClassID
end if

if strField<>"" then
	if keyword<>"" then
		select case strField
		case "Title"
			sql=sql & " and Title like '%" & keyword & "%' "
		case "Content"
			sql=sql & " and Content like '%" & keyword & "%' "
		case "Author"
			sql=sql & " and Author like '%" & keyword & "%' "
		case "Editor"
			sql=sql & " and Editor like '%" & keyword & "%' "
		case else
			sql=sql & " and Title like '%" & keyword & "%' "
		end select
	end if
end if
sql=sql & " order by Article.articleid desc"

Set rsArticleList= Server.CreateObject("ADODB.Recordset")
rsArticleList.open sql,conn,1,1
'������������
%>
<html>
<head>
<title>�γ����¹���</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta name="GENERATOR" content="Microsoft FrontPage 3.0">
<link rel="stylesheet" type="text/css" href="Admin_Style.css">
<SCRIPT language=javascript>
function unselectall()
{
    if(document.myform.chkAll.checked){
	document.myform.chkAll.checked = document.myform.chkAll.checked&0;
    } 	
}

function CheckAll(form)
  {
  for (var i=0;i<form.elements.length;i++)
    {
    var e = form.elements[i];
    if (e.Name != "chkAll"&&e.disabled==false)
       e.checked = form.chkAll.checked;
    }
  }
function ConfirmDel()
{
	if(document.myform.Action.value=="DelFromSpecial")
	{
		document.myform.action="Admin_ArticleDel.asp";
		if(confirm("ȷ��Ҫ��ѡ�е����´��������γ���ɾ���𣿲����ɹ������½��������κογ̡�"))
		    return true;
		else
			return false;
	}
	else
	{
		document.myform.action="Admin_ArticleMove.asp";
		if(confirm("ȷ��Ҫ��ѡ�е������ƶ���ָ���Ŀγ���"))
		    return true;
		else
			return false;
	}
}

</SCRIPT>
</head>
<body leftmargin="2" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" class="border">
  <tr class="topbg"> 
    <td height="22" colspan="2"  align="center"><strong>�� �� �� �� �� ��</strong></td>
  </tr>
  <tr class='tdbg'> 
    <td width="70"><strong>�γ��б�</strong> </td>
    <td >
      <%
	  'response.Write(session("AdminTeacherName"))
	  'response.Write(session("AdminPurview_SpecialID"))
	 ' response.Write(sql)
if rsSpecial.bof and rsSpecial.eof then
	response.write "û���κογ�"
else
	response.write "<table width=100% border=0 cellspacing=1 cellpadding=2><tr>"
	i=1
	do while not rsSpecial.eof
		if rsSpecial("SpecialID")=SpecialID then
			SpecialName=rsSpecial("SpecialName")
			response.write "<td><a href='" & FileName & "?SpecialID=" & SpecialID & "'><font color=red>" & SpecialName & "</font></a></td>"
		else
			response.write "<td><a href='" & FileName & "?SpecialID=" & rsSpecial("SpecialID") & "'>" & rsSpecial("SpecialName") & "</a></td>"
		end if
		i=i+1
		if i mod 10 =0 then
			response.write "</tr><tr>"
		end if
		rsSpecial.movenext
	loop
	response.write "</tr></table>"
end if
%>
    </td>
  </tr>
</table>
<br>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr> 
    <td height="22">�����ڵ�λ�ã�<a href="Admin_ArticleManageSpecial.asp">�γ����¹���</a>&nbsp;&gt;&gt;&nbsp;<%
if SpecialID=0 then
	response.write "��������"
else
	response.write SpecialName
end if
%>
	</td>
  </tr>
</table>
<%
if rsArticleList.eof and rsArticleList.bof then
	totalPut=0
	if SpecialID=0 then
		response.write "<p align='center'><br>û���κ����£�<br></p>"
	else
		response.write "<p align='center'><br>�˿γ���û���κ����£�<br></p>"
	end if
else
   	totalPut=rsArticleList.recordcount
	if currentpage<1 then
   		currentpage=1
   	end if
   	if (currentpage-1)*MaxPerPage>totalput then
   		if (totalPut mod MaxPerPage)=0 then
     		currentpage= totalPut \ MaxPerPage
	  	else
	      	currentpage= totalPut \ MaxPerPage + 1
   		end if
   	end if
    if currentPage=1 then
       	showContent
       	showpage strFileName,totalput,MaxPerPage,true,true,"ƪ����"
 	else
     	if (currentPage-1)*MaxPerPage<totalPut then
       	   	rsArticleList.move  (currentPage-1)*MaxPerPage
       		dim bookmark
           	bookmark=rsArticleList.bookmark
            showContent
            showpage strFileName,totalput,MaxPerPage,true,true,"ƪ����"
       	else
	        currentPage=1
           	showContent
          	showpage strFileName,totalput,MaxPerPage,true,true,"ƪ����"
	    end if
	end if
end if
rsArticleList.close
set rsArticleList=nothing  


sub showContent
   	dim ArticleNum
    ArticleNum=0
%>
<table width='100%' border="0" cellpadding="0" cellspacing="0"><tr>
    <form name="myform" method="Post" action="Admin_ArticleDel.asp" onSubmit="return ConfirmDel();">
     <td><table class="border" border="0" cellspacing="1" width="100%" cellpadding="0">
          <tr class="title" height="22"> 
            <td height="22" width="30" align="center"><strong>ѡ��</strong></td>
            <td width="25" align="center"  height="22"><strong>ID</strong></td>
            <td width="120" align="center" ><strong>�����γ�</strong></td>
            <td align="center" ><strong>���±���</strong></td>
            <td width="60" align="center" ><strong>¼��</strong></td>
            <td width="40" align="center" ><strong>�����</strong></td>
            <td width="60" align="center" ><strong>��������</strong></td>
            <td width="40" align="center" ><strong>�����</strong></td>
          </tr>
          <% '��ʼ�ж�Ȩ�ޡ�ǰ���SQL��ѯ���Ҫ����SpecialID��.�����ݿ��ÿγ���.
'				  
'		 dim rsArticleList_Special , sql_Special
'		
'		
		 %>
		  <%do while not rsArticleList.eof%>
          <!-- ������վ���룬���ݿγ��ж�Ȩ�ޡ�Admin_ChkPurview.asp�жϹ���ԱȨ�ޡ����δ��뿪ʼ,�����������һ��-->
          <%
'		  '�ж��Ƿ�����ĳ�γ�
'		if   ( rsArticleList("SpecialID") = "" ) then
'			sql_Special="select SpecialID ,SpecialName from Special where SpecialID=0"
'		
'		else
'			sql_Special="select SpecialID ,SpecialName from Special where SpecialID=" &  rsArticleList("SpecialID")
'		
'		end if
'		'�����ж��Ƿ�����ĳ�γ�
'		 
'		 Set rsArticleList_Special= Server.CreateObject("ADODB.Recordset")
'			rsArticleList_Special.open sql_Special,conn,1,3 
'		  if  rsArticleList("SpecialID")=0 or AdminPurview=1  or ( not     rsArticleList_Special.eof  )  then 
'		  	 
'				if rsArticleList("SpecialID")=0 or AdminPurview=1 or (instr( AdminPurview_Special , rsArticleList_Special("SpecialName"))>0)   then	
'			 		if 1 < 3  then
'			  %><!--�����ж�-->
          <tr class="tdbg" onMouseOut="this.style.backgroundColor=''" onMouseOver="this.style.backgroundColor='#BFDFFF'"> 
            <td width="30" align="center"><input name='ArticleID' type='checkbox' onClick="unselectall()" id="ArticleID" value='<%=cstr(rsArticleList("articleID"))%>'></td>
            <td width="25" align="center"><%=rsArticleList("articleid")%></td>
            <td width="160" align="center"><%
			if rsArticleList("SpecialID")>0  then
				response.write "<a href='" & FileName & "?SpecialID=" & rsArticleList("SpecialID") & "'>" & rsArticleList("SpecialName") & "</a>"
			else
				response.write "&nbsp;"
			end if
			%></td>
            <td> <%
			if rsArticleList("IncludePic")=true then
				response.write "<font color=blue>[ͼ��]</font>"
			end if
			response.write "<a href='Admin_ArticleShow.asp?ArticleID=" & rsArticleList("articleid") & "'"
			response.write " title='��    �⣺" & rsArticleList("Title") & vbcrlf & "��    �ߣ�" & rsArticleList("Author") & vbcrlf & "ת �� �ԣ�" & rsArticleList("CopyFrom") & vbcrlf & "����ʱ�䣺" & rsArticleList("UpdateTime") & vbcrlf
			response.write "�� �� ����" & rsArticleList("Hits") & vbcrlf & "�� �� �֣�" & mid(rsArticleList("Key"),2,len(rsArticleList("Key"))-2) & vbcrlf & "�Ƽ��ȼ���"
			if rsArticleList("Stars")=0 then
				response.write "��"
			else
				response.write string(rsArticleList("Stars"),"��")
			end if			
			response.write vbcrlf & "��ҳ��ʽ��"
			if rsArticleList("PaginationType")=0 then
				response.write "����ҳ"
			elseif rsArticleList("PaginationType")=1 then
				response.write "�Զ���ҳ"
			elseif rsArticleList("PaginationType")=2 then
				response.write "�ֶ���ҳ"
			end if
			response.write vbcrlf & "�Ķ��ȼ���"	
			if rsArticleList("ReadLevel")=9999 then
				response.write "�ο�"
			elseif  rsArticleList("ReadLevel")=999 then
				response.write "ע���û�"
			elseif  rsArticleList("ReadLevel")=99 then
				response.write "�շ��û�"
			elseif  rsArticleList("ReadLevel")=9 then
				response.write "VIP�û�"
			elseif  rsArticleList("ReadLevel")=5 then
				response.write "����Ա"
			end if
			response.write vbcrlf & "�Ķ�������" & rsArticleList("ReadPoint")
			response.write "'>" & rsArticleList("title") & "</a>"
			%></td>
            <td width="60" align="center">
              <%
			response.write "<a href='" & FileName & "?field=Editor&keyword=" & rsArticleList("Editor") & "' title='������鿴���û�¼�����������'>" & rsArticleList("Editor") & "</a>"
			%>
            </td>
            <td width="40" align="center"><%= rsArticleList("Hits") %></td>
            <td width="60" align="center"> <%
			if rsArticleList("OnTop")=true then
				response.Write "<font color=blue>��</font> "
			else
				response.write "&nbsp;&nbsp;&nbsp;"
			end if
			if rsArticleList("Hits")>=HitsOfHot then
				response.write "<font color=red>��</a> "
			else
				response.write "&nbsp;&nbsp;&nbsp;"
			end if
			if rsArticleList("Elite")=true then
				response.write "<font color=green>��</a>"
			else
				response.write "&nbsp;&nbsp;"
			end if
			%> </td>
            <td width="40" align="center"> <%
			if rsArticleList("Passed")=true then
				response.write "��"
			else
				response.write "��"
			end if%></td>
          </tr>
          <%
		ArticleNum=ArticleNum+1
	   	if ArticleNum>=MaxPerPage then exit do
'	   	'������վ�����ж�Ȩ�ޡ����Ķδ���
'		
'		end if
'		end if
'		end if
'		
'		rsArticleList_Special.close
' 		set rsArticleList_Special=nothing
'		 '����������վ�����ж�Ȩ��
		rsArticleList.movenext
	loop
	'������վ����д��Ȩ����ʾ
   if  ArticleNum=0 then
    response.Write("<font color=blue><div align=center><strong>������Ȩ�޷�Χ��û�з������������¡�</strong></div></font>")
   end if
 
   '����������վ����д��Ȩ����ʾ.��δ������
%>
        </table>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td width="200" height="30"><input name="chkAll" type="checkbox" id="chkAll" onclick=CheckAll(this.form) value="checkbox">
              ѡ�б�ҳ��ʾ���������� </td>
    <td nowrap><input name="submit" type='submit' value='��ѡ�������´������γ���ɾ��' onClick="document.myform.Action.value='DelFromSpecial'">
              <input name="Action" type="hidden" id="Action" value="DelFromSpecial">
              &nbsp;&nbsp; 
              <input type="submit" name="Submit" value="��ѡ���������ƶ���" onClick="document.myform.Action.value='MoveToSpecial'">
              <select name="SpecialID" id="SpecialID"  >
      <%
if rsSpecial.bof and rsSpecial.eof then
	response.write "<option value=''>û���κογ�</option>"
else
	rsSpecial.movefirst
	do while not rsSpecial.eof
		response.write "<option value='" & rsSpecial("SpecialID") & "'>" & rsSpecial("SpecialName") & "</option>"
		rsSpecial.movenext
	loop
end if
%>
			  </select> </td>
  </tr>
</table>
</td>
</form></tr></table>
<%
end sub
%>
<br>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="border">
  <tr class="tdbg">
    <td width="80" align="right"><strong>����������</strong></td>
    <td>
      <%call Admin_ShowSearchForm(FileName,2)%>
    </td>
  </tr>
</table>
</body>
</html>
<%
rsSpecial.close
set rsSpecial=nothing
call CloseConn()
%>