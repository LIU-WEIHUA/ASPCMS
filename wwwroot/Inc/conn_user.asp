<%
dim UserTableType,Conn_User,db_bbs
UserTableType = "MyPower"					  ' "Dvbbs6.0" --- ���϶�����̳6.0
											  ' "Dvbbs6.1" --- ���϶�����̳6.1	
											  ' "MyPower"  --- ��������̳
db_bbs="database/user.mdb"      '���ݿ��ļ���λ��
Set Conn_User = Server.CreateObject("ADODB.Connection")
Conn_User.Open "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & Server.MapPath(db_bbs)

sub CloseConn_User()
	Conn_User.close
	set Conn_User=nothing
end sub

'MY�����붯����̳���õ��û����ݱ�
Const db_User_Table="[User]"

'MY�����붯����̳���õ��û��ֶ���
Const db_User_ID="UserID"						'�û�ID
Const db_User_Name="UserName"					'�û���
Const db_User_Sex="Sex"							'�Ա�

'����ѧԺ���ν̸���վ�������ֶ���

Const db_User_TrueName="TrueName"				'��ʵ����

Const db_User_StudentNumber="StudentNumber"		'ѧ��

Const db_User_StudentClass="StudentClass"						'�༶
Const db_User_College="College"					'ѧԺ
Const db_User_ArticleCommentScore="sum(ArticleComment.Score)"

'����������ѧԺ���ν̸���վ�������ֶ���
Const db_User_Email="UserEmail"					'Email��ַ
Const db_User_Homepage="homepage"				'��ҳ
Const db_User_QQ="Oicq"							'QQ
Const db_User_Icq="icq"							'Icq
Const db_User_Msn="msn"							'Msn
Const db_User_Password="UserPassword"			'����
Const db_User_Question="Quesion"				'�����������ʾ����
Const db_User_Answer="Answer"					'�����
Const db_User_Sign="sign"						'ǩ��
Const db_User_Face="face"						'ͷ��
Const db_User_FaceWidth="width"					'ͷ����
Const db_User_FaceHeight="height"				'ͷ��߶�
Const db_User_RegDate="addDate"					'ע������
Const db_User_LoginTimes="logins"				'��¼����
Const db_User_LastLoginTime="lastlogin"			'����¼ʱ��
Const db_User_LastLoginIP="UserLastIP"			'����¼IP
Const db_User_UserClass="userclass"				'��̳�û��ȼ�����¼ʱ�õ���


'MY����ʹ�õ��û��ֶ���
Const db_User_LockUser="lockuser"				'�Ƿ������û�
Const db_User_ArticleCount="ArticleCount"		'����������
Const db_User_ArticleChecked="ArticleChecked"	'�����������
Const db_User_UserLevel="UserLevel"				'�û��ȼ���Ȩ�ޣ�
Const db_User_UserPoint="UserPoint"				'�û�����
Const db_User_ChargeType="ChargeType"			'�Ʒѷ�ʽ
Const db_User_BeginDate="BeginDate"				'��ʼ����
Const db_User_Valid_Num="Valid_Num"				'��Ч����ֵ
Const db_User_Valid_Unit="Valid_Unit"			'��Ч�ڵ�λ


'������̳ʹ�õ��û��ֶ���
Const db_User_BbsType="bbstype"
Const db_User_Article="Article"
Const db_User_UserGroup="UserGroup"
Const db_User_UserWealth="userWealth"
Const db_User_UserEP="userEP"
Const db_User_UserCP="userCP"
Const db_User_Title="title"
Const db_User_Showre="showre"
Const db_User_Reann="reann"
Const db_User_UserCookies="usercookies"
Const db_User_Birthday="birthday"
Const db_User_UserPhoto="UserPhoto"
Const db_User_UserPower="UserPower"
Const db_User_UserDel="UserDel"
Const db_User_UserIsBest="UserIsBest"
Const db_User_UserInfo="UserInfo"
Const db_User_UserSetting="UserSetting"
Const db_User_UserGroupID="UserGroupID"
Const db_User_TitlePic="TitlePic"
%>

