#import "ZBMineViewModel.h"
@implementation ZBMineViewModel
+ (NSArray *)getMineDataArray {
    NSMutableArray *groupArray = [NSMutableArray array];
    NSArray *imageArray1 = @[@"image2", @"image3",@"image11", @"image12"];
    NSArray *leftContentArry1 = @[@"账户明细", @"购买记录",@"分析师收入", @"优惠券"];
    NSMutableArray *array1 = [NSMutableArray new];
    for (NSInteger i = 0; i < imageArray1.count; i ++) {
        ZBMineModel *model = [[ZBMineModel alloc]init];
        model.leftContent = leftContentArry1[i];
        model.leftImageName = imageArray1[i];
        model.rightImageName = @"meRight";
        [array1 addObject:model];
    }
    [groupArray addObject:array1];
    NSArray *imageArra2 = @[@"image15", @"image16",@"image5", @"image1"];
    NSArray *leftContentArry2 = @[@"分析师申请", @"推荐记录", @"推荐统计", @"滚球服务"];
    NSMutableArray *array2 = [NSMutableArray new];
    for (NSInteger i = 0; i < imageArra2.count; i ++) {
        ZBMineModel *model = [[ZBMineModel alloc]init];
        model.leftContent = leftContentArry2[i];
        model.leftImageName = imageArra2[i];
        model.rightImageName = @"meRight";
        [array2 addObject:model];
    }
    [groupArray addObject:array2];
    NSArray *imageArra4 = @[@"image17", @"image8", @"image9", @"image10"];
    NSArray *leftContentArry4 = @[@"消息中心",@"邀请好友", @"意见反馈", @"更多设置"];
    NSMutableArray *array4 = [NSMutableArray new];
    for (NSInteger i = 0; i < imageArra4.count; i ++) {
        ZBMineModel *model = [[ZBMineModel alloc]init];
        model.leftContent = leftContentArry4[i];
        model.leftImageName = imageArra4[i];
        model.rightImageName = @"meRight";
        if (i == 1) {
            model.rightContent = @"邀请好友得滚球币";
        }
        [array4 addObject:model];
    }
    [groupArray addObject:array4];
    return groupArray;
}
@end
