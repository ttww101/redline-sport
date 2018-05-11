//
//  BaseWebViewController.m
//  newGQapp
//
//  Created by genglei on 2018/4/26.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import "BaseWebViewController.h"
#import "WebViewJavascriptBridge.h"
#import "AppManger.h"
#import "NavImageView.h"
#import "ToolWebViewController.h"

@interface BaseWebViewController () <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@property (nonatomic , strong) WebViewJavascriptBridge* bridge;

@property (nonatomic , copy) GQJSResponseCallback callBack;

@property (nonatomic , assign) BOOL isToFenxi;


@end

@implementation BaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (_webView) {
        [_webView removeFromSuperview];
        _webView = nil;
    }
    [self configUI];
    [self loadBradgeHandler];
    [self loadData];
}

- (void)loadBradgeHandler {
    __weak BaseWebViewController *weakSelf = self;
    WebViewJavascriptBridge *bridge = [[AppManger shareInstance]registerJSTool:self.webView hannle:^(id data, GQJSResponseCallback responseCallback) {
        if (responseCallback) {
            weakSelf.callBack = responseCallback;
        }
        JSModel *model = (JSModel *)data;
        NSString *actionString = model.methdName;
        SEL action = NSSelectorFromString(actionString);
        if ([self respondsToSelector:action]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [weakSelf performSelector:action withObject:model.parameterData];
#pragma clang diagnostic pop
        }
    }];
    
    [bridge setWebViewDelegate:self];
}

#pragma mark - Load Data

- (void)loadData {
    if (_model) {
        self.urlPath = _model.webUrl;
        self.html5Url = _model.htmlUrl;
    }
    
    if (self.urlPath != nil) {
        self.urlPath = [self.urlPath stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSURL *url = [NSURL URLWithString:self.urlPath];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:15];
        [self.webView loadRequest:request];
    } else if (self.html5Url != nil) {
        NSString* path = [[NSBundle mainBundle] pathForResource:self.html5Url ofType:@"html"];
        NSString *htmlString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        [self.webView loadHTMLString:htmlString baseURL:[NSURL URLWithString:path]];
    }
}

#pragma mark - Config UI

- (void)configUI {
    if (!_webView) {
        [self.view addSubview:self.webView];
        self.webView.frame = CGRectMake(0, 0, self.view.width, self.view.height - self.tabBarController.tabBar.height);
    }
   
    self.navigationItem.title = _model.title;
    adjustsScrollViewInsets_NO(self.webView.scrollView, self);
    [self.navigationController setNavigationBarHidden:_model.hideNavigationBar animated:YES];
    
    if (self.navigationController.navigationBarHidden) {
        
    } else {
        if ([_model.parameter isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dataDic = _model.parameter;
            NSDictionary *navDic = dataDic[@"nav"];
            NSArray *leftArray = navDic[@"left"];
            NSArray *rightArray = navDic[@"right"];
            if (leftArray.count > 0) {
                NSMutableArray *leftItemsArray = [NSMutableArray new];
                for (NSInteger i = 0; i < leftArray.count; i ++) {
                    NSDictionary *dic = leftArray[i];
                    NavImageView *imageV = [[NavImageView alloc]init];
                    [[SDImageCache sharedImageCache]removeImageForKey:dic[@"icon"]];
                   [imageV sd_setImageWithURL:[NSURL URLWithString:dic[@"icon"]] placeholderImage:[UIImage imageNamed:dic[@"icon"]]];
                    imageV.frame = CGRectMake(i * 22, 0, 22, 22);
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
                    imageV.frame = CGRectMake(i * 22, 0, 22, 22);
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
    [LodingAnimateView showLodingView];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [LodingAnimateView dissMissLoadingView];
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [SVProgressHUD showErrorWithStatus:@"加载失败"];
    [LodingAnimateView dissMissLoadingView];
}

#pragma mark - Private Method

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

#pragma mark - Events

- (void)tableBarAction:(UITapGestureRecognizer *)tap {
    NavImageView *imageView = (NavImageView *)tap.view;
    if ([imageView.Parameter isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dic = (NSDictionary *)imageView.Parameter;
        SEL selecter = NSSelectorFromString(dic[@"func"]);
        if ([self respondsToSelector:selecter]) {
            NSDictionary *data = nil;
            if ([dic[@"func"] isEqualToString:@"openNative:"]) {
                data = dic[@"vars"];
            }
            
            if ([dic[@"func"] isEqualToString:@"openH5:"]) {
                data = dic[@"vars"];
              
            }
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [self performSelector:selecter withObject:data];
#pragma clang diagnostic pop
        }
    }
}

#pragma mark - JS Handle

- (void)openNative:(id)data {
    if ([data isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dataDic = (NSDictionary *)data;
        NSString *className = dataDic[@"n"];
        
        if ([className isEqualToString:@"FenxiPageVC"]) {
            [self pushToMatchDetail:dataDic];
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

#pragma mark - Lazy Load

- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc]init];
        _webView.delegate = self;
        _webView.backgroundColor = [UIColor whiteColor];
        _webView.scrollView.showsVerticalScrollIndicator = NO;
        _webView.scrollView.showsHorizontalScrollIndicator = NO;
        _webView.scrollView.keyboardDismissMode  = UIScrollViewKeyboardDismissModeOnDrag;
    }
    return _webView;
}

@end
