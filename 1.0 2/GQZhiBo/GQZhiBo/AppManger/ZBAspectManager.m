
//
//  ZBAspectManager.m
//  newGQapp
//
//  Created by genglei on 2018/7/2.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import "ZBAspectManager.h"

@implementation ZBAspectManager

+ (void)GQ_SavePageDic {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [dic setObject:version forKey:@"appVersion"];
    NSDictionary *pageDic = @{@"ZBFirstViewController"                :@"首页",
                              @"ZBPanwangZhishuVC"                    :@"盘王指数",
                              @"ZBJiXianVC"                           :@"极限拐点",
                              @"ZBBettingVC"                          :@"投注异常",
                              @"ZBJiaoYiViewController"               :@"交易冷热",
                              @"ZBTongpeiTongjiVC"                    :@"同赔统计",
                              @"ZBTongPeiDetailVC"                    :@"同赔统计详情",
                              @"ZBTongPeiPeiLvDTVC"                   :@"同赔统计赔率",
                              @"ZBBaolengZhishuVC"                    :@"爆冷指数",
                              @"ZBBaolengDetailVC"                    :@"爆冷指数详情",
                              @"ZBPeilvYichangVC"                     :@"赔率异常",
                              @"ZBYapanZhoushouVC"                    :@"亚盘助手",
                              @"ZBLiveViewController"                 :@"动画",
                              @"ZBLiveListViewController"             :@"动画详情",
                              @"ZBLiveQuizViewController"             :@"直播答题",
                              @"ZBCouponListViewController"           :@"优惠券",
                              @"ZBLiveQuizWithDrawalViewController"   :@"直播答题提现",
                              @"ZBBifenSetingViewController"          :@"比分页设置",
                              @"ZBSaishiSelecterdVC"                  :@"比分筛选",
                              @"ZBSelectedAllVC"                      :@"所有筛选",
                              @"ZBSelectedChupanVC"                   :@"初盘筛选",
                              @"ZBSelectedJincaiVC"                   :@"竞猜筛选",
                              @"ZBSearchMatchVC"                      :@"比分页搜索",
                              @"ZBBifenViewController"                :@"比分大厅",
                              @"ZBGuanzhuViewController"              :@"关注",
                              @"ZBJishiViewController"                :@"即时",
                              @"ZBSaichengViewController"             :@"赛程",
                              @"ZBSaiguoViewController"               :@"赛果",
                              @"ZBFenxiPageVC"                        :@"比赛详情",
                              @"ZBPeiLvDetailVC"                      :@"赔率详情",
                              @"ZBJiShiPeiLvVC"                       :@"即时赔率",
                              @"ZBDoubleBattleVC"                     :@"双赔",
                              @"ZBFabuTuijianSelectedItemVC"          :@"发布推荐",
                              @"ZBRelRecNewVC"                        :@"选择赔率",
                              @"ZBBuyRecordsVC"                       :@"购买记录",
                              @"ZBFaBuSucceedVCViewController"        :@"发布成功",
                              @"ZBTuijianDTViewController"            :@"推荐大厅",
                              @"ZBTuijianDetailVC"                    :@"推荐详情",
                              @"ZBSearchViewController"               :@"搜索专家",
                              @"ZBNewRecommandVC"                     :@"榜单",
                              @"ZBQBNavigationVC"                     :@"情报导航",
                              @"ZBNewQingBaoViewController"           :@"情报大厅",
                              @"ZBMyBuyTuijianVC"                     :@"我的购买",
                              @"ZBUserViewController"                 :@"个人主页",
                              @"ZBFeedbackNewVC"                      :@"意见反馈",
                              @"ZBSettingVC"                          :@"设置",
                              @"ZBPushSettingVC"                      :@"推送设置",
                              @"ZBChangePassWordVC"                   :@"修改密码",
                              @"ZBAnQuanCenterVC"                     :@"安全中心",
                              @"ZBRealNameCerVC"                      :@"实名认证",
                              @"ZBFriendsVC"                          :@"我的关注",
                              @"ZBMineViewController"               :@"个人中心",
                              @"ZBUserTuijianVC"                      :@"我的推荐",
                              @"ZBTongjiVC"                           :@"我的统计",
                              @"ZBMyProfileVC"                        :@"我的资料",
                              @"ZBSignatureVC"                        :@"个人签名",
                              @"ZBAnalystsEventFilterVC"              :@"申请分析师",
                              @"ZBToAnalystsVC"                       :@"成为分析师",
                              @"ZBForgetPswViewController"            :@"忘记密码",
                              @"ZBLoginViewController"                :@"登陆",
                              @"ZBRegisterViewController"             :@"注册",
                              @"ZBChangePhoneNumVC"                   :@"绑定手机",
                              @"ZBLotteryWebViewController"           :@"活动web",
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
