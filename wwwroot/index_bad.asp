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
<HEAD>
<TITLE><%=strPageTitle%></TITLE>
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<META 
content="<%=strPageTitle%>:��Դ��ѣ����¿죬��Դȫ���ṩ���ơ�˶ʿ�о����ĸ���˼�����οκ����˼�������ۿν�ѧ��Դ����Ŀ�У����۶�̬���������ġ�ʱ�����š�ѧ����Ʒ��" 
name=Keywords>
<META 
content="<%=strPageTitle%>:��Դ��ѣ����¿죬��Դȫ���ṩ���ơ�˶ʿ�о����ĸ���˼�����οκ����˼�������ۿν�ѧ��Դ����Ŀ�У����۶�̬���������ġ�ʱ�����š�ѧ����Ʒ��" 
name=Description>
</HEAD>
<body><table>


	<!--body���ж���--><div align="center">
    
    <!--	��һ�У����--><tr>
		
		<!--��һ�У���һ�񣬺��--><td>
			
			<img src="ImagesNew/TopBanner.jpg">

		</td><!--��һ�У���һ�񣬺��-->
	</tr><!--	��һ�У����-->
    <!--<br/>-->
 <!--<div align="left">-->
 <!--   �ڶ��в˵���������-->
 
 <tr >
   <td align="left" background="ImagesNew/IconSpaceHolder.bmp"> <a href="index.asp"> <img src="ImagesNew/HomePageIcon.jpg"></a>  </td>
   <td align="left" background="ImagesNew/IconSpaceHolder.bmp"> <a href="Article_Class2.asp?ClassID=2"> <img src="ImagesNew/LibraryIcon.jpg"></a>  </td>
    <td align="left"> <a href="Article_Class2.asp?ClassID=1"> <img src="ImagesNew/TheoryIcon.jpg"></a>  </td>
    <td align="left"> <a href="Article_Class2.asp?ClassID=3"> <img src="ImagesNew/News.jpg"></a>  </td>
    <td align="left"> <a href="Article_Class2.asp?ClassID=58"> <img src="ImagesNew/StudentArticleIcons.jpg"></a>  </td>
    
     <td align="left"> <a href="userlist.asp"> <img src="ImagesNew/PersonalArticles.jpg"></a>
    <td align="left"> <a href="guestbook.asp"> <img src="ImagesNew/GuestBookIcon.jpg"></a>
    <td  width="40" background="ImagesNew/IconSpaceHolder.bmp"></td>
    <td  background="ImagesNew/IconSpaceHolder.bmp"><% call ShowSearchForm("Article_Search.asp",1) %> </td>
    <td  width="20" background="ImagesNew/IconSpaceHolder.bmp"></td>
  </tr>  <!--   �ڶ��в˵���������-->
  <!--</div>-->
  <!--������--><tr >
  	<!--�����е�һ�� ��td-->
    <td  valign="top" align="left">
    <table ><!--�����е�һ�� ��table-->
  				<td  valign="top" align="left">
  					<fieldset><!--�û���¼��ʼ-->
            			<legend>�û���¼</legend>
            				<% call ShowUserLogin() %>
            
            		</fieldset><!--�û���¼����-->
  
  						</td>
                        
         <!--�����е�һ�� ��table--> </table></td><!--�����е�һ�� ��td-->              
  </tr><!--������-->
   
   
   
   
    </div><!--body���ж���-->
</table></body>
</html>