<!--#include file="Inc/syscode_Photo.asp"-->
<%
'����Ķ����������д���
const ChannelID=4
Const ShowRunTime="Yes"
MaxPerPage=20
SkinID=0
PageTitle="�鿴ͼƬ"
dim UrlID
UrlID=trim(request("UrlID"))
if UrlID="" then
	UrlID=1
else
	UrlID=Clng(UrlID)
end if
FoundErr=False
if rs("PhotoLevel")<=999 then
	if UserLogined<>True then
		FoundErr=True
		ErrMsg=ErrMsg & "�Բ��𣬱�ͼƬΪ�շ�ͼƬ��Ҫ�������Ǳ�վ��ע���û��������ͣ�<br>����ûע�����û�е�¼�����Բ������ͱ�ͼƬ����Ͻ� <a href='User_Reg.asp'><font color=red><b>ע��</b></font></a> �� <a href='User_Login.asp'><font color=red><b>��¼</a></font></a>�ɣ�"
	else
		if UserLevel>rs("PhotoLevel") then
			FoundErr=True
			ErrMsg=ErrMsg & "�Բ��𣬱�ͼƬΪ�շ�ͼƬ������ֻ�� <font color=blue>"
			if rs("PhotoLevel")=999 then
				ErrMsg=ErrMsg & "ע���û�"
			elseif rs("PhotoLevel")=99 then
				ErrMsg=ErrMsg & "�շ��û�"
			elseif rs("PhotoLevel")=9 then
				ErrMsg=ErrMsg & "VIP�û�"
			elseif rs("PhotoLevel")=5 then
				ErrMsg=ErrMsg & "����Ա"
			end if
			ErrMsg=ErrMsg & "������û�</font> �������͡���Ŀǰ��Ȩ�޼��𲻹������Բ������͡�"
		else
			if ChargeType=1 and rs("PhotoPoint")>0 then
				if Request.Cookies("asp163")("Pay_Photo" & PhotoID)<>"yes" then
					if UserPoint<rs("PhotoPoint") then
						FoundErr=True
						ErrMsg=ErrMsg &"�Բ��𣬱�ͼƬΪ�շ�ͼƬ���������ͱ�ͼƬ��Ҫ���� <b><font color=red>" & rs("PhotoPoint") & "</font></b> �㣡"
						ErrMsg=ErrMsg &"����Ŀǰֻ�� <b><font color=blue>" & UserPoint & "</font></b> ����á��������㣬�޷����ͱ�ͼƬ������������ϵ���г�ֵ��"
					else
						if lcase(trim(request("Pay")))="yes" then
							Conn_User.execute "update " & db_User_Table & " set " & db_User_UserPoint & "=" & db_User_UserPoint & "-" & rs("PhotoPoint") & " where " & db_User_Name & "='" & UserName & "'"
							response.Cookies("asp163")("Pay_Photo" & PhotoID)="yes"
						else
							FoundErr=True
							ErrMsg=ErrMsg & "<font color=red><b>ע��</b></font>�����ͱ�ͼƬ��Ҫ���� <font color=red><b>" & rs("PhotoPoint") & "</b></font>"
							ErrMsg=ErrMsg &"��Ŀǰ���� <b><font color=blue>" & UserPoint & "</font></b> ����á��Ķ����ĺ��㽫ʣ�� <b><font color=green>" & UserPoint-rs("PhotoPoint") & "</font></b> ��"
							ErrMsg=ErrMsg &"<br><br>��ȷʵԸ�⻨�� <b><font color=red>" & rs("PhotoPoint") & "</font></b> �������ͱ�ͼƬ��"
							ErrMsg=ErrMsg &"<br><br><a href='Photo_Viewer.asp?Pay=yes&UrlID=" & UrlID & "&PhotoID=" & PhotoID & "'>��Ը��</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href='index.asp'>�Ҳ�Ը��</a></p>"
						end if
					end if
				end if
			elseif ChargeType=2 then
				if ValidDays<=0 then
					FoundErr=True
					ErrMsg=ErrMsg & "<font color=red>�Բ��𣬱�ͼƬΪ�շ�ͼƬ����������Ч���Ѿ����ڣ������޷����ͱ�ͼƬ������������ϵ���г�ֵ��</font>"
				end if
			end if
		end if
	end if							
end if
if FoundErr<>True then
		rs("Hits")=rs("Hits")+1
		if datediff("D",rs("LastHitTime"),now())<=0 then
			rs("DayHits")=rs("DayHits")+1
		else
			rs("DayHits")=1
		end if
		if datediff("ww",rs("LastHitTime"),now())<=0 then
			rs("WeekHits")=rs("WeekHits")+1
		else
			rs("WeekHits")=1
		end if
		if datediff("m",rs("LastHitTime"),now())<=0 then
			rs("MonthHits")=rs("MonthHits")+1
		else
			rs("MonthHits")=1
		end if
		rs("LastHitTime")=now()
		rs.update
end if
%>
<html>
<head>
<title><%=PhotoTitle%></title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">

<!--#include file="inc/Skin_CSS.asp"-->
<%call MenuJS()%>
<script language=JavaScript>
function smallit(){            
	var height1=PhotoViewer.images1.height;            
	var width1=PhotoViewer.images1.width;            
	PhotoViewer.images1.height=height1/1.2;            
	PhotoViewer.images1.width=width1/1.2;           
}             
          
function bigit(){            
	var height1=PhotoViewer.images1.height;            
	var width1=PhotoViewer.images1.width;            
	PhotoViewer.images1.height=height1*1.2;          
	PhotoViewer.images1.width=width1*1.2;           
}             
function fullit()
{
	var width_s=screen.width-10;
	var height_s=screen.height-30;
	window.open("Photo_View.asp?UrlID=<%=UrlID%>&PhotoID=<%=PhotoID%>", "PhotoView", "width="+width_s+",height="+height_s+",left=0,top=0,location=no,toolbar=no,status=no,resizable=no,scrollbars=yes,menubar=no,directories=no");
}
function realsize()
{
	PhotoViewer.images1.height=PhotoViewer.images2.height;     
	PhotoViewer.images1.width=PhotoViewer.images2.width;
	PhotoViewer.block1.style.left = 0;
	PhotoViewer.block1.style.top = 0;
	
}
function featsize()
{
	var width1=PhotoViewer.images2.width;            
	var height1=PhotoViewer.images2.height;            
	var width2=760;            
	var height2=500;            
	var h=height1/height2;
	var w=width1/width2;
	if(height1<height2&&width1<width2)
	{
		PhotoViewer.images1.height=height1;            
		PhotoViewer.images1.width=width1;           
	}
	else
	{
		if(h>w)
		{
			PhotoViewer.images1.height=height2;          
			PhotoViewer.images1.width=width1*height2/height1;           
		}
		else
		{
			PhotoViewer.images1.width=width2;           
			PhotoViewer.images1.height=height1*width2/width1;          
		}
	}
	PhotoViewer.block1.style.left = 0;
	PhotoViewer.block1.style.top = 0;
}
</script>         
</head>
<body <%=Body_Label%> onmousemove='HideMenu()'>
<!--#include file="Top.asp"-->
<table width="760" border="0" align="center" cellpadding="0" cellspacing="0" class="border2">
  <tr>
    <td height="40" align="center"><strong><font size="4"><%= dvhtmlencode(rs("PhotoName")) %></font></strong></td>
  </tr>
  <tr class="tdbg_rightall">
    <td align="center"><table width="100%" border="0" cellspacing="3" cellpadding="0">
        <tr> 
          <td><div align="center">ͼƬ��С��<%= rs("PhotoSize") & " K" %></div></td>
          <td><div align="center">ͼƬ���ߣ� 
              <%
		if rs("Author")="" then
			response.write "����"
		else
			response.write dvhtmlencode(rs("Author")) 
		end if%>
            </div></td>
          <td><div align="center">����ʱ�䣺<%= rs("UpdateTime") %></div></td>
          <td><div align="center">�Ƽ��ȼ���<font color="#009900"><%= string(rs("Stars"),"��") %></font></div></td>
          <td>�鿴������<%=rs("Hits")%></td>
        </tr>
      </table></td>
  </tr>
  <%if rs("PhotoUrl2")<>"" or rs("PhotoUrl3")<>"" or rs("PhotoUrl3")<>"" then%>
  <tr>
    <td align="center" valign="middle" class="tdbg_leftall"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr align="center">
        <td><%
		if UrlID=1 then
			response.write "<font color=red>ͼƬ��ַһ</font>"
		else
			response.write "<a href='Photo_Viewer.asp?UrlID=1&PhotoID=" & rs("PhotoID") & "'>ͼƬ��ַһ" & "</a>"
		end if
		  %>
        </td>
		<%if rs("PhotoUrl2")<>"" then %>
        <td><%
		if UrlID=2 then
			response.write "<font color=red>ͼƬ��ַ��</font>"
		else
			response.write "<a href='Photo_Viewer.asp?UrlID=2&PhotoID=" & rs("PhotoID") & "'>ͼƬ��ַ��" & "</a>"
		end if
		  %>
        </td>
		<%
		end if
		if rs("PhotoUrl3")<>"" then %>
        <td><%
		if UrlID=3 then
			response.write "<font color=red>ͼƬ��ַ��</font>"
		else
			response.write "<a href='Photo_Viewer.asp?UrlID=3&PhotoID=" & rs("PhotoID") & "'>ͼƬ��ַ��" & "</a>"
		end if
		  %>
        </td>
		<%
		end if
		if rs("PhotoUrl4")<>"" then %>
        <td><%
		if UrlID=4 then
			response.write "<font color=red>ͼƬ��ַ��</font>"
		else
			response.write "<a href='Photo_Viewer.asp?UrlID=4&PhotoID=" & rs("PhotoID") & "'>ͼƬ��ַ��" & "</a>"
		end if
		  %>
        </td>
		<%end if%>
      </tr>
    </table></td>
  </tr>
  <%end if%>
  <tr>
    <td height="30" align="center" valign="middle" class="tdbg_leftall"><input name="smallit" type="button" id="smallit" onclick="smallit();" value="- ��С -">    
&nbsp;&nbsp;
<input name="bigit" type="button" id="bigit" onclick="bigit();" value="+ �Ŵ� +">              
          
&nbsp;
<input name="fullit" type="button" id="fullit" value="ȫ����ʾ" onClick="fullit();">
&nbsp;
<input name="realsize" type="button" id="realsize" value="ʵ�ʴ�С" onClick="realsize();">
&nbsp;
<input name="featsize" type="button" id="featsize" value="����ʴ�С" onClick="featsize();"></td>
  </tr>
  <tr> 
    <td height="500" align="center" valign="middle" class="tdbg_leftall"><%
	if FoundErr=True then
		response.write ErrMsg
	else
		response.write "<iframe id='PhotoViewer' width='99%' height='500' scrolling='no' src='Photo_View.asp?UrlID=" & UrlID & "&PhotoID=" & PhotoID &"'></iframe>"
	end if%></td>
  </tr>
  <tr>
    <td height="30" align="center" valign="middle" class="tdbg_leftall"><input name="smallit" type="button" id="smallit" onclick="smallit();" value="- ��С -">    
&nbsp;&nbsp;
<input name="bigit" type="button" id="bigit" onclick="bigit();" value="+ �Ŵ� +">              
          
&nbsp;
<input name="fullit" type="button" id="fullit" value="ȫ����ʾ" onClick="fullit();">
&nbsp;
<input name="realsize" type="button" id="realsize" value="ʵ�ʴ�С" onClick="realsize();">
&nbsp;
<input name="featsize" type="button" id="featsize" value="����ʴ�С" onClick="featsize();"></td>
  </tr>
</table>
<table width="760" border="0" align="center" cellpadding="0" cellspacing="0" class="topborder">
  <tr> 
    <td  height="13" align="center" valign="top"><table width="756" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
          <td height="13" Class="tdbg_left2"></td>
        </tr>
      </table></td>
  </tr>
</table>
<% call Bottom() %>
<% call PopAnnouceWindow(400,300) %>
</body>
</html>
<%
rs.close
set rs=nothing
call CloseConn()
%>