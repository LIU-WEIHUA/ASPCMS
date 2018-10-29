<%@language=vbscript codepage=936 %>
<%
option explicit
response.buffer=true	
%>
<!--#include file="inc/conn.asp"-->
<!--#include file="inc/Conn_User.asp"-->
<!--#include file="inc/config.asp"-->
<!--#include file="inc/ubbcode.asp"-->
<!--#include file="inc/function.asp"-->
<!--#include file="inc/admin_code_article.asp"-->
<%
if CheckUserLogined()=False then
	response.Redirect "User_Login.asp"
end if
dim strFileName,FileName
const MaxPerPage=20
dim totalPut,CurrentPage,TotalPages
dim i,j
dim keyword,strField
dim sql,rsArticleList
dim ClassID
dim ManageType
dim PurviewChecked
dim strAdmin,arrAdmin
dim AdminPurview,AdminPurview_Article 
dim tClass,ClassName,RootID,ParentID,Depth,ParentPath,Child,ChildID,tID,tChild,ClassMaster
FileName="User_ArticleManage.asp"
ClassID=Trim(request("ClassID"))
keyword=trim(request("keyword"))
if keyword<>"" then 
	keyword=ReplaceBadChar(keyword)
end if
strField=trim(request("Field"))
UserName=Trim(Request.Cookies("asp163")("UserName"))
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
<title>���¹���</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta name="GENERATOR" content="Microsoft FrontPage 3.0">
<link rel="stylesheet" type="text/css" href="Admin_style.css">
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
   if(confirm("ȷ��Ҫɾ��ѡ�е�������һ��ɾ�������ָܻ���"))
     return true;
   else
     return false;
	 
}

</SCRIPT>
</head>
<body leftmargin="2" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" class="border">
  <tr class="topbg"> 
    <td height="22" colspan="2"  align="center"><strong>�� �� �� �� ��<%=UserName%>�����£�</strong></td>
  </tr>
  <tr class="tdbg"> 
    <td width="70" height="30" ><strong>��������</strong></td>
    <td><a href="User_ArticleManage.asp">���¹�����ҳ</a>&nbsp;|&nbsp;<a href="User_ArticleAdd.asp">�������</a>&nbsp;|&nbsp;<a href="User_Articlere.asp">���˻ص�����</a></td>
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
    <td height="22"><%call Admin_ShowPath("���¹���")%></td>
    <td width="200" height="22" align="right">
	<select name='JumpClass' id="JumpClass" onchange="if(this.options[this.selectedIndex].value!=''){location='<%=FileName & "?ClassID="%>'+this.options[this.selectedIndex].value;}">
      <option value='' selected>��ת��Ŀ����</option>
	  <%call Admin_ShowClass_Option(2,0)%>
	</select>
    </td>
  </tr>
</table>
<%
sql="select A.ArticleID,A.ClassID,C.ClassName,A.Title,A.Key,A.Author,A.CopyFrom,A.UpdateTime,A.Editor,"
sql=sql & "A.Hits,A.OnTop,A.Hot,A.Elite,A.Passed,A.IncludePic,A.Stars,A.PaginationType,A.ReadLevel,A.ReadPoint from Article A"
sql=sql & " inner join ArticleClass C on A.ClassID=C.ClassID where A.Deleted=False and A.nopass=False and A.Editor='" & UserName & "' "
if ClassID>0 then
	if Child>0 then
		ChildID=""
		if Depth<=0 then
			set tClass=conn.execute("select ClassID from ArticleClass where ParentID=" & ClassID  & " or ParentPath like '" & ClassID & ",%'")
		else
			set tClass=conn.execute("select ClassID from ArticleClass where ParentID=" & ClassID & " or ParentPath like '" & ParentPath & "," & ClassID & ",%'")
		end if
		do while not tClass.eof
			if ChildID="" then
				ChildID=tClass(0)
			else
				ChildID=ChildID & "," & tClass(0)
			end if
			tClass.movenext
		loop
		sql=sql & " and A.ClassID in (" & ChildID & ")"
	else
		sql=sql & " and A.ClassID=" & ClassID
	end if
end if

if keyword<>"" then
	select case strField
		case "Title"
			sql=sql & " and A.Title like '%" & keyword & "%' "
		case "Content"
			sql=sql & " and A.Content like '%" & keyword & "%' "
		case "Author"
			sql=sql & " and A.Author like '%" & keyword & "%' "
		case else
			sql=sql & " and A.Title like '%" & keyword & "%' "
	end select
end if
sql=sql & " order by A.ArticleID desc"

Set rsArticleList= Server.CreateObject("ADODB.Recordset")
rsArticleList.open sql,conn,1,1
Set rsArticleList= Server.CreateObject("ADODB.Recordset")
rsArticleList.open sql,conn,1,1
if rsArticleList.eof and rsArticleList.bof then
	totalPut=0
	if Child=0 then
		response.write "<p align='center'><br>û���κ����£�<br></p>"
	else
		response.write "<p align='center'><br>����Ŀ����һ������Ŀ��û���κ����£�<br></p>"
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
    <form name="myform" method="Post" action="User_ArticleDel.asp" onsubmit="return ConfirmDel();">
     <td><table class="border" border="0" cellspacing="1" width="100%" cellpadding="0" style="word-break:break-all">
    <tr class="title"> 
      <td width="30" height="22" align="center"><strong>ѡ��</strong></td>
      <td width="25" align="center"  height="22"><strong>ID</strong></td>
      <td height="22" align="center" ><strong>���±���</strong></td>
      <td width="60" height="22" align="center" ><strong>����</strong></td>
      <td width="60" height="22" align="center" ><strong>����ʱ��</strong></td>
      <td width="40" height="22" align="center" ><strong>�����</strong></td>
      <td width="60" height="22" align="center" ><strong>����</strong></td>
    </tr>
    <%do while not rsArticleList.eof%>
    <tr class="tdbg"> 
      <td width="30" align="center"><input name='ArticleID' type='checkbox' onclick="unselectall()" id="ArticleID" value='<%=cstr(rsArticleList("articleID"))%>' <%if rsArticleList("Passed")=True then response.write "disabled" %>></td>
      <td width="25" align="center"><%=rsArticleList("articleid")%></td>
            <td>
              <%
			if rsArticleList("ClassID")<>ClassID then
				response.write "<a href='" & FileName & "?ClassID=" & rsArticleList("ClassID") & "'>[" & rsArticleList("ClassName") & "]</a>&nbsp;"
			end if
			if rsArticleList("IncludePic")=true then
				response.write "<font color=blue>[ͼ��]</font>"
			end if
			response.write "<a href='User_ArticleShow.asp?ArticleID=" & rsArticleList("articleid") & "'"
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
			%>
            </td>
      <td width="60" align="center"><%= rsArticleList("Author") %></td>
      <td width="60" align="center"><%= FormatDateTime(rsArticleList("UpdateTime"),2) %></td>
      <td width="40" align="center"><%if rsArticleList("Passed")=true then response.write "��" else response.write "��" end if%></td>
      <td width="60" align="center"> <%if rsArticleList("Passed")=False then%> <a href="User_ArticleModify.asp?ArticleID=<%=rsArticleList("articleid")%>">�޸�</a> 
        <a href="User_ArticleDel.asp?ArticleID=<%=rsArticleList("ArticleID")%>&Action=Del" onclick="return ConfirmDel();">ɾ��</a> 
        <%end if%> </td>
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
    <td width="300" height="30"><input name="chkAll" type="checkbox" id="chkAll" onclick=CheckAll(this.form) value="checkbox">
              ѡ�б�ҳ��ʾ���������� </td>
    <td><input name="submit" type='submit' value='ɾ��ѡ��������'>
              <input name="Action" type="hidden" id="Action" value="Del"></td>
  </tr>
</table></td>
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