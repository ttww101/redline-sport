//
//  LoginViewController.m
//  GunQiuLive
//
//  Created by WQ_h on 16/1/21.
//  Copyright © 2016年 WQ_h. All rights reserved.
//
#import "LoginViewController.h"
#import "MBProgressHUD.h"
#import "DCHttpRequest.h"
#import "RegisterViewController.h"
#import "ForgetPswViewController.h"
#import "UserModel.h"
//#import "UMSocialSinaSSOHandler.h"
//#import "UMSocialQQHandler.h"
//#import "UMSocial.h"
#import "BangUserVC.h"

@interface LoginViewController ()<UITextFieldDelegate>
{
    float _keyboardHeight;
}
@property (nonatomic, strong) UITextField *telTextF;
@property (nonatomic, strong) UITextField *pswTextF;
@property (nonatomic, strong) MBProgressHUD *prograssHud;
@property (nonatomic, strong)UIButton *btnJIZhu;
@property (nonatomic, strong)UIImageView *imageViewTel;
@property (nonatomic, strong)UIImageView *imageViewPsw;

@end

@implementation LoginViewController
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
    if ([Methods login]) {
        [self dismiss];
        return;
    }
    _pswTextF.text = nil;
//    if (_type == typeLoginNormal) {
//        if ([Methods isMobileNumber:[[NSUserDefaults standardUserDefaults] objectForKey:@"telTextF"]]) {
//
//        }else{
//            _telTextF.text = @"";
//
//        }
//    }
//[[NSUserDefaults standardUserDefaults]setObject:_pswTextF.text forKey:@"password"];
    
    if (_type == typeLoginNormal) {
        NSInteger b = [[[NSUserDefaults standardUserDefaults]objectForKey:@"passwordBOOL"] integerValue];;
        if (b == 1) {
            _pswTextF.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
            _btnJIZhu.selected = YES;
        }
        _telTextF.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"telTextF"];

    }
    
    
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavView];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = grayColor1;
//    self.navigationController.title = @"登陆";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keybordUp:) name:UIKeyboardWillShowNotification object:nil];
    _keyboardHeight = 0;
    [self creatLogin];
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
    
}
#pragma mark -- setnavView
- (void)setNavView{
    NavView *nav = [[NavView alloc] init];
    nav.delegate = self;
    nav.labTitle.text = @"登录";
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
        RegisterViewController *registerVC = [[RegisterViewController alloc]init];
        [self presentViewController:registerVC animated:YES completion:nil];
        
    }
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
    

//    忘记密码
    _btnJIZhu = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnJIZhu.frame = CGRectMake(15, logView.bottom + 15, 18, 18);
    [_btnJIZhu setImage:[UIImage imageNamed:@"wangji"] forState:UIControlStateNormal];
    [_btnJIZhu setImage:[UIImage imageNamed:@"jizhu"] forState:UIControlStateSelected];
    [_btnJIZhu addTarget:self action:@selector(jiZhuPassword:) forControlEvents:UIControlEventTouchUpInside];
    _btnJIZhu.selected = YES;
    [self.view addSubview:_btnJIZhu];
    
    UILabel *labMima = [[UILabel alloc] initWithFrame:CGRectMake(_btnJIZhu.right + 10, logView.bottom + 16, 60, 15)];
    labMima.text = @"记住密码";
    labMima.textColor = ColorWithRGBA(64, 64, 64, 1);
    labMima.font = font13;
    [self.view addSubview:labMima];
//    找回密码
    UIButton *forgetPsw = [UIButton buttonWithType:UIButtonTypeCustom];
    forgetPsw.frame = CGRectMake(Width - 80, logView.bottom + 15, 70, 20);
    [forgetPsw setTitle:@"找回密码?" forState:UIControlStateNormal];
    [forgetPsw setTitleColor:color4C8DE5 forState:UIControlStateNormal];
    [forgetPsw.titleLabel setFont: font13];
    [forgetPsw addTarget:self action:@selector(forgetPswBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *loginbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginbtn.bounds = CGRectMake(10, 0, logView.bounds.size.width - 20, 40);
    loginbtn.center = CGPointMake(Width/2, logView.frame.origin.y + logView.bounds.size.height + space/2 + height/2 + 50);
    loginbtn.titleLabel.font = font14;
    loginbtn.backgroundColor = redcolor;
    loginbtn.layer.cornerRadius = 3;
//    [loginbtn setTitle:@"登 录" forState:UIControlStateNormal];
    [loginbtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginbtn addTarget:self action:@selector(loginBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginbtn];
    
    //不是第三方登陆的时候才加上注册,第三方登陆等内容
    if (_type == typeLoginNormal) {
//        [logView addSubview:viewLine];
        [self.view addSubview:forgetPsw];
        _telTextF.placeholder = @"请输入手机号/用户名";
        UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        registerBtn.frame = CGRectMake(Width - 80, title.top+2, 80, 15);
        registerBtn.titleLabel.textAlignment = NSTextAlignmentRight;
        registerBtn.titleLabel.font = font14;
        [registerBtn setTitle:@"免费注册" forState:UIControlStateNormal];
        [registerBtn setTitleColor:ColorWithRGBA(252, 68, 72, 1) forState:UIControlStateNormal];
        [registerBtn addTarget:self action:@selector(toRegister) forControlEvents:UIControlEventTouchUpInside];
//        [self.view addSubview:registerBtn];
        
        
        
        
    }else if (_type == typeLoginThirdParth){
        
        
        
        _telTextF.text = _nickname;
    }
    
    
    
}
- (void)jiZhuPassword:(UIButton *)btn{
    btn.selected = !btn.selected;
    [[NSUserDefaults standardUserDefaults] setObject:@(btn.selected) forKey:@"passwordBOOL"];
    if (btn.selected) {
//        [[NSUserDefaults standardUserDefaults]setObject:_pswTextF.text forKey:@"password"];
    }else{
        [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"password"];
    }
    
    
}

- (void)keybordUp:(NSNotification *)notification
{
    NSValue *value = [notification.userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect rect = [value CGRectValue];
    _keyboardHeight = rect.size.height;
    CGFloat space =Height - (_pswTextF.frame.origin.y + _pswTextF.frame.size.height) - _keyboardHeight;
    if (space < 0) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.25];
        self.view.frame = CGRectMake(0, space, self.view.bounds.size.width, self.view.bounds.size.height);
        [UIView commitAnimations];
    }
    else
    {
        return;
    }
}
- (void)dismiss
{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}
- (void)forgetPswBtnClick
{
    ForgetPswViewController *forgetPswVC = [[ForgetPswViewController alloc] init];
    [self presentViewController:forgetPswVC animated:YES completion:nil];
}
- (void)loginBtn
{
    _telTextF.text = [_telTextF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    _pswTextF.text = [_pswTextF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    
    if (isNUll(self.telTextF.text) || isNUll(self.pswTextF.text)) {
        
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"应填项不能为空"];
        return;

    }
    
    if (_type == typeLoginNormal) {
        //注释这里是因为，可以使用用户名和密码登录，不只是手机号和密码
//        if (_telTextF.text.length != 11) {
//            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"请输入11位手机号"];
//            return;
//        }
//        if (![Methods isMobileNumber:_telTextF.text]) {
//            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"请输入正确的手机号格式"];
//            return;
//        }
 
    }else if (_type == typeLoginThirdParth){
    
        if (_telTextF.text.length <2 || _telTextF.text.length >8) {
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"请输入2~8位的字符昵称"];
            return;
        }
        
    }
    
    
    if (_pswTextF.text.length < 6 || _pswTextF.text.length > 16)
    {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"密码错误"];
        return;
    }
    
    
    if (_type == typeLoginNormal) {
        [self login];

    }else if (_type == typeLoginThirdParth){
        
        [self loginThirdPartWithUserName:_username nickName:_telTextF.text picUrl:_pic resource:_resource password:_pswTextF.text];
    }

}


//- (void)thirdPartLoginToAddNickNametWithUserName:(NSString *)username nickName:(NSString *)nickname picUrl:(NSString *)pic resource:(NSString *)resource
//{
//    
//    LoginViewController *loginVC = [[LoginViewController alloc] init];
//    loginVC.type = typeLoginThirdParth;
//    loginVC.nickname = nickname;
//    loginVC.username = username;
//    loginVC.pic = pic;
//    loginVC.resource = resource;
//
//    [self presentViewController:loginVC animated:YES completion:^{
//        
//    }];
//    
//}


- (void)login
{
    /*
     utype = 0，//操作类型（0:登录操作，1：获取手机验证码，2：用户注册，3：找回密码）
     username， //用户名
     password   //用户密码
     */
    [self.view endEditing:YES];

    NSMutableDictionary *dictParameter = [NSMutableDictionary dictionaryWithDictionary:[HttpString getCommenParemeter]];
    [dictParameter setObject:@"0" forKey:@"flag"];
    [dictParameter setObject:_telTextF.text forKey:@"username"];
    [dictParameter setObject:[Methods md5WithString:_pswTextF.text] forKey:@"password"];
    // 设备udid
    [dictParameter setObject:@"1" forKey:@"platform"];
    [dictParameter setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"deviceTokenStr"] forKey:@"uuid"];
    

    [[DCHttpRequest shareInstance] sendRequestByMethod:@"post" WithParamaters:dictParameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_loginAndRegister] ArrayFile:nil Start:^(id requestOrignal) {
        if (!_prograssHud) {
        _prograssHud = [[MBProgressHUD alloc] initWithView:self.view];
        }
        _prograssHud.mode = MBProgressHUDModeIndeterminate;
        _prograssHud.labelText = @"正在登录";
        [_prograssHud show:YES];
        [self.view addSubview:_prograssHud];
       
    } End:^(id responseOrignal) {
        [_prograssHud hide:YES afterDelay:1];

    } Success:^(id responseResult, id responseOrignal) {
        NSLog(@"登陆成功---%@",responseOrignal);

        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            _prograssHud.mode = MBProgressHUDModeCustomView;
            _prograssHud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"success"]];
            _prograssHud.labelText = @"登录成功";
            [[NSUserDefaults standardUserDefaults] setObject:@(_btnJIZhu.selected) forKey:@"passwordBOOL"];
            if (_btnJIZhu.selected == YES) {
                [[NSUserDefaults standardUserDefaults]setObject:_pswTextF.text forKey:@"password"];

            }else{
                [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"password"];
            }
            
            
            [[NSUserDefaults standardUserDefaults] setObject:_telTextF.text forKey:@"telTextF"];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"login"];
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"thirdPartLogin"];

            
//            NSString *token = [[responseOrignal objectForKey:@"data"] objectForKey:@"token"];
//            NSString *refreshToken = [[responseOrignal objectForKey:@"data"] objectForKey:@"refreshToken"];
//            
//            [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"token"];
//            [[NSUserDefaults standardUserDefaults] setObject:refreshToken forKey:@"refreshToken"];
            [[NSUserDefaults standardUserDefaults] setDouble:([[responseOrignal objectForKey:@"time"] doubleValue] + RequestRefreshTokenTime) forKey:@"refreshTokentime"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            
            UserModel *model = [UserModel entityFromDictionary:[responseOrignal objectForKey:@"data"]];
            TokenModel *tokenModel = [TokenModel entityFromDictionary:[responseOrignal objectForKey:@"data"]];

            [Methods updateTokentModel:tokenModel];
            [Methods updateUsetModel:model];
            
//            NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
//            [def setObject:[[responseOrignal objectForKey:@"data"] objectForKey:@"token"] forKey:@"token"];
//            [def setObject:[[responseOrignal objectForKey:@"data"] objectForKey:@"refreshToken"] forKey:@"refreshToken"];
//            [def setDouble:([[responseOrignal objectForKey:@"time"] doubleValue] + RequestRefreshTokenTime) forKey:@"refreshTokentime"];
//            [def synchronize];
            
            NSLog(@"NSData                  - %f",[[NSDate date] timeIntervalSince1970]*1000);
            NSLog(@"refreshTokentime        - %f",[[NSUserDefaults standardUserDefaults] doubleForKey:@"refreshTokentime"]);
            NSLog(@"OutOfRefreshTokenTime   - %f",[[NSUserDefaults standardUserDefaults] doubleForKey:@"OutOfRefreshTokenTime"]);
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"userLoginNotification" object:nil userInfo:nil];

            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationOpenMainTableBarTimer object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"open",@"timer", nil]];
            [self connectRongyunWithUserModel:model];
            //登陆成功之后注册推送
//            [XGPush setAccount:[NSString stringWithFormat:@"GQ%lu",(long)model.idId]];
//
//            [XGPush registerDevice:[[NSUserDefaults standardUserDefaults] objectForKey:@"deviceTokenData"] successCallback:^{
//                NSLog(@"[XGPush Demo]register successBlock");
//                
//            } errorCallback:^{
//                NSLog(@"[XGPush Demo]register wrongBlock");
//                
//            }];
            
#warning 推送代码
            
//            [UMessage setUniqueID:[NSString stringWithFormat:@"GQ%lu",(long)model.idId]];
//            [UMessage setAlias:[NSString stringWithFormat:@"GQ%lu",(long)model.idId] type:@"GUN_QIU" response:^(id  _Nonnull responseObject, NSError * _Nonnull error) {
//
//                NSLog(@"");
//            }];

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
//        if ([responseOrignal objectForKey:@"code"] != nil) {
//            _prograssHud.labelText = [responseOrignal objectForKey:@"msg"];
//        }else{
            _prograssHud.labelText = errorDict;
//        }
        [_prograssHud hide:YES afterDelay:1];
        //        [self performSelector:@selector(dismiss) withObject:nil afterDelay:1];
        NSLog(@"%@",responseOrignal);
    }];

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
    
    NSMutableDictionary *dictParameter = [NSMutableDictionary dictionaryWithDictionary:[HttpString getCommenParemeter]];
    [dictParameter setObject:@"9" forKey:@"flag"];
    [dictParameter setObject:username forKey:@"username"];
    [dictParameter setObject:nickname forKey:@"nickname"];
    [dictParameter setObject:resource forKey:@"resource"];
    [dictParameter setObject:pic forKey:@"pic"];
    [dictParameter setObject:[Methods md5WithString:password] forKey:@"password"];
    // 设备udid
    [dictParameter setObject:@"1" forKey:@"platform"];
    [dictParameter setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"deviceTokenStr"] forKey:@"uuid"];
    [dictParameter setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"deviceTokenStr"] forKey:@"token"];

    [[DCHttpRequest shareInstance] sendRequestByMethod:@"post" WithParamaters:dictParameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_loginAndRegister] ArrayFile:nil Start:^(id requestOrignal) {
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
            
            NSString *nowDate = [Methods getDateByStyle:dateStyleFormatter withDate:[NSDate dateWithTimeIntervalSinceNow:3600*24*15]];
            [[NSUserDefaults standardUserDefaults] setObject:nowDate forKey:@"thirdPartLoginDeadline"];
            [[NSUserDefaults standardUserDefaults] synchronize];
           
            UserModel *model = [UserModel entityFromDictionary:[responseOrignal objectForKey:@"data"]];
            TokenModel *tokenModel = [TokenModel entityFromDictionary:[responseOrignal objectForKey:@"data"]];
            
            [Methods updateTokentModel:tokenModel];
            [Methods updateUsetModel:model];
            
//            [[NSUserDefaults standardUserDefaults] setObject:tokenModel.token forKey:@"token"];
//            [[NSUserDefaults standardUserDefaults] setObject:tokenModel.refreshToken forKey:@"refreshToken"];
            [[NSUserDefaults standardUserDefaults] setDouble:([[responseOrignal objectForKey:@"time"] doubleValue] + RequestRefreshTokenTime) forKey:@"refreshTokentime"];
            [[NSUserDefaults standardUserDefaults] synchronize];
//

            
//            [[NSNotificationCenter defaultCenter]postNotificationName:@"userLoginNotification" object:nil userInfo:nil];

            
            
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
- (void)everRegisterThirdPartLoginWithUsername:(NSString *)username nickName:(NSString *)nickname picUrl:(NSString *)pic resource:(NSString *)resource
{
    /*
     utype = 0，//操作类型（0:登录操作，1：获取手机验证码，2：用户注册，3：找回密码）
     
     visit=1&flag=10&username=DD217B7A7A169C868F5D222E83FDCC38
     10;判断是否用第三方登陆过
     */
    [self.view endEditing:YES];
    
    BangUserVC *bangVC = [BangUserVC new];
    bangVC.nickname = nickname;
    bangVC.username = username;
    bangVC.pic = pic;
    [[NSUserDefaults standardUserDefaults] setObject:nickname forKey:@"bangNickName"];
    [[NSUserDefaults standardUserDefaults] setObject:username forKey:@"bangUserName"];
    [[NSUserDefaults standardUserDefaults] setObject:pic forKey:@"bangPic"];
    [[NSUserDefaults standardUserDefaults] setObject:resource forKey:@"bangResource"];
    
    NSMutableDictionary *dictParameter = [NSMutableDictionary dictionaryWithDictionary:[HttpString getCommenParemeter]];
    [dictParameter setObject:@"10" forKey:@"flag"];
    [dictParameter setObject:username forKey:@"username"];
    [dictParameter setObject:resource forKey:@"resource"];

    // 设备udid
    [dictParameter setObject:@"1" forKey:@"platform"];
    [dictParameter setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"deviceTokenStr"] forKey:@"uuid"];
    [dictParameter setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"deviceTokenStr"] forKey:@"token"];


    [[DCHttpRequest shareInstance] sendRequestByMethod:@"post" WithParamaters:dictParameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_loginAndRegister] ArrayFile:nil Start:^(id requestOrignal) {
        if (!_prograssHud) {
            _prograssHud = [[MBProgressHUD alloc] initWithView:self.view];
        }
        _prograssHud.mode = MBProgressHUDModeIndeterminate;
        _prograssHud.labelText = @"正在登陆";
        [_prograssHud show:YES];
        [self.view addSubview:_prograssHud];
        
    } End:^(id responseOrignal) {
        
    } Success:^(id responseResult, id responseOrignal) {
        //        NSLog(@"登陆成功---%@",responseOrignal);
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            

            if ([[responseOrignal objectForKey:@"data"] isKindOfClass:[NSDictionary class]] ) {
                
                _prograssHud.mode = MBProgressHUDModeCustomView;
                _prograssHud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"success"]];
                _prograssHud.labelText = @"登录成功";
                
                
                
                [[NSUserDefaults standardUserDefaults] setObject:_telTextF.text forKey:@"telTextF"];
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"login"];
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"thirdPartLogin"];
                
                NSString *nowDate = [Methods getDateByStyle:dateStyleFormatter withDate:[NSDate dateWithTimeIntervalSinceNow:3600*24*15]];
                [[NSUserDefaults standardUserDefaults] setObject:nowDate forKey:@"thirdPartLoginDeadline"];
                [[NSUserDefaults standardUserDefaults] synchronize];
               
                UserModel *model = [UserModel entityFromDictionary:[responseOrignal objectForKey:@"data"]];
                TokenModel *tokenModel = [TokenModel entityFromDictionary:[responseOrignal objectForKey:@"data"]];
                
                [Methods updateTokentModel:tokenModel];
                [Methods updateUsetModel:model];
                
//                [[NSUserDefaults standardUserDefaults] setObject:tokenModel.token forKey:@"token"];
//                [[NSUserDefaults standardUserDefaults] setObject:tokenModel.refreshToken forKey:@"refreshToken"];
                [[NSUserDefaults standardUserDefaults] setDouble:([[responseOrignal objectForKey:@"time"] doubleValue] + RequestRefreshTokenTime) forKey:@"refreshTokentime"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                

            
                
                [[NSNotificationCenter defaultCenter] postNotificationName:NotificationOpenMainTableBarTimer object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"open",@"timer", nil]];
                
                [self connectRongyunWithUserModel:model];

                [_prograssHud hide:YES afterDelay:1];
                [self performSelector:@selector(dismiss) withObject:nil afterDelay:1];

                
            }else{
                [_prograssHud hide:YES afterDelay:0];
//                LoginViewController *loginVC = [[LoginViewController alloc] init];
//                loginVC.type = typeLoginThirdParth;
//                loginVC.nickname = nickname;
//                loginVC.username = username;
//                loginVC.pic = pic;
//                loginVC.resource = resource;
//                [self presentViewController:loginVC animated:YES completion:^{
//                    
//                }];

//                [self toRegister];
                [self toBangUserVC];
            }
            
            
            
            
        }else{
            _prograssHud.mode = MBProgressHUDModeCustomView;
            _prograssHud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wrong"]];
            _prograssHud.labelText = [responseOrignal objectForKey:@"msg"];
            [_prograssHud hide:YES afterDelay:1];

        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        _prograssHud.mode = MBProgressHUDModeCustomView;
        _prograssHud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wrong"]];
        _prograssHud.labelText = errorDict;
        [_prograssHud hide:YES afterDelay:1];
        NSLog(@"%@",responseOrignal);
    }];
    
}

- (void)toBangUserVC {

    BangUserVC *bangVC = [BangUserVC new];
    [self presentViewController:bangVC animated:YES completion:nil];
}

- (void)toRegister
{
    RegisterViewController *registerVC = [[RegisterViewController alloc]init];
//    registerVC.bangType = bangDingType;
    [self presentViewController:registerVC animated:YES completion:nil];
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;        // return NO to disallow editing.
{
    if (textField == _telTextF) {
        _imageViewTel.image = [UIImage imageNamed:@"register2_1"];
    }else if (textField == _pswTextF){
        _imageViewPsw.image = [UIImage imageNamed:@"register3_1"];
    }
    
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField;           // became first responder
{
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string   // return NO to not change text
{
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
    
    if (_telTextF == textField)  //判断是否时我们想要限定的那个输入框
    {
        
//        return YES;
//        if (_type == typeLoginThirdParth) {
//            return YES;
//        }
//        NSCharacterSet *cs;
//        cs = [[NSCharacterSet characterSetWithCharactersInString:Nunbers] invertedSet];
//        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs]componentsJoinedByString:@""]; //按cs分离出数组,数组按@""分离出字符串
//        if ([string isEqualToString:filtered]) {
//            if ([toBeString length] > 11) { //如果输入框内容大于20则弹出警告
//                textField.text = [toBeString substringToIndex:11];
//                return NO;
//            }else{
//                return YES;
//            }
//
//        }else{
//            return NO;
//        }
//        
        
    }else if(_pswTextF == textField){
        NSCharacterSet *cs;
        cs = [[NSCharacterSet characterSetWithCharactersInString:LettersAndNum] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        if ([string isEqualToString:filtered]) {
            if ([toBeString length]>16) {
                textField.text = [toBeString substringToIndex:16];
                return NO;
            }else{
                return YES;
            }
        }else{
            return NO;
        }
    }
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    self.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    [UIView commitAnimations];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_telTextF resignFirstResponder];
    [_pswTextF resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//登录之后要更新融云信息
- (void)connectRongyunWithUserModel:(UserModel *)user
{
    
}
//{
//    [[RCIM sharedRCIM] disconnect];
//    
//    NSMutableDictionary *parameter =[NSMutableDictionary dictionaryWithDictionary: [HttpString getCommenParemeter]];
//    [parameter setObject:[NSString stringWithFormat:@"%ld",user.idId] forKey:@"userId"];
//    [parameter setObject:user.nickname forKey:@"nickname"];
//    [parameter setObject:user.pic forKey:@"pic"];
//    [[DCHttpRequest shareInstance] sendRequestByMethod:@"post" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_getRonyunUserToken] ArrayFile:nil Start:^(id requestOrignal) {
//        
//    } End:^(id responseOrignal) {
//        
//    } Success:^(id responseResult, id responseOrignal) {
//        
//        
//        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
//            
//            NSString *tokenRongyun = [[responseOrignal objectForKey:@"data"] objectForKey:@"token"];
//            NSString *userIdRongyun = [[responseOrignal objectForKey:@"data"] objectForKey:@"userId"];
//            [[NSUserDefaults standardUserDefaults] setObject:userIdRongyun forKey:@"userIdRongyun"];
//            [[NSUserDefaults standardUserDefaults] setObject:tokenRongyun forKey:@"tokenRongyun"];
//            
//
//            //
//            [[RCIM sharedRCIM] connectWithToken:tokenRongyun success:^(NSString *userId) {
//                NSLog(@"%@",userId);
//                
//
//            } error:^(RCConnectErrorCode status) {
//                NSLog(@"");
//                
//            } tokenIncorrect:^{
//                NSLog(@"");
//                
//            }];
//            [[RCIM sharedRCIM] clearUserInfoCache];
//            RCUserInfo *userInfo = [RCUserInfo new];
//            userInfo.name = user.nickname;
//            userInfo.userId = [NSString stringWithFormat:@"%ld",user.idId];
//            userInfo.portraitUri = user.pic;
//            
//            [[RCIM sharedRCIM] refreshUserInfoCache:userInfo withUserId:userInfo.userId];
//            [RCIM sharedRCIM].currentUserInfo = [[RCUserInfo alloc] initWithUserId:[NSString stringWithFormat:@"%ld",user.idId] name:user.nickname portrait:user.pic];
//
//        }
//        
//        
//        
//    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
//        
//    }];
//    
//
//}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
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
