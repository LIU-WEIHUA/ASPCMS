<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<!--#include file="inc/syscode_article.asp"-->
<%

const ChannelID=1
Const ShowRunTime="Yes"
MaxPerPage=20
SkinID=0
PageTitle="��ҳ"
Set rsArticle= Server.CreateObject("ADODB.Recordset")
Set rsPic= Server.CreateObject("ADODB.Recordset")
%>

<html>
<head>
<TITLE><%=strPageTitle%></TITLE>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<LINK 
href="imags97/DefaultSkin.css" type=text/css rel=stylesheet>
<LINK 
href="SkinIndex/DefaultSkin.css" type=text/css rel=stylesheet>
<SCRIPT language=JavaScript src="SkinIndex/menu.js" 
type=text/JavaScript></SCRIPT>
<META content=o7FhrjMKBn/3XGgcDXmGdE4BkAxwd6a97bpMEXpOURY= name=verify-v1>
<META content="MSHTML 6.00.2900.3395" name=GENERATOR>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<!--#include file="inc/Skin_CSS.asp"-->
<%call MenuJS()%>
</head>
<body bgcolor="#FFFFFF"  style="BACKGROUND-COLOR: #ffffff"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<!-- ImageReady Slices (��ҳ_slice2.psd) -->
<div align="center" ><table id="__01" width="989"  border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
	<tr>
		<td colspan="2">
			<img   src="images/��ҳ_slice2_03.jpg" width="989" height="140" alt=""></td>
	</tr>
	<tr>
       <td background="images/��ҳ_slice_05.jpg" width="84%" height="25">&nbsp;&nbsp;<a href="index.asp">��&nbsp;&nbsp;&nbsp;&nbsp;ҳ</a>&nbsp;&nbsp;<font color="#FFFFFF">��</font>&nbsp;&nbsp;<a href="Article_Class2.asp?ClassID=2">��������</a>&nbsp;&nbsp;<font color="#FFFFFF">��</font>&nbsp;&nbsp;<a href="Article_Class2.asp?ClassID=1">���۶�̬</a>&nbsp;&nbsp;<font color="#FFFFFF">��</font>&nbsp;&nbsp;<a href="Article_Class2.asp?ClassID=3">ʱ������</a>&nbsp;&nbsp;<font color="#FFFFFF">��</font>&nbsp;&nbsp;<a href="Article_Class2.asp?ClassID=58">ѧ����Ʒ</a>&nbsp;&nbsp;<font color="#FFFFFF">��</font>&nbsp;&nbsp;<a href="userlist.asp">��&nbsp;&nbsp;&nbsp;&nbsp;��</a>&nbsp;&nbsp;<font color="#FFFFFF">��</font>&nbsp;&nbsp;<a href="guestbook.asp">��&nbsp;&nbsp;&nbsp;&nbsp;��</a></td><td background="images/��ҳ_slice_05.jpg"  align="left"><% call ShowSearchForm("Article_Search.asp",1) %></td>
		<td colspan="2"><img src="images/�ָ���.gif" width="1" height="25" alt=""></td>
	</tr>
    </table><!--top--></div>
   <div align="center"><!--main body--><table  bgcolor="#FFFFFF" width="989">
    <tr><!--main body-->
    <td  align="left" valign="top"><!--left column user login-->
    	<table>
    	<tr><!--user login-->
        	<td>
            	<fieldset><legend>�û���¼</legend><% call ShowUserLogin() %></fieldset>
                </td>
        </tr>
        <tr><!--lessons-->
        	<td>
            	<table width="215">
			<tr><td background="images/��ҳ_slice2_15_top.jpg" height="57" width="150">
            <!--<img src="images/��ҳ_slice2_15.jpg" width="210" height="127" alt="">-->&nbsp;<strong>�γ��б�</strong></td></tr>
            <tr><td background="images/��ҳ_slice2_15_middle.jpg">   <% call ShowSpecial(10) %>
            </td></tr>
            <!--<tr><td background="images/��ҳ_slice2_15_bottom2.jpg"  width="150">&nbsp; </td></tr>-->
            </table>
            </td>
        </tr>
        
        <tr><!--board--><td>
        <table width="215">
        <tr ><td background="Images/��ҳ_slice2_29_top.jpg" width="215"  height="44">&nbsp;<strong>���԰�</strong></td></tr>
        <tr><td background="Images/��ҳ_slice2_29_middle.jpg" width="215">
        <% call showGuest(20,10) %>
        </td></tr>
			<tr><td  background="Images/��ҳ_slice2_29_bottom.jpg" width="215" height="48">
        
        </td></tr>
        
        
        </table>
        
        </td></tr>
        
    	</table>
    </td>
    <td valign="top"  align="center"><!--right column articles-->
    	<table>
    		<tr><td align="center">
            	<table width="529" height="180"><!--��������-->
                <tr valign="middle">  
    				<td valign="middle" width="540" height="30" background="Images/��ҳ_slice2_08_2.jpg">
           <font face="����"><strong>&nbsp;��������</strong></font>
            </td>
   			  </tr>
              <tr><td valign="top">
              <% call Showhot(8,16) %>
              </td></tr></table>
              </td>
             <td  valign="top"  align="center">
             	<table> <!--����-->
       			   	  <tr><td background="Images/��ҳ_slice2_111.jpg"   width="210"  height="180">
       		 	  	   <%call ShowAnnounce(1,1)%>
     		   	 	    </td></tr>
             
             	</table></td>
              </tr>
    		<tr><!--����Ŀ-->
            <td  colspan="10">  
            	<table>
					<tr valign="middle">
                    <td valign="middle" width="275" height="15" background="images/��ҳ_slice2_200.jpg">&nbsp;&nbsp;<font face="����"><strong>��������</strong></font></td><td width="100" align="center" background="images/��ҳ_slice2_200.jpg"><a href='Article_Class2.asp?ClassID=2'>����&nbsp;>></a>&nbsp;&nbsp;</td>
                    <td valign="middle" width="275" height="15" background="images/��ҳ_slice2_200.jpg">&nbsp;&nbsp;<font face="����"><strong>ʱ������</strong></font></td><td width="100"  align="center" background="images/��ҳ_slice2_200.jpg"><a href='Article_Class2.asp?ClassID=3'>����&nbsp;>></a>&nbsp;&nbsp;</td>
                    </tr>    
                      <!--����-->     
                      <tr height="90" valign="top">
                      <td colspan="2"><%  call ShowArticle_Index(36,2,-1,4) %></td>
                      <td colspan="2"><%  call ShowArticle_Index(36,3,-1,4) %></td>
              		  </tr> 
            		<!--����-->
                    <tr>
                    <td width="275" height="15" background="images/��ҳ_slice2_200.jpg">&nbsp;&nbsp;<font face="����"><strong>���۶�̬</strong></font></td><td width="100" align="center" background="images/��ҳ_slice2_200.jpg"><a href='Article_Class2.asp?ClassID=1'>����&nbsp;>></a>&nbsp;&nbsp;</td>
		            <td width="275" height="15" background="images/��ҳ_slice2_200.jpg">&nbsp;&nbsp;<font face="����"><strong>ѧ����Ʒ</strong></font></td><td width="100" align="center" background="images/��ҳ_slice2_200.jpg"><a href='Article_Class2.asp?ClassID=58'>����&nbsp;>></a>&nbsp;&nbsp;</td>
                    
                    </tr>
                    <tr height="90" valign="top"><!--����-->
                  <td colspan="2"><%  call ShowArticle_Index(36,1,-1,4) %></td>
                  <td colspan="2"><%  call ShowArticle_Index(36,58,-1,4) %></td>
                    </tr>
            	</table>
            
            </td>
            </tr>
    
   		  </table>
    
    </td>
    </tr>
	
	
	
	
	
	
	
	
	
	</table><!--main body--></div>
<div align="center">	<table bgcolor="#FFFFFF" width="989">
	<tr>
		<td colspan="12" width="989" height="50" background="images/��ҳ_slice2_35.jpg">
            <P align=center><B>| <SPAN style="CURSOR: hand" 
      onclick="var strHref=window.location.href;this.style.behavior='url(#default#homepage)';this.setHomePage('http://renwen.university.edu.cn');">��Ϊ��ҳ</SPAN> | <SPAN title='���ν�ѧ��' style="CURSOR: hand" 
      onclick="window.external.addFavorite('http://renwen.university.edu.cn','���ν�ѧ��')">�ղر�վ</SPAN> | <A  href="mailto:86277298@QQ.COM">��ϵվ��</A> | <A  
      href="http://renwen.university.edu.cn/FriendSite/Index.asp" target=_blank>��������</A> | <A  href="http://renwen.university.edu.cn/Copyright.asp" 
      target=_blank>��Ȩ����</A> | </B><br>
      ����վ��<font color="#3300FF"><a href="http://renwen.university.edu.cn/">university��������ѧѧԺ</a></font>���졢ά��</P>
            </td>
	</tr>
</table></div>
<!-- End ImageReady Slices -->
</body>
</html>