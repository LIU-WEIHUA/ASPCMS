<!--#include file="inc/conn.asp"-->
<!--#include file="inc/config.asp"-->
<!--#include file="inc/function.asp"-->
<!--#include file="inc/md5.asp"-->
<!--#include file="inc/ubbcode.asp"-->
<%
dim Action,FoundErr,ErrMsg
Action=trim(request("Action"))
if EnableLinkReg="No" then
	FoundErr=True
	ErrMsg=ErrMsg & "<br><li>����Աû�п��������������룡</li>"
	call WriteErrMsg()
else
	if Action="Reg" then
		dim LinkType,LinkSiteName,LinkSiteUrl,LinkLogoUrl,LinkSiteAdmin,LinkEmail,LinkSitePassword,LinkSitePwdConfirm,LinkSiteIntro
		LinkType=trim(request("LinkType"))
		LinkSiteName=trim(request("SiteName"))
		LinkSiteUrl=trim(request("SiteUrl"))
		LinkLogoUrl=trim(request("LogoUrl"))
		LinkSiteAdmin=trim(request("SiteAdmin"))
		LinkEmail=trim(request("Email"))
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
				ErrMsg=ErrMsg & "<br><li>��������վLOGO��ַ��</li>"
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
		if FoundErr<>True then
			dim sqlLink,rsLink
			sqlLink="select top 1 * from FriendSite where SiteName='" & dvHtmlEncode(LinkSiteName) & "' and SiteUrl='" & dvHtmlEncode(LinkSiteUrl) & "'"
			set rsLink=Server.CreateObject("Adodb.RecordSet")
			rsLink.open sqlLink,conn,1,3
			if not (rsLink.bof and rsLink.eof) then
				FoundErr=True
				ErrMsg=ErrMsg & "<br><li>���������վ�Ѿ����ڣ��벻Ҫ�ظ����룡</li>"
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
				rsLink.update
				rsLink.close
				set rsLink=nothing
				call WriteSuccessMsg()
			end if
		end if
		if FoundErr=True then
			call WriteErrMsg()
		end if
	else
%>
<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<LINK href="Admin_style.css" rel="stylesheet">
<title>������������</title>
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
if (document.AddLink.SitePassword.value=="")
	{
	  alert("��������վ���룡")
	  document.AddLink.SitePassword.focus()
	  return false
	 }
if (document.AddLink.SitePwdConfirm.value=="")
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

//-->
</script>
</head>
<body leftmargin="2" topmargin="0" marginwidth="0" marginheight="0"><br>
<table width="53%" border="0" align="center">
  <tr>
    <td>�������������Ӻ�ʱ��������վ�����ӹ�������<br>���ǵ����ӷ�ʽ���£�<br>ͼƬ��ַ��http://www.fanchen.com/images/fclogo.gif<br>��վ���֣�׹�䷲��<br>��վ��ַ��http://www.fanchen.com</td>
  </tr>
</table>
<form method="post" name="AddLink" onsubmit="return Check()" action="FriendSiteReg.asp">
  <table border="0" cellpadding="2" cellspacing="1" align="center" width="400" class="border">
    <tr align="center" class="title"> 
      <td height="22" colspan="2"><strong>������������</strong></td>
    </tr>
    <tr class="tdbg"> 
      <td width="100" height="25" align="right">�������ͣ�</td>
      <td height="25"><input name="LinkType" type="radio" value="1" checked>
        Logo����&nbsp;&nbsp;&nbsp;&nbsp; <input type="radio" name="LinkType" value="2">
        ��������</td>
    </tr>
    <tr class="tdbg"> 
      <td width="100" height="25" align="right" valign="middle">��վ���ƣ�</td>
      <td height="25"> <input name="SiteName" size="30"  maxlength="20" title="����������������վ���ƣ����Ϊ20������"> 
        <font color="#FF0000"> *</font></td>
    </tr>
    <tr class="tdbg"> 
      <td width="100" height="25" align="right">��վ��ַ��</td>
      <td height="25"> <input name="SiteUrl" size="30"  maxlength="100" type="text"  value="http://" title="����������������վ��ַ�����Ϊ50���ַ���ǰ������http://"> 
        <font color="#FF0000">*</font></td>
    </tr>
    <tr class="tdbg"> 
      <td width="100" height="25" align="right">��վLogo��</td>
      <td height="25"> <input name="LogoUrl" size="30"  maxlength="100" type="text"  value="http://" title="����������������վLogoUrl��ַ�����Ϊ50���ַ���������ڵ�һѡ��ѡ������������ӣ�����Ͳ�����">
        ��С������88*31 </td>
    </tr>
    <tr class="tdbg"> 
      <td width="100" height="25" align="right">վ��������</td>
      <td height="25"> <input name="SiteAdmin" size="30"  maxlength="20" type="text"  title="�������������Ĵ����ˣ���Ȼ��֪������˭�������Ϊ20���ַ�"> 
        <font color="#FF0000">*</font></td>
    </tr>
    <tr class="tdbg"> 
      <td width="100" height="25" align="right">�����ʼ���</td>
      <td height="25"> <input name="Email" size="30"  maxlength="30" type="text"  value="@" title="����������������ϵ�����ʼ������Ϊ30���ַ�"> 
        <font color="#FF0000">*</font></td>
    </tr>
    <tr class="tdbg"> 
      <td width="100" height="25" align="right">��վ���룺</td>
      <td height="25"><input name="SitePassword" type="password" id="SitePassword" size="20" maxlength="20"> 
        <font color="#FF0000">*</font> �����޸���Ϣʱ�á�</td>
    </tr>
    <tr class="tdbg">
      <td height="25" align="right">ȷ�����룺</td>
      <td height="25"><input name="SitePwdConfirm" type="password" id="SitePwdConfirm" size="20" maxlength="20">
        <font color="#FF0000">*</font> </td>
    </tr>
    <tr class="tdbg"> 
      <td width="100" align="right">��վ��飺</td>
      <td valign="middle"> <textarea name="SiteIntro" cols="40" rows="5" id="SiteIntro" title="����������������վ�ļ򵥽���"></textarea></td>
    </tr>
    <tr class="tdbg"> 
      <td height="40" colspan="2" align="center"><input name="Action" type="hidden" id="Action" value="Reg"> 
        <input type="submit" value=" ȷ �� " name="cmdOk"> &nbsp; <input type="reset" value=" �� �� " name="cmdReset"> 
      </td>
    </tr>
  </table>
  </form>
</body>
</html>
<%
	end if
end if
call CloseConn()
sub WriteSuccessMsg()
	response.write "�����������ӳɹ�����ȴ�����Ա���ͨ����"
end sub
%>