<!--#include file="Inc/syscode_article.asp"-->
<%
const ChannelID=2
Const ShowRunTime="Yes"
dim Action
SkinID=0
PageTitle="���϶���"
Action=trim(request("Action"))
if Action="SaveOrderForm" then
	call SaveOrderForm()
else
%>
<html>
<head>
<title><%=strPageTitle & " >> " & PageTitle%></title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<!--#include file="inc/Skin_CSS.asp"-->
<% call MenuJS() %>
<script language="JavaScript" type="text/JavaScript">
function CheckOrderForm()
{
  if(document.myform.Company.value==""){
    alert("�����뵥λ���ƣ�");
	document.myform.Company.focus();
	return false;
  }
  if(document.myform.ContactMan.value==""){
    alert("��������ϵ��������");
	document.myform.ContactMan.focus();
	return false;
  }
  if(document.myform.Phone.value==""){
    alert("��������ϵ�绰��");
	document.myform.Phone.focus();
	return false;
  }
  if(document.myform.ProductName[0].value==""){
    alert("����������һ���Ʒ�Ĳ�Ʒ���ƣ�");
	document.myform.ProductName[0].focus();
	return false;
  }
  if(document.myform.Standard[0].value==""){
    alert("����������һ���Ʒ�Ĺ���ͺţ�");
	document.myform.Standard[0].focus();
	return false;
  }
  if(document.myform.Unit[0].value==""){
    alert("����������һ���Ʒ�ĵ�λ��");
	document.myform.Unit[0].focus();
	return false;
  }
  var Ammount=document.myform.Ammount[0].value;
  if(Ammount==""){
    alert("����������һ���Ʒ�Ķ���������");
	document.myform.Ammount[0].focus();
	return false;
  }
  if (isNaN(Ammount)){
    alert("��Ʒ�Ķ����������������֣�");
	document.myform.Ammount[0].focus();
	return false;
  }  
}
</script>
</head>
<body <%=Body_Label%> onmousemove='HideMenu()'>
<form name="myform" method="post" action="OrderForm.asp" onSubmit="return CheckOrderForm();">
<!--#include file="Top.asp"-->
<table width="760" border="0" align="center" cellpadding="0" cellspacing="2" class="tdbg">
  <tr>
    <td colspan="4" align="center"><strong>�� �� �� ��</strong></td>
  </tr>
  <tr>
    <td width="68">��λ���ƣ�</td>
    <td colspan="3"><input name="Company" type="text" id="Company" size="80" maxlength="200">
      <font color="#FF0000">*</font></td>
    </tr>
  <tr>
    <td>�� ϵ �ˣ�</td>
    <td width="377"><input name="ContactMan" type="text" id="ContactMan" size="50" maxlength="20">
      <font color="#FF0000">*</font></td>
    <td width="67">��ϵ�绰��</td>
    <td width="227"><input name="Phone" type="text" id="Phone" size="15" maxlength="30">
      <font color="#FF0000">*</font></td>
  </tr>
  <tr>
    <td>��ϵ��ַ��</td>
    <td><input name="Address" type="text" id="Address" size="50" maxlength="200"></td>
    <td>�������룺</td>
    <td><input name="PostCode" type="text" id="PostCode" size="15" maxlength="10"></td>
  </tr>
  <tr>
    <td colspan="4"><table width="100%" border="0" cellspacing="3" cellpadding="0">
      <tr align="center">
        <td colspan="6"><strong>�� �� �� �� �� ��</strong></td>
        </tr>
      <tr align="center">
        <td>��Ʒ����</td>
        <td>����ͺ�</td>
        <td>��λ</td>
        <td>����</td>
        <td>�ͻ�ʱ��</td>
        <td>��ע</td>
      </tr>
      <tr align="center">
        <td><input name="ProductName" type="text" id="ProductName" size="24" maxlength="200"></td>
        <td><input name="Standard" type="text" id="Standard" size="26" maxlength="200"></td>
        <td><input name="Unit" type="text" id="Unit" size="10" maxlength="10"></td>
        <td><input name="Ammount" type="text" id="Ammount" size="10" maxlength="10"></td>
        <td><input name="SendTime" type="text" id="SendTime" value="<%=FormatDateTime(now(),2)%>" size="10" maxlength="20"></td>
        <td><input name="Remark" type="text" id="Remark" size="20" maxlength="255"></td>
      </tr>
      <tr align="center">
        <td><input name="ProductName" type="text" id="ProductName" size="24" maxlength="200"></td>
        <td><input name="Standard" type="text" id="Standard" size="26" maxlength="200"></td>
        <td><input name="Unit" type="text" id="Unit" size="10" maxlength="10"></td>
        <td><input name="Ammount" type="text" id="Ammount" size="10" maxlength="10"></td>
        <td><input name="SendTime" type="text" id="SendTime" size="10" maxlength="20"></td>
        <td><input name="Remark" type="text" id="Remark" size="20" maxlength="255"></td>
      </tr>
      <tr align="center">
        <td><input name="ProductName" type="text" id="ProductName" size="24" maxlength="200"></td>
        <td><input name="Standard" type="text" id="Standard" size="26" maxlength="200"></td>
        <td><input name="Unit" type="text" id="Unit" size="10" maxlength="10"></td>
        <td><input name="Ammount" type="text" id="Ammount" size="10" maxlength="10"></td>
        <td><input name="SendTime" type="text" id="SendTime" size="10" maxlength="20"></td>
        <td><input name="Remark" type="text" id="Remark" size="20" maxlength="255"></td>
      </tr>
      <tr align="center">
        <td><input name="ProductName" type="text" id="ProductName" size="24" maxlength="200"></td>
        <td><input name="Standard" type="text" id="Standard" size="26" maxlength="200"></td>
        <td><input name="Unit" type="text" id="Unit" size="10" maxlength="10"></td>
        <td><input name="Ammount" type="text" id="Ammount" size="10" maxlength="10"></td>
        <td><input name="SendTime" type="text" id="SendTime" size="10" maxlength="20"></td>
        <td><input name="Remark" type="text" id="Remark" size="20" maxlength="255"></td>
      </tr>
      <tr align="center">
        <td><input name="ProductName" type="text" id="ProductName" size="24" maxlength="200"></td>
        <td><input name="Standard" type="text" id="Standard" size="26" maxlength="200"></td>
        <td><input name="Unit" type="text" id="Unit" size="10" maxlength="10"></td>
        <td><input name="Ammount" type="text" id="Ammount" size="10" maxlength="10"></td>
        <td><input name="SendTime" type="text" id="SendTime" size="10" maxlength="20"></td>
        <td><input name="Remark" type="text" id="Remark" size="20" maxlength="255"></td>
      </tr>
      <tr align="center">
        <td><input name="ProductName" type="text" id="ProductName" size="24" maxlength="200"></td>
        <td><input name="Standard" type="text" id="Standard" size="26" maxlength="200"></td>
        <td><input name="Unit" type="text" id="Unit" size="10" maxlength="10"></td>
        <td><input name="Ammount" type="text" id="Ammount" size="10" maxlength="10"></td>
        <td><input name="SendTime" type="text" id="SendTime" size="10" maxlength="20"></td>
        <td><input name="Remark" type="text" id="Remark" size="20" maxlength="255"></td>
      </tr>
      <tr align="center">
        <td><input name="ProductName" type="text" id="ProductName" size="24" maxlength="200"></td>
        <td><input name="Standard" type="text" id="Standard" size="26" maxlength="200"></td>
        <td><input name="Unit" type="text" id="Unit" size="10" maxlength="10"></td>
        <td><input name="Ammount" type="text" id="Ammount" size="10" maxlength="10"></td>
        <td><input name="SendTime" type="text" id="SendTime" size="10" maxlength="20"></td>
        <td><input name="Remark" type="text" id="Remark" size="20" maxlength="255"></td>
      </tr>
      <tr align="center">
        <td><input name="ProductName" type="text" id="ProductName" size="24" maxlength="200"></td>
        <td><input name="Standard" type="text" id="Standard" size="26" maxlength="200"></td>
        <td><input name="Unit" type="text" id="Unit" size="10" maxlength="10"></td>
        <td><input name="Ammount" type="text" id="Ammount" size="10" maxlength="10"></td>
        <td><input name="SendTime" type="text" id="SendTime" size="10" maxlength="20"></td>
        <td><input name="Remark" type="text" id="Remark" size="20" maxlength="255"></td>
      </tr>
      <tr align="center">
        <td><input name="ProductName" type="text" id="ProductName" size="24" maxlength="200"></td>
        <td><input name="Standard" type="text" id="Standard" size="26" maxlength="200"></td>
        <td><input name="Unit" type="text" id="Unit" size="10" maxlength="10"></td>
        <td><input name="Ammount" type="text" id="Ammount" size="10" maxlength="10"></td>
        <td><input name="SendTime" type="text" id="SendTime" size="10" maxlength="20"></td>
        <td><input name="Remark" type="text" id="Remark" size="20" maxlength="255"></td>
      </tr>
      <tr align="center">
        <td><input name="ProductName" type="text" id="ProductName" size="24" maxlength="200"></td>
        <td><input name="Standard" type="text" id="Standard" size="26" maxlength="200"></td>
        <td><input name="Unit" type="text" id="Unit" size="10" maxlength="10"></td>
        <td><input name="Ammount" type="text" id="Ammount" size="10" maxlength="10"></td>
        <td><input name="SendTime" type="text" id="SendTime" size="10" maxlength="20"></td>
        <td><input name="Remark" type="text" id="Remark" size="20" maxlength="255"></td>
      </tr>
    </table>
      </td>
  </tr>
  <tr>
    <td rowspan="2">����Ҫ��</td>
    <td colspan="3"><textarea name="SpecialDemand" cols="80" rows="6" id="SpecialDemand"></textarea></td>
    </tr>
  <tr>
    <td colspan="3"><table width="100%" border="0" cellspacing="2" cellpadding="0">
      <tr>
        <td>�ϴ�ͼƬ��</td>
        <td><iframe style="top:2px" ID="UploadFiles" src="upload_OrderPic.asp" frameborder=0 scrolling=no width="450" height="25"></iframe></td>
      </tr>
     </table>
    </td>
  </tr>
  <tr align="center">
    <td height="40" colspan="4"><input name="Action" type="hidden" id="Action" value="SaveOrderForm">      <input type="submit" name="Submit" value=" �ύ���� ">
&nbsp;      <input type="reset" name="Submit2" value=" ������д "></td>
    </tr>
</table>
<table width="760" border="0" align="center" cellpadding="0" cellspacing="0" class="tdbg">
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
%>
</form>
</body>
</html>
<%
end if
if FoundErr=True then
	call WriteErrMsg()
end if
call CloseConn()

sub SaveOrderForm()
	dim OrderFormID,OrderFormNum,Company,ContactMan,Phone,Address,PostCode,SpecialDemand
	dim ProductName,Standard,Unit,Ammount,SendTime,Remark
	dim arrProductName,arrStandard,arrUnit,arrAmmount,arrSendTime,arrRemark
	dim sqlOrderForm,rsOrderForm,trs,i
	Company=trim(request.form("Company"))
	ContactMan=trim(request.form("ContactMan"))
	Phone=trim(request.form("Phone"))
	Address=trim(request.form("Address"))
	PostCode=trim(request.form("PostCode"))
	SpecialDemand=trim(request.form("SpecialDemand"))
	ProductName=trim(request.form("ProductName"))
	Standard=trim(request.form("Standard"))
	Unit=trim(request.form("Unit"))
	Ammount=trim(request.form("Ammount"))
	SendTime=trim(request.form("SendTime"))
	Remark=trim(request.form("Remark"))
	if Company="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>�����뵥λ����</li>"
	end if
	if ContactMan="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>��������ϵ������</li>"
	end if
	if Phone="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>��������ϵ�绰</li>"
	end if
	if ProductName="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>����������һ���Ʒ�Ĳ�Ʒ����</li>"
	end if
	if Standard="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>����������һ���Ʒ�Ĺ���ͺ�</li>"
	end if
	if Unit="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>����������һ���Ʒ�ĵ�λ</li>"
	end if
	if Ammount="" then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>����������һ���Ʒ�Ķ�������</li>"
	end if
	
	if FoundErr=True then
		exit sub
	end if

	arrProductName=split(ProductName,",")
	arrStandard=split(Standard,",")
	arrUnit=split(Unit,",")
	arrAmmount=split(Ammount,",")
	arrSendTime=split(SendTime,",")
	arrRemark=split(Remark,",")

'	response.write ProductName & "<br>"
'	response.write Standard & "<br>"
'	response.write Unit & "<br>"
'	response.write Ammount & "<br>"
'	response.write SendTime & "<br>"
'	response.write Remark & "<br>"
'	exit sub
	
	
	set trs=conn.execute("select max(OrderFormNum) from OrderForm where datediff('d',AddTime,now())=0")
	if trs.bof and trs.eof then
		OrderFormNum=year(now)&right("0"&month(now),2)&right("0"&day(now),2) & "001"
	else
		if IsNull(trs(0)) then
			OrderFormNum=year(now)&right("0"&month(now),2)&right("0"&day(now),2) & "001"
		else
			OrderFormNum=trs(0)+1
		end if
	end if
	set trs=nothing
		
	sqlOrderForm="select top 1 * from OrderForm"
	set rsOrderForm=server.createobject("adodb.recordset")
	rsOrderForm.open sqlOrderForm,conn,1,3
	rsOrderForm.addnew
	rsOrderForm("OrderFormNum")=OrderFormNum
	rsOrderForm("Company")=Company
	rsOrderForm("ContactMan")=ContactMan
	rsOrderForm("Phone")=Phone
	rsOrderForm("Address")=Address
	rsOrderForm("PostCode")=PostCode
	rsOrderForm("SpecialDemand")=SpecialDemand
	rsOrderForm("AddTime")=now()
	rsOrderForm.update
	OrderFormID=rsOrderForm("OrderFormID")
	rsOrderForm.close
	
	sqlOrderForm="select top 1 * from OrderForm_Item"
	rsOrderForm.open sqlOrderForm,conn,1,3
	for i=0 to ubound(arrProductName)
		if trim(arrProductName(i))<>"" and trim(arrStandard(i))<>"" and trim(arrUnit(i))<>"" and isnumeric(trim(arrAmmount(i)))<>"" then
			rsOrderForm.addnew
			rsOrderForm("OrderFormID")=OrderFormID
			rsOrderForm("ProductName")=trim(arrProductName(i))
			rsOrderForm("Standard")=trim(arrStandard(i))
			rsOrderForm("Unit")=trim(arrUnit(i))
			rsOrderForm("Ammount")=Cdbl(trim(arrAmmount(i)))
			if trim(arrSendTime(i))<>"" then
				rsOrderForm("SendTime")=trim(arrSendTime(i))
			end if
			rsOrderForm("Remark")=trim(arrRemark(i))
			rsOrderForm.update
		end if
	next
	set rsOrderForm=nothing
	
	call WriteSuccessMsg("�����Ѿ����浽���ǵĶ������ݿ��С����ǽ��������ٶ�������ϵ��<br><br>���ס��Ķ����ţ�<b>" & OrderFormNum & "</b>")
end sub
%>