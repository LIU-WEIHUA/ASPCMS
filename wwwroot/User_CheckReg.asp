<!--#include file="Inc/Conn_User.asp"-->
<!--#include file="Inc/Conn.asp"-->
<!--#include file="Inc/function.asp"-->
<%
dim RegUserName,FoundErr,ErrMsg
RegUserName=trim(request("UserName"))
if RegUserName="" or strLength(RegUserName)>14 or strLength(RegUserName)<4 then
	founderr=true
	errmsg=errmsg & "<br><li>�������û���<br/>���԰������ġ�Ӣ�Ļ�����,���ܶ���14������4������ַ�</li>"
else
  	if Instr(RegUserName,"=")>0 or Instr(RegUserName,"%")>0 or Instr(RegUserName,chr(32))>0 or Instr(RegUserName,"?")>0 or Instr(RegUserName,"&")>0 or Instr(RegUserName,";")>0 or Instr(RegUserName,",")>0 or Instr(RegUserName,"'")>0 or Instr(RegUserName,",")>0 or Instr(RegUserName,chr(34))>0 or Instr(RegUserName,chr(9))>0 or Instr(RegUserName,"��")>0 or Instr(RegUserName,"$")>0 then
		errmsg=errmsg+"<br><li>�û����к��зǷ��ַ�</li>"
		founderr=true
	end if
end if
if founderr=false then
	dim sqlCheckReg,rsCheckReg,chkadminname,rschkadminname

	chkadminname="select * from admin where UserName='" & RegUserName & "'"
	set rschkadminname=server.createobject("adodb.recordset")
	rschkadminname.open chkadminname,Conn,1,1
	if not(rschkadminname.bof and rschkadminname.eof) then
		founderr=true
		errmsg=errmsg & "<br><li>�𾴵ġ�" & RegUserName & "����������վ�Ĺ���Ա����رܣ�</li>"
	else

	sqlCheckReg="select * from " & db_User_Table & " where " & db_User_Name & "='" & RegUserName & "'"
	set rsCheckReg=server.createobject("adodb.recordset")
	rsCheckReg.open sqlCheckReg,Conn_User,1,1
	if not(rsCheckReg.bof and rsCheckReg.eof) then
		founderr=true
		errmsg=errmsg & "<br><li>��" & RegUserName & "���Ѿ����ڣ��뻻һ���û��������ԣ�</li>"
	else
	end if
	rsCheckReg.close
	set rsCheckReg=nothing
	end if
	rschkadminname.close
	set rschkadminname=nothing
end if		
%>
<html>
<head>
<title>����û���</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="STYLE.CSS" rel="stylesheet" type="text/css">
</head>

<body leftmargin="2" topmargin="0" marginwidth="0" marginheight="0">
<br>
<%
if founderr=false then
	call Success()
else
	call WriteErrmsg()
end if
%>
</body>
</html>
<%
call CloseConn_User
call CloseConn

sub WriteErrMsg()
    response.write "<table align='center' width='300' border='0' cellpadding='2' cellspacing='0' class='border'>"
    response.write "<tr class='title'><td align='center' height='15'>������ʾ</td></tr>"
    response.write "<tr class='tdbg'><td align='left' height='100'>" & errmsg & "<p align='center'>��<a href='javascript:onclick=window.close()'>�� ��</a>��<br></p></td></tr>"
	response.write "</table>" 
end sub

sub Success()
    response.write "<table align='center' width='300' border='0' cellpadding='2' cellspacing='0' class='border'>"
    response.write "<tr class='title'><td align='center' height='15'>��ϲ����</td></tr>"
    response.write "<tr class='tdbg'><td align='left' height='100'><br>��" & RegUserName & "����δ����ʹ�ã��Ͻ�ע��ɣ�<p align='center'>��<a href='javascript:onclick=window.close()'>�� ��</a>��<br></p></td></tr>"
	response.write "</table>" 
end sub
%>