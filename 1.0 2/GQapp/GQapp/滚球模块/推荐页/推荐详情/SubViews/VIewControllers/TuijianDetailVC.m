//
//  TuijianDetailVC.m
//  GQapp
//
//  Created by WQ_h on 16/8/3.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import "TuijianDetailVC.h"
#import "CommentModel.h"
#import "BuyRecordsVC.h"
#import "BuyerModel.h"
#import "payUserModel.h"
#import "TuijianDetailHeaderView.h"
#import "TuijianDTViewController.h"
#import "AppleIAPService.h"
@interface TuijianDetailVC ()<UITextViewDelegate>
@property (nonatomic, strong) TuijianDetailTableView *tableView;
@property (nonatomic, strong) UITextView *textView;
//记录当前输入框中的内容
@property (nonatomic, copy) NSString *currentTextViewText;
//底部输入评论的view
@property (nonatomic, strong) UIView *bottomView;
//支付View
@property (nonatomic, strong) UIView *payView;
//需要球币
@property (nonatomic, strong) UILabel *labelQiuBi;
//paybtn
@property (nonatomic, strong) UIButton *btnPay;
//发送按钮
@property (nonatomic, strong) UIButton *sendBtn;
//取消按钮
@property (nonatomic, strong) UIButton *cancelBtn;

//底部的点赞
@property (nonatomic, strong) UIButton *labComment;
//底部的点赞数
@property (nonatomic, strong) UILabel *labCommentNum;

//底部的点反
@property (nonatomic, strong) UIButton *labComment1;
//底部的点反数
@property (nonatomic, strong) UILabel *labCommentNum1;

//头部数据
@property (nonatomic, strong) TuijiandatingModel *model;

//分享

//区分发送评论的类型
@property (nonatomic, assign) NSInteger sendCommentTag;
@property (nonatomic, strong) NSDictionary *notifComment;
@property (nonatomic, assign) NSInteger payTime;

@property (nonatomic, strong) NSArray *buyerArr;
@property (nonatomic, strong) NSString *appIdStr;

@end

@implementation TuijianDetailVC
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UMStatisticsMgr sharedInstance] viewStaticsBeginWithMarkStr:@"TuijianDetailVC"];
    self.navigationController.navigationBarHidden = YES;
    [self.tableView reloadData];
    
    
}
-(UIStatusBarStyle)preferredStatusBarStyle

{
    return UIStatusBarStyleLightContent;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self viewdatanew];
    [self zhucetongzhi];
}
-(void)viewdatanew{
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    //    [self.tableView addSubview:self.bottomView];
    
    //默认是1 ，有些页面没有传值，所以赋值为1
    if (_status == 0) {
        _status = 1;
    }
    
    [self payViewpayl];
    [self loadDataWhetherFirst:YES];
    [self.view addSubview:self.tableView];
    
    // if (_status == 1) {
    [self.view addSubview:self.payView];
    [self.view addSubview:self.bottomView];
    [self addAutoLayout];
    
    //}

    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addComment:) name:@"TuijianDetailVCAddComment" object:nil];
    [self setNavView];
}
- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [[UMStatisticsMgr sharedInstance] viewStaticsEndWithMarkStr:@"TuijianDetailVC"];
}
- (void)addComment:(NSNotification *)notification
{
    NSLog(@"%@",notification.userInfo);
    [self.textView becomeFirstResponder];
    
    
    _sendCommentTag = [[notification.userInfo objectForKey:@"commentTag"] integerValue];
    _notifComment = notification.userInfo;
    
//    [self sendCommentWithCommentTag:[[notification.userInfo objectForKey:@"commentTag"] integerValue] withDict:notification.userInfo];
    
    
}

#pragma mark -- setnavView
- (void)setNavView
{
    NavView *nav = [[NavView alloc] init];
    nav.delegate = self;
    nav.labTitle.text = @"推荐详情";
    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateNormal];
    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateHighlighted];
     [self.view addSubview:nav];
}

- (void)navViewTouchAnIndex:(NSInteger)index
{
    if (index == 1) {
//        for (UIViewController *controller in self.navigationController.viewControllers) {
//            if ([controller isKindOfClass:[TuijianDTViewController class]]) {
//                TuijianDTViewController *A =(TuijianDTViewController *)controller;
//                [self.navigationController popToViewController:A animated:YES];
//            }
//        }
//        
        
        //left
        [self.navigationController popViewControllerAnimated:YES];
        
       
        
    }else if(index == 2){
    }
}


- (void)addAutoLayout
{
    
//    if (!_model.see) {
    
        [self.payView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left);
            make.bottom.equalTo(self.view.mas_bottom);
            make.height.mas_equalTo(55);
            make.width.equalTo(self.view.mas_width);
        }];
//    }

    [self.labelQiuBi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.payView).offset(2);
        make.left.mas_equalTo(15);
        make.width.mas_equalTo(120);
    }];
    
    [self.btnPay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.trailing.bottom.equalTo(self.payView);
        make.width.mas_equalTo(100);
    }];
    
    
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tableView.mas_left);
        make.bottom.equalTo(self.view.mas_bottom);
        make.width.mas_equalTo(Width);
    }];

    
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomView.mas_top);
        make.left.equalTo(self.bottomView.mas_left).offset(15);
        make.size.mas_equalTo(CGSizeMake(0, 0));
    }];
    
    [self.sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomView.mas_top);
        make.right.equalTo(self.bottomView.mas_right).offset(-15);
        make.size.mas_equalTo(CGSizeMake(0, 0));
    }];

    
    //计算高度
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bottomView.mas_left).offset(10);
        make.bottom.equalTo(self.bottomView.mas_bottom).offset(-6);
        make.top.equalTo(self.cancelBtn.mas_bottom).offset(6);
        make.size.mas_equalTo(CGSizeMake(Width - 88 - 20, 32));
        
    }];
    [self.labComment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.textView.mas_centerY);
        make.left.equalTo(self.textView.mas_right).offset(0);
        make.size.mas_equalTo(CGSizeMake(44, 44));
    }];
    
    [self.labCommentNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.textView.mas_right).offset(35);
        make.centerY.equalTo(self.textView.mas_centerY);
    }];
    
    [self.labComment1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.textView.mas_centerY);
        make.left.equalTo(self.textView.mas_right).offset(44);
        make.size.mas_equalTo(CGSizeMake(44, 44));
    }];
    
    [self.labCommentNum1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.textView.mas_right).offset(80);
        make.centerY.equalTo(self.textView.mas_centerY);
    }];

    
    
}
- (TuijianDetailTableView *)tableView
{
    if (!_tableView) {
        _tableView = [[TuijianDetailTableView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar, Width, _status == 1? (Height - APPDELEGATE.customTabbar.height_myNavigationBar - 49):(Height - APPDELEGATE.customTabbar.height_myNavigationBar)) style:UITableViewStylePlain];
        _tableView.typeTuijianDetailHeader = _typeTuijianDetailHeader;
        _tableView.hidden = YES;
    }
    return _tableView;
}
- (NSString *)appIdStr {
    
    if (!_appIdStr) {
        _appIdStr = [NSString string];
    }
    return _appIdStr;
}

- (UIView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = colorFA;
//        _bottomView.backgroundColor = [UIColor blackColor];
        _bottomView.layer.borderColor = colorDD.CGColor;
        _bottomView.layer.borderWidth = 0.6;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addComment)];
        [_bottomView addGestureRecognizer:tap];
        [_bottomView addSubview:self.labComment];
        [_bottomView addSubview:self.labCommentNum];
        [_bottomView addSubview:self.labComment1];
        [_bottomView addSubview:self.labCommentNum1];

        [_bottomView addSubview:self.textView];
        [_bottomView addSubview:self.sendBtn];
        [_bottomView addSubview:self.cancelBtn];
        
        _bottomView.hidden = YES;
    }
    return _bottomView;
}

- (void)payViewpayl {
    
    if (!_payView) {
        _payView = [[UIView alloc] init];
        _payView.backgroundColor = colorf5f5f5;
        _payView.layer.borderColor = colorDD.CGColor;
        _payView.layer.borderWidth = 0.6;
        _payView.userInteractionEnabled = YES;
        
        [_payView addSubview:self.labelQiuBi];
        [_payView addSubview:self.btnPay];
        _payView.hidden = YES;
    }
}

- (void)addComment
{
    
    if ([self.textView isFirstResponder]) {
        [self.view endEditing:YES];
        
    }else{
        [self.textView becomeFirstResponder];
        _sendCommentTag = 0;

    }
}
- (UITextView *)textView
{
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.delegate = self;
        //        _textView.backgroundColor = colorTableViewBackgroundColor;
        _textView.font = font13;
        _textView.text = @" 说说您对比赛的看法";
        _textView.scrollEnabled = YES;   // 允许滚动
        _textView.layer.borderColor = colorDD.CGColor;
        _textView.layer.borderWidth = 0.5;
        _textView.layer.cornerRadius = 3;
        _textView.textColor = colorCC;
        _textView.userInteractionEnabled = YES;
        _textView.returnKeyType = UIReturnKeySend;
        //        _textView.returnKeyType = UIReturnKeySend;
    }
    return _textView;
}
- (UIButton *)sendBtn
{
    if (!_sendBtn) {
        _sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sendBtn setTitle:@"发送" forState:UIControlStateNormal];
        [_sendBtn setTitleColor:color33 forState:UIControlStateNormal];
        [_sendBtn.titleLabel setFont:font14];
        [_sendBtn addTarget:self action:@selector(sendComment:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendBtn;
}
- (UIButton *)cancelBtn
{
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:color33 forState:UIControlStateNormal];
        [_cancelBtn.titleLabel setFont:font14];

        [_cancelBtn addTarget:self action:@selector(cancelComment) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}
- (void)cancelComment
{
    [self.view endEditing:YES];
}
- (void)sendComment:(UIButton *)btn
{
    _sendBtn.enabled = NO;
    [self sendCommentWithCommentTag:_sendCommentTag withDict:_notifComment];
}

- (UIButton *)labComment
{
    if (!_labComment) {
        _labComment = [UIButton buttonWithType:UIButtonTypeCustom];
        [_labComment setBackgroundImage:[UIImage imageNamed:@"agreeDetail"] forState:UIControlStateNormal];
        [_labComment setBackgroundImage:[UIImage imageNamed:@"red-agreeDetail"] forState:UIControlStateSelected];
        _labComment.selected = _model.liked;
        _labComment.tag = 1;
        [_labComment addTarget:self action:@selector(addLiked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _labComment;
}

- (UILabel *)labCommentNum
{
    if (!_labCommentNum) {
        _labCommentNum = [[UILabel alloc] init];
        _labCommentNum.font = font10;
        _labCommentNum.textColor = color33;
        _labCommentNum.text = [NSString stringWithFormat:@"%ld",(long)_model.like_count];
    }
    return _labCommentNum;
}


- (UIButton *)labComment1
{
    if (!_labComment1) {
        _labComment1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_labComment1 setBackgroundImage:[UIImage imageNamed:@"noagreeDetail"] forState:UIControlStateNormal];
        [_labComment1 setBackgroundImage:[UIImage imageNamed:@"red-noagreeDetail"] forState:UIControlStateSelected];
        _labComment1.selected = _model.hated;
        _labComment1.tag = 2;
        [_labComment1 addTarget:self action:@selector(addLiked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _labComment1;
}

- (UILabel *)labCommentNum1
{
    if (!_labCommentNum1) {
        _labCommentNum1 = [[UILabel alloc] init];
        _labCommentNum1.font = font10;
        _labCommentNum1.textColor = color33;
        _labCommentNum1.text = [NSString stringWithFormat:@"%ld",(long)_model.hate_count];
    }
    return _labCommentNum1;
}

- (UILabel *)labelQiuBi {
    
    if (!_labelQiuBi) {
        _labelQiuBi = [[UILabel alloc] init];
        _labelQiuBi.font = font14;
        _labelQiuBi.textColor = color33;
    }
    return _labelQiuBi;
}

- (UIButton *)btnPay {
    
    if (!_btnPay) {
        _btnPay = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnPay setTitle:@"立即支付" forState:UIControlStateNormal];
        [_btnPay setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnPay setBackgroundColor:redcolor];
        [_btnPay.titleLabel setFont:font16];
        
        
        [_btnPay addTarget:self action:@selector(payBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnPay;
}

- (void)payBtnClick {
    [[AppleIAPService sharedInstance]purchase:@"com.Gunqiu.GQapp8" resultBlock:^(NSString *message, NSError *error) {
        if (error) {
            NSString *errMse = error.userInfo[@"NSLocalizedDescription"];
            [SVProgressHUD showErrorWithStatus:errMse];
        } else{

        }
        NSLog(@"%@   %@",message,error.userInfo);
    }];
}

/*
- (void)WXPay{
    
    PayReq *req   = [[PayReq alloc] init];
    req.openID = [[NSUserDefaults standardUserDefaults] objectForKey:@"payAppID"];;
    req.nonceStr  = [[NSUserDefaults standardUserDefaults] objectForKey:@"paynonce_str"];;
    req.package   = [[NSUserDefaults standardUserDefaults] objectForKey:@"paypackage"];
    req.partnerId = [[NSUserDefaults standardUserDefaults] objectForKey:@"paymch_id"];;
    req.prepayId  = [[NSUserDefaults standardUserDefaults] objectForKey:@"payprepay_id"];;
    req.sign = [[NSUserDefaults standardUserDefaults] objectForKey:@"paysign"];
    NSString * stamp = [[NSUserDefaults standardUserDefaults] objectForKey:@"paytime"];
    req.timeStamp = stamp.intValue;
    [WXApi sendReq:req];
}
 */
-(void)zhucetongzhi{
   // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(alitongzhi:) name:@"alitongzhi" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wxtongzhi:) name:@"wxtongzhi" object:nil];
    
    
}
- (void)wxtongzhi:(NSNotification *)text{
    
    self.payView.hidden = YES;
                    self.bottomView.hidden= NO;
                    self.tableView.frame = CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar - 49);
                    _model.see = YES;
                    self.tableView.headerModel = _model;
       [self loadDataWhetherFirst:NO];
                    [self.tableView reloadData];
    
    [self paySuccess];
}
//-(void)respBackPaydata:(BaseResp*)resp{
//    self.payView.hidden = YES;
//    self.bottomView.hidden= NO;
//    self.tableView.frame = CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar - 49);
//    _model.see = YES;
//    self.tableView.headerModel = _model;
//    [self.tableView reloadData];
//    
//    [self loadDataWhetherFirst:YES];
//    
//     NSLog(@"modelId22222=%ld",_modelId);
//   // _status=[[[NSUserDefaults standardUserDefaults]objectForKey:@"statusPayTest"] integerValue];
////}
////
////#pragma mark - WXApiDelegate
////-(void) onResp:(BaseResp*)resp {
//    
//    NSString *payResoult = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
//     NSLog(@"支付结果=%@-%@-%d",resp,payResoult,resp.errCode);
//    if([resp isKindOfClass:[PayResp class]]){
//        switch (resp.errCode) {
//            case 0:
//                payResoult = @"支付结果：成功！";
//                
////
//                
//                break;
//            case -1:
//                payResoult = @"支付结果：失败！";
//                self.payView.hidden = NO;
//                self.bottomView.hidden= YES;
//                self.tableView.frame = CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar - 55);
//                
//
//                break;
//            case -2:{
//                payResoult = @"用户已经退出支付！";
//                TuijianDTViewController *su=[[TuijianDTViewController alloc] init];
//                
//                [self.navigationController pushViewController:su animated:YES];
////                self.payView.hidden = NO;
////                self.bottomView.hidden= YES;
////                self.tableView.frame = CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar - 55);
////            self.str=@"11";
//                  bgview.hidden=YES;
//                self.payView.hidden = YES;
//                                    self.bottomView.hidden= NO;
//                                    self.tableView.frame = CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar - 49);
//                                    _model.see = YES;
//                                    self.tableView.headerModel = _model;
//                                    [self.tableView reloadData];
//            }
//                
//               
//                break;
//            default:
//                payResoult = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
//                self.payView.hidden = NO;
//                self.bottomView.hidden= YES;
//                self.tableView.frame = CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar - 55);
//
//                break;
//                
//               
//        }
//        NSLog(@"payResoult%@",payResoult);
//        
//    }
//}

- (void)paySuccess {
    
     NSLog(@"modelId11111=%ld",_modelId);
   NSString*mid= [[NSUserDefaults standardUserDefaults]objectForKey:@"paymodelId"];
    NSMutableDictionary *parameter =[NSMutableDictionary dictionaryWithDictionary: [HttpString getCommenParemeter]];
    
    [parameter setObject:mid forKey:@"outerId"];
    //[parameter setObject:[NSString stringWithFormat:@"%ld",self.model.user_id] forKey:@"userId"];
    [parameter setObject:@"1" forKey:@"oType"];
//    [parameter setObject:@"IOS" forKey:@"resource"];

    [[DCHttpRequest shareInstance] sendRequestByMethod:@"post" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_appPaySuccess]  ArrayFile:nil Start:^(id requestOrignal) {
        
    } End:^(id responseOrignal) {
        
    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] integerValue]==200) {
            
            self.payView.hidden = YES;
            self.bottomView.hidden= NO;
            self.tableView.frame = CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar - 49);
            _model.see = YES;
            self.tableView.headerModel = _model;
            [self.tableView reloadData];
           
             [self loadDataWhetherFirst:YES];
        }else {
            [SVProgressHUD showWithStatus:[NSString stringWithFormat:@"%@",[responseOrignal objectForKey:@"msg"]]];
            [SVProgressHUD dismissWithDelay:2.0f];
            
        }
        
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        NSLog(@"pay失败");
    }];

    
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
//    NSLog(@"%@",text);
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        //在这里做你响应return键的代码
        
        
        if (_sendBtn.enabled) {
            [self sendCommentWithCommentTag:_sendCommentTag withDict:_notifComment];
            _sendBtn.enabled = NO;
        }else{
//            [self sendCommentWithCommentTag:_sendCommentTag withDict:_notifComment];

        }

        
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    
    
////    如果是表情的话，就过滤掉
//    if ([textView isFirstResponder]) {
//        if ([[[textView textInputMode] primaryLanguage] isEqualToString:@"emoji"] ||
//            ![[textView textInputMode] primaryLanguage] ) {
//            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"暂不支持输入表情符号"];
//
//            return NO;
//        }
//    }
//
//    
//    if ([textView isFirstResponder]) {
//        
//        if ([self stringContainsEmoji:text]) {
//            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"暂不支持输入表情符号"];
//            return NO;
//        }
//        
//    }
    
    
    
    
    return YES;
}

// 过滤所有表情
- (BOOL)stringContainsEmoji:(NSString *)string {
    __block BOOL returnValue = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         
         const unichar hs = [substring characterAtIndex:0];
         // surrogate pair
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     returnValue = YES;
                 }
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3) {
                 returnValue = YES;
             }
             
         } else {
             // non surrogate
             if (0x2100 <= hs && hs <= 0x27ff) {
                 
//                 九键的拼音输出的不是字母和数字，而是带边框的数字表情，return yes 的话就不能用九键写拼音了
//                 returnValue = YES;
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 returnValue = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 returnValue = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 returnValue = YES;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                 returnValue = YES;
             }
         }
     }];
    
    return returnValue;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    
    
    if ([Methods login]) {
        return YES;
    }else{
        [Methods toLogin];
        return NO;
    }
}


//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
//    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
//        //在这里做你响应return键的代码
//        [self.view endEditing:YES];
//        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
//    }
//
//    return YES;
//}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@" 说说您对比赛的看法"]) {
        textView.text = @"";
        _textView.textColor = color33;
        
    }else if ([textView.text isEqualToString:@"......"]){
        
        textView.text = _currentTextViewText;
        _textView.textColor = color33;
        
    }
    CGRect frame = textView.frame;
    CGSize constraintSize = CGSizeMake(frame.size.width, MAXFLOAT);
    CGSize size = [textView sizeThatFits:constraintSize];
    [self.textView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(frame.size.width, size.height));
        
    }];
    
    [self.view layoutIfNeeded];
    textView.scrollsToTop = YES;
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.text==nil || [textView.text isEqualToString:@""]) {
        textView.text = @" 说说您对比赛的看法";
        _textView.textColor = colorCC;
        
    }else{
        textView.text = @"......";
        _textView.textColor = color33;
        
    }
    CGRect frame = textView.frame;
    CGSize constraintSize = CGSizeMake(frame.size.width, MAXFLOAT);
    CGSize size = [textView sizeThatFits:constraintSize];
    [self.textView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(frame.size.width, size.height));
        
    }];
    
    [self.view layoutIfNeeded];
}

- (void)textViewDidChange:(UITextView *)textView
{
    _currentTextViewText = textView.text;
    CGRect frame = textView.frame;
    CGSize constraintSize = CGSizeMake(frame.size.width, MAXFLOAT);
    CGSize size = [textView sizeThatFits:constraintSize];
    [self.textView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(frame.size.width, size.height));
        
    }];
    
    [self.view layoutIfNeeded];
}
- (void)KeyboardShow:(NSNotification *)notification
{

//    if (![self.textView isFirstResponder]) {
//        return;
//    }
    _sendBtn.enabled = YES;

    
    NSDictionary *userInfo = [notification userInfo];
    CGRect rect =
    [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat keyboardHeight = CGRectGetHeight(rect);
    CGFloat keyboardDuration =
    [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [self.bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-keyboardHeight);

//        make.bottom.mas_equalTo(-keyboardHeight);
    }];

    [self.cancelBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(0, 0));
    }];
    
    [self.sendBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(0, 0));
    }];

    
    [self.textView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Width - 0 - 20, 32));
    }];
    
    [UIView animateWithDuration:keyboardDuration animations:^{
        [self.view layoutIfNeeded];
    }];
    _textView.scrollsToTop = YES;
    
}
- (void)KeyboardHide:(NSNotification *)notification
{
    
//    if ([self.textView isFirstResponder]) {
//        return;
//    }
    _sendBtn.enabled = YES;

    NSDictionary *userInfo = [notification userInfo];
    CGFloat keyboardDuration =[userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [self.textView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Width - 20 - 88, 32));
        
    }];
    
    
    [self.cancelBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(0, 0));
    }];
    
    [self.sendBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(0, 0));
    }];

    [self.bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
    }];
    
    [UIView animateWithDuration:keyboardDuration animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)loadDataWhetherFirst:(BOOL)first
{
    
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[HttpString getCommenParemeter]];
    if (_modelId==0) {
        NSString*mid= [[NSUserDefaults standardUserDefaults]objectForKey:@"paymodelId"];
        [parameter setObject:mid forKey:@"newsId"];
    }else{
        [parameter setObject:[NSString stringWithFormat:@"%ld",(long)_modelId] forKey:@"newsId"];
    }
    
    [parameter setObject:[NSString stringWithFormat:@"%ld",[[NSUserDefaults standardUserDefaults] integerForKey:@"oddstypeDetail"]] forKey:@"oddstype"];
    NSString *url;
    url = url_recommendshow;
//    if (_typeTuijianDetailHeader == typeTuijianDetailHeaderCellDanchang) {
//        //        type = @""
//        
//        if (_status == 1) {
//            url = url_recommendshow;
//
//        }else{
//        
//            url = url_reviewNewsshow;//支付回来调用
//        }
//    }else if(_typeTuijianDetailHeader == typeTuijianDetailHeaderCellChuanGuan){
//        
//        url = url_recommendinfocg;
//        
//    }else if (_typeTuijianDetailHeader == typeTuijianDetailHeaderCellZucai){
//        url = url_recommendinfocg;
//
//    }
    [[DCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url] Start:^(id requestOrignal) {
        
        if (first) {
            [LodingAnimateView showLodingView];

        }
        

    } End:^(id responseOrignal) {
        
        [LodingAnimateView dissMissLoadingView];

    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
//            NSLog(@"%@",responseOrignal);
            _tableView.arrData = [[NSArray alloc] initWithArray:[CommentModel arrayOfEntitiesFromArray:[[responseOrignal objectForKey:@"data"] objectForKey:@"comments"]]];
            
            
            _buyerArr = [payUserModel arrayOfEntitiesFromArray:[[[responseOrignal objectForKey:@"data"] objectForKey:@"news"] objectForKey:@"payUsers"]];
            
            _tableView.arrPic = _buyerArr;
            _model=nil;
            _model= [TuijiandatingModel entityFromDictionary:[[responseOrignal objectForKey:@"data"] objectForKey:@"news"]];
            if (_typeTuijianDetailHeader == typeTuijianDetailHeaderCellDanchang) {
                _tableView.typeTuijianDetailHeader = _typeTuijianDetailHeader;
                _tableView.headerModel = _model;
                
                
                if (_status == 1) {
                    
                }
                self.tableView.hidden = NO;
                if (!_model.see) {
                    NSLog(@"---不可见");
                    self.payView.hidden = NO;
                    self.bottomView.hidden = YES;
                    self.tableView.frame = CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar, Width,_status == 1? (Height - APPDELEGATE.customTabbar.height_myNavigationBar - 49):(Height - APPDELEGATE.customTabbar.height_myNavigationBar));
                    _labCommentNum.text = [NSString stringWithFormat:@"%ld",(long)_model.like_count];
                    _labComment.selected = _model.liked;
                    
                    _labCommentNum1.text = [NSString stringWithFormat:@"%ld",(long)_model.hate_count];
                    _labComment1.selected = _model.hated;
                    
                    _labelQiuBi.text = [NSString stringWithFormat:@"需支付%ld球币",_model.amount/100];
                    _labelQiuBi.font = font14;
                    
                    _labelQiuBi.attributedText = [Methods withContent:_labelQiuBi.text WithColorText:[NSString stringWithFormat:@"%ld",_model.amount/100] textColor:redcolor strFont:font18];
                }else{
                     NSLog(@"---可见");
                    self.bottomView.hidden = NO;
                    self.payView.hidden = YES;
                    self.tableView.frame = CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar, Width, _status == 1? (Height - APPDELEGATE.customTabbar.height_myNavigationBar - 49):(Height - APPDELEGATE.customTabbar.height_myNavigationBar));

                }

            }else{
               
            }
            [_tableView reloadData];
            
        }else {
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:[responseOrignal objectForKey:@"msg"]];
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:errorDict];
    }];
}


- (void)sendCommentWithCommentTag:(NSInteger)commentTag withDict:(NSDictionary *)dictP
{
    //commentTag 0 原界面评论 1cell界面的评论 2 cell界面的子评论
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    
    if (_textView.text == nil || [_textView.text isEqualToString:@""]) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"请输入评论内容"];
        return;
    }
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[HttpString getCommenParemeter]];
    
    
    if (_typeTuijianDetailHeader == typeTuijianDetailHeaderCellDanchang) {
        [parameter setObject:@"0" forKey:@"type"];
        
        [parameter setObject:[NSString stringWithFormat:@"%ld",(long)_model.idId] forKey:@"newsId"];
        
    }else{
        
    }
    
    
    switch (commentTag) {
        case 0:
        {
            
        }
            break;
        case 1:
        {
            
            [parameter setObject:[dictP objectForKey:@"parentId"] forKey:@"parentId"];
            [parameter setObject:[dictP objectForKey:@"toUserid"] forKey:@"toUserid"];
            [parameter setObject:[dictP objectForKey:@"toUsername"] forKey:@"toUsername"];
        }
            break;
        case 2:
        {
            /*
             userId：               //评论用户id
             parentId：106，        //评论id
             toUserid: 330,        //被评论用户id
             toUsername: "云江夜雨",   //被评论用户昵称

             */
            //公共参数里面有
//            [parameter setObject:@"" forKey:@"userId"];
            
            [parameter setObject:[dictP objectForKey:@"parentId"] forKey:@"parentId"];
            [parameter setObject:[dictP objectForKey:@"toUserid"] forKey:@"toUserid"];
            [parameter setObject:[dictP objectForKey:@"toUsername"] forKey:@"toUsername"];

        }
            break;

        default:
            break;
    }
    
    NSString *content = _textView.text;
//    NSString *contentNew = [content stringByReplacingOccurrencesOfString:@"\n" withString:@"---"];
    [parameter setObject:content forKey:@"content"];

    [[DCHttpRequest shareInstance] sendRequestByMethod:@"post" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_addComment] ArrayFile:nil Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
        
    } Success:^(id responseResult, id responseOrignal) {
        if ([[ responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            _textView.text = nil;
            _currentTextViewText = nil;
            
            if (_typeTuijianDetailHeader == typeTuijianDetailHeaderCellDanchang) {
                _model.comment_count = _model.comment_count + 1;
                // 数量为0 就不显示
                _labCommentNum.text = [NSString stringWithFormat:@"%ld",(long)_model.like_count];
                _labComment.selected = _model.liked;

            }else{
              
            }
            
            
            
            
            [self.view endEditing:YES];
            [self loadDataWhetherFirst:NO];
        }else{
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:[responseOrignal objectForKey:@"msg"]];
            [self.view endEditing:YES];
            
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:[responseOrignal objectForKey:@"msg"]];
        [self.view endEditing:YES];
        
    }];
}






- (void)addLiked:(UIButton *)btn
{
    
    //    param.put("type", "1"); //1 推荐曝料 2 评论
    //    param.put("targetId", "417"); ////点赞的对象id
    
    if (![Methods login]) {
        [Methods toLogin];
        return;
    }
    if (btn.tag == 1) {
        if (_model.liked == YES) {
            return;
        }
        if (_model.hated == YES) {
            return;
        }
    }else if (btn.tag == 2){
        if (_model.liked == YES) {
            return;
        }
        if (_model.hated == YES) {
            return;
        }
    }
    
    NSMutableDictionary *paremeter = [NSMutableDictionary dictionaryWithDictionary:[HttpString getCommenParemeter]];
    [paremeter setObject:@"1" forKey:@"type"];
    [paremeter setObject:[NSString stringWithFormat:@"%ld",(long)_model.idId] forKey:@"targetId"];
    [paremeter setObject:[NSString stringWithFormat:@"%ld",(long)btn.tag] forKey:@"lclass"];

    
    [[DCHttpRequest shareInstance] sendRequestByMethod:@"post" WithParamaters:paremeter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_likeAdd] ArrayFile:nil Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
        
    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            if ((NSInteger)[[responseOrignal objectForKey:@"data"] integerValue] >0) {
                
                if (btn.tag == 1) {
                    _labComment.selected = YES;
                    _model.like_count = _model.like_count + 1;
                    _model.liked = YES;
                    _labCommentNum.text = [NSString stringWithFormat:@"%ld",(long)_model.like_count];

                }else{
                    
                    _labComment1.selected = YES;
                    _model.hate_count = _model.hate_count + 1;
                    _model.hated = YES;
                    _labCommentNum1.text = [NSString stringWithFormat:@"%ld",(long)_model.hate_count];

                    
                    
                }
                
            }else{
                //                [SVProgressHUD showImage:[UIImage imageNamed:@""] status:[responseOrignal objectForKey:@"msg"]];
            }
        }else
        {
            //            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:[responseOrignal objectForKey:@"msg"]];
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:errorDict];
        
    }];
}















//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    [self.view endEditing:YES];
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
