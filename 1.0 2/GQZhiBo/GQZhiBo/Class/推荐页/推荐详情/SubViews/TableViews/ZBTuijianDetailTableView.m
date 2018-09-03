#import "ZBTuijianDetailTableView.h"
#import "ZBTuijianDetailHeaderView.h"
#import "ZBTuijianDetailCommentCell.h"
#import "ZBTuijiandatingModel.h"
#import "ZBBuyRecordsVC.h"
#define CellTuijianDetZucaiHeader @"CellTuijianDetZucaiHeader"
#define CellTuijianDetChuanGuanHeader @"CellTuijianDetChuanGuanHeader"
#define CellTuijianDetailHeader @"CellTuijianDetailHeader"
#define CellTuijianDetailComment @"CellTuijianDetailComment"
@interface ZBTuijianDetailTableView()<UITableViewDelegate,UITableViewDataSource,TuijianDetailCommentCellDelegate,UIWebViewDelegate>
@property (nonatomic ,strong) NSMutableArray *arrCells;
@property (nonatomic, assign) CGFloat cellWebhight;
@property (nonatomic, strong) UILabel *payNum;
@property (nonatomic ,strong) NSMutableArray *picArray;
@end
@implementation ZBTuijianDetailTableView
- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        if (_typeTuijianDetailHeader == typeTuijianDetailHeaderCellDanchang) {
        }else if(_typeTuijianDetailHeader == typeTuijianDetailHeaderCellChuanGuan){
        }else if (_typeTuijianDetailHeader == typeTuijianDetailHeaderCellZucai){
        }
        [self registerClass:[ZBTuijianDetailHeaderView class] forCellReuseIdentifier:CellTuijianDetailHeader];
        [self registerClass:[ZBTuijianDetailCommentCell class] forCellReuseIdentifier:CellTuijianDetailComment];
    }
    return self;
}
- (NSMutableArray *)picArray {
    if (!_picArray) {
        _picArray = [NSMutableArray array];
    }
    return  _picArray;
}
- (void)setPayUsersModel:(ZBpayUserModel *)payUsersModel {
    _payUsersModel = payUsersModel;
    [_picArray removeAllObjects]; 
    if (_payUsersModel.pic) {
        [_picArray addObject:_payUsersModel.pic];
    }
}
- (void)setArrPic:(NSArray *)arrPic{
    _arrPic = arrPic;
    [_picArray removeAllObjects]; 
    if (_arrPic.count > 0) {
        for (int i = 0; i < _arrPic.count;  i ++) {
            ZBpayUserModel *model = _arrPic[i];
            [_picArray addObject:model.pic];
        }
    }
}
- (void)setTuijianModel:(ZBTuijiandatingModel *)tuijianModel {
    _tuijianModel = tuijianModel;
}
- (void)setHeaderModel:(ZBTuijiandatingModel *)headerModel
{
    _headerModel = headerModel;
    if (_headerModel.contentInfo!= nil && ![_headerModel.contentInfo isEqualToString:@""]) {
        UIWebView *webview = [[UIWebView alloc] init];
        webview.frame = CGRectMake(0, 0, Width -30, 0);
        webview.delegate = self;
        [self addSubview:webview];
        NSString *htmls = [NSString stringWithFormat:@"<html> \n"
                           "<head> \n"
                           "<style type=\"text/css\"> \n"
                           "*{padding:0;margin:0;}p{line-height:22px;width:100%%; padding-bottom:0px;float:left;}"
                           "</style> \n"
                           "</head> \n"
                           "<body>"
                           "<script type='text/javascript'>"
                           "window.onload = function(){\n"
                           "var $img = document.getElementsByTagName('img');\n"
                           "for(var p in  $img){\n"
                           " $img[p].style.maxWidth = '100%%';\n"
                           "$img[p].style.height ='auto'\n"
                           "}\n"
                           "}"
                           "</script>%@"
                           "</body>"
                           "</html>",_headerModel.contentInfo];
        [webview loadHTMLString:htmls baseURL:nil];
    }
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    CGFloat webViewHeight= [[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"]floatValue];
    if (webViewHeight <= 20) {
        webViewHeight = 30;
    }
    _cellWebhight = webViewHeight;
    [self reloadData];
}
- (void)setArrData:(NSArray *)arrData
{
    _arrData = arrData;
    _arrCells = [[NSMutableArray alloc] init];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        if (_typeTuijianDetailHeader == typeTuijianDetailHeaderCellDanchang) {
            if (_headerModel) {
                return 1;
            }else{
                return 0;
            }
        }else{
        }
        return 1;
    }else if (section == 1){
        if (!_headerModel.see) {
            return 0;
        }
        if (_arrData.count == 0) {
            return 0;
        }
        return _arrData.count;
    }else{
        return 0;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.superview endEditing:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (_typeTuijianDetailHeader == typeTuijianDetailHeaderCellDanchang) {
            return [tableView fd_heightForCellWithIdentifier:CellTuijianDetailHeader configuration:^(ZBTuijianDetailHeaderView* cell) {
                cell.webViewHight = _cellWebhight;
                cell.model = _headerModel;
            }];
        }else if(_typeTuijianDetailHeader == typeTuijianDetailHeaderCellChuanGuan){
        }else if (_typeTuijianDetailHeader == typeTuijianDetailHeaderCellZucai){
        }
    }else if (indexPath.section == 1){
        if (!_headerModel.see) {
            return 0;
        }
        if (_arrData.count == 0) {
            return 0;
        }
        return [tableView fd_heightForCellWithIdentifier:CellTuijianDetailComment cacheByIndexPath:indexPath configuration:^(ZBTuijianDetailCommentCell* cell) {
            cell.type = typeCommentCellTuijian;
            if (_arrData.count >0) {
                cell.model = [_arrData objectAtIndex:indexPath.row];
            }
        }];
    }else{
        return 0.5;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (_typeTuijianDetailHeader == typeTuijianDetailHeaderCellDanchang) {
             ZBTuijianDetailHeaderView   *cell = [[ZBTuijianDetailHeaderView alloc] init];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.webViewHight = _cellWebhight;
            cell.model = _headerModel;
            return cell;
        }else if(_typeTuijianDetailHeader == typeTuijianDetailHeaderCellChuanGuan){
        }else if (_typeTuijianDetailHeader == typeTuijianDetailHeaderCellZucai){
        }
        return nil;
    }else if(indexPath.section == 1){
        if (!_headerModel.see) {
            return [UITableViewCell new];
        }
        if (_arrData.count == 0) {
            return [UITableViewCell new];
        }
        ZBTuijianDetailCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:CellTuijianDetailComment];
        if (!cell) {
            cell = [[ZBTuijianDetailCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellTuijianDetailComment];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        cell.type = typeCommentCellTuijian;
        if (_arrData.count >0) {
            cell.model = [_arrData objectAtIndex:indexPath.row];
        }
        if (![_arrCells containsObject:cell]) {
            [_arrCells addObject:cell];
        }
        return cell;
    }
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        CGFloat headerHeight = _headerModel.amount == 0? 45 : 91;
        UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, headerHeight)];
        header.backgroundColor = [UIColor whiteColor];
        CGFloat paySeeViewHeight = _headerModel.amount == 0? 0: 45;
        UIView *paySeeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, paySeeViewHeight)];
        _payNum = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, (Width- 30) * 0.3, paySeeViewHeight)];
        _payNum.text = [NSString stringWithFormat:@"付费查看%ld人",(long)_headerModel.payUsers_count];
        _payNum.font = font14;
        _payNum.textColor = color33;
        _payNum.attributedText = [ZBMethods withContent:_payNum.text WithColorText:[NSString stringWithFormat:@"%zi",_headerModel.payUsers_count] textColor:redcolor strFont:font14];
        paySeeView.userInteractionEnabled = YES;
        UITapGestureRecognizer *payViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(payViewTap)];
        if (_headerModel.payUsers_count >0) {
            [paySeeView addGestureRecognizer:payViewTap];
        }
        if (self.picArray != 0) {
            for (int i = 0; i < self.picArray.count; i++) {
                UIImageView *userImage = [[UIImageView alloc] init];
                [userImage sd_setImageWithURL:self.picArray[i] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                }];
                userImage.layer.cornerRadius = 15;
                userImage.layer.masksToBounds = YES;
                [paySeeView addSubview:userImage];
                [userImage mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.size.mas_equalTo(CGSizeMake(30, 30));
                    make.right.equalTo(paySeeView.mas_right).offset(-40 - 30*i);
                    make.centerY.mas_equalTo(paySeeView.mas_centerY);
                }];
            }
        }
        UIImageView *rightImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"meRight"]];
        UIView *viewLineUp = [[UIView alloc] initWithFrame:CGRectMake(0, paySeeView.bottom, Width, 0.5)];
        viewLineUp.backgroundColor = colorDD;
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(15, paySeeView.bottom , Width - 30, 45)];
        lab.font = font14;
        lab.textColor = color33;
        lab.text = [NSString stringWithFormat:@"评论%ld条",_headerModel.comment_count];
        [lab setAttributedText:[ZBMethods withContent:lab.text WithColorText:[NSString stringWithFormat:@"%ld",_headerModel.comment_count] textColor:redcolor strFont:font14]];
        UIView *viewLineDown = [[UIView alloc] initWithFrame:CGRectMake(0, lab.bottom, Width, 0.5)];
        viewLineDown.backgroundColor = colorDD;
        [paySeeView addSubview:self.payNum];
        if (_headerModel.payUsers_count > 0  ) {
            [paySeeView addSubview:rightImageView];
            [rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.trailing.equalTo(paySeeView).offset(-15);
                make.centerY.equalTo(paySeeView);
                make.size.mas_equalTo(CGSizeMake(9, 18));
            }];
        }
        if (_headerModel.amount != 0) {
            [header addSubview:paySeeView];
        }
        [header addSubview:viewLineUp];
        [header addSubview:lab];
        [header addSubview:viewLineDown];
        return header;
    }
    return nil;
}
- (void)payViewTap {
    NSLog(@"view被点击");
    if ([ZBMethods getUserModel].idId != _headerModel.user_id) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"用户暂无权限" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
        }];
        [alert addAction:action];
        [APPDELEGATE.customTabbar presentViewController:alert animated:YES completion:^{
        }];
    }
    ZBBuyRecordsVC *buyerVC = [[ZBBuyRecordsVC alloc] init];
    buyerVC.newsID = _headerModel.idId;
    buyerVC.hidesBottomBarWhenPushed = YES;
    [APPDELEGATE.customTabbar pushToViewController:buyerVC animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return _headerModel.amount >0 ? 91 : 45;
    }
    return 0;
}
- (void)reloadData
{
    [super reloadData];
    _arrCells = [[NSMutableArray alloc] init];
}
- (void)didShowMoreBtn
{    
    [self reloadData];
}
- (void)touchBasicViewToHideHudViewWithIdid:(NSInteger)Idid
{
    for (int i = 0; i<_arrCells.count; i++) {
        ZBCommentModel *model = [_arrData objectAtIndex:i];
        if (model.Idid != Idid) {
            ZBTuijianDetailCommentCell *cell = [_arrCells objectAtIndex:i];
            [cell hideHudView];
        }
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.superview endEditing:YES];
}
@end
