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
<!--#include file="inc/function.asp"-->
<!--#include file="inc/ubbcode.asp"-->
<!--#include file="inc/admin_code_article.asp"-->
<%
'Response.Write("Line 16")
'Response.End()
dim Action,FoundErr,ErrMsg
dim rs,sql
dim SkinCount,LayoutCount

'���α����ӡ�������������ձ���
'dim  StudentClass , StudentClassName , StudentClassYear , StudentClassNumber
'dim College  'dim TeacherName �˱����Ѷ���,δ֪�ںδ�����

'dim  TermNumber
Action=trim(request("Action"))



'���ձ���
'College=Trim(Request("College"))
'StudentClass=Trim(Request("StudentClassName")) & Trim(Request("StudentClassYear"))  &  Trim(Request("StudentClassNumber"))
'StudentClassName=Trim(Request("StudentClassName"))
'StudentClassYear=Trim(Request("StudentClassYear"))
'StudentClassNumber=Trim(Request("StudentClassNumber"))

'TeacherName=Trim(Request("TeacherName"))

'TermNumber=Trim(Request("TermNumber"))
'Response.Write("Line 38")
'Response.End()
%>
<html>
<head>
<title>����ʱ��༶����</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link href="Admin_Style.css" rel="stylesheet" type="text/css" />
</head>
<body leftmargin="2" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" class="border">
  <tr class="topbg">
    <td height="22" colspan="3" align="center"><strong>����ʱ��༶����</strong></td>
  </tr>
  <tr class="tdbg">
    <td width="70" height="30"><strong>��������</strong></td>
    <td><a href="Admin_Course.asp">����ʱ��༶ | ����</a></td><td align=right>���ͣ�������Ͻ�������ʾ</td>
  </tr>
</table>
<%
if Action="Add" then
	call AddSpecial()
elseif Action="SaveAdd" then
	call SaveAdd()
elseif Action="Modify" then
	call Modify()
elseif Action="SaveModify" then
	call SaveModify()
elseif Action="Del" then
	call DelSpecial()
elseif Action="Clear" then
	call ClearSpecial()
elseif Action="UpOrder" then 
	call UpOrder() 
elseif Action="DownOrder" then 
	call DownOrder() 
elseif Action="Unite" then
	call ShowUniteForm()
elseif Action="UniteSpecial" then
	call UniteSpecial()
elseif Action="Order" then
	call ShowOrder()
	
	
	'˼���������ۿ��������ܣ����α�
elseif Action="CourseDel" then
	call CourseDel()
elseif Action="CourseAdd" then
	call CourseAdd()
	
	
	'�������ܾ���Щ��
else
	call main()
end if
if FoundErr=True then
	call WriteErrMsg()
end if
call CloseConn()

sub main()
if 	AdminPurview=3 then
 call Admin3Course()
 elseif AdminPurview=2 then
 call Admin2Course()
 elseif AdminPurview=1 then
 call Admin1Course()
 end if
%>
<br/>
<%
	
end sub

%>
</body>
</html>
<%
sub Admin3Course()
FoundErr=True
		
		ErrMsg=ErrMsg & "<br><li>ѧ������Աû��Ȩ�޹����ΰ��ţ�</li><!--<li> <a Href=Admin_Course.asp>����</a> </li>-->"
end sub

'��������Ա����ҳ�������
sub Admin1Course()
%>
<table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" class="border">
  <form name='Admin_Course' action='Admin_Course.asp' method='post' id='Admin_Course'>
    <tr class="tdbg" align="center" onMouseOut="this.style.backgroundColor=''" onMouseOver="this.style.backgroundColor='#BFDFFF'"  >
      <!--������ĳһ���趨�п�-->
      <td  align="center"  ><%  call TeacherTrueNameComboBox()	   %></td>
      <td align="center" ><% call SpecialAbbreviationComboBox()  %></td>
      <td><!--�γ�˵����������ڿγ����� ����--></td>
      <td><!--����ʱ��������-->
        <% call TermYear() %>
        &nbsp;
        <% call TermOrder() %></td>
      <td><!--���ΰ༶-->
        <% call StudentClassName() %>
        &nbsp;
        <% call StudentClassYear() %>
        &nbsp;
        <% call StudentClassNumber() %>
        &nbsp;
        <% call College() %></td>
      <td align="center" ><input type='hidden' name='Action' value='CourseAdd' />
        <input name="Submit" type="submit" id="Submit" value="��������" /></td>
    </tr>
  </form>
  <!--���г�ͬһ��ʦ��ͬһ�γ̵Ķ����-->
  <%
    dim rsAdminList 
  	dim rsSpecialList
	'˼���������ۿν�ѧƽ̨�������ܿ���ʱ��༶����ı�������
	dim sqlCourseList
	dim rsCourseList
	'
	'Response.End()
	set rsAdminList=conn.execute("select  ID , TrueName ,TeacherName from Admin where Purview=1 or Purview=2")
	'Response.Write("Line 108")
	
	'ÿλ��ʦ��Ҫ��һ��ѭ����һ�ο��α�
	do while not rsAdminList.eof
	%>
  <tr class="title">
    <!--ÿ����ʦ�Ŀ��Զ�����һ�������-->
    <!-- �����г���ʦ�����γ̵��б�ı�ͷ-->
    <td height="22"  align="center" width="100"><strong>��ʦ����</strong></td>
    <td height="22"  align="center" width="100"><strong>�γ�����</strong></td>
    <td    align="center" width="70"><strong>�γ�˵��</strong></td>
    <td width="100" align="center"><strong>����ʱ��</strong></td>
    <td   width="200" align="center"><strong>�Ͽΰ༶</strong></td>
    <td width="100" align="center"><strong>����</strong></td>
    <!--<td width="110" align="center"><strong>�Ͽΰ༶����ѧԺ</strong></td>-->
    <!--<td width="100" height="22" align="center"><strong> �������</strong></td>-->
  </tr>
  <%
	set rsSpecialList=conn.execute("select SpecialID,SpecialName , ReadMe , SpecialAbbreviation  from Special ")
	if rsSpecialList.bof and rsSpecialList.eof then
		'response.write ("")
		FoundErr=True
		
		ErrMsg=ErrMsg & "<br/><li>�γ��б�Ϊ�գ�������ӿγ̣�</li>"
		rsSpecialList=nothing
		exit sub
		
	else
		do while not rsSpecialList.eof '�б�Ϊ�գ�������ʾȱ�ٶ���
			if   (   InStr( AdminPurview_SpecialID  ,  rsSpecialList("SpecialID")   )   >0 ) then
				Set rsCourseList=Server.CreateObject("Adodb.RecordSet")
				'sql="select * from CourseList , Special , Admin where CourseList.SpecialID=Special.SpecialID and CourseList.TeacherName='" & session("AdminTrueName") &  "'"
				'sqlAdmin="select AdminPurview_SpecialID from Admin"
				sqlCourseList="select * from CourseList where  CourseList.SpecialID=" &      rsSpecialList("SpecialID") & " and TeacherName='" & rsAdminList("TeacherName") & "'"
				rsCourseList.Open sqlCourseList,conn,1,1
				 
			
  %>
  <!--<hr/>-->
  <tr class="tdbg" onMouseOut="this.style.backgroundColor=''" onMouseOver="this.style.backgroundColor='#BFDFFF'">
    <td align="center" rowspan="<%=(rsCourseList.RecordCount+2)%>"><a href="Admin_UserList.asp?Action=CountByTeacher&TeacherName=<%=rsAdminList("TeacherName")%>"  title="���������λ��ʦ��ѧ��"><%=rsAdminList("TeacherName")%></a></td>
    <td align="center" rowspan="<%=(rsCourseList.RecordCount+2)%>"><!--��ʾ�γ�����,�ӵ�һ����Ϊ�˱���룬�ӵڶ�����Ϊ���������α�һ��-->
      <a href="Admin_UserList.asp?Action=CountBySpecial&SpecialID=<%=rsSpecialList("SpecialID")%>" title="�������˿γ̵�ѧ��"><%=rsSpecialList("SpecialAbbreviation")%></a></td>
    <td align="center" rowspan="<%=(rsCourseList.RecordCount+2)%>"><!--��ʾ�γ̼�飬����δʹ��-->
      <%=dvhtmlencode(rsSpecialList("ReadMe"))%></td>
    <!---->
  </tr>
  <!--<td colspan="2"><table>-->
  <% 'if rsCourseList.bof and rsCourseList.eof then
					'		response.write ("������ӿ���ʱ��Ͱ༶�б�")
					'else
         					'response.Write(" <table>  ") %>
  <% 			if  (rsCourseList.bof and rsCourseList.EOF) then
						%>
  <tr class="tdbg"  align="center" onMouseOut="this.style.backgroundColor=''" onMouseOver="this.style.backgroundColor='#BFDFFF'"  >
    <td align="center">δ���ڴ˿γ�</td>
    <td></td>
    <td></td>
  </tr>
  <%
					else
						do while not rsCourseList.EOF %>
  <!--һ���γ̵Ķ����-->
  <!--ѧ���İ༶�ı�ʾ��ʽ��δ������Ϊ�����������б��-->
  <!--ѧ����ѧԺ�ı�ʾ��ʽ��δ������Ϊ�����������б��-->
  <% 'Response.Write("<tr class=tdbg > <td align=center>") %>
  <tr class="tdbg" align="center" onMouseOut="this.style.backgroundColor=''" onMouseOver="this.style.backgroundColor='#BFDFFF'">
    <td align="center"  ><!--��ʾ����ʱ�䣬ʱ������λ����ݺ���������ʾ-->
      <%=rsCourseList("TermYear")%><%=rsCourseList("TermOrder")%></td>
    <td align='center' ><% 
	  Response.Write(rsCourseList("StudentClassName"))
	  Response.Write("&nbsp;&nbsp;")
	  	  Response.Write("&nbsp;")

	  
	  Response.Write(rsCourseList("StudentClassYear"))
	  	  Response.Write("&nbsp;&nbsp;")

	  Response.Write("&nbsp;")

	  Response.Write(rsCourseList("StudentClassNumber"))
	  	  Response.Write("&nbsp;&nbsp;")

	  Response.Write("&nbsp;")

	  %>
      &nbsp;&nbsp;<%
	  Response.Write( "<a href='Admin_UserList.asp?Action=CountByCollege&College='" & rsCourseList("College") & "' title='����鿴��ѧԺ����ѧ��' >" & rsCourseList("College") & "</a>"    )
	  %>
      <% 'Response.Write(" </td> </tr>") %></td>
    <td align="center" ><a  href="Admin_Course.asp?Action=CourseDel&CourseListID=<%=rsCourseList("CourseListID")%>">ɾ������</a></td>
  </tr>
  <%
						rsCourseList.MoveNext
  	 					loop
						'end if
						rsCourseList.Close
						set rsCourseList=Nothing
 		 				%>
  <!--��һ���γ�-->
  <!--��ӿ��α�-->
  <% 'Response.Write("</table>") %>
  <!--</table></td>-->
  <!-- </tr>-->
  <!--<tr>-->
  <!--</tr>-->
  <% 				end if
   				 end if
		%>
  <tr  ></tr>
  <!--<hr/>-->
  <!--�������ӿհ׷ָ�<tr></tr> <tr></tr> <tr></tr> <tr></tr> <tr></tr>-->
  <%
		rsSpecialList.movenext
		loop
	end if
	set rsSpecialList=nothing
  rsAdminList.movenext
  loop
  set rsAdminList=nothing
  
  '��ӿ��α�һ��
  %>
</table>
<%
end sub
'������������Ա����ҳ����
'��Ȩ��Ϊ2�Ľ�ʦ����Ա��ҳ����

sub Admin2Course()
%>
<table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" class="border">
  <form name='Admin_Course' action='Admin_Course.asp' method='post' id='Admin_Course'>
    <tr class="tdbg" align="center" onMouseOut="this.style.backgroundColor=''" onMouseOver="this.style.backgroundColor='#BFDFFF'"  >
      <td align="center" ><% call SpecialAbbreviationComboBox()  %></td>
      <td><!--�γ�˵����������ڿγ����� ����--></td>
      <td><!--����ʱ��������-->
        <% call TermYear() %>
        &nbsp;
        <% call TermOrder() %></td>
      <td><!--���ΰ༶-->
        <% call StudentClassName() %>
        &nbsp;
        <% call StudentClassYear() %>
        &nbsp;
        <% call StudentClassNumber() %>
        &nbsp;
        <% call College() %></td>
      <td align="center"><input type='hidden' name='Action' value='CourseAdd'>
        <input name="Submit" type="submit" id="Submit" value="��������"></td>
    </tr>
  </form>
  <!--���г�ͬһ��ʦ��ͬһ�γ̵Ķ����-->
  <%
  	dim RowCounter
	dim rsSpecialList
	'˼���������ۿν�ѧƽ̨�������ܿ���ʱ��༶����ı�������
	dim sqlCourseList
	dim rsCourseList
	'Response.Write("Line 108")
	'Response.End()
	RowCounter=1
	set rsSpecialList=conn.execute("select SpecialID,SpecialName , ReadMe ,SpecialAbbreviation  from Special ")
	'if rsSpecialList.bof and rsSpecialList.eof then
	'	response.write ("������ӿγ�")
	'else
		do while not rsSpecialList.eof
			if   (   InStr( AdminPurview_SpecialID  ,  rsSpecialList("SpecialID")   )   >0 ) then
				Set rsCourseList=Server.CreateObject("Adodb.RecordSet")
				'sql="select * from CourseList , Special , Admin where CourseList.SpecialID=Special.SpecialID and CourseList.TeacherName='" & session("AdminTrueName") &  "'"
				'sqlAdmin="select AdminPurview_SpecialID from Admin"
				sqlCourseList="select * from CourseList where  CourseList.SpecialID=" &      rsSpecialList("SpecialID") & " and TeacherName='" & session("AdminTeacherName") & "'"
				rsCourseList.Open sqlCourseList,conn,1,1
				 
			
  %>
  <!--<hr/>-->
  <tr class="title">
    <!-- �����г���ʦ�����γ̵��б�ı�ͷ-->
    <td height="22"  align="center" width="100"><strong>�γ�����</strong></td>
    <td  align="center"><strong>�γ�˵��</strong></td>
    <td width="100" align="center"><strong>����ʱ��</strong></td>
    <td   width="200" align="center"><strong>�Ͽΰ༶</strong></td>
    <td width="100" align="center"><strong>����</strong></td>
    <!--<td width="110" align="center"><strong>�Ͽΰ༶����ѧԺ</strong></td>-->
    <!--<td width="100" height="22" align="center"><strong> �������</strong></td>-->
  </tr>
  <tr class="tdbg" onMouseOut="this.style.backgroundColor=''" onMouseOver="this.style.backgroundColor='#BFDFFF'">
    <td align="center" rowspan="<%=(rsCourseList.RecordCount+2)%>"><!--��ʾ�γ�����,�ӵ�һ����Ϊ�˱���룬�ӵڶ�����Ϊ���������α�һ��-->
      <a href="Admin_ArticleManageSpecial.asp?SpecialID=<%=rsSpecialList("SpecialID")%>" title="����������˿γ̵�����"><%=rsSpecialList("SpecialAbbreviation")%></a></td>
    <td align="center" rowspan="<%=(rsCourseList.RecordCount+2)%>"><!--��ʾ�γ̼�飬����δʹ��-->
      <%=dvhtmlencode(rsSpecialList("ReadMe"))%></td>
    <!---->
  </tr>
  <!--<td colspan="2"><table>-->
  <% 'if rsCourseList.bof and rsCourseList.eof then
					'		response.write ("������ӿ���ʱ��Ͱ༶�б�")
					'else
         					'response.Write(" <table>  ") %>
  <% 			if  (rsCourseList.bof and rsCourseList.EOF) then
						%>
  <tr class="tdbg"  align="center" onMouseOut="this.style.backgroundColor=''" onMouseOver="this.style.backgroundColor='#BFDFFF'"  >
    <td align="center">δ���ڴ˿γ�</td>
    <td></td>
    <td></td>
  </tr>
  <%
					else
						do while not rsCourseList.EOF %>
  <!--һ���γ̵Ķ����-->
  <!--ѧ���İ༶�ı�ʾ��ʽ��δ������Ϊ�����������б��-->
  <!--ѧ����ѧԺ�ı�ʾ��ʽ��δ������Ϊ�����������б��-->
  <% 'Response.Write("<tr class=tdbg > <td align=center>") %>
  <tr class="tdbg" align="center" onMouseOut="this.style.backgroundColor=''" onMouseOver="this.style.backgroundColor='#BFDFFF'">
    <td align="center"  ><!--��ʾ����ʱ�䣬ʱ������λ����ݺ���������ʾ-->
      <%=rsCourseList("TermYear")%><%=rsCourseList("TermOrder")%></td>
    <td align='center' ><% 
	  Response.Write(rsCourseList("StudentClassName"))
	  Response.Write(rsCourseList("StudentClassYear"))
	  Response.Write(rsCourseList("StudentClassNumber"))
	  %>
      &nbsp;&nbsp;<%=rsCourseList("College")%>
      <% 'Response.Write(" </td> </tr>") %></td>
    <td align="center" ><a  href="Admin_Course.asp?Action=CourseDel&CourseListID=<%=rsCourseList("CourseListID")%>">ɾ������</a></td>
  </tr>
  <%
						rsCourseList.MoveNext
  	 					loop
						'end if
						rsCourseList.Close
						set rsCourseList=Nothing
 		 				%>
  <!--��һ���γ�-->
  <!--��ӿ��α�-->
  <% 'Response.Write("</table>") %>
  <!--</table></td>-->
  <!-- </tr>-->
  <!--<tr>-->
  <!--</tr>-->
  <% 				end if
   				 end if
		%>
  <tr  ></tr>
  <!--<hr/>-->
  <!--�������ӿհ׷ָ�<tr></tr> <tr></tr> <tr></tr> <tr></tr> <tr></tr>-->
  <%
		rsSpecialList.movenext
		loop
	'end if
	set rsSpecialList=nothing
  
  
  '��ӿ��α�һ��
  %>
</table>
<%
end sub
'������ʦ����Ա������ҳ����

'��ʼ�����������۵��������α����ʽ�Ų��밡
sub CourseAdd()
dim rsCourseAdd , sqlCourseAdd , SpecialID , TermNumber , StudentGradeClass , TermYear , TermOrder ,StudentClassYear , StudentClassName , StudentClassNumber
if Trim(Request("SpecialID"))="" or Trim(Request("TermYear"))="" or Trim(Request("TermOrder"))="" or Trim(Request("College"))="" or Trim(Request("StudentClassName"))="" or Trim(Request("StudentClassYear"))="" or Trim(Request("StudentClassNumber"))=""   then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>��ѡ��ȫ����Ŀ��</li> <!--<a Href=Admin_Course.asp>����</a>-->   "
		'Response.Write(ErrMsg)
'		Call Main()
		'rsCourseAdd.close
		'set rsCourseAdd=nothing
		'response.redirect "Admin_Course.asp"		
		exit sub
		end if
SpecialID=Clng(Trim(Request("SpecialID")))
StudentClassName=Trim(Request("StudentClassName")) 
StudentClassYear=Trim(Request("StudentClassYear"))
StudentClassNumber=Trim(Request("StudentClassNumber"))
TermYear=Clng(Trim(Request("TermYear")))
TermOrder=Trim(Request("TermOrder"))
StudentGradeClass=Trim(Request("StudentClassName")) & Trim(Request("StudentClassYear")) & Trim(Request("StudentClassNumber"))
sqlCourseAdd="Select * from CourseList where SpecialID=" & SpecialID & "and TermYear=" & TermYear & " and TermOrder='" & TermOrder & "' and StudentClassName='" & StudentClassName & "' and StudentClassYear='" & StudentClassYear & "' and StudentClassNumber='" & StudentClassNumber & "'"
	Set rsCourseAdd=Server.CreateObject("Adodb.RecordSet")
	rsCourseAdd.Open sqlCourseAdd,conn,1,3
	if not (rsCourseAdd.bof and rsCourseAdd.EOF) then
		FoundErr=True
		
		ErrMsg=ErrMsg & "<br><li>�˰༶�ڴ�ѧ�����д˿Σ�</li><!--<li> <a Href=Admin_Course.asp>����</a> </li>-->"
		'Response.Write(ErrMsg)
'		Call Main()
		rsCourseAdd.close
		set rsCourseAdd=nothing
		'response.redirect "Admin_Course.asp"		
		exit sub
	else
		rsCourseAdd.addnew
		'��ʹ���˰˸��ֶ�
 	rsCourseAdd("SpecialID")=SpecialID
	rsCourseAdd("TermYear")=TermYear
	rsCourseAdd("TermOrder")=TermOrder
	if AdminPurview=2 then
		rsCourseAdd("TeacherName")=session("AdminTeacherName")
	elseif AdminPurview=1 then
		rsCourseAdd("TeacherName")=Trim(Request("TeacherName"))
	end if
	rsCourseAdd("College")=Trim(Request("College"))
	rsCourseAdd("StudentClassName")=StudentClassName
	rsCourseAdd("StudentClassYear")=StudentClassYear
	rsCourseAdd("StudentClassNumber")=StudentClassNumber
		
	rsCourseAdd.update
    rsCourseAdd.Close
	set rsCourseAdd=Nothing
	end if


response.redirect "Admin_Course.asp"
end sub
'�����������α�


'�ڿ��α���ɾ��һ��
sub CourseDel()
	'dim rsCourseDel , sqlCourseDel
	'Set rsCourseDel=Server.CreateObject("Adodb.RecordSet")
'				sqlCourseDel="select CourseListID from CourseList where                CourseList.CourseListID=" & Trim(Request("CourseListID"))
'				rsCourseList.Open sqlCourseList,conn,1,1
'	
'				rsCourseDel.Close
'				set rsCourseDel=Nothing

	dim CourseListID
	CourseListID=Trim(Request("CourseListID"))
	if CourseListID="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>��ָ��Ҫ�޸ĵĿ��α��CourseListID��</li>"
		exit sub
	else
		CourseListID=Clng(CourseListID)
	end if
	conn.Execute("delete from CourseList where CourseListID=" & CourseListID)
'	conn.execute("update Article set SpecialID=0 where SpecialID=" & SpecialID)
	call CloseConn()      
	response.redirect "Admin_Course.asp"
end sub
'����ɾ�����α�һ�еĴ���
sub SaveAdd()
	dim SpecialName,ReadMe,SkinID,LayoutID,BrowsePurview,AddPurview,rs,mrs,MaxOrderID
	SpecialName=trim(request.Form("SpecialName"))
	ReadMe=trim(request("ReadMe"))
	SkinID=Trim(request("SkinID"))
	LayoutID=trim(request("LayoutID"))
	BrowsePurview=trim(request("BrowsePurview"))
	AddPurview=trim(request("AddPurview"))
	if SpecialName="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>�γ����Ʋ���Ϊ�գ�</li>"
	end if
	
	''������վ��������
	if SpecialName="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>�γ̼�Ʋ���Ϊ�գ�</li>"
	end if

	'����������վ����
	if SkinID="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>��ָ����Ŀ��ɫģ��</li>"
	else
		SkinID=CLng(SkinID)
	end if
	if LayoutID="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>��ָ���������ģ��</li>"
	else
		LayoutID=CLng(LayoutID)
	end if
	if FoundErr=True then
		exit sub
	end if
	set mrs=conn.execute("select max(OrderID) from Special")
	MaxOrderID=mrs(0)
	if isnull(MaxOrderID) then MaxOrderID=0
	Set rs=Server.CreateObject("Adodb.RecordSet")
	rs.open "Select * From Special Where SpecialName='" & SpecialName & "'",conn,1,3
	if not (rs.bof and rs.EOF) then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>�γ������Ѿ����ڣ�</li>"
		rs.close
	    set rs=Nothing
    	exit sub
	end if
    
	'����Ƿ����д˼��
	
	set mrs=conn.execute("select max(OrderID) from Special")
	MaxOrderID=mrs(0)
	if isnull(MaxOrderID) then MaxOrderID=0
	Set rs=Server.CreateObject("Adodb.RecordSet")
	rs.open "Select * From Special Where SpecialAbbreviation='" & Trim(Request("SpecialAbbreviation")) & "'",conn,1,3
	if not (rs.bof and rs.EOF) then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>�γ������Ѿ����ڣ�</li>"
		rs.close
	    set rs=Nothing
    	exit sub
	end if
	'�������
	
	
	
	
	rs.addnew
	rs("OrderID")=MaxOrderID+1
    rs("SpecialName")=SpecialName
	rs("ReadMe")=ReadMe
	rs("SkinID")=SkinID
	rs("LayoutID")=LayoutID
	rs("BrowsePurview")=BrowsePurview
	rs("AddPurview")=AddPurview
	
	'������վ��������
	rs("SpecialAbbreviation")=Trim(Request("SpecialAbbreviation"))
	'��������
	rs.update
    rs.Close
    set rs=Nothing
	Response.Redirect "Admin_Special.asp"  
end sub

sub SaveModify()
	dim SpecialID,SpecialName,ReadMe,SkinID,LayoutID,BrowsePurview,AddPurview
	SpecialID=trim(request("SpecialID"))
	if SpecialID="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>��ָ��Ҫ�޸ĵĿγ�ID��</li>"
		exit sub
	else
		SpecialID=Clng(SpecialID)
	end if
	SpecialName=trim(request.Form("SpecialName"))
	Readme=trim(request("Readme"))
	SkinID=Trim(request("SkinID"))
	LayoutID=trim(request("LayoutID"))
	BrowsePurview=trim(request("BrowsePurview"))
	AddPurview=trim(request("AddPurview"))
	if SpecialName="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>�γ����Ʋ���Ϊ�գ�</li>"
	end if
	
		''������վ��������
	if SpecialName="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>�γ̼�Ʋ���Ϊ�գ�</li>"
	end if

	'����������վ����

	
	if SkinID="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>��ָ����Ŀ��ɫģ��</li>"
	else
		SkinID=CLng(SkinID)
	end if
	if LayoutID="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>��ָ���������ģ��</li>"
	else
		LayoutID=CLng(LayoutID)
	end if
	if FoundErr=True then
		exit sub
	end if
	
	sql="Select * From Special Where SpecialID=" & SpecialID
	Set rs=Server.CreateObject("Adodb.RecordSet")
	rs.open sql,conn,1,3
	if rs.bof and rs.EOF then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>�Ҳ���ָ���Ŀγ̣������Ѿ���ɾ����</li>"
		rs.close
		set rs=nothing
	else
	    rs("SpecialName")=SpecialName
		rs("ReadMe")=ReadMe
		rs("SkinID")=SkinID
		rs("LayoutID")=LayoutID
		rs("BrowsePurview")=BrowsePurview
		rs("AddPurview")=AddPurview
			'������վ��������
		rs("SpecialAbbreviation")=Trim(Request("SpecialAbbreviation"))
	'��������

		
		rs.update
		rs.close
		set rs=nothing
		call CloseConn()
		Response.Redirect "Admin_Special.asp"  
	end if
end sub

sub DelSpecial()
	dim SpecialID
	SpecialID=trim(request("SpecialID"))
	if SpecialID="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>��ָ��Ҫ�޸ĵĿγ�ID��</li>"
		exit sub
	else
		SpecialID=Clng(SpecialID)
	end if
	conn.Execute("delete from Special where SpecialID=" & SpecialID)
	conn.execute("update Article set SpecialID=0 where SpecialID=" & SpecialID)
	call CloseConn()      
	response.redirect "Admin_Special.asp"

end sub

sub ClearSpecial()
	dim SpecialID
	SpecialID=trim(request("SpecialID"))
	if SpecialID="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>��ָ��Ҫ�޸ĵĿγ�ID��</li>"
		exit sub
	else
		SpecialID=Clng(SpecialID)
	end if
	conn.execute("update Article set SpecialID=0 where SpecialID=" & SpecialID)
	call CloseConn()      
	response.redirect "Admin_Special.asp"
end sub

sub UpOrder()
	dim SpecialID,sqlOrder,rsOrder,MoveNum,cOrderID,tOrderID,i,rs
	SpecialID=trim(request("SpecialID"))
	cOrderID=Trim(request("cOrderID"))
	MoveNum=trim(request("MoveNum"))
	if SpecialID="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>�������㣡</li>"
	else
		SpecialID=CLng(SpecialID)
	end if
	if cOrderID="" then
		FoundErr=true
		ErrMsg=ErrMsg & "<br><li>���������</li>"
	else
		cOrderID=Cint(cOrderID)
	end if
	if MoveNum="" then
		FoundErr=true
		ErrMsg=ErrMsg & "<br><li>���������</li>"
	else
		MoveNum=Cint(MoveNum)
		if MoveNum=0 then
			FoundErr=True
			ErrMsg=ErrMsg & "<br><li>��ѡ��Ҫ���������֣�</li>"
		end if
	end if
	if FoundErr=True then
		exit sub
	end if

	dim mrs,MaxOrderID
	set mrs=conn.execute("select max(OrderID) From Special")
	MaxOrderID=mrs(0)+1
	'�Ƚ���ǰ��Ŀ������󣬰�������Ŀ
	conn.execute("update Special set OrderID=" & MaxOrderID & " where SpecialID=" & SpecialID)
	
	'Ȼ��λ�ڵ�ǰ��Ŀ���ϵ���Ŀ��OrderID���μ�һ����ΧΪҪ����������
	sqlOrder="select * From Special where OrderID<" & cOrderID & " order by OrderID desc"
	set rsOrder=server.CreateObject("adodb.recordset")
	rsOrder.open sqlOrder,conn,1,3
	if rsOrder.bof and rsOrder.eof then
		exit sub        '�����ǰ��Ŀ�Ѿ��������棬�������ƶ�
	end if
	i=1
	do while not rsOrder.eof
		tOrderID=rsOrder("OrderID")       '�õ�Ҫ����λ�õ�OrderID����������Ŀ
		conn.execute("update Special set OrderID=OrderID+1 where OrderID=" & tOrderID)
		i=i+1
		if i>MoveNum then
			exit do
		end if
		rsOrder.movenext
	loop
	rsOrder.close
	set rsOrder=nothing
	
	'Ȼ���ٽ���ǰ��Ŀ������Ƶ���Ӧλ�ã���������Ŀ
	conn.execute("update Special set OrderID=" & tOrderID & " where SpecialID=" & SpecialID)
	call CloseConn()      
	response.redirect "Admin_Special.asp"
end sub

sub DownOrder()
	dim SpecialID,sqlOrder,rsOrder,MoveNum,cOrderID,tOrderID,i,rs,PrevID,NextID
	SpecialID=trim(request("SpecialID"))
	cOrderID=Trim(request("cOrderID"))
	MoveNum=trim(request("MoveNum"))
	if SpecialID="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>�������㣡</li>"
	else
		SpecialID=CLng(SpecialID)
	end if
	if cOrderID="" then
		FoundErr=true
		ErrMsg=ErrMsg & "<br><li>���������</li>"
	else
		cOrderID=Cint(cOrderID)
	end if
	if MoveNum="" then
		FoundErr=true
		ErrMsg=ErrMsg & "<br><li>���������</li>"
	else
		MoveNum=Cint(MoveNum)
		if MoveNum=0 then
			FoundErr=True
			ErrMsg=ErrMsg & "<br><li>��ѡ��Ҫ���������֣�</li>"
		end if
	end if
	if FoundErr=True then
		exit sub
	end if

	dim mrs,MaxOrderID
	set mrs=conn.execute("select max(OrderID) From Special")
	MaxOrderID=mrs(0)+1
	'�Ƚ���ǰ��Ŀ������󣬰�������Ŀ
	conn.execute("update Special set OrderID=" & MaxOrderID & " where SpecialID=" & SpecialID)
	
	'Ȼ��λ�ڵ�ǰ��Ŀ���µ���Ŀ��OrderID���μ�һ����ΧΪҪ�½�������
	sqlOrder="select * From Special where OrderID>" & cOrderID & " order by OrderID"
	set rsOrder=server.CreateObject("adodb.recordset")
	rsOrder.open sqlOrder,conn,1,3
	if rsOrder.bof and rsOrder.eof then
		exit sub        '�����ǰ��Ŀ�Ѿ��������棬�������ƶ�
	end if
	i=1
	do while not rsOrder.eof
		tOrderID=rsOrder("OrderID")       '�õ�Ҫ����λ�õ�OrderID����������Ŀ
		conn.execute("update Special set OrderID=OrderID-1 where OrderID=" & tOrderID)
		i=i+1
		if i>MoveNum then
			exit do
		end if
		rsOrder.movenext
	loop
	rsOrder.close
	set rsOrder=nothing
	
	'Ȼ���ٽ���ǰ��Ŀ������Ƶ���Ӧλ�ã���������Ŀ
	conn.execute("update Special set OrderID=" & tOrderID & " where SpecialID=" & SpecialID)
	call CloseConn()      
	response.redirect "Admin_Special.asp"
end sub

sub ShowSpecial()
	dim rsSpecial
	set rsSpecial=conn.execute("select SpecialID,SpecialName from Special")
	if rsSpecial.bof and rsSpecial.eof then
		response.write "<option value=''>������ӿγ�</option>"
	else
		do while not rsSpecial.eof
			response.write "<option value='" & rsSpecial(0) & "'>" & rsSpecial(1) & "</option>"
			rsSpecial.movenext
		loop
	end if
	set rsSpecial=nothing
end sub

sub UniteSpecial()
	dim SpecialID,TargetSpecialID,SuccessMsg
	SpecialID=trim(request("SpecialID"))
	TargetSpecialID=trim(request("TargetSpecialID"))
	if SpecialID="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>��ָ��Ҫ�ϲ��Ŀγ̣�</li>"
	else
		SpecialID=CLng(SpecialID)
	end if
	if TargetSpecialID="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>��ָ��Ŀ��γ̣�</li>"
	else
		TargetSpecialID=CLng(TargetSpecialID)
	end if
	if SpecialID=TargetSpecialID then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>�벻Ҫ����ͬ�γ��ڽ��в���</li>"
	end if
	if FoundErr=True then
		exit sub
	end if
	if FoundErr=True then
		exit sub
	end if
	
	'�������������γ�
	conn.execute("update Article set SpecialID="&TargetSpecialID&" where SpecialID="&SpecialID)
	'ɾ�����ϲ��γ̼��������γ�
	conn.execute("delete from Special where SpecialID="&SpecialID)
		
	SuccessMsg="�γ̺ϲ��ɹ����Ѿ������ϲ��γ̵���������ת��Ŀ��γ��С�"
	call WriteSuccessMsg(SuccessMsg)
end sub

%>
