<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<%
option explicit
response.buffer=true	
'ǿ����������·��ʷ���������ҳ�棬�����Ǵӻ����ȡҳ��
Response.Buffer = True 
Response.Expires = -1
Response.ExpiresAbsolute = Now() - 1 
Response.Expires = 0 
Response.CacheControl = "no-cache" 
Const PurviewLevel=2
Const CheckChannelID=2
Const PurviewLevel_Article=3
%>
<!--#include file="inc/conn.asp"-->
<!--#include file="inc/config.asp"-->
<!--#include file="Admin_ChkPurview.asp"-->
<html>
<head>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<style type="text/css">body {font-size:	9pt}</style>
</head>
<BODY bgcolor="#FFFFFF" MONOSPACE>
<%
dim Action,FoundErr,ErrMsg
dim ArticleID,sql,rs
Action=trim(request("Action"))
ArticleID=trim(request("ArticleID"))
if Action="Modify" then
	if ArticleId="" then
		response.write "��ָ��Ҫ�޸ĵ�����ID"
	else
		ArticleID=Clng(ArticleID)
		sql="select * from article where Deleted=False and ArticleID=" & ArticleID & ""
		Set rs= Server.CreateObject("ADODB.Recordset")
		rs.open sql,conn,1,1
		if rs.bof and rs.eof then
			response.write "�Ҳ�������"
		else
			response.write "<p>" & rs("Content") & "</p>"
		end if
		rs.close
		set rs=nothing
	end if
end if
%>
</body>
</html>
<%
call CloseConn()
%>