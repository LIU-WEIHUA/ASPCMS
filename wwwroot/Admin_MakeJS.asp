<%@language=vbscript codepage=936 %>
<%
option explicit
response.buffer=true	
Const PurviewLevel=2    '����Ȩ��
Const CheckChannelID=0    '����Ƶ����0Ϊ���������Ƶ��
Const PurviewLevel_Others="JS"
%>
<!--#include file="inc/conn.asp"-->
<!--#include file="inc/config.asp"-->
<!--#include file="Admin_ChkPurview.asp"-->
<!--#include file="inc/admin_code_article.asp"-->
<%
dim ClassID,SpecialID
%>
<html>
<head>
<title>JS�������</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="Admin_Style.css" rel="stylesheet" type="text/css">
<script language="javascript">
<!--
function copy() {
document.myform.JsCode.focus();
document.myform.JsCode.select();
textRange = document.myform.JsCode.createTextRange();
textRange.execCommand("Copy");
}
// -->
</script>
</head>

<body leftmargin="2" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" class="border">
  <tr class="topbg"> 
    <td height="22" colspan="2" align="center"><strong>JS �� �� �� ��</strong></td>
  </tr>
  <tr class="tdbg"> 
    <td width="70" height="30"><strong>��������</strong></td>
    <td height="30"><a href="Admin_MakeJS.asp?Action=JS_Common">��ͨ���µ�JS����</a> 
      | <a href="Admin_MakeJS.asp?Action=JS_Pic">��ҳͼ�ĵ�JS����</a></td>
  </tr>
</table>
<%
dim Action
Action=trim(request("Action"))
if Action="JS_Common" then
	call JS_Common()
elseif Action="JS_Pic" then
	call JS_Pic
end if
call CloseConn()


sub JS_Common()
%>
<form action="" method="post" name="myform" id="myform">
  <table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" class="border">
    <tr class="title"> 
      <td height="22" colspan="2" align="center"><strong>��ͨ���µ�JS����</strong></td>
    </tr>
    <tr class="tdbg"> 
      <td height="25" align="right">������Ŀ��</td>
      <td height="25"><select name="ClassID" id="ClassID">
          <option value="0">��ָ����Ŀ</option>
          <%call Admin_ShowClass_Option(2,0)%>
        </select> <font color="#0000FF">&nbsp;&nbsp;����ָ��Ϊ�ⲿ��Ŀ</font>&nbsp;&nbsp;&nbsp;&nbsp; 
        <input name="IncludeChild" type="checkbox" id="IncludeChild" value="True" checked>
        ��������Ŀ</td>
    </tr>
    <tr class="tdbg">
      <td height="25" align="right">����ר�⣺</td>
      <td height="25">
        <%call Admin_ShowSpecial_Option(1,SpecialID)%>
      </td>
    </tr>
    <tr class="tdbg"> 
      <td height="25" align="right">������Ŀ��</td>
      <td height="25"><input name="ArticleNum" type="text" value="10" size="5" maxlength="3"> 
        &nbsp;&nbsp;&nbsp;&nbsp;<font color="#FF0000">���Ϊ�գ�����ʾ��������</font></td>
    </tr>
    <tr class="tdbg"> 
      <td height="25" align="right">��ʾ���ͣ�</td>
      <td height="25"><select name="ShowType" id="select">
          <option value="1" selected>���±����б�</option>
          <option value="2">���±���+��������</option>
        </select> &nbsp;&nbsp;&nbsp;&nbsp;������ 
        <select name="ShowCols" id="ShowCols">
          <option value="1" selected>һ��</option>
          <option value="2">����</option>
          <option value="3">����</option>
        </select> </td>
    </tr>
    <tr class="tdbg"> 
      <td height="50" align="right">��ʾ���ݣ�</td>
      <td height="50"><input name="ShowProperty" type="checkbox" id="ShowProperty" value="True" checked>
        ��������&nbsp;&nbsp;&nbsp;&nbsp; <input name="ShowClassName" type="checkbox" id="ShowClassName" value="True">
        ������Ŀ&nbsp;&nbsp;&nbsp;&nbsp; <input name="ShowIncludePic" type="checkbox" id="ShowIncludePic" value="True" checked>
        ͼ�ı�־&nbsp;&nbsp;&nbsp;&nbsp; <input name="ShowTitle" type="checkbox" id="ShowTitle" value="True" checked disabled>
        ���±��� 
        <input type="checkbox" name="checkbox2" value="checkbox">
        ��������<br> <input name="ShowUpdateTime" type="checkbox" id="ShowUpdateTime" value="True">
        ����ʱ��&nbsp;&nbsp;&nbsp;&nbsp; <input name="ShowHits" type="checkbox" id="ShowHits" value="True">
        �������&nbsp;&nbsp;&nbsp;&nbsp; <input name="ShowAuthor" type="checkbox" id="ShowAuthor" value="True">
        ����&nbsp;&nbsp;&nbsp;&nbsp; <input name="ShowHot" type="checkbox" id="ShowHot" value="True" checked>
        �ȵ����±�־ 
        <input name="ShowMore" type="checkbox" id="ShowMore" value="True">
        �����࡭��������</td>
    </tr>
    <tr class="tdbg"> 
      <td height="25" align="right">��������ַ�����</td>
      <td height="25"><input name="TitleMaxLen" type="text" id="TitleMaxLen" value="30" size="5" maxlength="3"> 
        &nbsp;&nbsp;&nbsp;&nbsp;<font color="#FF0000">���Ϊ�գ�����ʾ�������⡣��ĸ��һ���ַ������������ַ���</font></td>
    </tr>
    <tr class="tdbg"> 
      <td height="25" align="right">���������ַ�����</td>
      <td height="25"><input name="ContentMaxLen" type="text" id="ContentMaxLen" value="200" size="5" maxlength="3"> 
        &nbsp;&nbsp;&nbsp;&nbsp;<font color="#FF0000">ֻ�е���ʾ������Ϊ������+���ݡ�ʱ����Ч</font></td>
    </tr>
    <tr class="tdbg"> 
      <td height="25" align="right">�������ԣ�</td>
      <td height="25"> <input name="Hot" type="checkbox" id="Hot" value="True">
        ��������&nbsp;&nbsp;&nbsp;&nbsp; <input name="Elite" type="checkbox" id="Elite" value="True">
        �Ƽ����� &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="#FF0000">�������ѡ������ʾ��������</font></td>
    </tr>
    <tr class="tdbg"> 
      <td height="25" align="right">���ڷ�Χ��</td>
      <td height="25">ֻ��ʾ��� 
        <input name="DateNum" type="text" id="DateNum" value="10" size="5" maxlength="3">
        ���ڵ�����&nbsp;&nbsp;&nbsp;&nbsp;<font color="#FF0000">���Ϊ�գ�����ʾ��������������</font></td>
    </tr>
    <tr class="tdbg"> 
      <td height="25" align="right">�����ֶΣ�</td>
      <td height="25"><select name="OrderField" id="OrderField">
          <option value="ArticleID" selected>����ID</option>
          <option value="UpdateTime">����ʱ��</option>
          <option value="Hits">�������</option>
        </select> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;���򷽷��� 
        <select name="OrderType" id="OrderType">
          <option value="asc">����</option>
          <option value="desc" selected>����</option>
        </select></td>
    </tr>
    <tr class="tdbg"> 
      <td height="40" colspan="2" align="center"><input name="SystemPath" type="hidden" id="SystemPath" value="<%= "http://"&request.servervariables("server_name")&replace(lcase(request.servervariables("url")),"admin_makejs.asp","") %>"> 
        <input name="MakeJS" type="button" id="MakeJS" onclick="makejs();" value="����JS����"> 
        &nbsp;&nbsp; <input name="Copy" type="button" id="Copy" value="���Ƶ������� " onclick="copy();"> 
        &nbsp;&nbsp; <input type="reset" name="Reset" value="�ָ�Ĭ��ֵ"></td>
    </tr>
    <tr class="tdbg"> 
      <td height="40" colspan="2" align="center"><textarea name="JsCode" cols="80" rows="10" id="JsCode"></textarea></td>
    </tr>
    <tr class="tdbg"> 
      <td height="60" colspan="2">ʹ�÷�����<br> &nbsp;&nbsp;&nbsp;&nbsp;�����趨��ѡ�Ȼ��㡰����JS���롱��������ɵ�JS���븴�Ƶ���ҳ�������Ӧλ�ô����ɡ��ɲο�js.htm�ļ��з�����<font color="#0000FF">�й����塢�ֺš���ɫ���о�����Ե����ã��������ڵ��ô����ҳ����CSS�������á�</font></td>
    </tr>
  </table>
</form>
<script language="JavaScript" type="text/JavaScript">
function makejs()
{
if(document.myform.ClassID.value=="")
{
	alert("������Ŀ����ָ���ⲿ��Ŀ��");
	document.myform.ClassID.focus();
	return false;
}
var strJS;
strJS="<!--���뿪ʼ-->\n<";
strJS+="script language='JavaScript' type='text/JavaScript' src='";
strJS+=document.myform.SystemPath.value+"article_js.asp"
strJS+="?ClassID="+document.myform.ClassID.value;
strJS+="&IncludeChild="+document.myform.IncludeChild.checked;
strJS+="&SpecialID="+document.myform.SpecialID.value;
strJS+="&ArticleNum="+document.myform.ArticleNum.value;
strJS+="&ShowType="+document.myform.ShowType.value;
strJS+="&ShowCols="+document.myform.ShowCols.value;
strJS+="&ShowProperty="+document.myform.ShowProperty.checked;
strJS+="&ShowClassName="+document.myform.ShowClassName.checked;
strJS+="&ShowIncludePic="+document.myform.ShowIncludePic.checked;
strJS+="&ShowTitle="+document.myform.ShowTitle.checked;
strJS+="&ShowUpdateTime="+document.myform.ShowUpdateTime.checked;
strJS+="&ShowHits="+document.myform.ShowHits.checked;
strJS+="&ShowAuthor="+document.myform.ShowAuthor.checked;
strJS+="&ShowHot="+document.myform.ShowHot.checked;
strJS+="&ShowMore="+document.myform.ShowMore.checked;
strJS+="&TitleMaxLen="+document.myform.TitleMaxLen.value;
strJS+="&ContentMaxLen="+document.myform.ContentMaxLen.value;
strJS+="&Hot="+document.myform.Hot.checked;
strJS+="&Elite="+document.myform.Elite.checked;
strJS+="&DateNum="+document.myform.DateNum.value;
strJS+="&OrderField="+document.myform.OrderField.value;
strJS+="&OrderType="+document.myform.OrderType.value;
strJS+="'></";
strJS+="script";
strJS+=">\n<!--�������-->";
document.myform.JsCode.value=strJS;
}
</script>
<%
end sub

sub JS_Pic()
%>
<form action="" method="post" name="myform" id="myform">
  <table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" class="border">
    <tr class="title"> 
      <td height="22" colspan="2" align="center"><strong>��ҳͼ�ĵ�JS����</strong></td>
    </tr>
    <tr class="tdbg"> 
      <td height="25" align="right">������Ŀ��</td>
      <td height="25"><select name="ClassID" id="ClassID"><option value="0">��ָ����Ŀ</option>
          <%call Admin_ShowClass_Option(2,0)%>
        </select>
        <font color="#0000FF">&nbsp;&nbsp;����ָ��Ϊ�ⲿ��Ŀ</font>&nbsp;&nbsp;&nbsp;&nbsp;
        <input name="IncludeChild" type="checkbox" id="IncludeChild" value="True" checked>
        ��������Ŀ</td>
    </tr>
    <tr class="tdbg">
      <td height="25" align="right">����ר�⣺</td>
      <td height="25">
        <%call Admin_ShowSpecial_Option(1,SpecialID)%>
      </td>
    </tr>
    <tr class="tdbg"> 
      <td height="25" align="right">������Ŀ��</td>
      <td height="25"><input name="ArticleNum" type="text" value="10" size="5" maxlength="3"> 
        &nbsp;&nbsp;&nbsp;&nbsp;<font color="#FF0000">���Ϊ�գ�����ʾ��������</font></td>
    </tr>
    <tr class="tdbg"> 
      <td height="25" align="right">��ʾ���ͣ�</td>
      <td height="25"><select name="ShowType" id="select">
          <option value="3" selected>ͼƬ+����</option>
          <option value="4">ͼƬ+����+����</option>
        </select>
      </td>
    </tr>
    <tr class="tdbg"> 
      <td height="50" align="right">��ʾ���ݣ�</td>
      <td height="50"> 
        <input name="ShowClassName" type="checkbox" id="ShowClassName" value="True">
        ������Ŀ&nbsp;&nbsp;&nbsp;&nbsp; 
        <input name="ShowTitle" type="checkbox" id="ShowTitle" value="True" checked disabled>
        ���±���
        <input type="checkbox" name="checkbox2" value="checkbox">
        ��������&nbsp;&nbsp;&nbsp;&nbsp; 
        <input name="ShowUpdateTime" type="checkbox" id="ShowUpdateTime" value="True">
        ����ʱ��<br>
        <input name="ShowHits" type="checkbox" id="ShowHits" value="True">
        �������&nbsp;&nbsp;&nbsp;&nbsp; <input name="ShowAuthor" type="checkbox" id="ShowAuthor" value="True">
        ����&nbsp;&nbsp;&nbsp;&nbsp; <input name="ShowHot" type="checkbox" id="ShowHot" value="True" checked>
        �ȵ����±�־
        <input name="ShowMore" type="checkbox" id="ShowMore" value="True">
        �����࡭��������</td>
    </tr>
    <tr class="tdbg"> 
      <td height="25" align="right">��������ַ�����</td>
      <td height="25"><input name="TitleMaxLen" type="text" id="TitleMaxLen" value="30" size="5" maxlength="3"> 
        &nbsp;&nbsp;&nbsp;&nbsp;<font color="#FF0000">���Ϊ�գ�����ʾ�������⡣��ĸ��һ���ַ������������ַ���</font></td>
    </tr>
    <tr class="tdbg">
      <td height="25" align="right">���������ַ�����</td>
      <td height="25"><input name="ContentMaxLen" type="text" id="ContentMaxLen" value="200" size="5" maxlength="3">
        &nbsp;&nbsp;&nbsp;&nbsp;<font color="#FF0000">ֻ�е���ʾ������Ϊ��ͼƬ+����+���ݡ�ʱ����Ч</font></td>
    </tr>
    <tr class="tdbg"> 
      <td height="25" align="right">�������ԣ�</td>
      <td height="25"> <input name="Hot" type="checkbox" id="Hot" value="True">
        ��������&nbsp;&nbsp;&nbsp;&nbsp; <input name="Elite" type="checkbox" id="Elite" value="True">
        �Ƽ����� &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="#FF0000">�������ѡ������ʾ��������</font></td>
    </tr>
    <tr class="tdbg"> 
      <td height="25" align="right">���ڷ�Χ��</td>
      <td height="25">ֻ��ʾ��� 
        <input name="DateNum" type="text" id="DateNum" value="10" size="5" maxlength="3">
        ���ڵ�����&nbsp;&nbsp;&nbsp;&nbsp;<font color="#FF0000">���Ϊ�գ�����ʾ��������������</font></td>
    </tr>
    <tr class="tdbg"> 
      <td height="25" align="right">�����ֶΣ�</td>
      <td height="25"><select name="OrderField" id="OrderField">
          <option value="ArticleID" selected>����ID</option>
          <option value="UpdateTime">����ʱ��</option>
          <option value="Hits">�������</option>
        </select> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;���򷽷��� 
        <select name="OrderType" id="OrderType">
          <option value="asc">����</option>
          <option value="desc" selected>����</option>
        </select></td>
    </tr>
    <tr class="tdbg"> 
      <td height="25" align="right">��ҳͼƬ���ã�</td>
      <td height="25">&nbsp;��ȣ� 
        <input name="ImgWidth" type="text" id="ImgWidth" value="180" size="5" maxlength="3">
        ����&nbsp;&nbsp;&nbsp;&nbsp;�߶ȣ� <input name="ImgHeight" type="text" id="ImgHeight" value="120" size="5" maxlength="3">
        ����</td>
    </tr>
    <tr class="tdbg"> 
      <td height="40" colspan="2" align="center"><input name="SystemPath" type="hidden" id="SystemPath" value="<%= "http://"&request.servervariables("server_name")&replace(lcase(request.servervariables("url")),"admin_makejs.asp","") %>"> 
        <input name="MakeJS" type="button" id="MakeJS" onclick="makejs();" value="����JS����"> 
        &nbsp;&nbsp; <input name="Copy" type="button" id="Copy" value="���Ƶ������� " onclick="copy();"> 
        &nbsp;&nbsp; <input type="reset" name="Reset" value="�ָ�Ĭ��ֵ"></td>
    </tr>
    <tr class="tdbg"> 
      <td height="40" colspan="2" align="center"><textarea name="JsCode" cols="80" rows="10" id="JsCode"></textarea></td>
    </tr>
    <tr class="tdbg"> 
      <td height="60" colspan="2">ʹ�÷�����<br>
        &nbsp;&nbsp;&nbsp;&nbsp;�����趨��ѡ�Ȼ��㡰����JS���롱��������ɵ�JS���븴�Ƶ���ҳ�������Ӧλ�ô����ɡ��ɲο�js.htm�ļ��з�����<font color="#0000FF">�й����塢�ֺš���ɫ���о�����Ե����ã��������ڵ��ô����ҳ����CSS�������á�</font></td>
    </tr>
  </table>
</form>
<script language="JavaScript" type="text/JavaScript">
function makejs()
{
if(document.myform.ClassID.value=="")
{
	alert("������Ŀ����ָ���ⲿ��Ŀ��");
	document.myform.ClassID.focus();
	return false;
}
var strJS;
strJS="<!--���뿪ʼ-->\n<";
strJS+="script language='JavaScript' type='text/JavaScript' src='";
strJS+=document.myform.SystemPath.value+"article_js.asp"
strJS+="?ClassID="+document.myform.ClassID.value;
strJS+="&IncludeChild="+document.myform.IncludeChild.checked;
strJS+="&SpecialID="+document.myform.SpecialID.value;
strJS+="&ArticleNum="+document.myform.ArticleNum.value;
strJS+="&ShowType="+document.myform.ShowType.value;
strJS+="&ShowClassName="+document.myform.ShowClassName.checked;
strJS+="&ShowTitle="+document.myform.ShowTitle.checked;
strJS+="&ShowUpdateTime="+document.myform.ShowUpdateTime.checked;
strJS+="&ShowHits="+document.myform.ShowHits.checked;
strJS+="&ShowAuthor="+document.myform.ShowAuthor.checked;
strJS+="&ShowHot="+document.myform.ShowHot.checked;
strJS+="&ShowMore="+document.myform.ShowMore.checked;
strJS+="&TitleMaxLen="+document.myform.TitleMaxLen.value;
strJS+="&ContentMaxLen="+document.myform.ContentMaxLen.value;
strJS+="&Hot="+document.myform.Hot.checked;
strJS+="&Elite="+document.myform.Elite.checked;
strJS+="&DateNum="+document.myform.DateNum.value;
strJS+="&OrderField="+document.myform.OrderField.value;
strJS+="&OrderType="+document.myform.OrderType.value;
strJS+="&ImgWidth="+document.myform.ImgWidth.value;
strJS+="&ImgHeight="+document.myform.ImgHeight.value;
strJS+="'></";
strJS+="script";
strJS+=">\n<!--�������-->";
document.myform.JsCode.value=strJS;
}
</script>
<%
end sub
%>
</body>
</html>
