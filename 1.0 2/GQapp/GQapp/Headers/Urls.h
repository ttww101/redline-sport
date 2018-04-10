//
//  Urls.h
//  GunQiuLive
//
//  Created by WQ_h on 15/12/22.
//  Copyright (c) 2015年 WQ_h. All rights reserved.
//

#ifndef GunQiuLive_Urls_h
#define GunQiuLive_Urls_h


// http://60.191.221.30:8092/ 或者 http://www.gunqiu.com/interface/
//服务器
//10.0.80.29:8088本地
//球队图片
#define url_imageTeam(teamId) [NSString stringWithFormat:@"http://www.gunqiu.com/static/img/team/mobile/team_%ld.png",teamId]

//欧洲杯相关，暂时无用
//球员头像图片
//#define url_imageplayer(PlayerId) [NSString stringWithFormat:@"http://www.gunqiu.com/static/img/player/player_%ld.jpg",PlayerId]
////欧洲杯球队图片
//#define url_imageEuroTeam(teamId) [NSString stringWithFormat:@"http://mobile.gunqiu.com/static/active/team_%ld.png",teamId]
//#define url_imageEuroTeamNStSring(teamId) [NSString stringWithFormat:@"http://mobile.gunqiu.com/static/active/team_%@.png",teamId]
////欧洲杯竞猜界面的小图片
//#define url_imageEuroTeamNStSringSmall(teamId) [NSString stringWithFormat:@"http://mobile.gunqiu.com/static/active/small/team_%@.png",teamId]


#define url_pic @"http://pic.gunqiu.com/"


//tuijian,qingbao,tongzhi,chengji
#define url_shareImage(shareType) [NSString stringWithFormat:@"/share/v8.0/img/%@.png",shareType]
//分享的网页地址
#define url_share_interface @"/interface/v8.0/"
#define url_share @"/share/v8.0/"

#define url_defaultUserPic @"http://www.gunqiu.com/static/image/user-default.png"

//获取融云的token
#define url_getRonyunUserToken @"/rong/getUserToken"


//app打开的时候的图片
#define url_startpage @"/startpage"

//登陆注册接口
/*
 flag = 0，//操作类型（0:登录操作，1：获取手机验证码，2：用户注册，3：找回密码 9:联合登录）
	username， //用户名
	password   //用户密码
 //联合登录
 username userid
 nickname  username
 visit  :1
 */
//申请分析师
#define url_loginAndRegister @"/account"
//判断当前是否神奇分析师的状态
#define url_OnAndRegister @"/analyst"
//刷新token
#define url_refreshtoken @"/account/refreshtoken"

//热门专家
#define url_speciallist_hot @"/speciallist/hot"

//即时比分
/*
 请求参数：
	flag = 0，//赛事类型（0：全部赛事，1：北单，2：竞彩，3：足彩）
	visit，    //访问来源（为空的话来自pc，1-1000:ios）
	begin,     //开始时间
	end,       //结束时间
 */
#define url_liveScores @"/match"
//关注取消比赛
#define url_attentionSchedule_add @"/attentionSchedule/add"
#define url_attentionSchedule_del @"/attentionSchedule/del"

//即时比分文件地址
#define url_jsbf @"http://mobiledev.gunqiu.com/jsbf"
//完整赛事和精彩期次
#define url_jsbf_stageJC @"/stage/jc.json"
//完整赛事和精彩期次
#define url_jsbf_stageAll @"/stage/all.json"

//北单期次
#define url_jsbf_stageBD @"/stage/bd.json"
//足彩期次
#define url_jsbf_stageZC @"/stage/zc.json"

//完整赛事对阵
#define url_jsbf_all @"/v1.1/all"
// 全部赛果
#define url_jsbf_all_result @"/v1.1/all/result"
// 全部赛程
#define url_jsbf_all_future @"/v1.1/all/future"
// 竞彩赛果
#define url_jsbf_jc_result @"/v1.1/jc/result"
// 竞彩赛程
#define url_jsbf_jc_future @"/v1.1/jc/future"

//竞彩对阵
#define url_jsbf_jc @"/v1.1/jc"

//北单对阵
#define url_jsbf_bd @"/v1.1/bd"
//足彩对阵
#define url_jsbf_zc @"/v1.1/zc"
//即时比分
#define url_jsbf_change @"/change/change.json"
//分析页直播 /live/live_1212008.json
#define url_jsbf_live @"/live/newlive_"
//比分页关注的比赛
#define url_bifen_focus @"/bifen/focus"

//比分页面新接口
#define url_bifen_jsbfnew @"/bifen/jsbf"


//欧洲杯
//设置我的预测
#define url_eurocupchamp @"/eurocup/champ"
//竞猜比赛的对阵
///eurocup/quizmatch
#define url_eurocupquizmatch @"/eurocup/quizmatch"
///eurocup/match赛程对阵
#define url_eurocupmatch @"/eurocup/match"
// eurocup/matchquiz竞猜比赛
#define url_eurocupmatchquiz @"/eurocup/matchquiz"
///eurocup/myquiz 我的竞猜
#define url_eurocupmyquiz @"/eurocup/myquiz"
///eurocup/rank 竞猜排行
#define url_eurocuprank @"/eurocup/rank";
///eurocup/score 积分排名
#define url_eurocupscore @"/eurocup/score"
//欧洲杯爆料 欧洲杯的情报和情报首页用的接口一样,即时参数不一样
#define url_euroInfolistByDay @"/info/listIndex"
///recommend/listOneLeague欧洲杯推荐
#define url_eurorecommendlistByDay @"/recommend/listByDay"
//是否预测过冠军;
#define url_eurocupisquiz @"/eurocup/isquiz"
//红包
#define url_eurocuppasswd @"/eurocup/passwd"


//付费用户
#define url_BuyersUrl @"/order/payUsers"

//后缀名 .json
#define url_jsbf_json @".json"
//获取爆料和推荐的比赛
#define Url_BaoliaoMatchList @"/news/schedule/list"
//获取单场爆料比赛的信息
#define url_SingalInfoMatch @"/info/schedule/show"
//获取单场推荐比赛的信息
#define url_SingalRecommendMatch @"/recommend/schedule/show"
//增加爆料
#define url_addinfo @"/info/add"
//增加推荐
#define url_addrecommend @"/recommend/add"
//爆料首页
#define url_listInfo @"/info/listIndex"
//推荐首页
#define url_listrecommend @"/recommend/listIndex"
//推荐串关
#define url_listrecommendquerycg @"/recommend/querycg"

//单个爆料页面的信息
#define url_infoshow @"/info/show"
//单个推荐页面
#define url_recommendshow @"/recommend/show"
//待审核推荐
#define url_reviewNewsshow @"/reviewNews/show"

//单个推荐页面,串关
#define url_recommendinfocg @"/recommend/infocg"


//发布竞猜
#define url_quizaddQuiz @"/quiz/addQuiz"
//分析页竞猜
#define url_ontMatchQuiz @"/quiz/ontMatchQuiz"

//单个竞猜详情,付费之后调用
#define url_quizoneQuiz @"/quiz/oneQuiz"








// 苹果内购验证

#define url_purchase @"/pay/applepay/model" // 模型

#define url_purchase_recommend @"/payweb/apple/recommend" // 推荐


#define url_verifyPayment @"/applepay/verifyPayment"



//支付
#define url_appPay @"/pay/appPay"

//支付回调
#define url_appPaySuccess @"/order/newsPaySuccess"
// /comment/add 增加评论
#define url_addComment @"/comment/add"

#define url_QiuMatch @"/quiz/match"


// info/listUser 单个用户的曝料列表
#define url_infolistUser @"/info/listUser"
// recommend/listUser 单个用户的推荐列表
#define url_recommendlistUser @"/recommend/listUser"


// recommend/listUser 单个用户的推荐列表,串关,足彩
#define url_recommendlistUserChuanGuan @"/recommend/querymycg"
// /quiz/myQuizList 单个用户的推荐列表
#define url_quizmyQuizList @"/quiz/myQuizList"

// /info/listOneSchedule 单场比赛的曝料列表
#define url_infolistOneSchedule @"/info/listOneSchedule"
//  /recommmend/listOneSchedule 单场比赛的推荐列表
#define url_recommmendlistOneSchedule @"/recommend/listOneSchedule"
//提点数据接口
#define url_tidian @"/tip/mobile"

// /illegal/add 举报
#define url_illegaladd @"/report"
// /like/add 点赞
#define url_likeAdd @"/like/add"
// /focusAdd 新增关注
#define url_focusAdd @"/focus/add"
// /focusRemove 删除关注
#define url_focusRemove @"/focus/remove"
///follower/list 粉丝列表
#define url_followerlist @"/follower/list"
//关注列表
#define url_focuslist @"/focus/list"
// /user/info用户信息
#define url_userinfo @"/user/info"
// /ucenter/statistics 统计
#define url_ucenterstatistics @"/ucenter/statistics"
// /ucenter/userstatis  新版个人统计
#define url_ucenteruserstatis @"/ucenter/userstatis"
///ucenter/usercatestatis 新个人统计总,月,周
#define url_ucenterusercatestatis @"/ucenter/usercatestatis"
///ucenter/statis 用户中心的统计数据
#define url_ucenterstatis @"/ucenter/statis"
///quiz/myQuizStatis 竞猜统计
#define url_quizmyQuizStatis @"/quiz/myQuizStatis"
//竞猜统计-----wt
#define  url_quizmyQuizIndex @"/quiz/myQuizIndex"
//feedback.do 意见反馈
#define url_feedback @"/feedback"
///notice.do 站内通知
#define url_noticedo @"/notice"
//首页 index.do
//#define url_firstIndex @"/index"
#define url_firstIndex @"/newindex"
// 上传头像到阿里云
#define url_uploadAliyun @"/oss/upload/pic"

///uploadpic.do 上传头像 老的接口地址 /uploadpic

#define url_uploadpic @"/user/v2/updateUserPic"
///schedule/infolist 增加情报页面的 相关情报
#define url_scheduleinfolist @"/schedule/infolist"
///ranking/query推荐排行榜
#define url_rankingquery @"/ranking/query"
#define url_rankingqueryWM @"/rankmobile/stage.do"//排行榜的周月的接口
//quiz/quizRank竞猜排行榜
#define url_quizquizRank @"/quiz/quizRank"


///ranking/sclass推荐排行榜赛事
#define url_rankingsclass @"/ranking/sclass"

//h5网页头
#define UrlWebHead @"http://mobile.gunqiu.com"
//分析页
#define urlWebanalytics @"/analytics"
//基本面
#define urlWebanalyticsbasic @"/analytics-basic.html"
//欧赔
#define urlWebanalyticseuro @"/analytics-euro.html"
//亚盘
#define urlWebanalyticsasia @"/analytics-asia.html"
//数据
#define urlWebanalyticsdata @"/analytics-data.html"
//盈亏
#define urlWebanalyticsProfit @"/analytics-profit-loss.html"
//指数
#define urlWebidx @"/idx"
//指数欧赔
#define urlWebidxeuro @"/idx-euro.html"
//指数亚盘
#define urlWebidxaisa @"/idx-asia.html"
//指数大小球
#define urlWebidxoverunder @"/idx-overunder.html"


//首页
#define urlWebIndex @"/index"
//交易冷热
#define urlWebIndexdealhot @"/index-deal-hot.html"
//战绩特征
#define urlWebIndexrecordstate @"/index-record-state.html"
//每日伤停 /index-injure.html
#define urlWebindexinjure @"/index-injure.html"
//赔率升降  /index-oddslift
#define urlWebindexoddslift @"/index-oddslift.html"


//修改的h5页面的url
//每日伤停列表
#define url_shangTingList @"//injure"
#define url_shangTingDateil @"/basic"

//赔率升降
#define url_OddsList @"/oddsindex"

//战绩特征
//#define url_RecordLilst @"/record"
#define url_RecordLilst @"/recordodds"
//最近战绩
#define url_RecordNearList @"/basic"
//战绩特征
#define url_qtapi_zjtz @"/qtapi/zjtz"

//极限挂点
#define url_recordodds @"/recordodds"

//交易冷热
#define url_JiaoYiList @"/bifaindex"

//即时赔率
//#define url_JiShiPeiLv @"/matchodds"
#define url_JiShiPeiLv @"/qtapi/airlive?matchid="




//交易冷热详情
#define url_JiaoYiDetail @"/match/bifa/show"


//分析——基本面
#define url_JiBenbBasic @"/basic"
// 分析——欧赔面,亚盘面
#define url_FenXi @"/odds"
//分析——数据面
#define url_FenXiShuJuMian @"/data"
//指数——欧赔
#define url_ZhiShuOuPei  @"/oddsindex"

//资讯
#define url_ZiXunUrl @"/information"

//同赔指数
#define url_sameOdd_index @"/sameOdd/newIndex"

//同赔详情
#define url_sameOdd_detail @"/sameOdd/detail"

//爆冷指数
#define url_surprisestatis @"/surprisestatis"

//爆冷详情
#define url_surprise @"/surprise"

//赔率异常
#define url_oddsAbnormalindex @"/oddsAbnormal/index"

//亚盘助手
#define url_letgoalAbnormalindex @"/letgoalAbnormal/index"
//打小球盘口
#define url_totalAbnormalindex @"/totalAbnormal/index"


//推送设置
#define url_push_setting @"/push/setting"
//推送设置index
#define url_push_index @"/push/index"

//绑定账号
#define url_bang_Account @"/user/bind"

//查询绑定
#define url_hasAccountBanged @"/user/queryBind"



//我的购买
#define url_buy_listUser @"/buy/listUser"

//意见反馈上传图片
#define url_feedBack_upLoadImg @"/oss/upload/pic"

//／********************wt**********
//1.8.0 推荐帮助
#define TUIJIAN_API_HTML @"http://www.gunqiu.com/help/v1.8.0/tuijian.html"

//1.8.0 榜单帮助
#define BANGDAN_API_HTML @"http://www.gunqiu.com/help/v1.8.0/phb.html"

#define In_App_Purchase_Path [NSString stringWithFormat:@"%@/purchase.data",[ArchiveFile LibraryDirectory]]

#endif






