<!--#include file="Inc/syscode_diary.asp"-->
<%
'********************************************************************
'�ռǵ��ó���
'���÷�����<script language=javascript src="Diary_js.asp?Num=1&leastLen=30&showLen=200&Owner=ɽ��&showMore=true"> < /script>
'����˵����	Num�����ռ�����
'			leastLen�����ռ���̳���
'			showLen������ʾ�ռ����ݳ��ȣ�
'			Owner�����û�������дΪȫ��;
'			showMore�����Ƿ���ʾ�������ռǡ�����
'********************************************************************
dim diaryNum,diaryLen,leastLen,showMore,strTempDiary
diaryOwner=trim(request("Owner"))
diaryNum=cint(request("Num"))
diaryLen=cint(request("showLen"))
leastLen=cint(request("leastLen"))
showMore=lcase(trim(request("showMore")))
if diaryNum<1 or diaryNum>10 then diaryNum=1
if diaryLen<10 or diaryLen>500 then diaryLen=100
if leastLen<10 or leastLen>500 then leastLen=20
if diaryOwner="" then
	sql="select top "&diaryNum&" * from diary where len(diarycontent)>"&leastLen&" and secret<=9 order by addtime desc"
else
	sql="select top "&diaryNum&" * from diary where diaryOwner='"&diaryOwner&"' and len(diarycontent)>"&leastLen&" and secret<=9 order by addtime desc"
end if
set rs=server.createobject("adodb.recordset")
rs.open sql,conn_user,1,1
do while not rs.EOF
	strTempDiary = strTempDiary & "<br><div align=left><img src='diary_images/dia-b-icon.gif' align='absmiddle'> <b>"&rs("diaryOwner")&"</b> <img src='diary_images/"&rs("mood")&"' align=absmiddle>&nbsp;&nbsp;&nbsp;&nbsp;<font color='#999966'>("&formatdatetime(rs("addtime"),2)&")</font></div>"
	strTempDiary = strTempDiary & "<a target=_blank href='/diary_show.asp?diaryid="&rs("id")&"' TITLE='�����鿴��ϸ����'>"&replace(left(rs("diaryContent"),diaryLen),"<BR><BR>","<br>")&"��</a><br>"
	rs.MoveNext
loop
if showMore="true" then strTempDiary = strTempDiary & "<div align=right> <a href=/diary_index.asp?diaryOwner="&diaryOwner&">�����ռ�...</a></div>"
strTempDiary ="document.write(""" & strTempDiary & """);"
response.write strTempDiary

rs.Close
set rs=nothing
conn_user.close
set conn_user = nothing
%>

  