
//
//  GQAspectManager.m
//  newGQapp
//
//  Created by genglei on 2018/7/2.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import "GQAspectManager.h"

@implementation GQAspectManager

+ (void)GQ_SavePageDic {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [dic setObject:version forKey:@"appVersion"];
    NSDictionary *pageDic = @{@"FirstViewController"                :@"首页",
                              @"PanwangZhishuVC"                    :@"盘王指数",
                              @"JiXianVC"                           :@"极限拐点",
                              @"BettingVC"                          :@"投注异常",
                              @"JiaoYiViewController"               :@"交易冷热",
                              @"TongpeiTongjiVC"                    :@"同赔统计",
                              @"TongPeiDetailVC"                    :@"同赔统计详情",
                              @"TongPeiPeiLvDTVC"                   :@"同赔统计赔率",
                              @"BaolengZhishuVC"                    :@"爆冷指数",
                              @"BaolengDetailVC"                    :@"爆冷指数详情",
                              @"PeilvYichangVC"                     :@"赔率异常",
                              @"YapanZhoushouVC"                    :@"亚盘助手",
                              @"LiveViewController"                 :@"动画",
                              @"LiveListViewController"             :@"动画详情",
                              @"LiveQuizViewController"             :@"直播答题",
                              @"CouponListViewController"           :@"优惠券",
                              @"LiveQuizWithDrawalViewController"   :@"直播答题提现",
                              @"BifenSetingViewController"          :@"比分页设置",
                              @"SaishiSelecterdVC"                  :@"比分筛选",
                              @"SelectedAllVC"                      :@"所有筛选",
                              @"SelectedChupanVC"                   :@"初盘筛选",
                              @"SelectedJincaiVC"                   :@"竞猜筛选",
                              @"SearchMatchVC"                      :@"比分页搜索",
                              @"BifenViewController"                :@"比分大厅",
                              @"GuanzhuViewController"              :@"关注",
                              @"JishiViewController"                :@"即时",
                              @"SaichengViewController"             :@"赛程",
                              @"SaiguoViewController"               :@"赛果",
                              @"FenxiPageVC"                        :@"比赛详情",
                              @"PeiLvDetailVC"                      :@"赔率详情",
                              @"JiShiPeiLvVC"                       :@"即时赔率",
                              @"DoubleBattleVC"                     :@"双赔",
                              @"FabuTuijianSelectedItemVC"          :@"发布推荐",
                              @"RelRecNewVC"                        :@"选择赔率",
                              @"BuyRecordsVC"                       :@"购买记录",
                              @"FaBuSucceedVCViewController"        :@"发布成功",
                              @"TuijianDTViewController"            :@"推荐大厅",
                              @"TuijianDetailVC"                    :@"推荐详情",
                              @"SearchViewController"               :@"搜索专家",
                              @"NewRecommandVC"                     :@"榜单",
                              @"QBNavigationVC"                     :@"情报导航",
                              @"NewQingBaoViewController"           :@"情报大厅",
                              @"MyBuyTuijianVC"                     :@"我的购买",
                              @"UserViewController"                 :@"个人主页",
                              @"FeedbackNewVC"                      :@"意见反馈",
                              @"SettingVC"                          :@"设置",
                              @"PushSettingVC"                      :@"推送设置",
                              @"ChangePassWordVC"                   :@"修改密码",
                              @"AnQuanCenterVC"                     :@"安全中心",
                              @"RealNameCerVC"                      :@"实名认证",
                              @"FriendsVC"                          :@"我的关注",
                              @"GQMineViewController"               :@"个人中心",
                              @"UserTuijianVC"                      :@"我的推荐",
                              @"TongjiVC"                           :@"我的统计",
                              @"MyProfileVC"                        :@"我的资料",
                              @"SignatureVC"                        :@"个人签名",
                              @"AnalystsEventFilterVC"              :@"申请分析师",
                              @"ToAnalystsVC"                       :@"成为分析师",
                              @"ForgetPswViewController"            :@"忘记密码",
                              @"LoginViewController"                :@"登陆",
                              @"RegisterViewController"             :@"注册",
                              @"ChangePhoneNumVC"                   :@"绑定手机",
                              @"LotteryWebViewController"           :@"活动web",
                              };
    [dic setObject:pageDic forKey:@"pageDic"];
    NSString*doc=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString*path=[doc stringByAppendingPathComponent:PAGE_PATH];
    [dic writeToFile:path atomically:YES];
}

+ (NSMutableDictionary *)GQ_PathForPageDic {
    NSString*doc=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString*path=[doc stringByAppendingPathComponent:PAGE_PATH];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    return dic;
}

@end
