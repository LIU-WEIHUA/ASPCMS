<%@language=vbscript codepage=936 %>
<!--#include file="inc/conn.asp"-->
<!--#include file="inc/Conn_User.asp"-->
<!--#include file="inc/function.asp"-->
<!--#include file="inc/md5.asp"-->
<!--#include file="inc/config.asp"-->
<%
dim Action,FoundErr,ErrMsg
dim rs,sql
Action=trim(request("Action"))
if Action="Check" then
	call CheckUser()
else
	call main()
end if
if FoundErr=true then
	call WriteErrMsg()
end if
call CloseConn()

sub main()
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
	if(document.Login.CheckNum.value == "")
	{
		alert("��������֤�룡");
		document.Login.CheckNum.focus();
		return false;
	}
}
</script>
</head>
<body onLoad="SetFocus();">
<p>&nbsp;</p>
<form name="Login" action="User_RegCheck.asp" method="post" onSubmit="return CheckForm();">
    <table width="400" border="0" align="center" cellpadding="5" cellspacing="0" class="border" >
      <tr class="title"> 
        
      <td colspan="2" align="center"> <strong>ע���û���֤</strong></td>
      </tr>
      
    <tr> 
      <td height="120" colspan="2" class="tdbg">��������ע��ʱ��д���û��������룬�Լ���վ�������ȷ�����е������֤�롣������ȫ��ȷ������ʻ��Żἤ� 
        <table width="250" border="0" cellspacing="8" cellpadding="0" align="center">
          <tr> 
            <td align="right">�û����ƣ�</td>
            <td><input name="UserName"  type="text"  id="UserName" size="23" maxlength="20"></td>
          </tr>
          <tr> 
            <td align="right">�û����룺</td>
            <td><input name="Password"  type="password" id="Password" size="23" maxlength="20"></td>
          </tr>
          <tr>
		    <td height='25' align='right'>�����֤�룺</td>
			<td height='25'><input name="CheckNum" type="text" id="CheckNum" size="23" maxlength="6"></td>
		  </tr>
		  <tr align="center"> 
            <td colspan="2"> <input name="Action" type="hidden" id="Action" value="Check"> 
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
<%
end sub

sub CheckUser()
	dim password,CheckNum
	username=replace(trim(request("username")),"'","")
	password=replace(trim(Request("password")),"'","")
	CheckNum=replace(trim(Request("CheckNum")),"'","")

	if UserName="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>�û�������Ϊ�գ�</li>"
	end if
	if Password="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>���벻��Ϊ�գ�</li>"
	end if
	if CheckNum="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>���벻��Ϊ�գ�</li>"
	end if

	if FoundErr=True then
		exit sub
	end if
	
	password=md5(password)
	set rs=server.createobject("adodb.recordset")
	sql="select * from " & db_User_Table & " where " & db_User_LockUser & "=False and " & db_User_Name & "='" & username & "' and " & db_User_Password & "='" & password &"'"
	rs.open sql,Conn_User,1,3
	if rs.bof and rs.eof then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>�û�����������󣡣���</li>"
	else
		if password<>rs(db_User_Password) then
			FoundErr=True
			ErrMsg=ErrMsg & "<br><li>�û�����������󣡣���</li>"
		else
			if AdminCheckReg="Yes" then
				rs(db_User_UserLevel)=2000
				rs.update
				call WriteSuccessMsg("��ϲ��ͨ����Email��֤����ȴ�����ͨ����ʺš���ͨ�������ʽ��Ϊ��վ��һԱ�ˡ�")
			else
				rs(db_User_UserLevel)=999
				rs.update
				call WriteSuccessMsg("��ϲ����ʽ��Ϊ��վ��һԱ��")
				call SaveCookie_asp163()
			end if
		end if
	end if
	rs.close
	set rs=nothing
	
end sub

sub SaveCookie_asp163()
	Response.Cookies("asp163")("UserName")=rs(db_User_Name)
	Response.Cookies("asp163")("Password") = rs(db_User_Password)
	Response.Cookies("asp163")("UserLevel")=rs(db_User_UserLevel)
	Response.Cookies("asp163")("CookieDate") = 0
end sub

%>