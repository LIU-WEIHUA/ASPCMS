<!--#include file="inc/conn.asp"-->
<!--#include file="inc/config.asp"-->
<!--#include file="inc/function.asp"-->
<!--#include file="inc/md5.asp"-->
<!--#include file="inc/ubbcode.asp"-->
<%
dim ID,Action,FoundErr,ErrMsg
ID=trim(request("ID"))
Action=trim(request("Action"))
if ID="" then
	call CloseConn()
	response.redirect "FriendSite.asp"
end if
dim sqlLink,rsLink
sqlLink="select * from FriendSite where ID=" & CLng(ID)
set rsLink=Server.CreateObject("Adodb.RecordSet")
rsLink.open sqlLink,conn,1,3
if rsLink.bof and rsLink.eof then
	FoundErr=True
	ErrMsg=ErrMsg & "<br><li>�Ҳ���վ�㣡</li>"
else
  if Action="Modify" then
	dim LinkType,LinkSiteName,LinkSiteUrl,LinkLogoUrl,LinkSiteAdmin,LinkEmail,OldSitePassword,LinkSitePassword,LinkSitePwdConfirm,LinkSiteIntro
	LinkType=trim(request("LinkType"))
	LinkSiteName=trim(request("SiteName"))
	LinkSiteUrl=trim(request("SiteUrl"))
	LinkLogoUrl=trim(request("LogoUrl"))
	LinkSiteAdmin=trim(request("SiteAdmin"))
	LinkEmail=trim(request("Email"))
	OldSitePassword=trim(request("OldSitePassword"))
	LinkSitePassword=trim(request("SitePassword"))
	LinkSitePwdConfirm=trim(request("SitePwdConfirm"))
	LInkSiteIntro=trim(request("SiteIntro"))
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
	if OldSitePassword="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>����վ���벻��Ϊ�գ�</li>"
	end if
	if md5(OldSitePassword)<>rsLink("SitePassword") then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>������ľ���վ���벻�ԣ�û��Ȩ���޸ģ�</li>"
	end if
	if LinkSitePwdConfirm<>LinkSitePassword then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>����վ������ȷ�����벻һ�£�</li>"
	end if
	if LinkSiteIntro="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>��վ��鲻��Ϊ�գ�</li>"
	end if
	if LinkSiteIntro="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>��վ��鲻��Ϊ�գ�</li>"
	end if
	if FoundErr<>True then
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
			rsLink.update
			rsLink.close
			set rsLink=nothing
			call CloseConn()
			Response.Redirect "FriendSite.asp"
		end if
	end if
end if
if FoundErr=True then
	call WriteErrMsg()
else
%>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<LINK href="style.css" rel="stylesheet">
<title>�޸�����������Ϣ</title>
<script LANGUAGE="javascript">
<!--
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
if (document.AddLink.OldSitePassword.value=="")
	{
	  alert("���������վ���룡")
	  document.AddLink.OldSitePassword.focus()
	  return false
	 }
if (document.AddLink.SitePwdConfirm.value!=document.AddLink.SitePassword.value)
	{
	  alert("����վ������ȷ�����벻һ�£�")
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

//-->
</script>
</head>
<body leftmargin="2" topmargin="0" marginwidth="0" marginheight="0">
<form method="post" name="AddLink" onsubmit="return Check()" action="FriendSiteModify.asp">
  <table border="0" cellpadding="2" cellspacing="1" align="center" width="400" class="border">
    <tr align="center" class="title"> 
      <td height="22" colspan="2"><strong>�޸�����������Ϣ</strong></td>
    </tr>
    <tr class="tdbg"> 
      <td width="100" height="25" align="right">�������ͣ�</td>
      <td height="25"><input name="LinkType" type="radio" value="1" <%if rsLink("LinkType")=1 then response.write "checked"%>>
        Logo����&nbsp;&nbsp;&nbsp;&nbsp; <input type="radio" name="LinkType" value="2" <%if rsLink("LinkType")=2 then response.write "checked"%>>
        ��������</td>
    </tr>
    <tr class="tdbg"> 
      <td width="100" height="25" align="right" valign="middle">��վ���ƣ�</td>
      <td height="25"> <input name="SiteName" title="����������������վ���ƣ����Ϊ20������" value="<%=rsLink("SiteName")%>" size="30"  maxlength="20"> 
        <font color="#FF0000"> *</font></td>
    </tr>
    <tr class="tdbg"> 
      <td width="100" height="25" align="right">��վ��ַ��</td>
      <td height="25"> <input name="SiteUrl" size="30"  maxlength="100" type="text"  value="<%=rsLink("SiteUrl")%>" title="����������������վ��ַ�����Ϊ50���ַ���ǰ������http://"> 
        <font color="#FF0000">*</font></td>
    </tr>
    <tr class="tdbg"> 
      <td width="100" height="25" align="right">��վLogo��</td>
      <td height="25"> <input name="LogoUrl" size="30"  maxlength="100" type="text"  value="<%=rsLink("LogoUrl")%>" title="����������������վLogoUrl��ַ�����Ϊ50���ַ���������ڵ�һѡ��ѡ������������ӣ�����Ͳ�����"> 
      </td>
    </tr>
    <tr class="tdbg"> 
      <td width="100" height="25" align="right">վ��������</td>
      <td height="25"> <input name="SiteAdmin" type="text"  title="�������������Ĵ����ˣ���Ȼ��֪������˭�������Ϊ20���ַ�" value="<%=rsLink("SiteAdmin")%>" size="30"  maxlength="20"> 
        <font color="#FF0000">*</font></td>
    </tr>
    <tr class="tdbg"> 
      <td width="100" height="25" align="right">�����ʼ���</td>
      <td height="25"> <input name="Email" size="30"  maxlength="30" type="text"  value="<%=rsLink("Email")%>" title="����������������ϵ�����ʼ������Ϊ30���ַ�"> 
        <font color="#FF0000">*</font></td>
    </tr>
    <tr class="tdbg"> 
      <td width="100" height="25" align="right">ԭ��վ���룺</td>
      <td height="25"><input name="OldSitePassword" type="password" id="OldSitePassword" size="20" maxlength="20"> 
        <font color="#FF0000">* ��������</font></td>
    </tr>
    <tr class="tdbg"> 
      <td width="100" height="25" align="right">����վ���룺</td>
      <td height="25"><input name="SitePassword" type="password" id="SitePassword" size="20" maxlength="20"> 
        <font color="#0000FF">�����޸ģ��뱣��Ϊ��</font></td>
    </tr>
    <tr class="tdbg"> 
      <td height="25" align="right">ȷ�����룺</td>
      <td height="25"><input name="SitePwdConfirm" type="password" id="SitePwdConfirm" size="20" maxlength="20"> 
      </td>
    </tr>
    <tr class="tdbg"> 
      <td width="100" align="right">��վ��飺</td>
      <td valign="middle"> <textarea name="SiteIntro" cols="40" rows="5" id="SiteIntro" title="����������������վ�ļ򵥽���"><%=rsLink("SiteIntro")%></textarea></td>
    </tr>
    <tr class="tdbg"> 
      <td height="40" colspan="2" align="center"><input name="ID" type="hidden" id="ID" value="<%=rsLink("ID")%>"> 
        <input name="Action" type="hidden" id="Action" value="Modify"> <input type="submit" value=" ȷ �� " name="cmdOk"> 
      </td>
    </tr>
  </table>
  </form>
</body>
</html>
<%
end if
rsLink.close
set rsLink=nothing
call CloseConn()
%>