<%@language=vbscript codepage=936 %>
<%
option explicit
response.buffer=true	
Const PurviewLevel=2
Const CheckChannelID=0
Const PurviewLevel_Others="FriendSite"
%>
<!--#include file="inc/conn.asp"-->
<!--#include file="inc/config.asp"-->
<!--#include file="Admin_ChkPurview.asp"-->
<!--#include file="inc/function.asp"-->
<!--#include file="inc/md5.asp"-->
<!--#include file="inc/ubbcode.asp"-->
<%
dim strFileName
const MaxPerPage=20
dim totalPut,CurrentPage,TotalPages
dim sql,rs,ID,LinkType
dim Action,FoundErr,ErrMsg
Action=trim(request("Action"))
ID=Trim(Request("ID"))
LinkType=trim(request("LinkType"))
strFileName="Admin_FriendSite.asp?LinkType=" & LinkType

if request("page")<>"" then
    currentPage=cint(request("page"))
else
	currentPage=1
end if

if ID<>"" then
	if Action="Check" then
		conn.execute "Update FriendSite set IsOK=True where ID=" & CLng(ID)
	elseif Action="CancelCheck" then
		conn.execute "Update FriendSite set IsOK=False Where ID=" & CLng(ID)
	elseif Action="Good" then
		conn.execute "Update FriendSite set IsGood=True Where ID=" & CLng(ID)
	elseif Action="CancelGood" then
		conn.execute "Update FriendSite set IsGood=False Where ID=" & CLng(ID)
	elseif Action="Del" then
		conn.execute "Delete From FriendSite Where ID=" & CLng(ID)
	end if
end if
%>
<html>
<head>
<title>�������ӹ���</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" type="text/css" href="Admin_Style.css">
<script LANGUAGE="javascript">
function Check() {
if (document.AddLink.SiteName.value=="")
	{
	  alert("��������վ���ƣ�")
	  document.AddLink.SiteName.focus()
	  return false
	 }
if (document.AddLink.SiteUrl.value=="")
	{
	  alert("��������վ��ַ��")
	  document.AddLink.SiteUrl.focus()
	  return false
	 }
if (document.AddLink.SiteUrl.value=="http://")
	{
	  alert("��������վ��ַ��")
	  document.AddLink.SiteUrl.focus()
	  return false
	 }
if (document.AddLink.SiteAdmin.value=="")
	{
	  alert("������վ��������")
	  document.AddLink.SiteAdmin.focus()
	  return false
	 }
if (document.AddLink.Email.value=="")
	{
	  alert("����������ʼ���ַ��")
	  document.AddLink.Email.focus()
	  return false
	 }
if (document.AddLink.Email.value=="@")
	{
	  alert("����������ʼ���ַ��")
	  document.AddLink.Email.focus()
	  return false
	 }
if (document.AddLink.Action.value=="SaveAdd"&&document.AddLink.SitePassword.value=="")
	{
	  alert("��������վ���룡")
	  document.AddLink.SitePassword.focus()
	  return false
	 }
if (document.AddLink.Action.value=="SaveAdd"&&document.AddLink.SitePwdConfirm.value=="")
	{
	  alert("������ȷ�����룡")
	  document.AddLink.SitePwdConfirm.focus()
	  return false
	 }
if (document.AddLink.SitePwdConfirm.value!=document.AddLink.SitePassword.value)
	{
	  alert("��վ������ȷ�����벻һ�£�")
	  document.AddLink.SitePwdConfirm.focus()
	  document.AddLink.SitePwdConfirm.select()
	  return false
	 }
if (document.AddLink.SiteIntro.value=="")
	{
	  alert("��������վ��飡")
	  document.AddLink.SiteIntro.focus()
	  return false
	 }
}

function ConfirmDel()
{
   if(confirm("ȷ��Ҫɾ������������վ����"))
     return true;
   else
     return false;
}
</script>
</head>
<body leftmargin="2" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" Class="border">
  <tr class="topbg"> 
    <td height="22" colspan=2 align=center><strong>�� �� �� �� �� ��</strong></td>
  </tr>
  <tr class="tdbg"> 
    <td width="70" height="30"><strong>��������</strong></td>
    <td height="30"><a href="Admin_FriendSite.asp?Action=Add">�����������</a>&nbsp;|&nbsp;<a href="Admin_FriendSite.asp?LinkType=2">��������</a>&nbsp;|&nbsp;<a href="Admin_FriendSite.asp?LinkType=1">LOGO����</a>&nbsp;|&nbsp;<a href="Admin_FriendSite.asp">��������</a></td>
  </tr>
</table>
<br>
<%
if Action="Add" then
	call Add()
elseif Action="SaveAdd" then
	call SaveAdd()
elseif Action="Modify" then
	call Modify()
elseif Action="SaveModify" then
	call SaveModify()
else
	call main()
end if
if FoundErr=True then
	call WriteErrMsg()
end if
call CloseConn()

sub main()
	sql="select * from FriendSite "
	if LinkType<>"" then
		LinkType=CInt(LinkType)
		if LinkType=1 then
			sql=sql & " where LinkType=1 "
		elseif LinkType=2 then
			sql=sql & " where LinkType=2 "
		end if
	end if
	sql=sql & "order by id desc"
	set rs=server.createobject("adodb.recordset")
	rs.open sql,conn,1,1
	
  	if rs.eof and rs.bof then
		response.write "Ŀǰ���� 0 ����������"
	else
    	totalPut=rs.recordcount
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
        	showpage strFileName,totalput,MaxPerPage,true,true,"��վ��"
   	 	else
   	     	if (currentPage-1)*MaxPerPage<totalPut then
         	   	rs.move  (currentPage-1)*MaxPerPage
         		dim bookmark
           		bookmark=rs.bookmark
            	showContent
            	showpage strFileName,totalput,MaxPerPage,true,true,"��վ��"
        	else
	        	currentPage=1
           		showContent
           		showpage strFileName,totalput,MaxPerPage,true,true,"��վ��"
	    	end if
		end if
	end if
	rs.close
	set rs=nothing
end sub

sub showContent
   	dim i
    i=0
%>
  <table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" Class="border">
    <tr class="title">
      <td width="50" height="22" align="center">��������</td>
      <td width="80" height="22" align="center">��վ����</td>
      <td width="100" height="22" align="center">��վLOGO</td>
      <td width="150" height="22" align="center">��վ���</td>
      <td width="60" height="22" align="center">վ��</td>
      <td width="50" height="22" align="center">״̬</td>
      <td width="100" height="22" align="center">����</td>
    </tr>
<%
do while not rs.eof
%>
    <tr class="tdbg" onmouseout="this.style.backgroundColor=''" onmouseover="this.style.backgroundColor='#BFDFFF'">
      <td width="50" align="center">
	  <%
	  if rs("LinkType")=1 then
	  	response.write "<a href='Admin_FriendSite.asp?LinkType=1'>LOGO����</a>"
	  else
		response.write "<a href='Admin_FriendSite.asp?LinkType=2'>��������</a>"
	  end if
	  %></td>
      <td width="80"><a href="<%=rs("SiteUrl")%>" target='blank' title="<%=rs("SiteUrl")%>"><%=rs("SiteName")%></a></td>
      <td width="100" align="center">
<%
if rs("LogoUrl")<>"" and rs("LogoUrl")<>"http://" then
	if lcase(right(rs("LogoUrl"),3))="swf" then
		Response.Write "<object classid='clsid:D27CDB6E-AE6D-11cf-96B8-444553540000' codebase='http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=5,0,0,0' width='88' height='31'><param name='movie' value='" & rs("LogoUrl") & "'><param name='quality' value='high'><embed src='" & rs("LogoUrl") & "' pluginspage='http://www.macromedia.com/shockwave/download/index.cgi?P1_Prod_Version=ShockwaveFlash' type='application/x-shockwave-flash' width='88' height='31'></embed></object>"
	else
		response.write "<a href='" & rs("SiteUrl") & "' target='_blank' title='" & rs("LogoUrl") & "'><img src='" & rs("LogoUrl") & "' width='88' height='31' border='0'></a>"
	end if
else
	response.write "&nbsp;"
end if
%> </td>
      <td width="150"><%=rs("SiteIntro")%></td>
      <td width="60" align="center"><a href="mailto:<%=rs("Email")%>"><%=rs("SiteAdmin")%></a></td>
      <td width="50" align="center"> <%
	  if rs("IsOK")=True then
	  	response.write "�����"
	  else
	    response.write "&nbsp;"
	  end if
	  if rs("IsGood")=True then
	  	response.write "<br>�Ƽ�"
	  end if
	  %> </td>
      <td width="100" align="center"> <%
	  If rs("IsOK")=False Then 
        response.write "<a href='Admin_FriendSite.asp?ID=" & rs("ID") & "&Action=Check'>���ͨ��</a>&nbsp;&nbsp;"
      Else
        response.write "<a href='Admin_FriendSite.asp?ID=" & rs("ID") & "&Action=CancelCheck'>ȡ�����</a>&nbsp;&nbsp;"
      End If
	  response.write "<a href='Admin_FriendSite.asp?Action=Modify&ID=" & rs("ID") & "'>�޸�</a><br>"
	  if rs("IsGood")=False then
        response.write "<a href='Admin_FriendSite.asp?ID=" & rs("ID") & "&Action=Good'>��Ϊ�Ƽ�</a>&nbsp;&nbsp;"
      Else
        response.write "<a href='Admin_FriendSite.asp?ID=" & rs("ID") & "&Action=CancelGood'>ȡ���Ƽ�</a>&nbsp;&nbsp;"
      End If
      response.write "<a href='Admin_FriendSite.asp?Action=Del&ID=" & rs("ID") & "' onclick='return ConfirmDel();'>ɾ��</a>"
	  %> </td>
    </tr>
    <%
	i=i+1
	if i>=MaxPerPage then exit do
	rs.movenext
loop
%>
  </table>
<%
end sub

sub Add()
%>
<form method="post" name="AddLink" onsubmit="return Check()" action="Admin_FriendSite.asp">
  <table border="0" cellpadding="2" cellspacing="1" align="center" width="100%" class="border">
    <tr class="title"> 
      <td height="22" colspan="2" align="center"><strong>�����������</strong></td>
    </tr>
    <tr class="tdbg"> 
      <td width="300" height="25"><strong>�������ͣ�</strong></td>
      <td height="25"><input name="LinkType" type="radio" value="1" checked>
        Logo����&nbsp;&nbsp;&nbsp;&nbsp; <input type="radio" name="LinkType" value="2">
        ��������</td>
    </tr>
    <tr class="tdbg"> 
      <td width="300" height="25" valign="middle"><strong>��վ���ƣ�</strong></td>
      <td height="25"> <input name="SiteName" size="30"  maxlength="20" title="����������������վ���ƣ����Ϊ20������"> 
        <font color="#FF0000"> *</font></td>
    </tr>
    <tr class="tdbg"> 
      <td width="300" height="25"><strong>��վ��ַ��</strong></td>
      <td height="25"> <input name="SiteUrl" size="30"  maxlength="100" type="text"  value="http://" title="����������������վ��ַ�����Ϊ50���ַ���ǰ������http://"> 
        <font color="#FF0000">*</font></td>
    </tr>
    <tr class="tdbg"> 
      <td width="300" height="25"><strong>��վLogo��</strong></td>
      <td height="25"> <input name="LogoUrl" size="30"  maxlength="100" type="text"  value="http://" title="����������������վLogoUrl��ַ�����Ϊ50���ַ���������ڵ�һѡ��ѡ������������ӣ�����Ͳ�����"> 
      </td>
    </tr>
    <tr class="tdbg"> 
      <td width="300" height="25"><strong>վ��������</strong></td>
      <td height="25"> <input name="SiteAdmin" size="30"  maxlength="20" type="text"  title="�������������Ĵ����ˣ���Ȼ��֪������˭�������Ϊ20���ַ�"> 
        <font color="#FF0000">*</font></td>
    </tr>
    <tr class="tdbg"> 
      <td width="300" height="25"><strong>�����ʼ���</strong></td>
      <td height="25"> <input name="Email" size="30"  maxlength="30" type="text"  value="@" title="����������������ϵ�����ʼ������Ϊ30���ַ�"> 
        <font color="#FF0000">*</font></td>
    </tr>
    <tr class="tdbg"> 
      <td width="300" height="25"><strong>��վ���룺</strong><br>
        �����޸���Ϣʱ�á�</td>
      <td height="25"><input name="SitePassword" type="password" id="SitePassword" size="20" maxlength="20">
        <font color="#FF0000">*</font> </td>
    </tr>
    <tr class="tdbg"> 
      <td width="300" height="25"><strong>ȷ�����룺</strong></td>
      <td height="25"><input name="SitePwdConfirm" type="password" id="SitePwdConfirm" size="20" maxlength="20"> 
        <font color="#FF0000">*</font> </td>
    </tr>
    <tr class="tdbg"> 
      <td width="300"><strong>��վ��飺</strong></td>
      <td valign="middle"> <textarea name="SiteIntro" cols="40" rows="5" id="SiteIntro" title="����������������վ�ļ򵥽���"></textarea></td>
    </tr>
    <tr class="tdbg"> 
      <td width="300" height="25"><strong>�Ƽ�վ�㣺</strong></td>
      <td height="25" valign="middle"> <input name="IsGood" type="radio" value="True" checked>
        ��&nbsp;&nbsp;&nbsp;&nbsp; <input type="radio" name="IsGood" value="False">
        ��</td>
    </tr>
    <tr class="tdbg"> 
      <td width="300" height="25"><strong>���ͨ����</strong></td>
      <td height="25" valign="middle"><input name="IsOK" type="radio" value="True" checked>
        ��&nbsp;&nbsp;&nbsp;&nbsp; <input type="radio" name="IsOK" value="False">
        ��</td>
    </tr>
    <tr class="tdbg"> 
      <td height="40" colspan="2" align="center"><input name="Action" type="hidden" id="Action" value="SaveAdd"> 
        <input type="submit" value=" ȷ �� " name="cmdOk"> &nbsp; <input type="reset" value=" �� �� " name="cmdReset"> 
      </td>
    </tr>
  </table>
</form>
<%
end sub

sub Modify()
	if ID="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>��ָ������վ��ID</li>"
		exit sub
	else
		ID=Clng(ID)
	end if
	dim sqlLink,rsLink
	sqlLink="select * from FriendSite where ID=" & ID
	set rsLink=Server.CreateObject("Adodb.RecordSet")
	rsLink.open sqlLink,conn,1,3
	if rsLink.bof and rsLink.eof then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>�Ҳ���վ�㣡</li>"
		rsLink.close
		set rsLink=nothing
		exit sub
	end if

%>
<form method="post" name="AddLink" onsubmit="return Check()" action="Admin_FriendSite.asp">
  <table border="0" cellpadding="2" cellspacing="1" align="center" width="100%" class="border">
    <tr class="title"> 
      <td height="22" colspan="2" align="center"><strong>�޸�����������Ϣ</strong></td>
    </tr>
    <tr class="tdbg"> 
      <td width="300" height="25"><strong>�������ͣ�</strong></td>
      <td height="25"><input name="LinkType" type="radio" value="1" <%if rsLink("LinkType")=1 then response.write "checked"%>>
        Logo����&nbsp;&nbsp;&nbsp;&nbsp; <input type="radio" name="LinkType" value="2" <%if rsLink("LinkType")=2 then response.write "checked"%>>
        ��������</td>
    </tr>
    <tr class="tdbg"> 
      <td width="300" height="25" valign="middle"><strong>��վ���ƣ�</strong></td>
      <td height="25"> <input name="SiteName" title="����������������վ���ƣ����Ϊ20������" value="<%=rsLink("SiteName")%>" size="30"  maxlength="20"> 
        <font color="#FF0000"> *</font></td>
    </tr>
    <tr class="tdbg"> 
      <td width="300" height="25"><strong>��վ��ַ��</strong></td>
      <td height="25"> <input name="SiteUrl" size="30"  maxlength="100" type="text"  value="<%=rsLink("SiteUrl")%>" title="����������������վ��ַ�����Ϊ50���ַ���ǰ������http://"> 
        <font color="#FF0000">*</font></td>
    </tr>
    <tr class="tdbg"> 
      <td width="300" height="25"><strong>��վLogo��</strong></td>
      <td height="25"> <input name="LogoUrl" size="30"  maxlength="100" type="text"  value="<%=rsLink("LogoUrl")%>" title="����������������վLogoUrl��ַ�����Ϊ50���ַ���������ڵ�һѡ��ѡ������������ӣ�����Ͳ�����"> 
      </td>
    </tr>
    <tr class="tdbg"> 
      <td width="300" height="25"><strong>վ��������</strong></td>
      <td height="25"> <input name="SiteAdmin" type="text"  title="�������������Ĵ����ˣ���Ȼ��֪������˭�������Ϊ20���ַ�" value="<%=rsLink("SiteAdmin")%>" size="30"  maxlength="20"> 
        <font color="#FF0000">*</font></td>
    </tr>
    <tr class="tdbg"> 
      <td width="300" height="25"><strong>�����ʼ���</strong></td>
      <td height="25"> <input name="Email" size="30"  maxlength="30" type="text"  value="<%=rsLink("Email")%>" title="����������������ϵ�����ʼ������Ϊ30���ַ�"> 
        <font color="#FF0000">*</font></td>
    </tr>
    <tr class="tdbg"> 
      <td width="300" height="25"><strong>��վ���룺</strong><br><font color="#FF0000">
        �����޸ģ��뱣��Ϊ��</font></td>
      <td height="25"><input name="SitePassword" type="password" id="SitePassword" size="20" maxlength="20">
      </td>
    </tr>
    <tr class="tdbg"> 
      <td width="300" height="25"><strong>ȷ�����룺</strong></td>
      <td height="25"><input name="SitePwdConfirm" type="password" id="SitePwdConfirm" size="20" maxlength="20"> 
      </td>
    </tr>
    <tr class="tdbg"> 
      <td width="300"><strong>��վ��飺</strong></td>
      <td valign="middle"> <textarea name="SiteIntro" cols="40" rows="5" id="SiteIntro" title="����������������վ�ļ򵥽���"><%=rsLink("SiteIntro")%></textarea></td>
    </tr>
    <tr class="tdbg"> 
      <td width="300" height="25"><strong>�Ƽ�վ�㣺</strong></td>
      <td height="25" valign="middle"> <input name="IsGood" type="radio" value="True" <%if rsLink("IsGood")=True then response.write "checked"%>>
        ��&nbsp;&nbsp;&nbsp;&nbsp; <input type="radio" name="IsGood" value="False" <%if rsLink("IsGood")=False then response.write "checked"%>>
        ��</td>
    </tr>
    <tr class="tdbg"> 
      <td width="300" height="25"><strong>���ͨ����</strong></td>
      <td height="25" valign="middle"><input name="IsOK" type="radio" value="True" <%if rsLink("IsOK")=True then response.write "checked"%>>
        ��&nbsp;&nbsp;&nbsp;&nbsp; <input type="radio" name="IsOK" value="False" <%if rsLink("IsOK")=False then response.write "checked"%>>
        ��</td>
    </tr>
    <tr class="tdbg"> 
      <td height="40" colspan="2" align="center"><input name="ID" type="hidden" id="ID" value="<%=rsLink("ID")%>"> 
        <input name="Action" type="hidden" id="Action" value="SaveModify"> <input type="submit" value=" ȷ �� " name="cmdOk"> 
      </td>
    </tr>
  </table>
</form>
<%
	rsLink.close
	set rsLink=nothing
end sub
%></body>
</html>
<%

sub SaveAdd()
	dim LinkType,LinkSiteName,LinkSiteUrl,LinkLogoUrl,LinkSiteAdmin,LinkEmail,LinkSitePassword,LinkSitePwdConfirm,LinkSiteIntro,LinkIsGood,LinkIsOK
	LinkType=trim(request("LinkType"))
	LinkSiteName=trim(request("SiteName"))
	LinkSiteUrl=trim(request("SiteUrl"))
	LinkLogoUrl=trim(request("LogoUrl"))
	LinkSiteAdmin=trim(request("SiteAdmin"))
	LinkEmail=trim(request("Email"))
	LinkSitePassword=trim(request("SitePassword"))
	LinkSitePwdConfirm=trim(request("SitePwdConfirm"))
	LInkSiteIntro=trim(request("SiteIntro"))
	LinkIsGood=trim(request("IsGood"))
	LinkIsOK=trim(request("IsOK"))
	if LinkType="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>�������Ͳ���Ϊ�գ�</li>"
	else
		LinkType=Cint(LinkType)
		if LinkType=1 and (LinkLogoUrl="" or LinkLogoUrl="http://") then
			FoundErr=True
			ErrMsg=ErrMsg & "<br><li>��վLOGO����Ϊ�գ�</li>"
		end if
	end if
	if LinkSiteName="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>��վ���Ʋ���Ϊ�գ�</li>"
	end if
	if LinkSiteUrl="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>��վ��ַ����Ϊ�գ�</li>"
	end if
	if LinkSiteAdmin="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>վ����������Ϊ�գ�</li>"
	end if
	if LinkEmail="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>Email����Ϊ�գ�</li>"
	else
		if IsValidEmail(LinkEmail)=false then
			errmsg=errmsg & "<br><li>Email��ַ����!</li>"
	   		founderr=true
		end if
	end if
	if LinkSitePassword="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>��վ���벻��Ϊ�գ�</li>"
	end if
	if LinkSitePwdConfirm="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>ȷ�����벻��Ϊ�գ�</li>"
	end if
	if LinkSitePwdConfirm<>LinkSitePassword then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>��վ������ȷ�����벻һ�£�</li>"
	end if
	if LinkSiteIntro="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>��վ��鲻��Ϊ�գ�</li>"
	end if
	if LinkSiteIntro="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>��վ��鲻��Ϊ�գ�</li>"
	end if
	if LinkIsGood="True" then
		LinkIsGood=True
	else
		LinkIsGood=False
	end if
	if LinkIsOK="True" then
		LinkIsOK=True
	else
		LinkIsOK=False
	end if
	if FoundErr<>True then
		dim sqlLink,rsLink
		sqlLink="select top 1 * from FriendSite where SiteName='" & dvHtmlEncode(LinkSiteName) & "' and SiteUrl='" & dvHtmlEncode(LinkSiteUrl) & "'"
		set rsLink=Server.CreateObject("Adodb.RecordSet")
		rsLink.open sqlLink,conn,1,3
		if not (rsLink.bof and rsLink.eof) then
			FoundErr=True
			ErrMsg=ErrMsg & "<br><li>��Ҫ��ӵ���վ�Ѿ����ڣ�</li>"
		else
			rsLink.Addnew
			rsLink("LinkType")=LinkType
			rsLink("SiteName")=dvHtmlEncode(LinkSiteName)
			rsLink("SiteUrl")=dvHtmlEncode(LinkSiteUrl)
			rsLink("LogoUrl")=dvHtmlEncode(LinkLogoUrl)
			rsLink("SiteAdmin")=dvHtmlEncode(LinkSiteAdmin)
			rsLink("Email")=dvHtmlEncode(LinkEmail)
			rsLink("SitePassword")=md5(LinkSitePassword)
			rsLink("SiteIntro")=dvHtmlEncode(LinkSiteIntro)
			rsLink("IsGood")=LinkIsGood
			rsLink("IsOK")=LinkIsOK
			rsLink.update
			rsLink.close
			set rsLink=nothing
			call CloseConn()
			Response.Redirect "Admin_FriendSite.asp"
		end if
		rsLink.close
		set rsLink=nothing
	end if
end sub

sub SaveModify()
	if ID="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>��ָ������վ��ID</li>"
		exit sub
	else
		ID=Clng(ID)
	end if
	dim LinkType,LinkSiteName,LinkSiteUrl,LinkLogoUrl,LinkSiteAdmin,LinkEmail,LinkSitePassword,LinkSitePwdConfirm,LinkSiteIntro,LinkIsGood,LinkIsOK
	LinkType=trim(request("LinkType"))
	LinkSiteName=trim(request("SiteName"))
	LinkSiteUrl=trim(request("SiteUrl"))
	LinkLogoUrl=trim(request("LogoUrl"))
	LinkSiteAdmin=trim(request("SiteAdmin"))
	LinkEmail=trim(request("Email"))
	LinkSitePassword=trim(request("SitePassword"))
	LinkSitePwdConfirm=trim(request("SitePwdConfirm"))
	LInkSiteIntro=trim(request("SiteIntro"))
	LinkIsGood=trim(request("IsGood"))
	LinkIsOK=trim(request("IsOK"))
	if LinkType="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>�������Ͳ���Ϊ�գ�</li>"
	else
		LinkType=Cint(LinkType)
		if LinkType=1 and (LinkLogoUrl="" or LinkLogoUrl="http://") then
			FoundErr=True
			ErrMsg=ErrMsg & "<br><li>��վLOGO����Ϊ�գ�</li>"
		end if
	end if
	if LinkSiteName="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>��վ���Ʋ���Ϊ�գ�</li>"
	end if
	if LinkSiteUrl="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>��վ��ַ����Ϊ�գ�</li>"
	end if
	if LinkSiteAdmin="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>վ����������Ϊ�գ�</li>"
	end if
	if LinkEmail="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>Email����Ϊ�գ�</li>"
	else
		if IsValidEmail(LinkEmail)=false then
			errmsg=errmsg & "<br><li>Email��ַ����!</li>"
	   		founderr=true
		end if
	end if
	if LinkSitePwdConfirm<>LinkSitePassword then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>��վ������ȷ�����벻һ�£�</li>"
	end if
	if LinkSiteIntro="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>��վ��鲻��Ϊ�գ�</li>"
	end if
	if LinkSiteIntro="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>��վ��鲻��Ϊ�գ�</li>"
	end if
	if LinkIsGood="True" then
		LinkIsGood=True
	else
		LinkIsGood=False
	end if
	if LinkIsOK="True" then
		LinkIsOK=True
	else
		LinkIsOK=False
	end if
	if FoundErr=True then
		exit sub
	end if
	dim sqlLink,rsLink
	sqlLink="select * from FriendSite where ID=" & ID
	set rsLink=Server.CreateObject("Adodb.RecordSet")
	rsLink.open sqlLink,conn,1,3
	if rsLink.bof and rsLink.eof then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>�Ҳ���վ�㣡</li>"
	else
		rsLink("LinkType")=LinkType
		rsLink("SiteName")=dvHtmlEncode(LinkSiteName)
		rsLink("SiteUrl")=dvHtmlEncode(LinkSiteUrl)
		rsLink("LogoUrl")=dvHtmlEncode(LinkLogoUrl)
		rsLink("SiteAdmin")=dvHtmlEncode(LinkSiteAdmin)
		rsLink("Email")=dvHtmlEncode(LinkEmail)
		if LinkSitePassword<>"" then
			rsLink("SitePassword")=md5(LinkSitePassword)
		end if
		rsLink("SiteIntro")=dvHtmlEncode(LinkSiteIntro)
		rsLink("IsGood")=LinkIsGood
		rsLink("IsOK")=LinkIsOK
		rsLink.update
		rsLink.close
		set rsLink=nothing
		call CloseConn()
		Response.Redirect "Admin_FriendSite.asp"
	end if
	rsLink.close
	set rsLink=nothing
end sub
%>
