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
dim ClassID,SpecialID
dim SkinID,LayoutID,SkinCount,LayoutCount,ClassMaster,BrowsePurview,AddPurview
ClassID=session("ClassID_Article")
SpecialID=session("SpecialID_Article")
if ClassID="" then
	ClassID=0
else
	ClassID=Clng(ClassID)
end if
if SpecialID="" then
	SpecialID=0
else
	SpecialID=Clng(SpecialID)
end if
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta name="GENERATOR" content="Microsoft FrontPage 3.0">
<title>������£��߼�ģʽ��</title>
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

  if (document.myform.ClassID.value=="")
  {
    alert("����������Ŀ����ָ��Ϊ��������Ŀ����Ŀ��");
	document.myform.ClassID.focus();
	return false;
  }
  if (document.myform.ClassID.value==0)
  {
    alert("����������Ŀ����ָ��Ϊ�ⲿ��Ŀ��");
	document.myform.ClassID.focus();
	return false;
  }

  if (document.myform.Title.value=="")
  {
    alert("���±��ⲻ��Ϊ�գ�");
	document.myform.Title.focus();
	return false;
  }
  
    if (document.myform.SpecialID.value==0)
  {
    alert("��ָ�����������γ̣�");
	document.myform.SpecialID.focus();
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
    alert("��������̫����������ACCESS���ݿ�����ƣ�64KB�������齫���·ֳɼ�����¼�롣");
	editor.HtmlEdit.focus();
	return false;
  }
  return true;  
}
</script>

</head>

<body>
<form method="POST" name="myform" onSubmit="return CheckForm();" action="Admin_ArticleSave.asp" target="_self">
  <table border="0" align="center" cellpadding="0" cellspacing="0" class="border">
    <tr class="title">
      <td height="22" align="center"><b>�� �� �� �£��߼�ģʽ��</b></td>
    </tr>
    <tr align="center">
      <td>
	<table width="100%" border="0" cellpadding="2" cellspacing="1">
          <tr class="tdbg"> 
            <td width="100" align="right"><strong>������Ŀ��</strong></td>
            <td><select name='ClassID'>
                <%call Admin_ShowClass_Option(3,ClassID)%>
              </select>
              </td>
            <td><%response.write "<font color='#FF0000'><strong>ע�⣺</strong></font><font color='#0000FF'>1������ָ��Ϊ��������Ŀ����Ŀ�������ⲿ��Ŀ"
			if AdminPurview=2 and AdminPurview_Article=3 then
              response.write "<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2����ֻ����<font color='#FF0000'>��ɫ��Ŀ</font>��������Ŀ�з�������</font>"
			end if%>
            </td>
          </tr>
          <tr class="tdbg"> 
            <td width="100" align="right"><strong>�����γ̣�</strong></td>
            <td colspan="2"><%call Admin_ShowSpecial_Option(1,SpecialID)%>  <font color="#FF0000">*</font>  </td>
          </tr>
          <tr class="tdbg"> 
            <td width="100" align="right"><strong>���±��⣺</strong></td>
            <td colspan="2"><input name="Title" type="text" id="Title" value="" size="50" maxlength="255"> 
              <font color="#FF0000">*</font> <select name="TitleFontColor" id="TitleFontColor">
                <option value="" selected>��ɫ</option>
                <OPTION value="">Ĭ��</OPTION>
                <OPTION value="#000000" style="background-color:#000000"></OPTION>
                <OPTION value="#FFFFFF" style="background-color:#FFFFFF"></OPTION>
                <OPTION value="#008000" style="background-color:#008000"></OPTION>
                <OPTION value="#800000" style="background-color:#800000"></OPTION>
                <OPTION value="#808000" style="background-color:#808000"></OPTION>
                <OPTION value="#000080" style="background-color:#000080"></OPTION>
                <OPTION value="#800080" style="background-color:#800080"></OPTION>
                <OPTION value="#808080" style="background-color:#808080"></OPTION>
                <OPTION value="#FFFF00" style="background-color:#FFFF00"></OPTION>
                <OPTION value="#00FF00" style="background-color:#00FF00"></OPTION>
                <OPTION value="#00FFFF" style="background-color:#00FFFF"></OPTION>
                <OPTION value="#FF00FF" style="background-color:#FF00FF"></OPTION>
                <OPTION value="#FF0000" style="background-color:#FF0000"></OPTION>
                <OPTION value="#0000FF" style="background-color:#0000FF"></OPTION>
                <OPTION value="#008080" style="background-color:#008080"></OPTION>
              </select> <select name="TitleFontType" id="TitleFontType">
                <option value="0" selected>����</option>
                <option value="1">����</option>
                <option value="2">б��</option>
                <option value="3">��+б</option>
                <option value="0">����</option>
              </select> </td>
          </tr>
          <tr class="tdbg"> 
            <td width="100" align="right"><strong>�ؼ��֣�</strong></td>
            <td colspan="2"><input name="Key" type="text"
           id="Key" value="<%=session("Key")%>" size="50" maxlength="255"> <font color="#FF0000">*</font><br>
              <font color="#0000FF">��������������£����������ؼ��֣��м���<font color="#FF0000">��|��</font>�ֿ������ܳ���&quot;&quot;'*?,.()���ַ���</font></td>
          </tr>
          <tr class="tdbg"> 
            <td width="100" align="right"><strong>���ߣ�</strong></td>
            <td colspan="2"> ������ 
              <input name="AuthorName" type="text"
           id="AuthorName" value="<%=session("AuthorName")%>" size="20" maxlength="30"> 
              &nbsp;&nbsp;&nbsp;&nbsp;Email�� 
              <input name="AuthorEmail" type="text" id="AuthorEmail" value="<%=session("AuthorEmail")%>" size="40" maxlength="100"> 
            </td>
          </tr>
          <tr class="tdbg"> 
            <td width="100" align="right"><strong>ת���ԣ�</strong></td>
            <td colspan="2">���ƣ� 
              <input name="CopyFromName" type="text"
           id="CopyFromName" value="<%=session("CopyFromName")%>" size="20" maxlength="50"> 
              &nbsp;&nbsp;&nbsp;&nbsp;�� ַ�� 
              <input name="CopyFromUrl" type="text" id="CopyFromUrl2" value="<%=session("CopyFromUrl")%>" size="40" maxlength="200"> 
            </td>
          </tr>
          <tr class="tdbg"> 
            <td width="100" align="right" valign="middle"><p><strong>�������ݣ�</strong></p>
              <p align="left"><font color="#006600"><% if EnableSaveRemote="Yes" then%>&middot;������Ǵ�������վ�ϸ������ݣ����������а�����ͼƬ����ϵͳ�����ͼƬ���Ƶ���վ�������ϣ�ϵͳ������ͼƬ�Ĵ�С��Ӱ���ٶȣ����Ժ򣨴˹�����Ҫ��������װ��IE5.5���ϰ汾����Ч����<%end if%><br>
                <br>
                &middot;�������밴Shift+Enter</font><br>
                <font color="#006600">&middot;������һ���밴Enter</font></p></td>
            <td colspan="2"><textarea name="Content" style="display:none"></textarea> 
              <iframe ID="editor" src="editor.asp" frameborder=1 scrolling=no width="600" height="405"></iframe> 
            </td>
          </tr>
          <tr class="tdbg"> 
            <td width="100" align="right"><strong>���ݷ�ҳ��ʽ��</strong></td>
            <td colspan="2"><select name="PaginationType" id="PaginationType">
                <option value="0" <%if session("PaginationType")=0 then response.write " selected"%>>����ҳ</option>
                <option value="1" <%if session("PaginationType")=1 then response.write " selected"%>>�Զ���ҳ</option>
                <option value="2" <%if session("PaginationType")=2 then response.write " selected"%>>�ֶ���ҳ</option>
              </select> &nbsp;&nbsp;&nbsp;&nbsp;<strong><font color="#0000FF">ע��</font></strong><font color="#0000FF">�ֶ���ҳ�����Ϊ��</font><font color="#FF0000">[NextPage]</font><font color="#0000FF">����ע���Сд</font></td>
          </tr>
          <tr class="tdbg">
            <td align="right">&nbsp;</td>
            <td colspan="2">�Զ���ҳʱ��ÿҳ��Լ�ַ���������HTML��ǣ���<strong> 
              <input name="MaxCharPerPage" type="text" id="MaxCharPerPage" value="10000" size="8" maxlength="8">
              </strong></td>
          </tr>
          <tr class="tdbg"> 
            <td width="100" align="right"><strong>�����Ķ��ȼ���</strong></td>
            <td colspan="2"><select name="ReadLevel" id="ReadLevel">
                <option value="9999" <%if session("ReadLevel")=9999 then response.write " selected"%>>�ο�</option>
                <option value="999" <%if session("ReadLevel")=999 then response.write " selected"%>>ע���û�</option>
                <option value="99" <%if session("ReadLevel")=99 then response.write " selected"%>>�շ��û�</option>
                <option value="9" <%if session("ReadLevel")=9 then response.write " selected"%>>VIP�û�</option>
                <option value="5" <%if session("ReadLevel")=5 then response.write " selected"%>>����Ա</option>
              </select>
              &nbsp;&nbsp;&nbsp;<font color="#0000FF">ֻ�о�����ӦȨ�޵��˲����Ķ������¡�</font></td>
          </tr>
          <tr class="tdbg"> 
            <td width="100" align="right"><strong>�����Ķ�������</strong></td>
            <td colspan="2"><input name="ReadPoint" type="text" id="ReadPoint" value="<%=session("ReadPoint")%>" size="5" maxlength="3"> 
              &nbsp;&nbsp;&nbsp;&nbsp; <font color="#0000FF">�������0�����û��Ķ�������ʱ��������Ӧ�����������οͺ͹���Ա��Ч��</font></td>
          </tr>
          <tr class="tdbg"> 
            <td width="100" align="right"><strong>����ͼƬ��</strong></td>
            <td colspan="2"><input name="IncludePic" type="checkbox" id="IncludePic" value="yes">
              ��<font color="#0000FF">�����ѡ�еĻ����ڱ���ǰ����ʾ[ͼ��]��</font></td>
          </tr>
          <tr class="tdbg"> 
            <td width="100" align="right"><strong>��ҳͼƬ��</strong></td>
            <td colspan="2"><input name="DefaultPicUrl" type="text" id="DefaultPicUrl" size="56" maxlength="200">
              ��������ҳ��ͼƬ���´���ʾ <br>
              ֱ�Ӵ��ϴ�ͼƬ��ѡ�� 
              <select name="DefaultPicList" id="DefaultPicList" onChange="DefaultPicUrl.value=this.value;">
                <option selected>��ָ����ҳͼƬ</option>
              </select> <input name="UploadFiles" type="hidden" id="UploadFiles"> 
            </td>
          </tr>
<%if AdminPurview=1 or AdminPurview_Article<=2 then%>
          <tr class="tdbg"> 
            <td width="100" align="right"><strong>�������ʣ�</strong></td>
            <td colspan="2"><input name="OnTop" type="checkbox" id="OnTop" value="yes">
              �̶�����&nbsp;&nbsp;&nbsp;&nbsp; <input name="Hot" type="checkbox" id="Hot" value="yes" onClick="javascript:document.myform.Hits.value=<%=HitsOfHot%>">
              �ȵ�����&nbsp;&nbsp;&nbsp;&nbsp; <input name="Elite" type=checkbox id="Elite" value="yes">
              �Ƽ�����&nbsp;&nbsp;&nbsp;&nbsp;�������ֵȼ��� 
              <select name="Stars" id="Stars">
                <option value="5">������</option>
                <option value="4">�����</option>
                <option value="3" selected>����</option>
                <option value="2">���</option>
                <option value="1">��</option>
                <option value="0">��</option>
              </select></td>
          </tr>
          <tr class="tdbg"> 
            <td width="100" align="right"><strong>�������ʼֵ��</strong></td>
            <td colspan="2"><input name="Hits" type="text" id="Hits" value="0" size="10" maxlength="10"> 
              &nbsp;&nbsp; <font color="#0000FF">�⹦�����ṩ������Ա�����õġ�����������Ҫ��ѽ��^_^</font></td>
          </tr>
          <tr class="tdbg"> 
            <td width="100" align="right"><strong>¼��ʱ�䣺</strong></td>
            <td colspan="2"><input name="UpdateTime" type="text" id="UpdateTime" value="<%=now()%>" maxlength="50">
              ʱ���ʽΪ����-��-�� ʱ:��:�롱���磺<font color="#0000FF">2003-5-12 12:32:47</font></td>
          </tr>
<%end if%>
          <tr class="tdbg"> 
            <td width="100" align="right"><strong>��ɫģ�壺</strong></td>
            <td colspan="2"><%call Admin_ShowSkin_Option(session("SkinID"))%>&nbsp;���ģ���а���CSS����ɫ��ͼƬ����Ϣ</td>
          </tr>
          <tr class="tdbg"> 
            <td width="100" align="right"><strong>�������ģ�壺</strong></td>
            <td colspan="2"><%call Admin_ShowLayout_Option(3,session("LayoutID"))%>&nbsp;���ģ���а����˰�����Ƶİ�ʽ����Ϣ</td>
          </tr>
<%if AdminPurview=1 or AdminPurview_Article<=2 then%>
          <tr class="tdbg"> 
            <td width="100" align="right"><strong>����������</strong></td>
            <td colspan="2"><input name="Passed" type="checkbox" id="Passed" value="yes" checked>
              ��<font color="#0000FF">�����ѡ�еĻ���ֱ�ӷ�����������˺���ܷ�������</font></td>
          </tr>
<%end if%>
        </table>
      </td>
    </tr>
  </table>
  <div align="center"> 
    <p> 
      <input name="Action" type="hidden" id="Action" value="Add2">
      <input
  name="Add" type="submit"  id="Add" value=" �� �� " onClick="document.myform.action='Admin_ArticleSave.asp';document.myform.target='_self';" style="cursor:hand;">
      &nbsp; 
      <input
  name="Preview" type="submit"  id="Preview" value=" Ԥ �� " onClick="document.myform.action='Admin_ArticlePreview.asp';document.myform.target='_blank';" style="cursor:hand;">
      &nbsp;
      <input name="Cancel" type="button" id="Cancel" value=" ȡ �� " onClick="window.location.href='Admin_ArticleManage.asp'" style="cursor:hand;">
    </p>
  </div>
</form>
</body>
</html>
<%
call CloseConn()
%>
