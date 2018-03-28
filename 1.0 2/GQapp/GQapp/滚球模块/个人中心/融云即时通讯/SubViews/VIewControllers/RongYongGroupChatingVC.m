//
//  RongYongGroupChatingVC.m
//  GQapp
//
//  Created by WQ on 16/9/18.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import "RongYongGroupChatingVC.h"

@interface RongYongGroupChatingVC ()

@end

@implementation RongYongGroupChatingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setDisplayConversationTypes:
     [NSArray arrayWithObjects:
      @(ConversationType_DISCUSSION),
      @(ConversationType_GROUP), nil]];
}
//重写RCConversationListViewController的onSelectedTableRow事件
- (void)onSelectedTableRow:(RCConversationModelType)conversationModelType
         conversationModel:(RCConversationModel *)model
               atIndexPath:(NSIndexPath *)indexPath {
    
    RCConversationViewController *conversationVC = [[RCConversationViewController alloc]init];
    conversationVC.conversationType = model.conversationType;
    conversationVC.targetId = model.targetId;
    conversationVC.title = @"想显示的会话标题";
    [self.navigationController pushViewController:conversationVC animated:YES];
    
}
- (void)willDisplayConversationTableCell:(RCConversationCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    cell.headerImageViewBackgroundView.backgroundColor = redcolor;
    
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
