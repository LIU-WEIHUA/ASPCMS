<%@language=vbscript codepage=936 %>
<%
option explicit
response.buffer=true	
Const PurviewLevel=2
Const CheckChannelID=0
Const PurviewLevel_Others="Layout"
%>
<!--#include file="inc/conn.asp"-->
<!--#include file="inc/config.asp"-->
<!--#include file="Admin_ChkPurview.asp"-->
<!--#include file="inc/function.asp"-->
<!--#include file="inc/ubbcode.asp"-->
<%
dim rs, sql
dim Action,LayoutID,LayoutType,FoundErr,ErrMsg
Action=trim(request("Action"))
LayoutID=trim(request("LayoutID"))
LayoutType=trim(request("LayoutType"))
if LayoutType="" then
	LayoutType=session("LayoutType")
end if
if LayoutType="" then
	LayoutType=2
else
	LayoutType=CLng(LayoutType)
end if
session("LayoutType")=LayoutType
%>
<html>
<head>
<title>�������ģ�����</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="Admin_Style.css" rel="stylesheet" type="text/css">
</head>
<body leftmargin="2" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" class="border">
  <tr class="topbg"> 
    <td height="22" colspan="2" align="center"><strong>�� �� �� �� ģ �� �� ��</strong></td>
  </tr>
  <tr class="tdbg"> 
    <td width="70" height="30"><strong>��������</strong></td>
    <td><a href="Admin_Layout.asp?Action=Add">��Ӱ������ģ��</a> | <a href="Admin_Layout.asp?LayoutType=2">������Ŀģ��</a> 
      | <a href="Admin_Layout.asp?LayoutType=3">��������ҳģ��</a> | <a href="Admin_Layout.asp?LayoutType=4">ר������ģ��</a> 
      | <a href="Admin_Layout.asp?LayoutType=5">�����Ŀģ��</a> | <a href="Admin_Layout.asp?LayoutType=6">ͼƬ��Ŀģ��</a></td>
  </tr>
</table>
<%
select case Action
	case "Add","Modify"
		call ShowLayoutSet()
	case "SaveAdd"
		call SaveAdd()
	case "SaveModify"
		call SaveModify()
	case "Set"
		call SetDefault()
	case "Del"
		call DelLayout()
	case else
		call main()
end select
if FoundErr=True then
	call WriteErrMsg()
end if
call CloseConn()

sub main()
	sql="select * from Layout where LayoutType=" & LayoutType
	Set rs=Server.CreateObject("Adodb.RecordSet")
	rs.Open sql,conn,1,1
%>
<form name="form1" method="post" action="">
<%
response.write "�����ڵ�λ�ã��������ģ�����&nbsp;&gt;&gt;&nbsp;<font color=red>"
select case LayoutType
	case 2
		response.write "������Ŀģ��"
	case 3
		response.write "��������ҳģ��"
	case 4
		response.write "ר������ģ��"
	case 5
		response.write "�����Ŀģ��"
	case 6
		response.write "ͼƬ��Ŀģ��"
	case else
		response.write "����Ĳ���"
end select
response.write "</font><br>"
%>
  <table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" class="border">
    <tr class="title"> 
      <td width="30" align="center"><strong>ѡ��</strong></td>
      <td width="30" align="center"><strong>ID</strong></td>
      <td height="22" align="center"><strong> ģ������</strong></td>
      <td width="100" align="center"><strong>ģ���ļ���</strong></td>
      <td width="150" align="center"><strong>Ч��ͼ</strong></td>
      <td width="60" align="center"><strong>�����</strong></td>
      <td width="60" align="center"><strong>ģ������</strong></td>
      <td width="150" height="22" align="center"><strong> ����</strong></td>
    </tr>
    <%if not(rs.bof and rs.eof) then
  do while not rs.EOF %>
    <tr class="tdbg" onmouseout="this.style.backgroundColor=''" onmouseover="this.style.backgroundColor='#BFDFFF'"> 
      <td width="30" align="center"><input type="radio" value="<%=rs("LayoutID")%>" <%if rs("IsDefault")=true then response.write " checked"%> name="LayoutID"></td>
      <td width="30" align="center"><%=rs("LayoutID")%></td>
      <td align="center"><%=rs("LayoutName")%></td>
      <td width="100" align="center"><%=rs("LayoutFileName")%></td>
      <td width="150" align="center"><%response.write "<a href='Admin_Layout.asp?Action=Prview&LayoutID=" & rs("LayoutID") & "' title='��˲鿴ԭʼЧ��ͼ'><img src='" & rs("PicUrl") & "' width=100 height=30 border=0></a>"%></td>
      <td width="60" align="center"><%response.write "<a href='mailto:" & rs("DesignerEmail") & "' title='��������䣺" & rs("DesignerEmail") & vbcrlf & "�������ҳ��" & rs("DesignerHomepage") & "'>" & rs("DesignerName") & "</a>"%></td>
      <td width="60" align="center"><%if rs("DesignType")=1 then response.write "�û��Զ���" else response.write "ϵͳ�ṩ"%></td>
      <td width="150" align="center"><%
	response.write "<a href='Admin_Layout.asp?Action=Modify&LayoutID=" & rs("LayoutID") & "'>�޸�ģ������</a>&nbsp;"
	if rs("DesignType")=1 and rs("IsDefault")=False then
		response.write "<a href='Admin_Layout.asp?Action=Del&LayoutID=" & rs("LayoutID") & "' onClick=""return confirm('ȷ��Ҫɾ���˰������ģ����ɾ���˰������ģ���ԭʹ�ô˰������ģ������½���Ϊʹ��ϵͳĬ�ϰ������ģ�塣');"">ɾ��ģ��</a>"
	else
		response.write "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
	end if
	%> </td>
    </tr>
    <%
		rs.MoveNext
   	loop
  %>
    <tr class="tdbg"> 
      <td colspan="8" align="center"><input name="LayoutType" type="hidden" id="LayoutType" value="<%=LayoutType%>"> 
        <input name="Action" type="hidden" id="Action" value="Set"> <input type="submit" name="Submit" value="��ѡ�е�ģ����ΪĬ��ģ��"></td>
    </tr>
    <%end if%>
  </table>  
</form>
<%
	rs.close
	set rs=nothing
end sub

sub ShowLayoutSet()
	if Action="Add" then
		sql="select * from Layout where IsDefault=True and LayoutType=" & LayoutType
	elseif Action="Modify" then
		if LayoutID="" then
			FoundErr=True
			ErrMsg=ErrMsg & "<br><li>��ָ��LayoutID</li>"
			exit sub
		else
			LayoutID=Clng(LayoutID)
		end if
		sql="select * from Layout where LayoutID=" & LayoutID
	end if
	Set rs=Server.CreateObject("Adodb.RecordSet")
	rs.Open sql,conn,1,1
	if rs.bof and rs.eof then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>���ݿ���ִ���</li>"
		rs.close
		set rs=nothing
		exit sub
	end if
%>
<form name="form1" method="post" action="Admin_Layout.asp">
  <table width="100%" border="0" cellspacing="1" cellpadding="2" class="border">
    <tr align="center" class="title"> 
      <td height="22" colspan="2"><strong> 
        <%if Action="Add" then%>
        ����°������ģ�� 
        <%else%>
        �޸�ģ������ 
        <%end if%>
        </strong></td>
    </tr>
    <tr class="topbg"> 
      <td height="20" colspan="2"><strong>�������ģ�������Ϣ</strong></td>
    </tr>
    <tr class="tdbg"> 
      <td width="40%"><strong>ģ�����ͣ�</strong></td>
      <td><%if Action="Modify" then%>
        <input name="LayoutType" type="hidden" id="LayoutType" value="<%=rs("LayoutType")%>">
        <%end if%> <select name="LayoutType" id="LayoutType" <%if Action="Modify" then response.write "disabled"%>>
          <option value="2" <%if rs("LayoutType")=2 then response.write " selected"%>>������Ŀģ��</option>
          <option value="3" <%if rs("LayoutType")=3 then response.write " selected"%>>��������ҳģ��</option>
          <option value="4" <%if rs("LayoutType")=4 then response.write " selected"%>>ר������ģ��</option>
          <option value="5" <%if rs("LayoutType")=5 then response.write " selected"%>>�����Ŀģ��</option>
          <option value="6" <%if rs("LayoutType")=6 then response.write " selected"%>>ͼƬ��Ŀģ��</option>
        </select></td>
    </tr>
    <tr class="tdbg"> 
      <td width="40%"><strong>�������ģ�����ƣ�</strong></td>
      <td><%if Action="Modify" and rs("DesignType")=0 then%>
        <input name="LayoutName" type="hidden" id="LayoutName" value="<%=rs("LayoutName")%>">
        <%=rs("LayoutName")%>
        <%else%>
        <input name="LayoutName" type="text" id="LayoutName" value="<%if Action="Modify" then response.write rs("LayoutName")%>" size="50" maxlength="50">
        <%end if%> </td>
    </tr>
    <tr class="tdbg"> 
      <td><strong>ģ���ļ�����</strong></td>
      <td><%if Action="Modify" and rs("DesignType")=0 then%>
        <input name="LayoutFileName" type="hidden" id="LayoutFileName" value="<%=rs("LayoutFileName")%>">
        <%=rs("LayoutFileName")%>
        <%else%>
        <input name="LayoutFileName" type="text" id="LayoutFileName" value="<%if Action="Modify" then response.write rs("LayoutFileName")%>" size="50" maxlength="100">
        <%end if%></td>
    </tr>
    <tr class="tdbg"> 
      <td width="40%"><strong>�������ģ��Ԥ��ͼ��</strong></td>
      <td><%if Action="Modify" and rs("DesignType")=0 then%>
        <input name="PicUrl" type="hidden" id="PicUrl" value="<%=rs("PicUrl")%>">
        <%=rs("PicUrl")%>
        <%else%>
        <input name="PicUrl" type="text" id="PicUrl" value="<%if Action="Modify" then response.write rs("PicUrl")%>" size="50" maxlength="100">
        <%end if%></td>
    </tr>
    <tr class="tdbg"> 
      <td width="40%"><strong>�����������</strong></td>
      <td><%if Action="Modify" and rs("DesignType")=0 then%>
        <input name="DesignerName" type="hidden" id="DesignerName" value="<%=rs("DesignerName")%>">
        <%=rs("DesignerName")%>
        <%else%>
        <input name="DesignerName" type="text" id="DesignerName" value="<%=rs("DesignerName")%>" size="50" maxlength="30">
        <%end if%></td>
    </tr>
    <tr class="tdbg"> 
      <td width="40%"><strong>�����Email��</strong></td>
      <td><%if Action="Modify" and rs("DesignType")=0 then%>
        <input name="DesignerEmail" type="hidden" id="DesignerEmail" value="<%=rs("DesignerEmail")%>">
        <%=rs("DesignerEmail")%>
        <%else%>
        <input name="DesignerEmail" type="text" id="DesignerEmail" value="<%=rs("DesignerEmail")%>" size="50" maxlength="100">
        <%end if%></td>
    </tr>
    <tr class="tdbg"> 
      <td width="40%"><strong>�������ҳ��</strong></td>
      <td><%if Action="Modify" and rs("DesignType")=0 then%>
        <input name="DesignerHomepage" type="hidden" id="DesignerHomepage" value="<%=rs("DesignerHomepage")%>">
        <%=rs("DesignerHomepage")%>
        <%else%>
        <input name="DesignerHomepage" type="text" id="DesignerHomepage" value="<%=rs("DesignerHomepage")%>" size="50" maxlength="100">
        <%end if%></td>
    </tr>
    <tr align="center" class="tdbg"> 
      <td height="50" colspan="2"><input name="LayoutID" type="hidden" id="LayoutID" value="<%=LayoutID%>">
        <%if Action="Add" then%> <input name="Action" type="hidden" id="Action" value="SaveAdd"> 
        <input type="submit" name="Submit2" value=" �� �� "> <%else%> <input name="Action" type="hidden" id="Action" value="SaveModify"> 
        <input type="submit" name="Submit2" value=" �����޸Ľ�� "> <%end if%> </td>
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
	call CheckLayout()
	if FoundErr=True then exit sub
	
	sql="select top 1 * from Layout"
	Set rs=Server.CreateObject("Adodb.RecordSet")
	rs.Open sql,conn,1,3
	rs.addnew
	rs("IsDefault")=False
	rs("DesignType")=1
	call SaveLayout()
	rs.close
	set rs=nothing
	call WriteSuccessMsg("�ɹ�����µİ������ģ�壺"& trim(request("LayoutName")))	
end sub

sub SaveModify()
	
	if LayoutID="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>��ָ��LayoutID</li>"
	else
		LayoutID=Clng(LayoutID)
	end if
	call CheckLayout()
	if FoundErr=True then exit sub
	
	sql="select * from Layout where LayoutID=" & LayoutID
	Set rs=Server.CreateObject("Adodb.RecordSet")
	rs.Open sql,conn,1,3
	if rs.bof and rs.eof then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>�Ҳ���ָ���İ������ģ�壡</li>"
	else
		call SaveLayout()
		call WriteSuccessMsg("����������ģ�����óɹ���")
	end if
	rs.close
	set rs=nothing	
end sub

sub SetDefault()
	if LayoutID="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>��ָ��LayoutID</li>"
		exit sub
	else
		LayoutID=Clng(LayoutID)
	end if
	conn.execute("update Layout set IsDefault=False where IsDefault=True and LayoutType=" & LayoutType)
	conn.execute("update Layout set IsDefault=True where LayoutID=" & LayoutID)
	call WriteSuccessMsg("�ɹ���ѡ����ģ������ΪĬ��ģ��")
end sub

sub CheckLayout()
	if trim(request("LayoutName"))="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>ģ�����Ʋ���Ϊ�գ�</li>"
	end if
	if trim(request("LayoutFileName"))="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>ģ���ļ�������Ϊ�գ�</li>"
	end if
	if trim(request("PicUrl"))="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>ģ��Ԥ��ͼ��ַ����Ϊ�գ�</li>"
	end if
	if trim(request("DesignerName"))="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>ģ���������������Ϊ�գ�</li>"
	end if
	if trim(request("DesignerEmail"))="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>ģ����������䲻��Ϊ�գ�</li>"
	end if
end sub

sub SaveLayout()
	rs("LayoutType")=LayoutType
	rs("LayoutName")=trim(request("LayoutName"))
	rs("LayoutFileName")=trim(request("LayoutFileName"))
	rs("PicUrl")=trim(request("PicUrl"))
	rs("DesignerName")=trim(request("DesignerName"))
	rs("DesignerEmail")=trim(request("DesignerEmail"))
	rs("DesignerHomePage")=trim(request("DesignerHomepage"))
	rs.update
end sub

sub DelLayout()
'********************�����ӵĴ���********************
	dim LayoutType
'********************�����������********************
	if LayoutID="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>��ָ��LayoutID</li>"
		exit sub
	else
		LayoutID=Clng(LayoutID)
	end if
	sql="select * from Layout where LayoutID=" & LayoutID
	Set rs=Server.CreateObject("Adodb.RecordSet")
	rs.Open sql,conn,1,3
	if rs.bof and rs.eof then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>�Ҳ���ָ���İ������ģ�壡</li>"
	else
		if rs("DesignType")=0 then
			FoundErr=True
			ErrMsg=ErrMsg & "<br><li>����ɾ��ϵͳ�Դ���ģ�壡</li>"
		elseif rs("IsDefault")=True then
			FoundErr=True
			ErrMsg=ErrMsg & "<br><li>��ǰģ��ΪĬ��ģ�壬����ɾ�������Ƚ�Ĭ��ģ���Ϊ����ģ�������ɾ����ģ�塣</li>"
		else
'********************�����ӵĴ���********************
			LayoutType=rs("LayoutType")
'********************�����������********************
			rs.delete
			rs.update
			dim trs
'********************ԭʼ��������********************
'			set trs=conn.execute("select LayoutID from Layout where IsDefault=True and LayoutType=" & rs("LayoutType"))
'********************�����ӵĴ���********************
			set trs=conn.execute("select LayoutID from Layout where IsDefault=True and LayoutType=" & LayoutType)
'********************�����������********************
			conn.execute("update ArticleClass set LayoutID=" & trs(0) & " where LayoutID=" & LayoutID)
			conn.execute("update Article set LayoutID=" & trs(0) & " where LayoutID=" & LayoutID)
			set trs=nothing
		end if
	end if
	rs.close
	set rs=nothing
	if FoundErr=True then exit sub
	call WriteSuccessMsg("�ɹ�ɾ��ѡ����ģ�塣����ʹ�ô�ģ�����Ŀ�����¸�Ϊʹ��Ĭ��ģ�塣")	
end sub
%>
