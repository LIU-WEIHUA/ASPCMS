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
dim Action,FoundErr,ErrMsg
dim rs,sql
dim SkinCount,LayoutCount
Action=trim(request("Action"))
%>
<html>
<head>
<title>�γ̹���</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="Admin_Style.css" rel="stylesheet" type="text/css">
</head>
<body leftmargin="2" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" class="border">
  <tr class="topbg"> 
    <td height="22" colspan="2" align="center"><strong>�� �� �� ��</strong></td>
  </tr>
  <tr class="tdbg"> 
    <td width="70" height="30"><strong>��������</strong></td>
    <td><a href="Admin_Course.asp">�γ̹���</a> | <a href="Admin_Course_Add.asp">����¿γ�</a></td>
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
else
	call main()
end if
if FoundErr=True then
	call WriteErrMsg()
end if
call CloseConn()

sub main()
	Set rs=Server.CreateObject("Adodb.RecordSet")
	sql="select * from CourseList , Special , Admin where CourseList.SpecialID=Special.SpecialID and CourseList.TeacherName='" & session("AdminTrueName") &  "'"
	rs.Open sql,conn,1,1
%>
<br>
<table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" class="border">
  <tr class="title"><!-- �����г���ʦ�����γ̵��б�ı�ͷ-->
    <td height="22"   width="300" align="center"><strong>�γ�����</strong></td>
    <td width="100" align="center"><strong>�γ�˵��</strong></td>
    <td width="100" align="center"><strong>����ʱ��</strong></td>
    <td width="200" align="center"><strong>�Ͽΰ༶</strong></td>
    <td width="110" align="center"><strong>�Ͽΰ༶����ѧԺ</strong></td>
    <!--<td width="100" height="22" align="center"><strong> �������</strong></td>-->
  </tr>
  <%do while not rs.EOF %>
  <tr class="tdbg" onMouseOut="this.style.backgroundColor=''" onMouseOver="this.style.backgroundColor='#BFDFFF'"> 
    <td align="center"><a href="Admin_ArticleManageSpecial.asp?SpecialID=<%=rs("SpecialID")%>" title="����������˿γ̵�����"><%=rs("SpecialName")%></a></td>
    <td width="200"><%=dvhtmlencode(rs("ReadMe"))%></td>
    <td width="100" align="center">
      <%
	select case rs("BrowsePurview")
	case 9999
		response.write "�ο�"
	case 999
		response.write "ע���û�"
	case 99
		response.write "�շ��û�"
	case 9
		response.write "VIP�û�"
	case 5
		response.write "����Ա"
	end select%>
    </td>
    <td width="100" align="center">
      <%
	select case rs("AddPurview")
	case 999
		response.write "ע���û�"
	case 99
		response.write "�շ��û�"
	case 9
		response.write "VIP�û�"
	case 5
		response.write "����Ա"
	end select%>
    </td>
    <td width="100" align="center"><%
	response.write "<a href='Admin_Special.asp?action=Modify&SpecialID=" & rs("SpecialID") & "'>�޸�</a>&nbsp;&nbsp;"
	response.write "<a href='Admin_Special.asp?Action=Del&SpecialID=" & rs("SpecialID") & "' onClick=""return confirm('ȷ��Ҫɾ���˿γ���ɾ���˿γ̺�ԭ���ڴ˿γ̵����½��������κογ̡�');"">ɾ��</a>&nbsp;&nbsp;" 
    response.write "<a href='Admin_Special.asp?Action=Clear&SpecialID=" & rs("SpecialID") & "' onClick=""return confirm('ȷ��Ҫ��մ˿γ��е������𣿱�������ԭ���ڴ˿γ̵����¸�Ϊ�������κογ̡�');"">���</a>"
	%></td>
    <form action='Admin_Special.asp?Action=UpOrder' method='post'>
    </form>
    <form action='Admin_Special.asp?Action=DownOrder' method='post'>
    </form>
  </tr>
  <%
		rs.MoveNext
   	loop
  %>
</table> 
<%
	rs.Close
	set rs=Nothing
end sub

sub ShowOrder()
	dim iCount,i,j
	Set rs=Server.CreateObject("Adodb.RecordSet")
	sql="select * from Special"
	rs.Open sql,conn,1,1
	iCount=rs.recordcount
	j=1
%>
<br>
<table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" class="border">
  <tr class="title"> 
    <td height="22" colspan="4" align="center"><strong> �� �� </strong><strong>�� 
      ��</strong></td>
  </tr>
  <%do while not rs.EOF %>
  <tr class="tdbg" onMouseOut="this.style.backgroundColor=''" onMouseOver="this.style.backgroundColor='#BFDFFF'"> 
    <td align="center"><a href="Admin_ArticleManageSpecial.asp?SpecialID=<%=rs("SpecialID")%>" title="����������˿γ̵�����"><%=rs("SpecialName")%></a></td>
    <form action='Admin_Special.asp?Action=UpOrder' method='post'>
      <td width='120' align="center"> <% 
	if j>1 then 
		response.write "<select name=MoveNum size=1><option value=0>�����ƶ�</option>" 
		for i=1 to j-1 
			response.write "<option value="&i&">"&i&"</option>" 
		next 
		response.write "</select>" 
		response.write "<input type=hidden name=SpecialID value="&rs("SpecialID")&">"
		response.write "<input type=hidden name=cOrderID value="&rs("OrderID")&">&nbsp;<input type=submit name=Submit value=�޸�>" 
	else 
		response.write "&nbsp;" 
	end if 
%> </td>
    </form>
    <form action='Admin_Special.asp?Action=DownOrder' method='post'>
      <td width='120' align="center"> <%
	if iCount>j then 
		response.write "<select name=MoveNum size=1><option value=0>�����ƶ�</option>" 
		for i=1 to iCount-j 
			response.write "<option value="&i&">"&i&"</option>" 
		next 
		response.write "</select>" 
		response.write "<input type=hidden name=SpecialID value="&rs("SpecialID")&">"
		response.write "<input type=hidden name=cOrderID value="&rs("OrderID")&">&nbsp;<input type=submit name=Submit value=�޸�>" 
	else 
		response.write "&nbsp;" 
	end if 
%> </td>
      <td width='200' align="center">&nbsp;</td>
    </form>
  </tr>
  <%
     	j=j+1	
		rs.MoveNext
   	loop
  %>
</table> 
<%
	rs.Close
	set rs=Nothing
end sub

sub AddSpecial()
%>
<form method="post" action="Admin_Special.asp" name="form1">
  <table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" class="border" >
    <tr class="title"> 
      <td height="22" colspan="2"> <div align="center"><strong>�� �� �� �� ��</strong></div></td>
    </tr>
    <tr class="tdbg"> 
      <td width="350" class="tdbg"><strong> �γ����ƣ�</strong></td>
      <td class="tdbg"><input name="SpecialName" type="text" id="SpecialName" size="49" maxlength="45"> 
        &nbsp;</td>
    </tr>
    <tr class="tdbg"> 
      <td width="350" class="tdbg"><strong> �γ̼�ƣ�</strong>&nbsp;(�ĸ����ֻ�����)</td>
      <td class="tdbg"><input name="SpecialAbbreviation" type="text" id="SpecialAbbreviation" size="49" maxlength="8"> 
        &nbsp;</td>
    </tr>
    <tr class="tdbg"> 
      <td width="350" class="tdbg"><strong>�γ�˵��</strong><br>
        ��������γ�������ʱ����ʾ�趨��˵�����֣���֧��HTML��</td>
      <td class="tdbg"><textarea name="ReadMe" cols="40" rows="5" id="ReadMe"></textarea></td>
    </tr>
    <tr class="tdbg"> 
      <td width="350" class="tdbg"><strong>Ĭ����ɫģ�壺</strong><br>
        ���ģ���а���CSS����ɫ��ͼƬ����Ϣ</td>
      <td class="tdbg">
        <%call Admin_ShowSkin_Option(0)%>
      </td>
    </tr>
    <tr class="tdbg"> 
      <td width="350" class="tdbg"><strong>�������ģ�壺</strong><br>���ģ���а����˰�����Ƶİ�ʽ����Ϣ�������������ӵ����ģ�壬���ܻᵼ�¡���Ŀ��ɫģ�塱ʧЧ��
        </td>
      <td class="tdbg">
        <%call Admin_ShowLayout_Option(4,0)%>
      </td>
    </tr>
    <tr class="tdbg"> 
      <td width="350"><strong>�γ����Ȩ�ޣ�</strong><br>
        ֻ�о�����ӦȨ�޵��˲�������˿γ��е����¡�</td>
      <td><select name="BrowsePurview" id="BrowsePurview">
          <option value="9999">�ο�</option>
          <option value="999">ע���û�</option>
          <option value="99">�շ��û�</option>
          <option value="9">VIP�û�</option>
          <option value="5">����Ա</option>
        </select></td>
    </tr>
    <tr class="tdbg"> 
      <td width="350"><strong>�γ̷�������Ȩ�ޣ�</strong><br>
        ֻ�о�����ӦȨ�޵��˲����ڴ˿γ��з������¡�</td>
      <td><select name="AddPurview" id="AddPurview">
          <option value="999">ע���û�</option>
          <option value="99">�շ��û�</option>
          <option value="9">VIP�û�</option>
          <option value="5">����Ա</option>
        </select></td>
    </tr>
    <tr class="tdbg"> 
      <td colspan="2" align="center" class="tdbg"><input name="Action" type="hidden" id="Action" value="SaveAdd">
        <input  type="submit" name="Submit" value=" �� �� ">
        &nbsp; 
        <input name="Cancel" type="button" id="Cancel" value=" ȡ �� " onClick="window.location.href='Admin_Special.asp'" style="cursor:hand;"></td>
    </tr>
  </table>
  </form>
<%
end sub

sub Modify()
	dim SpecialID
	SpecialID=trim(request("SpecialID"))
	if SpecialID="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>��ָ��Ҫ�޸ĵĿγ�ID��</li>"
		exit sub
	else
		SpecialID=Clng(SpecialID)
	end if
	sql="Select * From Special Where SpecialID=" & SpecialID
	Set rs=Server.CreateObject("Adodb.RecordSet")
	rs.open sql,conn,1,3
	if rs.bof and rs.EOF then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>�Ҳ���ָ���Ŀγ̣������Ѿ���ɾ����</li>"
	else

%>
<form method="post" action="Admin_Special.asp" name="form1">
  <table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" class="border" >
    <tr class="title"> 
      <td height="22" colspan="2"> <div align="center"><strong>�� �� �� ��</strong></div></td>
    </tr>
    <tr class="tdbg"> 
      <td width="350" class="tdbg"><strong> �γ����ƣ�</strong></td>
      <td class="tdbg"><input name="SpecialName" type="text" id="SpecialName" value="<%=rs("SpecialName")%>" size="49" maxlength="45">
        <input name="SpecialID" type="hidden" id="SpecialID" value="<%=rs("SpecialID")%>"> </td>
    </tr>
   <!-- �γ̼��-->
    <tr class="tdbg"> 
      <td width="350" class="tdbg"><strong> �γ����ƣ�&nbsp;(�ĸ����ֻ�����)</strong></td>
      <td class="tdbg"><input name="SpecialAbbreviation" type="text" id="SpecialAbbreviation" value="<%=rs("SpecialAbbreviation")%>" size="49" maxlength="8">
      </td>
    </tr>
    <!--�����γ̼��-->
    
    <tr class="tdbg"> 
      <td width="350" class="tdbg"><strong>�γ�˵��</strong><br>
        ��������γ�������ʱ����ʾ�趨��˵�����֣���֧��HTML��</td>
      <td class="tdbg"><textarea name="ReadMe" cols="40" rows="5" id="ReadMe"><%=rs("ReadMe")%>
</textarea></td>
    </tr>
    <tr class="tdbg"> 
      <td width="350" class="tdbg"><strong>Ĭ����ɫģ�壺</strong><br>
        ���ģ���а���CSS����ɫ��ͼƬ����Ϣ</td>
      <td class="tdbg">
        <%call Admin_ShowSkin_Option(rs("SkinID"))%>
      </td>
    </tr>
    <tr class="tdbg"> 
      <td width="350" class="tdbg"><strong>�������ģ�壺</strong><br>���ģ���а����˰�����Ƶİ�ʽ����Ϣ�������������ӵ����ģ�壬���ܻᵼ�¡���Ŀ��ɫģ�塱ʧЧ��
        </td>
      <td class="tdbg">
        <%call Admin_ShowLayout_Option(4,rs("SkinID"))%>
      </td>
    </tr>
    <tr class="tdbg"> 
      <td width="350"><strong>�γ����Ȩ�ޣ�</strong><br>
        ֻ�о�����ӦȨ�޵��˲�������˿γ��е����¡�</td>
      <td><select name="BrowsePurview" id="select">
          <option value="9999" <%if rs("BrowsePurview")=9999 then response.write " selected"%>>�ο�</option>
          <option value="999" <%if rs("BrowsePurview")=999 then response.write " selected"%>>ע���û�</option>
          <option value="99" <%if rs("BrowsePurview")=99 then response.write " selected"%>>�շ��û�</option>
          <option value="9" <%if rs("BrowsePurview")=9 then response.write " selected"%>>VIP�û�</option>
          <option value="5" <%if rs("BrowsePurview")=5 then response.write " selected"%>>����Ա</option>
        </select></td>
    </tr>
    <tr class="tdbg"> 
      <td width="350"><strong>�γ̷�������Ȩ�ޣ�</strong><br>
        ֻ�о�����ӦȨ�޵��˲����ڴ˿γ��з������¡�</td>
      <td><select name="AddPurview" id="select2">
          <option value="999" <%if rs("AddPurview")=999 then response.write " selected"%>>ע���û�</option>
          <option value="99" <%if rs("AddPurview")=99 then response.write " selected"%>>�շ��û�</option>
          <option value="9" <%if rs("AddPurview")=9 then response.write " selected"%>>VIP�û�</option>
          <option value="5" <%if rs("AddPurview")=5 then response.write " selected"%>>����Ա</option>
        </select></td>
    </tr>
    <tr class="tdbg"> 
      <td colspan="2" align="center" class="tdbg"><input name="Action" type="hidden" id="Action" value="SaveModify">
        <input  type="submit" name="Submit" value="�����޸Ľ��">
        &nbsp; 
        <input name="Cancel" type="button" id="Cancel" value=" ȡ �� " onClick="window.location.href='Admin_Special.asp'" style="cursor:hand;"></td>
    </tr>
  </table>
</form>
<%
	end if
	rs.close
	set rs=nothing
end sub

sub ShowUniteForm()
%>
<br>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="1" class="border">
  <tr class="title"> 
    <td height="22" colspan="3" align="center"><strong>�� �� �� ��</strong></td>
  </tr>
  <tr class="tdbg"> 
    <td height="100"><form name="myform" method="post" action="Admin_Special.asp" onSubmit="return ConfirmUnite();">
        &nbsp;&nbsp;���γ� 
        <select name="SpecialID" id="SpecialID">
        <%call ShowSpecial()%>
        </select>
        �ϲ���
        <select name="TargetSpecialID" id="TargetSpecialID">
        <%call ShowSpecial()%>
        </select>
        <br> <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        <input name="Action" type="hidden" id="Action" value="UniteSpecial">
        <input type="submit" name="Submit" value=" �ϲ��γ� " style="cursor:hand;">
        &nbsp;&nbsp; 
        <input name="Cancel" type="button" id="Cancel" value=" ȡ �� " onClick="window.location.href='Admin_ClassManage.asp'" style="cursor:hand;">
      </form>
	</td>
  </tr>
  <tr class="tdbg"> 
    <td height="60"><strong>ע�����</strong><br>
      &nbsp;&nbsp;&nbsp;&nbsp;���в��������棬�����ز���������<br>
      &nbsp;&nbsp;&nbsp;&nbsp;������ͬһ���γ��ڽ��в�����<br>
      &nbsp;&nbsp;&nbsp;&nbsp;�ϲ�������ָ���Ŀγ̽���ɾ�����������½�ת�Ƶ�Ŀ��γ��С�</td>
  </tr>
</table> 
<script language="JavaScript" type="text/JavaScript">
function ConfirmUnite()
{
  if (document.myform.SpecialID.value==document.myform.TargetSpecialID.value)
  {
    alert("�벻Ҫ����ͬ�γ��ڽ��в�����");
	document.myform.TargetSpecialID.focus();
	return false;
  }
}
</script>
<%
end sub
%>
</body>
</html>
<%
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
