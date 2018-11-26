#ifndef GunQiuLive_Urls_h
#define GunQiuLive_Urls_h
#define url_imageTeam(teamId) [NSString stringWithFormat:@"http://www.gunqiu.com/static/img/team/mobile/team_%ld.png",teamId]
#define url_pic @"http://pic.gunqiu.com/"
#define url_shareImage(shareType) [NSString stringWithFormat:@"/share/v8.0/img/%@.png",shareType]
#define url_share_interface @"/interface/v8.0/"
#define url_share @"/share/v8.0/"
#define url_defaultUserPic @"http://www.gunqiu.com/static/image/user-default.png"
#define url_getRonyunUserToken @"/rong/getUserToken"
#define url_startpage @"/startpageX"
#define url_loginAndRegister @"/account"
#define url_OnAndRegister @"/analyst"
#define url_refreshtoken @"/account/refreshtoken"
#define url_speciallist_hot @"/speciallist/hot"
#define url_liveScores @"/match"
#define url_attentionSchedule_add @"/attentionSchedule/add"
#define url_attentionSchedule_del @"/attentionSchedule/del"
#define url_jsbf @"http://mobiledev.gunqiu.com/jsbf"
#define url_jsbf_stageJC @"/stage/jc.json"
#define url_jsbf_stageAll @"/stage/all.json"
#define url_jsbf_stageBD @"/stage/bd.json"
#define url_jsbf_stageZC @"/stage/zc.json"
#define url_jsbf_all @"/v1.1/all"
#define url_jsbf_all_result @"/v1.1/all/result"
#define url_jsbf_all_future @"/v1.1/all/future"
#define url_jsbf_jc_result @"/v1.1/jc/result"
#define url_jsbf_jc_future @"/v1.1/jc/future"
#define url_jsbf_jc @"/v1.1/jc"
#define url_jsbf_bd @"/v1.1/bd"
#define url_jsbf_zc @"/v1.1/zc"
#define url_jsbf_change @"/change/change.json"
#define url_jsbf_live @"/live/newlive_"
#define url_bifen_focus @"/bifen/focus"
#define url_bifen_jsbfnew @"/bifen/jsbf"
#define url_video_live @"/livestv"
#define url_eurocupchamp @"/eurocup/champ"
#define url_eurocupquizmatch @"/eurocup/quizmatch"
#define url_eurocupmatch @"/eurocup/match"
#define url_eurocupmatchquiz @"/eurocup/matchquiz"
#define url_eurocupmyquiz @"/eurocup/myquiz"
#define url_eurocuprank @"/eurocup/rank";
#define url_eurocupscore @"/eurocup/score"
#define url_euroInfolistByDay @"/info/listIndex"
#define url_eurorecommendlistByDay @"/recommend/listByDay"
#define url_eurocupisquiz @"/eurocup/isquiz"
#define url_eurocuppasswd @"/eurocup/passwd"
#define url_BuyersUrl @"/order/payUsers"
#define url_jsbf_json @".json"
#define Url_BaoliaoMatchList @"/news/schedule/list"
#define url_SingalInfoMatch @"/info/schedule/show"
#define url_SingalRecommendMatch @"/pc/recommend/schedule/show"
#define url_addinfo @"/info/add"
#define url_addrecommend @"/pc/recommend/publish"
#define url_listInfo @"/info/listIndex"
#define url_listrecommend @"/recommend/listIndex"
#define url_newlistrecommend @"/v22/recommend/listIndex"
#define url_listrecommendquerycg @"/recommend/querycg"
#define url_infoshow @"/info/show"
#define url_recommendshow @"/recommend/show"
#define url_reviewNewsshow @"/reviewNews/show"
#define url_recommendinfocg @"/recommend/infocg"
#define url_quizaddQuiz @"/quiz/addQuiz"
#define url_ontMatchQuiz @"/quiz/ontMatchQuiz"
#define url_quizoneQuiz @"/quiz/oneQuiz"
#pragma mark -   新加接口
#define url_couponlist @"/couponlist"
#define url_reward_list @"/reward_list"
#define url_liveQuiz @"/activity_entry3"
#define url_idfa @"/upidfa"
#define url_update @"/upgrade"
#define url_redBomb @"/redpacket/pic"
#define url_modelPay @"/pay/modelPay/new"
#define url_modelPay_ali @"/pay/alipay/model"
#define url_modelPay_coupon @"/pay/couponpay/model"
#define url_ConfigjSon @"/initx.json"
#define H5_Host @"appH5/v4"
#define url_purchase @"/pay/applepay/model" 
#define url_purchase_recommend @"/payweb/apple/recommend" 
#define url_verifyPayment @"/applepay/verifyPayment"
#define url_appPayW @"/pay/appPay"
#define url_appPayA @"/pay/app/alipay"
#define url_appPaySuccess @"/order/newsPaySuccess"
#define url_addComment @"/comment/add"
#define url_QiuMatch @"/quiz/match"
#define url_infolistUser @"/info/listUser"
#define url_recommendlistUser @"/recommend/listUser"
#define url_newrecommendlistUser @"/v22/recommend/listUser"
#define url_recommendlistUserChuanGuan @"/recommend/querymycg"
#define url_quizmyQuizList @"/quiz/myQuizList"
#define url_infolistOneSchedule @"/info/listOneSchedule"
#define url_recommmendlistOneSchedule @"/recommend/listOneSchedule"
#define url_tidian @"/tip/mobile"
#define url_illegaladd @"/report"
#define url_likeAdd @"/like/add"
#define url_focusAdd @"/focus/add"
#define url_focusRemove @"/focus/remove"
#define url_followerlist @"/follower/list"
#define url_focuslist @"/focus/list"
#define url_userinfo @"/user/info"
#define url_usernewinfo @"/user/myinfo"
#define url_ucenterstatistics @"/ucenter/statistics"
#define url_ucenteruserstatis @"/ucenter/userstatis"
#define url_ucenterusercatestatis @"/ucenter/usercatestatis"
#define url_ucenterstatis @"/ucenter/statis"
#define url_quizmyQuizStatis @"/quiz/myQuizStatis"
#define  url_quizmyQuizIndex @"/quiz/myQuizIndex"
#define url_feedback @"/feedback"
#define url_noticedo @"/notice"
#define url_firstIndex @"/newindex"
#define url_uploadAliyun @"/oss/upload/pic"
#define url_uploadpic @"/user/v2/updateUserPic"
#define url_scheduleinfolist @"/schedule/infolist"
#define url_rankingquery @"/ranking/query"
#define url_rankingqueryWM @"/rankmobile/stage.do"
#define url_quizquizRank @"/quiz/quizRank"
#define url_rankingsclass @"/ranking/sclass"
#define UrlWebHead @"http://mobile.gunqiu.com"
#define urlWebanalytics @"/analytics"
#define urlWebanalyticsbasic @"/analytics-basic.html"
#define urlWebanalyticseuro @"/analytics-euro.html"
#define urlWebanalyticsasia @"/analytics-asia.html"
#define urlWebanalyticsdata @"/analytics-data.html"
#define urlWebanalyticsProfit @"/analytics-profit-loss.html"
#define urlWebidx @"/idx"
#define urlWebidxeuro @"/idx-euro.html"
#define urlWebidxaisa @"/idx-asia.html"
#define urlWebidxoverunder @"/idx-overunder.html"
#define urlWebIndex @"/index"
#define urlWebIndexdealhot @"/index-deal-hot.html"
#define urlWebIndexrecordstate @"/index-record-state.html"
#define urlWebindexinjure @"/index-injure.html"
#define urlWebindexoddslift @"/index-oddslift.html"
#define url_shangTingList @"
#define url_shangTingDateil @"/basic"
#define url_OddsList @"/oddsindex"
#define url_RecordLilst @"/recordodds"
#define url_RecordNearList @"/basic"
#define url_qtapi_zjtz @"/qtapi/zjtz"
#define url_recordodds @"/recordodds"
#define url_JiaoYiList @"/bifaindex"
#define url_JiShiPeiLv @"/qtapi/airlive?matchid="
#define url_JiaoYiDetail @"/match/bifa/show"
#define url_JiBenbBasic @"/basic"
#define url_FenXi @"/odds"
#define url_FenXiShuJuMian @"/data"
#define url_ZhiShuOuPei  @"/oddsindex"
#define url_ZiXunUrl @"/information"
#define url_sameOdd_index @"/sameOdd/newIndex"
#define url_sameOdd_detail @"/sameOdd/detail"
#define url_surprisestatis @"/surprisestatis"
#define url_surprise @"/surprise"
#define url_oddsAbnormalindex @"/oddsAbnormal/index"
#define url_letgoalAbnormalindex @"/letgoalAbnormal/index"
#define url_totalAbnormalindex @"/totalAbnormal/index"
#define url_push_setting @"/push/setting"
#define url_push_index @"/push/index"
#define url_bang_Account @"/user/bind"
#define url_hasAccountBanged @"/user/queryBind"
#define url_buy_listUser @"/buy/listUser"
#define url_feedBack_upLoadImg @"/oss/upload/pic"
#define TUIJIAN_API_HTML @"http://www.gunqiu.com/help/v1.8.0/tuijian.html"
#define BANGDAN_API_HTML @"http://www.gunqiu.com/help/v1.8.0/phb.html"
#define In_App_Purchase_Path [NSString stringWithFormat:@"%@/purchase.data",[ArchiveFile LibraryDirectory]]
#define Buy_Type_Path [NSString stringWithFormat:@"%@/buytype.data",[ArchiveFile LibraryDirectory]]
#define TableConfig [NSString stringWithFormat:@"%@/tableConfig.data",[ArchiveFile LibraryDirectory]]
#define Activity_Path [NSString stringWithFormat:@"%@/activity.data",[ArchiveFile LibraryDirectory]]
#define PAGE_PATH @"PagePath.plist"
#pragma mark -
#define info_url @"/flashnews/comments"
#define info_like_url @"/flashnews/like"
#define info_like_comment @"/flashnews/comment"
#define info_url_commentcount @"/flashnews/comments/count"
#endif