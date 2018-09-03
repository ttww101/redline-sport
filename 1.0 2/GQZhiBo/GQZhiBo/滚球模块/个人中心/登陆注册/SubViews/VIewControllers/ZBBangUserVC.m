//
//  ZBBangUserVC.m
//  GQapp
//
//  Created by Marjoice on 16/08/2017.
//  Copyright © 2017 GQXX. All rights reserved.
//

#import "ZBBangUserVC.h"
#import "ZBRegisterViewController.h"

@interface ZBBangUserVC ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *telTextF;
@property (nonatomic, strong) UITextField *pswTextF;
@property (nonatomic, strong) MBProgressHUD *prograssHud;

@property (nonatomic, strong)UIImageView *imageViewTel;
@property (nonatomic, strong)UIImageView *imageViewPsw;

@end

@implementation ZBBangUserVC

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
    if ([ZBMethods login]) {
        [self dismiss];
        return;
    }
    _pswTextF.text = nil;
    //    if (_type == typeLoginNormal) {
    //        if ([ZBMethods isMobileNumber:[[NSUserDefaults standardUserDefaults] objectForKey:@"telTextF"]]) {
    //
    //        }else{
    //            _telTextF.text = @"";
    //
    //        }
    //    }
    //[[NSUserDefaults standardUserDefaults]setObject:_pswTextF.text forKey:@"password"];
    
//    if (_type == typeLoginNormal) {
//        NSInteger b = [[[NSUserDefaults standardUserDefaults]objectForKey:@"passwordBOOL"] integerValue];;
//        if (b == 1) {
//            _pswTextF.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
//            _btnJIZhu.selected = YES;
//        }
//        _telTextF.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"telTextF"];
    
    _telTextF.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"bangNickName"];
//    }
    
    
    [super viewWillAppear:animated];
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
    
}

#pragma mark -- setnavView
- (void)setNavView{
    ZBNavView *nav = [[ZBNavView alloc] init];
    nav.delegate = self;
    nav.labTitle.text = @"用户绑定";
    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateNormal];
    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateHighlighted];
    [nav.btnRight setTitle:@"注册" forState:UIControlStateNormal];
    
    [self.view addSubview:nav];
}
- (void)navViewTouchAnIndex:(NSInteger)index
{
    if (index == 1) {
        //left
        [self dismissViewControllerAnimated:YES completion:^{
        }];
        
    }else if(index == 2){
        //right
        ZBRegisterViewController *registerVC = [[ZBRegisterViewController alloc]init];
        [self presentViewController:registerVC animated:YES completion:^{
            
            
        }];
        
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = grayColor1;
    [self setNavView];

    [self creatLogin];
}

- (void)creatLogin
{
    float space = 20;
    float height = 50;
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(0, 20, 59, 44);
    [cancelBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *back = [[UIImageView alloc] initWithFrame:CGRectMake(15, 0, 44, 44)];
    //    back.center = CGPointMake(cancelBtn.width/2, cancelBtn.width/2);
    back.image = [UIImage imageNamed:@"back"];
    [cancelBtn addSubview:back];
    //    [self.view  addSubview:cancelBtn];
    UILabel *title = [[UILabel alloc] init];
    title.text = @"登录";
    title.font = font17;
    title.textColor = ColorWithRGBA(64, 64, 64, 1);
    title.frame = CGRectMake(0, 30, 40, 15);
    CGPoint titlePiont = title.center;
    titlePiont.x = self.view.center.x;
    title.center = titlePiont;
    //    [self.view addSubview:title];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, Width, 0.5)];
    lineView.backgroundColor = colorDD;
    [self.view  addSubview:lineView];
    
    UIImageView *logoImageView = [[UIImageView alloc] init];
    logoImageView.image = [UIImage imageNamed:@"logo测"];
    logoImageView.bounds = CGRectMake(0, 0, 100, 100);
    logoImageView.center = CGPointMake(Width/2, cancelBtn.frame.origin.y + cancelBtn.bounds.size.height + space + logoImageView.bounds.size.height/2);
    logoImageView.layer.cornerRadius = 15;
    logoImageView.clipsToBounds = YES;
    //    [self.view  addSubview:logoImageView];
    
    UIView *logView = [[UIView alloc] init];
    logView.frame = CGRectMake(0, lineView.bottom, Width, height *2);
    //    logView.center = CGPointMake(Width/2, logoImageView.frame.origin.y + logoImageView.bounds.size.height + space + logView.bounds.size.height/2);
    logView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:logView];
    
    //手机号
    _imageViewTel = [[UIImageView alloc] initWithFrame:CGRectMake(20, 5, height/3, height/3)];
    CGPoint pointImageTel = _imageViewTel.center;
    pointImageTel.y = height/2;
    _imageViewTel.center = pointImageTel;
    _imageViewTel.image = [UIImage imageNamed:@"register2"];
    [logView addSubview:_imageViewTel];
    _telTextF = [[UITextField alloc] initWithFrame:CGRectMake(_imageViewTel.frame.origin.x + _imageViewTel.bounds.size.width + space, _imageViewTel.frame.origin.y, logView.frame.size.width - (_imageViewTel.frame.origin.x + _imageViewTel.bounds.size.width + space), height - 10)];
    CGPoint pointTxtfTel = _telTextF.center;
    pointTxtfTel.y = _imageViewTel.center.y;
    _telTextF.center = pointTxtfTel;
    _telTextF.delegate = self;
    _telTextF.font = font14;
    _telTextF.textColor = color33;
    //    if (_type == typeLoginNormal) {
    //        _telTextF.keyboardType = UIKeyboardTypeDecimalPad;
    //     }
    _telTextF.clearButtonMode = UITextFieldViewModeWhileEditing;
    _telTextF.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"telTextF"];
    [logView addSubview:_telTextF];
    
    UIView *viewlineH = [[UIView alloc] initWithFrame:CGRectMake(0, 0,Width, 0.5)];
    viewlineH.center = CGPointMake(logView.bounds.size.width/2, height);
    viewlineH.backgroundColor = cellLineColor;
    [logView addSubview:viewlineH];
    //密码
    _imageViewPsw = [[UIImageView alloc] initWithFrame:CGRectMake(_imageViewTel.frame.origin.x, height + 5, height/3 ,height/3)];
    CGPoint pointImagePsw = _imageViewPsw.center;
    pointImagePsw.y = height + height/2;
    _imageViewPsw.center = pointImagePsw;
    _imageViewPsw.image = [UIImage imageNamed:@"register3"];
    [logView addSubview:_imageViewPsw];
    _pswTextF = [[UITextField alloc] init];
    _pswTextF.frame = CGRectMake(_telTextF.frame.origin.x, _imageViewPsw.frame.origin.y , _telTextF.bounds.size.width - 70, _telTextF.bounds.size.height);
    _pswTextF.center = CGPointMake(_pswTextF.center.x, _imageViewPsw.center.y);
    _pswTextF.font = font14;
    _pswTextF.delegate = self;
    _pswTextF.borderStyle = UITextBorderStyleNone;
    _pswTextF.placeholder = @"请输入密码";
    _pswTextF.textColor = color33;
    _pswTextF.secureTextEntry = YES;
    _pswTextF.clearButtonMode = UITextFieldViewModeWhileEditing;
    _pswTextF.keyboardType = UIKeyboardTypeDefault;
    _pswTextF.clearsOnBeginEditing = YES;
    [logView addSubview:_pswTextF];
    
    UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(_pswTextF.frame.origin.x + _pswTextF.frame.size.width, _pswTextF.frame.origin.y +3, 1, height - 16)];
    viewLine.backgroundColor = cellLineColor;
    
    
    UIButton *loginbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginbtn.bounds = CGRectMake(10, 0, logView.bounds.size.width - 20, 40);
    loginbtn.center = CGPointMake(Width/2, logView.frame.origin.y + logView.bounds.size.height + space/2 + height/2 + 15);
    loginbtn.titleLabel.font = font14;
    loginbtn.backgroundColor = redcolor;
    loginbtn.layer.cornerRadius = 3;
    //    [loginbtn setTitle:@"登 录" forState:UIControlStateNormal];
    [loginbtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginbtn addTarget:self action:@selector(loginBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginbtn];
    
    //不是第三方登陆的时候才加上注册,第三方登陆等内容
//    if (_type == typeLoginNormal) {
        //        [logView addSubview:viewLine];
        _telTextF.placeholder = @"请输入手机号/用户名";
        UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        registerBtn.frame = CGRectMake(Width - 80, title.top+2, 80, 15);
        registerBtn.titleLabel.textAlignment = NSTextAlignmentRight;
        registerBtn.titleLabel.font = font14;
        [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
        [registerBtn setTitleColor:ColorWithRGBA(252, 68, 72, 1) forState:UIControlStateNormal];
        [registerBtn addTarget:self action:@selector(toRegister) forControlEvents:UIControlEventTouchUpInside];
        //        [self.view addSubview:registerBtn];
        
//        float widthBtn = 40;
//        float spaceBtn = (Width - space *2 *2 - widthBtn*3)/2;
    
        
        UILabel *labText = [[UILabel alloc] init];
        labText.bounds = CGRectMake(0, 0, logoImageView.bounds.size.width, height/2);
        if (isOniPhone4) {
            //            labText.center = CGPointMake(Width/2, Height - space - widthBtn - space/2 - labText.bounds.size.height/2- 100);
            labText.center = CGPointMake(Width/2, loginbtn.bottom + 100);
        }else{
            //            labText.center = CGPointMake(Width/2, Height - space - widthBtn - space/2 - labText.bounds.size.height/2- 100);
            labText.center = CGPointMake(Width/2, loginbtn.bottom + 100);
        }
//        labText.text = @"其他登录方式";
//        labText.textColor = ColorWithRGBA(116, 116, 116, 1);
//        labText.textAlignment = NSTextAlignmentCenter;
//        labText.font = font12;
//        [self.view addSubview:labText];
//        
//        for (int i = 0; i<3; i++) {
//            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//            
//            if (isOniPhone4) {
//                btn.frame = CGRectMake(space*2 + (widthBtn + spaceBtn) *i, labText.bottom + 25, widthBtn, widthBtn);
//            }else{
//                btn.frame = CGRectMake(space*2 + (widthBtn + spaceBtn) *i, labText.bottom + 25, widthBtn, widthBtn);
//            }
//            
//            
//            
//            //            只能微信登陆，其他的暂时隐藏
//            //            if (i == 1) {
//            [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"log%d",i]] forState:UIControlStateNormal];
//            
//            //            }
//            //            else{
//            //                [btn setBackgroundImage:[UIImage imageNamed:@"clear"] forState:UIControlStateNormal];
//            
//            //                btn.enabled = NO;
//            //            }
//            
//            //            [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"log%d",i]] forState:UIControlStateNormal];
//            
//            
//            btn.tag= i;
//            [btn addTarget:self action:@selector(thirdPartLogin:) forControlEvents:UIControlEventTouchUpInside];
//            [self.view addSubview:btn];
//        }
//        UIView *viewleft = [[UIView alloc] initWithFrame:CGRectMake(space, labText.frame.origin.y + labText.bounds.size.height/2, Width/4, 0.5)];
//        viewleft.backgroundColor = cellLineColor;
//        [self.view addSubview:viewleft];
//        
//        UIView *viewRight = [[UIView alloc] initWithFrame:CGRectMake(Width - Width/4 - space, viewleft.frame.origin.y, Width/4, 0.5)];
//        viewRight.backgroundColor = cellLineColor;
//        [self.view addSubview:viewRight];
    
        
//    }else if (_type == typeLoginThirdParth){
    
        
        
        _telTextF.text = _nickname;
//    }
    
    
}


- (void)loginBtn
{
    _telTextF.text = [_telTextF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    _pswTextF.text = [_pswTextF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
//    if (_type == typeLoginNormal) {
        //注释这里是因为，可以使用用户名和密码登录，不只是手机号和密码
        //        if (_telTextF.text.length != 11) {
        //            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"请输入11位手机号"];
        //            return;
        //        }
        //        if (![ZBMethods isMobileNumber:_telTextF.text]) {
        //            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"请输入正确的手机号格式"];
        //            return;
        //        }
        
//    }else if (_type == typeLoginThirdParth){
    
//        if (!(_telTextF.text.length >= 2 && _telTextF.text.length <=8)) {
//            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"请输入2~8位的字符昵称"];
//            return;
//        }
//        
//    }
    
    if (_pswTextF.text.length == 0) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"请输入密码"];
        return;
    }
    if (!(_pswTextF.text.length >= 6 && _pswTextF.text.length <=16)) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"请输入6~16位的字符密码"];
        return;
    }
//    if (_type == typeLoginNormal) {
//        [self login];
//        
//    }else if (_type == typeLoginThirdParth){
    
        [self loginThirdPartWithUserName:_username nickName:_telTextF.text picUrl:_pic resource:_resource password:_pswTextF.text];
//    }
    
}

- (void)loginThirdPartWithUserName:(NSString *)username nickName:(NSString *)nickname picUrl:(NSString *)pic resource:(NSString *)resource password:(NSString *)password
{
    /*
     utype = 0，//操作类型（0:登录操作，1：获取手机验证码，2：用户注册，3：找回密码）
     username， //用户名
     password   //用户密码
     9;第三方登陆
     username userid
     nickname  username
     pic
     resource
     */
    [self.view endEditing:YES];
    
    nickname = [[NSUserDefaults standardUserDefaults] objectForKey:@"bangNickName"];
    username = [[NSUserDefaults standardUserDefaults] objectForKey:@"bangUserName"];
    pic = [[NSUserDefaults standardUserDefaults] objectForKey:@"bangPic"];
    resource = [[NSUserDefaults standardUserDefaults] objectForKey:@"bangResource"];
    
    NSMutableDictionary *dictParameter = [NSMutableDictionary dictionaryWithDictionary:[ZBHttpString getCommenParemeter]];
    [dictParameter setObject:@"9" forKey:@"flag"];
    [dictParameter setObject:username forKey:@"username"];
    [dictParameter setObject:nickname forKey:@"nickname"];
    [dictParameter setObject:resource forKey:@"resource"];
    [dictParameter setObject:pic forKey:@"pic"];
    [dictParameter setObject:[ZBMethods md5WithString:password] forKey:@"password"];
    // 设备udid
    [dictParameter setObject:@"1" forKey:@"platform"];
    [dictParameter setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"deviceTokenStr"] forKey:@"uuid"];
    [dictParameter setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"deviceTokenStr"] forKey:@"token"];
    
    [[ZBDCHttpRequest shareInstance] sendRequestByMethod:@"post" WithParamaters:dictParameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_loginAndRegister] ArrayFile:nil Start:^(id requestOrignal) {
        if (!_prograssHud) {
            _prograssHud = [[MBProgressHUD alloc] initWithView:self.view];
        }
        _prograssHud.mode = MBProgressHUDModeIndeterminate;
        _prograssHud.labelText = @"正在登录";
        [_prograssHud show:YES];
        [self.view addSubview:_prograssHud];
        
    } End:^(id responseOrignal) {
        
    } Success:^(id responseResult, id responseOrignal) {
        //        NSLog(@"登陆成功---%@",responseOrignal);
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            
            NSLog(@"%@",responseOrignal);
            _prograssHud.mode = MBProgressHUDModeCustomView;
            _prograssHud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"success"]];
            _prograssHud.labelText = @"登录成功";
            [[NSUserDefaults standardUserDefaults] setObject:_telTextF.text forKey:@"telTextF"];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"login"];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"thirdPartLogin"];
            
            NSString *nowDate = [ZBMethods getDateByStyle:dateStyleFormatter withDate:[NSDate dateWithTimeIntervalSinceNow:3600*24*15]];
            [[NSUserDefaults standardUserDefaults] setObject:nowDate forKey:@"thirdPartLoginDeadline"];
            [[NSUserDefaults standardUserDefaults] synchronize];
//            ZBUserModel *model = [ZBUserModel entityFromDictionary:[responseOrignal objectForKey:@"data"]];
            //            model.pic = pic;
//            [self connectRongyunWithUserModel:model];
            
            ZBUserModel *model = [ZBUserModel entityFromDictionary:[responseOrignal objectForKey:@"data"]];
            ZBTokenModel *tokenModel = [ZBTokenModel entityFromDictionary:[responseOrignal objectForKey:@"data"]];
            
            [ZBMethods updateTokentModel:tokenModel];
            [ZBMethods updateUsetModel:model];

            
            
//            [[NSUserDefaults standardUserDefaults] setObject:model.token forKey:@"token"];
//            
//            [[NSUserDefaults standardUserDefaults] setObject:model.refreshToken forKey:@"refreshToken"];
//            
            [[NSUserDefaults standardUserDefaults] setDouble:[[responseOrignal objectForKey:@"time"] doubleValue] + RequestRefreshTokenTime forKey:@"refreshTokentime"];
//
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationOpenMainTableBarTimer object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"open",@"timer", nil]];
            [_prograssHud hide:YES afterDelay:1];
            [self performSelector:@selector(dismiss) withObject:nil afterDelay:1];
            
            
        }else{
            _prograssHud.mode = MBProgressHUDModeCustomView;
            _prograssHud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wrong"]];
            _prograssHud.labelText = [responseOrignal objectForKey:@"msg"];
            [_prograssHud hide:YES afterDelay:1];
            //            [self performSelector:@selector(dismiss) withObject:nil afterDelay:1];
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        _prograssHud.mode = MBProgressHUDModeCustomView;
        _prograssHud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wrong"]];
        _prograssHud.labelText = errorDict;
        //        }
        [_prograssHud hide:YES afterDelay:1];
        //        [self performSelector:@selector(dismiss) withObject:nil afterDelay:1];
        NSLog(@"%@",responseOrignal);
    }];
    
}

- (void)toRegister
{
    ZBRegisterViewController *registerVC = [[ZBRegisterViewController alloc]init];
    //    registerVC.bangType = bangDingType;
    [self presentViewController:registerVC animated:YES completion:nil];
}


- (void)dismiss
{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
