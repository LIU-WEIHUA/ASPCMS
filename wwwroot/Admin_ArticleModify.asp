<%@language=vbscript codepage=936 %>
<%
option explicit
response.buffer=true	
Const PurviewLevel=2
Const CheckChannelID=2
Const PurviewLevel_Article=3
%>
<!--#include file="inc/conn.asp"-->
<!--#include file="inc/config.asp"-->
<!--#include file="Admin_ChkPurview.asp"-->
<!--#include file="inc/function.asp"-->
<!--#include file="inc/admin_code_article.asp"-->
<%
dim ArticleID,sql,rsArticle,FoundErr,ErrMsg,PurviewChecked
dim Author,AuthorName,AuthorEmail,CopyFrom,CopyFromName,CopyFromUrl
dim ClassID,tClass,ClassName,RootID,ParentID,Depth,ParentPath,ClassMaster
dim SkinID,LayoutID,SkinCount,LayoutCount,BrowsePurview,AddPurview
ArticleID=trim(request("ArticleID"))
FoundErr=False
PurviewChecked=False
if ArticleID="" then 
	FoundErr=True
	ErrMsg=ErrMsg & "<br><li>��ָ��Ҫ�޸ĵ�����ID</li>"
	call WriteErrMsg()
	call CloseConn()
	response.end
else
	ArticleID=Clng(ArticleID)
end if
sql="select * from article where ArticleID=" & ArticleID & ""
Set rsArticle= Server.CreateObject("ADODB.Recordset")
rsArticle.open sql,conn,1,1
if rsArticle.bof and rsArticle.eof then
	FoundErr=True
	ErrMsg=ErrMsg & "<br><li>�Ҳ�������</li>"
else
	ClassID=rsArticle("ClassID")
	set tClass=conn.execute("select ClassName,RootID,ParentID,Depth,ParentPath,ClassMaster From ArticleClass where ClassID=" & ClassID)
	if tClass.bof and tClass.eof then
		founderr=True
		ErrMsg=ErrMsg & "<br><li>�Ҳ���ָ������Ŀ</li>"
	else
		ClassName=tClass(0)
		RootID=tClass(1)
		ParentID=tClass(2)
		Depth=tClass(3)
		ParentPath=tClass(4)
		ClassMaster=tClass(5)
	end if
	if rsArticle("Editor")=AdminName and rsArticle("Passed")=False then
		PurviewChecked=True
	else
		if AdminPurview=1 or AdminPurview_Article<=2 then
			PurviewChecked=True
		else
			PurviewChecked=CheckClassMaster(ClassMaster,AdminName)
			if PurviewChecked=False and ParentID>0 then
				set tClass=conn.execute("select ClassMaster from ArticleClass where ClassID in (" & ParentPath & ")")
				do while not tClass.eof
					PurviewChecked=CheckClassMaster(tClass(0),AdminName)
					if PurviewChecked=True then exit do
					tClass.movenext
				loop
			end if
		end if
		if PurviewChecked=False then
			FoundErr=True
			ErrMsg=ErrMsg & "<br><li>�Բ�������Ȩ�޲����������޸Ĵ��ģ�</li>"
		end if
	end if
end if
if FoundErr=True then
	call WriteErrMsg()
else
	Author=rsArticle("Author")
	CopyFrom=rsarticle("CopyFrom")
	if instr(Author,"|")>0 then
		AuthorName=left(Author,instr(Author,"|")-1)
		AuthorEmail=right(Author,len(Author)-instr(Author,"|"))
	else
		AuthorName=Author
		AuthorEmail=""
	end if
	if instr(CopyFrom,"|")>0 then
		CopyFromName=left(CopyFrom,instr(CopyFrom,"|")-1)
		CopyFromUrl=right(CopyFrom,len(CopyFrom)-instr(CopyFrom,"|"))
	else
		CopyFromName=CopyFrom
		CopyFromUrl=""
	end if
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�޸�����</title>
<link rel="stylesheet" type="text/css" href="Admin_Style.css">
<script language = "JavaScript">
function AddItem(strFileName){
  document.myform.IncludePic.checked=true;
  document.myform.DefaultPicUrl.value=strFileName;
  document.myform.DefaultPicList.options[document.myform.DefaultPicList.length]=new Option(strFileName,strFileName);
  document.myform.DefaultPicList.selectedIndex+=1;
  if(document.myform.UploadFiles.value==''){
	document.myform.UploadFiles.value=strFileName;
  }
  else{
    document.myform.UploadFiles.value=document.myform.UploadFiles.value+"|"+strFileName;
  }
}
function selectPaginationType()
{
  document.myform.PaginationType.selectedIndex=2;
}
function CheckForm()
{
  if (editor.EditMode.checked==true)
	  document.myform.Content.value=editor.HtmlEdit.document.body.innerText;
  else
	  document.myform.Content.value=editor.HtmlEdit.document.body.innerHTML; 

  if (document.myform.Title.value=="")
  {
    alert("���±��ⲻ��Ϊ�գ�");
	document.myform.Title.focus();
	return false;
  }
  if (document.myform.Key.value=="")
  {
    alert("�ؼ��ֲ���Ϊ�գ�");
	document.myform.Key.focus();
	return false;
  }
  if (document.myform.Content.value=="")
  {
    alert("�������ݲ���Ϊ�գ�");
	editor.HtmlEdit.focus();
	return false;
  }
  if (document.myform.Content.value.length>65536)
  {
    alert("��������̫����������ACCESS���ݿ�����ƣ�64K�������齫���·ֳɼ�����¼�롣");
	editor.HtmlEdit.focus();
	return false;
  }
  return true;  
}
</script>
</head>
<body leftmargin="5" topmargin="10">
<form method="POST" name="myform" onSubmit="return CheckForm();" action="Admin_ArticleSave.asp?action=Modify">
  <table border="0" align="center" cellpadding="0" cellspacing="0" class="border">
    <tr class="title">
      <td height="22" align="center"><b>�� �� �� ��</b></td>
    </tr>
    <tr align="center">
      <td>
	<table width="100%" border="0" cellpadding="2" cellspacing="1">
          <tr class="tdbg"> 
            <td width="100" align="right"><strong>������Ŀ��</strong></td>
            <td>
             <table width="100%" border="0" cellspacing="0" cellpadding="0">
               <tr>
                 <td><%
			if AdminPurview=1 or AdminPurview_Article<=2 then
			 	response.write "<select name='ClassID'>"	
				call Admin_ShowClass_Option(3,rsArticle("ClassID"))
				response.write "</select></td><td>"
				response.write "<font color='#FF0000'><strong>ע�⣺</strong></font><font color='#0000FF'>1������ָ��Ϊ��������Ŀ����Ŀ�������ⲿ��Ŀ"
			 else
			 	call Admin_ShowPath2(ParentPath,ClassName,Depth)
				response.write "<input type='hidden' name='ClassID' value='" & rsArticle("ClassID") & "'>"
			 end if
			 %>
                 </td>
               </tr>
             </table>
</td>
          </tr>
          <tr class="tdbg"> 
            <td width="100" align="right"><strong>����ר�⣺</strong></td>
            <td> 
              <%
			  if AdminPurview=1 or AdminPurview_Article<=2 then
			  	call Admin_ShowSpecial_Option(1,rsArticle("SpecialID"))
			  else
				if rsArticle("SpecialID")>0 then
					dim rsSpecial
					set rsSpecial=conn.execute("select * from Special where SpecialID=" & rsArticle("SpecialID"))
					if rsSpecial.bof and rsSpecial.eof then
						response.write "�Ҳ�������ר�⣡��������ר���Ѿ���ɾ����"
					else
						response.write rsSpecial("SpecialName")
					end if
					set rsSpecial=nothing
				end if
				response.write "<input type='hidden' name='SpecialID' value='" & rsArticle("SpecialID") & "'>"
			  end if%>
            </td>
          </tr>
          <tr class="tdbg"> 
            <td width="100" align="right"><strong>���±��⣺</strong></td>
            <td><input name="Title" type="text"
           id="Title" value="<%=rsArticle("Title")%>" size="50" maxlength="255">
              <font color="#FF0000">*</font>
              <select name="TitleFontColor" id="TitleFontColor">
                <option value="" <%if rsArticle("TitleFontColor")="" then response.write " selected"%>>��ɫ</option>
                <OPTION value="">Ĭ��</OPTION>
                <OPTION value="#000000" style="background-color:#000000" <%if rsArticle("TitleFontColor")="#000000" then response.write " selected"%>></OPTION>
                <OPTION value="#FFFFFF" style="background-color:#FFFFFF" <%if rsArticle("TitleFontColor")="#FFFFFF" then response.write " selected"%>></OPTION>
                <OPTION value="#008000" style="background-color:#008000" <%if rsArticle("TitleFontColor")="#008000" then response.write " selected"%>></OPTION>
                <OPTION value="#800000" style="background-color:#800000" <%if rsArticle("TitleFontColor")="#800000" then response.write " selected"%>></OPTION>
                <OPTION value="#808000" style="background-color:#808000" <%if rsArticle("TitleFontColor")="#808000" then response.write " selected"%>></OPTION>
                <OPTION value="#000080" style="background-color:#000080" <%if rsArticle("TitleFontColor")="#000080" then response.write " selected"%>></OPTION>
                <OPTION value="#800080" style="background-color:#800080" <%if rsArticle("TitleFontColor")="#800080" then response.write " selected"%>></OPTION>
                <OPTION value="#808080" style="background-color:#808080" <%if rsArticle("TitleFontColor")="#808080" then response.write " selected"%>></OPTION>
                <OPTION value="#FFFF00" style="background-color:#FFFF00" <%if rsArticle("TitleFontColor")="#FFFF00" then response.write " selected"%>></OPTION>
                <OPTION value="#00FF00" style="background-color:#00FF00" <%if rsArticle("TitleFontColor")="#00FF00" then response.write " selected"%>></OPTION>
                <OPTION value="#00FFFF" style="background-color:#00FFFF" <%if rsArticle("TitleFontColor")="#00FFFF" then response.write " selected"%>></OPTION>
                <OPTION value="#FF00FF" style="background-color:#FF00FF" <%if rsArticle("TitleFontColor")="#FF00FF" then response.write " selected"%>></OPTION>
                <OPTION value="#FF0000" style="background-color:#FF0000" <%if rsArticle("TitleFontColor")="#FF0000" then response.write " selected"%>></OPTION>
                <OPTION value="#0000FF" style="background-color:#0000FF" <%if rsArticle("TitleFontColor")="#0000FF" then response.write " selected"%>></OPTION>
                <OPTION value="#008080" style="background-color:#008080" <%if rsArticle("TitleFontColor")="#008080" then response.write " selected"%>></OPTION>
              </select>
              <select name="TitleFontType" id="TitleFontType">
                <option value="0" <%if rsArticle("TitleFontType")="0" then response.write " selected"%>>����</option>
                <option value="1" <%if rsArticle("TitleFontType")="1" then response.write " selected"%>>����</option>
                <option value="2" <%if rsArticle("TitleFontType")="2" then response.write " selected"%>>б��</option>
                <option value="3" <%if rsArticle("TitleFontType")="3" then response.write " selected"%>>��+б</option>
                <option value="0" <%if rsArticle("TitleFontType")="4" then response.write " selected"%>>����</option>
              </select>
            </td>
          </tr>
          <tr class="tdbg"> 
            <td width="100" align="right"><strong>�ؼ��֣�</strong></td>
            <td><input name="Key" type="text"
           id="Key" value="<%=mid(rsArticle("Key"),2,len(rsArticle("Key"))-2)%>" size="50" maxlength="255"> 
              <font color="#FF0000">*</font><br>
              <font color="#0000FF">��������������£����������ؼ��֣��м���<font color="#FF0000">��|��</font>�ֿ������ܳ���&quot;'*?()���ַ���</font></td>
          </tr>
          <tr class="tdbg"> 
            <td width="100" align="right"><strong>���ߣ�</strong></td>
            <td>������ 
              <input name="AuthorName" type="text"
           id="AuthorName" value="<%=AuthorName%>" size="20" maxlength="30"> 
              &nbsp;&nbsp;&nbsp;&nbsp;Email�� 
              <input name="AuthorEmail" type="text" id="AuthorEmail" value="<%=AuthorEmail%>" size="40" maxlength="100"> 
            </td>
          </tr>
          <tr class="tdbg"> 
            <td width="100" align="right"><strong>ԭ������</strong></td>
            <td>���ƣ� 
              <input name="CopyFromName" type="text"
           id="CopyFromName" value="<%=CopyFromName%>" size="20" maxlength="50"> 
              &nbsp;&nbsp;&nbsp;&nbsp;�� ַ�� 
              <input name="CopyFromUrl" type="text" id="CopyFromUrl" value="<%=CopyFromUrl%>" size="40" maxlength="200"></td>
          </tr>
          <tr class="tdbg"> 
            <td width="100" align="right" valign="middle"><p><strong>�������ݣ�</strong></p>
              <p align="left"><font color="#006600">&middot;������Ǵ�������վ�ϸ������ݣ����������а�����ͼƬ����ϵͳ�����޸Ľ��ʱ���ѷǱ�վͼƬ���Ƶ���վ�������ϣ�ϵͳ������ͼƬ�Ĵ�С��Ӱ���ٶȣ����Ժ򣨴˹�����Ҫ��������װ��IE5.5���ϰ汾����Ч����<br>
                <br>
                &middot;�������밴Shift+Enter</font><br>
                <font color="#006600">&middot;������һ���밴Enter</font></p></td>
            <td><textarea name="Content" style="display:none"></textarea>
              <iframe ID="editor" src="editor.asp?Action=Modify&ArticleID=<%=ArticleID%>" frameborder=1 scrolling=no width="600" height="405"></iframe> 
            </td>
          </tr>
          <tr class="tdbg"> 
            <td width="100" align="right"><strong>���ݷ�ҳ��ʽ��</strong></td>
            <td><select name="PaginationType" id="PaginationType">
                <option value="0" <%if rsArticle("PaginationType")=0 then response.write " selected"%>>����ҳ</option>
                <option value="1" <%if rsArticle("PaginationType")=1 then response.write " selected"%>>�Զ���ҳ</option>
                <option value="2" <%if rsArticle("PaginationType")=2 then response.write " selected"%>>�ֶ���ҳ</option>
              </select> &nbsp;&nbsp;&nbsp;&nbsp;<strong><font color="#0000FF">ע��</font></strong><font color="#0000FF">�ֶ���ҳ�����Ϊ��</font><font color="#FF0000">[NextPage]</font><font color="#0000FF">����ע���Сд</font></td>
          </tr>
          <tr class="tdbg">
            <td align="right">&nbsp;</td>
            <td>�Զ���ҳʱ��ÿҳ��Լ�ַ���������HTML��ǣ���<strong> 
              <input name="MaxCharPerPage" type="text" id="MaxCharPerPage" value="<%=rsArticle("MaxCharPerPage")%>" size="8" maxlength="8">
              </strong></td>
          </tr>
          <tr class="tdbg"> 
            <td width="100" align="right"><strong>�����Ķ��ȼ���</strong></td>
            <td><select name="ReadLevel" id="select">
                <option value="9999" <%if rsArticle("ReadLevel")=9999 then response.write " selected"%>>�ο�</option>
                <option value="999" <%if rsArticle("ReadLevel")=999 then response.write " selected"%>>ע���û�</option>
                <option value="99" <%if rsArticle("ReadLevel")=99 then response.write " selected"%>>�շ��û�</option>
                <option value="9" <%if rsArticle("ReadLevel")=9 then response.write " selected"%>>VIP�û�</option>
                <option value="5" <%if rsArticle("ReadLevel")=5 then response.write " selected"%>>����Ա</option>
              </select>
              &nbsp;&nbsp;&nbsp;<font color="#0000FF">ֻ�о�����ӦȨ�޵��˲����Ķ������¡�</font></td>
          </tr>
          <tr class="tdbg">
            <td width="100" align="right"><strong>�����Ķ�������</strong></td>
            <td><input name="ReadPoint" type="text" id="ReadPoint" value="<%=rsArticle("ReadPoint")%>" size="5" maxlength="3">
              &nbsp;&nbsp;&nbsp;&nbsp; <font color="#0000FF">�������0�����û��Ķ�������ʱ��������Ӧ�����������οͺ͹���Ա��Ч��</font></td>
          </tr>
          <tr class="tdbg"> 
            <td width="100" align="right"><strong>����ͼƬ��</strong></td>
            <td><input name="IncludePic" type="checkbox" id="IncludePic" value="yes" <% if rsArticle("IncludePic")=true then response.Write("checked") end if%>>
              ��<font color="#0000FF">�����ѡ�еĻ����ڱ���ǰ����ʾ[ͼ��]��</font></td>
          </tr>
          <tr class="tdbg"> 
            <td width="100" align="right"><strong>��ҳͼƬ��</strong></td>
            <td><input name="DefaultPicUrl" type="text" id="DefaultPicUrl" value="<%=rsArticle("DefaultPicUrl")%>" size="56" maxlength="200">
              ��������ҳ��ͼƬ���´���ʾ <br>
              ֱ�Ӵ��ϴ�ͼƬ��ѡ�� 
              <select name="DefaultPicList" id="DefaultPicList" onChange="DefaultPicUrl.value=this.value;">
                <option value=""<% if rsArticle("DefaultPicUrl")="" then response.write "selected" %>>��ָ����ҳͼƬ</option>
                <%
				if rsArticle("UploadFiles")<>"" then
					dim IsOtherUrl
					IsOtherUrl=True
					if instr(rsArticle("UploadFiles"),"|")>1 then
						dim arrUploadFiles,intTemp
						arrUploadFiles=split(rsArticle("UploadFiles"),"|")						
						for intTemp=0 to ubound(arrUploadFiles)
							if rsArticle("DefaultPicUrl")=arrUploadFiles(intTemp) then
								response.write "<option value='" & arrUploadFiles(intTemp) & "' selected>" & arrUploadFiles(intTemp) & "</option>"
								IsOtherUrl=False
							else
								response.write "<option value='" & arrUploadFiles(intTemp) & "'>" & arrUploadFiles(intTemp) & "</option>"
							end if
						next
					else
						if rsArticle("UploadFiles")=rsArticle("DefaultPicUrl") then
							response.write "<option value='" & rsArticle("UploadFiles") & "' selected>" & rsArticle("UploadFiles") & "</option>"
							IsOtherUrl=False
						else
							response.write "<option value='" & rsArticle("UploadFiles") & "'>" & rsArticle("UploadFiles") & "</option>"		
						end if
					end If
					if IsOtherUrl=True then
						response.write "<option value='" & rsArticle("DefaultPicUrl") & "' selected>" & rsArticle("DefaultPicUrl") & "</option>"
					end if
				end if
				 %>
              </select> <input name="UploadFiles" type="hidden" id="UploadFiles" value="<%=rsArticle("UploadFiles")%>"> 
            </td>
          </tr>
<%if AdminPurview=1 or AdminPurview_Article<=2 then%>
          <tr class="tdbg"> 
            <td width="100" align="right"><strong>�������ʣ�</strong></td>
            <td><input name="OnTop" type="checkbox" id="OnTop" value="yes" <% if rsArticle("OnTop")=true then response.Write("checked") end if%>>
              �̶�����&nbsp;&nbsp;&nbsp;&nbsp; <input name="Hot" type="checkbox" id="Hot" value="yes" onclick="javascript:document.myform.Hits.value=<%=HitsOfHot%>" disabled>
              �ȵ�����&nbsp;&nbsp;&nbsp;&nbsp; <input name="Elite" type=checkbox id="Elite" value="yes" <% if rsArticle("Elite")=true then response.Write("checked") end if%>>
              �Ƽ�����&nbsp;&nbsp;&nbsp;&nbsp;�������ֵȼ��� 
              <select name="Stars" id="Stars">
                <option value="5" <%if rsArticle("Stars")=5 then response.write " selected"%>>������</option>
                <option value="4" <%if rsArticle("Stars")=4 then response.write " selected"%>>�����</option>
                <option value="3" <%if rsArticle("Stars")=3 then response.write " selected"%>>����</option>
                <option value="2" <%if rsArticle("Stars")=2 then response.write " selected"%>>���</option>
                <option value="1" <%if rsArticle("Stars")=1 then response.write " selected"%>>��</option>
                <option value="0" <%if rsArticle("Stars")=0 then response.write " selected"%>>��</option>
              </select>
            </td>
          </tr>
          <tr class="tdbg"> 
            <td width="100" align="right"><strong>�������</strong></td>
            <td><input name="Hits" type="text" id="Hits" value="<%=rsArticle("Hits")%>" size="10" maxlength="10"> 
              &nbsp;&nbsp;<font color="#0000FF">�⹦�����ṩ������Ա�����õġ�����������Ҫ��ѽ��^_^</font></td>
          </tr>
          <tr class="tdbg"> 
            <td width="100" align="right"><strong>¼��ʱ�䣺</strong></td>
            <td><input name="UpdateTime" type="text" id="UpdateTime" value="<%=rsArticle("UpdateTime")%>" maxlength="50">
              ʱ���ʽΪ����-��-�� ʱ:��:�롱���磺<font color="#0000FF">2003-5-12 12:32:47</font> 
            </td>
          </tr>
<%end if%>
          <tr class="tdbg"> 
            <td width="100" align="right"><strong>��ɫģ�壺</strong></td>
            <td><%call Admin_ShowSkin_Option(rsArticle("SkinID"))%>&nbsp;���ģ���а���CSS����ɫ��ͼƬ����Ϣ</td>
          </tr>
          <tr class="tdbg"> 
            <td width="100" align="right"><strong>�������ģ�壺</strong></td>
            <td><%call Admin_ShowLayout_Option(3,rsArticle("LayoutID"))%>&nbsp;���ģ���а����˰�����Ƶİ�ʽ����Ϣ</td>
          </tr>
<%if AdminPurview=1 or AdminPurview_Article<=2 then%>
          <tr class="tdbg"> 
            <td width="100" align="right"><strong>��ͨ����ˣ�</strong></td>
            <td><input name="Passed" type="checkbox" id="Passed" value="yes" <% if rsArticle("Passed")=true then response.Write("checked") end if%>>
              ��<font color="#0000FF">�����ѡ�еĻ���ֱ�ӷ�����������˺���ܷ�������</font></td>
          </tr>
<%end if%>
        </table>
      </td>
    </tr>
  </table>
  <div align="center"> 
    <p> 
      <input name="ArticleID" type="hidden" id="ArticleID" value="<%=rsArticle("ArticleID")%>">
      <input
  name="Save" type="submit"  id="Save" value="�����޸Ľ��" style="cursor:hand;">
      &nbsp; 
      <input name="Cancel" type="button" id="Cancel" value=" ȡ �� " onClick="window.location.href='Admin_ArticleManage.asp'" style="cursor:hand;">
    </p>
  </div>
</form>
</body>
</html>
<%
end if
rsArticle.close
set rsArticle=nothing
call CloseConn()
%>