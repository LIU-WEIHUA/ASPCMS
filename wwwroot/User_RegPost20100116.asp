<!--#include file="Inc/syscode_article.asp"-->
<!--#include file="Inc/md5.asp"-->
<!--#include file="Inc/RegBBS.asp"-->
<%
if EnableUserReg<>"Yes" then
	FoundErr=true
	ErrMsg=ErrMsg & "<br><li>�Բ��𣬱�վ��ͣ���û�ע�����</li>"
	call WriteErrMsg()
	response.end
end if

const ChannelID=2
Const ShowRunTime="Yes"
SkinID=0

dim RegUserName,Password,PwdConfirm,Question,Answer,Sex,Email,Homepage,QQ,MSN,TrueName,StudentNumber,College,StudentClass',StudentClassName,StudentClassYear,StudentClassNumber
RegUserName=trim(request("UserName"))

'����ѧԺ���ν̸���վ���������ݱ�����
TrueName=Trim(Request("TrueName"))
StudentNumber=Trim(Request("StudentNumber"))
College=Trim(Request("College"))
StudentClass=Trim(Request("StudentClassName")) & Trim(Request("StudentClassYear"))  &  Trim(Request("StudentClassNumber"))
StudentClassName=Trim(Request("StudentClassName"))
StudentClassYear=Trim(Request("StudentClassYear"))
StudentClassNumber=Trim(Request("StudentClassNumber"))
'����������ѧԺ���ν̸���վ���������ݱ�����

Password=trim(request("Password"))
PwdConfirm=trim(request("PwdConfirm"))
Question=trim(request("Question"))
Answer=trim(request("Answer"))
Sex=trim(Request("Sex"))
Email=trim(request("Email"))
Homepage=trim(request("Homepage"))
if Homepage="http://" or isnull(Homepage) then Homepage=""
QQ=trim(request("QQ"))
MSN=trim(request("MSN"))
dim CheckNum,CheckUrl
randomize
CheckNum = int(7999*rnd+2000) '�����֤��
CheckUrl=Request.ServerVariables("HTTP_REFERER")
CheckUrl=left(CheckUrl,instrrev(CheckUrl,"/")) & "User_RegCheck.asp?Action=Check&UserName=" & RegUserName & "&Password=" & Password & "&CheckNum=" & CheckNum
if RegUserName="" or strLength(RegUserName)>14 or strLength(RegUserName)<4 then
	founderr=true
	errmsg=errmsg & "<br><li>�������û���(���ܴ���14С��4)</li>"
else
  	if Instr(RegUserName,"=")>0 or Instr(RegUserName,"%")>0 or Instr(RegUserName,chr(32))>0 or Instr(RegUserName,"?")>0 or Instr(RegUserName,"&")>0 or Instr(RegUserName,";")>0 or Instr(RegUserName,",")>0 or Instr(RegUserName,"'")>0 or Instr(RegUserName,",")>0 or Instr(RegUserName,chr(34))>0 or Instr(RegUserName,chr(9))>0 or Instr(RegUserName,"��")>0 or Instr(RegUserName,"$")>0 then
		errmsg=errmsg+"<br><li>�û����к��зǷ��ַ�</li>"
		founderr=true
	end if
end if
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
	errmsg=errmsg & "<br><li>������ȷ������(���ܳ���12����6)</li>"
else
	if Password<>PwdConfirm then
		founderr=true
		errmsg=errmsg & "<br><li>�����ȷ�����벻һ��</li>"
	end if
end if
if Question="" then
	founderr=true
	errmsg=errmsg & "<br><li>������ʾ���ⲻ��Ϊ��</li>"
end if
if Answer="" then
	founderr=true
	errmsg=errmsg & "<br><li>����𰸲���Ϊ��</li>"
end if
'У��ѧ����ʵ����
if TrueName="" or strLength(TrueName)>14 or strLength(TrueName)<4 then
	founderr=true
	errmsg=errmsg & "<br><li>��������ʵ����(���ܴ���14��С��4������ַ�)</li>"
else
  	if Instr(TrueName,"=")>0 or Instr(TrueName,"%")>0 or Instr(TrueName,chr(32))>0 or Instr(TrueName,"?")>0 or Instr(TrueName,"&")>0 or Instr(TrueName,";")>0 or Instr(TrueName,",")>0 or Instr(TrueName,"'")>0 or Instr(TrueName,",")>0 or Instr(TrueName,chr(34))>0 or Instr(TrueName,chr(9))>0 or Instr(TrueName,"��")>0 or Instr(TrueName,"$")>0 then
		errmsg=errmsg+"<br><li>��ʵ�����к��зǷ��ַ�</li>"
		founderr=true
	end if
end if
'����У��ѧ����ʵ����

'У��ѧ��
if StudentNumber<>"" then
	if not isnumeric(StudentNumber) or len(cstr(StudentNumber))>12 then
		errmsg=errmsg & "<br><li>ѧ��ֻ����4-12λ���֣��������롣</li>"
		founderr=true
	end if
end if
'����У��ѧ��

'У��ѧԺ
if College="" then 
	founderr=true
	errmsg=errmsg & "<br><li>����ѡ������ѧԺ</li>"
end if
'����У��ѧԺ

'У��༶
if StudentClassName=""  or StudentClassYear="" or StudentClassNumber=""  then 
	founderr=true
	errmsg=errmsg & "<br><li>����ѡ�������༶</li>"
end if
'����У��༶



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
		errmsg=errmsg & "<br><li>����Email��ַ��ʽ�д���</li>"
   		founderr=true
	end if
end if
if QQ<>"" then
	if not isnumeric(QQ) or len(cstr(QQ))>10 then
		errmsg=errmsg & "<br><li>QQ����ֻ����4-10λ���֣�������ѡ�����롣</li>"
		founderr=true
	end if
end if


if founderr=false then
	dim sqlReg,rsReg,sqladminname,rsadminname

	sqladminname="select * from admin where UserName='" & RegUserName & "'"
	set rsadminname=server.createobject("adodb.recordset")
	rsadminname.open sqladminname,Conn,1,3
	if not(rsadminname.bof and rsadminname.eof) then
		founderr=true
		errmsg=errmsg & "<br><li>���ǹ���Ա���û������뻻һ���û����ٳ���ע�ᣡ</li>"
	else

	sqlReg="select * from " & db_User_Table & " where " & db_User_Name & "='" & RegUserName & "'"
	set rsReg=server.createobject("adodb.recordset")
	rsReg.open sqlReg,Conn_User,1,3
	if not(rsReg.bof and rsReg.eof) then
		founderr=true
		errmsg=errmsg & "<br><li>��ע����û����Ѿ����ڣ��뻻һ���û����ٳ���ע�ᣡ</li>"
	else
		rsReg.addnew
		rsReg(db_User_Name)=RegUserName
		rsReg(db_User_Password)=md5(Password)
		rsReg(db_User_Question)=Question
		rsReg(db_User_Answer)=md5(Answer)
		
		
		'����ѧԺ���ν̸���վ�������ֶ���
		rsReg(db_User_StudentNumber)=StudentNumber
		rsReg(db_User_TrueName)=TrueName
		rsReg(db_User_StudentClass)=StudentClass
		rsReg(db_User_College)=College
		rsReg("StudentClassName")=Trim(Request("StudentClassName"))
		rsReg("StudentClassYear")=Trim(Request("StudentClassYear"))
		rsReg("StudentClassNumber")=Trim(Request("StudentClassNumber"))
'		StudentClass=Trim(Request("StudentClassName")) & Trim(Request("StudentClassYear"))  &  Trim(Request("StudentClassNumber"))
		
		'����������ѧԺ���ν̸���վ�������ֶ���
		
		
		rsReg(db_User_Sex)=Sex
		rsReg(db_User_Email)=Email
		rsReg(db_User_Homepage)=Homepage
		rsReg(db_User_QQ)=QQ
		rsReg(db_User_Msn)=MSN
		rsReg(db_User_RegDate)=Now()
		rsReg(db_User_ArticleCount)=0
		rsReg(db_User_ArticleChecked)=0
		rsReg(db_User_LoginTimes)=1
		rsReg(db_User_LastLoginTime)=NOW()
		rsReg(db_User_ChargeType)=ChargeType_999
		rsReg(db_User_UserPoint)=UserPoint_999
		rsReg(db_User_BeginDate)=formatdatetime(now(),2)
		rsReg(db_User_Valid_Num)=ValidDays_999
		rsReg(db_User_Valid_Unit)=1
		if EmailCheckReg="Yes" then
			rsReg(db_User_UserLevel)=3000
			call SendRegEmail()
		else
			if AdminCheckReg="Yes" then
				rsReg(db_User_UserLevel)=2000
			else			
				rsReg(db_User_UserLevel)=999
				Response.Cookies("asp163")("UserName")=RegUserName
				Response.Cookies("asp163")("Password") =md5(Password)
				Response.Cookies("asp163")("UserLevel")=999
			end if
		end if		

		if UserTableType="Dvbbs6.0" or UserTableType="Dvbbs6.1" then
			rsReg(db_User_UserClass) = FU_UserClass
			rsReg(db_User_TitlePic) = FU_TitlePic
			rsReg(db_User_UserGroupID) = FU_UserGroupID
			rsReg(db_User_Face) = FU_Face
			rsReg(db_User_FaceWidth) = FU_FaceWidth
			rsReg(db_User_FaceHeight) = FU_FaceHeight
			rsReg(db_User_UserWealth) = FU_UserWealth
			rsReg(db_User_UserEP) = FU_UserEP
			rsReg(db_User_UserCP) = FU_UserCP
			rsReg(db_User_UserGroup) = FU_UserGroup
			rsReg(db_User_Showre) = FU_Showre
		end if 

		rsReg.update
		call UpdateUserNum(RegUserName)
	end if
	rsReg.close
	set rsReg=nothing
	end if
	rsadminname.close
	set rsadminname=nothing
end if		
PageTitle="ע��ɹ�"
%>
<html>
<head>
<title><%=strPageTitle & " >> " & PageTitle%></title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<!--#include file="inc/Skin_CSS.asp"-->
<% call MenuJS() %>
</head>

<body leftmargin="2" topmargin="0" marginwidth="0" marginheight="0"    bgcolor=#ffffff style="BACKGROUND-COLOR: #ffffff" >
<table width="989"><!--the great talbe--><tr><td>
<%	call Top_noIndex() %></td></tr>
<tr><td>
<table width="989" height="300" border="0" align="center" cellpadding="0" cellspacing="0" class="border2">
  <tr>
    <td width="180" valign="top" class="tdbg_leftall"><TABLE cellSpacing=0 cellPadding=0 width="100%" border="0" style="word-break:break-all">
        <TR class="title_left"> 
          <TD align="center"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td class="title_lefttxt"><div align="center"><b>��ע��<%=SiteName%></b></div></td>
              </tr>
            </table></TD>
        </TR>
        <TR> 
          <TD height="80" valign="top" class="tdbg_left"> <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="5">
              <tr> 
                <td valign="top"><br> <b>&nbsp;&nbsp;ע�Ჽ��</b><br> &nbsp;&nbsp;һ���Ķ���ͬ��Э��<font color="#FF0000">��</font><br> 
                  &nbsp;&nbsp;������дע������<font color="#FF0000">��</font><br> &nbsp;&nbsp;�������ע��<font color="#FF0000">��</font></td>
              </tr>
            </table></TD>
        </TR>
      </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td class="tdbg_left"><table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr> 
                <td height="11" Class="title_left2"></td>
              </tr>
            </table></td>
        </tr>
      </table>
      
    </td>
    <td width=5></td>
    <td width="800" align="center" valign=top><table width="100%" height="280" border="0" cellpadding="0" cellspacing="0" class="border">
        <tr>
          <td> <div align="center">
              <%
			if founderr=false then
				call RegSuccess()
			else
				call WriteErrmsg()
			end if
			%>
              <br>
              <br>
            </div></td>
        </tr>
      </table> 
      
      <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <tr> 
          <td  height="15" align="center" valign="top"> <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr> 
                <td height="13" Class="tdbg_left2"></td>
              </tr>
            </table></td>
        </tr>
      </table></td>
  </tr>
</table></td></tr>


<tr><td>    <!--Bottom--><%  call Bottom_All()  %></td></tr>
    </table><!--the great talbe-->
</body>
</html>
<%
call CloseConn
call CloseConn_User

sub WriteErrMsg()
    response.write "<br><br><table align='center' width='300' border='0' cellpadding='2' cellspacing='0' class='border'>"
    response.write "<tr class='title'><td align='center' height='22'>�������µ�ԭ����ע���û���</td></tr>"
    response.write "<tr class='tdbg'><td align='left' height='100'><br>" & errmsg & "<p align='center'>��<a href='javascript:onclick=history.go(-1)'>�� ��</a>��<br></p></td></tr>"
	response.write "</table>" 
end sub

sub RegSuccess()
    response.write "<br><br><table align='center' width='300' border='0' cellpadding='2' cellspacing='0' class='border'>"
    response.write "<tr class='title'><td align='center' height='22'>�ɹ�ע���û���</td></tr>"
    response.write "<tr class='tdbg'><td align='left' height='100'><br>��ע����û�����" & RegUserName & "<br>"
	if EmailCheckReg="Yes" then
		response.write "ϵͳ�Ѿ�������һ��ȷ���ŵ���ע��ʱ��д�������У���������յ�ȷ���Ų�ͨ��ȷ���������ӽ���ȷ�Ϻ��������ʽ��Ϊ��վ��ע���û���"
	else
		if AdminCheckReg="Yes" then
			response.write "��ȴ�����ͨ�����ע���������Ϳ�����ʽ��Ϊ��վ��ע���û��ˡ�"
		else			
			response.write "��ӭ���ļ��룡����"
		end if
	end if		
	response.write "<p align='center'>��<a href='javascript:onclick=window.close()'>�� ��</a>��<br></p></td></tr>"
	response.write "</table>" 
end sub

sub SendRegEmail()
	dim MailtoAddress,MailtoName,Subject,MailBody,FromName,MailFrom,Priority
	MailtoAddress=Email
	MailtoName=RegUserName
	Subject="ע��ȷ����"
	MailBody="����һ��ע��ȷ���š������֤���ǣ�" & CheckNum & vbcrlf & "<br>���˽���ȷ�ϣ�<a href='" & CheckUrl & "'>" & CheckUrl & "</a>"
	FromName=SiteName
	MailFrom=WebmasterEmail
	Priority=3
	ErrMsg=SendMail(MailtoAddress,MailtoName,Subject,MailBody,FromName,MailFrom,Priority)
	if ErrMsg<>"" then FoundErr=True
end sub
%>