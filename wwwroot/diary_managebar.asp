|&nbsp;<a href='' onclick='window.open("diary_calendar.asp?DiaryOwner=<%=DiaryOwner%>","win_user","width=480,height=330,left=200,top=120");return false;' title=������ѡ��鿴�ռ�����>ѡ���ռ�ʱ��</a>
|&nbsp;<a href="diary_index.asp?DiaryOwner=">���������ռ�</a>
<%if CurrentLoginUser<>empty then
	response.write("|&nbsp;<a href=diary_index.asp?DiaryOwner="&CurrentLoginUser&">�鿴�ҵ��ռ�</a>&nbsp;")
	response.write("|&nbsp;<a href=diary_add.asp title=�����Լ��������ռ�>д�ռ�</a>")
end if%>
|&nbsp;<a href="userlist.asp" title=���������˵��ռ� target="_blank">�����ռ��б�</a>
<%if CurrentLoginUser=empty then
	response.write("|&nbsp;<a href="&sysRegFile&" title=ע���������Լ����ռǱ�>��δע�ᷲ��</a>&nbsp;")
	response.write("|&nbsp;<a href="&sysLoginFile&" title=��¼�������Լ����ռǱ�>��δ��¼</a>")
else
	response.write("|&nbsp;<a href="&sysLogoutFile&" title=�˳��Լ����ռǱ�>�˳���¼</a>")
end if%>
|