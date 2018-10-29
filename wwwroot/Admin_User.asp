<%@language=vbscript codepage=936 %>
<%
option explicit
response.buffer=true	
Const PurviewLevel=2
Const CheckChannelID=0
Const PurviewLevel_Others="User"
%>
<!--#include file="inc/conn.asp"-->
<!--#include file="inc/config.asp"-->
<!--#include file="Admin_ChkPurview.asp"-->
<!--#include file="inc/Conn_User.asp"-->
<!--#include file="inc/function.asp"-->
<!--#include file="inc/md5.asp"-->
<!--#include file="Inc/RegBBS.asp"-->
<%
const MaxPerPage=20
dim strFileName
dim totalPut,CurrentPage,TotalPages
dim rs, sql
dim UserID,UserSearch,Keyword,strField
dim Action,FoundErr,ErrMsg
dim tmpDays
keyword=trim(request("keyword"))
if keyword<>"" then 
	keyword=ReplaceBadChar(keyword)
end if
strField=trim(request("Field"))
UserSearch=trim(request("UserSearch"))
Action=trim(request("Action"))
UserID=trim(Request("UserID"))
ComeUrl=Request.ServerVariables("HTTP_REFERER")

if UserSearch="" then
	UserSearch=0
else
	UserSearch=Clng(UserSearch)
end if
strFileName="Admin_User.asp?UserSearch=" & UserSearch
if request("page")<>"" then
    currentPage=cint(request("page"))
else
	currentPage=1
end if

%>
<html>
<head>
<title>ע���û�����</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="Admin_Style.css" rel="stylesheet" type="text/css">
<SCRIPT language=javascript>
function unselectall()
{
    if(document.myform.chkAll.checked){
	document.myform.chkAll.checked = document.myform.chkAll.checked&0;
    } 	
}

function CheckAll(form)
{
  for (var i=0;i<form.elements.length;i++)
    {
    var e = form.elements[i];
    if (e.Name != "chkAll")
       e.checked = form.chkAll.checked;
    }
}
</SCRIPT>
</head>
<body leftmargin="2" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" Class="border">
  <tr class="topbg"> 
    <td height="22" colspan=2 align=center><strong>ע �� �� �� �� ��</strong></td>
  </tr>
  <form name="form1" action="Admin_User.asp" method="get">
    <tr class="tdbg"> 
      <td width="100" height="30"><strong>���ٲ����û���</strong></td>
      <td width="687" height="30"><select size=1 name="UserSearch" onChange="javascript:submit()">
          <option value="0" <%if UserSearch=0 then response.write " selected"%>>�г������û�</option>
          <option value="1" <%if UserSearch=1 then response.write " selected"%>>�������TOP100</option>
          <option value="2" <%if UserSearch=2 then response.write " selected"%>>�������ٵ�100���û�</option>
          <option value="3" <%if UserSearch=3 then response.write " selected"%>>���24Сʱ�ڵ�¼���û�</option>
          <option value="4" <%if UserSearch=4 then response.write " selected"%>>���24Сʱ��ע����û�</option>
          <option value="5" <%if UserSearch=5 then response.write " selected"%>>�ȴ��ʼ���֤���û�</option>
          <option value="6" <%if UserSearch=6 then response.write " selected"%>>�ȴ�����Ա��֤���û�</option>
          <option value="7" <%if UserSearch=7 then response.write " selected"%>>���б���ס���û�</option>
          <option value="8" <%if UserSearch=8 then response.write " selected"%>>�����շ��û�</option>
          <option value="9" <%if UserSearch=9 then response.write " selected"%>>����VIP�û�</option>
        </select>
        &nbsp;&nbsp;&nbsp;&nbsp;<a href="Admin_User.asp">�û�������ҳ</a>&nbsp;|&nbsp;<a href="Admin_User.asp?Action=Add">������û�</a></td>
    </tr>
  </form>
</table>
<br>
<%
if Action="Add" then
	call AddUser()
elseif Action="SaveAdd" then
	call SaveAdd()
elseif Action="Modify" then
	call Modify()
elseif Action="SaveModify" then
	call SaveModify()
elseif Action="Del" then
	call DelUser()
elseif Action="Lock" then
	call LockUser()
elseif Action="UnLock" then
	call UnLockUser()
elseif Action="Move" then
	call MoveUser()
elseif Action="Update" then
	call UpdateUser()
elseif Action="DoUpdate" then
	call DoUpdate()
elseif Action="AddMoney" then
	call AddMoney()
elseif Action="SaveAddMoney" then
	call SaveAddMoney()
else
	call main()
end if
if FoundErr=True then
	call WriteErrMsg()
end if
call CloseConn_User()  

sub main()
	dim strGuide
	strGuide="<table width='100%'><tr><td align='left'>�����ڵ�λ�ã�<a href='Admin_User.asp'>ע���û�����</a>&nbsp;&gt;&gt;&nbsp;"
	select case UserSearch
		case 0
			sql="select * from " & db_User_Table & " order by " & db_User_ID & " desc"
			strGuide=strGuide & "�����û�"
		case 1
			sql="select top 100 * from " & db_User_Table & " order by " & db_User_ArticleChecked & " desc"
			strGuide=strGuide & "������������ǰ100���û�"
		case 2
			sql="select top 100 * from " & db_User_Table & " order by " & db_User_ArticleChecked & ""
			strGuide=strGuide & "�����������ٵ�100���û�"
		case 3
			sql="select * from " & db_User_Table & " where datediff('h'," & db_User_LastLoginTime & ",Now())<25 order by " & db_User_LastLoginTime & " desc"
			strGuide=strGuide & "���24Сʱ�ڵ�¼���û�"
		case 4
			sql="select * from " & db_User_Table & " where datediff('h'," & db_User_RegDate & ",Now())<25 order by " & db_User_RegDate & " desc"
			strGuide=strGuide & "���24Сʱ��ע����û�"
		case 5
			sql="select * from " & db_User_Table & " where " & db_User_UserLevel & "=3000 order by " & db_User_ID & " desc"
			strGuide=strGuide & "�ȴ��ʼ���֤���û�"
		case 6
			sql="select * from " & db_User_Table & " where " & db_User_UserLevel & "=2000 order by " & db_User_ID & " desc"
			strGuide=strGuide & "�ȴ�������֤֤���û�"
		case 7
			sql="select * from " & db_User_Table & " where " & db_User_LockUser & "=True order by " & db_User_ID & " desc"
			strGuide=strGuide & "���б���ס���û�"
		case 8
			sql="select * from " & db_User_Table & " where " & db_User_UserLevel & "=99 order by " & db_User_ID & " desc"
			strGuide=strGuide & "�����շ��û�"
		case 9
			sql="select * from " & db_User_Table & " where " & db_User_UserLevel & "=9 order by " & db_User_ID & " desc"
			strGuide=strGuide & "����VIP�û�"
		case 10
			if Keyword="" then
				sql="select * from " & db_User_Table & " order by " & db_User_ID & " desc"
				strGuide=strGuide & "�����û�"
			else
				select case strField
				case "UserID"
					if IsNumeric(Keyword)=False then
						FoundErr=True
						ErrMsg=ErrMsg & "<br><li>�û�ID����������</li>"
					else
						sql="select * from " & db_User_Table & " where " & db_User_ID & "=" & Clng(Keyword)
						strGuide=strGuide & "�û�ID����<font color=red> " & Clng(Keyword) & " </font>���û�"
					end if
				case "UserName"
					sql="select * from " & db_User_Table & " where " & db_User_Name & " like '%" & Keyword & "%' order by " & db_User_ID & " desc"
					strGuide=strGuide & "�û����к��С� <font color=red>" & Keyword & "</font> �����û�"
				end select
			end if
		case else
			FoundErr=True
			ErrMsg=ErrMsg & "<br><li>����Ĳ�����</li>"
	end select
	strGuide=strGuide & "</td><td align='right'>"
	if FoundErr=True then exit sub
	
	Set rs=Server.CreateObject("Adodb.RecordSet")
	rs.Open sql,Conn_User,1,1
  	if rs.eof and rs.bof then
		strGuide=strGuide & "���ҵ� <font color=red>0</font> ���û�</td></tr></table>"
		response.write strGuide
	else
    	totalPut=rs.recordcount
		strGuide=strGuide & "���ҵ� <font color=red>" & totalPut & "</font> ���û�</td></tr></table>"
		response.write strGuide
		if currentpage<1 then
       		currentpage=1
    	end if
    	if (currentpage-1)*MaxPerPage>totalput then
	   		if (totalPut mod MaxPerPage)=0 then
	     		currentpage= totalPut \ MaxPerPage
		  	else
		      	currentpage= totalPut \ MaxPerPage + 1
	   		end if

    	end if
	    if currentPage=1 then
        	showContent
        	showpage strFileName,totalput,MaxPerPage,true,true,"���û�"
   	 	else
   	     	if (currentPage-1)*MaxPerPage<totalPut then
         	   	rs.move  (currentPage-1)*MaxPerPage
         		dim bookmark
           		bookmark=rs.bookmark
            	showContent
            	showpage strFileName,totalput,MaxPerPage,true,true,"���û�"
        	else
	        	currentPage=1
           		showContent
           		showpage strFileName,totalput,MaxPerPage,true,true,"���û�"
	    	end if
		end if
	end if
	rs.Close
	set rs=Nothing
	call ShowSearch()
end sub

sub showContent()
   	dim i
    i=0
%>
<table width='100%' border="0" cellpadding="0" cellspacing="0">
  <tr>
  <form name="myform" method="Post" action="Admin_User.asp" onSubmit="return confirm('ȷ��Ҫִ��ѡ���Ĳ�����');">
      <td height="90"> 
        <table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" class="border">
          <tr class="title">
            <td width="30" align="center"><strong>ѡ��</strong></td>
            <td width="30" align="center"><strong>ID</strong></td>
            <td width="80" height="22" align="center"><strong> �û���</strong></td>
            <td width="84" height="22" align="center"><strong>�����û���</strong></td>
            <td width="87" align="center"><strong>����/����</strong></td>
            <td width="82" height="24" align="center"><strong>����¼IP</strong></td>
            <td width="97" align="center"><strong>����¼ʱ��</strong></td>
            <td width="60" height="22" align="center"><strong>��¼����</strong></td>
            <td width="40" height="22" align="center"><strong> ״̬</strong></td>
<!-- ============================ ɽ����û��ռǱ�����޸� 01 ��ʼ ==================================== -->
            <td width="59" height="20" align="center"><strong>�ռ���</strong></td>
<!-- ============================ ɽ����û��ռǱ�����޸� 01 ���� ==================================== -->
            <td width="60" align="center"><strong>����</strong></td>
          </tr>
          <%do while not rs.EOF %>
          <tr class="tdbg" onMouseOut="this.style.backgroundColor=''" onMouseOver="this.style.backgroundColor='#BFDFFF'">
            <td width="30" height="22" align="center"> 
              <input name='UserID' type='checkbox' onClick="unselectall()" id="UserID" value='<%=cstr(rs(db_User_ID))%>'></td>
            <td width="30" align="center"><%=rs(db_User_ID)%></td>
            <td width="80" align="center"><%
			response.write "<a href='Admin_User.asp?Action=Modify&UserID=" & rs(db_User_ID) & "' title=""======== �� �� �� Ϣ ========" & vbcrlf & "�Ա�"
			if rs(db_User_Sex)=1 then
				response.write "��"
			else
				response.write "Ů"
			end if
			response.write vbcrlf & "���䣺" & rs(db_User_Email) & vbcrlf & "�ѣѣ�"
			if rs(db_User_QQ)<>"" then
				response.write rs(db_User_QQ)
			else
				response.write "δ��"
			end if
			response.write vbcrlf & "MSN��"
			if rs(db_User_Msn)<>"" then
			response.write rs(db_User_Msn)
			else
				response.write "δ��"
			end if
			response.write vbcrlf & "��ҳ��"
			if rs(db_User_Homepage)<>"" then
				response.write rs(db_User_Homepage)
			else
				response.write "δ��"
			end if
			response.write vbcrlf & "ע�����ڣ�" & rs(db_User_RegDate)

			response.write """>" & rs(db_User_Name) & "</a>"
			%> </td>
            <td align="center"> <%
			select case rs(db_User_UserLevel)
				case 3000
					response.write "<font color=green>�ȴ��ʼ���֤���û�</font>"
				case 2000
					response.write "<font color=green>�ȴ�����Ա��֤���û�</font>"
				case 999
					response.write "��ͨע���û�"
				case 99
					response.write "<font color=blue>�շ��û�</font>"
				case 9
					response.write "<font color=blue>VIP�û�</font>"
				case else
					response.write "<font color=red>�쳣�û�</font>"
			end select
			%> </td>
            <td align="center"> <%
	if rs(db_User_UserLevel)=99 or rs(db_User_UserLevel)=9 then
		if rs(db_User_ChargeType)=1 then
			if rs(db_User_UserPoint)<=0 then
				response.write "<font color=red>" & rs(db_User_UserPoint) & "</font> ��"
			else
				if rs(db_User_UserPoint)<=10 then
					response.write "<font color=blue>" & rs(db_User_UserPoint) & "</font> ��"
				else
					response.write rs(db_User_UserPoint) & " ��"
				end if
			end if
		else
		  if rs(db_User_Valid_Unit)=1 then
			ValidDays=rs(db_User_Valid_Num)
		  elseif rs(db_User_Valid_Unit)=2 then
			ValidDays=rs(db_User_Valid_Num)*30
		  elseif rs(db_User_Valid_Unit)=3 then
			ValidDays=rs(db_User_Valid_Num)*365
		  end if
		  tmpDays=ValidDays-DateDiff("D",rs(db_User_BeginDate),now())
		  if tmpDays<=0 then
			response.write "<font color=red>" & tmpDays & "</font> ��"
		  else
		  	if tmpDays<=10 then
				response.write "<font color=blue>" & tmpDays & "</font> ��"
		    else
				response.write tmpDays & " ��"
			end if
		  end if
		end if
	else
		response.write "&nbsp;"
	end if
		%></td>
            <td align="center"> <%
	if rs(db_User_LastLoginIP)<>"" then
		response.write rs(db_User_LastLoginIP)
	else
		response.write "&nbsp;"
	end if
	%> </td>
            <td align="center"> <%
	if rs(db_User_LastLoginTime)<>"" then
		response.write rs(db_User_LastLoginTime)
	else
		response.write "&nbsp;"
	end if
	%> </td>
            <td width="60" align="center"> <%
	if rs(db_User_LoginTimes)<>"" then
		response.write rs(db_User_LoginTimes)
	else
		response.write "0"
	end if
	%> </td>
            <td width="40" align="center"><%
	  if rs(db_User_LockUser)=true then
	  	response.write "<font color=red>������</font>"
	  else
	  	response.write "����"
	  end if
	  %></td>
<!-- ============================ ɽ����û��ռǱ�����޸� 02 ��ʼ ==================================== -->
            <td align="center"><a href=diary_userdiarylist.asp?diaryOwner=<%=rs("UserName")%> title=����鿴������û��Ĺ����ռ�><%=rs("diaryNum")%></a></td>
            <td align="center"> 
              <%
		response.write "<a href='Admin_User.asp?Action=Modify&UserID=" & rs(db_User_ID) & "'>��</a>&nbsp;"
		if rs(db_User_LockUser)=False then
			response.write "<a href='Admin_User.asp?Action=Lock&UserID=" & rs(db_User_ID) & "'>��</a>&nbsp;"
		else
            response.write "<a href='Admin_User.asp?Action=UnLock&UserID=" & rs(db_User_ID) & "'>��</a>&nbsp;"
		end if
        response.write "<a href='Admin_User.asp?Action=Del&UserID=" & rs(db_User_ID) & "' onClick='return confirm(""ȷ��Ҫɾ�����û���"");'>ɾ</a>&nbsp;"
		if rs(db_User_UserLevel)=99 or rs(db_User_UserLevel)=9 then
			response.write "<a href='Admin_User.asp?Action=AddMoney&UserID=" & rs(db_User_ID) & "'>����</a>"
		else
            response.write "&nbsp;&nbsp;&nbsp;&nbsp;"
		end if
		%>
            </td>
          </tr>
          <%
	i=i+1
	if i>=MaxPerPage then exit do
	rs.movenext
loop
%>
        </table>  
        <strong>����</strong>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td width="200" height="30"><input name="chkAll" type="checkbox" id="chkAll" onclick=CheckAll(this.form) value="checkbox">
              ѡ�б�ҳ��ʾ�������û�</td>
            <td> <strong>������</strong> 
              <input name="Action" type="radio" value="Del" checked onClick="document.myform.UserLevel.disabled=true">ɾ��&nbsp;&nbsp;&nbsp;&nbsp;
              <input name="Action" type="radio" value="Lock" onClick="document.myform.UserLevel.disabled=true">���� &nbsp;&nbsp;&nbsp;
              <input name="Action" type="radio" value="UnLock" onClick="document.myform.UserLevel.disabled=true">���� &nbsp;&nbsp;&nbsp; 
              <input name="Action" type="radio" value="Move" onClick="document.myform.UserLevel.disabled=false">�ƶ���
              <select name="UserLevel" id="UserLevel" disabled>
                <option value="3000">�ȴ��ʼ���֤���û�</option>
                <option value="2000">�ȴ�������˵��û�</option>
                <option value="999">ע���û�</option>
                <option value="99" selected>�շ��û�</option>
                <option value="9">VIP�û�</option>
              </select>
              &nbsp;&nbsp; 
              <input type="submit" name="Submit" value=" ִ �� "> </td>
  </tr>
</table>
</td>
</form></tr></table>
<%
end sub

sub ShowSearch()
%>
<form name="form2" method="post" action="Admin_User.asp">
<table width="100%" border="0" cellspacing="1" cellpadding="2" class="border">
  <tr class="tdbg">
    <td width="120"><strong>�û��߼���ѯ��</strong></td>
    <td width="300">
      <select name="Field" id="Field">
      <option value="UserID" selected>�û�ID</option>
      <option value="UserName">�û���</option>
      </select>
      <input name="Keyword" type="text" id="Keyword" size="20" maxlength="30">
      <input type="submit" name="Submit2" value=" �� ѯ ">
      <input name="UserSearch" type="hidden" id="UserSearch" value="10">
	</td>
    <td>��Ϊ�գ����ѯ�����û�</td>
  </tr>
</table>
    </form>
<%
end sub

sub AddUser()
%>
<form name="myform" action="Admin_User.asp" method="post">
  <table width=100% border=0 cellpadding=2 cellspacing=1 class="border">
    <TR align=center class='title'> 
      <TD height=22 colSpan=2><font class=en><b>�� �� �� �� ��</b></font></TD>
    </TR>
    <TR class="tdbg" > 
      <TD width="40%"><b>�û�����</b><BR>
        ���ܳ���14���ַ���7�����֣�</TD>
      <TD width="60%"> <INPUT   maxLength=14 size=30 name=UserName> <font color="#FF0000">*</font></TD>
    </TR>
    <TR class="tdbg" > 
      <TD width="40%"><B>����(����6λ)��</B><BR>
        ���������룬���ִ�Сд�� �벻Ҫʹ���κ����� '*'��' ' �� HTML �ַ� </TD>
      <TD width="60%"> <INPUT   type=password maxLength=12 size=30 name=Password> 
        <font color="#FF0000">*</font> </TD>
    </TR>
    <TR class="tdbg" > 
      <TD width="40%"><strong>ȷ������(����6λ)��</strong><BR>
        ������һ��ȷ��</TD>
      <TD width="60%"> <INPUT   type=password maxLength=12 size=30 name=PwdConfirm> 
        <font color="#FF0000">*</font> </TD>
    </TR>
    <TR class="tdbg" > 
      <TD width="40%"><strong>�������⣺</strong><BR>
        �����������ʾ����</TD>
      <TD width="60%"> <INPUT   type=text maxLength=50 size=30 name="Question"> 
        <font color="#FF0000">*</font> </TD>
    </TR>
    <TR class="tdbg" > 
      <TD width="40%"><strong>����𰸣�</strong><BR>
        �����������ʾ����𰸣�����ȡ������</TD>
      <TD width="60%"> <INPUT   type=text maxLength=20 size=30 name="Answer"> 
        <font color="#FF0000">*</font> </TD>
    </TR>
    <TR class="tdbg" > 
      <TD width="40%"><strong>�Ա�</strong></TD>
      <TD width="60%"> <INPUT type=radio CHECKED value="1" name=sex>
        �� &nbsp;&nbsp; <INPUT type=radio value="0" name=sex>
        Ů</TD>
    </TR>
    <TR class="tdbg" > 
      <TD width="40%"><strong>Email��ַ��</strong></TD>
      <TD width="60%"> <INPUT   maxLength=50 size=30 name=Email> <font color="#FF0000">*</font></TD>
    </TR>
    <TR class="tdbg" > 
      <TD width="40%"><strong>��ҳ��</strong></TD>
      <TD width="60%"> <INPUT   maxLength=100 size=30 name=homepage value="http://"></TD>
    </TR>
    <TR class="tdbg" > 
      <TD width="40%"><strong>OICQ���룺</strong></TD>
      <TD width="60%"> <INPUT maxLength=20 size=30 name=OICQ></TD>
    </TR>
    <TR class="tdbg" > 
      <TD width="40%"><strong>���˼�飺</strong></TD>
      <TD width="60%"> <textarea name="msn" cols="30" rows="3"></textarea></TD>
    </TR>
    <TR class="tdbg" > 
      <TD width="40%"><strong>�û�����</strong></TD>
      <TD width="60%"><select name="UserLevel" id="UserLevel">
          <option value="3000">�ȴ��ʼ���֤���û�</option>
          <option value="2000">�ȴ�������˵��û�</option>
          <option value="999" selected>ע���û�</option>
          <option value="99">�շ��û�</option>
          <option value="9">VIP�û�</option>
        </select></TD>
    </TR>
    <TR class="tdbg" >
      <TD><strong>�Ʒѷ�ʽ��</strong></TD>
      <TD><input name="ChargeType" type="radio" value="1" checked>
        �۵���<font color="#0000FF">���Ƽ���</font>��&nbsp;ÿ�Ķ�һƪ�շ����£��۳���Ӧ������&nbsp;<br>
        <input type="radio" name="ChargeType" value="2">
        ��Ч�ڣ�����Ч���ڣ��û����������Ķ��շ�����</TD>
    </TR>
    <TR class="tdbg" >
      <TD><strong>�û�������</strong><br>
        �����Ķ���Ҫ���Ķ����������£����Ķ�����ʱ���ȥ��Ӧ�ĵ���<br>
        �˹���ֻ�е��Ʒѷ�ʽΪ���۵�����ʱ����Ч</TD>
      <TD><input name="UserPoint" type="text" id="UserPoint" value="500" size="10" maxlength="10">
        ��</TD>
    </TR>
    <TR class="tdbg" >
      <TD><strong>��Ч���ޣ�</strong><br>
        �����������ޣ����û������Ķ��շ�����<br>
        �˹���ֻ�е��Ʒѷ�ʽΪ����Ч���ޡ�ʱ����Ч</TD>
      <TD>��ʼ���ڣ�
        <input name="BeginDate" type="text" id="BeginDate" value="<%=FormatDateTime(now(),2)%>" size="20" maxlength="20">
      <br>
      �� Ч �ڣ�
      <input name="Valid_Num" type="text" id="Valid_Num" value="1" size="10" maxlength="10">
      <select name="Valid_Unit" id="Valid_Unit">
      <option value="1">��</option>
      <option value="2">��</option>
      <option value="3" selected>��</option>
      </select>
      </TD>
    </TR>
    <TR class="tdbg" > 
      <TD width="40%"><strong>�û�״̬��</strong></TD>
      <TD width="60%"><input name="LockUser" type="radio" value="False" checked>
        ����&nbsp;&nbsp; <input type="radio" name="LockUser" value="True">
        ����</TD>
    </TR>
    <TR align="center" class="tdbg" > 
      <TD colspan="2"><input name="Action" type="hidden" id="Action" value="SaveAdd">
        <input type="submit" name="Submit" value=" �� �� "></TD>
    </TR>
  </TABLE>
</form>
<%
end sub

sub Modify()
	dim UserID
	dim rsUser,sqlUser
	UserID=trim(request("UserID"))
	if UserID="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>�������㣡</li>"
		exit sub
	else
		UserID=Clng(UserID)
	end if
	Set rsUser=Server.CreateObject("Adodb.RecordSet")
	sqlUser="select * from " & db_User_Table & " where " & db_User_ID & "=" & UserID
	rsUser.Open sqlUser,Conn_User,1,3
	if rsUser.bof and rsUser.eof then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>�Ҳ���ָ�����û���</li>"
		rsUser.close
		set rsUser=nothing
		exit sub
	end if
%>
<FORM name="Form1" action="Admin_User.asp" method="post">
  <table width="100%" border="0" cellspacing="1" cellpadding="2" class="border">
    <TR class='title'> 
      <TD height=22 colSpan=2 align="center"><b>�޸�ע���û���Ϣ</b></TD>
    </TR>
    <TR class="tdbg" > 
      <TD width="40%"><b>�û�����</b></TD>
      <TD width="60%"><%=rsUser(db_User_Name)%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="Admin_ArticleManage.asp?Field=Editor&Keyword=<%=rsUser(db_User_Name)%>">�鿴���û����������</a></TD>
    </TR>
    <TR class="tdbg" > 
      <TD width="40%"><B>����(����6λ)��</B><BR>
        ���������룬���ִ�Сд�� �벻Ҫʹ���κ����� '*'��' ' �� HTML �ַ� </TD>
      <TD width="60%"> <INPUT   type=password maxLength=16 size=30 name=Password> 
        <font color="#FF0000">��������޸ģ�������</font> </TD>
    </TR>
    <TR class="tdbg" >
      <TD><strong>ȷ������(����6λ)��</strong><br>
        ������һ��ȷ��</TD>
      <TD><INPUT name=PwdConfirm   type=password id="PwdConfirm" size=30 maxLength=12>
        <font color="#FF0000">��������޸ģ�������</font> </TD>
    </TR>
    <TR class="tdbg" > 
      <TD width="40%"><strong>�������⣺</strong><br>
        �����������ʾ����</TD>
      <TD width="60%"> <INPUT name="Question"   type=text value="<%=rsUser(db_User_Question)%>" size=30> 
      </TD>
    </TR>
    <TR class="tdbg" > 
      <TD width="40%"><strong>����𰸣�</strong><BR>
        �����������ʾ����𰸣�����ȡ������</TD>
      <TD width="60%"> <INPUT   type=text size=30 name="Answer"> <font color="#FF0000">��������޸ģ�������</font></TD>
    </TR>
    <TR class="tdbg" > 
      <TD width="40%"><strong>�Ա�</strong></TD>
      <TD width="60%"> <INPUT type=radio value="1" name=sex <%if rsUser(db_User_Sex)=1 then response.write "CHECKED"%>>
        �� &nbsp;&nbsp; <INPUT type=radio value="0" name=sex <%if rsUser(db_User_Sex)=0 then response.write "CHECKED"%>>
        Ů</TD>
    </TR>
    <TR class="tdbg" > 
      <TD width="40%"><strong>Email��ַ��</strong></TD>
      <TD width="60%"> <INPUT name=Email value="<%=rsUser(db_User_Email)%>" size=30   maxLength=50>
        <a href="mailto:<%=rsUser(db_User_Email)%>">�����û���һ������ʼ�</a> </TD>
    </TR>
    <TR class="tdbg" > 
      <TD width="40%"><strong>��ҳ��</strong></TD>
      <TD width="60%"> <INPUT   maxLength=100 size=30 name=homepage value="<%=rsUser(db_User_Homepage)%>"></TD>
    </TR>
    <TR class="tdbg" > 
      <TD width="40%"><strong>OICQ���룺</strong></TD>
      <TD width="60%"> <INPUT name=OICQ value="<%=rsUser(db_User_QQ)%>" size=30 maxLength=20></TD>
    </TR>
    <TR class="tdbg" > 
      <TD width="40%"><strong>���˼�飺</strong></TD>
      <TD width="60%"> <textarea name="msn" cols="30" rows="3"><%=rsUser(db_User_Msn)%></textarea></TD>
    </TR>
    <TR class="tdbg" > 
      <TD width="40%"><strong>�û�����</strong></TD>
      <TD width="60%"><select name="UserLevel" id="UserLevel">
          <option value="3000" <%if rsUser(db_User_UserLevel)=3000 then response.write " selected"%>>�ȴ��ʼ���֤���û�</option>
          <option value="2000" <%if rsUser(db_User_UserLevel)=2000 then response.write " selected"%>>�ȴ�������˵��û�</option>
          <option value="999" <%if rsUser(db_User_UserLevel)=999 then response.write " selected"%>>ע���û�</option>
          <option value="99" <%if rsUser(db_User_UserLevel)=99 then response.write " selected"%>>�շ��û�</option>
          <option value="9" <%if rsUser(db_User_UserLevel)=9 then response.write " selected"%>>VIP�û�</option>
        </select></TD>
    </TR>
    <TR class="tdbg" >
      <TD><strong>�Ʒѷ�ʽ��</strong></TD>
      <TD><input name="ChargeType" type="radio" value="1" <%if rsUser(db_User_ChargeType)=1 then response.write " checked"%>>
        �۵���<font color="#0000FF">���Ƽ���</font>��&nbsp;ÿ�Ķ�һƪ�շ����£��۳���Ӧ������&nbsp;<br>
        <input type="radio" name="ChargeType" value="2" <%if rsUser(db_User_ChargeType)=2 then response.write " checked"%>>
        ��Ч�ڣ�����Ч���ڣ��û����������Ķ��շ�����</TD>
    </TR>
    <TR class="tdbg" >
      <TD><strong>�û�������</strong><br>
        �����Ķ���Ҫ���Ķ����������£����Ķ�����ʱ���ȥ��Ӧ�ĵ���<br>
        �˹���ֻ�е��Ʒѷ�ʽΪ���۵�����ʱ����Ч</TD>
      <TD><input name="UserPoint" type="text" id="UserPoint" value="<%=rsUser(db_User_UserPoint)%>" size="10" maxlength="10">
        ��</TD>
    </TR>
    <TR class="tdbg" >
      <TD><strong>��Ч���ޣ�</strong><br>
        �����������ޣ����û������Ķ��շ�����<br>
        �˹���ֻ�е��Ʒѷ�ʽΪ����Ч���ޡ�ʱ����Ч</TD>
      <TD>��ʼ���ڣ�
        <input name="BeginDate" type="text" id="BeginDate" value="<%=FormatDateTime(rsUser(db_User_BeginDate),2)%>" size="20" maxlength="20">
      <br>
      �� Ч �ڣ�
      <input name="Valid_Num" type="text" id="Valid_Num" value="<%=rsUser(db_User_Valid_Num)%>" size="10" maxlength="10">
      <select name="Valid_Unit" id="Valid_Unit">
      <option value="1" <%if rsUser(db_User_Valid_Unit)=1 then response.write " selected"%>>��</option>
      <option value="2" <%if rsUser(db_User_Valid_Unit)=2 then response.write " selected"%>>��</option>
      <option value="3" <%if rsUser(db_User_Valid_Unit)=3 then response.write " selected"%>>��</option>
      </select>
      </TD>
    </TR>
    <TR class="tdbg" > 
      <TD width="40%"><strong>�û�״̬��</strong></TD>
      <TD width="60%"><input type="radio" name="LockUser" value="False" <%if rsUser(db_User_LockUser)=False then response.write "checked"%>>
        ����&nbsp;&nbsp; <input type="radio" name="LockUser" value="True" <%if rsUser(db_User_LockUser)=True then response.write "checked"%>>
        ����</TD>
    </TR>
    <TR class="tdbg" > 
      <TD height="40" colspan="2" align="center"><input name="Action" type="hidden" id="Action" value="SaveModify"> 
        <input name=Submit   type=submit id="Submit" value="�����޸Ľ��"> <input name="UserID" type="hidden" id="UserID" value="<%=rsUser(db_User_ID)%>"></TD>
    </TR>
  </TABLE>
</form>
<%
	rsUser.close
	set rsUser=nothing
end sub

sub AddMoney()
	dim UserID
	dim rsUser,sqlUser
	UserID=trim(request("UserID"))
	if UserID="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>�������㣡</li>"
		exit sub
	else
		UserID=Clng(UserID)
	end if
	Set rsUser=Server.CreateObject("Adodb.RecordSet")
	sqlUser="select * from " & db_User_Table & " where " & db_User_ID & "=" & UserID
	rsUser.Open sqlUser,Conn_User,1,3
	if rsUser.bof and rsUser.eof then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>�Ҳ���ָ�����û���</li>"
		rsUser.close
		set rsUser=nothing
		exit sub
	end if
	if rsUser(db_User_UserLevel)>99 then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>���û������շ��û���VIP�û����������ѣ�</li>"
		rsUser.close
		set rsUser=nothing
		exit sub
	end if
%>
<FORM name="Form1" action="Admin_User.asp" method="post">
  <table width="100%" border="0" cellspacing="1" cellpadding="2" class="border">
    <TR class='title'> 
      <TD height=22 colSpan=2 align="center"><b>�� �� �� ��</b></TD>
    </TR>
    <TR class="tdbg" > 
      <TD width="40%"><b>�û�����</b></TD>
      <TD width="60%"><%=rsUser(db_User_Name)%></TD>
    </TR>
    <TR class="tdbg" > 
      <TD width="40%"><strong>�û�����</strong></TD>
      <TD width="60%"><%
	  if rsUser(db_User_UserLevel)=99 then
	  	response.write "�շ��û�"      
	  elseif rsUser(db_User_UserLevel)=9 then
	  	response.write "VIP�û�"
	  end if
      %></TD>
    </TR>
    <TR class="tdbg" >
      <TD><strong>�Ʒѷ�ʽ��</strong></TD>
      <TD><%
	  if rsUser(db_User_ChargeType)=1 then
	   	response.write "�۵�����&nbsp;ÿ�Ķ�һƪ�շ����£��۳���Ӧ������"
      else
	   	response.write "��Ч�ڣ�����Ч���ڣ��û����������Ķ��շ�����"
	  end if
	  %>
        <input name="ChargeType" type="hidden" id="ChargeType" value="<%=rsUser(db_User_ChargeType)%>">
		</TD>
    </TR>
    <%if rsUser(db_User_ChargeType)=1 then%>
	<TR class="tdbg" >
      <TD><strong>Ŀǰ���û�������</strong></TD>
      <TD><%=rsUser(db_User_UserPoint)%> ��</TD>
    </TR>
    <TR class="tdbg" >
      <TD><strong>׷�ӵ�����</strong></TD>
      <TD> <input name="UserPoint" type="text" id="UserPoint" value="100" size="10" maxlength="10">
      ��</TD>
    </TR>
	<%else%>
    <TR class="tdbg" >
      <TD><strong>Ŀǰ����Ч������Ϣ��</strong></TD>
      <TD><%
	  response.write "��ʼ��������" & FormatDateTime(rsUser(db_User_BeginDate),2) & "&nbsp;&nbsp;&nbsp;&nbsp;�� Ч �ڣ�" & rsUser(db_User_Valid_Num)
	  if rsUser(db_User_Valid_Unit)=1 then
	  	ValidDays=rsUser(db_User_Valid_Num)
	  	response.write "��"
	  elseif rsUser(db_User_Valid_Unit)=2 then
	  	ValidDays=rsUser(db_User_Valid_Num)*30
	  	response.write "��"
	  elseif rsUser(db_User_Valid_Unit)=3 then
	  	ValidDays=rsUser(db_User_Valid_Num)*365
	  	response.write "��"
	  end if
	  response.write "<br>"
	  tmpDays=ValidDays-DateDiff("D",rsUser(db_User_BeginDate),now())
	  if tmpDays>=0 then
	  	response.write "���� <font color=blue>" & tmpDays & "</font> �쵽��"
	  else
	  	response.write "�Ѿ����� <font color=red>" & abs(tmpDays) & "</font> ��"
	  end if
	  %>
      </TD>
    </TR>
	<tr class="tdbg" >
	  <td><strong>׷��������</strong><br>
	    ��Ŀǰ�û���δ���ڣ���׷����Ӧ����<br>
	    ��Ŀǰ�û��Ѿ�������Ч�ڣ�����Ч�ڴ�����֮�������¼�����</td>
	  <td>
      <input name="Valid_Num" type="text" id="Valid_Num" value="1" size="10" maxlength="10">
      <select name="Valid_Unit" id="Valid_Unit" <%if tmpDays>0 then response.write " disabled"%>>
        <option value="1" <%if rsUser(db_User_Valid_Unit)=1 then response.write " selected"%>>��</option>
        <option value="2" <%if rsUser(db_User_Valid_Unit)=2 then response.write " selected"%>>��</option>
        <option value="3" <%if rsUser(db_User_Valid_Unit)=3 then response.write " selected"%>>��</option>
      </select>
	  </td>
	</tr>
	<%end if%>
    <TR class="tdbg" > 
      <TD height="40" colspan="2" align="center"><input name="Action" type="hidden" id="Action" value="SaveAddMoney"> 
        <input name=Submit   type=submit id="Submit" value="�������ѽ��"> <input name="UserID" type="hidden" id="UserID" value="<%=rsUser(db_User_ID)%>"></TD>
    </TR>
  </TABLE>
</form>
<%
	rsUser.close
	set rsUser=nothing
end sub

sub UpdateUser()
%>
<FORM name="Form1" action="Admin_User.asp" method="post">
<table width="100%" border="0" cellspacing="1" cellpadding="2" class="border">
  <tr align="center" class="title"> 
    <td height="22" colspan="2"><strong>�� �� �� �� �� ��</strong></td>
  </tr>
  <tr class="tdbg"> 
      <td colspan="2"><p>˵����<br>
          1�������������¼����û��ķ�����������<br>
          2�����������ܽ��ǳ����ķ�������Դ�����Ҹ���ʱ��ܳ�������ϸȷ��ÿһ��������ִ�С�</p>
      </td>
  </tr>
  <tr class="tdbg"> 
    <td height="25">��ʼ�û�ID��</td>
    <td height="25"><input name="BeginID" type="text" id="BeginID" value="1" size="15" maxlength="10">
      �û�ID��������д�������һ��ID�ſ�ʼ�����޸�</td>
  </tr>
  <tr class="tdbg"> 
    <td height="25">�����û�ID��</td>
    <td height="25"><input name="EndID" type="text" id="EndID" value="1000" size="15" maxlength="10">
      �����¿�ʼ������ID֮����û����ݣ�֮�����ֵ��ò�Ҫѡ�����</td>
  </tr>
  <tr class="tdbg"> 
    <td height="25">&nbsp;</td>
    <td height="25"><input name="Submit" type="submit" id="Submit" value="�����û�����"> <input name="Action" type="hidden" id="Action" value="DoUpdate"></td>
  </tr>
</table>
</form>
<%
end sub
%>
</body>
</html>
<%
sub SaveAdd()
	dim UserName,Password,PwdConfirm,Question,Answer,Sex,Email,Homepage,OICQ,MSN,UserLevel,LockUser,ChargeType,UserPoint,BeginDate,Valid_Num,Valid_Unit
	UserName=trim(request("UserName"))
	Password=trim(request("Password"))
	PwdConfirm=trim(request("PwdConfirm"))
	Question=trim(request("Question"))
	Answer=trim(request("Answer"))
	Sex=trim(Request("Sex"))
	Email=trim(request("Email"))
	Homepage=trim(request("Homepage"))
	OICQ=trim(request("OICQ"))
	MSN=trim(request("MSN"))
	UserLevel=trim(request("UserLevel"))
	LockUser=trim(request("LockUser"))
	ChargeType=trim(request("ChargeType"))
	UserPoint=trim(request("UserPoint"))
	BeginDate=trim(request("BeginDate"))
	Valid_Num=trim(request("Valid_Num"))
	Valid_Unit=trim(request("Valid_Unit"))
	
	if UserName="" or strLength(UserName)>14 or strLength(UserName)<4 then
		founderr=true
		errmsg=errmsg & "<br><li>�������û���(���ܴ���14С��4)</li>"
	else
  		if Instr(UserName,"=")>0 or Instr(UserName,"%")>0 or Instr(UserName,chr(32))>0 or Instr(UserName,"?")>0 or Instr(UserName,"&")>0 or Instr(UserName,";")>0 or Instr(UserName,",")>0 or Instr(UserName,"'")>0 or Instr(UserName,",")>0 or Instr(UserName,chr(34))>0 or Instr(UserName,chr(9))>0 or Instr(UserName,"��")>0 or Instr(UserName,"$")>0 then
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
		errmsg=errmsg & "<br><li>������ȷ������(���ܴ���12С��6)</li>"
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
	if OICQ<>"" then
		if not isnumeric(OICQ) or len(cstr(OICQ))>10 then
			errmsg=errmsg & "<br><li>OICQ����ֻ����4-10λ���֣�������ѡ�����롣</li>"
			founderr=true
		end if
	end if
	
	if UserLevel="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>��ָ���û�����</li>"
	else
		UserLevel=CLng(UserLevel)
	end if
	if LockUser="True" then
		LockUser=True
	else
		LockUser=False
	end if
	if ChargeType="" then
		ChargeType=1
	else
		ChargeType=Clng(ChargeType)
	end if
	if UserPoint="" then
		UserPoint=0
	else
		UserPoint=Clng(UserPoint)
	end if
	if BeginDate="" then
		BeginDate=now()
	else
		BeginDate=Cdate(BeginDate)
	end if
	if Valid_Num="" then
		Valid_Num=0
	else
		Valid_Num=Clng(Valid_Num)
	end if
	if Valid_Unit="" then
		Valid_Unit=1
	else
		Valid_Unit=Clng(Valid_Unit)
	end if
	if (UserLevel=99 or UserLevel=9) then
		if ChargeType=1 and UserPoint=0 then
			FoundErr=True
			ErrMsg=ErrMsg & "<br><li>�������û�������</li>"
		end if
		if ChargeType=2 and Valid_Num=0 then
			FoundErr=True
			ErrMsg=ErrMsg & "<br><li>��������Ч����</li>"
		end if
	end if

	if founderr=true then
		exit sub
	end if
	
	dim sqlReg,rsReg
	sqlReg="select * from " & db_User_Table & " where " & db_User_Name & "='" & Username & "'"
	set rsReg=server.createobject("adodb.recordset")
	rsReg.open sqlReg,Conn_User,1,3
	if not(rsReg.bof and rsReg.eof) then
		founderr=true
		errmsg=errmsg & "<br><li>��ע����û��Ѿ����ڣ��뻻һ���û��������ԣ�</li>"
	else
		rsReg.addnew
		rsReg(db_User_Name)=UserName
		rsReg(db_User_Password)=md5(Password)
		rsReg(db_User_Question)=Question
		rsReg(db_User_Answer)=md5(Answer)
		rsReg(db_User_Sex)=Sex
		rsReg(db_User_Email)=Email
		rsReg(db_User_Homepage)=Homepage
		rsReg(db_User_QQ)=OICQ
		rsReg(db_User_Msn)=MSN
		rsReg(db_User_UserLevel)=UserLevel
		rsReg(db_User_LockUser)=LockUser
		rsReg(db_User_RegDate)=Now()
		rsReg(db_User_ChargeType)=ChargeType
		rsReg(db_User_UserPoint)=UserPoint
		rsReg(db_User_BeginDate)=BeginDate
		rsReg(db_User_Valid_Num)=Valid_Num
		rsReg(db_User_Valid_Unit)=Valid_Unit

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
		call UpdateUserNum(UserName)

		founderr=false
	end if
	rsReg.close
	set rsReg=nothing
	call CloseConn_User()
	response.Redirect "Admin_User.asp"
end sub		

sub SaveModify()
	dim UserID,Password,PwdConfirm,Question,Answer,Sex,Email,Homepage,OICQ,MSN,UserLevel,LockUser,ChargeType,UserPoint,BeginDate,Valid_Num,Valid_Unit
	dim rsUser,sqlUser
	Action=trim(request("Action"))
	UserID=trim(request("UserID"))
	if UserID="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>�������㣡</li>"
		exit sub
	else
		UserID=Clng(UserID)
	end if
	Password=trim(request("Password"))
	PwdConfirm=trim(request("PwdConfirm"))
	Question=trim(request("Question"))
	Answer=trim(request("Answer"))
	Sex=trim(Request("Sex"))
	Email=trim(request("Email"))
	Homepage=trim(request("Homepage"))
	OICQ=trim(request("OICQ"))
	MSN=trim(request("MSN"))
	UserLevel=trim(request("UserLevel"))
	LockUser=trim(request("LockUser"))
	ChargeType=trim(request("ChargeType"))
	UserPoint=trim(request("UserPoint"))
	BeginDate=trim(request("BeginDate"))
	Valid_Num=trim(request("Valid_Num"))
	Valid_Unit=trim(request("Valid_Unit"))

	if Password<>"" then
		if strLength(Password)>12 or strLength(Password)<6 then
			founderr=true
			errmsg=errmsg & "<br><li>���벻�ܴ���12С��6������㲻���޸����룬�뱣��Ϊ�ա�</li>"
		end if
		if Instr(Password,"=")>0 or Instr(Password,"%")>0 or Instr(Password,chr(32))>0 or Instr(Password,"?")>0 or Instr(Password,"&")>0 or Instr(Password,";")>0 or Instr(Password,",")>0 or Instr(Password,"'")>0 or Instr(Password,",")>0 or Instr(Password,chr(34))>0 or Instr(Password,chr(9))>0 or Instr(Password,"��")>0 or Instr(Password,"$")>0 then
			errmsg=errmsg+"<br><li>�����к��зǷ��ַ�������㲻���޸����룬�뱣��Ϊ�ա�</li>"
			founderr=true
		end if
	end if
	if Password<>PwdConfirm then
		founderr=true
		errmsg=errmsg & "<br><li>�����ȷ�����벻һ��</li>"
	end if
	if Question="" then
		founderr=true
		errmsg=errmsg & "<br><li>������ʾ���ⲻ��Ϊ��</li>"
	end if
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
	if OICQ<>"" then
		if not isnumeric(OICQ) or len(cstr(OICQ))>10 then
			errmsg=errmsg & "<br><li>OICQ����ֻ����4-10λ���֣�������ѡ�����롣</li>"
			founderr=true
		end if
	end if
	
	if UserLevel="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>��ָ���û�����</li>"
	else
		UserLevel=CLng(UserLevel)
	end if
	if LockUser="True" then
		LockUser=True
	else
		LockUser=False
	end if
	if ChargeType="" then
		ChargeType=1
	else
		ChargeType=Clng(ChargeType)
	end if
	if UserPoint="" then
		UserPoint=0
	else
		UserPoint=Clng(UserPoint)
	end if
	if BeginDate="" then
		BeginDate=now()
	else
		BeginDate=Cdate(BeginDate)
	end if
	if Valid_Num="" then
		Valid_Num=0
	else
		Valid_Num=Clng(Valid_Num)
	end if
	if Valid_Unit="" then
		Valid_Unit=1
	else
		Valid_Unit=Clng(Valid_Unit)
	end if
	if (UserLevel=99 or UserLevel=9) then
		if ChargeType=1 and UserPoint=0 then
			FoundErr=True
			ErrMsg=ErrMsg & "<br><li>�������û�������</li>"
		end if
		if ChargeType=2 and Valid_Num=0 then
			FoundErr=True
			ErrMsg=ErrMsg & "<br><li>��������Ч����</li>"
		end if
	end if

	if founderr=true then
		exit sub
	end if
	
	Set rsUser=Server.CreateObject("Adodb.RecordSet")
	sqlUser="select * from " & db_User_Table & " where " & db_User_ID & "=" & UserID
	rsUser.Open sqlUser,Conn_User,1,3
	if rsUser.bof and rsUser.eof then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>�Ҳ���ָ�����û���</li>"
		rsUser.close
		set rsUser=nothing
		exit sub
	end if
	if Password<>"" then
		rsUser(db_User_Password)=md5(Password)
	end if
	rsUser(db_User_Question)=Question
	if Answer<>"" then
		rsUser(db_User_Answer)=md5(Answer)
	end if
	rsUser(db_User_Sex)=Sex
	rsUser(db_User_Email)=Email
	rsUser(db_User_Homepage)=HomePage
	rsUser(db_User_QQ)=OICQ
	rsUser(db_User_Msn)=MSN
	rsUser(db_User_UserLevel)=UserLevel
	rsUser(db_User_LockUser)=LockUser
	rsUser(db_User_ChargeType)=ChargeType
	rsUser(db_User_UserPoint)=UserPoint
	rsUser(db_User_BeginDate)=BeginDate
	rsUser(db_User_Valid_Num)=Valid_Num
	rsUser(db_User_Valid_Unit)=Valid_Unit
	rsUser.update
	rsUser.Close
	set rsUser=nothing
	call CloseConn_User()
	response.redirect "Admin_User.asp"
end sub

sub SaveAddMoney()
	dim UserID,ChargeType,UserPoint,Valid_Num,Valid_Unit
	dim rsUser,sqlUser
	Action=trim(request("Action"))
	UserID=trim(request("UserID"))
	if UserID="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>�������㣡</li>"
		exit sub
	else
		UserID=Clng(UserID)
	end if
	ChargeType=trim(request("ChargeType"))
	UserPoint=trim(request("UserPoint"))
	Valid_Num=trim(request("Valid_Num"))
	Valid_Unit=trim(request("Valid_Unit"))

	if ChargeType="" then
		ChargeType=1
	else
		ChargeType=Clng(ChargeType)
	end if
	if UserPoint="" then
		UserPoint=0
	else
		UserPoint=Clng(UserPoint)
	end if
	if Valid_Num="" then
		Valid_Num=0
	else
		Valid_Num=Clng(Valid_Num)
	end if
		if Valid_Unit="" then
		Valid_Unit=1
	else
		Valid_Unit=Clng(Valid_Unit)
	end if
	
	if ChargeType=1 and UserPoint=0 then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>������Ҫ׷�ӵ��û�������</li>"
	end if
	if ChargeType=2 and Valid_Num=0 then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>������Ҫ׷�ӵ�����</li>"
	end if

	if founderr=true then
		exit sub
	end if
	
	Set rsUser=Server.CreateObject("Adodb.RecordSet")
	sqlUser="select * from " & db_User_Table & " where " & db_User_ID & "=" & UserID
	rsUser.Open sqlUser,Conn_User,1,3
	if rsUser.bof and rsUser.eof then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>�Ҳ���ָ�����û���</li>"
		rsUser.close
		set rsUser=nothing
		exit sub
	end if
	if ChargeType=1 then
		rsUser(db_User_UserPoint)=rsUser(db_User_UserPoint)+UserPoint
	else
		if rsUser(db_User_Valid_Unit)=1 then
			ValidDays=rsUser(db_User_Valid_Num)
		elseif rsUser(db_User_Valid_Unit)=2 then
			ValidDays=rsUser(db_User_Valid_Num)*30
		elseif rsUser(db_User_Valid_Unit)=3 then
			ValidDays=rsUser(db_User_Valid_Num)*365
		end if
		tmpDays=ValidDays-DateDiff("D",rsUser(db_User_BeginDate),now())
		if tmpDays>0 then
			rsUser(db_User_Valid_Num)=rsUser(db_User_Valid_Num)+Valid_Num
		else
			rsUser(db_User_BeginDate)=now()
			rsUser(db_User_Valid_Num)=Valid_Num
			rsUser(db_User_Valid_Unit)=Valid_Unit
		end if
	end if
	rsUser.update
	rsUser.Close
	set rsUser=nothing
	call CloseConn_User()
	response.redirect "Admin_User.asp"
end sub

sub DelUser()
	if UserID="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>��ָ��Ҫɾ�����û�</li>"
		exit sub
	end if
	if instr(UserID,",")>0 then
		UserID=replace(UserID," ","")
		sql="delete from " & db_User_Table & " where " & db_User_ID & " in (" & UserID & ")"
	else
		sql="delete from " & db_User_Table & " where " & db_User_ID & "=" & Clng(UserID)
	end if
	Conn_User.Execute sql
	call CloseConn_User()      
	response.redirect ComeUrl
end sub

sub LockUser()
	if UserID="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>��ѡ��Ҫ�������û�</li>"
		exit sub
	end if
	if instr(UserID,",")>0 then
		UserID=replace(UserID," ","")
		sql="Update " & db_User_Table & " set " & db_User_LockUser & "=true where " & db_User_ID & " in (" & UserID & ")"
	else
		sql="Update " & db_User_Table & " set " & db_User_LockUser & "=true where " & db_User_ID & "=" & CLng(UserID)
	end if
	Conn_User.Execute sql
	call CloseConn_User()      
	response.redirect ComeUrl
end sub

sub UnLockUser()
	if UserID="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>��ָ��Ҫ�������û�</li>"
		exit sub
	end if
	if instr(UserID,",")>0 then
		UserID=replace(UserID," ","")
		sql="Update " & db_User_Table & " set " & db_User_LockUser & "=False where " & db_User_ID & " in (" & UserID & ")"
	else
		sql="Update " & db_User_Table & " set " & db_User_LockUser & "=False where " & db_User_ID & "=" & CLng(UserID)
	end if
	Conn_User.Execute sql
	call CloseConn_User()      
	response.redirect ComeUrl
end sub

sub MoveUser()
	dim msg
	if UserID="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>��ָ��Ҫ�ƶ����û�</li>"
		exit sub
	end if
	dim UserLevel
	UserLevel=trim(request("UserLevel"))
	if UserLevel="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>��ָ��Ŀ���û���</li>"
		exit sub
	else
		UserLevel=Clng(UserLevel)
	end if
	if instr(UserID,",")>0 then
		UserID=replace(UserID," ","")
		if UserLevel=999 then
			msg="&nbsp;&nbsp;&nbsp;&nbsp;�Ѿ��ɹ���ѡ���û���Ϊ��<font color=blue>��ͨע���û�</font>�������Ұ�������[��վѡ��---�û�ѡ��]�е�Ԥ��ֵ���趨����Щ�û��ļƷѷ�ʽ����ʼ��������Ч�ڵ����ݡ�"
			msg=msg & "<br><br>�Ʒѷ�ʽ��"
			if ChargeType_999=1 then
				msg=msg & "�۵���<br>��ʼ������" & UserPoint_999 & "��"
			else
				msg=msg & "��Ч��<br>��ʼ���ڣ�" & formatdatetime(now(),2) & "<br>�� Ч �ڣ�" & ValidDays_999 & "��"
			end if
			sql="Update " & db_User_Table & " set " & db_User_UserLevel & "=" & UserLevel & "," & db_User_ChargeType & "=" & ChargeType_999 & "," & db_User_UserPoint & "=" & UserPoint_999 & "," & db_User_BeginDate & "=#" & formatdatetime(now(),2) & "#," & db_User_Valid_Num & "=" & ValidDays_999 & "," & db_User_Valid_Unit & "=1 where " & db_User_ID & " in (" & UserID & ")"
		elseif UserLevel=99 then
			msg="&nbsp;&nbsp;&nbsp;&nbsp;�Ѿ��ɹ���ѡ���û���Ϊ��<font color=blue>�շ��û�</font>�������Ұ�������[��վѡ��---�û�ѡ��]�е�Ԥ��ֵ���趨����Щ�û��ļƷѷ�ʽ����ʼ��������Ч�ڵ����ݡ�"
			msg=msg & "<br><br>�Ʒѷ�ʽ��"
			if ChargeType_99=1 then
				msg=msg & "�۵���<br>��ʼ������" & UserPoint_99 & "��"
			else
				msg=msg & "��Ч��<br>��ʼ���ڣ�" & formatdatetime(now(),2) & "<br>�� Ч �ڣ�" & ValidDays_99 & "��"
			end if
			sql="Update " & db_User_Table & " set " & db_User_UserLevel & "=" & UserLevel & "," & db_User_ChargeType & "=" & ChargeType_99 & "," & db_User_UserPoint & "=" & UserPoint_99 & "," & db_User_BeginDate & "=#" & formatdatetime(now(),2) & "#," & db_User_Valid_Num & "=" & ValidDays_99 & "," & db_User_Valid_Unit & "=1 where " & db_User_ID & " in (" & UserID & ")"
		elseif UserLevel=9 then
			msg="&nbsp;&nbsp;&nbsp;&nbsp;�Ѿ��ɹ���ѡ���û���Ϊ��<font color=blue>VIP�û�</font>�������Ұ�������[��վѡ��---�û�ѡ��]�е�Ԥ��ֵ���趨����Щ�û��ļƷѷ�ʽ����ʼ��������Ч�ڵ����ݡ�"
			msg=msg & "<br><br>�Ʒѷ�ʽ��"
			if ChargeType_9=1 then
				msg=msg & "�۵���<br>��ʼ������" & UserPoint_9 & "��"
			else
				msg=msg & "��Ч��<br>��ʼ���ڣ�" & formatdatetime(now(),2) & "<br>�� Ч �ڣ�" & ValidDays_9 & "��"
			end if
			sql="Update " & db_User_Table & " set " & db_User_UserLevel & "=" & UserLevel & "," & db_User_ChargeType & "=" & ChargeType_9 & "," & db_User_UserPoint & "=" & UserPoint_9 & "," & db_User_BeginDate & "=#" & formatdatetime(now(),2) & "#," & db_User_Valid_Num & "=" & ValidDays_9 & "," & db_User_Valid_Unit & "=1 where " & db_User_ID & " in (" & UserID & ")"
		end if
	else
		if UserLevel=999 then
			msg="&nbsp;&nbsp;&nbsp;&nbsp;�Ѿ��ɹ���ѡ���û���Ϊ��<font color=blue>��ͨע���û�</font>�������Ұ�������[��վѡ��---�û�ѡ��]�е�Ԥ��ֵ���趨����Щ�û��ļƷѷ�ʽ����ʼ��������Ч�ڵ����ݡ�"
			msg=msg & "<br><br>�Ʒѷ�ʽ��"
			if ChargeType_999=1 then
				msg=msg & "�۵���<br>��ʼ������" & UserPoint_999 & "��"
			else
				msg=msg & "��Ч��<br>��ʼ���ڣ�" & formatdatetime(now(),2) & "<br>�� Ч �ڣ�" & ValidDays_999 & "��"
			end if
			sql="Update " & db_User_Table & " set " & db_User_UserLevel & "=" & UserLevel & "," & db_User_ChargeType & "=" & ChargeType_999 & "," & db_User_UserPoint & "=" & UserPoint_999 & "," & db_User_BeginDate & "=#" & formatdatetime(now(),2) & "#," & db_User_Valid_Num & "=" & ValidDays_999 & "," & db_User_Valid_Unit & "=1 where " & db_User_ID & "=" & CLng(UserID)
		elseif UserLevel=99 then
			msg="&nbsp;&nbsp;&nbsp;&nbsp;�Ѿ��ɹ���ѡ���û���Ϊ��<font color=blue>�շ��û�</font>�������Ұ�������[��վѡ��---�û�ѡ��]�е�Ԥ��ֵ���趨����Щ�û��ļƷѷ�ʽ����ʼ��������Ч�ڵ����ݡ�"
			msg=msg & "<br><br>�Ʒѷ�ʽ��"
			if ChargeType_99=1 then
				msg=msg & "�۵���<br>��ʼ������" & UserPoint_99 & "��"
			else
				msg=msg & "��Ч��<br>��ʼ���ڣ�" & formatdatetime(now(),2) & "<br>�� Ч �ڣ�" & ValidDays_99 & "��"
			end if
			sql="Update " & db_User_Table & " set " & db_User_UserLevel & "=" & UserLevel & "," & db_User_ChargeType & "=" & ChargeType_99 & "," & db_User_UserPoint & "=" & UserPoint_99 & "," & db_User_BeginDate & "=#" & formatdatetime(now(),2) & "#," & db_User_Valid_Num & "=" & ValidDays_99 & "," & db_User_Valid_Unit & "=1 where " & db_User_ID & "=" & CLng(UserID)
		elseif UserLevel=9 then
			msg="&nbsp;&nbsp;&nbsp;&nbsp;�Ѿ��ɹ���ѡ���û���Ϊ��<font color=blue>VIP�û�</font>�������Ұ�������[��վѡ��---�û�ѡ��]�е�Ԥ��ֵ���趨����Щ�û��ļƷѷ�ʽ����ʼ��������Ч�ڵ����ݡ�"
			msg=msg & "<br><br>�Ʒѷ�ʽ��"
			if ChargeType_9=1 then
				msg=msg & "�۵���<br>��ʼ������" & UserPoint_9 & "��"
			else
				msg=msg & "��Ч��<br>��ʼ���ڣ�" & formatdatetime(now(),2) & "<br>�� Ч �ڣ�" & ValidDays_9 & "��"
			end if
			sql="Update " & db_User_Table & " set " & db_User_UserLevel & "=" & UserLevel & "," & db_User_ChargeType & "=" & ChargeType_9 & "," & db_User_UserPoint & "=" & UserPoint_9 & "," & db_User_BeginDate & "=#" & formatdatetime(now(),2) & "#," & db_User_Valid_Num & "=" & ValidDays_9 & "," & db_User_Valid_Unit & "=1 where " & db_User_ID & "=" & CLng(UserID)
		end if
	end if
	Conn_User.Execute sql
	
	call WriteSuccessMsg(msg)
end sub

sub DoUpdate()
	dim BeginID,EndID,sqlUser,rsUser,trs
	BeginID=trim(request("BeginID"))
	EndID=trim(request("EndID"))
	if BeginID="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>��ָ����ʼID</li>"
	else
		BeginID=Clng(BeginID)
	end if
	if EndID="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>��ָ������ID</li>"
	else
		EndID=Clng(EndID)
	end if
	
	if FoundErr=True then exit sub
	
	Set rsUser=Server.CreateObject("Adodb.RecordSet")
	sqlUser="select * from " & db_User_Table & " where " & db_User_ID & ">=" & BeginID & " and " & db_User_ID & "<=" & EndID
	rsUser.Open sqlUser,Conn_User,1,3
	do while not rsUser.eof
		set trs=Conn.execute("select count(ArticleID) from Article where Editor='" & rsUser(db_User_Name) & "'")
		if isNull(trs(0)) then
			rsUser(db_User_ArticleCount)=0
		else
			rsUser(db_User_ArticleCount)=trs(0)
		end if
		set trs=Conn.execute("select count(ArticleID) from Article where Passed=True and Editor='" & rsUser(db_User_Name) & "'")
		if isNull(trs(0)) then
			rsUser(db_User_ArticleChecked)=0
		else
			rsUser(db_User_ArticleChecked)=trs(0)
		end if
		rsUser.update
		rsUser.movenext
	loop
	rsUser.close
	set rsUser=nothing
	call WriteSuccessMsg("�Ѿ��ɹ����û����ݽ����˸��£�")
end sub
%>