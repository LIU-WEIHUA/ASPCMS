<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<%
option explicit
response.buffer=true	
Const PurviewLevel=5    '����Ȩ��
Const CheckChannelID=2    '����Ƶ����0Ϊ���������Ƶ��
%>
<!--#include file="Admin_ChkPurview.asp"-->
<!--#include file="inc/conn.asp"-->
<!--#include file="inc/function.asp"-->
<!--#include file="inc/ubbcode.asp"-->
<%
const MaxPerPage=20
dim strFileName,FileName
dim totalPut,CurrentPage,TotalPages
dim sql,rsOrderForm
dim Action,FoundErr,ErrMsg
FileName="Admin_OrderForm.asp"
Action=trim(request("Action"))
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>����������</title>
<link href="Admin_Style.css" rel="stylesheet" type="text/css">
</head>
<body leftmargin="2" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" class="border">
  <tr class="topbg"> 
    <td height="22" colspan="2" align="center"><strong>�� �� �� �� ��</strong></td>
  </tr>
  <tr class="tdbg"> 
    <td width="70" height="30"><strong>��������</strong></td>
    <td><a href="Admin_OrderForm.asp">������������ҳ</a></td>
  </tr>
</table>
<%
if Action="Show" then
	call ShowOrderForm()
elseif Action="Del" then
	call DelOrderForm()
else
	call main()
end if
if FoundErr=True then
	call WriteErrMsg()
end if
call CloseConn()

sub main()
	sql="select * from OrderForm order by OrderFormID desc"
	Set rsOrderForm= Server.CreateObject("ADODB.Recordset")
	rsOrderForm.open sql,conn,1,1
	if rsOrderForm.eof and rsOrderForm.bof then
		totalPut=0
		if Child=0 then
			response.write "<p align='center'><br>û���κ����£�<br></p>"
		else
			response.write "<p align='center'><br>����Ŀ����һ������Ŀ��û���κ����£�<br></p>"
		end if
	else
		totalPut=rsOrderForm.recordcount
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
			showContent
			showpage strFileName,totalput,MaxPerPage,true,true,"ƪ����"
		else
			if (currentPage-1)*MaxPerPage<totalPut then
				rsOrderForm.move  (currentPage-1)*MaxPerPage
				dim bookmark
				bookmark=rsOrderForm.bookmark
				showContent
				showpage strFileName,totalput,MaxPerPage,true,true,"ƪ����"
			else
				currentPage=1
				showContent
				showpage strFileName,totalput,MaxPerPage,true,true,"ƪ����"
			end if
		end if
	end if
	rsOrderForm.close
	set rsOrderForm=nothing  
end sub

sub showContent
   	dim FormCount
    FormCount=0
%>
<br>
<table width='100%' border="0" cellpadding="0" cellspacing="0">
  <tr>
    <form name="myform" method="Post" action="Admin_OrderFormDel.asp" onsubmit="return ConfirmDel();">
      <td><table class="border" border="0" cellspacing="1" width="100%" cellpadding="0">
          <tr class="title" height="22">
            <td height="22" width="30" align="center"><strong>ѡ��</strong></td>
            <td width="80" align="center"  height="22"><strong>�������</strong></td>
            <td align="center" ><strong>������λ</strong></td>
            <td width="100" align="center" ><strong>��ϵ��</strong></td>
            <td width="150" align="center" ><strong>��ϵ�绰</strong></td>
            <td width="100" align="center" ><strong>����</strong></td>
          </tr>
          <%do while not rsOrderForm.eof%>
          <tr class="tdbg" onmouseout="this.style.backgroundColor=''" onmouseover="this.style.backgroundColor='#BFDFFF'">
            <td width="30" align="center"><input name='OrderFormID' type='checkbox' onclick="unselectall()" id="OrderFormID" value='<%=cstr(rsOrderForm("OrderFormID"))%>'>
            </td>
            <td width="80" align="center"><%=rsOrderForm("OrderFormNum")%></td>
            <td><%response.write "<a href='Admin_OrderForm.asp?Action=Show&OrderFormID=" & rsOrderForm("OrderFormID") & "'>" & rsOrderForm("Company") & "</a>" %></td>
            <td width="100" align="center"><%= rsOrderForm("ContactMan") %></td>
            <td width="150" align="center"><%= rsOrderForm("Phone") %></td>
            <td width="100" align="center"><%
			response.write "<a href='Admin_OrderForm.asp?Action=Del&OrderFormID=" & rsOrderForm("OrderFormID") & "'>ɾ��</a>" %></td>
          </tr>
          <%
		FormCount=FormCount+1
	   	if FormCount>=MaxPerPage then exit do
	   	rsOrderForm.movenext
	loop
%>
        </table>
          <table width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td width="250" height="30"><input name="chkAll" type="checkbox" id="chkAll" onclick=CheckAll(this.form) value="checkbox">
              ѡ�б�ҳ��ʾ�����ж���</td>
              <td><input name="submit" type='submit' value='ɾ��ѡ���Ķ���' onClick="document.myform.Action.value='Del'">
                  <input name="Action" type="hidden" id="Action" value="Del">
              </td>
            </tr>
          </table>
      </td>
    </form>
  </tr>
</table>
<%
end sub

sub ShowOrderForm()
	dim OrderFormID
	OrderFormID=trim(request("OrderFormID"))
	if OrderFormID="" then
		FoundErr=true
		ErrMsg=ErrMsg & "<br><li>��ָ������ID</li>"
		exit sub
	else
		OrderFormID=Clng(OrderFormID)
	end if
	
	sql="select * from OrderForm where OrderFormID=" & OrderFormID
	Set rsOrderForm= Server.CreateObject("ADODB.Recordset")
	rsOrderForm.open sql,conn,1,1
	if rsOrderForm.eof and rsOrderForm.bof then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>�Ҳ���ָ���Ķ�����</li>"
		rsOrderForm.close
		set rsOrderForm=nothing
		exit sub
	end if
%>
<form name="form1" method="post" action="Admin_OrderForm.asp">
<table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" class="border">
  <tr class="title">
    <td height="22" colspan="4" align="center"><strong> �� �� �� �� Ϣ</strong></td>
  </tr>
  <tr class="tdbg">
    <td width="68">��λ���ƣ�</td>
    <td colspan="3"><%=rsOrderForm("Company")%></td>
  </tr>
  <tr class="tdbg">
    <td>�� ϵ �ˣ�</td>
    <td width="377"><%=rsOrderForm("ContactMan")%></td>
    <td width="67">��ϵ�绰��</td>
    <td width="227"><%=rsOrderForm("Phone")%></td>
  </tr>
  <tr class="tdbg">
    <td>��ϵ��ַ��</td>
    <td><%=rsOrderForm("Address")%> </td>
    <td>�������룺</td>
    <td><%=rsOrderForm("PostCode")%> </td>
  </tr>
  <tr>
    <td colspan="4"><table width="100%" border="0" cellspacing="1" cellpadding="0">
      <tr align="center" class="tdbg">
        <td colspan="6"><strong>�� �� �� �� �� ��</strong></td>
        </tr>
      <tr align="center" class="tdbg">
        <td>��Ʒ����</td>
        <td>����ͺ�</td>
        <td>��λ</td>
        <td>����</td>
        <td>�ͻ�ʱ��</td>
        <td>��ע</td>
      </tr>
	  <%
	  dim rsFormItem,i,j
	  i=0
	  set rsFormItem=conn.execute("select * from OrderForm_Item where OrderFormID=" & rsOrderForm("OrderFormID"))
	  do while not rsFormItem.eof
	  %>
      <tr align="center" class="tdbg">
        <td><%=rsFormItem("ProductName")%></td>
        <td><%=rsFormItem("Standard")%></td>
        <td><%=rsFormItem("Unit")%></td>
        <td><%=rsFormItem("Ammount")%></td>
        <td><%=rsFormItem("SendTime")%> </td>
        <td><%=rsFormItem("Remark")%> </td>
      </tr>
	  <%
	  	rsFormItem.movenext
		i=i+1
	loop
	set rsFormItem=nothing
	for j=i+1 to 10
	%>
      <tr align="center" class="tdbg">
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
	  <%
	  next
	  %>
    </table>
    </td>
  </tr>
  <tr class="tdbg">
    <td>����Ҫ��</td>
    <td height="50" colspan="3" valign="top"><%=ubbcode(rsOrderForm("SpecialDemand"))%></td>
  </tr>
  <tr align="center" class="tdbg">
    <td height="40" colspan="4"><input name="OrderFormID" type="hidden" id="OrderFormID" value="<%=OrderFormID%>">      <input name="Action" type="hidden" id="Action" value="Del">      <input name="Submit" type="submit" id="Submit" value="ɾ��������"></td>
  </tr>
</table>
</form>
<%
	rsOrderForm.close
	set rsOrderForm=nothing
end sub
%>
</body>
</html>
<%
sub DelOrderForm()
	dim OrderFormID,i
	OrderFormID=trim(Request("OrderFormID"))
	if OrderFormID="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>��ָ������ID</li>"
		Exit sub
	end if

	if instr(OrderFormID,",")>0 then
		dim idarr
		idArr=split(OrderFormID)
		for i = 0 to ubound(idArr)
		    conn.execute "delete from OrderForm where OrderFormID=" & Clng(idArr(i))
		    conn.execute "delete from OrderForm_Item where OrderFormID=" & Clng(idArr(i))
		next
	else
		conn.execute "delete from OrderForm where OrderFormID=" & Clng(OrderFormID)
		conn.execute "delete from OrderForm_Item where OrderFormID=" & Clng(OrderFormID)
	end if
	call CloseConn()
	response.redirect "Admin_OrderForm.asp"
end sub
%>
