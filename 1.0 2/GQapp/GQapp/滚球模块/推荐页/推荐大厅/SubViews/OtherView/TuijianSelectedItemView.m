//
//  TuijianSelectedItemView.m
//  GQapp
//
//  Created by WQ on 2017/8/24.
//  Copyright © 2017年 GQXX. All rights reserved.
//
#define cellTuijianSelectedSaishi @"cellTuijianSelectedSaishi"
#define cellTuijianSelectedItem @"cellTuijianSelectedItem"
#define headerTuijianSelectedSaishi @"headerTuijianSelectedSaishi"


#import "TuijianSelectedItemTitleView.h"
#import "TuijianSelectedItemView.h"
@interface TuijianSelectedItemView()<UIGestureRecognizerDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,TuijianSelectedItemTitleViewDelegate>
@property (nonatomic, strong) UIView *basiView;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) TuijianSelectedItemTitleView *titleView;




@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *arrPlay;
@property (nonatomic, strong) NSArray *arrState;
@property (nonatomic, strong) NSArray *arrList;

@property (nonatomic, assign) NSInteger currentIndex;


@property (nonatomic, assign) NSInteger play;
@property (nonatomic, assign) NSInteger state;
@property (nonatomic, assign) NSInteger list;

@end
@implementation TuijianSelectedItemView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    
    if (touch.view!= self.collectionView) {
        return NO;
    }
    return YES;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _play = 0;
        _state = 1;
        _list = 0;
        _currentIndex = 0;
        _arrPlay = @[@"全部玩法",@"胜平负",@"让球",@"大小球"];
        
        _arrState = @[@"全部状态",@"未完场",@"已完场",];
        
        _arrList = @[@"最近发布",@"按胜率",@"按盈利率",@"按人气",@"最近开赛"];
        
        [self addSubview:self.basiView];

    }
    return self;
}
- (void)setArrSaishi:(NSArray *)arrSaishi
{
    _arrSaishi = arrSaishi;
    [self.collectionView reloadData];
}

- (void)updateWithIndex:(NSInteger)index
{
    _currentIndex  =index;
    
    switch (_currentIndex) {
        case 0:
        {
            [_titleView updateSelectedIndexWithindex:_currentIndex WithTitle:[_arrPlay objectAtIndex:_play]];
        }
            break;
        case 1:
        {
            [_titleView updateSelectedIndexWithindex:_currentIndex WithTitle:[_arrState objectAtIndex:_state]];
        }
            break;
        case 2:
        {
            [_titleView updateSelectedIndexWithindex:_currentIndex WithTitle:[_arrList objectAtIndex:_list]];
        }
            break;
        case 3:
        {
//            [_titleView updateSelectedIndexWithindex:_currentIndex WithTitle:@"我的关注"];
        }
            break;

        default:
            break;
    }
    
    [self.collectionView reloadData];
}

- (void)updateWithIndexAttentioned:(BOOL)selected
{
    [_titleView attentionBtnSelected:selected];
}
- (UIView *)basiView
{
    if (!_basiView) {
        _basiView = [[UIView alloc] initWithFrame:self.bounds];
        _bgView = [[UIView alloc] initWithFrame:self.basiView.bounds];
        _bgView.backgroundColor = [UIColor blackColor];
        _bgView.alpha = 0.5;
        
        
        
        [_basiView addSubview:_bgView];
        
        _titleView = [[TuijianSelectedItemTitleView alloc] initWithFrame:CGRectMake(0, 0, Width, 44)];
        _titleView.backgroundColor = [UIColor whiteColor];
        _titleView.delegate = self;
        [_basiView addSubview:_titleView];
        UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(0, 43.5, Width, 0.5)];
        viewLine.backgroundColor = colorCellLine;
        [_basiView addSubview:viewLine];
        
        [_basiView addSubview:self.collectionView];
        
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapViewBG)];
        tap.delegate = self;
        [_basiView addGestureRecognizer:tap];

    }
    return _basiView;
}
- (void)tapTuijianSelectedItemTitleViewAtindex:(NSInteger)index
{
    
    
    if (index == 3) {
        
        if (![Methods login]) {
            [Methods toLogin];
            return;
        }

        _currentIndex = index;
        [_delegate touchWithItem:_currentIndex WithIndex:0 WithTitle:@"我的关注"];
        
    }else{
        
        if (_currentIndex == index) {
            
            if (_delegate && [_delegate respondsToSelector:@selector(touchWithItem:WithIndex:WithTitle:)]) {
                
                switch (_currentIndex) {
                    case 0:
                    {
                        [_delegate touchWithItem:_currentIndex WithIndex:_play WithTitle:[_arrPlay objectAtIndex:_play]];
                        
                    }
                        break;
                    case 1:
                    {
                        [_delegate touchWithItem:_currentIndex WithIndex:_state WithTitle:[_arrState objectAtIndex:_state]];
                        
                    }
                        break;
                    case 2:
                    {
                        [_delegate touchWithItem:_currentIndex WithIndex:_list WithTitle:[_arrList objectAtIndex:_list]];
                        
                    }
                        break;
                    case 3:
                    {
                        //                    [_delegate touchWithItem:_currentIndex WithIndex:0 WithTitle:@"我的关注"];
                        
                    }
                        break;
                        
                    default:
                        break;
                }
            }
            
        }else{
            
            _currentIndex = index;
            [self.collectionView reloadData];
            
            
        }
    }
}


- (void)tapViewBG
{
    
    if (_delegate && [_delegate respondsToSelector:@selector(touchWithItem:WithIndex:WithTitle:)]) {
        
        switch (_currentIndex) {
            case 0:
            {
                [_delegate touchWithItem:_currentIndex WithIndex:_play WithTitle:[_arrPlay objectAtIndex:_play]];
                
            }
                break;
            case 1:
            {
                [_delegate touchWithItem:_currentIndex WithIndex:_state WithTitle:[_arrState objectAtIndex:_state]];
                
            }
                break;
            case 2:
            {
                [_delegate touchWithItem:_currentIndex WithIndex:_list WithTitle:[_arrList objectAtIndex:_list]];
                
            }
                break;
            case 3:
            {
                [_delegate touchWithItem:_currentIndex WithIndex:0 WithTitle:@"我的关注"];
                
            }
                break;
                
            default:
                break;
        }
    }
    
}
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        //区头的高度
        
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 44, Width,_basiView.height - 44 ) collectionViewLayout:layout];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.collectionView.alwaysBounceVertical = YES;
        self.collectionView.showsVerticalScrollIndicator = NO;
        self.collectionView.backgroundColor = [UIColor clearColor];
        [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellTuijianSelectedSaishi];
        [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellTuijianSelectedItem];
        [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerTuijianSelectedSaishi];
        [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerTuijianSelectedSaishi];
        [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:headerTuijianSelectedSaishi];

    }
    return _collectionView;
}

#pragma mark -- uicollectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    switch (_currentIndex) {
        case 0:
        {
            return 1;
        }
            break;
        case 1:
        {
            return 1;
        }
            break;
        case 2:
        {
            return 1;
        }
            break;
        case 3:
        {
            return 1;
        }
            break;
        default:
            break;
    }
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    switch (_currentIndex) {
        case 0:
        {
            return _arrPlay.count;
        }
            break;
        case 1:
        {
            return _arrState.count;
        }
            break;
        case 2:
        {
            return _arrList.count;
        }
            break;
        case 3:
        {
            return _arrSaishi.count;
        }
            break;
        default:
            break;
    }
    return 1;
}


// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellTuijianSelectedItem forIndexPath:indexPath];
    if (!cell) {
        NSLog(@"无法创建cell");
    }
    
    else{
        //删除cell中的子对象,刷新覆盖问题。
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    
    if (_currentIndex == 3) {
        
        
        
    }else{
    
        UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 45)];
        contentView.backgroundColor = [UIColor whiteColor];
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, Width - 15, 45)];
        lab.textColor = color33;
        lab.font = font12;
        [contentView addSubview:lab];
        
        UIView *lineV = [[UIView alloc] initWithFrame:CGRectMake(0, 44.5, Width, 0.5)];
        lineV.backgroundColor = colorCellLine;
        [contentView addSubview:lineV];
        cell.backgroundView = contentView;
        
        UIView *contentViewSelected = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 45)];
        contentViewSelected.backgroundColor = colorCellLine;
        UILabel *labSelected = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, Width - 15, 45)];
        labSelected.textColor = redcolor;
        labSelected.font = font12;
        [contentViewSelected addSubview:labSelected];
        
        cell.selectedBackgroundView = contentViewSelected;
        
        switch (_currentIndex) {
            case 0:
            {
                lab.text = [_arrPlay objectAtIndex:indexPath.item];
                labSelected.text = [_arrPlay objectAtIndex:indexPath.item];
                if (indexPath.item == _play) {
                    cell.selected = YES;
                }else{
                    cell.selected = NO;

                }
            }
                break;
            case 1:
            {
                lab.text = [_arrState objectAtIndex:indexPath.item];
                labSelected.text = [_arrState objectAtIndex:indexPath.item];
                if (indexPath.item == _state) {
                    cell.selected = YES;
                }else{
                    cell.selected = NO;
                    
                }
            }
                break;
            case 2:
            {
                lab.text = [_arrList objectAtIndex:indexPath.item];
                labSelected.text = [_arrList objectAtIndex:indexPath.item];
                if (indexPath.item == _list) {
                    cell.selected = YES;
                }else{
                    cell.selected = NO;
                    
                }
            }
                break;

            default:
                break;
        }
        
    
    }
    
    
    
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
//    if (_currentIndex == 3) {
//        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:headerTuijianSelectedSaishi forIndexPath:indexPath];
//        headerView.backgroundColor = [UIColor whiteColor];
//        
//        
//        UILabel *labContent = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, Width - 60, 67)];
//        labContent.textColor = color99;
//        labContent.font = font10;
//        labContent.text = @"*以上选项可以进行多选";
//        [headerView addSubview:labContent];
//        
//        UIButton *btncancel = [UIButton buttonWithType:UIButtonTypeCustom];
//        btncancel.frame = CGRectMake(0, 67,Width/2 , 44);
//        btncancel.titleLabel.font = font13;
//        [btncancel setTitleColor:color33 forState:UIControlStateNormal];
//        [btncancel setTitle:@"取消" forState:UIControlStateNormal];
//        btncancel.backgroundColor = colorTableViewBackgroundColor;
//        [btncancel addTarget:self action:@selector(btncancelClick) forControlEvents:UIControlEventTouchUpInside];
//        [headerView addSubview:btncancel];
//        
//        
//        UIButton *btnconfire = [UIButton buttonWithType:UIButtonTypeCustom];
//        btnconfire.frame = CGRectMake(Width/2, 67,Width/2 , 44);
//        btnconfire.titleLabel.font = font13;
//        [btnconfire setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [btnconfire setTitle:@"确认" forState:UIControlStateNormal];
//        btnconfire.backgroundColor = redcolor;
//        [btnconfire addTarget:self action:@selector(btnconfireClick) forControlEvents:UIControlEventTouchUpInside];
//        [headerView addSubview:btnconfire];
//
//        return headerView;
//
//    }
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerTuijianSelectedSaishi forIndexPath:indexPath];
    headerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    return headerView;

}

- (void)btncancelClick
{
    
    if (_delegate && [_delegate respondsToSelector:@selector(touchWithItem:WithIndex:WithTitle:)]) {
        
        switch (_currentIndex) {
            case 0:
            {
                [_delegate touchWithItem:_currentIndex WithIndex:_play WithTitle:[_arrPlay objectAtIndex:_play]];
                
            }
                break;
            case 1:
            {
                [_delegate touchWithItem:_currentIndex WithIndex:_state WithTitle:[_arrState objectAtIndex:_state]];
                
            }
                break;
            case 2:
            {
                [_delegate touchWithItem:_currentIndex WithIndex:_list WithTitle:[_arrList objectAtIndex:_list]];
                
            }
                break;
            case 3:
            {
                [_delegate touchWithItem:_currentIndex WithIndex:0 WithTitle:@"我的关注"];
                
            }
                break;
                
            default:
                break;
        }
    }
    
}

- (void)btnconfireClick
{
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
    
    switch (_currentIndex) {
        case 0:
        {
            _play = indexPath.item;
            [_titleView updateSelectedIndexWithindex:0 WithTitle:[_arrPlay objectAtIndex:indexPath.item]];
            
            if (_delegate && [_delegate respondsToSelector:@selector(selectedWithItem:WithIndex:WithTitle:)]) {
                [_delegate selectedWithItem:_currentIndex WithIndex:indexPath.item WithTitle:[_arrPlay objectAtIndex:indexPath.item]] ;
            }
        }
            break;
        case 1:
        {
            _state = indexPath.item;
            [_titleView updateSelectedIndexWithindex:1 WithTitle:[_arrState objectAtIndex:indexPath.item]];
            if (_delegate && [_delegate respondsToSelector:@selector(selectedWithItem:WithIndex:WithTitle:)]) {
                [_delegate selectedWithItem:_currentIndex WithIndex:indexPath.item WithTitle:[_arrState objectAtIndex:indexPath.item]];
            }
        }
            break;
        case 2:
        {
            _list = indexPath.item;
            [_titleView updateSelectedIndexWithindex:2 WithTitle:[_arrList objectAtIndex:indexPath.item]];
            if (_delegate && [_delegate respondsToSelector:@selector(selectedWithItem:WithIndex:WithTitle:)]) {
                [_delegate selectedWithItem:_currentIndex WithIndex:indexPath.item WithTitle:[_arrList objectAtIndex:indexPath.item]];
            }
        }
        case 3:
        {
//            _play = indexPath.item;
        }
            break;
            break;
        default:
            break;
    }
    
    [self.collectionView reloadData];

}
#pragma mark --  UICollectionViewDelegateFlowLayout

//定义每个UICollectionView 的大小

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
 
    if (_currentIndex == 3) {
        return CGSizeMake(0, 45);
    }else{
    
        return CGSizeMake(Width, 45);

    }
    return CGSizeMake(0,0);
}
//定义每个UICollectionView 的间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);

//    if (_currentIndex == 3) {
//        return UIEdgeInsetsMake(0, 0, 0, 0);
//
//    }else{
//        return UIEdgeInsetsMake(0, 0, 0, 0);
//
//    }
//    //    上左下右
//    return UIEdgeInsetsMake(12, 12, 12, 12);
}
//cell的最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;

//    if (_currentIndex == 3) {
//        
//    }else{
//    
//        return 0;
//    }
//    return 8;
}

//cell的最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;

//    if (_currentIndex == 3) {
//        
//    }else{
//        
//        return 0;
//    }
//    return 12;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeZero;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
//    if (_currentIndex == 3) {
//        return CGSizeMake(Width, 67 + 44);
//    }
    return CGSizeZero;
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y<0) {
        scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, 0);
    }
}






















@end
