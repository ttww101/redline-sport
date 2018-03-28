//
//  AppDelegate.h
//  GQapp
//
//  Created by WQ_h on 16/3/28.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCTabBarController.h"
#import "WebDetailViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>
//@property (nonatomic, strong)WebDetailViewController *webDetailVC;
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) DCTabBarController *customTabbar;
//@property (strong, nonatomic) NSMutableArray *attentionArray;
@property (strong, nonatomic) NSString *url_Server;
@property (strong, nonatomic) NSString *url_jsonHeader;
@property (strong, nonatomic) NSString *url_ServerWWW;
@property (strong, nonatomic) NSString *url_ServerQiuTan;
@property (strong, nonatomic) NSString *url_ServerAgreement;
@property (strong, nonatomic) NSString *url_upLoadImg;
@property (strong, nonatomic) NSString *url_ip;
@property (strong, nonatomic) NSString*url_JISHUIDATA;

@end

