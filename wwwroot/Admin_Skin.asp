<%@language=vbscript codepage=936 %>
<%
option explicit
response.buffer=true	
Const PurviewLevel=2    '����Ȩ��
Const CheckChannelID=0    '����Ƶ����0Ϊ���������Ƶ��
Const PurviewLevel_Others="Skin"
%>
<!--#include file="inc/conn.asp"-->
<!--#include file="inc/config.asp"-->
<!--#include file="Admin_ChkPurview.asp"-->
<!--#include file="inc/function.asp"-->
<!--#include file="inc/ubbcode.asp"-->
<%
dim rs, sql
dim Action,SkinID,FoundErr,ErrMsg
Action=trim(request("Action"))
SkinID=trim(request("SkinID"))
%>
<html>
<head>
<title>��ɫģ�����</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="Admin_Style.css" rel="stylesheet" type="text/css">
</head>
<body leftmargin="2" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" class="border">
  <tr class="topbg"> 
    <td height="22" colspan="2" align="center"><strong>�� ɫ ģ �� �� ��</strong></td>
  </tr>
  <tr class="tdbg"> 
    <td width="70" height="30"><strong>��������</strong></td>
    <td><a href="Admin_Skin.asp">��ɫģ�������ҳ</a> | <a href="Admin_Skin.asp?Action=Add">�����ɫģ��</a> 
      | <a href="Admin_Skin.asp?Action=Export">��ɫģ�嵼��</a> | <a href="Admin_Skin.asp?Action=Import">��ɫģ�嵼��</a></td>
  </tr>
</table>
<%
select case Action
	case "Add","Modify"
		call ShowSkinSet()
	case "SaveAdd"
		call SaveAdd()
	case "SaveModify"
		call SaveModify()
	case "Set"
		call SetDefault()
	case "Del"
		call DelSkin()
	case "Export"
		call Export()
	case "DoExport"
		call DoExport()
	case "Import"
		call Import()
	case "Import2"
		call Import2()		
	case "DoImport"
		call DoImport()
	case else
		call main()
end select
if FoundErr=True then
	call WriteErrMsg()
end if
call CloseConn()

sub main()
	sql="select * from Skin"
	Set rs=Server.CreateObject("Adodb.RecordSet")
	rs.Open sql,conn,1,1
%>
<form name="form1" method="post" action="Admin_Skin.asp">
  <table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" class="border">
    <tr class="title"> 
      <td width="30" align="center"><strong>ѡ��</strong></td>
      <td width="50" align="center"><strong>ID</strong></td>
      <td height="22" align="center"><strong> ģ������</strong></td>
      <td width="150" align="center"><strong>Ч��ͼ</strong></td>
      <td width="100" align="center"><strong>�����</strong></td>
      <td width="80" align="center"><strong>ģ������</strong></td>
      <td width="150" height="22" align="center"><strong> ����</strong></td>
    </tr>
    <%if not(rs.bof and rs.eof) then
  do while not rs.EOF %>
    <tr class="tdbg" onmouseout="this.style.backgroundColor=''" onmouseover="this.style.backgroundColor='#BFDFFF'"> 
      <td width="30" align="center"><input type="radio" value="<%=rs("SkinID")%>" <%if rs("IsDefault")=true then response.write " checked"%> name="SkinID"></td>
      <td width="50" align="center"><%=rs("SkinID")%></td>
      <td align="center"><%=rs("SkinName")%></td>
      <td width="150" align="center"><%response.write "<a href='Admin_Skin.asp?Action=Prview&SkinID=" & rs("SkinID") & "' title='��˲鿴ԭʼЧ��ͼ'><img src='" & rs("PicUrl") & "' width=100 height=30 border=0></a>"%></td>
      <td width="100" align="center"><%response.write "<a href='mailto:" & rs("DesignerEmail") & "' title='��������䣺" & rs("DesignerEmail") & vbcrlf & "�������ҳ��" & rs("DesignerHomepage") & "'>" & rs("DesignerName") & "</a>"%></td>
      <td width="80" align="center"><%if rs("DesignType")=1 then response.write "�û��Զ���" else response.write "ϵͳ�ṩ"%></td>
      <td width="150" align="center"><%
	response.write "<a href='Admin_Skin.asp?Action=Modify&SkinID=" & rs("SkinID") & "'>�޸�ģ������</a>&nbsp;"
	if rs("DesignType")=1 and rs("IsDefault")=False then
		response.write "<a href='Admin_Skin.asp?Action=Del&SkinID=" & rs("SkinID") & "' onClick=""return confirm('ȷ��Ҫɾ������ɫģ����ɾ������ɫģ���ԭʹ�ô���ɫģ������½���Ϊʹ��ϵͳĬ����ɫģ�塣');"">ɾ��ģ��</a>"
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
      <td colspan="7" align="center"><input name="Action" type="hidden" id="Action" value="Set"> 
        <input type="submit" name="Submit" value="��ѡ�е�ģ����ΪĬ��ģ��"></td>
    </tr>
    <%end if%>
  </table>  
</form>
<%
	rs.close
	set rs=nothing
end sub

sub Export()
	sql="select * from Skin"
	Set rs=Server.CreateObject("Adodb.RecordSet")
	rs.Open sql,conn,1,1
%>
<form name="myform" method="post" action="Admin_Skin.asp">
  <table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" class="border">
    <tr class="topbg"> 
      <td height="22" colspan="6" align="center"><strong>��ɫģ�嵼��</strong></td>
    </tr>
    <tr class="title"> 
      <td width="30" align="center"><strong>ѡ��</strong></td>
      <td width="50" align="center"><strong>ID</strong></td>
      <td height="22" align="center"><strong> ģ������</strong></td>
      <td width="150" align="center"><strong>Ч��ͼ</strong></td>
      <td width="100" align="center"><strong>�����</strong></td>
      <td width="80" height="22" align="center"><strong>ģ������</strong></td>
    </tr>
    <%if not(rs.bof and rs.eof) then
  do while not rs.EOF %>
    <tr class="tdbg" onmouseout="this.style.backgroundColor=''" onmouseover="this.style.backgroundColor='#BFDFFF'"> 
      <td width="30" align="center"><input type="checkbox" value="<%=rs("SkinID")%>" name="SkinID" onclick="unselectall()"></td>
      <td width="50" align="center"><%=rs("SkinID")%></td>
      <td align="center"><%=rs("SkinName")%></td>
      <td width="150" align="center"><%response.write "<a href='Admin_Skin.asp?Action=Prview&SkinID=" & rs("SkinID") & "' title='��˲鿴ԭʼЧ��ͼ'><img src='" & rs("PicUrl") & "' width=100 height=30 border=0></a>"%></td>
      <td width="100" align="center"><%response.write "<a href='mailto:" & rs("DesignerEmail") & "' title='��������䣺" & rs("DesignerEmail") & vbcrlf & "�������ҳ��" & rs("DesignerHomepage") & "'>" & rs("DesignerName") & "</a>"%></td>
      <td width="80" align="center"><%if rs("DesignType")=1 then response.write "�û��Զ���" else response.write "ϵͳ�ṩ"%></td>
    </tr>
    <%
		rs.MoveNext
   	loop
  %>
    <tr class="tdbg"> 
      <td colspan="6"><input name="chkAll" type="checkbox" id="chkAll" onclick=CheckAll(this.form) value="checkbox">
        ѡ������ģ��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;����ѡ�е�ģ�嵽���ݿ⣺ 
        <input name="SkinMdb" type="text" id="SkinMdb" value="Skin/Skin.mdb" size="20" maxlength="50">
        <input type="submit" name="Submit" value="����">
        <input name="Action" type="hidden" id="Action" value="DoExport"></td>
    </tr>
    <%end if%>
  </table>  
</form>
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
    if (e.Name != "chkAll"&&e.disabled!=true)
       e.checked = form.chkAll.checked;
    }
}
</script>
<%
	rs.close
	set rs=nothing
end sub

sub Import()
%>
<form name="myform" method="post" action="Admin_Skin.asp">
  <table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" class="border">
    <tr class="topbg"> 
      <td height="22" align="center"><strong>��ɫģ�嵼�루��һ����</strong></td>
    </tr>
	<tr class="tdbg">
      <td height="100">&nbsp;&nbsp;&nbsp;&nbsp;������Ҫ�����ģ�����ݿ���ļ����� 
        <input name="SkinMdb" type="text" id="SkinMdb" value="Skin/Skin.mdb" size="20" maxlength="50">
        <input name="Submit" type="submit" id="Submit" value=" ��һ�� ">
        <input name="Action" type="hidden" id="Action" value="Import2"> </td>
	</tr>
  </table>
</form>
<%
end sub

sub Import2()
	on error resume next
	dim mdbname,tconn,trs
	mdbname=replace(trim(request.form("skinmdb")),"'","")
	if mdbname="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>����д����ģ�����ݿ���"
		exit sub
	end if
	
	Set tconn = Server.CreateObject("ADODB.Connection")
	tconn.open "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & Server.MapPath(mdbname)
	if err.number<>0 then
		ErrMsg=ErrMsg & "<br><li>���ݿ����ʧ�ܣ����Ժ����ԣ�����ԭ��" & err.Description
		err.clear
		exit sub
	end if
	

	sql="select * from Skin"
	Set rs=Server.CreateObject("Adodb.RecordSet")
	rs.Open sql,tconn,1,1
%>
<form name="myform" method="post" action="Admin_Skin.asp">
  <table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" class="border">
    <tr class="topbg"> 
      <td height="22" colspan="6" align="center"><strong>��ɫģ�嵼�루�ڶ�����</strong></td>
    </tr>
    <tr class="title"> 
      <td width="30" align="center"><strong>ѡ��</strong></td>
      <td width="50" align="center"><strong>ID</strong></td>
      <td height="22" align="center"><strong> ģ������</strong></td>
      <td width="150" align="center"><strong>Ч��ͼ</strong></td>
      <td width="100" align="center"><strong>�����</strong></td>
      <td width="80" height="22" align="center"><strong>ģ������</strong></td>
    </tr>
    <%if not(rs.bof and rs.eof) then
  do while not rs.EOF %>
    <tr class="tdbg" onmouseout="this.style.backgroundColor=''" onmouseover="this.style.backgroundColor='#BFDFFF'"> 
      <td width="30" align="center"><input type="checkbox" value="<%=rs("SkinID")%>" name="SkinID" onclick="unselectall()"></td>
      <td width="50" align="center"><%=rs("SkinID")%></td>
      <td align="center"><%=rs("SkinName")%></td>
      <td width="150" align="center"><%response.write "<a href='Admin_Skin.asp?Action=Prview&SkinID=" & rs("SkinID") & "' title='��˲鿴ԭʼЧ��ͼ'><img src='" & rs("PicUrl") & "' width=100 height=30 border=0></a>"%></td>
      <td width="100" align="center"><%response.write "<a href='mailto:" & rs("DesignerEmail") & "' title='��������䣺" & rs("DesignerEmail") & vbcrlf & "�������ҳ��" & rs("DesignerHomepage") & "'>" & rs("DesignerName") & "</a>"%></td>
      <td width="80" align="center"><%if rs("DesignType")=1 then response.write "�û��Զ���" else response.write "ϵͳ�ṩ"%></td>
    </tr>
    <%
		rs.MoveNext
   	loop
  %>
    <tr class="tdbg"> 
      <td colspan="6"><input name="chkAll" type="checkbox" id="chkAll" onclick=CheckAll(this.form) value="checkbox">
        ѡ������ģ��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <input type="submit" name="Submit" value="����ѡ�е�ģ��">
        <input name="SkinMdb" type="hidden" id="SkinMdb" value="<%=mdbname%>">
        <input name="Action" type="hidden" id="Action" value="DoImport"></td>
    </tr>
    <%end if%>
  </table>  
</form>
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
    if (e.Name != "chkAll"&&e.disabled!=true)
       e.checked = form.chkAll.checked;
    }
}
</script>
<%
	rs.close
	set rs=nothing
end sub

sub ShowSkinSet()
	if Action="Add" then
		sql="select * from Skin where IsDefault=True"
	elseif Action="Modify" then
		if SkinID="" then
			FoundErr=True
			ErrMsg=ErrMsg & "<br><li>��ָ��SkinID</li>"
			exit sub
		else
			SkinID=Clng(SkinID)
		end if
		sql="select * from Skin where SkinID=" & SkinID
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
	dim Skin_CSS
	Skin_CSS=split(rs("Skin_CSS"),"|||")
%>
<form name="form1" method="post" action="Admin_Skin.asp">
  <table width="100%" border="0" cellspacing="1" cellpadding="2" class="border">
    <tr align="center" class="title"> 
      <td height="22" colspan="2"><strong> 
        <%if Action="Add" then%>
        �������ɫģ�� 
        <%else%>
        �޸�ģ������ 
        <%end if%>
        </strong></td>
    </tr>
    <tr class="topbg"> 
      <td height="20" colspan="2"><strong>��ɫģ�������Ϣ</strong></td>
    </tr>
    <tr class="tdbg"> 
      <td width="40%"><strong>��ɫģ�����ƣ�</strong></td>
      <td> <input name="SkinName" type="text" id="SkinName" value="<%if Action="Modify" then response.write rs("SkinName")%>" size="50" maxlength="50"> 
        <input name="SkinID" type="hidden" id="SkinID" value="<%=SkinID%>"></td>
    </tr>
    <tr class="tdbg"> 
      <td width="40%"><strong>��ɫģ��Ԥ��ͼ��</strong></td>
      <td><%if Action="Modify" and rs("DesignType")=0 then%> <input name="PicUrl" type="hidden" id="PicUrl" value="<%=rs("PicUrl")%>"> 
        <%=rs("PicUrl")%> <%else%> <input name="PicUrl" type="text" id="PicUrl" value="<%=rs("PicUrl")%>" size="50" maxlength="100"> 
        <%end if%></td>
    </tr>
    <tr class="tdbg"> 
      <td width="40%"><strong>�����������</strong></td>
      <td><%if Action="Modify" and rs("DesignType")=0 then%> <input name="DesignerName" type="hidden" id="DesignerName" value="<%=rs("DesignerName")%>"> 
        <%=rs("DesignerName")%> <%else%> <input name="DesignerName" type="text" id="DesignerName" value="<%=rs("DesignerName")%>" size="50" maxlength="30"> 
        <%end if%></td>
    </tr>
    <tr class="tdbg"> 
      <td width="40%"><strong>�����Email��</strong></td>
      <td><%if Action="Modify" and rs("DesignType")=0 then%> <input name="DesignerEmail" type="hidden" id="DesignerEmail" value="<%=rs("DesignerEmail")%>"> 
        <%=rs("DesignerEmail")%> <%else%> <input name="DesignerEmail" type="text" id="DesignerEmail" value="<%=rs("DesignerEmail")%>" size="50" maxlength="100"> 
        <%end if%></td>
    </tr>
    <tr class="tdbg"> 
      <td width="40%"><strong>�������ҳ��</strong></td>
      <td><%if Action="Modify" and rs("DesignType")=0 then%> <input name="DesignerHomepage" type="hidden" id="DesignerHomepage" value="<%=rs("DesignerHomepage")%>"> 
        <%=rs("DesignerHomepage")%> <%else%> <input name="DesignerHomepage" type="text" id="DesignerHomepage" value="<%=rs("DesignerHomepage")%>" size="50" maxlength="100"> 
        <%end if%></td>
    </tr>
    <tr class="topbg"> 
      <td height="20" colspan="2"><strong>ģ����ɫ���ã��޸��������ñ���߱�һ����ҳ֪ʶ��<font color="#FFFF00">����ʹ�õ����Ż�˫���ţ������������ɳ������</font>��</strong></td>
    </tr>
    <tr class="tdbg"> 
      <td><strong>BODY��ǩ</strong><br>
        ��������ҳ����ı�����ɫ���߱���ͼƬ��</td>
      <td> <input name="Body" type="text" id="Body" value="<%=rs("Body")%>" size="50" maxlength="200"></td>
    </tr>
    <tr class="tdbg"> 
      <td><strong>�����ܵ�CSS����</strong><br>
        �ɶ�������Ϊ����������ɫ����ʽ��</td>
      <td><textarea name="Link" cols="41" rows="4" id="Link"><%=Skin_CSS(0)%></textarea></td>
    </tr>
    <tr class="tdbg"> 
      <td><strong>Body��CSS����</strong><br>
        ��ӦCSS�С�BODY�����ɶ�������Ϊ��ҳ������ɫ��������������߿��</td>
      <td><textarea name="CSS_Body" cols="41" rows="4" id="CSS_Body"><%=Skin_CSS(1)%></textarea></td>
    </tr>
    <tr class="tdbg"> 
      <td><strong>��Ԫ���CSS����</strong><br>
        ��ӦCSS�еġ�TD��������Ϊ�ܵı���壬Ϊһ����ĵĵ�Ԫ�������ã��ɶ�������Ϊ������������ɫ����ʽ��</td>
      <td><textarea name="TD" cols="41" rows="4" id="TD"><%=Skin_CSS(2)%></textarea></td>
    </tr>
    <tr class="tdbg"> 
      <td><p><strong>�ı����CSS����</strong><br>
          ��ӦCSS�еġ�INPUT��������Ϊ�ı���ķ�����ã��ɶ�������Ϊ���������塢��ɫ���߿��</p></td>
      <td><textarea name="Input" cols="41" rows="4" id="Input"><%=Skin_CSS(3)%></textarea></td>
    </tr>
    <tr class="tdbg"> 
      <td><strong>��ť��CSS����</strong><br>
        ��ӦCSS�еġ�BUTTON��������Ϊ��ť�ķ�����ã��ɶ�������Ϊ���������塢��ɫ���߿��</td>
      <td><textarea name="Button" cols="41" rows="4" id="Button"><%=Skin_CSS(4)%></textarea></td>
    </tr>
    <tr class="tdbg"> 
      <td><strong>�����б���CSS����</strong><br>
        ��ӦCSS�еġ�SELECT��������Ϊ�����б��ķ�����ã��ɶ�������Ϊ���������塢��ɫ���߿�� </td>
      <td><textarea name="Select" cols="41" rows="5" id="Select"><%=Skin_CSS(5)%></textarea></td>
    </tr>
    <tr class="tdbg"> 
      <td><strong>���߿��CSS����</strong>һ<br>
        ��ӦCSS�еġ�.border�����ɶ�������Ϊ����������ͼ�����弰����ɫ��<br> <font color="#0000FF">���ã�Class=border 
        </font></td>
      <td><textarea name="Border" cols="41" rows="5" id="Border"><%=Skin_CSS(6)%></textarea></td>
    </tr>
    <tr class="tdbg"> 
      <td><strong>���߿��CSS����</strong>��<br>
        ��ӦCSS�еġ�.border2�����ɶ�������Ϊ����������ͼ�����弰����ɫ��<br> <font color="#0000FF">���ã�Class=border2</font></td>
      <td><textarea name="Border2" cols="41" rows="5" id="Border2"><%=Skin_CSS(7)%></textarea></td>
    </tr>
    <tr class="tdbg"> 
      <td><strong>�������ֵ�CSS����һ</strong><br>
        ��ӦCSS�еġ�.title_txt�����ɶ�������Ϊ���塢��ɫ��<br> <font color="#0000FF">���ã�Class=title_txt</font></td>
      <td><textarea name="title_txt" cols="41" rows="4" id="title_txt"><%=Skin_CSS(8)%></textarea></td>
    </tr>
    <tr class="tdbg"> 
      <td><strong>���ⵥԪ���CSS����һ</strong><br>
        ��ӦCSS�еġ�.title�����ɶ�������Ϊ����������ͼ�����弰����ɫ��<br> <font color="#0000FF">���ã�Class=title 
        </font></td>
      <td><textarea name="Title" cols="41" rows="4" id="textarea3"><%=Skin_CSS(9)%></textarea></td>
    </tr>
    <tr class="tdbg"> 
      <td><strong>���ݵ�Ԫ���CSS����һ</strong><br>
        ��ӦCSS�еġ�.tdbg�����ɶ�������Ϊ����������ͼ�����弰����ɫ��<br> <font color="#0000FF">���ã�Class=tdbg</font></td>
      <td><textarea name="tdbg" cols="41" rows="4" id="textarea"><%=Skin_CSS(10)%></textarea></td>
    </tr>
    <tr class="tdbg"> 
      <td><strong>���������ݵ�CSS����</strong><br>
        ��ӦCSS�еġ�.txt_css�����ɶ�������Ϊ���塢��ɫ��<br> <font color="#0000FF">���ã�Class=txt_css</font></td>
      <td><textarea name="txt_css" cols="41" rows="4" id="textarea2"><%=Skin_CSS(11)%></textarea></td>
    </tr>
    <tr class="tdbg"> 
      <td colspan="2"><table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
          <tr> 
            <td><strong><font color="#CC0000">���������ʽ����CSS�����</font></strong></td>
          </tr>
        </table></td>
    </tr>
    <tr class="tdbg"> 
      <td><strong>&middot;��������������ֵ�CSS����</strong><br>
        ��ӦCSS�еġ�.title_lefttxt�����ɶ�������Ϊ���塢��ɫ��<br> <font color="#0000FF">���ã�Class=title_lefttxt</font></td>
      <td><textarea name="title_lefttxt" cols="41" rows="4" id="textarea4"><%=Skin_CSS(12)%></textarea></td>
    </tr>
    <tr class="tdbg"> 
      <td><strong>&middot;����������ⵥԪ���CSS���壨1��</strong><br>
        ��ӦCSS�еġ�.title_left�����ɶ�������Ϊ����������ͼ�����弰����ɫ��<br> <font color="#0000FF">���ã�Class=title_left</font></td>
      <td><textarea name="Title_Left" cols="41" rows="4" id="Title_Left"><%=Skin_CSS(13)%></textarea></td>
    </tr>
    <tr class="tdbg"> 
      <td><strong>&middot;����������ݵ�Ԫ���CSS���壨1��</strong><br>
        ��ӦCSS�еġ�.tdbg_left�����ɶ�������Ϊ����������ͼ�����弰����ɫ��<br> <font color="#0000FF">���ã�Class=tdbg_left</font></td>
      <td><textarea name="tdbg_left" cols="41" rows="4" id="textarea5"><%=Skin_CSS(14)%></textarea></td>
    </tr>
    <tr class="tdbg"> 
      <td><strong>&middot;����������ⵥԪ���CSS���壨2��</strong><font color="#CC0000">*</font><br>
        ��ӦCSS�еġ�.title_left2�����ɶ�������Ϊ����������ͼ�����弰����ɫ��<font color="#666666">��ע����ֻΪ����Ʈ��ģ����ʹ�ã�</font><br> <font color="#0000FF">���ã�Class=title_left2</font></td>
      <td><textarea name="Title_Left2" cols="41" rows="4" id="Title_Left2"><%=Skin_CSS(15)%></textarea></td>
    </tr>
    <tr class="tdbg"> 
      <td><strong>&middot;����������ݵ�Ԫ���CSS���壨2��</strong><font color="#CC0000">*</font><br>
        ��ӦCSS�еġ�.tdbg_left2�����ɶ�������Ϊ����������ͼ�����弰����ɫ��<font color="#666666">��ע����Ϊ��ɫ��Ӱ����CSS��</font><br> <font color="#0000FF">���ã�Class=tdbg_left2</font></td>
      <td><textarea name="tdbg_left2" cols="41" rows="4" id="textarea6"><%=Skin_CSS(16)%></textarea></td>
    </tr>
    <tr class="tdbg"> 
      <td><strong>&middot;����������ݵ�Ԫ�񱳾���CSS����</strong><br>
        ��ӦCSS�еġ�.tdbg_leftall�����ɶ�������Ϊ����������ͼ�����弰����ɫ��<br> <font color="#0000FF">���ã�Class=tdbg_leftall</font></td>
      <td><textarea name="tdbg_leftall" cols="41" rows="4" id="textarea7"><%=Skin_CSS(17)%></textarea></td>
    </tr>
    <tr class="tdbg"> 
      <td colspan="2"><table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
          <tr> 
            <td><strong><font color="#CC0000">���з�����ʽ����CSS�����</font></strong></td>
          </tr>
        </table></td>
    </tr>
    <tr class="tdbg"> 
      <td><strong>&middot;�з������������ֵ�CSS����</strong><br>
        ��ӦCSS�еġ�.title_maintxt�����ɶ�������Ϊ���塢��ɫ��<br> <font color="#0000FF">���ã�Class=title_maintxt</font></td>
      <td><textarea name="title_maintxt" cols="41" rows="4" id="textarea9"><%=Skin_CSS(18)%></textarea></td>
    </tr>
    <tr class="tdbg"> 
      <td><strong>&middot;�з��������ⵥԪ���CSS���壨1��</strong><br>
        ��ӦCSS�еġ�.title_main�����ɶ�������Ϊ����������ͼ�����弰����ɫ��<br> <font color="#0000FF">���ã�Class=title_main</font></td>
      <td><textarea name="Title_Main" cols="41" rows="4" id="textarea12"><%=Skin_CSS(19)%></textarea></td>
    </tr>
    <tr class="tdbg"> 
      <td><strong>&middot;�з��������ݵ�Ԫ���CSS���壨1��</strong><br>
        ��ӦCSS�еġ�.tdbg_main�����ɶ�������Ϊ����������ͼ�����弰����ɫ��<br> <font color="#0000FF">���ã�Class=tdbg_main</font></td>
      <td><textarea name="tdbg_main" cols="41" rows="4" id="textarea13"><%=Skin_CSS(20)%></textarea></td>
    </tr>
    <tr class="tdbg"> 
      <td><strong>&middot;�з��������ⵥԪ���CSS���壨2��</strong><br>
        ��ӦCSS�еġ�.title_main2�����ɶ�������Ϊ����������ͼ�����弰����ɫ��<br> <font color="#0000FF">���ã�Class=title_main2</font></td>
      <td><textarea name="Title_Main2" cols="41" rows="4" id="textarea14"><%=Skin_CSS(21)%></textarea></td>
    </tr>
    <tr class="tdbg"> 
      <td><strong>&middot;�з��������ݵ�Ԫ���CSS���壨2��</strong><br>
        ��ӦCSS�еġ�.tdbg_main2�����ɶ�������Ϊ����������ͼ�����弰����ɫ��<br> <font color="#0000FF">���ã�Class=tdbg_main2</font></td>
      <td><textarea name="tdbg_main2" cols="41" rows="4" id="textarea15"><%=Skin_CSS(22)%></textarea></td>
    </tr>
    <tr class="tdbg"> 
      <td><strong>&middot;�з��������ݵ�Ԫ�񱳾���CSS����</strong><br>
        ��ӦCSS�еġ�.tdbg_mainall�����ɶ�������Ϊ����������ͼ�����弰����ɫ��<br> <font color="#0000FF">���ã�Class=tdbg_mainall</font></td>
      <td><textarea name="tdbg_mainall" cols="41" rows="4" id="textarea11"><%=Skin_CSS(23)%></textarea></td>
    </tr>
    <tr class="tdbg"> 
      <td colspan="2"><table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
          <tr> 
            <td><strong><font color="#CC0000">���ҷ�����ʽ����CSS�����</font></strong></td>
          </tr>
        </table></td>
    </tr>
    <tr class="tdbg"> 
      <td><strong>&middot;�ҷ������������ֵ�CSS����</strong><br>
        ��ӦCSS�еġ�.title_righttxt�����ɶ�������Ϊ���塢��ɫ��<br> <font color="#0000FF">���ã�Class=title_righttxt</font></td>
      <td><textarea name="title_righttxt" cols="41" rows="4" id="textarea8"><%=Skin_CSS(24)%></textarea></td>
    </tr>
    <tr class="tdbg"> 
      <td><strong>&middot;�ҷ��������ⵥԪ���CSS���壨1��</strong><br>
        ��ӦCSS�еġ�.title_right�����ɶ�������Ϊ����������ͼ�����弰����ɫ��<br> <font color="#0000FF">���ã�Class=title_right</font></td>
      <td><textarea name="Title_Right" cols="41" rows="4" id="Title_Right"><%=Skin_CSS(25)%></textarea></td>
    </tr>
    <tr class="tdbg"> 
      <td><strong>&middot;�ҷ��������ݵ�Ԫ���CSS���壨1��</strong><br>
        ��ӦCSS�еġ�.tdbg_right�����ɶ�������Ϊ����������ͼ�����弰����ɫ��<br> <font color="#0000FF">���ã�Class=tdbg_right</font></td>
      <td><textarea name="tdbg_right" cols="41" rows="4" id="textarea17"><%=Skin_CSS(26)%></textarea></td>
    </tr>
    <tr class="tdbg"> 
      <td><strong>&middot;�ҷ��������ⵥԪ���CSS���壨2��</strong><font color="#CC0000">*</font><br>
        ��ӦCSS�еġ�.title_right2�����ɶ�������Ϊ����������ͼ�����弰����ɫ��<font color="#666666">��ע�����õ�CSS��</font><br> <font color="#0000FF">���ã�Class=title_right2</font></td>
      <td><textarea name="Title_Right2" cols="41" rows="4" id="textarea16"><%=Skin_CSS(27)%></textarea></td>
    </tr>
    <tr class="tdbg"> 
      <td><strong>&middot;�ҷ��������ݵ�Ԫ���CSS���壨2��</strong><font color="#CC0000">*</font><br>
        ��ӦCSS�еġ�.tdbg_right2�����ɶ�������Ϊ����������ͼ�����弰����ɫ��<font color="#666666">��ע�����õ�CSS��</font><br> <font color="#0000FF">���ã�Class=tdbg_right2</font></td>
      <td><textarea name="tdbg_right2" cols="41" rows="4" id="textarea18"><%=Skin_CSS(28)%></textarea></td>
    </tr>
    <tr class="tdbg"> 
      <td><strong>&middot;�ҷ��������ݵ�Ԫ�񱳾���CSS����</strong><br>
        ��ӦCSS�еġ�.tdbg_rightall�����ɶ�������Ϊ����������ͼ�����弰����ɫ��<br> <font color="#0000FF">���ã�Class=tdbg_rightall</font></td>
      <td><textarea name="tdbg_rightall" cols="41" rows="4" id="textarea10"><%=Skin_CSS(29)%></textarea></td>
    </tr>
    <tr class="tdbg"> 
      <td colspan="2"><table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
          <tr> 
            <td><strong><font color="#CC0000">�۶����˵�����CSS�����</font></strong></td>
          </tr>
        </table></td>
    </tr>
    <tr class="tdbg"> 
      <td><strong>�����˵����CSS����</strong><br>
        ��ӦCSS�еġ�.topborder�����ɶ�������Ϊ����������ͼ�����弰����ɫ��<br> <font color="#0000FF">���ã�Class=topborder</font></td>
      <td><textarea name="topborder" cols="41" rows="4" id="topborder"><%=Skin_CSS(30)%></textarea></td>
    </tr>
    <tr class="tdbg"> 
      <td><strong>�����˵����CSS����(Logo &amp; Banner�Ϸ�)</strong><br>
        ��ӦCSS�еġ�.nav_top�����ɶ�������Ϊ����������ͼ�����弰����ɫ��<br> <font color="#0000FF">���ã�Class=nav_top</font></td>
      <td><textarea name="nav_top" cols="41" rows="4" id="nav_top"><%=Skin_CSS(31)%></textarea></td>
    </tr>
    <tr class="tdbg"> 
      <td><strong>�����˵����CSS����(Logo &amp; Banner����)</strong><br>
        ��ӦCSS�еġ�.nav_main�����ɶ�������Ϊ����������ͼ�����弰����ɫ��<br> <font color="#0000FF">���ã�Class=nav_main</font></td>
      <td><textarea name="nav_main" cols="41" rows="4" id="nav_main"><%=Skin_CSS(32)%></textarea></td>
    </tr>
    <tr class="tdbg"> 
      <td><strong>�����˵����CSS����(Logo &amp; Banner�·�)</strong><br>
        ��ӦCSS�еġ�.nav_bottom�����ɶ�������Ϊ����������ͼ�����弰����ɫ��<br> <font color="#0000FF">���ã�Class=nav_bottom</font></td>
      <td><textarea name="nav_bottom" cols="41" rows="4" id="nav_bottom"><%=Skin_CSS(33)%></textarea></td>
    </tr>
    <tr class="tdbg"> 
      <td><strong>�����˵����CSS����(�����˵�����)</strong><br>
        ��ӦCSS�еġ�.nav_menu�����ɶ�������Ϊ����������ͼ�����弰����ɫ��<br> <font color="#0000FF">���ã�Class=nav_menu</font></td>
      <td><textarea name="nav_menu" cols="41" rows="4" id="nav_menu"><%=Skin_CSS(34)%></textarea></td>
    </tr>
    <tr class="tdbg"> 
      <td><strong>�����˵�CSS����</strong><br>
        ��ӦCSS�еġ�.menu�����ɶ�������Ϊ����������ͼ�����弰����ɫ��<br> <font color="#0000FF">���ã�Class=menu</font></td>
      <td><textarea name="menu" cols="41" rows="4" id="menu"><%=Skin_CSS(35)%></textarea></td>
    </tr>
    <tr class="tdbg"> 
      <td><strong>�����˵����岿��CSS����</strong><br>
        ��ӦCSS�еġ�td.MenuBody�����ɶ�������Ϊ����������ͼ�����弰����ɫ��<br> <font color="#0000FF">���ã�Class=MenuBody</font></td>
      <td><textarea name="MenuBody" cols="41" rows="4" id="MenuBody"><%=Skin_CSS(36)%></textarea></td>
    </tr>
    <tr align="center" class="tdbg"> 
      <td height="50" colspan="2"><%if Action="Add" then%> <input name="Action" type="hidden" id="Action" value="SaveAdd"> 
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
	call CheckSkin()
	if FoundErr=True then exit sub
	
	sql="select top 1 * from Skin"
	Set rs=Server.CreateObject("Adodb.RecordSet")
	rs.Open sql,conn,1,3
	rs.addnew
	rs("IsDefault")=False
	rs("DesignType")=1
	call SaveSkin()
	rs.close
	set rs=nothing
	call WriteSuccessMsg("�ɹ�����µ���ɫģ�壺"& trim(request("SkinName")))	
end sub

sub SaveModify()
	
	if SkinID="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>��ָ��SkinID</li>"
	else
		SkinID=Clng(SkinID)
	end if
	call CheckSkin()
	if FoundErr=True then exit sub
	
	sql="select * from Skin where SkinID=" & SkinID
	Set rs=Server.CreateObject("Adodb.RecordSet")
	rs.Open sql,conn,1,3
	if rs.bof and rs.eof then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>�Ҳ���ָ������ɫģ�壡</li>"
	else
		call SaveSkin()
		call WriteSuccessMsg("������ɫģ�����óɹ���")
	end if
	rs.close
	set rs=nothing	
end sub

sub SetDefault()
	if SkinID="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>��ָ��SkinID</li>"
		exit sub
	else
		SkinID=Clng(SkinID)
	end if
	conn.execute("update Skin set IsDefault=False where IsDefault=True")
	conn.execute("update Skin set IsDefault=True where SkinID=" & SkinID)
	call WriteSuccessMsg("�ɹ���ѡ����ģ������ΪĬ��ģ��")
end sub

sub CheckSkin()
	if trim(request("SkinName"))="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>ģ�����Ʋ���Ϊ�գ�</li>"
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

sub SaveSkin()
	rs("SkinName")=trim(request("SkinName"))
	rs("PicUrl")=trim(request("PicUrl"))
	rs("DesignerName")=trim(request("DesignerName"))
	rs("DesignerEmail")=trim(request("DesignerEmail"))
	rs("DesignerHomePage")=trim(request("DesignerHomepage"))
	rs("Body")=trim(request("Body"))
	dim Skin_CSS
	Skin_CSS= request("Link") & "|||" & request("CSS_Body") & "|||" & request("TD") & "|||" & request("Input") & "|||" & request("Button") & "|||" & request("Select") & "|||"
	Skin_CSS=Skin_CSS & request("border") & "|||" & request("border2") & "|||" & request("title_txt") & "|||" & request("title") & "|||" & request("tdbg") & "|||" & request("txt_css") & "|||"
	Skin_CSS=Skin_CSS & request("title_lefttxt") & "|||" & request("title_left") & "|||" & request("tdbg_left") & "|||" & request("title_left2") & "|||" & request("tdbg_left2") & "|||" & request("tdbg_leftall") & "|||"
	Skin_CSS=Skin_CSS & request("title_maintxt") & "|||" & request("title_main") & "|||" & request("tdbg_main") & "|||" & request("title_main2") & "|||" & request("tdbg_main2") & "|||" & request("tdbg_mainall") & "|||"
	Skin_CSS=Skin_CSS & request("title_righttxt") & "|||" & request("title_right") & "|||" & request("tdbg_right") & "|||" & request("title_right2") & "|||" & request("tdbg_right2") & "|||" & request("tdbg_rightall") & "|||"
	Skin_CSS=Skin_CSS & request("topborder") & "|||" & request("nav_top") & "|||" & request("nav_main") & "|||" & request("nav_bottom") & "|||" & request("nav_menu") & "|||" & request("menu") & "|||" & request("MenuBody")
	rs("Skin_CSS")=Skin_CSS
	rs.update
end sub

sub DelSkin()
	if SkinID="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>��ָ��SkinID</li>"
		exit sub
	else
		SkinID=Clng(SkinID)
	end if
	sql="select * from Skin where SkinID=" & SkinID
	Set rs=Server.CreateObject("Adodb.RecordSet")
	rs.Open sql,conn,1,3
	if rs.bof and rs.eof then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>�Ҳ���ָ������ɫģ�壡</li>"
	else
		if rs("DesignType")=0 then
			FoundErr=True
			ErrMsg=ErrMsg & "<br><li>����ɾ��ϵͳ�Դ���ģ�壡</li>"
		elseif rs("IsDefault")=True then
			FoundErr=True
			ErrMsg=ErrMsg & "<br><li>��ǰģ��ΪĬ��ģ�壬����ɾ�������Ƚ�Ĭ��ģ���Ϊ����ģ�������ɾ����ģ�塣</li>"
		end if
	end if
	if FoundErr=True then
		rs.close
		set rs=nothing
		exit sub
	end if
	rs.delete
	rs.update
	rs.close
	set rs=nothing
	dim trs
	set trs=conn.execute("select SkinID from Skin where IsDefault=True")
	conn.execute("update ArticleClass set SkinID=" & trs(0) & " where SkinID=" & SkinID)
	conn.execute("update Article set SkinID=" & trs(0) & " where SkinID=" & SkinID)
	set trs=nothing
	call WriteSuccessMsg("�ɹ�ɾ��ѡ����ģ�塣����ʹ�ô�ģ�����Ŀ�����¸�Ϊʹ��Ĭ��ģ�塣")	
end sub

sub DoExport()
	on error resume next
	dim mdbname,tconn,trs
	SkinID=replace(SkinID,"'","")
	mdbname=replace(trim(request.form("skinmdb")),"'","")
	if SkinID="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>��ָ��Ҫ������ģ��</li>"
	end if
	if mdbname="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>����д����ģ�����ݿ���"
	end if
	
	if FoundErr=True then
		exit sub
	end if
	
	Set tconn = Server.CreateObject("ADODB.Connection")
	tconn.open "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & Server.MapPath(mdbname)
	if err.number<>0 then
		ErrMsg=ErrMsg & "<br><li>���ݿ����ʧ�ܣ����Ժ����ԣ�����ԭ��" & err.Description
		err.clear
		exit sub
	end if
	tconn.execute("delete * from Skin")
	set rs=conn.execute("select * from Skin where SkinID in (" & SkinID &")  order by SkinID ")
	set trs=server.CreateObject("adodb.recordset")
	trs.open "select * from Skin",tconn,1,3
	do while not rs.eof
		trs.addnew
		trs("SkinName")=rs("SkinName")
		trs("PicUrl")=rs("PicUrl")
		trs("DesignerName")=rs("DesignerName")
		trs("DesignerEmail")=rs("DesignerEmail")
		trs("DesignerHomePage")=rs("DesignerHomePage")
		trs("Body")=rs("Body")
		trs("Skin_CSS")=rs("Skin_CSS")
		trs("IsDefault")=False
		trs("DesignType")=rs("DesignType")
		trs.update
		rs.movenext
	loop
	trs.close
	set trs=nothing
	rs.close
	set rs=nothing
	tconn.close
	set tconn=nothing
	call WriteSuccessMsg("�Ѿ��ɹ�����ѡ�е�ģ�����õ�����ָ�������ݿ��У�<br><br>�㻹��Ҫ��Skin�ļ�����ͼƬ�ļ�һ������")
end sub

sub DoImport()
	on error resume next
	dim mdbname,tconn,trs
	SkinID=replace(SkinID,"'","")
	mdbname=replace(trim(request.form("skinmdb")),"'","")
	if SkinID="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>��ָ��Ҫ�����ģ��</li>"
	end if
	if mdbname="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>����д����ģ�����ݿ���"
	end if
	
	if FoundErr=True then
		exit sub
	end if
	
	Set tconn = Server.CreateObject("ADODB.Connection")
	tconn.open "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & Server.MapPath(mdbname)
	if err.number<>0 then
		ErrMsg=ErrMsg & "<br><li>���ݿ����ʧ�ܣ����Ժ����ԣ�����ԭ��" & err.Description
		err.clear
		exit sub
	end if
	
	set rs=tconn.execute(" select * from Skin where SkinID in (" & SkinID &")  order by SkinID")
	set trs=server.CreateObject("adodb.recordset")
	trs.open "select * from Skin",conn,1,3
	do while not rs.eof
		trs.addnew
		trs("SkinName")=rs("SkinName")
		trs("PicUrl")=rs("PicUrl")
		trs("DesignerName")=rs("DesignerName")
		trs("DesignerEmail")=rs("DesignerEmail")
		trs("DesignerHomePage")=rs("DesignerHomePage")
		trs("Body")=rs("Body")
		trs("Skin_CSS")=rs("Skin_CSS")
		trs("IsDefault")=False
		trs("DesignType")=rs("DesignType")
		trs.update
		rs.movenext
	loop
	trs.close
	set trs=nothing
	rs.close
	set rs=nothing
	tconn.close
	set tconn=nothing
	call WriteSuccessMsg("�Ѿ��ɹ���ָ�������ݿ��е���ѡ�е�ģ�壡<br><br>�㻹��Ҫ��ͼƬ�ļ����Ƶ�SkinĿ¼�е���Ӧ�ļ����в�������ɵ��빤����")
end sub
%>
