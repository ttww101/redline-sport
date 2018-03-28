//
//  UsersCell.m
//  GQapp
//
//  Created by WQ on 2017/1/11.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import "UsersCell.h"
#import "DC_JZAPhotoVC.h"
#import "UserTuiianView.h"
#import "UserTuijianVC.h"
#import "SignatureVC.h"
#import "NoticePageVC.h"
#import "MyProfileVC.h"
@interface UsersCell()<UserTuiianViewDelegate,UIGestureRecognizerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) UIView *basicView;

@property (nonatomic, strong) UIImageView *imageBasic;
@property (nonatomic, strong) UIButton *btnUserPic;
@property (nonatomic, strong) UIButton *btnUser;

@property (nonatomic, strong) UIButton *unreadBtn;
@property (nonatomic, strong) UILabel *labUnreadNum;


//勋章
@property (nonatomic, strong) UIImageView *imageAuthorTitle;
@property (nonatomic, strong) UIImageView *imageAuthorTitle1;
@property (nonatomic, strong) UIImageView *imageAuthorTitle2;


@property (nonatomic, strong) UILabel *labUserRemark1;
@property (nonatomic, strong) UILabel *labUserRemark2;
@property (nonatomic, strong) UILabel *labUserIntro;//用户简介
//@property (nonatomic, strong) UserTuiianView *viewTuijian;
@property (nonatomic, strong) UIButton *btnEdit;

@property (nonatomic, strong) UIView                *gzView;
//关注
@property (nonatomic, strong) UILabel               *labGZ;
@property (nonatomic, strong) UILabel               *labGZNum;

//@property (nonatomic, strong) UIView                *viewLineR;
@property (nonatomic, strong) UIView                *fsView;
//粉丝
@property (nonatomic, strong) UILabel               *labFS;
@property (nonatomic, strong) UILabel               *labFSNum;
@property (nonatomic, assign) BOOL isAddAutoLayout;
@end

@implementation UsersCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(UserModel *)model
{
    _model = model;
    
    [self.contentView addSubview:self.basicView];
    if (!_isAddAutoLayout) {
        [self addAutoLayout];
        _isAddAutoLayout = YES;
    }
    
    _labGZNum.text = [NSString stringWithFormat:@"%ld",(long)_model.focusCount];;
    _labFSNum.text = [NSString stringWithFormat:@"%ld",(long)_model.followerCount];;
    
    _labGZ.hidden = ![Methods login];
    _labFS.hidden = ![Methods login];
    _labGZNum.hidden = ![Methods login];
    _labFSNum.hidden = ![Methods login];
    
//    _imageBasic.image = [UIImage imageNamed:@"userBg1"];
    if ([Methods login]) {
        [self.btnUserPic mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.basicView.mas_top).offset(15); //64
            make.left.equalTo(self.basicView.mas_left).offset(15);
            make.height.mas_equalTo(50);
            make.width.mas_equalTo(50);
        }];
//        [self.viewTuijian mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.btnUserPic.mas_bottom).offset(7.5);
//            make.left.equalTo(self.basicView.mas_left);
//            make.size.mas_equalTo(CGSizeMake(Width, 60));
//            make.bottom.equalTo(self.basicView.mas_bottom);
//        }];

        
        
        [_btnUser setTitle:_model.nickname forState:UIControlStateNormal];
        [_btnUser setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

        _labUserIntro.text = _model.userinfo;
//        [_labUserIntro setAttributedText:[Methods setTextStyleWithString:_model.userinfo WithLineSpace:6 WithHeaderIndent:0]];
        if (_model.userinfo.length == 0 || isNUll(_model.userinfo)) {
            _labUserIntro.text = @"写下你的个性签名，让更多人认识你呦";
        }
        _labUserIntro.textColor = [UIColor darkGrayColor];

        _gzView.userInteractionEnabled = YES;
        _fsView.userInteractionEnabled = YES;
        [_btnEdit setBackgroundImage:[UIImage imageNamed:@"bianji"] forState:UIControlStateNormal];
        _btnEdit.hidden = YES;
//        _viewTuijian.model = _model;
//        self.viewTuijian.hidden = NO;
        [self.btnUserPic mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.basicView.mas_top).offset(15); //64
            make.left.equalTo(self.basicView.mas_left).offset(15);
            make.height.mas_equalTo(50);
            make.width.mas_equalTo(50);
            make.bottom.mas_equalTo(self.basicView.mas_bottom).offset(-15); // -67.5
        }];
//        [self.btnUserPic sd_setBackgroundImageWithURL:[NSURL URLWithString:_model.pic] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@""]];
        
        [self.btnUserPic sd_setImageWithURL:[NSURL URLWithString:_model.pic] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"defaultPic"]];
        
    }else{
        [_btnUserPic setImage:[UIImage imageNamed:@"defaultPic1"] forState:UIControlStateNormal];
        [_btnUser setTitle:@"登录/注册" forState:UIControlStateNormal];
        [_btnUser setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        _labUserIntro.text = @"马上登录，获取更多的信息和福利";
        _labUserIntro.textColor = [UIColor darkGrayColor];
        _gzView.userInteractionEnabled = NO;
        _fsView.userInteractionEnabled = NO;
        _btnEdit.hidden = YES;
        [self.btnUserPic mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.basicView.mas_top).offset(15); //64
            make.left.equalTo(self.basicView.mas_left).offset(15);
            make.height.mas_equalTo(50);
            make.width.mas_equalTo(50);
            make.bottom.mas_equalTo(self.basicView.mas_bottom).offset(-15); // -20
        }];
//        self.viewTuijian.hidden = YES;
    }
    
    

    
    
    
//    _labUserRemark1.text = @" 12中5 ";
//    _labUserRemark2.text = @" 7连红 ";
    //
    //    for (int i = 0; i<remark.count; i++) {
    //        UsermarkModel *usermark = [remark objectAtIndex:i];
    //
    //        if (usermark.type == 1) {
    //            _labRemark1.text =[NSString stringWithFormat:@" %@ ",usermark.remark];
    //
    //        }else if (usermark.type == 2){
    //
    //            _labRemark2.text  = usermark.remark;
    //        }else{
    //
    //        }
    //    }
    //
//    [_imageAuthorTitle setImage:[UIImage imageNamed:@"red"]];
//    [_imageAuthorTitle1 setImage:[UIImage imageNamed:@"red"]];
//    [_imageAuthorTitle2 setImage:[UIImage imageNamed:@"red"]];
    //    [titls enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    //
    //        MedalsModel *medals = (MedalsModel*)obj;
    //        switch (idx) {
    //            case 0:
    //            {
    //                [_imageAuthorTitle sd_setImageWithURL:[NSURL URLWithString:medals.url]];
    //            }
    //                break;
    //            case 1:
    //            {
    //                [_imageAuthorTitle1 sd_setImageWithURL:[NSURL URLWithString:medals.url]];
    //            }
    //                break;
    //            case 2:
    //            {
    //                [_imageAuthorTitle2 sd_setImageWithURL:[NSURL URLWithString:medals.url]];
    //            }
    //                break;
    //
    //            default:
    //                break;
    //        }
    //
    //    }];
    //
    

    
}
- (void)clickLogin{
    if ([Methods login]) {
        
    }else{
        [Methods toLogin];
    }
    
    
}

- (UIView *)basicView
{
    if (!_basicView) {
        _basicView = [[UIView alloc] init];
        UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showUserPic)];
        _basicView.userInteractionEnabled = YES;
        [_basicView addGestureRecognizer:tapGest];
//        _basicView.backgroundColor = redcolor;
        _basicView.backgroundColor = [UIColor clearColor];
        [_basicView addSubview:self.imageBasic];
        [_basicView addSubview:self.btnUserPic];
        [_basicView addSubview:self.btnUser];
//        [_basicView addSubview:self.imageAuthorTitle];
//        [_basicView addSubview:self.imageAuthorTitle1];
//        [_basicView addSubview:self.imageAuthorTitle2];
//        [_basicView addSubview:self.labUserRemark1];
//        [_basicView addSubview:self.labUserRemark2];
        [_basicView addSubview:self.labUserIntro];
//        [_basicView addSubview:self.viewTuijian];
        [_basicView addSubview:self.btnEdit];
        
        [_basicView addSubview:self.fsView];
        [_basicView addSubview:self.gzView];
        
//        [_basicView addSubview:self.viewLineR];
     
    }
    return _basicView;
}

- (UIView *)gzView {
    
    if (!_gzView) {
        _gzView = [UIView new];
        [_gzView addSubview:self.labGZNum];
        [_gzView addSubview:self.labGZ];
        _gzView.tag = 1001;
        _gzView.userInteractionEnabled = YES;
        UITapGestureRecognizer *gzTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userFocusClick:)];
        [_gzView addGestureRecognizer:gzTap];
    }
    return _gzView;
}

- (UIView *)fsView {

    if (!_fsView) {
        _fsView = [UIView new];
        [_fsView addSubview:self.labFSNum];
        [_fsView addSubview:self.labFS];
        _fsView.tag = 1002;
        _fsView.userInteractionEnabled = YES;
        UITapGestureRecognizer *fsTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userFocusClick:)];
        [_fsView addGestureRecognizer:fsTap];
    }
    return _fsView;
}

- (UIImageView *)imageBasic
{
    if (!_imageBasic) {
        _imageBasic = [[UIImageView alloc] init];
        
    }
    return _imageBasic;
}

- (UIButton *)btnUserPic
{
    if (!_btnUserPic) {
        _btnUserPic = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnUserPic.layer.cornerRadius = 50/2;
        _btnUserPic.layer.masksToBounds = YES;
        [_btnUserPic addTarget:self action:@selector(showUserPic) forControlEvents:UIControlEventTouchUpInside];

    }
    return _btnUserPic;
}
- (void)showUserPic{
    
    
    if ([Methods login]) {
//        DC_JZAPhotoVC *album = [[DC_JZAPhotoVC alloc] init];
//        
//        album.imgArr = [NSMutableArray arrayWithObject:_model.pic];//可以是图片的url字符串数组，亦可以是UIImage
//        [APPDELEGATE.customTabbar presentToViewController:album animated:YES completion:^{
//            
//        }];
        
        MyProfileVC *myProfile = [[MyProfileVC alloc] init];
        myProfile.hidesBottomBarWhenPushed = YES;
        [APPDELEGATE.customTabbar pushToViewController:myProfile animated:YES];

    }else{
        [Methods toLogin];
    }

}

- (UIButton *)btnUser
{
    if (!_btnUser) {
        _btnUser = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnUser.titleLabel.font = BoldFont4(fontSize18);
        [_btnUser setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnUser addTarget:self action:@selector(clickLogin) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnUser;
}

- (void)rightBarButtonItem
{
    if ([Methods login]) {
        
        NoticePageVC *noticeVC = [[NoticePageVC alloc] init];
        noticeVC.hidesBottomBarWhenPushed = YES;
        [APPDELEGATE.customTabbar pushToViewController:noticeVC animated:YES];
    }else{
        [Methods toLogin];
    }
    
}
- (UIImageView *)imageAuthorTitle
{
    if (!_imageAuthorTitle) {
        _imageAuthorTitle = [[UIImageView alloc] init];
        //                _imageAuthorTitle.image = [UIImage imageNamed:@"red"];
    }
    return _imageAuthorTitle;
}
- (UIImageView *)imageAuthorTitle1
{
    if (!_imageAuthorTitle1) {
        _imageAuthorTitle1 = [[UIImageView alloc] init];
        //        _imageAuthorTitle1.image = [UIImage imageNamed:@"red"];
    }
    return _imageAuthorTitle1;
}
- (UIImageView *)imageAuthorTitle2
{
    if (!_imageAuthorTitle2) {
        _imageAuthorTitle2 = [[UIImageView alloc] init];
        //                _imageAuthorTitle2.image = [UIImage imageNamed:@"red"];
    }
    return _imageAuthorTitle2;
}


- (UILabel *)labUserRemark1
{
    if (!_labUserRemark1) {
        _labUserRemark1 = [[UILabel alloc] init];
        _labUserRemark1.font = font13;
        _labUserRemark1.textColor = [UIColor whiteColor];
        _labUserRemark1.backgroundColor = redcolor;
        _labUserRemark1.layer.cornerRadius = 3;
        _labUserRemark1.layer.masksToBounds = YES;
    }
    return _labUserRemark1;
}
- (UILabel *)labUserRemark2
{
    if (!_labUserRemark2) {
        _labUserRemark2 = [[UILabel alloc] init];
        _labUserRemark2.font = font13;
        _labUserRemark2.textColor = color74;
        //        _labUserRemark2.backgroundColor = redcolor;
    }
    return _labUserRemark2;
}

- (UILabel *)labUserIntro
{
    if (!_labUserIntro) {
        _labUserIntro = [[UILabel alloc] init];
        _labUserIntro.textColor = [UIColor whiteColor];
        _labUserIntro.text = @"写下你的个性签名，让更多人认识你呦";
        _labUserIntro.font = font12;
        _labUserIntro.numberOfLines = 1;
    }
    return _labUserIntro;
}

- (UILabel *)labGZ {
    
    if (!_labGZ) {
        _labGZ = [[UILabel alloc] init];
        _labGZ.text = @"关注";
        _labGZ.hidden = NO;
        _labGZ.tag = 1001;
        _labGZ.textColor = [UIColor darkGrayColor];
        _labGZ.font = font12;
    }
    return _labGZ;
}
- (UILabel *)labGZNum {
    
    if (!_labGZNum) {
        _labGZNum = [[UILabel alloc] init];
//        _labGZNum.text = @"0";
        _labGZNum.textColor = [UIColor darkGrayColor];
        _labGZNum.font = font11;
//        _labFSNum.tag = 1001;
//        _labGZNum.userInteractionEnabled = YES;
//        UITapGestureRecognizer *gzTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userFocusClick:)];
//        [_labGZNum addGestureRecognizer:gzTap];

    }
    return _labGZNum;
}
//-(UIView *)viewLineR {
//    
//    if (!_viewLineR) {
//        _viewLineR = [[UIView alloc] init];
//        _viewLineR.hidden = YES;
//        _viewLineR.backgroundColor = color99;
//    }
//    return _viewLineR;
//}
- (UILabel *)labFS {
    
    if (!_labFS) {
        _labFS = [[UILabel alloc] init];
        _labFS.text = @"粉丝";
        _labFS.hidden = NO;
        _labFS.tag = 1002;
        _labFS.textColor = [UIColor darkGrayColor];
        _labFS.font = font12;
    }
    return _labFS;
}
- (UILabel *)labFSNum {
    
    if (!_labFSNum) {
        _labFSNum = [[UILabel alloc] init];
//        _labFSNum.text = @"0";
        _labFSNum.textColor = [UIColor darkGrayColor];
        _labFSNum.font = font11;
//        _labFSNum.tag = 1003;
//        _labFSNum.userInteractionEnabled = YES;
//        UITapGestureRecognizer *fsTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userFocusClick:)];
//        [_labFSNum addGestureRecognizer:fsTap];
    }
    return _labFSNum;
}


//- (UserTuiianView *)viewTuijian
//{
//    if (!_viewTuijian) {
//        _viewTuijian = [[UserTuiianView alloc] init];
//        _viewTuijian.delegate = self;
//    }
//    return _viewTuijian;
//}
//- (void)didTouchItemWithIndex:(NSInteger)index
//{
//    if (index == 0) {
//        UserTuijianVC *tuijian = [[UserTuijianVC alloc] init];
//        tuijian.userName = _model.nickname;
//        tuijian.userId = _model.idId;
//        tuijian.hidesBottomBarWhenPushed = YES;
//        [APPDELEGATE.customTabbar pushToViewController:tuijian animated:YES];
//
//        
//        
//    }else if (index == 1){
//    
//        //                    关注
//        FriendsVC *friend = [[FriendsVC alloc] init];
//        friend.userId = _model.idId;
//        friend.selectedIndex = 0;
//        friend.hidesBottomBarWhenPushed = YES;
//        [APPDELEGATE.customTabbar pushToViewController:friend animated:YES];
//
//    }else if(index == 2){
//    
//        //                    粉丝
//        FriendsVC *friend = [[FriendsVC alloc] init];
//        friend.userId = _model.idId;
//        friend.selectedIndex = 1;
//        friend.hidesBottomBarWhenPushed = YES;
//        [APPDELEGATE.customTabbar pushToViewController:friend animated:YES];
//
//    }
//}

- (void)userFocusClick:(UITapGestureRecognizer *)gesture {

    
    if (gesture.view.tag == 1001) {
        
        // 关注
        FriendsVC *friend = [[FriendsVC alloc] init];
        friend.userId = _model.idId;
        friend.selectedIndex = 0;
        friend.hidesBottomBarWhenPushed = YES;
        [APPDELEGATE.customTabbar pushToViewController:friend animated:YES];
 
    }else{
    
        // 粉丝
        FriendsVC *friend = [[FriendsVC alloc] init];
        friend.userId = _model.idId;
        friend.selectedIndex = 1;
        friend.hidesBottomBarWhenPushed = YES;
        [APPDELEGATE.customTabbar pushToViewController:friend animated:YES];
   
    }
     
}

- (UIButton *)btnEdit
{
    if (!_btnEdit) {
        _btnEdit = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnEdit addTarget:self action:@selector(edit:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnEdit;
}
- (void)edit:(UIButton *)btn
{
    
    SignatureVC *siVC = [[SignatureVC alloc] init];
    siVC.labContent = _model.userinfo;
    siVC.hidesBottomBarWhenPushed = YES;
    [APPDELEGATE.customTabbar pushToViewController:siVC animated:YES];

}
- (void)addAutoLayout
{
    
    [self.basicView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    
    [self.imageBasic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.basicView.mas_top);
        make.left.equalTo(self.basicView.mas_left);
        make.right.equalTo(self.basicView.mas_right);
        make.bottom.equalTo(self.basicView.mas_bottom);
        
    }];
    [self.btnUserPic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.basicView.mas_top).offset(15);  //64
        make.left.equalTo(self.basicView.mas_left).offset(15);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(50);
    }];
    [self.btnEdit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.basicView.mas_right);
        make.centerY.equalTo(self.labUserIntro.mas_centerY);
//        make.top.equalTo(self.basicView.mas_top).offset(5);
        make.height.mas_equalTo(52);
        make.width.mas_equalTo(52);

    }];

    [self.btnUser mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.btnUserPic.mas_right).offset(15);
//        make.top.equalTo(self.basicView.mas_top).offset(64);
            make.top.equalTo(self.btnUserPic.mas_top).offset(-3);
    }];
    
    [self.labUserIntro mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btnUser.mas_bottom).offset(3);
        make.left.equalTo(self.btnUserPic.mas_right).offset(15);
        make.right.equalTo(self.basicView.mas_right).offset(-60);
    }];
    
//
//    [self.imageAuthorTitle mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.btnUser.mas_right).offset(12);
//        make.centerY.equalTo(self.btnUser.mas_centerY);
//        make.height.mas_equalTo(15);
//        make.width.mas_equalTo(15);
//        
//    }];
//    [self.imageAuthorTitle1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.imageAuthorTitle.mas_right).offset(10);
//        make.centerY.equalTo(self.btnUser.mas_centerY);
//        make.height.mas_equalTo(15);
//        make.width.mas_equalTo(15);
//        
//    }];
//    [self.imageAuthorTitle2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.imageAuthorTitle1.mas_right).offset(10);
//        make.centerY.equalTo(self.btnUser.mas_centerY);
//        make.height.mas_equalTo(15);
//        make.width.mas_equalTo(15);
//        
//    }];
//    
//    
//    [self.labUserRemark1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self.btnUserPic.mas_bottom).offset(0);
//        make.left.equalTo(self.btnUser.mas_left);
//    }];
//    
//    [self.labUserRemark2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.labUserRemark1.mas_top);
//        make.left.equalTo(self.labUserRemark1.mas_right);
//    }];
    
    [self.fsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.basicView.mas_trailing).offset(-26);
        make.centerY.equalTo(self.btnUserPic.mas_centerY).offset(- 15);
        make.size.mas_equalTo(CGSizeMake(30, 40));
    }];
    [self.gzView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.fsView.mas_leading);
        make.centerY.equalTo(self.fsView);
        make.size.mas_equalTo(CGSizeMake(30, 40));
        
    }];
    
    //粉丝
    [self.labFSNum mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.trailing.equalTo(self.basicView).offset(-26);
        make.top.equalTo(self.fsView.mas_top).offset(10);
        make.centerX.equalTo(self.fsView);
    }];
    [self.labFS mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.labFSNum.mas_centerX);
        make.top.equalTo(self.labFSNum.mas_bottom).offset(3);
    }];
    
//
//    [self.viewLineR mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.trailing.equalTo(self.labTJ.mas_leading).offset(-1);
//        make.height.mas_equalTo(self.labTJ.mas_height).offset(-4);
//        make.centerY.equalTo(self.labTJ);
//        make.width.mas_equalTo(1);
//    }];
//
    
    
    //关注
    [self.labGZNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.gzView.mas_top).offset(10);
        make.centerX.equalTo(self.gzView);
    }];
    [self.labGZ mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labGZNum.mas_bottom).offset(3);
        make.centerX.equalTo(self.labGZNum);
    }];

    
    
    
    
//    //计算cell的高度
//    [self.viewTuijian mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.btnUserPic.mas_bottom).offset(7.5);
//        make.left.equalTo(self.basicView.mas_left);
//        make.size.mas_equalTo(CGSizeMake(Width, 60));
//        make.bottom.equalTo(self.basicView.mas_bottom);
//    }];
//


}



- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {

    return YES;
}


















@end
