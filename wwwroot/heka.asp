<!--#include file="inc/syscode_article.asp"-->
<%
'����Ķ����������д���
const ChannelID=1
Const ShowRunTime="Yes"
MaxPerPage=20
SkinID=0
PageTitle="�ؿ�"
Set rsArticle= Server.CreateObject("ADODB.Recordset")
Set rsPic= Server.CreateObject("ADODB.Recordset")
%>
<html>
<head>
<title>�ؿ�</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<!--#include file="inc/Skin_CSS.asp"-->
<%call MenuJS()%>
</head>
<body <%=Body_Label%> onmousemove='HideMenu()'>
<div id=menuDiv style='Z-INDEX: 1000; VISIBILITY: hidden; WIDTH: 1px; POSITION: absolute; HEIGHT: 1px; BACKGROUND-COLOR: #9cc5f8'></div>
<table width="760" border="0" align="center" cellpadding="0" cellspacing="0" class="tdbg">
  <tr> 
    <td> <table width="100%" align="center" cellpadding="0" cellspacing="0">
        <tr><td height="4"></td></tr><tr> 
          <td> <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr> 
                <td width="180"> <% call ShowLogo() %> </td>
                <td width="500"> 
                  <div align="center"> 
                    <% call ShowBanner() %>
                  </div></td>
                <td width="80" valign="middle">
<table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%" align="center">
                    <tr valign="middle"> 
                      <td align="center"><img src="Images/home.gif" align="absmiddle" width="16" height="16"></td>
                      <td align="center"><a href="#" onClick="this.style.behavior='url(#default#homepage)';this.setHomePage('<%=SiteUrl%>')">��Ϊ��ҳ</a></td>
                    </tr>
                    <tr valign="middle"> 
                      <td align="center"><img src="Images/email.gif" align="absmiddle" width="16" height="17"></td>
                      <td align="center"><a href="mailto:<%=WebmasterEmail%>">��ϵվ��</a></td>
                    </tr>
                    <tr valign="middle"> 
                      <td align="center"><img src="Images/bookmark.gif" align="absmiddle" width="16" height="16"></td>
                      <td align="center"><a href="javascript:window.external.addFavorite('<%=SiteUrl%>','<%=SiteName%>')">�����ղ�</a></td>
                    </tr>
                  </table></td>
              </tr>
            </table></td>
        </tr>
      </table></td>
  </tr>
  <tr valign="middle" class="nav_top"> 
    <td valign="middle"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td>��</td>
          <td width="600" class="title_maintxt"> 
            <%
	if ShowSiteChannel="Yes" then
		response.write strChannel
	else
		response.write "&nbsp;"
	end if
    	if ShowMyStyle="Yes" then
		response.write "<a href='#' onMouseOver='ShowMenu(menu_skin,100)'>��ѡ���&nbsp;</a>|"
	end if
	%>
          </td>
        </tr>
      </table></td>
  </tr>
  
<!--webbot bot="PurpleText" PREVIEW="��͸��flash��nav_main" -->  

<TR> 
      <TD width="100%"  valign="top" Class="nav_main"> <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0" width="760" height="137">
          <param name="movie" value="images/flash/shu6.swf">
          <param name="quality" value="high">
          <param name="wmode" value="transparent">
          <embed src="images/flash/shu6.swf";; quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer";;;; type="application/x-shockwave-flash" width="760" height="137"></embed></object></TD>
                </TR>

<!--webbot bot="PurpleText" PREVIEW="��͸��flash��nav_main" -->  
  

  <tr> 
    <td class="nav_bottom"></td>
  </tr></table>
<table width="760" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" class="txt_css">
  <tr valign="middle"> 
    <td width=46> <div align="right"><img src="Images/arrow3.gif" width="29" height="11" align="absmiddle"> 
      </div></td>
    <td width="596"> 
      �����ڵ�λ�ã�&nbsp;<A href="index.asp">��ҳ</A>&nbsp;&gt;&gt;&nbsp;<A 
href="heka.asp">�ؿ�</A> 
      ��</td>
    <td width="118"><font color="#CC0000">POWER</font> WEB <font color="#CC0000">
    &copy;</font></td>
  </tr>
</table>
<table width="760" border="0" align="center" cellpadding="0" cellspacing="0" class="tdbg">
  <tr valign="middle"> 
    <td width=95><div align="center"><strong><img src="Images/announce.gif" width="20" height="16" align="absmiddle">&nbsp;<font color="#FF0000">���¹���</font></strong> 
      </div></td>
    <td width=507><div align="right"> 
        <MARQUEE scrollAmount=1 scrollDelay=4 width=500
            align="left" onmouseover="this.stop()" onmouseout="this.start()">
        <% call ShowAnnounce(2,5) %>
        </MARQUEE></MARQUEE></MARQUEE></MARQUEE></MARQUEE></MARQUEE></MARQUEE></MARQUEE></MARQUEE></MARQUEE>
      </div></td>
    <td width=158 align=right> <script language="JavaScript" type="text/JavaScript">
var day="";
var month="";
var ampm="";
var ampmhour="";
var myweekday="";
var year="";
mydate=new Date();
myweekday=mydate.getDay();
mymonth=mydate.getMonth()+1;
myday= mydate.getDate();
myyear= mydate.getYear();
year=(myyear > 200) ? myyear : 1900 + myyear;
if(myweekday == 0)
weekday=" ������ ";
else if(myweekday == 1)
weekday=" ����һ ";
else if(myweekday == 2)
weekday=" ���ڶ� ";
else if(myweekday == 3)
weekday=" ������ ";
else if(myweekday == 4)
weekday=" ������ ";
else if(myweekday == 5)
weekday=" ������ ";
else if(myweekday == 6)
weekday=" ������ ";
document.write(year+"��"+mymonth+"��"+myday+"�� "+weekday);
    </script> ��</td>
  </tr>
</table>
<table width="760" border="0" align="center" cellpadding="0" cellspacing="0" class="tdbg">
  <tr>
   <table cellpadding=3 cellspacing=1 align=center class=tableborder1><tr><td valign=middle class=tablebody1 height=100><CENTER>
   
<table height=5 cellspacing=0 cellpadding=0 width=491 border=0>
  <tbody> 
  <tr> 
    <td> 
     <iframe frameborder=0 width=760 height=880 leftmargin=0 scrolling=no src=http://card3.silversand.net/diy/gen/img1.html topmargin=0></iframe>
    </td>
  </tr>
  </tbody>
</table>
</CENTER></td></tr></table>
                         
  </tr>                         
</table>                         
<% call Bottom() %>                         
<% call PopAnnouceWindow(400,300) %>                         
<% call ShowAD(0) %>                         
<% call ShowAD(4) %>                         
<% call ShowAD(5) %>                         
</body>                         
</html>                         
<%                         
call CloseConn()           
              
'=================================================
'��������ShowNewSoft
'��  �ã���ʾ���¸���
'��  ����SoftNum  ----�����ʾ���ٸ����
'        TitleLen   ----��������ַ�����һ������=����Ӣ���ַ�
'=================================================
sub ShowNewSoft(SoftNum,TitleLen)
	dim sqlNew,rsNew
	if SoftNum>0 and SoftNum<=100 then
		sqlNew="select top " & SoftNum
	else
		sqlNew="select top 10 "
	end if
	sqlNew=sqlNew & " S.SoftID,S.SoftName,S.SoftVersion,S.Author,S.Keyword,S.UpdateTime,S.Editor,S.Hits,S.DayHits,S.WeekHits,S.MonthHits,S.SoftSize,S.SoftLevel,S.SoftPoint from Soft S where S.Deleted=False and S.Passed=True "
	sqlNew=sqlNew & " order by S.SoftID desc"
	Set rsNew= Server.CreateObject("ADODB.Recordset")
	rsNew.open sqlNew,conn,1,1
	if TitleLen<0 or TitleLen>255 then TitleLen=100
	if rsNew.bof and rsNew.eof then 
		response.write "<li>û������</li>" 
	else 
		do while not rsNew.eof   
			response.Write "<li><a href='Soft_Show.asp?SoftID=" & rsNew("Softid") & "' title='������ƣ�" & rsNew("SoftName") & vbcrlf & "����汾��" & rsNew("SoftVersion") & vbcrlf & "�ļ���С��" & rsNew("SoftSize") & " K" & vbcrlf & "��    �ߣ�" & rsNew("Author") & vbcrlf & "����ʱ�䣺" & rsNew("UpdateTime") & vbcrlf & "���ش���������:" & rsNew("DayHits") & " ����:" & rsNew("WeekHits") & " ����:" & rsNew("MonthHits") & " �ܼ�:" & rsNew("Hits") & "' target='_blank'>" & gotTopic(rsNew("SoftName") & " " & rsNew("SoftVersion"),TitleLen) & "</li><br>"
        	rsNew.movenext     
		loop
	end if  
	rsNew.close
	set rsNew=nothing
end sub

'=================================================
'��������ShowNewPhoto
'��  �ã���ʾ������µ�ͼƬ
'��  ����PhotoNum  ----�����ʾ���ٸ�ͼƬ
'        ShowTitle  ----�Ƿ���ʾͼƬ���ƣ�TrueΪ��ʾ��FalseΪ����ʾ
'        TitleLen   ----��������ַ�����һ������=����Ӣ���ַ�
'=================================================
sub ShowNewPhoto(PhotoNum,ShowTitle,TitleLen)
	dim sqlNew,rsNew,i
	if PhotoNum>0 and PhotoNum<=100 then
		sqlNew="select top " & PhotoNum
	else
		sqlNew="select top 10 "
	end if
	sqlNew=sqlNew & " P.PhotoID,P.PhotoName,P.PhotoUrl_Thumb,P.Author,P.Keyword,P.UpdateTime,P.Editor,P.Hits,P.DayHits,P.WeekHits,P.MonthHits,P.PhotoSize,P.PhotoLevel,P.PhotoPoint from Photo P where P.Deleted=False and P.Passed=True "
	sqlNew=sqlNew & " order by P.PhotoID desc"
	Set rsNew= Server.CreateObject("ADODB.Recordset")
	rsNew.open sqlNew,conn,1,1
	if TitleLen<0 or TitleLen>255 then TitleLen=100
	response.write "<table border='0' cellpadding='0' cellspacing='5'><tr>"
	if rsNew.bof and rsNew.eof then 
		response.write "<td width='135' align='center'>û��ͼƬ</td>" 
	else 
		i=1
		do while not rsNew.eof   
			if i mod 6=0 then
				resposne.write "</tr><tr>"
			end if
			response.Write "<td align='center' width='135'>"
			response.write "<table border='0' cellspacing='0' cellpadding='0' align='center'><tr><td height='10'><img src='Images/bg_0ltop.gif' width='10' height='10'></td>"
			response.write "<td height='10' background='Images/bg_01.gif'></td>"
			response.write "<td height='10'><img src='Images/bg_0rtop.gif' width='10' height='10'></td></tr><tr>" 
			response.write "<td width=10 background=Images/bg_03.gif>&nbsp;</td>"
			response.write "<td align='center' valign='middle' bgcolor='#FFFFFF'>"
			response.write "<a href='Photo_Show.asp?PhotoID=" & rsNew("Photoid") & "' title='ͼƬ���ƣ�" & rsNew("PhotoName") & vbcrlf & "ͼƬ��С��" & rsNew("PhotoSize") & vbcrlf & "��    �ߣ�" & rsNew("Author") & vbcrlf & "����ʱ�䣺" & rsNew("UpdateTime") & vbcrlf & "���ش���������:" & rsNew("DayHits") & " ����:" & rsNew("WeekHits") & " ����:" & rsNew("MonthHits") & " �ܼ�:" & rsNew("Hits") & "' target='_blank'><img width='105' height='90' border='0' src='" & rsNew("PhotoUrl_Thumb") & "'></a>"
			response.write "</td><td width='10' background='Images/bg_04.gif'>&nbsp;</td></tr>"
			response.write "<tr><td height='10'><img src='Images/bg_0lbottom.gif' width='10' height='10'></td>"
			response.write "<td height='10' background='Images/bg_02.gif'></td>"
			response.write "<td height='10'><img src='Images/bg_0rbottom.gif' width='10' height='10'></td></tr></table>"
			if ShowTitle=True then
				response.write "<a href='Photo_Show.asp?PhotoID=" & rsNew("Photoid") & "' title='ͼƬ���ƣ�" & rsNew("PhotoName") & vbcrlf & "ͼƬ��С��" & rsNew("PhotoSize") & vbcrlf & "��    �ߣ�" & rsNew("Author") & vbcrlf & "����ʱ�䣺" & rsNew("UpdateTime") & vbcrlf & "���ش���������:" & rsNew("DayHits") & " ����:" & rsNew("WeekHits") & " ����:" & rsNew("MonthHits") & " �ܼ�:" & rsNew("Hits") & "' target='_blank'>" & gotTopic(rsNew("PhotoName"),TitleLen) & "</a>"
			end if
			response.write "</td>"
			i=i+1
        	rsNew.movenext     
		loop
	end if
	response.write "</tr></table>" 
	rsNew.close
	set rsNew=nothing
end sub

'=================================================
'��������ShowClassNavigation
'��  �ã���ʾ��Ŀ����
'��  ������
'=================================================
sub ShowSiteNavigation(TableName)
	dim rsNavigation,sqlNavigation,strNavigation,PrevRootID,i
	sqlNavigation="select C.ClassID,C.ClassName,C.Depth,L.LayoutFileName,C.RootID,C.LinkUrl,C.Child From " & TableName & " C"
	sqlNavigation= sqlNavigation & " inner join Layout L on C.LayoutID=L.LayoutID where C.Depth<=1 order by C.RootID,C.OrderID"
	Set rsNavigation= Server.CreateObject("ADODB.Recordset")
	rsNavigation.open sqlNavigation,conn,1,1
	if rsNavigation.bof and rsNavigation.eof then
		response.write "û���κ���Ŀ"
	else
		strNavigation="<table border='0' cellpadding='0' cellspacing='2' width='100%'><tr><td valign='top' nowrap>��<a href='" & rsNavigation(3) & "?ClassID=" & rsNavigation(0) & "'>" & rsNavigation(1) & "</a>��</td><td>"
		PrevRootID=rsNavigation(4)
		rsNavigation.movenext
		i=1
		do while not rsNavigation.eof
			if PrevRootID=rsNavigation(4) then
				if i mod 6=0 then
					strNavigation=strNavigation & ""
				end if
				strNavigation=strNavigation & "<a href='" & rsNavigation(3) & "?ClassID=" & rsNavigation(0) & "'>" & rsNavigation(1) & "</a>&nbsp;&nbsp;"
				i=i+1
			else
				strNavigation=strNavigation & "</td></tr><tr><td valign='top' nowrap>��<a href='" & rsNavigation(3) & "?ClassID=" & rsNavigation(0) & "'>" & rsNavigation(1) & "</a>��</td><td>"
				i=1
			end if
			PrevRootID=rsNavigation(4)
			rsNavigation.movenext
		loop
		strNavigation=strNavigation & "</td></tr></table>"
		response.write strNavigation
	end if
	rsNavigation.close
	set rsNavigation=nothing
end sub

'=================================================
'��������ShowSiteCountAll
'��  �ã���ʾվ��ͳ����Ϣ
'��  ������
'=================================================
sub ShowSiteCountAll()
	dim sqlCount,rsCount
	Set rsCount= Server.CreateObject("ADODB.Recordset")

	sqlCount="select count(ArticleID) from Article where Deleted=False"
	rsCount.open sqlCount,conn,1,1
	response.write "����������" & rsCount(0) & "ƪ<br>"
	rsCount.close

	sqlCount="select count(SoftID) from Soft where Deleted=False"
	rsCount.open sqlCount,conn,1,1
	response.write "����������" & rsCount(0) & "��<br>"
	rsCount.close
	
	sqlCount="select count(PhotoID) from Photo where Deleted=False"
	rsCount.open sqlCount,conn,1,1
	response.write "ͼƬ������" & rsCount(0) & "��<br>"
	rsCount.close
	
	'sqlCount="select sum(Hits) from article"
	'rsCount.open sqlCount,conn,1,1
	'response.write "�����Ķ���" & rsCount(0) & "�˴�<br>"
	'rsCount.close
	
	'sqlCount="select sum(Hits) from Soft"
	'rsCount.open sqlCount,conn,1,1
	'response.write "�ļ����أ�" & rsCount(0) & "�˴�<br>"
	'rsCount.close

	'sqlCount="select sum(Hits) from Photo"
	'rsCount.open sqlCount,conn,1,1
	'response.write "ͼƬ�鿴��" & rsCount(0) & "�˴�<br>"
	'rsCount.close

	sqlCount="select count(UserID) from " & db_User_Table
	rsCount.open sqlCount,Conn_User,1,1
	response.write "ע���û���" & rsCount(0) & "��<br>"
	rsCount.close
	
	set rsCount=nothing
	
	response.write "<script src='count/mystat.asp?style=all'></script>"
end sub

%>