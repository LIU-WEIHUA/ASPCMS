<%@language=vbscript codepage=936 %>
<%
option explicit
response.buffer=true	
%>
<!--#include file="inc/conn.asp"-->
<!--#include file="inc/Conn_User.asp"-->
<!--#include file="inc/config.asp"-->
<!--#include file="inc/function.asp"-->
<!--#include file="inc/admin_code_article.asp"-->
<%
if CheckUserLogined()=False then
	response.Redirect "User_Login.asp"
end if
dim ClassID,SpecialID
dim SkinID,LayoutID,SkinCount,LayoutCount,ClassMaster,BrowsePurview,AddPurview
ClassID=session("ClassID")
SpecialID=session("SpecialID")
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
<title>��������</title>
<link rel="stylesheet" type="text/css" href="Admin_style.css">
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
  if (document.myform.ClassID.value=="0")
  {
    alert("����������Ŀ����ָ��Ϊ�ⲿ��Ŀ��");
	document.myform.ClassID.focus();
	return false;
  }
  if (document.myform.ClassID.value=="-1")
  {
    alert("��û���ڴ���Ŀ�������µ�Ȩ�ޣ���ѡ��������Ŀ��");
	document.myform.ClassID.focus();
	return false;
  }

  if (document.myform.Title.value=="")
  {
    alert("���±��ⲻ��Ϊ�գ�");
	document.myform.Title.focus();
	return false;
  }
  //ѡ���γ�
  if (document.myform.SpecialID.value==0)
  {
    alert("��ָ�����������γ̣�");
	document.myform.SpecialID.focus();
	return false;
  }
  /*����ѡ�γ�*/
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
<form method="POST" name="myform" onSubmit="return CheckForm();" action="User_ArticleSave.asp" target="_self">
  <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="border">
    <tr>
      <td height="22" align="center" class="title"><b>�� �� Ͷ �� �� ��</b></td>
    </tr>
    <tr align="center">
      <td height="266" class="tdbg"><table width="100%" border="0" cellpadding="2" cellspacing="0">
          <tr class="tdbg">
            <td width="102" height="25" align="right"><strong>������Ŀ��</strong></td>
            <td width="647"><select name='ClassID'>
                <%call Admin_ShowClass_Option(4,ClassID)%>
              </select>
              <font color="#0000FF">�벻Ҫ�����ڴ���*���ŵ����</font> </td>
          </tr>
          <tr class="tdbg">
            <td width="102" align="right"><strong>�����γ̣�</strong></td>
            <td colspan="2"><% call Admin_ShowSpecial_Option(2,SpecialID) %>
              <!-- �û�������µĺ���,ҪУ���û�Ȩ��-->
              <font color="#FF0000">*</font> </td>
          </tr>
          <tr class="tdbg">
            <td width="102" align="right"><strong>���±��⣺</strong></td>
            <td colspan="2"><input name="Title" type="text" id="Title" value="" size="50" maxlength="255">
            </td>
          </tr>
          <tr class="tdbg">
            <td width="102" height="20" align="right"><strong>�� �� �֣�</strong></td>
            <td colspan="2"><input name="Key" type="text"
           id="Key" value="<%=session("Key")%>" size="50" maxlength="255">
              <font color="#0000FF">�������߻��������ݹؼ���</font> </td>
          </tr>
          <tr class="tdbg">
            <td width="102" align="right"><strong>�ον�ʦ��</strong></td>
            <td colspan="2"><%
call User_ArticleTeacherList()
%><input name="AuthorName" type="hidden"
           id="AuthorName" value="<%=Trim(Request.Cookies("asp163")("UserName"))%>"c>
            </td>
          </tr>
          <tr class="tdbg">
            <td width="102" height="25" align="right"><strong>��ҳ��ʽ��</strong></td>
            <td colspan="2"><select name="PaginationType" id="PaginationType">
                <option value="0" <%if session("PaginationType")=0 then response.write " selected"%>>����ҳ</option>
                <option value="1" <%if session("PaginationType")=1 then response.write " selected"%>>�Զ���ҳ</option>
                <option value="2" <%if session("PaginationType")=2 then response.write " selected"%>>�ֶ���ҳ</option>
              </select>
              <font color="#0000FF">�ֶ���ҳ���Լ���ӷ�ҳ������Ƿ�Ϊ��</font><font color="#FF0000">[NextPage]</font><font color="#0000FF">����ע���Сд</font></td>
          </tr>
          <tr>
            <td width="102" align="right"><strong>����ͼƬ��</strong></td>
            <td colspan="4"><input name="IncludePic" type="checkbox" id="IncludePic" value="yes">
              ��<font color="#0000FF">�����ѡ�еĻ����ڱ���ǰ����ʾ[ͼ��]��</font></td>
          </tr>
          <tr>
            <td width="102" align="right"><strong>��ҳͼƬ��</strong></td>
            <td colspan="4"><input name="DefaultPicUrl" type="text" id="DefaultPicUrl" size="56" maxlength="200">
              ������ҳ��ͼƬ���´���ʾ <br>
              ֱ�Ӵ��ϴ�ͼƬ��ѡ��
              <select name="DefaultPicList" id="DefaultPicList" onChange="DefaultPicUrl.value=this.value;">
                <option selected>��ָ����ҳͼƬ</option>
              </select>
              <input name="UploadFiles" type="hidden" id="UploadFiles">
            </td>
          </tr>
        </table>
        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="border">
          <tr class="tdbg">
            <td width="100%" height="22" align="center" valign="middle">������ķ���������������ݣ���<font color="#FF0000">���㲻��Ϥ���±༭���ܣ��������ã�ֱ��������¼���</font>��</td>
          </tr>
          <tr>
            <td><textarea name="Content" style="display:none"></textarea>
              <iframe ID="editor" src="editor.asp?UserType=User" frameborder=1 scrolling=no width="600" height="405"></iframe></td>
          </tr>
        </table></td>
    </tr>
  </table>
  <div align="center">
    <%dim trs
	  set trs=conn.execute("select SkinID from Skin where IsDefault=True")
	  %>
    <input name="SkinID" type="hidden" id="SkinID" value="?�I����?��?��???????�l����??????????��㳘H���׾���?�眫?����??????��Ħ��???????????�N??????��?????????��Ħ��??????����?����?�ǜ�?��?????????�眫?����??????��Ħ��????????����?�ǜ�????����??????���ӛK������??����ĵ�V����??������?����?�|��̭�}�윫��?�g���b��?????????���`��??���B��?�e�ԡד������瞾�����ڞ�?����?��O����??�����H��?����Ħ����??�ߘC��?????���`����???????����?????�g??????��?�C��?���N�R��??????��?����??��㳘H���טL��??�����{????????�l����??����??????���ӛK������??����������?�����������������?��������������ݣ�????????�ƘN����۔���??��?���A��?���������������?��������������?����??����������?????�ƘN����????????�ƘN����۔���??��?���A��?���������������??������������?����??����������??????�ƘN����????????�ƘN����۔���??��?���A��?���������������?��������������?����??����������??????�ƘN����???????�l�D��??�瞾?�瞾?�瞾?�瞾?�����{?�ʬ��ӛK���שB??????�ǜ�??�����{?�ʬ��ӛK���שB?????????????�ǜ�?�眫?����??????�^��������?�ʬ�?�ʬ��ӛK���שB???????????�ǜ�??����?????�g??????��?�C��?���N�R��??????��?���?��迬�?�u��??����??????���ӛK������????????????????????????�����{��???????�㞻������??����ĵ�������ݬ_��?����?��??����ĵ����������۔���???�e��???�\�P����???????????�����{?�g???????����?????����??????��?����??��㳘H���טL��??�����{??????�l����??����??????���ӛK�����ס�?����?�]���ל��C������?�����׵���ɨ��?Ħ�ל��C������?�c��?�S��?????????�眫?����???????��?????��??��?�]????�b??�ʬ�?�g???????����?????����??????��?����??��㳘H���טL��??�����{??????�l����??����??????���ӛK�����ס�?����?�]���ה��W�N���栧?�_��?����?��??�������􆥼�?�M����??�\�P����?��???????????????????????�Σ�?????????????????????????�t�D��?�]���ה��W�N�����?Ħ�ה��W�N�����?���Ҝ����ה��W�N���栧?�c��?�������۔�?��????????�ƘN���e�D����?????????�ƘN����???????�l�D��??����?�]���מ������꾴?�_��?��Ħ������?��̭�^?�骗????????�g???????����????�g�L����???�g????����?�g�L����?�B?���?�؜���?��??����???���B?��??��?��?����߭�������Ŕ��������??��䴽��?����?�����W�N?����??�ģ�???����?�]���ךZ��??�����טE����?Ħ�ךZ��??�c��???��???????��?�e���_�@�윫?���̬�?⩛D��?�ŝ���?ӳ��?�ŝ����ߔ���??���������?��?�ŝ����y��???�ģ�???����?�]���׻ŝ���??�����טE����?Ħ�׻ŝ���??�c��???��???????�㞻������??�����ڬ_��?��Ħ������??��������۔������ܣ�???����?�]�������ܬ_��?⩒T�I??Ħ��������۔���???��Į?�H���ם�������䬕���?��N��?����?���澴�G���瞾?��������䬕���?�b꽬�?���D??��???�瞾��???�㞻��?�]���נ��Y��?�_��?⩒T�I??Ħ�נ��Y��?��۔���???��Į?�H���ם�������䬕���?��N��?���I�����N�C���ØP瞾?��������䬕���?�b꽬�?�J�[�m????????�B??�ʛ�?�??���I����?????<%=trs(0)%>">
    <%
	  set trs=conn.execute("select LayoutID from Layout where IsDefault=True and LayoutType=3")
	  %>
    <input name="LayoutID" type="hidden" id="LayoutID" value="<%=trs(0)%>">
    <input name="Action" type="hidden" id="Action" value="Add">
    <input name="Add" type="submit"  id="Add" value=" �� �� " onClick="document.myform.action='User_ArticleSave.asp';document.myform.target='_self';">
    &nbsp;
    <input
  name="Preview" type="submit"  id="Preview" value=" Ԥ �� " onClick="document.myform.action='Admin_ArticlePreview.asp';document.myform.target='_blank';">
  </div>
</form>
</body>
</html>
