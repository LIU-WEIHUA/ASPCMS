<%@language=vbscript codepage=936 %>
<%
option explicit
'ǿ����������·��ʷ���������ҳ�棬�����Ǵӻ����ȡҳ��
Response.Buffer = True 
Response.Expires = -1
Response.ExpiresAbsolute = Now() - 1 
Response.Expires = 0 
Response.CacheControl = "no-cache" 
'��Ҫ��ʹ������ֵ�ͼƬ�������

dim ComeUrl
ComeUrl=trim(request("ComeUrl"))
if ComeUrl="" then
	ComeUrl=Request.ServerVariables("HTTP_REFERER")
end if
if ComeUrl="" then
	ComeUrl="index.asp"
end if
%>
<html>
<head>
<title>ע���û���¼</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="style.CSS">
<script language=javascript>
function SetFocus()
{
if (document.Login.UserName.value=="")
	document.Login.UserName.focus();
else
	document.Login.UserName.select();
}
function CheckForm()
{
	if(document.Login.UserName.value=="")
	{
		alert("�������û�����");
		document.Login.UserName.focus();
		return false;
	}
	if(document.Login.Password.value == "")
	{
		alert("���������룡");
		document.Login.Password.focus();
		return false;
	}
	//'��֤�벻����XP SP3���Ժ����ϵͳ

	//if (document.Login.CheckCode.value=="")
//	{
//       		alert ("������������֤�룡");
//       		document.Login.CheckCode.focus();
//       		return(false);
//       }
}
function CheckBrowser() 
{
  var app=navigator.appName;
  var verStr=navigator.appVersion;
  if (app.indexOf('Netscape') != -1) {
    alert("������ʾ��\n    ��ʹ�õ���Netscape����������ܻᵼ���޷�ʹ�ú�̨�Ĳ��ֹ��ܡ�������ʹ�� IE6.0 �����ϰ汾��");
  } 
  else if (app.indexOf('Microsoft') != -1) {
    if (verStr.indexOf("MSIE 3.0")!=-1 || verStr.indexOf("MSIE 4.0") != -1 || verStr.indexOf("MSIE 5.0") != -1 || verStr.indexOf("MSIE 5.1") != -1)
      alert("������ʾ��\n    ����������汾̫�ͣ����ܻᵼ���޷�ʹ�ú�̨�Ĳ��ֹ��ܡ�������ʹ�� IE6.0 �����ϰ汾��");
  }
}
</script>
</head>
<body onLoad="SetFocus();">
<p>&nbsp;</p>
<form name="Login" action="User_ChkLogin.asp" method="post" onSubmit="return CheckForm();">
    <table width="300" border="0" align="center" cellpadding="5" cellspacing="0" class="border" >
      <tr class="title"> 
        <td colspan="2" align="center"> <strong>ע���û���¼</strong></td>
      </tr>
      
    <tr> 
      <td height="120" colspan="2" class="tdbg">
<table width="250" border="0" cellspacing="8" cellpadding="0" align="center">
          <tr> 
            <td align="right">�û����ƣ�</td>
            <td><input name="UserName"  type="text"  id="UserName" size="23" maxlength="20"></td>
          </tr>
          <tr> 
            <td align="right">�û����룺</td>
            <td><input name="Password"  type="password" id="Password" size="23" maxlength="20"></td>
          </tr>
	  <!--'��֤�벻����XP SP3���Ժ����ϵͳ-->
      <!--<tr> 
            <td align="right">�� ֤ �룺</td>
            <td><input name="CheckCode" size="6" maxlength="4"><img src="inc/checkcode.asp"></td>
          </tr>-->
          <tr>
		    <td height='25' align='right'>Cookieѡ�</td>
			<td height='25'><select name=CookieDate><option selected value=0>������</option><option value=1>����һ��</option><option value=2>����һ��</option><option value=3>����һ��</option></select></td>
		  </tr>
		  <tr align="center"> 
            <td colspan="2"> <input name="ComeUrl" type="hidden" id="ComeUrl" value="<%=ComeUrl%>"> 
              <input   type="submit" name="Submit" value=" ȷ�� "> &nbsp; <input name="reset" type="reset"  id="reset" value=" ��� "> 
            </td>
          </tr>
        </table>
        </td>
      </tr>
    </table>
</form>
</body>
</html>
