//
//  ZBRongyongChatingVC.m
//  GQapp
//
//  Created by WQ_h on 16/9/13.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import "ZBRongyongChatingVC.h"
#import "ZBRongYongGroupChatingVC.h"
#import "ZBRongyunChatVC.h"
@interface ZBRongyongChatingVC ()

@end

@implementation ZBRongyongChatingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置需要显示哪些类型的会话
    [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE),@(ConversationType_CHATROOM),@(ConversationType_APPSERVICE),                                          @(ConversationType_SYSTEM),@(ConversationType_DISCUSSION),@(ConversationType_GROUP)]];
    //设置需要将哪些类型的会话在会话列表中聚合显示
    [self setCollectionConversationType:@[@(ConversationType_DISCUSSION),@(ConversationType_GROUP)]];

    
}

//重写RCConversationListViewController的onSelectedTableRow事件
- (void)onSelectedTableRow:(RCConversationModelType)conversationModelType
         conversationModel:(RCConversationModel *)model
               atIndexPath:(NSIndexPath *)indexPath {
        
    if (model.conversationType == ConversationType_DISCUSSION || model.conversationType == ConversationType_GROUP) {
        ZBRongYongGroupChatingVC *chatVC = [[ZBRongYongGroupChatingVC alloc] init];
        [APPDELEGATE.customTabbar pushToViewController:chatVC animated:YES];
        
        
    }else{
        ZBRongyunChatVC *conversationVC = [[ZBRongyunChatVC alloc]init];
        conversationVC.conversationType = model.conversationType;
        conversationVC.targetId = model.targetId;
        conversationVC.title = @"想显示的会话标题";
        [APPDELEGATE.customTabbar pushToViewController:conversationVC animated:YES];

    
    }
    
    
}
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
