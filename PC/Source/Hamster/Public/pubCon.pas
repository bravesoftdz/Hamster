unit pubCon;

interface

const
  IDM_BUTTON_1 = 8101;
  IDM_BUTTON_2 = 8102;
  IDM_BUTTON_3 = 8103;
  IDM_BUTTON_4 = 8104;
  IDM_BUTTON_5 = 8105;
  IDM_BUTTON_6 = 8106;

  D_MAIN_URL = 'http://www.j1m1.com/index.php/hamster/login';  // Ĭ����ҳ
  //D_MAIN_URL = 'http://www.iqiyi.com/';
  D_TK_LOGIN = 'https://login.taobao.com/member/login.jhtml?style=mini&newMini2=true&from=alimama&redirectURL=http%3A%2F%2Fwww.alimama.com%2F&full_redirect=true&disableQuickLogin=true'; // ���������½��ַ
  D_TK_USER_INFO = 'http://pub.alimama.com/common/adzone/newSelfAdzone2.json?tag=29&_tb_token_=%s&_input_charset=utf-8';
  D_TK_API_ADZONECREATE = 'http://pub.alimama.com/common/adzone/selfAdzoneCreate.json'; // ������λ
  D_TK_API_GUIDEADD = 'http://pub.alimama.com/common/site/generalize/guideAdd.json'; // ��������λ
  D_TK_MMID = 'http://pub.alimama.com/common/adzone/adzoneManage.json?tab=3&toPage=%s&perPageSize=40&gcid=8&_tb_token_=%s&_input_charset=utf-8'; // ��ȡMMID
  //  D_TK_API_URLTRANS = 'http://pub.alimama.com/urltrans/urltrans.json?siteid=%s&adzoneid=%s&promotionURL=%s&_tb_token_=%s&_input_charset=utf-8';
  D_TK_API_URLTRANS ='http://pub.alimama.com/common/code/getAuctionCode.json?auctionid=%s&adzoneid=%s&siteid=%s&_tb_token_=%s&scenes=1';   // ��ȡ�Ա������ӽӿ�
  D_TK_GET_RPT = 'http://pub.alimama.com/report/mediaRptByPaging.json?gcId=8&siteId=%s&startTime=%s&endTime=%s&pageNo=1&pageSize=40&_tb_token_=%s&_input_charset=utf-8'; // ��ȡ��������
  D_TK_GET_RPT2= 'http://pub.alimama.com/report/mediaRpt.json?gcId=8&siteType=&siteId=%s&startTime=%s&endTime=%s&pvid=&_tb_token_=%s&_input_charset=utf-8';
  D_TK_GET_COMMONCAMPAIGNBYITEMID = 'http://pub.alimama.com/pubauc/getCommonCampaignByItemId.json?itemId=%s&_tb_token_=%s';// ��ȡ����ƻ��б���JSON��ʽ���أ�
  D_TK_APPLYFORCOMMONCAMPAIGN = 'http://pub.alimama.com/pubauc/applyForCommonCampaign.json'; // ���붨��ƻ�,POST��ʽ�ύ
  D_TK_PROMOTIONINFO = 'http://pub.alimama.com/pubauc/searchPromotionInfo.json?oriMemberId=%s&blockId=&_tb_token_=%S'; // ����MemberId��ȡ������Ϣ
  D_TK_SEARCH = 'http://pub.alimama.com/items/search.json?q=%s&_tb_token_=%s'; // ������Ʒ���ӻ�ȡ��Ʒ��Ϣ
  D_TK_EXCLE='http://pub.alimama.com/favorites/item/export.json?spm=%s&pvid=%s&actionid=%s&scenes=1&adzoneId=%s&siteId=s%&groupId=%s'; //����excle��ַ
  D_TK_USER_INFO2='http://pub.alimama.com/common/getUnionPubContextInfo.json' ;//��ȡ�����û���Ϣ
  D_TK_PROD_GROUP='http://pub.alimama.com/favorites/group/newList.json?toPage=1&perPageSize=50&keyword=&t=1498486218699&_tb_token_=KPgJkTJfHlq&pvid=11_183.94.119.48_2691_1498486218599';//��ȡѡƷ����Ϣ
  D_TK_SAVE_GROUP='http://pub.alimama.com/favorites/group/save.json' ;//����ѡƷ����� grouptype=1����ͨ���飬2�Ǹ�Ӷ����  FormData:groupTitle=aaaaa&groupType=2&t=1498487410150&_tb_token_=KPgJkTJfHlq&pvid=11_183.94.119.48_1352_1498487365903
  otherAdzones_name = '�����Կ�����';
  otherAdzones_sub_name = '�����Կ��ƹ�λ';

  regSoftPath = 'Software\Hamster';
implementation

end.


