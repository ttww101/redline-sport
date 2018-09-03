//
//  NewTuijianHtml.m
//  GQapp
//
//  Created by 叶忠阳 on 2017/5/8.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import "NewTuijianHtml.h"
#import "WebViewJavascriptBridge.h"
#import "NewZhiShuWebVC.h"
#import "WKWebViewJavascriptBridge.h"

@interface NewTuijianHtml()
@property WebViewJavascriptBridge* bridge;
@property (nonatomic, assign) NSInteger indexZhiShuNum;//判断指数请求数据
@property (nonatomic, retain) NSMutableArray *arrZhiShu;//指数的数据
@property (nonatomic, assign) CGFloat oldContentY;
@property (nonatomic, strong) UISegmentedControl *segment;


@end

@implementation NewTuijianHtml

- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame: frame]) {
        
                
        
        self.opaque = NO;
        self.scalesPageToFit = YES;
        UIView *viewHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 65)];
        viewHeader.backgroundColor = [UIColor whiteColor];
        [self addSubview:viewHeader];
        _segment = [[UISegmentedControl alloc] initWithItems:@[@"欧赔",@"亚盘",@"大小球",@"凯利",@"必发"]];
        _segment.frame = CGRectMake(0, 15, 60*5, 30);
        _segment.center = CGPointMake(Width/2, _segment.center.y);
        _segment.tintColor = redcolor;
//        if (self.segIndex) {
//            _segment.selectedSegmentIndex = self.segIndex;
//        }else{
            _segment.selectedSegmentIndex = 0;
//        }
        
        
       
        [_segment addTarget:self action:@selector(changIndex:) forControlEvents:UIControlEventValueChanged];
        [viewHeader addSubview:_segment];
        
        _indexZhiShuNum = 0;
        _arrZhiShu = [[NSMutableArray alloc] initWithCapacity:0];

        _bridge = [WebViewJavascriptBridge bridgeForWebView:self];
        self.backgroundColor = colorTableViewBackgroundColor;
        

        
//        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(delayMethod) userInfo:nil repeats:NO];
//        [WebViewJavascriptBridge enableLogging];
        [_bridge registerHandler:@"zhushuList" handler:^(id data, WVJBResponseCallback responseCallback) {
            // data 后台传过来的参数,例如用户名、密码等
            
            NSLog(@"%@", data);
            NewZhiShuWebVC *listWeb = [[NewZhiShuWebVC alloc] init];
            listWeb.dic = data;
            
            listWeb.hidesBottomBarWhenPushed = YES;
            [APPDELEGATE.customTabbar pushToViewController:listWeb animated:YES];
            
            
            //具体的登录事件的实现,这里的login代表实现登录功能的一个OC函数。
            
            
            // responseCallback 给后台的回复
            
            responseCallback(@"Response from testObjcCallback");
        }];
    }

    return self;
}
- (void)setSegIndex:(NSInteger)segIndex{
    _segIndex = segIndex;
    
        _segment.selectedSegmentIndex = _segIndex;

    
}

- (void)changIndex:(UISegmentedControl *)seg
{
    
    [_bridge callHandler:@"zhishuindex" data:[NSString stringWithFormat:@"%ld",seg.selectedSegmentIndex] responseCallback:^(id response) {
        NSLog(@"testJavascriptHandler responded: %@", response);
    }];

}
- (void)delayMethod{
//    [self reload];
}
- (void)setModel:(LiveScoreModel *)model{
    _model = model;
    [self loadZhiShu];
}
- (void)loadZhiShu{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:[HttpString getCommenParemeter]];
    //    [dict setObject:@(self.model.mid) forKey:@"matchId"];
    
    //    1366319self.model.mid
    [dict setObject:@(self.model.mid) forKey:@"sid"];
    switch (_indexZhiShuNum) {
        case 0:{
            [dict setObject:@"1" forKey:@"flag"];
            
        }
            break;
        case 1:{
            [dict setObject:@"2" forKey:@"flag"];
            
        }
            break;
        case 2:{
            [dict setObject:@"3" forKey:@"flag"];
            
        }
            break;
        case 3:{
            [dict setObject:@"2" forKey:@"flag"];
            
        }
            break;
            
        default:
            break;
    }
    
    [[DCHttpRequest shareInstance] sendHtmlGetRequestByMethod:@"get" WithParamaters:dict PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,_indexZhiShuNum == 3 ? url_JiaoYiList:url_ZhiShuOuPei] Start:^(id requestOrignal) {
        
    } End:^(id responseOrignal) {
        
    } Success:^(id responseResult, id responseOrignal) {
//        NSLog(@"%@",responseOrignal);
        [_arrZhiShu addObject:responseOrignal];
        if (_indexZhiShuNum == 3) {
            
            NSString *path = [[NSBundle mainBundle] pathForResource:@"zhishu" ofType:@"html"];
            
            NSString *htmlString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
            
            NSString *basePath = [[NSBundle mainBundle] bundlePath];
            
            NSURL *baseURL = [NSURL fileURLWithPath:basePath];
            
            [self loadHTMLString:htmlString baseURL:baseURL];
            
            [_arrZhiShu addObject:[NSString stringWithFormat:@"%ld",_model.mid]];
            
            [_bridge callHandler:@"zhishu" data:_arrZhiShu responseCallback:^(id response) {
                NSLog(@"testJavascriptHandler responded: %@", response);
            }];
            if (self.segIndex) {
                [_bridge callHandler:@"zhishuindex" data:[NSString stringWithFormat:@"%ld",self.segIndex] responseCallback:^(id response) {
                    NSLog(@"testJavascriptHandler responded: %@", response);
                }];
                
            }
            

            
//            [self reload];
        }else{
            _indexZhiShuNum += 1;
            [self loadZhiShu];
        }
        
        
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        
    }];
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    
    if (!_cellCanScroll) {
        scrollView.contentOffset = CGPointZero;
    }
    if (scrollView.contentOffset.y <= 0) {
        
        _cellCanScroll = NO;
        scrollView.contentOffset = CGPointZero;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"changeTableViewFrame" object:nil];//到顶通知父视图改变状态
    }
    
    
}
    

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
