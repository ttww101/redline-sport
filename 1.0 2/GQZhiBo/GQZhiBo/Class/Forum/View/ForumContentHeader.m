//
//  ForumContentHeader.m
//  GQZhiBo
//
//  Created by genglei on 2018/11/20.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import "ForumContentHeader.h"


@interface ForumContentHeader ()

@property (nonatomic, strong) BaseImageView *avatarImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic , strong) UILabel *dateLabel;
@property (nonatomic , strong) UILabel *titleLabel;
@property (nonatomic , strong) UILabel *messageLabel;
@property (nonatomic, strong) PicView *picView;
@property (nonatomic, strong) UIImageView *seeImageView;
@property (nonatomic, strong) UILabel *seeCount;
@property (nonatomic, strong) UILabel *comments;
@property (nonatomic, strong) UILabel *commentsCount;


@end

CGFloat imageWidth = 40;
CGFloat space = 10;

@implementation ForumContentHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self configUI];
    }
    return  self;
}

#pragma mark - Opend Method

- (void)setInfoModel:(HeaderInfoModel *)infoModel {
    _infoModel = infoModel;
    [self.avatarImageView setImageWithAvatarUrl:[NSURL URLWithString:infoModel.avaterUrl] placeholder:[UIImage imageNamed:@"defaultPic1"]];
    self.dateLabel.text = infoModel.dateStr;
    self.nameLabel.text = infoModel.name;
    self.titleLabel.text = infoModel.title;
    self.messageLabel.attributedText = infoModel.messageAtt;
    [self.messageLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Width - 30, infoModel.messageAttHeight));
    }];
    self.picView.dataSource = _infoModel.pics;
    [self.picView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Width - 30, infoModel.picLayout.height));
    }];
    self.commentsCount.text = infoModel.commentsCount;
    self.seeCount.text = infoModel.seeCount;
}

#pragma mark - Config UI

- (void)configUI {
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.avatarImageView];
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(15);
        make.left.equalTo(self).offset(15);
        make.size.mas_equalTo(CGSizeMake(imageWidth, imageWidth));
    }];
    
    [self addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(15);
        make.left.equalTo(self.avatarImageView.mas_right).offset(10);
    }];
    
    [self addSubview:self.dateLabel];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_left);
        make.bottom.equalTo(self.avatarImageView.mas_bottom);
    }];
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarImageView.mas_left);
        make.top.equalTo(self.avatarImageView.mas_bottom).offset(space);
        make.size.mas_equalTo(CGSizeMake(Width - 30, 20));
    }];
    
    [self addSubview:self.messageLabel];
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_left);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(space);
        make.size.mas_equalTo(CGSizeMake(Width - 30, 50));
    }];

    [self addSubview:self.picView];
    [self.picView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.messageLabel.mas_bottom).offset(space);
        make.left.equalTo(self.messageLabel.mas_left);
        make.size.mas_equalTo(CGSizeMake(Width - 30, 0));
    }];
    
    [self addSubview:self.seeImageView];
    [self.seeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.picView.mas_bottom).offset(space);
        make.left.equalTo(self.avatarImageView.mas_left);
        make.size.mas_equalTo(CGSizeMake(14, 8));
    }];
    
    [self addSubview:self.seeCount];
    [self.seeCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.seeImageView.mas_centerY);
        make.left.equalTo(self.seeImageView.mas_right).offset(3);
    }];
    
    [self addSubview:self.comments];
    [self.comments mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.seeImageView.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-15);
    }];
    
    [self addSubview:self.commentsCount];
    [self.commentsCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.seeImageView.mas_centerY);
        make.right.equalTo(self.comments.mas_left).offset(-3);
    }];
}

#pragma mark - Lazy Load

- (BaseImageView *)avatarImageView {
    if (_avatarImageView == nil) {
        _avatarImageView = [BaseImageView new];
        _avatarImageView.contentMode = UIViewContentModeScaleAspectFit;
        [_avatarImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(avatarClick)]];
        _avatarImageView.userInteractionEnabled = YES;
    }
    return _avatarImageView;
}
- (UILabel *)nameLabel {
    if (_nameLabel == nil) {
        _nameLabel = [UILabel new];
        _nameLabel.font = [UIFont systemFontOfSize:14.f];;
        _nameLabel.textColor = UIColorFromRGBWithOX(0xFC3224);
        _nameLabel.text = @"你的名字";
        _nameLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _nameLabel;
}
- (UILabel *)dateLabel {
    if (_dateLabel == nil) {
        _dateLabel = [UILabel new];
        _dateLabel.font = [UIFont systemFontOfSize:12.f];;
        _dateLabel.textColor = UIColorFromRGBWithOX(0x979696);
    }
    return _dateLabel;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:16.f];;
        _titleLabel.textColor = UIColorFromRGBWithOX(0x292929);
        _titleLabel.numberOfLines = 1;
    }
    return _titleLabel;
}

- (UILabel *)messageLabel {
    if (_messageLabel == nil) {
        _messageLabel = [UILabel new];
        _messageLabel.font = [UIFont systemFontOfSize:14.f];;
        _messageLabel.textColor = UIColorFromRGBWithOX(0x828282);
        _messageLabel.numberOfLines = 0;
        _messageLabel.lineBreakMode = NSLineBreakByCharWrapping;
    }
    return _messageLabel;
}

- (PicView *)picView {
    if (_picView == nil) {
        _picView = [[PicView alloc]init];
    }
    return _picView;
}

- (UIImageView *)seeImageView {
    if (_seeImageView == nil) {
        _seeImageView = [UIImageView new];
        _seeImageView.image = [UIImage imageNamed:@"recommend_eye"];
        _seeImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _seeImageView;
}

- (UILabel *)seeCount {
    if (_seeCount == nil) {
        _seeCount = [UILabel new];
        _seeCount.font = [UIFont systemFontOfSize:10.f];;
        _seeCount.textColor = UIColorFromRGBWithOX(0x999999);
    }
    return _seeCount;
}

- (UILabel *)comments {
    if (_comments == nil) {
        _comments = [UILabel new];
        _comments.font = [UIFont systemFontOfSize:10.f];;
        _comments.textColor = UIColorFromRGBWithOX(0x999999);
        _comments.text = @"评论";
    }
    return _comments;
}

- (UILabel *)commentsCount {
    if (_commentsCount == nil) {
        _commentsCount = [UILabel new];
        _commentsCount.font = [UIFont systemFontOfSize:10.f];;
        _commentsCount.textColor = UIColorFromRGBWithOX(0xDB2D21);
    }
    return _commentsCount;
}


@end
