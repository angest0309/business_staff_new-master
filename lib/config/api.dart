class API {
  static const reqUrl = 'http://120.79.185.173:8080/check/';
  static const BOOK_URL = 'http://120.79.185.173:8080/resource/health/book.pdf';
  static const USER_LOGIN = 'common/login';
  static const CONFIRM_HEALTH = 'healthyInfomation/add_healthy';
  static const CONFIRM_ACTIVITY = 'workers/update.do';
  static const NEWS = 'news/list.do';
  static const INSTITUTE = 'admin_s/institute/list';
  static const REGISTER = 'workers/register.do';
  static const APPLY = 'applyCheck/addApply';
  static const GET_DEPHEADER_LIST = 'options/getDepHeaderList';
  static const GET_FUNDSLIST = 'options/getFundsList';
  static const GET_LEADERLIST = 'options/getLeaderList';
  static const GET_REASONLIST = 'options/getReasonList';
  static const GET_TRANSPORTBEYONDLIST = '/options/getTransportBeyondList';
  static const GET_TRANSPORTLIST = 'options/getTransportList';
  static const GET_HISLIST = 'applyCheck/getHisList';
  static var APPLY_LIST = "check/getCheckList";
  static const ABOLISH = "applyCheck/abolishApplication";
  static const All_USER_NAME = "applyCheck/getAllUserName";//获取所有用户姓名
  static const CHECK = "check/checkApp";//同意申请
  static const PDF = "export/getApplicationPdf";//获取出差申请Pdf表
  static const SUMMER = 'summer/addOrUpdateSummer';//创建或修改新的出差总结
  static const GET_ONESUMMER = 'summer/checkOneSummer';//查看某个特定的出差总结
  static const DEL_SUMMER_FILE = 'summer/deleteFile';//删除某个出差总结文件
  static const GET_SUMMERLIST = 'summer/selectSummers';//获取个人的所有的出差总结
  static const UPLOAD_SUMMER_FILE = 'summer/uploadFile';//上传某个出差文件
  static const DEL_SUMMER = 'summer/cancelSummary';//删除某个出差总结

  static const GET_APPLICATION = 'applyCheck/getOpenApplication';
}
    
