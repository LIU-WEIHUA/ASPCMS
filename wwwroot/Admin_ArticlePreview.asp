<%@language=vbscript codepage=936 %>
<!--#include file="inc/conn.asp"-->
<!--#include file="inc/ubbcode.asp"-->
<!--#include file="inc/function.asp"-->
<%
dim FoundErr,ErrMsg
dim ClassID,tClass,ClassName,RootID,ParentID,ParentPath,Depth,Child,ClassMaster
call main()
call CloseConn()

sub main()
%>
<html>
<head>
<title><%=request("Title")%></title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="Admin_Style.css" rel="stylesheet" type="text/css">
</head>

<body leftmargin="2" topmargin="0" marginwidth="0" marginheight="0">
<table width="760" border="0" align="center" cellpadding="5" cellspacing="0" class="border">
  <tr class="title"> 
    <td width="400" height="22">
	<%
	ClassID=trim(request("ClassID"))
	if ClassID="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>��ָ��������Ŀ</li>"
		exit sub
	else
		ClassID=Clng(ClassID)
	end if
	set tClass=conn.execute("select ClassName,RootID,ParentID,Depth,ParentPath,Child,ClassMaster From ArticleClass where ClassID=" & ClassID)
	if tClass.bof and tClass.eof then
		founderr=True
		ErrMsg=ErrMsg & "<br><li>�Ҳ���ָ������Ŀ</li>"
		exit sub
	else
		ClassName=tClass(0)
		RootID=tClass(1)
		ParentID=tClass(2)
		Depth=tClass(3)
		ParentPath=tClass(4)
		Child=tClass(5)
		ClassMaster=tClass(6)
	end if
	set tClass=nothing
if ParentID>0 then
	dim sqlPath,rsPath
	sqlPath="select ClassID,ClassName From ArticleClass where ClassID in (" & ParentPath & ") order by Depth"
	set rsPath=server.createobject("adodb.recordset")
	rsPath.open sqlPath,conn,1,1
	do while not rsPath.eof
		response.Write rsPath(1) & "&nbsp;&gt;&gt;&nbsp;"
		rsPath.movenext
	loop
	rsPath.close
	set rsPath=nothing
end if
response.write ClassName & "&nbsp;&gt;&gt;&nbsp;"

	if request("IncludePic")=true then
		response.write "<font color=blue>[ͼ��]</font>"
	end if
	response.write request("Title")
	%>
	</td>
    <td width="50" height="22" align="right"> <%
			if lcase(request("OnTop"))="yes" then
				response.Write("��&nbsp;")
			else
				response.write("&nbsp;&nbsp;&nbsp;")
			end if
			if lcase(request("Hot"))="yes" then
				response.write("��&nbsp;")
			else
				response.write("&nbsp;&nbsp;&nbsp;")
			end if
			if lcase(request("Elite"))="yes" then
				response.write("��")
			else
				response.write("&nbsp;&nbsp;")
			end if
			%> </td>
  </tr>
  <tr class="tdbg"> 
    <td colspan="3"><p align="center"><font size="6"><%=dvhtmlencode(request("Title"))%></font><br>
        ���ߣ�<%=dvhtmlencode(request("Author"))%>&nbsp;&nbsp;&nbsp;&nbsp;ת���ԣ�<%=dvhtmlencode(request("CopyFrom"))%>&nbsp;&nbsp;&nbsp;&nbsp;�������0&nbsp;&nbsp;&nbsp;&nbsp;����¼�룺<%=session("AdminName")%></p>
      <p><%=ubbcode(request("Content"))%></p>
      </td>
  </tr>
</table>
<p align="center">��<a href="javascript:window.close();">�رմ���</a>��</p>
</body>
</html>
<%
end sub
%>