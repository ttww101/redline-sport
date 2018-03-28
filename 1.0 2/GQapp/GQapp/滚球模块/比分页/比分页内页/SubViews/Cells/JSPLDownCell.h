//
//  JSPLDownCell.h
//  GQapp
//
//  Created by Marjoice on 14/08/2017.
//  Copyright © 2017 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSPLDownMode.h"
#import "JSPLDownTwoModel.h"
@interface JSPLDownCell : UITableViewCell
@property (nonatomic, strong) JSPLDownMode          *jsplDwonModel;
@property (nonatomic, strong) JSPLDownTwoModel      *jsplDwonTwoModel;

@end
