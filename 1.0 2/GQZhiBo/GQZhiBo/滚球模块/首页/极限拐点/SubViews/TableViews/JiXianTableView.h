//
//  JiXianTableView.h
//  GQapp
//
//  Created by 叶忠阳 on 2017/6/21.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import "BasicTableView.h"

@interface JiXianTableView : BasicTableView
//0 胜平负  1亚盘  2大小球

- (void)updateWithType:(NSInteger)type;
@end
