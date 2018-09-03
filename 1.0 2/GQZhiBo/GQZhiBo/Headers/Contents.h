//
//  Contents.h
//  GunQiuLive
//
//  Created by WQ_h on 15/12/31.
//  Copyright © 2015年 WQ_h. All rights reserved.
//

#ifndef Contents_h
#define Contents_h


//通知

//更新个人中心页面上的未读消息
#define NotificationupdateUnreadLabNum @"updateUnreadLabNum"
//开启tabbar里面的定时器
#define NotificationOpenMainTableBarTimer @"OpenMainTableBarTimer"
//比分页加载每一天的数据
#define NotificationRefreshOneDayEvent @"RefreshOneDayEvent"
//比分也更新赔率
#define NotificationupdatePeiLv @"updatePeiLv"
//比分也更新关注页面的新数据
#define NotificationupdateAttentionView @"updateAttentionView"

//比分也根据赛事选项加载数据
#define NotificationupdateByselectedSaishi @"updateByselectedSaishi"
//竞猜赛事筛选
#define NotificationupdateByselectedJingCaiSaishi @"updateByselectedJingCaiSaishi"
//竞猜赛事筛选
#define NotificationupdateByselectedinfo @"updateByselectedfabuInfo"

//情报也根据赛事选项加载数据
#define NotificationupdateByselectedQingBao  @"updateByselectedQingBao"
//爆料推荐页点击tableView的区头,让键盘下去
#define NotificationtouchDetailHeaderView @"touchDetailHeaderView"
//推送过来的时候首页跳转到首页然后跳转到指定页面
#define NotificationpushToNewsWeb @"Notification"
//设置页面的接受推送按钮状态
#define NotificationchangePushSwitch @"changePushSwitch"

//点击tabbar 让tableView的列表置顶
#define NotificationsetFirstTableViewContentOffsetZero @"setFirstTableViewContentOffsetZero"
#define NotificationsetSecondTableViewContentOffsetZero @"setSecondTableViewContentOffsetZero"
#define NotificationsetThirdTableViewContentOffsetZero @"setThirdTableViewContentOffsetZero"
#define NotificationsetForthTableViewContentOffsetZero @"setForthTableViewContentOffsetZero"
#define NotificationsetForth2TableViewContentOffsetZero @"setForth2TableViewContentOffsetZero"

#define NotificationsetFifthTableViewContentOffsetZero @"setFifthTableViewContentOffsetZero"



//textFile 的输入文本限制
#define LettersAndNum   @"_.ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
#define Nunbers @"0123456789"

//时间格式
#define DateFormatterYear                   @"yyyy-MM-dd"
#define DateFormatterYearH                   @"yy-MM-dd"
#define DateFormatterhour                   @"HH:mm"
#define DateFormatterMonth                  @"yyyy-MM"
#define DateFormatter                  @"yyyy-MM-dd"
#define dateStyleFormatter @"yyyy-MM-dd HH:mm:ss"
#define dateStyleFormatterWeek @"yyyy-MM-dd HH:mm:ss EEEE"
#define dateStyleFormatterMdHm @"MM-dd HH:mm"


//本地存储 NSUserDefaults
//登录信息
#define islogin @"login"

//比分页
//即时比分页面的全部筛选
#define arrSaveBifenAllSelectedPath @"arrSaveBifenAllSelectedPath.plist"
//即时比分页面的竞彩筛选
#define arrSaveBifenJingcaiSelectedPath @"arrSaveBifenJingcaiSelectedPath.plist"
//即时比分页面的初盘筛选
#define arrSaveBifenChupanSelectedPath @"arrSaveBifenChupanSelectedPath.plist"

//推荐竞猜页
//即时比分页面的全部筛选
#define arrSaveAllSelectedPathTuijianJingcai @"arrSaveTuijianJingcaiAllSelectedPath.plist"
//即时比分页面的竞彩筛选
#define arrSaveJingcaiSelectedPathTuijianJingcai @"arrSaveTuijianJingcaiJingcaiSelectedPath.plist"
//即时比分页面的初盘筛选
#define arrSaveChupanSelectedPathTuijianJingcai @"arrSavetuijianjingcaiChupanSelectedPath.plist"

//发布情报页
//全部筛选
#define arrSaveAllSelectedPathinfo @"arrSaveinfoAllSelectedPath.plist"
//竞彩筛选
#define arrSaveJingcaiSelectedPathinfo @"arrSaveinfoJingcaiSelectedPath.plist"
//初盘筛选
#define arrSaveChupanSelectedPathinfo @"arrSaveinfoChupanSelectedPath.plist"

//比分titleChange
#define biFenTitleChange @"biFenTitleChange"


//即时比分存在本地的关注的比赛的id
#define BifenPageAttentionArray @"BifenPageAttentionArray.plist"

//情报页面存在本地的关注的比赛的id
#define QingBaoPagettentionArray @"QingBaoPagettentionArray.plist"

//文字
#define default_loadFailure @"加载失败，再刷新试试"
#define default_noMatch @"没有比赛，休息一下哦"
#define default_isLoading @"载入数据中，稍候"
#define default_noGame @"没有关注的比赛"


#define default_1 @"等待赔率更新"
#define default_2 @"等待阵容公布"
#define default_3 @"球队无伤停，给力"
#define default_4 @"本场暂无比赛统计"
#define default_5 @"两队无交锋"
#define default_6 @"暂无未来赛事"
#define default_7 @"暂无必发数据"
#define default_8 @"暂无数据"
#define default_9 @"Ta还没发布过情报"
#define default_10 @"Ta还没发布过推荐"
#define default_11 @"Ta还没竞猜过比赛"
#define default_12 @"暂无情报，你要做头条吗"
#define default_13 @"暂无推荐，你要做头条吗"
#define default_14 @"懒人，还没发过情报呢"
#define default_15 @"懒人，还没发过推荐呢"
#define default_16 @"懒人，还没猜过比赛呢"
#define default_17 @"加油，去拉您的第一个粉丝"
#define default_18 @"您还没有关注过他人"
#define default_19 @"还没有关注过其他人"
#define default_20 @"暂无粉丝"
#define default_21 @"没有相关情报"
#define default_22 @"本场无数据"

//富文本编辑 图片标识
#define RICHTEXT_IMAGE (@"[UIImageView]")

#define isNUll(str) (str == nil || [str isEqualToString:@""])









#endif /* Contents_h */
/*
 Debug通常称为调试版本，通过一系列编译选项的配合，编译的结果通常包含调试信息，而且不做任何优化，以为开发人员提供强大的应用程序调试能力。
 而Release通常称为发布版本，是为用户使用的，一般客户不允许在发布版本上进行调试。所以不保存调试信息，同时，它往往进行了各种优化，以期达到代码最小和速度最优。为用户的使用提供便利。
 */
//在debug(调试的模式下才输出,否则不输出)

//debug模式输出
//#ifdef DEBUG
////nslog
//#define HHLog(format, ...) CFShow((__bridge CFTypeRef)[NSString stringWithFormat:format, ## __VA_ARGS__]);
//
//
//#define debugLog(...) NSLog(__VA_ARGS__)
//#define NSLogMethod() NSLog(@"%s", __func__)
//#define NSLog(...) NSLog(__VA_ARGS__)
//#else
//#define debugLog(...)
//#define NSLogMethod()
//#define NSLog(...)
//#endif


#ifdef DEBUG
#define NSLog(format, ...) printf("\n[%s] %s [第%d行] %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String])
#else
#define NSLog(format, ...)
#endif


