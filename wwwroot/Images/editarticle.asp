<!--#include file="chkstr.inc"-->  
<!--#include file="const.asp"-->
 <!--#include file="articleconn.asp"-->
 <%
IF not(Session("KEY")="super" or session("KEY")="check" ) THEN
	response.redirect "error.asp?id=065"
	response.end
END IF
%>

<html>
<head>
<title>�޸�����</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style>
<!--
a:link       { text-decoration: underline; color: #000000; font-family: ���� }
a:visited    { text-decoration: underline; color: #000000; font-family: ���� }
a:hover      { text-decoration: underline; color: #cc0000 }
body {font-family: "����"; font-size: 9pt;line-height: 12pt;}
table {font-family: "����"; font-size: 9pt;line-height: 12pt;}
-->
</style>
</head>


<body bgcolor="#a4ce97" text="#000000">
<TABLE cellSpacing=0 borderColorDark=#ffffff cellPadding=0  width="80%" align=center 
 borderColorLight=#397904 border=1>
  <form method="POST" action="editok.asp?id=<%=request("id")%>">
    <tr align="center"> 
      <td colspan="2">&nbsp;<b><font color="#FF0000">�� �� �� �� </font></b></td>
    </tr>
    <tr> 
      <td width="20%" align="right">&nbsp;���⣺</td>
      <td>&nbsp; 
        <%
dim sql
dim rs
set rs=server.createobject("adodb.recordset")
 sql="select * from article where newsid="&request("id")
rs.open sql,conn,1,1
                %>
        <INPUT name="txttitle"  size=40 
      value="<%=rs("title")%>"> </td>
    </tr>
    <tr> 
      <td align="right">&nbsp;���ݣ�</td>
      <td>&nbsp; <TEXTAREA id=content name=txtcontent rows=12 cols=50><%content=replace(rs("content"),"<br>",chr(13))
            content=replace(content,"&nbsp;"," ")
            content=replace(content,"<img src=","[sayyes]")
            content=replace(content,"></img>","[/sayyes]")
            response.write content%></TEXTAREA> </td>
    </tr>
    <tr> 
      <td align="right">&nbsp;��Ŀ��</td>
      <td>&nbsp; <select class="unnamed2" name="typeid" size="1" style="border: 1px dotted #008000">
          <%                                     
dim rs1,sql1,sel                                     
 set rs1=server.createobject("adodb.recordset")                                     
  sql1="select * from type"                                     
 rs1.open sql1,conn,1,1                                     
  do while not rs1.eof 
 if rs1("type")=rs("typename") then                                    
      sel="selected"               
   else
   sel=""
  end if                          
		             response.write "<option " & sel & " value='"+CStr(rs1("typeID"))+"' name=typeid>"+rs1("type")+"</option>"+chr(13)+chr(10)                                     
		             rs1.movenext                                     
    		          loop                                     
			rs1.close                                     
			  %>
        </select> </td>
    </tr>
    <tr bordercolor="#111111" background="images/greystrip.gif"> 
      <td align="right" valign="middle" class="unnamed2">��ҳͼƬ·����</td>
      <td> <span style='cursor:hand' title='���̶Ի���' onClick='if (me1.size>10)me1.size=me1.size-2'>-</span> 
        <input name="picurl" type="TEXT" id=me1 style="background-color:ffffff;color:000000;border: 1 double" size="34"> 
        <span style='cursor:hand' title='�ӳ��Ի���' onClick='if (me1.size<102)me1.size=me1.size+2'>+</span> 
        (ͼƬ��С���Ϊ100X120) </td>
    </tr>
    <tr bordercolor="#111111" background="images/greystrip.gif"> 
      <td align="right" height="30" class="unnamed2" valign="middle">�Ƿ���ͼƬ</td>
      <td height="30" valign="middle"> <input type="checkbox" name="checkbox3" value="1" class="unnamed5"> 
        <span class="unnamed2">��ѡ��,���ű���ǰ���Զ�����<font color="#0000FF">[ͼ��]</font>��־. 
        </span></td>
    </tr>
    <tr> 
      <td width="20%" align="right">&nbsp;�Ƽ���</td>
      <td>&nbsp; <select name="tj" size="1">
          <option  <%if rs("tjnews")="��" then%> selected <%end if%> value="��" name="tj">��</option>
          <option  <%if rs("tjnews")="���" then%> selected <%end if%> value="���" name="tj">���</option>
          <option  <%if rs("tjnews")="����" then%> selected <%end if%>  value="����" name="tj">����</option>
          <option  <%if rs("tjnews")="�����" then%> selected <%end if%> value="�����" name="tj">�����</option>
          <option  <%if rs("tjnews")="������" then%> selected <%end if%> value="������" name="tj">������</option>
        </select> </td>
    </tr>
    <tr align="center"> 
      <td colspan="2"> <input type="submit" value="�޸�" name="cmdok" size="12" class=button4 onmousedown="document.forms[0].target='_self'" > 
        <input type="reset" value="�� ��"  style="cmdcancel" class=button4 >
        <script LANGUAGE="JavaScript">
function goHist(a) 
{
   history.go(a);   
}
                </script> <input TYPE="button" VALUE="&lt;--����" onClick="goHist(-1)" class=button4> 
      </td>
    </tr>
  </form>
</table>
      
</body>
</html>
<%
set rs=nothing
set rs1=nothing
 conn.close
set conn=nothing
%>