<%@language=vbscript codepage=936 %>
<%
option explicit
response.buffer=true	
Const PurviewLevel=1
'response.write "�˹��ܱ�WEBBOY��ʱ��ֹ�ˣ�"
'response.end
%>
<!--#include file="inc/conn.asp"-->
<!--#include file="inc/config.asp"-->
<!--#include file="Admin_ChkPurview.asp"-->
<!--#include file="inc/function.asp"-->
<%
dim ObjInstalled,Action,FoundErr,ErrMsg
ObjInstalled=IsObjInstalled("Scripting.FileSystemObject")
Action=trim(request("Action"))
if Action="" then
	Action="ShowInfo"
end if
%>
<html>
<head>
<title>ר�����</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="Admin_Style.css" rel="stylesheet" type="text/css">
</head>
<body leftmargin="2" topmargin="0" marginwidth="0" marginheight="0">
  <table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" Class="border">
    <tr class="topbg"> 
      
    <td height="22" colspan=2 align=center><b>�� վ �� ��</b></td>
    </tr>
    <tr class="tdbg"> 
      <td width="70" height="30"><strong>��������</strong></td>
      
    <td height="30"><a href="Admin_SiteConfig.asp">��վ��Ϣ����</a> | <a href="Admin_SiteConfig.asp">��վѡ������</a> 
      | <a href="#Email">�ʼ�������ѡ��</a> | <a href="#UpFile">�ϴ��ļ�ѡ��</a></td>
    </tr>
  </table>
<%
if Action="SaveConfig" then
	call SaveConfig()
else
	call ShowConfig()
end if
if FoundErr=True then
	call WriteErrMsg()
end if
call CloseConn()

sub ShowConfig()
%>
<form method="POST" action="Admin_SiteConfig.asp" id="form1" name="form1">
  <table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" Class="border">
    <tr> 
      <td height="22" colspan="2" class="topbg"> <a name="SiteInfo"></a><strong>��վ��Ϣ����</strong></td>
    </tr>
    <tr> 
      <td width="400" height="25" class="tdbg"><strong>��վ���ƣ�</strong></td>
      <td width="368" height="25" class="tdbg"> 
        <input name="SiteName" type="text" id="SiteName" value="<%=SiteName%>" size="40" maxlength="50">
      </td>
    </tr>
    <tr> 
      <td width="400" height="25" class="tdbg"><strong>��վ���⣺</strong></td>
      <td width="368" height="25" class="tdbg"> 
        <input name="SiteTitle" type="text" id="SiteTitle" value="<%=SiteTitle%>" size="40" maxlength="50">
      </td>
    </tr>
    <tr> 
      <td width="400" height="25" class="tdbg"><strong>��վ��ַ��</strong><br>
        ����д����URL��ַ</td>
      <td width="368" height="25" class="tdbg"> 
        <input name="SiteUrl" type="text" id="SiteUrl" value="<%=SiteUrl%>" size="40" maxlength="255">
      </td>
    </tr>
    <tr> 
      <td width="400" height="25" class="tdbg"><strong>LOGO��ַ��</strong><br>
        ����д����URL��ַ</td>
      <td width="368" height="25" class="tdbg"> 
        <input name="LogoUrl" type="text" id="LogoUrl" value="<%=LogoUrl%>" size="40" maxlength="255">
      </td>
    </tr>
    <tr> 
      <td width="400" height="25" class="tdbg"><strong>Banner��ַ��</strong><br>
        ����д����URL��ַ����Ϊ�գ�����Banner����ʾ��������Ԥ��Ĺ�档</td>
      <td width="368" height="25" class="tdbg"> 
        <input name="BannerUrl" type="text" id="BannerUrl" value="<%=BannerUrl%>" size="40" maxlength="255">
      </td>
    </tr>
    <tr> 
      <td width="400" height="25" class="tdbg"><strong>վ��������</strong></td>
      <td width="368" height="25" class="tdbg"> 
        <input name="WebmasterName" type="text" id="WebmasterName" value="<%=WebmasterName%>" size="40" maxlength="20">
      </td>
    </tr>
    <tr> 
      <td width="400" height="25" class="tdbg"><strong>վ�����䣺</strong></td>
      <td width="368" height="25" class="tdbg"> 
        <input name="WebmasterEmail" type="text" id="WebmasterEmail" value="<%=WebmasterEmail%>" size="40" maxlength="100">
      </td>
    </tr>
    <tr> 
      <td width="400" height="25" class="tdbg"><strong>��Ȩ��Ϣ��</strong><br>
        ֧��HTML��ǣ�����ʹ��˫����</td>
      <td width="368" height="25" class="tdbg"> 
        <textarea name="Copyright" cols="32" rows="4" id="Copyright"><%=Copyright%></textarea>
      </td>
    </tr>
    <tr> 
      <td height="25" colspan="2" class="topbg"><a name="SiteOption"></a><strong>��վѡ������</strong></td>
    </tr>
    <tr> 
      <td width="400" height="25" class="tdbg"><strong>��̨�Ƿ���ʾ�Ҽ��˵���</strong></td>
      <td height="25" class="tdbg"> 
        <input type="radio" name="ShowPopMenu" value="Yes" <%if ShowPopMenu="Yes" then response.write "checked"%>>
        �� &nbsp;&nbsp;&nbsp;&nbsp; 
        <input type="radio" name="ShowPopMenu" value="No" <%if ShowPopMenu="No" then response.write "checked"%>>
        ��</td>
    </tr>
    <tr> 
      <td width="400" height="25" class="tdbg"><strong>�Ƿ���ʾ��վƵ����</strong></td>
      <td height="25" class="tdbg"> 
        <input type="radio" name="ShowSiteChannel" value="Yes" <%if ShowSiteChannel="Yes" then response.write "checked"%>>
        �� &nbsp;&nbsp;&nbsp;&nbsp; 
        <input type="radio" name="ShowSiteChannel" value="No" <%if ShowSiteChannel="No" then response.write "checked"%>>
        ��</td>
    </tr>
    <tr> 
      <td width="400" height="25" class="tdbg"><strong>�Ƿ���ʾ��ѡ���</strong></td>
      <td height="25" class="tdbg"> 
        <input type="radio" name="ShowMyStyle" value="Yes" <%if ShowMyStyle="Yes" then response.write "checked"%>>
        �� &nbsp;&nbsp;&nbsp;&nbsp; 
        <input type="radio" name="ShowMyStyle" value="No" <%if ShowMyStyle="No" then response.write "checked"%>>
        ��</td>
    </tr>
    <tr> 
      <td width="400" height="25" class="tdbg"><strong>�Ƿ�ʹ����״�����˵���</strong></td>
      <td height="25" class="tdbg"> 
        <input type="radio" name="ShowClassTreeGuide" value="Yes" <%if ShowClassTreeGuide="Yes" then response.write "checked"%>>
        �� &nbsp;&nbsp;&nbsp;&nbsp; 
        <input type="radio" name="ShowClassTreeGuide" value="No" <%if ShowClassTreeGuide="No" then response.write "checked"%>>
        ��</td>
    </tr>
    <tr> 
      <td width="400" height="25" class="tdbg"><strong>�Ƿ�����������˹��ܣ�</strong><br>
        �����������˹��ܣ�����¼������½�ֱ�ӷ���ͨ����ˣ�</td>
      <td height="25" class="tdbg"> 
        <input type="radio" name="EnableArticleCheck" value="Yes" <%if EnableArticleCheck="Yes" then response.write "checked"%>>
        �� &nbsp;&nbsp;&nbsp;&nbsp; 
        <input type="radio" name="EnableArticleCheck" value="No" <%if EnableArticleCheck="No" then response.write "checked"%>>
        ��</td>
    </tr>
    <tr> 
      <td width="400" height="25" class="tdbg"><strong>�Ƿ�����������˹��ܣ�</strong><br>
        �����������˹��ܣ����·�������Խ�ֱ����ʾ��ͨ����ˣ�</td>
      <td height="25" class="tdbg"> 
        <input type="radio" name="EnableGuestCheck" value="Yes" <%if EnableGuestCheck="Yes" then response.write "checked"%>>
        �� &nbsp;&nbsp;&nbsp;&nbsp; 
        <input type="radio" name="EnableGuestCheck" value="No" <%if EnableGuestCheck="No" then response.write "checked"%>>
        ��</td>
    </tr>
    <tr> 
      <td width="400" height="25" class="tdbg"><strong>�Ƿ񿪷��ļ��ϴ����ܣ�</strong><br>
        ���/�޸�����ʱ�Ƿ�����ϴ��ļ�</td>
      <td height="25" class="tdbg"> 
        <input type="radio" name="EnableUploadFile" value="Yes" <%if EnableUploadFile="Yes" then response.write "checked"%>>
        �� &nbsp;&nbsp;&nbsp;&nbsp; 
        <input type="radio" name="EnableUploadFile" value="No" <%if EnableUploadFile="No" then response.write "checked"%>>
        ��</td>
    </tr>
    <tr>
      <td width="400" height="25" class="tdbg"><strong>�Ƿ񱣴�Զ��ͼƬ�����أ�
        </strong><br>
        �����������վ�ϸ��Ƶ������а���ͼƬ����ͼƬ���Ƶ���վ��������</td>
      <td height="25" class="tdbg">
        <input type="radio" name="EnableSaveRemote" value="Yes" <%if EnableSaveRemote="Yes" then response.write "checked"%>>
        �� &nbsp;&nbsp;&nbsp;&nbsp; 
        <input type="radio" name="EnableSaveRemote" value="No" <%if EnableSaveRemote="No" then response.write "checked"%>>
        ��</td>
    </tr>
    <tr> 
      <td width="400" height="25" class="tdbg"><strong>�Ƿ񿪷������������룺</strong></td>
      <td height="25" class="tdbg"> 
        <input type="radio" name="EnableLinkReg" value="Yes" <%if EnableLinkReg="Yes" then response.write "checked"%>>
        �� &nbsp;&nbsp;&nbsp;&nbsp; 
        <input type="radio" name="EnableLinkReg" value="No" <%if EnableLinkReg="No" then response.write "checked"%>>
        ��</td>
    </tr>
    <tr> 
      <td width="400" height="25" class="tdbg"><strong>�Ƿ񵯳����洰�ڣ�</strong></td>
      <td height="25" class="tdbg"> 
        <input type="radio" name="PopAnnounce" value="Yes" <%if PopAnnounce="Yes" then response.write "checked"%>>
        �� &nbsp;&nbsp;&nbsp;&nbsp; 
        <input name="PopAnnounce" type="radio" value="No" <%if PopAnnounce="No" then response.write "checked"%>>
        ��</td>
    </tr>
    <tr> 
      <td width="400" height="25" class="tdbg"><strong>�ȵ����µĵ������</strong><br>
        ���µ�����ﵽ����ʱ�ͻᱻ��Ϊ�ȵ�����</td>
      <td height="25" class="tdbg"> 
        <input name="HitsOfHot" type="text" id="HitsOfHot" value="<%=HitsOfHot%>" size="6" maxlength="5">
      </td>
    </tr>
    <tr> 
      <td width="400" height="25" class="tdbg"><strong>Session�Ự�ı���ʱ�䣺</strong><br>
        ��Ҫ���ں�̨����Ա��¼��Ϊ�˰�ȫ���벻Ҫ��ʱ�����̫����������Ϊ10���ӡ�</td>
      <td height="25" class="tdbg"> 
        <input name="SessionTimeout" type="text" id="SessionTimeout" value="<%=SessionTimeout%>" size="6" maxlength="5">
        ����</td>
    </tr>
    <tr> 
      <td width="400" height="25" class="tdbg"><strong>��������Ȩ�ޣ�</strong><br>
        ֻ�о�����ӦȨ�޵��˲��ܷ������ۡ�</td>
      <td height="25" class="tdbg"> 
        <select name="CommentPurview" id="CommentPurview">
          <option value="9999" <%if CommentPurview=9999 then response.write " selected"%>>�ο�</option>
          <option value="999" <%if CommentPurview=999 then response.write " selected"%>>ע���û�</option>
          <option value="99" <%if CommentPurview=99 then response.write " selected"%>>�շ��û�</option>
          <option value="9" <%if CommentPurview=9 then response.write " selected"%>>VIP�û�</option>
          <option value="5" <%if CommentPurview=5 then response.write " selected"%>>����Ա</option>
        </select>
      </td>
    </tr>
    <tr> 
      <td height="25" colspan="2" class="topbg"><a name="Email"></a><strong>�û�ѡ��</strong></td>
    </tr>
    <tr> 
      <td width="400" height="25" class="tdbg"><strong>�Ƿ��������û�ע�᣺</strong></td>
      <td height="25" class="tdbg"> 
        <input type="radio" name="EnableUserReg" value="Yes" <%if EnableUserReg="Yes" then response.write "checked"%>>
        �� &nbsp;&nbsp;&nbsp;&nbsp; 
        <input type="radio" name="EnableUserReg" value="No" <%if EnableUserReg="No" then response.write "checked"%>>
        ��</td>
    </tr>
    <tr> 
      <td width="400" height="25" class="tdbg"><strong>���û�ע���Ƿ���Ҫ�ʼ���֤��</strong><br>
        ��ѡ���ǡ������û�ע���ϵͳ�ᷢһ�������֤����ʼ������û����û�������ͨ���ʼ���֤�����������Ϊ��ʽע���û�</td>
      <td height="25" class="tdbg"> 
        <input type="radio" name="EmailCheckReg" value="Yes" <%if EmailCheckReg="Yes" then response.write "checked"%>>
        �� &nbsp;&nbsp;&nbsp;&nbsp; 
        <input type="radio" name="EmailCheckReg" value="No" <%if EmailCheckReg="No" then response.write "checked"%>>
        ��</td>
    </tr>
    <tr> 
      <td width="400" height="25" class="tdbg"> 
        <p><strong>���û�ע���Ƿ���Ҫ����Ա��֤��</strong><br>
          ��ѡ���ǣ����û�������ͨ������Ա��֤����������ɹ���ʽע���û���</p>
      </td>
      <td height="25" class="tdbg"> 
        <input type="radio" name="AdminCheckReg" value="Yes" <%if AdminCheckReg="Yes" then response.write "checked"%>>
        �� &nbsp;&nbsp;&nbsp;&nbsp; 
        <input type="radio" name="AdminCheckReg" value="No" <%if AdminCheckReg="No" then response.write "checked"%>>
        ��</td>
    </tr>
    <TR bgcolor="#EAEEFB" > 
      <TD width="400"><strong>ע���û���Ĭ�ϼƷѷ�ʽ��</strong></TD>
      <TD> 
        <input name="ChargeType_999" type="radio" value="1" <%if ChargeType_999=1 then response.write " checked"%>>
        �۵���<font color="#0000FF">���Ƽ���</font>��&nbsp;ÿ�Ķ�һƪ�շ����£��۳���Ӧ������&nbsp;<br>
        <input type="radio" name="ChargeType_999" value="2" <%if ChargeType_999=2 then response.write " checked"%>>
        ��Ч�ڣ�����Ч���ڣ��û����������Ķ��շ�����</TD>
    </TR>
    <tr bgcolor="#EAEEFB"> 
      <td width="400" height="25"><strong>ע���û���Ĭ�Ͽ��õ�����</strong><br>
        ���û�ע��ɹ���Ĭ�Ͽ��Եõ��ĵ���������ע���û�����һЩ�շ���Ŀ</td>
      <td height="25"> 
        <input name="UserPoint_999" type="text" id="UserPoint_999" value="<%=UserPoint_999%>" size="6" maxlength="5">
        �� </td>
    </tr>
    <tr bgcolor="#EAEEFB"> 
      <td width="400" height="25"><strong>ע���û���Ĭ����Ч�ڣ�</strong><br>
        ���û�ע��ɹ���Ĭ����Ч�ڣ�����ע���û�����һЩ�շ���Ŀ<br>
        ��Ч�ڴ�ע��֮�տ�ʼ����</td>
      <td height="25"> 
        <input name="ValidDays_999" type="text" id="ValidDays_999" value="<%=ValidDays_999%>" size="6" maxlength="5">
        ��</td>
    </tr>
    <TR bgcolor="#DFEFFF" > 
      <TD width="400"><strong>�շ��û���Ĭ�ϼƷѷ�ʽ��</strong></TD>
      <TD> 
        <input name="ChargeType_99" type="radio" value="1" <%if ChargeType_99=1 then response.write " checked"%>>
        �۵���<font color="#0000FF">���Ƽ���</font>��&nbsp;ÿ�Ķ�һƪ�շ����£��۳���Ӧ������&nbsp;<br>
        <input type="radio" name="ChargeType_99" value="2" <%if ChargeType_99=2 then response.write " checked"%>>
        ��Ч�ڣ�����Ч���ڣ��û����������Ķ��շ�����</TD>
    </TR>
    <tr bgcolor="#DFEFFF"> 
      <td width="400" height="25"><strong>�շ��û���Ĭ�Ͽ��õ�����</strong><br>
        ���û���Ϊ�շ��û�ʱ����Щ�û���Ĭ�Ͽ��õ���</td>
      <td height="25"> 
        <input name="UserPoint_99" type="text" id="UserPoint_99" value="<%=UserPoint_99%>" size="6" maxlength="5">
        �� </td>
    </tr>
    <tr bgcolor="#DFEFFF"> 
      <td width="400" height="25"><strong>�շ��û���Ĭ����Ч�ڣ�</strong><br>
        ���û���Ϊ�շ��û�ʱ����Щ�û���Ĭ����Ч��<br>
        ��Ч�ڴ���Ϊ�շ��û�֮�տ�ʼ����</td>
      <td height="25"> 
        <input name="ValidDays_99" type="text" id="ValidDays_99" value="<%=ValidDays_99%>" size="6" maxlength="5">
        ��</td>
    </tr>
    <TR bgcolor="#E6E6FF" > 
      <TD width="400"><strong>VIP�û���Ĭ�ϼƷѷ�ʽ��</strong></TD>
      <TD> 
        <input name="ChargeType_9" type="radio" value="1" <%if ChargeType_99=1 then response.write " checked"%>>
        �۵���<font color="#0000FF">���Ƽ���</font>��&nbsp;ÿ�Ķ�һƪ�շ����£��۳���Ӧ������&nbsp;<br>
        <input type="radio" name="ChargeType_9" value="2" <%if ChargeType_99=2 then response.write " checked"%>>
        ��Ч�ڣ�����Ч���ڣ��û����������Ķ��շ�����</TD>
    </TR>
    <tr bgcolor="#E6E6FF"> 
      <td width="400" height="25"><strong>VIP�û���Ĭ�Ͽ��õ�����</strong><br>
        ���û���ΪVIP�û�ʱ����Щ�û���Ĭ�Ͽ��õ���</td>
      <td height="25"> 
        <input name="UserPoint_9" type="text" id="UserPoint_9" value="<%=UserPoint_9%>" size="6" maxlength="5">
        �� </td>
    </tr>
    <tr bgcolor="#E6E6FF"> 
      <td width="400" height="25"><strong>VIP�û���Ĭ����Ч�ڣ�</strong><br>
        ���û���ΪVIP�û�ʱ����Щ�û���Ĭ����Ч��<br>
        ��Ч�ڴ���ΪVIP�û�֮�տ�ʼ����</td>
      <td height="25"> 
        <input name="ValidDays_9" type="text" id="ValidDays_9" value="<%=ValidDays_9%>" size="6" maxlength="5">
        ��</td>
    </tr>
    <tr> 
      <td height="25" colspan="2" class="topbg"><a name="Email"></a><strong>�ʼ�������ѡ��</strong></td>
    </tr>
    <tr> 
      <td width="400" height="25" class="tdbg"><strong>�ʼ����������</strong><br>
        ��һ��Ҫѡ����������Ѱ�װ�����</td>
      <td height="25" class="tdbg"> 
        <select name="MailObject" id="MailObject">
          <option value="Jmail" selected>Jmail</option>
        </select>
      </td>
    </tr>
    <tr> 
      <td width="400" height="25" class="tdbg"><strong>SMTP��������ַ��</strong><br>
        ���������ʼ���SMTP������<br>
        ����㲻����˲������壬����ϵ��Ŀռ��� </td>
      <td height="25" class="tdbg"> 
        <input name="MailServer" type="text" id="MailServer" value="<%=MailServer%>" size="40">
      </td>
    </tr>
    <tr> 
      <td width="400" height="25" class="tdbg"><strong>SMTP��¼�û�����</strong><br>
        ����ķ�������ҪSMTP�����֤ʱ�������ô˲���</td>
      <td height="25" class="tdbg"> 
        <input name="MailServerUserName" type="text" id="MailServerUserName" value="<%=MailServerUserName%>" size="40">
      </td>
    </tr>
    <tr> 
      <td width="400" height="25" class="tdbg"><strong>SMTP��¼���룺</strong><br>
        ����ķ�������ҪSMTP�����֤ʱ�������ô˲��� </td>
      <td height="25" class="tdbg"> 
        <input name="MailServerPassWord" type="text" id="MailServerPassWord" value="<%=MailServerPassWord%>" size="40">
      </td>
    </tr>
    <tr> 
      <td width="400" height="25" class="tdbg"><strong>SMTP����</strong>��<br>
        ����á�name@domain.com���������û�����¼ʱ����ָ��domain.com</td>
      <td height="25" class="tdbg"> 
        <input name="MailDomain" type="text" id="MailDomain" value="<%=MailDomain%>" size="40">
      </td>
    </tr>
    <tr> 
      <td height="25" colspan="2" class="topbg"><a name="UpFile" id="UpFile"></a><strong>�ϴ��ļ�ѡ��</strong></td>
    </tr>
    <tr> 
      <td width="400" height="25" class="tdbg"><strong>�ϴ��ļ���С���ƣ�</strong><br>
        ���鲻Ҫ����1024K������Ӱ�����������</td>
      <td height="25" class="tdbg"> 
        <input name="MaxFileSize" type="text" id="MaxFileSize" value="<%=MaxFileSize%>" size="6" maxlength="5">
        K</td>
    </tr>
    <tr> 
      <td width="400" height="25" class="tdbg"><strong>����ϴ��ļ���Ŀ¼��</strong><br>
        �������������ҳ��Default.asp�������·��</td>
      <td height="25" class="tdbg"> 
        <input name="SaveUpFilesPath" type="text" id="SaveUpFilesPath" value="<%=SaveUpFilesPath%>" size="30" maxlength="100">
      </td>
    </tr>
    <tr> 
      <td width="400" height="25" class="tdbg"><strong>������ϴ��ļ����ͣ�</strong><br>
        ֻ������չ����ÿ���ļ������á�|���ŷֿ���</td>
      <td height="25" class="tdbg"> 
        <input name="UpFileType" type="text" id="UpFileType" value="<%=UpFileType%>" size="50" maxlength="255">
      </td>
    </tr>
    <tr> 
      <td width="400" height="25" class="tdbg"><strong>ɾ������ʱ�Ƿ�ͬʱɾ�������е��ϴ��ļ���</strong><br>
        �˹�����ҪFSO֧�֡�</td>
      <td height="25" class="tdbg"> 
        <input type="radio" name="DelUpFiles" value="Yes" <%if DelUpFiles="Yes" then response.write "checked"%>>
        �� &nbsp;&nbsp;&nbsp;&nbsp; 
        <input type="radio" name="DelUpFiles" value="No" <%if DelUpFiles="No" then response.write "checked"%>>
        ��</td>
    </tr>
    <tr> 
      <td height="40" colspan="2" align="center" class="tdbg"> 
        <input name="Action" type="hidden" id="Action" value="SaveConfig">
        <input name="cmdSave" type="submit" id="cmdSave" value=" �������� " <% If ObjInstalled=false Then response.write "disabled" %>>
      </td>
    </tr>
    <%
If ObjInstalled=false Then
	Response.Write "<tr class='tdbg'><td height='40' colspan='3'><b><font color=red>��ķ�������֧�� FSO(Scripting.FileSystemObject)! ����ʹ�ñ����ܡ�<br>��ֱ���޸ġ�Inc/config.asp���ļ��е����ݡ�</font></b></td></tr>"
End If
%>
  </table>
<%
end sub
%>
</form>
</body>
</html>
<%
sub SaveConfig()
	If ObjInstalled=false Then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>��ķ�������֧�� FSO(Scripting.FileSystemObject)! </li>"
		exit sub
	end if
	dim fso,hf
	set fso=Server.CreateObject("Scripting.FileSystemObject")
	set hf=fso.CreateTextFile(Server.mappath("inc/config.asp"),true)
	hf.write "<" & "%" & vbcrlf
	hf.write "Const SiteName=" & chr(34) & trim(request("SiteName")) & chr(34) & "        '��վ����" & vbcrlf
	hf.write "Const SiteTitle=" & chr(34) & trim(request("SiteTitle")) & chr(34) & "        '��վ����" & vbcrlf
	hf.write "Const SiteUrl=" & chr(34) & trim(request("SiteUrl")) & chr(34) & "        '��վ��ַ" & vbcrlf
	hf.write "Const LogoUrl=" & chr(34) & trim(request("LogoUrl")) & chr(34) & "        'Logo��ַ" & vbcrlf
	hf.write "Const BannerUrl=" & chr(34) & trim(request("BannerUrl")) & chr(34) & "        'Banner��ַ" & vbcrlf
	hf.write "Const WebmasterName=" & chr(34) & trim(request("WebmasterName")) & chr(34) & "        'վ������" & vbcrlf
	hf.write "Const WebmasterEmail=" & chr(34) & trim(request("WebmasterEmail")) & chr(34) & "        'վ������" & vbcrlf
	hf.write "Const Copyright=" & chr(34) & trim(request("Copyright")) & chr(34) & "        '��Ȩ��Ϣ" & vbcrlf
	hf.write "Const ShowPopMenu=" & chr(34) & trim(request("ShowPopMenu")) & chr(34) & "        '��̨�Ƿ���ʾ�Ҽ��˵�" & vbcrlf
	hf.write "Const ShowSiteChannel=" & chr(34) & trim(request("ShowSiteChannel")) & chr(34) & "        '�Ƿ���ʾ��վƵ��" & vbcrlf
	hf.write "Const ShowMyStyle=" & chr(34) & trim(request("ShowMyStyle")) & chr(34) & "        '�Ƿ���ʾ��ѡ���" & vbcrlf  
	hf.write "Const ShowClassTreeGuide=" & chr(34) & trim(request("ShowClassTreeGuide")) & chr(34) & "        '�Ƿ�ʹ����״�����˵�" & vbcrlf  
	hf.write "Const EnableArticleCheck=" & chr(34) & trim(request("EnableArticleCheck")) & chr(34) & "        '�Ƿ�����������˹���" & vbcrlf
	hf.write "Const EnableGuestCheck=" & chr(34) & trim(request("EnableGuestCheck")) & chr(34) & "        '�Ƿ�����������˹���" & vbcrlf
	hf.write "Const EnableUploadFile=" & chr(34) & trim(request("EnableUploadFile")) & chr(34) & "        '�Ƿ񿪷��ļ��ϴ�" & vbcrlf
	hf.write "Const EnableSaveRemote=" & chr(34) & trim(request("EnableSaveRemote")) & chr(34) & "        '�Ƿ񱣴�Զ��ͼƬ������" & vbcrlf
	hf.write "Const EnableUserReg=" & chr(34) & trim(request("EnableUserReg")) & chr(34) & "        '�Ƿ��������û�ע��" & vbcrlf
	hf.write "Const EmailCheckReg=" & chr(34) & trim(request("EmailCheckReg")) & chr(34) & "        '���û�ע���Ƿ���Ҫ�ʼ���֤" & vbcrlf
	hf.write "Const AdminCheckReg=" & chr(34) & trim(request("AdminCheckReg")) & chr(34) & "        '���û�ע���Ƿ���Ҫ����Ա��֤" & vbcrlf
	hf.write "Const EnableLinkReg=" & chr(34) & trim(request("EnableLinkReg")) & chr(34) & "        '�Ƿ񿪷�������������" & vbcrlf
	hf.write "Const PopAnnounce=" & chr(34) & trim(request("PopAnnounce")) & chr(34) & "        '�Ƿ񵯳����洰��" & vbcrlf
	hf.write "Const HitsOfHot=" & trim(request("HitsOfHot")) & "        '�������µ����" & vbcrlf
	hf.write "Const SessionTimeout=" & trim(request("SessionTimeout")) & "        'Session�Ự�ı���ʱ��" & vbcrlf
	hf.write "Const CommentPurview=" & trim(request("CommentPurview")) & "        '�������۵�Ȩ��" & vbcrlf
	hf.write "Const MailObject=" & chr(34) & trim(request("MailObject")) & chr(34) & "        '�ʼ��������" & vbcrlf
	hf.write "Const MailServer=" & chr(34) & trim(request("MailServer")) & chr(34) & "        '���������ʼ���SMTP������" & vbcrlf
	hf.write "Const MailServerUserName=" & chr(34) & trim(request("MailServerUserName")) & chr(34) & "        '��¼�û���" & vbcrlf
	hf.write "Const MailServerPassWord=" & chr(34) & trim(request("MailServerPassWord")) & chr(34) & "        '��¼����" & vbcrlf
	hf.write "Const MailDomain=" & chr(34) & trim(request("MailDomain")) & chr(34) & "        '����" & vbcrlf
	hf.write "Const MaxFileSize=" & trim(request("MaxFileSize")) & "        '�ϴ��ļ���С����" & vbcrlf
	hf.write "Const SaveUpFilesPath=" & chr(34) & trim(request("SaveUpFilesPath")) & chr(34) & "        '����ϴ��ļ���Ŀ¼" & vbcrlf
	hf.write "Const UpFileType=" & chr(34) & trim(request("UpFileType")) & chr(34) & "        '������ϴ��ļ�����" & vbcrlf
	hf.write "Const DelUpFiles=" & chr(34) & trim(request("DelUpFiles")) & chr(34) & "        'ɾ������ʱ�Ƿ�ͬʱɾ�������е��ϴ��ļ�" & vbcrlf
	hf.write "Const ChargeType_999=" & trim(request("ChargeType_999")) & "        'ע���û���Ĭ�ϼƷѷ�ʽ" & vbcrlf
	hf.write "Const UserPoint_999=" & trim(request("UserPoint_999")) & "        'ע���û���Ĭ�Ͽ��õ���" & vbcrlf
	hf.write "Const ValidDays_999=" & trim(request("ValidDays_999")) & "        'ע���û���Ĭ����Ч��" & vbcrlf
	hf.write "Const ChargeType_99=" & trim(request("ChargeType_99")) & "        '�շ��û���Ĭ�ϼƷѷ�ʽ" & vbcrlf
	hf.write "Const UserPoint_99=" & trim(request("UserPoint_99")) & "        '�շ��û���Ĭ�Ͽ��õ���" & vbcrlf
	hf.write "Const ValidDays_99=" & trim(request("ValidDays_99")) & "        '�շ��û���Ĭ����Ч��" & vbcrlf
	hf.write "Const ChargeType_9=" & trim(request("ChargeType_9")) & "        'VIP�û���Ĭ�ϼƷѷ�ʽ" & vbcrlf
	hf.write "Const UserPoint_9=" & trim(request("UserPoint_9")) & "        'VIP�û���Ĭ�Ͽ��õ���" & vbcrlf
	hf.write "Const ValidDays_9=" & trim(request("ValidDays_9")) & "        'VIP�û���Ĭ����Ч��" & vbcrlf
	hf.write "%" & ">"
	hf.close
	set hf=nothing
	set fso=nothing
	call WriteSuccessMsg("��վ���ñ���ɹ���")
end sub
%>