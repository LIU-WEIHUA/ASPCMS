<!--#include file="inc/conn.asp"-->
<!--#include file="inc/Conn_User.asp"-->
<!--#include file="Inc/function.asp"-->
<!--#include file="inc/config.asp"-->
<%
if CheckUserLogined()=False then
	response.Redirect "User_Login.asp"
end if

dim ArticleID,Action,sqlDel,rsDel,FoundErr,ErrMsg,PurviewChecked,ObjInstalled
ArticleID=trim(request("ArticleID"))
Action=Trim(Request("Action"))
FoundErr=False
ObjInstalled=IsObjInstalled("Scripting.FileSystemObject")

if ArticleId="" or Action<>"Del" then
	FoundErr=True
	ErrMsg=ErrMsg & "<br><li>�������㣡</li>"
end if
if FoundErr=False then
	if instr(ArticleID,",")>0 then
		dim idarr,i
		idArr=split(ArticleID)
		for i = 0 to ubound(idArr)
			call DelArticle(clng(idarr(i)))
		next
	else
		call DelArticle(clng(ArticleID))
	end if
end if
call CloseConn()
if FoundErr=False then
	response.Redirect "User_ArticleManage.asp"
else
	call WriteErrMsg()
end if

sub DelArticle(ID)
	PurviewChecked=False
	sqlDel="select * from article where ArticleID=" & CLng(ID)
	Set rsDel= Server.CreateObject("ADODB.Recordset")
	rsDel.open sqlDel,conn,1,3
	if rsDel.bof and rsDel.eof then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>�Ҳ������£�" & rsDel("Title") & " </li>"
	else
		if rsDel("Editor")=Trim(Request.Cookies("asp163")("UserName")) then
			if rsDel("Passed")=True then
				FoundErr=True
				ErrMsg=ErrMsg & "<br><li>ɾ�����¡�" & rsDel("Title") & "��ʧ�ܡ�ԭ�򣺴������Ѿ������ͨ�����㲻����ɾ����</li>"
			end if
		else
			FoundErr=True
			ErrMsg=ErrMsg & "<br><li>ɾ�����¡�" & rsDel("Title") & "��ʧ�ܡ�ԭ�򣺴��������������ѷ���ģ��㲻��ɾ�������˵����£�</li>"
		end if
	end if
	if FoundErr=False then
		rsDel("Deleted")=True
		rsDel.update
		Conn_User.execute("update " & db_User_Table & " set " & db_User_ArticleCount & "=" & db_User_ArticleCount & "-1 where " & db_User_Name & "='" & rsDel("Editor") & "'")
	end if
	rsDel.close
	set rsDel=nothing
end sub
%>
