#import "ZBTuijianDetailTableView.h"
#import "ZBTuijianDetailHeaderView.h"
#import "ZBTuijianDetailCommentCell.h"
#import "ZBTuijiandatingModel.h"
#import "ZBBuyRecordsVC.h"
#import "ZBTuijianDatingCell.h"

#define CellTuijianDetZucaiHeader @"CellTuijianDetZucaiHeader"
#define CellTuijianDetChuanGuanHeader @"CellTuijianDetChuanGuanHeader"
#define CellTuijianDetailHeader @"CellTuijianDetailHeader"
#define CellTuijianDetailComment @"CellTuijianDetailComment"
#define CellTuijianDating @"CellTuijianDatingDetail"
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
        self.backgroundColor = [UIColor whiteColor];
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        if (_typeTuijianDetailHeader == typeTuijianDetailHeaderCellDanchang) {
        }else if(_typeTuijianDetailHeader == typeTuijianDetailHeaderCellChuanGuan){
        }else if (_typeTuijianDetailHeader == typeTuijianDetailHeaderCellZucai){
        }
        [self registerClass:[ZBTuijianDetailHeaderView class] forCellReuseIdentifier:CellTuijianDetailHeader];
        [self registerClass:[ZBTuijianDetailCommentCell class] forCellReuseIdentifier:CellTuijianDetailComment];
        [self registerClass:NSClassFromString(@"ZBTuijianDatingCell") forCellReuseIdentifier:CellTuijianDating];
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
    return _arrData.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    DetailGroupModel *model = _arrData[section];
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
    }else if (section == 2){
        return model.dataList.count;
    } else if (section == 1){
        return model.dataList.count;
    } else{
        return 0;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.superview endEditing:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{  DetailGroupModel *model = _arrData[indexPath.section];
    if (indexPath.section == 0) {
        if (_typeTuijianDetailHeader == typeTuijianDetailHeaderCellDanchang) {
            return [tableView fd_heightForCellWithIdentifier:CellTuijianDetailHeader configuration:^(ZBTuijianDetailHeaderView* cell) {
                cell.webViewHight = _cellWebhight;
                cell.model = _headerModel;
            }];
        }else if(_typeTuijianDetailHeader == typeTuijianDetailHeaderCellChuanGuan){
            
        }else if (_typeTuijianDetailHeader == typeTuijianDetailHeaderCellZucai){
        }
    }else if (indexPath.section == 2){
        if (!_headerModel.see) {
            return 0;
        }
        if (_arrData.count == 0) {
            return 0;
        }
        return [tableView fd_heightForCellWithIdentifier:CellTuijianDetailComment cacheByIndexPath:indexPath configuration:^(ZBTuijianDetailCommentCell* cell) {
            cell.type = typeCommentCellTuijian;
            if (model.dataList.count >0) {
                cell.model = [model.dataList objectAtIndex:indexPath.row];
            }
        }];
    }else if (indexPath.section == 1){
        return 190;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     DetailGroupModel *model = _arrData[indexPath.section];
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
    } else if (indexPath.section == 1) {
        ZBTuijianDatingCell *cell = [tableView dequeueReusableCellWithIdentifier:CellTuijianDating forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.type = typeTuijianCellDating;
        cell.model = [model.dataList objectAtIndex:indexPath.row];
        return cell;
        
    } else if(indexPath.section == 2){
        ZBTuijianDetailCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:CellTuijianDetailComment forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        cell.type = typeCommentCellTuijian;
        if (_arrData.count >0) {
            cell.model = [model.dataList objectAtIndex:indexPath.row];
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
    DetailGroupModel *model = _arrData[section];
    if (section == 2) {
        UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 45)];
        header.backgroundColor = [UIColor whiteColor];
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(15, 0 , Width - 30, 45)];
        lab.font = font14;
        lab.textColor = color33;
        lab.text = [NSString stringWithFormat:@"评论%ld条",model.dataList.count];
        [lab setAttributedText:[ZBMethods withContent:lab.text WithColorText:[NSString stringWithFormat:@"%ld",_headerModel.comment_count] textColor:redcolor strFont:font14]];
        UIView *viewLineDown = [[UIView alloc] initWithFrame:CGRectMake(0, lab.bottom, Width, 0.5)];
        viewLineDown.backgroundColor = colorDD;
        [header addSubview:lab];
        [header addSubview:viewLineDown];
        return header;
    } else if (section == 1) {
         UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 45)];
        header.backgroundColor = [UIColor whiteColor];
        UIView *verticalLine = [[UIView alloc] initWithFrame:CGRectMake(15, 7.5, ONE_PX_LINE, 30)];
        verticalLine.backgroundColor = UIColorHex(#EF4131);
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(verticalLine.right + 15, 0 , Width - 30, 45)];
        lab.font = font14;
        lab.textColor = color33;
        lab.text = model.title;
        UIView *viewLineDown = [[UIView alloc] initWithFrame:CGRectMake(0, lab.bottom, Width, 0.5)];
        viewLineDown.backgroundColor = colorDD;
        [header addSubview:verticalLine];
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
     DetailGroupModel *model = _arrData[section];
    if (section == 2 && model.dataList.count > 0) {
        return 45;
    } else if (section == 1 && model.dataList.count > 0) {
        return 45;
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
