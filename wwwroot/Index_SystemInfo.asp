<%@ Language="VBScript" %>
<% Option Explicit %>
<%

'��ʹ�������������ֱ�ӽ����н����ʾ�ڿͻ���
Response.Buffer = False

'�������������
Dim ObjTotest(26,4)

ObjTotest(0,0) = "MSWC.AdRotator"
ObjTotest(1,0) = "MSWC.BrowserType"
ObjTotest(2,0) = "MSWC.NextLink"
ObjTotest(3,0) = "MSWC.Tools"
ObjTotest(4,0) = "MSWC.Status"
ObjTotest(5,0) = "MSWC.Counters"
ObjTotest(6,0) = "IISSample.ContentRotator"
ObjTotest(7,0) = "IISSample.PageCounter"
ObjTotest(8,0) = "MSWC.PermissionChecker"
ObjTotest(9,0) = "Scripting.FileSystemObject"
	ObjTotest(9,1) = "(FSO �ı��ļ���д)"
ObjTotest(10,0) = "adodb.connection"
	ObjTotest(10,1) = "(ADO ���ݶ���)"
	
ObjTotest(11,0) = "SoftArtisans.FileUp"
	ObjTotest(11,1) = "(SA-FileUp �ļ��ϴ�)"
ObjTotest(12,0) = "SoftArtisans.FileManager"
	ObjTotest(12,1) = "(SoftArtisans �ļ�����)"
ObjTotest(13,0) = "LyfUpload.UploadFile"
	ObjTotest(13,1) = "(�ļ��ϴ����)"
ObjTotest(14,0) = "Persits.Upload.1"
	ObjTotest(14,1) = "(ASPUpload �ļ��ϴ�)"
ObjTotest(15,0) = "w3.upload"
	ObjTotest(15,1) = "(Dimac �ļ��ϴ�)"

ObjTotest(16,0) = "JMail.SmtpMail"
	ObjTotest(16,1) = "(Dimac JMail �ʼ��շ�)"
ObjTotest(17,0) = "CDONTS.NewMail"
	ObjTotest(17,1) = "(���� SMTP ����)"
ObjTotest(18,0) = "Persits.MailSender"
	ObjTotest(18,1) = "(ASPemail ����)"
ObjTotest(19,0) = "SMTPsvg.Mailer"
	ObjTotest(19,1) = "(ASPmail ����)"
ObjTotest(20,0) = "DkQmail.Qmail"
	ObjTotest(20,1) = "(dkQmail ����)"
ObjTotest(21,0) = "Geocel.Mailer"
	ObjTotest(21,1) = "(Geocel ����)"
ObjTotest(22,0) = "IISmail.Iismail.1"
	ObjTotest(22,1) = "(IISmail ����)"
ObjTotest(23,0) = "SmtpMail.SmtpMail.1"
	ObjTotest(23,1) = "(SmtpMail ����)"
	
ObjTotest(24,0) = "SoftArtisans.ImageGen"
	ObjTotest(24,1) = "(SA ��ͼ���д���)"
ObjTotest(25,0) = "W3Image.Image"
	ObjTotest(25,1) = "(Dimac ��ͼ���д���)"

public IsObj,VerObj

'���Ԥ�����֧��������汾

dim i
for i=0 to 25
	on error resume next
	IsObj=false
	VerObj=""
	dim TestObj
	set TestObj=server.CreateObject(ObjTotest(i,0))
	If -2147221005 <> Err then		'��л���ѵı�����
		IsObj = True
		VerObj = TestObj.version
		if VerObj="" or isnull(VerObj) then VerObj=TestObj.about
	end if
	ObjTotest(i,2)=IsObj
	ObjTotest(i,3)=VerObj
next

'�������Ƿ�֧�ּ�����汾���ӳ���
sub ObjTest(strObj)
	on error resume next
	IsObj=false
	VerObj=""
	dim TestObj
	set TestObj=server.CreateObject (strObj)
	If -2147221005 <> Err then		'��л����5757�ı�����
		IsObj = True
		VerObj = TestObj.version
		if VerObj="" or isnull(VerObj) then VerObj=TestObj.about
	end if	
End sub
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>�˳�AspWeb������ v1.0.0.5</title>
<LINK href="MCT/css.css" type="text/css" rel="stylesheet">
<script type="text/JavaScript">
<!--



function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}
//-->
</script>
</head>

<body>
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="52"><img src="MCT/main_1.jpg" width="52" height="55"></td>
        <td background="MCT/main_2.jpg" class="title1">����������</td>
        <td width="52"><img src="MCT/main_3.jpg" width="52" height="55"></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="15" background="MCT/main_4.gif">&nbsp;</td>
        <td background="MCT/main_9.gif"><table class="table" width="98%" border="0" align="center" cellpadding="0" cellspacing="1">
          
          <tr>
            <td align="center">
                  <table width=100% border=0 cellpadding=0 cellspacing=1 bgcolor="#6B8FC8">
                      <tr bgcolor="#E8F1FF" height=18>
                        <td colspan="2" align=center class="td2">��������ز���</td>
                      </tr>
                      <tr bgcolor="#E8F1FF" height=18>
                        <td align=center class="td">&nbsp;��������</td>
                        <td class="td">&nbsp;<%=Request.ServerVariables("SERVER_NAME")%></td>
                      </tr>
                      <tr bgcolor="#E8F1FF" height=18>
                        <td align=center class="td">&nbsp;������IP</td>
                        <td class="td">&nbsp;<%=Request.ServerVariables("LOCAL_ADDR")%></td>
                      </tr>
                      <tr bgcolor="#E8F1FF" height=18>
                        <td align=center class="td">&nbsp;�������˿�</td>
                        <td class="td">&nbsp;<%=Request.ServerVariables("SERVER_PORT")%></td>
                      </tr>
                      <tr bgcolor="#E8F1FF" height=18>
                        <td align=center class="td">&nbsp;������ʱ��</td>
                        <td class="td">&nbsp;<%=now%></td>
                      </tr>
                      <tr bgcolor="#E8F1FF" height=18>
                        <td align=center class="td">&nbsp;IIS�汾</td>
                        <td class="td">&nbsp;<%=Request.ServerVariables("SERVER_SOFTWARE")%></td>
                      </tr>
                      <tr bgcolor="#E8F1FF" height=18>
                        <td align=center class="td">&nbsp;�ű���ʱʱ��</td>
                        <td class="td">&nbsp;<%=Server.ScriptTimeout%> ��</td>
                      </tr>
                      <tr bgcolor="#E8F1FF" height=18>
                        <td align=center class="td">&nbsp;���ļ�·��</td>
                        <td class="td">&nbsp;<%=server.mappath(Request.ServerVariables("SCRIPT_NAME"))%></td>
                      </tr>
                      <tr bgcolor="#E8F1FF" height=18>
                        <td align=center class="td">&nbsp;������CPU����</td>
                        <td class="td">&nbsp;<%=Request.ServerVariables("NUMBER_OF_PROCESSORS")%> ��</td>
                      </tr>
                      <tr bgcolor="#E8F1FF" height=18>
                        <td align=center class="td">&nbsp;��������������</td>
                        <td class="td">&nbsp;<%=ScriptEngine & "/"& ScriptEngineMajorVersion &"."&ScriptEngineMinorVersion&"."& ScriptEngineBuildVersion %></td>
                      </tr>
                      <tr bgcolor="#E8F1FF" height=18>
                        <td align=center class="td">&nbsp;����������ϵͳ</td>
                        <td class="td">&nbsp;<%=Request.ServerVariables("OS")%></td>
                      </tr>
                  </table>
                  <table width="100%" border="0" cellpadding="0" cellspacing="1" class="table" style="border-collapse: collapse">
                <tr>
                  <td colspan="2" align="center" class="td2"><%
	Dim strClass
	strClass = Trim(Request.Form("classname"))
	If "" <> strClass then
	Response.Write "<br>��ָ��������ļ������"
	ObjTest(strClass)
	  If Not IsObj then 
		Response.Write "<br><font color=red>���ź����÷�������֧�� " & strclass & " �����</font>"
	  Else
		Response.Write "<br><font class=fonts>��ϲ���÷�����֧�� " & strclass & " �����������汾�ǣ�" & VerObj & "</font>"
	  End If
	  Response.Write "<br>"
	end if
	%>
�� IIS�Դ���ASP��� ��</td>
                  </tr>
                <tr height=18 class=backs align=center>
                  <td width=320 class="td">�� �� �� ��</td>
                  <td width=130 class="td">֧�ּ��汾</td>
                </tr>
                <%For i=0 to 10%>
                <tr>
                  <td align=left class="td">&nbsp;<%=ObjTotest(i,0) & "<font color=#888888>&nbsp;" & ObjTotest(i,1)%></td>
                  <td align=left class="td">&nbsp;
              <%
		If Not ObjTotest(i,2) Then 
			Response.Write "<font color=red><b>��</b></font>"
		Else
			Response.Write "<font class=fonts><b>��</b></font> <a title='" & ObjTotest(i,3) & "'>" & left(ObjTotest(i,3),11) & "</a>"
		End If%></td>
                </tr>
                <%next%>
              </table>
                  <table width="100%" border="0" cellpadding="0" cellspacing="1" class="table">
                <tr align=center>
                  <td colspan="2" class="td2">�� �������ļ��ϴ��͹������ �� </td>
                  </tr>
                <tr align=center>
                  <td width=320 class="td">�� �� �� ��</td>
                  <td width=130 class="td">֧�ּ��汾</td>
                </tr>
                <%For i=11 to 15%>
                <tr >
                  <td align=left class="td">&nbsp;<%=ObjTotest(i,0) & "<font color=#888888>&nbsp;" & ObjTotest(i,1)%></td>
                  <td align=left class="td">&nbsp;
              <%
		If Not ObjTotest(i,2) Then 
			Response.Write "<font color=red><b>��</b></font>"
		Else
			Response.Write "<font class=fonts><b>��</b></font> <a title='" & ObjTotest(i,3) & "'>" & left(ObjTotest(i,3),11) & "</a>"
		End If%></td>
                </tr>
                <%next%>
              </table>
                  <table width="100%" border="0" cellpadding="0" cellspacing="1" class="table">
                <tr>
                  <td colspan="2" align="center" class="td2">�� �������շ��ʼ���� ��</td>
                  </tr>
                <tr>
                  <td width=320 class="td">�� �� �� ��</td>
                  <td width=130 class="td">֧�ּ��汾</td>
                </tr>
                <%For i=16 to 23%>
                <tr>
                  <td align=left class="td">&nbsp;<%=ObjTotest(i,0) & "<font color=#888888>&nbsp;" & ObjTotest(i,1)%></td>
                  <td align=left class="td">&nbsp;
              <%
		If Not ObjTotest(i,2) Then 
			Response.Write "<font color=red><b>��</b></font>"
		Else
			Response.Write "<font class=fonts><b>��</b></font> <a title='" & ObjTotest(i,3) & "'>" & left(ObjTotest(i,3),11) & "</a>"
		End If%></td>
                </tr>
                <%next%>
              </table>
                  <table width="100%" border="0" cellpadding="0" cellspacing="1" class="table">
                <tr>
                  <td colspan="2" align="center" class="td2">�� ͼ������� ��</td>
                  </tr>
                <tr>
                  <td width=320 class="td">�� �� �� ��</td>
                  <td width=130 class="td">֧�ּ��汾</td>
                </tr>
                <%For i=24 to 25%>
                <tr>
                  <td height="39" align=left class="td">&nbsp;<%=ObjTotest(i,0) & "<font color=#888888>&nbsp;" & ObjTotest(i,1)%></td>
                  <td align=left class="td">&nbsp;
              <%
		If Not ObjTotest(i,2) Then 
			Response.Write "<font color=red><b>��</b></font>"
		Else
			Response.Write "<font class=fonts><b>��</b></font> <a title='" & ObjTotest(i,3) & "'>" & left(ObjTotest(i,3),11) & "</a>"
		End If%></td>
                </tr>
                <%next%>
              </table>
              <table width="100%" border="0" cellpadding="0" cellspacing="1" class="table">
                <form action=<%=Request.ServerVariables("SCRIPT_NAME")%> method=post id=form1 name=form1>
              
                </form>
              </table>
              <table width="100%" border="0" cellpadding="0" cellspacing="1" class="table">
                <tr align=center>
                  <td colspan="2" class="td2">�� ASP�ű����ͺ������ٶȲ��� ��<br>
�����÷�����ִ��50��Ρ�1��1���ļ��㣬��¼����ʹ�õ�ʱ�䡣</td>
                  </tr>
                <tr align=center>
                  <td width=351 class="td">��&nbsp;&nbsp;&nbsp;��&nbsp;&nbsp;&nbsp;��</td>
                  <td width=142 class="td">���ʱ��</td>
                </tr>
                <form action="<%=Request.ServerVariables("SCRIPT_NAME")%>" method=post>
                  <%
	
	dim t1,t2,lsabc,thetime
	t1=timer
	for i=1 to 500000
		lsabc= 1 + 1
	next
	t2=timer

	thetime=cstr(int(( (t2-t1)*10000 )+0.5)/10)
%>
                  <tr height=18>
                    <td width="351" align=left class="td">&nbsp;<font color=red>������ʹ�õ���̨������</font>&nbsp;</td>
                    <td width="142" class="td">&nbsp;<font color=red><%=thetime%> ����</font></td>
                  </tr>
                </form>
              </table>
			  </td>
          </tr>
        </table>
          <br></td>
        <td width="15" background="MCT/main_5.gif">&nbsp;</td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="52"><img src="MCT/main_6.gif" width="52" height="16"></td>
        <td background="MCT/main_7.gif">&nbsp;</td>
        <td width="52"><img src="MCT/main_8.gif" width="52" height="16"></td>
      </tr>
    </table></td>
  </tr>
</table>
</body>
</html>