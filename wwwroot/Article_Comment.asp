<!--#include file="Inc/conn.asp"-->
<!--#include file="inc/Conn_User.asp"-->
<!--#include file="inc/config.asp"-->
<!--#include file="inc/ubbcode.asp"-->
<!--#include file="Inc/function.asp"-->
<%
dim CommentPurviewGrade,CommentUserGrade
UserLogined=CheckUserLogined()
if UserLevel="" then
	UserLevel=9999
else
	UserLevel=Cint(UserLevel)
end if

select case UserLevel
	case 9999
		CommentUserGrade="�ο�"
	case 999
		CommentUserGrade="ע���û�"
	case 99
		CommentUserGrade="�շ��û�"
	case 9
		CommentUserGrade="VIP�û�"
	case 5
		CommentUserGrade="����Ա"
end select
select case CommentPurview
	case 9999
		CommentPurviewGrade="�ο�"
	case 999
		CommentPurviewGrade="ע���û�"
	case 99
		CommentPurviewGrade="�շ��û�"
	case 9
		CommentPurviewGrade="VIP�û�"
	case 5
		CommentPurviewGrade="����Ա"
end select

if CommentPurview<UserLevel then 
	FoundErr=True
	ErrMsg=ErrMsg & "<br><br><li>�Բ���ֻ�б�վ��<font color=red>"
	ErrMsg=ErrMsg & CommentPurviewGrade
	ErrMsg=ErrMsg & "</font>���ܷ������ۣ�</li><br><br>"
	ErrMsg=ErrMsg & "<li>����㻹ûע�ᣬ��Ͻ�<a href='User_Reg.asp'><font color=red>���ע��</font></a>�ɣ�</li><br><br>"
	ErrMsg=ErrMsg & "<li>������Ѿ�ע�ᵫ��û��¼����Ͻ�<a href='User_Login.asp'><font color=red>��˵�¼</font></a>�ɣ�</li><br><br>"
end if

dim ArticleID,Action,ErrMsg,FoundErr
dim Commented,CommentedID,arrCommentedID,i
Action=trim(request("Action"))
ArticleID=trim(request("ArticleID"))
Commented=False
CommentedID=session("CommentedID")

if ArticleId="" then
	founderr=true
	errmsg=errmsg+"<li>��ָ��Ҫ���۵�����ID</li>"
else
	ArticleID=Clng(ArticleID)
end if
if CommentedID<>"" then
	if instr(CommentedID,"|")>0 then
		arrCommentedID=split(CommentedID,"|")
		for i=0 to ubound(arrCommentedID)
			if Clng(arrCommentedID(i))=ArticleID then
				Commented=True
				exit for
			end if
		next
	else
		if Clng(CommentedID)=ArticleID then
			Commented=True
		end if
	end if
end if
if Commented=True then
	FoundErr=True
	ErrMsg=ErrMsg & "<li>���Ѿ��Ը�ƪ���·���������ˣ�����������ͬһƪ���·������ۡ�</li>"
end if

if FoundErr<>True then
	if Action="Save" then
		call SaveComment()
	else
		call main()
	end if
end if
if FoundErr=True then
	call WriteErrMsg()
end if
call CloseConn()

sub main()
%>
<html>
<head>
<title>��������</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="STYLE.CSS" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/JavaScript">
function Check()
{
  if (document.form1.Name.value=="")
  {
    alert("������������");
	document.form1.Name.focus();
	return false;
  }
  if (document.form1.Content.value=="")
  {
    alert("�������������ݣ�");
	document.form1.Content.focus();
	return false;
  }
  return true;  
}
</script>
</head>

<body leftmargin="2" topmargin="0" marginwidth="0" marginheight="0">
<form name="form1" method="post" action="Article_Comment.asp" onSubmit="return Check();">
  <table width="500" border="0" align="center" cellpadding="2" cellspacing="1" class="border">
    <tr class="title"> 
      <td height="22" colspan="4" align="center"><strong>�� �� �� ��</strong> <font color=blue>��<%=CommentUserGrade%>��</font></td>
    </tr>
    <% if UserLogined=false then%>
    <tr class="tdbg"> 
      <td align="right" width="110">�� &nbsp;����</td>
      <td width="180"> 
        <input type="text" name="Name" maxlength="16" size="20">
        <font color=red>*</font> </td>
      <td width="60" align="right">Oicq��</td>
      <td width="170"> 
        <input type="text" name="Oicq" maxlength="15" size="20" >
      </td>
    </tr>
    <tr class="tdbg"> 
      <td align="right" width="110">��&nbsp;&nbsp;��</td>
      <td width="180"> 
        <input type="radio" name="Sex" value="1" checked style="BORDER:0px;">
        ��&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        <input type="radio" name="Sex" value="0" style="BORDER:0px;">
        Ů </td>
      <td width="60" align="right">Msn��</td>
      <td width="170"> 
        <input type="text" name="Msn" maxlength="40" size="20">
      </td>
    </tr>
    <tr class="tdbg"> 
      <td align="right" width="110">E-mail��</td>
      <td width="180"> 
        <input type="text" name="Email" maxlength="40" size="20">
      </td>
      <td width="60" align="right">Icq��</td>
      <td width="170"> 
        <input type="text" name="Icq" maxlength="15" size="20">
      </td>
    </tr>
    <tr class="tdbg"> 
      <td align="right" width="110">��&nbsp;&nbsp;ҳ��</td>
      <td colspan="3"> 
        <input name="Homepage" type="text" id="Title" size="60" maxlength="60" value="http://">
      </td>
    </tr>
    <%else%>
    <input type="hidden" name="Name"  value="<%=UserName%>">
    <% end if %>
    <tr class="tdbg"> 
      <td align="right" width="110">�� �֣�</td>
      <td colspan="3"> 
        <input type="radio" name="Score" value="1">
        1��&nbsp;&nbsp;&nbsp;&nbsp; 
        <input type="radio" name="Score" value="2">
        2��&nbsp;&nbsp;&nbsp;&nbsp; 
        <input type="radio" name="Score" value="3" checked>
        3��&nbsp;&nbsp;&nbsp;&nbsp; 
        <input type="radio" name="Score" value="4">
        4��&nbsp;&nbsp;&nbsp;&nbsp; 
        <input type="radio" name="Score" value="5">
        5�� </td>
    </tr>
    <tr class="tdbg"> 
      <td align="right">�������ݣ�</td>
      <td colspan="3"> 
        <textarea name="Content" cols="50" rows="10" id="Content"></textarea>
      </td>
    </tr>
    <tr bgcolor="#DAE8CA" class="tdbg"> 
      <td colspan="4" align="center"> 
        <input name="Action" type="hidden" id="Action" value="Save">
        <input name="ArticleID" type="hidden" id="ArticleID" value="<%=ArticleID%>">
        <input type="submit" name="Submit" value=" �� �� ">
      </td>
    </tr>
    <tr bgcolor="#DAE8CA" class="tdbg">
      <td colspan="4">
          <br>
		  
        <li> ������<a href=bbs.htm target=_blank><font color=red>�����������ӹ���������涨��</font></a>���л����񹲺͹����������йط��ɷ��档<br>
          <li>�Ͻ�����Σ�����Ұ�ȫ���𺦹������桢�ƻ������Žᡢ�ƻ������ڽ����ߡ��ƻ�����ȶ������衢�̰�����������������ݵ����� ��<br>
          <li>�û�����Լ���ʹ�ñ�վ��������е���Ϊ�е��������Σ�ֱ�ӻ��ӵ��µģ���<br>
          <li>��վ����Ա��Ȩ������ɾ���������ݡ�<br>
          <li>��������ֻ�������Ѹ��˹۵㣬�뱾��վ�����޹ء�
      </td>
    </tr>
  </table>
  </form>

</body>
</html>
<%
end sub

sub SaveComment()
	dim rsComment,ClassID,tClass
	dim CommentUserType,CommentUserName,CommentUserSex,CommentUserEmail,CommentUserOicq
	dim CommentUserIcq,CommentUserMsn,CommentUserHomepage,CommentUserScore,CommentUserContent
	if UserLogined=false then
		CommentUserType=0
		CommentUserName=trim(request("Name"))
		if CommentUserName="" then
			founderr=true
			errmsg=errmsg & "<br><li>����������</li>"
		end if
		CommentUserSex=trim(request("Sex"))
		CommentUserOicq=trim(request("Oicq"))
		CommentUserIcq=trim(request("Icq"))
		CommentUserMsn=trim(request("Msn"))
		CommentUserEmail=trim(request("Email"))
		CommentUserHomepage=trim(request("Homepage"))
		if CommentUserHomepage="http://" or isnull(CommentUserHomepage) then CommentUserHomepage=""
	else
		CommentUserType=1
		CommentUserName=UserName
	end if
	CommentUserScore=Clng(request.Form("Score"))
	CommentUserContent=trim(request.Form("Content"))
	if CommentUserContent="" then
		founderr=true
		errmsg=errmsg & "<br><li>��������������</li>"
	end if
	CommentUserContent=DvHtmlEncode(CommentUserContent)

	set tClass=conn.execute("select ClassID from Article where ArticleID=" & ArticleID)
	if tClass.bof and tClass.eof then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>�Ҳ���Ҫ���۵����£������Ѿ���ɾ����</li>"
	else
		ClassID=tClass(0)
	end if
	set tClass=nothing
	
	if founderr=true then
		exit sub
	end if

	set rsComment=server.createobject("adodb.recordset")
	sql="select * from ArticleComment"
	rsComment.open sql,conn,1,3
	rsComment.addnew
	rsComment("ClassID")=ClassID
	rsComment("ArticleID")=ArticleID
	rsComment("UserType")=CommentUserType
	rsComment("UserName")=CommentUserName
	rsComment("Sex")=CommentUserSex
	rsComment("Oicq")=CommentUserOicq
	rsComment("Icq")=CommentUserIcq
	rsComment("Msn")=CommentUserMsn
	rsComment("Email")=CommentUserEmail
	rsComment("Homepage")=CommentUserHomepage
	rsComment("IP")=Request.ServerVariables("REMOTE_ADDR")
	rsComment("Score")=CommentUserScore
	rsComment("Content")=CommentUserContent
	rsComment("WriteTime")=now()
	rsComment.update
	rsComment.close
	set rsComment=nothing

	if CommentedID="" then
		session("CommentedID")=ArticleID
	else
		session("CommentedID")=CommentedID & "|" & ArticleID
	end if
	call WriteSuccessMsg("�������۳ɹ���")
end sub
%>