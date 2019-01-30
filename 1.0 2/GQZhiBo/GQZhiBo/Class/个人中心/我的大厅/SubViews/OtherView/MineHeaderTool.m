//
//  MineHeaderTool.m
//  GQZhiBo
//
//  Created by genglei on 2019/1/20.
//  Copyright © 2019年 GQXX. All rights reserved.
//

#import "MineHeaderTool.h"
#import "ZBToolWebViewController.h"

@interface MineHeaderTool ()

@end

@implementation MineHeaderTool


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return  self;
}

#pragma mark - Config UI

- (void)configUI {
    self.backgroundColor = [UIColor whiteColor];
}

- (void)setToolItems:(NSArray *)toolItems {
    _toolItems = toolItems;

    [self removeAllSubViews];
    CGFloat width = self.width / toolItems.count;
    for (NSInteger i = 0; i < toolItems.count; i++) {
        ToolControl *control = [[ToolControl alloc]initWithFrame:CGRectMake(i * width, 0, width, self.height) itemDic:toolItems[i]];
        control.tag = i;
        [control addTarget:self action:@selector(controlAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:control];
    }
}

- (void)controlAction:(ToolControl *)sender {
    switch (sender.tag) {
        case 0: {
            if(![ZBMethods login]) {
                [ZBMethods toLogin];
                return;
            }
            
            ZBWebModel *model = [[ZBWebModel alloc]init];
            model.title = @"VIP会员";
            model.hideNavigationBar = false;
            model.webUrl = [NSString stringWithFormat:@"%@/%@/myvip.html", APPDELEGATE.url_ip,H5_Host];
            ZBToolWebViewController *webDetailVC = [[ZBToolWebViewController alloc] init];
            webDetailVC.model = model;
            [APPDELEGATE.customTabbar pushToViewController:webDetailVC animated:YES];
        }
            
            break;
        case 1: {
            ZBWebModel *model = [[ZBWebModel alloc]init];
            model.hideNavigationBar = true;
            model.webUrl = [NSString stringWithFormat:@"%@/%@/mode.html", APPDELEGATE.url_ip,H5_Host];
            ZBToolWebViewController *webDetailVC = [[ZBToolWebViewController alloc] init];
            webDetailVC.model = model;
            [APPDELEGATE.customTabbar pushToViewController:webDetailVC animated:YES];
        }
            
            break;
        case 2: {
            ZBWebModel *model = [[ZBWebModel alloc]init];
            model.hideNavigationBar = true;
            model.webUrl = [NSString stringWithFormat:@"%@/%@/tooldata.html", APPDELEGATE.url_ip,H5_Host];
            ZBToolWebViewController *webDetailVC = [[ZBToolWebViewController alloc] init];
            webDetailVC.model = model;
            [APPDELEGATE.customTabbar pushToViewController:webDetailVC animated:YES];
        }
            
            break;
        case 3: {
            ZBWebModel *model = [[ZBWebModel alloc]init];
            model.title = @"滚球情报";
             model.hideNavigationBar = false;
            model.webUrl = [NSString stringWithFormat:@"%@/%@/qingbao.html", APPDELEGATE.url_ip,H5_Host];
            ZBToolWebViewController *webDetailVC = [[ZBToolWebViewController alloc] init];
            webDetailVC.model = model;
            [APPDELEGATE.customTabbar pushToViewController:webDetailVC animated:YES];
        }
            break;
            
        default:
            break;
    }
}

@end
