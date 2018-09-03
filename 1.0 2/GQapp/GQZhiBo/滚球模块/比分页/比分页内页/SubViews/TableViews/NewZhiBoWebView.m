//
//  NewZhiBoWebView.m
//  GQapp
//
//  Created by 叶忠阳 on 2017/5/17.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import "NewZhiBoWebView.h"
#import "WebViewJavascriptBridge.h"
#import "WKWebViewJavascriptBridge.h"

@interface NewZhiBoWebView()
@property WebViewJavascriptBridge* bridge;
@property (nonatomic, retain)NSMutableArray *arrzhibo;
@property (nonatomic, assign) CGFloat oldContentY;

@end


@implementation NewZhiBoWebView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        
        UIView *viewHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 65)];
        viewHeader.backgroundColor = [UIColor whiteColor];
        [self addSubview:viewHeader];

        UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:@[@"即时赔率",@"比赛统计",@"双方阵容"]];
        UIFont *font = [UIFont boldSystemFontOfSize:12.0f];
        NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
       
        [segment setTitleTextAttributes:attributes forState:UIControlStateNormal];
        segment.frame = CGRectMake(0, 15, 85*2, 30);
        segment.center = CGPointMake(Width/2, segment.center.y);
        segment.tintColor = redcolor;
        
        segment.selectedSegmentIndex = 0;
        [segment addTarget:self action:@selector(changIndex:) forControlEvents:UIControlEventValueChanged];
        [viewHeader addSubview:segment];
        
        
//        if (segment.selectedSegmentIndex == 0) {
//            
//            UITableView *jiShiTableView = [UITableView new];
//            jiShiTableView.backgroundColor = redcolor;
//            jiShiTableView.delegate = self;
//            jiShiTableView.dataSource = self;
//            jiShiTableView.frame = CGRectMake(0, 65 + 10, Width, 200);
//            [self addSubview:jiShiTableView];
//        }
        
        self.opaque = NO;
        self.scalesPageToFit = YES;
        _arrzhibo = [[NSMutableArray alloc] initWithCapacity:0];
 
        _bridge = [WebViewJavascriptBridge bridgeForWebView:self];
        self.backgroundColor = colorTableViewBackgroundColor;
        [WebViewJavascriptBridge enableLogging];

    }
    
    return self;
    
}

- (void)changIndex:(UISegmentedControl *)segment
{
//    if (segment.selectedSegmentIndex == 0) {
    
//        self.hidden = YES;
//    }else {
    
        [_bridge callHandler:@"zhiBoindex" data:[NSString stringWithFormat:@"%ld",segment.selectedSegmentIndex] responseCallback:^(id response) {
            NSLog(@"testJavascriptHandler responded: %@", response);
        }];
//    }
}


- (void)setModel:(LiveScoreModel *)model{
    _model = model;
    [self loadDataZhiBo];
}
- (void)loadDataZhiBo{
    
    [[DCHttpRequest shareInstance] sendHtmlGetRequestByMethod:@"get" WithParamaters:nil PathUrlL:[NSString stringWithFormat:@"%@%@%ld.json",APPDELEGATE.url_jsonHeader,@"/jsbf/live/newlive_",self.model.mid] Start:^(id requestOrignal) {
        
    } End:^(id responseOrignal) {
        
    } Success:^(id responseResult, id responseOrignal) {
//        NSLog(@"%@",responseOrignal);
        NSString* path = [[NSBundle mainBundle] pathForResource:@"zhibo" ofType:@"html"];
        
        NSString *htmlString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        
        NSString *basePath = [[NSBundle mainBundle] bundlePath];
        
        NSURL *baseURL = [NSURL fileURLWithPath:basePath];
        
        [self loadHTMLString:htmlString baseURL:baseURL];

        
        [_arrzhibo addObject:responseOrignal];
        if ((![[[NSUserDefaults standardUserDefaults] objectForKey:@"_currentflag"] isEqualToString:@"0"])) {
            
            if (_model.neutrality) {
                
                [_arrzhibo addObject:@{@"guesName":self.model.hometeam.length < 6 ? self.model.hometeam:[self.model.hometeam substringToIndex:6],@"homeName":self.model.guestteam.length < 6 ? self.model.guestteam:[self.model.guestteam substringToIndex:6]}];
 
            }else{
            
                [_arrzhibo addObject:@{@"homeName":self.model.hometeam.length < 6 ? self.model.hometeam:[self.model.hometeam substringToIndex:6],@"guesName":self.model.guestteam.length < 6 ? self.model.guestteam:[self.model.guestteam substringToIndex:6]}];

            }
            
        }else{
               [_arrzhibo addObject:@{@"homeName":self.model.hometeam.length < 6 ? self.model.hometeam:[self.model.hometeam substringToIndex:6],@"guesName":self.model.guestteam.length < 6 ? self.model.guestteam:[self.model.guestteam substringToIndex:6]}];

            
        }
        
        [_bridge callHandler:@"zhiBo" data:_arrzhibo responseCallback:^(id response) {
            NSLog(@"testJavascriptHandler responded: %@", response);
        }];

        
//        [self reload];
 
        
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
