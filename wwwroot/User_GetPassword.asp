<!--#include file="Inc/Conn_User.asp"-->
<!--#include file="Inc/function.asp"-->
<!--#include file="Inc/md5.asp"-->
<%
dim Action,GpUserName,rsGetPassword,FoundErr,ErrMsg
dim Answer,Password,PwdConfirm
Action=trim(request("Action"))
GpUserName=trim(request("UserName"))
Answer=trim(request("Answer"))
Password=trim(request("Password"))
PwdConfirm=trim(request("PwdConfirm"))
%>
<html>
<head>
<title>��������</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="STYLE.CSS" rel="stylesheet" type="text/css">
</head>

<body>
<%if Action="" then%>
<table align='center' width='300' border='0' cellpadding='4' cellspacing='0' class='border'>
  <tr > 
    <td height='15' colspan='2' class='title'>�������� &gt;&gt; ��һ���������û���</td>
  </tr>
  <tr> 
    <td height='100' colspan='2' align="center" class='tdbg'><form name="form1" method="post" action="">
        <strong> ����������û�����</strong> 
        <input name="UserName" type="text" id="UserName" size="20" maxlength="20">
        <br>
        <br>
        <input name="Action" type="hidden" id="Action" value="step2">
        <input name="Next" type="submit" id="Next" style="cursor:hand;" value="��һ��">
        <input name="Cancel" type="button" id="Cancel" style="cursor:hand;" onclick="window.location.href='index.asp'" value=" ȡ�� ">
      </form></td>
  </tr>
</table>
<%
elseif Action="step2" then
	if GpUserName="" or strLength(GpUserName)>14 or strLength(GpUserName)<4 then
		founderr=true
		errmsg=errmsg & "<br><li>�������û���(���ܴ���14С��4)</li>"
	else
  		if Instr(GpUserName,"=")>0 or Instr(GpUserName,"%")>0 or Instr(GpUserName,chr(32))>0 or Instr(GpUserName,"?")>0 or Instr(GpUserName,"&")>0 or Instr(GpUserName,";")>0 or Instr(GpUserName,",")>0 or Instr(GpUserName,"'")>0 or Instr(GpUserName,",")>0 or Instr(GpUserName,chr(34))>0 or Instr(GpUserName,chr(9))>0 or Instr(GpUserName,"��")>0 or Instr(GpUserName,"$")>0 then
			errmsg=errmsg+"<br><li>�û����к��зǷ��ַ�</li>"
			founderr=true
		end if
	end if
	if FoundErr=true then
		call WriteErrMsg()
	else
		set rsGetPassword=server.createobject("adodb.recordset")
		rsGetPassword.open "select " & db_User_Name & "," & db_User_Question & "," & db_User_Answer & "," & db_User_Password & " from " & db_User_Table & " where " & db_User_Name & "='" & GpUserName & "'",Conn_User,1,1
		if rsGetPassword.bof and rsGetPassword.eof then
			FoundErr=True
			ErrMsg=ErrMsg & "<br><li>�Բ�����������û��������ڣ�</li>"
			call WriteErrMsg()
		else
	
%>
<table align='center' width='300' border='0' cellpadding='4' cellspacing='0' class='border'>
  <tr > 
    <td height='15' colspan='2' class='title'>�������� &gt;&gt; �ڶ������ش�����</td>
  </tr>
  <tr> 
    <td height='100' colspan='2' align="center" class='tdbg'><form name="form1" method="post" action="">
        <table width="100%" border="0" cellspacing="5" cellpadding="0">
          <tr> 
            <td width="44%" align="right"><strong>������ʾ���⣺</strong></td>
            <td width="56%"><%=rsGetPassword(db_User_Question)%></td>
          </tr>
          <tr> 
            <td align="right"><strong>��Ĵ𰸣�</strong></td>
            <td><input name="Answer" type="text" size="20" maxlength="20"></td>
          </tr>
        </table>
        <br>
        <input name="UserName" type="hidden" id="UserName" value="<%=rsGetPassword(db_User_Name)%>">
        <input name="Action" type="hidden" id="Action" value="step3">
        <input name="PrevStep" type="button" id="PrevStep" value="��һ��" style="cursor:hand;" onclick="history.go(-1)">
        &nbsp; 
        <input name="NextStep" type="submit" id="NextStep" style="cursor:hand;" value="��һ��">
        &nbsp; 
        <input name="Cancel" type="button" id="Cancel" style="cursor:hand;" onclick="window.location.href='index.asp'" value=" ȡ�� ">
      </form></td>
  </tr>
</table>
<%
		end if
		rsGetPassword.close
		set rsGetPassword=nothing
	end if
elseif Action="step3" then
	if Answer="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>��������ʾ����Ĵ𰸣�</li>"
		call WriteErrmsg()
	else
		set rsGetPassword=server.createobject("adodb.recordset")
		rsGetPassword.open "select " & db_User_Name & "," & db_User_Question & "," & db_User_Answer & "," & db_User_Password & " from " & db_User_Table & " where " & db_User_Name & "='" & GpUserName & "'",Conn_User,1,1
		if rsGetPassword.bof and rsGetPassword.eof then
			FoundErr=True
			ErrMsg=ErrMsg & "<br><li>�Բ����û��������ڣ������Ѿ�������Աɾ���ˡ�</li>"
			call WriteErrMsg()
		else
			if rsGetPassword(db_User_Answer)<>md5(Answer) then
				FoundErr=True
				ErrMsg=ErrMsg & "<br><li>�Բ�����Ĵ𰸲��ԣ�</li>"
				Call WriteErrMsg()
			else				
%>
<table align='center' width='300' border='0' cellpadding='4' cellspacing='0' class='border'>
  <tr > 
    <td height='15' colspan='2' class='title'>�������� &gt;&gt; ������������������</td>
  </tr>
  <tr> 
    <td height='100' colspan='2' align="center" class='tdbg'><form name="form1" method="post" action="">
        <table width="100%" border="0" cellspacing="5" cellpadding="0">
          <tr> 
            <td width="44%" align="right"><strong>������ʾ���⣺</strong></td>
            <td width="56%"><%=rsGetPassword(db_User_Question)%></td>
          </tr>
          <tr> 
            <td align="right"><strong>��Ĵ𰸣�</strong></td>
            <td><%=Answer%> <input name="Answer" type="hidden" id="Answer" value="<%=rsGetPassword(db_User_Answer)%>"></td>
          </tr>
          <tr> 
            <td align="right"><strong>�����룺</strong></td>
            <td><input name="Password" type="password" id="Password" size="20" maxlength="20"></td>
          </tr>
          <tr> 
            <td align="right"><strong>ȷ�������룺</strong></td>
            <td><input name="PwdConfirm" type="password" id="PwdConfirm" size="20" maxlength="20"></td>
          </tr>
        </table>
        <br>
        <input name="UserName" type="hidden" id="UserName" value="<%=rsGetPassword(db_User_Name)%>">
        <input name="Action" type="hidden" id="Action" value="step4">
        <input name="PrevStep" type="button" id="PrevStep" value="��һ��" style="cursor:hand;" onclick="history.go(-1)">
        &nbsp; 
        <input name="Next" type="submit" id="Next" style="cursor:hand;" value="��һ��">
        &nbsp; 
        <input name="Cancel" type="button" id="Cancel" style="cursor:hand;" onclick="window.location.href='index.asp'" value=" ȡ�� ">
      </form></td>
  </tr>
</table>
<%
			end if
		end if
		rsGetPassword.close
		set rsGetPassword=nothing
	end if
elseif Action="step4" then
	if Password="" or strLength(Password)>12 or strLength(Password)<6 then
		founderr=true
		errmsg=errmsg & "<br><li>����������(���ܴ���12С��6)</li>"
	else
		if Instr(Password,"=")>0 or Instr(Password,"%")>0 or Instr(Password,chr(32))>0 or Instr(Password,"?")>0 or Instr(Password,"&")>0 or Instr(Password,";")>0 or Instr(Password,",")>0 or Instr(Password,"'")>0 or Instr(Password,",")>0 or Instr(Password,chr(34))>0 or Instr(Password,chr(9))>0 or Instr(Password,"��")>0 or Instr(Password,"$")>0 then
			errmsg=errmsg+"<br><li>�����к��зǷ��ַ�</li>"
			founderr=true
		end if
	end if
	if PwdConfirm="" then
		founderr=true
		errmsg=errmsg & "<br><li>������ȷ������(���ܴ���12С��6)</li>"
	else
		if Password<>PwdConfirm then
			founderr=true
			errmsg=errmsg & "<br><li>�����ȷ�����벻һ��</li>"
		end if
	end if
	if FoundErr=True then
		call WriteErrmsg()
	else
		set rsGetPassword=server.createobject("adodb.recordset")
		rsGetPassword.open "select " & db_User_Name & "," & db_User_Question & "," & db_User_Answer & "," & db_User_Password & " from " & db_User_Table & " where " & db_User_Name & "='" & GpUserName & "'",Conn_User,1,3
		if rsGetPassword.bof and rsGetPassword.eof then
			FoundErr=True
			ErrMsg=ErrMsg & "<br><li>�Բ����û��������ڣ������Ѿ�������Աɾ���ˡ�</li>"
			call WriteErrMsg()
		else
			if rsGetPassword(db_User_Answer)<>Answer then
				FoundErr=True
				ErrMsg=ErrMsg & "<br><li>�Բ�����Ĵ𰸲��ԣ�</li>"
				Call WriteErrMsg()
			else
				rsGetPassword(db_User_Password)=md5(Password)
				rsGetPassword.update
%>
<table align='center' width='300' border='0' cellpadding='4' cellspacing='0' class='border'>
  <tr > 
    <td height='15' colspan='2' class='title'>�������� &gt;&gt; ���Ĳ����ɹ�����������</td>
  </tr>
  <tr> 
    <td height='100' colspan='2' align="center" class='tdbg'> <table width="90%" border="0" cellspacing="5" cellpadding="0">
        <tr>
          <td width="80" align="right"><strong>�û�����</strong></td>
          <td><%=GpUserName%></td>
        </tr>
        <tr>
          <td width="80" align="right"><strong>�����룺</strong></td>
          <td><strong><%=Password%></strong></td>
        </tr>
      </table>
      <br>
      <font color="#FF0000">���ס���������벢ʹ��������<a href="index.asp">��¼</a>��</font><br> <br>
      <a href="index.asp">���� �ء�</a><a href="javascript:window.close();">���رմ��ڡ�</a></td>
  </tr>
</table>
<%
			end if
		end if
		rsGetPassword.close
		set rsGetPassword=nothing
	end if
end if
%>
</body>
</html>
<%
call CloseConn_User()
%>