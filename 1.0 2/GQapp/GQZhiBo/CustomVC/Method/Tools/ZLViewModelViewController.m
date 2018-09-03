//
//  ZLViewModelViewController.m
//  DictPublishAssistant
//
//  Created by Marjoice on 7/19/17.
//  Copyright © 2017 zhuliang. All rights reserved.
//

#import "ZLViewModelViewController.h"
#import "NSObject+Perform.h"

@interface ZLViewModelViewController (PRIVATE)

@end

@implementation ZLViewModelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SEL viewModelSel = NSSelectorFromString(@"setupViewModel");
    if([self respondsToSelector:viewModelSel]) {
        [self performSelectorAlongChain:viewModelSel];
    }
}



@end
