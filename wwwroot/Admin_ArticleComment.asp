<%@language=vbscript codepage=936 %>
<%
option explicit
response.buffer=true	
Const PurviewLevel=2
Const CheckChannelID=2
Const PurviewLevel_Article=1
%>
<!--#include file="inc/conn.asp"-->
<!--#include file="inc/config.asp"-->
<!--#include file="Admin_ChkPurview.asp"-->
<!--#include file="inc/Conn_User.asp"-->
<!--#include file="inc/function.asp"-->
<!--#include file="inc/ubbcode.asp"-->
<%
dim strFileName
strFileName="Admin_ArticleComment.asp"
const MaxPerPage=20
dim totalPut,CurrentPage,TotalPages,i,j
dim SearchContent
dim Action,FoundErr,Errmsg
Action=Trim(request("Action"))
SearchContent=Trim(request("SearchContent"))
if request("page")<>"" then
    currentPage=cint(request("page"))
else
	currentPage=1
end if
dim sql,rs
%>
<html>
<head>
<title>�������۹���</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta name="GENERATOR" content="Microsoft FrontPage 3.0">
<link rel="stylesheet" type="text/css" href="Admin_Style.css">
<SCRIPT language=javascript>
function unselectall()
{
    if(document.del.chkAll.checked){
	document.del.chkAll.checked = document.del.chkAll.checked&0;
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
function ConfirmDel()
{
   if(confirm("ȷ��Ҫɾ��ѡ�е�������һ��ɾ�������ָܻ���"))
     return true;
   else
     return false;
	 
}

</SCRIPT>
</head>
<body leftmargin="2" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" Class="border">
  <tr class="topbg"> 
    <td height="22" colspan=2 align=center><b>�� �� �� �� �� ��</b></td>
  </tr>
  <tr class="tdbg"> 
    <td width="70" height="30"><strong>��������</strong></td>
    <td height="30">
      <table width="100%"><tr>
	  <form name="searchArticle" method="get" action="Admin_ArticleComment.asp">
            <td> 
              <input name="SearchContent" type="text" class=smallInput id="SearchContent" size="28">
				<input name="Query" type="submit" id="Query" value="�� ѯ">
              &nbsp;&nbsp;�������ѯ�����ݡ����Ϊ�գ�������������ۡ�</td>
          </form></tr></table>
	</td>
  </tr>
</table>
<%
if Action="Modify" then
	call Modify()
elseif Action="SaveModify" then
	call SaveModify()
elseif Action="Del" then
	call DelComment()
elseif Action="Del2" then
	call DelComment2()
elseif Action="Reply" then
	call Reply()
elseif Action="SaveReply" then
	call SaveReply()
else
	call main()
end if
if FoundErr=True then
	call WriteErrMsg()
end if
call CloseConn()

sub main()
	sql="select A.ArticleID, A.ClassID, A.Title as ArticleTitle, A.IncludePic, C.CommentID,C.UserName,C.IP, C.Content,C.WriteTime,C.ReplyName,C.ReplyContent,C.ReplyTime,C.Email,C.Oicq,C.Homepage,C.Icq,C.Msn,C.UserType,C.Score from ArticleComment C Left Join Article A On C.ArticleID=A.ArticleID "
	if SearchContent<>"" then
		sql=sql & " where C.Content like '%" & SearchContent & "%' "
	end if
	sql=sql & " order by A.ArticleID desc"
	Set rs= Server.CreateObject("ADODB.Recordset")
	rs.open sql,conn,1,1
%>
<br>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
<form name="del" method="Post" action="Admin_ArticleComment.asp" onsubmit="return ConfirmDel();">
  <tr>
    <td align="center">
<table border="0" cellpadding="2" width="100%" cellspacing="0">
  <tr>
            <td>�����ڵ�λ�ã�<a href="Admin_ArticleComment.asp">���۹���</a>&nbsp;&gt;&gt;&nbsp; 
              <%
if request.querystring="" then
	response.write "��������"
else
	if SearchContent<>"" then
		response.write "���������к��С�<font color=blue>" & SearchContent & "</font>��������"
	else
		response.Write("��������")
	end if
end if
%>
	</td>
	<td width="150" align="right">
<%
  	if rs.eof and rs.bof then
		response.write "���ҵ� 0 ƪ����</td></tr></table>"
	else
    	totalPut=rs.recordcount
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
		response.Write "���ҵ� " & totalPut & " ƪ����"
%>
	</td>
  </tr>
</table>
<%		
	    if currentPage=1 then
        	showContent
        	showpage strFileName,totalput,MaxPerPage,true,false,"ƪ����"
   	 	else
   	     	if (currentPage-1)*MaxPerPage<totalPut then
         	   	rs.move  (currentPage-1)*MaxPerPage
         		dim bookmark
           		bookmark=rs.bookmark
            	showContent
            	showpage strFileName,totalput,MaxPerPage,true,false,"ƪ����"
        	else
	        	currentPage=1
           		showContent
           		showpage strFileName,totalput,MaxPerPage,true,false,"ƪ����"
	    	end if
		end if
	end if
%>
      </form>
	</td>
  </tr>
</table>
<%  
   	rs.close
   	set rs=nothing  
end sub

sub showContent
   	dim i,rsCommentUser
    i=0
	dim PrevID
	PrevID=rs("ArticleID")
	do while not rs.eof
		if rs("ArticleID")<>PrevID then response.write "</table></td></tr></table><br>"
		if i=0 or rs("ArticleID")<>PrevID then
%>
        <table class="border" width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr class="title"> 
            <td width="80%" height="22">| 
              <%
			if rs("IncludePic")=true then
			  	response.write "<font color=blue>[ͼ��]</font>"
			end if
			response.write "<a href='Admin_ArticleShow.asp?ArticleID=" & rs("ArticleID") & "'>" & rs("ArticleTitle") & "</a>"
			%></td>
            <td width="20%" align="right"><a href="Admin_ArticleComment.asp?ArticleID=<%=rs("ArticleID")%>&Action=Del2">ɾ���������µ���������</a></td>
          </tr>
          <tr> 
            <td colspan="2"> 
      <table border="0" cellspacing="1" width="100%" cellpadding="0" style="word-break:break-all">
        <%end if%>
        <tr class="tdbg" onmouseout="this.style.backgroundColor=''" onmouseover="this.style.backgroundColor='#BFDFFF'"> 
          <td width="30" align="center">
            <input name='CommentID' type='checkbox' onclick="unselectall()" id="CommentID" value='<%=cstr(rs("CommentID"))%>'>
          </td>
          <td><a href="#" Title="<%=left(rs("Content"),200)%>"><%=left(rs("Content"),25)%></a></td>
          <td width="70" align="center">���֣�<%=rs("Score")%></td>
          <td width="50" align="center"><%if rs("UserType")=1 then response.write "��Ա" else response.write "�ο�" end if%> </td>
          <td width="100" align="center"> 
            <%
			if rs("UserType")=1 then
				set rsCommentUser=Conn_User.execute("select " & db_User_ID & "," & db_User_Name & "," & db_User_Email & "," & db_User_QQ & "," & db_User_ICQ & "," & db_User_Msn & "," & db_User_Homepage & " from " & db_User_Table & " where " & db_User_Name & "='" & rs("UserName") & "'")
				if rsCommentUser.bof and rsCommentUser.eof then
					response.write rs("UserName")
				else
					response.write "<a href='UserInfo.asp?UserID=" & rsCommentUser(0) & "' title='������" & rsCommentUser(1) & vbcrlf & "���䣺" & rsCommentUser(2) & vbcrlf & "Oicq��" & rsCommentUser(3) & vbcrlf & " Icq��" &  rsCommentUser(4) & vbcrlf & " Msn��" &  rsCommentUser(5) & vbcrlf & " I P��" & rs("IP") & vbcrlf & "��ҳ��" &  rsCommentUser(6)&"' target='_blank'>" & rs("UserName") & "</a>"
				end if
			else
				response.write "<span title='������" & rs("UserName") & vbcrlf & "���䣺" & rs("Email") & vbcrlf & "Oicq��" & rs("Oicq") & vbcrlf & " Icq��" & rs("Icq") & vbcrlf & " Msn��" & rs("Msn") & vbcrlf & " I P��" & rs("IP") & vbcrlf & "��ҳ��" &  rs("Homepage")&"' style='cursor:hand'>" & rs("UserName") & "</span>"
			end if
		  %>
          </td>
          <td width="120" align="center"><%= rs("WriteTime") %></td>
          <td width="100" align="center">
            <%
		  if rs("ReplyName")<>"" then
		      response.write "&nbsp;&nbsp;&nbsp;&nbsp;"
		  else
			  response.write "<a href='Admin_ArticleComment.asp?Action=Reply&CommentID=" & rs("Commentid") & "'>�ظ�</a>&nbsp;&nbsp;"
		  end if
		  response.write "<a href='Admin_ArticleComment.asp?Action=Modify&CommentID=" & rs("Commentid") & "'>�޸�</a>&nbsp;&nbsp;" 
          response.write "<a href='Admin_ArticleComment.asp?Action=Del&CommentID=" & rs("CommentID") & "' onclick='return ConfirmDel();'>ɾ��</a>"
		  %>
          </td>
        </tr>
        <%if rs("ReplyName")<>"" then%>
        <tr class="tdbg" onmouseout="this.style.backgroundColor=''" onmouseover="this.style.backgroundColor='#BFDFFF'"> 
          <td align="center">&nbsp;</td>
          <td colspan="5">
            <%response.write "����Ա��" & rs("ReplyName") & "���� " & rs("ReplyTime") & " �ظ���<br><div style='padding:0px 20px'>" & rs("ReplyContent") & "</div>"%>
          </td>
          <td align="center"><a href="Admin_ArticleComment.asp?Action=Reply&CommentID=<%=rs("CommentID")%>">�޸Ļظ�����</a></td>
        </tr>
        <%
		end if
		i=i+1
	    if i>=MaxPerPage then exit do
	    PrevID=rs("ArticleID")
		rs.movenext
	loop
%>
      </table>
    </td>
          </tr>
        </table>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td width="250" height="30"><input name="chkAll" type="checkbox" id="chkAll" onclick=CheckAll(this.form) value="checkbox">
              ѡ�б�ҳ��ʾ���������� </td>
    <td><input name="submit" type='submit' value='ɾ��ѡ��������'>
              <input name="Action" type="hidden" id="Action" value="Del"></td>
  </tr>
</table>
<%
end sub 

sub Modify()
	dim CommentID
	CommentID=trim(Request("CommentID"))
	if CommentID="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>��ָ������ID</li>"
		Exit sub
	else
		CommentID=Clng(CommentID)
	end if
	sql="Select * from ArticleComment where CommentID=" & CommentID
	Set rs=Server.CreateObject("Adodb.RecordSet")
	rs.Open sql,conn,1,1
	if rs.Bof or rs.EOF then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>�Ҳ���ָ�������ۣ�</li>"
	else
	
%>
<form method="post" action="Admin_ArticleComment.asp" name="form1">
    
  <table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" class="border" >
    <tr align="center" class="title"> 
      <td height="22" colspan="4"> <strong>�� �� �� �� </strong>&nbsp;&nbsp; 
        <%if rs("UserType")=1 then response.write "����Աģʽ��" else response.write "���ο�ģʽ��" end if%>
      </td>
    </tr>
    <% if rs("UserType")=0 then%>
    <tr> 
      <td width="200" align="right" class="tdbg">������������</td>
      <td class="tdbg" width="200"> 
        <input name="UserName" type="text" id="UserName" maxlength="16" value="<%=rs("UserName")%>">
      </td>
      <td class="tdbg" align="right" width="101">������Oicq��</td>
      <td class="tdbg" width="475"> 
        <input name="Oicq" type="text" id="UserName" maxlength="15" value="<%=rs("Oicq")%>">
      </td>
    </tr>
    <tr> 
      <td width="200" align="right" class="tdbg">�������Ա�</td>
      <td class="tdbg" width="200"> 
        <input type="radio" name="Sex" value="1" checked style="BORDER:0px;">
        ��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        <input type="radio" name="Sex" value="0" style="BORDER:0px;">
        Ů </td>
      <td class="tdbg" align="right" width="101">������ Icq��</td>
      <td class="tdbg" width="475"> 
        <input name="Icq" type="text" id="UserName"  maxlength="15" value="<%=rs("Icq")%>">
      </td>
    </tr>
    <tr> 
      <td width="200" align="right" class="tdbg">������Email��</td>
      <td class="tdbg" width="200"> 
        <input name="Email" type="text" id="UserName" maxlength="40" value="<%=rs("Email")%>">
      </td>
      <td class="tdbg" align="right" width="101">������ Msn��</td>
      <td class="tdbg" width="475"> 
        <input name="Msn" type="text" id="UserName" maxlength="40" value="<%=rs("Msn")%>">
      </td>
    </tr>
    <tr> 
      <td width="200" align="right" class="tdbg">����ʱ�䣺</td>
      <td class="tdbg" width="200"> 
        <input name="WriteTime" type="text" id="WriteTime" value="<%=rs("WriteTime")%>">
      </td>
      <td class="tdbg" align="right" width="101">������IP��</td>
      <td class="tdbg" width="475"> 
        <input name="IP" type="text" id="IP"  maxlength="15" value="<%=rs("IP")%>">
      </td>
    </tr>
    <tr> 
      <td width="200" align="right" class="tdbg">��������ҳ��</td>
      <td class="tdbg" colspan="3"> 
        <input name="Homepage" type="text" id="UserName" maxlength="60" value="<%if rs("Homepage")="" then response.write "http://" else response.write rs("Homepage") end if%>" size="66">
      </td>
    </tr>
    <%else%>
    <tr> 
      <td width="200" align="right" class="tdbg">������������</td>
      <td class="tdbg" colspan="3">
        <input name="ShowUserName" type="text" id="UserName" value="<%=rs("UserName")%>" disabled>
        <input name="UserName" type="hidden" id="UserName" value="<%=rs("UserName")%>">
      </td>
    </tr>
    <tr> 
      <td width="200" align="right" class="tdbg">����ʱ�䣺</td>
      <td class="tdbg" width="200"> 
        <input name="WriteTime" type="text" id="WriteTime" value="<%=rs("WriteTime")%>">
      </td>
      <td class="tdbg" align="right" width="101">������IP��</td>
      <td class="tdbg" width="475"> 
        <input name="IP" type="text" id="IP" maxlength="15" value="<%=rs("IP")%>">
      </td>
    </tr>
    <% end if %>
    <tr> 
      <td width="200" align="right" class="tdbg">�� �֣�</td>
      <td class="tdbg" colspan="3"> 
        <input type="radio" name="Score" value="1" <%if rs("Score")=1 then response.write "checked"%>>
        1��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        <input type="radio" name="Score" value="2" <%if rs("Score")=2 then response.write "checked"%>>
        2��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        <input type="radio" name="Score" value="3" <%if rs("Score")=3 then response.write "checked"%>>
        3��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        <input type="radio" name="Score" value="4" <%if rs("Score")=4 then response.write "checked"%>>
        4��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        <input type="radio" name="Score" value="5" <%if rs("Score")=5 then response.write "checked"%>>
        5�� </td>
    </tr>
    <tr> 
      <td width="200" align="right" class="tdbg">�������ݣ�</td>
      <td class="tdbg" colspan="3"> 
        <textarea name="Content" cols="56" rows="8" id="Content"><%=rs("Content")%></textarea>
      </td>
    </tr>
    <tr align="center"> 
      <td height="30" colspan="4" class="tdbg"> 
        <input name="ComeUrl" type="hidden" id="ComeUrl" value="<%=ComeUrl%>">
        <input name="Action" type="hidden" id="Action" value="SaveModify">
        <input name="CommentID" type="hidden" id="CommentID" value="<%=rs("CommentID")%>">
        <input name="UserType" type="hidden" id="UserType" value="<%=rs("UserType")%>">
        <input  type="submit" name="Submit" value=" �����޸Ľ�� ">
      </td>
    </tr>
  </table>
</form>
<%
	end if
	rs.close
	set rs=nothing
end sub

sub Reply()
	dim CommentID
	CommentID=trim(Request("CommentID"))
	if CommentID="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>��ָ������ID</li>"
		Exit sub
	else
		CommentID=Clng(CommentID)
	end if
	sql="select A.ArticleID, A.ClassID, A.Title as ArticleTitle, A.IncludePic, C.CommentID,C.UserName,C.IP, C.Content,C.WriteTime,C.ReplyContent from ArticleComment C Left Join Article A On C.ArticleID=A.ArticleID where C.CommentID=" & CommentID
	Set rs=Server.CreateObject("Adodb.RecordSet")
	rs.Open sql,conn,1,1
	if rs.Bof or rs.EOF then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>�Ҳ���ָ�������ۣ�</li>"
	else
	
%>
<form method="post" action="Admin_ArticleComment.asp" name="form1">
    
  <table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" class="border" >
    <tr align="center" class="title"> 
      <td height="22" colspan="2"> <strong>�� �� �� ��</strong></td>
    </tr>
    <tr> 
      <td width="200" align="right" class="tdbg">�������±��⣺</td>
      <td class="tdbg"><%=rs("ArticleTitle")%></td>
    </tr>
    <tr> 
      <td width="200" align="right" class="tdbg">�������û�����</td>
      <td class="tdbg"><%=rs("UserName")%></td>
    </tr>
    <tr> 
      <td width="200" align="right" class="tdbg">�������ݣ�</td>
      <td class="tdbg"><%=rs("Content")%></td>
    </tr>
    <tr>
      <td align="right" class="tdbg">�ظ����ݣ�</td>
      <td class="tdbg"><textarea name="ReplyContent" cols="50" rows="6" id="ReplyContent"><%=rs("ReplyContent")%></textarea></td>
    </tr>
    <tr align="center"> 
      <td height="30" colspan="2" class="tdbg"><input name="ComeUrl" type="hidden" id="ComeUrl" value="<%=ComeUrl%>">
	  <input name="Action" type="hidden" id="Action" value="SaveReply"> 
        <input name="CommentID" type="hidden" id="CommentID" value="<%=rs("CommentID")%>"> 
        <input  type="submit" name="Submit" value=" �� �� "> </td>
    </tr>
  </table>
</form>
<%
	end if
	rs.close
	set rs=nothing
end sub
%>
</body>
</html>
<%
sub DelComment()
	dim CommentID,i
	CommentID=trim(Request("CommentID"))
	if CommentID="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>��ָ������ID</li>"
		Exit sub
	end if

	if instr(CommentID,",")>0 then
		dim idarr
		idArr=split(CommentID)
		for i = 0 to ubound(idArr)
		    conn.execute "delete from ArticleComment where Commentid=" & Clng(idArr(i))
		next
	else
		conn.execute "delete from ArticleComment where Commentid=" & Clng(CommentID)
	end if
	call CloseConn()
	response.redirect ComeUrl
End sub

sub DelComment2()
    dim ArticleID
	ArticleID=trim(request("ArticleID"))
	if ArticleID="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>��ָ������ID</li>"
		Exit sub
	else
		ArticleID=Clng(ArticleID)
	end if
	
    conn.execute "delete from ArticleComment where ArticleID=" & ArticleID
	call CloseConn()
	response.redirect ComeUrl
End sub

sub SaveModify()
	dim rsComment,ClassID,tClass,CommentID
	dim CommentUserType,CommentUserName,CommentUserSex,CommentUserEmail,CommentUserOicq
	dim CommentUserIcq,CommentUserMsn,CommentUserHomepage,CommentUserScore,CommentUserContent
	dim CommentUserIP,CommentWritetime
	CommentID=trim(Request("CommentID"))
	if CommentID="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>��ָ������ID</li>"
		Exit sub
	end if
	CommentUserName=trim(request("UserName"))
	if CommentUserName="" then
		founderr=true
		errmsg=errmsg & "<br><li>����������</li>"
		Exit sub
	end if
	CommentUserType=Clng(request("UserType"))
	if CommentUserType=0 then
		CommentUserSex=trim(request("Sex"))
		CommentUserOicq=trim(request("Oicq"))
		CommentUserIcq=trim(request("Icq"))
		CommentUserMsn=trim(request("Msn"))
		CommentUserEmail=trim(request("Email"))
		CommentUserHomepage=trim(request("Homepage"))
		if CommentUserHomepage="http://" or isnull(CommentUserHomepage) then CommentUserHomepage=""
	end if
	CommentUserIP=trim(request.form("IP"))
	CommentWriteTime=trim(request.form("WriteTime"))
	CommentUserScore=Clng(request.Form("Score"))
	CommentUserContent=trim(request.Form("Content"))
	if CommentUserContent="" or CommentUserIP="" or CommentUserScore="" then
		founderr=true
		errmsg=errmsg & "<br><li>�����������������ݡ�����ʱ�䡢������IP����Ϣ</li>"
	end if
	CommentUserContent=DvHtmlEncode(CommentUserContent)
	if CommentWriteTime="" then
		CommentWriteTime=now()
	else
		CommentWriteTime=Cdate(CommentWriteTime)
	end if

	if FoundErr=True then
		exit sub
	end if

	sql="Select * from ArticleComment where CommentID=" & CommentID
	Set rsComment=Server.CreateObject("Adodb.RecordSet")
	rsComment.Open sql,conn,1,3
	if rsComment.Bof or rsComment.EOF then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>�Ҳ���ָ�������ۣ�</li>"
	else
		rsComment("UserType")=CommentUserType
		rsComment("UserName")=CommentUserName
		rsComment("Sex")=CommentUserSex
		rsComment("Oicq")=CommentUserOicq
		rsComment("Icq")=CommentUserIcq
		rsComment("Msn")=CommentUserMsn
		rsComment("Email")=CommentUserEmail
		rsComment("Homepage")=CommentUserHomepage
		rsComment("IP")=CommentUserIP
		rsComment("WriteTime")=CommentWriteTime
		rsComment("Score")=CommentUserScore
		rsComment("Content")=CommentUserContent
		rsComment.update
	end if
	rsComment.Close
   	set rsComment=Nothing
	call CloseConn()
	response.redirect ComeUrl
end sub

sub SaveReply()
	dim CommentID,ReplyName,ReplyContent,ReplyTime
	CommentID=trim(Request("CommentID"))
	ReplyContent=trim(request("ReplyContent"))
	if CommentID="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>��ָ������ID</li>"
		Exit sub
	else
		CommentID=Clng(CommentID)
	end if
	if ReplyContent="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>������ظ�����</li>"
	end if
	
	if FoundErr=True then
		exit sub
	end if
	
	sql="Select * from ArticleComment where CommentID=" & CommentID
	Set rs=Server.CreateObject("Adodb.RecordSet")
	rs.Open sql,conn,1,3
	if rs.Bof or rs.EOF then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>�Ҳ���ָ�������ۣ�</li>"
	else
		rs("ReplyName")=AdminName
		rs("ReplyTime")=now()
     	rs("ReplyContent")=dvhtmlencode(ReplyContent)
     	rs.update
	end if
	rs.Close
   	set rs=Nothing
	call CloseConn()
	response.redirect ComeUrl
end sub

%>