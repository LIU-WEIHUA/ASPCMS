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

<body leftmargin="2" topmargin="0" marginwidth="0" marginheight="0">
<!--#include file="Top.asp"-->
<table width="760" height="300" border="0" align="center" cellpadding="0" cellspacing="0" class="border2">
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
    <td width="575" align="center" valign=top> 
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
          <td height="382" align=left><br> 
            <div align=center> 
              <textarea readonly style="width:98%;height:310;font size:9pt">
 ��ӭ��ע���Ϊ<%=SiteName%>�û���
 ����ϸ�Ķ������Э�飬ֻ�н���Э����ܼ�������ע�ᡣ 

 1�����������ȷ�Ϻͽ���

����<%=SiteName%>�û����������Ȩ������Ȩ��<%=SiteName%>ӵ�С�<%=SiteName%>���ṩ�ķ��񽫰����й��³̡���������Ͳ��������ϸ�ִ�С��û�ͨ��ע�����������ͬ�⡱ ��ť������ʾ�û���<%=SiteName%>���Э�鲢�������еķ������

 2�� <%=SiteName%>������

����<%=SiteName%>ͨ�����ʻ�����Ϊ�û��ṩ�ʼ��շ���BBS��̳�����������������صȷ���

�����û����룺 
����1)�����豸���������˵���һ̨�����ƽ����һ�����䱸����װ�á� 
����2)����������֧����˷����йصĵ绰���á�������á�

�����û�ͬ�⣺ 
����1)�ṩ��ʱ���꾡��׼ȷ�ĸ������ϡ� 
����2)���ϸ���ע�����ϣ����ϼ�ʱ���꾡��׼ȷ��Ҫ������ԭʼ��������Ͻ�����Ϊע�����ϡ� 
����3)�û�ͬ�����ء��л����񹲺͹����ع������ܷ��������л����񹲺͹��������Ϣϵͳ��ȫ�����������������������������������йؼ�������������涨�ķ��ɺͷ��桢ʵʩ�취�����κ�����£��й�վ��վ�������Ϊ�û�����Ϊ����Υ���������ɡ����棬�й�վ��վ�������κ�ʱ�򣬲�������֪ͨ��ֹ����û��ṩ�����û�Ӧ�˽���ʻ��������޹����ԣ�Ӧ�ر�ע�����ص��������йصķ��ɺͷ��档
���� 
 3�� ����������޸�

����<%=SiteName%>�᲻��ʱ���޸ķ��������������һ�������䶯�����������ҳ������ʾ�޸����ݡ������ͬ��Ķ�������һ�ε������ͬ�⡱��ť�� ����������ܣ���ʱȡ�������û�ʹ�÷����ʸ�

 4�� �����޶�

����<%=SiteName%>������ʱ�޸Ļ��жϷ��������֪���û���Ȩ�����й�վ��վ��ʹ�޸Ļ��жϷ����Ȩ����������û������������*�ʼ�ϵͳ�����շѵĿ��ܡ�

 5�� �û���˽�ƶ�

���������û�������˽��<%=SiteName%>�� �������ߡ�<%=SiteName%>���ṫ�����༭��͸¶�û����ʼ����ݣ������з������Ҫ�󣬻�<%=SiteName%>�ڳ��ŵĻ�������Ϊ͸¶��Щ�ż���������������Ǳ�Ҫ�ģ� 
����1)�����йط��ɹ涨����ӺϷ�������� 
����2)����ά��<%=SiteName%>���̱�����Ȩ�� 
����3)�ڽ�������½���ά���û����˺������ڵ���˽��ȫ�� 
����4)����������ص�Ҫ�� 

 6���û����ʺţ�����Ͱ�ȫ��

����һ��ע��ɹ���Ϊ<%=SiteName%>�û��������õ�һ��������ʺš�����������ܺ��Լ����ʺź����밲ȫ��������˲����ĺ����ȫ�����Ρ����⣬ÿ���û���Ҫ�����ʻ��е����л���¼���ȫ��������ʱ����ָʾ�ı��������룬Ҳ���Խ����ɵ��ʻ��ؿ�һ�����ʻ����û�ͬ���������κηǷ�ʹ���û��ʺŻ�ȫ©�������������֪ͨ�й�վ��վ��

 7�� ��������

�����û���ȷͬ���ʼ������ʹ�����û����˳е����ա� ���� 
����<%=SiteName%>�����κ����͵ĵ���������������һ���������û���Ҫ��Ҳ���������񲻻����жϣ��Է���ļ�ʱ�ԣ���ȫ�ԣ��������������������û���Ⲣ���ܣ��κ�ͨ���й�վ��վ����ȡ�õ���Ϣ���ϵĿɿ���ȡ�����û��Լ����û��Լ��е����з��պ����Ρ� 
 
 8����������

����<%=SiteName%>���κ�ֱ�ӡ���ӡ�żȻ�����⼰������𺦲������Σ���Щ�����ԣ�������ʹ���ʼ����������Ϲ�����Ʒ����������Ͻ��н��ף��Ƿ�ʹ���ʼ�������û����͵���Ϣ���䶯��
 
 9�� ���ṩ���ۺ���ҵ�Է��� 
���� 
�����û�ʹ���ʼ������Ȩ���Ǹ��˵ġ��û�ֻ����һ�������ĸ����������һ����˾��ʵ����ҵ����֯���û���ŵ����<%=SiteName%>ͬ�⣬���������ʼ�����������ۻ�������ҵ��;��

 10���û����� 

�����û������е��������ݵ����Ρ��û�������ѭ�� 
����1)���й��������⴫�似��������ʱ��������й��йط��档 
����2)ʹ���ʼ��������Ƿ���;�� 
����3)�����Ż����������� 
����4)������̳BBS�����Բ������κ���������ص���Ϣ�� 
����5)��������ʹ���ʼ����������Э�顢�涨������͹�����
����6)�������ñ�վΣ�����Ұ�ȫ��й¶�������ܣ������ַ�������Ἧ��ĺ͹���ĺϷ�Ȩ�档
����7)�������ñ�վ���������ƺʹ���������Ϣ�� 
������1��ɿ�����ܡ��ƻ��ܷ��ͷ��ɡ���������ʵʩ�ģ�
������2��ɿ���߸�������Ȩ���Ʒ���������ƶȵģ�
������3��ɿ�����ѹ��ҡ��ƻ�����ͳһ�ģ�
������4��ɿ�������ޡ��������ӣ��ƻ������Ž�ģ�
������5���������������ʵ��ɢ��ҥ�ԣ������������ģ�
������6������⽨���š����ࡢɫ�顢�Ĳ�����������ɱ���ֲ�����������ģ�
������7����Ȼ�������˻���������ʵ�̰����˵ģ����߽����������⹥���ģ�
������8���𺦹��һ��������ģ�
������9������Υ���ܷ��ͷ�����������ģ�
������10��������ҵ�����Ϊ�ġ�
���� 
�����û����������ʼ������������ʼ��������ʼ���ַ����κ�δ����������ż����ˡ��û����ŵ�������κηǷ��ġ�ɧ���Եġ��������˵ġ������Եġ������Եġ��˺��Եġ�ӹ�׵ĺ��������Ϣ���ϡ����⣬�û�Ҳ���ܴ����κν������˹��ɷ�����Ϊ�����ϣ����ܴ��䳤���ڲ����������漰���Ұ�ȫ�����ϣ����ܴ����κβ����ϵ��ط��桢���ҷ��ɺ͹��ʷ� �ɵ����ϡ�δ����ɶ��Ƿ�������������ϵͳ�ǽ�ֹ�ġ����û�����Ϊ���������ϵ����<%=SiteName%>��ȡ���û������ʺš�

 11������ͨ��

�������з����û���ͨ�涼��ͨ�������ʼ��򳣹���ż����͡�<%=SiteName%>��ͨ���ʼ����񷢱���Ϣ���û����������Ƿ���������޸ġ�����������������Ҫ���顣

 12����վ���ݵ�����Ȩ

����<%=SiteName%>��������ݰ��������֡��������������Ƭ��¼��ͼ���ڹ����ȫ�����ݣ������ʼ���ȫ�����ݣ��й�վ��վΪ�û��ṩ����ҵ��Ϣ��������Щ�����ܰ�Ȩ���̱ꡢ��ǩ�������Ʋ�����Ȩ���ɵı��������ԣ��û�ֻ�����й�վ��վ�͹������Ȩ�²���ʹ����Щ���ݣ����������Ը��ơ��۸���Щ���ݡ������������йص�������Ʒ��

 13��������Ϣ����

�����û�������<%=SiteName%>�ṩ����ѷ����ͬʱ��ͬ�����<%=SiteName%>�ṩ�ĸ��฽����Ϣ����

 14������Ȩ

������ע��Э��Ľ���Ȩ��<%=SiteName%>���С�����������κ���������ҵ��йط�����ִ������Թ��ҷ��ɵ����Ĺ涨Ϊ׼��
</textarea>
            </div>
            <div align="center"> 
              <form action="User_Reg.asp" method="get">
                <input name="Action" type="hidden" id="Action" value="apply">
                <input name="Submit" type="submit" value=" ��ͬ�� " style="cursor:hand;">
                &nbsp; 
                <input type="button" value=" ��ͬ�� " onClick="window.location.href='index.asp'"  style="cursor:hand;">
              </form>
            </div></td>
        </tr>
      </table>
      <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <tr> 
          <td  height="15" align="center" valign="top"> <table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
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
                <td class="title_maintxt"><div align="center"><font class=en><b>���û�ע��</b></font></div></td>
              </tr>
            </table></td>
        </tr>
      </table> 
      <table width=100% border=0 cellpadding=2 cellspacing=4 bordercolor="#FFFFFF" class="border" style="border-collapse: collapse">
        <FORM name='UserReg' action='User_RegPost.asp' method='post'>
          <TR class="tdbg" > 
            <TD width="43%"><b>�û�����</b><BR>
              ���ܳ���14���ַ���7�����֣�</TD>
            <TD width="57%"> <INPUT   maxLength=14 size=30 name="UserName"> <font color="#FF0000">*</font> 
              <input name="Check" type="button" id="Check" value="����û���" onClick="checkreg();"></TD>
          </TR>
          <TR class="tdbg" > 
            <TD width="43%"><B>����(����6λ)��</B><BR>
              ���������룬���ִ�Сд�� �벻Ҫʹ���κ����� '*'��' ' �� HTML �ַ� </TD>
            <TD width="57%"> <INPUT   type=password maxLength=12 size=33.5 name="Password"> 
              <font color="#FF0000">*</font> </TD>
          </TR>
          <TR class="tdbg" > 
            <TD width="43%"><strong>ȷ������(����6λ)��</strong><BR>
              ������һ��ȷ��</TD>
            <TD width="57%"> <INPUT   type=password maxLength=12 size=33.5 name="PwdConfirm"> 
              <font color="#FF0000">*</font> </TD>
          </TR>
          <TR class="tdbg" > 
            <TD width="43%"><strong>�������⣺</strong><BR>
              �����������ʾ����</TD>
            <TD width="57%"> <input   type=text maxlength=50 size=30 name="Question"> 
              <font color="#FF0000">*</font> </TD>
          </TR>
          <TR class="tdbg" > 
            <TD width="43%"><strong>����𰸣�</strong><BR>
              �����������ʾ����𰸣�����ȡ������</TD>
            <TD width="57%"> <INPUT   type=text maxLength=20 size=30 name="Answer"> 
              <font color="#FF0000">*</font> </TD>
          </TR>
		  
		  <!--��ʵ��������-->
		            <TR class="tdbg" > 
            <TD width="43%"><strong>������</strong><BR>
              ������������ʵ����</TD>
            <TD width="57%"><input   type=text maxlength=50 size=30 name="TrueName"> 
              <font color="#FF0000">*</font> </TD>
          </TR>

		  
		  <!--������ʵ��������-->
		  
		  
		  <!--��ʵѧ������-->
		  <TR class="tdbg" > 
            <TD width="43%"><strong>ѧ�ţ�</strong><BR>
              ����������ѧ��</TD>
            <TD width="57%"><input   type=text maxlength=50 size=30 name="StudentNumber"> 
              <font color="#FF0000">*</font> </TD>
          </TR>

		  
		  <!--������ʵѧ������-->

		  
          <TR class="tdbg" > 
            <TD width="43%"><strong>�Ա�</strong><BR>
              ��ѡ�������Ա�</TD>
            <TD width="57%"> <INPUT type=radio CHECKED value="1" name=sex>
              �� &nbsp;&nbsp; <INPUT type=radio value="0" name=sex>
              Ů</TD>
          </TR>
          
		  <!--ѧԺ�б�������-->
		  <TR class="tdbg" > 
            <TD width="43%"><strong>ѧԺ��</strong></TD>
            <TD width="57%"> 
				<select  maxLength=50 size="1" name="College">
					<option  value="" >��ѡ������ѧԺ</option>
					<option  value="��ѧԺ" >��ѧԺ</option>
					<option  value="ˮ��ѧԺ" >ˮ��ѧԺ</option>
					<option  value="԰��ѧԺ">԰��ѧԺ</option>
					<option  value="����ѧԺ">����ѧԺ</option>
					<option  value="����ѧԺ" >����ѧԺ</option>
					<option  value="����ѧԺ" >����ѧԺ</option>
					<option  value="����ѧԺ" >����ѧԺ</option>
					<option  value="��ϢѧԺ" >��ϢѧԺ</option>
					<option  value="����ѧԺ" >����ѧԺ</option>
					<option  value="��ѧԺ" >��ѧԺ</option>
					<option  value="��ѧԺ" >��ѧԺ</option>
					<option  value="������ѧԺ" >������ѧԺ</option>
					<option  value="����ѧԺ" >����ѧԺ</option>

				</select> <font color="#FF0000">*</font></TD>
          </TR>
		  <!--����ѧԺ�б�������-->
		  
		  	  <!--�༶�б�������-->
		  <TR class="tdbg" > 
            <TD width="43%"><strong>�༶��</strong></TD>
            <TD width="57%"> <!-- רҵ����-->
				<select  maxLength=50 size="1" name="StudentClassName">
					<option  value="" >��ѡ������רҵ����</option>
					<option  value="��ѧ" >��ѧ</option>
					<option  value="���" >���</option>
					<option  value="��ҵ">��ҵ</option>
					<option  value="����">����</option>
					<option  value="��ƺ">��ƺ</option>
					<option  value="ˮ��" >ˮ��</option>
					<option  value="����" >����</option>
					<option  value="��ľ" >��ľ</option>
					<option  value="԰��" >԰��</option>
					<option  value="����" >����</option>
					<option  value="��԰" >��԰</option>
					<option  value="԰��" >԰��</option>
					<option  value="�ǹ�" >�ǹ�</option>
					<option  value="����">����</option>
					<option  value="����" >����</option>					
					<option  value="ʳƷ" >ʳƷ</option>
					<option  value="ľ��" >ľ��</option>
					<option  value="��װ">��װ</option>
					<option  value="�ֻ�">�ֻ�</option>
					<option  value="����" >����</option>
					<option  value="�־�" >�־�</option>
					<option  value="����" >����</option>
					<option  value="���" >���</option>
					<option  value="ͳ��" >ͳ��</option>
					<option  value="����" >����</option>
					<option  value="��ó" >��ó</option>
					<option  value="Ӫ��" >Ӫ��</option>
					<option  value="����" >����</option>
					<option  value="��ѧ" >��ѧ</option>
					<option  value="����" >����</option>
					<option  value="��Ϣ" >��Ϣ</option>
					<option  value="�����" >�����</option>
					<option  value="��ý" >��ý</option>
					<option  value="����" >����</option>
					<option  value="Ӣ��" >Ӣ��</option>					
					<option  value="����" >����</option>
					<option  value="��е" >��е</option>
					<option  value="����" >����</option>
					<option  value="����" >����</option>
					<option  value="�Զ���" >�Զ���</option>
					<option  value="����" >����</option>
					<option  value="����" >����</option>					
					<option  value="��ѧ" >��ѧ</option>
					<option  value="������" >������</option>
					<option  value="����" >����</option>
					<option  value="����" >����</option>
					<option  value="��ϣ" >��ϣ</option>
					
					
					
					

				</select><!-- ����רҵ����������-->
				
				<select  maxLength=50 size="1" name="StudentClassYear">
					<option  value="" >��ѡ�������꼶</option>
					<option  value="03" >03</option>
					<option  value="04" >04</option>
					<option  value="05">05</option>
					<option  value="06">06</option>
					<option  value="07" >07</option>
					<option  value="08" >08</option>
					<option  value="09" >09</option>
					<option  value="10" >10</option>
					<option  value="11" >11</option>
					<option  value="12" >12</option>
					<option  value="13" >13</option>
					<option  value="14" >14</option>
					<option  value="15" >15</option>

				</select>
				
				<select  maxLength=50 size="1" name="StudentClassNumber">
					<option  value="" >��ѡ�������༶(��רҵֻ��һ�����ѡ"01")</option>
					<option  value="01" >01</option>
					<option  value="02" >02</option>
					<option  value="03" >03</option>
					<option  value="04" >04</option>
					<option  value="05">05</option>
					<option  value="06">06</option>
					<option  value="07" >07</option>
					<option  value="08" >08</option>
					<option  value="09" >09</option>
					<option  value="10" >10</option>
					

				</select>

				
				 <font color="#FF0000">*</font>
		    </TD>
          </TR>
		  <!--�����༶�б�������-->
		  
		  
		  <TR class="tdbg" > 
            <TD width="43%"><strong>Email��ַ��</strong><BR>
              ��������Ч���ʼ���ַ���⽫ʹ�����õ���վ�е����й���</TD>
            <TD width="57%"> <INPUT   maxLength=50 size=30 name=Email> <font color="#FF0000">*</font></TD>
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
          <td  height="15" align="center" valign="top"> <table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
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

<table width="760" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
  <tr> 
    <td  height="13" align="center" valign="top"><table width="755" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
          <td height="13" Class="tdbg_left2"></td>
        </tr>
      </table></td>
  </tr>
</table>
<%
call Bottom()
call CloseConn
%>
</body>
</html>
