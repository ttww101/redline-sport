//
//  PublishViewController.m
//  GQZhiBo
//
//  Created by genglei on 2018/11/23.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import "PublishViewController.h"
#import "GL_TextView.h"
#import "ZBInputViewController.h"

@interface PublishViewController () <UITextViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UITextField *titleTxtFiled;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) GL_TextView *textview;
@property (nonatomic, strong) UILabel *placeHolder;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIView *bgView;



@end

@implementation PublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:false animated:true];
}

#pragma mark - Config UI

- (void)configUI {
    self.navigationItem.title = @"发布推荐";
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn setTitle:@"发表" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = font16;
    rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightBtn.frame = CGRectMake(0, 0, 40, 44);
    [rightBtn addTarget:self action:@selector(upContent) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    
    self.navigationItem.title = @"发表帖子";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.bgView];
    
    [self.bgView addSubview:self.titleTxtFiled];
    [self.titleTxtFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgView).offset(5);
        make.left.equalTo(self.bgView).offset(15);
        make.right.equalTo(self.bgView).offset(-15);
        make.height.mas_equalTo(44);
    }];
    
    [self.bgView addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleTxtFiled.mas_bottom).offset(0);
        make.left.equalTo(self.bgView);
        make.right.equalTo(self.bgView);
        make.height.mas_equalTo(ONE_PX_LINE);
    }];

    [self.bgView addSubview:self.textview];
    [self.textview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView.mas_bottom).offset(0);
        make.left.equalTo(self.bgView).offset(15);
        make.right.equalTo(self.bgView).offset(-15);
        make.height.mas_equalTo(Scale_Value(300));
    }];

    [self.textview addSubview:self.placeHolder];
    [self.placeHolder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textview).offset(5);
        make.left.equalTo(self.textview).offset(0);
    }];

    [self.bgView addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textview.mas_bottom).offset(0);
        make.left.equalTo(self.bgView).offset(0);
        make.right.equalTo(self.bgView).offset(0);
        make.height.mas_equalTo(100);
    }];
    
    self.scrollView.contentSize = CGSizeMake(Width, Scale_Value(300) + 200);
    self.bgView.height = self.scrollView.contentSize.height;
}

#pragma mark - Load Data

- (void)loadData {
    
}

#pragma mark - UITextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView {
    self.placeHolder.hidden = true;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if (!(textView.text.length > 0)) {
        self.placeHolder.hidden = false;
    }
}

#pragma mark UITextFieldDelegate

// 简易写法 限制字数不是很准确
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (string.length == 0) return YES;
    NSInteger existedLength = textField.text.length;
    NSInteger selectedLength = range.length;
    NSInteger replaceLength = string.length;
    if (existedLength - selectedLength + replaceLength > 20){
        return NO;
    }
    return YES;
}

#pragma mark - Events

- (void)upContent {
    ZBInputViewController *control = [[ZBInputViewController alloc]init];
    [self.navigationController pushViewController:control animated:true];
}

#pragma mark - Lazy Load

- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 64)];
        _scrollView.backgroundColor = [UIColor whiteColor];
    }
    return _scrollView;
}

- (UITextField *)titleTxtFiled {
    if (_titleTxtFiled == nil) {
        _titleTxtFiled = [[UITextField alloc]init];
        NSString *placeText = @"标题（最多36个字符）";
        NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithString:placeText];
        [att addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:[placeText rangeOfString:placeText]];
        [att addAttribute:NSForegroundColorAttributeName value:UIColorHex(#D0CFCF) range:[placeText rangeOfString:placeText]];
        _titleTxtFiled.attributedPlaceholder = att;
        _titleTxtFiled.delegate = self;
    }
    return _titleTxtFiled;
}

- (UIView *)lineView {
    if (_lineView == nil) {
        _lineView = [UIView new];
        _lineView.backgroundColor = UIColorHex(eeeeee);
    }
    return _lineView;
}

- (UIView *)bgView {
    if (_bgView == nil) {
        _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 0)];
        _bgView.backgroundColor = self.scrollView.backgroundColor;
    }
    return _bgView;
}

- (GL_TextView *)textview {
    if (_textview == nil) {
        _textview = [[GL_TextView alloc]init];
        _textview.delegate = self;
    }
    return _textview;
}

- (UILabel *)placeHolder {
    if (_placeHolder == nil) {
        _placeHolder = [[UILabel alloc]init];
        _placeHolder.text = @"发表帖子正文";
        _placeHolder.textColor = UIColorHex(#D0CFCF);
        _placeHolder.font = [UIFont systemFontOfSize:14];
    }
    return _placeHolder;
}

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = 5;
        layout.minimumInteritemSpacing = 5;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor orangeColor];
    }
    return _collectionView;
}

@end
