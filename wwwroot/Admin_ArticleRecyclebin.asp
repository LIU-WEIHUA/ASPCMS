<%@language=vbscript codepage=936 %>
<%
option explicit
response.buffer=true	
Const PurviewLevel=2
Const CheckChannelID=2
Const PurviewLevel_Article=1
%>
<!--#include file="inc/conn.asp"-->
<!--#include file="inc/config.asp"-->
<!--#include file="Admin_ChkPurview.asp"-->
<!--#include file="inc/ubbcode.asp"-->
<!--#include file="inc/function.asp"-->
<!--#include file="inc/admin_code_article.asp"-->
<%
dim strFileName,FileName
const MaxPerPage=20
dim totalPut,CurrentPage,TotalPages
dim i,j
dim keyword,strField
dim sql,rsArticleList
dim ClassID
dim strAdmin,arrAdmin
dim tClass,ClassName,RootID,ParentID,Depth,ParentPath,Child,ChildID,tID,tChild,ClassMaster
dim ManageType
ManageType=trim(request("ManageType"))
FileName="Admin_ArticleRecyclebin.asp"
ClassID=Trim(request("ClassID"))
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
if ClassID>0 then
	set tClass=conn.execute("select ClassName,RootID,ParentID,Depth,ParentPath,Child,ClassMaster From ArticleClass where ClassID=" & ClassID)
	if tClass.bof and tClass.eof then
		founderr=True
		ErrMsg=ErrMsg & "<br><li>�Ҳ���ָ������Ŀ</li>"
		Call WriteErrMsg()
		response.end
	else
		ClassName=tClass(0)
		RootID=tClass(1)
		ParentID=tClass(2)
		Depth=tClass(3)
		ParentPath=tClass(4)
		Child=tClass(5)
	end if
end if
strFileName=FileName & "?ClassID=" & ClassID & "&strField=" & strField & "&keyword=" & keyword
if request("page")<>"" then
    currentPage=cint(request("page"))
else
	currentPage=1
end if
%>
<html>
<head>
<title>����վ����</title>
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
    if (e.Name != "chkAll")
       e.checked = form.chkAll.checked;
    }
  }
function ConfirmDel()
{
	if(document.myform.Action.value=="ConfirmDel")
	{
		if(confirm("ȷ��Ҫ����ɾ��ѡ�е�������һ��ɾ�������ָܻ���"))
			return true;
		else
			return false;
	}
	else if(document.myform.Action.value=="ClearRecyclebin")
	{
		if(confirm("ȷ��Ҫ��ջ���վ��һ����ս����ָܻ���"))
			return true;
		else
			return false;
	}
}
</SCRIPT>
</head>
<body leftmargin="2" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" border="0" align="center" cellpadding="5" cellspacing="0" class="border">
  <tr class="topbg"> 
    <td height="22" colspan="2"  align="center"><strong>�� �� վ �� ��</strong></td>
  </tr>
  <tr class="tdbg"> 
    <td width="70" height="30" ><strong>��������</strong></td>
    <td><a href="Admin_ArticleRecyclebin.asp">����վ������ҳ</a> | <a href="Admin_ArticleDel.asp?Action=ClearRecyclebin" onclick="return confirm('ȷ��Ҫ��ջ���վ��һ����ս��޷��ָ���');">��ջ���վ</a> 
      | <a href="Admin_ArticleDel.asp?Action=RestoreAll" onclick="return confirm('ȷ����ԭ����վ�е��������£�');">��ԭ����վ�е���������</a></td>
  </tr>
</table>
<br>
<table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" class="border">
  <tr class="title"> 
    <td height="22"><%call Admin_ShowRootClass()%></td>
  </tr>
</table>
<br>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr> 
    <td height="22"><%call Admin_ShowPath("����վ����")%></td>
    <td width="200" height="22" align="right">
	<select name='JumpClass' id="JumpClass" onchange="if(this.options[this.selectedIndex].value!=''){location='<%=FileName & "?ClassID="%>'+this.options[this.selectedIndex].value;}">
      <option value='' selected>��ת��Ŀ����</option>
	  <%call Admin_ShowClass_Option(2,0)%>
	</select>
    </td>
  </tr>
</table>
<%
sql="select Article.ArticleID,Article.ClassID,ArticleClass.ClassName,Article.Title,Article.Key,Article.Author,Article.CopyFrom,Article.UpdateTime,Article.Editor,"
sql=sql & "Article.Hits,Article.OnTop,Article.Hot,Article.Elite,Article.Passed,Article.IncludePic,Article.Stars,Article.PaginationType,Article.ReadLevel,Article.ReadPoint from article"
sql=sql & " inner join ArticleClass on Article.ClassID=ArticleClass.ClassID where Article.Deleted=True "
if ClassID>0 then
	if Child>0 then
		ChildID=""
		set tClass=conn.execute("select ClassID from ArticleClass where ParentPath like '" & ParentPath & "," & ClassID & "%'")
		do while not tClass.eof
			if ChildID="" then
				ChildID=tClass(0)
			else
				ChildID=ChildID & "," & tClass(0)
			end if
			tClass.movenext
		loop
		sql=sql & " and Article.ClassID in (" & ChildID & ")"
	else
		sql=sql & " and Article.ClassID=" & ClassID
	end if
end if
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
sql=sql & " order by Article.articleid desc"

Set rsArticleList= Server.CreateObject("ADODB.Recordset")
rsArticleList.open sql,conn,1,1
if rsArticleList.eof and rsArticleList.bof then
	totalPut=0
	if Child=0 then
		response.write "<p align='center'><br>û���κα�ɾ�������£�<br></p>"
	else
		response.write "<p align='center'><br>����Ŀ����һ������Ŀ��û���κα�ɾ�������£�<br></p>"
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
    <form name="myform" method="Post" action="Admin_ArticleDel.asp" onsubmit="return ConfirmDel();">
     <td><table class="border" border="0" cellspacing="1" width="100%" cellpadding="0">
          <tr class="title" height="22"> 
            <td height="22" width="30" align="center"><strong>ѡ��</strong></td>
            <td width="25" align="center"  height="22"><strong>ID</strong></td>
            <td align="center" ><strong>���±���</strong></td>
            <td width="60" align="center" ><strong>¼��</strong></td>
            <td width="40" align="center" ><strong>�����</strong></td>
            <td width="60" align="center" ><strong>��������</strong></td>
            <td width="40" align="center" ><strong>�����</strong></td>
            <td width="100" align="center" ><strong>����</strong></td>
          </tr>
          <%do while not rsArticleList.eof%>
          <tr class="tdbg" onmouseout="this.style.backgroundColor=''" onmouseover="this.style.backgroundColor='#BFDFFF'"> 
            <td width="30" align="center"><input name='ArticleID' type='checkbox' onclick="unselectall()" id="ArticleID" value='<%=cstr(rsArticleList("articleID"))%>'></td>
            <td width="25" align="center"><%=rsArticleList("articleid")%></td>
            <td> <%
			if rsArticleList("ClassID")<>ClassID then
				response.write "<a href='" & FileName & "?ClassID=" & rsArticleList("ClassID") & "'>[" & rsArticleList("ClassName") & "]</a>&nbsp;"
			end if
			if rsArticleList("IncludePic")=true then
				response.write "<font color=blue>[ͼ��]</font>"
			end if
			response.write rsArticleList("title")
			%></td>
            <td width="60" align="center"><%= rsArticleList("Editor") %></td>
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
            <td width="100" align="center"><a href="Admin_ArticleDel.asp?Action=ConfirmDel&ArticleID=<%=rsArticleList("ArticleID")%>" onclick='return ConfirmDel();'>����ɾ��</a> 
              <a href="Admin_ArticleDel.asp?Action=Restore&ArticleID=<%=rsArticleList("ArticleID")%>">��ԭ</a></td>
          </tr>
          <%
		ArticleNum=ArticleNum+1
	   	if ArticleNum>=MaxPerPage then exit do
	   	rsArticleList.movenext
	loop
%>
        </table>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td width="200" height="30"><input name="chkAll" type="checkbox" id="chkAll" onclick=CheckAll(this.form) value="checkbox">
              ѡ�б�ҳ��ʾ���������� </td>
    <td><input name="Action" type="hidden" id="Action2" value="ConfirmDel">
              <input name="submit1" type='submit' id="submit1" onClick="document.myform.Action.value='ConfirmDel'" value='����ɾ��ѡ��������'>
              <input type="submit" name="Submit2" value="��ջ���վ"  onClick="document.myform.Action.value='ClearRecyclebin'">
              &nbsp;&nbsp;&nbsp;&nbsp; 
              <input name="Submit3" type="submit" id="Submit3"  onClick="document.myform.Action.value='Restore'" value="��ԭѡ��������">
              <input name="Submit4" type="submit" id="Submit4" onClick="document.myform.Action.value='RestoreAll'" value="��ԭ��������"></td>
  </tr>
</table>
</td>
</form></tr></table>
<%
end sub

if ClassID>0 and Child>0 then
%>
<br>
<table width="100%" height="5" border="0" cellpadding="0" cellspacing="0"><tr><td></td></tr></table>
<table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" class='border'>
  <tr height="20" class='tdbg'>
    <td width='150' align="right">��<%response.write "<a href='" & strFileName & "'>" & ClassName & "</a>"%>������Ŀ������</td>
	<td><%call Admin_ShowChild()%></td></tr>
</table>
<%
end if
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
call CloseConn()
%>