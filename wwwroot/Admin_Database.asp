<%@language=vbscript codepage=936 %>
<%
option explicit
response.buffer=true	
Const PurviewLevel=1
Const CheckChannelID=0
Const PurviewLevel_Others="Database"
'response.write "�˹��ܱ�WEBBOY��ʱ��ֹ�ˣ�"
'response.end
%>
<!--#include file="inc/conn.asp"-->
<!--#include file="inc/config.asp"-->
<!--#include file="Admin_ChkPurview.asp"-->
<!--#include file="inc/Conn_User.asp"-->
<!--#include file="inc/function.asp"-->
<%
dim Action,FoundErr,ErrMsg
Action=trim(request("Action"))
dim dbpath
dim ObjInstalled
dbpath=server.mappath(db)
ObjInstalled=IsObjInstalled("Scripting.FileSystemObject")
%>
<html>
<head>
<title>���ݿⱸ��</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" type="text/css" href="Admin_Style.css">
</head>
<body leftmargin="2" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" class="border">
  <tr class="topbg"> 
    <td height="22" colspan="2" align="center"><strong>�� �� �� �� ��</strong></td>
  </tr>
  <tr class="tdbg"> 
    <td width="70" height="30"><strong>��������</strong></td>
    <td height="30"><a href="Admin_Database.asp?Action=Backup">�������ݿ�</a> | <a href="Admin_Database.asp?Action=Restore">�ָ����ݿ�</a> 
      | <a href="Admin_Database.asp?Action=Compact">ѹ�����ݿ�</a> | <a href="Admin_Database.asp?Action=Init">ϵͳ��ʼ��</a> 
      | <a href="Admin_Database.asp?Action=SpaceSize">ϵͳ�ռ�ռ�����</a></td>
  </tr>
</table>
<%
if Action="Backup" or Action="BackupData" then
	call CloseConn()
	call ShowBackup()
elseif Action="Compact" or Action="CompactData" then
	call CloseConn()
	call ShowCompact()
elseif Action="Restore" or Action="RestoreData" then
	call CloseConn()
	call ShowRestore()
elseif Action="Init" or Action="Clear" then
	call ShowInit()
	call CloseConn()
elseif Action="SpaceSize" then
	call SpaceSize()
	call CloseConn()
else
	FoundErr=True
	ErrMsg=ErrMsg & "<br><li>���������</li>"
	call CloseConn()
end if
if FoundErr=True then
	call WriteErrMsg()
end if
call CloseConn_User()

sub ShowBackup()
%>
<form method="post" action="Admin_Database.asp?action=BackupData">
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="border">
  <tr class="title"> 
      <td align="center" height="22" valign="middle"><b>�� �� �� �� ��</b></td>
  </tr>
  <tr class="tdbg"> 
    <td height="150" align="center" valign="middle">
<%    
if request("action")="BackupData" then
	call backupdata()
else
%>
        <table cellpadding="3" cellspacing="1" border="0" width="100%">
          <tr> 
            <td width="200" height="33" align="right">����Ŀ¼��</td>
            <td><input type=text size=20 name=bkfolder value=Databackup></td>
            <td>���·��Ŀ¼����Ŀ¼�����ڣ����Զ�����</td>
          </tr>
          <tr> 
            <td width="200" height="34" align="right">�������ƣ�</td>
            <td height="34"><input type=text size=20 name=bkDBname value="<%=date()%>"></td>
            <td height="34">���������ļ�����׺��Ĭ��Ϊ��.asa����������ͬ���ļ���������</td>
          </tr>
          <tr align="center"> 
            <td height="40" colspan="3"><input name="submit" type=submit value=" ��ʼ���� " <%If ObjInstalled=false Then response.Write "disabled"%>></td>
          </tr>
        </table>
<%
	If ObjInstalled=false Then
		Response.Write "<b><font color=red>��ķ�������֧�� FSO(Scripting.FileSystemObject)! ����ʹ�ñ�����</font></b>"
	end if
end if
%>
    </td>
 </tr>
</table>
</form>
<%
end sub

sub ShowCompact()
%>
<form method="post" action="Admin_Database.asp?action=CompactData">
<table class="border" width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr class="title"> 
		<td align="center" height="22" valign="middle"><b>���ݿ�����ѹ��</b></td>
	</tr>
	<tr class="tdbg">
		<td align="center" height="150" valign="middle"> 
<%    
if request("action")="CompactData" then
	call CompactData()
else
%>
      <br>
      <br>
      <br>
      ѹ��ǰ�������ȱ������ݿ⣬���ⷢ��������� <br>
      <br>
      <br>
	<input name="submit" type=submit value=" ѹ�����ݿ� " <%If ObjInstalled=false Then response.Write "disabled"%>>
        <br>
        <br>
<%
	If ObjInstalled=false Then
		Response.Write "<b><font color=red>��ķ�������֧�� FSO(Scripting.FileSystemObject)! ����ʹ�ñ�����</font></b>"
	end if
end if
%>
            </td>
          </tr>
        </table>
</form>
<%
end sub

sub ShowRestore()
%>
<form method="post" action="Admin_Database.asp?action=RestoreData">
	<table width="100%" class="border" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr class="title"> 
      		<td align="center" height="22" valign="middle"><b>���ݿ�ָ�</b></td>
        </tr>
        <tr class="tdbg">
            <td align="center" height="150" valign="middle"> 
        <%
if request("action")="RestoreData" then
	call RestoreData()
else
%>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr> 
            <td width="200" height="30" align="right">�������ݿ����·����</td>
            <td height="30"><input name=backpath type=text id="backpath" value="DataBackup\Article.mdb" size=50 maxlength="200"></td>
          </tr>
          <tr align="center"> 
            <td height="40" colspan="2"><input name="submit" type=submit value=" �ָ����� " <%If ObjInstalled=false Then response.Write "disabled"%>></td>
          </tr>
        </table>
<%
	If ObjInstalled=false Then
		Response.Write "<b><font color=red>��ķ�������֧�� FSO(Scripting.FileSystemObject)! ����ʹ�ñ�����</font></b>"
	end if
end if
%>
            </td>
        </tr>
      </table>
</form>
<%
end sub

sub ShowInit()
%>
<form action="Admin_Database.asp" method="post" name="form1" id="form1" onSubmit="return confirm('ȷʵҪ���ѡ���ı���һ��������޷��ָ���');">
  <table class="border" width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr class="title"> 
      <td align="center" height="22" valign="middle"><b>ϵ ͳ �� ʼ ��</b></td>
    </tr>
    <tr class="tdbg"> 
      <td width="100%" height="150" align=center valign="middle">
<%
if Action="Clear" then
	call ClearData()
else
%>        <b><br>
        <font color="#FF0000">�����ô˹��ܣ���Ϊһ��������޷��ָ���</font><br>
        <br>
        </b> 
        <table border="0" cellspacing="0" cellpadding="5">
          <tr> 
            <td align="center"><b>��ѡ����Ҫ��յ����ݿ⣺</b></td>
          </tr>
          <tr> 
            <td><fieldset>
              <legend>����Ƶ��</legend>
              <table width="500" border="0" cellpadding="0" cellspacing="5">
                <tr> 
                  <td width="25%"><input name="ArticleClass" type="checkbox" id="ArticleClass" value="yes">
                    ������Ŀ</td>
                  <td width="25%"><input name="Article" type="checkbox" id="Ariticle" value="yes">
                    ��������</td>
                  <td width="25%"><input name="Special" type="checkbox" id="Special" value="yes">
                    ��&nbsp;&nbsp;��</td>
                  <td width="25%"><input name="ArticleComment" type="checkbox" id="ArticleComment" value="yes">
                    ��������</td>
                </tr>
              </table>
              </fieldset></td>
          </tr>
           
         <!-- ����ҪͼƬƵ������  <tr>  <td><fieldset>
              <legend>ͼƬƵ��</legend>
              <table width="500" border="0" cellpadding="0" cellspacing="5">
                <tr> 
                  <td width="25%"><input name="PhotoClass" type="checkbox" id="PhotoClass" value="yes">
                    ͼƬ��Ŀ</td>
                  <td width="25%"><input name="Photo" type="checkbox" id="Photo" value="yes">
                    ����ͼƬ</td>
                  <td width="25%"><input name="PhotoComment" type="checkbox" id="PhotoComment" value="yes">
                    ͼƬ����</td>
                  <td width="25%">&nbsp;</td>
                </tr>
              </table>
              </fieldset></td>  </tr> -->
          
          <tr> 
            <td><fieldset>
              <legend>���԰�</legend>
              <table width="500" border="0" cellspacing="5" cellpadding="0">
                <tr> 
                  <td width="25%"><input name="Guest" type="checkbox" id="Guest" value="yes">
                    ��������</td>
                  <td width="25%">&nbsp;</td>
                  <td width="25%">&nbsp;</td>
                  <td width="25%">&nbsp;</td>
                </tr>
              </table>
              </fieldset></td>
          </tr>
          <tr> 
            <td><fieldset>
              <legend>����</legend>
              <table width="500" border="0" cellpadding="0" cellspacing="5">
                <tr> 
                  <td width="25%"> <input name="Announce" type="checkbox" id="Announce" value="yes">
                    ��&nbsp;&nbsp;��</td>
                  <!-- ����Ҫ������  <td width="25%"><input name="Advertisement" type="checkbox" id="Advertisement" value="yes">
                    �㡡����</td>  -->
                  <td width="25%"> <input name="Vote" type="checkbox" id="Vote" value="yes">
                    ��վ����</td>
                  <td width="25%"><input name="FriendSite" type="checkbox" id="FriendSite" value="yes">
                    ��վ����</td>
                
                 
                  <td width="25%"> <input name="User" type="checkbox" id="User" value="yes">
                    ע���û�</td>
                </tr>
              </table>
              </fieldset></td>
          </tr>
          <tr> 
            <td align="center"><input name="Action" type="hidden" id="Action2" value="Clear"> 
              <input type="submit" name="Submit" value="�������"></td>
          </tr>
        </table>
        <%
end if
%>
      </td>
    </tr>
  </table>
</form>
<%
end sub

sub SpaceSize()
	on error resume next
%>
<br>
<table class="border" width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr class="title"> 
		<td align="center" height="22" valign="middle"><b>ϵͳ�ռ�ռ�����</b></td>
	</tr>
  <tr class="tdbg"> 
    <td width="100%" height="150" valign="middle">
	<blockquote><br>
      ϵͳ����ռ�ÿռ䣺&nbsp;<img src="images/bar.gif" width=<%=drawbar("database")%> height=10>&nbsp;
      <%showSpaceinfo("database")%>
      <br>
      <br>
      ��������ռ�ÿռ䣺&nbsp;<img src="images/bar.gif" width=<%=drawbar("databackup")%> height=10>&nbsp;
      <%showSpaceinfo("databackup")%>
      <br>
      <br>
      ��ɫģ��ռ�ÿռ䣺&nbsp;<img src="images/bar.gif" width=<%=drawbar("skin")%> height=10>&nbsp;
      <%showSpaceinfo("skin")%>
      <br>
      <br>
      ϵͳͼƬռ�ÿռ䣺&nbsp;<img src="images/bar.gif" width=<%=drawbar("images")%> height=10>&nbsp;
      <%showSpaceinfo("images")%>
      <br>
      <br>
      �ϴ��ļ�ռ�ÿռ䣺&nbsp;<img src="images/bar.gif" width=<%=drawbar("UploadFiles")%> height=10>&nbsp;
      <%showSpaceinfo("UploadFiles")%>
      <br>
      <br>
      ϵͳռ�ÿռ��ܼƣ�<img src="images/bar.gif" width=400 height=10> 
      <%showspecialspaceinfo("All")%>
	</blockquote> 	
    </td>
  </tr>
</table>
<%
end sub
%>
</body>
</html>
<%
sub BackupData()
	dim bkfolder,bkdbname,fso
	bkfolder=trim(request("bkfolder"))
	bkdbname=trim(request("bkdbname"))
	if bkfolder="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>��ָ������Ŀ¼��</li>"
	end if
	if bkdbname="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>��ָ�������ļ���</li>"
	end if
	if FoundErr=True then exit sub
	bkfolder=server.MapPath(bkfolder)
	Set Fso=server.createobject("scripting.filesystemobject")
	if fso.FileExists(dbpath) then
		If fso.FolderExists(bkfolder)=false Then
			fso.CreateFolder(bkfolder)
		end if
		fso.copyfile dbpath,bkfolder & "\" & bkdbname & ".asa"
		response.write "<center>�������ݿ�ɹ������ݵ����ݿ�Ϊ " & bkfolder & "\" & bkdbname & ".asa</center>"
	Else
		response.write "<center>�Ҳ���Դ���ݿ��ļ�������inc/conn.asp�е����á�</center>"
	End if
end sub

sub CompactData()
	Dim fso, Engine, strDBPath
	strDBPath = left(dbPath,instrrev(DBPath,"\"))
	Set fso = Server.CreateObject("Scripting.FileSystemObject")
	If fso.FileExists(dbPath) Then
		Set Engine = CreateObject("JRO.JetEngine")
		Engine.CompactDatabase "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & dbpath," Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & strDBPath & "temp.mdb"
		fso.CopyFile strDBPath & "temp.mdb",dbpath
		fso.DeleteFile(strDBPath & "temp.mdb")
		Set fso = nothing
		Set Engine = nothing
		response.write "���ݿ�ѹ���ɹ�!"
	Else
		response.write "���ݿ�û���ҵ�!"
	End If
end sub

sub RestoreData()
	dim backpath,fso
	backpath=request.form("backpath")
	if backpath="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>��ָ��ԭ���ݵ����ݿ��ļ�����<li>"
		exit sub	
	end if
	backpath=server.mappath(backpath)
	Set Fso=server.createobject("scripting.filesystemobject")
	if fso.fileexists(backpath) then  					
		fso.copyfile Backpath,Dbpath
		response.write "�ɹ��ָ����ݣ�"
	else
		response.write "�Ҳ���ָ���ı����ļ���"	
	end if
end sub

sub ClearData()
	dim z
	z=0
	if request("ArticleClass")="yes" then
		conn.execute("delete From ArticleClass")
		response.write "�ɹ����������������Ŀ��<br>"
		z=z+1
	end if
	if request("Article")="yes" then
		conn.execute("delete from Article")
		response.write "�ɹ�������������£�<br>"
		z=z+1
	end if
	if request("Special")="yes" then
		conn.execute("delete from Special")
		response.write "�ɹ���������пγ̣�<br>"
		z=z+1
	end if
	if request("ArticleComment")="yes" then
		conn.execute("delete from ArticleComment")
		response.write "�ɹ�����������������ۣ�<br>"
		z=z+1
	end if
	if request("PhotoClass")="yes" then
		conn.execute("delete From PhotoClass")
		response.write "�ɹ����������ͼƬ��Ŀ��<br>"
		z=z+1
	end if
	if request("Photo")="yes" then
		conn.execute("delete from Photo")
		response.write "�ɹ����������ͼƬ��<br>"
		z=z+1
	end if
	if request("PhotoComment")="yes" then
		conn.execute("delete from PhotoComment")
		response.write "�ɹ����������ͼƬ���ۣ�<br>"
		z=z+1
	end if
	if request("Guest")="yes" then
		conn.execute("delete from Guest")
		response.write "�ɹ�������������ԣ�<br>"
		z=z+1
	end if
	if request("Announce")="yes" then
		conn.execute("delete from Announce")
		z=z+1
	end if
	if request("Advertisement")="yes" then
		conn.execute("delete from Advertisement")
		z=z+1
	end if
	if request("FriendSite")="yes" then
		conn.execute("delete from FriendSite")
		z=z+1
	end if
	if request("Vote")="yes" then
		conn.execute("delete from Vote")
		z=z+1
	end if
	if request("User")="yes" then
		Conn_User.execute("delete from " & db_User_Table & "")
		z=z+1
	end if
	if z>0 then
		response.write cstr(z) & "�����ݿⱻ��գ�����Կ�ʼ��������ݡ�"
	else
		response.write "��û��ѡ���κ����ݿ⣬0�����ݿⱻ��ա�"
	end if

end sub

Sub ShowSpaceInfo(drvpath)
	dim fso,d,size,showsize
	set fso=server.createobject("scripting.filesystemobject") 		
	drvpath=server.mappath(drvpath) 		 		
	set d=fso.getfolder(drvpath) 		
	size=d.size
	showsize=size & "&nbsp;Byte" 
	if size>1024 then
	   size=(size\1024)
	   showsize=size & "&nbsp;KB"
	end if
	if size>1024 then
	   size=(size/1024)
	   showsize=formatnumber(size,2) & "&nbsp;MB"		
	end if
	if size>1024 then
	   size=(size/1024)
	   showsize=formatnumber(size,2) & "&nbsp;GB"	   
	end if   
	response.write "<font face=verdana>" & showsize & "</font>"
End Sub	

Sub Showspecialspaceinfo(method)
	dim fso,d,fc,f1,size,showsize,drvpath 		
	set fso=server.createobject("scripting.filesystemobject")
	drvpath=server.mappath("pic")
	drvpath=left(drvpath,(instrrev(drvpath,"\")-1))
	set d=fso.getfolder(drvpath) 		
	
	if method="All" then 		
		size=d.size
	elseif method="Program" then
		set fc=d.Files
		for each f1 in fc
			size=size+f1.size
		next	
	end if	
	
	showsize=size & "&nbsp;Byte" 
	if size>1024 then
	   size=(size\1024)
	   showsize=size & "&nbsp;KB"
	end if
	if size>1024 then
	   size=(size/1024)
	   showsize=formatnumber(size,2) & "&nbsp;MB"		
	end if
	if size>1024 then
	   size=(size/1024)
	   showsize=formatnumber(size,2) & "&nbsp;GB"	   
	end if   
	response.write "<font face=verdana>" & showsize & "</font>"
end sub 	 	 	

Function Drawbar(drvpath)
	dim fso,drvpathroot,d,size,totalsize,barsize
	set fso=server.createobject("scripting.filesystemobject")
	drvpathroot=server.mappath("pic")
	drvpathroot=left(drvpathroot,(instrrev(drvpathroot,"\")-1))
	set d=fso.getfolder(drvpathroot)
	totalsize=d.size
	
	drvpath=server.mappath(drvpath) 		
	set d=fso.getfolder(drvpath)
	size=d.size
	
	barsize=cint((size/totalsize)*400)
	Drawbar=barsize
End Function 	

Function Drawspecialbar()
	dim fso,drvpathroot,d,fc,f1,size,totalsize,barsize
	set fso=server.createobject("scripting.filesystemobject")
	drvpathroot=server.mappath("pic")
	drvpathroot=left(drvpathroot,(instrrev(drvpathroot,"\")-1))
	set d=fso.getfolder(drvpathroot)
	totalsize=d.size
	
	set fc=d.files
	for each f1 in fc
		size=size+f1.size
	next	
	
	barsize=cint((size/totalsize)*400)
	Drawspecialbar=barsize
End Function 	
%>