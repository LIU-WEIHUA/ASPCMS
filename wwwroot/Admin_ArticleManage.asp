<%@language=vbscript codepage=936 %>
<%
option explicit
response.buffer=true	
Const PurviewLevel=2
Const CheckChannelID=2
Const PurviewLevel_Article=3
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
dim PurviewChecked
dim strAdmin,arrAdmin
dim tClass,ClassName,RootID,ParentID,Depth,ParentPath,Child,ChildID,tID,tChild,ClassMaster
dim SkinID,LayoutID,BrowsePurview,AddPurview
dim ManageType
ManageType=trim(request("ManageType"))
PurviewChecked=false
FileName="Admin_ArticleManage.asp"
ClassID=Trim(request("ClassID"))
keyword=trim(request("keyword"))
if keyword<>"" then 
	keyword=ReplaceBadChar(keyword)
end if
strField=trim(request("Field"))
if ClassID="" then
	ClassID=0
	if strField="" and  AdminPurview=2 and AdminPurview_Article=3 and ManageType<>"MyArticle" then
		set tClass=conn.execute("select ClassName,RootID,ParentID,Depth,ParentPath,Child,ClassMaster,ClassID From ArticleClass where ClassMaster like '%" & AdminName & "%'")
		do while not tClass.eof
			if CheckClassMaster(tClass(6),AdminName)=true then
				ClassName=tClass(0)
				RootID=tClass(1)
				ParentID=tClass(2)
				Depth=tClass(3)
				ParentPath=tClass(4)
				Child=tClass(5)
				ClassMaster=tClass(6)
				ClassID=tClass(7)
				PurviewChecked=True
				exit do
			end if
			tClass.movenext
		loop
	end if
else
	ClassID=CLng(ClassID)
end if
if ClassID>0 and PurviewChecked=False then
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
		ClassMaster=tClass(6)
		PurviewChecked=CheckClassMaster(tClass(6),AdminName)
		if PurviewChecked=False and ParentID>0 then
			set tClass=conn.execute("select ClassMaster from ArticleClass where ClassID in (" & ParentPath & ")")
			do while not tClass.eof
				PurviewChecked=CheckClassMaster(tClass(0),AdminName)
				if PurviewChecked=True then exit do
				tClass.movenext
			loop
		end if
	end if
end if
if request("page")<>"" then
    currentPage=cint(request("page"))
else
	currentPage=1
end if
if ManageType="MyArticle" then
	FileName=FileName & "?ManageType=" & ManageType
	strFileName=FileName & "&ClassID=" & ClassID & "&strField=" & strField & "&keyword=" & keyword
else
	strFileName=FileName & "?ClassID=" & ClassID & "&strField=" & strField & "&keyword=" & keyword
end if
%>
<html>
<head>
<title>���¹���</title>
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
	if(document.myform.Action.value=="Del")
	{
		document.myform.action="Admin_ArticleDel.asp";
		if(confirm("ȷ��Ҫɾ��ѡ�е������𣿱���������ѡ�е������Ƶ�����վ�С���Ҫʱ���ɴӻ���վ�лָ���"))
		    return true;
		else
			return false;
	}
	else
	{
		document.myform.action="Admin_ArticleMove.asp";
		if(document.myform.TargetClassID.value=="")
		{
			alert("���ܽ������ƶ�����������Ŀ����Ŀ���ⲿ��Ŀ�У�");
			return false;
		}
		if(confirm("ȷ��Ҫ��ѡ�е������ƶ���ָ������Ŀ��"))
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
    <td height="22" colspan="2"  align="center"><strong>�� �� �� ��</strong></td>
  </tr>
  <tr class="tdbg"> 
    <td width="70" height="30" ><strong>��������</strong></td>
    <td><a href="Admin_ArticleManage.asp">���¹�����ҳ</a>&nbsp;
	<%if AdminPurview=1 or AdminPurview=2  then %>
	|&nbsp;<a href="Admin_ArticleAdd1.asp">������£����ģʽ��</a>&nbsp;|&nbsp;<a href="Admin_ArticleAdd2.asp">������£��߼�ģʽ��</a>&nbsp;
	<%end if%>
	|&nbsp;<a href="Admin_ArticleCheck.asp">�������</a> 
    <%if AdminPurview=1 or AdminPurview_Article<=2 then %>| <a href="Admin_ArticleManageSpecial.asp">�γ����¹���</a><%end if%>
	<%if AdminPurview=1 or AdminPurview_Article=1 then %>| <a href="Admin_ArticleRecyclebin.asp">���»���վ����</a>
    | <a href="Admin_ArticleComment.asp">�������۹���</a><%end if%>
	</td>
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
	<select name='JumpClass' id="JumpClass" onChange="if(this.options[this.selectedIndex].value!=''){location='<%=FileName & "?ClassID="%>'+this.options[this.selectedIndex].value;}">
      <option value='' selected>��ת��Ŀ����</option>
	  <%call Admin_ShowClass_Option(2,0)%>
	</select>
    </td>
  </tr>
</table>
<%
sql="select A.ArticleID,A.ClassID,C.ClassName,A.Title,A.Key,A.Author,A.CopyFrom,A.UpdateTime,A.Editor,A.SpecialID,"'һ��Ҫ��SpcecialID��
sql=sql & "A.Hits,A.OnTop,A.Hot,A.Elite,A.Passed,A.IncludePic,A.Stars,A.PaginationType,A.ReadLevel,A.ReadPoint from Article A"

'�ж�Ȩ��
if AdminPurview=1 then
	sql=sql & " inner join ArticleClass C on A.ClassID=C.ClassID where A.Deleted=False  "
else if AdminPurview=2 then
	sql=sql & " inner join ArticleClass C on A.ClassID=C.ClassID where A.Deleted=False  " & " and ( A.TeacherName='" & session("AdminTeacherName") & "' or A.TeacherName='admin' ) "
else if AdminPurview=3 then
		sql=sql & " inner join ArticleClass C on A.ClassID=C.ClassID where A.Deleted=False  and A.TeacherName='" & session("AdminTeacherName") & "'"

	'sql=sql & " inner join ArticleClass C on A.ClassID=C.ClassID where A.Deleted=False  and A.TeacherName='" & session("AdminTeacherName") & "' and  A.SpecialID like '%" & session("AdminPurview_SpecialID") & ",%' "
end if
end if
end if
'�����ж�



if ClassID>0 then
	if Child>0 then
		ChildID=""
		set tClass=conn.execute("select ClassID from ArticleClass where ParentID=" & ClassID & " or ParentPath like '" & ParentPath & "," & ClassID & ",%'")
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

if ManageType="MyArticle" then
	sql=sql & " and A.Editor='" & AdminName & "' "
else
	if keyword<>"" then
		select case strField
		case "Title"
			sql=sql & " and A.Title like '%" & keyword & "%' "
		case "Content"
			sql=sql & " and A.Content like '%" & keyword & "%' "
		case "Author"
			sql=sql & " and A.Author like '%" & keyword & "%' "
		case "Editor"
			sql=sql & " and A.Editor like '%" & keyword & "%' "
		case else
			sql=sql & " and A.Title like '%" & keyword & "%' "
		end select
	end if
end if
sql=sql & " order by A.ArticleID desc"

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
    <form name="myform" method="Post" action="Admin_ArticleDel.asp" onSubmit="return ConfirmDel();">
     <td><table class="border" border="0" cellspacing="1" width="100%" cellpadding="0">
          <tr class="title" height="22"> 
            <td height="22" width="30" align="center"><strong>ѡ��</strong></td>
            <td width="25" align="center"  height="22"><strong>ID</strong></td>
            <td align="center" ><strong>���±���</strong></td>
            <td width="60" align="center" ><strong>¼��</strong></td>
            <td width="40" align="center" ><strong>�����</strong></td>
            <td width="60" align="center" ><strong>��������</strong></td>
            <td width="40" align="center" ><strong>�����</strong></td>
            <td width="180" align="center" ><strong>����</strong></td>
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
		 
'		 Set rsArticleList_Special= Server.CreateObject("ADODB.Recordset")
'			rsArticleList_Special.open sql_Special,conn,1,3 
'		  if  AdminPurview=1  or   ( not     rsArticleList_Special.eof  )  then 
'		  	 
'				if AdminPurview=1 or rsArticleList("SpecialID")=0 or  (instr( AdminPurview_Special , rsArticleList_Special("SpecialName"))>0)   then	
'			 		if 1 < 3  then
'			  %><!--�����ж�-->
          <tr class="tdbg" onMouseOut="this.style.backgroundColor=''" onMouseOver="this.style.backgroundColor='#BFDFFF'"> 
            <td width="30" align="center"><input name='ArticleID' type='checkbox' onClick="unselectall()" id="ArticleID" value='<%=cstr(rsArticleList("articleID"))%>'></td>
            <td width="25" align="center"><%=rsArticleList("articleid")%></td>
            <td> <%
			if rsArticleList("ClassID")<>ClassID then
				response.write "<a href='" & FileName & "?ClassID=" & rsArticleList("ClassID") & "'>[" & rsArticleList("ClassName") & "]</a>&nbsp;"
			end if
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
            <td width="60" align="center"><%
			response.write "<a href='" & FileName & "?field=Editor&keyword=" & rsArticleList("Editor") & "' title='������鿴���û�¼�����������'>" & rsArticleList("Editor") & "</a>"
			%></td>
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
            <td width="180" align="center"> <%
			if AdminPurview=1 or AdminPurview_Article<=2 or PurviewChecked=true or AdminName=rsArticleList("Editor") then
            	response.write "<a href='Admin_ArticleModify.asp?ArticleID=" & rsArticleList("articleid") &"'>�޸�</a>&nbsp;"
            	response.write "<a href='Admin_ArticleDel.asp?ArticleID=" & rsArticleList("ArticleID") & "&Action=Del' onclick='return ConfirmDel();'>ɾ��</a>&nbsp;"
			end if
			if AdminPurview=1 or AdminPurview_Article<=2 then
				response.write "<a href='Admin_ArticleMove.asp?ArticleID=" & rsArticleList("ArticleID") & "'>�ƶ�</a>&nbsp;"
            end if
			if AdminPurview=1 or AdminPurview_Article<=2 or PurviewChecked=true then
				if rsArticleList("OnTop")=False then	
					response.write "<a href='Admin_ArticleProperty.asp?ArticleID=" & rsArticleList("ArticleID") & "&Action=SetOnTop'>�̶�</a>&nbsp;"
				else
					response.write "<a href='Admin_ArticleProperty.asp?ArticleID=" & rsArticleList("ArticleID") & "&Action=CancelOnTop'>���</a>&nbsp;"
				end if
            	if rsArticleList("Elite")=False then	
					response.write "<a href='Admin_ArticleProperty.asp?ArticleID=" & rsArticleList("ArticleID") & "&Action=SetElite'>��Ϊ�Ƽ�</a>"
				else
					response.write "<a href='Admin_ArticleProperty.asp?ArticleID=" & rsArticleList("ArticleID") & "&Action=CancelElite'>ȡ���Ƽ�</a>"
				end if
            end if
            %></td>
          </tr>
          <%
		ArticleNum=ArticleNum+1
	   	if ArticleNum>=MaxPerPage then exit do
	   	
'		'������վ�����ж�Ȩ�ޡ����Ķδ���
'		
''		end if
''		end if
''		end if
''		
''		rsArticleList_Special.close
'' 		set rsArticleList_Special=nothing
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
    <td width="250" height="30"><input name="chkAll" type="checkbox" id="chkAll" onclick=CheckAll(this.form) value="checkbox">
              ѡ�б�ҳ��ʾ���������� </td>
    <td><input name="submit" type='submit' value='ɾ��ѡ��������' onClick="document.myform.Action.value='Del'" <%if PurviewChecked=False and AdminPurview=2 and AdminPurview_Article>=3 then response.write "disabled"%>>
              <input name="Action" type="hidden" id="Action" value="Del">
               <%
			   if AdminPurview=1 or AdminPurview_Article<=2 then
			   %>&nbsp;&nbsp;&nbsp;&nbsp; 
              <input type="submit" name="Submit" value="��ѡ���������ƶ���" onClick="document.myform.Action.value='MoveToClass'">
              <select name="TargetClassID"><%call Admin_ShowClass_Option(3,ClassID)%></select>
			  <%end if%>
            </td>
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