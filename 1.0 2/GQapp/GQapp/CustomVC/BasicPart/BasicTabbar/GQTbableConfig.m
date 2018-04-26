//
//  GQTbableConfig.m
//  newGQapp
//
//  Created by genglei on 2018/4/26.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import "GQTbableConfig.h"
#import "ArchiveFile.h"
#import "WebModel.h"

@interface GQTbableConfig ()

/**
 
 */
@property (nonatomic, readwrite, strong) DCTabBarController *tableBarController;

@end

@implementation GQTbableConfig

- (DCTabBarController *)tableBarController {
    if (_tableBarController == nil) {
        _tableBarController = [[DCTabBarController alloc]initWithItemArray:[self tableBarItemArray]];
    }
    return _tableBarController;
}

- (NSArray *)tableBarItemArray {
    NSMutableArray *array = [ArchiveFile getDataWithPath:TableConfig];
    if (array.count > 0) {
        return [self loadServerTableBarConfigWithArray:array];
    } else {
        return [self loadLocalTableBarConfig];
    }
}

- (NSArray *)loadServerTableBarConfigWithArray:(NSArray *)array {
    __block NSMutableArray *dataArray = [NSMutableArray new];
    [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *imageUrl = obj[@"defaultImage"];
        NSString *selectImageUrl = obj[@"selectImage"];
    
        UIImage *defaultImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:imageUrl];
        UIImage *selectImage = [[SDImageCache sharedImageCache]imageFromDiskCacheForKey:selectImageUrl];
        if (defaultImage && selectImage) {
            BOOL loadH5 = [obj[@"loadH5"] integerValue];
            if (loadH5) {
                WebModel *model = [[WebModel alloc]init];
                model.title = obj[@"title"];
                model.webUrl = obj[@"url"];
                model.hideNavigationBar = YES;
                [dataArray addObject:@{
                                       GQTableBarControllerName : @"BaseWebViewController",
                                       GQTabBarItemTitle : obj[@"title"],
                                       GQTabBarItemImage : [defaultImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
                                       GQTabBarItemSelectedImage : [selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
                                       GQTabBarItemLoadH5 : @(loadH5),
                                       GQTabBarItemWbebModel : model
                                       }];
            } else {
                [dataArray addObject:@{
                                       GQTableBarControllerName : obj[@"className"],
                                       GQTabBarItemTitle : obj[@"title"],
                                       GQTabBarItemImage : [defaultImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
                                       GQTabBarItemSelectedImage : [selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                       }];
            }
            
            
        } else {
            dataArray = [[self loadLocalTableBarConfig] mutableCopy];
            *stop = YES;
        }
    }];
    return dataArray;
}

- (NSArray *)loadLocalTableBarConfig {
    NSDictionary *firstTabBarItemsAttributes = [self tableBarItemControllerName:@"FirstViewController" title:@"首页" defaultImage:@"shouye" selectImage:@"shouye-1"];
    NSDictionary *secondTabBarItemsAttributes = [self tableBarItemControllerName:@"BifenViewController" title:@"比分" defaultImage:@"bifen" selectImage:@"bifen-1"];
    NSDictionary *fifthTabBarItemsAttributes = [self tableBarItemControllerName:@"NewQingBaoViewController" title:@"情报" defaultImage:@"qingbao" selectImage:@"qingbao-1"];
    NSDictionary *thirdTabBarItemsAttributes = [self tableBarItemControllerName:@"TuijianDTViewController" title:@"推荐" defaultImage:@"tuijian" selectImage:@"tuijian-1"];
    NSDictionary *fourthTabBarItemsAttributes = [self tableBarItemControllerName:@"MineViewController" title:@"我的" defaultImage:@"wode" selectImage:@"wode-1"];
    NSArray *array = @[firstTabBarItemsAttributes, secondTabBarItemsAttributes, fifthTabBarItemsAttributes, thirdTabBarItemsAttributes, fourthTabBarItemsAttributes];
    return array;
}

- (NSDictionary *)tableBarItemControllerName:(NSString *)name
                                       title:(NSString *)title
                                defaultImage:(NSString *)defaultImaeg
                                 selectImage:(NSString *)selectImage; {
    return @{
             GQTableBarControllerName : name,
             GQTabBarItemTitle : title,
             GQTabBarItemImage : [[UIImage imageNamed:defaultImaeg] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
             GQTabBarItemSelectedImage : [[UIImage imageNamed:selectImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
             };
}

@end
