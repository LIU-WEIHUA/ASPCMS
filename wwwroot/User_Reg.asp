<!--#include file="Inc/syscode_article.asp"-->
<%
if EnableUserReg<>"Yes" then
	FoundErr=true
	ErrMsg=ErrMsg & "<br><li>�Բ��𣬱�վ��ͣ���û�ע�����</li>"
	call WriteErrMsg()
	response.end
end if
const ChannelID=0
Const ShowRunTime="Yes"

dim action
action=trim(request("action"))
SkinID=0
if action="apply" then
	PageTitle="���û�ע��"
else
	PageTitle="�������������"
end if
%>
<html>
<head>
<title><%=strPageTitle & " >> " & PageTitle%></title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<!--#include file="inc/Skin_CSS.asp"-->
<% call MenuJS() %>
</head>

<body leftmargin="2" topmargin="0" marginwidth="0" marginheight="0" bgcolor="#FFFFFF" style="BACKGROUND-COLOR: #ffffff" >
<table><tr><td>
<% call top_noIndex() %></td></tr>
<tr><td>
<table width="989" height="300" border="0" align="center" cellpadding="0" cellspacing="0" class="border2">
  <tr>
      
    <td width="180" height="300" valign="top" class="tdbg_leftall"> 
      <TABLE cellSpacing=0 cellPadding=0 width="100%" border="0" style="word-break:break-all">
        <TR class="title_left"> 
          <TD align="center"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td class="title_lefttxt"><div align="center"><strong><b>��ע��<%=SiteName%></b></strong></div></td>
              </tr>
            </table></TD>
        </TR>
        <TR> 
          <TD height="80" valign="top" class="tdbg_left"> <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="5">
              <tr> 
                <td valign="top"><br> <b>&nbsp;&nbsp;ע�Ჽ��</b><br> &nbsp;&nbsp;һ���Ķ���ͬ��Э��<font color="#FF0000">
                  <%if action<>"apply" then %>
                  ��
                  <%else%>
                  ��
                  <%end if%>
                  </font><br> &nbsp;&nbsp;������дע������<font color="#FF0000">
                  <%if action="apply" then %>
                  ��
                  <%end if%>
                  </font><br> &nbsp;&nbsp;�������ע�� </td>
              </tr>
            </table></TD>
        </TR>
      </table> 
      
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td class="tdbg_left"><table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr> 
                <td height="11" Class="title_left2"></td>
              </tr>
            </table></td>
        </tr>
      </table></td>
    <td width=5></td>
    <td width="804" align="center" valign=top> 
<%
if action<>"apply" then
%>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr class='title_main'>
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td class="title_maintxt"><div align="center"><b><%=SiteName%>�������������</b></div></td>
              </tr>
            </table></td>
        </tr>
      </table>
      <table width=100% border=0 align=center cellpadding=0 cellspacing=0 class="border">
        <tr class='tdbg'> 
          <td height="382" align=left> 
           <!-- <div align=center > -->
              <text readonly style="font size:9pt;height:100%;width:100%">
&nbsp;&nbsp;&nbsp;&nbsp;��ӭ��ע���Ϊ<%=SiteName%>���û���<br>
&nbsp;&nbsp;&nbsp;&nbsp;����ϸ�Ķ������Э�飬ֻ�н���Э����ܼ�������ע�ᡣ<br>
&nbsp;&nbsp;&nbsp;&nbsp;1�����������ȷ�Ϻͽ���<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=SiteName%>�û����������Ȩ������Ȩ��<%=SiteName%>ӵ�С�<%=SiteName%>���ṩ�ķ��񽫰����й��³̡���������Ͳ��������ϸ�ִ�С��û�ͨ��ע�����������ͬ�⡱ ��ť������ʾ�û���<%=SiteName%>���Э�鲢�������еķ������<br>
&nbsp;&nbsp;&nbsp;&nbsp;2���û�ͬ�⣺<br> 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1)�ṩ��ʱ���꾡��׼ȷ�ĸ������ϡ�(<font color=red>����վ������д��ѧ���������Ͻ����ڽ�ѧͳ��ʹ�ã���ͬѧ��������ʵ��д��</font>)<br> 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2)���ϸ���ע�����ϣ����ϼ�ʱ���꾡��׼ȷ��Ҫ������ԭʼ��������Ͻ�����Ϊע�����ϡ�<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3)�û�ͬ�����ء��л����񹲺͹����ع������ܷ��������л����񹲺͹��������Ϣϵͳ��ȫ�����������������������������������йؼ�������������涨�ķ��ɺͷ��桢ʵʩ�취�����κ�����£��й�վ��վ�������Ϊ�û�����Ϊ����Υ���������ɡ����棬�й�վ��վ�������κ�ʱ�򣬲�������֪ͨ��ֹ����û��ṩ�����û�Ӧ�˽���ʻ��������޹����ԣ�Ӧ�ر�ע�����ص��������йصķ��ɺͷ��档<br>
&nbsp;&nbsp;&nbsp;&nbsp;3������������޸�<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=SiteName%>�᲻��ʱ���޸ķ��������������һ�������䶯�����������ҳ������ʾ�޸����ݡ������ͬ��Ķ�������һ�ε������ͬ�⡱��ť�� ����������ܣ���ʱȡ�������û�ʹ�÷����ʸ�<br>
&nbsp;&nbsp;&nbsp;&nbsp;4���û���˽�ƶ�<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�����û�������˽��<%=SiteName%>�� �������ߡ�<%=SiteName%>���ṫ�����༭��͸¶�û����ʼ����ݣ������з������Ҫ�󣬻�<%=SiteName%>�ڳ��ŵĻ�������Ϊ͸¶��Щ�ż���������������Ǳ�Ҫ�ģ�<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1)�����йط��ɹ涨����ӺϷ��������<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2)����ά��<%=SiteName%>���̱�����Ȩ��<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3)�ڽ�������½���ά���û����˺������ڵ���˽��ȫ��<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4)����������ص�Ҫ��<br>
&nbsp;&nbsp;&nbsp;&nbsp;6���û����ʺţ�����Ͱ�ȫ��<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;һ��ע��ɹ���Ϊ<%=SiteName%>�û��������õ�һ��������ʺš�����������ܺ��Լ����ʺź����밲ȫ��������˲����ĺ����ȫ�����Ρ����⣬ÿ���û���Ҫ�����ʻ��е����л���¼���ȫ��������ʱ����ָʾ�ı��������룬Ҳ���Խ����ɵ��ʻ��ؿ�һ�����ʻ����û�ͬ���������κηǷ�ʹ���û��ʺŻ�ȫ©�������������֪ͨվ����<br>
&nbsp;&nbsp;&nbsp;&nbsp;7���û�����<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�û������е��������ݵ����Ρ��û�������ѭ��<br> 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1)�����Ż�����������<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2)������վ�κ�ҳ�淢���κ���������ص���Ϣ��<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3)��������ʹ���ʼ����������Э�顢�涨������͹�����<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4)�������ñ�վΣ�����Ұ�ȫ��й¶�������ܣ������ַ�������Ἧ��ĺ͹���ĺϷ�Ȩ�档<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;5)�������ñ�վ���������ƺʹ���������Ϣ��<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1��ɿ�����ܡ��ƻ��ܷ��ͷ��ɡ���������ʵʩ�ģ�<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2��ɿ���߸�������Ȩ���Ʒ���������ƶȵģ�<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3��ɿ�����ѹ��ҡ��ƻ�����ͳһ�ģ�<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4��ɿ�������ޡ��������ӣ��ƻ������Ž�ģ�<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;5���������������ʵ��ɢ��ҥ�ԣ������������ģ�<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;6������⽨���š����ࡢɫ�顢�Ĳ�����������ɱ���ֲ�����������ģ�<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;7����Ȼ�������˻���������ʵ�̰����˵ģ����߽����������⹥���ģ�<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;8���𺦹��һ��������ģ�<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;9������Υ���ܷ��ͷ�����������ģ�<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;10��������ҵ�����Ϊ�ġ�<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�û����������ʼ������������ʼ��������ʼ���ַ����κ�δ����������ż����ˡ��û����ŵ�������κηǷ��ġ�ɧ���Եġ��������˵ġ������Եġ������Եġ��˺��Եġ�ӹ�׵ĺ��������Ϣ���ϡ����⣬�û�Ҳ���ܴ����κν������˹��ɷ�����Ϊ�����ϣ����ܴ��䳤���ڲ����������漰���Ұ�ȫ�����ϣ����ܴ����κβ����ϵ��ط��桢���ҷ��ɺ͹��ʷ� �ɵ����ϡ�δ����ɶ��Ƿ�������������ϵͳ�ǽ�ֹ�ġ����û�����Ϊ���������ϵ����<%=SiteName%>��ȡ���û������ʺš�<br>
&nbsp;&nbsp;&nbsp;&nbsp;8������Ȩ<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��ע��Э��Ľ���Ȩ��<%=SiteName%>���С�����������κ���������ҵ��йط�����ִ������Թ��ҷ��ɵ����Ĺ涨Ϊ׼��<br>
</text>
          <!--  </div>-->
            <div align="center"> 
              <form action="User_Reg.asp" method="get">
                <input name="Action" type="hidden" id="Action" value="apply">
                <input name="Submit" type="submit" value=" ��ͬ�� " style="cursor:hand;">
                &nbsp; &nbsp; &nbsp; 
                <input type="button" value=" ��ͬ�� " onClick="window.location.href='index.asp'"  style="cursor:hand;">
              </form>
            </div></td>
        </tr>
      </table>
      <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <tr> 
          <td  height="15" align="center" valign="top"> <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr> 
                <td height="13" Class="tdbg_left2"></td>
              </tr>
            </table></td>
        </tr>
      </table>
      <%
else
%>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr class='title_main'> 
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td class="title_maintxt"><div align="center"><font face="����" color="#FF3300"><strong>���û�ע��</strong></font></div></td>
              </tr>
            </table></td>
        </tr>
      </table> 
      <table width=100% border=0 cellpadding=2 cellspacing=4 bordercolor="#FFFFFF" class="border" style="border-collapse: collapse">
        <FORM name='UserReg' action='User_RegPost.asp' method='post'>
          <TR class="tdbg" > 
            <TD width="43%"><b>�û�����</b><BR>
              ���ܳ���14���ַ���7�����֣�</TD>
            <TD width="57%" align="left"><INPUT   maxLength=14 size=30 name="UserName"> <font color="#FF0000">*</font> 
              <input name="Check" type="button" id="Check" value="����û���" onClick="checkreg();"></TD>
          </TR>
          <TR class="tdbg" > 
            <TD width="43%"><B>����(����6λ)��</B><BR>
              ���������룬���ִ�Сд�� �벻Ҫʹ���κ����� '*'��' ' �� HTML �ַ� </TD>
            <TD width="57%" align="left"> <INPUT   type=password maxLength=12 size=30 name="Password"> 
              <font color="#FF0000">*</font> </TD>
          </TR>
          <TR class="tdbg" > 
            <TD width="43%"><strong>ȷ������(����6λ)��</strong><BR>
              ������һ��ȷ��</TD>
            <TD width="57%" align="left"> <INPUT   type=password maxLength=12 size=30 name="PwdConfirm"> 
              <font color="#FF0000">*</font> </TD>
          </TR>
          <TR class="tdbg" > 
            <TD width="43%"><strong>�������⣺</strong><BR>
              �����������ʾ����</TD>
            <TD width="57%" align="left"> <input   type=text maxlength=50 size=30 name="Question"> 
              <font color="#FF0000">*</font> </TD>
          </TR>
          <TR class="tdbg" > 
            <TD width="43%"><strong>����𰸣�</strong><BR>
              �����������ʾ����𰸣�����ȡ������</TD>
            <TD width="57%" align="left"> <INPUT   type=text maxLength=20 size=30 name="Answer"> 
              <font color="#FF0000">*</font> </TD>
          </TR>
		  <!--��ʵ��������-->
		            <TR class="tdbg" > 
            <TD width="43%"><strong>������</strong><BR>
              ������������ʵ����</TD>
            <TD width="57%" align="left"><input   type=text maxlength=50 size=30 name="TrueName"> 
              <font color="#FF0000">*</font> </TD>
          </TR>
		  <!--������ʵ��������-->
		  <!--��ʵѧ������-->
		  <TR class="tdbg" > 
            <TD width="43%"><strong>ѧ�ţ�</strong><BR>
              ����������ѧ��</TD>
            <TD width="57%" align="left"><input   type=text maxlength=50 size=30 name="StudentNumber"> 
              <font color="#FF0000">*</font> </TD>
          </TR>
		  <!--������ʵѧ������-->
          <TR class="tdbg" > 
            <TD width="43%"><strong>�Ա�</strong><BR>
              ��ѡ�������Ա�</TD>
            <TD width="57%" align="left"> <INPUT type=radio CHECKED value="1" name=sex>
              �� &nbsp;&nbsp; <INPUT type=radio value="0" name=sex>
              Ů</TD>
          </TR>
		  <!--ѧԺ�б�������-->
		  <TR class="tdbg" > 
            <TD width="43%"><strong>ѧԺ��</strong></TD>
            <TD width="57%" align="left"> 
				<%  call College() %><font color="#FF0000">*</font>
                </TD>
          </TR>
		  <!--����ѧԺ�б�������-->
		  	  <!--�༶�б�������-->
		  <TR class="tdbg" > 
            <TD width="43%"><strong>�༶��</strong></TD>
            <TD width="57%" align="left"> <!-- רҵ����-->
				<% call StudentClassName() %>&nbsp;&nbsp;
				<% call StudentClassYear() %>
				<% call StudentClassNumber() %>
				 <font color="#FF0000">*</font>(��רҵֻ��һ�����ѡ"01")
		    </TD>
          </TR>
		  <!--�����༶�б�������-->
		  <TR class="tdbg" > 
            <TD width="43%"><strong>Email��ַ��</strong><BR/>
              ��������Ч���ʼ���ַ���⽫ʹ�����õ���վ�е����й���</TD>
            <TD width="57%" align="left"> <INPUT   maxLength=50 size=30 name=Email> <font color="#FF0000">*</font></TD>
          </TR>
          <TR align="center" class="tdbg" > 
            <TD height="30" colspan="2"> <input   type=submit value=" ע �� " name=Submit2> 
              &nbsp; <input name=Reset   type=reset id="Reset" value=" �� �� "> 
            </TD>
          </TR>
        </form>
        <form name='reg' action='User_checkreg.asp' method='post' target='CheckReg'>
          <input type='hidden' name='username' value=''>
        </form>
      </TABLE>
      <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <tr> 
          <td  height="15" align="center" valign="top"> <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr> 
                <td height="13" Class="tdbg_left2"></td>
              </tr>
            </table></td>
        </tr>
      </table>
      <script language=javascript>
function checkreg()
{
  if (document.UserReg.UserName.value=="")
	{
	alert("�������û�����");
	document.UserReg.UserName.focus();
	return false;
	}
  else
    {
	document.reg.username.value=document.UserReg.UserName.value;
	var popupWin = window.open('User_CheckReg.asp', 'CheckReg', 'scrollbars=no,width=340,height=200');
	document.reg.submit();
	}
}
</script>
<%end if%>
    </td>
    </tr>
</table>
</td></tr>
<tr><td>
<%
 call Bottom_All()  
call CloseConn
%></td></tr></table>
</body>
</html>
