<!--#include file="Inc/syscode_Photo.asp"-->
<%
'����Ķ����������д���
const ChannelID=4
PageTitle="�鿴ͼƬ"
FoundErr=False
if rs("PhotoLevel")<=999 then
	if UserLogined<>True then
		FoundErr=True
		ErrMsg=ErrMsg & "�Բ��𣬱�ͼƬΪ�շ�ͼƬ��Ҫ�������Ǳ�վ��ע���û��������ͣ�<br>����ûע�����û�е�¼�����Բ������ͱ�ͼƬ����Ͻ� <a href='User_Reg.asp'><font color=red><b>ע��</b></font></a> �� <a href='User_Login.asp'><font color=red><b>��¼</a></font></a>�ɣ�"
	else
		if UserLevel>rs("PhotoLevel") then
			FoundErr=True
			ErrMsg=ErrMsg & "�Բ��𣬱�ͼƬΪ�շ�ͼƬ������ֻ�� <font color=blue>"
			if rs("PhotoLevel")=999 then
				ErrMsg=ErrMsg & "ע���û�"
			elseif rs("PhotoLevel")=99 then
				ErrMsg=ErrMsg & "�շ��û�"
			elseif rs("PhotoLevel")=9 then
				ErrMsg=ErrMsg & "VIP�û�"
			elseif rs("PhotoLevel")=5 then
				ErrMsg=ErrMsg & "����Ա"
			end if
			ErrMsg=ErrMsg & "������û�</font> �������͡���Ŀǰ��Ȩ�޼��𲻹������Բ������͡�"
		else
			if ChargeType=1 and rs("PhotoPoint")>0 then
				if Request.Cookies("asp163")("Pay_Photo" & PhotoID)<>"yes" then
					if UserPoint<rs("PhotoPoint") then
						FoundErr=True
						ErrMsg=ErrMsg &"�Բ��𣬱�ͼƬΪ�շ�ͼƬ���������ͱ�ͼƬ��Ҫ���� <b><font color=red>" & rs("PhotoPoint") & "</font></b> �㣡"
						ErrMsg=ErrMsg &"����Ŀǰֻ�� <b><font color=blue>" & UserPoint & "</font></b> ����á��������㣬�޷����ͱ�ͼƬ������������ϵ���г�ֵ��"
					else
						if lcase(trim(request("Pay")))="yes" then
							Conn_User.execute "update " & db_User_Table & " set " & db_User_UserPoint & "=" & db_User_UserPoint & "-" & rs("PhotoPoint") & " where " & db_User_Name & "='" & UserName & "'"
							response.Cookies("asp163")("Pay_Photo" & PhotoID)="yes"
						else
							FoundErr=True
							ErrMsg=ErrMsg & "<font color=red><b>ע��</b></font>�����ͱ�ͼƬ��Ҫ���� <font color=red><b>" & rs("PhotoPoint") & "</b></font>"
							ErrMsg=ErrMsg &"��Ŀǰ���� <b><font color=blue>" & UserPoint & "</font></b> ����á��Ķ����ĺ��㽫ʣ�� <b><font color=green>" & UserPoint-rs("PhotoPoint") & "</font></b> ��"
							ErrMsg=ErrMsg &"<br><br>��ȷʵԸ�⻨�� <b><font color=red>" & rs("PhotoPoint") & "</font></b> �������ͱ�ͼƬ��"
							ErrMsg=ErrMsg &"<br><br><a href='Photo_View.asp?Pay=yes&UrlID=" & UrlID & "&PhotoID=" & PhotoID & "'>��Ը��</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href='index.asp'>�Ҳ�Ը��</a></p>"
						end if
					end if
				end if
			elseif ChargeType=2 then
				if ValidDays<=0 then
					FoundErr=True
					ErrMsg=ErrMsg & "<font color=red>�Բ��𣬱�ͼƬΪ�շ�ͼƬ����������Ч���Ѿ����ڣ������޷����ͱ�ͼƬ������������ϵ���г�ֵ��</font>"
				end if
			end if
		end if
	end if							
end if
if FoundErr=True then
	response.write ErrMsg
else
%>
<html>
<head>
<title><%=PhotoTitle%></title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style type="text/css">
body {CURSOR: url('images/hmove.cur')}
</style>
<SCRIPT language=JavaScript>
drag = 0
move = 0
function init() {
    window.document.onmousemove = mouseMove
    window.document.onmousedown = mouseDown
    window.document.onmouseup = mouseUp
    window.document.ondragstart = mouseStop
}
function mouseDown() {
    if (drag) {
        clickleft = window.event.x - parseInt(dragObj.style.left)
        clicktop = window.event.y - parseInt(dragObj.style.top)
        dragObj.style.zIndex += 1
        move = 1
    }
}
function mouseStop() {
    window.event.returnValue = false
}
function mouseMove() {
    if (move) {
        dragObj.style.left = window.event.x - clickleft
        dragObj.style.top = window.event.y - clicktop
    }
}
function mouseUp() {
    move = 0
}
</SCRIPT>
<script language="JavaScript" type="text/JavaScript">
<!--
function MM_reloadPage(init) {  //reloads the window if Nav4 resized
  if (init==true) with (navigator) {if ((appName=="Netscape")&&(parseInt(appVersion)==4)) {
    document.MM_pgW=innerWidth; document.MM_pgH=innerHeight; onresize=MM_reloadPage; }}
  else if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) location.reload();
}
MM_reloadPage(true);
//-->
</script>
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="init()">
<noscript><iframe src=*></iframe></noscript>
<%
dim UrlID
UrlID=trim(request("UrlID"))
if UrlID="" then
	UrlID=1
else
	UrlID=Cint(UrlID)
end if
if UrlID=1 then
	response.write "<div id='hiddenPic' style='position:absolute; left:433px; top:258px; width:77px; height:91px; z-index:1; visibility: hidden;'><img name='images2' src='" & rs("PhotoUrl") & "' border='0'></div>"
	response.write "<div id='block1' onmouseout='drag=0' onmouseover='dragObj=block1; drag=1;' style='z-index:10; height: 60; left: 0; position: absolute; top: 0; width: 120'><dd><img name='images1' src='" & rs("PhotoUrl") & "' border='0'></dd></div>"
else
	if UrlID>4 then
		response.write "��ַ��������"
	else
		if rs("PhotoUrl" & UrlID)="" then
			response.write "��ַ����!"
		else
			response.write "<div id='hiddenPic' style='position:absolute; left:433px; top:258px; width:77px; height:91px; z-index:1; visibility: hidden;'><img name='images2' src='" & rs("PhotoUrl" & UrlID) & "' border='0'></div>"
			response.write "<div id='block1' onmouseout='drag=0' onmouseover='dragObj=block1; drag=1;' style='z-index:10; height: 60; left: 0; position: absolute; top: 0; width: 120'><dd><img name='images1' src='" & rs("PhotoUrl" & UrlID) & "' border='0'></dd></div>"
		end if
	end if
end if
%>
</body>
</html>
<%
end if
rs.close
set rs=nothing
call CloseConn()
%>