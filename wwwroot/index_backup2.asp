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
<HTML  xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE><%=strPageTitle%></TITLE>
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<LINK 
href="imags97/DefaultSkin.css" type=text/css rel=stylesheet>
<LINK 
href="SkinIndex/DefaultSkin.css" type=text/css rel=stylesheet>
<SCRIPT language=JavaScript src="SkinIndex/menu.js" 
type=text/JavaScript></SCRIPT>
<META 
content="<%=strPageTitle%>:��Դ��ѣ����¿죬��Դȫ���ṩ���ơ�˶ʿ�о����ĸ���˼�����οκ����˼�������ۿν�ѧ��Դ����Ŀ�У����۶�̬���������ġ�ʱ�����š�ѧ����Ʒ��" 
name=Keywords>
<META 
content="<%=strPageTitle%>:��Դ��ѣ����¿죬��Դȫ���ṩ���ơ�˶ʿ�о����ĸ���˼�����οκ����˼�������ۿν�ѧ��Դ����Ŀ�У����۶�̬���������ġ�ʱ�����š�ѧ����Ʒ��" 
name=Description>
<META content=o7FhrjMKBn/3XGgcDXmGdE4BkAxwd6a97bpMEXpOURY= name=verify-v1>
<META content="MSHTML 6.00.2900.3395" name=GENERATOR>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<!--#include file="inc/Skin_CSS.asp"-->
<%call MenuJS()%>
</HEAD>
<BODY   style="BACKGROUND-IMAGE: url(SkinIndex/bg_all.gif)" bottomMargin=0 
leftMargin=0 background=SkinIndex/bg_all.gif topMargin=0 rightMargin=0 
marginheight="0" marginwidth="0" <%=Body_Label%> onmousemove='HideMenu()' >
<DIV align=center>
  <!--������-->
  <!--#include file="Top.asp"-->
</DIV>
<DIV align=center>
  <TABLE id=table7 height=80 cellSpacing=0 cellPadding=0 width=797 
background=SkinIndex/new_wow_43.jpg border=0>
    <TBODY>
      <TR>
        <TD width=8>��</TD>
        <TD align=middle width=781 bgColor=#ffffff height=80><SCRIPT language=javascript src="SkinIndex/1.js"></SCRIPT>
        </TD>
        <TD width=8>��</TD>
      </TR>
    </TBODY>
  </TABLE>
</DIV>
<DIV align=center>
  <TABLE id=table7 cellSpacing=0 cellPadding=0 width=797 
background=SkinIndex/new_wow_43.jpg border=0>
    <TBODY>
      <TR>
        <TD width=8 rowSpan=3>��</TD>
        <TD width=781 bgColor=#ffffff height=22><IMG height=21 
      src="SkinIndex/zin_r39_c2.gif" width=781 border=0></TD>
        <TD width=8 rowSpan=3></TD>
      </TR>
      <TR>
        <TD align=middle width=781 background=SkinIndex/zin_r42_c12.gif 
    bgColor=#ffffff height=6></TD>
      </TR>
      <TR>
        <TD width=781 bgColor=#ffffff height=22><IMG height=19 
      src="SkinIndex/zin_r41_c2.gif" width=781 
border=0></TD>
      </TR>
    </TBODY>
  </TABLE>
</DIV>
<DIV align=center>
  <TABLE id=table2 height=300 cellSpacing=0 cellPadding=0 width=797 
background=SkinIndex/new_wow_43.jpg border=0>
    <TBODY>
    
    <TR>
      <TD width=8 rowSpan=7>��</TD>
      <TD width=781 bgColor=#ffffff colSpan=2></TD>
      <TD width=8 rowSpan=7>��</TD>
    </TR>
    <TR>
      <TD align=right width=40 bgColor=#ffffff height=16><IMG height=31 
      src="SkinIndex/njyyjy_13.gif" width=38 border=0></TD>
      <TD width=741 background=SkinIndex/njyyjy_14.gif bgColor=#ffffff 
    height=16><TABLE id=table1 cellSpacing=0 cellPadding=0 width="100%" border=0>
          <TBODY>
            <TR>
              <TD align=middle>��</TD>
              <TD align=middle><B><A 
            href="http://www.zz6789.com/User/User_Article.asp?ChannelID=1&amp;Action=Add"><FONT 
            color=#0000ff>������µ����������ġ�</FONT></A></B></TD>
              <TD align=middle><B><A 
            href="http://www.zz6789.com/User/User_Article.asp?ChannelID=1001&amp;Action=Add"><FONT 
            color=#0000ff>������µ������пγ̡�</FONT></A></B></TD>
              <TD align=middle><B><A 
            href="http://www.zz6789.com/User/User_Soft.asp?ChannelID=2&amp;Action=Add"><FONT 
            color=#0000ff>��ӿμ������μ����ġ�</FONT></A></B></TD>
              <TD align=middle><B><A 
            href="http://www.zz6789.com/User/User_Photo.asp?ChannelID=3&amp;Action=Add"><FONT 
            color=#0000ff>���ͼƬ����ͼƬ���ġ�</FONT></A></B></TD>
              <TD align=middle>��</TD>
            </TR>
          </TBODY>
        </TABLE></TD>
    </TR>
    <TR>
      <TD width=781 bgColor=#ffffff colSpan=2 height=0></TD>
    </TR>
    <TR>
      <TD width=781 bgColor=#ffffff colSpan=2><TABLE id=table3 height=88 cellSpacing=0 cellPadding=0 width="100%" 
      border=0>
          <TBODY>
          
          <TR>
          
          <TD vAlign=top width=197><DIV align=center>
              <TABLE id=table4 cellSpacing=0 cellPadding=0 width=197 border=0>
                <TBODY>
                  <TR>
                    <TD align=middle><img height=45 
                  src="SkinIndex/zdl_6.gif" width=197 border=0 >��</TD>
                  </TR>
                  <TR>
                    <TD><IMG height=24 src="SkinIndex/zin_r11_c2.gif" 
                  width=197 border=0></TD>
                  </TR>
                  <TR>
                    <!---�û���¼---->
                    <TD align=middle background=SkinIndex/zin_r13_c2.gif 
                height=172><% call ShowUserLogin() %>
                      </TD>
                  </TR>
                  <TR>
                    <TD><IMG height=80 src="SkinIndex/zin_r16_c1.gif" 
                  width=197 border=0></TD>
                  </TR>
                </TBODY>
              </TABLE>
            </DIV>
            <TABLE id=table5 height=200 cellSpacing=0 cellPadding=0 width=197 
            border=0>
              <TBODY>
                <TR>
                
                
                  <TD align=middle background=SkinIndex/zdl_8.gif 
                  height=35><Strong>�� �� ��</Strong></TD>
                  </TR>
                  
                  <TR>
                    <TD height=24><IMG height=24 
                  src="SkinIndex/zin_r11_c1.gif" width=197 border=0></TD>
                  </TR>
                  <TR>
                    <TD vAlign=top align=middle 
                background=SkinIndex/zin_r13_c1.gif height=50><% call showGuest(20,10) %></TD>
                  </TR>
                  <TR>
                    <TD height=24><IMG height=25 
                  src="SkinIndex/zin_r18_c1.gif" width=197 
                border=0></TD>
                
              </TR>
              
              </TBODY>
              
            </TABLE></TD>
          <TD vAlign=top align=middle width=387><!-- ��VBSCRIPT�г���Ŀ�������±���,�����ݼ� -->
              <%
          	sqlShowClassArticleListName="select ClassID,ClassName from ArticleClass Order by ClassID"
	Set rsShowClassArticleListName=Server.CreateObject("Adodb.RecordSet")
	rsShowClassArticleListName.Open sqlShowClassArticleListName,conn,1,1

	If rsShowClassArticleListName.BOF and rsShowClassArticleListName.EOF then
	
	Response.Write("û���κο��г�����Ŀ�����������Ŀ��")
	
	Else
	
			do while not rsShowClassArticleListName.EOF
			'��ʼ�����
			Response.Write("<TABLE id=table6 cellSpacing=0 cellPadding=0 width=387 border=0> <TBODY> <TR>  <TD background=SkinIndex/zin_r46_c21.jpg  height=48><B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")
	
			Response.Write("<a href='Article_Class2.asp?ClassID="  & rsShowClassArticleListName("ClassID")  & "'>"  )
			Response.Write(rsShowClassArticleListName("ClassName"))
			Response.Write("</a>")
			
			
			Response.Write("</B></TD> </TR> <TR>  <TD background=SkinIndex/zin_r42_c21_r3.jpg height=93><DIV align=center>  <TABLE id=table12 height=27 cellSpacing=0 cellPadding=0  width='95%' border=0>  <TBODY>  <TR>") 
			Response.Write(" <!--���۶�̬��Ŀ�ڵ������б�-->   <TD><TABLE cellSpacing=0 cellPadding=0 width='100%'>  <TBODY>  <TR>")
			'��������񣬿�ʼ�г�����
			'ʹ��ԭ��վ��javascript�г�����
			
             ' <!--���뿪ʼ-->
            Response.Write("  <script language='JavaScript' type='text/JavaScript' src='article_js.asp?ClassID=" &  rsShowClassArticleListName("ClassID")  )
			 Response.Write("&IncludeChild=true&SpecialID=&ArticleNum=6&ShowType=1&ShowCols=1&ShowProperty=true&ShowClassName=false&ShowIncludePic=false&ShowTitle=true&ShowUpdateTime=false&ShowHits=false&ShowAuthor=true&ShowHot=false&ShowMore=false&TitleMaxLen=30&ContentMaxLen=200&Hot=false&Elite=false&DateNum=&OrderField=UpdateTime&OrderType=desc'>   </script>  ")
            '  <!--�������-->
              
			'�����б������°벿�ֱ��
			Response.Write("</TR> <TR></TR> </TBODY>  </TABLE></TD> </TR> </TBODY> </TABLE> </DIV></TD></TR>")
            Response.Write("<TR><TD><IMG height=20 src='SkinIndex/zin_r41_c21.jpg' width=387 border=0></TD> </TR> </TBODY> </TABLE>")
			'���������
			
			rsShowClassArticleListName.movenext
			loop
	End If	

          
          %>
              <TABLE id=table6 cellSpacing=0 cellPadding=0 width=387 border=0>
                <TBODY>
                  <TR>
                    <TD background=SkinIndex/zin_r46_c21.jpg 
                  height=48><B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;���۶�̬</B></TD>
                  </TR>
                  <TR>
                    <TD background=SkinIndex/zin_r42_c21_r3.jpg height=93><DIV align=center>
                        <TABLE id=table12 height=27 cellSpacing=0 cellPadding=0 
                  width="95%" border=0>
                          <TBODY>
                            <TR>
                              <!--���۶�̬��Ŀ�ڵ������б�-->
                              <TD><TABLE cellSpacing=0 cellPadding=0 width="100%">
                                  <TBODY>
                                    <TR>
                                      <!--���뿪ʼ-->
                                      <script language='JavaScript' type='text/JavaScript' src='article_js.asp?ClassID=1&IncludeChild=true&SpecialID=&ArticleNum=6&ShowType=1&ShowCols=1&ShowProperty=true&ShowClassName=false&ShowIncludePic=false&ShowTitle=true&ShowUpdateTime=false&ShowHits=false&ShowAuthor=true&ShowHot=false&ShowMore=false&TitleMaxLen=30&ContentMaxLen=200&Hot=false&Elite=false&DateNum=&OrderField=UpdateTime&OrderType=desc'></script>
                                      <!--�������-->
                                    </TR>
                                    <TR></TR>
                                  </TBODY>
                                </TABLE></TD>
                            </TR>
                          </TBODY>
                        </TABLE>
                      </DIV></TD>
                  </TR>
                  <TR>
                    <TD><IMG height=20 src="SkinIndex/zin_r41_c21.jpg" 
                  width=387 border=0></TD>
                  </TR>
                </TBODY>
              </TABLE>
              <%
              rsShowClassArticleListName.close
				set  rsShowClassArticleListName=nothing
              %>
              <!-- �����г���Ŀ�������±������,�ر����ݼ�-->
              <TABLE id=table6 cellSpacing=0 cellPadding=0 width=387 border=0>
                <TBODY>
                  <TR>
                    <TD background=SkinIndex/zin_r46_c21.jpg 
                  height=48><B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�Ƽ�����</B></TD>
                  </TR>
                  <TR>
                    <TD background=SkinIndex/zin_r42_c21_r3.jpg height=93><DIV align=center>
                        <TABLE id=table12 height=27 cellSpacing=0 cellPadding=0 
                  width="95%" border=0>
                          <TBODY>
                            <TR>
                              <!--�Ƽ�����-->
                              <TD><TABLE cellSpacing=0 cellPadding=0 width="100%">
                                  <TBODY>
                                    <TR>
                                      <TD class=listbg>[<A class=listA 
                              href="http://www.zz6789.com/Article/C/C3/Index.html">������</A>]<A 
                              class=listA title=�п�ָ�� 
                              href="http://www.zz6789.com/Article/C/C3/200808/Article_20080819203053.html" 
                              target=_blank>�п�ָ��</A></TD>
                                    </TR>
                                    <TR>
                                      <TD class=listbg2>[<A class=listA 
                              href="http://www.zz6789.com/Article/D/D5/Index.html">�߶���</A>]<A 
                              class=listA title=����ҵ����˰������ѧ���� 
                              href="http://www.zz6789.com/Article/D/D5/200808/Article_20080816091805.html" 
                              target=_blank>����ҵ����˰������ѧ����</A></TD>
                                    </TR>
                                    <TR>
                                      <TD class=listbg>[<A class=listA 
                              href="http://www.zz6789.com/Article/E/E8/Index.html">����߿���</A>]<A 
                              class=listA title=2008��߿����γ�ʶ������� 
                              href="http://www.zz6789.com/Article/E/E8/200808/Article_20080815091349.html" 
                              target=_blank>2008��߿����γ�ʶ�������</A></TD>
                                    </TR>
                                    <TR>
                                      <TD class=listbg2>[<A class=listA 
                              href="http://www.zz6789.com/Article/E/E8/Index.html">����߿���</A>]<A 
                              class=listA title=2008��߿���ѧ��ʶ������� 
                              href="http://www.zz6789.com/Article/E/E8/200808/Article_20080815091140.html" 
                              target=_blank>2008��߿���ѧ��ʶ�������</A></TD>
                                    </TR>
                                    <TR>
                                      <TD class=listbg>[<A class=listA 
                              href="http://www.zz6789.com/Article/E/E2/Index.html">�߿�����</A>]<A 
                              class=listA title=2008��߿����ó�ʶ������� 
                              href="http://www.zz6789.com/Article/E/E2/200808/Article_20080815090848.html" 
                              target=_blank>2008��߿����ó�ʶ�������</A></TD>
                                    </TR>
                                    <TR>
                                      <TD class=listbg2>[<A class=listA 
                              href="http://www.zz6789.com/Article/J/J7/Index.html">ʱ������</A>]<A 
                              class=listA title=2008��7��1��31��ʱ�£�����תժ�� 
                              href="http://www.zz6789.com/Article/J/J7/200808/Article_20080806171600.html" 
                              target=_blank>2008��7��1��31��ʱ�£�����תժ��</A></TD>
                                    </TR>
                                    <TR>
                                      <TD class=listbg>[<A class=listA 
                              href="http://www.zz6789.com/Article/J/J7/Index.html">ʱ������</A>]<A 
                              class=listA title=2008��7��ʱ������ 
                              href="http://www.zz6789.com/Article/J/J7/200808/Article_20080804083705.html" 
                              target=_blank>2008��7��ʱ������</A></TD>
                                    </TR>
                                    <TR>
                                      <TD class=listbg2>[<A class=listA 
                              href="http://www.zz6789.com/Article/E/E3/Index.html">��������</A>]<A 
                              class=listA title=��08��߿��Ŀ��ۺ�ȫ����09�����θ߿����� 
                              href="http://www.zz6789.com/Article/E/E3/200807/Article_20080725225113.html" 
                              target=_blank>��08��߿��Ŀ��ۺ�ȫ����09�����θ߿�����</A></TD>
                                    </TR>
                                    <TR>
                                      <TD class=listbg>[<A class=listA 
                              href="http://www.zz6789.com/Article/D/D3/Index.html">������</A>]<A 
                              class=listA title=������ѧʱ���ܽ� 
                              href="http://www.zz6789.com/Article/D/D3/200806/Article_20080627100627.html" 
                              target=_blank>������ѧʱ���ܽ�</A></TD>
                                    </TR>
                                    <TR></TR>
                                  </TBODY>
                                </TABLE></TD>
                            </TR>
                          </TBODY>
                        </TABLE>
                      </DIV></TD>
                  </TR>
                  <TR>
                    <TD><IMG height=20 src="SkinIndex/zin_r41_c21.jpg" 
                  width=387 border=0></TD>
                  </TR>
                </TBODY>
              </TABLE>
              <TABLE id=table6 cellSpacing=0 cellPadding=0 width=387 border=0>
                <TBODY>
                  <TR>
                    <TD background=SkinIndex/zin_r46_c21.jpg height=48><P align=left><B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                        �ȵ�����</B></P></TD>
                  </TR>
                  <TR>
                    <TD background=SkinIndex/zin_r42_c21_r3.jpg height=93><DIV align=center>
                        <TABLE id=table12 height=27 cellSpacing=0 cellPadding=0 
                  width="95%" border=0>
                          <TBODY>
                            <TR>
                              <!--�ȵ�����-->
                              <TD><TABLE cellSpacing=0 cellPadding=0 width="100%">
                                  <TBODY>
                                    <TR>
                                      <TD class=listbg>[<A class=listA 
                              href="http://www.zz6789.com/Article/k/k3/Index.html">��ʷ����</A>]<A 
                              class=listA title=������Ϊ�Ρ�����ϧ������ 
                              href="http://www.zz6789.com/Article/k/k3/200809/Article_20080908091703.html" 
                              target=_blank>������Ϊ�Ρ�����ϧ������</A></TD>
                                    </TR>
                                    <TR>
                                      <TD class=listbg2>[<A class=listA 
                              href="http://www.zz6789.com/Article/J/J7/Index.html">ʱ������</A>]<A 
                              class=listA title=2008��8��1��31��ʱ�� 
                              href="http://www.zz6789.com/Article/J/J7/200809/Article_20080906143043.html" 
                              target=_blank>2008��8��1��31��ʱ��</A></TD>
                                    </TR>
                                    <TR>
                                      <TD class=listbg>[<A class=listA 
                              href="http://www.zz6789.com/Article/H/H1/Index.html">��ѧ�ĵ�</A>]<A 
                              class=listA title=�ó���˼��Ʒ�¿ν�ѧ��� 
                              href="http://www.zz6789.com/Article/H/H1/200809/Article_20080905142959.html" 
                              target=_blank>�ó���˼��Ʒ�¿ν�ѧ���</A></TD>
                                    </TR>
                                    <TR>
                                      <TD class=listbg2>[<A class=listA 
                              href="http://www.zz6789.com/Article/C/C3/Index.html">������</A>]<A 
                              class=listA title=����ʡ�˺���ѧ���꼶��һ��Ԫ˼��Ʒ�²��� 
                              href="http://www.zz6789.com/Article/C/C3/200809/Article_20080905081954.html" 
                              target=_blank>����ʡ�˺���ѧ���꼶��һ��Ԫ˼��Ʒ�²���</A></TD>
                                    </TR>
                                    <TR>
                                      <TD class=listbg>[<A class=listA 
                              href="http://www.zz6789.com/Article/I/I2/Index.html">�¿α���ѵ</A>]<A 
                              class=listA title=���˿���ѧ��ѧģʽ���ҵĸ��� 
                              href="http://www.zz6789.com/Article/I/I2/200808/Article_20080823095759.html" 
                              target=_blank>���˿���ѧ��ѧģʽ���ҵĸ���</A></TD>
                                    </TR>
                                    <TR>
                                      <TD class=listbg2>[<A class=listA 
                              href="http://www.zz6789.com/Article/C/C3/Index.html">������</A>]<A 
                              class=listA title=�п�ָ�� 
                              href="http://www.zz6789.com/Article/C/C3/200808/Article_20080819203053.html" 
                              target=_blank>�п�ָ��</A></TD>
                                    </TR>
                                    <TR>
                                      <TD class=listbg>[<A class=listA 
                              href="http://www.zz6789.com/Article/G/G3/Index.html">��������̸</A>]<A 
                              class=listA title=�ͷ�ϸ��ů���� 
                              href="http://www.zz6789.com/Article/G/G3/200808/Article_20080819161621.html" 
                              target=_blank>�ͷ�ϸ��ů����</A></TD>
                                    </TR>
                                    <TR>
                                      <TD class=listbg2>[<A class=listA 
                              href="http://www.zz6789.com/Article/D/D5/Index.html">�߶���</A>]<A 
                              class=listA title=����ҵ����˰������ѧ���� 
                              href="http://www.zz6789.com/Article/D/D5/200808/Article_20080816091805.html" 
                              target=_blank>����ҵ����˰������ѧ����</A></TD>
                                    </TR>
                                    <TR>
                                      <TD class=listbg>[<A class=listA 
                              href="http://www.zz6789.com/Article/E/E8/Index.html">����߿���</A>]<A 
                              class=listA title=2008��߿����γ�ʶ������� 
                              href="http://www.zz6789.com/Article/E/E8/200808/Article_20080815091349.html" 
                              target=_blank>2008��߿����γ�ʶ�������</A></TD>
                                    </TR>
                                    <TR></TR>
                                  </TBODY>
                                </TABLE></TD>
                            </TR>
                          </TBODY>
                        </TABLE>
                      </DIV></TD>
                  </TR>
                  <TR>
                    <TD><IMG height=20 src="SkinIndex/zin_r41_c21.jpg" 
                  width=387 border=0></TD>
                  </TR>
                </TBODY>
              </TABLE></TD>
            <TD width=197><TABLE id=table5 height=200 cellSpacing=0 cellPadding=0 width=197 
            border=0>
                <TBODY>
                  <TR>
                    <TD background=SkinIndex/zdl_8.gif height=35><P align=center><B>�� �� �� ��</B></P></TD>
                  </TR>
                  <TR>
                    <TD height=24><IMG height=24 
                  src="SkinIndex/zin_r11_c1.gif" width=197 border=0></TD>
                  </TR>
                  <TR>
                    <TD align=middle background=SkinIndex/zin_r13_c1.gif><%call ShowAnnounce(1,1)%>
                    </TD>
                  </TR>
                  <TR>
                    <TD height=24><IMG height=25 
                  src="SkinIndex/zin_r18_c1.gif" width=197 
              border=0></TD>
                  </TR>
                </TBODY>
              </TABLE>
              <TABLE id=table5 height=200 cellSpacing=0 cellPadding=0 width=197 
            border=0>
                <TBODY>
                  <TR>
                    <TD background=SkinIndex/zdl_8.gif height=35><P align=center><B>�� �� �� �� ��</B></P></TD>
                  </TR>
                  <TR>
                    <TD height=24><IMG height=24 
                  src="SkinIndex/zin_r11_c1.gif" width=197 border=0></TD>
                  </TR>
                  <TR>
                    <TD align=middle background=SkinIndex/zin_r13_c1.gif><SPAN class=s1>
                        <% call ShowTopUser(5) %>
                        </SPAN>
                      <DIV align=right><A class=LinkTopUser 
                  href="http://www.zz6789.com/ShowUser.asp?Action=List&amp;ChannelID=0">more...</A>&nbsp;&nbsp;</DIV></TD>
                  </TR>
                  <TR>
                    <TD height=24><IMG height=25 
                  src="SkinIndex/zin_r18_c1.gif" width=197 
              border=0></TD>
                  </TR>
                </TBODY>
              </TABLE>
              <TABLE id=table5 height=100 cellSpacing=0 cellPadding=0 width=197 
            border=0>
                <TBODY>
                  <TR>
                    <TD background=SkinIndex/zdl_8.gif height=35><P align=center><B>Google �� �� </B></P></TD>
                  </TR>
                  <TR>
                    <TD height=24><IMG height=24 
                  src="SkinIndex/zin_r11_c1.gif" width=197 border=0></TD>
                  </TR>
                  <TR>
                    <TD background=SkinIndex/zin_r13_c1.gif><!-- Search Google -->
                      <CENTER>
                        <FORM action=http://www.google.cn/custom method=get 
                  target=google_window>
                          <TABLE bgColor=#fcfcf2>
                            <TBODY>
                              <TR>
                                <TD vAlign=top noWrap align=left height=32><A 
                        href="http://www.google.com/"><IMG alt=Google 
                        src="SkinIndex/Logo_25wht.gif" align=middle 
                        border=0></IMG></A> <BR>
                                  <LABEL style="DISPLAY: none" 
                        for=sbi>�������������ִ�</LABEL>
                                  <INPUT id=sbi maxLength=255 
                        size=25 name=q>
                                  </INPUT>
                                </TD>
                              </TR>
                              <TR>
                                <TD vAlign=top align=left><P align=center>
                                    <LABEL style="DISPLAY: none" 
                        for=sbb>�ύ������</LABEL>
                                    <INPUT id=sbb type=submit value=���� name=sa>
                                    </INPUT>
                                    <INPUT type=hidden value=pub-2209561258995469 
                        name=client>
                                    </INPUT>
                                    <INPUT type=hidden value=1 
                        name=forid>
                                    </INPUT>
                                    <INPUT type=hidden value=GB2312 
                        name=ie>
                                    </INPUT>
                                    <INPUT type=hidden value=GB2312 
                        name=oe>
                                    </INPUT>
                                    <INPUT type=hidden 
                        value=GALT:#008000;GL:1;DIV:#336699;VLC:663399;AH:center;BGC:FFFFFF;LBGC:336699;ALC:0000FF;LC:0000FF;T:000000;GFNT:0000FF;GIMP:0000FF;FORID:1 
                        name=cof>
                                    </INPUT>
                                    <INPUT type=hidden value=zh-CN 
                        name=hl>
                                    </INPUT>
                                  </P></TD>
                              </TR>
                            </TBODY>
                          </TABLE>
                        </FORM>
                      </CENTER>
                      <!-- Search Google --></TD>
                  </TR>
                  <TR>
                    <TD height=24><IMG height=25 
                  src="SkinIndex/zin_r18_c1.gif" width=197 
              border=0></TD>
                  </TR>
                </TBODY>
              </TABLE></TD>
          </TR></TBODY>
          
        </TABLE></TD>
    </TR>
    <TR>
      <TD width=781 bgColor=#ffffff colSpan=2 height=1></TD>
    </TR>
    </TBODY>
    
  </TABLE>
  <DIV align=center>
    <TABLE id=table7 cellSpacing=0 cellPadding=0 width=797 
background=SkinIndex/new_wow_43.jpg border=0>
      <TBODY>
        <TR>
          <TD width=8 rowSpan=3>��</TD>
          <TD width=781 bgColor=#ffffff height=22><IMG height=21 
      src="SkinIndex/zin_r39_c2.gif" width=781 border=0></TD>
          <TD width=8 rowSpan=3></TD>
        </TR>
        <TR>
          <TD align=middle width=781 background=SkinIndex/zin_r42_c12.gif 
    bgColor=#ffffff height=6></TD>
        </TR>
        <TR>
          <TD width=781 bgColor=#ffffff height=22><IMG height=19 
      src="SkinIndex/zin_r41_c2.gif" width=781 
border=0></TD>
        </TR>
      </TBODY>
    </TABLE>
  </DIV>
  <DIV align=center>
    <TABLE id=table7 height=100 cellSpacing=0 cellPadding=0 width=797 
background=SkinIndex/new_wow_43.jpg border=0>
      <TBODY>
        <TR>
          <TD width=8 rowSpan=2>��</TD>
          <TD width=391 bgColor=#ffffff><P align=center>
            <TABLE id=table6 cellSpacing=0 cellPadding=0 width=387 border=0>
              <TBODY>
                <TR>
                  <TD background=SkinIndex/zin_r46_c21.jpg height=48><P align=left><B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                      ʱ������</B></P></TD>
                </TR>
                <TR>
                  <TD background=SkinIndex/zin_r42_c21_r3.jpg height=93><DIV align=center>
                      <TABLE id=table12 height=27 cellSpacing=0 cellPadding=0 width="95%" 
            border=0>
                        <TBODY>
                          <TR>
                            <!--ʱ������-->
                            <TD><TABLE cellSpacing=0 cellPadding=0 width="100%">
                                <TBODY>
                                  <TR>
                                    <TD class=listbg>[<A class=listA 
                        href="http://www.zz6789.com/Article/J/J7/Index.html">ʱ������</A>]<A 
                        class=listA 
                        title="���±��⣺2008��8��1��31��ʱ��&#13;&#10;��&nbsp;&nbsp;&nbsp;&nbsp;�ߣ�������&#13;&#10;����ʱ�䣺2008-9-6 14:30:43" 
                        href="http://www.zz6789.com/Article/J/J7/200809/Article_20080906143043.html" 
                        target=_blank>2008��8��1��31��ʱ��</A></TD>
                                    <TD class=listbg align=right width=40><FONT 
                        color=red>09-06</FONT></TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg2>[<A class=listA 
                        href="http://www.zz6789.com/Article/J/J7/Index.html">ʱ������</A>]<A 
                        class=listA 
                        title="���±��⣺2008��7��1��31��ʱ�£�����תժ��&#13;&#10;��&nbsp;&nbsp;&nbsp;&nbsp;�ߣ�������&#13;&#10;����ʱ�䣺2008-8-6 17:16:00" 
                        href="http://www.zz6789.com/Article/J/J7/200808/Article_20080806171600.html" 
                        target=_blank>2008��7��1��31��ʱ�£�����תժ��</A></TD>
                                    <TD class=listbg2 align=right width=40>08-06</TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg>[<A class=listA 
                        href="http://www.zz6789.com/Article/J/J7/Index.html">ʱ������</A>]<A 
                        class=listA 
                        title="���±��⣺2008��7��ʱ������&#13;&#10;��&nbsp;&nbsp;&nbsp;&nbsp;�ߣ�fanyongxin&#13;&#10;����ʱ�䣺2008-8-4 8:37:05" 
                        href="http://www.zz6789.com/Article/J/J7/200808/Article_20080804083705.html" 
                        target=_blank>2008��7��ʱ������</A></TD>
                                    <TD class=listbg align=right width=40>08-04</TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg2>[<A class=listA 
                        href="http://www.zz6789.com/Article/J/J7/Index.html">ʱ������</A>]<A 
                        class=listA 
                        title="���±��⣺2008��7��1��15��ʱ�£�ԭ����&#13;&#10;��&nbsp;&nbsp;&nbsp;&nbsp;�ߣ�������&#13;&#10;����ʱ�䣺2008-7-16 21:48:41" 
                        href="http://www.zz6789.com/Article/J/J7/200807/Article_20080716214841.html" 
                        target=_blank>2008��7��1��15��ʱ�£�ԭ����</A></TD>
                                    <TD class=listbg2 align=right width=40>07-16</TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg>[<A class=listA 
                        href="http://www.zz6789.com/Article/J/J7/Index.html">ʱ������</A>]<A 
                        class=listA 
                        title="���±��⣺2008��6��16��30��ʱ�£�ԭ����&#13;&#10;��&nbsp;&nbsp;&nbsp;&nbsp;�ߣ�������&#13;&#10;����ʱ�䣺2008-7-1 21:44:42" 
                        href="http://www.zz6789.com/Article/J/J7/200807/Article_20080701214442.html" 
                        target=_blank>2008��6��16��30��ʱ�£�ԭ����</A></TD>
                                    <TD class=listbg align=right width=40>07-01</TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg2>[<A class=listA 
                        href="http://www.zz6789.com/Article/J/j9/Index.html">ʱ��͸��</A>]<A 
                        class=listA 
                        title="���±��⣺�ۿ�����־���&#13;&#10;��&nbsp;&nbsp;&nbsp;&nbsp;�ߣ�������&#13;&#10;����ʱ�䣺2008-6-16 13:35:01" 
                        href="http://www.zz6789.com/Article/J/j9/200806/Article_20080616133501.html" 
                        target=_blank>�ۿ�����־���</A></TD>
                                    <TD class=listbg2 align=right width=40>06-16</TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg>[<A class=listA 
                        href="http://www.zz6789.com/Article/J/j9/Index.html">ʱ��͸��</A>]<A 
                        class=listA 
                        title="���±��⣺����ý�����������ҹ����ء�3&#8226;14���¼�͸��&#13;&#10;��&nbsp;&nbsp;&nbsp;&nbsp;�ߣ�������&#13;&#10;����ʱ�䣺2008-6-16 13:26:56" 
                        href="http://www.zz6789.com/Article/J/j9/200806/Article_20080616132656.html" 
                        target=_blank>����ý�����������ҹ����ء�3&#8226;14����</A></TD>
                                    <TD class=listbg align=right width=40>06-16</TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg2>[<A class=listA 
                        href="http://www.zz6789.com/Article/J/J7/Index.html">ʱ������</A>]<A 
                        class=listA 
                        title="���±��⣺2008��6��1��15��ʱ�£�ԭ����&#13;&#10;��&nbsp;&nbsp;&nbsp;&nbsp;�ߣ�������&#13;&#10;����ʱ�䣺2008-6-15 21:42:52" 
                        href="http://www.zz6789.com/Article/J/J7/200806/Article_20080615214252.html" 
                        target=_blank>2008��6��1��15��ʱ�£�ԭ����</A></TD>
                                    <TD class=listbg2 align=right width=40>06-15</TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg>[<A class=listA 
                        href="http://www.zz6789.com/Article/J/J6/Index.html">����ר��</A>]<A 
                        class=listA 
                        title="���±��⣺512����:���ס��100��˲��(ת��&#13;&#10;��&nbsp;&nbsp;&nbsp;&nbsp;�ߣ�����&#13;&#10;����ʱ�䣺2008-6-9 13:56:01" 
                        href="http://www.zz6789.com/Article/J/J6/200806/Article_20080609135601.html" 
                        target=_blank>512����:���ס��100��˲��(ת��</A></TD>
                                    <TD class=listbg align=right width=40>06-09</TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg2>[<A class=listA 
                        href="http://www.zz6789.com/Article/J/J2/Index.html">��������</A>]<A 
                        class=listA 
                        title="���±��⣺���������ֵܽ���������������ҲҪ���й�&#13;&#10;��&nbsp;&nbsp;&nbsp;&nbsp;�ߣ�godeeg019&#13;&#10;����ʱ�䣺2008-6-2 13:57:21" 
                        href="http://www.zz6789.com/Article/J/J2/200806/Article_20080602135721.html" 
                        target=_blank>���������ֵܽ���������������ҲҪ���й�</A></TD>
                                    <TD class=listbg2 align=right width=40>06-02</TD>
                                  </TR>
                                  <TR></TR>
                                </TBODY>
                              </TABLE></TD>
                          </TR>
                        </TBODY>
                      </TABLE>
                    </DIV></TD>
                </TR>
                <TR>
                  <TD><IMG height=20 src="SkinIndex/zin_r41_c21.jpg" width=387 
            border=0></TD>
                </TR>
              </TBODY>
            </TABLE>
            </P></TD>
          <TD width=390 bgColor=#ffffff><P align=center>
            <TABLE id=table6 cellSpacing=0 cellPadding=0 width=387 border=0>
              <TBODY>
                <TR>
                  <TD background=SkinIndex/zin_r46_c21.jpg height=48><P 
            align=left><B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��������</B></P></TD>
                </TR>
                <TR>
                  <TD background=SkinIndex/zin_r42_c21_r3.jpg height=93><DIV align=center>
                      <TABLE id=table12 height=27 cellSpacing=0 cellPadding=0 width="95%" 
            border=0>
                        <TBODY>
                          <TR>
                            <!--ʱ������-->
                            <TD><TABLE cellSpacing=0 cellPadding=0 width="100%">
                                <TBODY>
                                  <TR>
                                    <TD class=listbg>[<A class=listA 
                        href="http://www.zz6789.com/Article/C/C4/Index.html">��һ��</A>]<A 
                        class=listA 
                        title="���±��⣺���лῼ&nbsp;��3��&nbsp;��Ʒ�ļ�ֵ��&nbsp;ѧ��&#13;&#10;��&nbsp;&nbsp;&nbsp;&nbsp;�ߣ�����ռ&#13;&#10;����ʱ�䣺2008-9-9 20:46:05" 
                        href="http://www.zz6789.com/Article/C/C4/200809/Article_20080909204605.html" 
                        target=_blank>���лῼ&nbsp;��3��&nbsp;��Ʒ�ļ�ֵ��&nbsp;ѧ��</A></TD>
                                    <TD class=listbg align=right width=40><FONT 
                        color=red>09-09</FONT></TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg2>[<A class=listA 
                        href="http://www.zz6789.com/Article/C/C4/Index.html">��һ��</A>]<A 
                        class=listA 
                        title="���±��⣺�ῼ-���ó�ʶ��1��2��ѧ��&#13;&#10;��&nbsp;&nbsp;&nbsp;&nbsp;�ߣ�����ռ&#13;&#10;����ʱ�䣺2008-9-9 20:41:39" 
                        href="http://www.zz6789.com/Article/C/C4/200809/Article_20080909204139.html" 
                        target=_blank>�ῼ-���ó�ʶ��1��2��ѧ��</A></TD>
                                    <TD class=listbg2 align=right width=40><FONT 
                        color=red>09-09</FONT></TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg>[<A class=listA 
                        href="http://www.zz6789.com/Article/D/D3/Index.html">������</A>]<A 
                        class=listA 
                        title="���±��⣺2&nbsp;0&nbsp;0&nbsp;8&nbsp;ѧ&nbsp;��&nbsp;��&nbsp;��&nbsp;һ&nbsp;ѧ&nbsp;�ڵ�һ���¿�&#13;&#10;��&nbsp;&nbsp;&nbsp;&nbsp;�ߣ�zhuwenhui&#13;&#10;����ʱ�䣺2008-9-9 19:32:21" 
                        href="http://www.zz6789.com/Article/D/D3/200809/Article_20080909193221.html" 
                        target=_blank>2&nbsp;0&nbsp;0&nbsp;8&nbsp;ѧ&nbsp;��&nbsp;��&nbsp;��&nbsp;һ&nbsp;ѧ&nbsp;�ڵ�һ���¿�</A></TD>
                                    <TD class=listbg align=right width=40><FONT 
                        color=red>09-09</FONT></TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg2>[<A class=listA 
                        href="http://www.zz6789.com/Article/A/A3/Index.html">������</A>]<A 
                        class=listA 
                        title="���±��⣺�����¿�����&#13;&#10;��&nbsp;&nbsp;&nbsp;&nbsp;�ߣ�����&#13;&#10;����ʱ�䣺2008-9-9 14:09:59" 
                        href="http://www.zz6789.com/Article/A/A3/200809/Article_20080909140959.html" 
                        target=_blank>�����¿�����</A></TD>
                                    <TD class=listbg2 align=right width=40><FONT 
                        color=red>09-09</FONT></TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg>[<A class=listA 
                        href="http://www.zz6789.com/Article/H/H1/Index.html">��ѧ�ĵ�</A>]<A 
                        class=listA 
                        title="���±��⣺ǳ̸��ѧ������������&#13;&#10;��&nbsp;&nbsp;&nbsp;&nbsp;�ߣ��ӱ�&nbsp;¹Ȫ&nbsp;ʯ��&#13;&#10;����ʱ�䣺2008-9-8 21:19:24" 
                        href="http://www.zz6789.com/Article/H/H1/200809/Article_20080908211924.html" 
                        target=_blank>ǳ̸��ѧ������������</A></TD>
                                    <TD class=listbg align=right width=40><FONT 
                        color=red>09-08</FONT></TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg2>[<A class=listA 
                        href="http://www.zz6789.com/Article/C/C1/Index.html">��һ��</A>]<A 
                        class=listA 
                        title="���±��⣺���̰�˼��Ʒ�°��꼶���ϲᣩ�����Ծ�&#13;&#10;��&nbsp;&nbsp;&nbsp;&nbsp;�ߣ�����&#13;&#10;����ʱ�䣺2008-9-8 10:56:26" 
                        href="http://www.zz6789.com/Article/C/C1/200809/Article_20080908105626.html" 
                        target=_blank>���̰�˼��Ʒ�°��꼶���ϲᣩ�����Ծ�</A></TD>
                                    <TD class=listbg2 align=right width=40><FONT 
                        color=red>09-08</FONT></TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg>[<A class=listA 
                        href="http://www.zz6789.com/Article/k/k3/Index.html">��ʷ����</A>]<A 
                        class=listA 
                        title="���±��⣺������Ϊ�Ρ�����ϧ������&#13;&#10;��&nbsp;&nbsp;&nbsp;&nbsp;�ߣ�����&#13;&#10;����ʱ�䣺2008-9-8 9:17:03" 
                        href="http://www.zz6789.com/Article/k/k3/200809/Article_20080908091703.html" 
                        target=_blank>������Ϊ�Ρ�����ϧ������</A></TD>
                                    <TD class=listbg align=right width=40><FONT 
                        color=red>09-08</FONT></TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg2>[<A class=listA 
                        href="http://www.zz6789.com/Article/D/D5/Index.html">�߶���</A>]<A 
                        class=listA 
                        title="���±��⣺2008����2007�꡶�Ļ�����̲ĵ�һ��Ԫ�Ķ�����Ա�&#13;&#10;��&nbsp;&nbsp;&nbsp;&nbsp;�ߣ��¸�֥&#13;&#10;����ʱ�䣺2008-9-7 23:58:31" 
                        href="http://www.zz6789.com/Article/D/D5/200809/Article_20080907235831.html" 
                        target=_blank>2008����2007�꡶�Ļ�����̲ĵ�һ��Ԫ��</A></TD>
                                    <TD class=listbg2 align=right width=40><FONT 
                        color=red>09-07</FONT></TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg>[<A class=listA 
                        href="http://www.zz6789.com/Article/J/J7/Index.html">ʱ������</A>]<A 
                        class=listA 
                        title="���±��⣺2008��8��1��31��ʱ��&#13;&#10;��&nbsp;&nbsp;&nbsp;&nbsp;�ߣ�������&#13;&#10;����ʱ�䣺2008-9-6 14:30:43" 
                        href="http://www.zz6789.com/Article/J/J7/200809/Article_20080906143043.html" 
                        target=_blank>2008��8��1��31��ʱ��</A></TD>
                                    <TD class=listbg align=right width=40><FONT 
                        color=red>09-06</FONT></TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg2>[<A class=listA 
                        href="http://www.zz6789.com/Article/H/H1/Index.html">��ѧ�ĵ�</A>]<A 
                        class=listA 
                        title="���±��⣺�ó���˼��Ʒ�¿ν�ѧ���&#13;&#10;��&nbsp;&nbsp;&nbsp;&nbsp;�ߣ������&#13;&#10;����ʱ�䣺2008-9-5 14:29:59" 
                        href="http://www.zz6789.com/Article/H/H1/200809/Article_20080905142959.html" 
                        target=_blank>�ó���˼��Ʒ�¿ν�ѧ���</A></TD>
                                    <TD class=listbg2 align=right width=40><FONT 
                        color=red>09-05</FONT></TD>
                                  </TR>
                                  <TR></TR>
                                </TBODY>
                              </TABLE></TD>
                          </TR>
                        </TBODY>
                      </TABLE>
                    </DIV></TD>
                </TR>
                <TR>
                  <TD><IMG height=20 src="SkinIndex/zin_r41_c21.jpg" width=387 
            border=0></TD>
                </TR>
              </TBODY>
            </TABLE>
            </P></TD>
          <TD width=8 rowSpan=2>��</TD>
        </TR>
        <TR>
          <TD width=391 bgColor=#ffffff><P align=center>
            <TABLE id=table6 cellSpacing=0 cellPadding=0 width=387 border=0>
              <TBODY>
                <TR>
                  <TD background=SkinIndex/zin_r46_c21.jpg height=48><P align=left><B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                      ʱ��͸��</B></P></TD>
                </TR>
                <TR>
                  <TD background=SkinIndex/zin_r42_c21_r3.jpg height=93><DIV align=center>
                      <TABLE id=table12 height=27 cellSpacing=0 cellPadding=0 width="95%" 
            border=0>
                        <TBODY>
                          <TR>
                            <!--ʱ������-->
                            <TD><TABLE cellSpacing=0 cellPadding=0 width="100%">
                                <TBODY>
                                  <TR>
                                    <TD class=listbg>[<A class=listA 
                        href="http://www.zz6789.com/Article/J/j9/Index.html">ʱ��͸��</A>]<A 
                        class=listA 
                        title="���±��⣺�ۿ�����־���&#13;&#10;��&nbsp;&nbsp;&nbsp;&nbsp;�ߣ�������&#13;&#10;����ʱ�䣺2008-6-16 13:35:01" 
                        href="http://www.zz6789.com/Article/J/j9/200806/Article_20080616133501.html" 
                        target=_blank>�ۿ�����־���</A></TD>
                                    <TD class=listbg align=right width=40>06-16</TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg2>[<A class=listA 
                        href="http://www.zz6789.com/Article/J/j9/Index.html">ʱ��͸��</A>]<A 
                        class=listA 
                        title="���±��⣺����ý�����������ҹ����ء�3&#8226;14���¼�͸��&#13;&#10;��&nbsp;&nbsp;&nbsp;&nbsp;�ߣ�������&#13;&#10;����ʱ�䣺2008-6-16 13:26:56" 
                        href="http://www.zz6789.com/Article/J/j9/200806/Article_20080616132656.html" 
                        target=_blank>����ý�����������ҹ����ء�3&#8226;14���¼�͸</A></TD>
                                    <TD class=listbg2 align=right width=40>06-16</TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg>[<A class=listA 
                        href="http://www.zz6789.com/Article/J/j9/Index.html">ʱ��͸��</A>]<A 
                        class=listA 
                        title="���±��⣺��ѩ����&#13;&#10;��&nbsp;&nbsp;&nbsp;&nbsp;�ߣ��ӱ�ʡ�����ص�����ѧ�����飺���Ứ&#13;&#10;����ʱ�䣺2008-4-5 17:10:46" 
                        href="http://www.zz6789.com/Article/J/j9/200804/Article_20080405171046.html" 
                        target=_blank>��ѩ����</A></TD>
                                    <TD class=listbg align=right width=40>04-05</TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg2>[<A class=listA 
                        href="http://www.zz6789.com/Article/J/j9/Index.html">ʱ��͸��</A>]<A 
                        class=listA 
                        title="���±��⣺����˼��Ʒ�¿κ͸���˼�����ο�&nbsp;�᳹����ʮ�ߴ����ָ�����&#13;&#10;��&nbsp;&nbsp;&nbsp;&nbsp;�ߣ�dyy730808&#13;&#10;����ʱ�䣺2008-1-31 0:03:48" 
                        href="http://www.zz6789.com/Article/J/j9/200801/Article_20080131000348.html" 
                        target=_blank>����˼��Ʒ�¿κ͸���˼�����ο�&nbsp;�᳹����ʮ�ߴ�</A></TD>
                                    <TD class=listbg2 align=right width=40>01-31</TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg>[<A class=listA 
                        href="http://www.zz6789.com/Article/J/j9/Index.html">ʱ��͸��</A>]<A 
                        class=listA 
                        title="���±��⣺����������ת�����ڳ�&#13;&#10;��&nbsp;&nbsp;&nbsp;&nbsp;�ߣ�δ֪&#13;&#10;����ʱ�䣺2007-12-16 20:56:27" 
                        href="http://www.zz6789.com/Article/J/j9/200712/Article_20071216205627.html" 
                        target=_blank>����������ת�����ڳ�</A></TD>
                                    <TD class=listbg align=right width=40>12-16</TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg2>[<A class=listA 
                        href="http://www.zz6789.com/Article/J/j9/Index.html">ʱ��͸��</A>]<A 
                        class=listA 
                        title="���±��⣺�¾��������컨��������ը��12��ͯ����������&#13;&#10;��&nbsp;&nbsp;&nbsp;&nbsp;�ߣ�δ֪&#13;&#10;����ʱ�䣺2007-12-16 20:53:59" 
                        href="http://www.zz6789.com/Article/J/j9/200712/Article_20071216205359.html" 
                        target=_blank>�¾��������컨��������ը��12��ͯ����������</A></TD>
                                    <TD class=listbg2 align=right width=40>12-16</TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg>[<A class=listA 
                        href="http://www.zz6789.com/Article/J/j9/Index.html">ʱ��͸��</A>]<A 
                        class=listA 
                        title="���±��⣺ũ��а������δ������ì��&nbsp;����ũ����ظ���&#13;&#10;��&nbsp;&nbsp;&nbsp;&nbsp;�ߣ�δ֪&#13;&#10;����ʱ�䣺2007-12-16 20:52:41" 
                        href="http://www.zz6789.com/Article/J/j9/200712/Article_20071216205241.html" 
                        target=_blank>ũ��а������δ������ì��&nbsp;����ũ����ظ���</A></TD>
                                    <TD class=listbg align=right width=40>12-16</TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg2>[<A class=listA 
                        href="http://www.zz6789.com/Article/J/j9/Index.html">ʱ��͸��</A>]<A 
                        class=listA 
                        title="���±��⣺2007ȫ����ǿ������ȡ����������&#13;&#10;��&nbsp;&nbsp;&nbsp;&nbsp;�ߣ�δ֪&#13;&#10;����ʱ�䣺2007-12-16 20:48:56" 
                        href="http://www.zz6789.com/Article/J/j9/200712/Article_20071216204856.html" 
                        target=_blank>2007ȫ����ǿ������ȡ����������</A></TD>
                                    <TD class=listbg2 align=right width=40>12-16</TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg>[<A class=listA 
                        href="http://www.zz6789.com/Article/J/j9/Index.html">ʱ��͸��</A>]<A 
                        class=listA 
                        title="���±��⣺�㶫�����ڰ�ͷĿ���ĳ�����&#13;&#10;��&nbsp;&nbsp;&nbsp;&nbsp;�ߣ�δ֪&#13;&#10;����ʱ�䣺2007-12-16 20:44:26" 
                        href="http://www.zz6789.com/Article/J/j9/200712/Article_20071216204426.html" 
                        target=_blank>�㶫�����ڰ�ͷĿ���ĳ�����</A></TD>
                                    <TD class=listbg align=right width=40>12-16</TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg2>[<A class=listA 
                        href="http://www.zz6789.com/Article/J/j9/Index.html">ʱ��͸��</A>]<A 
                        class=listA 
                        title="���±��⣺��ʹ��Ϊ�˼��仹����ȴ��&#13;&#10;��&nbsp;&nbsp;&nbsp;&nbsp;�ߣ�δ֪&#13;&#10;����ʱ�䣺2007-12-16 20:42:42" 
                        href="http://www.zz6789.com/Article/J/j9/200712/Article_20071216204242.html" 
                        target=_blank>��ʹ��Ϊ�˼��仹����ȴ��</A></TD>
                                    <TD class=listbg2 align=right width=40>12-16</TD>
                                  </TR>
                                  <TR></TR>
                                </TBODY>
                              </TABLE></TD>
                          </TR>
                        </TBODY>
                      </TABLE>
                    </DIV></TD>
                </TR>
                <TR>
                  <TD><IMG height=20 src="SkinIndex/zin_r41_c21.jpg" width=387 
            border=0></TD>
                </TR>
              </TBODY>
            </TABLE>
            </P></TD>
          <TD width=390 bgColor=#ffffff><P align=center>
            <TABLE id=table6 cellSpacing=0 cellPadding=0 width=387 border=0>
              <TBODY>
                <TR>
                  <TD background=SkinIndex/zin_r46_c21.jpg height=48><P 
            align=left><B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;���¿μ�</B></P></TD>
                </TR>
                <TR>
                  <TD background=SkinIndex/zin_r42_c21_r3.jpg height=93><DIV align=center>
                      <TABLE id=table12 height=27 cellSpacing=0 cellPadding=0 width="95%" 
            border=0>
                        <TBODY>
                          <TR>
                            <!--ʱ������-->
                            <TD><TABLE cellSpacing=0 cellPadding=0 width="100%">
                                <TBODY>
                                  <TR>
                                    <TD class=listbg>[<A class=listA 
                        href="http://www.zz6789.com/Soft/JuniorClass/c3/Index.html">������</A>]<A 
                        class=listA title='1.2ʵ���е�"һ������"' 
                        href="http://www.zz6789.com/Soft/JuniorClass/c3/200809/Soft_3839.html" 
                        target=_blank>1.2ʵ���е�"һ������"</A></TD>
                                    <TD class=listbg align=right width=40>09-03</TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg2>[<A class=listA 
                        href="http://www.zz6789.com/Soft/JuniorClass/c3/Index.html">������</A>]<A 
                        class=listA title=1.2���񵱼������������ƶ� 
                        href="http://www.zz6789.com/Soft/JuniorClass/c3/200809/Soft_3838.html" 
                        target=_blank>1.2���񵱼������������ƶ�</A></TD>
                                    <TD class=listbg2 align=right width=40>09-03</TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg>[<A class=listA 
                        href="http://www.zz6789.com/Soft/JuniorClass/c3/Index.html">������</A>]<A 
                        class=listA title=1.2���л����Ļ��������ƶ� 
                        href="http://www.zz6789.com/Soft/JuniorClass/c3/200809/Soft_3837.html" 
                        target=_blank>1.2���л����Ļ��������ƶ�</A></TD>
                                    <TD class=listbg align=right width=40>09-03</TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg2>[<A class=listA 
                        href="http://www.zz6789.com/Soft/JuniorClass/c3/Index.html">������</A>]<A 
                        class=listA title=1.1�����׶εĻ���·�� 
                        href="http://www.zz6789.com/Soft/JuniorClass/c3/200809/Soft_3836.html" 
                        target=_blank>1.1�����׶εĻ���·��</A></TD>
                                    <TD class=listbg2 align=right width=40>09-03</TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg>[<A class=listA 
                        href="http://www.zz6789.com/Soft/JuniorClass/c3/Index.html">������</A>]<A 
                        class=listA title=1.1�����׶ε���Ҫì�ܺ͸������� 
                        href="http://www.zz6789.com/Soft/JuniorClass/c3/200809/Soft_3835.html" 
                        target=_blank>1.1�����׶ε���Ҫì�ܺ͸�������</A></TD>
                                    <TD class=listbg align=right width=40>09-03</TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg2>[<A class=listA 
                        href="http://www.zz6789.com/Soft/JuniorClass/c3/Index.html">������</A>]<A 
                        class=listA title=1.1�����׶ε�������� 
                        href="http://www.zz6789.com/Soft/JuniorClass/c3/200809/Soft_3834.html" 
                        target=_blank>1.1�����׶ε��������</A></TD>
                                    <TD class=listbg2 align=right width=40>09-03</TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg>[<A class=listA 
                        href="http://www.zz6789.com/Soft/Highclass/Economy/Levy01/Index.html">��һ�� 
                                      ����Ļ���</A>]<A class=listA title=����Ļ��� 
                        href="http://www.zz6789.com/Soft/Highclass/Economy/Levy01/200809/Soft_3833.html" 
                        target=_blank>����Ļ���</A></TD>
                                    <TD class=listbg align=right width=40>09-02</TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg2>[<A class=listA 
                        href="http://www.zz6789.com/Soft/M/Index.html">��ϰר��μ�</A>]<A 
                        class=listA title=�������ϰ�ڶ��� 
                        href="http://www.zz6789.com/Soft/M/200809/Soft_3831.html" 
                        target=_blank>�������ϰ�ڶ���</A></TD>
                                    <TD class=listbg2 align=right width=40>09-02</TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg>[<A class=listA 
                        href="http://www.zz6789.com/Soft/N/Index.html">���������μ�</A>]<A 
                        class=listA title=���� 
                        href="http://www.zz6789.com/Soft/N/200808/Soft_3828.html" 
                        target=_blank>����</A></TD>
                                    <TD class=listbg align=right width=40>08-04</TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg2>[<A class=listA 
                        href="http://www.zz6789.com/Soft/JuniorClass/c2/Index.html">������</A>]<A 
                        class=listA title=ƽ�ȴ��ˣ��ڶ���ʱ�� 
                        href="http://www.zz6789.com/Soft/JuniorClass/c2/200807/Soft_3827.html" 
                        target=_blank>ƽ�ȴ��ˣ��ڶ���ʱ��</A></TD>
                                    <TD class=listbg2 align=right width=40>07-24</TD>
                                  </TR>
                                  <TR></TR>
                                </TBODY>
                              </TABLE></TD>
                          </TR>
                        </TBODY>
                      </TABLE>
                    </DIV></TD>
                </TR>
                <TR>
                  <TD><IMG height=20 src="SkinIndex/zin_r41_c21.jpg" width=387 
            border=0></TD>
                </TR>
              </TBODY>
            </TABLE>
            </P></TD>
        </TR>
      </TBODY>
    </TABLE>
  </DIV>
  <DIV align=center>
    <TABLE id=table7 height=80 cellSpacing=0 cellPadding=0 width=797 
background=SkinIndex/new_wow_43.jpg border=0>
      <TBODY>
        <TR>
          <TD width=8>��</TD>
          <TD align=middle width=781 bgColor=#ffffff height=80><SCRIPT language=javascript src="SkinIndex/1.js"></SCRIPT>
          </TD>
          <TD width=8>��</TD>
        </TR>
      </TBODY>
    </TABLE>
  </DIV>
  <DIV align=center>
    <TABLE id=table7 height=100 cellSpacing=0 cellPadding=0 width=797 
background=SkinIndex/new_wow_43.jpg border=0>
      <TBODY>
        <TR>
          <TD width=8>��</TD>
          <TD vAlign=top align=middle width=197 bgColor=#ffffff><TABLE id=table5 height=200 cellSpacing=0 cellPadding=0 width=197 
border=0>
              <TBODY>
                <TR>
                  <TD background=SkinIndex/zdl_8.gif height=35><P align=center><B>�� �� �� ��</B></P></TD>
                </TR>
                <TR>
                  <TD height=24><IMG height=24 src="SkinIndex/zin_r11_c1.gif" 
            width=197 border=0></TD>
                </TR>
                
                
                <TR>
                  <TD background=SkinIndex/zin_r13_c1.gif>
                   <% call Showhot(8,16) %>
                    </TD>
                </TR>
                
                <TR>
                  <TD height=24><IMG height=25 src="SkinIndex/zin_r18_c1.gif" 
            width=197 border=0></TD>
                </TR>
              </TBODY>
            </TABLE>
            <TABLE id=table5 height=200 cellSpacing=0 cellPadding=0 width=197 
border=0>
              <TBODY>
                <TR>
                  <TD background=SkinIndex/zdl_8.gif height=35><P align=center><B>�� ӭ �� ��</B></P></TD>
                </TR>
                <TR>
                  <TD height=24><IMG height=24 src="SkinIndex/zin_r11_c1.gif" 
            width=197 border=0></TD>
                </TR>
                
                
                <TR>
                  <TD align=middle background=SkinIndex/zin_r13_c1.gif>
				  <% call ShownewUser(5) %>
                  </TD>
                </TR>
                
                
                <TR>
                  <TD height=24><IMG height=25 src="SkinIndex/zin_r18_c1.gif" 
            width=197 border=0></TD>
                </TR>
              </TBODY>
            </TABLE>
            <TABLE id=table5 height=200 cellSpacing=0 cellPadding=0 width=197 
border=0>
              <TBODY>
                <TR>
                  <TD background=SkinIndex/zdl_8.gif height=35><P align=center><B>�� վ �� ��</B></P></TD>
                </TR>
                <TR>
                  <TD height=24><IMG height=24 src="SkinIndex/zin_r11_c1.gif" 
            width=197 border=0></TD>
                </TR>
                <TR>
                  		<TD align=middle background=SkinIndex/zin_r13_c1.gif  height=200>
            				<% call showvote() %>
           				 </TD><td bgcolor="
                </TR>
                <TR>
                  <TD height=24><IMG height=25 src="SkinIndex/zin_r18_c1.gif" 
            width=197 border=0></TD>
                </TR>
              </TBODY>
            </TABLE></TD>
          <TD vAlign=top align=middle width=584 bgColor=#ffffff><TABLE id=table8 cellSpacing=0 cellPadding=0 width=577 border=0>
              <TBODY>
                <TR>
                  <TD width=287 background=SkinIndex/zin_r48_c1.gif 
            height=48><B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�̲ķ���</B></TD>
                  <TD width=3>��</TD>
                  <TD width=287 background=SkinIndex/zin_r48_c1.gif 
            height=48><B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�߿��о�</B></TD>
                </TR>
                <TR>
                  <TD background=SkinIndex/zin_r49_c1.gif height=200><DIV align=center>
                      <TABLE id=table12 height=27 cellSpacing=0 cellPadding=0 width="95%" 
            border=0>
                        <TBODY>
                          <TR>
                            <!--����1-->
                            <TD><TABLE cellSpacing=0 cellPadding=0 width="100%">
                                <TBODY>
                                  <TR>
                                    <TD class=listbg vAlign=top width=10><IMG alt=��ͨ���� 
                        src="SkinIndex/article_common.gif"></TD>
                                    <TD class=listbg>[<A class=listA 
                        href="http://www.zz6789.com/Article/A/A3/Index.html">������</A>]<A 
                        class=listA title=�����¿����� 
                        href="http://www.zz6789.com/Article/A/A3/200809/Article_20080909140959.html" 
                        target=_blank>�����¿�����</A></TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg2 vAlign=top width=10><IMG alt=��ͨ���� 
                        src="SkinIndex/article_common.gif"></TD>
                                    <TD class=listbg2>[<A class=listA 
                        href="http://www.zz6789.com/Article/A/A1/Index.html">��һ��</A>]<A 
                        class=listA title=��ѧ�����������ѧ����������. 
                        href="http://www.zz6789.com/Article/A/A1/200808/Article_20080813161106.html" 
                        target=_blank>��ѧ�����������ѧ����������.</A></TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg vAlign=top width=10><IMG alt=��ͨ���� 
                        src="SkinIndex/article_common.gif"></TD>
                                    <TD class=listbg>[<A class=listA 
                        href="http://www.zz6789.com/Article/A/A3/Index.html">������</A>]<A 
                        class=listA title=2&nbsp;0&nbsp;0&nbsp;8���ߺ��г��б�ҵѧҵ���� 
                        href="http://www.zz6789.com/Article/A/A3/200807/Article_20080702161758.html" 
                        target=_blank>2&nbsp;0&nbsp;0&nbsp;8���ߺ��г��б�ҵѧҵ����</A></TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg2 vAlign=top width=10><IMG alt=��ͨ���� 
                        src="SkinIndex/article_common.gif"></TD>
                                    <TD class=listbg2>[<A class=listA 
                        href="http://www.zz6789.com/Article/A/A6/Index.html">������</A>]<A 
                        class=listA title=2008���Ļ������ȵ����⼰��������ѵ���� 
                        href="http://www.zz6789.com/Article/A/A6/200806/Article_20080628162241.html" 
                        target=_blank>2008���Ļ������ȵ����⼰������</A></TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg vAlign=top width=10><IMG alt=��ͨ���� 
                        src="SkinIndex/article_common.gif"></TD>
                                    <TD class=listbg>[<A class=listA 
                        href="http://www.zz6789.com/Article/A/A3/Index.html">������</A>]<A 
                        class=listA title=������ѧ2008������ڶ����¿�˼��Ʒ�� 
                        href="http://www.zz6789.com/Article/A/A3/200804/Article_20080427141009.html" 
                        target=_blank>������ѧ2008������ڶ����¿�˼</A></TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg2 vAlign=top width=10><IMG alt=��ͨ���� 
                        src="SkinIndex/article_common.gif"></TD>
                                    <TD class=listbg2>[<A class=listA 
                        href="http://www.zz6789.com/Article/A/A3/Index.html">������</A>]<A 
                        class=listA title=�й�����WTO�кλ������壿 
                        href="http://www.zz6789.com/Article/A/A3/200804/Article_20080421210216.html" 
                        target=_blank>�й�����WTO�кλ������壿</A></TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg vAlign=top width=10><IMG alt=��ͨ���� 
                        src="SkinIndex/article_common.gif"></TD>
                                    <TD class=listbg>[<A class=listA 
                        href="http://www.zz6789.com/Article/A/A3/Index.html">������</A>]<A 
                        class=listA title=2007-2008ѧ���һѧ����ĩ���꼶˼�������Ծ� 
                        href="http://www.zz6789.com/Article/A/A3/200804/Article_20080421142028.html" 
                        target=_blank>2007-2008ѧ���һѧ����ĩ���꼶</A></TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg2 vAlign=top width=10><IMG alt=��ͨ���� 
                        src="SkinIndex/article_common.gif"></TD>
                                    <TD class=listbg2>[<A class=listA 
                        href="http://www.zz6789.com/Article/A/A3/Index.html">������</A>]<A 
                        class=listA title=�����ϼ���� 
                        href="http://www.zz6789.com/Article/A/A3/200804/Article_20080421141732.html" 
                        target=_blank>�����ϼ����</A></TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg vAlign=top width=10><IMG alt=��ͨ���� 
                        src="SkinIndex/article_common.gif"></TD>
                                    <TD class=listbg>[<A class=listA 
                        href="http://www.zz6789.com/Article/A/A3/Index.html">������</A>]<A 
                        class=listA title=�߶���ѧ��00�����һ��ģ���˼��Ʒ������ 
                        href="http://www.zz6789.com/Article/A/A3/200804/Article_20080420084414.html" 
                        target=_blank>�߶���ѧ��00�����һ��ģ���˼</A></TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg2 vAlign=top width=10><IMG alt=�Ƽ����� 
                        src="SkinIndex/article_elite.gif"></TD>
                                    <TD class=listbg2>[<A class=listA 
                        href="http://www.zz6789.com/Article/A/A6/Index.html">������</A>]<A 
                        class=listA title=����ѧУ����ָ�������ʮ�ߴ��뾭�������ϵ�ר���� 
                        href="http://www.zz6789.com/Article/A/A6/200804/Article_20080413153656.html" 
                        target=_blank>����ѧУ����ָ�������ʮ�ߴ���</A></TD>
                                  </TR>
                                  <TR></TR>
                                </TBODY>
                              </TABLE></TD>
                          </TR>
                        </TBODY>
                      </TABLE>
                    </DIV></TD>
                  <TD width=3>��</TD>
                  <TD background=SkinIndex/zin_r49_c1.gif height=200><DIV align=center>
                      <TABLE id=table12 height=27 cellSpacing=0 cellPadding=0 width="95%" 
            border=0>
                        <TBODY>
                          <TR>
                            <!--����1-->
                            <TD><TABLE cellSpacing=0 cellPadding=0 width="100%">
                                <TBODY>
                                  <TR>
                                    <TD class=listbg vAlign=top width=10><IMG alt=��ͨ���� 
                        src="SkinIndex/article_common.gif"></TD>
                                    <TD class=listbg>[<A class=listA 
                        href="http://www.zz6789.com/Article/E/E2/Index.html">�߿�����</A>]<A 
                        class=listA 
                        title=�߿��ȵ�ר��һ&nbsp;&nbsp;&nbsp;&nbsp;��ע������������г 
                        href="http://www.zz6789.com/Article/E/E2/200809/Article_20080901084735.html" 
                        target=_blank>�߿��ȵ�ר��һ&nbsp;&nbsp;&nbsp;&nbsp;��ע��������</A></TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg2 vAlign=top width=10><IMG alt=�Ƽ����� 
                        src="SkinIndex/article_elite.gif"></TD>
                                    <TD class=listbg2>[<A class=listA 
                        href="http://www.zz6789.com/Article/E/E8/Index.html">����߿���</A>]<A 
                        class=listA title=2008��߿����γ�ʶ������� 
                        href="http://www.zz6789.com/Article/E/E8/200808/Article_20080815091349.html" 
                        target=_blank>2008��߿����γ�ʶ�������</A></TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg vAlign=top width=10><IMG alt=�Ƽ����� 
                        src="SkinIndex/article_elite.gif"></TD>
                                    <TD class=listbg>[<A class=listA 
                        href="http://www.zz6789.com/Article/E/E8/Index.html">����߿���</A>]<A 
                        class=listA title=2008��߿���ѧ��ʶ������� 
                        href="http://www.zz6789.com/Article/E/E8/200808/Article_20080815091140.html" 
                        target=_blank>2008��߿���ѧ��ʶ�������</A></TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg2 vAlign=top width=10><IMG alt=�Ƽ����� 
                        src="SkinIndex/article_elite.gif"></TD>
                                    <TD class=listbg2>[<A class=listA 
                        href="http://www.zz6789.com/Article/E/E2/Index.html">�߿�����</A>]<A 
                        class=listA title=2008��߿����ó�ʶ������� 
                        href="http://www.zz6789.com/Article/E/E2/200808/Article_20080815090848.html" 
                        target=_blank>2008��߿����ó�ʶ�������</A></TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg vAlign=top width=10><IMG alt=�Ƽ����� 
                        src="SkinIndex/article_elite.gif"></TD>
                                    <TD class=listbg>[<A class=listA 
                        href="http://www.zz6789.com/Article/E/E3/Index.html">��������</A>]<A 
                        class=listA title=��08��߿��Ŀ��ۺ�ȫ����09�����θ߿����� 
                        href="http://www.zz6789.com/Article/E/E3/200807/Article_20080725225113.html" 
                        target=_blank>��08��߿��Ŀ��ۺ�ȫ����09��</A></TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg2 vAlign=top width=10><IMG alt=��ͨ���� 
                        src="SkinIndex/article_common.gif"></TD>
                                    <TD class=listbg2>[<A class=listA 
                        href="http://www.zz6789.com/Article/E/E8/Index.html">����߿���</A>]<A 
                        class=listA title=2008��㶫�߿����������(A����Ƭ��4) 
                        href="http://www.zz6789.com/Article/E/E8/200806/Article_20080617215719.html" 
                        target=_blank>2008��㶫�߿����������(A��</A></TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg vAlign=top width=10><IMG alt=��ͨ���� 
                        src="SkinIndex/article_common.gif"></TD>
                                    <TD class=listbg>[<A class=listA 
                        href="http://www.zz6789.com/Article/E/E8/Index.html">����߿���</A>]<A 
                        class=listA title=2008��㶫�߿����������(A����Ƭ��3) 
                        href="http://www.zz6789.com/Article/E/E8/200806/Article_20080617215225.html" 
                        target=_blank>2008��㶫�߿����������(A��</A></TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg2 vAlign=top width=10><IMG alt=��ͨ���� 
                        src="SkinIndex/article_common.gif"></TD>
                                    <TD class=listbg2>[<A class=listA 
                        href="http://www.zz6789.com/Article/E/E8/Index.html">����߿���</A>]<A 
                        class=listA title=2008��㶫�߿����������(A����Ƭ��2) 
                        href="http://www.zz6789.com/Article/E/E8/200806/Article_20080617214448.html" 
                        target=_blank>2008��㶫�߿����������(A��</A></TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg vAlign=top width=10><IMG alt=��ͨ���� 
                        src="SkinIndex/article_common.gif"></TD>
                                    <TD class=listbg>[<A class=listA 
                        href="http://www.zz6789.com/Article/E/E8/Index.html">����߿���</A>]<A 
                        class=listA title=2008��㶫�߿����������(A����Ƭ��1) 
                        href="http://www.zz6789.com/Article/E/E8/200806/Article_20080617204930.html" 
                        target=_blank>2008��㶫�߿����������(A��</A></TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg2 vAlign=top width=10><IMG alt=��ͨ���� 
                        src="SkinIndex/article_common.gif"></TD>
                                    <TD class=listbg2>[<A class=listA 
                        href="http://www.zz6789.com/Article/E/E8/Index.html">����߿���</A>]<A 
                        class=listA title=2008��㶫�߿���������(A��word��) 
                        href="http://www.zz6789.com/Article/E/E8/200806/Article_20080617204107.html" 
                        target=_blank>2008��㶫�߿���������(A��word</A></TD>
                                  </TR>
                                  <TR></TR>
                                </TBODY>
                              </TABLE></TD>
                          </TR>
                        </TBODY>
                      </TABLE>
                    </DIV></TD>
                </TR>
                <TR>
                  <TD height=17><IMG height=17 src="SkinIndex/zin_r50_c1.gif" 
            width=287 border=0></TD>
                  <TD width=3>��</TD>
                  <TD height=17><IMG height=17 src="SkinIndex/zin_r50_c1.gif" 
            width=287 border=0></TD>
                </TR>
              </TBODY>
            </TABLE>
            <TABLE id=table8 cellSpacing=0 cellPadding=0 width=577 border=0>
              <TBODY>
                <TR>
                  <TD width=287 background=SkinIndex/zin_r48_c1.gif 
            height=48><B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�̰�ѡ��</B></TD>
                  <TD width=3>��</TD>
                  <TD width=287 background=SkinIndex/zin_r48_c1.gif 
            height=48><B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�п��о�</B></TD>
                </TR>
                <TR>
                  <TD background=SkinIndex/zin_r49_c1.gif height=200><DIV align=center>
                      <TABLE id=table12 height=27 cellSpacing=0 cellPadding=0 width="95%" 
            border=0>
                        <TBODY>
                          <TR>
                            <!--����1-->
                            <TD><TABLE cellSpacing=0 cellPadding=0 width="100%">
                                <TBODY>
                                  <TR>
                                    <TD class=listbg vAlign=top width=10><IMG alt=�Ƽ����� 
                        src="SkinIndex/article_elite.gif"></TD>
                                    <TD class=listbg>[<A class=listA 
                        href="http://www.zz6789.com/Article/B/B3/Index.html">������</A>]<A 
                        class=listA title=2008���п�ʱ���ȵ�Ԥ�� 
                        href="http://www.zz6789.com/Article/B/B3/200806/Article_20080619111204.html" 
                        target=_blank>2008���п�ʱ���ȵ�Ԥ��</A></TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg2 vAlign=top width=10><IMG alt=��ͨ���� 
                        src="SkinIndex/article_common.gif"></TD>
                                    <TD class=listbg2>[<A class=listA 
                        href="http://www.zz6789.com/Article/B/B2/Index.html">������</A>]<A 
                        class=listA title=�Ʋ�����˭��ѧ��� 
                        href="http://www.zz6789.com/Article/B/B2/200805/Article_20080524200913.html" 
                        target=_blank>�Ʋ�����˭��ѧ���</A></TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg vAlign=top width=10><IMG alt=��ͨ���� 
                        src="SkinIndex/article_common.gif"></TD>
                                    <TD class=listbg>[<A class=listA 
                        href="http://www.zz6789.com/Article/B/B2/Index.html">������</A>]<A 
                        class=listA title=������˼Ʒ�θ�ϰ��Ҫ 
                        href="http://www.zz6789.com/Article/B/B2/200804/Article_20080421142347.html" 
                        target=_blank>������˼Ʒ�θ�ϰ��Ҫ</A></TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg2 vAlign=top width=10><IMG alt=��ͨ���� 
                        src="SkinIndex/article_common.gif"></TD>
                                    <TD class=listbg2>[<A class=listA 
                        href="http://www.zz6789.com/Article/B/B5/Index.html">�߶���</A>]<A 
                        class=listA title=�����˶�ʱ�й��ɵĽ̰� 
                        href="http://www.zz6789.com/Article/B/B5/200803/Article_20080330161846.html" 
                        target=_blank>�����˶�ʱ�й��ɵĽ̰�</A></TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg vAlign=top width=10><IMG alt=��ͨ���� 
                        src="SkinIndex/article_common.gif"></TD>
                                    <TD class=listbg>[<A class=listA 
                        href="http://www.zz6789.com/Article/B/B3/Index.html">������</A>]<A 
                        class=listA 
                        title=��Ϣ�������µĽ�ѧ���&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;���˽����&nbsp;&nbsp;�����л�����Ԫ��ѧ���� 
                        href="http://www.zz6789.com/Article/B/B3/200803/Article_20080304102437.html" 
                        target=_blank>��Ϣ�������µĽ�ѧ���&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</A></TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg2 vAlign=top width=10><IMG alt=��ͨ���� 
                        src="SkinIndex/article_common.gif"></TD>
                                    <TD class=listbg2>[<A class=listA 
                        href="http://www.zz6789.com/Article/B/B1/Index.html">��һ��</A>]<A 
                        class=listA title=�ഺ���� 
                        href="http://www.zz6789.com/Article/B/B1/200801/Article_20080118092924.html" 
                        target=_blank>�ഺ����</A></TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg vAlign=top width=10><IMG alt=��ͨ���� 
                        src="SkinIndex/article_common.gif"></TD>
                                    <TD class=listbg>[<A class=listA 
                        href="http://www.zz6789.com/Article/B/B4/Index.html">��һ��</A>]<A 
                        class=listA title=˰�ռ������� 
                        href="http://www.zz6789.com/Article/B/B4/200801/Article_20080116220749.html" 
                        target=_blank>˰�ռ�������</A></TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg2 vAlign=top width=10><IMG alt=��ͨ���� 
                        src="SkinIndex/article_common.gif"></TD>
                                    <TD class=listbg2>[<A class=listA 
                        href="http://www.zz6789.com/Article/B/B4/Index.html">��һ��</A>]<A 
                        class=listA title=���������ϵ��ԭ�� 
                        href="http://www.zz6789.com/Article/B/B4/200801/Article_20080116220614.html" 
                        target=_blank>���������ϵ��ԭ��</A></TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg vAlign=top width=10><IMG alt=��ͨ���� 
                        src="SkinIndex/article_common.gif"></TD>
                                    <TD class=listbg>[<A class=listA 
                        href="http://www.zz6789.com/Article/B/B4/Index.html">��һ��</A>]<A 
                        class=listA title=����������ʾ��þ�������� 
                        href="http://www.zz6789.com/Article/B/B4/200801/Article_20080116220438.html" 
                        target=_blank>����������ʾ��þ��������</A></TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg2 vAlign=top width=10><IMG alt=��ͨ���� 
                        src="SkinIndex/article_common.gif"></TD>
                                    <TD class=listbg2>[<A class=listA 
                        href="http://www.zz6789.com/Article/B/B2/Index.html">������</A>]<A 
                        class=listA title=���ɹ淶������Ϊ 
                        href="http://www.zz6789.com/Article/B/B2/200801/Article_20080116125154.html" 
                        target=_blank>���ɹ淶������Ϊ</A></TD>
                                  </TR>
                                  <TR></TR>
                                </TBODY>
                              </TABLE></TD>
                          </TR>
                        </TBODY>
                      </TABLE>
                    </DIV></TD>
                  <TD width=3>��</TD>
                  <TD background=SkinIndex/zin_r49_c1.gif height=200><DIV align=center>
                      <TABLE id=table12 height=27 cellSpacing=0 cellPadding=0 width="95%" 
            border=0>
                        <TBODY>
                          <TR>
                            <!--����1-->
                            <TD><TABLE cellSpacing=0 cellPadding=0 width="100%">
                                <TBODY>
                                  <TR>
                                    <TD class=listbg vAlign=top width=10><IMG alt=��ͨ���� 
                        src="SkinIndex/article_common.gif"></TD>
                                    <TD class=listbg>[<A class=listA 
                        href="http://www.zz6789.com/Article/F/F6/Index.html">�����п���</A>]<A 
                        class=listA title=2008�人���п����� 
                        href="http://www.zz6789.com/Article/F/F6/200807/Article_20080708231409.html" 
                        target=_blank>2008�人���п�����</A></TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg2 vAlign=top width=10><IMG alt=��ͨ���� 
                        src="SkinIndex/article_common.gif"></TD>
                                    <TD class=listbg2>[<A class=listA 
                        href="http://www.zz6789.com/Article/F/F6/Index.html">�����п���</A>]<A 
                        class=listA title=2007�人���п����� 
                        href="http://www.zz6789.com/Article/F/F6/200807/Article_20080708231328.html" 
                        target=_blank>2007�人���п�����</A></TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg vAlign=top width=10><IMG alt=��ͨ���� 
                        src="SkinIndex/article_common.gif"></TD>
                                    <TD class=listbg>[<A class=listA 
                        href="http://www.zz6789.com/Article/F/F6/Index.html">�����п���</A>]<A 
                        class=listA title=2008����ʡʮ�����п�˼��Ʒ���Ծ��� 
                        href="http://www.zz6789.com/Article/F/F6/200807/Article_20080704001616.html" 
                        target=_blank>2008����ʡʮ�����п�˼��Ʒ����</A></TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg2 vAlign=top width=10><IMG alt=��ͨ���� 
                        src="SkinIndex/article_common.gif"></TD>
                                    <TD class=listbg2>[<A class=listA 
                        href="http://www.zz6789.com/Article/F/F1/Index.html">�п���Ϣ</A>]<A 
                        class=listA title=����������2008���п���ʷ���� 
                        href="http://www.zz6789.com/Article/F/F1/200807/Article_20080703102040.html" 
                        target=_blank>����������2008���п���ʷ����</A></TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg vAlign=top width=10><IMG alt=��ͨ���� 
                        src="SkinIndex/article_common.gif"></TD>
                                    <TD class=listbg>[<A class=listA 
                        href="http://www.zz6789.com/Article/F/F4/Index.html">�п�����</A>]<A 
                        class=listA title=��������п������� 
                        href="http://www.zz6789.com/Article/F/F4/200807/Article_20080703101429.html" 
                        target=_blank>��������п�������</A></TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg2 vAlign=top width=10><IMG alt=��ͨ���� 
                        src="SkinIndex/article_common.gif"></TD>
                                    <TD class=listbg2>[<A class=listA 
                        href="http://www.zz6789.com/Article/F/F5/Index.html">�п�ģ����</A>]<A 
                        class=listA title=2008���п�����ģ������ 
                        href="http://www.zz6789.com/Article/F/F5/200807/Article_20080702075952.html" 
                        target=_blank>2008���п�����ģ������</A></TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg vAlign=top width=10><IMG alt=�Ƽ����� 
                        src="SkinIndex/article_elite.gif"></TD>
                                    <TD class=listbg>[<A class=listA 
                        href="http://www.zz6789.com/Article/F/F4/Index.html">�п�����</A>]<A 
                        class=listA title=��5&#8226;12�������п�ר�� 
                        href="http://www.zz6789.com/Article/F/F4/200806/Article_20080618105103.html" 
                        target=_blank>��5&#8226;12�������п�ר��</A></TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg2 vAlign=top width=10><IMG alt=�Ƽ����� 
                        src="SkinIndex/article_elite.gif"></TD>
                                    <TD class=listbg2>[<A class=listA 
                        href="http://www.zz6789.com/Article/F/F4/Index.html">�п�����</A>]<A 
                        class=listA title=2008�п�����ʱ�����αر����⾫ѡ 
                        href="http://www.zz6789.com/Article/F/F4/200806/Article_20080615103602.html" 
                        target=_blank>2008�п�����ʱ�����αر����⾫</A></TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg vAlign=top width=10><IMG alt=�Ƽ����� 
                        src="SkinIndex/article_elite.gif"></TD>
                                    <TD class=listbg>[<A class=listA 
                        href="http://www.zz6789.com/Article/F/F4/Index.html">�п�����</A>]<A 
                        class=listA title=ר��ʮһ&nbsp;&nbsp;&nbsp;�����裬�ջ�ж� 
                        href="http://www.zz6789.com/Article/F/F4/200806/Article_20080615103132.html" 
                        target=_blank>ר��ʮһ&nbsp;&nbsp;&nbsp;�����裬�ջ�ж�</A></TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg2 vAlign=top width=10><IMG alt=�Ƽ����� 
                        src="SkinIndex/article_elite.gif"></TD>
                                    <TD class=listbg2>[<A class=listA 
                        href="http://www.zz6789.com/Article/F/F4/Index.html">�п�����</A>]<A 
                        class=listA title=ר��ʮ&nbsp;&nbsp;����ĸ￪��30���� 
                        href="http://www.zz6789.com/Article/F/F4/200806/Article_20080615103114.html" 
                        target=_blank>ר��ʮ&nbsp;&nbsp;����ĸ￪��30����</A></TD>
                                  </TR>
                                  <TR></TR>
                                </TBODY>
                              </TABLE></TD>
                          </TR>
                        </TBODY>
                      </TABLE>
                    </DIV></TD>
                </TR>
                <TR>
                  <TD height=17><IMG height=17 src="SkinIndex/zin_r50_c1.gif" 
            width=287 border=0></TD>
                  <TD width=3>��</TD>
                  <TD height=17><IMG height=17 src="SkinIndex/zin_r50_c1.gif" 
            width=287 border=0></TD>
                </TR>
              </TBODY>
            </TABLE>
            <TABLE id=table8 cellSpacing=0 cellPadding=0 width=577 border=0>
              <TBODY>
                <TR>
                  <TD width=287 background=SkinIndex/zin_r48_c1.gif 
            height=48><B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;���ʲ�����</B></TD>
                  <TD width=3>��</TD>
                  <TD width=287 background=SkinIndex/zin_r48_c1.gif 
            height=48><B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��ѧ�о�</B></TD>
                </TR>
                <TR>
                  <TD background=SkinIndex/zin_r49_c1.gif height=200><DIV align=center>
                      <TABLE id=table12 height=27 cellSpacing=0 cellPadding=0 width="95%" 
            border=0>
                        <TBODY>
                          <TR>
                            <!--����1-->
                            <TD><TABLE cellSpacing=0 cellPadding=0 width="100%">
                                <TBODY>
                                  <TR>
                                    <TD class=listbg vAlign=top width=10><IMG alt=��ͨ���� 
                        src="SkinIndex/article_common.gif"></TD>
                                    <TD class=listbg>[<A class=listA 
                        href="http://www.zz6789.com/Article/C/C4/Index.html">��һ��</A>]<A 
                        class=listA title=���лῼ&nbsp;��3��&nbsp;��Ʒ�ļ�ֵ��&nbsp;ѧ�� 
                        href="http://www.zz6789.com/Article/C/C4/200809/Article_20080909204605.html" 
                        target=_blank>���лῼ&nbsp;��3��&nbsp;��Ʒ�ļ�ֵ��&nbsp;ѧ</A></TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg2 vAlign=top width=10><IMG alt=��ͨ���� 
                        src="SkinIndex/article_common.gif"></TD>
                                    <TD class=listbg2>[<A class=listA 
                        href="http://www.zz6789.com/Article/C/C4/Index.html">��һ��</A>]<A 
                        class=listA title=�ῼ-���ó�ʶ��1��2��ѧ�� 
                        href="http://www.zz6789.com/Article/C/C4/200809/Article_20080909204139.html" 
                        target=_blank>�ῼ-���ó�ʶ��1��2��ѧ��</A></TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg vAlign=top width=10><IMG alt=��ͨ���� 
                        src="SkinIndex/article_common.gif"></TD>
                                    <TD class=listbg>[<A class=listA 
                        href="http://www.zz6789.com/Article/C/C1/Index.html">��һ��</A>]<A 
                        class=listA title=���̰�˼��Ʒ�°��꼶���ϲᣩ�����Ծ� 
                        href="http://www.zz6789.com/Article/C/C1/200809/Article_20080908105626.html" 
                        target=_blank>���̰�˼��Ʒ�°��꼶���ϲᣩ��</A></TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg2 vAlign=top width=10><IMG alt=��ͨ���� 
                        src="SkinIndex/article_common.gif"></TD>
                                    <TD class=listbg2>[<A class=listA 
                        href="http://www.zz6789.com/Article/C/C3/Index.html">������</A>]<A 
                        class=listA title=����ʡ�˺���ѧ���꼶��һ��Ԫ˼��Ʒ�²��� 
                        href="http://www.zz6789.com/Article/C/C3/200809/Article_20080905081954.html" 
                        target=_blank>����ʡ�˺���ѧ���꼶��һ��Ԫ˼</A></TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg vAlign=top width=10><IMG alt=��ͨ���� 
                        src="SkinIndex/article_common.gif"></TD>
                                    <TD class=listbg>[<A class=listA 
                        href="http://www.zz6789.com/Article/C/C5/Index.html">�߶���</A>]<A 
                        class=listA title=����ʡ2008��6�¸��лῼģ�⿼�� 
                        href="http://www.zz6789.com/Article/C/C5/200808/Article_20080831115535.html" 
                        target=_blank>����ʡ2008��6�¸��лῼģ�⿼��</A></TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg2 vAlign=top width=10><IMG alt=�Ƽ����� 
                        src="SkinIndex/article_elite.gif"></TD>
                                    <TD class=listbg2>[<A class=listA 
                        href="http://www.zz6789.com/Article/C/C3/Index.html">������</A>]<A 
                        class=listA title=�п�ָ�� 
                        href="http://www.zz6789.com/Article/C/C3/200808/Article_20080819203053.html" 
                        target=_blank>�п�ָ��</A></TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg vAlign=top width=10><IMG alt=��ͨ���� 
                        src="SkinIndex/article_common.gif"></TD>
                                    <TD class=listbg>[<A class=listA 
                        href="http://www.zz6789.com/Article/C/C3/Index.html">������</A>]<A 
                        class=listA title=2007���ս�����п��ر�����֪ʶ 
                        href="http://www.zz6789.com/Article/C/C3/200808/Article_20080806223009.html" 
                        target=_blank>2007���ս�����п��ر�����֪ʶ</A></TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg2 vAlign=top width=10><IMG alt=��ͨ���� 
                        src="SkinIndex/article_common.gif"></TD>
                                    <TD class=listbg2>[<A class=listA 
                        href="http://www.zz6789.com/Article/C/C3/Index.html">������</A>]<A 
                        class=listA title=�����������п�����������ο��� 
                        href="http://www.zz6789.com/Article/C/C3/200807/Article_20080702203650.html" 
                        target=_blank>�����������п�����������ο���</A></TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg vAlign=top width=10><IMG alt=��ͨ���� 
                        src="SkinIndex/article_common.gif"></TD>
                                    <TD class=listbg>[<A class=listA 
                        href="http://www.zz6789.com/Article/C/C3/Index.html">������</A>]<A 
                        class=listA title=���п��Գ����������� 
                        href="http://www.zz6789.com/Article/C/C3/200807/Article_20080702203010.html" 
                        target=_blank>���п��Գ�����������</A></TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg2 vAlign=top width=10><IMG alt=��ͨ���� 
                        src="SkinIndex/article_common.gif"></TD>
                                    <TD class=listbg2>[<A class=listA 
                        href="http://www.zz6789.com/Article/C/C3/Index.html">������</A>]<A 
                        class=listA title=���п��Գ����������� 
                        href="http://www.zz6789.com/Article/C/C3/200807/Article_20080702202743.html" 
                        target=_blank>���п��Գ�����������</A></TD>
                                  </TR>
                                  <TR></TR>
                                </TBODY>
                              </TABLE></TD>
                          </TR>
                        </TBODY>
                      </TABLE>
                    </DIV></TD>
                  <TD width=3>��</TD>
                  <TD background=SkinIndex/zin_r49_c1.gif height=200><DIV align=center>
                      <TABLE id=table12 height=27 cellSpacing=0 cellPadding=0 width="95%" 
            border=0>
                        <TBODY>
                          <TR>
                            <!--����1-->
                            <TD><TABLE cellSpacing=0 cellPadding=0 width="100%">
                                <TBODY>
                                  <TR>
                                    <TD class=listbg vAlign=top width=10><IMG alt=��ͨ���� 
                        src="SkinIndex/article_common.gif"></TD>
                                    <TD class=listbg>[<A class=listA 
                        href="http://www.zz6789.com/Article/H/H1/Index.html">��ѧ�ĵ�</A>]<A 
                        class=listA title=ǳ̸��ѧ������������ 
                        href="http://www.zz6789.com/Article/H/H1/200809/Article_20080908211924.html" 
                        target=_blank>ǳ̸��ѧ������������</A></TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg2 vAlign=top width=10><IMG alt=��ͨ���� 
                        src="SkinIndex/article_common.gif"></TD>
                                    <TD class=listbg2>[<A class=listA 
                        href="http://www.zz6789.com/Article/H/H1/Index.html">��ѧ�ĵ�</A>]<A 
                        class=listA title=�ó���˼��Ʒ�¿ν�ѧ��� 
                        href="http://www.zz6789.com/Article/H/H1/200809/Article_20080905142959.html" 
                        target=_blank>�ó���˼��Ʒ�¿ν�ѧ���</A></TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg vAlign=top width=10><IMG alt=��ͨ���� 
                        src="SkinIndex/article_common.gif"></TD>
                                    <TD class=listbg>[<A class=listA 
                        href="http://www.zz6789.com/Article/H/H1/Index.html">��ѧ�ĵ�</A>]<A 
                        class=listA title=����ļ�ֵ 
                        href="http://www.zz6789.com/Article/H/H1/200808/Article_20080803105903.html" 
                        target=_blank>����ļ�ֵ</A></TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg2 vAlign=top width=10><IMG alt=��ͨ���� 
                        src="SkinIndex/article_common.gif"></TD>
                                    <TD class=listbg2>[<A class=listA 
                        href="http://www.zz6789.com/Article/H/H1/Index.html">��ѧ�ĵ�</A>]<A 
                        class=listA title=ǳ̸˼�����ο��е�������� 
                        href="http://www.zz6789.com/Article/H/H1/200807/Article_20080730230051.html" 
                        target=_blank>ǳ̸˼�����ο��е��������</A></TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg vAlign=top width=10><IMG alt=��ͨ���� 
                        src="SkinIndex/article_common.gif"></TD>
                                    <TD class=listbg>[<A class=listA 
                        href="http://www.zz6789.com/Article/H/H1/Index.html">��ѧ�ĵ�</A>]<A 
                        class=listA title=�Ż����ýṹ�������Ч���� 
                        href="http://www.zz6789.com/Article/H/H1/200807/Article_20080717154422.html" 
                        target=_blank>�Ż����ýṹ�������Ч����</A></TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg2 vAlign=top width=10><IMG alt=��ͨ���� 
                        src="SkinIndex/article_common.gif"></TD>
                                    <TD class=listbg2>[<A class=listA 
                        href="http://www.zz6789.com/Article/H/H1/Index.html">��ѧ�ĵ�</A>]<A 
                        class=listA title=˼��Ʒ�¿����������ʽ 
                        href="http://www.zz6789.com/Article/H/H1/200807/Article_20080717145918.html" 
                        target=_blank>˼��Ʒ�¿����������ʽ</A></TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg vAlign=top width=10><IMG alt=��ͨ���� 
                        src="SkinIndex/article_common.gif"></TD>
                                    <TD class=listbg>[<A class=listA 
                        href="http://www.zz6789.com/Article/H/H1/Index.html">��ѧ�ĵ�</A>]<A 
                        class=listA title=˼�����ο�Ӧ������Ϊ˼��Ʒ�½����� 
                        href="http://www.zz6789.com/Article/H/H1/200805/Article_20080521165423.html" 
                        target=_blank>˼�����ο�Ӧ������Ϊ˼��Ʒ�½�</A></TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg2 vAlign=top width=10><IMG alt=��ͨ���� 
                        src="SkinIndex/article_common.gif"></TD>
                                    <TD class=listbg2>[<A class=listA 
                        href="http://www.zz6789.com/Article/H/H3/Index.html">�о��ɹ�</A>]<A 
                        class=listA title=��ѧ˼��Ʒ�¿�������ѧģʽ̽�� 
                        href="http://www.zz6789.com/Article/H/H3/200805/Article_20080518184417.html" 
                        target=_blank>��ѧ˼��Ʒ�¿�������ѧģʽ̽��</A></TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg vAlign=top width=10><IMG alt=��ͨ���� 
                        src="SkinIndex/article_common.gif"></TD>
                                    <TD class=listbg>[<A class=listA 
                        href="http://www.zz6789.com/Article/H/H1/Index.html">��ѧ�ĵ�</A>]<A 
                        class=listA title=�ü����˼����ȼ���ο��� 
                        href="http://www.zz6789.com/Article/H/H1/200805/Article_20080518183930.html" 
                        target=_blank>�ü����˼����ȼ���ο���</A></TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg2 vAlign=top width=10><IMG alt=��ͨ���� 
                        src="SkinIndex/article_common.gif"></TD>
                                    <TD class=listbg2>[<A class=listA 
                        href="http://www.zz6789.com/Article/H/H3/Index.html">�о��ɹ�</A>]<A 
                        class=listA title=ѧϰǨ�����ۼ��ڽ�ѧ�������о� 
                        href="http://www.zz6789.com/Article/H/H3/200804/Article_20080420212903.html" 
                        target=_blank>ѧϰǨ�����ۼ��ڽ�ѧ�������о�</A></TD>
                                  </TR>
                                  <TR></TR>
                                </TBODY>
                              </TABLE></TD>
                          </TR>
                        </TBODY>
                      </TABLE>
                    </DIV></TD>
                </TR>
                <TR>
                  <TD height=17><IMG height=17 src="SkinIndex/zin_r50_c1.gif" 
            width=287 border=0></TD>
                  <TD width=3>��</TD>
                  <TD height=17><IMG height=17 src="SkinIndex/zin_r50_c1.gif" 
            width=287 border=0></TD>
                </TR>
              </TBODY>
            </TABLE></TD>
          <TD width=8>��</TD>
        </TR>
      </TBODY>
    </TABLE>
  </DIV>
  <DIV align=center>
    <TABLE id=table7 cellSpacing=0 cellPadding=0 width=797 
background=SkinIndex/new_wow_43.jpg border=0>
      <TBODY>
        <TR>
          <TD width=8 rowSpan=3>��</TD>
          <TD width=781 bgColor=#ffffff height=22><IMG height=21 
      src="SkinIndex/zin_r39_c2.gif" width=781 border=0></TD>
          <TD width=8 rowSpan=3>��</TD>
        </TR>
        <TR>
          <TD align=middle width=781 background=SkinIndex/zin_r42_c12.gif 
    bgColor=#ffffff height=60><TABLE cellSpacing=5 cellPadding=0 width="100%" align=center border=0>
              <TBODY>
                <TR vAlign=top>
                  <TD align=middle><A class="" 
            title="ͼƬ���ƣ�1QW&#13;&#10;��&nbsp;&nbsp;&nbsp;&nbsp;�ߣ�letian1971&#13;&#10;����ʱ�䣺2008-8-4 15:58:20" 
            href="http://www.zz6789.com/Photo/Y/200808/Photo_20080804155820.html" 
            target=_blank><IMG class=pic3 height=90 
            src="SkinIndex/20080804155817692.jpg" width=110 
            border=0></A><BR>
                    <A class="" 
            title="ͼƬ���ƣ�1QW&#13;&#10;��&nbsp;&nbsp;&nbsp;&nbsp;�ߣ�letian1971&#13;&#10;����ʱ�䣺2008-8-4 15:58:20" 
            href="http://www.zz6789.com/Photo/Y/200808/Photo_20080804155820.html" 
            target=_blank>1QW</A></TD>
                  <TD align=middle><A class="" 
            title="ͼƬ���ƣ�123&#13;&#10;��&nbsp;&nbsp;&nbsp;&nbsp;�ߣ�����&#13;&#10;����ʱ�䣺2008-8-4 15:56:32" 
            href="http://www.zz6789.com/Photo/S/200808/Photo_20080804155632.html" 
            target=_blank><IMG class=pic3 height=90 
            src="SkinIndex/20080804155628425.jpg" width=110 
            border=0></A><BR>
                    <A class="" 
            title="ͼƬ���ƣ�123&#13;&#10;��&nbsp;&nbsp;&nbsp;&nbsp;�ߣ�����&#13;&#10;����ʱ�䣺2008-8-4 15:56:32" 
            href="http://www.zz6789.com/Photo/S/200808/Photo_20080804155632.html" 
            target=_blank>123</A></TD>
                  <TD align=middle><A class="" 
            title="ͼƬ���ƣ�123&#13;&#10;��&nbsp;&nbsp;&nbsp;&nbsp;�ߣ�����&#13;&#10;����ʱ�䣺2008-8-4 15:54:51" 
            href="http://www.zz6789.com/Photo/S/200808/Photo_20080804155451.html" 
            target=_blank><IMG class=pic3 height=90 
            src="SkinIndex/20080804155335962.jpg" width=110 
            border=0></A><BR>
                    <A class="" 
            title="ͼƬ���ƣ�123&#13;&#10;��&nbsp;&nbsp;&nbsp;&nbsp;�ߣ�����&#13;&#10;����ʱ�䣺2008-8-4 15:54:51" 
            href="http://www.zz6789.com/Photo/S/200808/Photo_20080804155451.html" 
            target=_blank>123</A></TD>
                  <TD align=middle><A class="" 
            title="ͼƬ���ƣ����˵ļ�ǿ������־Ը���ĵ���һĻ(��ͼ)&#13;&#10;��&nbsp;&nbsp;&nbsp;&nbsp;�ߣ��»���(����)&#13;&#10;����ʱ�䣺2008-6-26 8:47:21" 
            href="http://www.zz6789.com/Photo/S/200806/Photo_20080626084721.html" 
            target=_blank><IMG class=pic3 height=90 
            src="SkinIndex/20080626084751345.jpg" width=110 
            border=0></A><BR>
                    <A class="" 
            title="ͼƬ���ƣ����˵ļ�ǿ������־Ը���ĵ���һĻ(��ͼ)&#13;&#10;��&nbsp;&nbsp;&nbsp;&nbsp;�ߣ��»���(����)&#13;&#10;����ʱ�䣺2008-6-26 8:47:21" 
            href="http://www.zz6789.com/Photo/S/200806/Photo_20080626084721.html" 
            target=_blank>���˵ļ�ǿ������</A></TD>
                  <TD align=middle><A class="" 
            title="ͼƬ���ƣ���ȸ��С������һ�㲻��(ͼ)&#13;&#10;��&nbsp;&nbsp;&nbsp;&nbsp;�ߣ����&#13;&#10;����ʱ�䣺2008-6-26 8:43:52" 
            href="http://www.zz6789.com/Photo/Q/200806/Photo_20080626084352.html" 
            target=_blank><IMG class=pic3 height=90 
            src="SkinIndex/20080626084412185.jpg" width=110 
            border=0></A><BR>
                    <A class="" 
            title="ͼƬ���ƣ���ȸ��С������һ�㲻��(ͼ)&#13;&#10;��&nbsp;&nbsp;&nbsp;&nbsp;�ߣ����&#13;&#10;����ʱ�䣺2008-6-26 8:43:52" 
            href="http://www.zz6789.com/Photo/Q/200806/Photo_20080626084352.html" 
            target=_blank>��ȸ��С������һ</A></TD>
                  <TD align=middle><A class="" 
            title="ͼƬ���ƣ����������������ͳ��ԭ[��ͼ]&#13;&#10;��&nbsp;&nbsp;&nbsp;&nbsp;�ߣ��ޱ���/��Ӱ&#13;&#10;����ʱ�䣺2008-6-26 8:38:52" 
            href="http://www.zz6789.com/Photo/V/200806/Photo_20080626083852.html" 
            target=_blank><IMG class=pic3 height=90 
            src="SkinIndex/20080626084005909.jpg" width=110 
            border=0></A><BR>
                    <A class="" 
            title="ͼƬ���ƣ����������������ͳ��ԭ[��ͼ]&#13;&#10;��&nbsp;&nbsp;&nbsp;&nbsp;�ߣ��ޱ���/��Ӱ&#13;&#10;����ʱ�䣺2008-6-26 8:38:52" 
            href="http://www.zz6789.com/Photo/V/200806/Photo_20080626083852.html" 
            target=_blank>���������������</A></TD>
                </TR>
                <TR vAlign=top>
                  <TD align=middle><A class="" 
            title="ͼƬ���ƣ���6��26�����ա����߽��䶾��(��ͼ)&#13;&#10;��&nbsp;&nbsp;&nbsp;&nbsp;�ߣ��������� ��ǿ ��Ӱ���� �ź�&#13;&#10;����ʱ�䣺2008-6-26 8:22:48" 
            href="http://www.zz6789.com/Photo/R/200806/Photo_20080626082248.html" 
            target=_blank><IMG class=pic3 height=90 
            src="SkinIndex/20080626082440715.jpg" width=110 
            border=0></A><BR>
                    <A class="" 
            title="ͼƬ���ƣ���6��26�����ա����߽��䶾��(��ͼ)&#13;&#10;��&nbsp;&nbsp;&nbsp;&nbsp;�ߣ��������� ��ǿ ��Ӱ���� �ź�&#13;&#10;����ʱ�䣺2008-6-26 8:22:48" 
            href="http://www.zz6789.com/Photo/R/200806/Photo_20080626082248.html" 
            target=_blank>��6��26�����ա���</A></TD>
                  <TD align=middle><A class="" 
            title="ͼƬ���ƣ���Ŀ���ģ������Ϸ�ˮ������(��ͼ)&#13;&#10;��&nbsp;&nbsp;&nbsp;&nbsp;�ߣ����Ѻ�ˮ&#13;&#10;����ʱ�䣺2008-6-26 8:15:17" 
            href="http://www.zz6789.com/Photo/T/200806/Photo_20080626081517.html" 
            target=_blank><IMG class=pic3 height=90 
            src="SkinIndex/20080626081941393.jpg" width=110 
            border=0></A><BR>
                    <A class="" 
            title="ͼƬ���ƣ���Ŀ���ģ������Ϸ�ˮ������(��ͼ)&#13;&#10;��&nbsp;&nbsp;&nbsp;&nbsp;�ߣ����Ѻ�ˮ&#13;&#10;����ʱ�䣺2008-6-26 8:15:17" 
            href="http://www.zz6789.com/Photo/T/200806/Photo_20080626081517.html" 
            target=_blank>��Ŀ���ģ�������</A></TD>
                  <TD align=middle><A class="" 
            title="ͼƬ���ƣ����������������ǿ�ľ���������&#13;&#10;��&nbsp;&nbsp;&nbsp;&nbsp;�ߣ������緢 ���� ��&#13;&#10;����ʱ�䣺2005-12-30 8:53:19" 
            href="http://www.zz6789.com/Photo/W/200512/Photo_20051230085319.html" 
            target=_blank><IMG class=pic3 height=90 
            src="SkinIndex/20080530090603933.jpg" width=110 
            border=0></A><BR>
                    <A class="" 
            title="ͼƬ���ƣ����������������ǿ�ľ���������&#13;&#10;��&nbsp;&nbsp;&nbsp;&nbsp;�ߣ������緢 ���� ��&#13;&#10;����ʱ�䣺2005-12-30 8:53:19" 
            href="http://www.zz6789.com/Photo/W/200512/Photo_20051230085319.html" 
            target=_blank>���������������</A></TD>
                  <TD align=middle><A class="" 
            title="ͼƬ���ƣ�̨���׸���̨������������Ԫ�����ɶ�����è(ͼ)&#13;&#10;��&nbsp;&nbsp;&nbsp;&nbsp;�ߣ������緢 ��Ʒ� ��&#13;&#10;����ʱ�䣺2008-5-6 10:45:21" 
            href="http://www.zz6789.com/Photo/200805/Photo_20080506104521.html" 
            target=_blank><IMG class=pic3 height=90 
            src="SkinIndex/20080506104542644.jpg" width=110 
            border=0></A><BR>
                    <A class="" 
            title="ͼƬ���ƣ�̨���׸���̨������������Ԫ�����ɶ�����è(ͼ)&#13;&#10;��&nbsp;&nbsp;&nbsp;&nbsp;�ߣ������緢 ��Ʒ� ��&#13;&#10;����ʱ�䣺2008-5-6 10:45:21" 
            href="http://www.zz6789.com/Photo/200805/Photo_20080506104521.html" 
            target=_blank>̨���׸���̨����</A></TD>
                  <TD align=middle><A class="" 
            title="ͼƬ���ƣ���ս�ι۷�����Ͽ����(��ͼ)&#13;&#10;��&nbsp;&nbsp;&nbsp;&nbsp;�ߣ�������(����)����ƽ ��&#13;&#10;����ʱ�䣺2008-5-6 10:10:24" 
            href="http://www.zz6789.com/Photo/U/200805/Photo_20080506101024.html" 
            target=_blank><IMG class=pic3 height=90 
            src="SkinIndex/20080506102938436.jpg" width=110 
            border=0></A><BR>
                    <A class="" 
            title="ͼƬ���ƣ���ս�ι۷�����Ͽ����(��ͼ)&#13;&#10;��&nbsp;&nbsp;&nbsp;&nbsp;�ߣ�������(����)����ƽ ��&#13;&#10;����ʱ�䣺2008-5-6 10:10:24" 
            href="http://www.zz6789.com/Photo/U/200805/Photo_20080506101024.html" 
            target=_blank>��ս�ι۷�����Ͽ</A></TD>
                  <TD align=middle><A class="" 
            title="ͼƬ���ƣ������м�ί����һǰ������������&#13;&#10;��&nbsp;&nbsp;&nbsp;&nbsp;�ߣ�������(����)&#13;&#10;����ʱ�䣺2008-5-6 9:39:56" 
            href="http://www.zz6789.com/Photo/U/200805/Photo_20080506093956.html" 
            target=_blank><IMG class=pic3 height=90 
            src="SkinIndex/20080506100822292.jpg" width=110 
            border=0></A><BR>
                    <A class="" 
            title="ͼƬ���ƣ������м�ί����һǰ������������&#13;&#10;��&nbsp;&nbsp;&nbsp;&nbsp;�ߣ�������(����)&#13;&#10;����ʱ�䣺2008-5-6 9:39:56" 
            href="http://www.zz6789.com/Photo/U/200805/Photo_20080506093956.html" 
            target=_blank>�����м�ί����һ</A></TD>
                </TR>
              </TBODY>
            </TABLE></TD>
        </TR>
        <TR>
          <TD width=781 bgColor=#ffffff height=22><IMG height=19 
      src="SkinIndex/zin_r41_c2.gif" width=781 
border=0></TD>
        </TR>
      </TBODY>
    </TABLE>
  </DIV>
  <DIV align=center>
    <TABLE id=table7 height=100 cellSpacing=0 cellPadding=0 width=797 
background=SkinIndex/new_wow_43.jpg border=0>
      <TBODY>
        <TR>
          <TD width=8>��</TD>
          <TD vAlign=top align=middle width=197 bgColor=#ffffff><TABLE id=table5 height=200 cellSpacing=0 cellPadding=0 width=197 
border=0>
              <TBODY>
                <TR>
                  <TD background=SkinIndex/zdl_8.gif height=35><P align=center><B>�� վ ͳ ��</B></P></TD>
                </TR>
                <TR>
                  <TD height=24><IMG height=24 src="SkinIndex/zin_r11_c1.gif" 
            width=197 border=0></TD>
                </TR>
                <TR>
                  <TD align=middle background=SkinIndex/zin_r13_c1.gif>���пγ̣�1046 
                    ƪ����<BR>
                    �������ģ�23721 ƪ����<BR>
                    �μ����ģ�2583 ���μ�<BR>
                    ͼƬ���ģ�6550 ��ͼƬ<BR>
                    ���������0 
                    �����<BR>
                    ע���Ա��156394λ<BR>
                    <SCRIPT src="SkinIndex/CounterLink.htm"></SCRIPT>
                  </TD>
                </TR>
                <TR>
                  <TD height=24><IMG height=25 src="SkinIndex/zin_r18_c1.gif" 
            width=197 border=0></TD>
                </TR>
              </TBODY>
            </TABLE></TD>
          <TD vAlign=top align=middle width=584 bgColor=#ffffff><TABLE id=table8 cellSpacing=0 cellPadding=0 width=577 border=0>
              <TBODY>
                <TR>
                  <TD width=287 background=SkinIndex/zin_r48_c1.gif 
            height=48><B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�Ƽ��μ�</B></TD>
                  <TD width=3>��</TD>
                  <TD width=287 background=SkinIndex/zin_r48_c1.gif 
            height=48><B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;�ȵ�μ�</B></TD>
                </TR>
                <TR>
                  <TD background=SkinIndex/zin_r49_c1.gif height=200><DIV align=center>
                      <TABLE id=table12 height=27 cellSpacing=0 cellPadding=0 width="95%" 
            border=0>
                        <TBODY>
                          <TR>
                            <!--�Ƽ��μ�-->
                            <TD><TABLE cellSpacing=0 cellPadding=0 width="100%">
                                <TBODY>
                                  <TR>
                                    <TD class=listbg>[<A class=listA 
                        href="http://www.zz6789.com/Soft/Highclass/Politics/Levy05/Index.html">����� 
                                      �ҹ�������������ƶ�</A>]<A class=listA title=����������ƶ� 
                        href="http://www.zz6789.com/Soft/Highclass/Politics/Levy05/200807/Soft_3824.html" 
                        target=_blank>����������ƶ�</A></TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg2>[<A class=listA 
                        href="http://www.zz6789.com/Soft/JuniorClass/c3/Index.html">������</A>]<A 
                        class=listA title=08ר�⸴ϰ 
                        href="http://www.zz6789.com/Soft/JuniorClass/c3/200806/Soft_3822.html" 
                        target=_blank>08ר�⸴ϰ</A></TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg>[<A class=listA 
                        href="http://www.zz6789.com/Soft/JuniorClass/c2/Index.html">������</A>]<A 
                        class=listA title=08ר�⸴ϰ 
                        href="http://www.zz6789.com/Soft/JuniorClass/c2/200806/Soft_3821.html" 
                        target=_blank>08ר�⸴ϰ</A></TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg2>[<A class=listA 
                        href="http://www.zz6789.com/Soft/Highclass/Politics/Levy03/Index.html">������ 
                                      �ҹ����������������</A>]<A class=listA title=����Ϊ�������ѵ�ƽ����� 
                        href="http://www.zz6789.com/Soft/Highclass/Politics/Levy03/200805/Soft_3817.html" 
                        target=_blank>����Ϊ�������ѵ�ƽ�����</A></TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg>[<A class=listA 
                        href="http://www.zz6789.com/Soft/Highclass/Organize/Index.html">�����������֯</A>]<A 
                        class=listA title=���ҵı��� 
                        href="http://www.zz6789.com/Soft/Highclass/Organize/200805/Soft_3813.html" 
                        target=_blank>���ҵı���</A></TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg2>[<A class=listA 
                        href="http://www.zz6789.com/Soft/Highclass/Economy/Levy12/Index.html">��ʮ���� 
                                      ����ȫ������⿪��</A>]<A class=listA title=���������������ʾ��þ���PPT 
                        href="http://www.zz6789.com/Soft/Highclass/Economy/Levy12/200804/Soft_3807.html" 
                        target=_blank>���������������ʾ��þ���PPT</A></TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg>[<A class=listA 
                        href="http://www.zz6789.com/Soft/N/Index.html">���������μ�</A>]<A 
                        class=listA title=�������� 
                        href="http://www.zz6789.com/Soft/N/200804/Soft_3802.html" 
                        target=_blank>��������</A></TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg2>[<A class=listA 
                        href="http://www.zz6789.com/Soft/M/Index.html">��ϰר��μ�</A>]<A 
                        class=listA title=����������������⼼�� 
                        href="http://www.zz6789.com/Soft/M/200804/Soft_3799.html" 
                        target=_blank>����������������⼼��</A></TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg>[<A class=listA 
                        href="http://www.zz6789.com/Soft/JuniorClass/c2/Index.html">������</A>]<A 
                        class=listA title=������Υ 
                        href="http://www.zz6789.com/Soft/JuniorClass/c2/200804/Soft_3797.html" 
                        target=_blank>������Υ</A></TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg2>[<A class=listA 
                        href="http://www.zz6789.com/Soft/M/Index.html">��ϰר��μ�</A>]<A 
                        class=listA title=����ʮ�ߴ󱨸��� 
                        href="http://www.zz6789.com/Soft/M/200803/Soft_3794.html" 
                        target=_blank>����ʮ�ߴ󱨸���</A></TD>
                                  </TR>
                                  <TR></TR>
                                </TBODY>
                              </TABLE></TD>
                          </TR>
                        </TBODY>
                      </TABLE>
                    </DIV></TD>
                  <TD width=3>��</TD>
                  <TD background=SkinIndex/zin_r49_c1.gif height=200><DIV align=center>
                      <TABLE id=table12 height=27 cellSpacing=0 cellPadding=0 width="95%" 
            border=0>
                        <TBODY>
                          <TR>
                            <!--�ȵ�μ�-->
                            <TD><TABLE cellSpacing=0 cellPadding=0 width="100%">
                                <TBODY>
                                  <TR>
                                    <TD class=listbg>[<A class=listA 
                        href="http://www.zz6789.com/Soft/N/Index.html">���������μ�</A>]<A 
                        class=listA title=���� 
                        href="http://www.zz6789.com/Soft/N/200808/Soft_3828.html" 
                        target=_blank>����</A></TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg2>[<A class=listA 
                        href="http://www.zz6789.com/Soft/JuniorClass/c2/Index.html">������</A>]<A 
                        class=listA title=ƽ�ȴ��ˣ��ڶ���ʱ�� 
                        href="http://www.zz6789.com/Soft/JuniorClass/c2/200807/Soft_3827.html" 
                        target=_blank>ƽ�ȴ��ˣ��ڶ���ʱ��</A></TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg>[<A class=listA 
                        href="http://www.zz6789.com/Soft/JuniorClass/c2/Index.html">������</A>]<A 
                        class=listA title=ƽ�ȴ��ˣ���һ��ʱ�� 
                        href="http://www.zz6789.com/Soft/JuniorClass/c2/200807/Soft_3826.html" 
                        target=_blank>ƽ�ȴ��ˣ���һ��ʱ��</A></TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg2>[<A class=listA 
                        href="http://www.zz6789.com/Soft/JuniorClass/c2/Index.html">������</A>]<A 
                        class=listA title=�������� 
                        href="http://www.zz6789.com/Soft/JuniorClass/c2/200807/Soft_3825.html" 
                        target=_blank>��������</A></TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg>[<A class=listA 
                        href="http://www.zz6789.com/Soft/Highclass/Politics/Levy05/Index.html">����� 
                                      �ҹ�������������ƶ�</A>]<A class=listA title=����������ƶ� 
                        href="http://www.zz6789.com/Soft/Highclass/Politics/Levy05/200807/Soft_3824.html" 
                        target=_blank>����������ƶ�</A></TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg2>[<A class=listA 
                        href="http://www.zz6789.com/Soft/Highclass/Politics/Levy08/Index.html">�ڰ˿� 
                                      �߽��������</A>]<A class=listA title=���Ϲ� 
                        href="http://www.zz6789.com/Soft/Highclass/Politics/Levy08/200806/Soft_3823.html" 
                        target=_blank>���Ϲ�</A></TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg>[<A class=listA 
                        href="http://www.zz6789.com/Soft/JuniorClass/c3/Index.html">������</A>]<A 
                        class=listA title=08ר�⸴ϰ 
                        href="http://www.zz6789.com/Soft/JuniorClass/c3/200806/Soft_3822.html" 
                        target=_blank>08ר�⸴ϰ</A></TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg2>[<A class=listA 
                        href="http://www.zz6789.com/Soft/JuniorClass/c2/Index.html">������</A>]<A 
                        class=listA title=08ר�⸴ϰ 
                        href="http://www.zz6789.com/Soft/JuniorClass/c2/200806/Soft_3821.html" 
                        target=_blank>08ר�⸴ϰ</A></TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg>[<A class=listA 
                        href="http://www.zz6789.com/Soft/JuniorClass/c1/Index.html">��һ��</A>]<A 
                        class=listA title=������ջ� 
                        href="http://www.zz6789.com/Soft/JuniorClass/c1/200806/Soft_3820.html" 
                        target=_blank>������ջ�</A></TD>
                                  </TR>
                                  <TR>
                                    <TD class=listbg2>[<A class=listA 
                        href="http://www.zz6789.com/Soft/JuniorClass/c1/Index.html">��һ��</A>]<A 
                        class=listA title=������������-������������ 
                        href="http://www.zz6789.com/Soft/JuniorClass/c1/200806/Soft_3819.html" 
                        target=_blank>������������-������������</A></TD>
                                  </TR>
                                  <TR></TR>
                                </TBODY>
                              </TABLE></TD>
                          </TR>
                        </TBODY>
                      </TABLE>
                    </DIV></TD>
                </TR>
                <TR>
                  <TD height=17><IMG height=17 src="SkinIndex/zin_r50_c1.gif" 
            width=287 border=0></TD>
                  <TD width=3>��</TD>
                  <TD height=17><IMG height=17 src="SkinIndex/zin_r50_c1.gif" 
            width=287 border=0></TD>
                </TR>
              </TBODY>
            </TABLE></TD>
          <TD width=8>��</TD>
        </TR>
      </TBODY>
    </TABLE>
  </DIV>
  <DIV align=center>
    <TABLE id=table7 height=80 cellSpacing=0 cellPadding=0 width=797 
background=SkinIndex/new_wow_43.jpg border=0>
      <TBODY>
        <TR>
          <TD width=8>��</TD>
          <TD align=middle width=781 bgColor=#ffffff height=80><SCRIPT language=javascript src="SkinIndex/1.js"></SCRIPT>
          </TD>
          <TD width=8>��</TD>
        </TR>
      </TBODY>
    </TABLE>
  </DIV>
  <DIV align=center>
    <TABLE id=table7 height=100 cellSpacing=0 cellPadding=0 width=797 
background=SkinIndex/new_wow_43.jpg border=0>
      <TBODY>
        <TR>
          <TD width=8 rowSpan=2>��</TD>
          <TD width=781 bgColor=#c7b883 height=20><P align=center><B>|<SPAN style="CURSOR: hand" 
      onclick="var strHref=window.location.href;this.style.behavior='url(#default#homepage)';this.setHomePage('http://www.zz6789.com');">��Ϊ��ҳ</SPAN> | <SPAN title=��ѧ˼�����ν�ѧ�� style="CURSOR: hand" 
      onclick="window.external.addFavorite('http://www.zz6789.com','��ѧ˼�����ν�ѧ��')">�ղر�վ</SPAN> | <A class=Bottom href="mailto:16350310@QQ.COM">��ϵվ��</A> | <A class=Bottom 
      href="http://www.zz6789.com/FriendSite/Index.asp" target=_blank>��������</A> | <A class=Bottom href="http://www.zz6789.com/Copyright.asp" 
      target=_blank>��Ȩ����</A> | <A class=Bottom 
      href="http://www.zz6789.com/Adminzz/Admin_Index.asp" 
      target=_blank>�����¼</A>&nbsp;|&nbsp;</B></P></TD>
          <TD width=8 rowSpan=2>��</TD>
        </TR>
        <TR>
          <TD align=middle width=781 
      bgColor=#ffffff>��������ѧ˼�����ν�ѧ���о������졢ά��<BR>
            ��ICP��05017562��<BR>
            ��Ȩ����Copyright(C)2000-2006 </TD>
        </TR>
      </TBODY>
    </TABLE>
  </DIV>
  <DIV align=center>
    <TABLE id=table7 height=50 cellSpacing=0 cellPadding=0 width=797 border=0>
      <TBODY>
        <TR>
          <TD width=8>��</TD>
          <TD width=781>��</TD>
          <TD width=8>��</TD>
        </TR>
      </TBODY>
    </TABLE>
  </DIV>
  <SCRIPT language=Javascript src=""></SCRIPT>
</DIV>
</BODY>
</HTML>
