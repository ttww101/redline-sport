//
//  ZBZLViewModelViewController.m
//  DictPublishAssistant
//
//  Created by Marjoice on 7/19/17.
//  Copyright © 2017 zhuliang. All rights reserved.
//

#import "ZBZLViewModelViewController.h"
#import "ZBNSObject+Perform.h"

@interface ZBZLViewModelViewController (PRIVATE)

@end

@implementation ZBZLViewModelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SEL viewModelSel = NSSelectorFromString(@"setupViewModel");
    if([self respondsToSelector:viewModelSel]) {
        [self performSelectorAlongChain:viewModelSel];
    }
}



@end
