<%@language=vbscript codepage=936 %>
<%
option explicit
response.buffer=true	
Const PurviewLevel=2
Const CheckChannelID=0
Const PurviewLevel_Others="ModifyPwd"
'response.write "�˹��ܱ�WEBBOY��ʱ��ֹ�ˣ�"
'response.end
%>
<!--#include file="inc/conn.asp"-->
<!--#include file="inc/config.asp"-->
<!--#include file="Admin_ChkPurview.asp"-->
<!--#include file="inc/function.asp"-->
<!--#include file="inc/md5.asp"-->
<%
dim Action,FoundErr,ErrMsg
dim rs,sql
Action=trim(request("Action"))
sql="Select * from Admin where UserName='" & AdminName & "'"
Set rs=Server.CreateObject("Adodb.RecordSet")
rs.Open sql,conn,1,3
if rs.Bof and rs.EOF then
	FoundErr=True
	ErrMsg=ErrMsg & "<br><li>�����ڴ��û���</li>"
else
	if Action="Modify" then
		call ModifyPwd()
	else
		call main()
	end if
end if
rs.close
set rs=nothing
if FoundErr=True then
	call WriteErrMsg()
end if
call CloseConn()

sub ModifyPwd()
	dim password,PwdConfirm
	password=trim(Request("Password"))
	PwdConfirm=trim(request("PwdConfirm"))
	if password="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>�����벻��Ϊ�գ�</li>"
	end if
	if PwdConfirm<>Password then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>ȷ�������������������ͬ��</li>"
		exit sub
	end if
	UserName=rs("UserName")
	if Password<>"" then
		rs("password")=md5(password)
	end if
   	rs.update
	call WriteSuccessMsg("�޸�����ɹ����´ε�¼ʱ�ǵû���������Ŷ��")
end sub

sub main()
%>
<html>
<head>
<title>�޸Ĺ���Ա��Ϣ</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="Admin_Style.css" rel="stylesheet" type="text/css">
<script language=javascript>
function check()
{
  if(document.form1.Password.value=="")
    {
      alert("���벻��Ϊ�գ�");
	  document.form1.Password.focus();
      return false;
    }
    
  if((document.form1.Password.value)!=(document.form1.PwdConfirm.value))
    {
      alert("��ʼ������ȷ�����벻ͬ��");
	  document.form1.PwdConfirm.select();
	  document.form1.PwdConfirm.focus();	  
      return false;
    }
}
</script>
</head>
<body>
<form method="post" action="Admin_AdminModifyPwd.asp" name="form1" onsubmit="javascript:return check();">
  <br>
  <br>
  <table width="300" border="0" align="center" cellpadding="2" cellspacing="1" class="border" >
    <tr class="title"> 
      <td height="22" colspan="2"> <div align="center"><strong>�� �� �� �� Ա �� ��</strong></div></td>
    </tr>
    <tr> 
      <td width="100" align="right" class="tdbg"><strong>�� �� ����</strong></td>
      <td class="tdbg"><%=rs("UserName")%></td>
    </tr>
    <tr>
      <td width="100" align="right" class="tdbg"><strong>�û�Ȩ�ޣ�</strong></td>
      <td class="tdbg">
        <%
		  select case rs("purview")
		  	case 1
				response.write "��������Ա"
			case 2
				response.write "��ʦ����Ա"
			case 3
				response.write "ѧ������Ա"
		  end select
		  %>
      </td>
    </tr>
    <tr> 
      <td width="100" align="right" class="tdbg"><strong>�� �� �룺</strong></td>
      <td class="tdbg"><input type="password" name="Password"> </td>
    </tr>
    <tr> 
      <td width="100" align="right" class="tdbg"><strong>ȷ�����룺</strong></td>
      <td class="tdbg"><input type="password" name="PwdConfirm"> </td>
    </tr>
    <tr> 
      <td height="40" colspan="2" align="center" class="tdbg"><input name="Action" type="hidden" id="Action" value="Modify"> 
        <input  type="submit" name="Submit" value=" ȷ �� " style="cursor:hand;"> 
        &nbsp; <input name="Cancel" type="button" id="Cancel" value=" ȡ �� " onClick="window.location.href='Admin_Index_Main.asp'" style="cursor:hand;"></td>
    </tr>
  </table>
  </form>
</body>
</html>
<%
end sub
%>
