<%@language=vbscript codepage=936 %>
<%
option explicit
response.buffer=true	
Const PurviewLevel=2    '����Ȩ��
Const CheckChannelID=0    '����Ƶ����0Ϊ���������Ƶ��
Const PurviewLevel_Others="Vote"
%>
<!--#include file="inc/conn.asp"-->
<!--#include file="inc/config.asp"-->
<!--#include file="Admin_ChkPurview.asp"-->
<!--#include file="inc/function.asp"-->
<%
dim sql,rs,strFileName,i
dim Action,Channel,FoundErr,ErrMsg
Action=Trim(Request("Action"))
Channel=Trim(Request("Channel"))
if Channel="" then
	Channel=0
else
	Channel=CLng(Channel)
end if
strFileName="admin_Vote.asp?Channel="&Channel
%>
<html>
<head>
<title>�������</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" type="text/css" href="Admin_Style.css">
</head>
<body leftmargin="2" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" Class="border">
  <tr class="topbg"> 
    <td height="22" colspan=2 align=center><b>�� վ �� �� �� ��</b></td>
  </tr>
  <tr class="tdbg"> 
    <td width="70" height="30"><strong>��������</strong></td>
    <td height="30"><a href="Admin_Vote.asp?Action=Add">����µ���</a> | <a href="Admin_Vote.asp">����Ƶ������</a> 
      | <a href="Admin_Vote.asp?Channel=1">��վ��ҳ����</a> | <a href="Admin_Vote.asp?Channel=2">����Ƶ������</a> 
      | <a href="Admin_Vote.asp?Channel=5">����Ƶ������</a> | </td>
  </tr>
</table>
<%
if Action="Add" then
	call AddVote()
elseif Action="SaveAdd" then
	call SaveAdd()
elseif Action="Modify" then
	call Modify()
elseif Action="SaveModify" then
	call SaveModify()
elseif Action="Set" then
	call SetNew()
elseif Action="Del" then
	call DelVote()
else
	call main()
end if
if FoundErr=True then
	call WriteErrMsg()
end if
call CloseConn()


sub main()
	sql="select * from Vote"
	sql=sql & " where ChannelID=" & Channel
	sql=sql & " order by id desc"
	set rs=server.createobject("adodb.recordset")
	rs.open sql,conn,1,1
%>
<form method="POST" action=<%=strFileName%>>
<%
response.write "�����ڵ�λ�ã���վ�������&nbsp;&gt;&gt;&nbsp;<font color=red>"
select case Channel
	case 0
		response.write "����Ƶ������"
	case 1
		response.write "��վ��ҳ����"
	case 2
		response.write "����Ƶ������"
	case 3
		response.write "���Ƶ������"
	case 4
		response.write "ͼƬƵ������"
	case 5
		response.write "����Ƶ������"
	case else
		response.write "����Ĳ���"
end select
response.write "</font><br>"
%>
  <table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" Class="border">
    <tr class="title"> 
      <td width="30" height="22" align="center"><strong>ѡ��</strong></td>
      <td width="30" height="22" align="center"><strong>ID</strong></td>
      <td height="22" align="center"><strong>����</strong></td>
      <td width="60" height="22" align="center"><strong>���µ���</strong></td>
      <td width="60" height="22" align="center"><strong>����</strong></td>
    </tr>
    <%
if not (rs.bof and rs.eof) then
	do while not rs.eof
%>
    <tr class="tdbg"> 
      <td width="30" align="center">
        <input type="radio" value=<%=rs("ID")%><%if rs("IsSelected")=true then%> checked<%end if%> name="ID">
      </td>
      <td width="30" align="center"><%=rs("ID")%></td>
      <td><%=rs("Title")%></td>
      <td width="60" align="center">
        <%if rs("IsSelected")=true then response.write "<font color=#009900>��</font>" end if%>
      </td>
      <td width="60" align="center">
        <%
	  response.write "<a href='" & strFileName & "&Action=Modify&ID=" & rs("ID") & "'>�޸�</a>&nbsp;&nbsp;"
      response.write "<a href='" & strFileName & "&Action=Del&ID=" & rs("ID")  & "' onClick=""return confirm('ȷ��Ҫɾ���˵�����');"">ɾ��</a>"
	  %>
      </td>
    </tr>
    <%
		rs.movenext
	loop
%>
    <tr class="tdbg"> 
      <td colspan=5 align=center>
        <input name="Action" type="hidden" id="Action" value="Set">
        <input type="submit" value="��ѡ���ĵ�����Ϊ���µ���" name="submit">
      </td>
    </tr>
    <%
end if
%>
  </table>
</form>
<%
	rs.close
	set rs=nothing
end sub

sub AddVote()
%>
<form method="POST" action=<%=strFileName%>>
  <table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" Class="border">
    <tr class="title"> 
      <td height="22" class="title" colspan=4 align=center><b>�� �� �� ��</b></td>
    </tr>
    <tr class="tdbg"> 
      <td width="15%" align="right">���⣺</td>
      <td width="85%" colspan="3">
        <textarea name="Title" cols="50" rows="4"></textarea>
      </td>
    </tr>
    <%
	for i=1 to 8%>
    <tr class="tdbg"> 
      <td align="right">ѡ��<%=i%>��</td>
      <td>
        <input type="text" name="select<%=i%>" size="36">
      </td>
      <td align="right">Ʊ����</td>
      <td width="80">
        <input type="text" name="answer<%=i%>" size="5">
      </td>
    </tr>
    <%next%>
    <tr class="tdbg"> 
      <td align="right">�������ͣ�</td>
      <td colspan="3">
        <select name="VoteType" id="VoteType">
          <option value="Single" selected>��ѡ</option>
          <option value="Multi">��ѡ</option>
        </select>
      </td>
    </tr>
    <tr class="tdbg">
      <td align="right">����Ƶ����</td>
      <td colspan="3">
        <input type='radio' name='ChannelID' value='0' checked>
        ȫ��&nbsp;&nbsp; 
        <input type='radio' name='ChannelID' value='1'>
        ��ҳ&nbsp;&nbsp; 
        <input type='radio' name='ChannelID' value='2'>
        ����&nbsp;&nbsp; 
        <input type='radio' name='ChannelID' value='3'>
        ���&nbsp;&nbsp; 
        <input type='radio' name='ChannelID' value='4'>
        ͼƬ&nbsp;&nbsp; 
        <input type='radio' name='ChannelID' value='5'>
        ����&nbsp;</td>
    </tr>
    <tr class="tdbg"> 
      <td align="right">&nbsp;</td>
      <td colspan="3">
        <input name="IsSelected" type="checkbox" id="IsSelected" value="True" checked>
        ��Ϊ���µ���</td>
    </tr>
    <tr class="tdbg"> 
      <td colspan=4 align=center>
        <input name="Action" type="hidden" id="Action" value="SaveAdd">
        <input name="Submit" type="submit" id="Submit" value=" �� �� ">
        &nbsp; 
        <input  name="Reset2" type="reset" id="Reset2" value=" �� �� ">
      </td>
    </tr>
  </table>
</form>
<%
end sub

sub Modify()
	dim ID
	ID=Trim(Request("ID"))
	if ID="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>��ָ������IP</li>"
		exit sub
	else
		ID=Clng(ID)
	end if
	sql="select * from Vote where ID="& ID
	Set rs= Server.CreateObject("ADODB.Recordset")
	rs.open sql,conn,1,1
	if rs.bof and rs.eof then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>�Ҳ���ָ���ĵ��飡</li>"
		rs.close
		set rs=nothing
		exit sub
	end if
%>
<form method="POST" action="Admin_Vote.asp">
  <table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" Class="border">
    <tr class="title"> 
      <td height="22" class="title" colspan=4 align=center><b>�� �� �� ��</b></td>
    </tr>
    <tr class="tdbg"> 
      <td width="15%" align="right">���⣺</td>
      <td width="85%" colspan="3">
        <textarea name="Title" cols="50" rows="4"><%=rs("Title")%></textarea>
      </td>
    </tr>
    <%
for i=1 to 8%>
    <tr class="tdbg"> 
      <td align="right">ѡ��<%=i%>��</td>
      <td>
        <input name="select<%=i%>" type="text" value="<%=rs("select"& i)%>" size="36">
      </td>
      <td align="right">Ʊ����</td>
      <td width="80">
        <input name="answer<%=i%>" type="text" value="<%=rs("answer"&i)%>" size="5">
      </td>
    </tr>
    <%next%>
    <tr class="tdbg"> 
      <td align="right">�������ͣ�</td>
      <td colspan="3">
        <select name="VoteType" id="VoteType">
          <option value="Single" <% if rs("VoteType")="Single" then %> selected <% end if%>>��ѡ</option>
          <option value="Multi" <% if rs("VoteType")="Multi" then %> selected <% end if%>>��ѡ</option>
        </select>
      </td>
    </tr>
    <tr class="tdbg">
      <td align="right">����Ƶ����</td>
      <td colspan="3">
        <input type='radio' name='ChannelID' value='0' <%if rs("ChannelID")=0 then response.write " checked"%>>
        ȫ��&nbsp;&nbsp; 
        <input type='radio' name='ChannelID' value='1' <%if rs("ChannelID")=1 then response.write " checked"%>>
        ��ҳ&nbsp;&nbsp; 
        <input type='radio' name='ChannelID' value='2' <%if rs("ChannelID")=2 then response.write " checked"%>>
        ����&nbsp;&nbsp; 
        <input type='radio' name='ChannelID' value='3' <%if rs("ChannelID")=3 then response.write " checked"%>>
        ���&nbsp;&nbsp; 
        <input type='radio' name='ChannelID' value='4' <%if rs("ChannelID")=4 then response.write " checked"%>>
        ͼƬ&nbsp;&nbsp; 
        <input type='radio' name='ChannelID' value='5' <%if rs("ChannelID")=5 then response.write " checked"%>>
        ����&nbsp;</td>
    </tr>
    <tr class="tdbg"> 
      <td align="right">&nbsp;</td>
      <td colspan="3">
        <input name="IsSelected" type="checkbox" id="IsSelected" value="True" <% if rs("IsSelected")=true then response.write "checked"%>>
        ��Ϊ���µ���</td>
    </tr>
    <tr class="tdbg"> 
      <td colspan=4 align=center>
        <input name="Action" type="hidden" id="Action" value="SaveModify">
        <input name="ID" type="hidden" id="ID" value="<%=rs("ID")%>">
        <input name="Submit" type="submit" id="Submit" value="�����޸Ľ��">
      </td>
    </tr>
  </table>
</form>
<%
	rs.close
	set rs=nothing
end sub
%>
</body>
</html>
<%

sub SaveAdd()
	dim Title,VoteTime,Action,IsSelected,ChannelID,i
	Title=trim(request.form("Title"))
	
	VoteTime=trim(request.form("VoteTime"))
	if VoteTime="" then VoteTime=now()
	IsSelected=trim(request("IsSelected"))
	ChannelID=Clng(request("ChannelID"))

	sql="select top 1 * from Vote"
	Set rs= Server.CreateObject("ADODB.Recordset")
	rs.open sql,conn,1,3
	rs.addnew
	rs("Title")=Title
	for i=1 to 8
		if trim(request("select"&i))<>"" then
			rs("select"&i)=trim(request("select"&i))
			if request("answer"&i)="" then
				rs("answer"&i)=0
			else
				rs("answer"&i)=clng(request("answer"&i))
			end if
		end if
	next
	rs("VoteTime")=VoteTime
	rs("VoteType")=request("VoteType")
	if IsSelected="" then IsSelected=false
	if IsSelected="True" then conn.execute "Update Vote set IsSelected=False where IsSelected=True and ChannelID=" & ChannelID & ""
	rs("IsSelected")=IsSelected
	rs("ChannelID")=ChannelID
	rs.update
	rs.close
	set rs=nothing
	call CloseConn()
	Response.Redirect "admin_Vote.asp?Channel="&ChannelID
end sub

sub SaveModify()
	dim ID,Title,VoteTime,IsSelected,ChannelID
	ID=Trim(Request("ID"))
	if ID="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>��ָ������IP</li>"
		exit sub
	else
		ID=Clng(ID)
	end if
	Title=trim(request.form("Title"))
	VoteTime=trim(request.form("VoteTime"))
	if VoteTime="" then VoteTime=now()
	ChannelID=Clng(request("ChannelID"))
	IsSelected=trim(request("IsSelected"))
	if IsSelected="True" then
		conn.execute "Update Vote set IsSelected=False where IsSelected=True and ChannelID=" & ChannelID & ""
	end if
	sql="select * from Vote where ID="& ID
	Set rs= Server.CreateObject("ADODB.Recordset")
	rs.open sql,conn,1,3
	if rs.bof and rs.eof then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>�Ҳ���ָ���ĵ��飡</li>"
		rs.close
		set rs=nothing
		exit sub
	end if
		rs("Title")=Title
		for i=1 to 8
			if trim(request("select"&i))<>"" then
				rs("select"&i)=trim(request("select"&i))
				if request("answer"&i)="" then
					rs("answer"&i)=0
				else
					rs("answer"&i)=clng(request("answer"&i))
				end if
			else
				rs("select"&i)=""
				rs("answer"&i)=0
			end if
		next
		rs("VoteTime")=VoteTime
		rs("VoteType")=request("VoteType")
		if IsSelected="" then IsSelected=false
		rs("IsSelected")=IsSelected
		rs("ChannelID")=ChannelID
		rs.update
		rs.close
		set rs=nothing
		call CloseConn()
		Response.Redirect "admin_Vote.asp?Channel="&ChannelID
end sub

sub SetNew()
	dim ID
	ID=Trim(Request("ID"))
	if ID="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>��ָ������IP</li>"
		exit sub
	else
		ID=Clng(ID)
	end if
	conn.execute "Update Vote set IsSelected=False where IsSelected=True and ChannelID=" & Channel & ""
	conn.execute "Update Vote set IsSelected=True Where ID=" & ID
	response.Write "<script language='JavaScript' type='text/JavaScript'>alert('���óɹ���');</script>"
	call main()
end sub

sub DelVote()
	dim ID
	ID=Trim(Request("ID"))
	if ID="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>��ָ������IP</li>"
		exit sub
	else
		ID=Clng(ID)
	end if
	conn.Execute "delete from Vote where ID=" & ID
	Response.Redirect strFileName
end sub
%>
