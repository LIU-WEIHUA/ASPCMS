<%@language=vbscript codepage=936 %>
<%
option explicit
response.buffer=true
'ǿ����������·��ʷ���������ҳ�棬�����Ǵӻ����ȡҳ��
Response.Buffer = True
Response.Expires = -1
Response.ExpiresAbsolute = Now() - 1
Response.Expires = 0
Response.CacheControl = "no-cache"
%>
<!--#include file="conn.asp"-->
<!--#include file="Conn_User.asp"-->
<!--#include file="config.asp"-->
<!--#include file="function.asp"-->
<%
dim strChannel,sqlChannel,rsChannel,ChannelUrl,ChannelName
dim strFileName,MaxPerPage,totalPut,CurrentPage,TotalPages
dim BeginTime,EndTime,founderr,errmsg,i
dim rs,sql,rsUser,sqlUser
dim PageTitle,strPath,strPageTitle
dim SkinID,ClassID,AnnounceCount
'***********************************************************************************************
strPath= "&nbsp;�����ڵ�λ�ã�&nbsp;<a href='" & SiteUrl & "'>" & SiteName & "</a>"
strPageTitle= SiteTitle
if ShowSiteChannel="Yes" then
	strChannel= "|&nbsp;"
	sqlChannel="select * from Channel order by OrderID"
	set rsChannel=server.CreateObject("adodb.recordset")
	rsChannel.open sqlChannel,conn,1,1
	do while not rsChannel.eof
		if rsChannel("ChannelID")=ChannelID then
			ChannelUrl=rsChannel("LinkUrl")
			ChannelName=rsChannel("ChannelName")
			strChannel=strChannel & "<a href='" & ChannelUrl & "'><font color=red>" & ChannelName & "</font></a>&nbsp;|&nbsp;"
		else
			strChannel=strChannel & "<a href='" & rsChannel("LinkUrl") & "'>" & rsChannel("ChannelName") & "</a>&nbsp;|&nbsp;"
		end if
		rsChannel.movenext
	loop
	rsChannel.close
	set rsChannel=nothing
	if CurrentLoginUser<>empty then
			strChannel=strChannel & "<a href='' onclick='window.open(""userinfo_center.asp"",""win_user"",""width=180,height=300,left=580,top=120"");return false;'><font color=red>�û��������</font></a>&nbsp;|&nbsp;"
	end if
	strPath=strPath & "&nbsp;&gt;&gt;&nbsp;<a href='" & ChannelUrl & "'>" & ChannelName & "</a>"
	strPageTitle=strPageTitle & " >> " & ChannelName
end if
BeginTime=Timer
ClassID=0

' ����Ķ����������д���
const ChannelID=8
Const ShowRunTime="Yes"
MaxPerPage=8
SkinID=0

'========== ɽ����û��ռǱ����ϵͳ��������������ϵͳʵ������޸� ============'
dim sysRegFile, sysLoginFile, sysLogoutFile, CurrentLoginUser, DiaryOwner
sysRegFile		= "user_reg.asp"												'�����û�ע���ļ�
sysLoginFile	= "user_login.asp"												'�����û���¼�ļ�
sysLogoutFile	= "user_logout.asp"												'�����û��˳��ļ�
CurrentLoginUser=request.cookies("asp163")("username")							'��ǰ�Ѿ���¼�û���
Const bgNum=30																	'����ͼƬ����








'========= ɽ����û��ռǱ����ϵͳ���룬�����ASP���Ǻ���Ϥ��������� =========
DiaryOwner=trim(request("DiaryOwner"))
if instr(DiaryOwner,"'")>0 or instr(DiaryOwner," ")>0 then
	response.write ("�û����Ƿ���")
	response.end
end if

'==================================
'��������getRndBg()
'�����ܣ�����������
'==================================
dim strRndBg
function getRndBg()
	Randomize() '��ʼ���������������
	strRndBg = 1+Int((bgNum-1) * Rnd)
	if len(strRndBg)=1 then strRndBg="0"&strRndBg
	strRndBg="diary_images/back/"&strRndBg&".gif"
end function
%>

