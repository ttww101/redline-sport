//
//  HeaderView.m
//  GQZhiBo
//
//  Created by genglei on 2018/11/21.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import "HeaderView.h"
#import "ItemCell.h"
#import "ForumTypeViewController.h"

@interface HeaderView () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIView *championView;
@property (nonatomic, strong) BaseImageView *championIV;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIView *verticalView;
@property (nonatomic, strong) UILabel *nameLabel;


@end

NSString *const idenfitier = @"cellID";

@implementation HeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configUI];
    }
    return self;
}

#pragma mark - Setter

- (void)setModules:(NSArray<ModulesInfo *> *)modules {
    _modules = modules;
    [self.collectionView reloadData];
}

- (void)setChampions:(NSArray<ChampionModel *> *)champions {
    _champions = champions;
    if (_champions.count > 0) {
         [_championIV setImageWithUrl:[NSURL URLWithString:PARAM_IS_NIL_ERROR([_champions firstObject].pic)] placeholder:nil];
    }
}

#pragma mark - Config UI

- (void)configUI {
    self.backgroundColor = UIColorHex(#EBEBEB);
    [self addSubview:self.collectionView];
    [self addSubview:self.championView];
    self.championView.top = self.collectionView.bottom + 10;
    [self.championView addSubview:self.championIV];
    [self addSubview:self.bottomView];
    self.bottomView.top = self.championView.bottom + 10;
    [self.bottomView addSubview:self.lineView];
    [self.bottomView addSubview:self.verticalView];
    [self.bottomView addSubview:self.nameLabel];
    [self.collectionView registerClass:NSClassFromString(@"ItemCell") forCellWithReuseIdentifier:idenfitier];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.modules.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:idenfitier forIndexPath:indexPath];
    cell.model = self.modules[indexPath.row];
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ForumTypeViewController *control = [[ForumTypeViewController alloc]init];
    [[ZBMethods help_getCurrentVC].navigationController pushViewController:control animated:true];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(collectionView.width / 4, collectionView.height);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

#pragma mark - Lazy Load

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.width, 96) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsHorizontalScrollIndicator = false;
        _collectionView.pagingEnabled = true;
    }
    return _collectionView;
}

- (UIView *)championView {
    if (_championView == nil) {
        _championView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, 85)];
        _championView.backgroundColor = [UIColor whiteColor];
    }
    return _championView;
}

- (BaseImageView *)championIV {
    if (_championIV == nil) {
        _championIV = [[BaseImageView alloc]initWithFrame:CGRectMake(15, 5, self.width - 30, self.championView.height - 10)];
        _championIV.layer.cornerRadius = 5;
        _championIV.layer.masksToBounds = true;
        _championIV.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _championIV;
}

- (UIView *)bottomView {
    if (_bottomView == nil) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, 44)];
        _bottomView.backgroundColor = [UIColor whiteColor];
    }
    return _bottomView;
}

- (UIView *)lineView {
    if (_lineView == nil) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, self.bottomView.height - ONE_PX_LINE, self.width, ONE_PX_LINE)];
        _lineView.backgroundColor = UIColorHex(#eeeeee);
    }
    return _lineView;
}

- (UIView *)verticalView {
    if (_verticalView == nil) {
        _verticalView = [[UIView alloc]initWithFrame:CGRectMake(15, (self.bottomView.height - 15) / 2, 3, 15)];
        _verticalView.backgroundColor = UIColorHex(#EF4131);
    }
    return _verticalView;
}

- (UILabel *)nameLabel {
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.verticalView.right + 5, 12, 100, 20)];
        _nameLabel.font = [UIFont systemFontOfSize:14.f];;
        _nameLabel.textColor = UIColorFromRGBWithOX(0x333333);
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.text = @"精彩推荐";
    }
    return _nameLabel;
}

@end
