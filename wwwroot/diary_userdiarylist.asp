<!--#include file="inc/syscode_diary.asp"-->
<%
Const PurviewLevel=2
Const CheckChannelID=0
Const PurviewLevel_Others="User"
%>
<!--#include file="Admin_ChkPurview.asp"-->
<%
set rs=server.createobject("adodb.recordset")
strFileName="diary_index.asp?DiaryOwner="&DiaryOwner
dim act,diaryID,nosecret
act=request("act")
diaryID=request("diaryID")
select case act
	case "delall1"
		sql="SELECT count(id) from diary where diaryOwner='"&DiaryOwner&"' and secret<=9"
		rs.open sql,conn_User,1,1
		i=rs(0)
		rs.close
		sqlUser="update [User] set diaryNum=diaryNum-"&i&" WHERE Username='"&DiaryOwner&"'"
		conn_user.execute(sqlUser)
		sqluser="delete from diary where diaryOwner='"&DiaryOwner&"' and secret<=9"
		conn_user.execute(sqlUser)

	case "delall2"
		sqlUser="update [User] set diaryNum=0 WHERE Username='"&DiaryOwner&"'"
		conn_user.execute(sqlUser)
		sqluser="delete from diary where diaryOwner='"&DiaryOwner&"'"
		conn_user.execute(sqlUser)
	case "del"
		sqlUser="update [User] set diaryNum=diaryNum-1 WHERE Username='"&DiaryOwner&"'"
		conn_user.execute(sqlUser)
		sqluser="delete from diary where diaryOwner='"&DiaryOwner&"' and id="&diaryID
		conn_user.execute(sqlUser)
	case "secret"
		sqluser="update diary set secret=999 where diaryOwner='"&DiaryOwner&"' and id="&diaryID
		conn_user.execute(sqlUser)
end select
sql="SELECT * from diary where diaryOwner='"&DiaryOwner&"' order by diaryDate desc"
rs.open sql,conn_User,1,1
if rs.eof then
	founderr=true
	errmsg="<br><br><li>���û�û���κ��ռ�</li>"
end if
%>
<html>
<head>
<title>�û������ռǹ���</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="Admin_Style.css" rel="stylesheet" type="text/css">
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
          <option value="0">�г������û�</option>
          <option value="1">�������TOP100</option>
          <option value="2">�������ٵ�100���û�</option>
          <option value="3">���24Сʱ�ڵ�¼���û�</option>
          <option value="4">���24Сʱ��ע����û�</option>
          <option value="5">�ȴ��ʼ���֤���û�</option>
          <option value="6">�ȴ�����Ա��֤���û�</option>
          <option value="7">���б���ס���û�</option>
          <option value="8">�����շ��û�</option>
          <option value="9">����VIP�û�</option>
        </select>
        &nbsp;&nbsp;&nbsp;&nbsp;<a href="Admin_User.asp">�û�������ҳ</a>&nbsp;|&nbsp;<a href="Admin_User.asp?Action=Add">������û�</a></td>
    </tr>
  </form>
</table>
<br>
<table width="100%" border="0" cellspacing="1" cellpadding="2" class="border">
  <tr align="center" class="title">
    <td height="22"><strong>��&nbsp;��&nbsp;��&nbsp;��&nbsp;��&nbsp;��&nbsp;��&nbsp;��</strong></td>
  </tr>
  <tr class="tdbg">
    <td align="center">
        <%
		if founderr=true then
			call writeerrmsg()
			response.write("<br>&nbsp;")
		else
		%>
      <table width="50%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="5"></td>
        </tr>
      </table>
      <table border="0" width="80%" cellspacing="0" cellpadding="0">
        <tr>
          <td nowrap><img border="0" src="diary_images/08.GIF" width="11" height="10"><b>
            <%response.write(rs("diaryOwner")&"�Ĺ����ռ�")%>
            </b> &nbsp;&nbsp;&nbsp;&nbsp;[<a href=diary_userdiarylist.asp?diaryOwner=<%=diaryOwner%>&act=delall1 onclick='return confirm("��ȷ��Ҫɾ�����û���ȫ�������ռ���")'><font color=red>ɾ�������ռ�</font></a>]
            &nbsp;&nbsp;&nbsp;&nbsp;[<a href=diary_userdiarylist.asp?diaryOwner=<%=diaryOwner%>&act=delall2 onclick='return confirm("��ȷ��Ҫɾ�����û��������ռ���")'><font color=red>ɾ��ȫ���ռ�</font></a>]
          </td>
          <td align="right" nowrap>&nbsp;
          </td>
        </tr>
      </table>
			<%if rs.eof and rs.bof then
				response.write "<p>��û��һ���ռ��أ�</p>"
				totalput=0
			else
				totalput=rs.recordcount
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
					call ShowDiary()
				else
					if (currentPage-1)*MaxPerPage<totalPut then
						rs.move  (currentPage-1)*MaxPerPage
						dim bookmark
						bookmark=rs.bookmark
						call ShowDiary()
					else
						currentPage=1
						call ShowDiary()
					end if
				end if
			end if

			response.write ("<br>���û�����<font color=red>&nbsp;"&totalput&"&nbsp;</font>�򣬹����ռ�<font color=red>&nbsp;"&nosecret&"&nbsp;</font>�򣬱����ռ�<font color=red>&nbsp;"&totalput-nosecret&"&nbsp;</font>��")

			if nosecret>MaxPerPage then
				call showpage(strFileName,totalput,MaxPerPage,false,false," ���ռ�")
			end if

			rs.close
			set rs=nothing
	end if%>
      <table width="420" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td background="diary_images/t-h_p-s.gif"><img src="diary_images/t-h_p-s.gif" width="26" height="12"></td>
        </tr>
      </table></td>
  </tr>
</table>
</body>
</html>
<%
sub ShowDiary()
	nosecret=0
	do while not rs.eof
		if rs("secret")<=9 then
			nosecret=nosecret+1%>
			<table width="90%" border="0" cellspacing="2" cellpadding="2">
			<tr>
			  <td><img src="diary_images/dia-b-icon.gif" width="21" height="21"><b>
			  <%response.write(FormatDateTime(rs("diaryDate"), 1))%>
				&nbsp;&nbsp;&nbsp;&nbsp;<%=rs("weather")%>&nbsp;&nbsp;&nbsp;&nbsp;<img src='diary_images/<%=rs("mood")%>'>
				</b>
				&nbsp;&nbsp;&nbsp;&nbsp;<a href=diary_userdiarylist.asp?diaryOwner=<%=diaryOwner%>&diaryID=<%=rs("ID")%>&act=del onclick='return confirm("��ȷ��Ҫɾ�������ռ���")'>ɾ��</a>&nbsp;|&nbsp;<a href=diary_userdiarylist.asp?diaryOwner=<%=diaryOwner%>&diaryID=<%=rs("ID")%>&act=secret onclick='return confirm("��ȷ��Ҫ�ѱ����ռ���Ϊ������")'>����</a>
				</td>
			</tr>
			<tr>
			  <td><img src=diary_images/icon.gif height=8 width=24 border=0 hspace=0>
				<%=rs("diaryContent")%>
			  </td>
			</tr>
			</table>
			<table width="90%" border="0" cellspacing="0" cellpadding="0">
			<tr>
			  <td background="diary_images/t-h_p-s.gif"><img src="diary_images/t-h_p-s.gif"></td>
			</tr>
			</table>
			<%
		end if
		rs.movenext
		i=i+1
		if i>=MaxPerPage then exit do
	loop
end sub
%>