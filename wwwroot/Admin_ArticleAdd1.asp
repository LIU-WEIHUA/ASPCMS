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
<title>������£����ģʽ��</title>
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
  document.myform.PaginationType.value=2;
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

<body>
<form method="POST" name="myform" onSubmit="return CheckForm();" action="Admin_ArticleSave.asp" target="_self">
  <table border="0" align="center" cellpadding="0" cellspacing="0" class="border">
    <tr class="title">
      <td height="22" align="center"><b>�� �� �� �£����ģʽ��</b></td>
    </tr>
    <tr align="center">
      <td>
	<table width="100%" border="0" cellpadding="2" cellspacing="1">
          <tr class="tdbg"> 
            <td width="100" align="right"><strong>������Ŀ��</strong></td>
            <td><select name='ClassID'><%call Admin_ShowClass_Option(3,ClassID)%></select>              
            </td>
            <td><%response.write "<font color='#FF0000'><strong>ע�⣺</strong></font><font color='#0000FF'>1������ָ��Ϊ��������Ŀ����Ŀ�������ⲿ��Ŀ"
			if AdminPurview=2 and AdminPurview_Article=3 then
              response.write "<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2����ֻ����<font color='#FF0000'>��ɫ��Ŀ</font>��������Ŀ�з�������</font>"
			end if%></td>
          </tr>
          <tr class="tdbg"> 
            <td width="100" align="right"><strong>�����γ̣�</strong></td>
            <td colspan="2"><%call Admin_ShowSpecial_Option(1,SpecialID)%> <font color="#FF0000">*</font>  </td>
          </tr>
          <tr class="tdbg"> 
            <td width="100" align="right"><strong>���±��⣺</strong></td>
            <td colspan="2"><input name="Title" type="text" id="Title" value="" size="50" maxlength="255"> 
              <font color="#FF0000">*</font></td>
          </tr>
          <tr class="tdbg"> 
            <td width="100" align="right"><strong>�ؼ��֣�</strong></td>
            <td colspan="2"><input name="Key" type="text"
           id="Key" value="<%=session("Key")%>" size="50" maxlength="255"> <font color="#FF0000">*</font><br>
              <font color="#0000FF">��������������£����������ؼ��֣��м���<font color="#FF0000">��|��</font>���������ܳ���&quot;&quot;'*?,.()���ַ���</font></td>
          </tr>
          <tr class="tdbg"> 
            <td width="100" align="right"><strong>���ߣ�</strong></td>
            <td colspan="2"> <input name="Author" type="text"
           id="Author" value="<%=session("Author")%>" size="50" maxlength="100"> 
            </td>
          </tr>
          <tr class="tdbg"> 
            <td width="100" align="right"><strong>ת���ԣ�</strong></td>
            <td colspan="2"> <input name="CopyFrom" type="text"
           id="CopyFrom" value="<%=session("CopyFrom")%>" size="50" maxlength="100"> 
            </td>
          </tr>
          <tr class="tdbg"> 
            <td width="100" align="right" valign="middle"><p><strong>�������ݣ�</strong></p>
              <p align="left"><font color="#006600"><% if EnableSaveRemote="Yes" then%>&middot;������Ǵ�������վ�ϸ������ݣ����������а�����ͼƬ����ϵͳ�����ͼƬ���Ƶ���վ�������ϣ�ϵͳ������ͼƬ�Ĵ�С��Ӱ���ٶȣ����Ժ򣨴˹�����Ҫ��������װ��IE5.5���ϰ汾����Ч����<%end if%><br>
                <br>
                &middot;�������밴Shift+Enter</font><br>
                <font color="#006600">&middot;������һ���밴Enter</font><br>
              </p></td>
            <td colspan="2"><textarea name="Content" style="display:none"></textarea> 
              <iframe ID="editor" src="editor.asp" frameborder=1 scrolling=no width="600" height="405"></iframe> 
            </td>
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
      <input name="PaginationType" type="hidden" id="PaginationType" value="0"> 
      <%dim trs
	  set trs=conn.execute("select SkinID from Skin where IsDefault=True")
	  %>
	  <input name="SkinID" type="hidden" id="SkinID" value="<%=trs(0)%>">
      <%
	  set trs=conn.execute("select LayoutID from Layout where IsDefault=True and LayoutType=3")
	  %>
      <input name="LayoutID" type="hidden" id="LayoutID" value="<%=trs(0)%>">
      <input name="Action" type="hidden" id="Action" value="Add1">
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
