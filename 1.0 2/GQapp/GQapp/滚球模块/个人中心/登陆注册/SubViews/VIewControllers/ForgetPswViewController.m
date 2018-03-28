//
//  ForgetPswViewController.m
//  GunQiuLive
//
//  Created by WQ_h on 16/1/26.
//  Copyright © 2016年 WQ_h. All rights reserved.
//

#import "ForgetPswViewController.h"
#import "JKCountDownButton.h"
#import "DCHttpRequest.h"
#import "MBProgressHUD.h"
#define colorBtn ColorWithRGBA(253, 186, 49, 1)

@interface ForgetPswViewController ()<UITextFieldDelegate>
{
    float _keyboardHeight;
}
@property (nonatomic, strong) UITextField *telTextF;
@property (nonatomic, strong) UITextField *checkTextF;
@property (nonatomic, strong) UITextField *pswTextF;
@property (nonatomic, strong) UITextField *pswAginTextF;
@property (nonatomic, strong) JKCountDownButton *getCheckBTn;
@property (nonatomic, strong) MBProgressHUD *prograssHud;
@property (nonatomic, retain)NSMutableArray *arrImg;

@end

@implementation ForgetPswViewController

- (void)viewWillAppear:(BOOL)animated{

    self.navigationController.navigationBar.hidden = YES;
    [super viewWillAppear:animated];
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavView];
    self.view.backgroundColor = grayColor1;
    // Do any additional setup after loading the view.
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    _arrImg = [[NSMutableArray alloc] initWithCapacity:0];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keybordUp:) name:UIKeyboardWillShowNotification object:nil];
    _keyboardHeight = 0;
    [self creatForgetPsw];
}
- (void)keybordUp:(NSNotification *)notification
{
    NSValue *value = [notification.userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect rect = [value CGRectValue];
    _keyboardHeight = rect.size.height;
    CGFloat space =Height - (_pswAginTextF.frame.origin.y + _pswAginTextF.frame.size.height) - _keyboardHeight;
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
#pragma mark -- setnavView
- (void)setNavView{
    NavView *nav = [[NavView alloc] init];
    nav.delegate = self;
    nav.labTitle.text = @"找回密码";
    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateNormal];
    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateHighlighted];
    [nav.btnRight setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [nav.btnRight setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
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
        
        
    }
}
- (void)creatForgetPsw
{
    float space = 20;
    float textHeight = 50;
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(0, 20, 59, 44);
    //    [cancelBtn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(dismissPresent) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *back = [[UIImageView alloc] initWithFrame:CGRectMake(15, 0, 44, 44)];
//    back.center = CGPointMake(cancelBtn.width/2, cancelBtn.width/2);
    back.image = [UIImage imageNamed:@"back"];
//    [cancelBtn addSubview:back];
//    [self.view addSubview:cancelBtn];
    
    
    UILabel *title = [[UILabel alloc] init];
    title.textAlignment = NSTextAlignmentCenter;
    title.text = @"密码找回";
    title.font = font16;
    title.textColor = ColorWithRGBA(64, 64, 64, 1);
    title.frame = CGRectMake(0, 30, 70, 15);
    CGPoint titlePiont = title.center;
    titlePiont.x = self.view.center.x;
    title.center = titlePiont;
    
//    [self.view addSubview:title];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, Width, 0.5)];
    lineView.backgroundColor = colorDD;
    [self.view  addSubview:lineView];

    [self.view addSubview:cancelBtn];
    UIView *ForgetPswView = [[UIView alloc] initWithFrame:CGRectMake(0, lineView.bottom, Width, textHeight*4)];
    ForgetPswView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:ForgetPswView];
  
    UILabel *lab86 = [[UILabel alloc] initWithFrame:CGRectMake(space, 5, textHeight-10, textHeight - 10)];
    lab86.center = CGPointMake(lab86.center.x, textHeight/2);
    lab86.font = font12;
    lab86.text = @"+86";
//    lab86.backgroundColor = redcolor;
//    [ForgetPswView addSubview:lab86];
    
    UIImageView *imgPhoneNum = [[UIImageView alloc] initWithFrame:CGRectMake(space, 5, textHeight/3.5, textHeight/2.3)];
    imgPhoneNum.image = [UIImage imageNamed:@"register0"];
    imgPhoneNum.center = CGPointMake(imgPhoneNum.center.x, textHeight/2);
    [ForgetPswView addSubview:imgPhoneNum];
    [_arrImg addObject:imgPhoneNum];
    
    _telTextF = [[UITextField alloc] initWithFrame:CGRectMake(textHeight, 0, ForgetPswView.bounds.size.width - (lab86.frame.origin.x + lab86.bounds.size.width + space), textHeight -10)];
    _telTextF.center = CGPointMake(_telTextF.center.x, lab86.center.y);
//    _telTextF.borderStyle = UITextBorderStyleRoundedRect;
    _telTextF.font = font12;
    _telTextF.keyboardType = UIKeyboardTypeDecimalPad;
    _telTextF.placeholder = @"请输入注册的手机号";
    _telTextF.clearButtonMode = UITextFieldViewModeWhileEditing;
    _telTextF.delegate = self;
    [ForgetPswView addSubview:_telTextF];
    
    UIImageView *imgPhoneyzm = [[UIImageView alloc] initWithFrame:CGRectMake(space, textHeight +5, textHeight/3.5, textHeight/3)];
    imgPhoneyzm.image = [UIImage imageNamed:@"register1"];
    imgPhoneyzm.center = CGPointMake(imgPhoneyzm.center.x, textHeight/2 + textHeight);
    [ForgetPswView addSubview:imgPhoneyzm];
    [_arrImg addObject:imgPhoneyzm];
    
    _checkTextF = [[UITextField alloc] initWithFrame:CGRectMake(textHeight, 0, ForgetPswView.bounds.size.width - textHeight - 80, textHeight - 10)];
    _checkTextF.center = CGPointMake(_checkTextF.center.x, _telTextF.center.y + textHeight);
//    _checkTextF.borderStyle = UITextBorderStyleRoundedRect;
    _checkTextF.font = font12;
    _checkTextF.keyboardType = UIKeyboardTypeDecimalPad;
    _checkTextF.placeholder = @"请输入验证码";
    _checkTextF.clearButtonMode = UITextFieldViewModeWhileEditing;
    _checkTextF.delegate = self;
    [ForgetPswView addSubview:_checkTextF];
    

    
    _getCheckBTn = [[JKCountDownButton alloc] initWithFrame:CGRectMake(_checkTextF.frame.origin.x + _checkTextF.frame.size.width - 10, textHeight + 10, 80, textHeight - 20)];
    _getCheckBTn.titleLabel.font = font12;
    [_getCheckBTn setTitleColor:grayColor34 forState:UIControlStateNormal];
    _getCheckBTn.layer.cornerRadius = 5;
    _getCheckBTn.layer.borderWidth = 1;
    [_getCheckBTn setBackgroundColor:[UIColor whiteColor]];
    _getCheckBTn.layer.borderColor = cellLineColor.CGColor;
    [_getCheckBTn setTitle:@"获取验证码" forState:UIControlStateNormal];
//    [_getCheckBTn setTintColor:[UIColor whiteColor]];
//    [_getCheckBTn setBackgroundColor:colorBtn];
//    [_getCheckBTn.titleLabel setFont:font12];
    [_getCheckBTn addTarget:self action:@selector(getCheckCode:) forControlEvents:UIControlEventTouchUpInside];
    [ForgetPswView addSubview:_getCheckBTn];
    
    for (int i = 0; i<3; i++) {
        if (i<2) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(space, 0, textHeight/3, textHeight/3)];
            imageView.center = CGPointMake(imageView.center.x , lab86.center.y + textHeight*(i + 2));
            imageView.image = [UIImage imageNamed:@"register3"];
            [ForgetPswView addSubview:imageView];
            [_arrImg addObject:imageView];
        }
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, textHeight*(i+1) - 0.5, ForgetPswView.bounds.size.width, 0.5)];
        lineView.backgroundColor = colorDD;
        [ForgetPswView addSubview:lineView];
    }
    
    _pswTextF = [[UITextField alloc] initWithFrame:CGRectMake(_telTextF.frame.origin.x, _telTextF.frame.origin.y + textHeight *2, _telTextF.bounds.size.width,_telTextF.bounds.size.height)];
//    _pswTextF.borderStyle = UITextBorderStyleRoundedRect;
    _pswTextF.font = font12;
    _pswTextF.keyboardType = UIKeyboardTypeDefault;
    _pswTextF.placeholder = @"请输入密码";
    _pswTextF.clearButtonMode = UITextFieldViewModeWhileEditing;
    _pswTextF.secureTextEntry = YES;
    _pswTextF.delegate = self;
    [ForgetPswView addSubview:_pswTextF];
    
    _pswAginTextF = [[UITextField alloc] initWithFrame:CGRectMake(_telTextF.frame.origin.x, _telTextF.frame.origin.y + textHeight *3, _telTextF.bounds.size.width,_telTextF.bounds.size.height)];
//    _pswAginTextF.borderStyle = UITextBorderStyleRoundedRect;
    _pswAginTextF.font = font12;
    _pswAginTextF.keyboardType = UIKeyboardTypeDefault;
    _pswAginTextF.placeholder = @"请再次输入密码";
    _pswAginTextF.secureTextEntry = YES;
    _pswAginTextF.clearButtonMode = UITextFieldViewModeWhileEditing;
    _pswAginTextF.delegate = self;
    [ForgetPswView addSubview:_pswAginTextF];
    
    UIButton *resetPswBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    resetPswBtn.frame = CGRectMake(10, ForgetPswView.frame.origin.y + ForgetPswView.frame.size.height + space*2, ForgetPswView.bounds.size.width - 20, textHeight - 10);
    [resetPswBtn setTitle:@"完成重置" forState:UIControlStateNormal];
    [resetPswBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [resetPswBtn setBackgroundColor:redcolor];
    [resetPswBtn.titleLabel setFont:font14];
    resetPswBtn.layer.cornerRadius = 3;
    [resetPswBtn addTarget:self action:@selector(resetPswBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:resetPswBtn];
    
    UILabel *detailLab = [[UILabel alloc] initWithFrame:CGRectMake(space*2, Height - space/2 - textHeight, Width - space *4, textHeight)];
    detailLab.text = @"您将收到一条验证您身份的短信,我们承诺绝不会向您推送垃圾消息和泄露您的个人信息。";
    detailLab.font = font10;
    detailLab.numberOfLines = 2;
    detailLab.textColor = ColorWithRGBA(64, 64, 64, 1);
    detailLab.backgroundColor = [UIColor clearColor];
    [self.view addSubview:detailLab];


    
}
- (void)getCheckCode:(JKCountDownButton *)btn
{
    [SVProgressHUD setMinimumDismissTimeInterval:1.5];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];

    _telTextF.text = [_telTextF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (![Methods isMobileNumber:self.telTextF.text]) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"手机号不正确"];
        return;
    }
    
    btn.enabled = NO;
    [btn startWithSecond:60];
    [btn didChange:^NSString *(JKCountDownButton *countDownButton, int second) {
        return [NSString stringWithFormat:@"%ds后重发",second];
    }];
    [btn didFinished:^NSString *(JKCountDownButton *countDownButton, int second) {
        countDownButton.enabled = YES;
        return @"重新获取";
    }];
    //    sender.enabled = NO;
    //button type要 设置成custom 否则会闪动
    [self getcheckCode];
}
//发送验证码
- (void)getcheckCode
{
    /*
     utype = 1，//操作类型（0:登录操作，1：获取手机验证码，2：用户注册，3：找回密码）
     mobile，  //手机号
     type     //验证码类型，0：注册验证码，1：找回密码验证码，2：更改手机号验证码',
     */
    [self.view endEditing:YES];
    NSMutableDictionary *dictParameter = [NSMutableDictionary dictionaryWithDictionary:[HttpString getCommenParemeter]];
    [dictParameter setObject:@"1" forKey:@"flag"];
    [dictParameter setObject:_telTextF.text forKey:@"mobile"];
    [dictParameter setObject:@"1" forKey:@"type"];
    
    // 设备udid
    [dictParameter setObject:@"1" forKey:@"platform"];
    [dictParameter setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"deviceTokenStr"] forKey:@"uuid"];
    

    [[DCHttpRequest shareInstance] sendRequestByMethod:@"post" WithParamaters:dictParameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_loginAndRegister] ArrayFile:nil Start:^(id requestOrignal) {

    } End:^(id responseOrignal) {
        
    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"验证码已发送"];
        }else{
            [_getCheckBTn stop];

            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:[responseOrignal objectForKey:@"msg"]];
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:errorDict];
        
    }];
}

- (void)dismissPresent
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)resetPswBtnClick:(UIButton *)btn
    {
        //    [self.view endEditing:YES];
        [_getCheckBTn stop];
        
        _telTextF.text = [_telTextF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        _checkTextF.text = [_checkTextF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        _pswAginTextF.text = [_pswAginTextF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        _pswTextF.text= [_pswTextF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        
        if (isNUll(self.telTextF.text) || isNUll(self.checkTextF.text) || isNUll(self.pswAginTextF.text) || isNUll(self.pswTextF.text)) {
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"应填项不能为空"];
            return;
        }

        
        
        if (![Methods isMobileNumber:self.telTextF.text]) {
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"手机号不正确"];
            return;
        }
        if (!(self.pswTextF.text.length >= 6 && self.pswTextF.text.length <=16)) {
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"请输入6~16个字符密码"];
            return;
        }
        
        if (!(self.pswAginTextF.text.length >= 6 && self.pswAginTextF.text.length <=16)) {
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"请输入6~16个字符密码"];
            return;
        }

        if (![_pswTextF.text isEqualToString:_pswAginTextF.text]) {
            [SVProgressHUD showErrorWithStatus:@"两次输入密码不一致"];
            return;
        }
        [self resetPsw];
}

- (void)resetPsw
{
    [self.view endEditing:YES];
    /*
     utype = 3，//操作类型（0:登录操作，1：获取手机验证码，2：用户注册，3：找回密码）
     mobile，  //手机号
     password，//密码
     authCode，//验证码
     */
    NSMutableDictionary *dictPatameter = [NSMutableDictionary dictionaryWithDictionary:[HttpString getCommenParemeter]];
    [dictPatameter setObject:@"3" forKey:@"flag"];
    [dictPatameter setObject:_telTextF.text forKey:@"mobile"];
    [dictPatameter setObject:[Methods md5WithString:_pswTextF.text] forKey:@"password"];
    [dictPatameter setObject:_checkTextF.text forKey:@"authCode"];
    // 设备udid
    [dictPatameter setObject:@"1" forKey:@"platform"];
    [dictPatameter setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"deviceTokenStr"] forKey:@"uuid"];
    

    [[DCHttpRequest shareInstance] sendRequestByMethod:@"post" WithParamaters:dictPatameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_loginAndRegister] ArrayFile:nil Start:^(id requestOrignal) {
        if (!_prograssHud) {
            _prograssHud = [[MBProgressHUD alloc] initWithView:self.view];
        }
        _prograssHud.mode = MBProgressHUDModeIndeterminate;
        _prograssHud.labelText = @"正在重置密码";
        [_prograssHud show:YES];
        [self.view addSubview:_prograssHud];
    } End:^(id responseOrignal) {
        [_prograssHud hide:YES afterDelay:1];

    } Success:^(id responseResult, id responseOrignal) {
        
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            _prograssHud.mode = MBProgressHUDModeCustomView;
            _prograssHud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"success"]];
            _prograssHud.labelText = @"重置成功";
            [_prograssHud hide:YES afterDelay:1];
            [[NSUserDefaults standardUserDefaults] setObject:_telTextF.text forKey:@"telTextF"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self performSelector:@selector(dismissPresent) withObject:nil afterDelay:1];
        }else{
            _prograssHud.mode = MBProgressHUDModeCustomView;
            _prograssHud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wrong"]];
            _prograssHud.labelText = [responseOrignal objectForKey:@"msg"];
            [_prograssHud hide:YES afterDelay:1];
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        _prograssHud.mode = MBProgressHUDModeCustomView;
        _prograssHud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wrong"]];
//        if ([responseOrignal objectForKey:@"code"]!= nil) {
//            _prograssHud.labelText = [responseOrignal objectForKey:@"code"];
//        }else{
        _prograssHud.labelText = errorDict;
//        }
        [_prograssHud hide:YES afterDelay:1];
    }];

}




- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;        // return NO to disallow editing.
{
    UIImageView *img = nil;
    if (textField == _pswTextF) {
        img = [_arrImg objectAtIndex:2];
        img.image = [UIImage imageNamed:@"register3_1"];
    }else if (textField == _pswAginTextF){
        img = [_arrImg objectAtIndex:3];
        img.image = [UIImage imageNamed:@"register3_1"];
    }else if (textField == _telTextF){
        img = [_arrImg objectAtIndex:0];
        img.image = [UIImage imageNamed:@"register0_1"];
    }else{
        img = [_arrImg objectAtIndex:1];
        img.image = [UIImage imageNamed:@"register1_1"];
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
        NSCharacterSet *cs;
        cs = [[NSCharacterSet characterSetWithCharactersInString:Nunbers] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs]componentsJoinedByString:@""]; //按cs分离出数组,数组按@""分离出字符串
        if ([string isEqualToString:filtered]) {
            if ([toBeString length] > 11) { //如果输入框内容大于20则弹出警告
                textField.text = [toBeString substringToIndex:11];
                return NO;
            }else{
                return YES;
            }
            
        }else{
            return NO;
        }
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
    }else if (_checkTextF == textField){
        NSCharacterSet *cs;
        cs = [[NSCharacterSet characterSetWithCharactersInString:Nunbers] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        if ([string isEqualToString:filtered]) {
            if ([toBeString length]>6) {
                textField.text = [toBeString substringToIndex:6];
                return NO;
            }else{
                return YES;
            }
        }else{
            return NO;
        }
    }else if (_pswAginTextF == textField){
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
    if (_checkTextF == textField) {
        if (_checkTextF.text.length == 6) {
            [_getCheckBTn stop];
        }
    }
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    self.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    [UIView commitAnimations];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
