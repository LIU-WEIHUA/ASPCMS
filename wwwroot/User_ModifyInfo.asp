<!--#include file="inc/Conn_User.asp"-->
<!--#include file="inc/md5.asp"-->
<!--#include file="inc/function.asp"-->
<%
if CheckUserLogined()=False then
	response.Redirect "User_Login.asp"
end if

dim Action,FoundErr,ErrMsg
dim rsUser,sqlUser
Action=trim(request("Action"))
if Action="Modify" then
	UserName=trim(request("UserName"))
else
	UserName=Trim(Request.Cookies("asp163")("UserName"))
end if
if  UserName="" then
	FoundErr=True
	ErrMsg=ErrMsg & "<br><li>�������㣡</li>"
end if
if FoundErr=true then
	call WriteErrMsg()
else
	Set rsUser=Server.CreateObject("Adodb.RecordSet")
	sqlUser="select * from " & db_User_Table & " where " & db_User_Name & "='" & UserName & "'"
	rsUser.Open sqlUser,Conn_User,1,3
	if rsUser.bof and rsUser.eof then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>�Ҳ���ָ�����û���</li>"
		call writeErrMsg()
	else
		if Action="Modify" then
			dim Sex,Email,Homepage,Company,Department,jszc
			Sex=trim(Request("Sex"))
			Email=trim(request("Email"))
			Homepage=trim(request("Homepage"))
			OICQ=trim(request("OICQ"))
			MSN=trim(request("MSN"))
			if Sex="" then
				founderr=true
				errmsg=errmsg & "<br><li>�Ա���Ϊ��</li>"
			else
				sex=cint(sex)
				if Sex<>0 and Sex<>1 then
					Sex=1
				end if
			end if
			if Email="" then
				founderr=true
				errmsg=errmsg & "<br><li>Email����Ϊ��</li>"
			else
				if IsValidEmail(Email)=false then
					errmsg=errmsg & "<br><li>����Email�д���</li>"
			   		founderr=true
				end if
			end if
			if FoundErr<>true then
				rsUser(db_User_Sex)=Sex
				rsUser(db_User_Email)=Email
				rsUser(db_User_Homepage)=HomePage
				rsUser(db_User_QQ)=OICQ
				rsUser(db_User_Msn)=MSN
				'������վ����
				
				rsUser("TrueName")=Trim(Request("TrueName"))
				rsUser("StudentClass")=Trim(Request("StudentClassName")) & Trim(Request("StudentClassYear")) & Trim(Request("StudentClassNumber"))
				rsUser("StudentNumber")=Trim(Request("StudentNumber"))
				rsUser("College")=Trim(Request("College"))

				'����������վ����
				rsUser.update
				call WriteSuccessMsg("�ɹ��޸��û���Ϣ��")
			else
				call WriteErrMsg()
			end if
		else

%>
<html>
<head>
<title>�޸�ע���û���Ϣ</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="Admin_STYLE.CSS" rel="stylesheet" type="text/css">
</head>
<body>
<br>
<FORM name="Form1" action="User_ModifyInfo.asp" method="post">
  <table width=400 border=0 align="center" cellpadding=2 cellspacing=1 class='border'>
    <TR align=center class='title'>
      <TD height=22 colSpan=2><font class=en><b>�޸�ע���û���Ϣ</b></font></TD>
    </TR>
    <TR class="tdbg" >
      <TD width="120" align="right"><b>�� �� ����</b></TD>
      <TD><%=Trim(Request.Cookies("asp163")("UserName"))%>
        <input name="UserName" type="hidden" value="<%=Trim(Request.Cookies("asp163")("UserName"))%>"></TD>
    </TR>
    <!--������վ����-->
    <TR class="tdbg" >
      <TD width="120" align="right"><b>��ʵ������</b></TD>
      <TD><INPUT name=TrueName id="TrueName" value="<%=rsUser("TrueName")%>" size=30 maxLength=20></TD>
    </TR>
    <TR class="tdbg" >
      <TD width="120" align="right"><b>ѧ�ţ�</b></TD>
      <TD><INPUT name=StudentNumber id="StudentNumber" value="<%=rsUser("StudentNumber")%>" size=30 maxLength=20></TD>
    </TR>
    <TR class="tdbg" >
      <TD width="120" align="right"><b>ѧԺ��</b></TD>
      <TD><select  maxLength=50 size="1" name="College">
          <option  value="" >��ѡ������ѧԺ</option>
          <option  value="��ѧԺ" >��ѧԺ</option>
          <option  value="ˮ��ѧԺ" >ˮ��ѧԺ</option>
          <option  value="԰��ѧԺ">԰��ѧԺ</option>
          <option  value="����ѧԺ">����ѧԺ</option>
          <option  value="����ѧԺ" >����ѧԺ</option>
          <option  value="����ѧԺ" >����ѧԺ</option>
          <option  value="����ѧԺ" >����ѧԺ</option>
          <option  value="��ϢѧԺ" >��ϢѧԺ</option>
          <option  value="����ѧԺ" >����ѧԺ</option>
          <option  value="��ѧԺ" >��ѧԺ</option>
          <option  value="��ѧԺ" >��ѧԺ</option>
          <option  value="������ѧԺ" >������ѧԺ</option>
          <option  value="����ѧԺ" >����ѧԺ</option>
        </select></TD>
    </TR>
    <TR class="tdbg" >
      <TD width="120" align="right"><b>�༶��</b></TD>
      <TD><!-- רҵ����-->
        <select  maxLength=50 size="1" name="StudentClassName">
          <option  value="" >��ѡ������רҵ����</option>
          <option  value="��ѧ" >��ѧ</option>
          <option  value="���" >���</option>
          <option  value="��ҵ">��ҵ</option>
          <option  value="����">����</option>
          <option  value="��ƺ">��ƺ</option>
          <option  value="ˮ��" >ˮ��</option>
          <option  value="����" >����</option>
          <option  value="��ľ" >��ľ</option>
          <option  value="԰��" >԰��</option>
          <option  value="����" >����</option>
          <option  value="��԰" >��԰</option>
          <option  value="԰��" >԰��</option>
          <option  value="�ǹ�" >�ǹ�</option>
          <option  value="����">����</option>
          <option  value="����" >����</option>
          <option  value="ʳƷ" >ʳƷ</option>
          <option  value="ľ��" >ľ��</option>
          <option  value="��װ">��װ</option>
          <option  value="�ֻ�">�ֻ�</option>
          <option  value="����" >����</option>
          <option  value="�־�" >�־�</option>
          <option  value="����" >����</option>
          <option  value="���" >���</option>
          <option  value="ͳ��" >ͳ��</option>
          <option  value="����" >����</option>
          <option  value="��ó" >��ó</option>
          <option  value="Ӫ��" >Ӫ��</option>
          <option  value="����" >����</option>
          <option  value="��ѧ" >��ѧ</option>
          <option  value="����" >����</option>
          <option  value="��Ϣ" >��Ϣ</option>
          <option  value="�����" >�����</option>
          <option  value="��ý" >��ý</option>
          <option  value="����" >����</option>
          <option  value="Ӣ��" >Ӣ��</option>
          <option  value="����" >����</option>
          <option  value="��е" >��е</option>
          <option  value="����" >����</option>
          <option  value="����" >����</option>
          <option  value="�Զ���" >�Զ���</option>
          <option  value="����" >����</option>
          <option  value="����" >����</option>
          <option  value="��ѧ" >��ѧ</option>
          <option  value="������" >������</option>
          <option  value="����" >����</option>
          <option  value="����" >����</option>
          <option  value="��ϣ" >��ϣ</option>
        </select>
        <!-- ����רҵ����������-->
        <select  maxLength=50 size="1" name="StudentClassYear">
          <option  value="" >��ѡ�������꼶</option>
          <option  value="03" >03</option>
          <option  value="04" >04</option>
          <option  value="05">05</option>
          <option  value="06">06</option>
          <option  value="07" >07</option>
          <option  value="08" >08</option>
          <option  value="09" >09</option>
          <option  value="10" >10</option>
          <option  value="11" >11</option>
          <option  value="12" >12</option>
          <option  value="13" >13</option>
          <option  value="14" >14</option>
          <option  value="15" >15</option>
        </select>
        <select  maxLength=50 size="1" name="StudentClassNumber">
          <option  value="" >��ѡ�������༶(��רҵֻ��һ�����ѡ"01")</option>
          <option  value="01" >01</option>
          <option  value="02" >02</option>
          <option  value="03" >03</option>
          <option  value="04" >04</option>
          <option  value="05" >05</option>
          <option  value="06" >06</option>
          <option  value="07" >07</option>
          <option  value="08" >08</option>
          <option  value="09" >09</option>
          <option  value="10" >10</option>
        </select>
      </TD>
    </TR>
    <!--    ����������վ���� -->
    <TR class="tdbg" >
      <TD width="120" align="right"><strong>�Ա�</strong></TD>
      <TD><INPUT type=radio value="1" name=sex <%if rsUser(db_User_Sex)=1 then response.write "CHECKED"%>>
        �� &nbsp;&nbsp;
        <INPUT type=radio value="0" name=sex <%if rsUser(db_User_Sex)=0 then response.write "CHECKED"%>>
        Ů</TD>
    </TR>
    <TR class="tdbg" >
      <TD width="120" align="right"><strong>Email��ַ��</strong></TD>
      <TD><INPUT name=Email value="<%=rsUser(db_User_Email)%>" size=30   maxLength=50>
      </TD>
    </TR>
    <!--    <TR class="tdbg" >
      <TD align="right"><strong>��ҳ��</strong></TD>
      <TD><INPUT   maxLength=100 size=30 name=homepage value="<%=rsUser(db_User_Homepage)%>">
      </TD>
    </TR>
-->
    <TR class="tdbg" >
      <TD align="right"><strong>OICQ���룺</strong></TD>
      <TD><INPUT name=OICQ id="OICQ" value="<%=rsUser(db_User_QQ)%>" size=30 maxLength=20>
      </TD>
    </TR>
    <TR class="tdbg" >
      <TD align="right"><strong>���Ҽ�飺</strong></TD>
      <TD><textarea name="msn" cols="30" rows="5"><%=rsUser(db_User_Msn)%></textarea>
      </TD>
    </TR>
    <TR align="center" class="tdbg" >
      <TD height="40" colspan="2"><input name="Action" type="hidden" id="Action" value="Modify">
        <input name=Submit   type=submit id="Submit" value="�����޸Ľ��">
      </TD>
    </TR>
  </TABLE>
</form>
</body>
</html>
<%
		end if
	end if
	rsUser.close
	set rsUser=nothing
end if
call CloseConn_User()
%>
