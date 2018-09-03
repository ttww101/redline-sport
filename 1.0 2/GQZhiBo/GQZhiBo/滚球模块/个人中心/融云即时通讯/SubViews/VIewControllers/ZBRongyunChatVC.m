 //
//  ZBRongyunChatVC.m
//  GQapp
//
//  Created by WQ on 16/9/27.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import "ZBRongyunChatVC.h"
#import <RongIMKit/RCImagePreviewController.h>
@interface ZBRongyunChatVC ()

@end

@implementation ZBRongyunChatVC
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (_chatFrame.size.height>0) {
        [self.conversationMessageCollectionView setFrame:_chatFrame];
  
    }
    NSUInteger finalRow = MAX(0, [self.conversationMessageCollectionView numberOfItemsInSection:0] - 1);
    
    if (0 == finalRow) {
        return;
    }
    NSIndexPath *finalIndexPath =
    [NSIndexPath indexPathForItem:finalRow inSection:0];
    //[self.customFlowLayout layoutAttributesForItemAtIndexPath:finalIndexPath];
    [self.conversationMessageCollectionView
     scrollToItemAtIndexPath:finalIndexPath
     atScrollPosition:UICollectionViewScrollPositionBottom
     animated:NO];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //去除位置信息的发送
//    [self.chatSessionInputBarControl.pluginBoardView removeItemAtIndex:2];
    [self.chatSessionInputBarControl.pluginBoardView removeAllItems];
    self.chatSessionInputBarControl.additionalButton.hidden = YES;
    self.title = @"聊天室";
    self.view.backgroundColor = [UIColor whiteColor];
    self.conversationMessageCollectionView.backgroundColor = [UIColor whiteColor];
    [self setNavBtn];
    
}


- (void)setNavBtn
{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithNormalImage:[UIImage imageNamed:@"back"] HighImage:[UIImage imageNamed:@""] target:self action:@selector(leftBarButtonItem)];
}
- (void)leftBarButtonItem
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)willDisplayConversationTableCell:(RCMessageBaseCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor whiteColor];
}

///**
// *  打开大图。开发者可以重写，自己下载并且展示图片。默认使用内置controller
// *
// *  @param imageMessageContent 图片消息内容
// */
//
//- (void)presentImagePreviewController:(RCMessageModel *)model {
//    RCImagePreviewController *imageVC = [[RCImagePreviewController alloc] init];
//    imageVC.messageModel = model;
//    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:imageVC];
//    nav.navigationBar.barTintColor   = [UIColor blackColor];
//    //没有色差
//    nav.navigationBar.translucent = NO;
//    //    The tint color to apply
//    [APPDELEGATE.customTabbar presentToViewController:nav animated:YES completion:^{
//    }];
//
//}
//-(void)pluginBoardView:(RCPluginBoardView*)pluginBoardView
//    clickedItemWithTag:(NSInteger)tag
//{
//    NSLog(@"%ld",tag);
//    [self.chatSessionInputBarControl openSystemAlbum];
//}
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
