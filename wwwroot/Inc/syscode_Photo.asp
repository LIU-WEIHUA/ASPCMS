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
<!--#include file="ubbcode.asp"-->
<!--#include file="function.asp"-->
<!--#include file="admin_code_Photo.asp"-->
<!--'********************�����ӵĴ���********************-->
<!--#include file="../sms_function.asp"-->
<!--'********************�����������********************-->
<%
dim strChannel,sqlChannel,rsChannel,ChannelUrl,ChannelName
dim PhotoID,PhotoTitle
dim FileName,strFileName,MaxPerPage,ShowSmallClassType
dim totalPut,CurrentPage,TotalPages
dim BeginTime,EndTime
dim founderr, errmsg
dim ClassID,SpecialID,keyword,strField,SpecialName
dim rs,sql,sqlPhoto,rsPhoto,sqlSearch,rsSearch,rsPic,sqlSpecial,rsSpecial,sqlUser,rsUser
dim tClass,ClassName,RootID,ParentID,Depth,ParentPath,Child,SkinID,LayoutID,LayoutFileName,ChildID,tID,tChild
dim tSpecial
dim strPic,AnnounceCount
dim PageTitle,strPath,strPageTitle
dim strClassTree

BeginTime=Timer
PhotoID=trim(request("PhotoID"))
ClassID=trim(request("ClassID"))
SpecialID=trim(request("SpecialID"))
strField=trim(request("Field"))
keyword=trim(request("keyword"))
UserLogined=CheckUserLogined()

if PhotoId="" then
	PhotoID=0
else
	PhotoID=Clng(PhotoID)
end if
if ClassID<>"" then
	ClassID=CLng(ClassID)
else
	ClassID=0
end if
if SpecialID="" then
	SpecialID=0
else
	SpecialID=CLng(SpecialID)
end if
if UserLevel="" then
	UserLevel=5000
else
	UserLevel=Cint(UserLevel)
end if
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
	strPath=strPath & "&nbsp;&gt;&gt;&nbsp;<a href='" & ChannelUrl & "'>" & ChannelName & "</a>"
	strPageTitle=strPageTitle & " >> " & ChannelName
end if

if PhotoID>0 then
	sql="select * from Photo where PhotoID=" & PhotoID & ""
	Set rs= Server.CreateObject("ADODB.Recordset")
	rs.open sql,conn,1,3
	if rs.bof and rs.eof then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>��Ҫ�ҵ�ͼƬ�����ڣ������Ѿ�������Աɾ����</li>"
	else	
		ClassID=rs("ClassID")
		'SpecialID=rs("SpecialID")
		'SkinID=rs("SkinID")
		'LayoutID=rs("LayoutID")
		PhotoTitle=rs("PhotoName")
	end if
end if

if ClassID>0 then
	sql="select C.ClassName,C.RootID,C.ParentID,C.Depth,C.ParentPath,C.Child,C.SkinID,L.LayoutID,L.LayoutFileName,C.BrowsePurview From PhotoClass C"
	sql=sql & " inner join Layout L on C.LayoutID=L.LayoutID where C.ClassID=" & ClassID
	set tClass=conn.execute(sql)
	if tClass.bof and tClass.eof then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>�Ҳ���ָ������Ŀ</li>"
		Call WriteErrMsg()
		response.end
	else
		if tClass(9)<UserLevel then
			FoundErr=True
			ErrMsg=ErrMsg & "<br><li>�Բ�����û���������Ŀ��Ȩ�ޣ�</li>"
			ErrMsg=ErrMsg & "�㲻��" & CheckLevel(tClass(9)) & "��"
			Call WriteErrMsg()
			response.end
		else
			ClassName=tClass(0)
			RootID=tClass(1)
			ParentID=tClass(2)
			Depth=tClass(3)
			ParentPath=tClass(4)
			Child=tClass(5)
			if PhotoID<=0 then
				SkinID=tClass(6)
				LayoutID=tClass(7)
			end if
			LayoutFileName=tClass(8)

			strPath=strPath & "&nbsp;&gt;&gt;&nbsp;"
			strPageTitle=strPageTitle & " >> "
			if ParentID>0 then
				dim sqlPath,rsPath
				sqlPath="select PhotoClass.ClassID,PhotoClass.ClassName,Layout.LayoutFileName,Layout.LayoutID From PhotoClass"
				sqlPath= sqlPath & " inner join Layout on PhotoClass.LayoutID=Layout.LayoutID where PhotoClass.ClassID in (" & ParentPath & ") order by PhotoClass.Depth"
				set rsPath=server.createobject("adodb.recordset")
				rsPath.open sqlPath,conn,1,1
				do while not rsPath.eof
					strPath=strPath & "<a href='" & rsPath(2) & "?ClassID=" & rsPath(0) & "&LayoutID=" & rsPath(3) & "'>" & rsPath(1) & "</a>&nbsp;&gt;&gt;&nbsp;"
					strPageTitle=strPageTitle & rsPath(1) & " >> "
					rsPath.movenext
				loop
				rsPath.close
				set rsPath=nothing
			end if
			strPath=strPath & "<a href='" & LayoutFileName & "?ClassID=" & ClassID & "'>" & ClassName & "</a>"
			strPageTitle=strPageTitle & ClassName
		end if	
	end if
end if
if SpecialID>0 then
	sql="select S.SpecialID,S.SpecialName,S.SkinID,S.LayoutID,L.LayoutFileName,S.BrowsePurview from Special S inner join Layout L on L.LayoutID=S.LayoutID where S.SpecialID=" & SpecialID
	set tSpecial=conn.execute(sql)
	if tSpecial.bof and tSpecial.eof then
		founderr=True
		ErrMsg=ErrMsg & "<br><li>�Ҳ���ָ������Ŀ</li>"
		Call WriteErrMsg()
		response.end
	else
		if tSpecial(5)<UserLevel then
			FoundErr=True
			ErrMsg=ErrMsg & "<br><li>�Բ�����û�������ר���Ȩ�ޣ�</li>"
			ErrMsg=ErrMsg & "�㲻��" & CheckLevel(tSpecial(5)) & "��"
			Call WriteErrMsg()
			response.end
		else
			SpecialName=tSpecial(1)
			if PhotoID<=0 then
				SkinID=tSpecial(2)
				LayoutID=tSpecial(3)
			end if
			LayoutFilename=tSpecial(4)
			
			strPath=strPath & "&nbsp;&gt;&gt;&nbsp;<font color=blue>[ר��]</font><a href='" & tSpecial(4) & "?SpecialID=" & tSpecial(0) & "'>" & SpecialName & "</a>"
			strPageTitle=strPageTitle & " >> [ר��]" & SpecialName
		end if
	end if
end if
	
if keyword<>"" then 
	keyword=ReplaceBadChar(keyword)
end if

if request("page")<>"" then
    currentPage=cint(request("page"))
else
	currentPage=1
end if

'=================================================
'��������ShowRootClass
'��  �ã���ʾһ����Ŀ��������Ч����
'��  ������
'=================================================
sub ShowRootClass()
	dim sqlRoot,rsRoot
	sqlRoot="select C.ClassID,C.ClassName,C.RootID,L.LayoutFileName,C.LinkUrl From PhotoClass C"
	sqlRoot= sqlRoot & " inner join Layout L on C.LayoutID=L.LayoutID where C.ParentID=0 and C.ShowOnTop=True order by C.RootID"
	Set rsRoot= Server.CreateObject("ADODB.Recordset")
	rsRoot.open sqlRoot,conn,1,1
	if rsRoot.bof and rsRoot.eof then 
		response.Write("��û���κ���Ŀ�������������Ŀ��")
	else
		if ClassID>0 then
			response.write "|<a href='" & ChannelUrl & "'>&nbsp;"&ChannelName&"��ҳ&nbsp;</a>|"
		else
			response.write "|<a href='" & ChannelUrl & "'><font color=red>&nbsp;"&ChannelName&"��ҳ&nbsp;</font></a>|"
		end if
		do while not rsRoot.eof
			if rsRoot(4)<>"" then
				response.write "<a href='" & rsRoot(4) & "'>&nbsp;" & rsRoot(1) & "&nbsp;</a>|"
			else
				if rsRoot(2)=RootID then
					response.Write "<a href='" & rsRoot(3) & "?ClassID=" & rsRoot(0) & "'><font color=red>&nbsp;" & rsRoot(1) & "</font>&nbsp;</a>|"
				else
					response.Write "<a href='" & rsRoot(3) & "?ClassID=" & rsRoot(0) & "'>&nbsp;" & rsRoot(1) & "&nbsp;</a>|"
				end if
			end if
			rsRoot.movenext
		loop
	end if
	rsRoot.close
	set rsRoot=nothing
	if ShowMyStyle="Yes" then
		response.write "<a href='#' onMouseOver='ShowMenu(menu_skin,100)'>&nbsp;��ѡ���&nbsp;</a>|"
	end if
end sub

dim pNum,pNum2
pNum=1
pNum2=0
'=================================================
'��������ShowRootClass_Menu
'��  �ã���ʾһ����Ŀ�������˵�Ч����
'��  ������
'=================================================
sub ShowRootClass_Menu()
	response.write "<script type='text/javascript' language='JavaScript1.2'>" & vbcrlf & "<!--" & vbcrlf
	response.write "stm_bm(['uueoehr',400,'','images/blank.gif',0,'','',0,0,0,0,0,1,0,0]);" & vbcrlf
	response.write "stm_bp('p0',[0,4,0,0,2,2,0,0,100,'',-2,'',-2,90,0,0,'#000000','transparent','',3,0,0,'#000000']);" & vbcrlf
	response.write "stm_ai('p0i0',[0,'|','','',-1,-1,0,'','_self','','','','',0,0,0,'','',0,0,0,0,1,'#f1f2ee',1,'#cccccc',1,'','',3,3,0,0,'#fffff7','#000000','#000000','#000000','9pt ����','9pt ����',0,0]);" & vbcrlf
	response.write "stm_aix('p0i1','p0i0',[0,'"&ChannelName&"��ҳ','','',-1,-1,0,'" & ChannelUrl & "','_self','" & ChannelUrl & "','','','',0,0,0,'','',0,0,0,0,1,'#f1f2ee',1,'#cccccc',1,'','',3,3,0,0,'#fffff7','#ff0000','#000000','#cc0000','9pt ����','9pt ����']);" & vbcrlf
	response.write "stm_aix('p0i2','p0i0',[0,'|','','',-1,-1,0,'','_self','','','','',0,0,0,'','',0,0,0,0,1,'#f1f2ee',1,'#cccccc',1,'','',3,3,0,0,'#fffff7','#000000','#000000','#000000','9pt ����','9pt ����',0,0]);" & vbcrlf

	dim sqlRoot,rsRoot,j
	sqlRoot="select C.ClassID,C.ClassName,C.Depth,L.LayoutFileName,C.NextID,C.LinkUrl,C.Child,C.Readme From PhotoClass C"
	sqlRoot= sqlRoot & " inner join Layout L on C.LayoutID=L.LayoutID where C.Depth=0 and C.ShowOnTop=True order by C.RootID"
	Set rsRoot= Server.CreateObject("ADODB.Recordset")
	rsRoot.open sqlRoot,conn,1,1
	if not(rsRoot.bof and rsRoot.eof) then 
		j=3
		do while not rsRoot.eof
			if rsRoot(5)<>"" then
				response.write "stm_aix('p0i"&j&"','p0i0',[0,'" & rsRoot(1) & "','','',-1,-1,0,'" & rsRoot(5) & "','_blank','" & rsRoot(5) & "','" & rsRoot(7) & "','','',0,0,0,'','',0,0,0,0,1,'#f1f2ee',1,'#cccccc',1,'','',3,3,0,0,'#fffff7','#ff0000','#000000','#cc0000','9pt ����','9pt ����']);" & vbcrlf
			else
				response.write "stm_aix('p0i"&j&"','p0i0',[0,'" & rsRoot(1) & "','','',-1,-1,0,'" & rsRoot(3) & "?ClassID=" & rsRoot(0) & "','_self','" & rsRoot(3) & "?ClassID=" & rsRoot(0) & "','" & rsRoot(7) & "','','',0,0,0,'','',0,0,0,0,1,'#f1f2ee',1,'#cccccc',1,'','',3,3,0,0,'#fffff7','#ff0000','#000000','#cc0000','9pt ����','9pt ����']);" & vbcrlf
			end if
			if rsRoot(6)>0 then
				call GetClassMenu(rsRoot(0),0)
			end if
			j=j+1
			response.write "stm_aix('p0i2','p0i0',[0,'|','','',-1,-1,0,'','_self','','','','',0,0,0,'','',0,0,0,0,1,'#f1f2ee',1,'#cccccc',1,'','',3,3,0,0,'#fffff7','#000000','#000000','#000000','9pt ����','9pt ����',0,0]);" & vbcrlf
			j=j+1
			rsRoot.movenext
		loop
	end if
	rsRoot.close
	set rsRoot=nothing
	response.write "stm_em();" & vbcrlf
	response.write "//-->" & vbcrlf & "</script>" & vbcrlf
end sub

sub GetClassMenu(ID,ShowType)
	dim sqlClass,rsClass,k
	
	if pNum=1 then
		response.write "stm_bp('p" & pNum & "',[1,4,0,0,2,3,6,7,100,'progid:DXImageTransform.Microsoft.Fade(overlap=.5,enabled=0,Duration=0.43)',-2,'',-2,67,2,3,'#999999','#ffffff','',3,1,1,'#aca899']);" & vbcrlf
	else
		if ShowType=0 then
			response.write "stm_bpx('p" & pNum & "','p" & pNum2 & "',[1,4,0,0,2,3,6]);" & vbcrlf
		else
			response.write "stm_bpx('p" & pNum & "','p" & pNum2 & "',[1,2,-2,-3,2,3,0]);" & vbcrlf
		end if
	end if
	
	k=0
	sqlClass="select C.ClassID,C.ClassName,C.Depth,L.LayoutFileName,C.NextID,C.LinkUrl,C.Child,C.Readme From PhotoClass C"
	sqlClass= sqlClass & " inner join Layout L on C.LayoutID=L.LayoutID where C.ParentID=" & ID & " order by C.OrderID asc"
	Set rsClass= Server.CreateObject("ADODB.Recordset")
	rsClass.open sqlClass,conn,1,1
	do while not rsClass.eof
		if rsClass(5)<>"" then
			if rsClass(6)>0 then
				response.write "stm_aix('p"&pNum&"i"&k&"','p"&pNum2&"i0',[0,'" & rsClass(1) & "','','',-1,-1,0,'" & rsClass(5) & "','_blank','" & rsClass(5) & "','" & rsClass(7) & "','','',6,0,0,'images/arrow_r.gif','images/arrow_w.gif',7,7,0,0,1,'#ffffff',0,'#cccccc',0,'','',3,3,0,0,'#fffff7','#000000','#000000','#ffffff','9pt ����']);" & vbcrlf
				pNum=pNum+1
				pNum2=pNum2+1
				call GetClassMenu(rsClass(0),1)
			else
				response.write "stm_aix('p"&pNum&"i"&k&"','p"&pNum2&"i0',[0,'" & rsClass(1) & "','','',-1,-1,0,'" & rsClass(5) & "','_blank','" & rsClass(5) & "','" & rsClass(7) & "','','',0,0,0,'','',0,0,0,0,1,'#f1f2ee',1,'#cccccc',0,'','',3,3,0,0,'#fffff7','#ff0000','#000000','#cc0000','9pt ����']);" & vbcrlf
			end if
		else
			if rsClass(6)>0 then
				response.write "stm_aix('p"&pNum&"i"&k&"','p"&pNum2&"i0',[0,'" & rsClass(1) & "','','',-1,-1,0,'" & rsClass(3) & "?ClassID=" & rsClass(0) & "','_self','" & rsClass(3) & "?ClassID=" & rsClass(0) & "','" & rsClass(7) & "','','',6,0,0,'images/arrow_r.gif','images/arrow_w.gif',7,7,0,0,1,'#ffffff',0,'#cccccc',0,'','',3,3,0,0,'#fffff7','#000000','#000000','#ffffff','9pt ����']);" & vbcrlf
				pNum=pNum+1
				pNum2=pNum2+1
				call GetClassMenu(rsClass(0),1)
			else
				response.write "stm_aix('p"&pNum&"i"&k&"','p"&pNum2&"i0',[0,'" & rsClass(1) & "','','',-1,-1,0,'" & rsClass(3) & "?ClassID=" & rsClass(0) & "','_self','" & rsClass(3) & "?ClassID=" & rsClass(0) & "','" & rsClass(7) & "','','',0,0,0,'','',0,0,0,0,1,'#f1f2ee',1,'#cccccc',0,'','',3,3,0,0,'#fffff7','#ff0000','#000000','#cc0000','9pt ����']);" & vbcrlf
			end if
		end if
		k=k+1
		rsClass.movenext
	loop
	rsClass.close
	set rsClass=nothing
	response.write "stm_ep();" & vbcrlf
end sub

'=================================================
'��������ShowJumpClass
'��  �ã���ʾ����ת��Ŀ�����������б��
'��  ������
'=================================================
sub ShowJumpClass()
	response.write "<div z-index:1><select name='ClassID' onchange=""if(this.options[this.selectedIndex].value!=''){location=this.options[this.selectedIndex].value;}"">"
    response.write "<option value='' selected>��ת��Ŀ����</option>"
	dim arrShowLine(20)
	for i=0 to ubound(arrShowLine)
		arrShowLine(i)=False
	next
	dim rsClass,sqlClass,strTemp,tmpDepth,i
	sqlClass="select C.ClassID,C.ClassName,C.Depth,L.LayoutFileName,C.NextID,C.LinkUrl From PhotoClass C"
	sqlClass= sqlClass & " inner join Layout L on C.LayoutID=L.LayoutID order by C.RootID,C.OrderID"
	set rsClass=server.CreateObject("adodb.recordset")
	rsClass.open sqlClass,conn,1,1
	if rsClass.bof and rsClass.bof then
		response.write "<option value=''>���������Ŀ</option>"
	else
		do while not rsClass.eof
			tmpDepth=rsClass(2)
			if rsClass(4)>0 then
				arrShowLine(tmpDepth)=True
			else
				arrShowLine(tmpDepth)=False
			end if
			if rsClass(5)="" then
				strTemp="<option value='" & rsClass(3) & "?ClassID=" & rsClass(0) & "'>"
			else
				strTemp="<option value='" & rsClass(5) & "'>"
			end if
			if tmpDepth>0 then
				for i=1 to tmpDepth
					strTemp=strTemp & "&nbsp;&nbsp;"
					if i=tmpDepth then
						if rsClass(4)>0 then
							strTemp=strTemp & "��&nbsp;"
						else
							strTemp=strTemp & "��&nbsp;"
						end if
					else
						if arrShowLine(i)=True then
							strTemp=strTemp & "��"
						else
							strTemp=strTemp & "&nbsp;"
						end if
					end if
				next
			end if
			strTemp=strTemp & rsClass(1)
			if rsClass(5)<>"" then
				strTemp=strTemp & "(��)"
			end if
			strTemp=strTemp & "</option>"
			response.write strTemp
			rsClass.movenext
		loop
	end if
	rsClass.close
	set rsClass=nothing
	response.write "</select></div>"
end sub

'=================================================
'��������ShowClass_Tree
'��  �ã���ʾ������Ŀ������Ŀ¼Ч����
'��  ������
'=================================================
sub ShowClass_Tree()
	dim arrShowLine(20)
	for i=0 to ubound(arrShowLine)
		arrShowLine(i)=False
	next
	dim rsClass,sqlClass,tmpDepth,i
	sqlClass="select C.ClassID,C.ClassName,C.Depth,L.LayoutFileName,C.NextID,C.LinkUrl,C.Child From PhotoClass C"
	sqlClass= sqlClass & " inner join Layout L on C.LayoutID=L.LayoutID order by C.RootID,C.OrderID"
	set rsClass=server.CreateObject("adodb.recordset")
	rsClass.open sqlClass,conn,1,1
	if rsClass.bof and rsClass.bof then
		strClassTree="û���κ���Ŀ"
	else
		strClassTree=""
		do while not rsClass.eof
			tmpDepth=rsClass(2)
			if rsClass(4)>0 then
				arrShowLine(tmpDepth)=True
			else
				arrShowLine(tmpDepth)=False
			end if
			if tmpDepth>0 then
				for i=1 to tmpDepth
					if i=tmpDepth then
						if rsClass(4)>0 then
							strClassTree=strClassTree & "<img src='images/tree_line1.gif' width='17' height='16' valign='abvmiddle'>"
						else
							strClassTree=strClassTree & "<img src='images/tree_line2.gif' width='17' height='16' valign='abvmiddle'>"
						end if
					else
						if arrShowLine(i)=True then
							strClassTree=strClassTree & "<img src='images/tree_line3.gif' width='17' height='16' valign='abvmiddle'>"
						else
							strClassTree=strClassTree & "<img src='images/tree_line4.gif' width='17' height='16' valign='abvmiddle'>"
						end if
					end if
				next
			end if
			if rsClass(6)>0 then 
				strClassTree=strClassTree & "<img src='Images/tree_folder4.gif' width='15' height='15' valign='abvmiddle'>" 
			else 
				strClassTree=strClassTree & "<img src='Images/tree_folder3.gif' width='15' height='15' valign='abvmiddle'>" 
			end if 
			if rsClass(5)="" then
				strClassTree=strClassTree & "<a href='" & rsClass(3) & "?ClassID=" & rsClass(0) & "'>"
			else
				strClassTree=strClassTree & "<a href='" & rsClass(5) & "' target='_blank'>"
			end if
			if rsClass(2)=0 then 
				strClassTree=strClassTree & "<b>"  & rsClass(1) & "</b>"
			else
				strClassTree=strClassTree & rsClass(1)
			end if 
			'if rsClass(5)<>"" then
			'	strClassTree=strClassTree & "(��)"
			'end if
			strClassTree=strClassTree & "</a>"
			if rsClass(6)>0 then 
				strClassTree=strClassTree & "��" & rsClass(6) & "��" 
			end if 
			strClassTree=strClassTree & "<br>"
			rsClass.movenext
		loop
	end if
	rsClass.close
	set rsClass=nothing
	response.write strClassTree
end sub

'=================================================
'��������ShowChildClass
'��  �ã���ʾ��ǰ��Ŀ����һ������Ŀ
'��  ����ShowType--------��ʾ��ʽ��1Ϊ�����б�2Ϊ�����б�
'=================================================
sub ShowChildClass(ShowType)
	dim sqlChild,rsChild,i
	sqlChild="select C.ClassID,C.ClassName,C.Depth,L.LayoutFileName,C.NextID,C.LinkUrl,C.Child From PhotoClass C"
	sqlChild= sqlChild & " inner join Layout L on C.LayoutID=L.LayoutID where C.ParentID=" & ClassID & " order by C.OrderID"
	Set rsChild= Server.CreateObject("ADODB.Recordset")
	rsChild.open sqlChild,conn,1,1
	if rsChild.bof and rsChild.eof then
		response.write "û���κ�����Ŀ"
	else
		if ShowType=1 then
			do while not rsChild.eof
				if rsChild(5)<>"" then
					response.write "<li><a href='" & rsChild(5) & "'>" & rsChild(1) & "</a></li>"
				else
					response.Write "<li><a href='" & rsChild(3) & "?ClassID=" & rsChild(0) & "'>" & rsChild(1) & "</a></li>"
				end if
				if rsChild(6)>0 then
					response.write "(" & rsChild(6) & ")"
				end if
				response.write "<br>"		
				rsChild.movenext
			loop
		else
			i=0
			do while not rsChild.eof
				if rsChild(5)<>"" then
					response.write "&nbsp;&nbsp;<a href='" & rsChild(5) & "'>" & rsChild(1) & "</a>"
				else
					response.Write "&nbsp;&nbsp;<a href='" & rsChild(3) & "?ClassID=" & rsChild(0) & "'>" & rsChild(1) & "</a>"
				end if
				if rsChild(6)>0 then
					response.write "(" & rsChild(6) & ")"
				end if		
				rsChild.movenext
				i=i+1
				if i mod 5=0 then
					response.write "<br>"
				end if
			loop
		end if
	end if
	rsChild.close
	set rsChild=nothing
end sub

'=================================================
'��������ShowClassNavigation
'��  �ã���ʾ��Ŀ����
'��  ������
'=================================================
sub ShowClassNavigation()
	dim rsNavigation,sqlNavigation,strNavigation,PrevRootID,i
	sqlNavigation="select C.ClassID,C.ClassName,C.Depth,L.LayoutFileName,C.RootID,C.LinkUrl,C.Child,C.Readme From PhotoClass C"
	sqlNavigation= sqlNavigation & " inner join Layout L on C.LayoutID=L.LayoutID where C.Depth<=1 order by C.RootID,C.OrderID"
	Set rsNavigation= Server.CreateObject("ADODB.Recordset")
	rsNavigation.open sqlNavigation,conn,1,1
	if rsNavigation.bof and rsNavigation.eof then
		response.write "û���κ���Ŀ"
	else
		strNavigation="<table border='0' cellpadding='0' cellspacing='2'><tr><td valign='top' nowrap>��<a href='" & rsNavigation(3) & "?ClassID=" & rsNavigation(0) & "' title='" & rsNavigation(7) & "'>" & rsNavigation(1) & "</a>��</td><td>"
		PrevRootID=rsNavigation(4)
		rsNavigation.movenext
		i=1
		do while not rsNavigation.eof
			if PrevRootID=rsNavigation(4) then
				if i mod 9=0 then
					strNavigation=strNavigation & "<br>"
				end if
				strNavigation=strNavigation & "<a href='" & rsNavigation(3) & "?ClassID=" & rsNavigation(0) & "' title='" & rsNavigation(7) & "'>" & rsNavigation(1) & "</a>&nbsp;&nbsp;"
				i=i+1
			else
				strNavigation=strNavigation & "</td></tr><tr><td valign='top' nowrap>��<a href='" & rsNavigation(3) & "?ClassID=" & rsNavigation(0) & "' title='" & rsNavigation(7) & "'>" & rsNavigation(1) & "</a>��</td><td>"
				i=1
			end if
			PrevRootID=rsNavigation(4)
			rsNavigation.movenext
		loop
		strNavigation=strNavigation & "</td></tr></table>"
		response.write strNavigation
	end if
	rsNavigation.close
	set rsNavigation=nothing
end sub

'=================================================
'��������ShowSiteCount
'��  �ã���ʾվ��ͳ����Ϣ
'��  ������
'=================================================
sub ShowSiteCount()
	dim sqlCount,rsCount
	Set rsCount= Server.CreateObject("ADODB.Recordset")
	sqlCount="select count(PhotoID) from Photo where Deleted=False"
	rsCount.open sqlCount,conn,1,1
	response.write "ͼƬ������" & rsCount(0) & "��<br>"
	rsCount.close

	sqlCount="select count(PhotoID) from Photo where Passed=False and Deleted=False"
	rsCount.open sqlCount,conn,1,1
	response.write "����ͼƬ��" & rsCount(0) & "��<br>"
	rsCount.close
	
	sqlCount="select count(CommentID) from PhotoComment"
	rsCount.open sqlCount,conn,1,1
	response.write "����������" & rsCount(0) & "��<br>"
	rsCount.close
	
	sqlCount="select count(SpecialID) from Special"
	rsCount.open sqlCount,conn,1,1
	response.write "ר��������" & rsCount(0) & "��<br>"
	rsCount.close

	sqlCount="select count(" & db_User_ID & ") from " & db_User_Table & ""
	rsCount.open sqlCount,Conn_User,1,1
	response.write "ע���û���" & rsCount(0) & "��<br>"
	rsCount.close
	
	sqlCount="select sum(Hits) from Photo"
	rsCount.open sqlCount,conn,1,1
	response.write "ͼƬ�鿴��" & rsCount(0) & "�˴�<br>"
	rsCount.close
	
	set rsCount=nothing
end sub

'=================================================
'��������ShowPhoto
'��  �ã���ҳ��ʾͼƬ�������Ϣ
'��  ����TitleLen  ----��������ַ�����һ������=����Ӣ���ַ�
'=================================================
sub ShowPhoto(TitleLen,strClassID)
	if TitleLen<0 or TitleLen>200 then
		TitleLen=50
	end if

	sqlPhoto="select P.PhotoID,P.ClassID,C.ClassName,L.LayoutFileName,P.PhotoName,P.PhotoUrl_Thumb,P.Author,P.AuthorEmail,P.Keyword,P.UpdateTime,P.Editor,P.Hits,P.DayHits,P.WeekHits,P.MonthHits,P.PhotoSize,P.OnTop,P.Elite,P.Passed,P.Stars,P.PhotoLevel,P.PhotoPoint from Photo P"
	sqlPhoto=sqlPhoto & " inner join (PhotoClass C inner join Layout L on C.LayoutID=L.LayoutID) on P.ClassID=C.ClassID where P.Deleted=False and P.Passed=True "

	'if SpecialID>0 then
	'	sqlPhoto=sqlPhoto & " and P.SpecialID=" & SpecialID
	'end if
	if instr(strClassID,",")>0 then
		sqlPhoto=sqlPhoto &  " and P.ClassID in (" & strClassID & ")"
	else
		sqlPhoto=sqlPhoto &  " and P.ClassID=" & Clng(strClassID)
	end if
	if keyword<>"" then
		select case strField
			case "PhotoName"
				sqlPhoto=sqlPhoto & " and P.PhotoName like '%" & keyword & "%' "
			case "PhotoIntro"
				sqlPhoto=sqlPhoto & " and P.PhotoIntro like '%" & keyword & "%' "
			case "Author"
				sqlPhoto=sqlPhoto & " and P.Author like '%" & keyword & "%' "
			case "Editor"
				sqlPhoto=sqlPhoto & " and P.Editor like '%" & keyword & "%' "
			case else
				sqlPhoto=sqlPhoto & " and P.PhotoName like '%" & keyword & "%' "
		end select
	end if
	sqlPhoto=sqlPhoto & " order by P.OnTop,P.PhotoID desc"

	Set rsPhoto= Server.CreateObject("ADODB.Recordset")
	rsPhoto.open sqlPhoto,conn,1,1
	if rsPhoto.bof and  rsPhoto.eof then
		totalput=0
		response.Write("<br><li>û���κ�ͼƬ</li>")
	else
		totalput=rsPhoto.recordcount
		if currentpage<1 then
			currentpage=1
		end if
		if (currentpage-1)*MaxPerPage>totalput then
			if (totalPut mod MaxPerPage)=0 then
				currentpage= totalPut \ MaxPerPage
			else
				currentpage= totalPut \ MaxPerPage + 1
			end if
		end if

		if currentPage=1 then
			call PhotoContent(TitleLen,True)
		else
			if (currentPage-1)*MaxPerPage<totalPut then
         	   	rsPhoto.move  (currentPage-1)*MaxPerPage
         		dim bookmark
           		bookmark=rsPhoto.bookmark
            	call PhotoContent(TitleLen,True)
        	else
	        	currentPage=1
           		call PhotoContent(TitleLen,True)
	    	end if
		end if
	end if
	rsPhoto.close
	set rsPhoto=nothing
end sub

'=================================================
'��������PhotoContent
'��  �ã���ʾͼƬ���ԡ����⡢���ߡ��������ڡ����������Ϣ
'��  ����intTitleLen  ----��������ַ�����һ������=����Ӣ���ַ�
'=================================================
sub PhotoContent(intTitleLen,ShowTitle)
   	dim i,strTemp,TitleStr
	response.write "<table border='0' cellpadding='0' cellspacing='5'><tr>"
	if rsPhoto.bof and rsPhoto.eof then 
		response.write "<td width='135' align='center'>û��ͼƬ</td>" 
	else 
		i=0
		do while not rsPhoto.eof   
			if i>0 and i mod 4=0 then
				response.write "</tr><tr>"
			end if
			response.Write "<td align='center' width='135'>"
			response.write "<table border='0' cellspacing='0' cellpadding='0' align='center'><tr><td>"
			response.write "<a href='Photo_Show.asp?PhotoID=" & rsPhoto("Photoid") & "' title='ͼƬ���ƣ�" & rsPhoto("PhotoName") & vbcrlf & "ͼƬ��С��" & rsPhoto("PhotoSize") & "K" & vbcrlf & "��    �ߣ�" & rsPhoto("Author") & vbcrlf & "����ʱ�䣺" & rsPhoto("UpdateTime") & vbcrlf & "���ش���������:" & rsPhoto("DayHits") & " ����:" & rsPhoto("WeekHits") & " ����:" & rsPhoto("MonthHits") & " �ܼ�:" & rsPhoto("Hits") & "' target='_blank'><img width='120' height='90' border='0' src='" & rsPhoto("PhotoUrl_Thumb") & "'></a>"
            response.write "</td><td><img src='images/yy1_02.gif' width='6' height='90'></td></tr>"
            response.write "<tr><td colspan='2'><img src='images/yy1_03.gif' width='125' height='7'></td></tr></table>"
			if ShowTitle=True then
				response.write "<a href='Photo_Show.asp?PhotoID=" & rsPhoto("Photoid") & "' title='ͼƬ���ƣ�" & rsPhoto("PhotoName") & vbcrlf & "ͼƬ��С��" & rsPhoto("PhotoSize") & "K" & vbcrlf & "��    �ߣ�" & rsPhoto("Author") & vbcrlf & "����ʱ�䣺" & rsPhoto("UpdateTime") & vbcrlf & "���ش���������:" & rsPhoto("DayHits") & " ����:" & rsPhoto("WeekHits") & " ����:" & rsPhoto("MonthHits") & " �ܼ�:" & rsPhoto("Hits") & "' target='_blank'>" & gotTopic(rsPhoto("PhotoName"),intTitleLen) & "</a>"
			end if
			response.write "</td>"
			i=i+1
			if i>=MaxPerPage then exit do
        	rsPhoto.movenext 
		loop
	end if
	response.write "</tr></table>" 
end sub 

'=================================================
'��������ShowNewPhoto
'��  �ã���ʾ������µ�ͼƬ
'��  ����PhotoNum  ----�����ʾ���ٸ�ͼƬ
'        ShowTitle  ----�Ƿ���ʾͼƬ���ƣ�TrueΪ��ʾ��FalseΪ����ʾ
'        TitleLen   ----��������ַ�����һ������=����Ӣ���ַ�
'=================================================
sub ShowNewPhoto(PhotoNum,ShowTitle,TitleLen)
	dim sqlNew,rsNew,i
	if PhotoNum>0 and PhotoNum<=100 then
		sqlNew="select top " & PhotoNum
	else
		sqlNew="select top 10 "
	end if
	sqlNew=sqlNew & " P.PhotoID,P.PhotoName,P.PhotoUrl_Thumb,P.Author,P.Keyword,P.UpdateTime,P.Editor,P.Hits,P.DayHits,P.WeekHits,P.MonthHits,P.PhotoSize,P.PhotoLevel,P.PhotoPoint from Photo P where P.Deleted=False and P.Passed=True "
	sqlNew=sqlNew & " order by P.PhotoID desc"
	Set rsNew= Server.CreateObject("ADODB.Recordset")
	rsNew.open sqlNew,conn,1,1
	if TitleLen<0 or TitleLen>255 then TitleLen=100
	response.write "<table border='0' cellpadding='0' cellspacing='5'><tr>"
	if rsNew.bof and rsNew.eof then 
		response.write "<td width='135' align='center'>û��ͼƬ</td>" 
	else 
		i=0
		do while not rsNew.eof   
			if i>0 and i mod 4=0 then
				response.write "</tr><tr>"
			end if
			response.Write "<td align='center' width='135'>"
			response.write "<table border='0' cellspacing='0' cellpadding='0' align='center'><tr><td>"
			response.write "<a href='Photo_Show.asp?PhotoID=" & rsNew("Photoid") & "' title='ͼƬ���ƣ�" & rsNew("PhotoName") & vbcrlf & "ͼƬ��С��" & rsNew("PhotoSize") & "K" & vbcrlf & "��    �ߣ�" & rsNew("Author") & vbcrlf & "����ʱ�䣺" & rsNew("UpdateTime") & vbcrlf & "���ش���������:" & rsNew("DayHits") & " ����:" & rsNew("WeekHits") & " ����:" & rsNew("MonthHits") & " �ܼ�:" & rsNew("Hits") & "' target='_blank'><img width='120' height='90' border='0' src='" & rsNew("PhotoUrl_Thumb") & "'></a>"
            response.write "</td><td><img src='images/yy1_02.gif' width='6' height='90'></td></tr>"
            response.write "<tr><td colspan='2'><img src='images/yy1_03.gif' width='125' height='7'></td></tr></table>"
			if ShowTitle=True then
				response.write "<a href='Photo_Show.asp?PhotoID=" & rsNew("Photoid") & "' title='ͼƬ���ƣ�" & rsNew("PhotoName") & vbcrlf & "ͼƬ��С��" & rsNew("PhotoSize") & "K" & vbcrlf & "��    �ߣ�" & rsNew("Author") & vbcrlf & "����ʱ�䣺" & rsNew("UpdateTime") & vbcrlf & "���ش���������:" & rsNew("DayHits") & " ����:" & rsNew("WeekHits") & " ����:" & rsNew("MonthHits") & " �ܼ�:" & rsNew("Hits") & "' target='_blank'>" & gotTopic(rsNew("PhotoName"),TitleLen) & "</a>"
			end if
			response.write "</td>"
			i=i+1
        	rsNew.movenext     
		loop
	end if
	response.write "</tr></table>" 
	rsNew.close
	set rsNew=nothing
end sub


'=================================================
'��������ShowTop
'��  �ã���ʾ�ۼ�����TOP N��N�ɲ���PhotoNumָ��
'��  ����PhotoNum  ----�����ʾ���ٸ�ͼƬ
'        TitleLen   ----��������ַ�����һ������=����Ӣ���ַ�
'=================================================
sub ShowTop(PhotoNum,TitleLen,strClassID)
	dim sqlTop,rsTop
	if PhotoNum>0 and PhotoNum<=100 then
		sqlTop="select top " & PhotoNum
	else
		sqlTop="select top 10 "
	end if
	sqlTop=sqlTop & " P.PhotoID,P.PhotoName,P.PhotoVersion,P.Author,P.Keyword,P.UpdateTime,P.Editor,P.Hits,P.DayHits,P.WeekHits,P.MonthHits,P.PhotoSize,P.PhotoLevel,P.PhotoPoint from Photo S where P.Deleted=False and P.Passed=True "
	if instr(strClassID,",")>0 then
		sqlTop=sqlTop & " and P.ClassID in (" & strClassID & ")"
	else
		if CLng(strClassID)>0 then
			sqlTop=sqlTop & " and P.ClassID=" & strClassID
		end if
	end if
	sqlTop=sqlTop & " order by P.Hits desc,P.PhotoID desc"
	Set rsTop= Server.CreateObject("ADODB.Recordset")
	rsTop.open sqlTop,conn,1,1
	if TitleLen<0 or TitleLen>255 then TitleLen=100
	if rsTop.bof and rsTop.eof then 
		response.write "<li>����û������</li>" 
	else 
		do while not rsTop.eof   
			response.Write "<li><a href='Photo_Show.asp?PhotoID=" & rsTop("Photoid") & "' title='ͼƬ���ƣ�" & rsTop("PhotoName") & vbcrlf & "ͼƬ�汾��" & rsTop("PhotoVersion") & vbcrlf & "ͼƬ��С��" & rsTop("PhotoSize") & "K" & vbcrlf & "��    �ߣ�" & rsTop("Author") & vbcrlf & "����ʱ�䣺" & rsTop("UpdateTime") & vbcrlf & "���ش���������:" & rsTop("DayHits") & " ����:" & rsTop("WeekHits") & " ����:" & rsTop("MonthHits") & " �ܼ�:" & rsTop("Hits") & "' target='_blank'>" & gotTopic(rsTop("PhotoName"),TitleLen) & "</li><br>"
        	rsTop.movenext     
		loop
	end if  
	rsTop.close
	set rsTop=nothing
end sub

'=================================================
'��������ShowTopDay
'��  �ã���ʾ��������TOP N��N�ɲ���PhotoNumָ��
'��  ����PhotoNum  ----�����ʾ���ٸ�ͼƬ
'        TitleLen   ----��������ַ�����һ������=����Ӣ���ַ�
'=================================================
sub ShowTopDay(PhotoNum,TitleLen)
	dim sqlTop,rsTop
	if PhotoNum>0 and PhotoNum<=100 then
		sqlTop="select top " & PhotoNum
	else
		sqlTop="select top 10 "
	end if
	sqlTop=sqlTop & " S.PhotoID,S.PhotoName,S.PhotoVersion,S.Author,S.Keyword,S.UpdateTime,S.Editor,S.Hits,S.DayHits,S.WeekHits,S.MonthHits,S.PhotoSize,S.PhotoLevel,S.PhotoPoint from Photo S where S.Deleted=False and S.Passed=True And datediff('D',LastHitTime,now())<=0 order by S.DayHits desc,S.PhotoID desc"
	Set rsTop= Server.CreateObject("ADODB.Recordset")
	rsTop.open sqlTop,conn,1,1
	if TitleLen<0 or TitleLen>255 then TitleLen=100
	if rsTop.bof and rsTop.eof then 
		response.write "<li>����û������</li>" 
	else 
		do while not rsTop.eof   
			response.Write "<li><a href='Photo_Show.asp?PhotoID=" & rsTop("Photoid") & "' title='ͼƬ���ƣ�" & rsTop("PhotoName") & vbcrlf & "ͼƬ�汾��" & rsTop("PhotoVersion") & vbcrlf & "ͼƬ��С��" & rsTop("PhotoSize") & "K" & vbcrlf & "��    �ߣ�" & rsTop("Author") & vbcrlf & "����ʱ�䣺" & rsTop("UpdateTime") & vbcrlf & "���ش���������:" & rsTop("DayHits") & " ����:" & rsTop("WeekHits") & " ����:" & rsTop("MonthHits") & " �ܼ�:" & rsTop("Hits") & "' target='_blank'>" & gotTopic(rsTop("PhotoName"),TitleLen) & "</li><br>"
        	rsTop.movenext     
		loop
	end if  
	rsTop.close
	set rsTop=nothing
end sub

'=================================================
'��������ShowTopWeek
'��  �ã���ʾ��������TOP N��N�ɲ���PhotoNumָ��
'��  ����PhotoNum  ----�����ʾ���ٸ�ͼƬ
'        TitleLen   ----��������ַ�����һ������=����Ӣ���ַ�
'=================================================
sub ShowTopWeek(PhotoNum,TitleLen)
	dim sqlTop,rsTop
	if PhotoNum>0 and PhotoNum<=100 then
		sqlTop="select top " & PhotoNum
	else
		sqlTop="select top 10 "
	end if
	sqlTop=sqlTop & " S.PhotoID,S.PhotoName,S.PhotoVersion,S.Author,S.Keyword,S.UpdateTime,S.Editor,S.Hits,S.DayHits,S.WeekHits,S.MonthHits,S.PhotoSize,S.PhotoLevel,S.PhotoPoint from Photo S where S.Deleted=False and S.Passed=True And datediff('ww',LastHitTime,now())<=0 order by S.WeekHits desc,S.PhotoID desc"
	Set rsTop= Server.CreateObject("ADODB.Recordset")
	rsTop.open sqlTop,conn,1,1
	if TitleLen<0 or TitleLen>255 then TitleLen=100
	if rsTop.bof and rsTop.eof then 
		response.write "<li>����û������</li>" 
	else 
		do while not rsTop.eof   
			response.Write "<li><a href='Photo_Show.asp?PhotoID=" & rsTop("Photoid") & "' title='ͼƬ���ƣ�" & rsTop("PhotoName") & vbcrlf & "ͼƬ�汾��" & rsTop("PhotoVersion") & vbcrlf & "ͼƬ��С��" & rsTop("PhotoSize") & "K" & vbcrlf & "��    �ߣ�" & rsTop("Author") & vbcrlf & "����ʱ�䣺" & rsTop("UpdateTime") & vbcrlf & "���ش���������:" & rsTop("DayHits") & " ����:" & rsTop("WeekHits") & " ����:" & rsTop("MonthHits") & " �ܼ�:" & rsTop("Hits") & "' target='_blank'>" & gotTopic(rsTop("PhotoName"),TitleLen) & "</li><br>"
        	rsTop.movenext     
		loop
	end if  
	rsTop.close
	set rsTop=nothing
end sub

'=================================================
'��������ShowTopMonth
'��  �ã���ʾ��������TOP N��N�ɲ���PhotoNumָ��
'��  ����PhotoNum  ----�����ʾ���ٸ�ͼƬ
'        TitleLen   ----��������ַ�����һ������=����Ӣ���ַ�
'=================================================
sub ShowTopMonth(PhotoNum,TitleLen)
	dim sqlTop,rsTop
	if PhotoNum>0 and PhotoNum<=100 then
		sqlTop="select top " & PhotoNum
	else
		sqlTop="select top 10 "
	end if
	sqlTop=sqlTop & " S.PhotoID,S.PhotoName,S.PhotoVersion,S.Author,S.Keyword,S.UpdateTime,S.Editor,S.Hits,S.DayHits,S.WeekHits,S.MonthHits,S.PhotoSize,S.PhotoLevel,S.PhotoPoint from Photo S where S.Deleted=False and S.Passed=True And datediff('m',LastHitTime,now())<=0 order by S.MonthHits desc,S.PhotoID desc"
	Set rsTop= Server.CreateObject("ADODB.Recordset")
	rsTop.open sqlTop,conn,1,1
	if TitleLen<0 or TitleLen>255 then TitleLen=100
	if rsTop.bof and rsTop.eof then 
		response.write "<li>����û������</li>" 
	else 
		do while not rsTop.eof   
			response.Write "<li><a href='Photo_Show.asp?PhotoID=" & rsTop("Photoid") & "' title='ͼƬ���ƣ�" & rsTop("PhotoName") & vbcrlf & "ͼƬ�汾��" & rsTop("PhotoVersion") & vbcrlf & "ͼƬ��С��" & rsTop("PhotoSize") & "K" & vbcrlf & "��    �ߣ�" & rsTop("Author") & vbcrlf & "����ʱ�䣺" & rsTop("UpdateTime") & vbcrlf & "���ش���������:" & rsTop("DayHits") & " ����:" & rsTop("WeekHits") & " ����:" & rsTop("MonthHits") & " �ܼ�:" & rsTop("Hits") & "' target='_blank'>" & gotTopic(rsTop("PhotoName") & "&nbsp;&nbsp;" & rsTop("PhotoVersion"),TitleLen) & "</li><br>"
        	rsTop.movenext     
		loop
	end if  
	rsTop.close
	set rsTop=nothing
end sub

'=================================================
'��������ShowHot
'��  �ã���ʾ��������
'��  ����PhotoNum  ----�����ʾ���ٸ�ͼƬ
'        TitleLen   ----��������ַ�����һ������=����Ӣ���ַ�
'=================================================
sub ShowHot(PhotoNum,TitleLen)
	dim sqlHot,rsHot
	if PhotoNum>0 and PhotoNum<=100 then
		sqlHot="select top " & PhotoNum
	else
		sqlHot="select top 10 "
	end if
	sqlHot=sqlHot & " P.PhotoID,P.PhotoName,P.PhotoUrl_Thumb,P.Author,P.Keyword,P.UpdateTime,P.Editor,P.Hits,P.DayHits,P.WeekHits,P.MonthHits,P.PhotoSize,P.PhotoLevel,P.PhotoPoint from Photo P where P.Deleted=False and P.Passed=True And P.Hits>=" & HitsOfHot
	sqlHot=sqlHot & " order by P.PhotoID desc"
	Set rsHot= Server.CreateObject("ADODB.Recordset")
	rsHot.open sqlHot,conn,1,1
	if TitleLen<0 or TitleLen>255 then TitleLen=50
	if rsHot.bof and rsHot.eof then 
		response.write "<li>������ͼƬ</li>" 
	else 
		do while not rsHot.eof   
			response.Write "<li><a href='Photo_Show.asp?PhotoID=" & rsHot("Photoid") & "' title='ͼƬ���ƣ�" & rsHot("PhotoName") & vbcrlf & "ͼƬ��С��" & rsHot("PhotoSize") & "K" & vbcrlf & "��    �ߣ�" & rsHot("Author") & vbcrlf & "����ʱ�䣺" & rsHot("UpdateTime") & vbcrlf & "���ش�����" & rsHot("Hits") & "' target='_blank'>" & gotTopic(rsHot("PhotoName"),TitleLen) & "[<font color=red>" & rsHot("hits") & "</font>]</li><br>"
        	rsHot.movenext     
		loop
	end if  
	rsHot.close
	set rsHot=nothing
end sub

'=================================================
'��������ShowElite
'��  �ã���ʾ�Ƽ�ͼƬ
'��  ����PhotoNum  ----�����ʾ���ٸ�ͼƬ
'        TitleLen   ----��������ַ�����һ������=����Ӣ���ַ�
'=================================================
sub ShowElite(PhotoNum,TitleLen)
	dim sqlElite,rsElite
	if PhotoNum>0 and PhotoNum<=100 then
		sqlElite="select top " & PhotoNum
	else
		sqlElite="select top 10 "
	end if
	sqlElite=sqlElite & " P.PhotoID,P.PhotoName,P.PhotoUrl_Thumb,P.Author,P.Keyword,P.UpdateTime,P.Editor,P.Hits,P.DayHits,P.WeekHits,P.MonthHits,P.PhotoSize,P.PhotoLevel,P.PhotoPoint from Photo P where P.Deleted=False and P.Passed=True And P.Elite=True "
	sqlElite=sqlElite & " order by P.PhotoID desc"
	Set rsElite= Server.CreateObject("ADODB.Recordset")
	rsElite.open sqlElite,conn,1,1
	if TitleLen<0 or TitleLen>255 then TitleLen=50
	if rsElite.bof and rsElite.eof then 
		response.write "<li>���Ƽ�ͼƬ</li>" 
	else 
		do while not rsElite.eof   
			response.Write "<li><a href='Photo_Show.asp?PhotoID=" & rsElite("Photoid") & "' title='ͼƬ���ƣ�" & rsElite("PhotoName") & vbcrlf & "ͼƬ��С��" & rsElite("PhotoSize") & "K" & vbcrlf & "��    �ߣ�" & rsElite("Author") & vbcrlf & "����ʱ�䣺" & rsElite("UpdateTime") & vbcrlf & "���ش�����" & rsElite("Hits") & "' target='_blank'>" & gotTopic(rsElite("PhotoName"),TitleLen) & "[<font color=red>" & rsElite("hits") & "</font>]</li><br>"
        	rsElite.movenext     
		loop
	end if  
	rsElite.close
	set rsElite=nothing
end sub

'=================================================
'��������ShowCorrelative
'��  �ã���ʾ���ͼƬ
'��  ����PhotoNum  ----�����ʾ���ٸ�ͼƬ
'        TitleLen   ----��������ַ�����һ������=����Ӣ���ַ�
'=================================================
sub ShowCorrelative(PhotoNum,TitleLen)
	dim rsCorrelative,sqlCorrelative
	dim strKey,arrKey,i
	if PhotoNum>0 and PhotoNum<=100 then
		sqlCorrelative="select top " & PhotoNum
	else	
		sqlCorrelative="Select Top 5 "
	end if
	strKey=mid(rs("Keyword"),2,len(rs("Keyword"))-2)
	if instr(strkey,"|")>1 then
		arrKey=split(strKey,"|")
		strKey="((S.Keyword like '%|" & arrKey(0) & "|%')"
		for i=1 to ubound(arrKey)
			strKey=strKey & " or (S.Keyword like '%|" & arrKey(i) & "|%')"
		next
		strKey=strKey & ")"
	else
		strKey="(S.Keyword like '%|" & strKey & "|%')"
	end if

	sqlCorrelative=sqlCorrelative & " S.PhotoID,S.PhotoName,S.PhotoVersion,S.Author,S.Keyword,S.UpdateTime,S.Editor,S.Hits,S.PhotoSize,S.PhotoLevel,S.PhotoPoint from Photo S Where S.Deleted=False and S.Passed=True and " & strKey & " and S.PhotoID<>" & PhotoID & " Order by S.PhotoID desc"
	Set rsCorrelative= Server.CreateObject("ADODB.Recordset")
	rsCorrelative.open sqlCorrelative,conn,1,1
	if TitleLen<0 or TitleLen>255 then TitleLen=50
	if rsCorrelative.bof and rsCorrelative.Eof then
		response.write "û�����ͼƬ"
	else
	 	do while not rsCorrelative.eof	
			response.Write "<li><a href='Photo_Show.asp?PhotoID=" & rsCorrelative("Photoid") & "' title='ͼƬ���ƣ�" & rsCorrelative("PhotoName") & vbcrlf & "ͼƬ��С��" & rsCorrelative("PhotoSize") & "K" & vbcrlf & "��    �ߣ�" & rsCorrelative("Author") & vbcrlf & "����ʱ�䣺" & rsCorrelative("UpdateTime") & vbcrlf & "���ش�����" & rsCorrelative("Hits") & "' target='_blank'>" & gotTopic(rsCorrelativ("PhotoName"),TitleLen) & "[<font color=red>" & rsCorrelative("hits") & "</font>]</li><br>"
			rsCorrelative.movenext
		loop
	end if
	rsCorrelative.close
	set rsCorrelative=nothing
end sub

'=================================================
'��������ShowComment
'��  �ã���ʾ�������
'��  ����CommentNum  ----�����ʾ���ٸ�����
'=================================================
sub ShowComment(CommentNum)
	dim rsComment,sqlComment,rsCommentUser
	if CommentNum>0 and CommentNum<=100 then
		sqlComment="select top " & CommentNum
	else
		sqlComment="select top 10 "
	end if
	sqlComment=sqlComment & " * from PhotoComment where PhotoID=" & PhotoID & " order by CommentID desc"
	Set rsComment= Server.CreateObject("ADODB.Recordset")
	rsComment.open sqlComment,conn,1,1
	if rsComment.bof and rsComment.eof then
		response.write "&nbsp;&nbsp;&nbsp;&nbsp;û���κ�����"
	else
		response.write "<table width='100%' border='0' cellspacing='0' cellpadding='0'>"
		do while not rsComment.eof
			response.write "<tr><td width='70%'>"
			if rsComment("UserType")=1 then
				response.write "<li>��Ա"
				set rsCommentUser=Conn_User.execute("select " & db_User_ID & "," & db_User_Name & "," & db_User_Email & "," & db_User_QQ & "," & db_User_Homepage & " from " & db_User_Table & " where " & db_User_Name & "='" & rsComment("UserName") & "'")
				if rsCommentUser.bof and rsCommentUser.eof then
					response.write rsComment("UserName")
				else
					response.write "��<a href='UserInfo.asp?UserID=" & rsCommentUser(0) & "' title='������" & rsCommentUser(1) & vbcrlf & "���䣺" & rsCommentUser(2) & vbcrlf & "Oicq��" & rsCommentUser(3) & vbcrlf & "��ҳ��" &  rsCommentUser(4)&"'><font color='blue'>" & rsComment("UserName") & "</font></a>��"
				end if
			else
				response.write "<li>�ο͡�<span title='������" & rsComment("UserName") & vbcrlf & "���䣺" & rsComment("Email") & vbcrlf & "Oicq��" & rsComment("Oicq") & vbcrlf & "��ҳ��" &  rsComment("Homepage")&"' style='cursor:hand'><font color='blue'>" & rsComment("UserName") & "</font></span>��"
			end if
			response.write "��" & rsComment("WriteTime") & "�������ۣ�</li>"
			response.write "</td><td align=right>���֣�"&rsComment("Score")&"��</td></tr>"
			response.write "<tr><td colspan='2'>"
			response.write "&nbsp;&nbsp;&nbsp;&nbsp;" & rsComment("Content") & "<br>"
			if rsComment("ReplyContent")<>"" then
				response.write "&nbsp;&nbsp;&nbsp;&nbsp;<font color='009900'>��</font>&nbsp;����Ա��<font color='blue'>" & rsComment("ReplyName") & "</font>���� " & rsComment("ReplyTime") & " �ظ�����&nbsp;&nbsp;&nbsp;&nbsp;" & rsComment("ReplyContent") & "<br>"			
			end if
			response.write "<br></td></tr>"
			rsComment.movenext
		loop
		response.write "<tr><td colspan='2' align='right'>"
		response.write "<a href='Photo_CommentShow.asp?PhotoID=" & PhotoID & "'>�鿴���ڴ����µ���������</a>"
		response.write "</td></tr></table>"
	end if

end sub

%>