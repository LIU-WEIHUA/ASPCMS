<%@language=vbscript codepage=936 %>
<%
option explicit
response.buffer=true	
Const PurviewLevel=2
Const CheckChannelID=0
Const PurviewLevel_Others="AD"
%>
<!--#include file="inc/conn.asp"-->
<!--#include file="inc/config.asp"-->
<!--#include file="Admin_ChkPurview.asp"-->
<!--#include file="inc/ubbcode.asp"-->
<!--#include file="inc/function.asp"-->
<%
dim sql,rs,strFileName
dim Action,Channel,FoundErr,ErrMsg
Action=Trim(Request("Action"))
Channel=Trim(Request("Channel"))
if Channel="" then
	Channel=0
else
	Channel=CLng(Channel)
end if
strFileName="Admin_Advertisement.asp?Channel="&Channel
%>
<html>
<head>
<title>������</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" type="text/css" href="Admin_Style.css">
<SCRIPT language=javascript>
function unselectall(thisform)
{
    if(thisform.chkAll.checked)
	{
		thisform.chkAll.checked = thisform.chkAll.checked&0;
    } 	
}

function CheckAll(thisform)
{
	for (var i=0;i<thisform.elements.length;i++)
    {
	var e = thisform.elements[i];
	if (e.Name != "chkAll"&&e.disabled!=true)
		e.checked = thisform.chkAll.checked;
    }
}
function ConfirmDel(thisform)
{
	if(thisform.Action.value=="Del")
	{
		if(confirm("ȷ��Ҫɾ��ѡ�еĹ����"))
		    return true;
		else
			return false;
	}
}
function showsetting(thisform)
{
	for (var j=0;j<6;j++)
	{
		var tab = eval("document.all.settable"+j);
		if(thisform.ADType.selectedIndex==j)
			tab.style.display = "";
		else
			tab.style.display = "none";
	}
	if(thisform.ADType.selectedIndex==6)
	{
		nocodead.style.display = "none";
		iscodead.style.display = "";
	}
	else
	{
		nocodead.style.display = "";
		iscodead.style.display = "none";
	}
}
function check(thisform)
{
	if(thisform.ADType.selectedIndex==6)
	{
		if(thisform.ADCode.value=="")
		{
			alert("�����벻��Ϊ�գ�")
			thisform.ADCode.focus()
			return false;
		}
		if(thisform.ADCode.value.length>250)
		{
			alert("�����볤�Ȳ��ܳ���250�ַ���")
			thisform.ADCode.focus()
			return false;
		}
	}
	else
	{
		if(thisform.SiteName.value=="")
		{
		  alert("��վ���Ʋ���Ϊ�գ�");
		  thisform.SiteName.focus();
		  return false;
		}
		if(thisform.ImgUrl.value=="")
		{
		  alert("ͼƬ��ַ����Ϊ�գ�");
		  thisform.ImgUrl.focus();
		  return false;
		}
		if(thisform.ADType.selectedIndex==0)
		{
			if(thisform.ImgWidth.value=="")
			{
			  alert("��������ͼƬ��Ȳ������գ�");
			  thisform.ImgWidth.focus();
			  return false;
			}
			if(thisform.ImgHeight.value=="")
			{
			  alert("��������ͼƬ�߶Ȳ������գ�");
			  thisform.ImgHeight.focus();
			  return false;
			}
		}
	}
}
</script>
</head>
<body leftmargin="2" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" Class="border">
  <tr class="topbg"> 
    <td height="22" colspan=2 align=center><strong>�� �� �� ��</strong></td>
  </tr>
  <tr class="tdbg"> 
    <td width="70" height="30"><strong>��������</strong></td>
    <td height="30"><a href="Admin_Advertisement.asp?Action=Add">����¹��</a> | <a href="Admin_Advertisement.asp">����Ƶ�����</a> 
      | <a href="Admin_Advertisement.asp?Channel=1">��վ��ҳ���</a> | <a href="Admin_Advertisement.asp?Channel=2">����Ƶ�����</a> 
      \<a href="Admin_Advertisement.asp?Channel=4"></a> | <a href="Admin_Advertisement.asp?Channel=5">����Ƶ�����</a> 
      | </td>
  </tr>
</table>
<%
if Action="Add" then
	call Add()
elseif Action="SaveAdd" then
	call SaveAdd()
elseif Action="Modify" then
	call Modify()
elseif Action="SaveModify" then
	call SaveModify()
elseif Action="SetNew" then
	call SetNew()
elseif Action="CancelNew" then
	call CancelNew()
elseif Action="Move" then
	call MoveAdvertisement()
elseif Action="Del" then
	call DelAD()
else
	call main()
end if
if FoundErr=True then
	call WriteErrMsg()
end if
call CloseConn()


sub main()
	sql="select * from Advertisement"
	sql=sql & " where ChannelID=" & Channel
	sql=sql & " order by IsSelected,id desc"
	set rs=server.createobject("adodb.recordset")
	rs.open sql,conn,1,1
%>
<form name="form1" method="POST" action=<%=strFileName%> >
<%
response.write "�����ڵ�λ�ã���վ������&nbsp;&gt;&gt;&nbsp;<font color=red>"
select case Channel
	case 0
		response.write "����Ƶ�����"
	case 1
		response.write "��վ��ҳ���"
	case 2
		response.write "����Ƶ�����"
	case 3
		response.write "���Ƶ�����"
	case 4
		response.write "ͼƬƵ�����"
	case 5
		response.write "����Ƶ�����"
	case else
		response.write "����Ĳ���"
end select
response.write "</font><br>"
%>
  <table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" Class="border">
    <tr class="title"> 
      <td width="30" height="22" align="center"><strong>ѡ��</strong></td>
      <td width="30" height="22" align="center"><strong>ID</strong></td>
      <td width="20" align="center"><strong>��</strong></td>
      <td width="80" align="center"><strong>�������</strong></td>
      <td width="100" height="22" align="center"><strong>��վ����</strong></td>
      <td height="22" align="center"><strong>���ͼƬ</strong></td>
      <td width="80" height="22" align="center"><strong>����</strong></td>
    </tr>
    <%
if not(rs.bof and rs.eof) then
	do while not rs.eof
%>
    <tr class="tdbg" onmouseout="this.style.backgroundColor=''" onmouseover="this.style.backgroundColor='#BFDFFF'"> 
      <td width="30" align="center"> 
        <input type="checkbox" value=<%=rs("ID")%> name="ID" onclick="unselectall(this.form)">
      </td>
      <td width="30" align="center"><%=rs("ID")%></td>
      <td width="20" align="center">
		  <%if rs("IsSelected")=true then response.write "<font color=#009900>��</font>" end if%>
	  </td>
      <td width="80" align="center"> 
        <%
		if rs("ADType")=0 then
			response.write "�������" 
		elseif rs("ADType")=1 then
			response.write "Banner���" 
		elseif rs("ADType")=2 then
			response.write "��Ŀ���" 
		elseif rs("ADType")=3 then
			response.write "��������ҳ���" 
		elseif rs("ADType")=4 then
			response.write "�������" 
		elseif rs("ADType")=5 then
			response.write "ҳ��̶����" 
		elseif rs("ADType")=6 then
			response.write "������" 
		else
			response.write "�������" 
		end if
		%>
      </td>
      <td width="100"><a href="<%=rs("SiteUrl")%>" target='blank' title="��վ��ַ��<%=rs("SiteUrl") & vbcrlf %>��վ��飺<%=vbcrlf & rs("SiteIntro")%>"><%=rs("SiteName")%></a></td>
      <td align="center"> 
        <%
		if rs("ADType")=6 then
			Response.Write rs("ImgUrl")
		else
			if lcase(right(rs("ImgUrl"),4))=".swf" then
				Response.Write "<object classid='clsid:D27CDB6E-AE6D-11cf-96B8-444553540000' codebase='http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=5,0,0,0'"
				if rs("ImgWidth")>0 then 
					response.write " width='" & rs("ImgWidth") & "'"
					if rs("ImgHeight")>0 then response.write " height='" & rs("ImgHeight") & "'"
				end if
				response.write "><param name='movie' value='" & rs("ImgUrl") & "'><param name='quality' value='high'><embed src='" & rs("ImgUrl") & "' pluginspage='http://www.macromedia.com/shockwave/download/index.cgi?P1_Prod_Version=ShockwaveFlash' type='application/x-shockwave-flash'"
				if rs("ImgWidth")>0 then 
					response.write " width='" & rs("ImgWidth") & "'"
					if rs("ImgHeight")>0 then response.write " height='" & rs("ImgHeight") & "'"
				end if
				response.write "></embed></object>"
			else
				response.write "<a href='" & rs("SiteUrl") & "' target='_blank' title='ͼƬ��ַ��" & rs("ImgUrl") & vbcrlf & "ͼƬ��ȣ�" & rs("ImgWidth") & "����" & vbcrlf & "ͼƬ�߶ȣ�" & rs("ImgHeight") & "����'><img src='" & rs("ImgUrl") & "'"
				if rs("ImgWidth")>0 then 
					response.write " width='" & rs("ImgWidth") & "'"
					if rs("ImgHeight")>0 then response.write " height='" & rs("ImgHeight") & "'"
				end if
				response.write " border='0'></a>"
			end if
		end if
		%>
      </td>
      <td width="80" align="center"> 
        <%
	  response.write "<a href='" & strFileName & "&Action=Modify&ID=" & rs("ID") & "'>�޸�</a>&nbsp;&nbsp;"
		response.write "<a href='" & strFileName & "&Action=Del&ID=" & rs("ID") & "' onclick=""return confirm('ȷ��Ҫɾ���˹����');"">ɾ��</a>"
	  %>
      </td>
    </tr>
    <%
rs.movenext
loop
%>
    <tr class="tdbg"> 
      <td colspan=7 height="30"> 
        <input name="chkAll" type="checkbox" id="chkAll" onclick=CheckAll(this.form) value="checkbox">
        ѡ�����й�� 
        <input name="Action" type="hidden" id="Action" value="Del">
		&nbsp;&nbsp;&nbsp;&nbsp;��ѡ���Ĺ�棺 
        <input type="submit" value=" ɾ�� " name="submit" onClick="this.form.Action.value='Del';return ConfirmDel(this.form);"">
        &nbsp;&nbsp;
        <input type="submit" value="��Ϊ���¹��" name="submit" onClick="this.form.Action.value='SetNew'">
        &nbsp;&nbsp;
        <input type="submit" value="ȡ�����¹��" name="submit" onClick="this.form.Action.value='CancelNew'">
        &nbsp;&nbsp;
        <input type="submit" value="�ƶ���" name="submit" onClick="this.form.Action.value='Move'">
		<select name='ChannelID'>
			<option value='0'>ȫ��</option>
			<option value='1'>��ҳ</option>
			<option value='2'>����</option>
			<option value='3'>���</option>
			<option value='4'>ͼƬ</option>
			<option value='5'>����</option>
		</select>
      </td>
    </tr>
    <% end if%>
  </table>
</form>
<%
	rs.close
	set rs=nothing
end sub

sub Add()
%>
<form name="myform" method="post" action="<%=strFileName%>" onSubmit="return check(myform)">
  <table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" class="border">
    <tr class="title"> 
      <td height="22" colspan="2" align="center"><strong>�� �� �� ��</strong></td>
    </tr>
    <tr class="tdbg"> 
      <td width="250"><strong>����Ƶ����</strong></td>
      <td width="550"> 
        <input type='radio' name='ChannelID' value='0' checked>
        ȫ��&nbsp; 
        <input type='radio' name='ChannelID' value='1'>
        ��ҳ&nbsp; 
        <input type='radio' name='ChannelID' value='2'>
        ����&nbsp; 
        <input type='radio' name='ChannelID' value='3'>
        ���&nbsp; 
        <input type='radio' name='ChannelID' value='4'>
        ͼƬ&nbsp; 
        <input type='radio' name='ChannelID' value='5'>
        ����&nbsp; </td>
    </tr>
    <tr class="tdbg"> 
      <td width="250"><strong>������ͣ�</strong></td>
      <td width="550"> 
        <select name="ADType" id="ADType" onchange=showsetting(this.form)>
          <option value="0" selected >�������</option>
          <option value="1" >Banner���</option>
          <option value="2" >��Ŀ���</option>
          <option value="3" >��������ҳ���</option>
          <option value="4" >�������</option>
          <option value="5" >ҳ��̶����</option>
          <option value="6" >������</option>
        </select>
		&nbsp;&nbsp;&nbsp;&nbsp;<input name="IsSelected" type="checkbox" id="IsSelected" value="True" checked>
        ��Ϊ���¹�� 
      </td>
    </tr>
  </table>
  <table id="nocodead" width="100%" border="0" align="center" cellpadding="2" cellspacing="1" class="border">
    <tr class="tdbg"> 
      <td width="250"><strong>������ã�</strong></td>
      <td height="26" width="550"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" id="settable0">
          <tr> 
            <td>�� 
              <input name="popleft" type="text" id="popleft" value="100" size="6" maxlength="5">
              �ϣ� 
              <input name="poptop" type="text" id="poptop" value="100" size="6" maxlength="5"> 
            </td>
          </tr>
        </table>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" id="settable1" style="DISPLAY: none">
          <tr> 
            <td> </td>
          </tr>
        </table>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" id="settable2" style="DISPLAY: none">
          <tr> 
            <td> </td>
          </tr>
        </table>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" id="settable3" style="DISPLAY: none">
          <tr> 
            <td> </td>
          </tr>
        </table>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" id="settable4" style="DISPLAY: none">
          <tr> 
            <td>�� 
              <input name="floatleft" type="text" id="floatleft" value="100" size="6" maxlength="5">
              �ϣ� 
              <input name="floattop" type="text" id="floattop" value="100" size="6" maxlength="5"> 
            </td>
          </tr>
        </table>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" id="settable5" style="DISPLAY: none">
          <tr> 
            <td>�� 
              <input name="fixedleft" type="text" id="fixedleft" value="100" size="6" maxlength="5">
              �ϣ� 
              <input name="fixedtop" type="text" id="fixedtop" value="100" size="6" maxlength="5"> 
            </td>
          </tr>
        </table></td>
    </tr>
    <tr class="tdbg"> 
      <td width="250"><strong>��վ���ƣ�</strong></td>
      <td width="550"> 
        <input name="SiteName" type="text" id="SiteName" value="" size="58" maxlength="255"> 
      </td>
    </tr>
    <tr class="tdbg"> 
      <td width="250"><strong>��վ��ַ��</strong></td>
      <td width="550"> 
        <input name="SiteUrl" type="text" id="SiteUrl" value="http://" size="58" maxlength="255"> 
      </td>
    </tr>
    <tr class="tdbg"> 
      <td width="250"><strong>��վ��飺</strong></td>
      <td width="550"> 
        <input name="SiteIntro" type="text" id="SiteIntro" size="58" maxlength="255"> 
      </td>
    </tr>
    <tr class="tdbg"> 
      <td width="250"><strong>ͼƬ��ַ��</strong><br>
        ͼƬ��ʽΪ��jpg,gif,bmp,png,swf</td>
      <td width="550"> 
        <input name="ImgUrl" type="text" id="ImgUrl" size="58" maxlength="255"> 
      </td>
    </tr>
    <tr class="tdbg"> 
      <td width="250"><strong>ͼƬ�ϴ���</strong></td>
      <td width="550"> <iframe style="top:2px" ID="UploadFiles" src="Upload_AdPic.asp" frameborder=0 scrolling=no width="450" height="25"></iframe> 
      </td>
    </tr>
    <tr class="tdbg"> 
      <td width="250"><strong>ͼƬ��С��</strong>��������ȡԭʼ��С��</td>
      <td width="550">�� 
        <input name="ImgWidth" type="text" id="ImgWidth"  size="6" maxlength="5">
        ����&nbsp;&nbsp;&nbsp;&nbsp;�ߣ� 
        <input name="ImgHeight" type="text" id="ImgHeight"  size="6" maxlength="5">
        ����&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="#FF0000">��&nbsp;</font><font color="#0000FF">�������ͼƬ��С��������</font></td>
    </tr>
    <tr class="tdbg"> 
      <td width="250"><strong>�Ƿ�FLASH��</strong></td>
      <td width="550"> 
        <input type="radio" name="IsFlash" value="True">
        ��&nbsp;&nbsp;&nbsp;&nbsp; <input name="IsFlash" type="radio" value="False" checked>
        ��</td>
    </tr>
  </table>
  <table id="iscodead" width="100%" border="0" align="center" cellpadding="2" cellspacing="1" class="border"  style="DISPLAY: none">
    <tr class="tdbg"> 
      <td width="250"><strong>�����룺</strong></td>
      <td width="550"> <br>
        <textarea name="ADCode" id="ADCode" cols="50" rows="10"></textarea>
        <br>
        <br>
      </td>
    </tr>
  </table>
  <table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" >
    <tr> 
      <td height="40" colspan="2" align="center"> 
        <input name="Action" type="hidden" id="Action" value="SaveAdd">
        <input type="submit" name="Submit" value=" �� �� ">
      </td>
    </tr>
  </table>
</form>
<%
end sub

sub Modify()
	dim ID,arrSetting,popleft,poptop,floatleft,floattop,fixedleft,fixedtop
	ID=trim(request("ID"))
	if ID="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>��ָ�����ID</li>"
		exit sub
	else
		ID=Clng(ID)
	end if
	sql="select * from Advertisement where ID=" & ID
	set rs=server.createobject("adodb.recordset")
	rs.open sql,conn,1,1
	if rs.bof and rs.eof then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>�Ҳ���ָ���Ĺ�棡</li>"
		rs.close
		set rs=nothing
		exit sub
	end if

	popleft="100"
	poptop="100"
	floatleft="100"
	floattop="100"
	fixedleft="100"
	fixedtop="100"
	if rs("ADType")=0 then
		if instr(rs("ADSetting"),"|")>0 then
			arrSetting=split(rs("ADSetting"),"|")
			popleft=arrsetting(0)
			poptop=arrsetting(1)
		end if
	elseif rs("ADType")=4 then
		if instr(rs("ADSetting"),"|")>0 then
			arrSetting=split(rs("ADSetting"),"|")
			floatleft=arrsetting(0)
			floattop=arrsetting(1)
		end if
	elseif rs("ADType")=5 then
		if instr(rs("ADSetting"),"|")>0 then
			arrSetting=split(rs("ADSetting"),"|")
			fixedleft=arrsetting(0)
			fixedtop=arrsetting(1)
		end if
	end if


%>
<form name="myform" method="post" action="<%=strFileName%>" onSubmit="return check(myform)">
  <table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" class="border">
    <tr class="title"> 
      <td height="22" colspan="2" align="center"><strong>�� �� �� ��</strong></td>
    </tr>
    <tr class="tdbg"> 
      <td width="250"><strong>����Ƶ����</strong></td>
      <td width="550"> 
        <input type='radio' name='ChannelID' value='0' <%if rs("ChannelID")=0 then response.write "checked"%>>
        ȫ��&nbsp; 
        <input type='radio' name='ChannelID' value='1' <%if rs("ChannelID")=1 then response.write "checked"%>>
        ��ҳ&nbsp; 
        <input type='radio' name='ChannelID' value='2' <%if rs("ChannelID")=2 then response.write "checked"%>>
        ����&nbsp; 
        <input type='radio' name='ChannelID' value='3' <%if rs("ChannelID")=3 then response.write "checked"%>>
        ���&nbsp; 
        <input type='radio' name='ChannelID' value='4' <%if rs("ChannelID")=4 then response.write "checked"%>>
        ͼƬ&nbsp; 
        <input type='radio' name='ChannelID' value='5' <%if rs("ChannelID")=5 then response.write "checked"%>>
        ����&nbsp; </td>
    </tr>
    <tr class="tdbg"> 
      <td width="250"><strong>������ͣ�</strong></td>
      <td width="550"> 
        <select name="ADType" id="ADType" onchange=showsetting(this.form)>
          <option value="0" <%if rs("ADType")=0 then response.write "selected"%>>�������</option>
          <option value="1" <%if rs("ADType")=1 then response.write "selected"%>>Banner���</option>
          <option value="2" <%if rs("ADType")=2 then response.write "selected"%>>��Ŀ���</option>
          <option value="3" <%if rs("ADType")=3 then response.write "selected"%>>��������ҳ���</option>
          <option value="4" <%if rs("ADType")=4 then response.write "selected"%>>�������</option>
          <option value="5" <%if rs("ADType")=5 then response.write "selected"%>>ҳ��̶����</option>
          <option value="6" <%if rs("ADType")=6 then response.write "selected"%>>������</option>
        </select>
		&nbsp;&nbsp;&nbsp;&nbsp;<input name="IsSelected" type="checkbox" id="IsSelected" value="True" <% if rs("IsSelected")=true then response.write "checked"%>>
        ��Ϊ���¹��
      </td>
    </tr>
  </table>
  <table id="nocodead" width="100%" border="0" align="center" cellpadding="2" cellspacing="1" class="border">
    <tr class="tdbg"> 
      <td width="250"><strong>������ã�</strong></td>
      <td width="550" height="26"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" id="settable0">
          <tr> 
            <td>�� 
              <input name="popleft" type="text" id="popleft" value='<%=popleft%>' size="6" maxlength="5">
              �ϣ� 
              <input name="poptop" type="text" id="poptop" value='<%=poptop%>' size="6" maxlength="5">
            </td>
          </tr>
        </table>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" id="settable1" style="DISPLAY: none">
          <tr> 
            <td> </td>
          </tr>
        </table>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" id="settable2" style="DISPLAY: none">
          <tr> 
            <td> </td>
          </tr>
        </table>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" id="settable3" style="DISPLAY: none">
          <tr> 
            <td> </td>
          </tr>
        </table>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" id="settable4" style="DISPLAY: none">
          <tr> 
            <td>�� 
              <input name="floatleft" type="text" id="floatleft" value='<%=floatleft%>' size="6" maxlength="5">
              �ϣ� 
              <input name="floattop" type="text" id="floattop" value='<%=floattop%>' size="6" maxlength="5">
            </td>
          </tr>
        </table>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" id="settable5" style="DISPLAY: none">
          <tr> 
            <td>�� 
              <input name="fixedleft" type="text" id="fixedleft" value='<%=fixedleft%>' size="6" maxlength="5">
              �ϣ� 
              <input name="fixedtop" type="text" id="fixedtop" value='<%=fixedtop%>' size="6" maxlength="5">
            </td>
          </tr>
        </table>
      </td>
    </tr>
    <tr class="tdbg"> 
      <td width="250"><strong>��վ���ƣ�</strong></td>
      <td width="550"> 
        <input name="SiteName" type="text" id="SiteName" value="<%=rs("SiteName")%>" size="50" maxlength="255">
      </td>
    </tr>
    <tr class="tdbg"> 
      <td width="250"><strong>��վ��ַ��</strong></td>
      <td width="550"> 
        <input name="SiteUrl" type="text" id="SiteUrl" value="<%=rs("SiteUrl")%>" size="50" maxlength="255">
      </td>
    </tr>
    <tr class="tdbg"> 
      <td width="250"><strong>��վ��飺</strong></td>
      <td width="550"> 
        <input name="SiteIntro" type="text" id="SiteIntro" value="<%=rs("SiteIntro")%>" size="50" maxlength="255">
      </td>
    </tr>
    <tr class="tdbg"> 
      <td width="250"><strong>ͼƬ��ַ��</strong></td>
      <td width="550"> 
        <input name="ImgUrl" type="text" id="ImgUrl" value="<%if rs("ADType")<>6 then response.write rs("ImgUrl")%>" size="50" maxlength="255">
      </td>
    </tr>
    <tr class="tdbg">
      <td width="250"><strong>ͼƬ�ϴ���</strong></td>
      <td width="550">
	  <iframe style="top:2px" ID="UploadFiles" src="Upload_AdPic.asp" frameborder=0 scrolling=no width="450" height="25"></iframe>
	  </td>
    </tr>
    <tr class="tdbg"> 
      <td width="250"><strong>ͼƬ��С��</strong></td>
      <td width="550">�� 
        <input name="ImgWidth" type="text" id="ImgWidth" value="<%=rs("ImgWidth")%>" size="6" maxlength="5">
        ����&nbsp;&nbsp;&nbsp;&nbsp;�ߣ� 
        <input name="ImgHeight" type="text" id="ImgHeight" value="<%=rs("ImgHeight")%>" size="6" maxlength="5">
        ����&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="#FF0000">��&nbsp;</font><font color="#0000FF">�������ͼƬ��С��������</font></td>
    </tr>
    <tr class="tdbg"> 
      <td width="250"><strong>�Ƿ�FLASH��</strong></td>
      <td width="550"> 
        <input type="radio" name="IsFlash" value="True" <% if rs("IsFlash")=true then response.write "checked"%>>
        ��&nbsp;&nbsp;&nbsp;&nbsp; 
        <input name="IsFlash" type="radio" value="False" <% if rs("IsFlash")=false then response.write "checked"%>>
        ��</td>
    </tr>
  </table>
  <table id="iscodead" width="100%" border="0" align="center" cellpadding="2" cellspacing="1" class="border" style="DISPLAY: none">
    <tr class="tdbg"> 
      <td width="250"><strong>�����룺</strong></td>
      <td width="550"> <br>
        <textarea name="ADCode" id="ADCode" cols="50" rows="10"><%if rs("ADType")=6 then response.write  rs("ImgUrl")%></textarea>
        <br>
        <br>
      </td>
    </tr>
  </table>
  <table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" >
    <tr> 
      <td height="40" colspan="2" align="center"> 
        <input name="Action" type="hidden" id="Action" value="SaveModify">
        <input name="ID" type="hidden" id="ID" value="<%=rs("ID")%>">
        <input type="submit" name="Submit" value=" �� �� ">
      </td>
    </tr>
  </table>
<script language=JavaScript>
showsetting(myform)
</script>
</form>
<%
	rs.close
	set rs=nothing
end sub
%>
<table width="100%" border="0" cellspacing="1" cellpadding="2" class="border">
  <tr class="title"> 
    <td height="22" colspan="2"><strong>�������˵��</strong></td>
  </tr>
  <tr class="tdbg"> 
    <td>������棺</td>
    <td>ָ���õ���������ʽ�Ĺ��</td>
  </tr>
  <tr class="tdbg"> 
    <td>Banner��棺</td>
    <td>ָҳ�涥���м�Banner���Ĺ�棬���Сһ��Ϊ480*60</td>
  </tr>
  <tr class="tdbg"> 
    <td>��Ŀ��棺</td>
    <td>ָ�����ڸ���Ŀ��Ĺ�棬���Сһ��Ϊ480*60</td>
  </tr>
  <tr class="tdbg"> 
    <td>��������ҳ��棺</td>
    <td>ָ��ʾ�����������м�Ĺ�棬���Сһ��Ϊ300*300</td>
  </tr>
  <tr class="tdbg"> 
    <td>������棺</td>
    <td>ָƯ����ҳ���ϲ����ƶ��Ĺ�棬���Сһ��Ϊ80*80 </td>
  </tr>
  <tr class="tdbg"> 
    <td>ҳ��̶���棺</td>
    <td>ָ�̶���ʾ��ҳ��ĳһλ�õĹ��</td>
  </tr>
  <tr class="tdbg"> 
    <td>�����棺</td>
    <td>ָ����html���ݵ���վ�ƹ����</td>
  </tr>
</table>
</body>
</html>
<%
sub SaveAdd()
	dim ChannelID,ADType,SiteName,SiteUrl,SiteIntro,ImgUrl,ImgWidth,ImgHeight,IsFlash,IsSelected,ADSetting
	dim popleft,poptop,floatleft,floattop,fixedleft,fixedtop
	ChannelID=Clng(request("ChannelID"))
	ADType=Clng(request("ADType"))
	SiteUrl=trim(request("SiteUrl"))
	SiteName=trim(request("SiteName"))
	SiteIntro=trim(request("SiteIntro"))
	ImgWidth=trim(request("ImgWidth"))
	ImgHeight=Trim(request("ImgHeight"))
	IsFlash=trim(request("IsFlash"))
	IsSelected=trim(request("IsSelected"))
	if ADType<>6 then
		ImgUrl=trim(request("ImgUrl"))
		if SiteName="" then
			FoundErr=True
			ErrMsg=ErrMsg & "<br><li>��վ���Ʋ���Ϊ�գ�</li>"
		end if
		if ImgUrl="" then
			FoundErr=True
			ErrMsg=ErrMsg & "<br><li>���ͼƬ����Ϊ�գ�</li>"
		end if
	else
		ImgUrl=trim(request("ADCode"))
		if ImgUrl="" then
			FoundErr=True
			ErrMsg=ErrMsg & "<br><li>�����벻��Ϊ�գ�</li>"
		end if
	end if

	if FoundErr=True then
		exit sub
	end if
	
	if SiteUrl="http://" then SiteUrl="http://www.asp163.net"
	if ImgWidth="" then 
		ImgWidth=0
	else
		ImgWidth=Cint(ImgWidth)
	end if
	if ImgHeight="" then
		ImgHeight=0
	else
		ImgHeight=Cint(ImgHeight)
	end if
	if IsFlash="" then IsFlash=false
	if IsSelected="" then IsSelected=false

	
	if ADType=0 then
		if trim(request("popleft"))="" then popleft=0 else popleft=trim(request("popleft"))
		if trim(request("poptop"))="" then poptop=0 else poptop=trim(request("poptop"))
		ADSetting=popleft & "|" & poptop
	elseif ADType=4 then
		if trim(request("floatleft"))="" then floatleft=0 else floatleft=trim(request("floatleft"))
		if trim(request("floattop"))="" then floattop=0 else floattop=trim(request("floattop"))
		ADSetting=floatleft & "|" & floattop
	elseif ADType=5 then
		if trim(request("fixedleft"))="" then fixedleft=0 else fixedleft=trim(request("fixedleft"))
		if trim(request("fixedtop"))="" then fixedtop=0 else fixedtop=trim(request("fixedtop"))
		ADSetting=fixedleft & "|" & fixedtop
	end if

	sql="select * from Advertisement"
	set rs=server.createobject("adodb.recordset")
	rs.open sql,conn,1,3
	rs.addnew
	rs("ChannelID")=ChannelID
	rs("ADType")=ADType
	rs("ADSetting")=ADSetting
	rs("SiteName")=SiteName
	rs("SiteUrl")=SiteUrl
	rs("SiteIntro")=SiteIntro
	rs("ImgUrl")=ImgUrl
	rs("ImgWidth")=ImgWidth
	rs("ImgHeight")=ImgHeight
	rs("IsFlash")=IsFlash
	rs("IsSelected")=IsSelected
	rs.update
	rs.close
	set rs=nothing
	call CloseConn()
	response.redirect "Admin_Advertisement.asp?Channel="&ChannelID
end sub

sub SaveModify()
	dim sql,rs
	dim ID,ChannelID,ADType,SiteName,SiteUrl,SiteIntro,ImgUrl,ImgWidth,ImgHeight,IsFlash,IsSelected,ADSetting
	dim popleft,poptop,floatleft,floattop,fixedleft,fixedtop
	ID=trim(request("ID"))
	ChannelID=Clng(request("ChannelID"))
	ADType=Clng(request("ADType"))
	SiteName=trim(request("SiteName"))
	SiteUrl=trim(request("SiteUrl"))
	SiteIntro=trim(request("SiteIntro"))
	ImgWidth=trim(request("ImgWidth"))
	ImgHeight=Trim(request("ImgHeight"))
	IsFlash=trim(request("IsFlash"))
	IsSelected=trim(request("IsSelected"))
	if ID="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>��ָ�����ID</li>"
	else
		ID=Clng(ID)
	end if
	if ADType<>6 then
		ImgUrl=trim(request("ImgUrl"))
		if SiteName="" then
			FoundErr=True
			ErrMsg=ErrMsg & "<br><li>��վ���Ʋ���Ϊ�գ�</li>"
		end if
		if ImgUrl="" then
			FoundErr=True
			ErrMsg=ErrMsg & "<br><li>���ͼƬ����Ϊ�գ�</li>"
		end if
	else
		ImgUrl=trim(request("ADCode"))
		if ImgUrl="" then
			FoundErr=True
			ErrMsg=ErrMsg & "<br><li>�����벻��Ϊ�գ�</li>"
		end if
	end if
	if FoundErr=True then
		exit sub
	end if
	if SiteUrl="http://" then SiteUrl="http://www.asp163.net"
	if ImgWidth="" then 
		ImgWidth=0
	else
		ImgWidth=Cint(ImgWidth)
	end if
	if ImgHeight="" then
		ImgHeight=0
	else
		ImgHeight=Cint(ImgHeight)
	end if
	if IsFlash="" then IsFlash=false
	if IsSelected="" then IsSelected=false

	if ADType=0 then
		if trim(request("popleft"))="" then popleft=0 else popleft=trim(request("popleft"))
		if trim(request("poptop"))="" then poptop=0 else poptop=trim(request("poptop"))
		ADSetting=popleft & "|" & poptop
	elseif ADType=4 then
		if trim(request("floatleft"))="" then floatleft=0 else floatleft=trim(request("floatleft"))
		if trim(request("floattop"))="" then floattop=0 else floattop=trim(request("floattop"))
		ADSetting=floatleft & "|" & floattop
	elseif ADType=5 then
		if trim(request("fixedleft"))="" then fixedleft=0 else fixedleft=trim(request("fixedleft"))
		if trim(request("fixedtop"))="" then fixedtop=0 else fixedtop=trim(request("fixedtop"))
		ADSetting=fixedleft & "|" & fixedtop
	end if

	sql="select * from Advertisement where ID=" & ID
	set rs=server.createobject("adodb.recordset")
	rs.open sql,conn,1,3
	if rs.bof and rs.eof then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>�Ҳ���ָ���Ĺ�棡</li>"
		rs.close
		set rs=nothing
		exit sub
	end if
	rs("ChannelID")=ChannelID
	rs("ADType")=ADType
	rs("ADSetting")=ADSetting
	rs("SiteName")=SiteName
	rs("SiteUrl")=SiteUrl
	rs("SiteIntro")=SiteIntro
	rs("ImgUrl")=ImgUrl
	rs("ImgWidth")=ImgWidth
	rs("ImgHeight")=ImgHeight
	rs("IsFlash")=IsFlash
	rs("IsSelected")=IsSelected
	rs.update
	rs.close
	set rs=nothing
	call CloseConn()
	response.redirect strFileName
end sub

sub SetNew()
	dim ID
	ID=Trim(Request("ID"))
	if ID="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>��ָ�����ID</li>"
		exit sub
	end if
	if Instr(ID,",")>0 then
		dim arrID,i
		arrID=split(ID,",")
		for i=0 to Ubound(arrID)
			conn.execute "Update Advertisement set IsSelected=True Where ID=" & CLng(arrID(i))
		next
	else
		conn.execute "Update Advertisement set IsSelected=True Where ID=" & CLng(ID)
	end if
	response.redirect strFileName
end sub

sub CancelNew()
	dim ID
	ID=Trim(Request("ID"))
	if ID="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>��ָ�����ID</li>"
		exit sub
	end if
	if Instr(ID,",")>0 then
		dim arrID,i
		arrID=split(ID,",")
		for i=0 to Ubound(arrID)
			conn.execute "Update Advertisement set IsSelected=False Where ID=" & CLng(arrID(i))
		next
	else
		conn.execute "Update Advertisement set IsSelected=False Where ID=" & CLng(ID)
	end if
	response.redirect strFileName
end sub

sub MoveAdvertisement()
	dim ID,MoveChannelID
	ID=Trim(Request("ID"))
	if ID="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>��ָ�����ID</li>"
		exit sub
	end if
	MoveChannelID=Trim(Request("ChannelID"))
	if Instr(ID,",")>0 then
		dim arrID,i
		arrID=split(ID,",")
		for i=0 to Ubound(arrID)
			conn.execute "Update Advertisement set ChannelID = "& MoveChannelID & " where ID=" & CLng(arrID(i))
		next
	else
		conn.execute "Update Advertisement set ChannelID = "& MoveChannelID & " where ID=" & CLng(ID)
	end if
	response.redirect strFileName
end sub

sub DelAD()
	dim ID
	ID=Trim(Request("ID"))
	if ID="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>��ָ�����ID</li>"
		exit sub
	end if
	if Instr(ID,",")>0 then
		dim arrID,i
		arrID=split(ID,",")
		for i=0 to Ubound(arrID)
		conn.execute "delete from Advertisement where ID=" & CLng(arrID(i))
		next
	else
		conn.execute "delete from Advertisement where ID=" & CLng(ID)
	end if
	response.redirect strFileName
end sub
%>
