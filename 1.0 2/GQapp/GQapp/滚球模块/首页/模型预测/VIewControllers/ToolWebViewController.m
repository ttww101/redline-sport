//
//  ToolWebViewController.m
//  newGQapp
//
//  Created by genglei on 2018/4/2.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import "ToolWebViewController.h"
#import "WebViewJavascriptBridge.h"
#import "UserModel.h"
#import "TokenModel.h"
#import "AppleIAPService.h"
#import <UShareUI/UShareUI.h>
#import "CouponListViewController.h"
#import "LiveQuizWithDrawalViewController.h"
#import "XHPayKit.h"
#import "ArchiveFile.h"
#import "AppManger.h"
#import "NavImageView.h"
#import "GQWebView.h"
#import "LiveQuizViewController.h"
#import "WebviewProgressLine.h"

@interface ToolWebViewController () <UIWebViewDelegate, GQWebViewDelegate>

@property (nonatomic , strong) WebViewJavascriptBridge* bridge;

@property (nonatomic , copy) GQJSResponseCallback callBack;

@property (nonatomic , copy) NSString *recordUrl;

@property (nonatomic , assign) BOOL isToFenxi;

@property (nonatomic, assign) BOOL isBack;

@property (nonatomic , strong) UIView *toastView;

@property (nonatomic , weak) id observer;

@property (nonatomic , strong) GQWebView *activityWeb;

@property (nonatomic , strong) WebviewProgressLine *progressLine;


@end

@implementation ToolWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    [self loadBradgeHandler];
    [self loadData];
//    if ([self.urlPath rangeOfString:@"pay-for.html"].location != NSNotFound) {
//        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshResult) name:@"refreshPayPage" object:nil];
//    }
    
    self.progressLine = [[WebviewProgressLine alloc] initWithFrame:CGRectMake(0, 0, Width, 3)];
    self.progressLine.lineColor = redcolor;
    [self.webView addSubview:self.progressLine];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:_model.hideNavigationBar animated:YES];
    [self configWebHeight];
    if (self.isBack) {
        [self refreshData];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.isBack = YES;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark - Notification

- (void)refreshResult {
    NSString *jsonParameter = [self getJSONMessage:@{@"id":@"fireEvent", @"val":@"payResult"}];
    [self.bridge callHandler:@"jsCallBack" data:jsonParameter responseCallback:^(id responseData) {
        
    }];
}

- (void)refreshData {
    NSString *jsonParameter = [self getJSONMessage:@{@"id":@"fireEvent", @"val":@"reload"}];
    [self.bridge callHandler:@"jsCallBack" data:jsonParameter responseCallback:^(id responseData) {
        
    }];
}

- (void)loadBradgeHandler {
    __weak ToolWebViewController *weakSelf = self;
    AppManger *manger = [[AppManger alloc]init];
    WebViewJavascriptBridge *bridge = [manger registerJSTool:self.webView hannle:^(id data, GQJSResponseCallback responseCallback) {
        if (responseCallback) {
            weakSelf.callBack = responseCallback;
        }
        JSModel *model = (JSModel *)data;
        NSString *actionString = model.methdName;
        SEL action = NSSelectorFromString(actionString);
        if ([weakSelf respondsToSelector:action]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [weakSelf performSelector:action withObject:model.parameterData];
#pragma clang diagnostic pop
        }
    }];
    
    [bridge setWebViewDelegate:self];
    self.bridge = bridge;
}


#pragma mark - Load Data

- (void)loadData {
    if (_model) {
        self.urlPath = _model.webUrl;
        self.html5Url = _model.htmlUrl;
        if (_recordUrl) {
            self.urlPath = _recordUrl;
            self.html5Url = _recordUrl;
        }
    }

    if (self.urlPath != nil) {
        self.urlPath = [self.urlPath stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSURL *url = [NSURL URLWithString:self.urlPath];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:15];
        [request setValue:PARAM_IS_NIL_ERROR([Methods getTokenModel].token) forHTTPHeaderField:@"token"];
        [self.webView loadRequest:request];
    } else if (self.html5Url != nil) {
        NSString* path = [[NSBundle mainBundle] pathForResource:self.html5Url ofType:@"html"];
        NSString *htmlString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        [self.webView loadHTMLString:htmlString baseURL:[NSURL URLWithString:path]];
    }
}

#pragma mark - Config UI

- (void)configWebHeight {
    if (self.navigationController.navigationBarHidden) {
        self.webView.frame = CGRectMake(0, 0, self.view.width, Height - (_model.fromTab ? 49:0));
    } else {
        self.webView.frame = CGRectMake(0, 0, self.view.width, Height - 64 - (_model.fromTab ? 49:0));
    }
}

- (void)configUI {
    [self.view addSubview:self.webView];
    self.navigationItem.title = _model.title;
    adjustsScrollViewInsets_NO(self.webView.scrollView, self);
    
    if (_model.showBuyBtn) {
        UIButton *buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [buyBtn setTitle:@"开通服务" forState:UIControlStateNormal];
        [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        buyBtn.frame = CGRectMake(0, 0, 70, 44);
        buyBtn.titleLabel.font = [UIFont systemFontOfSize:16.f];
        [buyBtn addTarget:self action:@selector(buyAction) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:buyBtn];
        self.navigationItem.rightBarButtonItem = rightItem;
    }
    
    if (self.navigationController.navigationBarHidden) {
        
    } else {
        if ([_model.parameter isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dataDic = _model.parameter;
            NSDictionary *navDic = dataDic[@"nav"];
            if (!([navDic isKindOfClass:[NSDictionary class]] && navDic.allKeys.count > 0)) {
                return;
            }
            NSArray *leftArray = navDic[@"left"];
            NSArray *rightArray = navDic[@"right"];
            if (leftArray.count > 0) {
                NSMutableArray *leftItemsArray = [NSMutableArray new];
                for (NSInteger i = 0; i < leftArray.count; i ++) {
                    NSDictionary *dic = leftArray[i];
                    [[SDImageCache sharedImageCache]removeImageForKey:dic[@"icon"]];
                    NavImageView *imageV = [[NavImageView alloc]init];
                    imageV.frame = CGRectMake(i * 44, 0, 44, 44);
                    [imageV sd_setImageWithURL:[NSURL URLWithString:dic[@"icon"]] placeholderImage:[UIImage imageNamed:dic[@"icon"]]];
                    imageV.image = [imageV.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                    imageV.clipsToBounds = YES;
                    imageV.userInteractionEnabled = YES;
                    imageV.Parameter = dic;
                    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tableBarAction:)];
                    [imageV addGestureRecognizer:tap];
                    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:imageV];
                    [leftItemsArray addObject:item];
                }
                self.navigationItem.leftBarButtonItems = [leftItemsArray copy];
            }
            
            if (rightArray.count > 0) {
                NSMutableArray *rightItemsArray = [NSMutableArray new];
                rightArray = [[rightArray reverseObjectEnumerator] allObjects];
                for (NSInteger i = 0; i < rightArray.count; i ++) {
                    NSDictionary *dic = rightArray[i];
                    [[SDImageCache sharedImageCache]removeImageForKey:dic[@"icon"]];
                    NavImageView *imageV = [[NavImageView alloc]init];
                    imageV.frame = CGRectMake(i * 44, 0, 44, 44);
                    [imageV sd_setImageWithURL:[NSURL URLWithString:dic[@"icon"]] placeholderImage:[UIImage imageNamed:dic[@"icon"]]];
                    imageV.userInteractionEnabled = YES;
                    imageV.Parameter = dic;
                    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tableBarAction:)];
                    [imageV addGestureRecognizer:tap];
                    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:imageV];
                    [rightItemsArray addObject:item];
                }
                self.navigationItem.rightBarButtonItems = rightItemsArray;
            }
        }
    }
}

#pragma mark - UIWebViewDelegate


- (void)webViewDidStartLoad:(UIWebView *)webView {
   [self.progressLine startLoadingAnimation];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.progressLine endLoadingAnimation];
    [self dissMissToastView];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self createNullToastView:@"" imageName:@"nodataFirstP"];
    [self.progressLine endLoadingAnimation];
    
}

#pragma mark - GQWebViewDelegate

- (void)webClose:(id)data {
    if (_activityWeb) {
        [_activityWeb removeFromSuperview];
        _activityWeb = nil;
    }
}

#pragma mark - JSHandle

- (void)webBack {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)webShare:(id)data {
    if ([data isKindOfClass:NSClassFromString(@"NSDictionary")]) {
        NSDictionary *dic = (NSDictionary *)data;
        NSString *title = dic[@"title"];
        NSString *picurl = dic[@"picurl"];
        NSString *des = dic[@"des"];
        NSString *linkurl = dic[@"linkurl"];
        [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
            
            switch (platformType) {
                case UMSocialPlatformType_Sina: {
                    if (![[UMSocialManager defaultManager]isInstall:UMSocialPlatformType_Sina]) {
                        [SVProgressHUD showErrorWithStatus:@"未安装新浪客户端"];
                        return ;
                    }
                }
                    break;
                    
                case UMSocialPlatformType_WechatSession: {
                    if (![[UMSocialManager defaultManager]isInstall:UMSocialPlatformType_WechatSession]) {
                        [SVProgressHUD showErrorWithStatus:@"未安装微信客户端"];
                        return ;
                    }
                }
                    break;
                    
                case UMSocialPlatformType_WechatTimeLine: {
                    if (![[UMSocialManager defaultManager]isInstall:UMSocialPlatformType_WechatTimeLine]) {
                        [SVProgressHUD showErrorWithStatus:@"未安装微信客户端"];
                        return ;
                    }
                }
                    break;
                    
                case UMSocialPlatformType_QQ: {
                    if (![[UMSocialManager defaultManager]isInstall:UMSocialPlatformType_QQ]) {
                        [SVProgressHUD showErrorWithStatus:@"未安装QQ客户端"];
                        return ;
                    }
                }
                    break;
                    
                case UMSocialPlatformType_Qzone: {
                    if (![[UMSocialManager defaultManager]isInstall:UMSocialPlatformType_Qzone]) {
                        [SVProgressHUD showErrorWithStatus:@"未安装QQ客户端"];
                        return ;
                    }
                }
                    break;
                    
                    
                    
                default:
                    break;
            }
            
            
            //创建分享消息对象
            UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
            //创建网页内容对象
            UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:des thumImage:picurl];
            //设置网页地址
            shareObject.webpageUrl = linkurl;
            //分享消息对象设置分享内容对象
            messageObject.shareObject = shareObject;
            //调用分享接口
            [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:[Methods help_getCurrentVC] completion:^(id data, NSError *error) {
                if (error) {
                    NSString *jsonParameter = [self getJSONMessage:@{@"id":@"shareFailed", @"val":@(platformType)}];
                    [self.bridge callHandler:@"jsCallBack" data:jsonParameter responseCallback:^(id responseData) {
                        
                    }];
                }else{
                    NSString *jsonParameter = [self getJSONMessage:@{@"id":@"shareSuccess", @"val":@(platformType)}];
                    [self.bridge callHandler:@"jsCallBack" data:jsonParameter responseCallback:^(id responseData) {
                        
                    }];
                }
            }];
        }];
    }
}

- (void)back:(id)parameter {
    if ([parameter integerValue] == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)openH5:(id)data {
    if ([data isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dic = (NSDictionary *)data;
        WebModel *webModel = [[WebModel alloc]init];
        webModel.title = dic[@"title"];
        webModel.webUrl =  dic[@"url"];
        webModel.hideNavigationBar = false;
        ToolWebViewController *control = [[ToolWebViewController alloc]init];
        control.model = webModel;
        [self.navigationController pushViewController:control animated:YES];
    }
}

- (void)openNative:(id)data {
    if ([data isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dataDic = (NSDictionary *)data;
        NSString *className = dataDic[@"n"];
        
        if ([className isEqualToString:@"FenxiPageVC"]) {
            [self pushToMatchDetail:dataDic];
            return;
        }
        
        if ([className isEqualToString:@"BifenViewController"]) {
            [self.tabBarController setSelectedIndex:1];
            return;
        }
        
        if ([className isEqualToString:@"NewQingBaoViewController"]) {
            [self.tabBarController setSelectedIndex:2];
            return;
        }
        
        if ([className isEqualToString:@"LiveQuizViewController"]) {
            WebModel *model = [[WebModel alloc]init];
            NSDictionary *vDic = dataDic[@"v"];
            model.title = PARAM_IS_NIL_ERROR(vDic[@"title"]);
            model.webUrl = PARAM_IS_NIL_ERROR(vDic[@"url"]);
            model.hideNavigationBar = YES;
            LiveQuizViewController *controller = [[LiveQuizViewController alloc]init];
            controller.model = model;
            [self.navigationController pushViewController:controller animated:YES];
            return;
        }
        
        if ([className isEqualToString:@"GQRedBombActivity"]) {
            WebModel *model = [[WebModel alloc]init];
            NSDictionary *vDic = dataDic[@"v"];
            model.title = PARAM_IS_NIL_ERROR(vDic[@"title"]);
            model.webUrl = PARAM_IS_NIL_ERROR(vDic[@"url"]);
            model.hideNavigationBar = YES;
            GQWebView *web = [[GQWebView alloc]init];
            web.webDelegate = self;
            web.frame = [UIScreen mainScreen].bounds;
            web.model = model;
            web.opaque = NO;
            web.backgroundColor = [UIColor clearColor];
            web.scrollView.scrollEnabled = false;
            [[Methods getMainWindow] addSubview:web];
            _activityWeb = web;
            return;
        }
        
        if ([self containsClassName:className]) {
            UIViewController *controller =[self indexWithClassName:className];
            if (controller) {
                [self.navigationController popToViewController:controller animated:YES];
            } else {
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
            
        } else {
            Class targetCalss = NSClassFromString(className);
            id target = [[targetCalss alloc] init];
            if (target == nil) {
                [SVProgressHUD showErrorWithStatus:@"暂时不能打开"];
                return;
            } else {
                unsigned int outCount = 0;
                NSMutableArray *keyArray = [NSMutableArray array];
                objc_property_t *propertys = class_copyPropertyList([targetCalss class], &outCount);
                for (unsigned int i = 0; i < outCount; i ++) {
                    objc_property_t property = propertys[i];
                    NSString * propertyName = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
                    [keyArray addObject:propertyName];
                }
                free(propertys);
                
                NSDictionary *parameterDic = dataDic[@"v"];
                if (parameterDic.allKeys.count > 0) {
                    NSArray *array = parameterDic.allKeys;
                    for (NSInteger i = 0; i < array.count; i++) {
                        NSString *key = array[i];
                        if ([keyArray containsObject:key]) {
                            [target setValue:parameterDic[key] forKey:key];
                        }
                    }
                }
                [self.navigationController pushViewController:target animated:YES];
            }
        }
    }
}

- (void)pay:(id)data {
    if ([data isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dataDic = (NSDictionary *)data;
        NSDictionary *parameter = dataDic[@"data"];
        NSString *type = dataDic[@"type"];
        __weak ToolWebViewController *weakSelf = self;
        if ([type isEqualToString:@"wx"]) {
            XHPayWxReq *req = [[XHPayWxReq alloc] init];
            req.openID = parameter[@"appid"];
            req.partnerId = parameter[@"partnerid"];
            req.prepayId = parameter[@"prepayid"];
            req.nonceStr = parameter[@"noncestr"];
            NSUInteger timStamp = [parameter[@"timestamp"] integerValue];
            req.timeStamp = timStamp;//时间戳，防重发
            req.package = parameter[@"package"];
            req.sign = parameter[@"sign"];//签名
            [[XHPayKit defaultManager] wxpayOrder:req completed:^(NSDictionary *resultDict) {
                NSInteger code = [resultDict[@"errCode"] integerValue];
                if(code == 0){//支付成功
                    weakSelf.callBack(@"1");
                } else {
                    weakSelf.callBack(@"0");
                }
            }];
        } else if ([type isEqualToString:@"ali"]) {
            NSString *orderSign = dataDic[@"data"];
            [[XHPayKit defaultManager] alipayOrder:orderSign fromScheme:@"com.Gunqiu.GQapp" completed:^(NSDictionary *resultDict) {
                NSInteger status = [resultDict[@"resultStatus"] integerValue];
                if(status == 9000){
                    weakSelf.callBack(@"1");
                } else {
                    weakSelf.callBack(@"0");
                }
            }];
        } else if ([type isEqualToString:@"apple"]) {
            [self appleBuyWithData:parameter];
        }
    } else {
        [SVProgressHUD showErrorWithStatus:@"数据类型报错"];
    }
}

- (void)nav:(id)data {
    if ([data isKindOfClass:NSClassFromString(@"NSDictionary")]) {
        NSDictionary *dataDic = (NSDictionary *)data;
        BOOL nav_hidden = [dataDic[@"nav_hidden"] integerValue];
        [self.navigationController setNavigationBarHidden:nav_hidden animated:YES];
        [self configWebHeight];
        if (!nav_hidden) {
            self.navigationItem.title = dataDic[@"title"];
            NSArray *leftArray = dataDic[@"left"];
            if (leftArray.count > 0) {
                NSMutableArray *leftItemsArray = [NSMutableArray new];
                for (NSInteger i = 0; i < leftArray.count; i ++) {
                    NSDictionary *dic = leftArray[i];
                    [[SDImageCache sharedImageCache]removeImageForKey:dic[@"icon"]];
                    NavImageView *imageV = [[NavImageView alloc]init];
                    imageV.frame = CGRectMake(i * 44, 0, 44, 44);
                    [imageV sd_setImageWithURL:[NSURL URLWithString:dic[@"icon"]] placeholderImage:[UIImage imageNamed:dic[@"icon"]]];
                    imageV.userInteractionEnabled = YES;
                    imageV.Parameter = dic;
                    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tableBarAction:)];
                    [imageV addGestureRecognizer:tap];
                    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:imageV];
                    [leftItemsArray addObject:item];
                }
                self.navigationItem.leftBarButtonItems = [leftItemsArray copy];
            }
            
            NSArray *rightArray = dataDic[@"right"];
            if (rightArray.count > 0) {
                NSMutableArray *rightItemsArray = [NSMutableArray new];
                rightArray = [[rightArray reverseObjectEnumerator] allObjects];
                for (NSInteger i = 0; i < rightArray.count; i ++) {
                    NSDictionary *dic = rightArray[i];
                    [[SDImageCache sharedImageCache]removeImageForKey:dic[@"icon"]];
                    NavImageView *imageV = [[NavImageView alloc]init];
                    imageV.frame = CGRectMake(i * 44, 0, 44, 44);
                    [imageV sd_setImageWithURL:[NSURL URLWithString:dic[@"icon"]] placeholderImage:[UIImage imageNamed:dic[@"icon"]]];
                    imageV.userInteractionEnabled = YES;
                    imageV.Parameter = dic;
                    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tableBarAction:)];
                    [imageV addGestureRecognizer:tap];
                    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:imageV];
                    [rightItemsArray addObject:item];
                }
                self.navigationItem.rightBarButtonItems = rightItemsArray;
            }
        }
    }
}

#pragma mark - Private Method

- (NSString *)getJSONMessage:(NSDictionary *)messageDic {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:messageDic options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};
    //去掉字符串中的空格
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    //去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}

- (void)pushToMatchDetail:(NSDictionary *)parameter {
    NSDictionary *v = parameter[@"v"];
    [self toFenxiWithMatchId:v[@"id"] toPageindex:[v[@"linkType"] integerValue] toItemIndex:[v[@"currentIndex"] integerValue]];
    
}
//loop 跳转分析页
- (void)toFenxiWithMatchId:(NSString *)idID toPageindex:(NSInteger)pageIndex toItemIndex:(NSInteger)itemIndex;
{
    //index 1 基本面 2 情报面 3 推荐
    
    if (!_isToFenxi == YES) {
        _isToFenxi = YES;
        
        NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[HttpString getCommenParemeter]];
        if (idID== nil) {
            idID = @"";
        }
        [parameter setObject:@"3" forKey:@"flag"];
        [parameter setObject:idID forKey:@"sid"];
        [[DCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_liveScores] Start:^(id requestOrignal) {
            
        } End:^(id responseOrignal) {
            
        } Success:^(id responseResult, id responseOrignal) {
            if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
                
                LiveScoreModel *model = [LiveScoreModel entityFromDictionary:[responseOrignal objectForKey:@"data"]];
                //从首页跳转分析页的时候不用反转
                model.neutrality = NO;
                FenxiPageVC *fenxiVC = [[FenxiPageVC alloc] init];
                fenxiVC.model = model;
                
                fenxiVC.segIndex = itemIndex;
                fenxiVC.currentIndex = pageIndex;
                
                fenxiVC.hidesBottomBarWhenPushed = YES;
                [APPDELEGATE.customTabbar pushToViewController:fenxiVC animated:YES];
                
            }
            _isToFenxi = NO;
            
            
        } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
            _isToFenxi = NO;
            
        }];
        
    }else{

    }
}

- (void)createNullToastView:(NSString *)text imageName:(NSString *)imageName {
    if (!_toastView) {
         _toastView = [[UIView alloc]initWithFrame:self.webView.bounds];
        UIImageView *toastImageView = [UIImageView new];
        toastImageView.image = [UIImage imageNamed:imageName];
        toastImageView.contentMode = UIViewContentModeScaleToFill;
        toastImageView.userInteractionEnabled = YES;
        [_toastView addSubview:toastImageView];
        [toastImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_toastView);
        }];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(reloadAction)];
        [toastImageView addGestureRecognizer:tap];
        [self.webView addSubview:_toastView];
    }
}

- (void)dissMissToastView {
    if (_toastView) {
        [_toastView removeFromSuperview];
        _toastView = nil;
    }
}

#pragma mark - Events

- (void)reloadAction {
    [self loadData];
}

- (void)tableBarAction:(UITapGestureRecognizer *)tap {
    NavImageView *imageView = (NavImageView *)tap.view;
    if ([imageView.Parameter isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dic = (NSDictionary *)imageView.Parameter;
        SEL selecter = NSSelectorFromString(dic[@"func"]);
        if ([self respondsToSelector:selecter]) {
            NSDictionary *data = dic[@"vars"];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [self performSelector:selecter withObject:data];
#pragma clang diagnostic pop
        }
    }
}

- (void)buyAction {
    if(![Methods login]) {
        [Methods toLogin];
        return;
    }
    
    WebModel *model = [[WebModel alloc]init];
    model.title = @"服务介绍";
    if (self.recordUrl) {
        if ([_recordUrl containsString:@"appH5/"]) {
            NSArray *array = [_recordUrl componentsSeparatedByString:@"appH5/"];
            NSString *htmlStr = [array lastObject];
            NSArray *modelArray = [htmlStr componentsSeparatedByString:@"."];
            NSString *modelStr = [modelArray firstObject];
            NSString *url= [NSString stringWithFormat:@"%@/appH5/%@-pay.html", APPDELEGATE.url_ip,modelStr];
            model.webUrl = url;
        }

    } else {
          model.webUrl = [NSString stringWithFormat:@"%@/appH5/%@", APPDELEGATE.url_ip,_model.modelType];
    }
    
    ToolWebViewController *webControl = [[ToolWebViewController alloc]init];
    webControl.model = model;
    [self.navigationController pushViewController:webControl animated:YES];
}



- (void)currentPage:(id)data {
    self.recordUrl = data;
}

- (void)payAction:(id)data {
    NSMutableArray *dataArray = [ArchiveFile getDataWithPath:Buy_Type_Path];
    if (!(dataArray.count > 0)) {
        [self appleBuyWithData:data];
        return;
    }
    
    NSString *matchID = data[@"scheduleId"];
    NSMutableArray *array = [NSMutableArray new];
    for (NSInteger i = 0; i < dataArray.count; i ++) {
        NSDictionary *typeDic = dataArray[i];
        NSInteger type = [typeDic[@"type"] integerValue];
        NSString *text = typeDic[@"text"];
        NSString *icon = nil;
        switch (type) {
            case 0: {
                icon = @"appicon";
            }
                break;
            case 1: {
                icon = @"wxicon";
            }
                break;
                
            case 2: {
                icon = @"aliicon";
            }
                break;
                
            case 3: {
                icon = @"coupon";
            }
                break;
                
            default:
                break;
        }
        if (matchID && type == 3) {
            [array addObject:@{PayMentLeftIcon:icon, PayMentTitle:text, PayMentType:@(type), CouponCount:data[@"couponCount"]}];
        } else {
            [array addObject:@{PayMentLeftIcon:icon, PayMentTitle:text, PayMentType:@(type)}];
        }
        
    }
    
    if (!matchID) {
        [array removeLastObject];
    }
    
    __weak ToolWebViewController *weakSelf = self;
    [SelectPayMentView showPaymentInfo:[NSString stringWithFormat:@"￥%@",PARAM_IS_NIL_ERROR(data[@"amount"])] options:array  animations:YES selectOption:^(payMentType type) {
        switch (type) {
            case payMentTypeApplePurchase: {
                [weakSelf appleBuyWithData:data];
            }
                break;
                
            case payMentTypeWx: {
                [weakSelf tencentBuyWithData:data];
            }
                break;
                
            case payMentTypeAli: {
                [weakSelf alibuyWithData:data];
            }
                break;
                
            case payMentTypeCoupon: {
                [weakSelf couponBuyWithData:data];
            }
                break;
                
            default:
                break;
        }
    }];
}

#pragma mark - Buy Type

- (void)tencentBuyWithData:(NSDictionary *)data {
    [LodingAnimateView showLodingView];
    NSMutableDictionary *parameter =[NSMutableDictionary dictionaryWithDictionary: [HttpString getCommenParemeter]];
    [parameter setObject:data[@"type"] forKey:@"modelType"];
    [parameter setObject:data[@"serviceType"] forKey:@"serviceType"];
    [parameter setObject:@"IOS" forKey:@"resource"];
    [parameter setObject:PARAM_IS_NIL_ERROR(data[@"scheduleId"]) forKey:@"matchId"];
    [[DCHttpRequest shareInstance]sendGetRequestByMethod:@"post" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_modelPay] Start:^(id requestOrignal) {
        
    } End:^(id responseOrignal) {
        
    } Success:^(id responseResult, id responseOrignal) {
        [LodingAnimateView dissMissLoadingView];
        NSDictionary *resultDic = (NSDictionary *)responseOrignal;
        if ([resultDic[@"code"] isEqualToString:@"200"]) {
            NSDictionary *dataDic = resultDic[@"data"];
            XHPayWxReq *req = [[XHPayWxReq alloc] init];
            req.openID = dataDic[@"appid"];
            req.partnerId = dataDic[@"partnerid"];
            req.prepayId = dataDic[@"prepayid"];
            req.nonceStr = dataDic[@"noncestr"];
            NSUInteger timStamp = [dataDic[@"timestamp"] integerValue];
            req.timeStamp = timStamp;//时间戳，防重发
            req.package = dataDic[@"package"];
            req.sign = dataDic[@"sign"];//签名
            
            [[XHPayKit defaultManager] wxpayOrder:req completed:^(NSDictionary *resultDict) {
                NSInteger code = [resultDict[@"errCode"] integerValue];
                if(code == 0){//支付成功
                    [SVProgressHUD showSuccessWithStatus:@"购买成功"];
                    [self.navigationController popViewControllerAnimated:YES];
                } else {
                    [SVProgressHUD showSuccessWithStatus:@"购买失败"];
                }
            }];
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        [LodingAnimateView dissMissLoadingView];
        [SVProgressHUD showErrorWithStatus:errorDict];
    }];
}

- (void)alibuyWithData:(NSDictionary *)data {
    [LodingAnimateView showLodingView];
    NSMutableDictionary *parameter =[NSMutableDictionary dictionaryWithDictionary: [HttpString getCommenParemeter]];
    [parameter setObject:data[@"type"] forKey:@"modelType"];
    [parameter setObject:data[@"serviceType"] forKey:@"serviceType"];
    [parameter setObject:@"IOS" forKey:@"resource"];
    [parameter setObject:PARAM_IS_NIL_ERROR(data[@"scheduleId"]) forKey:@"matchId"];
    [[DCHttpRequest shareInstance]sendGetRequestByMethod:@"post" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_modelPay_ali] Start:^(id requestOrignal) {
        
    } End:^(id responseOrignal) {
        
    } Success:^(id responseResult, id responseOrignal) {
        [LodingAnimateView dissMissLoadingView];
        NSDictionary *resultDic = (NSDictionary *)responseOrignal;
        if ([resultDic[@"code"] isEqualToString:@"200"]) {
            NSString *orderSign = resultDic[@"data"];
            [[XHPayKit defaultManager] alipayOrder:orderSign fromScheme:@"com.Gunqiu.GQapp" completed:^(NSDictionary *resultDict) {
                NSInteger status = [resultDict[@"resultStatus"] integerValue];
                if(status == 9000){
                    [SVProgressHUD showSuccessWithStatus:@"购买成功"];
                    [self.navigationController popViewControllerAnimated:YES];
                } else {
                    [SVProgressHUD showSuccessWithStatus:@"购买失败"];
                }
            }];
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        [LodingAnimateView dissMissLoadingView];
        [SVProgressHUD showErrorWithStatus:errorDict];
    }];
}

- (void)appleBuyWithData:(NSDictionary *)data {
     MBProgressHUD *hud = [[MBProgressHUD alloc]init];
     hud.mode = MBProgressHUDModeIndeterminate;
     hud.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.5];
     [self.view addSubview:hud];
     [hud show:YES];
    
    NSDictionary *dic = data;
    NSNumber *ordeId = dic[@"orderId"];
    NSString *productId = dic[@"productId"];
    NSInteger amount = [dic[@"amount"] integerValue];
    
    [[AppleIAPService sharedInstance]purchase:@{@"product_id":PARAM_IS_NIL_ERROR(productId), @"orderID":ordeId, @"amount":@(amount)} resultBlock:^(NSString *message, NSError *error) {
        [hud hide:YES];
        if (error) {
            NSString *errMse = error.userInfo[@"NSLocalizedDescription"];
            [SVProgressHUD showErrorWithStatus:errMse];
        } else{
            [SVProgressHUD showSuccessWithStatus:@"购买成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

- (void)couponBuyWithData:(NSDictionary *)data {
    if (!([data[@"couponCount"] integerValue] > 0)) {
        [SVProgressHUD showErrorWithStatus:@"您暂时还未拥有优惠券"];
        return;
    }
    [LodingAnimateView dissMissLoadingView];
    NSMutableDictionary *parameter =[NSMutableDictionary dictionaryWithDictionary: [HttpString getCommenParemeter]];
    [parameter setObject:data[@"type"] forKey:@"modelType"];
    [parameter setObject:data[@"serviceType"] forKey:@"serviceType"];
    [parameter setObject:@"IOS" forKey:@"resource"];
    [parameter setObject:PARAM_IS_NIL_ERROR(data[@"scheduleId"]) forKey:@"matchId"];
    [[DCHttpRequest shareInstance]sendGetRequestByMethod:@"post" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_modelPay_coupon] Start:^(id requestOrignal) {
        
    } End:^(id responseOrignal) {
        
    } Success:^(id responseResult, id responseOrignal) {
        [LodingAnimateView dissMissLoadingView];
        NSDictionary *resultDic = (NSDictionary *)responseOrignal;
        if ([resultDic[@"code"] isEqualToString:@"200"]) {
            [SVProgressHUD showSuccessWithStatus:@"购买成功"];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [SVProgressHUD showSuccessWithStatus:@"购买失败"];
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        [LodingAnimateView dissMissLoadingView];
        [SVProgressHUD showErrorWithStatus:errorDict];
    }];
}

- (BOOL)containsClassName:(NSString *)className {
    NSArray *classArray = self.navigationController.viewControllers;
    Class targetClass = NSClassFromString(className);
    for (UIViewController *control in classArray) {
        if (control.class == targetClass) {
            return YES;
        } else {
            return false;
        }
    }
    return false;
}

- (id)indexWithClassName:(NSString *)className {
    NSArray *classArray = self.navigationController.viewControllers;
    Class targetClass = NSClassFromString(className);
    for (NSInteger i = 0; i < classArray.count; i++) {
        UIViewController *control = classArray[i];
        if (control.class == targetClass) {
            return control;
        }
    }
    return nil;
}

#pragma mark - Lazy Load

- (UIWebView *)webView
{
    if (!_webView)
    {
        _webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
        _webView.delegate = self;
        _webView.backgroundColor = [UIColor whiteColor];
        _webView.scrollView.showsVerticalScrollIndicator = NO;
        _webView.scrollView.showsHorizontalScrollIndicator = NO;
        _webView.scrollView.keyboardDismissMode  = UIScrollViewKeyboardDismissModeOnDrag;
    }
    return _webView;
}

@end
