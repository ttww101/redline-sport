//
//  NSObject+Perform.h
//  DictPublishAssistant
//
///  Created by Marjoice on 7/19/17.
//  Copyright © 2017 zhuliang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Perform)

- (void)performSelectorAlongChain:(SEL)sel;
- (void)performSelectorAlongChainReversed:(SEL)sel;

- (void)performMsgSendWithTarget:(id)target sel:(SEL)sel signal:(id)signal;
- (BOOL)performMsgSendWithTarget:(id)target sel:(SEL)sel;

@end
